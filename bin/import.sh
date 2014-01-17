#!/bin/bash
set -e

curl 'https://www.lendingclub.com/fileDownload.action?file=InFundingStats3.csv.zip&type=gen' > file.zip
unzip -cqq file.zip | awk 'NR != 1 { print }' > csvs/latest.csv
cp csvs/{latest,$(date +"%T")}.csv
mongoimport --db meteor\
            --collection loans\
            --host 127.0.0.1\
            --port 3002\
            --type csv\
            --file csvs/latest.csv\
            --headerline\
            --upsert\
            --stopOnError\
            --upsertFields id

