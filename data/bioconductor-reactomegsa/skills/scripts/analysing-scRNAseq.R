# Code example from 'analysing-scRNAseq' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# if (!require(ReactomeGSA))
#   BiocManager::install("ReactomeGSA")
# 
# # install the ReactomeGSA.data package for the example data
# if (!require(ReactomeGSA.data))
#   BiocManager::install("ReactomeGSA.data")

## -----------------------------------------------------------------------------
library(ReactomeGSA.data)
data(jerby_b_cells)

jerby_b_cells

## -----------------------------------------------------------------------------
# store the Idents as a meta.data field - this was
# removed while compressing the object as an example
jerby_b_cells$clusters <- Idents(jerby_b_cells)

table(jerby_b_cells$clusters)

## -----------------------------------------------------------------------------
library(ReactomeGSA)

# This creates a pseudo-bulk object by splitting each cluster in 4
# random bulks of data. This approach can be changed through the
# split_by and k_variable parameter.
pseudo_bulk_data <- generate_pseudo_bulk_data(jerby_b_cells, group_by = "clusters")

# we can immediately create the metadata data.frame for this data
pseudo_metadata <- generate_metadata(pseudo_bulk_data)

## -----------------------------------------------------------------------------
# Create a new request object using 'Camera' for the gene set analysis
my_request <- ReactomeAnalysisRequest(method = "Camera")

# set the maximum number of allowed missing values to 50%
my_request <- set_parameters(request = my_request, max_missing_values = 0.5)

# add the pseudo-bulk data as a dataset
my_request <- add_dataset(request = my_request,
                          expression_values = pseudo_bulk_data,
                          sample_data = pseudo_metadata,
                          name = "Pseudo-bulk",
                          type = "rnaseq_counts",
                          comparison_factor = "Group",
                          comparison_group_1 = "Cluster 1",
                          comparison_group_2 = "Cluster 2")

my_request

## -----------------------------------------------------------------------------
quant_result <- perform_reactome_analysis(my_request, compress = FALSE)
quant_result

## -----------------------------------------------------------------------------
# get the pathway-level results
quant_pathways <- pathways(quant_result)
head(quant_pathways)

## -----------------------------------------------------------------------------
# get the top pathways to label them
library(tidyr)
library(dplyr)

top_pathways <- quant_pathways %>% 
  tibble::rownames_to_column(var = "Id") %>%
  filter(`FDR.Pseudo-bulk` < 0.001) %>%
  arrange(desc(`av_foldchange.Pseudo-bulk`))

# limit to a few pathway for aesthetic reasons
top_pathways <- top_pathways[c(1,5,6), ]

# create a simple volcano plot of the pathway results
library(ggplot2)
ggplot(quant_pathways,
       aes(x = `av_foldchange.Pseudo-bulk`,
           y = -log10(`FDR.Pseudo-bulk`))) +
  geom_vline(xintercept = c(log2(0.5), log2(2)), colour="grey", linetype = "longdash") +
  geom_hline(yintercept = -log10(0.05), colour="grey", linetype = "longdash") +
  geom_point() +
  geom_label(data = top_pathways, aes(label = Name), nudge_y = 1, check_overlap = TRUE)

## -----------------------------------------------------------------------------
gsva_result <- analyse_sc_clusters(jerby_b_cells, verbose = TRUE)

## -----------------------------------------------------------------------------
gsva_result

## -----------------------------------------------------------------------------
pathway_expression <- pathways(gsva_result)

# simplify the column names by removing the default dataset identifier
colnames(pathway_expression) <- gsub("\\.Seurat", "", colnames(pathway_expression))

pathway_expression[1:3,]

## -----------------------------------------------------------------------------
# find the maximum differently expressed pathway
max_difference <- do.call(rbind, apply(pathway_expression, 1, function(row) {
    values <- as.numeric(row[2:length(row)])
    return(data.frame(name = row[1], min = min(values), max = max(values)))
}))

max_difference$diff <- max_difference$max - max_difference$min

# sort based on the difference
max_difference <- max_difference[order(max_difference$diff, decreasing = T), ]

head(max_difference)

## ----fig.width=7, fig.height=4------------------------------------------------
plot_gsva_pathway(gsva_result, pathway_id = rownames(max_difference)[1])

## ----fig.width=7, fig.height=8------------------------------------------------
# Additional parameters are directly passed to gplots heatmap.2 function
plot_gsva_heatmap(gsva_result, max_pathways = 15, margins = c(6,20))

## ----fig.width=7, fig.height=4------------------------------------------------
# limit to selected B cell related pathways
relevant_pathways <- c("R-HSA-983170", "R-HSA-388841", "R-HSA-2132295", "R-HSA-983705", "R-HSA-5690714")
plot_gsva_heatmap(gsva_result, 
                  pathway_ids = relevant_pathways, # limit to these pathways
                  margins = c(6,30), # adapt the figure margins in heatmap.2
                  dendrogram = "col", # only plot column dendrogram
                  scale = "row", # scale for each pathway
                  key = FALSE, # don't display the color key
                  lwid=c(0.1,4)) # remove the white space on the left

## ----fig.width=6, fig.height=4------------------------------------------------
plot_gsva_pca(gsva_result)

## -----------------------------------------------------------------------------
sessionInfo()

