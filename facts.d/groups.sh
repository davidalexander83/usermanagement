#!/bin/bash

declare -a groupArray

echo -e "---\ngroups:" > temp.yaml

groups=$(getent group | awk -F':' '{ print $1 }')
while read -r line
do
  groupArray+=("$line")
done <<< "$groups"

for group in "${groupArray[@]}"
do
  input="$(lid -g "$group" | awk -F'(' '{ print $1 }')"
  echo -e "  ${group}:\n    users:" >> temp.yaml
  while read -r line
  do
    if [ ! "$line" == "" ]; then
      echo -e "      - ${line}" >> temp.yaml
    fi
  done <<< "$input"
done

cat temp.yaml | /usr/local/bin/yaml2json