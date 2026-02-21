# Code example from 'phenomis-vignette' vignette. See references/ for full tutorial.

## ----global_options, include=FALSE--------------------------------------------
knitr::opts_chunk$set(fig.width = 5,
                      fig.height = 5)

## ----reading, message = FALSE-------------------------------------------------
library(phenomis)
sacurine.se <- reading(system.file("extdata/sacurine", package = "phenomis"))

## ----inspecting---------------------------------------------------------------
sacurine.se <- inspecting(sacurine.se, report.c = "none")

## ----correcting, fig.dim = c(6, 5)--------------------------------------------
sacurine.se <- correcting(sacurine.se,
                          reference.vc = "pool",
                          report.c = "none")

## ----inspecting_variable_filtering--------------------------------------------
sacurine.se <- inspecting(sacurine.se,
                          figure.c = "none", report.c = "none")

## ----discarding_pool_CV_sup_0.3-----------------------------------------------
sacurine.se <- sacurine.se[rowData(sacurine.se)[, "pool_CV"] <= 0.3, ]

## ----discarding_pools---------------------------------------------------------
sacurine.se <- sacurine.se[, colData(sacurine.se)[, "sampleType"] != "pool"]
print(sacurine.se)

## ----normalizing_osmolality---------------------------------------------------
assay(sacurine.se) <- sweep(assay(sacurine.se),
                            2,
                            colData(sacurine.se)[, "osmolality"],
                            "/")

## ----transforming-------------------------------------------------------------
sacurine.se <- transforming(sacurine.se, method.vc = "log10")


## ----sample_filtering---------------------------------------------------------
sacurine.se <- inspecting(sacurine.se, figure.c = "none", report.c = "none")
sacurine.se <- sacurine.se[, colData(sacurine.se)[, "hotel_pval"] >= 0.001 &
                             colData(sacurine.se)[, "miss_pval"] >= 0.001 &
                             colData(sacurine.se)[, "deci_pval"] >= 0.001]

## ----final_check--------------------------------------------------------------
inspecting(sacurine.se, report.c = "none")

## ----hypotesting, warning=FALSE-----------------------------------------------
sacurine.se <- hypotesting(sacurine.se,
                           test.c = "ttest",
                           factor_names.vc = "gender",
                           adjust.c = "BH",
                           adjust_thresh.n = 0.05,
                           report.c = "none")

## ----PCA----------------------------------------------------------------------
sacurine.se <- ropls::opls(sacurine.se, info.txt = "none")
sacurine.pca <- ropls::getOpls(sacurine.se)[["PCA"]]
ropls::plot(sacurine.pca,
            parAsColFcVn = colData(sacurine.se)[, "gender"],
            typeVc = "x-score")
ropls::plot(sacurine.pca,
            parAsColFcVn = colData(sacurine.se)[, "age"],
            typeVc = "x-score")

## ----heatmap------------------------------------------------------------------
sacurine.se <- clustering(sacurine.se,
                          clusters.vi = c(5, 3))

## ----plsda--------------------------------------------------------------------
sacurine.se <- ropls::opls(sacurine.se, "gender")

## ----plsda_scoreplot, eval = FALSE--------------------------------------------
# sacurine_gender.plsda <- ropls::getOpls(sacurine.se)[["gender_PLSDA"]]
# ropls::plot(sacurine_gender.plsda,
#             parAsColFcVn = colData(sacurine.se)[, "gender"],
#             typeVc = "x-score")

## ----biosigner, fig.width = 5, fig.height = 5---------------------------------
sacurine.biosign <- biosigner::biosign(sacurine.se, "gender", bootI = 5)

## ----annotating_parameters----------------------------------------------------
annotating_parameters()

## ----chebi_annotation, eval = FALSE-------------------------------------------
# sacurine.se <- annotating(sacurine.se,
#                           database.c = "chebi",
#                           param.ls = list(query.type = "mz",
#                                           query.col = "mass_to_charge",
#                                           ms.mode = "neg",
#                                           mz.tol = 10,
#                                           mz.tol.unit = "ppm",
#                                           max.results = 3,
#                                           prefix = "chebiMZ."),
#                           report.c = "none")
# knitr::kable(head(rowData(sacurine.se)[, grep("chebiMZ",
#                                               colnames(rowData(sacurine.se)))]))

## ----chebi_identifier, eval = FALSE-------------------------------------------
# sacurine.se <- annotating(sacurine.se, database.c = "chebi",
#                           param.ls = list(query.type = "chebi.id",
#                                           query.col = "database_identifier",
#                                           prefix = "chebiID."))
# knitr::kable(head(rowData(sacurine.se)[, grep("chebiID",
#                                               colnames(rowData(sacurine.se)))]))
# 

## ----localdbDF----------------------------------------------------------------
msdbDF <- read.table(system.file("extdata/local_ms_db.tsv", package = "phenomis"),
                     header = TRUE,
                     sep = "\t",
                     stringsAsFactors = FALSE)

## ----localms_annotation, message=FALSE, warning=FALSE-------------------------
sacurine.se <- annotating(sacurine.se,
                          database.c = "local.ms",
                          param.ls = list(query.type = "mz",
                                          query.col = "mass_to_charge",
                                          ms.mode = "neg",
                                          mz.tol = 5,
                                          mz.tol.unit = "ppm",
                                          local.ms.db = msdbDF,
                                          prefix = "localMS."),
                          report.c = "none")
knitr::kable(rowData(sacurine.se)[!is.na(rowData(sacurine.se)[, "localMS.accession"]), grep("localMS.", colnames(rowData(sacurine.se)), fixed = TRUE)])

## ----writing, eval = FALSE----------------------------------------------------
# writing(sacurine.se, dir.c = getwd(), prefix.c = "sacurine")

## ----pms_read-----------------------------------------------------------------
prometis.mae <- reading(system.file("extdata/prometis",
                                    package = "phenomis"))

## -----------------------------------------------------------------------------
head(colData(prometis.mae))

## ----pms_inspect--------------------------------------------------------------
prometis.mae <- inspecting(prometis.mae, report.c = "none")

## ----pms_limma----------------------------------------------------------------
prometis.mae <- hypotesting(prometis.mae, "limma", "gene",
                            report.c = "none")

## ----pms_plsda----------------------------------------------------------------
prometis.mae <- ropls::opls(prometis.mae, "gene")

## ----pms_biosign, fig.width = 5, fig.height = 5-------------------------------
prometis.mae <- biosigner::biosign(prometis.mae, "gene", bootI = 5)

## ----pms_writing, eval = FALSE------------------------------------------------
# writing(prometis.mae, dir.c = getwd(), prefix.c = "prometis")

## ----cll_load-----------------------------------------------------------------
data(sCLLex, package = "CLL")
cll.eset <- sCLLex[seq_len(1000), ]

## ----cll_inspect, eval = FALSE------------------------------------------------
# cll.eset <- inspecting(cll.eset, report.c = "none")

## ----cll_heatmap, eval = FALSE------------------------------------------------
# Biobase::sampleNames(cll.eset) <- paste0(Biobase::sampleNames(cll.eset),
#                                          "_",
#                                          substr(Biobase::pData(cll.eset)[, "Disease"], 1, 1))
# 
# cll.eset <- clustering(cll.eset)

## ----cll_limma, eval = FALSE--------------------------------------------------
# Biobase::pData(cll.eset)[, "Disease"] <- gsub(".", "",
#                                               Biobase::pData(cll.eset)[, "Disease"],
#                                               fixed = TRUE)
# cll.eset <- hypotesting(cll.eset, "limma", "Disease")

## ----mae----------------------------------------------------------------------
data(NCI60, package = "ropls")
nci.mae <- NCI60[["mae"]]

## ----mae_focus, message=FALSE, warning=FALSE----------------------------------
library(MultiAssayExperiment)
table(nci.mae$cancer)
nci.mae <- nci.mae[,
                   nci.mae$cancer %in% c("LE", "ME"),
                   c("agilent", "hgu95")]

## ----mae_clustering, message=TRUE, warning=TRUE, eval = FALSE-----------------
# nci.mae <- clustering(nci.mae)

## ----mae_hypotesting, eval = FALSE--------------------------------------------
# nci.mae <- hypotesting(nci.mae, "limma", "cancer", report.c = "none")

## ----se_build-----------------------------------------------------------------
# Preparing the data (matrix) and sample and variable metadata (data frames):
data(sacurine, package = "ropls")
data.mn <- sacurine[["dataMatrix"]] # matrix: samples x variables
samp.df <- sacurine[["sampleMetadata"]] # data frame: samples x sample metadata
feat.df <- sacurine[["variableMetadata"]] # data frame: features x feature metadata

# Creating the SummarizedExperiment (package SummarizedExperiment)
library(SummarizedExperiment)
sac.se <- SummarizedExperiment(assays = list(sacurine = t(data.mn)),
                               colData = samp.df,
                               rowData = feat.df)
# note that colData and rowData main format is DataFrame, but data frames are accepted when building the object
stopifnot(validObject(sac.se))

# Viewing the SummarizedExperiment
# ropls::view(sac.se)

## ----mae_build_load-----------------------------------------------------------
data("NCI60_4arrays", package = "omicade4")

## ----mae_build, message = FALSE, warning=FALSE--------------------------------
library(MultiAssayExperiment)
# Building the individual SummarizedExperiment instances
experiment.ls <- list()
sampleMap.ls <- list()
for (set.c in names(NCI60_4arrays)) {
  # Getting the data and metadata
  assay.mn <- as.matrix(NCI60_4arrays[[set.c]])
  coldata.df <- data.frame(row.names = colnames(assay.mn),
                           .id = colnames(assay.mn),
                           stringsAsFactors = FALSE) # the 'cancer' information will be stored in the main colData of the mae, not the individual SummarizedExperiments
  rowdata.df <- data.frame(row.names = rownames(assay.mn),
                           name = rownames(assay.mn),
                           stringsAsFactors = FALSE)
  # Building the SummarizedExperiment
  assay.ls <- list(se = assay.mn)
  names(assay.ls) <- set.c
  se <- SummarizedExperiment(assays = assay.ls,
                             colData = coldata.df,
                             rowData = rowdata.df)
  experiment.ls[[set.c]] <- se
  sampleMap.ls[[set.c]] <- data.frame(primary = colnames(se),
                                      colname = colnames(se)) # both datasets use identical sample names
}
sampleMap <- listToMap(sampleMap.ls)

# The sample metadata are stored in the colData data frame (both datasets have the same samples)
stopifnot(identical(colnames(NCI60_4arrays[[1]]),
                    colnames(NCI60_4arrays[[2]])))
sample_names.vc <- colnames(NCI60_4arrays[[1]])
colData.df <- data.frame(row.names = sample_names.vc,
                         cancer = substr(sample_names.vc, 1, 2))

nci.mae <- MultiAssayExperiment(experiments = experiment.ls,
                                colData = colData.df,
                                sampleMap = sampleMap)

stopifnot(validObject(nci.mae))

## ----eset_build, message = FALSE, warning = FALSE-----------------------------
# Preparing the data (matrix) and sample and variable metadata (data frames):
data(sacurine, package = "ropls")
data.mn <- sacurine[["dataMatrix"]] # matrix: samples x variables
samp.df <- sacurine[["sampleMetadata"]] # data frame: samples x sample metadata
feat.df <- sacurine[["variableMetadata"]] # data frame: features x feature metadata
# Creating the ExpressionSet (package Biobase)
sac.set <- Biobase::ExpressionSet(assayData = t(data.mn))
Biobase::pData(sac.set) <- samp.df
Biobase::fData(sac.set) <- feat.df
stopifnot(validObject(sac.set))
# Viewing the ExpressionSet
# ropls::view(sac.set)

## ----mset_build_load----------------------------------------------------------
data("NCI60_4arrays", package = "omicade4")

## ----mset_build, message = FALSE, warning=FALSE-------------------------------
library(MultiDataSet)
# Creating the MultiDataSet instance
nci.mds <- MultiDataSet::createMultiDataSet()
# Adding the two datasets as ExpressionSet instances
for (set.c in names(NCI60_4arrays)) {
  # Getting the data
  expr.mn <- as.matrix(NCI60_4arrays[[set.c]])
  pdata.df <- data.frame(row.names = colnames(expr.mn),
                        cancer = substr(colnames(expr.mn), 1, 2),
                        stringsAsFactors = FALSE)
  fdata.df <- data.frame(row.names = rownames(expr.mn),
                        name = rownames(expr.mn),
                        stringsAsFactors = FALSE)
  # Building the ExpressionSet
  eset <- Biobase::ExpressionSet(assayData = expr.mn,
                                 phenoData = new("AnnotatedDataFrame",
                                                 data = pdata.df),
                                 featureData = new("AnnotatedDataFrame",
                                                   data = fdata.df),
                                 experimentData = new("MIAME",
                                                      title = set.c))
  # Adding to the MultiDataSet
  nci.mds <- MultiDataSet::add_eset(nci.mds, eset, dataset.type = set.c,
                                     GRanges = NA, warnings = FALSE)
}
stopifnot(validObject(nci.mds))

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

