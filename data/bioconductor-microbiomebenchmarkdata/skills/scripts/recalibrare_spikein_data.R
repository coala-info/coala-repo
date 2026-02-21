# Code example from 'recalibrare_spikein_data' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----setup, message=FALSE-----------------------------------------------------
library(MicrobiomeBenchmarkData)
library(dplyr)
library(ggplot2)
library(tidyr)

## -----------------------------------------------------------------------------
tse <- getBenchmarkData('Stammler_2016_16S_spikein', dryrun = FALSE)[[1]]
counts <- assay(tse)

## -----------------------------------------------------------------------------
## AF323500XXXX is the unique OTU corresponding to S. ruber
s_ruber <- counts['AF323500XXXX', ]
size_factor <- s_ruber/mean(s_ruber)

SCML_data <- counts 
for(i in seq(ncol(SCML_data))){
    SCML_data[,i] <- round(SCML_data[,i] / size_factor[i])
}

## ----fig.width=7--------------------------------------------------------------

no_cal <- counts |> 
    colSums() |> 
    as.data.frame() |> 
    tibble::rownames_to_column(var = 'sample_id') |> 
    magrittr::set_colnames(c('sample_id', 'colSum')) |> 
    mutate(calibrated = 'no') |> 
    as_tibble()

cal <-  SCML_data |> 
    colSums() |> 
    as.data.frame() |> 
    tibble::rownames_to_column(var = 'sample_id') |> 
    magrittr::set_colnames(c('sample_id', 'colSum')) |> 
    mutate(calibrated = 'yes') |> 
    as_tibble()

data <- bind_rows(no_cal, cal)

data |> 
    ggplot(aes(sample_id, colSum)) + 
    geom_col(aes(fill = calibrated), position = 'dodge') +
    theme_bw() +
    theme(axis.text.x = element_text(angle = 90, hjust = 1))


## -----------------------------------------------------------------------------
assay(tse) <- SCML_data
tse

## -----------------------------------------------------------------------------
tse <- getBenchmarkData('Stammler_2016_16S_spikein', dryrun = FALSE)[[1]]
tse <- scml(tse,bac = "s")

## -----------------------------------------------------------------------------
sessionInfo()

