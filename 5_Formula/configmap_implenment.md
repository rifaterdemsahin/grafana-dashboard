To include the sample dashboard JSON in your YAML configuration, you can add it as a ConfigMap. This way, you can reference it in your Grafana deployment. Here's how you can do it:

1. **Create a ConfigMap for the Dashboard**:
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

2. **Reference the ConfigMap in Your Grafana Deployment**:
   Add a volume and volumeMount to your Grafana deployment to use the ConfigMap.

   ```yaml
   admin:
     user: "admin"
     password: "your-password"  # Consider using Kubernetes secrets

   grafana:
     replicaCount: 1
     persistence:
       enabled: true
       size: 100Mi
     service:
       type: NodePort  # Ensure this is the intended service type
       port: 3000
       nodePort: 30000
     initContainers:
       - name: init-chmod-data
         image: busybox
         command: ['sh', '-c', 'chmod -R 777 /var/lib/grafana']
         volumeMounts:
           - name: grafana-storage
             mountPath: /var/lib/grafana
       - name: install-ping
         image: alpine
         command: ['sh', '-c', 'apk add --no-cache iputils && sleep 1']
     extraVolumes:
       - name: grafana-storage
         emptyDir: {}
     volumes:
       - name: grafana-dashboard
         configMap:
           name: grafana-dashboard
     volumeMounts:
       - name: grafana-dashboard
         mountPath: /var/lib/grafana/dashboards
         subPath: sample-dashboard.json

   service:
     type: ClusterIP  # Ensure this is the intended service type
     ports:
       grafana: 3000
   ```

This setup will mount the dashboard JSON file into the Grafana container, making it available for Grafana to load.

If you have any further questions or need additional assistance, feel free to ask!
