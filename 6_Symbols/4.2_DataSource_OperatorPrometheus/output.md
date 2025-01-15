@rifaterdemsahin ➜ /workspaces/grafana-dashboard (main) $ minikube start
😄  minikube v1.34.0 on Ubuntu 20.04 (docker/amd64)
✨  Using the docker driver based on existing profile
👍  Starting "minikube" primary control-plane node in "minikube" cluster
🚜  Pulling base image v0.0.45 ...
🔄  Restarting existing docker container for "minikube" ...
🐳  Preparing Kubernetes v1.31.0 on Docker 27.2.0 ...
🔎  Verifying Kubernetes components...
    ▪ Using image gcr.io/k8s-minikube/storage-provisioner:v5
🌟  Enabled addons: storage-provisioner, default-storageclass
🏄  Done! kubectl is now configured to use "minikube" cluster and "default" namespace by default
@rifaterdemsahin ➜ /workspaces/grafana-dashboard (main) $ helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
"prometheus-community" already exists with the same configuration, skipping
@rifaterdemsahin ➜ /workspaces/grafana-dashboard (main) $ helm repo update
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "prometheus-community" chart repository
...Successfully got an update from the "bitnami" chart repository
Update Complete. ⎈Happy Helming!⎈
@rifaterdemsahin ➜ /workspaces/grafana-dashboard (main) $ kubectl create namespace grafana-monitoring 
Error from server (AlreadyExists): namespaces "grafana-monitoring" already exists
@rifaterdemsahin ➜ /workspaces/grafana-dashboard (main) $ helm install prometheus-operator prometheus-community/kube-prometheus-stack -n grafana-monitoring
Error: INSTALLATION FAILED: cannot re-use a name that is still in use
@rifaterdemsahin ➜ /workspaces/grafana-dashboard (main) $ 


@rifaterdemsahin ➜ /workspaces/grafana-dashboard (main) $ kubectl apply -f /workspaces/grafana-dashboard/6_Symbols/4_DatasourceSetup/tomi-datasource.yaml -n grafana-grafanamonitoring
error: resource mapping not found for name: "grafanadatasource-sample" namespace: "" from "/workspaces/grafana-dashboard/6_Symbols/4_DatasourceSetup/tomi-datasource.yaml": no matches for kind "GrafanaDatasource" in version "grafana.integreatly.org/v1beta1"
ensure CRDs are installed first
@rifaterdemsahin ➜ /workspaces/grafana-dashboard (main) $ 



The error indicates that the `GrafanaDatasource` custom resource is not recognized because the required Custom Resource Definitions (CRDs) are not installed. To resolve this issue, follow these steps:

### 1. Verify the CRDs are Installed
Ensure that the `GrafanaDatasource` CRD from the `grafana-operator` is installed in your cluster. Run the following command to check:

```bash
kubectl get crds | grep grafana
```

If the CRD `grafanadatasources.integreatly.org` is missing, proceed to install it.

---

### 2. Install the `grafana-operator` CRDs
If the CRD is not installed, you need to apply the CRDs for the `grafana-operator`. You can usually get them from the operator's GitHub repository or Helm chart. Here’s a common way to install them:

- From YAML manifests:

```bash
kubectl apply -f https://raw.githubusercontent.com/grafana-operator/grafana-operator/main/deploy/crds/grafana-operator-crd.yaml
```

@rifaterdemsahin ➜ /workspaces/grafana-dashboard (main) $ kubectl apply -f https://raw.githubusercontent.com/grafana-operator/grafana-operator/main/deploy/crds/grafana-operator-crd.yaml
error: unable to read URL "https://raw.githubusercontent.com/grafana-operator/grafana-operator/main/deploy/crds/grafana-operator-crd.yaml", server reported 404 Not Found, status code=404
@rifaterdemsahin ➜ /workspaces/grafana-dashboard (main) $ 

- Or, if using Helm, install the operator, which will deploy the necessary CRDs:

```bash
helm repo add grafana-operator https://grafana-operator.github.io/grafana-operator
helm install grafana-operator grafana-operator/grafana-operator
```

@rifaterdemsahin ➜ /workspaces/grafana-dashboard (main) $ helm repo add grafana-operator https://grafana-operator.github.io/grafana-operator
Error: looks like "https://grafana-operator.github.io/grafana-operator" is not a valid chart repository or cannot be reached: failed to fetch https://grafana-operator.github.io/grafana-operator/index.yaml : 404 Not Found



---

### 3. Reapply the `tomi-datasource.yaml`
After ensuring the CRD is installed, reapply your resource file:

```bash
kubectl apply -f /workspaces/grafana-dashboard/6_Symbols/4_DatasourceSetup/tomi-datasource.yaml -n grafana-grafanamonitoring
```

---

### 4. Verify the Resource
Once applied, verify the `GrafanaDatasource` is successfully created:

```bash
kubectl get grafanadatasource -n grafana-grafanamonitoring
```

If any further issues arise, inspect the logs of the `grafana-operator` pod:

```bash
kubectl logs -n <operator-namespace> <grafana-operator-pod>
```

This process should resolve the issue and ensure your `GrafanaDatasource` is properly applied.