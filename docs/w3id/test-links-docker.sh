#!/bin/bash

# Using curl as a link checker
# https://alexwlchan.net/2022/04/checking-with-curl/
# -H "Accept: text/turtle"
# -H "Accept: application/n-triples"
# -H  "Accept: application/ld+json"


BASE_URL="${BASE_URL:-http://localhost:8000}"

ERRORS=0

for path in $(grep ^/ paths_to_check.txt)
do
  url="$BASE_URL$path"
  echo -n "Checking $url... "

  STATUS_CODE=$(curl -L \
      --output /dev/null \
      --silent \
      --write-out "%{http_code}" \
      "$url")

  if (( STATUS_CODE == 200 ))
  then
    echo "$STATUS_CODE"
  else
    echo -e "\033[0;31m$STATUS_CODE !!!\033[m"
    ERRORS=$(( ERRORS + 1 ))
  fi
done

if (( ERRORS != 0 ))
then
  echo -e "\033[0;31m!!! Errors checking URLs!\033[m"
fi

ERRORS=0
for path in $(grep ^/ paths_to_check.txt)
do
  url="$BASE_URL$path"
  echo -n "Checking $url for text/turtle ... "

  STATUS_CODE=$(curl -L \
        -H "Accept: text/turtle" \
      --output /dev/null \
      --silent \
      --write-out "%{http_code}" \
      "$url")

  if (( STATUS_CODE == 200 ))
  then
    echo "$STATUS_CODE"
  else
    echo -e "\033[0;31m$STATUS_CODE !!!\033[m"
    ERRORS=$(( ERRORS + 1 ))
  fi
done

if (( ERRORS != 0 ))
then
  echo -e "\033[0;31m!!! Errors checking URLs for Turtle!\033[m"
fi

ERRORS=0
for path in $(grep ^/ paths_to_check.txt)
do
  url="$BASE_URL$path"
  echo -n "Checking $url for JSON-LD ... "

  STATUS_CODE=$(curl -L \
        -H "Accept: application/ld+json" \
      --output /dev/null \
      --silent \
      --write-out "%{http_code}" \
      "$url")

  if (( STATUS_CODE == 200 ))
  then
    echo "$STATUS_CODE"
  else
    echo -e "\033[0;31m$STATUS_CODE !!!\033[m"
    ERRORS=$(( ERRORS + 1 ))
  fi
done

if (( ERRORS != 0 ))
then
  echo -e "\033[0;31m!!! Errors checking URLs for JSON-LD\033[m"
fi

ERRORS=0
for path in $(grep ^/ paths_to_check.txt)
do
  url="$BASE_URL$path"
  echo -n "Checking $url for N-Triples ... "

  STATUS_CODE=$(curl -L \
        -H "Accept: application/n-triples" \
      --output /dev/null \
      --silent \
      --write-out "%{http_code}" \
      "$url")

  if (( STATUS_CODE == 200 ))
  then
    echo "$STATUS_CODE"
  else
    echo -e "\033[0;31m$STATUS_CODE !!!\033[m"
    ERRORS=$(( ERRORS + 1 ))
  fi
done

if (( ERRORS != 0 ))
then
  echo -e "\033[0;31m!!! Errors checking URLs for N-Triples!\033[m"
fi

ERRORS=0
for path in $(grep ^/ paths_to_check.txt)
do
  url="$BASE_URL$path"
  echo -n "Checking $url for RDF+XML ... "

  STATUS_CODE=$(curl -L \
        -H "Accept: application/rdf+xml" \
      --output /dev/null \
      --silent \
      --write-out "%{http_code}" \
      "$url")

  if (( STATUS_CODE == 200 ))
  then
    echo "$STATUS_CODE"
  else
    echo -e "\033[0;31m$STATUS_CODE !!!\033[m"
    ERRORS=$(( ERRORS + 1 ))
  fi
done

if (( ERRORS != 0 ))
then
  echo -e "\033[0;31m!!! Errors checking URLs for RDF+XML!\033[m"
  exit 1
fi

