# Code example from 'ALPS-vignette' vignette. See references/ for full tutorial.

## ---- include = FALSE----------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  dpi = 72,
  fig.align = "center"
)

## ----eval=FALSE----------------------------------------------------------
#  if (!requireNamespace("BiocManager", quietly = TRUE))
#      install.packages("BiocManager")
#  
#  BiocManager::install("ALPS")

## ----setup---------------------------------------------------------------
## load the library

library(ALPS)

## ------------------------------------------------------------------------
chr21_data_table <- system.file("extdata/bw", "ALPS_example_datatable.txt", package = "ALPS", mustWork = TRUE)

## attach path to bw_path and bed_path
d_path <- dirname(chr21_data_table)

chr21_data_table <- read.delim(chr21_data_table, header = TRUE)
chr21_data_table$bw_path <- paste0(d_path, "/", chr21_data_table$bw_path)
chr21_data_table$bed_path <- paste0(d_path, "/", chr21_data_table$bed_path)

chr21_data_table %>% head 


## ------------------------------------------------------------------------
enrichments <- multiBigwig_summary(data_table = chr21_data_table, 
                                   summary_type = "mean", 
                                   parallel = FALSE)

enrichments %>% head

## ----fig.align="center", fig.width=7-------------------------------------
enrichments_matrix <- get_variable_regions(enrichments_df = enrichments,
                                           log_transform = TRUE,
                                           scale = TRUE,
                                           num_regions = 100)
  
suppressPackageStartupMessages(require(ComplexHeatmap))
suppressPackageStartupMessages(require(circlize))

Heatmap(enrichments_matrix, name = "enrichments",
    col = colorRamp2(c(-1, 0, 1), c("green", "white", "red")),
    show_row_names = FALSE, 
    show_column_names = TRUE, 
    show_row_dend = FALSE,
    column_names_gp =  gpar(fontsize = 8))


## ----fig.align="center"--------------------------------------------------

plot_correlation(enrichments_df = enrichments, 
                 log_transform = TRUE, 
                 plot_type = "replicate_level", 
                 sample_metadata = chr21_data_table)


## ----fig.align="center"--------------------------------------------------
## group_level
plot_correlation(enrichments_df = enrichments, 
                 log_transform = TRUE, 
                 plot_type = "group_level", 
                 sample_metadata = chr21_data_table)

## ----fig.pos="center"----------------------------------------------------
## plot_type == "separate"

plot_enrichments(enrichments_df = enrichments, 
                 log_transform = TRUE, 
                 plot_type = "separate", 
                 sample_metadata = chr21_data_table)

## ------------------------------------------------------------------------
## plot_type == "overlap"

enrichemnts_4_overlapviolins <- system.file("extdata/overlap_violins",
                                      "enrichemnts_4_overlapviolins.txt",
                                      package = "ALPS", mustWork = TRUE)
enrichemnts_4_overlapviolins <- read.delim(enrichemnts_4_overlapviolins, header = TRUE)

## metadata associated with above enrichments

data_table_4_overlapviolins <- system.file("extdata/overlap_violins",
                                        "data_table_4_overlapviolins.txt",
                                        package = "ALPS", mustWork = TRUE)
data_table_4_overlapviolins <- read.delim(data_table_4_overlapviolins, header = TRUE)

## enrichments table
enrichemnts_4_overlapviolins %>% head

## metadata table
data_table_4_overlapviolins %>% head


## ----fig.align="center"--------------------------------------------------
plot_enrichments(enrichments_df = enrichemnts_4_overlapviolins,
                 log_transform = FALSE,
                 plot_type = "overlap", 
                 sample_metadata = data_table_4_overlapviolins,
                 overlap_order = c("untreated", "treated"))

## ----fig.height=10, fig.width=7, fig.align="center"----------------------

## gene_range
gene_range = "chr21:45643725-45942454"

plot_browser_tracks(data_table = chr21_data_table,
                    gene_range = gene_range, 
                    ref_gen = "hg38")

## ------------------------------------------------------------------------

g_annotations <- get_genomic_annotations(data_table = chr21_data_table,
                                         ref_gen = "hg38",
                                         tss_region = c(-1000, 1000),
                                         merge_level = "group_level")

g_annotations %>% head


## ----fig.height=5, fig.width=5.5, fig.align="center"---------------------
plot_genomic_annotations(annotations_df = g_annotations, plot_type = "heatmap")


## ----fig.height=4, fig.width=8, fig.align="center"-----------------------
plot_genomic_annotations(annotations_df = g_annotations, plot_type = "bar")

## ----fig.align="center"--------------------------------------------------
myc_transfac <- system.file("extdata/motifs", "MA0147.2.transfac", package = "ALPS", mustWork = TRUE)

## bar plot

plot_motif_logo(motif_path = myc_transfac, 
                database = "transfac", 
                plot_type = "bar")

## logo plot
plot_motif_logo(motif_path = myc_transfac, 
                database = "transfac", 
                plot_type = "logo")


## ------------------------------------------------------------------------
sessionInfo()

