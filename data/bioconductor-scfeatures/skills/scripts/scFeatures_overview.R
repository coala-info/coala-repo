# Code example from 'scFeatures_overview' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    message = FALSE,
    warning = FALSE
)

## ----eval=TRUE, include=FALSE, paged.print=TRUE-------------------------------
library(S4Vectors)

## -----------------------------------------------------------------------------
library(scFeatures)

## -----------------------------------------------------------------------------
data("example_scrnaseq" , package = "scFeatures")
data <- example_scrnaseq

scfeatures_result <- scFeatures(data = data@assays$RNA@data, sample = data$sample, celltype = data$celltype,
                                feature_types = "gene_mean_celltype"  , 
                                type = "scrna",  
                                ncores = 1,  
                                species = "Homo sapiens")

## -----------------------------------------------------------------------------
 
feature_gene_mean_celltype <- scfeatures_result$gene_mean_celltype

# inspect the first 5 rows and first 5 columns
feature_gene_mean_celltype[1:5, 1:5]

# inspect the dimension of the matrix
dim(feature_gene_mean_celltype)


## ----fig.height=4, fig.width=7------------------------------------------------
library(ClassifyR)

# X is the feature type generated
# y is the condition for classification
X <- feature_gene_mean_celltype
y <- data@meta.data[!duplicated(data$sample), ]
y <- y[match(rownames(X), y$sample), ]$condition

# run the classification model using random forest
result <- ClassifyR::crossValidate(
    X, y,
    classifier = "randomForest", nCores = 2,
    nFolds = 3, nRepeats = 5
)

ClassifyR::performancePlot(results = result)

## ----fig.height=5, fig.width=7------------------------------------------------
library(survival)
library(survminer)
 

X <- feature_gene_mean_celltype
X <- t(X)

# run hierarchical clustering
hclust_res <- hclust(
    as.dist(1 - cor(X, method = "pearson")),
    method = "ward.D2"
)

set.seed(1)
# generate some survival outcome, including the survival days and the censoring outcome
survival_day <- sample(1:100, ncol(X))
censoring <- sample(0:1, ncol(X), replace = TRUE)

cluster_res <- cutree(hclust_res, k = 2)
metadata <- data.frame( cluster = factor(cluster_res),
                        survival_day = survival_day,
                        censoring = censoring)

# plot survival curve
fit <- survfit(
    Surv(survival_day, censoring) ~ cluster,
    data = metadata
)
ggsurv <- ggsurvplot(fit,
    conf.int = FALSE, risk.table = TRUE,
    risk.table.col = "strata", pval = TRUE
)
ggsurv

## -----------------------------------------------------------------------------
# here we use the demo data from the package 
data("scfeatures_result" , package = "scFeatures")

# here we use the current working directory to save the html output
# modify this to save the html file to other directory
output_folder <-  tempdir()

run_association_study_report(scfeatures_result, output_folder )

## ----eval=TRUE----------------------------------------------------------------
sessionInfo()

