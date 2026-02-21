# Code example from 'spatialLIBD' vignette. See references/ for full tutorial.

## ----include = FALSE--------------------------------------------------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----vignetteSetup, echo=FALSE, message=FALSE, warning = FALSE--------------------------------------------------------
## For links
library("BiocStyle")

## Track time spent on making the vignette
startTime <- Sys.time()

## Bib setup
library("RefManageR")

## Write bibliography information
bib <- c(
    R = citation(),
    AnnotationHub = citation("AnnotationHub")[1],
    benchmarkme = citation("benchmarkme")[1],
    BiocFileCache = citation("BiocFileCache")[1],
    BiocGenerics = citation("BiocGenerics")[1],
    BiocStyle = citation("BiocStyle")[1],
    circlize = citation("circlize")[1],
    ComplexHeatmap = citation("ComplexHeatmap")[1],
    cowplot = citation("cowplot")[1],
    DT = citation("DT")[1],
    edgeR = citation("edgeR")[1],
    ExperimentHub = citation("ExperimentHub")[1],
    GenomicRanges = citation("GenomicRanges")[1],
    ggplot2 = citation("ggplot2")[1],
    golem = citation("golem")[1],
    IRanges = citation("IRanges")[1],
    knitr = citation("knitr")[3],
    limma = citation("limma")[1],
    magick = citation("magick")[1],
    Matrix = citation("Matrix")[1],
    paletteer = citation("paletteer")[1],
    plotly = citation("plotly")[1],
    RColorBrewer = citation("RColorBrewer")[1],
    RefManageR = citation("RefManageR")[1],
    rmarkdown = citation("rmarkdown")[1],
    rtracklayer = citation("rtracklayer")[1],
    S4Vectors = citation("S4Vectors")[1],
    scater = citation("scater")[1],
    scuttle = citation("scuttle")[1],
    sessioninfo = citation("sessioninfo")[1],
    SingleCellExperiment = citation("SingleCellExperiment")[1],
    shiny = citation("shiny")[1],
    SpatialExperiment = citation("SpatialExperiment")[1],
    spatialLIBD = citation("spatialLIBD")[1],
    spatialLIBDpaper = citation("spatialLIBD")[2],
    spatialDLPFC = citation("spatialLIBD")[3],
    VisiumSPGAD = citation("spatialLIBD")[4],
    statmod = citation("statmod")[1],
    SummarizedExperiment = citation("SummarizedExperiment")[1],
    testthat = citation("testthat")[1],
    viridisLite = citation("viridisLite")[1]
)

## ----'install', eval = FALSE------------------------------------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#     install.packages("BiocManager")
# }
# 
# BiocManager::install("spatialLIBD")
# 
# ## Check that you have a valid Bioconductor installation
# BiocManager::valid()

## ----"install_deps", eval = FALSE-------------------------------------------------------------------------------------
# BiocManager::install("spatialLIBD", dependencies = TRUE, force = TRUE)

## ----"install_devel", eval = FALSE------------------------------------------------------------------------------------
# BiocManager::install("LieberInstitute/spatialLIBD")

## ----'citation'-------------------------------------------------------------------------------------------------------
## Citation info
citation("spatialLIBD")

## ----setup, message = FALSE, warning = FALSE--------------------------------------------------------------------------
library("spatialLIBD")

## ----'experiment_hub'-------------------------------------------------------------------------------------------------
## Connect to ExperimentHub
ehub <- ExperimentHub::ExperimentHub()

## ----'download_data'--------------------------------------------------------------------------------------------------
## Download the small example sce data
sce <- fetch_data(type = "sce_example", eh = ehub)

## Convert to a SpatialExperiment object
spe <- sce_to_spe(sce)

## If you want to download the full real data (about 2.1 GB in RAM) use:
if (FALSE) {
    if (!exists("spe")) spe <- fetch_data(type = "spe", eh = ehub)
}

## Query ExperimentHub and download the data
if (!exists("sce_layer")) sce_layer <- fetch_data(type = "sce_layer", eh = ehub)
modeling_results <- fetch_data("modeling_results", eh = ehub)

## ----'explore data'---------------------------------------------------------------------------------------------------
## spot-level data
spe

## layer-level data
sce_layer

## list of modeling result tables
sapply(modeling_results, class)
sapply(modeling_results, dim)
sapply(modeling_results, function(x) {
    head(colnames(x))
})

## ----'create_sig_genes'-----------------------------------------------------------------------------------------------
## Convert to a long format the modeling results
## This takes a few seconds to run
system.time(
    sig_genes <-
        sig_genes_extract_all(
            n = nrow(sce_layer),
            modeling_results = modeling_results,
            sce_layer = sce_layer
        )
)

## Explore the result
class(sig_genes)
dim(sig_genes)

## ---------------------------------------------------------------------------------------------------------------------
if (interactive()) {
    run_app(
        spe = spe,
        sce_layer = sce_layer,
        modeling_results = modeling_results,
        sig_genes = sig_genes
    )
}

## ----'vis_clus', fig.small = TRUE-------------------------------------------------------------------------------------
## View our LIBD layers for one sample
vis_clus(
    spe = spe,
    clustervar = "layer_guess_reordered",
    sampleid = "151673",
    colors = libd_layer_colors,
    ... = " LIBD Layers"
)

## ----'vis_clus_variables'---------------------------------------------------------------------------------------------
## This is not fully precise, but gives you a rough idea
## Some integer columns are actually continuous variables
table(sapply(colData(spe), class) %in% c("factor", "integer"))

## This is more precise (one cluster has 28 unique values)
table(sapply(colData(spe), function(x) length(unique(x))) < 29)

## ----'vis_clus_no_spatial', fig.small = TRUE--------------------------------------------------------------------------
## View our LIBD layers for one sample
## without spatial information
vis_clus(
    spe = spe,
    clustervar = "layer_guess_reordered",
    sampleid = "151673",
    colors = libd_layer_colors,
    ... = " LIBD Layers",
    spatial = FALSE
)

## ----'libd_layer_colors'----------------------------------------------------------------------------------------------
## Color palette designed by Lukas M. Weber with feedback from the team.
libd_layer_colors

## ----'vis_gene', fig.small = TRUE-------------------------------------------------------------------------------------
## Available gene expression assays
assayNames(spe)

## Not all of these make sense to visualize
## In particular, the key is not useful to visualize.
colnames(colData(spe))

## Visualize a gene
vis_gene(
    spe = spe,
    sampleid = "151673",
    viridis = FALSE
)

## Visualize the estimated number of cells per spot
vis_gene(
    spe = spe,
    sampleid = "151673",
    geneid = "cell_count"
)

## Visualize the fraction of chrM expression per spot
## without the spatial layer
vis_gene(
    spe = spe,
    sampleid = "151673",
    geneid = "expr_chrM_ratio",
    spatial = FALSE
)

## ----'sig_genes_detail'-----------------------------------------------------------------------------------------------
head(sig_genes)

## ----'layer_boxplot'--------------------------------------------------------------------------------------------------
## Note that we recommend setting the random seed so the jittering of the
## points will be reproducible. Given the requirements by BiocCheck this
## cannot be done inside the layer_boxplot() function.

## Create a boxplot of the first gene in `sig_genes`.
set.seed(20200206)
layer_boxplot(sig_genes = sig_genes, sce_layer = sce_layer)

## Viridis colors displayed in the shiny app
## showing the first pairwise model result
## (which illustrates the background colors used for the layers not
## involved in the pairwise comparison)
set.seed(20200206)
layer_boxplot(
    i = which(sig_genes$model_type == "pairwise")[1],
    sig_genes = sig_genes,
    sce_layer = sce_layer,
    col_low_box = viridisLite::viridis(4)[2],
    col_low_point = viridisLite::viridis(4)[1],
    col_high_box = viridisLite::viridis(4)[3],
    col_high_point = viridisLite::viridis(4)[4]
)

## Paper colors displayed in the shiny app
set.seed(20200206)
layer_boxplot(
    sig_genes = sig_genes,
    sce_layer = sce_layer,
    short_title = FALSE,
    col_low_box = "palegreen3",
    col_low_point = "springgreen2",
    col_high_box = "darkorange2",
    col_high_point = "orange1"
)

## ----'matt_t_stats'---------------------------------------------------------------------------------------------------
## Explore the enrichment t-statistics derived from Tran et al's snRNA-seq
## DLPFC data
dim(tstats_Human_DLPFC_snRNAseq_Nguyen_topLayer)
tstats_Human_DLPFC_snRNAseq_Nguyen_topLayer[seq_len(3), seq_len(6)]

## ----'layer_stat_cor'-------------------------------------------------------------------------------------------------
## Compute the correlation matrix of enrichment t-statistics between our data
## and Tran et al's snRNA-seq data
cor_stats_layer <- layer_stat_cor(
    tstats_Human_DLPFC_snRNAseq_Nguyen_topLayer,
    modeling_results,
    "enrichment"
)

## Explore the correlation matrix
head(cor_stats_layer[, seq_len(3)])

## ----'layer_stat_cor_plot', fig.wide = TRUE---------------------------------------------------------------------------
## Visualize the correlation matrix
layer_stat_cor_plot(cor_stats_layer)

## ----'read_sfari'-----------------------------------------------------------------------------------------------------
## Read in the SFARI gene sets included in the package
asd_sfari <- utils::read.csv(
    system.file(
        "extdata",
        "SFARI-Gene_genes_01-03-2020release_02-04-2020export.csv",
        package = "spatialLIBD"
    ),
    as.is = TRUE
)

## Format them appropriately
asd_sfari_geneList <- list(
    Gene_SFARI_all = asd_sfari$ensembl.id,
    Gene_SFARI_high = asd_sfari$ensembl.id[asd_sfari$gene.score < 3],
    Gene_SFARI_syndromic = asd_sfari$ensembl.id[asd_sfari$syndromic == 1]
)

## ----'sfari_enrichment'-----------------------------------------------------------------------------------------------
## Compute the gene set enrichment results
asd_sfari_enrichment <- gene_set_enrichment(
    gene_list = asd_sfari_geneList,
    modeling_results = modeling_results,
    model_type = "enrichment"
)

## Explore the results
head(asd_sfari_enrichment)

## ----'sfari_enrichment_plot'------------------------------------------------------------------------------------------
## Visualize gene set enrichment results
gene_set_enrichment_plot(
    asd_sfari_enrichment,
    xlabs = gsub(".*_", "", unique(asd_sfari_enrichment$ID)),
    plot_SetSize_bar = TRUE,
    model_colors = get_colors(
        spatialLIBD::libd_layer_colors,
        clusters = unique(asd_sfari_enrichment$test)
    )
)

## ----'run_check_functions'--------------------------------------------------------------------------------------------
check_spe(spe)
check_sce_layer(sce_layer)
## The output here is too long to print
xx <- check_modeling_results(modeling_results)
identical(xx, modeling_results)

## ----createVignette, eval=FALSE---------------------------------------------------------------------------------------
# ## Create the vignette
# library("rmarkdown")
# system.time(render("spatialLIBD.Rmd"))
# 
# ## Extract the R code
# library("knitr")
# knit("spatialLIBD.Rmd", tangle = TRUE)

## ----reproduce1, echo=FALSE-------------------------------------------------------------------------------------------
## Date the vignette was generated
Sys.time()

## ----reproduce2, echo=FALSE-------------------------------------------------------------------------------------------
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

