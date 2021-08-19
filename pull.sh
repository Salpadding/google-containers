#!/usr/bin/env bash
set -e
CUR=$(dirname $0)
CUR=$(cd $CUR; pwd)

echo "current directory = $CUR"

file="$CUR/images.properties"

if [ -f "$file" ]
then
  echo "$file found."

  cat $file | while read line
  do
    src=$(echo $line | sed 's/k8s.gcr.io/salpadding/')
    docker pull $src
    docker tag $src $file
  done

else
  echo "$file not found."
fi
