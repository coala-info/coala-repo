# Code example from 'SomaScan-db' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
library(withr)
library(SomaScan.db)
library(tibble)

## ----install-bioc, eval=FALSE-------------------------------------------------
#  if (!requireNamespace("BiocManager", quietly = TRUE)) {
#      install.packages("BiocManager")
#  }
#  
#  BiocManager::install("SomaScan.db", version = remotes::bioc_version())

## ----load-pkg-----------------------------------------------------------------
library(SomaScan.db)

## ----metadata-----------------------------------------------------------------
SomaScan.db

## ----taxonomy-----------------------------------------------------------------
species(SomaScan.db)
taxonomyId(SomaScan.db)

## ----mapped-keys--------------------------------------------------------------
SomaScan()

## ----keys---------------------------------------------------------------------
# Short list of primary keys
keys(SomaScan.db) |> head(10L)

## ----keytypes-----------------------------------------------------------------
## List all of the supported key types.
keytypes(SomaScan.db)

## ----keys-keytype-arg---------------------------------------------------------
keys(SomaScan.db, keytype = "UNIPROT") |> head(20L)

## ----columns------------------------------------------------------------------
columns(SomaScan.db)

## ----help, eval=FALSE---------------------------------------------------------
#  help("OMIM") # Example help call

## ----OMIM-bimap-help, eval=FALSE----------------------------------------------
#  ?SomaScanOMIM

## ----example-keys-------------------------------------------------------------
# Randomly select a set of keys
example_keys <- withr::with_seed(101L, sample(keys(SomaScan.db),
                                              size = 5L,
                                              replace = FALSE
))

# Query keys in the database
select(SomaScan.db,
       keys = example_keys,
       columns = c("ENTREZID", "SYMBOL", "GENENAME")
)

## ----select-na----------------------------------------------------------------
# Inserting a new key that won't be found in the annotations ("TEST")
test_keys <- c(example_keys[1], "TEST")

select(SomaScan.db, keys = test_keys, columns = c("PROBEID", "ENTREZID"))

## ----select-good--------------------------------------------------------------
# Good
select(SomaScan.db, keys = example_keys[3L], columns = "GO")

## ----select-bad---------------------------------------------------------------
# Bad
select(SomaScan.db,
       keys = example_keys[3L],
       columns = c("UNIPROT", "ENSEMBL", "GO", "PATH", "IPI")
) |> tibble::as_tibble()

## ----select-no-keytype--------------------------------------------------------
select(SomaScan.db, keys = example_keys, columns = c("ENTREZID", "UNIPROT"))

## ----select-keytype-symbol----------------------------------------------------
select(SomaScan.db,
       columns = c("PROBEID", "ENTREZID"),
       keys = "SMAD2", keytype = "SYMBOL"
)

## ----select-error-casc4, error=TRUE-------------------------------------------
select(SomaScan.db,
       columns = c("PROBEID", "ENTREZID"),
       keys = "CASC4", keytype = "SYMBOL"
)

## ----select-keytype-alias-----------------------------------------------------
select(SomaScan.db,
       columns = c("SYMBOL", "PROBEID", "ENTREZID"),
       keys = "CASC4", keytype = "ALIAS"
)

## ----menu-5k------------------------------------------------------------------
all_keys <- keys(SomaScan.db)
menu_5k <- select(SomaScan.db,
                  keys = all_keys, columns = "PROBEID",
                  menu = "5k"
)

head(menu_5k)

## ----mapIds-------------------------------------------------------------------
mapIds(SomaScan.db, keys = example_keys, column = "SYMBOL")

## ----map-ids-output-----------------------------------------------------------
# Only 1 symbol per key
mapIds(SomaScan.db, keys = example_keys[3L], column = "GO")

## ----select-output------------------------------------------------------------
# All entries for chosen key
select(SomaScan.db, keys = example_keys[3L], column = "GO")

## ----multiVals-first----------------------------------------------------------
# The default - returns the first available result
mapIds(SomaScan.db, keys = example_keys[3L], column = "GO", 
       multiVals = "first")

## ----multiVals-list-----------------------------------------------------------
# Returns a list object of results, instead of only returning the first result
mapIds(SomaScan.db, keys = example_keys[3L], column = "GO", 
       multiVals = "list")

## ----ensembl-example----------------------------------------------------------
ensg <- select(SomaScan.db,
               keys = example_keys[1:3L],
               columns = c("ENSEMBL", "OMIM")
)

ensg

## ----get-target-full-name-----------------------------------------------------
addTargetFullName(ensg)

## ----menu-summary-------------------------------------------------------------
summary(somascan_menu)

## ----menu-head----------------------------------------------------------------
lapply(somascan_menu, head)

## ----menu-setdiff-------------------------------------------------------------
setdiff(somascan_menu$v4.1, somascan_menu$v4.0) |> head(50L)

## ----session-info-------------------------------------------------------------
sessionInfo()

