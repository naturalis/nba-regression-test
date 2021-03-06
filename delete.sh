#!/bin/bash

SERVER="http://localhost:9200"
INDEX="specimen-crs-20200226213005"
DOCTYPE="Specimen"

declare -a DIRS=(specimen-query specimen-query-geo specimen-groupByScientificName)

for DIR in "${DIRS[@]}"
do
	COLTYPE="testset-$DIR"
	echo
	echo "Deleting data for collection type $COLTYPE from $DIR"			
	   
	curl -H "Content-Type: application/json" -XPOST $SERVER/$INDEX/_doc/_delete_by_query -d '{ "query": {"wildcard": {"collectionType" : "testset-*"}} }'
done

curl -XPOST http://localhost:9200/$INDEX/_refresh
