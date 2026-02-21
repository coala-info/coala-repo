# Code example from 'RCAS.metaAnalysis.vignette' vignette. See references/ for full tutorial.

## ----global_options, include=FALSE--------------------------------------------
knitr::opts_chunk$set(warning = FALSE, message = FALSE, eval = FALSE, fig.width = 7, fig.height = 4.2)

## ----load_libraries, results='hide'-------------------------------------------
# library(RCAS)

## -----------------------------------------------------------------------------
# FUS_rep1_path <- system.file('extdata', 'FUS_Nakaya2013c_hg19.bed', package = 'RCAS')
# FUS_rep2_path <- system.file('extdata', 'FUS_Nakaya2013d_hg19.bed', package = 'RCAS')
# FMR1_rep1_path <- system.file('extdata', 'FMR1_Ascano2012a_hg19.bed', package = 'RCAS')
# FMR1_rep2_path <- system.file('extdata', 'FMR1_Ascano2012b_hg19.bed', package = 'RCAS')
# EIF4A3_rep1_path <- system.file('extdata', 'EIF4A3Sauliere20121a.bed', package = 'RCAS')
# EIF4A3_rep2_path <- system.file('extdata', 'EIF4A3Sauliere20121b.bed', package = 'RCAS')

## -----------------------------------------------------------------------------
# projData <- data.frame('sampleName' = c('FUS_1', 'FUS_2', 'FMR1_1', 'FMR1_2', 'EIF4A3_1', 'EIF4A3_2'),
#                        'bedFilePath' = c(FUS_rep1_path, FUS_rep2_path,
#                                          FMR1_rep1_path, FMR1_rep2_path,
#                                          EIF4A3_rep1_path, EIF4A3_rep2_path),
#                        stringsAsFactors = FALSE)
# 
# projDataFile <- file.path(getwd(), 'myProjDataFile.tsv')
# write.table(projData, projDataFile, sep = '\t', quote =FALSE, row.names = FALSE)

## -----------------------------------------------------------------------------
# gtfFilePath <- system.file("extdata", "hg19.sample.gtf", package = "RCAS")

## -----------------------------------------------------------------------------
# databasePath <- file.path(getwd(), 'myProject.sqlite')
# invisible(createDB(dbPath = databasePath, projDataFile = projDataFile, gtfFilePath = gtfFilePath, genomeVersion = 'hg19'))

## -----------------------------------------------------------------------------
# RCAS::deleteSampleDataFromDB(dbPath = databasePath, sampleNames = c('FMR1_1', 'FMR1_2'))

## -----------------------------------------------------------------------------
# knitr::kable(RCAS::summarizeDatabaseContent(dbPath = databasePath))

## -----------------------------------------------------------------------------
# mydb <- RSQLite::dbConnect(RSQLite::SQLite(), databasePath)

## -----------------------------------------------------------------------------
# RSQLite::dbListTables(mydb)

## -----------------------------------------------------------------------------
# annotationSummaries <- RSQLite::dbReadTable(mydb, 'annotationSummaries')
# knitr::kable(annotationSummaries)

## -----------------------------------------------------------------------------
# sampleData <- data.frame('sampleName' = c('FUS_1', 'FUS_2', 'EIF4A3_1', 'EIF4A3_2'),
#                          'sampleGroup' = c('FUS', 'FUS', 'EIF4A3', 'EIF4A3'),
#                          stringsAsFactors = FALSE)
# sampleDataFile <- file.path(getwd(), 'mySampleDataTable.tsv')
# write.table(sampleData, sampleDataFile, sep = '\t', quote =FALSE, row.names = FALSE)

## -----------------------------------------------------------------------------
# runReportMetaAnalysis(dbPath = databasePath, sampleTablePath = sampleDataFile,
#                       outFile = file.path(getwd(), 'myProject.html'))

