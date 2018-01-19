# Downloaded from here https://github.com/civisanalytics/iam-role-injector
# This was modified by Nat
# USAGE:
# requires 4 args, needs to be run with source to get exported variables to stick
# source assume_role.sh {destinationAccountNumber} {rolename}

destinationAccountNumber=$1
rolename=$2

if [ -n "$destinationAccountNumber" ] && [ -n "$rolename" ]; then
  unset AWS_SECURITY_TOKEN
  unset AWS_SESSION_TOKEN
  if [ -z "$AWS_ENV_VARS" ]; then
    if [ -z "$AWS_SECRET_ACCESS_KEY" ]; then
      export AWS_ENV_VARS="True"
    elif [ -z "$OG_AWS_SECRET_ACCESS_KEY" ]; then
      export OG_AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
      export OG_AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
    else
      export AWS_SECRET_ACCESS_KEY=$OG_AWS_SECRET_ACCESS_KEY
      export AWS_ACCESS_KEY_ID=$OG_AWS_ACCESS_KEY_ID
    fi
  else
    unset AWS_SECRET_ACCESS_KEY
    unset AWS_ACCESS_KEY_ID
  fi

  roleArn="arn:aws:iam::"
  roleArn+="$destinationAccountNumber"
  roleArn+=":role/"
  roleArn+="$rolename"

  commandResult=" "
  commandResult+=$(aws sts assume-role --output json \
                --role-arn $roleArn \
                --role-session-name iam-role-injector \
                --query 'Credentials.[SecretAccessKey, SessionToken, AccessKeyId]')

  exitCode=$?

  size=${#commandResult}
  if (( $size > 5 )); then
    commandResult1=$(echo "$commandResult" | sed '5d' | sed '1d' | tr -d '\040\011\012\015' | sed 's/\"//g')
    echo "You have assumed the $rolename role successfully."
    arg1=$(echo "$commandResult1" | cut -d "," -f1)
    export AWS_SECRET_ACCESS_KEY=$arg1
    arg2=$(echo "$commandResult1" | cut -d "," -f2)
    # Set AWS_SESSION_TOKEN and AWS_SECURITY_TOKEN for backwards compatibility
    # See: http://boto3.readthedocs.org/en/latest/guide/configuration.html
    export AWS_SECURITY_TOKEN=$arg2
    export AWS_SESSION_TOKEN=$arg2
    arg3=$(echo "$commandResult1" | cut -d "," -f3)
    export AWS_ACCESS_KEY_ID=$arg3
  else
    echo "Unable to assume role"
    exitCode=1
  fi

else
  echo "Usage: source assume_role.sh {destinationAccountNumber} {rolename}"
  exitCode=1
fi

# This runs in a subshell, so it will not exit your shell when you are sourcing,
# but it still gives you the correct exit code if you read from $?
(exit $exitCode)