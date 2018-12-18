# nba-regression-test
Regression test for [Netherlands Biodiversity API (NBA)](https://github.com/naturalis/naturalis_data_api).

## Introduction
This regression test works with three scripts (from the top-level directory in this repo):
 * `insert.sh`, `delete.sh`: inserts and deletes test data, respectively
 * `run.sh` runs the tests

Data and test queries can be added in directories in this repo. 
E.g. the [specimen-query](https://github.com/naturalis/nba-regression-test/tree/master/specimen-query)
directory contains data and test queries for specimen objects and the `query` endpoint.
Each directory contains two files: `data.json` containing the data and `query-and-expect.json`
containing the queries and expected results of these queries.

## Data format

### Test data
Test data is provided in JSON format and must be compatible with the [NBA](https://github.com/naturalis/nba-regression-test/tree/master/specimen-query).

### Queries and expected query results
The queries and expected values are stored in tsv (tab-separated value) files named `query-and-expect.tsv`, located in the subdirectories for specific queries. 

[Example table:](https://github.com/naturalis/nba-regression-test/blob/master/specimen-groupByScientificName/query-and-expect.tsv)

| query_path                                                 | field_expected | value_expected |
|------------------------------------------------------------|----------------|----------------|
| specimen/groupByScientificName/?collectionType=testset_sng | totalSize      | 2              |

First field is the path of the query (without the server location), second one the field of the result set to be tested (nested fields are seperated by a `.`) and the third field is the value expected for this field given the query.

## Running the integration tests

### Inserting the test data into ElasticSearch
Log onto the test server. The script `insert.sh` inserts all data in the data subdirectories directly into Elastic Serch. **Note:** The location of the Elastic Search cluster is hard-coded in the script and defaults to http://localhost:9200.

### Running the tests
The script `run.sh` runs the tests by running all queries specified in the `query-and-expect.tsv` files in the subdirectories and compares the output to the values specified in these files. After running the queries, a summary will be displayed. If tests fail, the script will tell you so and also print the queries from the tests that failes. **Note:** The server location is hard-coded in the script and defaults to http://145.136.242.167:8080/v2.

### Cleaning up
The script `delete.sh` removes the data. It does this by removing all records for which the field `collectionType` starts with `testset-`.

