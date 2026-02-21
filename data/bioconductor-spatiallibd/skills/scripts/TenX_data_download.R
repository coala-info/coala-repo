# Code example from 'TenX_data_download' vignette. See references/ for full tutorial.

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
library("RefManageR")

## Write bibliography information
bib <- c(
    R = citation(),
    BiocFileCache = citation("BiocFileCache")[1],
    BiocStyle = citation("BiocStyle")[1],
    knitr = citation("knitr")[1],
    lobstr = citation("lobstr")[1],
    RefManageR = citation("RefManageR")[1],
    rmarkdown = citation("rmarkdown")[1],
    rtracklayer = citation("rtracklayer")[1],
    sessioninfo = citation("sessioninfo")[1],
    testthat = citation("testthat")[1],
    SpatialExperiment = citation("SpatialExperiment")[1],
    spatialLIBD = citation("spatialLIBD")[1],
    spatialLIBDpaper = citation("spatialLIBD")[2]
)

## ----"install", eval = FALSE--------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#     install.packages("BiocManager")
# }
# 
# BiocManager::install("spatialLIBD")
# 
# ## Check that you have a valid Bioconductor installation
# BiocManager::valid()

## ----"install_deps", eval = FALSE---------------------------------------------
# BiocManager::install("spatialLIBD", dependencies = TRUE, force = TRUE)

## ----"install_devel", eval = FALSE--------------------------------------------
# BiocManager::install("LieberInstitute/spatialLIBD")

## ----"citation"---------------------------------------------------------------
## Citation info
citation("spatialLIBD")

## ----"start", message=FALSE---------------------------------------------------
## Load packages in the order we'll use them next
library("BiocFileCache")
library("SpatialExperiment")
library("rtracklayer")
library("lobstr")
library("spatialLIBD")

## ----"download_10x_data"------------------------------------------------------
## Download and save a local cache of the data provided by 10x Genomics
bfc <- BiocFileCache::BiocFileCache()
lymph.url <-
    paste0(
        "https://cf.10xgenomics.com/samples/spatial-exp/",
        "1.1.0/V1_Human_Lymph_Node/",
        c(
            "V1_Human_Lymph_Node_filtered_feature_bc_matrix.tar.gz",
            "V1_Human_Lymph_Node_spatial.tar.gz",
            "V1_Human_Lymph_Node_analysis.tar.gz"
        )
    )
lymph.data <- sapply(lymph.url, BiocFileCache::bfcrpath, x = bfc)

## ----"extract_files"----------------------------------------------------------
## Extract the files to a temporary location
## (they'll be deleted once you close your R session)
xx <- sapply(lymph.data, utils::untar, exdir = file.path(tempdir(), "outs"))
## The names are the URLs, which are long and thus too wide to be shown here,
## so we shorten them to only show the file name prior to displaying the
## utils::untar() output status
names(xx) <- basename(names(xx))
xx

## List the files we downloaded and extracted
## These files are typically SpaceRanger outputs
lymph.dirs <- file.path(
    tempdir(), "outs",
    c("filtered_feature_bc_matrix", "spatial", "raw_feature_bc_matrix", "analysis")
)
list.files(lymph.dirs)

## ----"import_to_r"------------------------------------------------------------
## Import the data as a SpatialExperiment object
spe <- SpatialExperiment::read10xVisium(
    samples = tempdir(),
    sample_id = "lymph",
    type = "sparse", data = "filtered",
    images = "lowres", load = TRUE
)
## Inspect the R object we just created: class, memory, and how it looks in
## general
class(spe)
lobstr::obj_size(spe) / 1024^2 ## Convert to MB
spe

## The counts are saved in a sparse matrix R object
class(counts(spe))

## ----"add_key"----------------------------------------------------------------
## Add some information used by spatialLIBD
spe <- add_key(spe)
spe$sum_umi <- colSums(counts(spe))
spe$sum_gene <- colSums(counts(spe) > 0)

## ----"initial_gene_info"------------------------------------------------------
## Initially we don't have much information about the genes
rowRanges(spe)

## ----"use_10x_gtf", eval = FALSE----------------------------------------------
# ## You could:
# ## * download the 11 GB file from
# ## https://cf.10xgenomics.com/supp/cell-exp/refdata-gex-GRCh38-2020-A.tar.gz
# ## * decompress it
# 
# ## Read in the gene information from the annotation GTF file provided by 10x
# gtf <-
#     rtracklayer::import(
#         "/path/to/refdata-gex-GRCh38-2020-A/genes/genes.gtf"
#     )
# 
# ## Subject to genes only
# gtf <- gtf[gtf$type == "gene"]
# 
# ## Set the names to be the gene IDs
# names(gtf) <- gtf$gene_id
# 
# ## Match the genes
# match_genes <- match(rownames(spe), gtf$gene_id)
# 
# ## They should all be present if you are using the correct GTF file from 10x
# stopifnot(all(!is.na(match_genes)))
# 
# ## Keep only some columns from the gtf (you could keep all of them if you want)
# mcols(gtf) <-
#     mcols(gtf)[, c(
#         "source",
#         "type",
#         "gene_id",
#         "gene_version",
#         "gene_name",
#         "gene_type"
#     )]
# 
# ## Add the gene info to our SPE object
# rowRanges(spe) <- gtf[match_genes]
# 
# ## Inspect the gene annotation data we added
# rowRanges(spe)

## ----"use_gencode_gtf"--------------------------------------------------------
## Download the Gencode v32 GTF file and cache it
gtf_cache <- BiocFileCache::bfcrpath(
    bfc,
    paste0(
        "ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/",
        "release_32/gencode.v32.annotation.gtf.gz"
    )
)

## Show the GTF cache location
gtf_cache

## Import into R (takes ~1 min)
gtf <- rtracklayer::import(gtf_cache)

## Subset to genes only
gtf <- gtf[gtf$type == "gene"]

## Remove the .x part of the gene IDs
gtf$gene_id <- gsub("\\..*", "", gtf$gene_id)

## Set the names to be the gene IDs
names(gtf) <- gtf$gene_id

## Match the genes
match_genes <- match(rownames(spe), gtf$gene_id)
table(is.na(match_genes))

## Drop the few genes for which we don't have information
spe <- spe[!is.na(match_genes), ]
match_genes <- match_genes[!is.na(match_genes)]

## Keep only some columns from the gtf
mcols(gtf) <- mcols(gtf)[, c("source", "type", "gene_id", "gene_name", "gene_type")]

## Add the gene info to our SPE object
rowRanges(spe) <- gtf[match_genes]

## Inspect the gene annotation data we added
rowRanges(spe)

## ----"add_gene_info"----------------------------------------------------------
## Add information used by spatialLIBD
rowData(spe)$gene_search <- paste0(
    rowData(spe)$gene_name, "; ", rowData(spe)$gene_id
)

## Compute chrM expression and chrM expression ratio
is_mito <- which(seqnames(spe) == "chrM")
spe$expr_chrM <- colSums(counts(spe)[is_mito, , drop = FALSE])
spe$expr_chrM_ratio <- spe$expr_chrM / spe$sum_umi

## ----"filter_spe"-------------------------------------------------------------
## Remove genes with no data
no_expr <- which(rowSums(counts(spe)) == 0)

## Number of genes with no counts
length(no_expr)

## Compute the percent of genes with no counts
length(no_expr) / nrow(spe) * 100
spe <- spe[-no_expr, , drop = FALSE]

## Remove spots without counts
summary(spe$sum_umi)

## If we had spots with no counts, we would remove them
if (any(spe$sum_umi == 0)) {
    spots_no_counts <- which(spe$sum_umi == 0)
    ## Number of spots with no counts
    print(length(spots_no_counts))
    ## Percent of spots with no counts
    print(length(spots_no_counts) / ncol(spe) * 100)
    spe <- spe[, -spots_no_counts, drop = FALSE]
}

## ----"add_layer"--------------------------------------------------------------
## Add a variable for saving the manual annotations
spe$ManualAnnotation <- "NA"

## ----"check_spe"--------------------------------------------------------------
## Check the final dimensions and object size
dim(spe)
lobstr::obj_size(spe) / 1024^2 ## Convert to MB

## Run check_spe() function
check_spe(spe)

## ----"test_visualizations"----------------------------------------------------
## Example visualizations. Let's start with a continuous variable.
spatialLIBD::vis_gene(
    spe = spe,
    sampleid = "lymph",
    geneid = "sum_umi",
    assayname = "counts"
)

## We next create a random cluster label to visualize
set.seed(20210428)
spe$random_cluster <- sample(1:7, ncol(spe), replace = TRUE)

## Next we visualize that random cluster
spatialLIBD::vis_clus(
    spe = spe,
    sampleid = "lymph",
    clustervar = "random_cluster"
)

## ----"run_shiny_app"----------------------------------------------------------
## Run our shiny app
if (interactive()) {
    run_app(
        spe,
        sce_layer = NULL,
        modeling_results = NULL,
        sig_genes = NULL,
        title = "spatialLIBD: human lymph node by 10x Genomics",
        spe_discrete_vars = c("random_cluster", "ManualAnnotation"),
        spe_continuous_vars = c("sum_umi", "sum_gene", "expr_chrM", "expr_chrM_ratio"),
        default_cluster = "random_cluster"
    )
}

## ----"locate_documentation_files"---------------------------------------------
## Locate our documentation files
docs_path <- system.file("app", "www", package = "spatialLIBD")
docs_path
list.files(docs_path)

## ----wrapper_functions--------------------------------------------------------
## Import the data as a SpatialExperiment object
spe_wrapper <- read10xVisiumWrapper(
    samples = file.path(tempdir(), "outs"),
    sample_id = "lymph",
    type = "sparse", data = "filtered",
    images = c("lowres", "hires", "detected", "aligned"), load = TRUE,
    reference_gtf = gtf_cache
)

## ----"run_shiny_app_wrapper"--------------------------------------------------
## Run our shiny app
if (interactive()) {
    vars <- colnames(colData(spe_wrapper))

    run_app(
        spe_wrapper,
        sce_layer = NULL,
        modeling_results = NULL,
        sig_genes = NULL,
        title = "spatialLIBD: human lymph node by 10x Genomics (made with wrapper)",
        spe_discrete_vars = c(vars[grep("10x_", vars)], "ManualAnnotation"),
        spe_continuous_vars = c("sum_umi", "sum_gene", "expr_chrM", "expr_chrM_ratio"),
        default_cluster = "10x_graphclust"
    )
}

## ----"save_wrapper", eval = FALSE---------------------------------------------
# ## Directory we created to host the data for the web application
# ## Use a directory of your preference instead of copy-pasting this code
# app_dir <- here::here("inst", "spe_wrapper_app")
# dir.create(app_dir, showWarnings = FALSE)
# 
# ## Code we used to save the data
# saveRDS(spe_wrapper, file = file.path(app_dir, "spe_wrapper.rds"))
# 
# ## Copy the contents of system.file("app", "www", package = "spatialLIBD")
# file.copy(system.file("app", "www", package = "spatialLIBD"), app_dir, recursive = TRUE)
# ## Manually edit them to your liking.

## ----spatialLIBD_app_file, echo = FALSE---------------------------------------
cat(paste0(readLines(system.file("spe_wrapper_app", "app.R", package = "spatialLIBD")), "\n"))

## ----spatialLIBD_deploy_file, echo = FALSE------------------------------------
cat(paste0(readLines(system.file("spe_wrapper_app", "deploy.R", package = "spatialLIBD")), "\n"))

## ----"check_mem"--------------------------------------------------------------
lobstr::obj_size(spe) / 1024^2 ## Convert to MB

## ----createVignette, eval=FALSE-----------------------------------------------
# ## Create the vignette
# library("rmarkdown")
# system.time(render("TenX_data_download.Rmd", "BiocStyle::html_document"))
# 
# ## Extract the R code
# library("knitr")
# knit("TenX_data_download.Rmd", tangle = TRUE)

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
PrintBibliography(bib, .opts = list(hyperlink = "to.doc", style = "html"))

