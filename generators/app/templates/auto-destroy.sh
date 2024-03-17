#!/bin/bash

# Define the functions to call

#AWS
function aws {
     echo -e "You have opted for \033[1;32mAWS\033[0m cloud provider"
    # Add code here to execute the action for aws
    echo "Initiating the aws action...."
    while true; do
      echo ""
      echo "Set up AWS credentials which will be used be terraform"
      echo -n "Provide aws access key:"
      read aws_access_key
      echo -n "Provide aws secret key:"
      read aws_secret_key
      export AWS_ACCESS_KEY_ID=$aws_access_key
      export AWS_SECRET_ACCESS_KEY=$aws_secret_key
      echo ""
      echo -e "\033[1;33mProvided aws configuration\033[0m"
      echo "aws access key:"${AWS_ACCESS_KEY_ID}
      echo "aws secret key:"${AWS_SECRET_ACCESS_KEY}
      echo -n "Ensure that your aws credentials are correct,(yes/no):"
      read user_confirmation

      # convert user input to lowercase
      user_confirmation=$(echo "$user_confirmation" | tr '[:upper:]' '[:lower:]')
      if [[ "$user_confirmation" == "yes" ]]; then
          break
      fi
    done
    echo ""
    echo -e "\033[1;32mAws credentials are set!\033[0m"
    echo ""
    echo -n "Continue with the destroying Infrastructure,(yes/no):"
    read user_continue_action
    if [ "$user_continue_action" == "yes" ]; then
    echo "Destroying the Infrastructure in our AWS cloud....."
        # List of directories to process
        directories=(
        "./k8s-web-ui"
        "./istio-monitoring"
        "./istio"
        "./eck"
        "./eks-drivers"
        "./eks"
        )

        # Loop through each directory and execute command
        for dir in "${directories[@]}"
        do
            if [ -d "$dir" ]; then
                echo "Processing directory: $dir"
                cd "$dir" || exit
                # Execute your command here
                echo "Auto destroying terraform in $dir"
                terraform destroy -auto-approve
                cd ..
            else
                echo "Directory $dir does not exist"
            fi
        done
      echo ""
      echo -e "\033[1m\033[32mInfrastructure was destroyed successfully!\U0001F63B\033[0m"
      echo ""
      echo -e "\033[1;31mMake sure you delete the ECR manually.\U0001F431\033[0m"
      echo ""
    else 
        echo ""
        echo -e "Looks like you have already destroyed the Infrastructure, Thank you!\U0001F431"
        echo ""
    fi
}


############################ SCRIPT STARTS ##########################

# Check if figlet is installed
if [ "$(uname -m)" = "x86_64" ]; then
    if ! which figlet > /dev/null; then
        # Install figlet using apt-get
        sudo apt-get -y install figlet
    fi
elif [ "$(uname -m)" = "arm64" ]; then
    if ! which figlet > /dev/null; then
        # Install figlet using Homebrew
        brew install figlet
    fi
else
    echo "Unsupported architecture: $(uname -m)"
    exit 1
fi

# Use figlet to print "AutoDeploy"
figlet -f slant "AutoDestroy"
echo ""
aws
