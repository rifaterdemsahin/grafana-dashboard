To deploy a Grafana dashboard using a Kubernetes `ConfigMap`, follow these steps:

### 1. **Prerequisites**
Ensure you have:
- A running Kubernetes cluster.
- Grafana deployed in your cluster.
- Kubernetes CLI (`kubectl`) configured to interact with your cluster.

### 2. **Apply the ConfigMap**
Save the YAML configuration into a file, e.g., `grafana-dashboard-configmap.yaml`:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: grafana-dashboard
  labels:
    grafana_dashboard: "1"
data:
  sample-dashboard.json: |
    {
      "dashboard": {
        "id": null,
        "uid": null,
        "title": "Sample Dashboard",
        "tags": [],
        "timezone": "browser",
        "schemaVersion": 16,
        "version": 0,
        "refresh": "5s",
        "panels": [
          {
            "type": "graph",
            "title": "Sample Graph",
            "gridPos": {
              "x": 0,
              "y": 0,
              "w": 24,
              "h": 9
            },
            "id": 1,
            "datasource": null,
            "targets": [
              {
                "target": "sample.metric",
                "refId": "A"
              }
            ],
            "lines": true,
            "linewidth": 1,
            "nullPointMode": "null"
          }
        ]
      },
      "overwrite": false
    }
```

Deploy it to the cluster:

```bash
kubectl apply -f grafana-dashboard-configmap.yaml
```

### 3. **Mount the ConfigMap to Grafana**
Modify the Grafana deployment or pod configuration to include the ConfigMap. You need to mount the ConfigMap to the `dashboards` directory in the Grafana container.

Example snippet for a `Deployment`:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: grafana
spec:
  replicas: 1
  selector:
    matchLabels:
      app: grafana
  template:
    metadata:
      labels:
        app: grafana
    spec:
      containers:
      - name: grafana
        image: grafana/grafana:latest
        volumeMounts:
        - name: grafana-dashboard-config
          mountPath: /var/lib/grafana/dashboards
          readOnly: true
      volumes:
      - name: grafana-dashboard-config
        configMap:
          name: grafana-dashboard
```

Apply the updated deployment:

```bash
kubectl apply -f grafana-deployment.yaml
```

### 4. **Enable Provisioning**
Ensure that Grafana is configured to load dashboards from the directory where the ConfigMap is mounted. Create a dashboard provisioning configuration file, typically under `/etc/grafana/provisioning/dashboards`, like so:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: grafana-dashboards-provisioning
data:
  dashboards.yaml: |
    apiVersion: 1
    providers:
      - name: "default"
        orgId: 1
        folder: ""
        type: "file"
        options:
          path: /var/lib/grafana/dashboards
```

Deploy it to the cluster:

```bash
kubectl apply -f grafana-dashboards-provisioning.yaml
```

Mount this ConfigMap in the Grafana deployment at `/etc/grafana/provisioning/dashboards`:

```yaml
      volumeMounts:
      - name: grafana-dashboards-provisioning
        mountPath: /etc/grafana/provisioning/dashboards
      volumes:
      - name: grafana-dashboards-provisioning
        configMap:
          name: grafana-dashboards-provisioning
```

Copilot was utilized to integrate this section into the values-grafana.yaml.

### 5. **Verify**
After applying the configurations:
1. Restart the Grafana pod.
2. Log in to Grafana and check for the dashboard titled "Sample Dashboard."

If you encounter issues, check the Grafana logs for any errors in loading dashboards:

```bash
kubectl logs <grafana-pod-name>
```
