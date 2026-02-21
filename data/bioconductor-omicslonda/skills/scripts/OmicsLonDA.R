# Code example from 'OmicsLonDA' vignette. See references/ for full tutorial.

## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----results='hide',message=FALSE,warning=FALSE--------------------------
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager", repos = "http://cran.us.r-project.org")
BiocManager::install("OmicsLonDA")


## ---- results='hide',message=FALSE,warning=FALSE-------------------------
library(OmicsLonDA)
library(SummarizedExperiment)

## Load 10 simulated features and metadata
data("omicslonda_data_example")

## ------------------------------------------------------------------------
omicslonda_data_example$ome_matrix[1:5, 1:5]

## ------------------------------------------------------------------------
head(omicslonda_data_example$metadata)

## ----message=FALSE,warning=FALSE-----------------------------------------
se_ome_matrix = as.matrix(omicslonda_data_example$ome_matrix)
se_metadata = DataFrame(omicslonda_data_example$metadata)
omicslonda_se_object = SummarizedExperiment(assays=list(se_ome_matrix),
                                            colData = se_metadata)

## ----message=FALSE,warning=FALSE-----------------------------------------
omicslonda_se_object_adjusted = adjustBaseline(se_object = omicslonda_se_object)

## ------------------------------------------------------------------------
assay(omicslonda_se_object_adjusted)[1:5, 1:5]

## ----message=FALSE,warning=FALSE-----------------------------------------
omicslonda_test_object = omicslonda_se_object_adjusted[1,]
visualizeFeature(se_object = omicslonda_test_object, text = "Feature_1",
                 unit = "days", ylabel = "Normalized Count", 
                 col = c("blue", "firebrick"), prefix = tempfile())

## ------------------------------------------------------------------------
points = seq(1, 500, length.out = 500)

## ----results='hide', message=FALSE,warning=FALSE-------------------------
res = omicslonda(se_object = omicslonda_test_object, n.perm = 10,
                 fit.method = "ssgaussian", points = points, text = "Feature_1",
                 parall = FALSE, pvalue.threshold = 0.05, 
                 adjust.method = "BH", time.unit = "days",
                 ylabel = "Normalized Count",
                 col = c("blue", "firebrick"), prefix = tempfile())

## ----message=FALSE,warning=FALSE-----------------------------------------
visualizeFeatureSpline(se_object = omicslonda_test_object, omicslonda_object = res, fit.method = "ssgaussian",
                        text = "Feature_1", unit = "days",
                        ylabel = "Normalized Count", 
                        col = c("blue", "firebrick"),
                        prefix = "OmicsLonDA_example")

## ----results='hide', message=FALSE,warning=FALSE-------------------------
visualizeTestStatHistogram(omicslonda_object = res, text = "Feature_1", 
                                fit.method = "ssgaussian", prefix = tempfile())

## ----message=FALSE,warning=FALSE-----------------------------------------
visualizeArea(omicslonda_object = res, fit.method = "ssgaussian",
              text = "Feature_1", unit = "days", 
              ylabel = "Normalized Count", col =
                c("blue", "firebrick"), prefix = tempfile())

## ----message=FALSE,warning=FALSE-----------------------------------------
prefix = tempfile()
if (!dir.exists(prefix)){
        dir.create(file.path(prefix))
}

## Save OmicsLonDA results in RData file
save(res, file = sprintf("%s/Feature_%s_results_%s.RData",
                        prefix = prefix, text = "Feature_1", 
                        fit.method = "ssgaussian"))



## Save a summary of time intervals statistics in csv file
feature.summary = as.data.frame(do.call(cbind, res$details),
                                stringsAsFactors = FALSE)

write.csv(feature.summary, file = sprintf("%s/Feature_%s_Summary_%s.csv",
                                          prefix = prefix, text = "Feature_1", 
                                          fit.method = "ssgaussian"), row.names = FALSE)

