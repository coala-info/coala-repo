# Developer Introduction to the NanoStringGeoMxSet

#### David Henderson, Patrick Aboyoun, Nicole Ortogero, Zhi Yang, Jason Reeves, Kara Gorman, Rona Vitancol, Thomas Smith, Maddy Griswold

#### 2025-10-30

## Introduction

The NanoStringGeoMxSet was inherited from Biobase’s ExpressionSet class. The NanoStringGeoMxSet class was designed to encapsulate data and corresponding methods for NanoString DCC files generated from the NanoString GeoMx Digital Spatial Profiling (DSP) platform.

There are numerous functions that NanoStringGeoMxSet inherited from ExpressionSet class. You can find these in this link: <https://www.bioconductor.org/packages/release/bioc/vignettes/Biobase/inst/doc/ExpressionSetIntroduction.pdf>

## Loading Packages

Loading the NanoStringNCTools and GeoMxTools packages allow users access to the NanoStringGeoMxSet class and corresponding methods.

```
library(NanoStringNCTools)
library(GeomxTools)
library(EnvStats)
library(ggiraph)
```

## Building a NanoStringGeoMxSet from .DCC files

Use the readNanoStringGeoMxSet function to read in your DCC files.

The phenoDataFile variable takes in the annotation file, the phenoDataDccColName is to specify which column from your annotation contains the DCC file names. The protocolDataColNames are the columns in your annotation file that you want to put in the protocol data slot.

```
datadir <- system.file("extdata", "DSP_NGS_Example_Data",
                       package="GeomxTools")
DCCFiles <- dir(datadir, pattern=".dcc$", full.names=TRUE)
PKCFiles <- unzip(zipfile = file.path(datadir,  "/pkcs.zip"))
SampleAnnotationFile <- file.path(datadir, "annotations.xlsx")

demoData <-
  suppressWarnings(readNanoStringGeoMxSet(dccFiles = DCCFiles,
                                          pkcFiles = PKCFiles,
                                          phenoDataFile = SampleAnnotationFile,
                                          phenoDataSheet = "CW005",
                                          phenoDataDccColName = "Sample_ID",
                                          protocolDataColNames = c("aoi",
                                                                   "cell_line",
                                                                   "roi_rep",
                                                                   "pool_rep",
                                                                   "slide_rep")))

class(demoData)
#> [1] "NanoStringGeoMxSet"
#> attr(,"package")
#> [1] "GeomxTools"
isS4(demoData)
#> [1] TRUE
is(demoData, "ExpressionSet")
#> [1] TRUE
demoData
#> NanoStringGeoMxSet (storageMode: lockedEnvironment)
#> assayData: 8707 features, 88 samples
#>   element names: exprs
#> protocolData
#>   sampleNames: DSP-1001250002642-A02.dcc DSP-1001250002642-A03.dcc ...
#>     DSP-1001250002642-H05.dcc (88 total)
#>   varLabels: FileVersion SoftwareVersion ... NTC (21 total)
#>   varMetadata: labelDescription
#> phenoData
#>   sampleNames: DSP-1001250002642-A02.dcc DSP-1001250002642-A03.dcc ...
#>     DSP-1001250002642-H05.dcc (88 total)
#>   varLabels: slide name scan name ... area (6 total)
#>   varMetadata: labelDescription
#> featureData
#>   featureNames: RTS0039454 RTS0039455 ... RTS0995671 (8707 total)
#>   fvarLabels: RTS_ID TargetName ... Negative (9 total)
#>   fvarMetadata: labelDescription
#> experimentData: use 'experimentData(object)'
#> Annotation: Six-gene_test_v1_v1.1.pkc VnV_GeoMx_Hs_CTA_v1.2.pkc
#> signature: none
#> feature: Probe
#> analyte: RNA
```

## How is the DSP data stored in the NanoStringGeoMxSet object?

* The assayData slot stores the expression values. It can store muultiple count matrices.
* The protocolData slot stores information about the assay run. This information is read from the DCC files plus the annotations columns you specified in the protocolData argument. phenoData stores annotation data about the samples. You can add these as columns in the annotation file.
* featureData stores information about the targets or probes for the panel used.
* experimentData stores structured information about the experiment.
* annotation stores the name of the PKC data.
* feature is a feature type indicator whether this is probe level or target level (target aggregation was done)

```
# access the count matrix
assayData(demoData)[["exprs"]][1:3, 1:3]
#>            DSP-1001250002642-A02.dcc DSP-1001250002642-A03.dcc
#> RTS0039454                       294                       239
#> RTS0039455                       270                       281
#> RTS0039456                       255                       238
#>            DSP-1001250002642-A04.dcc
#> RTS0039454                         6
#> RTS0039455                         6
#> RTS0039456                         3

# access pheno data
pData(demoData)[1:3, ]
#>                                              slide name
#> DSP-1001250002642-A02.dcc 6panel-old-slide1 (PTL-10891)
#> DSP-1001250002642-A03.dcc 6panel-old-slide1 (PTL-10891)
#> DSP-1001250002642-A04.dcc 6panel-old-slide1 (PTL-10891)
#>                                          scan name
#> DSP-1001250002642-A02.dcc cw005 (PTL-10891) Slide1
#> DSP-1001250002642-A03.dcc cw005 (PTL-10891) Slide1
#> DSP-1001250002642-A04.dcc cw005 (PTL-10891) Slide1
#>                                                                                        panel
#> DSP-1001250002642-A02.dcc (v1.2) VnV Cancer Transcriptome Atlas, (v1.0) Six gene test custom
#> DSP-1001250002642-A03.dcc (v1.2) VnV Cancer Transcriptome Atlas, (v1.0) Six gene test custom
#> DSP-1001250002642-A04.dcc (v1.2) VnV Cancer Transcriptome Atlas, (v1.0) Six gene test custom
#>                           roi           segment     area
#> DSP-1001250002642-A02.dcc   1 Geometric Segment 31318.73
#> DSP-1001250002642-A03.dcc   2 Geometric Segment 31318.73
#> DSP-1001250002642-A04.dcc   3 Geometric Segment 31318.73

# access the protocol data
pData(protocolData(demoData))[1:3, ]
#>                           FileVersion SoftwareVersion       Date
#> DSP-1001250002642-A02.dcc         0.1           1.0.0 2020-07-14
#> DSP-1001250002642-A03.dcc         0.1           1.0.0 2020-07-14
#> DSP-1001250002642-A04.dcc         0.1           1.0.0 2020-07-14
#>                                        SampleID      Plate_ID Well
#> DSP-1001250002642-A02.dcc DSP-1001250002642-A02 1001250002642  A02
#> DSP-1001250002642-A03.dcc DSP-1001250002642-A03 1001250002642  A03
#> DSP-1001250002642-A04.dcc DSP-1001250002642-A04 1001250002642  A04
#>                                      SeqSetId    Raw Trimmed Stitched Aligned
#> DSP-1001250002642-A02.dcc VH00121:3:AAAG2YWM5 646250  646250   616150  610390
#> DSP-1001250002642-A03.dcc VH00121:3:AAAG2YWM5 629241  629241   603243  597280
#> DSP-1001250002642-A04.dcc VH00121:3:AAAG2YWM5 831083  831083   798188  791804
#>                           umiQ30 rtsQ30 DeduplicatedReads
#> DSP-1001250002642-A02.dcc 0.9785 0.9804            312060
#> DSP-1001250002642-A03.dcc 0.9784 0.9811            305528
#> DSP-1001250002642-A04.dcc 0.9785 0.9801            394981
#>                                                 aoi cell_line roi_rep pool_rep
#> DSP-1001250002642-A02.dcc Geometric Segment-aoi-001    HS578T       1        1
#> DSP-1001250002642-A03.dcc Geometric Segment-aoi-001    HS578T       2        1
#> DSP-1001250002642-A04.dcc Geometric Segment-aoi-001       HEL       1        1
#>                           slide_rep                    NTC_ID NTC
#> DSP-1001250002642-A02.dcc         1 DSP-1001250002642-A01.dcc   7
#> DSP-1001250002642-A03.dcc         1 DSP-1001250002642-A01.dcc   7
#> DSP-1001250002642-A04.dcc         1 DSP-1001250002642-A01.dcc   7

# access the probe information
fData(demoData)[1:3, ]
#>                RTS_ID TargetName                Module  CodeClass
#> RTS0039454 RTS0039454      ACTA2 VnV_GeoMx_Hs_CTA_v1.2 Endogenous
#> RTS0039455 RTS0039455      ACTA2 VnV_GeoMx_Hs_CTA_v1.2 Endogenous
#> RTS0039456 RTS0039456      ACTA2 VnV_GeoMx_Hs_CTA_v1.2 Endogenous
#>                          ProbeID GeneID SystematicName
#> RTS0039454 NM_001141945.1:460_5p     59          ACTA2
#> RTS0039455 NM_001141945.1:460_3p     59          ACTA2
#> RTS0039456    NM_001613.2:154_3p     59          ACTA2
#>                           TargetGroup Negative
#> RTS0039454 All Probes;Notch Signaling    FALSE
#> RTS0039455 All Probes;Notch Signaling    FALSE
#> RTS0039456 All Probes;Notch Signaling    FALSE

# check feature type
featureType(demoData)
#> [1] "Probe"

# access PKC information
annotation(demoData)
#> [1] "Six-gene_test_v1_v1.1.pkc" "VnV_GeoMx_Hs_CTA_v1.2.pkc"
```

## Accessing and Assigning NanoStringGeoMxSet Data Members

Alongside the accessors associated with the ExpressionSet class, NanoStringGeoMxSet objects have unique additional assignment and accessor methods facilitating common ways to view DSP data and associated labels.

## Access annotations

The package provide functions to get the annotations of the data

Access the available pheno and protocol data variables

```
svarLabels(demoData)
#>  [1] "slide name"        "scan name"         "panel"
#>  [4] "roi"               "segment"           "area"
#>  [7] "FileVersion"       "SoftwareVersion"   "Date"
#> [10] "SampleID"          "Plate_ID"          "Well"
#> [13] "SeqSetId"          "Raw"               "Trimmed"
#> [16] "Stitched"          "Aligned"           "umiQ30"
#> [19] "rtsQ30"            "DeduplicatedReads" "aoi"
#> [22] "cell_line"         "roi_rep"           "pool_rep"
#> [25] "slide_rep"         "NTC_ID"            "NTC"
head(sData(demoData), 2)
#>                                              slide name
#> DSP-1001250002642-A02.dcc 6panel-old-slide1 (PTL-10891)
#> DSP-1001250002642-A03.dcc 6panel-old-slide1 (PTL-10891)
#>                                          scan name
#> DSP-1001250002642-A02.dcc cw005 (PTL-10891) Slide1
#> DSP-1001250002642-A03.dcc cw005 (PTL-10891) Slide1
#>                                                                                        panel
#> DSP-1001250002642-A02.dcc (v1.2) VnV Cancer Transcriptome Atlas, (v1.0) Six gene test custom
#> DSP-1001250002642-A03.dcc (v1.2) VnV Cancer Transcriptome Atlas, (v1.0) Six gene test custom
#>                           roi           segment     area FileVersion
#> DSP-1001250002642-A02.dcc   1 Geometric Segment 31318.73         0.1
#> DSP-1001250002642-A03.dcc   2 Geometric Segment 31318.73         0.1
#>                           SoftwareVersion       Date              SampleID
#> DSP-1001250002642-A02.dcc           1.0.0 2020-07-14 DSP-1001250002642-A02
#> DSP-1001250002642-A03.dcc           1.0.0 2020-07-14 DSP-1001250002642-A03
#>                                Plate_ID Well            SeqSetId    Raw Trimmed
#> DSP-1001250002642-A02.dcc 1001250002642  A02 VH00121:3:AAAG2YWM5 646250  646250
#> DSP-1001250002642-A03.dcc 1001250002642  A03 VH00121:3:AAAG2YWM5 629241  629241
#>                           Stitched Aligned umiQ30 rtsQ30 DeduplicatedReads
#> DSP-1001250002642-A02.dcc   616150  610390 0.9785 0.9804            312060
#> DSP-1001250002642-A03.dcc   603243  597280 0.9784 0.9811            305528
#>                                                 aoi cell_line roi_rep pool_rep
#> DSP-1001250002642-A02.dcc Geometric Segment-aoi-001    HS578T       1        1
#> DSP-1001250002642-A03.dcc Geometric Segment-aoi-001    HS578T       2        1
#>                           slide_rep                    NTC_ID NTC
#> DSP-1001250002642-A02.dcc         1 DSP-1001250002642-A01.dcc   7
#> DSP-1001250002642-A03.dcc         1 DSP-1001250002642-A01.dcc   7
```

Design information can be assigned to the NanoStringGeoMxSet object, as well as feature and sample labels to use for NanoStringGeoMxSet plotting methods.

```
design(demoData) <- ~ `segments`
design(demoData)
#> ~segments

dimLabels(demoData)
#> [1] "RTS_ID"   "SampleID"
dimLabels(demoData)[2] <- "Sample ID"
dimLabels(demoData)
#> [1] "RTS_ID"    "Sample ID"
```

## Summarizing NanoString GeoMx Data

Easily summarize count results using the summary method. Data summaries can be generated across features or samples. Labels can be used to generate summaries based on feature or sample groupings.

```
head(summary(demoData, MARGIN = 1), 2)
#>            GeomMean SizeFactor MeanLog2   SDLog2 Min Q1 Median    Q3 Max
#> RTS0039454 11.41376   1.196060 3.512703 2.287478   1  4      9 16.75 344
#> RTS0039455 10.35145   1.084739 3.371761 2.228309   0  4      7 21.00 315
head(summary(demoData, MARGIN = 2), 2)
#>                           GeomMean SizeFactor MeanLog2  SDLog2 Min Q1 Median Q3
#> DSP-1001250002642-A02.dcc 9.929751  1.0405489 3.311758 1.94747   0  4      7 23
#> DSP-1001250002642-A03.dcc 9.280617  0.9725255 3.214221 1.98530   0  4      7 22
#>                            Max
#> DSP-1001250002642-A02.dcc 8137
#> DSP-1001250002642-A03.dcc 9147
unique(sData(demoData)$"cell_line")
#>  [1] "HS578T"  "HEL"     "U118MG"  "HDLM2"   "THP1"    "H596"    "OPM2"
#>  [8] "DAUDI"   "MALME3M" "COLO201" "HUT78"
head(summary(demoData, MARGIN = 2, GROUP = "cell_line")$"HS578T", 2)
#>                           GeomMean SizeFactor MeanLog2  SDLog2 Min Q1 Median Q3
#> DSP-1001250002642-A02.dcc 9.929751   1.507066 3.311758 1.94747   0  4      7 23
#> DSP-1001250002642-A03.dcc 9.280617   1.408545 3.214221 1.98530   0  4      7 22
#>                            Max
#> DSP-1001250002642-A02.dcc 8137
#> DSP-1001250002642-A03.dcc 9147
head(summary(demoData, MARGIN = 2, GROUP = "cell_line")$"COLO201", 2)
#>                           GeomMean SizeFactor MeanLog2   SDLog2 Min Q1 Median
#> DSP-1001250002642-B08.dcc 3.683270  0.5817191 1.880987 1.815589   0  2      3
#> DSP-1001250002642-B09.dcc 4.385107  0.6925640 2.132612 1.879853   0  2      4
#>                           Q3  Max
#> DSP-1001250002642-B08.dcc  8 1146
#> DSP-1001250002642-B09.dcc 10 1372
head(summary(demoData, MARGIN = 2, GROUP = "cell_line", log2 = FALSE)$"COLO201", 2)
#>                                Mean       SD Skewness Kurtosis Min Q1 Median Q3
#> DSP-1001250002642-B08.dcc  9.859538 31.49779 14.13199 312.7038   0  2      3  8
#> DSP-1001250002642-B09.dcc 12.517400 40.84549 13.33816 264.5914   0  2      4 10
#>                            Max
#> DSP-1001250002642-B08.dcc 1146
#> DSP-1001250002642-B09.dcc 1372
```

## Subsetting NanoStringGeoMxSet Objects

NanoStringGeoMxSet provides subsetting methods including bracket subsetting and subset functions. Users can use the subset or select arguments to further subset by feature or sample, respectively.

```
dim(demoData)
#> Features  Samples
#>     8707       88
```

use the bracket notation

```
dim(demoData[, demoData$`slide name` == "6panel-old-slide1 (PTL-10891)"])
#> Features  Samples
#>     8707       22
```

Or use subset method to subset demoData object by selecting only certain slides

```
dim(subset(demoData, select = phenoData(demoData)[["slide name"]] == "6panel-old-slide1 (PTL-10891)"))
#> Features  Samples
#>     8707       22
```

Subset by selecting specific targets and slide name

```
dim(subset(demoData, TargetName == "ACTA2", `slide name` == "6panel-old-slide1 (PTL-10891)"))
#> Features  Samples
#>        5       22
dim(subset(demoData, CodeClass == "Control", `slide name` == "6panel-old-slide1 (PTL-10891)"))
#> Features  Samples
#>      154       22
```

* endogenousSubset is provided to get only probes or targets of endogenous Code Class
* negativeControlSubset subsets the data object and includes only the probes with Negative Code Class You can see the Code Class information in the featureData slot.

use endogenousSubset and negativeControlSubset function to subset the demodata and include only features that belong to endogenous code class or negative code class.

```
dim(endogenousSubset(demoData))
#> Features  Samples
#>     8470       88
dim(negativeControlSubset(demoData))
#> Features  Samples
#>       83       88
```

endogenousSubset function also takes select arguments to further subset by phenodata

```
dim(endogenousSubset(demoData,
                              select = phenoData(demoData)[["slide name"]] == "6panel-old-slide1 (PTL-10891)"))
#> Features  Samples
#>     8470       22

# tally the number of samples according to their protocol or phenodata grouping
with(endogenousSubset(demoData), table(`slide name`))
#> slide name
#> 6panel-new-slide3 (PTL-10891) 6panel-new-slide4 (PTL-10891)
#>                            22                            22
#> 6panel-old-slide1 (PTL-10891) 6panel-old-slide2 (PTL-10891)
#>                            22                            22
with(demoData [1:10, 1:10], table(cell_line))
#> cell_line
#>  HDLM2    HEL HS578T   THP1 U118MG
#>      2      2      2      2      2
with(negativeControlSubset(demoData), table(CodeClass))
#> CodeClass
#> Negative
#>       83
```

## Apply Functions Across Assay Data

Similar to the ExpressionSet’s esApply function, an equivalent method is available with NanoStringGeoMxSet objects. Functions can be applied to assay data feature-wise or sample-wise.

Add the demoElem data which is computed as the logarithm of the count matrix (exprs) into the demoData by using assayDataApply function. The accessor function assayDataElement from eSet returns matrix element from assayData slot of object. Elt refers to the element in the assayData.

```
assayDataElement(demoData, "demoElem") <-
  assayDataApply(demoData, MARGIN=2, FUN=log, base=10, elt="exprs")
assayDataElement(demoData, "demoElem")[1:3, 1:2]
#>            DSP-1001250002642-A02.dcc DSP-1001250002642-A03.dcc
#> RTS0039454                  2.468347                  2.378398
#> RTS0039455                  2.431364                  2.448706
#> RTS0039456                  2.406540                  2.376577

# loop over the features(1) or samples(2) of the assayData element and get the mean
assayDataApply(demoData, MARGIN=1, FUN=mean, elt="demoElem")[1:5]
#> RTS0039454 RTS0039455 RTS0039456 RTS0039457 RTS0039458
#>  1.0574289       -Inf  0.9943958  1.4974429       -Inf

# split the data by group column with feature, pheno or protocol data then get the mean
head(esBy(demoData,
            GROUP = "cell_line",
            FUN = function(x) {
              assayDataApply(x, MARGIN = 1, FUN=mean, elt="demoElem")
            }))
#>              COLO201     DAUDI      H596    HDLM2       HEL   HS578T     HUT78
#> RTS0039454 0.3910499 0.7918610 0.7070841 1.235112 0.7436161 2.335504 2.3005684
#> RTS0039455 0.4139162 0.6934411 0.7044355 1.121399 0.7169818 2.250828 2.2031171
#> RTS0039456 0.3571666 0.5259476 0.7796930 1.153415 0.7048680 2.196286 2.1858906
#> RTS0039457 1.1237902 1.2848894 1.2285543 1.416938 1.2153038 2.611181 2.4856476
#> RTS0039458 0.4942803 0.8141501 0.7048680 1.216667 0.8127214 2.394991 2.3079279
#> RTS0039459 1.1052012 0.6291780 0.5407100     -Inf 0.5160499     -Inf 0.4350727
#>              MALME3M      OPM2      THP1    U118MG
#> RTS0039454 1.1950246 0.5140756 0.3692803 1.0485415
#> RTS0039455 1.1766227 0.4643331      -Inf 1.0308625
#> RTS0039456 1.1870660 0.4885606 0.3910499 0.9684105
#> RTS0039457 1.5631204 1.1072751 1.0942654 1.3409072
#> RTS0039458 1.2459613 0.7235564      -Inf 1.0365510
#> RTS0039459 0.4984583 0.5684411 0.5019619      -Inf
```

## Built-in Quality Control Assessment

Users can flag samples that fail QC thresholds or have borderline results based on expression. The setQC Flags will set the QC flags in the protocolData for the samples and probes that are low in count and saturation levels. It will also set flags for probe local outliers (low and high) and Global Outliers

```
demoData <- shiftCountsOne(demoData, useDALogic=TRUE)
demoData <- setSegmentQCFlags(demoData)
head(protocolData(demoData)[["QCFlags"]])
#>                           LowReads LowTrimmed LowStitched LowAligned
#> DSP-1001250002642-A02.dcc    FALSE      FALSE       FALSE      FALSE
#> DSP-1001250002642-A03.dcc    FALSE      FALSE       FALSE      FALSE
#> DSP-1001250002642-A04.dcc    FALSE      FALSE       FALSE      FALSE
#> DSP-1001250002642-A05.dcc    FALSE      FALSE       FALSE      FALSE
#> DSP-1001250002642-A06.dcc    FALSE      FALSE       FALSE      FALSE
#> DSP-1001250002642-A07.dcc    FALSE      FALSE       FALSE      FALSE
#>                           LowSaturation LowNegatives HighNTC LowArea
#> DSP-1001250002642-A02.dcc          TRUE         TRUE   FALSE   FALSE
#> DSP-1001250002642-A03.dcc          TRUE         TRUE   FALSE   FALSE
#> DSP-1001250002642-A04.dcc         FALSE         TRUE   FALSE   FALSE
#> DSP-1001250002642-A05.dcc          TRUE         TRUE   FALSE   FALSE
#> DSP-1001250002642-A06.dcc         FALSE         TRUE   FALSE   FALSE
#> DSP-1001250002642-A07.dcc          TRUE         TRUE   FALSE   FALSE
demoData <- setBioProbeQCFlags(demoData)
featureData(demoData)[["QCFlags"]][1:5, 1:4]
#>            LowProbeRatio GlobalGrubbsOutlier
#> RTS0039454         FALSE               FALSE
#> RTS0039455         FALSE               FALSE
#> RTS0039456         FALSE               FALSE
#> RTS0039457         FALSE               FALSE
#> RTS0039458         FALSE               FALSE
#>            LocalGrubbsOutlier.DSP-1001250002642-A02.dcc
#> RTS0039454                                        FALSE
#> RTS0039455                                        FALSE
#> RTS0039456                                        FALSE
#> RTS0039457                                        FALSE
#> RTS0039458                                        FALSE
#>            LocalGrubbsOutlier.DSP-1001250002642-A03.dcc
#> RTS0039454                                        FALSE
#> RTS0039455                                        FALSE
#> RTS0039456                                        FALSE
#> RTS0039457                                        FALSE
#> RTS0039458                                        FALSE
```

Probes and Samples that were flagged can be removed from analysis by subsetting.

Subset object to exclude all that did not pass Sequencing and background QC.

```
QCResultsIndex <- which(apply(protocolData(demoData)[["QCFlags"]],
                              1L , function(x) sum(x) == 0L))
QCPassed <- demoData[, QCResultsIndex]
dim(QCPassed)
#> Features  Samples
#>     8707        0
```

After cleaning the object from low counts, the counts can be collapsed to Target using aggregateCounts function.

Save the new object as target\_demoData when you call the aggregateCounts function. This will change the dimension of the features. After aggregating the counts, feature data will contain target counts and not probe counts. To check the feature type, you can use the featureType accessor function.

```
target_demoData <- aggregateCounts(demoData)
dim(target_demoData)
#> Features  Samples
#>     1821       88
```

Note that feature data changed to target.

```
featureType(target_demoData)
#> [1] "Target"
exprs(target_demoData)[1:5, 1:5]
#>         DSP-1001250002642-A02.dcc DSP-1001250002642-A03.dcc
#> ACTA2                  328.286182                323.490808
#> FOXA2                    4.919019                  4.919019
#> NANOG                    2.954177                  4.128918
#> TRAC                     2.992556                  4.617893
#> TRBC1/2                  2.825235                  1.933182
#>         DSP-1001250002642-A04.dcc DSP-1001250002642-A05.dcc
#> ACTA2                    6.081111                  5.304566
#> FOXA2                    6.942503                  4.208378
#> NANOG                    8.359554                  7.785262
#> TRAC                     4.514402                  4.192963
#> TRBC1/2                  3.519482                  3.807308
#>         DSP-1001250002642-A06.dcc
#> ACTA2                   15.927470
#> FOXA2                    6.470273
#> NANOG                    3.981072
#> TRAC                     4.643984
#> TRBC1/2                  4.535866
```

## Normalization

There is a preloaded GeoMx DSP-DA Normalization that comes with the NanoStringGeoMxSet class. This includes the options to normalize on quantile, housekeeping or negative normalization.

```
target_demoData <- normalize(target_demoData , norm_method="quant",
                      desiredQuantile = .9, toElt = "q_norm")
target_demoData <- normalize(target_demoData , norm_method="neg", fromElt="exprs",  toElt="neg_norm")
target_demoData <- normalize(target_demoData , norm_method="hk", fromElt="exprs", toElt="hk_norm")
assayDataElement( target_demoData , elt = "q_norm" )[1:3, 1:2]
#>       DSP-1001250002642-A02.dcc DSP-1001250002642-A03.dcc
#> ACTA2                326.118346                324.968900
#> FOXA2                  4.886536                  4.941495
#> NANOG                  2.934669                  4.147784
assayDataElement( target_demoData , elt = "hk_norm" )[1:3, 1:2]
#>       DSP-1001250002642-A02.dcc DSP-1001250002642-A03.dcc
#> ACTA2                265.002676                273.615381
#> FOXA2                  3.970783                  4.160610
#> NANOG                  2.384702                  3.492326
assayDataElement( target_demoData , elt = "neg_norm" )[1:3, 1:2]
#>       DSP-1001250002642-A02.dcc DSP-1001250002642-A03.dcc
#> ACTA2                288.519851                344.955505
#> FOXA2                  4.323163                  5.245412
#> NANOG                  2.596328                  4.402885
```

## Transforming NanoStringRCCSet Data to Data Frames

The NanoStringGeoMxSet munge function generates a data frame object for downstream modeling and visualization. This combines available features and samples into a long format.

```
neg_set <- negativeControlSubset(demoData)
class(neg_set)
#> [1] "NanoStringGeoMxSet"
#> attr(,"package")
#> [1] "GeomxTools"
neg_ctrls <- munge(neg_set, ~ exprs)
head(neg_ctrls, 2)
#>   FeatureName                SampleName exprs
#> 1  RTS0047618 DSP-1001250002642-A02.dcc     6
#> 2  RTS0047619 DSP-1001250002642-A02.dcc     4
class(neg_ctrls)
#> [1] "data.frame"
head(munge(demoData, ~ exprs), 2)
#>   FeatureName                SampleName exprs
#> 1  RTS0039454 DSP-1001250002642-A02.dcc   294
#> 2  RTS0039455 DSP-1001250002642-A02.dcc   270
munge(demoData, mapping = ~`cell_line` + GeneMatrix)
#> DataFrame with 88 rows and 2 columns
#>                             cell_line      GeneMatrix
#>                           <character>        <matrix>
#> DSP-1001250002642-A02.dcc      HS578T 294:270:255:...
#> DSP-1001250002642-A03.dcc      HS578T 239:281:238:...
#> DSP-1001250002642-A04.dcc         HEL   6:  6:  3:...
#> DSP-1001250002642-A05.dcc         HEL   7:  5:  2:...
#> DSP-1001250002642-A06.dcc      U118MG  13: 11: 16:...
#> ...                               ...             ...
#> DSP-1001250002642-H01.dcc     MALME3M  15: 21: 20:...
#> DSP-1001250002642-H02.dcc     COLO201   4:  8:  5:...
#> DSP-1001250002642-H03.dcc     COLO201   1:  4:  6:...
#> DSP-1001250002642-H04.dcc       HUT78 243:218:250:...
#> DSP-1001250002642-H05.dcc       HUT78 230:215:222:...
```

## Transforming NanoSetRccSet assayData matrices

Subtract max count from each sample Create log1p transformation of adjusted counts

```
thresh <- assayDataApply(negativeControlSubset(demoData), 2, max)
demoData <-
  transform(demoData,
            negCtrlZeroed = sweep(exprs, 2, thresh),
            log1p_negCtrlZeroed = log1p(pmax(negCtrlZeroed, 0)))
assayDataElementNames(demoData)
#> [1] "demoElem"            "exprs"               "log1p_negCtrlZeroed"
#> [4] "negCtrlZeroed"       "preLocalRemoval"     "rawZero"
```

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
#> [1] ggiraph_0.9.2            EnvStats_3.1.0           GeomxTools_3.14.0
#> [4] NanoStringNCTools_1.18.0 ggplot2_4.0.0            S4Vectors_0.48.0
#> [7] Biobase_2.70.0           BiocGenerics_0.56.0      generics_0.1.4
#>
#> loaded via a namespace (and not attached):
#>  [1] tidyselect_1.2.1        dplyr_1.1.4             vipor_0.4.7
#>  [4] farver_2.1.2            Biostrings_2.78.0       S7_0.2.0
#>  [7] fastmap_1.2.0           GGally_2.4.0            fontquiver_0.2.1
#> [10] dotCall64_1.2           digest_0.6.37           lifecycle_1.0.4
#> [13] SeuratObject_5.2.0      magrittr_2.0.4          compiler_4.5.1
#> [16] rlang_1.1.6             sass_0.4.10             tools_4.5.1
#> [19] yaml_2.3.10             data.table_1.17.8       knitr_1.50
#> [22] htmlwidgets_1.6.4       sp_2.2-0                plyr_1.8.9
#> [25] RColorBrewer_1.1-3      withr_3.0.2             purrr_1.1.0
#> [28] numDeriv_2016.8-1.1     grid_4.5.1              gdtools_0.4.4
#> [31] future_1.67.0           progressr_0.17.0        globals_0.18.0
#> [34] scales_1.4.0            MASS_7.3-65             dichromat_2.0-0.1
#> [37] cli_3.6.5               rmarkdown_2.30          crayon_1.5.3
#> [40] reformulas_0.4.2        future.apply_1.20.0     reshape2_1.4.4
#> [43] rjson_0.2.23            readxl_1.4.5            minqa_1.2.8
#> [46] ggbeeswarm_0.7.2        cachem_1.1.0            stringr_1.5.2
#> [49] ggthemes_5.1.0          splines_4.5.1           parallel_4.5.1
#> [52] cellranger_1.1.0        XVector_0.50.0          vctrs_0.6.5
#> [55] boot_1.3-32             Matrix_1.7-4            jsonlite_2.0.0
#> [58] fontBitstreamVera_0.1.1 IRanges_2.44.0          beeswarm_0.4.0
#> [61] listenv_0.9.1           systemfonts_1.3.1       tidyr_1.3.1
#> [64] jquerylib_0.1.4         spam_2.11-1             parallelly_1.45.1
#> [67] glue_1.8.0              nloptr_2.2.1            codetools_0.2-20
#> [70] ggstats_0.11.0          stringi_1.8.7           gtable_0.3.6
#> [73] lme4_1.1-37             lmerTest_3.1-3          tibble_3.3.0
#> [76] pillar_1.11.1           htmltools_0.5.8.1       Seqinfo_1.0.0
#> [79] R6_2.6.1                Rdpack_2.6.4            evaluate_1.0.5
#> [82] lattice_0.22-7          rbibutils_2.3           pheatmap_1.0.13
#> [85] fontLiberation_0.1.0    bslib_0.9.0             Rcpp_1.1.0
#> [88] nlme_3.1-168            xfun_0.53               pkgconfig_2.0.3
```