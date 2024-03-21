This Compose file sets up two services:

Grafana: 
- Exposes Grafana on port 3000.
- It sets an admin password and disables sign-up for new users. 
- Grafana's data is persisted to a volume named grafana_data.

Prometheus: 
- Exposes Prometheus on port 9090. 
- It mounts a Prometheus configuration file (prometheus.yml) into the container
- persists Prometheus data to a volume named prometheus_data.

After starting the services, you can access Grafana at http://localhost:3000 and Prometheus at http://localhost:9090.

