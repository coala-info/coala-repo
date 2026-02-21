# Code example from 'ODER_overview' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    crop = NULL
) # Related to https://stat.ethz.ch/pipermail/bioc-devel/2020-April/016656.html

## ----vignetteSetup, echo=FALSE, message=FALSE, warning = FALSE----------------
## Track time spent on making the vignette
startTime <- Sys.time()

## Bib setup
library("RefManageR")

## Write bibliography information
bib <- c(
    R = citation(),
    BiocStyle = citation("BiocStyle")[1],
    knitr = citation("knitr")[1],
    RefManageR = citation("RefManageR")[1],
    rmarkdown = citation("rmarkdown")[1],
    sessioninfo = citation("sessioninfo")[1],
    testthat = citation("testthat")[1],
    ODER = citation("ODER")[1]
)

## ----"install", eval = FALSE--------------------------------------------------
#  if (!requireNamespace("BiocManager", quietly = TRUE)) {
#      install.packages("BiocManager")
#  }
#  
#  BiocManager::install("eolagbaju/ODER")
#  
#  ## Check that you have a valid Bioconductor installation
#  BiocManager::valid()

## ----"citation"---------------------------------------------------------------
## Citation info
citation("ODER")

## ----load_data, eval = requireNamespace('ODER')-------------------------------

library("ODER")
library("magrittr")

# Download recount data in the form of BigWigs
gtex_metadata <- recount::all_metadata("gtex")

gtex_metadata <- gtex_metadata %>%
    as.data.frame() %>%
    dplyr::filter(project == "SRP012682")

url <- recount::download_study(
    project = "SRP012682",
    type = "samples",
    download = FALSE
)

# file_cache is an internal ODER function to cache files for
# faster repeated loading
bw_path <- file_cache(url[1])

bw_path

## ----ODER---------------------------------------------------------------------

# load reference annotation from Ensembl
gtf_url <- paste0(
    "http://ftp.ensembl.org/pub/release-103/gtf/homo_sapiens",
    "/Homo_sapiens.GRCh38.103.chr.gtf.gz"
)
gtf_path <- file_cache(gtf_url)
gtf_gr <- rtracklayer::import(gtf_path)
# As of rtracklayer 1.25.16, BigWig is not supported on Windows.
if (!xfun::is_windows()) {
    opt_ers <- ODER(
        bw_paths = bw_path, auc_raw = gtex_metadata[["auc"]][1],
        auc_target = 40e6 * 100, chrs = c("chr21"),
        genome = "hg38", mccs = c(2, 4, 6, 8, 10), mrgs = c(10, 20, 30),
        gtf = gtf_gr, ucsc_chr = TRUE, ignore.strand = TRUE,
        exons_no_overlap = NULL, bw_chr = "chr"
    )
}

## ----plot_example-------------------------------------------------------------
# visualise the spread of mccs and mrgs
if (!xfun::is_windows()) { # uses product of ODER
    plot_ers(opt_ers[["deltas"]], opt_ers[["opt_mcc_mrg"]])
}

## ----annotatER_example--------------------------------------------------------
library(utils)
# running only chr21 to reduce runtime
chrs_to_keep <- c("21")

# prepare the txdb object to create a genomic state
# based on https://support.bioconductor.org/p/93235/
hg38_chrominfo <- GenomeInfoDb::getChromInfoFromUCSC("hg38")

new_info <- hg38_chrominfo$size[match(
    chrs_to_keep,
    GenomeInfoDb::mapSeqlevels(hg38_chrominfo$chrom, "Ensembl")
)]

names(new_info) <- chrs_to_keep
gtf_gr_tx <- GenomeInfoDb::keepSeqlevels(gtf_gr,
    chrs_to_keep,
    pruning.mode = "tidy"
)

GenomeInfoDb::seqlengths(gtf_gr_tx) <- new_info
GenomeInfoDb::seqlevelsStyle(gtf_gr_tx) <- "UCSC"
GenomeInfoDb::genome(gtf_gr_tx) <- "hg38"

ucsc_txdb <- GenomicFeatures::makeTxDbFromGRanges(gtf_gr_tx)
genom_state <- derfinder::makeGenomicState(txdb = ucsc_txdb)

# convert UCSC chrs format to Ensembl to match the ERs
ens_txdb <- ucsc_txdb
GenomeInfoDb::seqlevelsStyle(ens_txdb) <- "Ensembl"

# lung_junc_21_22 is an example data set of junctions
# obtained from recount3, derived from the lung tissue
# run annotatERs()
data(lung_junc_21_22, package = "ODER")
if (!xfun::is_windows()) { # uses product of ODER
    annot_ers <- annotatERs(
        opt_ers = head(opt_ers[["opt_ers"]], 100),
        junc_data = lung_junc_21_22,
        genom_state = genom_state,
        gtf = gtf_gr,
        txdb = ens_txdb
    )

    # print first 5 ERs
    annot_ers[1:5]
}

## ----refine_ERs_example-------------------------------------------------------
if (!xfun::is_windows()) { # uses product of ODER
    refined_ers <- refine_ERs(annot_ers)

    refined_ers
}

## ----get_count_matrix_example-------------------------------------------------

# create sample metadata containing identifiers for each BigWig
run <- gtex_metadata[["run"]][[1]]
col_info <- as.data.frame(run)

# install megadepth
megadepth::install_megadepth()
if (!xfun::is_windows()) { # uses product of ODER
    er_count_matrix <- get_count_matrix(
        bw_paths = bw_path, annot_ers = annot_ers,
        cols = col_info
    )

    er_count_matrix
}

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

