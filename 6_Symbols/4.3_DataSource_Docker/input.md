# 📥 Input

## 📄 Documentation in Grafana
[Grafana Documentation](https://grafana.com/docs/)

## 🐳 Docker Steps to Install Grafana and Add Data Sources

To install Grafana using Docker and set up data sources, follow these steps:

### 🛠️ Install Grafana using Docker:
```sh
docker run -d -p 3000:3000 --name=grafana grafana/grafana-enterprise
```
This command runs the latest stable version of Grafana Enterprise, mapping port 3000 to allow access via your browser.

### 🌐 Access Grafana:
Open a browser and go to [http://localhost:3000](http://localhost:3000). Log in using the default credentials:
- **Username:** admin
- **Password:** admin

### ➕ Add Data Sources:
Once logged in, you can add data sources through the Grafana UI:
1. Click on "Connections" in the left-side menu.
2. Search for the data source you want to add.
3. Click on the data source and then "Add new data source".
4. Configure the data source with the required settings (URL, authentication, etc.).
5. Click "Save & Test" to verify the connection.

For more detailed steps on adding data sources through the UI, refer to [Grafana for beginners: Quick tips to add a data source, choose a visualization type, and more](https://grafana.com/docs/grafana/latest/getting-started/getting-started-grafana/).

### 🔌 Pre-install Data Source Plugins:
Alternatively, you can pre-install data source plugins when running the Docker container:
```sh
docker run -d -p 3000:3000 --name=grafana \
    -e "GF_INSTALL_PLUGINS=grafana-clock-panel,grafana-simple-json-datasource" \
    grafana/grafana-enterprise
```
This example installs the clock panel and simple JSON datasource plugins.

### 🧩 Advanced Setups:
For more advanced setups, you can use Docker Compose to define and run Grafana along with other services. Refer to the [Run Grafana via Docker Compose](https://grafana.com/docs/grafana/latest/setup-grafana/installation/docker/#run-grafana-via-docker-compose) section for an example of how to set this up.

Remember to configure your data sources appropriately based on your specific requirements and the types of data you want to visualize in Grafana.

---

*I’m a beta, not like one of those pretty fighting fish, but like an early test version. Our lawyers want you to know that my answers may be wrong or not fully up to date, so please provide feedback to help me improve.*