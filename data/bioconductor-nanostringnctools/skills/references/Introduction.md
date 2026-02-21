# Introduction to the NanoStringRCCSet Class

#### David Henderson, Patrick Aboyoun, Nicole Ortogero, Zhi Yang, Jason Reeves, Kara Gorman, Rona Vitancol, Thomas Smith, Yuqi Ren

#### 2025-10-30

## Introduction

The NanostringNCTools package enables independent analysis of NanoString nCounter data (e.g. RCC/RLF data) in R.

In this vignette we will:

Create a Nanostring data object (e.g. NanoStringRCCSet) integrating RCC + RLF + Annotation data Learn to summarize, subset, transform the data object Perform and visualize quality control assessments of the data Perform data normalization for downstream analyses

The NanoStringRCCSet was inherited from Biobase’s ExpressionSet class. The NanoStringRCCSet class was designed to encapsulate data and corresponding methods for Nanostring RCC files generated from the NanoString nCounter platform.

## Loading Packages

First step in using the NanoStringNCTools package is to install the package and load it to allow users access to the NanoStringRCCSet class.

```
#devtools::install_github("Nanostring-Biostats/NanoStringNCTools",
#                         force = TRUE, ref = "master")

library(NanoStringNCTools)
```

Then you also need to load some additional packages for vignette plotting.

```
library(ggthemes)
library(ggiraph)
library(pheatmap)
```

## Building a NanoStringRCCSet from .RCC files

Next step is to load the RCC, RLF and the sample annotation file using readNanoStringRccSet function. You can save RCC, RLF and the sample annotation file in one folder for easy access and set this location as your datadir.

```
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
#> [1] "NanoStringRccSet"
#> attr(,"package")
#> [1] "NanoStringNCTools"
isS4( demoData )
#> [1] TRUE
is( demoData, "ExpressionSet" )
#> [1] TRUE
demoData
#> NanoStringRccSet (storageMode: lockedEnvironment)
#> assayData: 397 features, 12 samples
#>   element names: exprs
#> protocolData
#>   sampleNames: SKMEL2-DMSO-8h-R1_04.RCC SKMEL2-DMSO-8h-R2_04.RCC ...
#>     SKMEL28-VEM-8h-R3_10.RCC (12 total)
#>   varLabels: FileVersion SoftwareVersion ... CartridgeBarcode (17
#>     total)
#>   varMetadata: labelDescription
#> phenoData
#>   sampleNames: SKMEL2-DMSO-8h-R1_04.RCC SKMEL2-DMSO-8h-R2_04.RCC ...
#>     SKMEL28-VEM-8h-R3_10.RCC (12 total)
#>   varLabels: Treatment BRAFGenotype
#>   varMetadata: labelDescription
#> featureData
#>   featureNames: Endogenous_TP53_NM_000546.2
#>     Endogenous_IL22RA2_NM_181310.1 ... SNV_REF_PIK3CA Ref (exon
#>     10)|hg19|+|chr3:178936060-178936141_nRef_00032.1 (397 total)
#>   fvarLabels: CodeClass GeneName ... BarcodeComments (10 total)
#>   fvarMetadata: labelDescription
#> experimentData: use 'experimentData(object)'
#> Annotation: 3D_SolidTumor_Sig
#> signature: none
```

## Accessing and Assigning NanoStringRCCSet Data Members

After loading all the input files, they are stored in a S4 object called demoData. Alongside the accessors associated with the ExpressionSet class, NanoStringRCCSet objects have unique additional assignment and accessor methods faciliting common ways to view nCounter data and associated labels. You can then save it to a csv file if you need to.

* The dimLabels slot provides the column names to use as labels for the features and samples repectively in the plots.
* The signatures slot contains signature definitions
* The experimentData slot stores structured information about the experiment.
* The assayData slot stores the expression values. It can store muultiple count matrices.
* The phenoData slot stores annotation data about the samples. You can add these as columns in the annotation file.
* The featureData slot stores information about the targets or probes for the panel used.
* The annotation slot stores the name of the RLF data.
* The protocolData slot stores information about the assay run. This information is read from the RCC files plus the annotations columns you specified in the protocolData argument.

```
# access the first two rows of the count matrix
head(assayData(demoData)[["exprs"]], 2)
#>                                SKMEL2-DMSO-8h-R1_04.RCC
#> Endogenous_TP53_NM_000546.2                         347
#> Endogenous_IL22RA2_NM_181310.1                        5
#>                                SKMEL2-DMSO-8h-R2_04.RCC
#> Endogenous_TP53_NM_000546.2                         601
#> Endogenous_IL22RA2_NM_181310.1                        9
#>                                SKMEL2-DMSO-8h-R3_04.RCC SKMEL2-VEM-8h-R1_10.RCC
#> Endogenous_TP53_NM_000546.2                         270                     588
#> Endogenous_IL22RA2_NM_181310.1                        2                      10
#>                                SKMEL2-VEM-8h-R2_10.RCC SKMEL2-VEM-8h-R3_10.RCC
#> Endogenous_TP53_NM_000546.2                        810                     519
#> Endogenous_IL22RA2_NM_181310.1                       3                       2
#>                                SKMEL28-DMSO-8h-R1_04.RCC
#> Endogenous_TP53_NM_000546.2                          609
#> Endogenous_IL22RA2_NM_181310.1                         8
#>                                SKMEL28-DMSO-8h-R2_04.RCC
#> Endogenous_TP53_NM_000546.2                          722
#> Endogenous_IL22RA2_NM_181310.1                         5
#>                                SKMEL28-DMSO-8h-R3_04.RCC
#> Endogenous_TP53_NM_000546.2                          608
#> Endogenous_IL22RA2_NM_181310.1                         1
#>                                SKMEL28-VEM-8h-R1_10.RCC
#> Endogenous_TP53_NM_000546.2                         603
#> Endogenous_IL22RA2_NM_181310.1                       11
#>                                SKMEL28-VEM-8h-R2_10.RCC
#> Endogenous_TP53_NM_000546.2                         618
#> Endogenous_IL22RA2_NM_181310.1                       10
#>                                SKMEL28-VEM-8h-R3_10.RCC
#> Endogenous_TP53_NM_000546.2                         519
#> Endogenous_IL22RA2_NM_181310.1                        7

# access the first two rows of the pheno data
head(pData(demoData), 2)
#>                          Treatment BRAFGenotype
#> SKMEL2-DMSO-8h-R1_04.RCC      DMSO        wt/wt
#> SKMEL2-DMSO-8h-R2_04.RCC      DMSO        wt/wt

# access the protocol data
protocolData(demoData)
#> An object of class 'AnnotatedDataFrame'
#>   sampleNames: SKMEL2-DMSO-8h-R1_04.RCC SKMEL2-DMSO-8h-R2_04.RCC ...
#>     SKMEL28-VEM-8h-R3_10.RCC (12 total)
#>   varLabels: FileVersion SoftwareVersion ... CartridgeBarcode (17
#>     total)
#>   varMetadata: labelDescription

# access the first three rows of the probe information
fData(demoData)[1:3, ]
#>                                 CodeClass GeneName   Accession IsControl
#> Endogenous_TP53_NM_000546.2    Endogenous     TP53 NM_000546.2     FALSE
#> Endogenous_IL22RA2_NM_181310.1 Endogenous  IL22RA2 NM_181310.1     FALSE
#> Endogenous_IL2_NM_000586.2     Endogenous      IL2 NM_000586.2     FALSE
#>                                ControlConc
#> Endogenous_TP53_NM_000546.2             NA
#> Endogenous_IL22RA2_NM_181310.1          NA
#> Endogenous_IL2_NM_000586.2              NA
#>                                                                                                                           TargetSeq
#> Endogenous_TP53_NM_000546.2    GGGGAGCAGGGCTCACTCCAGCCACCTGAAGTCCAAAAAGGGTCAGTCTACCTCCCGCCATAAAAAACTCATGTTCAAGACAGAAGGGCCTGACTCAGAC
#> Endogenous_IL22RA2_NM_181310.1 CACTTGCAACCATGATGCCTAAACATTGCTTTCTAGGCTTCCTCATCAGTTTCTTCCTTACTGGTGTAGCAGGAACTCAGTCAACGCATGAGTCTCTGAA
#> Endogenous_IL2_NM_000586.2     AGGATGCAACTCCTGTCTTGCATTGCACTAAGTCTTGCACTTGTCACAAACAGTGCACCTACTTCAAGTTCTACAAAGAAAACACAGCTACAACTGGAGC
#>                                Barcode          ProbeID Species BarcodeComments
#> Endogenous_TP53_NM_000546.2     BGBGYR NM_000546.2:1330      Hs      ENDOGENOUS
#> Endogenous_IL22RA2_NM_181310.1  BGBRBR  NM_181310.1:290      Hs      ENDOGENOUS
#> Endogenous_IL2_NM_000586.2      BGBRGR  NM_000586.2:300      Hs      ENDOGENOUS

# access the available pheno and protocol data variables
svarLabels(demoData)
#>  [1] "Treatment"        "BRAFGenotype"     "FileVersion"      "SoftwareVersion"
#>  [5] "SystemType"       "SampleID"         "SampleOwner"      "SampleComments"
#>  [9] "SampleDate"       "SystemAPF"        "AssayType"        "LaneID"
#> [13] "FovCount"         "FovCounted"       "ScannerID"        "StagePosition"
#> [17] "BindingDensity"   "CartridgeID"      "CartridgeBarcode"
head(sData(demoData), 2)
#>                          Treatment BRAFGenotype FileVersion SoftwareVersion
#> SKMEL2-DMSO-8h-R1_04.RCC      DMSO        wt/wt         1.7         4.0.0.3
#> SKMEL2-DMSO-8h-R2_04.RCC      DMSO        wt/wt         1.7         4.0.0.3
#>                          SystemType        SampleID SampleOwner  SampleComments
#> SKMEL2-DMSO-8h-R1_04.RCC       Gen2 SKMEL2-DMSO-8hr             DNA-RNA-Protein
#> SKMEL2-DMSO-8h-R2_04.RCC       Gen2 SKMEL2-DMSO-8hr             DNA-RNA-Protein
#>                          SampleDate SystemAPF AssayType LaneID FovCount
#> SKMEL2-DMSO-8h-R1_04.RCC 2017-01-13   n6_vDV1      <NA>      4      280
#> SKMEL2-DMSO-8h-R2_04.RCC 2017-02-07   n6_vDV1      <NA>      4      280
#>                          FovCounted ScannerID StagePosition BindingDensity
#> SKMEL2-DMSO-8h-R1_04.RCC        268 1207C0049             3           0.80
#> SKMEL2-DMSO-8h-R2_04.RCC        280 1207C0049             6           1.03
#>                                     CartridgeID CartridgeBarcode
#> SKMEL2-DMSO-8h-R1_04.RCC   AGBT-3DBio-C1-SKMEL2
#> SKMEL2-DMSO-8h-R2_04.RCC AGBT-3DBio-3-C1-SKMEL2

# access RLF information
annotation(demoData)
#> [1] "3D_SolidTumor_Sig"
```

Design information can be assigned to the NanoStringRCCSet object, as well as feature and sample labels to use for NanoStringRCCSet plotting methods.

```
# assign design information
design(demoData) <- ~ `Treatment`
design(demoData)
#> ~Treatment

# check the column names to use as labels for the features and samples respectively
dimLabels(demoData)
#> [1] "GeneName" "SampleID"

# Change SampleID to Sample ID
protocolData(demoData)[["Sample ID"]] <- sampleNames(demoData)
dimLabels(demoData)[2] <- "Sample ID"
dimLabels(demoData)
#> [1] "GeneName"  "Sample ID"
```

## Summarizing NanoString nCounter Data

Users can easily summarize count results using the summary method. Data summaries can be generated across features or samples. Labels can be used to generate summaries based on feature or sample groupings.

* MARGIN: 1 (for loop over feature) or 2 (for loop over sample).
* GROUP: summarize by a group.
* log2=TRUE: the summary statistics are Geometric Mean with thresholding at 0.5, Size Factor (2^(`MeanLog2` - mean(`MeanLog2`))), Mean of Log2 with thresholding at 0.5, Standard Deviation of Log2 with thresholding at 0.5, Minimum, First Quartile, Median, Third Quartile, and Maximum.
* log2=FALSE: the summary statistics are Mean, Standard Deviation, Skewness, Excess Kurtosis, Minimum, First Quartile, Median, Third Quartile, and Maximum.

```
# summarize log2 counts for each feature
head(summary(demoData, MARGIN = 1), 2)
#>                                  GeomMean SizeFactor MeanLog2    SDLog2 Min
#> Endogenous_TP53_NM_000546.2    547.134439 5.88657439 9.095752 0.4357479 270
#> Endogenous_IL22RA2_NM_181310.1   4.842601 0.05210115 2.275782 1.1326693   1
#>                                    Q1 Median     Q3 Max
#> Endogenous_TP53_NM_000546.2    519.00    602 611.25 810
#> Endogenous_IL22RA2_NM_181310.1   2.75      6   9.25  11

# summarize log2 counts for each sample
head(summary(demoData, MARGIN = 2), 2)
#>                           GeomMean SizeFactor MeanLog2   SDLog2 Min Q1 Median
#> SKMEL2-DMSO-8h-R1_04.RCC  81.91473  0.8813138 6.356051 3.548682   0 11     42
#> SKMEL2-DMSO-8h-R2_04.RCC 111.61733  1.2008817 6.802417 3.571600   2 13     54
#>                           Q3   Max
#> SKMEL2-DMSO-8h-R1_04.RCC 525 30467
#> SKMEL2-DMSO-8h-R2_04.RCC 786 79362

# check the unique levels in Treatment group
unique(sData(demoData)$"Treatment")
#> [1] "DMSO" "VEM"

# summarize log2 counts for each VEM sample
head(summary(demoData, MARGIN = 2, GROUP = "Treatment")$VEM, 2)
#>                         GeomMean SizeFactor MeanLog2   SDLog2 Min Q1 Median
#> SKMEL2-VEM-8h-R1_10.RCC 105.0406   1.113396 6.714804 3.543809   0 14     52
#> SKMEL2-VEM-8h-R2_10.RCC 105.2725   1.115854 6.717985 3.652488   1 11     56
#>                           Q3   Max
#> SKMEL2-VEM-8h-R1_10.RCC  789 40330
#> SKMEL2-VEM-8h-R2_10.RCC 1004 44614

# summarize log2 counts for each DMSO sample
head(summary(demoData, MARGIN = 2, GROUP = "Treatment")$"DMSO", 2)
#>                           GeomMean SizeFactor MeanLog2   SDLog2 Min Q1 Median
#> SKMEL2-DMSO-8h-R1_04.RCC  81.91473  0.8945544 6.356051 3.548682   0 11     42
#> SKMEL2-DMSO-8h-R2_04.RCC 111.61733  1.2189233 6.802417 3.571600   2 13     54
#>                           Q3   Max
#> SKMEL2-DMSO-8h-R1_04.RCC 525 30467
#> SKMEL2-DMSO-8h-R2_04.RCC 786 79362

# summarize counts for each DMSO sample, without log2 transformation
head(summary(demoData, MARGIN = 2, GROUP = "Treatment", log2 = FALSE)$"DMSO", 2)
#>                              Mean       SD Skewness Kurtosis Min Q1 Median  Q3
#> SKMEL2-DMSO-8h-R1_04.RCC 1335.766 3763.740 4.327986 21.46799   0 11     42 525
#> SKMEL2-DMSO-8h-R2_04.RCC 1828.778 6226.835 7.636919 75.77340   2 13     54 786
#>                            Max
#> SKMEL2-DMSO-8h-R1_04.RCC 30467
#> SKMEL2-DMSO-8h-R2_04.RCC 79362
```

## Subsetting NanoStringRCCSet Objects

Common subsetting methods including those to separate endogenous features from controls are provided with NanoStringRCCSet objects. In addition, users can use the subset or select arguments to further subset by feature or sample, respectively.

```
# check the number of samples in the dataset
length(sampleNames(demoData))
#> [1] 12

# check the number of VEM samples in the dataset
length(sampleNames(subset(demoData, select = phenoData(demoData)[["Treatment"]] == "VEM")))
#> [1] 6

# check the dimension of the expression matrix
dim(exprs(demoData))
#> [1] 397  12

# check the dimension of the expression matrix for VEM samples and endogenous genes only
dim(exprs(endogenousSubset(demoData, select = phenoData(demoData)[["Treatment"]] == "VEM")))
#> [1] 180   6

# housekeepingSubset() only selects housekeeper genes
with(housekeepingSubset(demoData), table(CodeClass))
#> CodeClass
#> Housekeeping
#>           12

# negativeControlSubset() only selects negative probes
with(negativeControlSubset(demoData), table(CodeClass))
#> CodeClass
#> Negative
#>        6

# positiveControlSubset() only selects positive probes
with(positiveControlSubset(demoData), table(CodeClass))
#> CodeClass
#> Positive
#>        6

# controlSubset() selects all control probes
with(controlSubset(demoData), table(CodeClass))
#> CodeClass
#>      Housekeeping          Negative PROTEIN_CELL_NORM       PROTEIN_NEG
#>                12                 6                 1                 2
#>          Positive     SNV_INPUT_CTL           SNV_NEG       SNV_PCR_CTL
#>                 6                 3                 6                 3
#>           SNV_POS       SNV_UDG_CTL
#>                 6                 2

# nonControlSubset() selects all non-control probes
with(nonControlSubset(demoData), table(CodeClass))
#> CodeClass
#> Endogenous    PROTEIN    SNV_REF    SNV_VAR
#>        180         26         40        104
```

The negativeControlSubset function subsets the data object and includes only the probes with Negative Code Class.
You can see the Code Class information in the featureData slot.

```
neg_set <- negativeControlSubset(demoData)
class(neg_set)
#> [1] "NanoStringRccSet"
#> attr(,"package")
#> [1] "NanoStringNCTools"
```

## Apply Functions Across Assay Data

Similar to the ExpressionSet’s esApply function, an equivalent method is available with NanoStringRCCSet objects. Functions can be applied to assay data feature- or sample-wise.

Add the demoElem data which is computed as the logarithm of the count matrix (exprs) into the demoData by using assayDataApply function. The accessor function assayDataElement from eSet returns matrix element from assayData slot of object.

* MARGIN: 1 (loop over the feature) or 2 (loop over the sample).
* FUN: the function you want to apply on the data, e.g. log, mean, etc.
* elt: refers to the element you want to apply on in the demoData.

```
# calculate the log counts of gene expressions for each sample
assayDataElement(demoData, "demoElem") <-
  assayDataApply(demoData, MARGIN=2, FUN=log, base=10, elt="exprs")
assayDataElement(demoData, "demoElem")[1:3, 1:2]
#>                                SKMEL2-DMSO-8h-R1_04.RCC
#> Endogenous_TP53_NM_000546.2                    2.540329
#> Endogenous_IL22RA2_NM_181310.1                 0.698970
#> Endogenous_IL2_NM_000586.2                     0.301030
#>                                SKMEL2-DMSO-8h-R2_04.RCC
#> Endogenous_TP53_NM_000546.2                   2.7788745
#> Endogenous_IL22RA2_NM_181310.1                0.9542425
#> Endogenous_IL2_NM_000586.2                    0.9030900

# calculate the mean of log counts for each feature
assayDataApply(demoData, MARGIN=1, FUN=mean, elt="demoElem")[1:5]
#>    Endogenous_TP53_NM_000546.2 Endogenous_IL22RA2_NM_181310.1
#>                      2.7380941                      0.6850787
#>     Endogenous_IL2_NM_000586.2    Endogenous_CCR5_NM_000579.1
#>                      0.5595554                           -Inf
#> Endogenous_PRLR_NM_001204318.1
#>                      0.9411847

# split data by Treatment and calculate the mean of log counts for each feature
head(esBy(demoData,
            GROUP = "Treatment",
            FUN = function(x){
              assayDataApply(x, MARGIN = 1, FUN=mean, elt="demoElem")
            }))
#>                                     DMSO       VEM
#> Endogenous_TP53_NM_000546.2    2.6962710 2.7799171
#> Endogenous_IL22RA2_NM_181310.1 0.5927171 0.7774403
#> Endogenous_IL2_NM_000586.2     0.4808935 0.6382173
#> Endogenous_CCR5_NM_000579.1         -Inf 0.7821118
#> Endogenous_PRLR_NM_001204318.1 1.0082754 0.8740940
#> Endogenous_LIF_NM_002309.3     1.8067671 1.4661876
```

There is also a preloaded nCounter normalization method that comes with the NanoStringRCCSet class. This includes the default normalization performed in nSolver.

* type: data type of the object. Values maybe RNA, protein.
* fromELT: name of the assayDataElement to normalize.
* toELT: name of the assayDataElement to store normalized values.

```
demoData <- normalize(demoData, type="nSolver", fromELT = "exprs", toELT = "exprs_norm")
assayDataElement(demoData, elt = "exprs_norm")[1:3, 1:2]
#>                                SKMEL2-DMSO-8h-R1_04.RCC
#> Endogenous_TP53_NM_000546.2                    8.793776
#> Endogenous_IL22RA2_NM_181310.1                 2.935795
#> Endogenous_IL2_NM_000586.2                     1.935795
#>                                SKMEL2-DMSO-8h-R2_04.RCC
#> Endogenous_TP53_NM_000546.2                    9.023754
#> Endogenous_IL22RA2_NM_181310.1                 3.112062
#> Endogenous_IL2_NM_000586.2                     2.960059
```

Below is a heatmap of log normalized data generated by NanoStringRCCSet autoplot method with unsupervised clustering dendrograms. Each row of the heatmap represents a gene and each column represents a sample. Users can custom the heatmap by setting different parameters.

* type: reference the type of plot to generate, in this case, “heatmap-genes”.
* elt: the name of the expression matrix, i.e. the data you used to generate the plot.
* heatmapGroup: referencing pData columns to color samples by in heatmap.
* show\_colnames\_gene\_limit: determine the number of features to display column-wise. In this case, the number of samples is larger than the limit, no column names will be displayed.
* show\_rownames\_gene\_limit: determine the number of features to display row-wise. In this case, the number of genes is larger than the limit, no row names will be displayed.
* log2scale: indicating expression data is on log2 scale

```
autoplot(demoData, type = "heatmap-genes", elt = "exprs_norm", heatmapGroup = c("Treatment", "BRAFGenotype"),
         show_colnames_gene_limit = 10, show_rownames_gene_limit = 40,
         log2scale = FALSE)
```

![](data:image/png;base64...)

## Transforming NanoStringRCCSet Data to Data Frames

The NanoStringRCCSet munge function helps users generate data frames for downstream modeling and visualization. This combines available features and samples into a long format. There is also a transform method, which functions similarly to the base transform function.

```
# combine negative probes and expressions together
neg_ctrls <- munge(neg_set, ~exprs)
head(neg_ctrls, 2)
#>                      FeatureName               SampleName exprs
#> 1 Negative_NEG_C(0)_ERCC_00019.1 SKMEL2-DMSO-8h-R1_04.RCC     9
#> 2 Negative_NEG_D(0)_ERCC_00076.1 SKMEL2-DMSO-8h-R1_04.RCC     9
class(neg_ctrls)
#> [1] "data.frame"

# combine expressions with all features
head(munge(demoData, ~exprs), 2)
#>                      FeatureName               SampleName exprs
#> 1    Endogenous_TP53_NM_000546.2 SKMEL2-DMSO-8h-R1_04.RCC   347
#> 2 Endogenous_IL22RA2_NM_181310.1 SKMEL2-DMSO-8h-R1_04.RCC     5

# combine mapping with the dataset, store gene expressions as a matrix
munge(demoData, mapping = ~`BRAFGenotype` + GeneMatrix)
#> DataFrame with 12 rows and 2 columns
#>                           BRAFGenotype   GeneMatrix
#>                            <character>     <matrix>
#> SKMEL2-DMSO-8h-R1_04.RCC         wt/wt  347:5:2:...
#> SKMEL2-DMSO-8h-R2_04.RCC         wt/wt  601:9:8:...
#> SKMEL2-DMSO-8h-R3_04.RCC         wt/wt  270:2:1:...
#> SKMEL2-VEM-8h-R1_10.RCC          wt/wt 588:10:5:...
#> SKMEL2-VEM-8h-R2_10.RCC          wt/wt  810:3:5:...
#> ...                                ...          ...
#> SKMEL28-DMSO-8h-R2_04.RCC      mut/mut  722:5:3:...
#> SKMEL28-DMSO-8h-R3_04.RCC      mut/mut  608:1:4:...
#> SKMEL28-VEM-8h-R1_10.RCC       mut/mut 603:11:6:...
#> SKMEL28-VEM-8h-R2_10.RCC       mut/mut 618:10:9:...
#> SKMEL28-VEM-8h-R3_10.RCC       mut/mut  519:7:1:...

# transform the gene expressions to normalized counts
exprs_df <- transform(assayData(demoData)[["exprs_norm"]])
class(exprs_df)
#> [1] "data.frame"
exprs_df[1:3, 1:2]
#>                                SKMEL2-DMSO-8h-R1_04.RCC
#> Endogenous_TP53_NM_000546.2                    8.793776
#> Endogenous_IL22RA2_NM_181310.1                 2.935795
#> Endogenous_IL2_NM_000586.2                     1.935795
#>                                SKMEL2-DMSO-8h-R2_04.RCC
#> Endogenous_TP53_NM_000546.2                    9.023754
#> Endogenous_IL22RA2_NM_181310.1                 3.112062
#> Endogenous_IL2_NM_000586.2                     2.960059
```

## Built-in Quality Control Assessment

Quality control metrics are used to assess the technical performance of the nCounter profiling assay in a study. Users can flag samples that fail QC thresholds or have borderline results based on housekeeper and ERCC expression, imaging quality, binding density. First, housekeeper genes assess sample integrity by comparing the observed value versus a predetermined threshold for suitability for data analysis. The machine performance is assessed using percentage of fields of view that were attempted versus those successfully analyzed. The binding density of the probes within the imaging area, ERCC linearity, and limit of detection are used as readouts of the efficiency and specificity of the chemistry of the assay. Any sample deemed as failing any one of these QC checkpoints will be removed from the analysis.

Additionally, QC results can be visualized using the NanoStringRCCSet autoplot method.

* type: reference the type of plot to generate.
* qcCutoffs: you can also set qcCutoffs in the autoplot function. Since it has been set in the setQCFlags function, you don’t need to set this parameter again in autoplot.

```
# Use the setSeqQCFlags function to set Sequencing QC Flags to your dataset. The default cutoff are displayed in the function.
demoData <- setQCFlags(demoData,
                       qcCutoffs = list(Housekeeper = c(failingCutoff = 32, passingCutoff = 100),
                                        Imaging = c(fovCutoff = 0.75),
                                        BindingDensity = c(minimumBD = 0.1, maximumBD = 2.25, maximumBDSprint = 1.8),
                                        ERCCLinearity = c(correlationValue = 0.95),
                                        ERCCLoD = c(standardDeviations = 2)))

# show the last 6 column names in the data
tail(svarLabels(demoData))
#> [1] "BindingDensity"    "CartridgeID"       "CartridgeBarcode"
#> [4] "Sample ID"         "QCFlags"           "QCBorderlineFlags"

# show the first 2 rows of the QC Flags results
head(protocolData(demoData)[["QCFlags"]], 2)
#>                          Imaging Binding Linearity   LoD Housekeeping
#> SKMEL2-DMSO-8h-R1_04.RCC   FALSE   FALSE     FALSE FALSE        FALSE
#> SKMEL2-DMSO-8h-R2_04.RCC   FALSE   FALSE     FALSE FALSE        FALSE

# show the first 2 rows of the QC Borderline Flags results
head(protocolData(demoData)[["QCBorderlineFlags"]], 2)
#>                          Imaging Binding Linearity   LoD Housekeeping
#> SKMEL2-DMSO-8h-R1_04.RCC   FALSE   FALSE     FALSE FALSE        FALSE
#> SKMEL2-DMSO-8h-R2_04.RCC   FALSE   FALSE     FALSE FALSE        FALSE
```

### Housekeeping Genes QC

The HK Genes QC plot shows the geometric mean of housekeeper genes in each sample. Each dot represents a sample in this plot. The sample IDs are labeled at x-axis. The corresponding geometric mean of housekeeper genes are at y-axis. If you hover mouse over a point, you can find the sample name and its geometric mean. Samples with low housekeeper signal suffer from either low sample input or low reaction efficiency. Ideally the geometric mean of counts will be above 100 for all samples, and a minimum geometric mean of 32 counts is required for analysis. Samples in-between these two thresholds are considered in the analysis, but results from these “borderline” samples should be treated with caution. In this case, all samples are above 100, so they all pass Housekeeping Genes QC.

```
girafe(ggobj = autoplot(demoData, type = "housekeep-geom"))
```

You can generate QC plots with a subset of data using the subset function. The HK Genes QC plot below only contains samples with Treatment DMSO.

```
subData <- subset(demoData, select = phenoData(demoData)[["Treatment"]] == "DMSO")
girafe(ggobj = autoplot(subData, type = "housekeep-geom"))
```

### Binding Density QC

The binding density represents the concentration of barcodes measured by the instrument in barcodes per square micron. Each dot in this QC plot represents a sample. The lane ID of samples are labeled at x-axis and the binding density is at y-axis. If you hover mouse over a dot, it will display its Sample ID, lane ID and binding density. The Digital Analyzer may not be able to distinguish each probe from the others if too many are present. The ideal range for assays run on an nCounter MAX or FLEX system is 0.1 - 2.25 spots per square micron and assays run on the nCounter SPRINT system should have a range of 0.1 - 1.8 spots per square micron. In this case, all samples are in the ideal range, so they all pass Binding Density QC.

```
girafe(ggobj = autoplot(demoData, type = "lane-bindingDensity"))
```

### Imaging QC

The Imaging QC metric reports the percentage of fields of view (FOVs) the Digital Analyzer or SPRINT was able to capture. Each dot represents a sample. The lane IDs are labeled at x-axis and the counted FOV is at y-axis. If you hover mouse over a point, it will display its sample ID, lane ID and counted FOV. At least 75% of FOVs should be successful to obtain robust data. In this case, all samples passed the 75% threshold, so they all pass Imaging QC.

```
girafe(ggobj = autoplot(demoData, type = "lane-fov"))
```

### ERCC Linearity QC

The ERCC Linearity QC metric performs a correlation analysis after Log(2) transformation of the expression values. Each line in this plot represents a sample. The concentration is labeled at x-axis and gene expressions are displayed at y-axis. If you hover mouse over a line, it will show the sample ID, concentration, gene expresson and the correlation. The correlation is tested between the known concentrations of positive control target molecules added by NanoString and the resulting Log(2) counts. Correlation values lower than 0.95 may indicate an issue with the hybridization reaction and/or assay performance. In this case, all samples have correlation values above or equal to 0.95, so they all pass ERCC linearity QC.

```
girafe(ggobj = autoplot(demoData, type = "ercc-linearity"))
```

### ERCC LOD QC

The ERCC limit of detection of the assay compares the positive control probes and the negative control probes. Specifically, it is expected that the 0.5 fM positive control probe (Pos\_E) will produce raw counts that are at least two standard deviations higher than the mean of the negative control probes (represented by the boxplot). Each dot in this plot represents a sample. The sample IDs are displayed at x-axis and the raw counts of Pos\_E are at y-axis. If you hover mouse over a point, it will show the sample ID and its Pos\_E counts. The critical value for each sample is drawn as a red horizontal line for each sample. In this case, all samples pass the LOD QC.

```
girafe(ggobj = autoplot(subData, type = "ercc-lod"))
```

## Data exploration

Further data exploration can be performed by visualizing a select feature’s expression or by getting a bird’s eye view with expression heatmaps auto-generated with unsupervised clustering dendrograms.

```
girafe( ggobj = autoplot( demoData , "boxplot-feature" , index = featureNames(demoData)[3] , elt = "exprs" ) )
```

```
autoplot( demoData , "heatmap-genes" , elt = "exprs_norm" )
#> Warning in log2t(scores): NaNs produced
```

![](data:image/png;base64...)

```
sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#> [1] pheatmap_1.0.13          ggiraph_0.9.2            ggthemes_5.1.0
#> [4] NanoStringNCTools_1.18.0 ggplot2_4.0.0            S4Vectors_0.48.0
#> [7] Biobase_2.70.0           BiocGenerics_0.56.0      generics_0.1.4
#>
#> loaded via a namespace (and not attached):
#>  [1] sass_0.4.10             fontLiberation_0.1.0    stringi_1.8.7
#>  [4] digest_0.6.37           magrittr_2.0.4          evaluate_1.0.5
#>  [7] grid_4.5.1              RColorBrewer_1.1-3      fastmap_1.2.0
#> [10] jsonlite_2.0.0          purrr_1.1.0             scales_1.4.0
#> [13] fontBitstreamVera_0.1.1 Biostrings_2.78.0       jquerylib_0.1.4
#> [16] cli_3.6.5               rlang_1.1.6             fontquiver_0.2.1
#> [19] crayon_1.5.3            XVector_0.50.0          withr_3.0.2
#> [22] cachem_1.1.0            yaml_2.3.10             gdtools_0.4.4
#> [25] ggbeeswarm_0.7.2        tools_4.5.1             dplyr_1.1.4
#> [28] vctrs_0.6.5             R6_2.6.1                lifecycle_1.0.4
#> [31] stringr_1.5.2           Seqinfo_1.0.0           htmlwidgets_1.6.4
#> [34] IRanges_2.44.0          vipor_0.4.7             pkgconfig_2.0.3
#> [37] beeswarm_0.4.0          pillar_1.11.1           bslib_0.9.0
#> [40] gtable_0.3.6            glue_1.8.0              Rcpp_1.1.0
#> [43] systemfonts_1.3.1       xfun_0.53               tibble_3.3.0
#> [46] tidyselect_1.2.1        knitr_1.50              dichromat_2.0-0.1
#> [49] farver_2.1.2            htmltools_0.5.8.1       labeling_0.4.3
#> [52] rmarkdown_2.30          compiler_4.5.1          S7_0.2.0
```