# Code example from 'dearseqUserguide' vignette. See references/ for full tutorial.

## ----knitrsetup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  tidy = TRUE)
knitr::knit_hooks$set(small.mar = function(before, options, envir) {
    if (before) par(mar = c(0, 0, 0, 0))  # no margin
})

## ----import, message=FALSE, results='hide'------------------------------------
library(GEOquery)
GSE107991_metadata <- GEOquery::getGEO("GSE107991", GSEMatrix = FALSE)

get_info <- function(i){
    name <- GEOquery::Meta(GSMList(GSE107991_metadata)[[i]])$source_name_ch1
    name <- gsub("Active_TB", "ActiveTB", name)
    name <- gsub("Test_set", "TestSet", name)
    c(unlist(strsplit(name, split="_")), 
             GEOquery::Meta(GSMList(GSE107991_metadata)[[i]])$title)
}

infos <- vapply(X = 1:length(GSMList(GSE107991_metadata)), 
                FUN = get_info,
                FUN.VALUE = c("a", "b", "c", "d", "e"))
infos_df <- cbind.data.frame("SampleID" = names(GSMList(GSE107991_metadata)), 
                             t(infos), stringsAsFactors=TRUE)
rownames(infos_df) <- names(GEOquery::GSMList(GSE107991_metadata))
colnames(infos_df)[-1] <- c("Cohort", "Location", "Set", "Status", "SampleTitle")

## ----London-download, message=FALSE, results='hide'---------------------------
library(readxl)
GEOquery::getGEOSuppFiles('GSE107991', 
                          filter_regex="edgeR_normalized_Berry_London")
London <- readxl::read_excel("GSE107991/GSE107991_edgeR_normalized_Berry_London.xlsx")
genes <- London$Genes
London <- as.matrix(London[, -c(1:3)])
rownames(London) <- genes

## ----LR_ST_echo, eval=TRUE, echo=TRUE, message=FALSE, fig.width=8, fig.height=8, out.width="98%"----
library(dearseq)
library(SummarizedExperiment)
col_data <- data.frame("Status" = infos_df$Status)
col_data$Status <- stats::relevel(col_data$Status, ref="Control")
rownames(col_data) <- infos_df$SampleTitle
se <- SummarizedExperiment(assays = London, 
                            colData = col_data)

res_dearseq <- dearseq::dear_seq(object = se[, se$Status != "LTBI"],
                                 variables2test = "Status",
                                 which_test='asymptotic',
                                 preprocessed=TRUE)
summary(res_dearseq)
plot(res_dearseq)

## ----London_raw, eval=TRUE, echo=TRUE, warning = FALSE, message=FALSE, results='hide', fig.width=8, fig.height=8, out.width="98%"----
library(readxl)
library(edgeR)
GEOquery::getGEOSuppFiles('GSE107991', 
                          filter_regex="Raw_counts_Berry_London")
London_raw<- readxl::read_excel("GSE107991/GSE107991_Raw_counts_Berry_London.xlsx")
genes_raw <- London_raw$Genes
London_raw <- as.matrix(London_raw[,-c(1:3)])

se_raw <- SummarizedExperiment(assays = London_raw, 
                            colData = col_data)

group <- ifelse(se_raw$Status=="ActiveTB",1,0)
dgList <- DGEList(counts = London_raw, group = group)
cpm <- cpm(dgList)
countCheck <- cpm > 2
keep <- which(rowSums(countCheck) >= 5)
London_raw <- London_raw[keep,]

res_dearseq <- dearseq::dear_seq(object = se_raw[ , se_raw$Status != "LTBI"],
                                 variables2test = "Status",
                                 which_test='permutation',
                                 preprocessed=FALSE, 
                                 parallel_comp = interactive())

summary(res_dearseq)
plot(res_dearseq)

## ----baduel, eval=TRUE, echo=TRUE, message=FALSE------------------------------
library(dearseq)
library(SummarizedExperiment)
library(BiocSet)
data('baduel_5gs')
se2 <- SummarizedExperiment(assay = log2(expr_norm_corr+1), 
                            colData = design)
genes_non0var_ind <- which(matrixStats::rowVars(expr_norm_corr)!=0)

KAvsTBG <- dearseq::dgsa_seq(object = se2[genes_non0var_ind, ],
                             covariates=c('Vernalized', 'AgeWeeks', 'Vernalized_Population', 'AgeWeeks_Population'),
                             variables2test = 'PopulationKA',
                             genesets=baduel_gmt$genesets[c(3,5)],
                             which_test = 'permutation', which_weights = 'loclin',
                             n_perm=2000, preprocessed = TRUE,
                             verbose = FALSE, 
                             parallel_comp = interactive())
summary(KAvsTBG)
KAvsTBG$pvals

Cold <- dearseq::dgsa_seq(object = se2[genes_non0var_ind, ],
                          covariates = c('AgeWeeks', 'PopulationKA', 'AgeWeeks_Population'),
                          variables2test = c('Vernalized', 'Vernalized_Population'),
                          genesets = baduel_gmt$genesets[c(3,5)],
                          which_test = 'permutation', which_weights = 'loclin',
                          n_perm = 2000, preprocessed = TRUE, 
                          verbose = FALSE, 
                          parallel_comp = interactive())
summary(Cold)
Cold$pvals

## ----fig.width = 8, fig.asp = .8----------------------------------------------
#Remove "non-vernalized" samples
colData(se2)[["Indiv"]] <- colData(se2)[["Population"]]:colData(se2)[["Replicate"]]
colData(se2)[["Vern"]] <- ifelse(colData(se2)[["Vernalized"]], "Vernalized", "Non-vernalized")

library(ggplot2)
spaghettiPlot1GS(gs_index = 3, gmt = baduel_gmt, expr_mat = assay(se2), 
  design = colData(se2), var_time = AgeWeeks, var_indiv = Indiv, 
  sampleIdColname = "sample", var_group=Vern, var_subgroup=Population, loess_span = 1.5) +
  ggplot2::xlab("Age (weeks)")

## ----dl_GEOquery, eval=FALSE, echo=TRUE---------------------------------------
# if (!requireNamespace("GEOquery", quietly = TRUE)) {
#     if (!requireNamespace("BiocManager", quietly = TRUE)){
#         install.packages("BiocManager")
#     }
#     BiocManager::install("GEOquery")
# }

## ----dl_readxl, echo=TRUE, eval=FALSE-----------------------------------------
# if (!requireNamespace("readxl", quietly = TRUE)) {
#     install.packages("readxl")
# }

## ----echo=FALSE---------------------------------------------------------------
utils::sessionInfo()

