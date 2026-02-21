Example data for use with the beadarray package

Mark Dunning

April 17, 2025

Contents

1 Data Introduction

2 Loading the data

3 Data creation

1 Data Introduction

1

2

4

This package provides a lightweight dataset for those wishing to try out the examples
within the beadarray package. The data in this package are a subset of the MAQC
bead-level data available in the beadarrayUseCases package.
‘Bead-level’ refers to the
availability of intensity and location information for each bead on each BeadArray in an
experiment. In this dataset, BeadArrays were hybridized with either Universal Human
Reference RNA (UHRR, Stratagene) or Brain Reference RNA (Ambion) as used in the
MAQC project. This pacakge includes a representation of the bead-level data for 2 arrays
in the data object exampleBLdata, which was created by beadarray. The summarised
data for all 12 arrays are given in the exampleSummaryData object, which was creating by
first reading the bead-level data for all 12 sections into beadarray and then summarising
using the procedures described in the vignette for BeadArrayUseCases.

1

2 Loading the data

The example datasets can be loaded using the data function. The first dataset com-
prises two sections from the bead-level MAQC dataset generated at Cancer Research
Uk (Cambridge Research Institute) that have been read in using the beadarray package.
The second dataset is the summarised data of all sections from the same dataset.

> library(beadarrayExampleData)
> data(exampleBLData)
> exampleBLData

-----------------
Experiment information (@experimentData)
-----------------
$sdfFile
[1] "/home/dunnin01/software/R-devel/library/BeadArrayUseCases/extdata/BeadLevelBabFiles/4613710017.sdf"

$platformClass
[1] "Slide"

$annotation
[1] "Humanv3"

-----------------
Per-section data (@sectionData)
-----------------
Targets

directory
1 /home/dunnin01/software/R-devel/library/BeadArrayUseCases/extdata/BeadLevelBabFiles
2 /home/dunnin01/software/R-devel/library/BeadArrayUseCases/extdata/BeadLevelBabFiles

sectionName

textFile greenImage

1 4613710017_B 4613710017_B.bab
2 4616494005_A 4616494005_A.bab
Metrics

<NA> 4613710017_B.bab
<NA> 4616494005_A.bab

greenLocs greenxml
<NA>
<NA>

1
12

3/13/2009 6:45:04 PM 4613710017
04/01/09 04:50 4616494005

Matrix Section RegGrn FocusGrn SatGrn
0
0.13
0
0.13

0.70
0.59

B
A

Date

P95Grn P05Grn RegRed FocusRed SatRed P95Red P05Red

2

704
678

1
12
SampleGroup

36
38

0
0

0
0

0
0

0
0

0
0

[1] "4613710017_B" "4616494005_A"

numBeads

[1] 1088369 1100773

-----------------
Per-bead data (@beadData)
-----------------
Raw data from section 4613710017_B

GrnX

ProbeID
10008
900.6661 10781.320 355
10008 1992.5400 11352.000 377
7559.513 452
10008 1257.4790
6351.157 267
10008 1700.1600
3299.495 431
10008 1814.5210

GrnY Grn wts
1
1
1
1
1

[1,]
[2,]
[3,]
[4,]
[5,]

... 1088364 more rows of data

... data for 1 more section/s

> data(exampleSummaryData)
> exampleSummaryData

ExpressionSetIllumina (storageMode: list)
assayData: 49576 features, 12 samples

element names: exprs, se.exprs, nObservations

protocolData: none
phenoData

rowNames: 4613710017_B 4613710052_B ... 4616494005_A (12

total)

varLabels: sampleID SampleFac
varMetadata: labelDescription

featureData

featureNames: ILMN_1802380 ILMN_1893287 ... ILMN_1846115

(49576 total)

3

fvarLabels: ArrayAddressID IlluminaID Status
fvarMetadata: labelDescription

experimentData: use 'experimentData(object)'
Annotation: Humanv3
QC Information

Available Slots:

QC Items: Date, Matrix, ..., SampleGroup, numBeads
sampleNames: 4613710017_B, 4613710052_B, ..., 4616443136_A, 4616494005_A

> pData(exampleSummaryData)

4613710017_B 4613710017_B
4613710052_B 4613710052_B
4613710054_B 4613710054_B
4616443079_B 4616443079_B
4616443093_B 4616443093_B
4616443115_B 4616443115_B
4616443081_B 4616443081_B
4616443081_H 4616443081_H
4616443092_B 4616443092_B
4616443107_A 4616443107_A
4616443136_A 4616443136_A
4616494005_A 4616494005_A

sampleID SampleFac
UHRR
UHRR
UHRR
UHRR
UHRR
UHRR
Brain
Brain
Brain
Brain
Brain
Brain

3 Data creation

The following commands were used to create the data included with this package.

> require(BeadArrayUseCases)
> targets <- read.table(system.file("extdata/BeadLevelBabFiles/targetsHT12.txt", package = "BeadArrayUseCases"), header=TRUE, sep="\t", as.is=TRUE)
> sn <- paste(targets[,3], targets[,4], sep="_")
> babFilePath <- system.file("extdata/BeadLevelBabFiles", package = "BeadArrayUseCases")
> exampleBLData <- readIllumina(dir=babFilePath, sectionNames=sn[c(1,12)], useImages=FALSE, illuminaAnnotation="Humanv3")
> bsh <- BASH(exampleBLData,array=c(1,2))
> exampleBLData <- setWeights(exampleBLData, wts = bsh$wts, array=1:2)
> data <- readIllumina(dir=babFilePath, sectionNames=sn, useImages=FALSE, illuminaAnnotation="Humanv3")
> grnchannel <- new("illuminaChannel", transFun = logGreenChannelTransform, outlierFun = illuminaOutlierMethod, exprFun = function(x) mean(x,na.rm=TRUE),
> grnchannel.unlogged <- new("illuminaChannel", transFun = greenChannelTransform, outlierFun = illuminaOutlierMethod, exprFun = function(x) mean(x,na.rm=TRUE), varFun= function(x) sd(x, na.rm=TRUE),channelName= "G.ul")

varFun= function(x) sd(x, na.rm=TRUE),channelName= "G")

4

> exampleSummaryData <- summarize(data, list(grnchannel, grnchannel.unlogged), useSampleFac=FALSE)
> pData(exampleSummaryData)[,2] <- targets[,2]
>
>

5

