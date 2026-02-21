# Code example from 'celaref_doco' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
library(celaref)
library(knitr) #kable
library(ggplot2)
library(dplyr)
library(magrittr)
library(readr)
library(tibble)



## ----eval=FALSE---------------------------------------------------------------
# # Installing BiocManager if necessary:
# # install.packages("BiocManager")
# BiocManager::install("celaref")

## ----eval=FALSE---------------------------------------------------------------
# devtools::install_github("MonashBioinformaticsPlatform/celaref")
# # Or
# BiocManager::install("MonashBioinformaticsPlatform/celaref")

## ----toy_example, message=FALSE, eval=TRUE------------------------------------

library(celaref)

# Paths to data files.
counts_filepath.query    <- system.file("extdata", "sim_query_counts.tab",    package = "celaref")
cell_info_filepath.query <- system.file("extdata", "sim_query_cell_info.tab", package = "celaref")
counts_filepath.ref      <- system.file("extdata", "sim_ref_counts.tab",      package = "celaref")
cell_info_filepath.ref   <- system.file("extdata", "sim_ref_cell_info.tab",   package = "celaref")

# Load data
toy_ref_se   <- load_se_from_files(counts_file=counts_filepath.ref, cell_info_file=cell_info_filepath.ref)
toy_query_se <- load_se_from_files(counts_file=counts_filepath.query, cell_info_file=cell_info_filepath.query)

# Filter data
toy_ref_se     <- trim_small_groups_and_low_expression_genes(toy_ref_se)
toy_query_se   <- trim_small_groups_and_low_expression_genes(toy_query_se)

# Setup within-experiment differential expression
de_table.toy_ref   <- contrast_each_group_to_the_rest(toy_ref_se,    dataset_name="ref")
de_table.toy_query <- contrast_each_group_to_the_rest(toy_query_se,  dataset_name="query")

## ----toy_example1b, message=FALSE, eval=TRUE----------------------------------
# Plot
make_ranking_violin_plot(de_table.test=de_table.toy_query, de_table.ref=de_table.toy_ref)

## ----toy_example2, message=FALSE, warnings=FALSE, eval=FALSE------------------
# # And get group labels
# make_ref_similarity_names(de_table.toy_query, de_table.toy_ref)

## ----toy_example3,  echo=FALSE, message=FALSE, warnings=FALSE-----------------
kable(make_ref_similarity_names(de_table.toy_query, de_table.toy_ref), digits=50)

## ----eval=FALSE---------------------------------------------------------------
# dataset_se <- load_se_from_files(counts_matrix   = "counts_matrix_file.tab",
#                                   cell_info_file = "cell_info_file.tab",
#                                   group_col_name = "Cluster")

## ----eval=FALSE---------------------------------------------------------------
# dataset_se <- load_se_from_files(counts_matrix   = "counts_matrix_file.tab",
#                                   cell_info_file = "cell_info_file.tab",
#                                   group_col_name  = "Cluster",
#                                   cell_col_name   = "CellId" )

## ----eval=FALSE---------------------------------------------------------------
# dataset_se <- load_se_from_files(counts_matrix   = "counts_matrix_file.tab",
#                                   cell_info_file = "cell_info_file.tab",
#                                   gene_info_file = "gene_info_file.tab",
#                                   group_col_name = "Cluster")
# 

## ----eval=FALSE---------------------------------------------------------------
# dataset_se <- load_se_from_tables(counts_matrix   = counts_matrix,
#                                   cell_info_table = cell_info_table,
#                                   group_col_name  = "Cluster")

## ----eval=FALSE---------------------------------------------------------------
# dataset_se <- load_dataset_10Xdata('~/path/to/data/10X_mydata',
#                                    dataset_genome = "GRCh38",
#                                    clustering_set = "kmeans_7_clusters")
# 

## ----eval=FALSE---------------------------------------------------------------
# library(Matrix)
# #a sparse big M Matrix.
# dataset_se.1 <- load_se_from_tables(counts_matrix = my_sparse_Matrix,
#                                   cell_info_table = cell_info_table,
#                                   group_col_name  = "Cluster")
# 
# # A hdf5-backed SummarisedExperiment from elsewhere
# dataset_se.2 <- loadHDF5SummarizedExperiment("a_SE_dir/")
# 

## -----------------------------------------------------------------------------
# For consistant subsampling, use set.seed
set.seed(12)
de_table.demo_query.subset <- 
   contrast_each_group_to_the_rest(demo_query_se, "subsetted_example",
                                   n.group = 100, n.other = 200)

## -----------------------------------------------------------------------------
set.seed(12)
demo_query_se.subset <- subset_cells_by_group(demo_query_se, n.group = 100)

## ----eval=FALSE---------------------------------------------------------------
# de_table.microarray <- contrast_each_group_to_the_rest_for_norm_ma_with_limma(
#     norm_expression_table=demo_microarray_expr,
#     sample_sheet_table=demo_microarray_sample_sheet,
#     dataset_name="DemoSimMicroarrayRef",
#     sample_name="cell_sample", group_name="group")
# 

## ----eval=TRUE, echo=FALSE----------------------------------------------------
# Just define a dummy dataset_se from less generically named test data,
# so it can be run during vignette compilation.
dataset_se <- toy_query_se

## ----eval=TRUE----------------------------------------------------------------
# Default filtering
dataset_se <- trim_small_groups_and_low_expression_genes(dataset_se)

# Also defaults, but specified
dataset_se <- trim_small_groups_and_low_expression_genes(dataset_se, 
                                    min_lib_size = 1000, 
                                    min_group_membership = 5,  
                                    min_detected_by_min_samples = 5)


## ----eval=FALSE---------------------------------------------------------------
# # Count and store total reads/gene.
# rowData(dataset_se)$total_count <- Matrix::rowSums(assay(dataset_se))
# # rowData(dataset_se) must already list column 'GeneSymbol'
# dataset_se <- convert_se_gene_ids(dataset_se, new_id='GeneSymbol', eval_col = 'total_count')
# 

## ----eval=TRUE----------------------------------------------------------------
demo_query_se.filtered <- trim_small_groups_and_low_expression_genes(demo_query_se)

de_table.demo_query <- contrast_each_group_to_the_rest(demo_query_se.filtered, "a_demo_query")

## ----eval=TRUE----------------------------------------------------------------
demo_ref_se.filtered <- trim_small_groups_and_low_expression_genes(demo_ref_se)
de_table.demo_ref   <- contrast_each_group_to_the_rest(demo_ref_se.filtered,   "a_demo_reference")

## ----eval=TRUE, echo=FALSE----------------------------------------------------
kable(head(de_table.demo_query))

## ----eval=TRUE----------------------------------------------------------------
de_table.microarray <- contrast_each_group_to_the_rest_for_norm_ma_with_limma(
    norm_expression_table=demo_microarray_expr, 
    sample_sheet_table=demo_microarray_sample_sheet,
    dataset_name="DemoSimMicroarrayRef", 
    sample_name="cell_sample", group_name="group") 

## ----eval=TRUE----------------------------------------------------------------
make_ranking_violin_plot(de_table.test=de_table.demo_query, de_table.ref=de_table.demo_ref)

## ----eval=TRUE----------------------------------------------------------------
make_ranking_violin_plot(de_table.test=de_table.demo_query, de_table.ref=de_table.demo_query)

## ----eval=TRUE----------------------------------------------------------------
group_names_table <- make_ref_similarity_names(de_table.demo_query, de_table.demo_ref)

## ----eval=TRUE, echo=FALSE----------------------------------------------------
kable(group_names_table)

## -----------------------------------------------------------------------------
de_table.marked.query_vs_ref <- get_the_up_genes_for_all_possible_groups(
   de_table.test=de_table.demo_query ,
   de_table.ref=de_table.demo_ref)
# Have to do do the reciprocal table too for labelling.
de_table.marked.ref_vs_query<- get_the_up_genes_for_all_possible_groups(
   de_table.test=de_table.demo_ref ,
   de_table.ref=de_table.demo_query)

kable(head(de_table.marked.query_vs_ref))

## -----------------------------------------------------------------------------
make_ranking_violin_plot(de_table.marked.query_vs_ref)
#use make_ref_similarity_names_using_marked instead:
similarity_label_table <- make_ref_similarity_names_using_marked(de_table.marked.query_vs_ref, de_table.recip.marked=de_table.marked.ref_vs_query)

## -----------------------------------------------------------------------------
kable(similarity_label_table)

## ----eval=TRUE, echo=FALSE, message=FALSE, warning=FALSE----------------------
# Preprocessed data
library(ExperimentHub)
eh = ExperimentHub()
de_table.10X_pbmc4k_k7        <- ExperimentHub::loadResources(eh, "celarefData", 'de_table_10X_pbmc4k_k7')[[1]]
de_table.Watkins2009PBMCs     <- ExperimentHub::loadResources(eh, "celarefData", 'de_table_Watkins2009_pbmcs')[[1]]
de_table.zeisel.cortex        <- ExperimentHub::loadResources(eh, "celarefData", 'de_table_Zeisel2015_cortex')[[1]]
de_table.zeisel.hippo         <- ExperimentHub::loadResources(eh, "celarefData", 'de_table_Zeisel2015_hc')[[1]]
de_table.Farmer2017lacrimalP4 <- ExperimentHub::loadResources(eh, "celarefData", 'de_table_Farmer2017_lacrimalP4')[[1]]

# Some tiny info tables  in a 52kb file named for historical reasons...
load(system.file("extdata", "larger_doco_examples.rdata", package = "celaref"))


## ----eval=FALSE---------------------------------------------------------------
# library(celaref)
# datasets_dir <- "~/celaref_extra_vignette_data/datasets"
# 
# dataset_se.10X_pbmc4k_k7 <- load_dataset_10Xdata(
#    dataset_path   = file.path(datasets_dir,'10X_pbmc4k'),
#    dataset_genome = "GRCh38",
#    clustering_set = "kmeans_7_clusters",
#    id_to_use      = "GeneSymbol")
# dataset_se.10X_pbmc4k_k7 <- trim_small_groups_and_low_expression_genes(dataset_se.10X_pbmc4k_k7)
# 

## ----eval=FALSE---------------------------------------------------------------
# de_table.10X_pbmc4k_k7   <- contrast_each_group_to_the_rest(dataset_se.10X_pbmc4k_k7, dataset_name="10X_pbmc4k_k7", num_cores=7)

## ----eval=FALSE---------------------------------------------------------------
# this_dataset_dir     <- file.path(datasets_dir,     'haemosphere_datasets','watkins')
# norm_expression_file <- file.path(this_dataset_dir, "watkins_expression.txt")
# samples_file         <- file.path(this_dataset_dir, "watkins_samples.txt")
# 
# norm_expression_table.full <- read.table(norm_expression_file, sep="\t", header=TRUE, quote="", comment.char="", row.names=1, check.names=FALSE)
# 
# samples_table              <- read_tsv(samples_file, col_types = cols())
# samples_table$description  <- make.names( samples_table$description) # Avoid group or extra_factor names starting with numbers, for microarrays
# 

## ----eval=FALSE---------------------------------------------------------------
# samples_table        <- samples_table[samples_table$tissue == "Peripheral Blood",]

## ----echo=FALSE---------------------------------------------------------------
kable(head(samples_table))

## ----eval=FALSE---------------------------------------------------------------
# library("tidyverse")
# library("illuminaHumanv2.db")
# probes_with_gene_symbol_and_with_data <- intersect(keys(illuminaHumanv2SYMBOL),rownames(norm_expression_table.full))
# 
# # Get mappings - non NA
# probe_to_symbol <- select(illuminaHumanv2.db, keys=rownames(norm_expression_table.full), columns=c("SYMBOL"), keytype="PROBEID")
# probe_to_symbol <- unique(probe_to_symbol[! is.na(probe_to_symbol$SYMBOL),])
# # no multimapping probes
# genes_per_probe <- table(probe_to_symbol$PROBEID) # How many genes a probe is annotated against?
# multimap_probes <- names(genes_per_probe)[genes_per_probe  > 1]
# probe_to_symbol <- probe_to_symbol[!probe_to_symbol$PROBEID %in% multimap_probes, ]
# 
# 
# convert_expression_table_ids<- function(expression_table, the_probes_table, old_id_name, new_id_name){
# 
#     the_probes_table <- the_probes_table[,c(old_id_name, new_id_name)]
#     colnames(the_probes_table) <- c("old_id", "new_id")
# 
#     # Before DE, just pick the top expresed probe to represent the gene
#     # Not perfect, but this is a ranking-based analysis.
#     # hybridisation issues aside, would expect higher epressed probes to be more relevant to Single cell data anyway.
#     probe_expression_levels <- rowSums(expression_table)
#     the_probes_table$avgexpr <- probe_expression_levels[as.character(the_probes_table$old_id)]
# 
#     the_genes_table <-  the_probes_table %>%
#         group_by(new_id) %>%
#         top_n(1, avgexpr)
# 
#     expression_table <- expression_table[the_genes_table$old_id,]
#     rownames(expression_table) <- the_genes_table$new_id
# 
#     return(expression_table)
# }
# 
# # Just the most highly expressed probe foreach gene.
# norm_expression_table.genes <- convert_expression_table_ids(norm_expression_table.full,
#                                                             probe_to_symbol, old_id_name="PROBEID", new_id_name="SYMBOL")

## ----eval=FALSE---------------------------------------------------------------
# # Go...
# de_table.Watkins2009PBMCs <- contrast_each_group_to_the_rest_for_norm_ma_with_limma(
#                  norm_expression_table = norm_expression_table.genes,
#                  sample_sheet_table    = samples_table,
#                  dataset_name          = "Watkins2009PBMCs",
#                  extra_factor_name     = 'description',
#                  sample_name           = "sampleId",
#                  group_name            = 'celltype')
# 

## ----eval=TRUE----------------------------------------------------------------
make_ranking_violin_plot(de_table.test=de_table.10X_pbmc4k_k7, de_table.ref=de_table.Watkins2009PBMCs)

## ----eval=TRUE----------------------------------------------------------------
make_ranking_violin_plot(de_table.test=de_table.10X_pbmc4k_k7, de_table.ref=de_table.Watkins2009PBMCs, log10trans = TRUE)

## ----eval=TRUE, warning=FALSE-------------------------------------------------
label_table.pbmc4k_k7_vs_Watkins2009PBMCs <- make_ref_similarity_names(de_table.10X_pbmc4k_k7, de_table.Watkins2009PBMCs)

## ----eval=TRUE, echo=FALSE----------------------------------------------------
kable(label_table.pbmc4k_k7_vs_Watkins2009PBMCs %>% arrange(test_group) ) 

## ----eval=TRUE----------------------------------------------------------------
make_ranking_violin_plot(de_table.test=de_table.Watkins2009PBMCs, de_table.ref=de_table.10X_pbmc4k_k7, log10trans = TRUE)

## ----eval=FALSE---------------------------------------------------------------
# datasets_dir <- "~/celaref_extra_vignette_data/datasets"
# zeisel_cell_info_file <- file.path(datasets_dir, "zeisel2015", "zeisel2015_mouse_scs_detail.tab")
# zeisel_counts_file    <- file.path(datasets_dir, "zeisel2015", "zeisel2015_mouse_scs_counts.tab")

## ----eval=FALSE---------------------------------------------------------------
# dataset_se.zeisel <- load_se_from_files(zeisel_counts_file, zeisel_cell_info_file,
#                                  group_col_name = "level1class",
#                                  cell_col_name  = "cell_id" )

## ----eval=FALSE---------------------------------------------------------------
# # Subset the summarizedExperiment object into two tissue-specific objects
# dataset_se.cortex <- dataset_se.zeisel[,dataset_se.zeisel$tissue == "sscortex"]
# dataset_se.hippo  <- dataset_se.zeisel[,dataset_se.zeisel$tissue == "ca1hippocampus"]
# 
# # And filter them
# dataset_se.cortex  <- trim_small_groups_and_low_expression_genes(dataset_se.cortex )
# dataset_se.hippo   <- trim_small_groups_and_low_expression_genes(dataset_se.hippo )

## ----eval=FALSE---------------------------------------------------------------
# de_table.zeisel.cortex <- contrast_each_group_to_the_rest(dataset_se.cortex, dataset_name="zeisel_sscortex",       num_cores=6)
# de_table.zeisel.hippo  <- contrast_each_group_to_the_rest(dataset_se.hippo,  dataset_name="zeisel_ca1hippocampus", num_cores=6)

## ----eval=TRUE----------------------------------------------------------------
make_ranking_violin_plot(de_table.test=de_table.zeisel.cortex, de_table.ref=de_table.zeisel.hippo)

## ----eval=TRUE, echo=FALSE, warning=FALSE-------------------------------------

kable(make_ref_similarity_names(de_table.zeisel.cortex, de_table.zeisel.hippo) %>% arrange(test_group), 
      digits=50) #kable display hack


## ----eval=FALSE---------------------------------------------------------------
# library(Matrix)
# 
# Farmer2017lacrimal_dir  <- file.path(datasets_dir, "Farmer2017_lacrimal", "GSM2671416_P4")
# 
# # Counts matrix
# Farmer2017lacrimal_matrix_file   <- file.path(Farmer2017lacrimal_dir, "GSM2671416_P4_matrix.mtx")
# Farmer2017lacrimal_barcodes_file <- file.path(Farmer2017lacrimal_dir, "GSM2671416_P4_barcodes.tsv")
# Farmer2017lacrimal_genes_file    <- file.path(Farmer2017lacrimal_dir, "GSM2671416_P4_genes.tsv")
# 
# counts_matrix <- readMM(Farmer2017lacrimal_matrix_file)
# counts_matrix <- as.matrix(counts_matrix)
# storage.mode(counts_matrix) <- "integer"
# 
# genes <- read.table(Farmer2017lacrimal_genes_file,    sep="", stringsAsFactors = FALSE)[,1]
# cells <- read.table(Farmer2017lacrimal_barcodes_file, sep="", stringsAsFactors = FALSE)[,1]
# rownames(counts_matrix) <- genes
# colnames(counts_matrix) <- cells
# 
# 
# # Gene info table
# gene_info_table.Farmer2017lacrimal <- as.data.frame(read.table(Farmer2017lacrimal_genes_file, sep="", stringsAsFactors = FALSE), stringsAsFactors = FALSE)
# colnames(gene_info_table.Farmer2017lacrimal) <- c("ensemblID","GeneSymbol") # ensemblID is first, will become ID
# 
# ## Cell/sample info
# Farmer2017lacrimal_cells2groups_file  <- file.path(datasets_dir, "Farmer2017_lacrimal", "Farmer2017_supps", paste0("P4_cellinfo.tab"))
# Farmer2017lacrimal_clusterinfo_file   <- file.path(datasets_dir, "Farmer2017_lacrimal", "Farmer2017_supps", paste0("Farmer2017_clusterinfo_P4.tab"))
# 
# 
# # Cells to cluster number (just a number)
# Farmer2017lacrimal_cells2groups_table <- read_tsv(Farmer2017lacrimal_cells2groups_file, col_types=cols())
# # Cluster info - number to classification
# Farmer2017lacrimal_clusterinfo_table <- read_tsv(Farmer2017lacrimal_clusterinfo_file, col_types=cols())
# # Add in cluster info
# Farmer2017lacrimal_cells2groups_table <- merge(x=Farmer2017lacrimal_cells2groups_table, y=Farmer2017lacrimal_clusterinfo_table, by.x="cluster", by.y="ClusterNum")
# 
# # Cell sample2group
# cell_sample_2_group.Farmer2017lacrimal <- Farmer2017lacrimal_cells2groups_table[,c("Cell identity","ClusterID", "nGene", "nUMI")]
# colnames(cell_sample_2_group.Farmer2017lacrimal) <- c("cell_sample", "group", "nGene", "nUMI")
# # Add -1 onto each of the names, that seems to be in the counts
# cell_sample_2_group.Farmer2017lacrimal$cell_sample <- paste0(cell_sample_2_group.Farmer2017lacrimal$cell_sample, "-1")
# 
# # Create a summarised experiment object.
# dataset_se.P4  <- load_se_from_tables(counts_matrix,
#                                    cell_info_table = cell_sample_2_group.Farmer2017lacrimal,
#                                    gene_info_table = gene_info_table.Farmer2017lacrimal )

## ----eval=TRUE, echo=FALSE----------------------------------------------------
kable(head(colData(dataset_se.P4)))

## ----eval=TRUE, echo=FALSE----------------------------------------------------
kable(head(rowData(dataset_se.P4)[,1:3])) #edit because total count is added later, but is in the obj during doco production

## ----eval=FALSE---------------------------------------------------------------
# rowData(dataset_se.P4)$total_count <- rowSums(assay(dataset_se.P4))
# dataset_se.P4  <-  convert_se_gene_ids( dataset_se.P4,  new_id='GeneSymbol', eval_col='total_count')

## ----eval=FALSE---------------------------------------------------------------
# dataset_se.P4 <- trim_small_groups_and_low_expression_genes(dataset_se.P4)
# de_table.Farmer2017lacrimalP4  <- contrast_each_group_to_the_rest(dataset_se.P4,  dataset_name="Farmer2017lacrimalP4", num_cores = 4)

## ----eval=TRUE----------------------------------------------------------------
make_ranking_violin_plot(de_table.test=de_table.zeisel.cortex, de_table.ref=de_table.Farmer2017lacrimalP4)

## ----eval=TRUE----------------------------------------------------------------
label_table.cortex_vs_lacrimal <- 
   make_ref_similarity_names(de_table.zeisel.cortex, de_table.Farmer2017lacrimalP4)

## ----eval=TRUE, echo=FALSE----------------------------------------------------
kable(label_table.cortex_vs_lacrimal %>% arrange(test_group) , digits=50 ) 

## -----------------------------------------------------------------------------
sessionInfo()

