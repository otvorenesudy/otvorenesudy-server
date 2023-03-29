#!/bin/bash

pkill -f chromium-browser
pkill -f chrome
curl --max-time 15 -s -o /dev/null "https://prokuratura.otvorenesudy.sk/criminality?l=sk"
curl --max-time 15 -s -o /dev/null "https://prokuratura.otvorenesudy.sk/criminality?l=en"

array=(
  "https://otvorenesudy.sk"
  "https://otvorenesudy.sk/decrees"
  "https://api.otvorenesudy.sk"
  "https://prokuratura.otvorenesudy.sk"
)

for url in "${array[@]}"
do
    echo "self-recovery # Testing [$url] ..." | ts

    status=$(curl --max-time 15 -s -o /dev/null -w '%{http_code}\n' "${url}")

    if [[ $status -ne 200 ]]; then
      /bin/systemctl restart postgresql
      /bin/systemctl restart memcached
      /bin/systemctl restart redis-server
      /bin/systemctl restart nginx
      /bin/systemctl restart elasticsearch

      echo "self-recovery # Url [$url] returned [$status] status and services restarted" | ts 1>&2
      exit 0
    else 
      echo "self-recovery # Url [$url] returned [$status] status" | ts
    fi
done

status=$(curl --max-time 15 -s -o /dev/null -w '%{http_code}\n' "http://localhost:9200/decrees_production/_search")

if [[ $status -ne 200 ]]; then
  echo "self-recovery # Elasticsearch timed out with [$status] status, restarting ..." | ts
  /bin/systemctl restart elasticsearch
  echo "self-recovery # Elasticsearch restarted" | ts
fi

exit 0