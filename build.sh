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
    dst=$(echo $line | sed 's/k8s.gcr.io/salpadding/')
    docker pull $line
    docker tag $line $dst
    docker push $dst
  done

else
  echo "$file not found."
fi
