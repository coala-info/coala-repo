# Code example from 'VisualizationTools' vignette. See references/ for full tutorial.

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
pngquant = "--speed=1 --quality=5-10"
)

## ----message=FALSE, fig.show='hide'-------------------------------------------
# Load library
library(scDiagnostics)

# Load datasets
data("reference_data")
data("query_data")
data("qc_data")

# Set seed for reproducibility
set.seed(0)

## ----fig.height=5, fig.width=10, fig.show='hide'------------------------------
# Generate the MDS scatter plot with cell type coloring
plotCellTypeMDS(query_data = query_data, 
                reference_data = reference_data, 
                cell_types = c("CD4", "CD8", "B_and_plasma", "Myeloid"),
                query_cell_type_col = "SingleR_annotation", 
                ref_cell_type_col = "expert_annotation")

## ----fig.height=5, fig.width=10, fig.show='hide'------------------------------
# Generate the MDS scatter plot with cell type coloring
plotCellTypePCA(query_data = query_data, 
                reference_data = reference_data,
                cell_types = c("CD4", "CD8", "B_and_plasma", "Myeloid"),
                query_cell_type_col = "SingleR_annotation", 
                ref_cell_type_col = "expert_annotation", 
                pc_subset = 1:3)

## ----fig.height=5, fig.width=10, fig.show='hide'------------------------------
# Plot the PCA data as boxplots
boxplotPCA(query_data = query_data, 
           reference_data = reference_data,
           cell_types = c("CD4", "CD8", "B_and_plasma", "Myeloid"),
           query_cell_type_col = "SingleR_annotation", 
           ref_cell_type_col = "expert_annotation", 
           pc_subset = 1:3)

## ----fig.height=5, fig.width=10, fig.show='hide'------------------------------
# Compute important variables for all pairwise cell comparisons
disc_output <- calculateDiscriminantSpace(
  reference_data = reference_data,
  query_data = query_data, 
  query_cell_type_col = "SingleR_annotation", 
  ref_cell_type_col = "expert_annotation")

# Generate scatter and boxplot
plot(disc_output, plot_type = "scatterplot")

## ----fig.height=5, fig.width=10, fig.show='hide'------------------------------
# Perform discriminant analysis and projection
discriminant_results <- calculateDiscriminantSpace(
  reference_data = reference_data,
  query_data = query_data,
  ref_cell_type_col = "expert_annotation",
  query_cell_type_col = "SingleR_annotation",
  calculate_metrics = TRUE,  # Compute Mahalanobis distance and cosine similarity
  alpha = 0.01  # Significance level for Mahalanobis distance cutoff
)

## ----fig.height=5, fig.width=10, fig.show='hide'------------------------------
# Extract Mahalanobis distances
mahalanobis_distances <- discriminant_results$query_mahalanobis_dist

# Identify anomalies based on a threshold
threshold <- discriminant_results$mahalanobis_crit  # Use the computed cutoff value
anomalies <- mahalanobis_distances[mahalanobis_distances > threshold]

## ----fig.height=5, fig.width=10, fig.show='hide'------------------------------
# Load ggplot2 for visualization
library(ggplot2)

# Convert distances to a data frame
distances_df <- data.frame(Distance = mahalanobis_distances,
                           Anomaly = ifelse(mahalanobis_distances > threshold, "Anomaly", "Normal"))

# Plot histogram of Mahalanobis distances
ggplot(distances_df, aes(x = Distance, fill = Anomaly)) +
  geom_histogram(binwidth = 0.5, position = "identity", alpha = 0.7) +
  labs(title = "Histogram of Mahalanobis Distances",
       x = "Mahalanobis Distance",
       y = "Frequency") +
  theme_bw()

## ----fig.height=5, fig.width=10, fig.show='hide'------------------------------
# Calculate the SIR space projections
sir_output <- calculateSIRSpace(
  reference_data = reference_data,
  query_data = query_data,
  query_cell_type_col = "SingleR_annotation",
  ref_cell_type_col = "expert_annotation",
  multiple_cond_means = TRUE
)

# Plot the SIR space projections
plot(sir_output,
     sir_subset = 1:5,
     cell_types = c("CD4", "CD8", "B_and_plasma", "Myeloid"),
     lower_facet = "scatter",
     diagonal_facet = "boxplot",
     upper_facet = "blank")

## ----fig.height=5, fig.width=10, fig.show='hide'------------------------------
# Plot the top contributing markers
plot(sir_output, 
     plot_type = "loadings", 
     sir_subset = 1:5,
     n_top = 10)

## ----fig.height=5, fig.width=10, fig.show='hide'------------------------------
# Visualize VPREB3 gene on a PCA plot
plotGeneExpressionDimred(sce_object = query_data,
                         method = "PCA",
                         pc_subset = 1:5,
                         feature = "NKG7",
                         cell_types = "CD4",
                         cell_type_col = "SingleR_annotation")

## ----fig.height=5, fig.width=10, fig.show='hide'------------------------------
plotMarkerExpression(
    reference_data = reference_data,
    query_data = query_data,
    ref_cell_type_col = "expert_annotation",
    query_cell_type_col = "SingleR_annotation",
    gene_name = "NKG7",
    cell_type = "CD4",
    normalization = "z_score"
)

## ----fig.height=5, fig.width=10, fig.show='hide'------------------------------
# Remove cell types with very few cells
qc_data_subset <- qc_data[, !(qc_data$SingleR_annotation 
                              %in% c("Chondrocytes", "DC", 
                                     "Neurons","Platelets"))]

# Generate scatter plot
p1 <- plotQCvsAnnotation(sce_object = qc_data_subset,
                         cell_type_col = "SingleR_annotation",
                         qc_col = "total",
                         score_col = "annotation_scores")
p1 + ggplot2::xlab("Library Size")

## ----fig.height=5, fig.width=10, fig.show='hide'------------------------------
# Generate histograms
histQCvsAnnotation(sce_object = query_data, 
                   cell_type_col = "SingleR_annotation", 
                   qc_col = "percent_mito", 
                   score_col = "annotation_scores")

## ----fig.height=5, fig.width=10, fig.show='hide'------------------------------
# Plot gene set scores on PCA
plotGeneSetScores(sce_object = query_data, 
                  cell_type_col = "SingleR_annotation",
                  cell_types = "CD8",
                  method = "PCA", 
                  score_col = "gene_set_scores", 
                  pc_subset = 1:3)

## ----SessionInfo, echo=FALSE, message=FALSE, warning=FALSE, comment=NA, fig.show='hide'----
options(width = 80) 
sessionInfo()

