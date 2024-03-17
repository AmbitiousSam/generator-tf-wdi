#!/bin/bash

# Define the functions to call

#applicationDeploymentazure
function applicationDeployment {
  echo ""
  echo -e "\033[1mPrerequisite:\033[0m"
  echo " 1. Make sure that you have installed kubectl and is configured with the up and running aks cluster."
  echo " 2. Make sure that you have installed azure-cli and configured it."
  echo " 3. Make sure that domain mapping is done properly."
  echo " NOTE:- You will find the DNS name of application load balancer under ./istio dir in output.txt file"
  echo ""

  echo -n "Confirm if you meet all the above requirements,(yes/no):"
  read user_continue_action_appDeployment
  if [ "$user_continue_action_appDeployment" == "yes" ]; then
      cd .. 
      cd kubernetes
      ./kubectl-apply.sh -f
      cd ..
      cd terraform
  else 
      echo "Thank you, user!"
  fi
}

#Azure
function azure {
    echo -e "You have opted for \033[1;32mAZURE\033[0m cloud provider"
    # Add code here to execute the action for azure
    echo "Initiating the azure action...."
    while true; do
      echo ""
      echo "Set up Azure credentials which will be used be terraform"
      echo -n "Provide azure client_id:"
      read client_id
      echo -n "Provide azure client_secret:"
      read client_secret
      export AZURE_CLIENT_ID=$client_id
      export AZURE_CLIENT_SECRET=$client_secret
      echo ""
      echo -e "\033[1;33mProvided azure service principal credentials\033[0m"
      echo "azure client_id:"${AZURE_CLIENT_ID}
      echo "azure client_secret:"${AZURE_CLIENT_SECRET}
      echo -n "Ensure that your azure credentials are correct,(yes/no):"
      read user_confirmation

      # convert user input to lowercase
      user_confirmation=$(echo "$user_confirmation" | tr '[:upper:]' '[:lower:]')
      if [[ "$user_confirmation" == "yes" ]]; then
          break
      fi
    done
    echo ""
    echo -e "\033[1;32mAzure service principal credentials are set!\033[0m"
    echo ""
    echo -n "Continue with the Infrastructure deployment,(yes/no):"
    read user_continue_action
    if [ "$user_continue_action" == "yes" ]; then
    echo "Deploying the Infrastructure in our Azure cloud....."
        # List of directories to process
        directories=(
        "./aks"
        "./eck"
        "./istio"
        "./istio-monitoring"
        "./k8s-web-ui"
        "./acr"
        "./acr-build&publish"
        )

        # Loop through each directory and execute command
        for dir in "${directories[@]}"
        do
            if [ -d "$dir" ]; then
                echo "Processing directory: $dir"
                cd "$dir" || exit
                # Execute your command here
                echo "Initiating terraform in $dir"
                terraform init
                echo "Auto applying terraform in $dir"
                terraform apply -auto-approve
                cd ..
            else
                echo "Directory $dir does not exist"
            fi
        done
      echo ""
      echo -e "\033[1m\033[32mInfrastructure was deployed successfully!\U0001F63B\033[0m"
      echo ""
    else 
        echo ""
        echo -e "Looks like you have already deployed the WDI, Thank you!\U0001F431"
        echo ""
    fi

    echo -n "Do you want to contiune with the application Deployment,(yes/no):"
    read  appDepolyment; 

    if [ "$appDepolyment" == "yes" ]; then
      applicationDeployment
    else 
      echo "Thank you, user!"
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
figlet -f slant "AutoDeploy"
echo ""
azure
