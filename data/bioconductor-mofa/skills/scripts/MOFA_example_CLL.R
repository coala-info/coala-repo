# Code example from 'MOFA_example_CLL' vignette. See references/ for full tutorial.

## ---- warning=FALSE, message=FALSE-----------------------------------------
library(MultiAssayExperiment)
library(MOFA)
library(MOFAdata)

## --------------------------------------------------------------------------
data("CLL_data")
MOFAobject <- createMOFAobject(CLL_data)
MOFAobject

## ---- warning=FALSE, message=FALSE-----------------------------------------

# Load data
# import list with mRNA, Methylation, Drug Response and Mutation data. 
data("CLL_data") 

# check dimensionalities, samples are columns, features are rows
lapply(CLL_data, dim) 

# Load sample metadata: Sex and Diagnosis
data("CLL_covariates")
head(CLL_covariates)

# Create MultiAssayExperiment object 
mae_CLL <- MultiAssayExperiment(
  experiments = CLL_data, 
  colData = CLL_covariates
)

# Build the MOFA object
MOFAobject <- createMOFAobject(mae_CLL)
MOFAobject


## --------------------------------------------------------------------------
plotDataOverview(MOFAobject)

## --------------------------------------------------------------------------
DataOptions <- getDefaultDataOptions()
DataOptions 

## --------------------------------------------------------------------------
ModelOptions <- getDefaultModelOptions(MOFAobject)
ModelOptions$numFactors <- 25
ModelOptions

## --------------------------------------------------------------------------
TrainOptions <- getDefaultTrainOptions()

# Automatically drop factors that explain less than 2% of variance in all omics
TrainOptions$DropFactorThreshold <- 0.02

TrainOptions$seed <- 2017

TrainOptions

## --------------------------------------------------------------------------
MOFAobject <- prepareMOFA(
  MOFAobject, 
  DataOptions = DataOptions,
  ModelOptions = ModelOptions,
  TrainOptions = TrainOptions
)

## --------------------------------------------------------------------------
# MOFAobject <- regressCovariates(
#   object = MOFAobject,
#   views = c("Drugs","Methylation","mRNA"),
#   covariates = MOFAobject@InputData$Gender
# )

## ---- eval=FALSE-----------------------------------------------------------
#  MOFAobject <- runMOFA(MOFAobject)

## --------------------------------------------------------------------------
# Loading an existing trained model
filepath <- system.file("extdata", "CLL_model.hdf5", package = "MOFAdata")

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
plotWeightsHeatmap(
  MOFAobject, 
  view = "Mutations", 
  factors = 1:5,
  show_colnames = FALSE
)

## --------------------------------------------------------------------------
plotWeights(
  MOFAobject, 
  view = "Mutations", 
  factor = 1, 
  nfeatures = 5
)

plotWeights(
  MOFAobject, 
  view = "Mutations", 
  factor = 1, 
  nfeatures = 5,
  manual = list(c("BRAF"),c("MED12")),
  color_manual = c("red","blue")
  
)

## --------------------------------------------------------------------------
plotTopWeights(
  MOFAobject, 
  view="Mutations", 
  factor=1
)

## --------------------------------------------------------------------------
plotTopWeights(
  MOFAobject, 
  view = "mRNA", 
  factor = 1
)

## --------------------------------------------------------------------------
plotDataHeatmap(
  MOFAobject, 
  view = "mRNA", 
  factor = 1, 
  features = 20, 
  show_rownames = FALSE
)

## --------------------------------------------------------------------------
# Load reactome annotations
data("reactomeGS") # binary matrix with feature sets in rows and features in columns

# perform enrichment analysis
gsea <- runEnrichmentAnalysis(
  MOFAobject,
  view = "mRNA",
  feature.sets = reactomeGS,
  alpha = 0.01
)

## --------------------------------------------------------------------------
plotEnrichmentBars(gsea, alpha=0.01)

## --------------------------------------------------------------------------
interestingFactors <- 4:5

fseaplots <- lapply(interestingFactors, function(factor) {
  plotEnrichment(
    MOFAobject,
    gsea,
    factor = factor,
    alpha = 0.01,
    max.pathways = 10 # The top number of pathways to display
  )
})

cowplot::plot_grid(fseaplots[[1]], fseaplots[[2]],
                   ncol = 1, labels = paste("Factor", interestingFactors))

## --------------------------------------------------------------------------
plotFactorScatter(
  MOFAobject,
  factors = 1:2,
  color_by = "IGHV",      # color by the IGHV values that are part of the training data
  shape_by = "trisomy12"  # shape by the trisomy12 values that are part of the training data
)

## --------------------------------------------------------------------------
plotFactorScatters(
  MOFAobject,
  factors = 1:3,
  color_by = "IGHV"
)

## --------------------------------------------------------------------------
plotFactorBeeswarm(
  MOFAobject,
  factors = 1,
  color_by = "IGHV"
)

## --------------------------------------------------------------------------
MOFAweights <- getWeights(
  MOFAobject, 
  views = "all", 
  factors = "all", 
  as.data.frame = TRUE    # if TRUE, it outputs a long dataframe format. If FALSE, it outputs a wide matrix format
)
head(MOFAweights)

## --------------------------------------------------------------------------
MOFAfactors <- getFactors(
  MOFAobject, 
  factors = c(1,2),
  as.data.frame = FALSE   # if TRUE, it outputs a long dataframe format. If FALSE, it outputs a wide matrix format
)
head(MOFAfactors)

## --------------------------------------------------------------------------
MOFAtrainData <- getTrainData(
  MOFAobject,
  as.data.frame = TRUE, 
  views = "Mutations"
)
head(MOFAtrainData)

## --------------------------------------------------------------------------
predictedDrugs <- predict(
  MOFAobject,
  view = "Drugs",
  factors = "all"
)[[1]]


# training data (incl. missing values)
drugData4Training <- getTrainData(MOFAobject, view="Drugs")[[1]]
pheatmap::pheatmap(drugData4Training[1:40,1:20],
         cluster_rows = FALSE, cluster_cols = FALSE,
         show_rownames = FALSE, show_colnames = FALSE)

# predicted data
pheatmap::pheatmap(predictedDrugs[1:40,1:20],
         cluster_rows = FALSE, cluster_cols = FALSE,
         show_rownames = FALSE, show_colnames = FALSE)

## --------------------------------------------------------------------------
MOFAobject <- impute(MOFAobject)
imputedDrugs <- getImputedData(MOFAobject, view="Drugs")[[1]]

# training data (incl. missing values)
pheatmap::pheatmap(drugData4Training[1:40,1:20],
         cluster_rows = FALSE, cluster_cols = FALSE,
         show_rownames = FALSE, show_colnames = FALSE)

# imputed data
pheatmap::pheatmap(imputedDrugs[1:40,1:20],
         cluster_rows = FALSE, cluster_cols = FALSE,
         show_rownames = FALSE, show_colnames = FALSE)

## --------------------------------------------------------------------------
set.seed(1234)
clusters <- clusterSamples(
  MOFAobject, 
  k = 2,        # Number of clusters for the k-means function
  factors = 1   # factors to use for the clustering
)

plotFactorScatter(
  MOFAobject, 
  factors = 1:2, 
  color_by = clusters
)

## --------------------------------------------------------------------------
sessionInfo()

