# Code example from 'read_scp' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    crop = NULL
    ## cf to https://stat.ethz.ch/pipermail/bioc-devel/2020-April/016656.html
)

## ----fig.cap="The `scp` framework relies on `SingleCellExperiment` and `QFeatures` objects", echo=FALSE, out.width='100%', fig.align='center'----
knitr::include_graphics("./figures/SCP_framework.png")

## ----message = FALSE----------------------------------------------------------
library(scp)
data("mqScpData")
dim(mqScpData)

## ----echo=FALSE, out.width="450px", fig.cap="Conceptual representation of the `assayData` input table", fig.align = 'center'----
knitr::include_graphics('figures/readSCP_inputTable.png')

## -----------------------------------------------------------------------------
(quantCols <- grep("Reporter.intensity.\\d", colnames(mqScpData),
                  value = TRUE))

## -----------------------------------------------------------------------------
head(mqScpData[, quantCols])

## -----------------------------------------------------------------------------
unique(mqScpData$Raw.file)

## -----------------------------------------------------------------------------
head(mqScpData[, c("Charge", "Score", "PEP", "Sequence", "Length",
                   "Retention.time", "Proteins")])

## -----------------------------------------------------------------------------
data("sampleAnnotation")
head(sampleAnnotation)

## ----echo=FALSE, out.width='450px', fig.cap="Conceptual representation of the sample table", fig.align = 'center'----
knitr::include_graphics('figures/readSCP_sampleTable.png')

## ----readSCP------------------------------------------------------------------
(scp <- readSCP(assayData = mqScpData,
                colData = sampleAnnotation,
                runCol = "Raw.file",
                removeEmptyCols = TRUE))

## ----colData------------------------------------------------------------------
head(colData(scp))

## ----rowData------------------------------------------------------------------
head(rowData(scp[["190222S_LCA9_X_FP94BM"]]))[, 1:5]

## ----assay--------------------------------------------------------------------
head(assay(scp, "190222S_LCA9_X_FP94BM"))

## ----echo=FALSE, out.width='450px', include=TRUE,fig.cap="Step1: Convert the input table to a `SingleCellExperiment` object", fig.align = 'center'----
knitr::include_graphics('figures/readSCP_step1.png')

## ----echo=FALSE, out.width='500px', fig.cap="Step2: Split by acquisition run", fig.align = 'center'----
knitr::include_graphics('figures/readSCP_step2.png')

## ----echo=FALSE, out.width='700px', fig.cap="Step3: Adding and matching the sample annotations", fig.align = 'center'----
knitr::include_graphics('figures/readSCP_step3.png')

## ----echo=FALSE, out.width='600px', fig.cap="Step4: Converting to a `QFeatures`", fig.align = 'center'----
knitr::include_graphics('figures/readSCP_step4.png')

## ----setup2, include = FALSE--------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "",
    crop = NULL
)

## ----sessioninfo, echo=FALSE--------------------------------------------------
sessionInfo()

