# Code example from 'example_prad_survival' vignette. See references/ for full tutorial.

params <-
list(seed = 2924)

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
prad <- tryCatch(
    {
        curatedTCGAData(
            diseaseCode = "PRAD",
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
# prad <- curatedTCGAData(
#     diseaseCode = "PRAD", assays = "RNASeq2GeneNorm",
#     version = "1.1.38", dry.run = FALSE
# )

## ----data.show, warning=FALSE, error=FALSE, eval=!is.null(prad)---------------
# keep only solid tumour (code: 01)
pradPrimarySolidTumor <- TCGAutils::TCGAsplitAssays(prad, "01")
xdataRaw <- t(assay(pradPrimarySolidTumor[[1]]))

# Get survival information
ydataRaw <- colData(pradPrimarySolidTumor) |>
    as.data.frame() |>
    # Find max time between all days (ignoring missings)
    dplyr::rowwise() |>
    dplyr::mutate(
        time = max(days_to_last_followup, days_to_death, na.rm = TRUE)
    ) |>
    # Keep only survival variables and codes
    dplyr::select(patientID, status = vital_status, time) |>
    # Discard individuals with survival time less or equal to 0
    dplyr::filter(!is.na(time) & time > 0) |>
    as.data.frame()

# Set index as the patientID
rownames(ydataRaw) <- ydataRaw$patientID

# keep only features that have standard deviation > 0
xdataRaw <- xdataRaw[
    TCGAbarcode(rownames(xdataRaw)) %in% rownames(ydataRaw),
]
xdataRaw <- xdataRaw[, apply(xdataRaw, 2, sd) != 0] |>
    scale()

# Order ydata the same as assay
ydataRaw <- ydataRaw[TCGAbarcode(rownames(xdataRaw)), ]

set.seed(params$seed)
smallSubset <- c(
    geneNames(c(
        "ENSG00000103091", "ENSG00000064787",
        "ENSG00000119915", "ENSG00000120158",
        "ENSG00000114491", "ENSG00000204176",
        "ENSG00000138399"
    ))$external_gene_name,
    sample(colnames(xdataRaw), 100)
) |>
    unique() |>
    sort()

xdata <- xdataRaw[, smallSubset[smallSubset %in% colnames(xdataRaw)]]
ydata <- ydataRaw |> dplyr::select(time, status)

## ----fit, eval=!is.null(prad)-------------------------------------------------
set.seed(params$seed)
fitted <- cv.glmHub(xdata, Surv(ydata$time, ydata$status),
    family = "cox",
    nlambda = 1000,
    network = "correlation",
    options = networkOptions(
        cutoff = .6,
        minDegree = .2
    )
)

## ----results, eval=!is.null(prad)---------------------------------------------
plot(fitted)

## ----show_coefs, eval=!is.null(prad)------------------------------------------
coefsCV <- Filter(function(.x) .x != 0, coef(fitted, s = "lambda.min")[, 1])
data.frame(
    ensembl.id = names(coefsCV),
    gene.name = geneNames(names(coefsCV))$external_gene_name,
    coefficient = coefsCV,
    stringsAsFactors = FALSE
) |>
    arrange(gene.name) |>
    knitr::kable()

## ----eval=!is.null(prad)------------------------------------------------------
separate2GroupsCox(as.vector(coefsCV),
    xdata[, names(coefsCV)],
    ydata,
    plotTitle = "Full dataset", legendOutside = FALSE
)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

