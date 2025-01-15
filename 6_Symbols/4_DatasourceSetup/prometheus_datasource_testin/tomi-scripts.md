# Tomi implementation Gpt Generated

- minikube start
- helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
- helm repo update
- kubectl create namespace grafana-monitoring 
- helm install prometheus-operator prometheus-community/kube-prometheus-stack -n grafana-monitoring
# in the back ground it installs the grafana service

- 


- kubectl apply -f /workspaces/grafana-dashboard/6_Symbols/4_DatasourceSetup/tomi-datasource.yaml -n grafana-grafanamonitoring

