# Code example from 'RcwlPipelines' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("RcwlPipelines")

## ----getDevel, eval=FALSE-----------------------------------------------------
# BiocManager::install("rworkflow/RcwlPipelines")

## ----Load, message=FALSE------------------------------------------------------
library(RcwlPipelines)

## -----------------------------------------------------------------------------
## For vignette use only. users don't need to do this step.
Sys.setenv(cachePath = tempdir()) 

## ----message=FALSE------------------------------------------------------------
atls <- cwlUpdate(branch = "dev") ## sync the tools/pipelines.
atls
table(mcols(atls)$Type)

## -----------------------------------------------------------------------------
t1 <- cwlSearch(c("bwa", "mem"))
t1
mcols(t1)

## -----------------------------------------------------------------------------
bwa <- cwlLoad(title(t1)[1])  ## "tl_bwa"
bwa <- cwlLoad(mcols(t1)$fpath[1]) ## equivalent to the above. 
bwa

## ----warning=FALSE------------------------------------------------------------
rnaseq_Sf <- cwlLoad("pl_rnaseq_Sf")
plotCWL(rnaseq_Sf)

## -----------------------------------------------------------------------------
arguments(rnaseq_Sf, "STAR")[5:6]
arguments(rnaseq_Sf, "STAR")[[6]] <- 5
arguments(rnaseq_Sf, "STAR")[5:6]

## -----------------------------------------------------------------------------
searchContainer("STAR", repo = "biocontainers", source = "quay")

## -----------------------------------------------------------------------------
requirements(rnaseq_Sf, "STAR")[[1]]
requirements(rnaseq_Sf, "STAR")[[1]] <- requireDocker(
    docker = "quay.io/biocontainers/star:2.7.8a--0")
requirements(rnaseq_Sf, "STAR")[[1]]

## ----eval=FALSE---------------------------------------------------------------
# inputs(rnaseq_Sf)
# rnaseq_Sf$in_seqfiles <- list("sample_R1.fq.gz",
#                               "sample_R2.fq.gz")
# rnaseq_Sf$in_prefix <- "sample"
# rnaseq_Sf$in_genomeDir <- "genome_STAR_index_Dir"
# rnaseq_Sf$in_GTFfile <- "GENCODE_version.gtf"
# 
# runCWL(rnaseq_Sf, outdir = "output/sample", docker = TRUE)

## ----eval=FALSE---------------------------------------------------------------
# library(BioParallel)
# bpparam <- BatchtoolsParam(workers = 2, cluster = "sge",
#                            template = batchtoolsTemplate("sge"))
# 
# inputList <- list(in_seqfiles = list(sample1 = list("sample1_R1.fq.gz",
#                                                     "sample1_R2.fq.gz"),
#                                      sample2 = list("sample2_R1.fq.gz",
#                                                     "sample2_R2.fq.gz")),
#                   in_prefix = list(sample1 = "sample1",
#                                    sample2 = "sample2"))
# 
# paramList <- list(in_genomeDir = "genome_STAR_index_Dir",
#                   in_GTFfile = "GENCODE_version.gtf",
#                   in_runThreadN = 16)
# 
# runCWLBatch(rnaseq_Sf, outdir = "output",
#             inputList, paramList,
#             BPPARAM = bpparam)

## -----------------------------------------------------------------------------
sessionInfo()

