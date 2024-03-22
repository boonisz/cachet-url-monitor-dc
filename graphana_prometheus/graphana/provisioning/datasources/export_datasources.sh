
# Use this to export all datasources from the grafana api
# Why? It's easier to configure datasources in the UI, but that's a manual process that we shouldn't have to repeat.
# Grafana will auto-provision datasources during startup that are found in the /etc/grafana/provisioning/datasources folder
# So we mount that folder to the host and generate the provisioning files into it with th

curl -s "http://localhost:3000/api/datasources" -u admin:your_admin_password_here | jq

mkdir -p datasources \
  && curl -s "http://localhost:3000/api/datasources" \
  -u admin:your_admin_password_here \
  | jq -r '[.[] | with_entries(.value |= tostring)] | {datasources: .}' \
  | python3 -c 'import yaml, sys; print("apiVersion: 1\n\n" + yaml.dump(yaml.safe_load(sys.stdin.read()), default_flow_style=False))'\
  > datasources.yml
