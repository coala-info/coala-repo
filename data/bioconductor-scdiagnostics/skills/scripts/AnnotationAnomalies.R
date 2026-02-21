# Code example from 'AnnotationAnomalies' vignette. See references/ for full tutorial.

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

## ----fig.height=5, fig.width=10, fig.show='hide'------------------------------
# Perform anomaly detection
anomaly_output <- detectAnomaly(reference_data = reference_data, 
                                query_data = query_data, 
                                ref_cell_type_col = "expert_annotation", 
                                query_cell_type_col = "SingleR_annotation",
                                pc_subset = 1:5,
                                n_tree = 500,
                                anomaly_threshold = 0.6)

# Plot the output for the "CD4" cell type
plot(anomaly_output, 
     cell_type = "CD8", 
     pc_subset = 1:5, 
     data_type = "query")

## ----fig.height=5, fig.width=10, fig.show='hide'------------------------------
# Perform anomaly detection
anomaly_output <- detectAnomaly(reference_data = reference_data, 
                                query_data = query_data, 
                                ref_cell_type_col = "expert_annotation", 
                                query_cell_type_col = "SingleR_annotation",
                                pc_subset = 1:5,
                                n_tree = 500,
                                anomaly_threshold = 0.6)

# Plot the global anomaly scores
plot(anomaly_output, 
     cell_type = NULL,  # Plot all cell types
     pc_subset = 1:5, 
     data_type = "query")

## ----fig.height=5, fig.width=10, fig.show='hide'------------------------------
# Detect anomalies and select top anomalies for further analysis
anomaly_output <- detectAnomaly(reference_data = reference_data, 
                                query_data = query_data,
                                ref_cell_type_col = "expert_annotation", 
                                query_cell_type_col = "SingleR_annotation",
                                pc_subset = 1:10,
                                n_tree = 500,
                                anomaly_threshold = 0.5)

# Select the top 6 anomalies based on the anomaly scores
top6_anomalies <- names(sort(anomaly_output$Combined$reference_anomaly_scores, 
                             decreasing = TRUE)[1:6])

# Calculate cosine similarity between the top anomalies and top 25 PCs
cosine_similarities <- calculateCellSimilarityPCA(reference_data, 
                                                  cell_names = top6_anomalies, 
                                                  pc_subset = 1:25, 
                                                  n_top_vars = 50)

# Plot the cosine similarities across PCs
round(cosine_similarities[, paste0("PC", 15:25)], 2)

## ----fig.height=5, fig.width=10, fig.show='hide'------------------------------
# Compute cell distances
distance_data <- calculateCellDistances(
    query_data = query_data,
    reference_data = reference_data,
    query_cell_type_col = "SingleR_annotation",
    ref_cell_type_col = "expert_annotation",
    pc_subset = 1:10
)

## ----fig.height=5, fig.width=10, fig.show='hide'------------------------------
# Identify top 6 anomalies for CD4 cells
cd4_anomalies <- detectAnomaly(
  reference_data = reference_data,
  query_data = query_data,
  query_cell_type_col = "SingleR_annotation",
  ref_cell_type_col = "expert_annotation",
  pc_subset = 1:10,
  n_tree = 500,
  anomaly_threshold = 0.5)

# Top 6 CD4 anomalies
cd4_top6_anomalies <- names(sort(cd4_anomalies$CD4$query_anomaly_scores, decreasing = TRUE)[1:6])

# Plot distances for CD4 and CD8 cells
plot(distance_data, ref_cell_type = "CD4", cell_names = cd4_top6_anomalies)

## ----fig.height=5, fig.width=10, fig.show='hide'------------------------------
# Plot distances for CD8 cells
plot(distance_data, ref_cell_type = "CD8", cell_names = cd4_top6_anomalies)

## ----fig.height=5, fig.width=10, fig.show='hide'------------------------------
# Compute similarity measures for top 6 CD4 anomalies
overlap_measures <- calculateCellDistancesSimilarity(
  query_data = query_data,
  reference_data = reference_data,
  cell_names = cd4_top6_anomalies,
  query_cell_type_col = "SingleR_annotation",
  ref_cell_type_col = "expert_annotation",
  pc_subset = 1:10)
overlap_measures

## ----SessionInfo, echo=FALSE, message=FALSE, warning=FALSE, comment=NA, fig.show='hide'----
options(width = 80) 
sessionInfo()

