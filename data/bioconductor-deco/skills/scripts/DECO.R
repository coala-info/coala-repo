# Code example from 'DECO' vignette. See references/ for full tutorial.

## ----pre,echo=FALSE,results='hide',warning=TRUE,include=FALSE--------------
library(knitr)
opts_chunk$set(warning=TRUE, message = FALSE, cache = FALSE, fig.path = "figures/", tidy = FALSE, tidy.opts = list(width.cutoff = 60))

## ---- message = FALSE, eval = FALSE----------------------------------------
#  ## From Bioconductor repository
#  if (!requireNamespace("BiocManager", quietly = TRUE)) {
#        install.packages("BiocManager")
#    }
#  BiocManager::install("deco")
#  
#  ## Or from GitHub repository using devtools
#  BiocManager::install("devtools")
#  devtools::install_github("fjcamlab/deco")

## ---- message = FALSE------------------------------------------------------
## Loading the R package
library(deco)

# Loading ALCL dataset and example R objects
data(ALCLdata)

# to see the SummarizedExperiment object
ALCL

# to see the phenotypic information
head(colData(ALCL))

## ---- message = FALSE, results='hide'--------------------------------------
## Group-vs-group comparison
classes.ALCL <- colData(ALCL)[, "Alk.positivity"]
names(classes.ALCL) <- colnames(ALCL)
## Multiclass comparison
multiclasses.ALCL <- factor(apply(
    as.data.frame(colData(ALCL)[, c("Alk.positivity", "Type")]), 1,
    function(x) paste(x, collapse = ".")
))

## ---- message = FALSE------------------------------------------------------
# Loading library
library(curatedTCGAData)
library(MultiAssayExperiment)

# Download counts from RNAseq data
BRCA_dataset_counts <- curatedTCGAData(
    diseaseCode = "BRCA",
    assays = "RNASeqGene", dry.run = FALSE
)

# or download normalized RNAseq data
BRCA_dataset_norm <- curatedTCGAData(
    diseaseCode = "BRCA",
    assays = "RNASeq2GeneNorm", dry.run = FALSE
)

# Extract the matrix
BRCA_counts <- assay(BRCA_dataset_counts)
BRCA_norm <- assay(BRCA_dataset_norm)

dim(BRCA_counts)
dim(BRCA_norm)

# Apply log-scale and normalization if needed...
BRCA_exp <- limma::voom(BRCA_counts)$E # logCPMs
BRCA_exp <- log2(BRCA_norm + 1) #logRPKMs


## ---- message = FALSE------------------------------------------------------
# Download counts from RNAseq data of miRNAs
BRCA_dataset_counts_mirna <- curatedTCGAData(
    diseaseCode = "BRCA",
    assays = "miRNASeqGene", dry.run = FALSE
)

# Extract the matrix
BRCA_counts_mirna <- assay(BRCA_dataset_counts_mirna)

dim(BRCA_counts_mirna)

# Apply log-scale and normalization if needed...
BRCA_exp_mirna <- limma::voom(BRCA_counts_mirna)$E # logCPMs

## ---- message = FALSE------------------------------------------------------
library(BiocParallel)

# Non-parallel computing
bpparam <- SerialParam()

# Computing in shared memory
bpparam <- MulticoreParam()

## ---- message = FALSE, results='hide'--------------------------------------
## if gene annotation was required (annot = TRUE or rm.xy = TRUE)
library(Homo.sapiens)

## ---- message = FALSE, results='hide'--------------------------------------
## number of samples per category
table(classes.ALCL)
# classes.ALCL
#   neg   pos
#    20    11

## example of SUPERVISED or BINARY design with Affymetrix microarrays data
# set annot = TRUE if annotation is required and corresponding library was loaded
sub_binary <- decoRDA(
    data = assay(ALCL), classes = classes.ALCL, q.val = 0.01,
    iterations = 1000, rm.xy = FALSE, r = NULL, 
    control = "pos", annot = FALSE, bpparam = bpparam,
    id.type = "ENSEMBL", pack.db = "Homo.sapiens"
)

## ---- message = FALSE------------------------------------------------------
dim(sub_binary$incidenceMatrix)

## ---- message = FALSE, results='hide'--------------------------------------
# if gene annotation will be required (annot = TRUE or rm.xy = TRUE)
# library(Homo.sapiens)
# example of UNSUPERVISED design with RNA-seq data (log2[RPKM])
sub_uns <- decoRDA(
    data = assay(ALCL), q.val = 0.05, r = NULL,
    iterations = 1000, annot = FALSE, rm.xy = FALSE,
    bpparam = bpparam, id.type = "ENSEMBL", 
    pack.db = "Homo.sapiens"
)

## ---- message = FALSE, results='hide'--------------------------------------
# number of samples per category
table(multiclasses.ALCL)
# multiclasses.ALCL
# neg.ALCL neg.PTCL pos.ALCL
#       12        8       11

# example of MULTICLASS design with RNA-seq data (log2[RPKM])
sub_multiclass <- decoRDA(
    data = assay(ALCL), classes = multiclasses.ALCL, q.val = 0.05,
    r = NULL, iterations = 1000, annot = FALSE, 
    bpparam = bpparam, rm.xy = FALSE,
    id.type = "ENSEMBL", pack.db = "Homo.sapiens"
)

## ---- message = FALSE------------------------------------------------------
# load the annotation package
library(Homo.sapiens) # for human

AnnotationDbi::columns(Homo.sapiens)

## ---- message = FALSE, results='hide'--------------------------------------
# It can be applied to any subsampling design (BINARY, MULTICLASS, or UNSUPERVISED)
deco_results <- decoNSCA(
    sub = sub_binary, v = 80, method = "ward.D", bpparam = bpparam,
    k.control = 3, k.case = 3, samp.perc = 0.05, rep.thr = 1
)

deco_results_multiclass <- decoNSCA(
    sub = sub_multiclass, v = 80, method = "ward.D", bpparam = bpparam,
    k.control = 3, k.case = 3, samp.perc = 0.05, rep.thr = 1
)

deco_results_uns <- decoNSCA(
    sub = sub_uns, v = 80, method = "ward.D", bpparam = bpparam,
    k.control = 3, k.case = 3, samp.perc = 0.05, rep.thr = 1
)

## ---- message = FALSE------------------------------------------------------
slotNames(deco_results)

## ---- warning=TRUE---------------------------------------------------------
resultsTable <- featureTable(deco_results)
dim(resultsTable)

# Statistics of top-10 features
resultsTable[1:10, ]

## ---- warning=TRUE---------------------------------------------------------
# If SUPERVISED analysis
sampleSubclass <- rbind(
    NSCAcluster(deco_results)$Control$samplesSubclass,
    NSCAcluster(deco_results)$Case$samplesSubclass
)
# If UNSUPERVISED analysis
sampleSubclass <- NSCAcluster(deco_results_uns)$All$samplesSubclass

## Sample subclass membership
head(sampleSubclass)

## ---- warning=TRUE, results='hide'-----------------------------------------
## Example of summary of a 'deco' R object (ALCL supervised/binary example)

summary(deco_results)
# Decomposing Heterogeneous Cohorts from Omic profiling: DECO
# Summary:
# Analysis design: Supervised
# Classes compared:
# neg pos
#  20  11
#            RDA.q.value Minimum.repeats Percentage.of.affected.samples NSCA.variability
# Thresholds        0.01          10.00                            5.00               86
# Number of features out of thresholds: 297
# Feature profile table:
# Complete Majority Minority    Mixed
#       12       87      197        1
# Number of samples affected: 31
# Number of positive RDA comparisons: 1999
# Number of total RDA comparisons: 10000

## ---- warning=TRUE, eval=FALSE---------------------------------------------
#  ### Example of decoReport using microarray dataset
#  decoReport(deco_results, sub_binary,
#      pdf.file = "Report.pdf",
#      info.sample = as.data.frame(colData(ALCL))[, c(
#          "Type", "Blood.paper"
#      ), drop = FALSE],
#      cex.names = 0.3, print.annot = TRUE
#  )

## ---- warning=TRUE, results='hide', eval=FALSE-----------------------------
#  # Extracting the h-statistic matrix used for
#  # the stratification and the feature profile's plot
#  
#  # All samples if 'multiclass' or 'unsupervised' comparison
#  hMatrix <- NSCAcluster(deco_results_uns)$All$NSCA$h
#  
#  # Control categories if 'binary' comparison
#  hMatrix <- NSCAcluster(deco_results)$Control$NSCA$h
#  
#  # Case categories if 'binary' comparison
#  hMatrix <- NSCAcluster(deco_results)$Case$NSCA$h
#  
#  dim(hMatrix)

## ---- warning=TRUE, eval=FALSE---------------------------------------------
#  ## Opening a new PDF file
#  pdf("HeatmapH_example.pdf", width = 16, height = 12)
#  
#  ## Heatmap with h-statistic matrix and biclustering of features-samples.
#  plotHeatmapH(
#    deco = deco_results,
#    info.sample = as.data.frame(colData(ALCL))[, c(9, 8, 10)],
#    cex.names = 0.3, print.annot = FALSE
#  )
#  
#  ## Closing the PDF file
#  dev.off()

## ---- warning=TRUE---------------------------------------------------------
## Association plot between phenotype and DECO subclasses
plotAssociationH(
    deco = deco_results, 
    info.sample = multiclasses.ALCL
)

## ---- warning=TRUE, eval=FALSE---------------------------------------------
#  ## ALK and ERBB4 feature profiles
#  # ALK: ENSG00000171094
#  # ERBB4: ENSG00000178568
#  plotDECOProfile(
#      deco = deco_results, id = c("ENSG00000171094", "ENSG00000178568"),
#      data = assay(ALCL), pdf.file = "ALCL_profiles.pdf",
#      cex.samples = 2, info.sample = as.data.frame(colData(ALCL))[, c(9, 8, 10)]
#  )

## ---- warning=TRUE---------------------------------------------------------
## Feature to represent
id <- featureTable(deco_results)[1, "ID"]

#### Comparing DECO subclasses against source of samples.
plotGainingH(
  deco_results, data = assay(ALCL), ids = id, 
  print.annot = FALSE, orig.classes = FALSE
)

