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
