# Code example from 'SILACcomplexomics' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    fig.width=7, fig.height=4.5, 
    collapse = TRUE,
    eval = TRUE,
    comment = "#>"
)

## -----------------------------------------------------------------------------
library(ComPrAn)
inputFile <- system.file("extData", "data.txt", package = "ComPrAn")
#read in data
peptides <- peptideImport(inputFile)
#mandatory filtering
peptides <- cleanData(peptides, fCol = "Search ID")
#optional filtering
peptides <- toFilter(peptides, rank = 1)
# separate chemical modifications and labelling into separate columns
peptides <- splitModLab(peptides) 
#remove unnecessary columns, simplify rows
peptides <- simplifyProteins(peptides) 


## -----------------------------------------------------------------------------
peptide_index <- pickPeptide(peptides)

## -----------------------------------------------------------------------------
protein <- "P52815"
max_frac <- 23
#example all peptide plot (default settings)
allPeptidesPlot(peptide_index,protein, max_frac = max_frac)

## -----------------------------------------------------------------------------
listOnlyOneLabState <- onlyInOneLabelState(peptide_index)

## -----------------------------------------------------------------------------
# produce a data frame in a format needed for downstream analysis
forAnalysis <- getNormTable(peptide_index,purpose = "analysis")
# produce a data frame in an easily human readable format that can be exported
forExport <- getNormTable(peptide_index,purpose = "export")

