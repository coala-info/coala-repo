# Code example from 'goSTAG' vignette. See references/ for full tutorial.

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("goSTAG")

## ----warning = FALSE, message = FALSE-----------------------------------------
library("goSTAG")

## -----------------------------------------------------------------------------
data( goSTAG_example_gene_lists )
head( lapply( goSTAG_example_gene_lists, head ) )

## ----eval = FALSE-------------------------------------------------------------
# gene_lists <- loadGeneLists( "gene_lists.gmt" )

## ----eval = FALSE-------------------------------------------------------------
# gene_lists <- loadGeneLists( "/gene/lists/directory", type = "DIR" )

## ----eval = FALSE-------------------------------------------------------------
# gene_lists <- loadGeneLists( "/gene/lists/directory", type = "DIR", header = TRUE, col = 7 )

## ----warning = FALSE, message = FALSE-----------------------------------------
go_terms <- loadGOTerms()
head( lapply( go_terms, head ) )
head( go_terms[["ALL"]] )

## ----eval = FALSE-------------------------------------------------------------
# go_terms <- loadGOTerms( use_archived = FALSE )

## -----------------------------------------------------------------------------
go_terms_mouse <- loadGOTerms( species = "mouse", domain = "MF", min_num_genes = 10 )

## -----------------------------------------------------------------------------
enrichment_matrix <- performGOEnrichment( goSTAG_example_gene_lists, go_terms )
head(enrichment_matrix)

## ----eval = FALSE-------------------------------------------------------------
# enrichment_matrix_FDR <- performGOEnrichment( goSTAG_example_gene_lists, go_terms, filter_method = "p.adjust", significance_threshold = 0.3, p.adjust_method = "BH" )

## -----------------------------------------------------------------------------
hclust_results <- performHierarchicalClustering( enrichment_matrix )
hclust_results

## -----------------------------------------------------------------------------
hclust_results_euclidean <- performHierarchicalClustering( enrichment_matrix, distance_method = "euclidean", clustering_method = "complete" )

## -----------------------------------------------------------------------------
sample_hclust_results <- performHierarchicalClustering( enrichment_matrix, feature = "col" )

## -----------------------------------------------------------------------------
clusters <- groupClusters( hclust_results_euclidean )
lapply( head( clusters ), head )

## -----------------------------------------------------------------------------
length( clusters )

## -----------------------------------------------------------------------------
clusters_larger_threshold <- groupClusters( hclust_results_euclidean, distance_threshold = 0.5 )
length( clusters_larger_threshold )

## -----------------------------------------------------------------------------
clusters_smaller_threshold <- groupClusters( hclust_results_euclidean, distance_threshold = 0.05 )
length( clusters_smaller_threshold )

## -----------------------------------------------------------------------------
cluster_labels <- annotateClusters( clusters )
head( cluster_labels )

## -----------------------------------------------------------------------------
plotHeatmap( enrichment_matrix, hclust_results_euclidean, clusters, cluster_labels )

## -----------------------------------------------------------------------------
plotHeatmap( enrichment_matrix, hclust_results_euclidean, clusters, cluster_labels, sample_hclust_results = sample_hclust_results )

## -----------------------------------------------------------------------------
plotHeatmap( enrichment_matrix, hclust_results_euclidean, clusters, cluster_labels, min_num_terms = 5 )

## ----eval = FALSE-------------------------------------------------------------
# png( "heatmap.png", width = 1600, height = 1200 )
# plotHeatmap( enrichment_matrix, hclust_results_euclidean, clusters, cluster_labels, dendrogram_lwd = 2, header_lwd = 2, cluster_label_cex = 2, sample_label_cex = 2 )
# dev.off()

## -----------------------------------------------------------------------------
citation("goSTAG")

## -----------------------------------------------------------------------------
sessionInfo()

