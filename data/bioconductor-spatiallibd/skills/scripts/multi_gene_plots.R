# Code example from 'multi_gene_plots' vignette. See references/ for full tutorial.

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
    BiocStyle = citation("BiocStyle")[1],
    knitr = citation("knitr")[3],
    MatrixGenerics = citation("MatrixGenerics")[1],
    RColorBrewer = citation("RColorBrewer")[1],
    RefManageR = citation("RefManageR")[1],
    rmarkdown = citation("rmarkdown")[1],
    sessioninfo = citation("sessioninfo")[1],
    SpatialExperiment = citation("SpatialExperiment")[1],
    spatialLIBD = citation("spatialLIBD")[1],
    HumanPilot = citation("spatialLIBD")[2],
    spatialDLPFC = citation("spatialLIBD")[3],
    tran2021 = RefManageR::BibEntry(
        bibtype = "Article",
        key = "tran2021",
        author = "Tran, Matthew N. and Maynard, Kristen R. and Spangler, Abby and Huuki, Louise A. and Montgomery, Kelsey D. and Sadashivaiah, Vijay and Tippani, Madhavi and Barry, Brianna K. and Hancock, Dana B. and Hicks, Stephanie C. and Kleinman, Joel E. and Hyde, Thomas M. and Collado-Torres, Leonardo and Jaffe, Andrew E. and Martinowich, Keri",
        title = "Single-nucleus transcriptome analysis reveals cell-type-specific molecular signatures across reward circuitry in the human brain",
        year = 2021, doi = "10.1016/j.neuron.2021.09.001",
        journal = "Neuron"
    )
)

## ----"setup", message = FALSE, warning = FALSE------------------------------------------------------------------------
library("spatialLIBD")
spe <- fetch_data(type = "spatialDLPFC_Visium_example_subset")
spe

## ----"white_matter_genes"---------------------------------------------------------------------------------------------
white_matter_genes <- c("GFAP", "AQP4", "MBP", "PLP1")
white_matter_genes <- rowData(spe)$gene_search[
    rowData(spe)$gene_name %in% white_matter_genes
]

## Our list of white matter genes
white_matter_genes

## ----"single_gene"----------------------------------------------------------------------------------------------------
vis_gene(
    spe,
    geneid = white_matter_genes[1],
    point_size = 1.5
)

## ----"histology_only"-------------------------------------------------------------------------------------------------
plot(imgRaster(spe))

## ----"GFAP_boxplot"---------------------------------------------------------------------------------------------------
modeling_results <- fetch_data(type = "modeling_results")
sce_layer <- fetch_data(type = "sce_layer")
sig_genes <- sig_genes_extract_all(
    n = 400,
    modeling_results = modeling_results,
    sce_layer = sce_layer
)
i_gfap <- subset(sig_genes, gene == "GFAP" &
    test == "WM")$top
i_gfap
set.seed(20200206)
layer_boxplot(
    i = i_gfap,
    sig_genes = sig_genes,
    sce_layer = sce_layer
)

## ----"multi_gene_z"---------------------------------------------------------------------------------------------------
vis_gene(
    spe,
    geneid = white_matter_genes,
    multi_gene_method = "z_score",
    point_size = 1.5
)

## ----"multi_gene_pca"-------------------------------------------------------------------------------------------------
vis_gene(
    spe,
    geneid = white_matter_genes,
    multi_gene_method = "pca",
    point_size = 1.5
)

## ----"multi_gene_sparsity"--------------------------------------------------------------------------------------------
vis_gene(
    spe,
    geneid = white_matter_genes,
    multi_gene_method = "sparsity",
    point_size = 1.5
)

## ----"multi_gene_z_score_top_enriched"--------------------------------------------------------------------------------
vis_gene(
    spe,
    geneid = subset(sig_genes, test == "WM")$ensembl[seq_len(25)],
    multi_gene_method = "z_score",
    point_size = 1.5
)

vis_gene(
    spe,
    geneid = subset(sig_genes, test == "WM")$ensembl[seq_len(50)],
    multi_gene_method = "z_score",
    point_size = 1.5
)

## ----"multi_gene_pca_top_enriched"------------------------------------------------------------------------------------
vis_gene(
    spe,
    geneid = subset(sig_genes, test == "WM")$ensembl[seq_len(25)],
    multi_gene_method = "pca",
    point_size = 1.5
)

vis_gene(
    spe,
    geneid = subset(sig_genes, test == "WM")$ensembl[seq_len(50)],
    multi_gene_method = "pca",
    point_size = 1.5
)

## ----"multi_gene_sparsity_top_enriched"-------------------------------------------------------------------------------
vis_gene(
    spe,
    geneid = subset(sig_genes, test == "WM")$ensembl[seq_len(25)],
    multi_gene_method = "sparsity",
    point_size = 1.5
)

vis_gene(
    spe,
    geneid = subset(sig_genes, test == "WM")$ensembl[seq_len(50)],
    multi_gene_method = "sparsity",
    point_size = 1.5
)

## ----"colData_example"------------------------------------------------------------------------------------------------
vis_gene(
    spe,
    geneid = c("sum_gene", "sum_umi"),
    multi_gene_method = "z_score",
    point_size = 1.5
)

## ----"colData_plus_gene"----------------------------------------------------------------------------------------------
vis_gene(
    spe,
    geneid = c("broad_tangram_astro"),
    point_size = 1.5
)
vis_gene(
    spe,
    geneid = c("broad_tangram_astro", white_matter_genes[1]),
    multi_gene_method = "pca",
    point_size = 1.5
)

## ----createVignette, eval=FALSE---------------------------------------------------------------------------------------
# ## Create the vignette
# library("rmarkdown")
# system.time(render("multi_gene_plots.Rmd"))
# 
# ## Extract the R code
# library("knitr")
# knit("multi_gene_plots.Rmd", tangle = TRUE)

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

