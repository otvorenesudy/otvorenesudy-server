status=$(curl --max-time 15 -s -o /dev/null -w '%{http_code}\n' "http://localhost:9200/decrees_production/_search")

if [[ $status -ne 200 ]]; then
  echo "elasticsearch-check # Elasticsearch timed out with [$status] status, restarting ..." | ts
  /bin/systemctl restart elasticsearch
  echo "elasticsearch-check # Elasticsearch restarted" | ts
fi