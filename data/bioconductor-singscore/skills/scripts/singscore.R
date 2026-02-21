# Code example from 'singscore' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
citation('singscore')

## ----installationBio, eval=FALSE----------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("singscore")

## ----installationGit, eval=FALSE----------------------------------------------
# 
# # You would need to install 'devtools' package first.
#  install.packages("devtools")
# 
# # And install the 'singscore' package from the GitHub repository
# # 'singscore' requires these packages to be installed: methods, stats, graphics, ggplot2, ggsci, grDevices,
# #  ggrepel, plotly, tidyr, plyr, magrittr, reshape, edgeR, RColorBrewer, Biobase, GSEABase, BiocParallel
#  devtools::install_github('DavisLaboratory/singscore')
# # Set build_vignette = TRUE if would like to browseVignette()

## ----loadDataset, message=FALSE-----------------------------------------------
library(singscore)
library(GSEABase)
# The example expression dataset and gene signatures are included in the package
# distribution, one can directly access them using the variable names

# To see the description of 'tgfb_expr_10_se','tgfb_gs_up','tgfb_gs_dn', look at 
# their help pages using:

# ?tgfb_expr_10_se
# ?tgfb_gs_up
# ?tgfb_gs_dn

# Have a look at the object tgfb_expr_10_se containing gene expression data
# for 10 samples 
tgfb_expr_10_se

# Get the sample names by
colnames(tgfb_expr_10_se)

# View what tgfb_gs_up/dn contains
tgfb_gs_up
tgfb_gs_dn

# Get the size of the gene sets
length(GSEABase::geneIds(tgfb_gs_up))
length(GSEABase::geneIds(tgfb_gs_dn))

## ----simplescoring------------------------------------------------------------
# The recommended method for dealing with ties in ranking is 'min', you can
# change by specifying 'tiesMethod' parameter for rankGenes function.
rankData <- rankGenes(tgfb_expr_10_se)

# Given the ranked data and gene signature, simpleScore returns the scores and 
# dispersions for each sample
scoredf <- simpleScore(rankData, upSet = tgfb_gs_up, downSet = tgfb_gs_dn)
scoredf

# To view more details of the simpleScore, use ?simpleScore
# Note that, when only one gene set is available in a gene signature, one can 
# only input values for the upSet argument. In addition, a knownDirection 
# argument can be set to FALSE if the direction of the gene set is unknown.

# simpleScore(rankData, upSet = tgfb_gs_up, knownDirection = FALSE)

## -----------------------------------------------------------------------------
#get the top 5 stable genes in carcinomas
getStableGenes(5, type = 'carcinoma')

#get the top 5 stable genes in blood
getStableGenes(5, type = 'blood')

#get ensembl IDs instead of gene symbold
getStableGenes(5, type = 'carcinoma', id = 'ensembl')

## -----------------------------------------------------------------------------
#here we specify a custom set of genes (Entrez IDs)
stable_genes <-  c('8315', '9391', '23435', '3190')

#create a dataset with a reduced set of genes (signature genes and stable genes)
measured <-  unique(c(stable_genes, geneIds(tgfb_gs_up), geneIds(tgfb_gs_dn)))
small_tgfb_expr_10 <-  tgfb_expr_10_se[measured, ]
dim(small_tgfb_expr_10)

#rank genes using stable genes
rankData_st <-  rankGenes(small_tgfb_expr_10, stableGenes = stable_genes)
head(rankData_st)

#score samples using stingscore
#simpleScore invoked with the new rank matrix will execute the stingscore
#   algorithm
scoredf_st <- simpleScore(rankData_st, upSet = tgfb_gs_up, downSet = tgfb_gs_dn)
scoredf_st

#plot the two scores against each other
plot(scoredf$TotalScore, scoredf_st$TotalScore)
abline(coef = c(0, 1), lty = 2)

## ----plotdt, fig.height = 4, fig.width = 8------------------------------------
#  You can provide the upSet alone when working with unpaired gene-sets 
# We plot the second sample in rankData, view it by 
head(rankData[,2,drop = FALSE])

plotRankDensity(rankData[,2,drop = FALSE], upSet = tgfb_gs_up, 
                downSet = tgfb_gs_dn, isInteractive = FALSE)

## ----plotds, fig.height = 4, fig.width = 8------------------------------------
#  Get the annotations of samples by their sample names
tgfbAnnot <- data.frame(SampleID = colnames(tgfb_expr_10_se),
                       Type = NA)
tgfbAnnot$Type[grepl("Ctrl", tgfbAnnot$SampleID)] = "Control"
tgfbAnnot$Type[grepl("TGFb", tgfbAnnot$SampleID)] = "TGFb"

# Sample annotations
tgfbAnnot$Type

plotDispersion(scoredf,annot = tgfbAnnot$Type,isInteractive = FALSE)
# To see an interactive version powered by 'plotly', simply set the 
# 'isInteractive' = TRUE, i.e :
#
# plotDispersion(scoredf,annot = tgfbAnnot$Type,isInteractive = TRUE)




## ----loadCCLE,fig.height = 4, fig.width = 8-----------------------------------

plotScoreLandscape(scoredf_ccle_epi, scoredf_ccle_mes, 
                   scorenames = c('ccle-EPI','ccle-MES'),hexMin = 10)


## ----loadTCGA,fig.height = 4, fig.width = 8-----------------------------------

tcgaLandscape <- plotScoreLandscape(scoredf_tcga_epi, scoredf_tcga_mes, 
                   scorenames = c('tcga_EPI','tcga_MES'), isInteractive = FALSE)

tcgaLandscape

# To get an interactive version of plot, set isInteractive = TRUE


## ----projectScore,fig.height = 4, fig.width = 8-------------------------------
# Project on the above generated 'tcgaLandscape' plot
projectScoreLandscape(plotObj = tcgaLandscape, scoredf_ccle_epi, 
                      scoredf_ccle_mes,
                      subSamples = rownames(scoredf_ccle_epi)[c(1,4,5)],
                      annot = rownames(scoredf_ccle_epi)[c(1,4,5)], 
                      sampleLabels = NULL,
                      isInteractive = FALSE)


## ----projectScore2,fig.height = 4, fig.width = 8------------------------------

projectScoreLandscape(plotObj = tcgaLandscape, scoredf_ccle_epi, scoredf_ccle_mes,
                      subSamples = rownames(scoredf_ccle_epi)[c(1,4,5,8,9)],
                      sampleLabels = c('l1','l2','l3','l4','l5'),
                      annot = rownames(scoredf_ccle_epi)[c(1,4,5,8,9)], 
                      isInteractive = FALSE)


## ----pvalue, fig.height = 8, fig.width = 10-----------------------------------

# tgfb_gs_up : up regulated gene set in the tgfb gene signature
# tgfb_gs_dn : down regulated gene set in the tgfb gene signature

# This permutation function uses BiocParallel::bplapply() parallel function, by 
# supplying the first 5 columns of rankData, we generate Null distribution for 
# the first 5 samples.

# detect how many CPU cores are available for your machine
# parallel::detectCores()

ncores <- 1

# Provide the generateNull() function the number of cores you would like
# the function to use by passing the ncore parameter

permuteResult <-
  generateNull(
    upSet = tgfb_gs_up,
    downSet = tgfb_gs_dn,
    rankData = rankData,
    subSamples = 1:5,
    centerScore = TRUE,
    knownDirection = TRUE,
    B = 1000,
    ncores = ncores,
    seed = 1,
    useBPPARAM = NULL
  )
# Note here, the useBPPARAM parameter allows user to supply a BPPARAM variable 
# as a parameter which decides the type of parallel ends to use.
# such as 
# snow <-  BiocParallel::SnowParam(type = "SOCK")
# permuteResult <-  generateNull(upSet = tgfb_gs_up, downSet = tgfb_gs_dn,
# rankData[,1:5],  B = 1000, seed = 1,ncores = ncores, useBPPARAM = snow)

# If you are not sure about this, just leave the value as NULL and set how many
# CPU cores to use via the ncores argument. It will use the default parallel 
# backend for your machine.

# For more information, please see the help page for ?generateNull()
# Please also note that one should pass the same values to the upSet, 
# downSet, centerScore and knownDirection arguments as what they provide 
# for the simpleScore() function to generate a proper null distribution.

head(permuteResult)

## ----getPvals, fig.height = 4, fig.width = 8----------------------------------
pvals <- getPvals(permuteResult, scoredf, subSamples = 1:5)

# getPval returns p-values for each individual sample.
# show the p-values for first 5 samples
pvals

## ----plotNull1, fig.height = 4, fig.width = 8---------------------------------

plotNull(permuteResult, scoredf, pvals, sampleNames = names(pvals)[1])


## ----plotNull2, fig.height = 6, fig.width = 12--------------------------------
# plot the null distributions for the first 2 samples and the p-values
# We can see from the plot, the control samples are not significant and TGFb 
# samples are very significant with very low p-values
plotNull(permuteResult, scoredf, pvals, sampleNames = names(pvals)[1:2])

## ----previewData--------------------------------------------------------------
# preview the scored CCLE samples
head(scoredf_ccle_epi)

# preview the scored TCGA samples
head(scoredf_tcga_epi)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

