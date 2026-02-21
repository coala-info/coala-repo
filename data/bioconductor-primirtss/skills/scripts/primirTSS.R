# Code example from 'primirTSS' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("primirTSS")

## ----eval = FALSE-------------------------------------------------------------
# BiocManager::install("ipumin/primirTSS")

## ----Load, message=FALSE------------------------------------------------------
library(primirTSS)

## -----------------------------------------------------------------------------
library(primirTSS)
peak_df <- data.frame(chrom = c("chr1", "chr2", "chr1"),
                       chromStart = c(450, 460, 680),
                       chromEnd = c(470, 480, 710),
                       stringsAsFactors = FALSE)
peak <-  as(peak_df, "GRanges")
peak_merge(peak, n =250)

## -----------------------------------------------------------------------------
peak_df1 <- data.frame(chrom = c("chr1", "chr1", "chr1", "chr2"),
                       start = c(100, 460, 600, 70),
                       end = c(200, 500, 630, 100),
                       stringsAsFactors = FALSE)
peak1 <-  as(peak_df1, "GRanges")

peak_df2 <- data.frame(chrom = c("chr1", "chr1", "chr1", "chr2"),
                       start = c(160, 470, 640, 71),
                       end = c(210, 480, 700, 90),
                       stringsAsFactors = FALSE)
peak2 <-  as(peak_df2, "GRanges")

peak_join(peak1, peak2)

## -----------------------------------------------------------------------------
peakfile <- system.file("testdata", "HMEC_h3.csv", package = "primirTSS")
DHSfile <- system.file("testdata", "HMEC_DHS.csv", package = "primirTSS")
peak_h3 <- read.csv(peakfile, stringsAsFactors = FALSE)
DHS <- read.csv(DHSfile, stringsAsFactors = FALSE)
DHS <- as(DHS, "GRanges")
peak_h3 <-  as(peak_h3, "GRanges")
peak <- peak_merge(peak_h3)

## -----------------------------------------------------------------------------
bed_merged <- data.frame(
                chrom = c("chr1", "chr1", "chr1", "chr1", "chr2"),
                start = c(9910686, 9942202, 9996940, 10032962, 9830615),
                end = c(9911113, 9944469, 9998065, 10035458, 9917994),
                stringsAsFactors = FALSE)
bed_merged <- as(bed_merged, "GRanges")

expressed_mir <- c("hsa-mir-5697")

ownmiRNA <- find_tss(bed_merged, expressed_mir = expressed_mir,
                     ignore_DHS_check = TRUE,
                     expressed_gene = "all",
                     allmirgene_byforce = TRUE,
                     seek_tf = FALSE)

## -----------------------------------------------------------------------------
ownmiRNA$tss_df

## -----------------------------------------------------------------------------
sessionInfo()

