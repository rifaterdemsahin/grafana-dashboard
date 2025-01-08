#!/bin/bash

# Deploy Grafana with a sample dashboard 🚀

# Step 1: Apply the ConfigMap for the dashboard 📊
echo "Creating ConfigMap for Grafana dashboard..."
kubectl apply -f configmap_empty.yaml -n grafana-monitoring
echo "ConfigMap created successfully! ✅"

# Step 3: Verify the deployment 🔍
echo "Checking the status of the Grafana pods..."
kubectl get pods -n grafana-monitoring
echo "Checking the status of the Grafana service..."
kubectl get svc -n grafana-monitoring

# Step 4: Access Grafana 🌐
echo "To access Grafana, use the node's IP address and the specified node port use the minikube ports and load balancer next to terminal section after kubectl port forward"

echo "Deployment script completed! 🎉"


#Save this script to a file named `deploy-grafana.sh`, make it executable, and run it:

#```sh
#chmod +x deploy-grafana.sh
#./deploy-grafana.sh
#```
