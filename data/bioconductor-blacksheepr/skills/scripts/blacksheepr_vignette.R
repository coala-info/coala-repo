# Code example from 'blacksheepr_vignette' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----install package, eval=FALSE----------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("blacksheepr")

## ----library call-------------------------------------------------------------
library(blacksheepr)

## ----countdata example--------------------------------------------------------
data("sample_phosphodata")
sample_phosphodata[1:5,1:5]

## ----annotation example-------------------------------------------------------
data("sample_annotationdata")
sample_annotationdata[1:5,]

## ----read in data - phospho, echo = TRUE--------------------------------------
data(sample_annotationdata)
comptable <- sample_annotationdata
comptable[1:5,]
dim(comptable)

## -----------------------------------------------------------------------------
data(sample_phosphodata)
phosphotable <- sample_phosphodata
phosphotable[1:5,1:5]
dim(phosphotable)

## ----summarized experiment----------------------------------------------------
suppressPackageStartupMessages(library(SummarizedExperiment))

blacksheep_SE <- SummarizedExperiment(
    assays=list(counts=as.matrix(phosphotable)), 
    colData=DataFrame(comptable))
blacksheep_SE

## ----deva, fig.keep="none"----------------------------------------------------
deva_out <- deva(se = blacksheep_SE, 
    analyze_negative_outliers = FALSE, aggregate_features = TRUE, 
    feature_delineator = "-", fraction_samples_cutoff = 0.3, 
    fdrcutoffvalue = 0.1)

## -----------------------------------------------------------------------------
names(deva_out)

## -----------------------------------------------------------------------------
names(deva_out$pos_outlier_analysis)

## -----------------------------------------------------------------------------
names(deva_out$significant_pos_heatmaps)

## -----------------------------------------------------------------------------
deva_results(deva_out)

## -----------------------------------------------------------------------------
subanalysis_Her2 <- deva_results(deva_out, ID = "Her2", type = "table")
head(subanalysis_Her2)

## -----------------------------------------------------------------------------
subanalysis_Her2 <- deva_results(deva_out, ID = "Her2", type = "table")
head(subanalysis_Her2)

## ----fig.width = 8, fig.height = 8--------------------------------------------
subanalysis_Her2_HM <- deva_results(deva_out, ID = "Her2", type = "heatmap")
subanalysis_Her2_HM

## ----eval = FALSE-------------------------------------------------------------
# ## NOT RUN
# ## To output separately to pdf
# pdf("outfile.pdf")
# draw(subanalysis_Her2_HM)
# dev.off()

## ----groupings - phospho------------------------------------------------------
groupings <- comparison_groupings(comptable)
## Print out the first 6 samples in each of our first 5 groupings
lapply(groupings, head)[1:5]

## ----make outlier table - phospho---------------------------------------------
## Perform the function
reftable_function_out <- make_outlier_table(phosphotable,
                                        analyze_negative_outliers = FALSE)
## See the names of the outputted objects
names(reftable_function_out)
## Assign them to individual variables
outliertab <- reftable_function_out$outliertab
upperboundtab <- reftable_function_out$upperboundtab
sampmedtab <- reftable_function_out$sampmedtab

## Note we will only use the outlier table - which looks like this now
outliertab[1:5,1:5]

## ----groupingtablist - phospho------------------------------------------------
count_outliers_out <- count_outliers(groupings, outliertab, 
                        aggregate_features = TRUE, feature_delineator = "-")
grouptablist <- count_outliers_out$grouptablist
aggoutliertab <- count_outliers_out$aggoutliertab
fractiontab <- count_outliers_out$fractiontab

names(grouptablist)

## -----------------------------------------------------------------------------
names(grouptablist$PAM50_Her2__Her2)

## -----------------------------------------------------------------------------
head(grouptablist$PAM50_Her2__Her2$feature_counts)

## -----------------------------------------------------------------------------
grouptablist$PAM50_Her2__Her2$samples

## ----outlier analysis - phospho-----------------------------------------------
outlier_analysis_out <- outlier_analysis(grouptablist = grouptablist,
                                        fraction_table = fractiontab,
                                        fraction_samples_cutoff = 0.3)
names(outlier_analysis_out)
head(outlier_analysis_out$
        outlieranalysis_for_PAM50_Her2__Her2_vs_PAM50_Her2__not_Her2)

## ----heatmap plotting - phospho, fig.keep="none"------------------------------
plottable <- comptable[do.call(order, c(decreasing = TRUE, 
                            data.frame(comptable[,1:ncol(comptable)]))),]
hm1 <- outlier_heatmap(outlier_analysis_out = outlier_analysis_out, 
                counttab = fractiontab, metatable = plottable, 
                fdrcutoffvalue = 0.1)

## To output heatmap to pdf outside of the function
#pdf(paste0(outfilepath, "test_hm1.pdf"))
#hm1
#junk<-dev.off()

## ----hm, fig.width = 8, fig.height = 8, fig.cap = "Example outputted Heatmap"----
hm1$print_outlieranalysis_for_PAM50_Her2__Her2_vs_PAM50_Her2__not_Her2

## ----format annotation data2 - phospho----------------------------------------
dummyannotations <- data.frame(comp1 = c(1,1,2,2,3,3), 
                    comp2 = c("red", "blue", "red", "blue", "green", "green"), 
                    row.names = paste0("sample", seq_len(6)))
dummyannotations
## Use the make_comparison_columns function to create binary columns
expanded_dummyannotations <- make_comparison_columns(dummyannotations)
expanded_dummyannotations

## ----normalize count data - phospho-------------------------------------------
library(pasilla)
pasCts <- system.file("extdata", "pasilla_gene_counts.tsv", package="pasilla")
cts <- as.matrix(read.csv(pasCts,sep="\t",row.names="gene_id"))
norm_cts <- deva_normalization(cts, method = "MoR-log")

