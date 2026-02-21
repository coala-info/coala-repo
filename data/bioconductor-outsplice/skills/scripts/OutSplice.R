# Code example from 'OutSplice' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----echo = FALSE, eval=FALSE-------------------------------------------------
# if (!require("BiocManager")) {
#     install.packages("BiocManager")
# }
# BiocManager::install("OutSplice")

## ----message=FALSE------------------------------------------------------------
library(OutSplice)

## ----results="hide", warning=FALSE, messages = FALSE--------------------------
junction <- system.file("extdata", "HNSC_junctions.txt.gz", package = "OutSplice")
gene_expr <- system.file("extdata", "HNSC_genes_normalized.txt.gz", package = "OutSplice")
rawcounts <- system.file("extdata", "Total_Rawcounts.txt", package = "OutSplice")
sample_labels <- system.file("extdata", "HNSC_pheno_table.txt", package = "OutSplice")
output_file_prefix <- "OutSplice_Example"
TxDb_hg19 <- "TxDb.Hsapiens.UCSC.hg19.knownGene"
dir <- paste0(tempdir(), "/")
message("Output is located at: ", dir)

results <- outspliceAnalysis(junction, gene_expr, rawcounts, sample_labels, saveOutput = TRUE, output_file_prefix, dir, filterSex = TRUE, annotation = "org.Hs.eg.db", TxDb = TxDb_hg19, offsets_value = 0.00001, correction_setting = "fdr", p_value = 0.05)

## ----results="hide", warning=FALSE, messages = FALSE--------------------------
junction <- system.file("extdata", "TCGA_HNSC_junctions.txt.gz", package = "OutSplice")
gene_expr <- system.file("extdata", "TCGA_HNSC_genes_normalized.txt.gz", package = "OutSplice")
rawcounts <- system.file("extdata", "Total_Rawcounts.txt", package = "OutSplice")
output_file_prefix <- "TCGA_OutSplice_Example"
dir <- paste0(tempdir(), "/")
message("Output is located at: ", dir)

results_TCGA <- outspliceTCGA(junction, gene_expr, rawcounts, saveOutput = TRUE, output_file_prefix, dir, filterSex = TRUE, annotation = "org.Hs.eg.db", TxDb = "TxDb.Hsapiens.UCSC.hg19.knownGene", offsets_value = 0.00001, correction_setting = "fdr", p_value = 0.05)

## ----results="hide", warning=FALSE, messages=FALSE----------------------------
data_file <- system.file("extdata", "OutSplice_Example_2023-01-06.RDa", package = "OutSplice")
ecm1_junc <- "chr1:150483674-150483933"
pdf <- "ecm1_expression.pdf"
pdf_output <- paste0(tempdir(), "/", pdf)
message("Output is located at: ", pdf_output)

plotJunctionData(data_file, NUMBER = 1, junctions = ecm1_junc, tail = NULL, p_value = 0.05, GENE = FALSE, SYMBOL = NULL, makepdf = TRUE, pdffile = pdf_output, tumcol = "red", normcol = "blue")

## -----------------------------------------------------------------------------
sessionInfo()

