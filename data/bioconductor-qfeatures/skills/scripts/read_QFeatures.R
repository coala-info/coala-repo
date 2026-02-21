# Code example from 'read_QFeatures' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    crop = NULL
    ## cf to https://stat.ethz.ch/pipermail/bioc-devel/2020-April/016656.html
)

## ----fig.cap="The `QFeatures` data class. The `QFeatures` object contains a list of `SummarizedExperiment` ojects (see [class description](https://bioconductor.org/packages/release/bioc/vignettes/SummarizedExperiment/inst/doc/SummarizedExperiment.html)) on `SingleCellExperiment` and `QFeatures` objects", echo=FALSE, out.width='100%'----
knitr::include_graphics("figs/readQFeatures_class.png")

## ----message=FALSE------------------------------------------------------------
library("QFeatures")

## ----fig.cap="Schematic representation of a data table under the single-set case. Quantification columns (`quantCols`) are represented by different shades of red.", echo=FALSE, out.width='150px'----
knitr::include_graphics("figs/readQFeatures_assayData_single.png")

## ----echo = FALSE, warning=FALSE----------------------------------------------
data("hlpsms")
quantCols <- grep("^X", colnames(hlpsms), value = TRUE)
library(DT)
formatStyle(datatable(hlpsms[, -12]),
            quantCols,
            backgroundColor = "#d35f5f"
) |> 
    formatRound(quantCols, digits = 4)

## ----readQFeatures_singlset---------------------------------------------------
data("hlpsms")
quantCols <- grep("^X", colnames(hlpsms))
(qfSingle <- readQFeatures(hlpsms, quantCols = quantCols))

## -----------------------------------------------------------------------------
(qfSingle <- readQFeatures(hlpsms, quantCols = quantCols, name = "psms"))

## ----fig.cap="Schematic representation of a data table under the multi-set case. Quantification columns (`quantCols`) are coloured by run and shaded by label. Every sample is uniquely represented by a colour and shade. Note that every `quantCol` contains multiple samples.", echo=FALSE, out.width='180px'----
knitr::include_graphics("figs/readQFeatures_assayData_multi.png")

## -----------------------------------------------------------------------------
hlpsms$FileName <- rep(
    rep(paste0("run", 1:3, ".raw"), each = 4), 
    length.out = nrow(hlpsms)
)

## ----echo = FALSE-------------------------------------------------------------
formatStyle(
    datatable(cbind(hlpsms["FileName"], hlpsms[, -ncol(hlpsms)])[, -13]),
    1:11,
    valueColumns = "FileName",
    backgroundColor = styleEqual(
        unique(hlpsms$FileName), c('#d35f5f', "orange", 'yellow')
    )
) |> 
    formatRound(2:11, digits = 4)

## ----readQFeatures_multiset---------------------------------------------------
(qfMulti <- readQFeatures(hlpsms, quantCols = quantCols, runCol = "FileName"))

## ----echo=FALSE, out.width='140px', include=TRUE, fig.cap="`colData` for the single-set case"----
knitr::include_graphics('figs/readQFeatures_colData_single.png')

## -----------------------------------------------------------------------------
(coldata <- DataFrame(
    quantCols = quantCols, 
    condition = rep(c("A", "B"), 5), 
    batch = rep(c("batch1", "batch2"), each = 5)
))

## -----------------------------------------------------------------------------
(qfSingle <- readQFeatures(hlpsms, quantCols = quantCols, colData = coldata))

## -----------------------------------------------------------------------------
(qfSingle <- readQFeatures(hlpsms, colData = coldata))

## -----------------------------------------------------------------------------
colData(qfSingle)

## ----echo=FALSE, out.width='175px', include=TRUE, fig.cap="`colData` for the multi-set case"----
knitr::include_graphics('figs/readQFeatures_colData_multi.png')

## -----------------------------------------------------------------------------
coldataMulti <- DataFrame()
for (run in paste0("run", 1:3, ".raw")) {
    coldataMulti <- rbind(coldataMulti, DataFrame(runCol = run, coldata))
}
coldataMulti

## -----------------------------------------------------------------------------
(qfMulti <- readQFeatures(
    hlpsms, quantCols = quantCols, colData = coldataMulti, 
    runCol = "FileName"
))

## -----------------------------------------------------------------------------
colnames(qfSingle)

## -----------------------------------------------------------------------------
colnames(qfMulti)

## -----------------------------------------------------------------------------
hlpsms$X126 <- NA
(qfNoEmptyCol <- readQFeatures(
    hlpsms, quantCols = quantCols, removeEmptyCols = TRUE
))

## -----------------------------------------------------------------------------
(qfSingle <- readQFeatures(
    hlpsms, quantCols = quantCols, verbose = FALSE
))

## ----echo=FALSE, out.width='200px', include=TRUE,fig.cap="Step1: Convert the input table to a `SingleCellExperiment` object"----
knitr::include_graphics('figs/readQFeatures_step1.png')

## ----echo=FALSE, out.width='240px', fig.cap="Step2: Split by acquisition run"----
knitr::include_graphics('figs/readQFeatures_step2.png')

## ----echo=FALSE, out.width='520px', fig.cap="Step3: Adding and matching the sample annotations"----
knitr::include_graphics('figs/readQFeatures_step3.png')

## ----echo=FALSE, out.width='400px', fig.cap="Step4: Converting to a `QFeatures`"----
knitr::include_graphics('figs/readQFeatures_step4.png')

## ----setup2, include = FALSE--------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "",
    crop = NULL
)

## ----sessioninfo, echo=FALSE--------------------------------------------------
sessionInfo()

