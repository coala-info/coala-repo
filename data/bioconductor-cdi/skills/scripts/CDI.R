# Code example from 'CDI' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
library(CDI)

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("CDI")

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("remotes", quietly = TRUE))
#     install.packages("remotes")
# remotes::install_github("jichunxie/CDI", build_vignettes = TRUE)

## ----data_reading-------------------------------------------------------------
data(one_batch_matrix, package = "CDI")
dim(one_batch_matrix)

data(one_batch_matrix_celltype, package = "CDI")
table(one_batch_matrix_celltype)

## ----data_label---------------------------------------------------------------
data(one_batch_matrix_label_df, package = "CDI")
knitr::kable(head(one_batch_matrix_label_df[,c("KMeans_k2", "KMeans_k4", "Seurat_k2", "Seurat_k3")], 3))

## ----feature_selection--------------------------------------------------------
feature_gene_indx <- feature_gene_selection(
	X = one_batch_matrix, 
	batch_label = NULL, 
	method = "wds", 
	nfeature = 500)
sub_one_batch_matrix <- one_batch_matrix[feature_gene_indx,]

## -----------------------------------------------------------------------------
one_batch_matrix_size_factor <- size_factor(X = one_batch_matrix)

## ----calculate_cdi1-----------------------------------------------------------
start_time <- Sys.time()
CDI_return1 <- calculate_CDI(
	X = sub_one_batch_matrix, 
	cand_lab_df = one_batch_matrix_label_df, 
	batch_label = NULL, 
	cell_size_factor = one_batch_matrix_size_factor)
end_time <- Sys.time()
print(difftime(end_time, start_time))

## -----------------------------------------------------------------------------
knitr::kable(CDI_return1)

## -----------------------------------------------------------------------------
CDI_lineplot(cdi_dataframe = CDI_return1, cdi_type = "CDI_BIC")

## -----------------------------------------------------------------------------
contingency_heatmap(benchmark_label = one_batch_matrix_celltype,
	candidate_label = one_batch_matrix_label_df$KMeans_k5,
	rename_candidate_clusters = TRUE,
	candidate_cluster_names = paste0('cluster', seq_len(length(unique(one_batch_matrix_label_df$KMeans_k5)))))

## -----------------------------------------------------------------------------
benchmark_return1 <- calculate_CDI(X = sub_one_batch_matrix,
	cand_lab_df = one_batch_matrix_celltype, 
	batch_label = NULL, 
	cell_size_factor = one_batch_matrix_size_factor)

## -----------------------------------------------------------------------------
CDI_lineplot(cdi_dataframe = CDI_return1,
	cdi_type = "CDI_BIC",
	benchmark_celltype_cdi = benchmark_return1,
	benchmark_celltype_ncluster = length(unique(one_batch_matrix_celltype)))

## ----data_reading2------------------------------------------------------------
data(two_batch_matrix_celltype, package = "CDI")
table(two_batch_matrix_celltype)

data(two_batch_matrix_batch, package = "CDI")
table(two_batch_matrix_batch)

data(two_batch_matrix, package = "CDI")
dim(two_batch_matrix)


## ----data_label2, out.width="70%"---------------------------------------------
data(two_batch_matrix_label_df, package = "CDI")
knitr::kable(head(two_batch_matrix_label_df[,c("KMeans_k5", "KMeans_k6", "Seurat_k5", "Seurat_k6")], 3))

## ----feature_selection2-------------------------------------------------------
feature_gene_indx <- feature_gene_selection(
	X = two_batch_matrix,
	batch_label = two_batch_matrix_batch,
	method = "wds",
	nfeature = 500)
sub_two_batch_matrix <- two_batch_matrix[feature_gene_indx,]

## -----------------------------------------------------------------------------
two_batch_matrix_size_factor <- size_factor(two_batch_matrix)

start_time <- Sys.time()
CDI_return2 <- calculate_CDI(
	X = sub_two_batch_matrix,
	cand_lab_df = two_batch_matrix_label_df, 
	batch_label = two_batch_matrix_batch,
	cell_size_factor = two_batch_matrix_size_factor)
end_time <- Sys.time()
print(difftime(end_time, start_time))

## -----------------------------------------------------------------------------
knitr::kable(CDI_return2)

## -----------------------------------------------------------------------------
benchmark_return <- calculate_CDI(
	X = sub_two_batch_matrix,
	cand_lab_df = two_batch_matrix_celltype,
	batch_label = two_batch_matrix_batch,
	cell_size_factor = two_batch_matrix_size_factor)

## -----------------------------------------------------------------------------
CDI_lineplot(cdi_dataframe = CDI_return2,
	cdi_type = "CDI_BIC",
	benchmark_celltype_cdi = benchmark_return,
	benchmark_celltype_ncluster = length(unique(two_batch_matrix_celltype))) 

## -----------------------------------------------------------------------------
contingency_heatmap(
	benchmark_label = two_batch_matrix_celltype,
	candidate_label = two_batch_matrix_label_df$Seurat_k5,
	rename_candidate_clusters = TRUE,
	candidate_cluster_names = paste0('cluster', seq_len(length(unique(one_batch_matrix_label_df$Seurat_k5)))))

## -----------------------------------------------------------------------------
sessionInfo()

