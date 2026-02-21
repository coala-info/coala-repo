# Code example from 'scae_intro' vignette. See references/ for full tutorial.

## ----options, include=FALSE, echo=FALSE---------------------------------------
library(BiocStyle)
knitr::opts_chunk$set(crop=NULL)

## ----eval=FALSE---------------------------------------------------------------
# if (!require("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("SingleCellAlleleExperiment")

## ----message = FALSE----------------------------------------------------------
library(SingleCellAlleleExperiment)
library(scaeData)
library(scater)
library(scran)
library(scuttle)
library(DropletUtils)
library(ggplot2)
library(patchwork)
library(org.Hs.eg.db)
library(AnnotationDbi)

## -----------------------------------------------------------------------------
example_data_10k <- scaeData::scaeDataGet(dataset="pbmc_10k")

## -----------------------------------------------------------------------------
example_data_10k

## -----------------------------------------------------------------------------
lookup_name <- "pbmc_10k_lookup_table.csv"
lookup <- utils::read.csv(system.file("extdata", lookup_name, package="scaeData"))

## -----------------------------------------------------------------------------
head(lookup)

## ----eval=FALSE, warning=FALSE------------------------------------------------
# scae <- read_allele_counts(example_data_10k$dir,
#                            sample_names="example_data",
#                            filter_mode="no",
#                            lookup_file=lookup,
#                            barcode_file=example_data_10k$barcodes,
#                            gene_file=example_data_10k$features,
#                            matrix_file=example_data_10k$matrix,
#                            filter_threshold=NULL,
#                            verbose=FALSE)
# 

## ----warning=FALSE------------------------------------------------------------
scae <- read_allele_counts(example_data_10k$dir,
                           sample_names="example_data",
                           filter_mode="yes",
                           lookup_file=lookup,
                           barcode_file=example_data_10k$barcodes,
                           gene_file=example_data_10k$features,
                           matrix_file=example_data_10k$matrix,
                           log=TRUE)
scae

## -----------------------------------------------------------------------------
metadata(scae)[["knee_info"]]

## ----warning=FALSE, fig.height=5, fig.width=5---------------------------------

knee_df <- metadata(scae)[["knee_info"]]$knee_df
knee_point <- metadata(scae)[["knee_info"]]$knee_point
inflection_point <- metadata(scae)[["knee_info"]]$inflection_point

ggplot(knee_df, aes(x=rank, y=total)) +
       geom_point() +
       scale_x_log10() +
       scale_y_log10() +
       annotation_logticks() +
       labs(x="Barcode rank", y="Total UMI count") +
       geom_hline(yintercept=S4Vectors::metadata(knee_df)$knee,
                  color="dodgerblue", linetype="dashed") +
       geom_hline(yintercept=S4Vectors::metadata(knee_df)$inflection,
                  color="forestgreen", linetype="dashed") +
       annotate("text", x=2, y=S4Vectors::metadata(knee_df)$knee * 1.2,
                label="knee", color="dodgerblue") +
       annotate("text", x=2.25, y=S4Vectors::metadata(knee_df)$inflection * 1.2,
                label="inflection", color="forestgreen") +  theme_bw()


## ----warning=FALSE, eval=FALSE------------------------------------------------
# #this is the object used in the further workflow
# scae <- read_allele_counts(example_data_10k$dir,
#                            sample_names="example_data",
#                            filter_mode="custom",
#                            lookup_file=lookup,
#                            barcode_file=example_data_10k$barcodes,
#                            gene_file=example_data_10k$features,
#                            matrix_file=example_data_10k$matrix,
#                            filter_threshold=282)
# scae

## -----------------------------------------------------------------------------
rowData(scae)

## -----------------------------------------------------------------------------
head(colData(scae))

## -----------------------------------------------------------------------------
metadata(scae)[["knee_info"]]

## -----------------------------------------------------------------------------
scae_nonimmune_subset <- scae_subset(scae, "nonimmune")

head(rownames(scae_nonimmune_subset))

## -----------------------------------------------------------------------------
scae_alleles_subset <- scae_subset(scae, "alleles")

head(rownames(scae_alleles_subset))

## -----------------------------------------------------------------------------
scae_immune_genes_subset <- scae_subset(scae, "immune_genes")

head(rownames(scae_immune_genes_subset))

## -----------------------------------------------------------------------------
scae_functional_groups_subset <- scae_subset(scae, "functional_groups")

head(rownames(scae_functional_groups_subset))

## -----------------------------------------------------------------------------
scae_immune_layers_subset <- c(rownames(scae_subset(scae, "alleles")),
                               rownames(scae_subset(scae, "immune_genes")),
                               rownames(scae_subset(scae, "functional_groups")))

scater::plotExpression(scae, scae_immune_layers_subset)

## -----------------------------------------------------------------------------
rn_scae_ni <- rownames(scae_subset(scae, "nonimmune"))
rn_scae_alleles <- rownames(scae_subset(scae, "alleles"))

scae_nonimmune__allels_subset <- scae[c(rn_scae_ni, rn_scae_alleles), ]

scae_nonimmune__allels_subset

## -----------------------------------------------------------------------------
rn_scae_i <- rownames(scae_subset(scae, "immune_genes"))

scae_nonimmune__immune <- scae[c(rn_scae_ni, rn_scae_i), ]

scae_nonimmune__immune

## -----------------------------------------------------------------------------
rn_scae_functional <- rownames(scae_subset(scae, "functional_groups"))

scae_nonimmune__functional <- scae[c(rn_scae_ni, rn_scae_functional), ]

scae_nonimmune__functional

## -----------------------------------------------------------------------------
df_ni_a <- modelGeneVar(scae_nonimmune__allels_subset)
top_ni_a <- getTopHVGs(df_ni_a, prop=0.1)

## -----------------------------------------------------------------------------
df_ni_g <- modelGeneVar(scae_nonimmune__immune)
top_ni_g <- getTopHVGs(df_ni_g, prop=0.1)

## -----------------------------------------------------------------------------
df_ni_f <- modelGeneVar(scae_nonimmune__functional)
top_ni_f <- getTopHVGs(df_ni_f, prop=0.1)

## -----------------------------------------------------------------------------
assay <- "logcounts"

scae <- runPCA(scae, ncomponents=10, subset_row=top_ni_a,
               exprs_values=assay, name="PCA_a")

scae <- runPCA(scae, ncomponents=10, subset_row=top_ni_g,
               exprs_values=assay, name="PCA_g")

scae <- runPCA(scae, ncomponents=10, subset_row=top_ni_f,
               exprs_values=assay, name="PCA_f")

## -----------------------------------------------------------------------------
reducedDimNames(scae)

## -----------------------------------------------------------------------------
set.seed(18)
scae <- runTSNE(scae, dimred="PCA_g",  name="TSNE_g")

## ----eval=FALSE---------------------------------------------------------------
# set.seed(18)
# scae <- runTSNE(scae, dimred="PCA_a",  name="TSNE_a")

## ----eval=FALSE---------------------------------------------------------------
# set.seed(18)
# scae <- runTSNE(scae, dimred="PCA_f",  name="TSNE_f")

## -----------------------------------------------------------------------------
reducedDimNames(scae)

## ----fig3, fig.height = 4, fig.width = 12, fig.align = "center", warning = FALSE, message=FALSE----
tsne <- "TSNE_g"

tsne_g_a  <- plotReducedDim(scae, dimred=tsne, colour_by="HLA-DRB1") +
             ggtitle("HLA-DRB1 gene")

tsne_g_a1 <- plotReducedDim(scae, dimred=tsne, colour_by="DRB1*07:01:01:01") + 
             ggtitle("Allele DRB1*07:01:01:01")

tsne_g_a2 <- plotReducedDim(scae, dimred=tsne, colour_by="DRB1*13:01:01:01") + 
             ggtitle("Allele DRB1*13:01:01:01")

p2 <- tsne_g_a + tsne_g_a1 + tsne_g_a2
p2

## -----------------------------------------------------------------------------
sessionInfo()

