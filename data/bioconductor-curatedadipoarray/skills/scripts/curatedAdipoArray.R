# Code example from 'curatedAdipoArray' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    warning = FALSE,
    message = FALSE
)

## ----install_biocmanager,eval=FALSE-------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("curatedAdipoArray")

## ----loading_libraries--------------------------------------------------------
# loading required libraries
library(ExperimentHub)
library(SummarizedExperiment)

## ----loading_data-------------------------------------------------------------
# query package resources on ExperimentHub
eh <- ExperimentHub()
query(eh, "curatedAdipoArray")

## ----choose_resource----------------------------------------------------------
listResources(eh, "curatedAdipoArray")[43]

## ----genetics_object----------------------------------------------------------
genetic <- query(eh, 'curatedAdipoArray')[[43]]

## ----expression_set-----------------------------------------------------------
# show class of the SummarizedExperiment
class(genetic)

# show the first table
assay(genetic)[1:5, 1:5]

# show the second table
colData(genetic)[1:5,]

## ----echo=FALSE---------------------------------------------------------------
column_desc <- list(
"series_id" = "The GEO series identifier.",
"sample_id"="The GEO sample identifier.",
"pmid"="The pubmed identifier of the published study.",
"time"="The time from the start of the differentiation protocol in hours.",
"media"="The differentiation media MDI or none.",
"treatment"="The treatment status: none, drug, knockdown or overexpression.",
"treatment_target"="The target of the treatment: gene name or a biological 
pathway.",
"treatment_type"="The type of the treatment.",
"treatment_subtype"="The detailed subtype of the treatment.",
"treatment_time"="The time of the treatment in relation to differentiation time
: -1, before; 0, at; and 1 after the start of the differentiation induction.",
"treatment_duration"="The duration from the treatment to the collection of the 
RNA from the sample.",
"treatment_dose"="The dose of the treatment.",                           
"treatment_dose_unit"="The dose unit of the treatment.",                       
"channels"="The number of the channels on the array chip: 1 or 2.",
"gpl"="The GEO GPL/annotation identifier.",
"geo_missing"="The availability of the data on GEO: 0 or 1.",
"symbol_missing"="The availability of the gene symbol of the probes in  the GPL
object.",                                 
"perturbation_type"="The type of the perturbation: genetic or pharmacological."
)
knitr::kable(
    data.frame(
        col_id = names(column_desc),
        description = unlist(column_desc, use.names = FALSE)
    )
)

## ----citation, eval=FALSE-----------------------------------------------------
# # citing the package
# citation("curatedAdipoArray")

## ----session_info, eval=FALSE-------------------------------------------------
# devtools::session_info()

