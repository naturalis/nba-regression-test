## Script to generate SNG regression test data.
## Makes a data set of 4 minimal specimens,
## two with scientificNameGroup 'A', and two
## with 'B', respecively.
## A groupByScientificName query on this dataset
## thus should return two sets.

require('nbaR')

datasetName <- "testset_sng"    
filename <- "testset_specimen_sng.json"
allData <- ""
counter <- 0

for (sng in c('A', 'A', 'B', 'B')) {
    counter <- counter + 1
    sp <- Specimen$new()    
    sp$collectionType <- datasetName
    sp$unitID <- paste0("TEST.", counter, ".sng")
    sp$sourceSystemId <- paste0("TEST/", sp$unitID)

    id <- SpecimenIdentification$new()
    cn <- ScientificName$new()
    cn$fullScientificName <- "Test scientific name"
    cn$scientificNameGroup <- sng
    id$scientificName <- cn

    sp$identifications <- list(id)
    
    allData <- paste0(allData, sp$toJSONString(pretty=FALSE), "\n")
}

cat(allData, file=filename)

