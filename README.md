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

## Format of test data
Test data is provided in JSON format and must be compatible with the [NBA](https://github.com/naturalis/nba-regression-test/tree/master/specimen-query).

## Format of queries and expected query results
