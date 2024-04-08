#!/bin/bash

set -e

attachments=$(curl -L "http://localhost:8080/rest/api/2/issue/${ISSUE_KEY}?fields=attachment" \
                   -H "Authorization: Bearer ${JIRA_PAT}" \
              | jq -r '.fields.attachment[].content')

downloaded=()
skipped=()

for file in $attachments; do
  if [[ "$file" == *.csv ]]; then
    downloaded+=($file)
    curl -SOsf --create-dirs --output-dir ./jira_temp -H "Authorization: Bearer ${JIRA_PAT}" $file
  else
    skipped+=($file)
  fi
done

if [[ "${#downloaded[@]}" != 0 ]]; then
  echo -e "\nDownloaded ${#downloaded[@]} file(s)"
  echo "List of downloaded files: "
  for file in "${downloaded[@]}"; do
    echo $file
  done
fi

if [[ "${#skipped[@]}" != 0 ]]; then
  echo -e "\nSkipped ${#skipped[@]} file(s)"
  echo "List of skipped files: "
  for file in "${skipped[@]}"; do
    echo $file
  done
fi
