# Code example from 'Introduction_4_process_pgxseg' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(pgxRpi)
library(GenomicRanges) # for pgxfreq object

## -----------------------------------------------------------------------------
# specify the location of the example file
file_name <- system.file("extdata", "example.pgxseg",package = 'pgxRpi')

# extract segment data
seg <- pgxSegprocess(file=file_name,return_seg = TRUE)

## -----------------------------------------------------------------------------
head(seg)

## -----------------------------------------------------------------------------
meta <- pgxSegprocess(file=file_name,return_metadata = TRUE)

## -----------------------------------------------------------------------------
head(meta)

## ----fig.width=7, fig.height=5------------------------------------------------
pgxSegprocess(file=file_name,show_KM_plot = TRUE)

## ----fig.width=7, fig.height=5------------------------------------------------
pgxSegprocess(file=file_name,show_KM_plot = TRUE,group_id = 'histological_diagnosis_id')

## ----fig.width=7, fig.height=5------------------------------------------------
pgxSegprocess(file=file_name,show_KM_plot = TRUE,pval=TRUE,palette='npg')

## -----------------------------------------------------------------------------
# Default is "group_id" in metadata
frequency <- pgxSegprocess(file=file_name,return_frequency = TRUE) 
# Use different ids for grouping
frequency_2 <- pgxSegprocess(file=file_name,return_frequency = TRUE, 
                             group_id ='icdo_morphology_id')
frequency

## -----------------------------------------------------------------------------
head(frequency[["pgx:icdot-C16.9"]])

## -----------------------------------------------------------------------------
mcols(frequency)

## -----------------------------------------------------------------------------
mcols(frequency_2)

## ----fig.width=7, fig.height=5------------------------------------------------
pgxFreqplot(frequency, filters="pgx:icdot-C16.9")

## ----fig.width=7, fig.height=5------------------------------------------------
pgxFreqplot(frequency, filters="pgx:icdot-C16.9",chrom = c(1,8,14), layout = c(3,1))

## ----fig.width=6, fig.height=6------------------------------------------------
pgxFreqplot(frequency, filters=c("pgx:icdot-C16.9","pgx:icdot-C73.9"),circos = TRUE)

## ----fig.width=7, fig.height=5------------------------------------------------
info <- pgxSegprocess(file=file_name,show_KM_plot = TRUE, return_seg = TRUE, 
                      return_metadata = TRUE, return_frequency = TRUE)

## -----------------------------------------------------------------------------
names(info)

## ----echo = FALSE-------------------------------------------------------------
sessionInfo()

