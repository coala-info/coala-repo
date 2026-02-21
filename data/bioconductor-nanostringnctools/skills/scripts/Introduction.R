# Code example from 'Introduction' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width = 5,
  fig.height = 4,
  dpi=200
)

## ----message=FALSE, warning=FALSE---------------------------------------------
#devtools::install_github("Nanostring-Biostats/NanoStringNCTools", 
#                         force = TRUE, ref = "master")

library(NanoStringNCTools)

## ----message=FALSE, warning=FALSE---------------------------------------------
library(ggthemes)
library(ggiraph)
library(pheatmap)

## -----------------------------------------------------------------------------
# set your file location
datadir <- system.file("extdata", "3D_Bio_Example_Data",
                       package = "NanoStringNCTools")
# read in RCC files
rcc_files <- dir(datadir, pattern = "SKMEL.*\\.RCC$", full.names = TRUE)
# read in RLF file
rlf_file <- file.path(datadir, "3D_SolidTumor_Sig.rlf")
# read in sample annotation
sample_annotation <- file.path(datadir, "3D_SolidTumor_PhenoData.csv")
# load all the input files into demoData (S4 object)
demoData <- readNanoStringRccSet(rcc_files, rlfFile = rlf_file, 
                                 phenoDataFile = sample_annotation)
class( demoData )
isS4( demoData )
is( demoData, "ExpressionSet" )
demoData

## ----warning = FALSE----------------------------------------------------------
# access the first two rows of the count matrix
head(assayData(demoData)[["exprs"]], 2)

# access the first two rows of the pheno data
head(pData(demoData), 2)

# access the protocol data
protocolData(demoData)

# access the first three rows of the probe information
fData(demoData)[1:3, ]

# access the available pheno and protocol data variables
svarLabels(demoData)
head(sData(demoData), 2)

# access RLF information
annotation(demoData)

## -----------------------------------------------------------------------------
# assign design information
design(demoData) <- ~ `Treatment`
design(demoData)

# check the column names to use as labels for the features and samples respectively
dimLabels(demoData)

# Change SampleID to Sample ID
protocolData(demoData)[["Sample ID"]] <- sampleNames(demoData)
dimLabels(demoData)[2] <- "Sample ID"
dimLabels(demoData)

## -----------------------------------------------------------------------------
# summarize log2 counts for each feature
head(summary(demoData, MARGIN = 1), 2)

# summarize log2 counts for each sample
head(summary(demoData, MARGIN = 2), 2)

# check the unique levels in Treatment group
unique(sData(demoData)$"Treatment")

# summarize log2 counts for each VEM sample
head(summary(demoData, MARGIN = 2, GROUP = "Treatment")$VEM, 2)

# summarize log2 counts for each DMSO sample
head(summary(demoData, MARGIN = 2, GROUP = "Treatment")$"DMSO", 2)

# summarize counts for each DMSO sample, without log2 transformation
head(summary(demoData, MARGIN = 2, GROUP = "Treatment", log2 = FALSE)$"DMSO", 2)

## ----warning = FALSE----------------------------------------------------------
# check the number of samples in the dataset
length(sampleNames(demoData))

# check the number of VEM samples in the dataset
length(sampleNames(subset(demoData, select = phenoData(demoData)[["Treatment"]] == "VEM")))

# check the dimension of the expression matrix
dim(exprs(demoData))

# check the dimension of the expression matrix for VEM samples and endogenous genes only
dim(exprs(endogenousSubset(demoData, select = phenoData(demoData)[["Treatment"]] == "VEM")))

# housekeepingSubset() only selects housekeeper genes
with(housekeepingSubset(demoData), table(CodeClass))

# negativeControlSubset() only selects negative probes
with(negativeControlSubset(demoData), table(CodeClass))

# positiveControlSubset() only selects positive probes
with(positiveControlSubset(demoData), table(CodeClass))

# controlSubset() selects all control probes
with(controlSubset(demoData), table(CodeClass))

# nonControlSubset() selects all non-control probes
with(nonControlSubset(demoData), table(CodeClass))

## -----------------------------------------------------------------------------
neg_set <- negativeControlSubset(demoData)
class(neg_set)

## -----------------------------------------------------------------------------
# calculate the log counts of gene expressions for each sample
assayDataElement(demoData, "demoElem") <- 
  assayDataApply(demoData, MARGIN=2, FUN=log, base=10, elt="exprs")
assayDataElement(demoData, "demoElem")[1:3, 1:2]

# calculate the mean of log counts for each feature
assayDataApply(demoData, MARGIN=1, FUN=mean, elt="demoElem")[1:5]

# split data by Treatment and calculate the mean of log counts for each feature
head(esBy(demoData, 
            GROUP = "Treatment", 
            FUN = function(x){ 
              assayDataApply(x, MARGIN = 1, FUN=mean, elt="demoElem") 
            }))

## ----warning = FALSE----------------------------------------------------------
demoData <- normalize(demoData, type="nSolver", fromELT = "exprs", toELT = "exprs_norm")
assayDataElement(demoData, elt = "exprs_norm")[1:3, 1:2]

## ----warning = FALSE----------------------------------------------------------
autoplot(demoData, type = "heatmap-genes", elt = "exprs_norm", heatmapGroup = c("Treatment", "BRAFGenotype"), 
         show_colnames_gene_limit = 10, show_rownames_gene_limit = 40,
         log2scale = FALSE)

## ----warning = FALSE----------------------------------------------------------
# combine negative probes and expressions together
neg_ctrls <- munge(neg_set, ~exprs)
head(neg_ctrls, 2)
class(neg_ctrls)

# combine expressions with all features
head(munge(demoData, ~exprs), 2)

# combine mapping with the dataset, store gene expressions as a matrix
munge(demoData, mapping = ~`BRAFGenotype` + GeneMatrix)

# transform the gene expressions to normalized counts
exprs_df <- transform(assayData(demoData)[["exprs_norm"]])
class(exprs_df)
exprs_df[1:3, 1:2]

## ----warning = FALSE----------------------------------------------------------
# Use the setSeqQCFlags function to set Sequencing QC Flags to your dataset. The default cutoff are displayed in the function. 
demoData <- setQCFlags(demoData,
                       qcCutoffs = list(Housekeeper = c(failingCutoff = 32, passingCutoff = 100), 
                                        Imaging = c(fovCutoff = 0.75), 
                                        BindingDensity = c(minimumBD = 0.1, maximumBD = 2.25, maximumBDSprint = 1.8), 
                                        ERCCLinearity = c(correlationValue = 0.95), 
                                        ERCCLoD = c(standardDeviations = 2)))

# show the last 6 column names in the data
tail(svarLabels(demoData))

# show the first 2 rows of the QC Flags results
head(protocolData(demoData)[["QCFlags"]], 2)

# show the first 2 rows of the QC Borderline Flags results
head(protocolData(demoData)[["QCBorderlineFlags"]], 2)

## ----warning = FALSE----------------------------------------------------------
girafe(ggobj = autoplot(demoData, type = "housekeep-geom"))

## ----warning = FALSE----------------------------------------------------------
subData <- subset(demoData, select = phenoData(demoData)[["Treatment"]] == "DMSO")
girafe(ggobj = autoplot(subData, type = "housekeep-geom"))

## ----warning = FALSE----------------------------------------------------------
girafe(ggobj = autoplot(demoData, type = "lane-bindingDensity"))

## ----warning = FALSE----------------------------------------------------------
girafe(ggobj = autoplot(demoData, type = "lane-fov"))

## ----warning = FALSE----------------------------------------------------------
girafe(ggobj = autoplot(demoData, type = "ercc-linearity"))

## ----warning=FALSE------------------------------------------------------------
girafe(ggobj = autoplot(subData, type = "ercc-lod"))

## -----------------------------------------------------------------------------
girafe( ggobj = autoplot( demoData , "boxplot-feature" , index = featureNames(demoData)[3] , elt = "exprs" ) )
autoplot( demoData , "heatmap-genes" , elt = "exprs_norm" )

## -----------------------------------------------------------------------------
sessionInfo()

