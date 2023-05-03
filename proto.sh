#!/bin/bash

find . -type f |
while read filename
do
  if [[ "$filename" == *".proto"* ]]; then
    dir="$(dirname "$filename")"
    cmd="protoc --go_out=${dir} --go-grpc_out=${dir} --go-grpc_opt=require_unimplemented_servers=false ${dir}/*.proto"
    echo "$cmd"
    eval "$cmd"
  fi
done
