# Code example from 'FeatSeekR-vignette' vignette. See references/ for full tutorial.

## ----setup, message=FALSE-----------------------------------------------------
library(FeatSeekR)
library(pheatmap)
library(SummarizedExperiment)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("FeatSeekR")

## ----simulate data------------------------------------------------------------
set.seed(111)
# simulate data with 500 conditions, 3 replicates and 5 latent factors 
conditions <- 500
latent_factors <- 5
replicates <- 3

# simData generates 10 features per latent_factor, so choosing latent_factors=5
# will generate 50 features.
# we simulate samples from 500 independent conditions per replicate. setting 
# conditions=500 and replicates=3 will generate 1500 samples, leading to 
# final data dimensions of 50 features x 1500 samples
sim <- simData(conditions=conditions, n_latent_factors=latent_factors,
                replicates=replicates)

# show that simulated data dimensions are indeed 50 x 1500 
dim(assay(sim, "data"))

# calculate the feature correlation for first replicate
data <- t(assay(sim, "data"))
cor <- cor(data, use = "pairwise.complete.obs")

# plot a heatmap of the features and color features according to their 
# generating latent factors
anno <- data.frame(Latent_factor = as.factor(rep(1:5, each=10)))
rownames(anno) <- dimnames(sim)[[1]]
colors        <- c("red", "blue", "darkorange", "darkgreen", "black")
names(colors) <- c("1", "2", "3", "4", "5")
anno_colors <- list(Latent_factor = colors)
range <- max(abs(cor))
pheatmap(cor, treeheight_row = 0 , treeheight_col = 0, 
        show_rownames = FALSE, show_colnames = FALSE,
        breaks = seq(-range, range, length.out = 100), cellwidth = 6, 
        cellheight = 6, annotation_col = anno, annotation_colors = anno_colors, 
        fontsize = 8)

## ----plot top 5---------------------------------------------------------------
# select the top 5 features
res <- FeatSeek(sim, max_features=5)

# plot a heatmap of the top 5 selected features 
plotSelectedFeatures(res)

## -----------------------------------------------------------------------------
sessionInfo()

