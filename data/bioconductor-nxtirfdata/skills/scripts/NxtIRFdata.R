# Code example from 'NxtIRFdata' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("NxtIRFdata")

## -----------------------------------------------------------------------------
library(NxtIRFdata)

## -----------------------------------------------------------------------------
example_fasta = chrZ_genome()
example_gtf = chrZ_gtf()

## ----results = FALSE, message=FALSE-------------------------------------------
bam_paths = example_bams(path = tempdir())

## ----results = FALSE, message=FALSE-------------------------------------------

# To get the MappabilityExclusion for hg38 as a GRanges object
gr = get_mappability_exclusion(genome_type = "hg38", as_type = "GRanges")

# To get the MappabilityExclusion for hg38 as a locally-copied gzipped BED file
bed_path = get_mappability_exclusion(genome_type = "hg38", as_type = "bed.gz",
	path = tempdir())

# Other `genome_type` values include "hg19", "mm10", and "mm9"

## ----results = FALSE, message=FALSE-------------------------------------------
library(ExperimentHub)

## ----eval = FALSE-------------------------------------------------------------
# eh = ExperimentHub()
# NxtIRF_hub = query(eh, "NxtIRF")
# 
# NxtIRF_hub
# 
# temp = eh[["EH6792"]]
# temp
# 
# temp = eh[["EH6787"]]
# temp

## ----eval=FALSE---------------------------------------------------------------
# ?`NxtIRFdata-package`

## -----------------------------------------------------------------------------
sessionInfo()

