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

# Provisioning
https://grafana.com/docs/grafana/latest/administration/provisioning/
## Export all datasources
```shell
# Use this to export all datasources from the grafana api
# It's easy to configure datasources in the UI, but that's a manual process that we shouldn't have to repeat in each environment
# Grafana will auto-provision datasources during startup that it finds in the /etc/grafana/provisioning/datasources folder

# Auth note:
# if auth is required, the curl flag is: [-u admin:your_admin_password_here]

curl -s "http://localhost:3000/api/datasources" \
  | jq -r '[.[] | with_entries(.value |= tostring | if .key == "jsonData" then .value = (.value | fromjson) else . end)] | {datasources: .}' \
  | python3 -c 'import yaml, sys; print("apiVersion: 1\n\n" + yaml.dump(yaml.safe_load(sys.stdin.read()), default_flow_style=False))' \
  > datasources.yml
```

# Todo
- connect services
  - sidekick
    - db
      - [ ] db as graphana datasource
      - [ ] db as prometheus job
    - api
      - [ ] create `/metrics` endpoint
      - [ ]
    - ui
      - [ ] determine alternative to `/metrics` endpoint
  - tracking
    - create metrics endpoint
      - [ ] create empty-response endpoint and configure in prometheus `/metrics`
      - add metrics to response body
        - [ ] camera connectivity
        - [ ] detection model connectivity
        - [ ] ffmpeg rtsp stream process status
        - [ ] sidekick api connectivity
    - multiprocessing
      - [ ] try this https://prometheus.github.io/client_python/multiprocess/
- alerts
  - [ ] how alerts will be sent: from graphana or prometheus?
  - [ ] send alert
- show status
  - [x] prometheus targets shows status - show in graphana?
  - [ ] graphana postgres datasource status?
- show incidents
  - show errors: graphana or prometheus
