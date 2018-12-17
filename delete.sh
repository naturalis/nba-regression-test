#!/bin/bash

SERVER="http://localhost:9200"
INDEX="specimen"
DOCTYPE="Specimen"

declare -a DIRS=(specimen-query specimen-query-geo specimen-groupByScientificName)

for DIR in "${DIRS[@]}"
do
	COLTYPE="testset-$DIR"
	echo
	echo "Deleting data for collection type $COLTYPE from $DIR"			
	   
	echo curl -XPOST $SERVER/$INDEX/$DOCTYPE/_delete_by_query -d '{ "query": {"wildcard": {"collectionType" : "testset-*"}} }'
done

