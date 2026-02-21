# Code example from 'kmcut_intro' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# BiocManager::install("kmcut")

## -----------------------------------------------------------------------------
library(kmcut)

## -----------------------------------------------------------------------------
sdat <- system.file("extdata", "survival_data.txt", package = "kmcut")

## -----------------------------------------------------------------------------
fdat <- system.file("extdata", "example_genes.txt", package = "kmcut")

## -----------------------------------------------------------------------------
# Read names of the built-in gene expression data file and survival data file
fdat = system.file("extdata", "example_genes.txt", package = "kmcut")
sdat = system.file("extdata", "survival_data.txt", package = "kmcut")

# Create a SummarizedExperiment object 'se'
se = create_se_object(efile = fdat, sfile = sdat)

## ----out.width='70%'----------------------------------------------------------
# Read names of the built-in gene expression data file and survival data file
fdat = system.file("extdata", "example_genes.txt", package = "kmcut")
sdat = system.file("extdata", "survival_data.txt", package = "kmcut")

# Create SummarizedExperiment object
se = create_se_object(efile = fdat, sfile = sdat)

# Run the permutation test for 10 iterations for each gene, use 1 processor
km_opt_pcut(obj = se, bfname = "test", n_iter = 10, wlabels = TRUE,
                wpdf = FALSE, verbose = FALSE, nproc = 1)

## ----out.width='70%'----------------------------------------------------------
# Read names of the built-in gene expression data file and survival data file
fdat = system.file("extdata", "example_genes.txt", package = "kmcut")
sdat = system.file("extdata", "survival_data.txt", package = "kmcut")

# Create SummarizedExperiment object
se <- create_se_object(efile = fdat, sfile = sdat)
 
# Search for optimal cutoffs
km_opt_scut(obj = se, bfname = "test", wpdf = FALSE, verbose = FALSE)

## ----out.width='70%'----------------------------------------------------------
# Read names of the built-in gene expression data file and survival data file
fdat = system.file("extdata", "example_genes.txt", package = "kmcut")
sdat = system.file("extdata", "survival_data.txt", package="kmcut")

# Create SummarizedExperiment object
se <- create_se_object(efile = fdat, sfile = sdat)
 
# Use the 50th quantile (the median) to stratify the samples
km_qcut(obj = se, bfname = "test", quant = 50, wpdf = FALSE)

## ----out.width='70%'----------------------------------------------------------
# Read names of the built-in gene expression data file and survival data file
fdat = system.file("extdata", "example_genes.txt", package = "kmcut")
sdat = system.file("extdata", "survival_data.txt", package = "kmcut")

# Create SummarizedExperiment object
se <- create_se_object(efile = fdat, sfile = sdat)
 
# Use the cutoff = 5 to stratify the samples and remove features that have 
# less than 90% unique values (this removes the MYH2 gene from the analysis)
km_ucut(obj = se, bfname = "test", cutoff = 5, min_uval = 90, wpdf = FALSE)

## ----out.width='70%'----------------------------------------------------------
# Read names of training (fdat1) and validation (fdat2) gene expression data
# files and survival data file (sdat).
fdat1 <- system.file("extdata", "expression_data_1.txt", package = "kmcut")
fdat2 <- system.file("extdata", "expression_data_2.txt", package = "kmcut")
sdat <- system.file("extdata", "survival_data.txt", package = "kmcut")

# Create SummarizedExperiment object with training data
se1 <- create_se_object(efile = fdat1, sfile = sdat)

# Step 1: Run 'km_qcut' on the training data in 'se1'
km_qcut(obj = se1, bfname = "training_data", quant = 50, min_uval = 40)

## ----out.width='70%'----------------------------------------------------------
# Create SummarizedExperiment object with test data
se2 <- create_se_object(efile = fdat2, sfile = sdat)
 
# Step 2: Validate the thresholds from "training_data_KM_quant_50.txt" on
# the test data in 'se2'.
km_val_cut(infile = "training_data_KM_quant_50.txt", obj = se2, 
             bfname = "test", wpdf = TRUE, min_uval = 40)

## -----------------------------------------------------------------------------
# Read names of the built-in gene expression data file (fdat) and
# survival data file (sdat)
fdat = system.file("extdata", "example_genes.txt", package = "kmcut")
sdat = system.file("extdata", "survival_data.txt", package = "kmcut")

# Create SummarizedExperiment object
se <- create_se_object(efile = fdat, sfile = sdat)

# Perform the regression on the data in 'se'
ucox_batch(obj = se, bfname = "test")

## -----------------------------------------------------------------------------
# Read names of the built-in training (fdat1) and test (fdat2) 
# gene expression data files and survival data file (sdat)
fdat1 = system.file("extdata", "expression_data_1.txt", package = "kmcut")
fdat2 = system.file("extdata", "expression_data_2.txt", package = "kmcut")
sdat = system.file("extdata", "survival_data.txt", package = "kmcut")

# Create SummarizedExperiment object with training data
se1 <- create_se_object(efile = fdat1, sfile = sdat)
# Create SummarizedExperiment object with test data
se2 <- create_se_object(efile = fdat2, sfile = sdat)

# Fit Cox model on the training data in 'se1' and use it to calculate the risk
# scores for the test data in 'se2'.
ucox_pred(obj1 = se1, obj2 = se2, bfname = "demo", min_uval = 40)

## -----------------------------------------------------------------------------
# Read the name of the built-in gene expression data file with 2 genes (2 rows)
fdat = system.file("extdata", "example_genes.txt", package = "kmcut")
# Read the name of the built-in list file that contains one gene id (MYCN)
idlist = system.file("extdata", "rowids.txt", package = "kmcut")

# Run the function
extract_rows(fnamein = fdat, fids = idlist,
            fnameout = "example_genes_subset.txt")

## -----------------------------------------------------------------------------
# Read the name of the built-in gene expression data file with 2 genes (2 rows)
fdat = system.file("extdata", "example_genes.txt", package = "kmcut")
# Read the name of the built-in list file that contains a sub-set of 
# column (sample) ids
idlist = system.file("extdata", "columnids.txt", package = "kmcut")

# Run the function
extract_columns(fnamein = fdat, fids = idlist,
                    fnameout = "example_samples_subset.txt")

## -----------------------------------------------------------------------------
# Read the name of the built-in gene expression data file.
# In this file, genes are rows and samples are columns.
fdat = system.file("extdata", "example_genes.txt", package = "kmcut")

# Run the function
transpose_table(fnamein = fdat, fnameout = "example_genes_transposed.txt")

## -----------------------------------------------------------------------------
sessionInfo()

