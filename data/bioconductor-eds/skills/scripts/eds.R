# Code example from 'eds' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
library(tximportData)
library(eds)
dir0 <- system.file("extdata",package="tximportData")
samps <- list.files(file.path(dir0, "alevin"))
dir <- file.path(dir0,"alevin",samps[3],"alevin")
quant.mat.file <- file.path(dir, "quants_mat.gz")
barcode.file <- file.path(dir, "quants_mat_rows.txt")
gene.file <- file.path(dir, "quants_mat_cols.txt")

## -----------------------------------------------------------------------------
cell.names <- readLines(barcode.file)
gene.names <- readLines(gene.file)
num.cells <- length(cell.names)
num.genes <- length(gene.names)

## -----------------------------------------------------------------------------
mat <- readEDS(
    numOfGenes=num.genes,
    numOfOriginalCells=num.cells,
    countMatFilename=quant.mat.file)

## -----------------------------------------------------------------------------
sessionInfo()

