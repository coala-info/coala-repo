# Code example from 'regsplice-workflow' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE)

## -----------------------------------------------------------------------------
# load data
file_counts <- system.file("extdata/vignette_counts.txt", package = "regsplice")
data <- read.table(file_counts, header = TRUE, sep = "\t", stringsAsFactors = FALSE)

head(data)

# extract counts, gene_IDs, and n_exons
counts <- data[, 2:7]
tbl_exons <- table(sapply(strsplit(data$exon, ":"), function(s) s[[1]]))
gene_IDs <- names(tbl_exons)
n_exons <- unname(tbl_exons)

dim(counts)

length(gene_IDs)

head(gene_IDs)

length(n_exons)

sum(n_exons)

# create condition vector
condition <- rep(c("untreated", "treated"), each = 3)

condition

## -----------------------------------------------------------------------------
library(regsplice)

rs_data <- RegspliceData(counts, gene_IDs, n_exons, condition)

rs_results <- suppressWarnings(regsplice(rs_data, seed = 123))

## -----------------------------------------------------------------------------
summaryTable(rs_results)

## -----------------------------------------------------------------------------
library(regsplice)

rs_data <- RegspliceData(counts, gene_IDs, n_exons, condition)

## -----------------------------------------------------------------------------
rs_data <- filterZeros(rs_data)

## -----------------------------------------------------------------------------
rs_data <- filterLowCounts(rs_data)

## -----------------------------------------------------------------------------
rs_data <- runNormalization(rs_data)

## -----------------------------------------------------------------------------
rs_data <- runVoom(rs_data)

# view column meta-data including normalization factors and normalized library sizes
colData(rs_data)

## -----------------------------------------------------------------------------
rs_results <- initializeResults(rs_data)

## -----------------------------------------------------------------------------
# set random seed for reproducibility
seed <- 123

# fit regularized models
rs_results <- suppressWarnings(fitRegMultiple(rs_results, rs_data, seed = seed))

# fit null models
rs_results <- fitNullMultiple(rs_results, rs_data, seed = seed)

# fit "full" models (not required if 'when_null_selected = "ones"' in next step)
rs_results <- fitFullMultiple(rs_results, rs_data, seed = seed)

## -----------------------------------------------------------------------------
rs_results <- LRTests(rs_results)

## -----------------------------------------------------------------------------
summaryTable(rs_results)

## -----------------------------------------------------------------------------
summaryTable(rs_results, n = Inf)

## -----------------------------------------------------------------------------
sum(p_adj(rs_results) < 0.05)

table(p_adj(rs_results) < 0.05)

## -----------------------------------------------------------------------------
# load true DS status labels
file_truth <- system.file("extdata/vignette_truth.txt", package = "regsplice")
data_truth <- read.table(file_truth, header = TRUE, sep = "\t", stringsAsFactors = FALSE)

str(data_truth)

# remove genes that were filtered during regsplice analysis
data_truth <- data_truth[data_truth$gene %in% gene_IDs(rs_results), ]

dim(data_truth)

length(gene_IDs(rs_results))

# number of true DS genes in simulated data set
sum(data_truth$ds_status == 1)

table(data_truth$ds_status)

# contingency table comparing true and predicted DS status for each gene
# (significance threshold: FDR < 0.05)
table(true = data_truth$ds_status, predicted = p_adj(rs_results) < 0.05)

# increasing the threshold detects more genes, at the expense of more false positives
table(true = data_truth$ds_status, predicted = p_adj(rs_results) < 0.99)

## -----------------------------------------------------------------------------
# gene with 3 exons
# 4 biological samples; 2 samples in each of 2 conditions
design_example <- createDesignMatrix(condition = rep(c(0, 1), each = 2), n_exons = 3)

design_example

