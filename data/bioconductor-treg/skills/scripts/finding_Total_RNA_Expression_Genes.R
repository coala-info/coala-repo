# Code example from 'finding_Total_RNA_Expression_Genes' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----vignetteSetup, echo=FALSE, message=FALSE, warning = FALSE----------------
## For links
library("BiocStyle")

## Track time spent on making the vignette
startTime <- Sys.time()

# Bib setup
library("RefManageR")

## Write bibliography information
bib <- c(
    R = citation(),
    BiocFileCache = citation("BiocFileCache")[1],
    BiocStyle = citation("BiocStyle")[1],
    dplyr = citation("dplyr")[1],
    ggplot2 = citation("ggplot2")[1],
    knitr = citation("knitr")[1],
    Matrix = citation("Matrix")[1],
    pheatmap = citation("pheatmap")[1],
    purrr = citation("purrr")[1],
    rafalib = citation("rafalib")[1],
    RefManageR = citation("RefManageR")[1],
    rmarkdown = citation("rmarkdown")[1],
    sessioninfo = citation("sessioninfo")[1],
    SummarizedExperiment = citation("SummarizedExperiment")[1],
    testthat = citation("testthat")[1],
    tibble = citation("tibble")[1],
    tidyr = citation("tidyr")[1],
    tran2021 = RefManageR::BibEntry(
        bibtype = "Article",
        key = "tran2021",
        author = "Tran, Matthew N. and Maynard, Kristen R. and Spangler, Abby and Huuki, Louise A. and Montgomery, Kelsey D. and Sadashivaiah, Vijay and Tippani, Madhavi and Barry, Brianna K. and Hancock, Dana B. and Hicks, Stephanie C. and Kleinman, Joel E. and Hyde, Thomas M. and Collado-Torres, Leonardo and Jaffe, Andrew E. and Martinowich, Keri",
        title = "Single-nucleus transcriptome analysis reveals cell-type-specific molecular signatures across reward circuitry in the human brain",
        year = 2021, doi = "10.1016/j.neuron.2021.09.001",
        journal = "Neuron"
    ),
    TREG = citation("TREG")[1],
    TREGpaper = citation("TREG")[2]
)

## ----'install', eval = FALSE--------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#     install.packages("BiocManager")
# }
# 
# BiocManager::install("TREG")
# 
# ## Check that you have a valid Bioconductor installation
# BiocManager::valid()

## ----'citation'---------------------------------------------------------------
## Citation info
citation("TREG")

## ----"load_TREG", message = FALSE, warning = FALSE----------------------------
library("TREG")

## ----"load_packages", message=FALSE, warning=FALSE----------------------------
library("SingleCellExperiment")
library("pheatmap")
library("dplyr")
library("ggplot2")
library("tidyr")
library("tibble")

## ----"download_DLPFC_data"----------------------------------------------------
# Download and save a local cache of the data available at:
# https://github.com/LieberInstitute/10xPilot_snRNAseq-human#processed-data
bfc <- BiocFileCache::BiocFileCache()
url <- paste0(
    "https://libd-snrnaseq-pilot.s3.us-east-2.amazonaws.com/",
    "SCE_DLPFC-n3_tran-etal.rda"
)
local_data <- BiocFileCache::bfcrpath(url, x = bfc)

load(local_data, verbose = TRUE)

## ----"Data Size Check", echo=FALSE--------------------------------------------
## Using 1.01 GB
# lobstr::obj_size(sce.dlpfc.tran)

## ----"acronyms", echo=FALSE---------------------------------------------------
ct_names <- tibble(
    "Cell Type" = c(
        "Astrocyte",
        "Excitatory Neurons",
        "Microglia",
        "Oligodendrocytes",
        "Oligodendrocyte Progenitor Cells",
        "Inhibitory Neurons"
    ),
    "Acronym" = c(
        "Astro",
        "Excit",
        "Micro",
        "Oligo",
        "OPC",
        "Inhib"
    )
)

knitr::kable(ct_names, caption = "Cell type names and corresponding acronyms used in this dataset", label = "acronyms")

## ----"define_cell_types"------------------------------------------------------
## Explore the dimensions and cell type annotations
dim(sce.dlpfc.tran)
table(sce.dlpfc.tran$cellType)

## Use a lower resolution of cell type annotation
sce.dlpfc.tran$cellType.broad <- gsub("_[A-Z]$", "", sce.dlpfc.tran$cellType)
(cell_type_tab <- table(sce.dlpfc.tran$cellType.broad))

## ----"drop_small_cell_types"--------------------------------------------------
## Find cell types with < 50 cells
(ct_drop <- names(cell_type_tab)[cell_type_tab < 50])

## Filter columns of sce object
sce.dlpfc.tran <- sce.dlpfc.tran[, !sce.dlpfc.tran$cellType.broad %in% ct_drop]

## Check new cell type bread down and dimension
table(sce.dlpfc.tran$cellType.broad)

dim(sce.dlpfc.tran)

## ----"examineSparsity", fig.cap = "Heatmap of the snRNA-seq counts. Illustrates sparseness of unfiltered data."----
## this data is 88% sparse
sum(assays(sce.dlpfc.tran)$counts == 0) / (nrow(sce.dlpfc.tran) * ncol(sce.dlpfc.tran))

## lets make a heatmap of the first 1k genes and 500 cells
count_test <- as.matrix(assays(sce.dlpfc.tran)$logcounts[seq_len(1000), seq_len(500)])
pheatmap(count_test,
    cluster_rows = FALSE,
    cluster_cols = FALSE,
    show_rownames = FALSE,
    show_colnames = FALSE
)

## ----"top50_filter"-----------------------------------------------------------
row_means <- rowMeans(assays(sce.dlpfc.tran)$logcounts)
(median_row_means <- median(row_means))

sce.dlpfc.tran <- sce.dlpfc.tran[row_means > median_row_means, ]
dim(sce.dlpfc.tran)

## ----"top50FilterHeatmap", fig.cap = "Heatmap of the snRNA-seq counts. With top 50% filtering the data becomes less sparse."----
## this data down to 77% sparse
sum(assays(sce.dlpfc.tran)$counts == 0) / (nrow(sce.dlpfc.tran) * ncol(sce.dlpfc.tran))

## replot heatmap
count_test <- as.matrix(assays(sce.dlpfc.tran)$logcounts[seq_len(1000), seq_len(500)])
pheatmap::pheatmap(count_test,
    cluster_rows = FALSE,
    cluster_cols = FALSE,
    show_rownames = FALSE,
    show_colnames = FALSE
)

## ----"get_prop_zero"----------------------------------------------------------
# get prop zero for each gene for each cell type
prop_zeros <- get_prop_zero(sce.dlpfc.tran, group_col = "cellType.broad")
head(prop_zeros)

## ----"propZeroDistribution", fig.cap = "Distribution of Proption Zero across cell types and regions."----
# Pivot data longer for plotting
prop_zero_long <- prop_zeros %>%
    rownames_to_column("Gene") %>%
    pivot_longer(!Gene, names_to = "Group", values_to = "prop_zero")

# Plot histograms
(prop_zero_histogram <- ggplot(
    data = prop_zero_long,
    aes(x = prop_zero, fill = Group)
) +
    geom_histogram(binwidth = 0.05) +
    facet_wrap(~Group))

## ----"pickCutoff", fig.cap = "Show Proportion Zero Cutoff on Distributions."----
## Specify a cutoff, here we use 0.9
propZero_limit <- 0.9

## Add a vertical red dashed line where the cutoff is located
prop_zero_histogram +
    geom_vline(xintercept = propZero_limit, color = "red", linetype = "dashed")

## ----"filter_prop_zero"-------------------------------------------------------
## get a list of filtered genes
filtered_genes <- filter_prop_zero(prop_zeros, cutoff = propZero_limit)

## How many genes pass the filter?
length(filtered_genes)

## What % of genes is this
length(filtered_genes) / nrow(sce.dlpfc.tran)

## Filter the sce object
sce.dlpfc.tran <- sce.dlpfc.tran[filtered_genes, ]

## ----"propZeroFilterHeatmap", fig.cap = "Heatmap of the snRNA-seq counts after Proption Zero filtering."----
## this data down to 50% sparse
sum(assays(sce.dlpfc.tran)$counts == 0) / (nrow(sce.dlpfc.tran) * ncol(sce.dlpfc.tran))

## re-plot heatmap
count_test <- as.matrix(assays(sce.dlpfc.tran)$logcounts[seq_len(1000), seq_len(500)])
pheatmap::pheatmap(count_test,
    cluster_rows = FALSE,
    cluster_cols = FALSE,
    show_rownames = FALSE,
    show_colnames = FALSE
)

## ----"rank_invariance_stepwise"-----------------------------------------------
## Get the rank of the gene in each group
group_rank <- rank_group(sce.dlpfc.tran, group_col = "cellType.broad")

## Get the rank of the gene for each cell
cell_rank <- rank_cells(sce.dlpfc.tran, group_col = "cellType.broad")

## Use both rankings to calculate rank_invariance()
rank_invar <- rank_invariance(group_rank, cell_rank)

## The top 5 Candidate TREGs:
head(sort(rank_invar, decreasing = TRUE))

## ----"run_RI_express"---------------------------------------------------------
## rank_invariance_express() runs the previous functions for you
rank_invar2 <- rank_invariance_express(
    sce.dlpfc.tran,
    group_col = "cellType.broad"
)
## Again the top 5 Candidate TREGs:
head(sort(rank_invar2, decreasing = TRUE))

## Check computationally that the results are identical
stopifnot(identical(rank_invar, rank_invar2))

## ----createVignette, eval=FALSE-----------------------------------------------
# ## Create the vignette
# library("rmarkdown")
# system.time(render("finding_Total_RNA_Expression_Genes.Rmd"))
# 
# ## Extract the R code
# library("knitr")
# knit("finding_Total_RNA_Expression_Genes.Rmd", tangle = TRUE)

## ----reproduce1, echo=FALSE---------------------------------------------------
## Date the vignette was generated
Sys.time()

## ----reproduce2, echo=FALSE---------------------------------------------------
## Processing time in seconds
totalTime <- diff(c(startTime, Sys.time()))
round(totalTime, digits = 3)

## ----reproduce3, echo=FALSE-------------------------------------------------------------------------------------------
## Session info
library("sessioninfo")
options(width = 120)
session_info()

## ----vignetteBiblio, results = 'asis', echo = FALSE, warning = FALSE, message = FALSE---------------------------------
## Print bibliography
PrintBibliography(bib, .opts = list(hyperlink = "to.doc", style = "html"))

