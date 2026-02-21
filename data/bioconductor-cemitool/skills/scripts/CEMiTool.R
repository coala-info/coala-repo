# Code example from 'CEMiTool' vignette. See references/ for full tutorial.

## ----style, echo=FALSE, results="asis", message=FALSE-------------------------
knitr::opts_chunk$set(tidy = FALSE,
                      warning = FALSE,
                      message = FALSE,
                      cache=TRUE)

## -----------------------------------------------------------------------------
library("CEMiTool")
# load expression data
data(expr0)
head(expr0[,1:4])

## ----results='hide'-----------------------------------------------------------
cem <- cemitool(expr0)

## -----------------------------------------------------------------------------
cem

## -----------------------------------------------------------------------------
# inspect modules
nmodules(cem)
head(module_genes(cem))

## ----eval=FALSE---------------------------------------------------------------
# generate_report(cem)

## -----------------------------------------------------------------------------
write_files(cem)

## -----------------------------------------------------------------------------
save_plots(cem, "all")

## -----------------------------------------------------------------------------
# load your sample annotation data
data(sample_annot)
head(sample_annot)

## ----results='hide'-----------------------------------------------------------
# run cemitool with sample annotation
cem <- cemitool(expr0, sample_annot)

## -----------------------------------------------------------------------------
sample_annotation(cem, 
                  sample_name_column="SampleName", 
                  class_column="Class") <- sample_annot

## -----------------------------------------------------------------------------
# generate heatmap of gene set enrichment analysis
cem <- mod_gsea(cem)
cem <- plot_gsea(cem)
show_plot(cem, "gsea")

## -----------------------------------------------------------------------------
# plot gene expression within each module
cem <- plot_profile(cem)
plots <- show_plot(cem, "profile")
plots[1]

## -----------------------------------------------------------------------------
# read GMT file
gmt_fname <- system.file("extdata", "pathways.gmt", package = "CEMiTool")
gmt_in <- read_gmt(gmt_fname)

## -----------------------------------------------------------------------------
# perform over representation analysis
cem <- mod_ora(cem, gmt_in)

## -----------------------------------------------------------------------------
# plot ora results
cem <- plot_ora(cem)
plots <- show_plot(cem, "ora")
plots[1]

## -----------------------------------------------------------------------------
# read interactions
int_fname <- system.file("extdata", "interactions.tsv", package = "CEMiTool")
int_df <- read.delim(int_fname)
head(int_df)

## -----------------------------------------------------------------------------
# plot interactions
library(ggplot2)
interactions_data(cem) <- int_df # add interactions
cem <- plot_interactions(cem) # generate plot
plots <- show_plot(cem, "interaction") # view the plot for the first module
plots[1]

## ----eval=FALSE---------------------------------------------------------------
# # run cemitool
# library(ggplot2)
# cem <- cemitool(expr0, sample_annot, gmt_in, interactions=int_df,
#                 filter=TRUE, plot=TRUE, verbose=TRUE)
# # create report as html document
# generate_report(cem, directory="./Report")
# 
# # write analysis results into files
# write_files(cem, directory="./Tables")
# 
# # save all plots
# save_plots(cem, "all", directory="./Plots")

## ----eval=FALSE---------------------------------------------------------------
# diagnostic_report(cem)

