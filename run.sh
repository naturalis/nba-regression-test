#!/bin/bash

SERVER="https://nba-api-test.k2.k8s.naturalis.nl/v2"

declare -a DIRS=(specimen-query specimen-query-geo specimen-groupByScientificName)

ERRORED=false

for DIR in "${DIRS[@]}"
do		

	FILE="$DIR/query-and-expect.tsv"
	
	echo "Testing queries in $FILE on server $SERVER"
	
	FAILED_TESTS=0
	PASSED_TESTS=0
	
	while IFS=$'\t' read -r -a myArray
	do
		# read data with queries, fields, and expected values
		# from file named 'query-and-expect.tsv'
		QUERY="${myArray[0]}"
		FIELD="${myArray[1]}"
		EXPECT="${myArray[2]}"
		
		CMD="curl -s $SERVER/$QUERY"
		
		RESULT=$($CMD | jq -r ".$FIELD")
		
		if [ "$RESULT" != "$EXPECT" ];
		then
			FAILED_TESTS=$((FAILED_TESTS + 1))
			ERRORED=true
		else
			PASSED_TESTS=$((PASSED_TESTS + 1))
		fi
		
	done < <(tail -n +2 $FILE)

	echo "Tested $DIR/query-and-expect.tsv; Passed: $PASSED_TESTS, Failed: $FAILED_TESTS"		
done

if [ $ERRORED = true ];
then
	echo "There were errors in the integration test." >&2
	exit 1
else
	exit 0	
fi

	
