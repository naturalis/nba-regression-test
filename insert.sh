#!/bin/bash

SERVER="http://localhost:9200"
INDEX="specimen"
DOCTYPE="Specimen"

declare -a DIRS=(specimen-query specimen-query-geo specimen-groupByScientificName)

for DIR in "${DIRS[@]}"
do		
	FILE="$DIR/data.json"	
	echo "Importing data from $FILE"
	while read ENTRY; do
		curl -w "\n" -XPOST $SERVER/$INDEX/$DOCTYPE -d "$ENTRY"
	done < $FILE
	
done

