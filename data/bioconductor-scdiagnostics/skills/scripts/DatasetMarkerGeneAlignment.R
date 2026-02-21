# Code example from 'DatasetMarkerGeneAlignment' vignette. See references/ for full tutorial.

## ----setup, include = FALSE, fig.show='hide'----------------------------------
knitr::knit_hooks$set(pngquant = knitr::hook_pngquant)

knitr::opts_chunk$set(
collapse = TRUE,
comment = "#>",
dev = "ragg_png",
dpi = 72,
fig.retina = 2,
fig.align = "center",
out.width = "100%",
pngquant = "--speed=1 --quality=1-5"
)

## ----message=FALSE, fig.show='hide'-------------------------------------------
# Load library
library(scDiagnostics)

# Load datasets
data("reference_data")
data("query_data")

# Set seed for reproducibility
set.seed(0)

## ----message=FALSE, fig.show='hide'-------------------------------------------
# Load library
library(scran)
library(scater)

# Subset to CD4 cells
ref_data_cd4 <- reference_data[, which(
    reference_data$expert_annotation == "CD4")]
query_data_cd4 <- query_data_cd4 <- query_data[, which(
    query_data$expert_annotation == "CD4")]

# Select highly variable genes
ref_top_genes <- getTopHVGs(ref_data_cd4, n = 500)
query_top_genes <- getTopHVGs(query_data_cd4, n = 500)
common_genes <- intersect(ref_top_genes, query_top_genes)

# Subset data by common genes
ref_data_cd4 <- ref_data_cd4[common_genes,]
query_data_cd4 <- query_data_cd4[common_genes,]

# Run PCA on both datasets
ref_data_cd4 <- runPCA(ref_data_cd4)
query_data_cd4 <- runPCA(query_data_cd4)

## ----fig.height=5, fig.width=10, fig.show='hide'------------------------------
# Perform PCA 
pca_comparison <- comparePCA(query_data = query_data_cd4, 
                             reference_data = ref_data_cd4, 
                             query_cell_type_col = "expert_annotation", 
                             ref_cell_type_col = "expert_annotation", 
                             pc_subset = 1:5, 
                             metric = "cosine")
plot(pca_comparison)

## ----fig.height=5, fig.width=10, fig.show='hide'------------------------------
# Compare PCA subspaces between query and reference data
subspace_comparison <- comparePCASubspace(
    query_data = query_data_cd4,
    reference_data = ref_data_cd4, 
    query_cell_type_col = "expert_annotation", 
    ref_cell_type_col = "expert_annotation", 
    pc_subset = 1:5
)

# View weighted cosine similarity score
subspace_comparison$weighted_cosine_similarity

# Plot output for PCA subspace comparison (if a plot method is available)
plot(subspace_comparison)

## ----fig.height=5, fig.width=10, fig.show='hide'------------------------------
# Example usage of the function
plotPairwiseDistancesDensity(query_data = query_data, 
                             reference_data = reference_data, 
                             query_cell_type_col = "expert_annotation", 
                             ref_cell_type_col = "expert_annotation", 
                             cell_type = "CD4", 
                             pc_subset = 1:5,
                             distance_metric = "euclidean")

## ----fig.height=5, fig.width=10, fig.show='hide'------------------------------
# Generate the Wasserstein distance density plot
wasserstein_data <- calculateWassersteinDistance(
    query_data = query_data_cd4,
    reference_data = ref_data_cd4, 
    query_cell_type_col = "expert_annotation", 
    ref_cell_type_col = "expert_annotation", 
    pc_subset = 1:10,
)
plot(wasserstein_data)

## ----fig.height=5, fig.width=10, fig.show='hide'------------------------------
# Perform Cramer test for the specified cell types and principal components
cramer_test <- calculateCramerPValue(
    reference_data = reference_data,
    query_data = query_data,
    ref_cell_type_col = "expert_annotation", 
    query_cell_type_col = "SingleR_annotation",
    cell_types = c("CD4", "CD8", "B_and_plasma", "Myeloid"),
    pc_subset = 1:5
)

# Display the Cramer test p-values
print(cramer_test)

## ----fig.height=5, fig.width=10, fig.show='hide'------------------------------
# Calculate Hotelling's T-squared test p-values
p_values <- calculateHotellingPValue(
    query_data = query_data, 
    reference_data = reference_data, 
    query_cell_type_col = "SingleR_annotation", 
    ref_cell_type_col = "expert_annotation",
    pc_subset = 1:10
)

# Display the p-values rounded to five decimal places
print(round(p_values, 5))

## ----fig.height=5, fig.width=10, fig.show='hide'------------------------------
# Compute pairwise correlations between specified cell types
cor_matrix_avg <- calculateAveragePairwiseCorrelation(
  query_data = query_data, 
  reference_data = reference_data, 
  query_cell_type_col = "SingleR_annotation", 
  ref_cell_type_col = "expert_annotation", 
  cell_types = c("CD4", "CD8", "B_and_plasma"), 
  pc_subset = 1:5,
  correlation_method = "spearman"
)

# Visualize the average pairwise correlation matrix
plot(cor_matrix_avg)

## ----fig.height=5, fig.width=10, fig.show='hide'------------------------------
# Query-only analysis: How well do cell types separate in PCA space?
regress_res_query <- regressPC(
    query_data = query_data,
    query_cell_type_col = "expert_annotation",
    cell_types = c("CD4", "CD8", "B_and_plasma", "Myeloid"),
    pc_subset = 1:10
)

# Visualize results
plot(regress_res_query, plot_type = "r_squared")
plot(regress_res_query, plot_type = "variance_contribution")

## ----fig.height=5, fig.width=10, fig.show='hide'------------------------------
# Plot results showing p-values
plot(regress_res_query, plot_type = "coefficient_heatmap")

## ----fig.height=5, fig.width=10, fig.show='hide'------------------------------
# Perform regression analysis using both reference and query data
regress_res <- regressPC(
    query_data = query_data,
    reference_data = reference_data,
    query_cell_type_col = "SingleR_annotation",
    ref_cell_type_col = "expert_annotation",
    cell_types = c("CD4", "CD8", "B_and_plasma", "Myeloid"),
    pc_subset = 1:10
)

# Visualize results
plot(regress_res, plot_type = "r_squared")
plot(regress_res, plot_type = "variance_contribution")

## ----fig.height=5, fig.width=10, fig.show='hide'------------------------------
# Plot results showing p-values
plot(regress_res, plot_type = "coefficient_heatmap")

## ----fig.height=5, fig.width=10, fig.show='hide'------------------------------
# Load library to get top HVGs
library(scran)

# Select the top 500 highly variable genes from both datasets
ref_var_genes <- getTopHVGs(reference_data, n = 500)
query_var_genes <- getTopHVGs(query_data, n = 500)

# Calculate the overlap coefficient between the reference and query HVGs
overlap_coefficient <- calculateHVGOverlap(reference_genes = ref_var_genes, 
                                           query_genes = query_var_genes)

# Display the overlap coefficient
overlap_coefficient

## ----fig.height=5, fig.width=10, fig.show='hide'------------------------------
# RF function to compare which genes are best at differentiating cell types
rf_output <- calculateVarImpOverlap(reference_data = reference_data, 
                                    query_data = query_data, 
                                    query_cell_type_col = "expert_annotation", 
                                    ref_cell_type_col = "expert_annotation", 
                                    n_tree = 500,
                                    n_top = 50)

# Comparison table
rf_output$var_imp_comparison

## ----SessionInfo, echo=FALSE, message=FALSE, warning=FALSE, comment=NA, fig.show='hide'----
options(width = 80) 
sessionInfo()

