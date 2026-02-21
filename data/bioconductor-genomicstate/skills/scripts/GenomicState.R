# Code example from 'GenomicState' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----vignetteSetup, echo=FALSE, message=FALSE, warning = FALSE----------------
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
    Seqinfo = citation("Seqinfo")[1],
    knitr = citation("knitr")[3],
    GenomicState = citation("GenomicState")[1],
    RefManageR = citation("RefManageR")[1],
    rmarkdown = citation("rmarkdown")[1],
    rtracklayer = citation("rtracklayer")[1],
    sessioninfo = citation("sessioninfo")[1],
    testthat = citation("testthat")[1],
    GenomicFeatures = citation("GenomicFeatures")[1],
    bumphunter = citation("bumphunter")[1],
    derfinder = citation("derfinder")[1],
    AnnotationDbi = citation("AnnotationDbi")[1],
    IRanges = citation("IRanges")[1],
    org.Hs.eg.db = citation("org.Hs.eg.db")[1],
    glue = citation("glue")[1],
    AnnotationHub = citation("AnnotationHub")[1],
    AnnotationHubData = citation("AnnotationHubData")[1],
    GenomicRanges = citation("GenomicRanges")[1],
	txdbmaker = citation("txdbmaker")[1]
)

## ----'install', eval = FALSE--------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#     install.packages("BiocManager")
# }
# 
# BiocManager::install("GenomicState")
# 
# ## Check that you have a valid Bioconductor installation
# BiocManager::valid()

## ----'citation'---------------------------------------------------------------
## Citation info
citation("GenomicState")

## ----setup, message = FALSE, warning = FALSE----------------------------------
library("GenomicState")

## ----'annotation_hub'---------------------------------------------------------
## Query AnnotationHub for the GenomicState object for Gencode v31 on
## hg19 coordinates
hub_query_gs_gencode_v31_hg19 <- GenomicStateHub(
    version = "31",
    genome = "hg19",
    filetype = "GenomicState"
)
hub_query_gs_gencode_v31_hg19


## Check the metadata
mcols(hub_query_gs_gencode_v31_hg19)

## Access the file through AnnotationHub
if (length(hub_query_gs_gencode_v31_hg19) == 1) {
    hub_gs_gencode_v31_hg19 <- hub_query_gs_gencode_v31_hg19[[1]]

    hub_gs_gencode_v31_hg19
}

## ----'build_ex_objects'-------------------------------------------------------
## Load the example TxDb object
## or start from scratch with:
## txdb_v31_hg19_chr21 <- gencode_txdb(version = '31', genome = 'hg19',
##     chrs = 'chr21')
txdb_v31_hg19_chr21 <- AnnotationDbi::loadDb(
    system.file("extdata", "txdb_v31_hg19_chr21.sqlite",
        package = "GenomicState"
    )
)

## Build the GenomicState and annotated genes
genes_v31_hg19_chr21 <- gencode_annotated_genes(txdb_v31_hg19_chr21)
gs_v31_hg19_chr21 <- gencode_genomic_state(txdb_v31_hg19_chr21)

## ----'obtain_annotation_hub'--------------------------------------------------
## Create the AnnotationHub object once and re-use it to speed up things
ah <- AnnotationHub::AnnotationHub()

## Find the TxDb object for hg19 Gencode version 31
hub_query_txdb_gencode_v31_hg19 <- GenomicStateHub(
    version = "31",
    genome = "hg19",
    filetype = "TxDb", ah = ah
)
hub_query_txdb_gencode_v31_hg19

## Now the Annotated Genes for hg19 Gencode v31
hub_query_genes_gencode_v31_hg19 <- GenomicStateHub(
    version = "31",
    genome = "hg19",
    filetype = "AnnotatedGenes", ah = ah
)
hub_query_genes_gencode_v31_hg19

## And finally the GenomicState for hg19 Gencode v31
hub_query_gs_gencode_v31_hg19 <- GenomicStateHub(
    version = "31",
    genome = "hg19",
    filetype = "GenomicState", ah = ah
)
hub_query_gs_gencode_v31_hg19

## If you want to access the files use the double bracket AnnotationHub syntax
## to retrieve the R objects from the web.
if (FALSE) {
    hub_txdb_gencode_v31_hg19 <- hub_query_txdb_gencode_v31_hg19[[1]]
    hub_genes_gencode_v31_hg19 <- hub_query_genes_gencode_v31_hg19[[1]]
    hub_gs_gencode_v31_hg19 <- hub_query_gs_gencode_v31_hg19[[1]]
}

## ----'load_derfinder', messages = FALSE, warnings = FALSE---------------------
## Load external packages
library("derfinder")
library("derfinderPlot")
library("bumphunter")
library("GenomicRanges")

## ----'example_plot_prep'------------------------------------------------------
## Some example regions from derfinder (set the chromosome lengths)
regions <- genomeRegions$regions[1:2]
seqlengths(regions) <- seqlengths(txdb_v31_hg19_chr21)[
    names(seqlengths(regions))
]

## Annotate them
nearestAnnotation <- matchGenes(x = regions, subject = genes_v31_hg19_chr21)
annotatedRegions <- annotateRegions(
    regions = regions,
    genomicState = gs_v31_hg19_chr21$fullGenome, minoverlap = 1
)

## Obtain fullCov object
fullCov <- list("chr21" = genomeDataRaw$coverage)
regionCov <- getRegionCoverage(fullCov = fullCov, regions = regions)

## ----'example_plot'-----------------------------------------------------------
## now make the plot
plotRegionCoverage(
    regions = regions, regionCoverage = regionCov,
    groupInfo = genomeInfo$pop, nearestAnnotation = nearestAnnotation,
    annotatedRegions = annotatedRegions, whichRegions = 1:2,
    txdb = txdb_v31_hg19_chr21, verbose = FALSE
)

## ----'local_metadata'---------------------------------------------------------
## Get the local metadata
meta <- local_metadata()

## Subset to the data of interest, lets say hg19 TxDb for v31
interest <- subset(meta, RDataClass == "TxDb" & Tags == "Gencode:v31:hg19")

## Next you can load the data
if (file.exists(interest$RDataPath)) {
    ## This only works at JHPCE
    eval(parse(text = interest$loadCode))

    ## Explore the loaded object (would be gencode_v31_hg19_txdb in this case)
    gencode_v31_hg19_txdb
}

## ----'build_local', eval = FALSE----------------------------------------------
# outdir <- "gencode"
# dir.create(outdir, showWarnings = FALSE)
# 
# ## Build and save the TxDb object
# gencode_v23_hg19_txdb <- gencode_txdb("23", "hg19")
# saveDb(gencode_v23_hg19_txdb,
#     file = file.path(outdir, "gencode_v23_hg19_txdb.sqlite")
# )
# 
# ## Build and save the annotateTranscripts output
# gencode_v23_hg19_annotated_genes <- gencode_annotated_genes(
#     gencode_v23_hg19_txdb
# )
# save(gencode_v23_hg19_annotated_genes,
#     file = file.path(outdir, "gencode_v23_hg19_annotated_genes.rda")
# )
# 
# ## Build and save the GenomicState
# gencode_v23_hg19_GenomicState <- gencode_genomic_state(
#     gencode_v23_hg19_txdb
# )
# save(gencode_v23_hg19_GenomicState,
#     file = file.path(outdir, "gencode_v23_hg19_GenomicState.rda")
# )

## ----'build_source'-----------------------------------------------------------
## R commands for building the files:
system.file("scripts", "make-data_gencode_human.R",
    package = "GenomicState"
)
## The above file was created by this one:
system.file("scripts", "generate_make_data_gencode_human.R",
    package = "GenomicState"
)

## ----createVignette, eval=FALSE-----------------------------------------------
# ## Create the vignette
# library("rmarkdown")
# system.time(render("GenomicState.Rmd"))
# 
# ## Extract the R code
# library("knitr")
# knit("GenomicState.Rmd", tangle = TRUE)

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

