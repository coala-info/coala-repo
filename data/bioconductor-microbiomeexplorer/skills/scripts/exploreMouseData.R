# Code example from 'exploreMouseData' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----hiddensetup, echo=FALSE, message=FALSE-----------------------------------
library(knitr)
library(rmarkdown)
doctype <- opts_knit$get("rmarkdown.pandoc.to")

## ----setup, echo=TRUE, message = FALSE----------------------------------------

library(microbiomeExplorer)


## ----eval=FALSE,echo=TRUE-----------------------------------------------------
# runMicrobiomeExplorer()

## ----eval=TRUE, echo=TRUE-----------------------------------------------------
data("mouseData", package = "metagenomeSeq")
meData <- filterMEData(mouseData,minpresence = 1, minfeats = 2, minreads = 2)

## ----eval=TRUE, echo=TRUE, warning=FALSE--------------------------------------
makeQCPlot(meData, col_by = "diet",
       log = "none",
       filter_feat = 101,
       filter_read = 511,
       allowWebGL = FALSE)

plotlySampleBarplot(meData,
                    col_by = "diet")

## ----eval=TRUE, echo=TRUE-----------------------------------------------------

meData <- filterMEData(mouseData,minpresence = 1, minfeats = 100, minreads = 500)


## ----eval=TRUE, echo=TRUE-----------------------------------------------------
meData <- normalizeData(meData,norm_method = "Proportion")

## ----eval=TRUE, echo=TRUE-----------------------------------------------------
new_pheno <- interaction(pData(meData)[,c("mouseID","relativeTime")])
mutatedRows <- row.names(pData(meData))
mutatedData <- dplyr::mutate(pData(meData), "mouse_time" = new_pheno)
row.names(mutatedData) <- mutatedRows
meData <- addPhenoData(meData,mutatedData)

## ----eval=TRUE, echo=TRUE-----------------------------------------------------
bufcolnames <- names(fData(meData))
df <- as.data.frame(t(apply(fData(meData),1, rollDownFeatures)))
names(df) <- bufcolnames
meData <- addFeatData(meData,df)

## ----eval=TRUE, echo=TRUE-----------------------------------------------------
aggDat <- aggFeatures(meData, level = "genus")

## ----eval=TRUE, echo=TRUE, warning=FALSE--------------------------------------
plotAbundance(aggDat,
              level = "genus",
              x_var = "diet",
              facet1 = NULL,
              facet2 = NULL,
              ind = 1:10,
              plotTitle = "Top 10 feature percentage at genus level",
              ylab = "Percentage")

## ----eval=TRUE, echo=TRUE-----------------------------------------------------
plotSingleFeature(aggDat,
            x_var = "diet",
            ind = 1:10,
            plotTitle = "Percentage of Enterococcus",
            facet1 = NULL,
            facet2 = NULL,
            feature = "Enterococcus",
            ylab = "Percentage",
            log = TRUE,
            showPoints = TRUE)

## ----eval=TRUE, echo=TRUE-----------------------------------------------------
plotAlpha(aggDat,
          level = "genus",
          index = "shannon",
          x_var = "diet",
          facet1 = NULL,
          facet2 = NULL,
          col_by = "mouseID",
          plotTitle = "Shannon diversity index at genus level")

## ----eval=TRUE, echo=TRUE, message = FALSE, warning = FALSE-------------------
distMat <- computeDistMat(aggDat, "bray")
pcaVals <- calculatePCAs(distMat, 
                         c("PC1", "PC2"))
plotBeta(aggDat,
         dist_method = "bray",
         pcas = pcaVals,
         dim = c("PC1", "PC2"),
         col_by = "diet",
         shape_by = NULL,
         plotTitle = "Bray-Curtis diversity at genus level",
         pt_size = "6",
         plotText = "R2: 0.478; Pr(>F): 0.002",
         confInterval = 0.95,
         allowWebGL = FALSE)


## ----eval=TRUE, echo=TRUE, warning = FALSE, fig.width = 8, fig.height = 10----
plotHeatmap(aggDat,
            features = NULL,
            log = TRUE,
            sort_by = "Variance",
            nfeat = 50,
            col_by = c("diet"),
            row_by = "",
            plotTitle = "Top 50 features sorted by Variance at genus level")

## ----eval=TRUE, echo=TRUE, warning = FALSE, message = FALSE-------------------
cf <- corrFeature(aggDat,
                 feat1 = "Bacteroides",
                 feat2 = "Prevotella",
                 log = TRUE,
                 facet1 = "diet",
                 facet2 = NULL,
                 method = "spearman",
                 plotTitle = "Spearman correlation of Bacteroides vs Prevotella split by diet",
                 col_by = "status",
                 allowWebGL = FALSE)


## ----eval=TRUE, echo=TRUE, warning = FALSE, message = FALSE-------------------
diffResults <- runDiffTest(aggDat,
                        level = "genus",
                        phenotype = "diet",
                        phenolevels = c("BK", "Western"),
                        method = "DESeq2")

kable(head(diffResults))

## ----eval=TRUE, echo=TRUE, warning = FALSE, fig.width = 8, fig.height = 10----
plotLongFeature(aggDat,
                x_var = "date",
                id_var = "mouseID",
                plotTitle = "Abundance of Prevotella",
                feature = "Prevotella",
                ylab = "Reads",
                log = TRUE,
                x_levels = c("2007-12-11","2008-01-21","2008-02-11","2008-02-25"))

