# Code example from 'MultimodalExperiment' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
library(MultimodalExperiment)

## ----eval = FALSE-------------------------------------------------------------
# BiocManager::install("MultimodalExperiment")

## ----eval = FALSE-------------------------------------------------------------
# BiocManager::install("schifferl/MultimodalExperiment", dependencies = TRUE, build_vignettes = TRUE)

## ----figure-one, echo = FALSE, fig.cap = "MultimodalExperiment Schematic. Normalized experiment, subject, sample, and cell annotations reside in the **Annotations** layer in blue at the top; the **Maps** layer in green in the middle contains the **experimentMap**, which specifies an experiment's type (bulk or single-cell), and the subject, sample, and cell maps which relate annotations to underlying biological data (i.e., experiments); the **Experiments** layer in orange at the bottom separates experiments by type (bulk or single-cell). The figure shows the subsetting of a MultimodalExperiment object: solid lines represent bulk information, and hatched lines represent single-cell information.", fig.wide = TRUE----
knitr::include_graphics("MultimodalExperiment.png")

## -----------------------------------------------------------------------------
pbRNAseq[1:4, 1:1, drop = FALSE]
scRNAseq[1:4, 1:4, drop = FALSE]
scADTseq[1:4, 1:4, drop = FALSE]

## -----------------------------------------------------------------------------
ME <-
    MultimodalExperiment()

## -----------------------------------------------------------------------------
bulkExperiments(ME) <-
    ExperimentList(
        pbRNAseq = pbRNAseq
    )

## -----------------------------------------------------------------------------
singleCellExperiments(ME) <-
    ExperimentList(
        scADTseq = scADTseq,
        scRNAseq = scRNAseq
    )

## -----------------------------------------------------------------------------
subjectMap(ME)[["subject"]] <-
    "SUBJECT-1"

## -----------------------------------------------------------------------------
sampleMap(ME)[["subject"]] <-
    "SUBJECT-1"

## -----------------------------------------------------------------------------
cellMap(ME)[["sample"]] <-
    "SAMPLE-1"

## -----------------------------------------------------------------------------
joinMaps(ME)

## -----------------------------------------------------------------------------
ME <-
    propagate(ME)

## -----------------------------------------------------------------------------
experimentData(ME)[["published"]] <-
    c(NA_character_, "2018-11-19", "2018-11-19") |>
    as.Date()

## -----------------------------------------------------------------------------
subjectData(ME)[["condition"]] <-
    as.character("healthy")

## -----------------------------------------------------------------------------
sampleData(ME)[["sampleType"]] <-
    as.character("peripheral blood mononuclear cells")

## -----------------------------------------------------------------------------
cellType <- function(x) {
    if (x[["CD4"]] > 0L) {
        return("T Cell")
    }

    if (x[["CD14"]] > 0L) {
        return("Monocyte")
    }

    if (x[["CD19"]] > 0L) {
        return("B Cell")
    }

    if (x[["CD56"]] > 0L) {
        return("NK Cell")
    }

    NA_character_
}

## -----------------------------------------------------------------------------
cellData(ME)[["cellType"]] <-
    experiment(ME, "scADTseq") |>
    apply(2L, cellType)

## -----------------------------------------------------------------------------
ME

## -----------------------------------------------------------------------------
isMonocyte <-
    cellData(ME)[["cellType"]] %in% "Monocyte"

## -----------------------------------------------------------------------------
cellData(ME) <-
    cellData(ME)[isMonocyte, , drop = FALSE]

## -----------------------------------------------------------------------------
harmonize(ME)

## -----------------------------------------------------------------------------
sessionInfo()

