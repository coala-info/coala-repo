# Code example from 'advanced' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    crop = NULL
    ## cf https://stat.ethz.ch/pipermail/bioc-devel/2020-April/016656.html
)

## ----message = FALSE----------------------------------------------------------
library(scp)
data("scp1")
scp1

## -----------------------------------------------------------------------------
normByType <- function(x, type) {
    ## Check argument
    stopifnot(length(type) == ncol(x))
    ## Normalize for each type separately
    for (i in unique(type)) {
        ## Get normalization factor
        nf <- rowMedians(x[, type == i], na.rm = TRUE)
        ## Perform normalization
        x[, type == i] <- x[, type == i] / nf
    }
    ## Return normalized data
    x
}

## -----------------------------------------------------------------------------
sce <- getWithColData(scp1, "proteins")
sce

## -----------------------------------------------------------------------------
mnorm <- normByType(assay(sce), type = sce$SampleType)
assay(sce) <- mnorm

## -----------------------------------------------------------------------------
scp1 <- addAssay(scp1, sce, name = "proteinsNorm")
scp1 <- addAssayLinkOneToOne(scp1, from = "proteins", to = "proteinsNorm")
scp1

## ----eval = FALSE-------------------------------------------------------------
# scp1[["proteins"]] <- sce

## -----------------------------------------------------------------------------
validObject(scp1)

## -----------------------------------------------------------------------------
m <- assay(scp1, "proteins")
meanExprs <- colMeans(m, na.rm = TRUE)
meanExprs

## -----------------------------------------------------------------------------
colData(scp1)[names(meanExprs), "meanProtExprs"] <- meanExprs

## -----------------------------------------------------------------------------
hist(log2(scp1$meanProtExprs))

## -----------------------------------------------------------------------------
validObject(scp1)

## -----------------------------------------------------------------------------
## Initialize the List object that will store the computed values
res <- List()
## We compute the metric for the first 3 assays
for (i in 1:3) {
    ## We get the quantitative values for the current assay
    m <- assay(scp1[[i]])
    ## We compute the number of samples in which each features is detected
    n <- rowSums(!is.na(m) & m != 0)
    ## We store the result as a DataFrame in the List
    res[[i]] <- DataFrame(nbSamples = n)
}
names(res) <- names(scp1)[1:3]
res
res[[1]]

## -----------------------------------------------------------------------------
rowData(scp1) <- res

## -----------------------------------------------------------------------------
library("ggplot2")
rd <- rbindRowData(scp1, i = 1:3)
ggplot(data.frame(rd)) +
    aes(x = nbSamples) +
    geom_histogram(bins = 16) +
    facet_wrap(~ assay)

## -----------------------------------------------------------------------------
validObject(scp1)

## -----------------------------------------------------------------------------
computeNbDetectedSamples <- function(object, i) {
    res <- List()
    for (ii in i) {
        m <- assay(object[[ii]])
        n <- rowSums(!is.na(m) & m != 0)
        res[[ii]] <- DataFrame(nbSamples = n)
    }
    names(res) <- names(object)[i]
    rowData(object) <- res
    stopifnot(validObject(object))
    object
}

## -----------------------------------------------------------------------------
scp1 <- computeNbDetectedSamples(scp1, i = 1:3)

## ----setup2, include = FALSE--------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "",
    crop = NULL
)

## ----sessioninfo, echo=FALSE--------------------------------------------------
sessionInfo()

