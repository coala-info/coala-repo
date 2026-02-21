# Code example from 'example_brca_protein-protein-interactions_survival' vignette. See references/ for full tutorial.

params <-
list(seed = 20188102)

## ----eval=FALSE---------------------------------------------------------------
# if (!require("BiocManager")) {
#     install.packages("BiocManager")
# }
# BiocManager::install("glmSparseNet")

## ----packages, message=FALSE, warning=FALSE, results='hide'-------------------
library(dplyr)
library(Matrix)
library(ggplot2)
library(forcats)
library(parallel)
library(reshape2)
library(survival)
library(VennDiagram)
library(futile.logger)
library(curatedTCGAData)
library(MultiAssayExperiment)
library(TCGAutils)
#
library(glmSparseNet)
#
#
# Some general options for futile.logger the debugging package
flog.layout(layout.format("[~l] ~m"))
options(
    "glmSparseNet.show_message" = FALSE,
    "glmSparseNet.base_dir" = withr::local_tempdir()
)
# Setting ggplot2 default theme as minimal
theme_set(ggplot2::theme_minimal())

## ----eval=FALSE---------------------------------------------------------------
# # Not evaluated in vignette as it takes too long to download and process
# allInteractions700 <- stringDBhomoSapiens(scoreThreshold = 700)
# stringNetwork <- buildStringNetwork(allInteractions700, "external")

## ----include=FALSE------------------------------------------------------------
data("string.network.700.cache", package = "glmSparseNet")
stringNetwork <- string.network.700.cache

## -----------------------------------------------------------------------------
stringNetworkUndirected <- stringNetwork + Matrix::t(stringNetwork)
stringNetworkUndirected <- (stringNetworkUndirected != 0) * 1

## ----echo=FALSE, collapse=TRUE------------------------------------------------
flog.info("Directed graph (score_threshold = %d)", 700)
flog.info("  *       total edges: %d", sum(stringNetwork != 0))
flog.info("  *    unique protein: %d", nrow(stringNetwork))
flog.info(
    "  * edges per protein: %f",
    sum(stringNetwork != 0) / nrow(stringNetwork)
)
flog.info("")
flog.info("Undirected graph (score_threshold = %d)", 700)
flog.info("  *       total edges: %d", sum(stringNetworkUndirected != 0) / 2)
flog.info("  *    unique protein: %d", nrow(stringNetworkUndirected))
flog.info(
    "  * edges per protein: %f",
    sum(stringNetworkUndirected != 0) / 2 / nrow(stringNetworkUndirected)
)

## ----echo=FALSE---------------------------------------------------------------
stringNetworkBinary <- (stringNetworkUndirected != 0) * 1
degreeNetworkVector <- (
    Matrix::rowSums(stringNetworkBinary) +
        Matrix::colSums(stringNetworkBinary)
) / 2

flog.info("Summary of degree:", summary(degreeNetworkVector), capture = TRUE)

## ----warning=FALSE------------------------------------------------------------
qplot(
    degreeNetworkVector[
        degreeNetworkVector <= quantile(degreeNetworkVector, probs = .99999)
    ],
    geom = "histogram", fill = my.colors(2), bins = 100
) +
    theme(legend.position = "none") + xlab("Degree (up until 99.999% quantile)")

## ----include=FALSE------------------------------------------------------------
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

## ----eval=FALSE---------------------------------------------------------------
# brca <- curatedTCGAData(
#     diseaseCode = "BRCA", assays = "RNASeq2GeneNorm",
#     version = "1.1.38", dry.run = FALSE
# )

## ----data.show, warning=FALSE, error=FALSE, eval=!is.null(brca)---------------
# keep only solid tumour (code: 01)
brcaPrimarySolidTumor <- TCGAutils::TCGAsplitAssays(brca, "01")
xdataRaw <- t(assay(brcaPrimarySolidTumor[[1]]))

# Get survival information
ydataRaw <- colData(brcaPrimarySolidTumor) |>
    as.data.frame() |>
    # Convert days to integer
    dplyr::mutate(
        Days.to.date.of.Death = as.integer(Days.to.date.of.Death),
        Days.to.Last.Contact  = as.integer(Days.to.Date.of.Last.Contact)
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

# keep only features that are in degreeNetworkVector and have
#  standard deviation > 0
validFeatures <- colnames(xdataRaw)[
    colnames(xdataRaw) %in% names(degreeNetworkVector[degreeNetworkVector > 0])
]
xdataRaw <- xdataRaw[
    TCGAbarcode(rownames(xdataRaw)) %in% rownames(ydataRaw), validFeatures
]
xdataRaw <- scale(xdataRaw)

# Order ydata the same as assay
ydataRaw <- ydataRaw[TCGAbarcode(rownames(xdataRaw)), ]

# Using only a subset of genes previously selected to keep this short example.
set.seed(params$seed)
smallSubset <- c(
    "AAK1", "ADRB1", "AK7", "ALK", "APOBEC3F", "ARID1B", "BAMBI",
    "BRAF", "BTG1", "CACNG8", "CASP12", "CD5", "CDA", "CEP72",
    "CPD", "CSF2RB", "CSN3", "DCT", "DLG3", "DLL3", "DPP4",
    "DSG1", "EDA2R", "ERP27", "EXD1", "GABBR2", "GADD45A",
    "GBP1", "HTR1F", "IFNK", "IRF2", "IYD", "KCNJ11", "KRTAP5-6",
    "MAFA", "MAGEB4", "MAP2K6", "MCTS1", "MMP15", "MMP9",
    "NFKBIA", "NLRC4", "NT5C1A", "OPN4", "OR13C5", "OR13C8",
    "OR2T6", "OR4K2", "OR52E6", "OR5D14", "OR5H1", "OR6C4",
    "OR7A17", "OR8J3", "OSBPL1A", "PAK6", "PDE11A", "PELO",
    "PGK1", "PIK3CB", "PMAIP1", "POLR2B", "POP1", "PPFIA3",
    "PSME1", "PSME2", "PTEN", "PTGES3", "QARS", "RABGAP1",
    "RBM3", "RFC3", "RGPD8", "RPGRIP1L", "SAV1", "SDC1", "SDC3",
    "SEC16B", "SFPQ", "SFRP5", "SIPA1L1", "SLC2A14", "SLC6A9",
    "SPATA5L1", "SPINT1", "STAR", "STXBP5", "SUN3", "TACC2",
    "TACR1", "TAGLN2", "THPO", "TNIP1", "TP53", "TRMT2B", "TUBB1",
    "VDAC1", "VSIG8", "WNT3A", "WWOX", "XRCC4", "YME1L1",
    "ZBTB11", "ZSCAN21"
) |>
    sample(size = 50) |>
    sort()

# make sure we have 100 genes
smallSubset <- c(smallSubset, sample(colnames(xdataRaw), 51)) |>
    unique() |>
    sort()

xdata <- xdataRaw[, smallSubset[smallSubset %in% colnames(xdataRaw)]]
ydata <- ydataRaw |>
    dplyr::select(time, status) |>
    dplyr::filter(!is.na(time) | time < 0)

## ----eval=!is.null(brca)------------------------------------------------------
#
# Add degree 0 to genes not in STRING network

myDegree <- degreeNetworkVector[smallSubset]
myString <- stringNetworkBinary[smallSubset, smallSubset]

## ----echo=FALSE, warning=FALSE, eval=!is.null(brca)---------------------------
qplot(myDegree, bins = 100, fill = my.colors(3)) +
    theme(legend.position = "none")

## ----eval=!is.null(brca)------------------------------------------------------
set.seed(params$seed)
foldid <- glmSparseNet:::balancedCvFolds(ydata$status)$output

## ----include=FALSE, eval=!is.null(brca)---------------------------------------
# List that will store all selected genes
selectedGenes <- list()

## ----warning=FALSE, error=FALSE, eval=!is.null(brca)--------------------------
resultCVHub <- cv.glmHub(xdata,
    Surv(ydata$time, ydata$status),
    family = "cox",
    foldid = foldid,
    network = myString,
    network.options = networkOptions(minDegree = 0.2)
)

## ----echo=FALSE, eval=!is.null(brca)------------------------------------------
separate2GroupsCox(
    as.vector(coef(resultCVHub, s = "lambda.min")[, 1]),
    xdata, ydata,
    plot.title = "Full dataset",
    legend.outside = FALSE
)

selectedGenes[["Hub"]] <- Filter(
    function(.x) .x != 0,
    coef(resultCVHub, s = "lambda.min")[, 1]
) |>
    names() |>
    geneNames() |>
    magrittr::extract2("external_gene_name")

## ----warning=FALSE, error=FALSE, eval=!is.null(brca)--------------------------
resultCVOrphan <- cv.glmOrphan(xdata,
    Surv(ydata$time, ydata$status),
    family = "cox",
    foldid = foldid,
    network = myString,
    network.options = networkOptions(minDegree = 0.2)
)

## ----echo=FALSE, eval=!is.null(brca)------------------------------------------
separate2GroupsCox(
    as.vector(coef(resultCVOrphan, s = "lambda.min")[, 1]),
    xdata, ydata,
    plot.title = "Full dataset",
    legend.outside = FALSE
)

selectedGenes[["Orphan"]] <- Filter(
    function(.x) .x != 0,
    coef(resultCVOrphan, s = "lambda.min")[, 1]
) |>
    names() |>
    geneNames() |>
    magrittr::extract2("external_gene_name")

## ----warning=FALSE, error=FALSE, eval=!is.null(brca)--------------------------
library(glmnet)
resultCVGlmnet <- cv.glmnet(xdata,
    Surv(ydata$time, ydata$status),
    family = "cox",
    foldid = foldid
)

## ----echo=FALSE, eval=!is.null(brca)------------------------------------------
separate2GroupsCox(
    as.vector(coef(resultCVGlmnet, s = "lambda.min")[, 1]),
    xdata, ydata,
    plotTitle = "Full dataset",
    legendOutside = FALSE
)

selectedGenes[["GLMnet"]] <- Filter(
    function(.x) .x != 0,
    coef(resultCVGlmnet, s = "lambda.min")[, 1]
) |>
    names() |>
    geneNames() |>
    magrittr::extract2("external_gene_name")

## ----echo=FALSE, warning=FALSE, eval=!is.null(brca)---------------------------
vennPlot <- venn.diagram(
    selectedGenes,
    NULL,
    fill = c(
        myColors(5), myColors(3),
        myColors(4)
    ),
    alpha = c(0.3, 0.3, .3),
    cex = 2,
    cat.fontface = 4,
    category.names = names(selectedGenes)
)
grid.draw(vennPlot)

## ----echo=FALSE, warning=FALSE, eval=!is.null(brca)---------------------------
melt(selectedGenes) |>
    mutate(
        Degree = myDegree[value],
        value = factor(value),
        L1 = factor(L1)
    ) |>
    mutate(value = fct_reorder(value, Degree)) |>
    as.data.frame() |>
    ggplot() +
    geom_point(
        aes(value, L1, size = Degree),
        shape = mySymbols(3), color = myColors(3)
    ) +
    theme(
        axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0),
        legend.position = "top"
    ) +
    ylab("Model") +
    xlab("Gene") +
    scale_size_continuous(trans = "log10")

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

