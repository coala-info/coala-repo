# Code example from 'vignette_02_synteny_detection_with_syntenet' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    crop = NULL
)

## ----load_package, message=FALSE----------------------------------------------
library(syntenet)

## ----data_intra---------------------------------------------------------------
# Load example data sets
data(scerevisiae_annot)
head(scerevisiae_annot)

data(scerevisiae_diamond)
names(scerevisiae_diamond)
head(scerevisiae_diamond$Scerevisiae_Scerevisiae)

## ----intra_syn----------------------------------------------------------------
# Detect intragenome synteny
intra_syn <- intraspecies_synteny(
    scerevisiae_diamond, scerevisiae_annot
)

intra_syn # see where the .collinearity file is

# Get anchor pairs from .collinearity file
anchors <- parse_collinearity(intra_syn)
head(anchors)

## ----parse_blocks-------------------------------------------------------------
# Get synteny block information with `parse_collinearity()`
blocks <- parse_collinearity(intra_syn, as = "blocks")
head(blocks)

## ----parse_all----------------------------------------------------------------
# Get anchors and block data with `parse_collinearity()`
intrasyn_all <- parse_collinearity(intra_syn, as = "all")
head(intrasyn_all)

## ----make_bidirectional-------------------------------------------------------
# Create a data frame with comparisons to be made
comp <- data.frame(
    query = "spA",
    db = "spB"
)
comp

# Make comparisons bidirectional
comp_bi <- make_bidirectional(comp)
comp_bi

## ----run_diamond_compare, eval = FALSE----------------------------------------
# # NOTE: Not executed because object `seq` doesn't exist; for demo only
# dmd_inter <- run_diamond(seq, compare = comp_bi)

## ----example_inter------------------------------------------------------------
# Load list of DIAMOND tables
data(blast_list)
names(blast_list)

algae_inter <- blast_list[c(2,3)] # keep only intergenome comparisons
names(algae_inter)


# Get processed annotation
data(proteomes)     # A list of `AAStringSet` objects
data(annotation)    # A `GRangesList` object

pdata <- process_input(proteomes, annotation)
names(pdata$annotation)

## ----inter_syn----------------------------------------------------------------
# Detect interspecies synteny
intersyn <- interspecies_synteny(algae_inter, pdata$annotation)

intersyn # see where the .collinearity file is

# Parse collinearity file
## 1) Get anchor pairs
algae_anchors <- parse_collinearity(intersyn)
head(algae_anchors)

## 2) Get synteny blocks
algae_blocks <- parse_collinearity(intersyn, as = "blocks")
head(algae_blocks)

## 3) Get all data combined (blocks + anchor pairs)
algae_all <- parse_collinearity(intersyn, as = "all")
head(algae_all)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

