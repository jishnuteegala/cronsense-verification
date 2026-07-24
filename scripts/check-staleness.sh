#!/usr/bin/env bash
set -euo pipefail

while IFS=$'\t' read -r path expected; do
  actual=$(curl --fail --silent --show-error "https://api.github.com/repos/github/docs/contents/$path?ref=main" | grep -Eo '"sha": "[a-f0-9]+"' | head -1 | cut -d'"' -f4)
  if [[ "$actual" != "$expected" ]]; then
    echo "::warning file=$path::GitHub docs changed; re-verify Cronsense claims."
  fi
done < docs-snapshot.tsv

stamps=$(grep -Eo 'recorded-at: [0-9]{4}-[0-9]{2}-[0-9]{2}' VERIFICATION.md || true)
if [[ -z "$stamps" ]]; then
  echo "::warning::Verification stamp is missing."
else
  while IFS= read -r stamp; do
    date=${stamp#recorded-at: }
    if (( $(date -u +%s) - $(date -u -d "$date" +%s) > 7776000 )); then
      echo "::warning::Verification stamp $date is older than 90 days."
    fi
  done <<< "$stamps"
fi
