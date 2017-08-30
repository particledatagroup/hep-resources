#!/bin/bash
URLS=$(sed -n '/%\s*no check-links/! s/.*\\url{\(.*\)}/\1/p' databases-body.tex)
previous_url=''
return_code=0

function test_url() {
  curl --fail -I "$@" -s >/dev/null
}

echo "Checking links..."
for url in $URLS; do
  test_url "$url" || test_url "${previous_url}${url}" || { echo FAILED: $url && return_code=1; }
  previous_url=$url
done

if [ $return_code -eq 0 ]; then
  echo OK!
fi
