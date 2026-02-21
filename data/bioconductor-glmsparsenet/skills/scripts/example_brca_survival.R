# Code example from 'example_brca_survival' vignette. See references/ for full tutorial.

params <-
list(seed = 41)

## ----eval=FALSE---------------------------------------------------------------
# if (!require("BiocManager")) {
#     install.packages("BiocManager")
# }
# BiocManager::install("glmSparseNet")

## ----packages, message=FALSE, warning=FALSE, results='hide'-------------------
library(dplyr)
library(ggplot2)
library(survival)
library(futile.logger)
library(curatedTCGAData)
library(TCGAutils)
library(MultiAssayExperiment)
#
library(glmSparseNet)
#
# Some general options for futile.logger the debugging package
flog.layout(layout.format("[~l] ~m"))
options(
    "glmSparseNet.show_message" = FALSE,
    "glmSparseNet.base_dir" = withr::local_tempdir()
)
# Setting ggplot2 default theme as minimal
theme_set(ggplot2::theme_minimal())

## ----curated_data, include=FALSE----------------------------------------------
# chunk not included as it produces to many unnecessary messages
brca <- tryCatch(
    {
        curatedTCGAData(
            diseaseCode = "BRCA",
            assays = "RNASeq2GeneNorm",
            version = "1.1.38",
            dry.run = FALSE
        )
    },
    error = function(err) {
        NULL
    }
)

## ----curated_data_non_eval, eval=FALSE----------------------------------------
# brca <- curatedTCGAData(
#     diseaseCode = "BRCA", assays = "RNASeq2GeneNorm",
#     version = "1.1.38", dry.run = FALSE
# )

## ----data, warning=FALSE, message=FALSE, eval=!is.null(brca)------------------
# keep only solid tumour (code: 01)
brcaPrimarySolidTumor <- TCGAutils::TCGAsplitAssays(brca, "01")
xdataRaw <- t(assay(brcaPrimarySolidTumor[[1]]))

# Get survival information
ydataRaw <- colData(brcaPrimarySolidTumor) |>
    as.data.frame() |>
    # Keep only data relative to survival or samples
    dplyr::select(
        patientID, vital_status,
        Days.to.date.of.Death, Days.to.Date.of.Last.Contact,
        days_to_death, days_to_last_followup,
        Vital.Status
    ) |>
    # Convert days to integer
    dplyr::mutate(Days.to.date.of.Death = as.integer(Days.to.date.of.Death)) |>
    dplyr::mutate(
        Days.to.Last.Contact = as.integer(Days.to.Date.of.Last.Contact)
    ) |>
    # Find max time between all days (ignoring missings)
    dplyr::rowwise() |>
    dplyr::mutate(
        time = max(days_to_last_followup, Days.to.date.of.Death,
            Days.to.Last.Contact, days_to_death,
            na.rm = TRUE
        )
    ) |>
    # Keep only survival variables and codes
    dplyr::select(patientID, status = vital_status, time) |>
    # Discard individuals with survival time less or equal to 0
    dplyr::filter(!is.na(time) & time > 0) |>
    as.data.frame()

# Set index as the patientID
rownames(ydataRaw) <- ydataRaw$patientID

# Get matches between survival and assay data
xdataRaw <- xdataRaw[
    TCGAbarcode(rownames(xdataRaw)) %in% rownames(ydataRaw),
]
xdataRaw <- xdataRaw[, apply(xdataRaw, 2, sd) != 0] |>
    scale()

# Order ydata the same as assay
ydataRaw <- ydataRaw[TCGAbarcode(rownames(xdataRaw)), ]

# Using only a subset of genes previously selected to keep this short example.
set.seed(params$seed)
smallSubset <- c(
    "CD5", "CSF2RB", "IRGC", "NEUROG2", "NLRC4", "PDE11A",
    "PTEN", "TP53", "BRAF",
    "PIK3CB", "QARS", "RFC3", "RPGRIP1L", "SDC1", "TMEM31",
    "YME1L1", "ZBTB11", sample(colnames(xdataRaw), 100)
) |>
    unique()

xdata <- xdataRaw[, smallSubset[smallSubset %in% colnames(xdataRaw)]]
ydata <- ydataRaw |> dplyr::select(time, status)

## ----fit, eval=!is.null(brca)-------------------------------------------------
set.seed(params$seed)
fitted <- cv.glmHub(xdata, Surv(ydata$time, ydata$status),
    family = "cox",
    lambda = buildLambda(1),
    network = "correlation",
    options = networkOptions(
        cutoff = .6,
        minDegree = .2
    )
)

## ----results, eval=!is.null(brca)---------------------------------------------
plot(fitted)

## ----show_coefs, eval=!is.null(brca)------------------------------------------
coefsCV <- Filter(function(.x) .x != 0, coef(fitted, s = "lambda.min")[, 1])
data.frame(
    gene.name = names(coefsCV),
    coefficient = coefsCV,
    stringsAsFactors = FALSE
) |>
    arrange(gene.name) |>
    knitr::kable()

## ----eval=!is.null(brca)------------------------------------------------------
separate2GroupsCox(as.vector(coefsCV),
    xdata[, names(coefsCV)],
    ydata,
    plotTitle = "Full dataset", legendOutside = FALSE
)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

