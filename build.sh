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
    src=$line
    dst=$(echo $line | sed 's/k8s.gcr.io/salpadding/')
    if [[ $line == *=* ]]
    then
        src="${line#=*}"
        dst="${line#*=}"
    fi
    docker pull $src
    docker tag $src $dst
    docker push $dst
  done

else
  echo "$file not found."
fi
