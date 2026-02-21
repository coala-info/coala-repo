# Code example from 'MOFA_example_scMT' vignette. See references/ for full tutorial.

## ---- warning=FALSE, message=FALSE-----------------------------------------
library(MultiAssayExperiment)
library(MOFA)
library(MOFAdata)
library(ggplot2)

## --------------------------------------------------------------------------
data("scMT_data")
scMT_data

## --------------------------------------------------------------------------
MOFAobject <- createMOFAobject(scMT_data)
MOFAobject

## --------------------------------------------------------------------------
plotDataOverview(MOFAobject, colors=c("#31A354","#377EB8","#377EB8","#377EB8"))

## --------------------------------------------------------------------------
DataOptions <- getDefaultDataOptions()
DataOptions

## --------------------------------------------------------------------------
ModelOptions <- getDefaultModelOptions(MOFAobject)
ModelOptions

## --------------------------------------------------------------------------
TrainOptions <- getDefaultTrainOptions()
TrainOptions$seed <- 2018

# Automatically drop factors that explain less than 1% of variance in all omics
TrainOptions$DropFactorThreshold <- 0.01

TrainOptions

## --------------------------------------------------------------------------
MOFAobject <- prepareMOFA(
  MOFAobject, 
  DataOptions = DataOptions,
  ModelOptions = ModelOptions,
  TrainOptions = TrainOptions
)

## ---- eval=FALSE-----------------------------------------------------------
#  MOFAobject <- runMOFA(MOFAobject)

## --------------------------------------------------------------------------
filepath <- system.file("extdata", "scMT_model.hdf5", package = "MOFAdata")
MOFAobject <- loadModel(filepath, MOFAobject)
MOFAobject

## --------------------------------------------------------------------------
# Calculate the variance explained (R2) per factor in each view 
r2 <- calculateVarianceExplained(MOFAobject)
r2$R2Total

# Variance explained by each factor in each view
head(r2$R2PerFactor)

# Plot it
plotVarianceExplained(MOFAobject)

## --------------------------------------------------------------------------
# Plot all weights and highlight specific gene markers
plotWeights(
  object = MOFAobject, 
  view = "RNA expression", 
  factor = 1, 
  nfeatures = 0, 
  abs = FALSE, 
  manual = list(c("Zfp42","Esrrb","Morc1","Fbxo15",
                  "Jam2","Klf4","Tcl1","Tbx3","Tex19.1"))
)

# Plot top 10 genes
plotTopWeights(
  object = MOFAobject,
  view = "RNA expression", 
  factor = 1, 
  nfeatures = 10
)

## --------------------------------------------------------------------------
# Add metadata to the plot
factor1 <- sort(getFactors(MOFAobject,"LF1")[,1])
order_samples <- names(factor1)
df <- data.frame(
  row.names = order_samples,
  culture = getCovariates(MOFAobject, "culture")[order_samples],
  factor = factor1
)

plotDataHeatmap(
  object = MOFAobject, 
  view = "RNA expression", 
  factor = "LF1", 
  features = 20, 
  transpose = TRUE, 
  show_colnames=FALSE, show_rownames=TRUE, # pheatmap options
  cluster_cols = FALSE, annotation_col=df # pheatmap options
)

## --------------------------------------------------------------------------
plotWeights(
  object = MOFAobject,
  view = "Met Enhancers", 
  factor = 1, 
  nfeatures = 0,
  abs = FALSE,
  scale = FALSE
)

## --------------------------------------------------------------------------
plotDataHeatmap(
  object = MOFAobject, 
  view = "Met Enhancers", 
  factor = 1, 
  features = 500,
  transpose = TRUE,
  cluster_rows=FALSE, cluster_cols=FALSE, # pheatmap options
  show_rownames=FALSE, show_colnames=FALSE, # pheatmap options
  annotation_col=df  # pheatmap options
)

## --------------------------------------------------------------------------
# Plot all weights and highlight specific gene markers
plotWeights(
  object = MOFAobject, 
  view="RNA expression", 
  factor = 2, 
  nfeatures = 0, 
  manual = list(c("Krt8","Cald1","Anxa5","Tagln",
                  "Ahnak","Dsp","Anxa3","Krt19")), 
  scale = FALSE,
  abs = FALSE
)

# Plot top 10 genes
plotTopWeights(
  object = MOFAobject, 
  view="RNA expression", 
  factor = 2, 
  nfeatures = 10
)

## --------------------------------------------------------------------------
plotWeights(
  object = MOFAobject, 
  view = "Met Enhancers", 
  factor = 2, 
  nfeatures = 0, 
  abs = FALSE,
  scale = FALSE
)

## ---- message=FALSE--------------------------------------------------------
factor2 <- sort(getFactors(MOFAobject,"LF2")[,1])
order_samples <- names(factor2)
df <- data.frame(
  row.names = order_samples,
  culture =  getCovariates(MOFAobject, "culture")[order_samples],
  factor = factor2
)
plotDataHeatmap(
  object = MOFAobject, 
  view = "Met Enhancers", 
  factor = 2, 
  features = 500,
  transpose = TRUE,
  cluster_rows=FALSE, cluster_cols=FALSE,  # pheatmap options
  show_rownames=FALSE, show_colnames=FALSE,  # pheatmap options
  annotation_col=df  # pheatmap options
)

## ---- message=FALSE--------------------------------------------------------
p <- plotFactorScatter(
  object = MOFAobject, 
  factors=1:2, 
  color_by = "culture")

p + scale_color_manual(values=c("lightsalmon","orangered3"))

## ---- message=FALSE--------------------------------------------------------
plotFactorBeeswarm(
  object = MOFAobject,
  factors = 3, 
  color_by = "cellular_detection_rate"
)

## ---- message=FALSE--------------------------------------------------------
cdr <- colMeans(getTrainData(MOFAobject)$`RNA expression`>0,na.rm=TRUE)
factor3 <- getFactors(MOFAobject,
                      factors=3)

foo <- data.frame(factor = as.numeric(factor3), cdr = cdr)
ggplot(foo, aes_string(x = "factor", y = "cdr")) + 
  geom_point() + xlab("Factor 3") +
  ylab("Cellular Detection Rate") +
  stat_smooth(method="lm") +
  theme_bw()

## --------------------------------------------------------------------------
MOFAobject <- impute(MOFAobject)
nonImputedMethylation <- getTrainData(MOFAobject,
                                      view="Met CpG Islands")[[1]]
imputedMethylation <- getImputedData(MOFAobject,
                                     view="Met CpG Islands")[[1]]

## --------------------------------------------------------------------------
# non-imputed data
pheatmap::pheatmap(nonImputedMethylation[1:100,1:20],
         cluster_rows = FALSE, cluster_cols = FALSE,
         show_rownames = FALSE, show_colnames = FALSE)

# imputed data
pheatmap::pheatmap(imputedMethylation[1:100,1:20],
         cluster_rows = FALSE, cluster_cols = FALSE,
         show_rownames = FALSE, show_colnames = FALSE)

## ---- message=FALSE--------------------------------------------------------
# kmeans clustering with K=3 using Factor 1
set.seed(1234)
clusters <- clusterSamples(MOFAobject, k=3, factors=1)

# Scatterplot colored by the predicted cluster labels,
# and shaped by the true culture conditions
plotFactorScatter(
  object = MOFAobject,
  factors = 1:2,
  color_by = clusters,
  shape_by = "culture"
)

## --------------------------------------------------------------------------
sessionInfo()

