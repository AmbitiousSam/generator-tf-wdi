#!/bin/bash

# Function to handle operations for Minikube
do_minikube() {
  if [ -z "$CERT_INGRESS" ]; then
    INGRESS_NAME="my-harbor"
  else
    INGRESS_NAME=$CERT_INGRESS
  fi

  kubectl get secrets $INGRESS_NAME-ingress -o jsonpath="{.data['ca\.crt']}" | base64 -d >harbor-ca.crt
  scp -o IdentitiesOnly=yes -i $(minikube ssh-key) harbor-ca.crt docker@$(minikube ip):./harbor-ca.crt

  minikube ssh -- sudo mkdir -p /etc/docker/certs.d/core.harbor.domain
  minikube ssh -- sudo cp harbor-ca.crt /etc/docker/certs.d/core.harbor.domain
}

# Function to handle operations for Local
do_local() {
  if [ -z "$CERT_INGRESS" ]; then
    INGRESS_NAME="my-harbor"
  else
    INGRESS_NAME=$CERT_INGRESS
  fi

  kubectl get secrets $INGRESS_NAME-ingress -o jsonpath="{.data['ca\.crt']}" | base64 -d >harbor-ca.crt
  echo "The following commands will require you to enter your sudo password to copy the harbor certificate file to docker daemon"

  sudo mkdir -p /etc/docker/certs.d/core.harbor.domain
  sudo cp harbor-ca.crt /etc/docker/certs.d/core.harbor.domain
}

# Check for command-line options
case "$1" in
--minikube)
  do_minikube
  ;;
--local)
  do_local
  ;;
*)
  echo "Usage: $0 [--minikube|--local]"
  exit 1
  ;;
esac
