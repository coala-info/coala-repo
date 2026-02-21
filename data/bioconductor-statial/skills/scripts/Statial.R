# Code example from 'Statial' vignette. See references/ for full tutorial.

params <-
list(test = FALSE)

## ----chunk setup, include = FALSE---------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  cache = TRUE,
  message = FALSE,
  warning = FALSE
)
library(BiocStyle)

## ----installation, eval = FALSE-----------------------------------------------
# # Install the package from Bioconductor
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#   install.packages("BiocManager")
# }
# BiocManager::install("Statial")

## ----libraries and setup, warning = FALSE, message = FALSE, eval = TRUE-------
# Loading required packages
library(Statial)
library(spicyR)
library(ClassifyR)
library(lisaClust)
library(dplyr)
library(SingleCellExperiment)
library(ggplot2)
library(ggsurvfit)
library(survival)
library(tibble)
library(treekoR)

theme_set(theme_classic())
nCores <- 1

## ----load dataset-------------------------------------------------------------
# Load breast cancer
data("kerenSCE")

kerenSCE

## ----biological hierarchy-----------------------------------------------------
# Examine all cell types in image
unique(kerenSCE$cellType)

# Named list of parents and their child cell types
biologicalHierarchy = list(
  "tumour" = c("Keratin_Tumour", "Tumour"),
  "tcells" = c("CD3_Cell", "CD4_Cell", "CD8_Cell", "Tregs"),
  "myeloid" = c("Dc/Mono", "DC", "Mono/Neu", "Macrophages", "Neutrophils"),
  "tissue" = c("Endothelial", "Mesenchymal")
)

# Adding more broader immune parent populationse
biologicalHierarchy$immune = c(biologicalHierarchy$bcells,
                               biologicalHierarchy$tcells,
                               biologicalHierarchy$myeloid,
                               "NK", "other immune", "B")


# Creating a vector for all cellTypes
all <- unique(kerenSCE$cellType)

## ----clustering hierarchy, warning = FALSE------------------------------------
# Calculate hierarchy using treekoR
kerenTree <- treekoR::getClusterTree(t(assay(kerenSCE, "intensities")),
                            kerenSCE$cellType,
                            hierarchy_method="hopach",
                            hopach_K = 1)

# Convert treekoR result to a name list of parents and children.
treekorParents = getParentPhylo(kerenTree)

treekorParents

## ----image6-------------------------------------------------------------------
# Lets define a new cell type vector
kerenSCE$cellTypeNew <- kerenSCE$cellType

# Select for all cells that express higher than baseline level of p53
p53Pos <- assay(kerenSCE)["p53", ] > -0.300460

# Find p53+ tumour cells
kerenSCE$cellTypeNew[kerenSCE$cellType %in% biologicalHierarchy$tumour] <- "Tumour"
kerenSCE$cellTypeNew[p53Pos & kerenSCE$cellType %in% biologicalHierarchy$tumour] <- "p53_Tumour"

# Group all immune cells under the name "Immune"
kerenSCE$cellTypeNew[kerenSCE$cellType %in% biologicalHierarchy$immune] <- "Immune"

# Plot image 6
kerenSCE |>
  colData() |>
  as.data.frame() |>
  filter(imageID == "6") |>
  filter(cellTypeNew %in% c("Immune", "Tumour", "p53_Tumour")) |>
  arrange(cellTypeNew) |>
  ggplot(aes(x = x, y = y, color = cellTypeNew)) +
  geom_point(size = 1) +
  scale_colour_manual(values = c("Immune" = "#505050", "p53_Tumour" = "#64BC46", "Tumour" = "#D6D6D6")) +
  guides(colour = guide_legend(title = "Cell types", override.aes = list(size = 3)))

## ----p53 relationship---------------------------------------------------------
p53_Kontextual <- Kontextual(
  cells = kerenSCE,
  r = 100,
  from = "Immune",
  to = "p53_Tumour",
  parent = c("p53_Tumour", "Tumour"),
  cellType = "cellTypeNew"
)

p53_Kontextual

## ----kontextCurve-------------------------------------------------------------
curves <- kontextCurve(
  cells = kerenSCE,
  from = "Immune",
  to = "p53_Tumour",
  parent = c("p53_Tumour", "Tumour"),
  rs = seq(50, 510, 50),
  image = "6",
  cellType = "cellTypeNew",
  cores = nCores
)

kontextPlot(curves)

## ----parentDf-----------------------------------------------------------------
# Get all relationships between cell types and their parents
parentDf <- parentCombinations(
  all = all,
  parentList = biologicalHierarchy
)

## ----kontextual---------------------------------------------------------------
# Running Kontextual on all relationships across all images.
kerenKontextual <- Kontextual(
  cells = kerenSCE,
  parentDf = parentDf,
  r = 100,
  cores = nCores
)

## ----head kontextual results--------------------------------------------------
head(kerenKontextual, 10)

## ----survival data------------------------------------------------------------
# add survival column to kerenSCE
kerenSCE$event = 1 - kerenSCE$Censored
kerenSCE$survival = Surv(kerenSCE$Survival_days_capped, kerenSCE$event)

## ----prep kontextual matrix---------------------------------------------------
# Converting Kontextual result into data matrix
kontextMat <- prepMatrix(kerenKontextual)

# Ensuring rownames of kontextMat match up with the image IDs of the SCE object
kontextMat <- kontextMat[kerenSCE$imageID |> unique(), ]

# Replace NAs with 0
kontextMat[is.na(kontextMat)] <- 0

## ----survival anaylysis-------------------------------------------------------
# Running survival analysis
survivalResults = spicy(cells = kerenSCE,
                        alternateResult = kontextMat,
                        condition = "survival",
                        weights = TRUE)

head(survivalResults$survivalResults, 10)


## ----survival signifPlot------------------------------------------------------
signifPlot(survivalResults)

## ----extract data KM curve----------------------------------------------------
# Extracting survival data
survData <- kerenSCE |>
  colData() |>
  data.frame() |>
  select(imageID, survival) |>
  unique()

# Creating survival vector
kerenSurv <- survData$survival
names(kerenSurv) <- survData$imageID

kerenSurv

## ----KM curve, fig.width=5, fig.height=4--------------------------------------
# Selecting most significant relationship
survRelationship <- kontextMat[["DC__NK__immune"]]
survRelationship <- ifelse(survRelationship > median(survRelationship), "Localised", "Dispersed")

# Plotting Kaplan-Meier curve
survfit2(kerenSurv ~ survRelationship) |>
  ggsurvfit() +
  ggtitle("DC__NK__immune")

## ----calc metrics-------------------------------------------------------------
kerenSCE <- getDistances(kerenSCE,
  maxDist = 200,
  nCores = 1
)

kerenSCE <- getAbundances(kerenSCE,
  r = 200,
  nCores = 1
)

## ----calcStateChanges---------------------------------------------------------
stateChanges <- calcStateChanges(
  cells = kerenSCE,
  type = "distances",
  image = "6",
  from = "Keratin_Tumour",
  to = "Macrophages",
  marker = "p53",
  nCores = 1
)

stateChanges

## ----plotStateChanges p53-----------------------------------------------------
p <- plotStateChanges(
  cells = kerenSCE,
  type = "distances",
  image = "6",
  from = "Keratin_Tumour",
  to = "Macrophages",
  marker = "p53",
  size = 1,
  shape = 19,
  interactive = FALSE,
  plotModelFit = FALSE,
  method = "lm"
)

p

## ----calcStateChanges all-----------------------------------------------------
stateChanges <- calcStateChanges(
  cells = kerenSCE,
  type = "distances",
  nCores = 1,
  minCells = 100
)

stateChanges |>
  filter(imageID == 6) |>
  head(n = 10)

## ----plotStateChanges HLA-----------------------------------------------------
p <- plotStateChanges(
  cells = kerenSCE,
  type = "distances",
  image = "6",
  from = "Keratin_Tumour",
  to = "Macrophages",
  marker = "HLA_Class_1",
  size = 1,
  shape = 19,
  interactive = FALSE,
  plotModelFit = FALSE,
  method = "lm"
)

p

## ----statChanges--------------------------------------------------------------
stateChanges |> head(n = 10)

## ----plotStateChanges CD20----------------------------------------------------
p <- plotStateChanges(
  cells = kerenSCE,
  type = "distances",
  image = "35",
  from = "CD4_Cell",
  to = "B",
  marker = "CD20",
  size = 1,
  shape = 19,
  interactive = FALSE,
  plotModelFit = FALSE,
  method = "lm"
)

p

## ----calcContamination--------------------------------------------------------
kerenSCE <- calcContamination(kerenSCE)

stateChangesCorrected <- calcStateChanges(
  cells = kerenSCE,
  type = "distances",
  nCores = 1,
  minCells = 100,
  contamination = TRUE
)

stateChangesCorrected |> head(n = 20)

## ----corrected----------------------------------------------------------------
cellTypeMarkers <- c("CD3", "CD4", "CD8", "CD56", "CD11c", "CD68", "CD45", "CD20")

values <- c("blue", "red")
names(values) <- c("None", "Corrected")

df <- rbind(
  data.frame(TP = cumsum(stateChanges$marker %in% cellTypeMarkers), FP = cumsum(!stateChanges$marker %in% cellTypeMarkers), type = "None"),
  data.frame(TP = cumsum(stateChangesCorrected$marker %in% cellTypeMarkers), FP = cumsum(!stateChangesCorrected$marker %in% cellTypeMarkers), type = "Corrected")
)

ggplot(df, aes(x = TP, y = FP, colour = type)) +
  geom_line() +
  labs(y = "Cell state marker", x = "Cell type marker") +
  scale_colour_manual(values = values)

## ----corrected zoom-----------------------------------------------------------
ggplot(df, aes(x = TP, y = FP, colour = type)) +
  geom_line() +
  xlim(0, 100) +
  ylim(0, 1000) +
  labs(y = "Cell state marker", x = "Cell type marker") +
  scale_colour_manual(values = values)

## ----survival state changes---------------------------------------------------
# Preparing features for Statial
stateMat <- prepMatrix(stateChanges)

# Ensuring rownames of stateMat match up with rownames of the survival vector
stateMat <- stateMat[names(kerenSurv), ]

# Remove some very small values
stateMat <- stateMat[, colMeans(abs(stateMat) > 0.0001) > .8]

survivalResults <- colTest(stateMat, kerenSurv, type = "survival")

head(survivalResults)

## ----KM curve state changes, fig.width=5, fig.height=4------------------------
# Selecting the most significant relationship
survRelationship <- stateMat[["Keratin_Tumour__CD4_Cell__Keratin6"]]
survRelationship <- ifelse(survRelationship > median(survRelationship), "Higher expression in close cells", "Lower expression in close cells")

# Plotting Kaplan-Meier curve
survfit2(kerenSurv ~ survRelationship) |>
  ggsurvfit() +
  add_pvalue() +
  ggtitle("Keratin_Tumour__CD4_Cell__Keratin6")

## ----lisaClust----------------------------------------------------------------
set.seed(51773)

# Preparing features for lisaClust
kerenSCE <- lisaClust::lisaClust(kerenSCE, k = 5)

## ----hatchingPlot, fig.height=5, fig.width=6.5--------------------------------
# Use hatching to visualise regions and cell types.
lisaClust::hatchingPlot(kerenSCE,
  useImages = "5",
  line.spacing = 41, # spacing of lines
  nbp = 100 # smoothness of lines
)

## ----colTest regions----------------------------------------------------------
cellTypeRegionMeans <- getMarkerMeans(kerenSCE,
  imageID = "imageID",
  cellType = "cellType",
  region = "region"
)

survivalResults <- colTest(cellTypeRegionMeans[names(kerenSurv), ], kerenSurv, type = "survival")

head(survivalResults)

## ----ClassifyR----------------------------------------------------------------
# Calculate cell type and region proportions
cellTypeProp <- getProp(kerenSCE,
  feature = "cellType",
  imageID = "imageID"
)
regionProp <- getProp(kerenSCE,
  feature = "region",
  imageID = "imageID"
)

# Combine all the features into a list for classification
featureList <- list(
  states = stateMat,
  kontextual = kontextMat,
  regionMarkerMeans = cellTypeRegionMeans,
  cellTypeProp = cellTypeProp,
  regionProp = regionProp
)

# Ensure the rownames of the features match the order of the survival vector
featureList <- lapply(featureList, function(x) x[names(kerenSurv), ])


set.seed(51773)

kerenCV <- crossValidate(
  measurements = featureList,
  outcome = kerenSurv,
  classifier = "CoxPH",
  selectionMethod = "CoxPH",
  nFolds = 5,
  nFeatures = 10,
  nRepeats = 20,
  nCores = 1
)

## ----performancePlot----------------------------------------------------------
# Calculate AUC for each cross-validation repeat and plot.
performancePlot(kerenCV,
  characteristicsList = list(x = "Assay Name")
) +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

