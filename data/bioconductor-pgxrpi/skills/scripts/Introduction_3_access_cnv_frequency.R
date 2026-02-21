# Code example from 'Introduction_3_access_cnv_frequency' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(pgxRpi)
library(SummarizedExperiment) # for pgxmatrix data
library(GenomicRanges) # for pgxfreq data

## -----------------------------------------------------------------------------
freq_pgxfreq <- pgxLoader(type="cnv_frequency", output ="pgxfreq",
                         filters=c("NCIT:C3058","NCIT:C3493"))

freq_pgxfreq

## -----------------------------------------------------------------------------
freq_pgxfreq[["NCIT:C3058"]]

## -----------------------------------------------------------------------------
mcols(freq_pgxfreq)

## -----------------------------------------------------------------------------
code <-c("C3059","C3716","C4917","C3512","C3493","C3771","C4017","C4001")
# add prefix for query
code <- paste0("NCIT:",code)

## -----------------------------------------------------------------------------
freq_pgxmatrix <- pgxLoader(type="cnv_frequency",output ="pgxmatrix",filters=code)
freq_pgxmatrix

## -----------------------------------------------------------------------------
colData(freq_pgxmatrix)

## -----------------------------------------------------------------------------
head(assay(freq_pgxmatrix,"lowlevel_cnv_frequency"))

## -----------------------------------------------------------------------------
rowRanges(freq_pgxmatrix)

## -----------------------------------------------------------------------------
# access variant data
variants <- pgxLoader(type="g_variants",biosample_id = c("pgxbs-kftvhmz9", "pgxbs-kftvhnqz","pgxbs-kftvhupd"),output="pgxseg")
# only keep segment cnv data
segdata <- variants[variants$variant_type %in% c("DUP","DEL"),]
head(segdata)

## -----------------------------------------------------------------------------
segfreq1 <- segtoFreq(segdata,cnv_column_idx = 6, cohort_name="c1")
segfreq1

## -----------------------------------------------------------------------------
segfreq2 <- segtoFreq(segdata,cnv_column_idx = 9,cohort_name="c1")
segfreq2

## ----fig.width=7, fig.height=5------------------------------------------------
pgxFreqplot(freq_pgxfreq, filters="NCIT:C3058")

## ----fig.width=7, fig.height=5------------------------------------------------
pgxFreqplot(freq_pgxmatrix, filters = "NCIT:C3493")

## ----fig.width=7, fig.height=5------------------------------------------------
pgxFreqplot(freq_pgxfreq, filters='NCIT:C3058',chrom=c(7,9), layout = c(2,1))  

## ----fig.width=6, fig.height=6------------------------------------------------
pgxFreqplot(freq_pgxmatrix,filters= c("NCIT:C3493","NCIT:C3512"),circos = TRUE) 

## ----echo = FALSE-------------------------------------------------------------
sessionInfo()

