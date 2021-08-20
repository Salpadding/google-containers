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
    if [[ $line == *=* ]]
    then
        src="${line#=*}"
        dst="${line#*=}" 
    fi
    docker pull $dst
    docker tag $dst $src
  done

else
  echo "$file not found."
fi
