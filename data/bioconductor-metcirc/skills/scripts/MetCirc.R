# Code example from 'MetCirc' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown()

## ----env, include=FALSE, echo=FALSE, cache=FALSE------------------------------
library("knitr")
opts_chunk$set(stop_on_error = 1L)
suppressPackageStartupMessages(library("MetCirc"))

## ----knitr, include=FALSE, cache=FALSE----------------------------------------
library("knitr")

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("MetCirc")

## ----eval=TRUE----------------------------------------------------------------
library("MetCirc")
library("MsCoreUtils")

## ----eval=TRUE,echo=c(1:2)----------------------------------------------------
## load data from Li et al., 2015
data("sd02_deconvoluted", package = "MetCirc")

## load binnedMSP
data("sd01_outputXCMS", package = "MetCirc")
#data("binnedMSP", package = "MetCirc")

## load similarityMat
data("similarityMat", package = "MetCirc")

## ----eval=TRUE----------------------------------------------------------------
## load idMSMStissueproject
data("idMSMStissueproject", package = "MetCirc")

## ----eval=TRUE,echo=c(1:2)----------------------------------------------------
## load data from GNPS
data("convertMsp2Spectra", package = "MetCirc")

## ----eval=TRUE----------------------------------------------------------------
## get all MS/MS spectra
id_uniq <- unique(sd02_deconvoluted[, "id"])

## obtain precursor m/z from id_uniq
prec_mz <- lapply(strsplit(as.character(id_uniq), split = " _ "), "[", 2) |>
    unlist() |>
    as.numeric()

## obtain m/z from fragments per precursor m/z
mz_l <- lapply(id_uniq, 
    function(id_i) sd02_deconvoluted[sd02_deconvoluted[, "id"] == id_i, "mz"])

## obtain corresponding intensity values 
int_l <- lapply(id_uniq, 
    function(id_i) sd02_deconvoluted[sd02_deconvoluted[, "id"] == id_i, "intensity"]) 

## obtain retention time by averaging all retention time values
rt <- lapply(id_uniq, function(x) sd02_deconvoluted[sd02_deconvoluted[, "id"] == x, "rt"]) |>
    lapply(function(i) mean(i)) |>
    unlist()

## create list of Spectra objects, concatenate, and add metadata
sps_l <- lapply(seq_len(length(mz_l)), function(i) {
    spd <- S4Vectors::DataFrame(
        name = as.character(i),
        rtime = rt[i], 
        msLevel = 2L,
        precursorMz = prec_mz[i])
    spd$mz <- list(mz_l[[i]])
    spd$intensity <- list(int_l[[i]])
    Spectra::Spectra(spd)})
sps_li <- Reduce(c, sps_l)
sps_li@metadata <- data.frame(show = rep(TRUE, length(sps_l)))

## ----eval=TRUE----------------------------------------------------------------
## get all MS/MS spectra
tissue <- tissue[tissue[, "id"] %in% compartmentTissue[, "mz_rt_pcgroup"], ]
id_uniq <- unique(tissue[, "id"])

## obtain precursor m/z from id_uniq
prec_mz <- lapply(strsplit(as.character(id_uniq), split = "_"), "[", 1) |>
    unlist() |>
    as.numeric()

## obtain m/z from fragments per precursor m/z
mz_l <- lapply(id_uniq, function(id_i) tissue[tissue[, "id"] == id_i, "mz"]) 

## obtain corresponding intensity values
int_l <- lapply(id_uniq, function(id_i) tissue[tissue[, "id"] == id_i, "intensity"])

## order mz and intensity values
int_l <- lapply(seq_along(int_l), function(i) int_l[[i]][order(mz_l[[i]])])
mz_l <- lapply(seq_along(mz_l), function(i) sort(mz_l[[i]]))

## obtain retention time by averaging all retention time values
rt <- lapply(id_uniq, function(x) tissue[tissue[, "id"] == x, "rt"]) |>
    lapply(FUN = mean) |>
    unlist()

## create list of Spectra objects and concatenate
sps_l <- lapply(seq_len(length(mz_l)), function(i) {
    spd <- S4Vectors::DataFrame(
        name = as.character(i),
        rtime = rt[i], 
        msLevel = 2L,
        precursorMz = prec_mz[i])
    spd$mz <- list(mz_l[[i]])
    spd$intensity <- list(int_l[[i]])
    Spectra::Spectra(spd)})
sps_tissue <- Reduce(c, sps_l)

## add metadata
## use SPL, LIM, ANT, STY for further analysis
sps_tissue@metadata <- data.frame(
    compartmentTissue[, c("SPL", "LIM", "ANT", "STY")])

## ----eval=TRUE----------------------------------------------------------------
sps_msp <- convertMsp2Spectra(msp2spectra)

## ----eval=TRUE----------------------------------------------------------------
## similarity Matrix 
similarityMat <- Spectra::compareSpectra(sps_tissue[1:100,], 
    FUN = MsCoreUtils::ndotproduct, ppm = 10, m = 0.5, n = 2)
colnames(similarityMat) <- rownames(similarityMat) <- sps_tissue$name[1:100]

## ----cluster,eval=TRUE,fig.show='hide'----------------------------------------
## load package amap
hClustMSP <- hcluster(similarityMat, method="spearman")

## visualize clusters
plot(hClustMSP, labels = FALSE, xlab="", sub="")

## ----truncateGroup1,eval=TRUE,echo=TRUE---------------------------------------
## define three clusters
cutTreeMSP <- cutree(hClustMSP, k = 3)

## extract feature identifiers that belong to module 1
module1 <- names(cutTreeMSP)[as.vector(cutTreeMSP) == "1"] 

## create a new similarity matrix that contains only highly related features
similarityMat_module1 <- similarityMat[module1, module1]

## ----eval=TRUE----------------------------------------------------------------
linkDf <- createLinkDf(similarityMatrix = similarityMat, sps = sps_tissue,
    condition = c("SPL", "LIM", "ANT", "STY"), lower = 0.5, upper = 1)

## ----eval=FALSE---------------------------------------------------------------
# selectedFeatures <- shinyCircos(similarityMat, sps = sps_tissue,
#     condition = c("LIM", "ANT", "STY"))

## ----circos,eval=TRUE,results='hide',message=FALSE,fig.show='hide'------------
## order similarity matrix according to retention time
condition <- c("SPL", "LIM", "ANT", "STY")
simM <- orderSimilarityMatrix(similarityMatrix = similarityMat, 
    sps = sps_tissue, type = "retentionTime", group = FALSE)
groupname <- rownames(simM)
inds <- MetCirc:::spectraCondition(sps_tissue, 
    condition = condition)
inds_match <- lapply(inds, function(x) {inds_match <- match(groupname, x)
    inds_match <- inds_match[!is.na(inds_match)]; x[inds_match]})
inds_cond <- lapply(seq_along(inds_match), 
    function(x) {
        if (length(inds_match[[x]]) > 0) {
            paste(condition[x], inds_match[[x]], sep = "_")
        } else character()
})
inds_cond <- unique(unlist(inds_cond))

## create link matrix
linkDf <- createLinkDf(similarityMatrix = simM, sps = sps_tissue, 
    condition = c("SPL", "LIM", "ANT", "STY"), lower = 0.9, upper = 1)
## cut link matrix (here: only display links between groups)
linkDf_cut <- cutLinkDf(linkDf = linkDf, type = "inter")

## set circlize paramters
circos.par(gap.degree = 0, cell.padding = c(0, 0, 0, 0), 
    track.margin = c(0, 0))

## here set indSelected arbitrarily
indSelected <- 14
selectedFeatures <- inds_cond[indSelected]

## actual plotting
plotCircos(inds_cond, linkDf_cut, initialize = TRUE, featureNames = TRUE, 
    cexFeatureNames = 0.2, groupSector = TRUE, groupName = FALSE, 
    links = FALSE, highlight = TRUE)

highlight(groupname = inds_cond, ind = indSelected, linkDf = linkDf_cut)

## plot without highlighting
plotCircos(inds_cond, linkDf_cut, initialize = TRUE, featureNames = TRUE, 
    cexFeatureNames = 0.2, groupSector = TRUE, groupName = FALSE, links = TRUE, 
    highlight = FALSE)

## ----session,eval=TRUE,echo=FALSE---------------------------------------------
sessionInfo()

