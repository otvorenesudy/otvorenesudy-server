#!/bin/bash

array=(
  "https://otvorenesudy.sk"
  "https://otvorenesudy.sk/decrees"
  "https://api.otvorenesudy.sk"
  "https://api.otvorenesudy.sk"
  "https://prokuratura.otvorenesudy.sk"
  "https://prokuratura.otvorenesudy.sk/criminality?l=sk"
  "https://prokuratura.otvorenesudy.sk/criminality?l=en"
)

for url in "${array[@]}"
do
    status=$(curl --max-time 15 -s -o /dev/null -w '%{http_code}\n' "${url}")

    if ((status != 200)); then
      /bin/systemctl restart postgresql
      /bin/systemctl restart memcached
      /bin/systemctl restart redis-server
      /bin/systemctl restart nginx
    fi
done

status=$(curl --max-time 15 -s -o /dev/null -w '%{http_code}\n' "http://localhost:9200/decrees_production/_search")

if ((status != 200)); then
  /bin/systemctl restart elasticsearch
fi

exit 0
