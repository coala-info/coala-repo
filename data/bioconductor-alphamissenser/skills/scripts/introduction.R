# Code example from 'introduction' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----install, eval = FALSE----------------------------------------------------
# if (!"BiocManager" %in% rownames(installed.packages()))
#     install.packages("BiocManager", repos = "https://cran.r-project.org")

## ----install-Bioconductor, eval = FALSE---------------------------------------
# if (BiocManager::version() >= "3.19") {
#     BiocManager::install("AlphaMissenseR")
# } else {
#     stop(
#         "'AlphaMissenseR' requires Bioconductor version 3.19 or later, ",
#         "install from GitHub?"
#     )
# }

## ----install-devel, eval = FALSE----------------------------------------------
# remotes::install_github(
#     "mtmorgan/AlphaMissenseR",
#     repos = BiocManager::repositories()
# )

## ----setup, message = FALSE---------------------------------------------------
library(AlphaMissenseR)

## ----am_browse, eval = FALSE--------------------------------------------------
# am_browse()

## ----am_available-------------------------------------------------------------
am_available()

## ----am_data------------------------------------------------------------------
tbl <- am_data("hg38")
tbl

## ----db_connect---------------------------------------------------------------
db <- db_connect()

## ----am_data-duckdb-----------------------------------------------------------
db_tables(db)

tbl <- tbl(db, "hg38")
tbl

## ----db-am_class--------------------------------------------------------------
tbl |>
    count(am_class)

## ----db-pathogenicity---------------------------------------------------------
tbl |>
    group_by(am_class) |>
    summarize(n = n(), pathogenecity = mean(am_pathogenicity, na.rm = TRUE))

## ----REF-ALT------------------------------------------------------------------
tbl |>
    count(REF, ALT) |>
    tidyr::pivot_wider(names_from = "ALT", values_from = "n") |>
    select("REF", "A", "C", "G", "T") |>
    arrange(REF)

## -----------------------------------------------------------------------------
tbl |>
    filter(CHROM == "chr4", POS > 0, POS <= 200000)

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("GenomicRanges", quietly = TRUE))
#     BiocManager::install("GenomicRanges")

## -----------------------------------------------------------------------------
tbl <-
    am_data("hg38") |>
    filter(CHROM == "chr2", POS < 10000000, REF == "G")

## -----------------------------------------------------------------------------
gpos <-
    tbl |>
    to_GPos()
gpos

## ----eval = FALSE-------------------------------------------------------------
# utils::browseVignettes("GenomicRanges")

## ----ahub-homo-sap------------------------------------------------------------
hub <- AnnotationHub::AnnotationHub()
AnnotationHub::query(hub, c("EnsDb", "Homo sapiens"))

AnnotationHub::AnnotationHub()["AH113665"]

## ----AnnotationHub, message = FALSE-------------------------------------------
library(ensembldb)
edb <- AnnotationHub::AnnotationHub()[["AH113665"]]
edb

## ----db_rw--------------------------------------------------------------------
db_rw <- db_connect(read_only = FALSE)

## ----tx-----------------------------------------------------------------------
bcl2l11 <-
    edb |>
    ensembldb::filter(
        ~ symbol == "BCL2L11" &
            tx_biotype == "protein_coding" &
            tx_is_canonical == TRUE
    ) |>
    exonsBy("tx")
bcl2l11

## ----temp-table---------------------------------------------------------------
bcl2l11_tbl <-
    bcl2l11 |>
    dplyr::as_tibble() |>
    dplyr::mutate(CHROM = paste0("chr", seqnames)) |>
    dplyr::select(CHROM, everything(), -seqnames)

db_temporary_table(db_rw, bcl2l11_tbl, "bcl2l11")

## ----db_tables-rw-------------------------------------------------------------
"bcl2l11" %in% db_tables(db_rw)

## ----range-join---------------------------------------------------------------
rng <- db_range_join(db_rw, "hg38", "bcl2l11", "bcl2l11_overlaps")
rng

## -----------------------------------------------------------------------------
rng |>
    dplyr::count(exon_id, am_class) |>
    tidyr::pivot_wider(names_from = "am_class", values_from = "n")

## ----db_disconnect-rw---------------------------------------------------------
db_disconnect(db_rw)

## ----filter-variants----------------------------------------------------------
variants_of_interest <-
    am_data("hg38") |>
    dplyr::filter(transcript_id %like% "ENST00000393256%")

## ----gpos---------------------------------------------------------------------
gpos <-
    variants_of_interest |>
    to_GPos()
## make gpos 'genome' and 'seqlevels' like bcl2l11
Seqinfo::genome(gpos) <- "GRCh38"
GenomeInfoDb::seqlevelsStyle(gpos) <- "Ensembl"
gpos

## ----countOverlaps------------------------------------------------------------
countOverlaps(unlist(bcl2l11), gpos)

## ----db_disconnect_all--------------------------------------------------------
db_disconnect_all()

## -----------------------------------------------------------------------------
sessionInfo()

