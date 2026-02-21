# Code example from 'HybridExpress' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    crop = NULL ## Related to https://stat.ethz.ch/pipermail/bioc-devel/2020-April/016656.html
)

## ----installation, eval=FALSE-------------------------------------------------
# if(!requireNamespace('BiocManager', quietly = TRUE))
#   install.packages('BiocManager')
# 
# BiocManager::install("HybridExpress")

## ----load_package, message=FALSE----------------------------------------------
# Load package after installation
library(HybridExpress)

set.seed(123) # for reproducibility

## ----message = FALSE----------------------------------------------------------
library(SummarizedExperiment)

# Load data
data(se_chlamy)

# Inspect the `SummarizedExperiment` object
se_chlamy

## Take a look at the colData and count matrix
colData(se_chlamy)
assay(se_chlamy) |> head()

table(se_chlamy$Ploidy, se_chlamy$Generation)

## -----------------------------------------------------------------------------
# Add midparent expression using the mean of the counts
se <- add_midparent_expression(se_chlamy)
head(assay(se))

# Alternative 1: using the sum of the counts
add_midparent_expression(se_chlamy, method = "sum") |>
    assay() |> 
    head()

# Alternative 2: using the weighted mean of the counts (weights = ploidy)
w <- c(2, 1) # P1 = diploid; P2 = haploid
add_midparent_expression(se_chlamy, method = "weightedmean", weights = w) |>
    assay() |> 
    head()

## -----------------------------------------------------------------------------
# Show last rows of the count matrix
assay(se) |> 
    tail()

## -----------------------------------------------------------------------------
# Take a look at the original colData
colData(se)

# Add size factors estimated from spike-in controls
se <- add_size_factors(se, spikein = TRUE, spikein_pattern = "ERCC")

# Take a look at the new colData
colData(se)

## -----------------------------------------------------------------------------
# For colData rows with missing values (midparent samples), add "midparent"
se$Ploidy[is.na(se$Ploidy)] <- "midparent"
se$Generation[is.na(se$Generation)] <- "midparent"

# Create PCA plot
pca_plot(se, color_by = "Generation", shape_by = "Ploidy", add_mean = TRUE)

## -----------------------------------------------------------------------------
# Plot a heatmap of sample correlations
plot_samplecor(se, coldata_cols = c("Generation", "Ploidy"))

## -----------------------------------------------------------------------------
# Get a list of differentially expressed genes for each contrast
deg_list <- get_deg_list(se)

# Inspecting the output
## Getting contrast names
names(deg_list)

## Accessing gene-wise test statistics for contrast `F1_vs_P1`
head(deg_list$F1_vs_P1)

## Counting the number of DEGs per contrast
sapply(deg_list, nrow)

## -----------------------------------------------------------------------------
# Get a data frame with DEG frequencies for each contrast
deg_counts <- get_deg_counts(deg_list)

deg_counts

## -----------------------------------------------------------------------------
attributes(deg_list)$ngenes

## -----------------------------------------------------------------------------
# Total number of genes in the C. reinhardtii genome (v6.1): 16883
attributes(deg_list)$ngenes <- 16883

## -----------------------------------------------------------------------------
deg_counts <- get_deg_counts(deg_list)
deg_counts

## -----------------------------------------------------------------------------
# Plot expression triangle
plot_expression_triangle(deg_counts)

## ----fig.height=5-------------------------------------------------------------
# Create vectors (length 4) of colors and box labels
pal <- c("springgreen4", "darkorange3", "mediumpurple4", "mediumpurple3")
labels <- c("Parent 1\n(2n)", "Parent 2\n(n)", "Progeny\n(3n)", "Midparent")

plot_expression_triangle(deg_counts, palette = pal, box_labels = labels)

## -----------------------------------------------------------------------------
# Classify genes in expression partitions
exp_partitions <- expression_partitioning(deg_list)

# Inspect the output
head(exp_partitions)

# Count number of genes per category
table(exp_partitions$Category)

# Count number of genes per class
table(exp_partitions$Class)

## ----fig.height=6, fig.width=8------------------------------------------------
# Plot partitions as a scatter plot of divergences
plot_expression_partitions(exp_partitions, group_by = "Category")

## ----fig.height=7, fig.width=8------------------------------------------------
# Group by `Class`
plot_expression_partitions(exp_partitions, group_by = "Class")

## ----fig.height=7-------------------------------------------------------------
# Visualize frequency of genes in each partition
## By `Category` (default)
plot_partition_frequencies(exp_partitions)

## By `Class`
plot_partition_frequencies(exp_partitions, group_by = "Class")

## -----------------------------------------------------------------------------
# Load example functional annotation (GO terms)
data(go_chlamy)

head(go_chlamy)

## -----------------------------------------------------------------------------
# Get a vector of genes in class "ADD"
genes_add <- exp_partitions$Gene[exp_partitions$Class == "ADD"]
head(genes_add)

# Get background genes - genes in the count matrix
bg <- rownames(se)

# Perform overrepresentation analysis
ora_add <- ora(genes_add, go_chlamy, background = bg)

# Inspect results
head(ora_add)

## -----------------------------------------------------------------------------
# Create a list of genes in each class
genes_by_class <- split(exp_partitions$Gene, exp_partitions$Class)

names(genes_by_class)
head(genes_by_class$UP)

# Iterate through each class and perform ORA
ora_classes <- lapply(
    genes_by_class, # list through which we will iterate
    ora, # function we will apply to each element of the list
    annotation = go_chlamy, background = bg # additional arguments to function
)

# Inspect output
ora_classes

## -----------------------------------------------------------------------------
# Get up-regulated genes for each contrast
up_genes <- lapply(deg_list, function(x) rownames(x[x$log2FoldChange > 0, ]))
names(up_genes)
head(up_genes$F1_vs_P1)

# Perform ORA
ora_up <- lapply(
    up_genes,
    ora,
    annotation = go_chlamy, background = bg
)

ora_up

## -----------------------------------------------------------------------------
# Get count matrix
count_matrix <- assay(se_chlamy)
head(count_matrix)

# Get colData (data frame of sample metadata)
coldata <- colData(se_chlamy)
head(coldata)

## -----------------------------------------------------------------------------
# Create a SummarizedExperiment object
new_se <- SummarizedExperiment(
    assays = list(counts = count_matrix),
    colData = coldata
)

new_se

## ----echo = FALSE-------------------------------------------------------------
sessioninfo::session_info()

