#!/bin/bash

find . -type f |
while read filename
do
    if [[ "$filename" != *"interface.go"* ]]; then
        continue;
    fi

    dir="$(dirname "$filename")"
    
    i=1  
    while read line; do  
        if [[ "$line" == *"package"* ]]; then
            packageName=$(echo $line | awk '{print $2}')
        fi

        if [[ "$line" == *"type I"* ]]; then
            name=$(echo "$line" | awk '{print substr($2, 2)}')
            name="I${name}"
            break;
        fi

        i=$((i+1))

        continue;
    done < $filename

    echo "mockery --dir=${dir} --name=${name} --filename=mock.go --output=${dir} --outpkg=${packageName} --structname=${name:1}Mock"

    rm ${dir}/mock.go

    mockery --dir=${dir} --name=${name} --filename=mock.go --output=${dir} --outpkg=${packageName} --structname=${name:1}Mock
done
