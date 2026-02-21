Intrudoction to caOmicsV

Hongen Zhang, Ph.D.
Genetics Branch, Center for Cancer Research,
National Cancer Institute, NIH

March 10, 2015

Contents

1 Introduction

2 An Quick Demo

3 Making Plot Data Set

4 Plot bioMatrix Layout Manually

5 Plot bioNetCircos Layout Manually

6 sessionInfo

1

Introduction

1

2

4

5

8

11

Translational genomics research in cancer, e.g., International Cancer Genome
Consortium (ICGC) and The Cancer Genome Atlas (TCGA), has generated
large multidimensional datasets from high-throughput technologies. Multidi-
mensional data oﬀers great promise to improve clinical applications of genomic
information in diagnosis, prognosis and therapeutics of cancers. Tools to eﬀec-
tively visualize integrated multidimensional data are important for understand-
ing and describing the relationship between genomic variations and cancers.
The caOmicsV package provides methods to visualize multidimensional cancer
genomic data in two layouts: a heatmap-like matrix layout, bioMatrix, and cir-
cular layouts superimposed on a biological network or graph, bioNetCircos.

The data that could be plotted with each layout is listed below:

(cid:136) Clinical (phenotypes) data such as gender, tissue type, and diagnosis,

plotted as colored rectangles

(cid:136) Expression data such as RNASeq and miRNASeq, plotted as heatmap

1

(cid:136) Category data such as DNA methylation status, plotted as colored box

outlines on bioMatrix layout and bars on bioNetCircos layout

(cid:136) Binary data such as mutation status and DNA copy number variations,

plotted as colored points

(cid:136) Text labelling, for gene names, sample names, summary in text format

In addition, link lines can also be plotted on bioNetCircos layout to show

the relationship between two samples.

For bioNetCircos layout, igraph and bc3net packages must be installed ﬁrst.

2 An Quick Demo

Following code will generate a bioMatrix layout image with the build-in demo
data.

> library(caOmicsV)
> data(biomatrixPlotDemoData)
> plotBioMatrix(biomatrixPlotDemoData, summaryType="text")
> bioMatrixLegend(heatmapNames=c("RNASeq", "miRNASeq"),
+
+
+

categoryNames=c("Methyl H", "Methyl L"),
binaryNames=c("CN LOSS", "CN Gain"),
heatmapMin=-3, heatmapMax=3, colorType="BlueWhiteRed")

2

Figure 1. caOmicsV bioMatrix layout plot

Run the code below will get a bioNetCircos layout image with the build-in

demo data.

> library(caOmicsV)
> data(bionetPlotDemoData)
> plotBioNetCircos(bionetPlotDemoData)

[1] "plot polygon"
[1] "plot heatmap"
[1] "plot heatmap"
[1] "plot bar"
[1] "plot points"

> dataNames <- c("Tissue Type", "RNASeq", "miRNASeq", "Methylation", "CNV")
> bioNetLegend(dataNames, heatmapMin=-3, heatmapMax=3)

3

BC.A216.NormalBD.A2L6.NormalBD.A3EP.NormalDD.A113.NormalDD.A114.NormalDD.A118.NormalDD.A119.NormalDD.A11A.NormalDD.A11B.NormalDD.A11C.NormalDD.A11D.NormalDD.A1EB.NormalDD.A1EC.NormalDD.A1EG.NormalDD.A1EH.NormalDD.A1EI.NormalDD.A1EJ.NormalDD.A1EL.NormalDD.A39V.NormalDD.A39W.NormalDD.A39X.NormalDD.A39Z.NormalDD.A3A1.NormalDD.A3A2.NormalDD.A3A3.NormalEP.A12J.NormalEP.A26S.NormalES.A2HT.NormalFV.A23B.NormalFV.A2QR.NormalBC.A216.TumorBD.A2L6.TumorBD.A3EP.TumorDD.A113.TumorDD.A114.TumorDD.A118.TumorDD.A119.TumorDD.A11A.TumorDD.A11B.TumorDD.A11C.TumorDD.A11D.TumorDD.A1EB.TumorDD.A1EC.TumorDD.A1EG.TumorDD.A1EH.TumorDD.A1EI.TumorDD.A1EJ.TumorDD.A1EL.TumorDD.A39V.TumorDD.A39W.TumorDD.A39X.TumorDD.A39Z.TumorDD.A3A1.TumorDD.A3A2.TumorDD.A3A3.TumorEP.A12J.TumorEP.A26S.TumorES.A2HT.TumorFV.A23B.TumorFV.A2QR.Tumorsample_typeECM1SLC26A6ADAMTS13FCN3CFPCXCL12PTH1RLIFRPLVAPTOMM40LLEPREL1AMIGO3CSRNP1DBHOLFML3RCAN1COL15A1LYVE1CDKN3RND3MT1FSEMA3FLOC222699LILRB5ESM1BCO2hsa−mir−10bhsa−mir−139hsa−mir−10bhsa−mir−10bhsa−mir−10bhsa−mir−10bhsa−mir−10bhsa−mir−10bhsa−mir−424hsa−mir−101−2hsa−mir−10bhsa−mir−450bhsa−mir−10bhsa−mir−10bhsa−mir−10bhsa−mir−10bhsa−mir−424hsa−mir−10bhsa−mir−101−1hsa−mir−10bhsa−mir−10bhsa−mir−139hsa−mir−139hsa−mir−10bhsa−mir−450bhsa−mir−10bSolid Tissue NormalPrimary TumorllllllllllllllllllllllllllllogFC−4.0 2.6−3.6−5.9−4.4−3.8−4.4−3.6 2.9 1.9−2.5 2.0−2.5−5.0−2.9−2.7 4.3−4.0 4.2−2.9−6.7 1.6 2.5−2.5 5.0−5.1−33Top:  RNASeq    Bottom:  miRNASeqMethyl HMethyl LllCN LOSSCN GainFigure 2. caOmicsV bioNetCircos layout plot

3 Making Plot Data Set

To use the default plot function shown as above, the ﬁrst step is making an plot
data set to hold all datasets in a list object. Two demo data sets are included
in the package installation and could be explored with:

> library(caOmicsV)
> data(biomatrixPlotDemoData)
> names(biomatrixPlotDemoData)

[1] "sampleNames"
[5] "heatmapData"

"geneNames"
"categoryData"

"secondGeneNames" "sampleInfo"
"binaryData"

"summaryInfo"

> data(bionetPlotDemoData)
> names(bionetPlotDemoData)

[1] "sampleNames"
[5] "heatmapData"

"geneNames"
"categoryData"

"secondGeneNames" "sampleInfo"
"binaryData"

"summaryInfo"

caOmicsV package has a function getPlotDataSet() to make the plot data

set as above. The input data to pass to the function are as below:

4

llllllllllllllllllllllllll1234567891011121314151617181920212223242526ADAMTS13FCN3CXCL12PTH1RLEPREL1CSRNP1OLFML3RND3LIFRTOMM40LRCAN1CDKN3SEMA3FLOC222699BCO2CFPMT1FLILRB5ESM1DBHCOL15A1AMIGO3LYVE1ECM1SLC26A6PLVAP−33From center to outer:lllllTissue TypeRNASeqmiRNASeqMethylationCNV(cid:136) sampleNames: required, character vector with names of samples to plot

(cid:136) geneNames: required, character vector with names of genes to plot

(cid:136) sampleData: required, data frame with rows for samples and columns for
features. The ﬁrst column must be sample names same as the sample-
Names above in same order

(cid:136) heatmapData:

list of data frames (maximum 2), continue numeric data

such as gene expression data.

(cid:136) categoryData: list of data frames(maximum 2), categorical data such as

methylation High, Low, NO.

(cid:136) binaryData: list of data frames(maximum 3), binary data such as 0/1.

(cid:136) summaryData: list of data frames (maximum 2), summarization for genes

or for samples.

(cid:136) secondGeneNames: names of second set of genes, e.g. miRNA names, to

label genes on right side of matrix layout.

All genomic data must be held with data frame in the format of rows for
genes and columns for samples. The ﬁrst column of each data frame must be
gene names same as the geneNames as above in same order. The column names
of each data frame must be sample names same as sampleNames as above in
same order. caOmicsV package contains functions to sort data frame for given
order and several supplement functions are also included in the package to help
extract required data set from big datasets by supplying required gene names
and sample names in a given order.

To make caOmicsV plot, the plot data set must contains at least one genomic

data (one of heatmap data, category data, or binary data)

4 Plot bioMatrix Layout Manually

The default plot method, plotBiomatrix(), is a convenient and eﬃcient way to
make bioMatirx plot. In case of necessary, users can follow procedures below to
generate bioMatrix layout plot manually.

1. Demo data

> library(caOmicsV)
> data(biomatrixPlotDemoData)
> dataSet <- biomatrixPlotDemoData
> names(dataSet)

[1] "sampleNames"
[5] "heatmapData"

"geneNames"
"categoryData"

"secondGeneNames" "sampleInfo"
"binaryData"

"summaryInfo"

5

2. Initialize bioMatrix Layout

<- rownames(dataSet$sampleInfo)[-1];

> numOfGenes <- length(dataSet$geneNames);
> numOfSamples <- length(dataSet$sampleNames);
> numOfPhenotypes <- nrow(dataSet$sampleInfo)-1;
> numOfHeatmap <- length(dataSet$heatmapData);
> numOfSummary <- length(dataSet$summaryData);
> phenotypes
> sampleHeight <- 0.4;
> sampleWidth <- 0.1;
> samplePadding <- 0.025;
> geneNameWidth <- 1;
> sampleNameHeight <- 2.5;
> remarkWidth <- 2;
> summaryWidth <- 1;
> rowPadding <- 0.1;
> initializeBioMatrixPlot(numOfGenes, numOfSamples, numOfPhenotypes,
+
+
> caOmicsVColors <- getCaOmicsVColors()
> png("caOmicsVbioMatrixLayoutDemo.png", height=8, width=12,
+
> par(cex=0.75)
> showBioMatrixPlotLayout(dataSet$geneNames,dataSet$sampleNames, phenotypes)

sampleHeight, sampleWidth, samplePadding, rowPadding,
geneNameWidth, remarkWidth, summaryWidth, sampleNameHeight)

unit="in", res=300, type="cairo")

3. Plot tissue types on phenotype area

> head(dataSet$sampleInfo)[,1:3]

TCGA.BC.A216.Normal
"TCGA.BC.A216.Normal" "TCGA.BD.A2L6.Normal" "TCGA.BD.A3EP.Normal"
sampleID
sample_type "Solid Tissue Normal" "Solid Tissue Normal" "Solid Tissue Normal"

TCGA.BD.A3EP.Normal

TCGA.BD.A2L6.Normal

> rowIndex <- 2;
> sampleGroup <- as.character(dataSet$sampleInfo[rowIndex,])
> sampleTypes <- unique(sampleGroup)
> sampleColors <- rep("blue", length(sampleGroup));
> sampleColors[grep("Tumor", sampleGroup)] <- "red"
> rowNumber <- 1
> areaName <- "phenotype"
> plotBioMatrixSampleData(rowNumber, areaName, sampleColors);
> geneLabelX <- getBioMatrixGeneLabelWidth()
> maxAreaX <- getBioMatrixDataAreaWidth()
> legendH <- getBioMatrixLegendHeight()
> plotAreaH <- getBioMatrixPlotAreaHeigth()
> sampleH<- getBioMatrixSampleHeight()
> sampleLegendX <- geneLabelX + maxAreaX

6

> sampleLegendY <- plotAreaH + legendH - length(sampleTypes)*sampleH
> colors <- c("blue", "red")
> legend(sampleLegendX, sampleLegendY, legend=sampleTypes,
+

fill=colors, bty="n", xjust=0)

4. Heatmap plot

> heatmapData <- as.matrix(dataSet$heatmapData[[1]][,]);
> plotBioMatrixHeatmap(heatmapData, maxValue=3, minValue=-3)
> heatmapData <- as.matrix(dataSet$heatmapData[[2]][,])
> plotBioMatrixHeatmap(heatmapData, topAdjust=sampleH/2,
+
> secondNames <- as.character(dataSet$secondGeneNames)
> textColors <- rep(caOmicsVColors[3], length(secondNames));
> plotBioMatrixRowNames(secondNames, "omicsData", textColors,
+

side="right", skipPlotColumns=0);

maxValue=3, minValue=-3);

5. Draw outline for each samples to show methylation status.

> categoryData <- dataSet$categoryData[[1]]
> totalCategory <- length(unique(as.numeric(dataSet$categoryData[[1]])))
> plotColors <- rev(getCaOmicsVColors())
> plotBioMatrixCategoryData(categoryData, areaName="omicsData",
+

sampleColors=plotColors[1:totalCategory])

6. Binary data plot

> binaryData <- dataSet$binaryData[[1]];
> plotBioMatrixBinaryData(binaryData, sampleColor=caOmicsVColors[4]);
> binaryData <- dataSet$binaryData[[2]];
> plotBioMatrixBinaryData(binaryData, sampleColor=caOmicsVColors[3])

7. Plot summary data on right side of plot area

> summaryData <- dataSet$summaryInfo[[1]][, 2];
> summaryTitle <- colnames(dataSet$summaryInfo[[1]])[2];
> remarkWidth <- getBioMatrixRemarkWidth();
> sampleWidth <- getBioMatrixSampleWidth();
> col2skip <- remarkWidth/2/sampleWidth + 2;
> plotBioMatrixRowNames(summaryTitle, areaName="phenotype",
+
> plotBioMatrixRowNames(summaryData, "omicsData",
+
+

colors=caOmicsVColors[3], side="right",
skipPlotColumns=col2skip)

colors="black", side="right", skipPlotColumns=col2skip);

8. Add legend

7

> bioMatrixLegend(heatmapNames=c("RNASeq", "miRNASeq"),
+
+
+
+
> dev.off()

categoryNames=c("Methyl H", "Methyl L"),
binaryNames=c("CN LOSS", "CN Gain"),
heatmapMin=-3, heatmapMax=3,
colorType="BlueWhiteRed")

null device
1

Run code above should generate an image same as Figure 1.

5 Plot bioNetCircos Layout Manually

With default bioNetCircos layout plot method, the node layout and labelling
rely on the igraph package and sometimes the node layout and labelling may
not be in desired location. In that case, it is recommended to manually check
out the layout ﬁrst then plot each item.

Following are basic procedures to make a bioNetCircos plot:

1. Demo data

<- dataSet$geneNames

> library(caOmicsV)
> data(bionetPlotDemoData)
> dataSet <- bionetPlotDemoData
> sampleNames <- dataSet$sampleNames
> geneNames
> numOfSamples <- length(sampleNames)
> numOfSampleInfo <- nrow(dataSet$sampleInfo) - 1
> numOfSummary <- ifelse(dataSet$summaryByRow, 0, col(dataSet$summaryInfo)-1)
> numOfHeatmap <- length(dataSet$heatmapData)
> numOfCategory <- length(dataSet$categoryData)
> numOfBinary <- length(dataSet$binaryData)
> expr <- dataSet$heatmapData[[1]]
> bioNet <- bc3net(expr)

2. Initialize bioNetCircos layout

<- 100

> widthOfSample
> widthBetweenNode <- 3
> lengthOfRadius
> dataNum <- sum(numOfSampleInfo, numOfSummary, numOfHeatmap,
+
> trackheight <- 1.5
> widthOfPlotArea <- dataNum*2*trackheight

numOfCategory, numOfBinary)

<- 10

8

> initializeBioNetCircos(bioNet, numOfSamples, widthOfSample,
+
lengthOfRadius, widthBetweenNode, widthOfPlotArea)
> caOmicsVColors <- getCaOmicsVColors()
> supportedType <- getCaOmicsVPlotTypes()
> par(cex=0.75)
> showBioNetNodesLayout()

3. Manually label each node

At this point, each node has its index labelled. Manually check out the de-
sired location for node name (gene) labelling then label each node (the node
index here may be diﬀerent from your graph).

labelLocation="top", labelOffset = 0.7)

> par(cex=0.6)
> onTop <- c(14, 15, 16, 9, 7, 20, 8, 24, 10, 25)
> labelBioNetNodeNames(nodeList=onTop,labelColor="blue",
+
> onBottom <- c(26, 22, 23, 18, 19, 3, 5)
> labelBioNetNodeNames(nodeList=onBottom,labelColor="black",
+
> onLeft <- c(2, 11, 21, 17)
> labelBioNetNodeNames(nodeList=onLeft,labelColor="red",
+
> onRight <- c(13, 12, 4, 1, 6)
> labelBioNetNodeNames(nodeList=onRight,labelColor="brown",
+

labelLocation="bottom", labelOffset = 0.7)

labelLocation="right", labelOffset = 0.7)

labelLocation="left", labelOffset = 0.7)

Once all node names are labelled correctly, plot area of each node could be

erased for plotting.

> eraseBioNetNode()

4. Plot each data set

> inner <- lengthOfRadius/2
> outer <- inner + trackheight

Plot tissue type for each node. Repeat this step if there are more than one

clinical features.

> groupInfo <- as.character(dataSet$sampleInfo[2, ])
> sampleColors <- rep("blue", numOfSamples);
> sampleColors[grep("Tumor", groupInfo)] <- "red"
> plotType=supportedType[1]
> groupInfo <- matrix(groupInfo, nrow=1)
> bioNetCircosPlot(dataValues=groupInfo,
+
> inner <- outer + 0.5
> outer <- inner + trackheight

plotType, outer, inner, sampleColors)

9

Heatmap plot for each node. Repeat this step if there are more heatmap

data.

> exprData <- dataSet$heatmapData[[1]]
> plotType <- supportedType[4]
> bioNetCircosPlot(exprData, plotType, outer, inner,
+
> inner <- outer + 0.5
> outer <- inner + trackheight

plotColors="BlueWhiteRed", maxValue=3, minValue=-3)

Category data plot for each node. Repeat this step if there are more category

datasets.

> categoryData <- dataSet$categoryData[[1]]
> plotType <- supportedType[2];
> bioNetCircosPlot(categoryData, plotType,
outer, inner, plotColors="red")
+

length of data values and colors are different.
First color will be used for all samples.

> inner <- outer + 0.5
> outer <- inner + trackheight

Binary data plot for each node. Repeat this step if there are more binary

datasets

> binaryData <- dataSet$binaryData[[1]]
> plotType <- supportedType[3]
> plotColors <- rep(caOmicsVColors[1], ncol(binaryData))
> bioNetCircosPlot(binaryData, plotType,
+
> inner <- outer + 0.5
> outer <- inner + trackheight

outer, inner, plotColors)

Link samples on a node. Repeat this step for each node when needed.

> outer <- 2.5
> bioNetGraph <- getBioNetGraph()
> nodeIndex <- which(V(bioNetGraph)$name=="PLVAP")
> fromSample <- 10
> toSample <- 50
> plotColors <- "red"
> linkBioNetSamples(nodeIndex, fromSample,
+
> fromSample <- 40
> toSample <- 20
> plotColors <- "blue"
> linkBioNetSamples(nodeIndex, fromSample,
+

toSample, outer, plotColors)

toSample, outer, plotColors)

10

5. Add legend

> dataNames <- c("Tissue Type", "RNASeq", "Methylation", "CNV")
> bioNetLegend(dataNames, heatmapMin=-3, heatmapMax=3)

The output from the code above should be same as Figure 2.

6

sessionInfo

> sessionInfo()

R version 3.5.2 (2018-12-20)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Ubuntu 16.04.5 LTS

Matrix products: default
BLAS: /home/biocbuild/bbs-3.8-bioc/R/lib/libRblas.so
LAPACK: /home/biocbuild/bbs-3.8-bioc/R/lib/libRlapack.so

locale:

[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_US.UTF-8
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

attached base packages:
[1] stats

graphics grDevices utils

datasets methods

base

other attached packages:
[1] caOmicsV_1.12.1 bc3net_1.0.4
[5] infotheo_1.2.0 c3net_1.1.1

lattice_0.20-38 Matrix_1.2-15
igraph_1.2.2

loaded via a namespace (and not attached):
[1] compiler_3.5.2 magrittr_1.5
[5] pkgconfig_2.0.2

tools_3.5.2

grid_3.5.2

11

