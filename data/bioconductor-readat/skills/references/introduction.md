# Introduction

#### *Richard Cotton richierocks@gmail.com*

#### *Last modified: 2016-09-07; Generated on 2018-10-30*

## Background

[SomaLogic](http://www.somalogic.com/Homepage.aspx)’s SOMAscan™ assay platform allows the analysis of the relative abundance of over 1300 proteins directly from biological matrices such as blood plasma and serum. The data resulting from the assay is provided in a proprietary text-based format called [ADAT](https://bitbucket.org/graumannlabtools/adat-spec).

## Data import

The `readAdat` function imports data from `ADAT` files. The resultant data variable is an object of class `WideSomaLogicData`, which consists of a `data.table`, from the [package of the same name](https://github.com/Rdatatable/data.table), for the sample and intensity data, and three attributes for the sequence data, metadata, and checksum.

*readat* contains sample datasets probed with both SomaLogic’s 1129 (1.1k) and 1310 (1.3k) suites of SOMAmer reagents. To demonstrate the features of the package, we exhibit the “1.3k” dataset. This dataset represents plasma samples from 20 US adults aged between 35 and 75 years old, split into age groups (“old”, 50 or older; “young”, under 50).

To import the data, type:

```
library(readat)
zipFile <- system.file(
  "extdata", "PLASMA.1.3k.20151030.adat.zip",
  package = "readat"
)
adatFile <- unzip(zipFile, exdir = tempfile("readat"))
plasma1.3k <- readAdat(adatFile)
```

```
## Removing 11 sequences that failed QC.
```

Intensity readings for eleven of the SOMAmer reagents did not pass SomaLogic’s quality control checks, and are excluded on import by default.

```
sequenceData <- getSequenceData(plasma1.3k)
nrow(sequenceData) # 1310 less 11
```

```
## [1] 1299
```

To include samples and sequences that did not pass QC,

```
plasma1.3kIncFailures <- readAdat(adatFile, keepOnlyPasses = FALSE)
nrow(getSequenceData(plasma1.3kIncFailures))
```

```
## [1] 1310
```

## Reshaping

The default format is not appropriate for all data analytical needs. When using [*ggplot2*](https://github.com/hadley/ggplot2) or [*dplyr*](https://github.com/hadley/dplyr), for example, it is more convenient to have one intensity per row rather than one sample per row. The package contains a `melt` method to transform `WideSomaLogicData` into `LongSomaLogicData`. This conversion requires access to the `melt` generic function in the [*reshape2*](https://github.com/hadley/reshape) package.

```
library(reshape2)
longPlasma1.3k <- melt(plasma1.3k)
str(longPlasma1.3k)
```

```
## Classes 'LongSomaLogicData', 'data.table' and 'data.frame':  25980 obs. of  29 variables:
##  $ PlateId            : Factor w/ 1 level "Set 01": 1 1 1 1 1 1 1 1 1 1 ...
##  $ ScannerID          : Factor w/ 1 level "SG12344217": 1 1 1 1 1 1 1 1 1 1 ...
##  $ PlatePosition      : Factor w/ 20 levels "A5","A6","B1",..: 19 14 9 12 15 8 1 20 7 2 ...
##  $ SlideId            : Factor w/ 12 levels "257711010447",..: 8 5 3 7 9 12 6 9 2 7 ...
##  $ Subarray           : int  8 6 4 5 6 4 1 8 4 1 ...
##  $ SampleId           : Factor w/ 20 levels "1029","1050",..: 20 14 18 4 1 3 5 11 7 8 ...
##  $ SampleType         : Factor w/ 1 level "Sample": 1 1 1 1 1 1 1 1 1 1 ...
##  $ PercentDilution    : int  40 40 40 40 40 40 40 40 40 40 ...
##  $ SampleMatrix       : Factor w/ 1 level "Plasma": 1 1 1 1 1 1 1 1 1 1 ...
##  $ Barcode            : Factor w/ 20 levels "S622008","S622032",..: 20 14 18 4 1 3 5 11 7 8 ...
##  $ Barcode2d          : Factor w/ 20 levels "0188777585","0188777599",..: 2 6 1 16 8 18 11 15 19 10 ...
##  $ SampleNotes        : Factor w/ 0 levels: NA NA NA NA NA NA NA NA NA NA ...
##  $ SampleDescription  : Factor w/ 0 levels: NA NA NA NA NA NA NA NA NA NA ...
##  $ AssayNotes         : Factor w/ 0 levels: NA NA NA NA NA NA NA NA NA NA ...
##  $ TimePoint          : Factor w/ 2 levels "Old","Young": 2 2 2 2 2 2 2 2 2 2 ...
##  $ ExtIdentifier      : Factor w/ 20 levels "EXID19881435244840",..: 1 2 3 4 5 6 7 8 9 10 ...
##  $ SsfExtId           : Factor w/ 20 levels "109863","109864",..: 15 11 9 2 17 1 12 18 8 13 ...
##  $ SampleGroup        : Factor w/ 2 levels "F","M": 1 1 1 1 1 2 2 2 2 2 ...
##  $ SiteId             : Factor w/ 1 level "Covance": 1 1 1 1 1 1 1 1 1 1 ...
##  $ TubeUniqueID       : Factor w/ 5 levels "1113.0","1132.0",..: NA NA NA 2 NA 1 NA NA NA NA ...
##  $ Subject_ID         : Factor w/ 20 levels "1029","1050",..: 20 14 18 4 1 3 5 11 7 8 ...
##  $ SampleUniqueID     : int  4178 3104 4140 1133 1029 1113 1149 2264 2158 2159 ...
##  $ HybControlNormScale: num  0.646 0.644 0.619 0.664 0.689 0.693 0.664 0.703 0.665 0.648 ...
##  $ RowCheck           : Factor w/ 1 level "PASS": 1 1 1 1 1 1 1 1 1 1 ...
##  $ NormScale_1        : num  1.097 0.998 1.142 0.906 1.026 ...
##  $ NormScale_40       : num  1.096 1.007 1.146 0.856 0.997 ...
##  $ NormScale_0_005    : num  0.978 1.014 0.988 1.047 1.065 ...
##  $ SeqId              : chr  "10336-3_3" "10336-3_3" "10336-3_3" "10336-3_3" ...
##  $ Intensity          : num  730 3607 612 3381 4288 ...
##  - attr(*, ".internal.selfref")=<externalptr>
##  - attr(*, "sorted")= chr "SeqId"
##  - attr(*, "Metadata")=List of 23
##   ..$ Version                :Classes 'package_version', 'numeric_version'  hidden list of 1
##   .. ..$ : int  1 2
##   ..$ AssayType              : chr "PharmaServices"
##   ..$ AssayVersion           : chr "V3.2"
##   ..$ AssayRobot             : chr "TECAN 1"
##   ..$ CreatedBy              : chr "PharmaServices"
##   ..$ CreatedDate            : Date, format: "2015-10-30"
##   ..$ EnteredBy              : chr "DP"
##   ..$ ExpDate                : Date, format: "2015-10-30"
##   ..$ GeneratedBy            : chr "Px (Build: 947 : c849b20284affe7c7e19f21c575f44fcc2a6a8f7)"
##   ..$ MasterMixVersion       : chr "1.3k Plasma"
##   ..$ ProcessSteps           : chr "Raw RFU, Hyb Normalization, Median Normalization([SampleType]), Calibration, Filtered"
##   ..$ ProteinEffectiveDate   : Date, format: "2015-10-30"
##   ..$ StudyMatrix            : chr "EDTA Plasma"
##   ..$ StudyOrganism          : chr "Human"
##   ..$ Title                  : chr "QC-15-166"
##   ..$ HybNormReference       : chr "HybridizationReference.8n.SL19239.amid2538564.20150821"
##   ..$ CalibrationReference   : chr "EDTAplasma_Tec_Cal_SL16485_9o_1.3k_mm3.3_p3.2"
##   ..$ PlateMedianCal_Set_01  : num 1.06
##   ..$ PlateMedianTest_Set_01 : chr "PASS"
##   ..$ PlateTailPercent_Set_01: num 0.9
##   ..$ PlateTailTest_Set_01   : chr "PASS"
##   ..$ SomascanMenuVersion    : chr "1.3k"
##   ..$ FilteringOptions       : chr "somascanMenuVersion + 1.3k, filteredMetadata + Notes, RunNotes"
##  - attr(*, "Checksum")= chr "2a8c4ae17f390f3b2d0ba3af43fc75f4bc9fff27"
##  - attr(*, "SequenceData")=Classes 'data.table' and 'data.frame':    1299 obs. of  14 variables:
##   ..$ SeqId           : Factor w/ 1310 levels "10336-3_3","10337-83_3",..: 1 2 3 4 5 6 7 8 9 10 ...
##   ..$ SomaId          : Factor w/ 1310 levels "SL000001","SL000002",..: 1305 888 231 1304 721 899 885 126 414 1250 ...
##   ..$ TargetFullName  : Factor w/ 1310 levels "1-phosphatidylinositol 4,5-bisphosphate phosphodiesterase gamma-1",..: 390 186 506 389 659 1120 649 1176 611 9 ...
##   ..$ Target          : Factor w/ 1310 levels "14-3-3","14-3-3 protein beta/alpha",..: 201 199 859 937 599 1090 663 1255 819 875 ...
##   ..$ UniProt         : Factor w/ 1277 levels "O00170","O00175",..: 1249 478 350 1037 918 665 396 274 878 148 ...
##   ..$ EntrezGeneID    : Factor w/ 1267 levels "1000","100049587",..: 22 35 210 707 507 975 528 535 598 660 ...
##   ..$ EntrezGeneSymbol: Factor w/ 1274 levels "A2M","ABL1","ABL2",..: 1146 228 393 940 618 1140 686 698 802 889 ...
##   ..$ Organism        : Factor w/ 5 levels "Human","Human papillomavirus type 16",..: 1 1 1 1 1 1 1 1 1 1 ...
##   ..$ Units           : Factor w/ 1 level "RFU": 1 1 1 1 1 1 1 1 1 1 ...
##   ..$ Type            : chr  "Protein" "Protein" "Protein" "Protein" ...
##   ..$ Dilution        : num  40 40 40 40 1 1 40 40 40 40 ...
##   ..$ CalReference    : num  1090 566 14324 555 924 ...
##   ..$ Cal_Set_01      : num  1.152 0.986 1.151 0.937 1 ...
##   ..$ ColCheck        : Factor w/ 2 levels "PASS","FLAG": 1 1 1 1 1 1 1 1 1 1 ...
##   ..- attr(*, ".internal.selfref")=<externalptr>
##   ..- attr(*, "sorted")= chr "SeqId"
```

For Bioconductor workflows, the package also includes a function to convert `WideSomaLogicData` objects into [*Biobase*](https://www.bioconductor.org/packages/release/bioc/html/Biobase.html) `ExpressionSet`s, [*SummarizedExperiment*](https://www.bioconductor.org/packages/release/bioc/html/SummarizedExperiment.html) `SummarizedExperiment`s, and [*MSnbase*](https://www.bioconductor.org/packages/release/bioc/html/MSnbase.html) `MSnSet`s.

```
as.ExpressionSet(plasma1.3k)
```

```
## ExpressionSet (storageMode: lockedEnvironment)
## assayData: 1299 features, 20 samples
##   element names: exprs
## protocolData: none
## phenoData
##   sampleNames: EXID19881435244840 EXID19881435244841 ...
##     EXID19886174944809 (20 total)
##   varLabels: PlateId ScannerID ... NormScale_0_005 (27 total)
##   varMetadata: labelDescription
## featureData
##   featureNames: 10336-3_3 10337-83_3 ... 9216-100_3 (1299 total)
##   fvarLabels: SeqId SomaId ... ColCheck (14 total)
##   fvarMetadata: labelDescription
## experimentData: use 'experimentData(object)'
## Annotation: Human
```

```
as.SummarizedExperiment(plasma1.3k)
```

```
## class: SummarizedExperiment
## dim: 1299 20
## metadata(2): x ''
## assays(1): intensities
## rownames(1299): 10336-3_3 10337-83_3 ... 9215-117_3 9216-100_3
## rowData names(14): SeqId SomaId ... Cal_Set_01 ColCheck
## colnames(20): EXID19881435244840 EXID19881435244841 ...
##   EXID19886174944808 EXID19886174944809
## colData names(27): PlateId ScannerID ... NormScale_40
##   NormScale_0_005
```

```
if(requireNamespace("MSnbase"))
{
  as.MSnSet(plasma1.3k)
}
```

```
## Loading required namespace: MSnbase
```

```
## MSnSet (storageMode: lockedEnvironment)
## assayData: 1299 features, 20 samples
##   element names: exprs
## protocolData: none
## phenoData
##   sampleNames: EXID19881435244840 EXID19881435244841 ...
##     EXID19886174944809 (20 total)
##   varLabels: PlateId ScannerID ... NormScale_0_005 (27 total)
##   varMetadata: labelDescription
## featureData
##   featureNames: 10336-3_3 10337-83_3 ... 9216-100_3 (1299 total)
##   fvarLabels: SeqId SomaId ... ColCheck (14 total)
##   fvarMetadata: labelDescription
## experimentData: use 'experimentData(object)'
## Annotation: Human
## - - - Processing information - - -
##  MSnbase version: 2.8.0
```