# Code example from 'scDiagnostics' vignette. See references/ for full tutorial.

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

## ----eval = FALSE, fig.show='hide'--------------------------------------------
# BiocManager::install("ccb-hms/scDiagnostics")

## ----eval=FALSE, fig.show='hide'----------------------------------------------
# BiocManager::install("ccb-hms/scDiagnostics",
#                      build_vignettes = TRUE,
#                      dependencies = TRUE)

## ----message=FALSE, fig.show='hide'-------------------------------------------
library(scDiagnostics)

## ----message=FALSE, fig.show='hide'-------------------------------------------
# Load datasets
data("reference_data")
data("query_data")
data("qc_data")

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
# Plot PCA data
pc_plot <- plotCellTypePCA(
    query_data = query_data, 
    reference_data = reference_data,
    cell_types = c("CD4", "CD8", "B_and_plasma", "Myeloid"),
    query_cell_type_col = "expert_annotation", 
    ref_cell_type_col = "expert_annotation",
    pc_subset = 1:3
)
# Display plot
pc_plot

## ----fig.show='hide'----------------------------------------------------------
disc_output <- calculateDiscriminantSpace(
    reference_data = reference_data,
    query_data = query_data, 
    ref_cell_type_col = "expert_annotation",
    query_cell_type_col = "SingleR_annotation"
)

## ----fig.height=5, fig.width=10, fig.show='hide'------------------------------
plot(disc_output, plot_type = "scatterplot")

## ----fig.height=5, fig.width=10, fig.show='hide', fig.show='hide'-------------
plotMarkerExpression(reference_data = reference_data, 
                     query_data = query_data, 
                     ref_cell_type_col = "expert_annotation", 
                     query_cell_type_col = "SingleR_annotation", 
                     gene_name = "VPREB3", 
                     cell_type = "B_and_plasma")

## ----fig.height=5, fig.width=10, fig.show='hide'------------------------------
# Remove cell types with very few cells
qc_data_subset <- qc_data[, !(qc_data$SingleR_annotation 
                              %in% c("Chondrocytes", "DC", 
                                     "Neurons","Platelets"))]

# Generate scatter plot
library(ggplot2)
p1 <- plotQCvsAnnotation(sce_object = qc_data_subset,
                         cell_type_col = "SingleR_annotation",
                         qc_col = "total",
                         score_col = "annotation_scores")
p1 + xlab("Library Size")

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
                             cell_type = "CD8", 
                             pc_subset = 1:10,
                             distance_metric = "correlation",
                             correlation_method = "pearson")

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
# RF function to compare (between datasets) which genes are best at differentiating cell types
rf_output <- calculateVarImpOverlap(reference_data = reference_data, 
                                    query_data = query_data, 
                                    query_cell_type_col = "SingleR_annotation", 
                                    ref_cell_type_col = "expert_annotation", 
                                    n_tree = 500,
                                    n_top = 50)

# Comparison table
rf_output$var_imp_comparison

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
# Perform anomaly detection
anomaly_output <- detectAnomaly(reference_data = reference_data, 
                                query_data = query_data, 
                                ref_cell_type_col = "expert_annotation", 
                                query_cell_type_col = "SingleR_annotation",
                                pc_subset = 1:5)
# Plot the results for a specific cell type
plot(anomaly_output, 
     cell_type = "CD4", 
     data_type = "query",
     pc_subset = 1:5)

## ----fig.height=5, fig.width=10, fig.show='hide'------------------------------
# Identify outliers for CD4
cd4_anomalies <- detectAnomaly(reference_data = reference_data, 
                               query_data = query_data, 
                               query_cell_type_col = "SingleR_annotation", 
                               ref_cell_type_col = "expert_annotation")
cd4_top6_anomalies <- names(sort(cd4_anomalies$CD4$query_anomaly_scores, 
                                 decreasing = TRUE)[1:6])

# Plot the PC data
distance_data <- calculateCellDistances(
    query_data = query_data, 
    reference_data = reference_data, 
    query_cell_type_col = "SingleR_annotation", 
    ref_cell_type_col = "expert_annotation"
) 

# Plot the densities of the distances
plot(distance_data, ref_cell_type = "CD4", cell_names = cd4_top6_anomalies)

## ----SessionInfo, echo=FALSE, message=FALSE, warning=FALSE, comment=NA, fig.show='hide'----
options(width = 80) 
sessionInfo()

