#!/bin/bash
kubectl create rolebinding kube-scheduler-auth-reader  --clusterrole=extension-apiserver-authentication-reader --serviceaccount=kube-system:kube-scheduler --namespace=kube-system

# chmod +x /workspaces/grafana-dashboard/6_Symbols/1_Init/minikube-startup.sh
# /workspaces/grafana-dashboard/6_Symbols/1_Init/minikube-startup.sh