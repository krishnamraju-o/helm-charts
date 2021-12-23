#!/bin/bash
set -e

echo Namespace = "$1"
echo Releasename = "$2"
echo "----------------------Installing pages----------------------------------"


NAMESPACE="$1"
RELEASE_NAME="$2"

kubectl get ns "$NAMESPACE" &> /dev/null || kubectl create ns "$NAMESPACE"

helm upgrade --install "$RELEASE_NAME" pages -n "$NAMESPACE" --debug
helm list
kubectl config current-context
sleep 30s

kubectl get pods -n "$NAMESPACE"


echo "----------------------Completed Installation of  pages----------------------------------"