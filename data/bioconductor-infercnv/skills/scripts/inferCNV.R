# Code example from 'inferCNV' vignette. See references/ for full tutorial.

## ----install, eval=FALSE------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("infercnv")

## ----install-optionals, eval = FALSE------------------------------------------
# install.packages("tibble")
# 
# install.packages("devtools")
# devtools::install_github("bmbroom/tsvio")
# devtools::install_github("bmbroom/NGCHMR", ref="stable")
# devtools::install_github("broadinstitute/inferCNV_NGCHM")
# 

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
library(infercnv)


## -----------------------------------------------------------------------------
infercnv_obj = CreateInfercnvObject(
  raw_counts_matrix="../inst/extdata/oligodendroglioma_expression_downsampled.counts.matrix.gz",
  annotations_file="../inst/extdata/oligodendroglioma_annotations_downsampled.txt",
  delim="\t",
  gene_order_file="../inst/extdata/gencode_downsampled.EXAMPLE_ONLY_DONT_REUSE.txt",
  ref_group_names=c("Microglia/Macrophage","Oligodendrocytes (non-malignant)"))


## ----results="hide"-----------------------------------------------------------
out_dir = tempfile()
infercnv_obj_default = infercnv::run(
    infercnv_obj,
    cutoff=1, # cutoff=1 works well for Smart-seq2, and cutoff=0.1 works well for 10x Genomics
    out_dir=out_dir,
    cluster_by_groups=TRUE, 
    plot_steps=FALSE,
    denoise=TRUE,
    HMM=FALSE,
    no_prelim_plot=TRUE,
    png_res=60
)


## ----echo=FALSE---------------------------------------------------------------
knitr::include_graphics(paste(out_dir, "infercnv.png", sep="/"))

## ----sessioninfo, echo=FALSE, tidy=TRUE, tidy.opts=list(width.cutoff=60), out.width=60----
sessionInfo()

