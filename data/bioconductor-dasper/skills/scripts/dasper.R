# Code example from 'dasper' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    crop = NULL ## Related to https://stat.ethz.ch/pipermail/bioc-devel/2020-April/016656.html
)

## ----vignetteSetup, echo=FALSE, message=FALSE, warning = FALSE----------------
## Track time spent on making the vignette
startTime <- Sys.time()

## Bib setup
library("knitcitations")

## Load knitcitations with a clean bibliography
cleanbib()
cite_options(hyperlink = "to.doc", citation_format = "text", style = "html")

## Write bibliography information
bib <- c(
    R = citation(),
    BiocStyle = citation("BiocStyle")[1],
    knitcitations = citation("knitcitations")[1],
    knitr = citation("knitr")[1],
    rmarkdown = citation("rmarkdown")[1],
    sessioninfo = citation("sessioninfo")[1],
    testthat = citation("testthat")[1],
    dasper = citation("dasper")[1]
)

write.bibtex(bib, file = "dasper.bib")

## ----"install", eval = FALSE--------------------------------------------------
#  if (!requireNamespace("BiocManager", quietly = TRUE)) {
#      install.packages("BiocManager")
#  }
#  
#  BiocManager::install("dzhang32/dasper")
#  
#  ## Check that you have a valid Bioconductor installation
#  BiocManager::valid()

## ----"citation"---------------------------------------------------------------
## Citation info
citation("dasper")

## ----"dasper workflow", echo = FALSE------------------------------------------
knitr::include_graphics("dasper_workflow.png")

## ----"install megadepth"------------------------------------------------------
megadepth::install_megadepth()

## ----"load ref", warning = FALSE----------------------------------------------

# use GenomicState to load txdb (GENCODE v31)
ref <- GenomicState::GenomicStateHub(version = "31", genome = "hg38", filetype = "TxDb")[[1]]

## ----"DL bws"-----------------------------------------------------------------

# Obtain the urls to the remotely hosted GTEx BigWig files
url <- recount::download_study(
    project = "SRP012682",
    type = "samples",
    download = FALSE
)

# cache the file using BiocFileCache for faster retrieval
bw_path <- dasper:::.file_cache(url[1])

## ----"junctions_example"------------------------------------------------------
library(dasper)

junctions_example

## ----"dasper quick start", eval = FALSE---------------------------------------
#  
#  library(magrittr)
#  
#  outlier_scores <-
#      junction_process(junctions_example, ref) %>%
#      coverage_process(ref,
#          coverage_paths_case = rep(bw_path, 2),
#          coverage_paths_control = rep(bw_path, 3),
#          bp_param = BiocParallel::MulticoreParam(5)
#      ) %>%
#      outlier_process(bp_param = BiocParallel::MulticoreParam(5))

## ----"junction_load"----------------------------------------------------------

junctions_example_1_path <-
    system.file(
        "extdata",
        "junctions_example_1.txt",
        package = "dasper",
        mustWork = TRUE
    )
junctions_example_2_path <-
    system.file(
        "extdata",
        "junctions_example_2.txt",
        package = "dasper",
        mustWork = TRUE
    )

# only keep chromosomes 21 + 22 for speed
junctions <-
    junction_load(
        junction_paths = c(
            junctions_example_1_path,
            junctions_example_2_path
        ),
        controls = "fibroblasts",
        chrs = c("chr21", "chr22")
    )

junctions

## ----"junction_annot"---------------------------------------------------------

# take only the first 5 samples (2 cases, 3 controls)
# to increase the speed of the vignette
junctions <- junctions[, 1:5]

junctions <- junction_annot(junctions, ref)

head(SummarizedExperiment::rowData(junctions))

## ----"junction_filter"--------------------------------------------------------

junctions <- junction_filter(junctions,
    count_thresh = c(raw = 5),
    n_samp = c(raw = 1)
)

junctions

## ----"junction_norm"----------------------------------------------------------

junctions <- junction_norm(junctions)

# save a separate object for plotting
junctions_normed <- junctions

# show the raw counts
tail(SummarizedExperiment::assays(junctions)[["raw"]])

# and those after normalisation
tail(SummarizedExperiment::assays(junctions)[["norm"]])

## ----"junction_score"---------------------------------------------------------
junctions <- junction_score(junctions)

names(SummarizedExperiment::assays(junctions))

## ----"coverage_norm"----------------------------------------------------------
coverage <- coverage_norm(
    junctions,
    ref,
    coverage_paths_case = rep(bw_path, 2),
    coverage_paths_control = rep(bw_path, 3),
    bp_param = BiocParallel::SerialParam()
)

## ---- "coverage_score"--------------------------------------------------------
junctions <- coverage_score(junctions, coverage)

names(SummarizedExperiment::assays(junctions))

## ---- "outlier_detect"--------------------------------------------------------
junctions <- outlier_detect(
    junctions,
    bp_param = BiocParallel::SerialParam(),
    random_state = 32L
)

names(SummarizedExperiment::assays(junctions))

## ---- "outlier_aggregate"-----------------------------------------------------
outlier_scores <- outlier_aggregate(junctions, samp_id_col = "samp_id", )

head(outlier_scores)

## ---- "sashimi_1"-------------------------------------------------------------

# take gene_id of the cluster ranked 1
gene_id <- unlist(outlier_scores[["gene_id_cluster"]][1])

plot_sashimi(
    junctions_normed,
    ref,
    case_id = list(samp_id = "samp_1"),
    gene_tx_id = gene_id,
    count_label = FALSE
)

## ---- "sashimi_2"-------------------------------------------------------------
plot_sashimi(junctions_normed,
    ref,
    case_id = list(samp_id = "samp_1"),
    gene_tx_id = gene_id,
    region = GenomicRanges::GRanges("chr22:42620000-42630000"),
    count_label = TRUE
)

## ----createVignette, eval=FALSE-----------------------------------------------
#  ## Create the vignette
#  library("rmarkdown")
#  system.time(render("dasper.Rmd", "BiocStyle::html_document"))
#  
#  ## Extract the R code
#  library("knitr")
#  knit("dasper.Rmd", tangle = TRUE)

## ----createVignette2----------------------------------------------------------
## Clean up
file.remove("dasper.bib")

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

## ----vignetteBiblio, results = "asis", echo = FALSE, warning = FALSE, message = FALSE---------------------------------
## Print bibliography
knitcitations::bibliography()

