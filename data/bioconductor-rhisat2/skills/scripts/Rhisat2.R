# Code example from 'Rhisat2' vignette. See references/ for full tutorial.

## ----setup, include = FALSE-----------------------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
options(width=100)

## ----getPackage, eval=FALSE-----------------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("Rhisat2")

## ----eval = FALSE---------------------------------------------------------------------------------
# BiocManager::install("fmicompbio/Rhisat2")

## -------------------------------------------------------------------------------------------------
library(Rhisat2)

## -------------------------------------------------------------------------------------------------
list.files(system.file("extdata/refs", package="Rhisat2"), pattern="\\.fa$")
refs <- list.files(system.file("extdata/refs", package="Rhisat2"), 
                   full.names=TRUE, pattern="\\.fa$")
td <- tempdir()
hisat2_build(references=refs, outdir=td, prefix="myindex", 
             force=TRUE, strict=TRUE, execute=TRUE)

## -------------------------------------------------------------------------------------------------
print(hisat2_build(references=refs, outdir=td, prefix="myindex",
                   force=TRUE, strict=TRUE, execute=FALSE))

## -------------------------------------------------------------------------------------------------
list.files(system.file("extdata/reads", package="Rhisat2"), 
           pattern="\\.fastq$")
reads <- list.files(system.file("extdata/reads", package="Rhisat2"),
                    pattern="\\.fastq$", full.names=TRUE)
hisat2(sequences=as.list(reads), index=file.path(td, "myindex"), 
       type="paired", outfile=file.path(td, "out.sam"), 
       force=TRUE, strict=TRUE, execute=TRUE)

## -------------------------------------------------------------------------------------------------
spsfile <- tempfile()
gtf <- system.file("extdata/refs/genes.gtf", package="Rhisat2")
extract_splice_sites(features=gtf, outfile=spsfile)
hisat2(sequences=as.list(reads), index=file.path(td, "myindex"),
       type="paired", outfile=file.path(td, "out_sps.sam"),
       `known-splicesite-infile`=spsfile, 
       force=TRUE, strict=TRUE, execute=TRUE)

## -------------------------------------------------------------------------------------------------
hisat2_version()

## -------------------------------------------------------------------------------------------------
hisat2_build_usage()

## -------------------------------------------------------------------------------------------------
hisat2_usage()

## -------------------------------------------------------------------------------------------------
sessionInfo()

