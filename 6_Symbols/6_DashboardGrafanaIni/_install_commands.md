- minikube delete
- minikube start --memory=4096 --cpus=2 
- kubectl create namespace grafana-monitoring 
- helm repo add bitnami https://charts.bitnami.com/bitnami  
- helm repo update 
- cd 6_Symbols/4_DashboardConfigMaps
- clear

- kubectl apply -f myconfig.yaml -n grafana-monitoring 

- kubectl apply -f grafana-datasource.yaml -n grafana-monitoring 
- kubectl apply -f configmap_randomwalk.yaml -n grafana-monitoring
- kubectl create secret generic datasource-secret --from-file=datasource-secret.yaml -n grafana-monitoring
- helm install grafana bitnami/grafana --namespace grafana-monitoring -f grafana-dashboard-deployment.yaml 

- kubectl port-forward -n grafana-monitoring svc/grafana 3000:3000  


- kubectl get pods -n grafana-monitoring
- kubectl logs grafana-64fcf79d7c-t8xhd  -n grafana-monitoring
- kubectl logs grafana-64fcf79d7c-t8xhd  -n grafana-monitoring > mylog.md