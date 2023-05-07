#!/bin/bash

curl -s "https://www.genpro.gov.sk/dokumenty/pravoplatne-uznesenia-prokuratora-ktorymi-sa-skoncilo-trestne-stihanie-vedene-proti-urcitej-2f09.html?action=download&id=211881" > test.rtf
timeout 10s unoconv -p 2002 -f text -n --stdout test.rtf &> /dev/null

if [ $? -ne 0 ]; then
  echo "unoconv-server # Unoconv is not running, restarting ..." | ts

  pkill "soffice"
  sleep 5

  unoconv --listener -p 2002 &
  disown

  echo "unoconv-server # Unoconv restarted" | ts
fi