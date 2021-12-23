#!/bin/bash
set -e

echo Namespace = "$1"
NAMESPACE=$1
RELEASE_NAME="$2"

kubectl config get-contexts
kubectl create ns "$NAMESPACE"
kubectl config set-context --current --namespace "$NAMESPACE"
helm lint pages
helm template pages


echo "------------------------Start time is--------  $(date +%Y-%m-%dT%H%M%S%z)"

helm upgrade --install "$RELEASE_NAME" pages --debug

echo "------------------------End time is--------  $(date +%Y-%m-%dT%H%M%S%z)"

echo '---------------------Started testing--------------'
sleep 60s
kubectl get po -n "$NAMESPACE" --show-labels
kubectl get svc -n "$NAMESPACE" -o wide
helm test "$RELEASE_NAME" --logs
echo '---------------------Completed testing------------'

helm uninstall "$RELEASE_NAME"
kubectl delete ns "$NAMESPACE"