# Code example from 'vignette' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, results = 'hide')

## ---- eval=FALSE--------------------------------------------------------------
#  if(!requireNamespace("BiocManager", quietly = TRUE))
#      install.packages("BiocManager")
#  BiocManager::install("STdeconvolve")

## ---- load_library------------------------------------------------------------
library(STdeconvolve)

## ---- data--------------------------------------------------------------------
data(mOB)
pos <- mOB$pos ## x and y positions of each pixel
cd <- mOB$counts ## matrix of gene counts in each pixel
annot <- mOB$annot ## annotated tissue layers assigned to each pixel

## ---- feature_selection, fig.width=6, fig.height=3----------------------------
## remove pixels with too few genes
counts <- cleanCounts(counts = cd,
                      min.lib.size = 100,
                      min.reads = 1,
                      min.detected = 1,
                      verbose = TRUE)
## feature select for genes
corpus <- restrictCorpus(counts,
                         removeAbove = 1.0,
                         removeBelow = 0.05,
                         alpha = 0.05,
                         plot = TRUE,
                         verbose = TRUE)

## ---- fit_ldas, fig.width=6, fig.height=4-------------------------------------
## Note: the input corpus needs to be an integer count matrix of pixels x genes
ldas <- fitLDA(t(as.matrix(corpus)), Ks = seq(2, 9, by = 1),
               perc.rare.thresh = 0.05,
               plot=TRUE,
               verbose=TRUE)

## ---- model-------------------------------------------------------------------
## select model with minimum perplexity
optLDA <- optimalModel(models = ldas, opt = "min")

## Extract pixel cell-type proportions (theta) and cell-type gene expression
## profiles (beta) for the given dataset.
## We can also remove cell-types from pixels that contribute less than 5% of the
## pixel proportion and scale the deconvolved transcriptional profiles by 1000 
results <- getBetaTheta(optLDA,
                        perc.filt = 0.05,
                        betaScale = 1000)

deconProp <- results$theta
deconGexp <- results$beta

## ---- visualize_all, fig.width=8, fig.height=4--------------------------------
vizAllTopics(deconProp, pos, 
             groups = annot, 
             group_cols = rainbow(length(levels(annot))),
             r=0.4)

## ---- visualize_one, fig.width=8, fig.height=4--------------------------------
vizTopic(theta = deconProp, pos = pos, topic = "5", plotTitle = "X5",
         size = 5, stroke = 1, alpha = 0.5,
         low = "white",
         high = "red")

## ---- proxy_annotations-------------------------------------------------------
# proxy theta for the annotated layers
mobProxyTheta <- model.matrix(~ 0 + annot)
rownames(mobProxyTheta) <- names(annot)
# fix names
colnames(mobProxyTheta) <- unlist(lapply(colnames(mobProxyTheta), function(x) {
  unlist(strsplit(x, "annot"))[2]
}))

mobProxyGexp <- counts %*% mobProxyTheta

## ---- correlation_beta, fig.width=6, fig.height=5-----------------------------
corMtx_beta <- getCorrMtx(# the deconvolved cell-type `beta` (celltypes x genes)
                          m1 = as.matrix(deconGexp),
                          # the reference `beta` (celltypes x genes)
                          m2 = t(as.matrix(mobProxyGexp)),
                          # "b" = comparing beta matrices, "t" for thetas
                          type = "b")

## row and column names need to be characters
rownames(corMtx_beta) <- paste0("decon_", seq(nrow(corMtx_beta)))

correlationPlot(mat = corMtx_beta,
                # colLabs (aka x-axis, and rows of matrix)
                colLabs = "Deconvolved cell-types",
                # rowLabs (aka y-axis, and columns of matrix)
                rowLabs = "Ground truth cell-types",
                title = "Transcriptional correlation", annotation = TRUE) +
  ## this function returns a `ggplot2` object, so can add additional aesthetics
  ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 90, vjust = 0))

## ---- correlation_theta, fig.width=6, fig.height=5----------------------------
corMtx_theta <- getCorrMtx(# deconvolved cell-type `theta` (pixels x celltypes)
                           m1 = as.matrix(deconProp),
                           # the reference `theta` (pixels x celltypes)
                           m2 = as.matrix(mobProxyTheta),
                           # "b" = comparing beta matrices, "t" for thetas
                           type = "t")

## row and column names need to be characters
rownames(corMtx_theta) <- paste0("decon_", seq(nrow(corMtx_theta)))

correlationPlot(mat = corMtx_theta,
                # colLabs (aka x-axis, and rows of matrix)
                colLabs = "Deconvolved cell-types",
                # rowLabs (aka y-axis, and columns of matrix)
                rowLabs = "Ground truth cell-types",
                title = "Proportional correlation", annotation = TRUE) +
  ## this function returns a `ggplot2` object, so can add additional aesthetics
  ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 90, vjust = 0))

## ---- correlation_pairing, fig.width=6, fig.height=5--------------------------
## Order the cell-types rows based on best match (highest correlation) with
## each community.
## Cannot have more rows than columns for this pairing, so transpose
pairs <- lsatPairs(t(corMtx_theta))
m <- t(corMtx_theta)[pairs$rowix, pairs$colsix]

correlationPlot(mat = t(m), # transpose back
                # colLabs (aka x-axis, and rows of matrix)
                colLabs = "Deconvolved cell-types",
                # rowLabs (aka y-axis, and columns of matrix)
                rowLabs = "Ground truth cell-types",
                title = "Transcriptional correlation", annotation = TRUE) +
  ## this function returns a `ggplot2` object, so can add additional aesthetics
  ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 90, vjust = 0))

## ---- marker_genes------------------------------------------------------------
mobProxyLayerMarkers <- list()

## make the tissue layers the rows and genes the columns
gexp <- t(as.matrix(mobProxyGexp))

for (i in seq(length(rownames(gexp)))){
  celltype <- i
  ## log2FC relative to other cell-types
  ## highly expressed in cell-type of interest
  highgexp <- names(which(gexp[celltype,] > 10))
  ## high log2(fold-change) compared to other deconvolved cell-types and limit
  ## to the top 200
  log2fc <- sort(
                log2(gexp[celltype,highgexp]/colMeans(gexp[-celltype,highgexp])),
                decreasing=TRUE)[1:200]
  
  ## for gene set of the ground truth cell-type, get the genes
  ## with log2FC > 1 (so FC > 2 over the mean exp of the other cell-types)
  markers <- names(log2fc[log2fc > 1])
  mobProxyLayerMarkers[[ rownames(gexp)[celltype] ]] <- markers
}

## ---- annotations-------------------------------------------------------------
celltype_annotations <- annotateCellTypesGSEA(beta = results$beta,
                                              gset = mobProxyLayerMarkers,
                                              qval = 0.05)

## ---- annotation_result_1-----------------------------------------------------
celltype_annotations$results$`2`

## ---- annotation_result_2-----------------------------------------------------
celltype_annotations$predictions

## ---- spatial_experiment_install, eval=FALSE----------------------------------
#  ## install `SpatialExperiment` and `TENxVisiumData` if not already
#  if (!require("BiocManager", quietly = TRUE))
#      install.packages("BiocManager")
#  BiocManager::install(c("SpatialExperiment", "TENxVisiumData"))

## ---- spatial_experiment_load, eval=FALSE-------------------------------------
#  library(SpatialExperiment)
#  library(TENxVisiumData)
#  
#  ## load the MouseBrainCoronal SpatialExperiment object from `TENxVisiumData`
#  se <- TENxVisiumData::MouseBrainCoronal()

## ---- eval=FALSE--------------------------------------------------------------
#  f <- "visiumTutorial/"
#  
#  if(!file.exists(f)){
#        dir.create(f)
#    }

## ---- eval=FALSE--------------------------------------------------------------
#  if(!file.exists(paste0(f, "V1_Adult_Mouse_Brain_filtered_feature_bc_matrix.tar.gz"))){
#    tar_gz_file <- "http://cf.10xgenomics.com/samples/spatial-exp/1.1.0/V1_Adult_Mouse_Brain/V1_Adult_Mouse_Brain_filtered_feature_bc_matrix.tar.gz"
#    download.file(tar_gz_file,
#                  destfile = paste0(f, "V1_Adult_Mouse_Brain_filtered_feature_bc_matrix.tar.gz"),
#                  method = "auto")
#  }
#  untar(tarfile = paste0(f, "V1_Adult_Mouse_Brain_filtered_feature_bc_matrix.tar.gz"),
#        exdir = f)
#  
#  if(!file.exists(paste0(f, "V1_Adult_Mouse_Brain_spatial.tar.gz"))){
#  spatial_imaging_data <- "http://cf.10xgenomics.com/samples/spatial-exp/1.1.0/V1_Adult_Mouse_Brain/V1_Adult_Mouse_Brain_spatial.tar.gz"
#    download.file(spatial_imaging_data,
#                  destfile = paste0(f, "V1_Adult_Mouse_Brain_spatial.tar.gz"),
#                  method = "auto")
#  }
#  untar(tarfile = paste0(f, "V1_Adult_Mouse_Brain_spatial.tar.gz"),
#        exdir = f)

## ---- eval=FALSE--------------------------------------------------------------
#  se <- SpatialExperiment::read10xVisium(samples = f,
#       type = "sparse",
#       data = "filtered")

## ---- eval=FALSE--------------------------------------------------------------
#  ## this is the genes x barcode sparse count matrix
#  ## make sure that SpatialExperiment is loaded because `assay` isn't an exported
#  ## object into the namespace
#  cd <- assay(se, "counts")

## ---- eval=FALSE--------------------------------------------------------------
#  pos <- SpatialExperiment::spatialCoords(se)
#  
#  ## change column names to x and y
#  ## for this dataset, we will visualize barcodes using
#  ## "pxl_col_in_fullres" = "y" coordinates,
#  ## and "pxl_row_in_fullres" = "x" coordinates
#  colnames(pos) <- c("y", "x")

## ---- eval=FALSE--------------------------------------------------------------
#  counts <- cleanCounts(cd, min.lib.size = 100, min.reads = 10)

## ---- eval=FALSE--------------------------------------------------------------
#  corpus <- restrictCorpus(counts,
#                           removeAbove=1.0,
#                           removeBelow = 0.05,
#                           nTopOD = 1000)

## ---- eval=FALSE--------------------------------------------------------------
#  ldas <- fitLDA(t(as.matrix(corpus)), Ks = c(15))

## ---- eval=FALSE--------------------------------------------------------------
#  optLDA <- optimalModel(models = ldas, opt = 15)
#  
#  results <- getBetaTheta(optLDA, perc.filt = 0.05, betaScale = 1000)
#  deconProp <- results$theta
#  deconGexp <- results$beta

## ---- fig.height=8, fig.width=7, eval=FALSE-----------------------------------
#  plt <- vizAllTopics(theta = deconProp,
#                     pos = pos,
#                     r = 45,
#                     lwd = 0,
#                     showLegend = TRUE,
#                     plotTitle = NA) +
#    ggplot2::guides(fill=ggplot2::guide_legend(ncol=2)) +
#  
#    ## outer border
#    ggplot2::geom_rect(data = data.frame(pos),
#              ggplot2::aes(xmin = min(x)-90, xmax = max(x)+90,
#                           ymin = min(y)-90, ymax = max(y)+90),
#              fill = NA, color = "black", linetype = "solid", size = 0.5) +
#  
#    ggplot2::theme(
#      plot.background = ggplot2::element_blank()
#    ) +
#  
#    ## remove the pixel "groups", which are color aesthetics for the pixel borders
#    ggplot2::guides(colour = "none")

## -----------------------------------------------------------------------------
sessionInfo()

