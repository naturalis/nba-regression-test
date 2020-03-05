#!/bin/bash

SERVER="http://localhost:9200"
INDEX="specimen-crs-20200226213005"
DOCTYPE="Specimen"

declare -a DIRS=(specimen-query-geo) #(specimen-query specimen-query-geo specimen-groupByScientificName)

for DIR in "${DIRS[@]}"
do		
	FILE="$DIR/data.json"	
	echo "Importing data from $FILE"
	while read ENTRY; do
	    HASH=$(echo $ENTRY | md5sum | cut -f 1 -d ' ')	    
	    curl -w "\n" -H "Content-Type: application/json" -XPOST $SERVER/$INDEX/_doc/TEST-$HASH -d "$ENTRY"
	done < $FILE
	
done

curl -XPOST http://localhost:9200/$INDEX/_refresh

