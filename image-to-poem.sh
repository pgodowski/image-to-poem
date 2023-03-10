#!/bin/sh


mkdir -p txt

for i in *.png; do
    echo ${i}
    j=`echo ${i} | tr ' ' '-' | tr -d '(' | tr -d ')'`
    echo ${j}
    #curl -H "apikey:helloworld" --form "file=@${i}" --form "language=eng" --form "isOverlayRequired=true" https://api.ocr.space/Parse/Image > txt/${j}.json
done


echo > txt/words.txt
for txt in txt/*.json; do
    cat ${txt} | jq | grep LineText >> txt/words.txt
done

cat txt/words.txt | sort | uniq | sed -e 's/.*"LineText": "//g' | sed -e 's/".*//g' | grep -v ' ' > txt/words-for-poem.txt

