# Code example from 'example_brca_logistic' vignette. See references/ for full tutorial.

params <-
list(seed = 29221)

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
library(MultiAssayExperiment)
library(TCGAutils)
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

## ----curated_data, include=FALSE, results="hide", message=FALSE, warning=FALSE----
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

## ----data.show, warning=FALSE, error=FALSE, eval=!is.null(brca)---------------
brca <- TCGAutils::TCGAsplitAssays(brca, c("01", "11"))
xdataRaw <- t(cbind(assay(brca[[1]]), assay(brca[[2]])))

# Get matches between survival and assay data
classV <- TCGAbiospec(rownames(xdataRaw))$sample_definition |> factor()
names(classV) <- rownames(xdataRaw)

# keep features with standard deviation > 0
xdataRaw <- xdataRaw[, apply(xdataRaw, 2, sd) != 0] |>
    scale()

set.seed(params$seed)
smallSubset <- c(
    "CD5", "CSF2RB", "HSF1", "IRGC", "LRRC37A6P", "NEUROG2",
    "NLRC4", "PDE11A", "PIK3CB", "QARS", "RPGRIP1L", "SDC1",
    "TMEM31", "YME1L1", "ZBTB11",
    sample(colnames(xdataRaw), 100)
)

xdata <- xdataRaw[, smallSubset[smallSubset %in% colnames(xdataRaw)]]
ydata <- classV

## ----fit.show, eval=!is.null(brca)--------------------------------------------
fitted <- cv.glmHub(xdata, ydata,
    family = "binomial",
    network = "correlation",
    nlambda = 1000,
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
    ensembl.id = names(coefsCV),
    gene.name = geneNames(names(coefsCV))$external_gene_name,
    coefficient = coefsCV,
    stringsAsFactors = FALSE
) |>
    arrange(gene.name) |>
    knitr::kable()

## ----accuracy, echo=FALSE, eval=!is.null(brca)--------------------------------
resp <- predict(fitted, s = "lambda.min", newx = xdata, type = "class")
flog.info("Misclassified (%d)", sum(ydata != resp))
flog.info(
    "  * False primary solid tumour: %d",
    sum(resp != ydata & resp == "Primary Solid Tumor")
)
flog.info(
    "  * False normal              : %d",
    sum(resp != ydata & resp == "Solid Tissue Normal")
)

## ----predict, echo=FALSE, warning=FALSE, eval=!is.null(brca)------------------
response <- predict(fitted, s = "lambda.min", newx = xdata, type = "response")
qplot(response, bins = 100)

## ----roc, echo=FALSE, eval=!is.null(brca)-------------------------------------
rocObj <- pROC::roc(ydata, as.vector(response))

data.frame(TPR = rocObj$sensitivities, FPR = 1 - rocObj$specificities) |>
    ggplot() +
    geom_line(aes(FPR, TPR), color = 2, size = 1, alpha = 0.7) +
    labs(
        title = sprintf("ROC curve (AUC = %f)", pROC::auc(rocObj)),
        x = "False Positive Rate (1-Specificity)",
        y = "True Positive Rate (Sensitivity)"
    )

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

