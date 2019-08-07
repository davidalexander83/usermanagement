#!/bin/bash

declare -a groupArray

echo -e "---\ngroups:\n" > temp.yaml

groups=$(getent group | awk -F':' '{ print $1 }')
while read -r line
do
  groupArray+=("$line")
done <<< "$groups"

for group in "${groupArray[@]}"
do
  echo -e "  ${group}:\n    users:\n" >> temp.yaml
  input="$(lid -g "$group" | awk -F'(' '{ print $1 }')"
  while read -r line
  do
    echo -e "    - ${line}" >> temp.yaml
  done <<< "$input"
done

#for group in "${groupArray[@]}"
#do
#  userArray+=("$(lid -g "$group" | awk -F'(' '{ print $1 }')")
#  printf "    \"%s\": {\n      \"users\": [\n" "$group" >> temp.json
#  for user in "${userArray[@]}"
#  do
#    printf "        %s,\n" "$user" >> temp.json
#  done
#done

cat temp.yaml