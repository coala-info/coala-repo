# Code example from 'introduction' vignette. See references/ for full tutorial.

## ----echo=FALSE, include=FALSE------------------------------------------------
library(knitr)
knitr::opts_chunk$set(
    cache=TRUE, warning=FALSE,
    message=FALSE, cache.lazy=FALSE)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("tidySingleCellExperiment")

## ----message=FALSE------------------------------------------------------------
# Bioconductor single-cell packages
library(scran)
library(scater)
library(igraph)
library(celldex)
library(SingleR)
library(SingleCellSignalR)

# Tidyverse-compatible packages
library(purrr)
library(GGally)
library(tidyHeatmap)

# Both
library(tidySingleCellExperiment)

# Other
library(Matrix)
library(dittoSeq)

## -----------------------------------------------------------------------------
data(pbmc_small, package="tidySingleCellExperiment")
pbmc_small_tidy <- pbmc_small

## -----------------------------------------------------------------------------
pbmc_small_tidy

## -----------------------------------------------------------------------------
counts(pbmc_small_tidy)[1:5, 1:4]

## -----------------------------------------------------------------------------
# Turn off the tibble visualisation
options("restore_SingleCellExperiment_show" = TRUE)
pbmc_small_tidy

## -----------------------------------------------------------------------------
# Turn on the tibble visualisation
options("restore_SingleCellExperiment_show" = FALSE)

## -----------------------------------------------------------------------------
pbmc_small_tidy$file[1:5]

## -----------------------------------------------------------------------------
# Create sample column
pbmc_small_polished <-
    pbmc_small_tidy %>%
    extract(file, "sample", "../data/([a-z0-9]+)/outs.+", remove=FALSE)

# Reorder to have sample column up front
pbmc_small_polished %>%
    select(sample, everything())

## -----------------------------------------------------------------------------
# Use colourblind-friendly colours
friendly_cols <- dittoSeq::dittoColors()

# Set theme
custom_theme <- list(
    scale_fill_manual(values=friendly_cols),
    scale_color_manual(values=friendly_cols),
    theme_bw() + theme(
        aspect.ratio=1,
        legend.position="bottom",
        axis.line=element_line(),
        text=element_text(size=12),
        panel.border=element_blank(),
        strip.background=element_blank(),
        panel.grid.major=element_line(linewidth=0.2),
        panel.grid.minor=element_line(linewidth=0.1),
        axis.title.x=element_text(margin=margin(t=10, r=10, b=10, l=10)),
        axis.title.y=element_text(margin=margin(t=10, r=10, b=10, l=10))))

## ----plot1--------------------------------------------------------------------
pbmc_small_polished %>%
    ggplot(aes(nFeature_RNA, fill=groups)) +
    geom_histogram() +
    custom_theme

## ----plot2--------------------------------------------------------------------
pbmc_small_polished %>%
    ggplot(aes(groups, nCount_RNA, fill=groups)) +
    geom_boxplot(outlier.shape=NA) +
    geom_jitter(width=0.1) +
    custom_theme

## -----------------------------------------------------------------------------
pbmc_small_polished %>%
    join_features(features=c("HLA-DRA", "LYZ"), shape="long") %>%
    ggplot(aes(groups, .abundance_counts + 1, fill=groups)) +
    geom_boxplot(outlier.shape=NA) +
    geom_jitter(aes(size=nCount_RNA), alpha=0.5, width=0.2) +
    scale_y_log10() +
    custom_theme

## ----preprocess---------------------------------------------------------------
# Identify variable genes with scran
variable_genes <-
    pbmc_small_polished %>%
    modelGeneVar() %>%
    getTopHVGs(prop=0.1)

# Perform PCA with scater
pbmc_small_pca <-
    pbmc_small_polished %>%
    runPCA(subset_row=variable_genes)

pbmc_small_pca

## ----pc_plot------------------------------------------------------------------
# Create pairs plot with 'GGally'
pbmc_small_pca %>%
    as_tibble() %>%
    select(contains("PC"), everything()) %>%
    GGally::ggpairs(columns=1:5, aes(colour=groups)) +
    custom_theme

## ----cluster------------------------------------------------------------------
pbmc_small_cluster <- pbmc_small_pca

# Assign clusters to the 'colLabels'
# of the 'SingleCellExperiment' object
colLabels(pbmc_small_cluster) <-
    pbmc_small_pca %>%
    buildSNNGraph(use.dimred="PCA") %>%
    igraph::cluster_walktrap() %$%
    membership %>%
    as.factor()

# Reorder columns
pbmc_small_cluster %>%
    select(label, everything())

## ----cluster count------------------------------------------------------------
# Count number of cells for each cluster per group
pbmc_small_cluster %>%
    count(groups, label)

## -----------------------------------------------------------------------------
# Identify top 10 markers per cluster
marker_genes <-
    pbmc_small_cluster %>%
    findMarkers(groups=pbmc_small_cluster$label) %>%
    as.list() %>%
    map(~ .x %>%
        head(10) %>%
        rownames()) %>%
    unlist() %>%
    unique()

# Plot heatmap
pbmc_small_cluster %>%
    join_features(features=marker_genes, shape="long") %>%
    group_by(label) %>%
    heatmap(
        .row=.feature, .column=.cell, 
        .value=.abundance_counts, scale="column")

## -----------------------------------------------------------------------------
# Create two subsets of the data
pbmc_subset1 <- pbmc_small_cluster %>%
    filter(groups == "g1")

pbmc_subset2 <- pbmc_small_cluster %>%
    filter(groups == "g2")

# Combine them using append_samples
combined_data <- append_samples(pbmc_subset1, pbmc_subset2)
combined_data

## ----umap---------------------------------------------------------------------
pbmc_small_UMAP <-
    pbmc_small_cluster %>%
    runUMAP(ncomponents=3)

## ----umap plot, eval=FALSE----------------------------------------------------
# pbmc_small_UMAP %>%
#     plot_ly(
#         x=~`UMAP1`,
#         y=~`UMAP2`,
#         z=~`UMAP3`,
#         color=~label,
#         colors=friendly_cols[1:4])

## ----eval=FALSE---------------------------------------------------------------
# # Get cell type reference data
# blueprint <- celldex::BlueprintEncodeData()
# 
# # Infer cell identities
# cell_type_df <-
#     logcounts(pbmc_small_UMAP) %>%
#     Matrix::Matrix(sparse = TRUE) %>%
#     SingleR::SingleR(
#         ref=blueprint,
#         labels=blueprint$label.main,
#         method="single") %>%
#     as.data.frame() %>%
#     as_tibble(rownames="cell") %>%
#     select(cell, first.labels)

## -----------------------------------------------------------------------------
# Join UMAP and cell type info
data(cell_type_df)
pbmc_small_cell_type <-
    pbmc_small_UMAP %>%
    left_join(cell_type_df, by="cell")

# Reorder columns
pbmc_small_cell_type %>%
    select(cell, first.labels, everything())

## -----------------------------------------------------------------------------
# Count number of cells for each cell type per cluster
pbmc_small_cell_type %>%
    count(label, first.labels)

## -----------------------------------------------------------------------------
pbmc_small_cell_type %>%
    # Reshape and add classifier column
    pivot_longer(
        cols=c(label, first.labels),
        names_to="classifier", values_to="label") %>%
    # UMAP plots for cell type and cluster
    ggplot(aes(UMAP1, UMAP2, color=label)) +
    facet_wrap(~classifier) +
    geom_point() +
    custom_theme

## -----------------------------------------------------------------------------
pbmc_small_cell_type %>%
    # Add some mitochondrial abundance values
    mutate(mitochondrial=rnorm(dplyr::n())) %>%
    # Plot correlation
    join_features(features=c("CST3", "LYZ"), shape="wide") %>%
    ggplot(aes(CST3+1, LYZ+1, color=groups, size=mitochondrial)) +
    facet_wrap(~first.labels, scales="free") +
    geom_point() +
    scale_x_log10() +
    scale_y_log10() +
    custom_theme

## -----------------------------------------------------------------------------
pbmc_small_nested <-
    pbmc_small_cell_type %>%
    filter(first.labels != "Erythrocytes") %>%
    mutate(cell_class=if_else(
        first.labels %in% c("Macrophages", "Monocytes"),
        true="myeloid", false="lymphoid")) %>%
    nest(data=-cell_class)

pbmc_small_nested

## ----warning=FALSE------------------------------------------------------------
pbmc_small_nested_reanalysed <-
    pbmc_small_nested %>%
    mutate(data=map(data, ~ {
        # feature selection
        variable_genes <- .x %>%
            modelGeneVar() %>%
            getTopHVGs(prop=0.3)
        # dimension reduction
        .x <- .x %>%
            runPCA(subset_row=variable_genes) %>%
            runUMAP(ncomponents=3)
        # clustering
        colLabels(.x) <- .x %>%
            buildSNNGraph(use.dimred="PCA") %>%
            cluster_walktrap() %$%
            membership %>%
            as.factor()
        return(.x)
    }))
pbmc_small_nested_reanalysed

## -----------------------------------------------------------------------------
pbmc_small_nested_reanalysed %>%
    # Convert to 'tibble', else 'SingleCellExperiment'
    # drops reduced dimensions when unifying data sets.
    mutate(data=map(data, ~as_tibble(.x))) %>%
    unnest(data) %>%
    # Define unique clusters
    unite("cluster", c(cell_class, label), remove=FALSE) %>%
    # Plotting
    ggplot(aes(UMAP1, UMAP2, color=cluster)) +
    facet_wrap(~cell_class) +
    geom_point() +
    custom_theme

## ----eval=FALSE---------------------------------------------------------------
# pbmc_small_nested_interactions <-
#     pbmc_small_nested_reanalysed %>%
#     # Unnest based on cell category
#     unnest(data) %>%
#     # Create unambiguous clusters
#     mutate(integrated_clusters=first.labels %>% as.factor() %>% as.integer()) %>%
#     # Nest based on sample
#     nest(data=-sample) %>%
#     mutate(interactions=map(data, ~ {
#         # Produce variables. Yuck!
#         cluster <- colData(.x)$integrated_clusters
#         data <- data.frame(assay(.x) %>% as.matrix())
#         # Ligand/Receptor analysis using 'SingleCellSignalR'
#         data %>%
#             cell_signaling(genes=rownames(data), cluster=cluster) %>%
#             inter_network(data=data, signal=., genes=rownames(data), cluster=cluster) %$%
#             `individual-networks` %>%
#             map_dfr(~ append_samples(as_tibble(.x)))
#     }))
# 
# pbmc_small_nested_interactions %>%
#     select(-data) %>%
#     unnest(interactions)

## -----------------------------------------------------------------------------
data(pbmc_small_nested_interactions)
pbmc_small_nested_interactions

## -----------------------------------------------------------------------------
pbmc_small_tidy %>%
  aggregate_cells(groups, assays="counts")

## -----------------------------------------------------------------------------
sessionInfo()

