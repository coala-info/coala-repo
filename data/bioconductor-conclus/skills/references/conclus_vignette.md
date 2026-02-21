“ScRNA-seq workﬂow CONCLUS:
from
CONsensus CLUSters to a meaningful
CONCLUSion”

"Ilyess Rachedi, Polina Pavlovich, Nicolas Descostes, and
Christophe Lancrin"

19 May 2021

Contents

1

2

3

4

Introduction .

Getting help .

.

.

.

.

Important note .

.

.

.

.

.

.

Standard workﬂow .

4.1

4.2

4.3

Quick start .

Data .

.

.

.

.

.

.

.

Test clustering .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

5

CONCLUS step by step .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

3

3

3

3

3

4

7

10

10

12

13

13

15

19

22

24

27

27

28

33

5.1

5.2

5.3

5.4

5.5

5.6

Normalization of the counts matrix .

Generation of t-SNE coordinates .

Clustering with DB-SCAN .

.

.

.

.

.

.

Cell and cluster similarity matrix calculation .

Plotting.

.

.

.

.

.

.

.

.

.

.

Marker genes identiﬁcation .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

Plot a heatmap with positive marker genes .

6

7

8

9

Plot t-SNE colored by expression of a selected gene .

Collect publicly available info about marker genes .

.

.

8.1

Collect information for the top 10 markers for each cluster .

Supervised clustering .

10 Conclusion .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

“ScRNA-seq workﬂow CONCLUS: from CONsensus CLUSters to a meaningful CONCLUSion”

11 Session info .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

33

2

“ScRNA-seq workﬂow CONCLUS: from CONsensus CLUSters to a meaningful CONCLUSion”

1

Introduction

CONCLUS is a tool for robust clustering and positive marker features selection of single-cell
RNA-seq (sc-RNA-seq) datasets. It is designed to identify rare cells populations by consensus
clustering. Of note, CONCLUS does not cover the preprocessing steps of sequencing ﬁles
obtained following next-generation sequencing. You can ﬁnd a good resource to start with
here.

CONCLUS is organized into the following steps:

• Generation of multiple t-SNE plots with a range of parameters including diﬀerent

selection of genes extracted from PCA.

• Use the Density-based spatial clustering of applications with noise (DBSCAN) algorithm

for idenﬁcation of clusters in each generated t-SNE plot.

• All DBSCAN results are combined into a cell similarity matrix.
• The cell similarity matrix is used to deﬁne “CONSENSUS” clusters conserved accross

the previously deﬁned clustering solutions.

• Identify marker genes for each concensus cluster.

2

Getting help

Issues can be submitted directly to the Bioconductor forum using the keyword ‘conclus’ in
the post title. To contact us directly write to christophe.lancrin@embl.it or ilyessr@hotmail.fr.
The principles of this package were originally developed by Polina Pavlovich who is now doing
her Ph.D at the Max Planck Institute of Immunobiology and Epigenetics.

3

Important note

Due to the stochastic aspect of tSNE, everything was generated with a random seed of
42 (default parameter of generateTSNECoordinates) to ensure reproducibility of the results.
Because of the evolution of biomaRt, you might get slightly diﬀerent ﬁgures. However, the
marker genes for each cluster should be the same.

The package is currently limited to mouse and human. Other organisms can be added on
demand. Write to christophe.lancrin@embl.it or ilyessr@hotmail.fr. Priority will be given to
model organisms.

4

4.1

Standard workﬂow

Quick start
CONCLUS requires to start with a raw-count matrix with reads or unique molecular identiﬁers
(UMIs). The columns of the count matrix must contain cells and the rows – genes. CONCLUS
needs a large number of cells to collect statistics, we recommend using CONCLUS if you have
at least 100 cells.

In the example below, a small toy example is used to illustrate the runCONCLUS method.
Real data are used later in this vignette.

3

“ScRNA-seq workﬂow CONCLUS: from CONsensus CLUSters to a meaningful CONCLUSion”

library(conclus)

outputDirectory <- tempdir()

experimentName <- "Test"

species <- "mouse"

countmatrixPath <- system.file("extdata/countMatrix.tsv", package="conclus")

countMatrix <- loadDataOrMatrix(file=countmatrixPath, type="countMatrix",

ignoreCellNumber=TRUE)

coldataPath <- system.file("extdata/colData.tsv", package="conclus")

columnsMetaData <- loadDataOrMatrix(file=coldataPath, type="coldata",
columnID="cell_ID")

sceObjectCONCLUS <- runCONCLUS(outputDirectory, experimentName, countMatrix,

species, columnsMetaData=columnsMetaData,

perplexities=c(2,3), tSNENb=1,

PCs=c(4,5,6,7,8,9,10), epsilon=c(380, 390, 400),

minPoints=c(2,3), clusterNumber=4)

In your “outputDirectory”, the sub-folder pictures contains all tSNE with dbscan coloration
(sub-folder tSNE_pictures), the cell similarity matrix ( Test_cells_correlation_X_clusters.pdf),
the cell heatmap (Test_clustersX_meanCenteredTRUE_orderClustersFALSE_orderGenesFALSE
markersPerCluster.pdf), and the cluster similarity matrix (Test_clusters_similarity_10_clusters.pdf).
You will also ﬁnd in the sub-folder Results:

• 1_MatrixInfo: The normalized count matrix and its meta-data for both rows and

columns.

• 2_TSNECoordinates: The tSNE coordinates for each parameter of principal components

(PCs) and perplexities.

• 3_dbScan: The diﬀerent clusters given by DBscan according to diﬀerent parameters.

Each ﬁle gives a cluster number for each cell.

• 4_CellSimilarityMatrix: The matrix underlying the cells similarity heatmap.
• 5_ClusterSimilarityMatrix: The matrix underlying the clusters similarity heatmap.
• 6_ConclusResult: A table containing the result of the consensus clustering. This table

contains two columns: clusters-cells.

• 7_fullMarkers: Files containing markers for each cluster, deﬁned by the consensus

clustering.

• 8_TopMarkers: Files containing the top 10 markers for each cluster.
• 9_genesInfos: Files containing gene information for the top markers deﬁned in the

previous folder.

Further details about how all these results are generated can be found below.

4.2

Data
In this vignette, we demonstrate how to use CONCLUS on a sc-RNA-seq dataset from
Shvartsman et al. The Yolk Sac (YS) and Aorta-Gonad-Mesonephros (AGM) are two major
haematopoietic regions during embryonic development. Interestingly, AGM is the only one
generating haematopoietic stem cells (HSCs). To identify the diﬀerence between AGM and
YS, Shvartsman et al compared them using single cell RNA sequencing between 9.5 and 11.5
days of mouse embryonic development. This vignette aims at reproducing the identiﬁcation

4

“ScRNA-seq workﬂow CONCLUS: from CONsensus CLUSters to a meaningful CONCLUSion”

of a rare population corresponding to liver like cells in the YS at day 11.5. The number of
clusters used in this vignette is lower than in the original article for sake of simpliﬁcation. This
vignette neither provides a description of the diﬀerences between the AGM and YS. Please
refer to Shvartsman et al for a complete description.

Since endothelial cells represent a small population in these tissues, cells expressing the
endothelial marker VE-Cadherin (VE-Cad, also called Cdh5) were enriched and sorted, VE-Cad
Negative cells constituting the microenvironment. Therefore, four cell states are deﬁned by
the cell barcodes: YS VE-Cad minus, AGM VE-Cad minus, YS VE-Cad minus, and AGM
VE-Cad minus. The E11.5 data are constituted of 1482 cells. After ﬁltering and normalization,
1303 cells were retained.

This sc-RNA-seq experiment was performed using the SMARTer ICELL8 Single-Cell System
(Click here for more info). The protocol was based on 3’ end RNA sequencing where each
mRNA molecule is labeled with a unique molecular identiﬁer (UMI) during reverse transcription
in every single cell.

Shvartsman et al deleted highly abundant haemoglobins having names starting with ‘Hba’
or ‘Hbb’ because they seemed to be the primary source of contamination. Additionally, they
excluded poorly annotated genes that did not have gene symbols to improve the clusters
annotation process. Finally, the human cell controls were removed.

4.2.1 Retrieving data from GEO

The code below format the count matrix and the columns meta-data. The source data are
downloaded from the GEO page GSE161933. The URL of the count matrix and the cells
meta-data were retrieved by right-click and ‘copy link adress’ on the http hyperlink of the
supplementary ﬁle at the bottom of the page. If the columns metadata are not available in
the supplementary ﬁle section, the name of the series matrix, containing columns meta-data
can be retrieved by clicking the ‘Series Matrix File(s)’ link just above the count matrix. The
function retrieveFromGEO used with the parameter seriesMatrixName will download all series
matrices present in the GEO record however only the one of interest will be kept.

library(conclus)

## Setting options('download.file.method.GEOquery'='auto')

## Setting options('GEOquery.inmemory.gpl'=FALSE)

##

outputDirectory <- tempdir()

dir.create(outputDirectory, showWarnings=FALSE)

species <- "mouse"

countMatrixPath <- file.path(outputDirectory, "countmatrix.txt")

metaDataPath <- file.path(outputDirectory, "metaData.txt")

matrixURL <- paste0("https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSM492",

"3493&format=file&file=GSM4923493%5FE11%5F5%5Frawcounts%5Fmatrix%2Etsv%2Egz")

metaDataURL <- paste0("https://www.ncbi.nlm.nih.gov/geo/download/?acc=",

"GSM4923493&format=file&file=GSM4923493%5FMetadata%5FE11%5F5%2Etxt%2Egz")

result <- retrieveFromGEO(matrixURL, countMatrixPath, species,

metaDataPath=metaDataPath, colMetaDataURL=metaDataURL)

## Warning in .retrieveColMetaDataFromURL(bfc, colMetaDataURL, metaDataPath): The

## columns of the cells meta-data should be: cellName, state, and cellBarcode.

5

“ScRNA-seq workﬂow CONCLUS: from CONsensus CLUSters to a meaningful CONCLUSion”

## Please correct the dataframe.

## Formating data.

## Warning in .filteringAndOrdering(countMatrix, columnsMetaData): The cell

## barcodes were not found in the matrix. The columns of the count matrix and the

## rows of the meta-data will not be re-ordered. Are you sure that the count matrix

## and the meta-data correspond?

## Converting ENSEMBL IDs to symbols.

## Loading required package: org.Mm.eg.db

## Loading required package: AnnotationDbi

## Loading required package: stats4

## Loading required package: BiocGenerics

## Loading required package: parallel

##

## Attaching package: 'BiocGenerics'

## The following objects are masked from 'package:parallel':

##

##

##

##

clusterApply, clusterApplyLB, clusterCall, clusterEvalQ,

clusterExport, clusterMap, parApply, parCapply, parLapply,

parLapplyLB, parRapply, parSapply, parSapplyLB

## The following objects are masked from 'package:stats':

##

##

IQR, mad, sd, var, xtabs

## The following objects are masked from 'package:base':

##

##

##

##

##

##

##

Filter, Find, Map, Position, Reduce, anyDuplicated, append,

as.data.frame, basename, cbind, colnames, dirname, do.call,

duplicated, eval, evalq, get, grep, grepl, intersect, is.unsorted,

lapply, mapply, match, mget, order, paste, pmax, pmax.int, pmin,

pmin.int, rank, rbind, rownames, sapply, setdiff, sort, table,

tapply, union, unique, unsplit, which.max, which.min

## Loading required package: Biobase

## Welcome to Bioconductor

##

##

##

##

Vignettes contain introductory material; view with

'browseVignettes()'. To cite Bioconductor, see

'citation("Biobase")', and for packages 'citation("pkgname")'.

## Loading required package: IRanges

## Loading required package: S4Vectors

##

## Attaching package: 'S4Vectors'

## The following objects are masked from 'package:base':

##

##

##

I, expand.grid, unname

## 'select()' returned 1:many mapping between keys and columns

## Warning in clusterProfiler::bitr(matrixSym, fromType = annoType, toType =

## c("SYMBOL"), : 95.54% of input gene IDs are fail to map...

## Warning in retrieveFromGEO(matrixURL, countMatrixPath, species, metaDataPath =

## metaDataPath, : Nb of lines removed due to duplication of row names: 1

countMatrix <- result[[1]]

columnsMetaData <- result[[2]]

6

“ScRNA-seq workﬂow CONCLUS: from CONsensus CLUSters to a meaningful CONCLUSion”

## Correct the columns names to fit conclus input requirement

## The columns should be: cellName, state, and cellBarcode

columnsMetaData <- columnsMetaData[,c(1,3,2)]

colnames(columnsMetaData) <- c("cellName", "state", "cellBarcode")

## Removing embryonic hemoglobins with names starting with "Hba" or "Hbb"

idxHba <- grep("Hba", rownames(countMatrix))

idxHbb <- grep("Hbb", rownames(countMatrix))

countMatrix <- countMatrix[-c(idxHba, idxHbb),]

## Removing control human cells

idxHumanPos <- which(columnsMetaData$state == "Pos Ctrl")

idxHumanNeg <- which(columnsMetaData$state == "Neg Ctrl")

columnsMetaData <- columnsMetaData[-c(idxHumanPos, idxHumanNeg),]

countMatrix <- countMatrix[,-c(idxHumanPos, idxHumanNeg)]

## Removing genes not having an official symbol

idxENS <- grep("ENSMUSG", rownames(countMatrix))

countMatrix <- countMatrix[-idxENS,]

4.2.2 Using local data

If you executed the code above, a matrix path is stored in countMatrixPath and a ﬁle path
to the meta-data is stored in metaDataPath. Just indicate the paths to your ﬁles in these
two variables. Please also note that to load the metadata, you need to ﬁll in the columnID
argument with the name of the column containing the names of the cells. These names must
be the same as those in the count matrix.

## countMatrixPath <- ""

## metaDataPath <- ""

countMatrix <- loadDataOrMatrix(countMatrixPath, type="countMatrix")

columnsMetaData <- loadDataOrMatrix(file=metaDataPath, type="coldata",

columnID="")

## Filtering steps to add here as performed above

4.3

Test clustering

The TestClustering function runs one clustering round out of the 84 (default) rounds that
CONCLUS normally performs. This step can be useful to determine if the default DBSCAN
parameters are suitable for your dataset. By default, they are dbscanEpsilon = c(1.3, 1.4,
1.5) and minPts = c(3,4). If the dashed horizontal line in the k-NN distance plot lays on the
“knee” of the curve (as shown below), it means that optimal epsilon is equal to the intersection
of the line to the y-axis. In our example, optimal epsilon is 1.4 for 5-NN distance where 5
corresponds to MinPts.

In the “test_clustering” folder under outputDirectory, the three plots below will be saved
where one corresponds to the “distance_graph.pdf”, another one to “test_tSNE.pdf” (p[[1]]),
and the last one will be saved as “test_clustering.pdf” (p[[2]]).

7

“ScRNA-seq workﬂow CONCLUS: from CONsensus CLUSters to a meaningful CONCLUSion”

## Creation of the single-cell RNA-Seq object
scr <- singlecellRNAseq(experimentName = "E11_5",

countMatrix

= countMatrix,

species

= "mouse",

outputDirectory = outputDirectory)

## Normalization of the count matrix

scr <- normaliseCountMatrix(scr, coldata=columnsMetaData)

## # Attempt 1/5 # Connection to Ensembl ...

## Connected with success.

## Annotating 17484 genes considering them as SYMBOLs.

## 'select()' returned 1:many mapping between keys and columns

## # Attempt 1/5 # Retrieving information about genes from biomaRt ...

## Information retrieved with success.

## Adding cell info for cells filtering.

## Running filterCells.

## Number of cells removed after filtering: 171

## Number of cells remaining after filtering: 1311

## Running filterGenes.

## Number of genes removed after filtering: 5793

## Number of genes remaining after filtering: 11691

## Running normalization. It can take a while depending on the number of cells.

## summary(sizeFactors(sceObject)):

##

##

Min. 1st Qu. Median

Mean 3rd Qu.

Max.

0.2632 0.5302 0.7912 1.0000

1.2629 10.7638

p <- testClustering(scr, writeOutput=TRUE, silent=TRUE)

# saved as "outputDirectory/test_clustering/test_tSNE.pdf"
p[[1]]

# saved as "outputDirectory/test_clustering/test_clustering.pdf"
p[[2]]

8

“ScRNA-seq workﬂow CONCLUS: from CONsensus CLUSters to a meaningful CONCLUSion”

Figure 1:
optimal epsilon is equal to the intersection of the line to the y-axis

If the dashed horizontal line in the k-NN distance plot lays on the “knee” of the curve, it means that

Figure 2: One of the 14 tSNE (by default) generated by conclus

9

“ScRNA-seq workﬂow CONCLUS: from CONsensus CLUSters to a meaningful CONCLUSion”

Figure 3: One of the 84 dbscan clustering solutions generated by conclus

5

CONCLUS step by step

The wrapper function runCONCLUS is organized into 7 steps:

• Normalization of the counts matrix
• Generation of t-SNE coordinates
• Clustering with DB-SCAN
• Cell and cluster similarity matrix calculation
• Plotting
• Marker genes identiﬁcation
• Results export

5.1

Normalization of the counts matrix

sc-RNA-seq datasets are quite challenging notably because of sparsity (many genes are not
detected consistently yielding expression matrices with many zeroes) and also because of
technical noise. To facilitate analysis, one needs to perform a step of normalization which
allows for the correction of unwanted technical and biological noises (click here for a complete
review on normalization techniques).

CONCLUS uses Scran and Scater packages for normalization. Beforehand, the function will
annotate genes creating rowData and add statistics about cells into columnsMetaData. If you
already have columnsMetaData and rowData, you can give it to the function (see manual). It
will keep your columns and add new ones at the end. If you do not want to lose any cell after
quality metrics check, select alreadyCellFiltered = TRUE, by default it is FALSE. Before scran

10

“ScRNA-seq workﬂow CONCLUS: from CONsensus CLUSters to a meaningful CONCLUSion”

and scater normalization, the function will call scran::quickCluster (see manual for details). If
you want to skip this step, set runQuickCluster = FALSE, by default it is TRUE. We advice to
ﬁrst try the analysis with this option and to set it to FALSE if no rare populations are found.

scr <- normaliseCountMatrix(scr, coldata=columnsMetaData)

The method normaliseCountMatrix returns a scRNASeq object with its sceNorm slot updated.
This slot contains a SingleCellExperiment object having the normalized count matrix, the
colData (table with cells informations), and the rowData (table with the genes informations).
See ?SingleCellExperiment for more details.

The rowdata can help to study cross-talk between cell types or ﬁnd surface protein-coding
marker genes suitable for ﬂow cytometry. The columns with the GO terms are go_id and
name_1006 (see manual).

The slots can be accessed as indicated below:

## Accessing slots

originalMat <- getCountMatrix(scr)

SCEobject <- getSceNorm(scr)

normMat <- SingleCellExperiment::logcounts(SCEobject)

# checking what changed after the normalisation

dim(originalMat)

## [1] 17484 1482

dim(normMat)

## [1] 11691 1311

# show first columns and rows of the count matrix

originalMat[1:5,1:5]

##

c1 c2 c3 c4 c5

## Gnai3 0 0 0 0 0

## Cdc45 0 0 0 0 0

## H19

13 10 17 9 7

## Scml2 0 0 0 0 0

## Apoh

0 0 0 0 0

# show first columns and rows of the normalized count matrix

normMat[1:5,1:5]

##

c1

c2

c3

c4

c5

## Gnai3 0.000000 0.000000 0.000000 0.000000 0.000000

## Cdc45 0.000000 0.000000 0.000000 0.000000 0.000000

## H19

3.016462 3.517389 4.615128 4.293571 3.583963

## Scml2 0.000000 0.000000 0.000000 0.000000 0.000000

## Narf 0.000000 0.000000 1.252640 0.000000 0.000000

# visualize first rows of metadata (coldata)

coldataSCE <- as.data.frame(SummarizedExperiment::colData(SCEobject))

head(coldataSCE)

##

cellName

state cellBarcode genesNum genesSum oneUMI oneUMIper mtGenes

## c1

## c2

## c3

c1 YS_VECad_min AACCAACCTGC
c2 YS_VECad_min AACCAAGACGA
c3 YS_VECad_min AACCAAGCCTG

1621

984

912

2795

1552

1373

1168

72.05429

738

696

75.00000

76.31579

6

6

7

11

“ScRNA-seq workﬂow CONCLUS: from CONsensus CLUSters to a meaningful CONCLUSion”

## c4

## c5

## c6

c4 YS_VECad_min AACCAAGCTAA
c5 YS_VECad_min AACCAAGGCCT
c6 YS_VECad_min AACCAAGTTGG

653

846

474

904

1333

626

527

656

391

80.70444

77.54137

82.48945

1

6

3

##

mtSum codGenes codSum

mtPer

codPer

sumMtPer sumCodPer filterPassed

## c1

## c2

## c3

## c4

## c5

## c6

42

39

21

1

41

10

1526

2473 0.3701419 94.13942 1.5026834

88.47943

932

867

616

807

447

1393 0.6097561 94.71545 2.5128866

89.75515

1235 0.7675439 95.06579 1.5294975

89.94902

816 0.1531394 94.33384 0.1106195

90.26549

1224 0.7092199 95.39007 3.0757689

91.82296

590 0.6329114 94.30380 1.5974441

94.24920

1

1

1

1

1

1

##

sizeFactor

## c1 1.8331012

## c2 0.9568555

## c3 0.7231857

## c4 0.4835920

## c5 0.6368449

## c6 0.2909400

# visualize beginning of the rowdata containing gene information

rowdataSCE <- as.data.frame(SummarizedExperiment:::rowData(SCEobject))

head(rowdataSCE)

##

nameInCountMatrix

ENSEMBL SYMBOL

## Gnai3

## Cdc45

## H19

## Scml2

## Narf

## Cav2

##

Gnai3 ENSMUSG00000000001

Gnai3

Cdc45 ENSMUSG00000000028

Cdc45

H19 ENSMUSG00000000031

H19

Scml2 ENSMUSG00000000037

Scml2

Narf ENSMUSG00000000056

Cav2 ENSMUSG00000000058

Narf

Cav2

GENENAME

## Gnai3 guanine nucleotide binding protein (G protein), alpha inhibiting 3

## Cdc45

## H19

## Scml2

## Narf

## Cav2

##

## Gnai3

## Cdc45

## H19

## Scml2

## Narf

## Cav2

H19, imprinted maternally expressed transcript

cell division cycle 45

Scm polycomb group protein like 2

nuclear prelamin A recognition factor

caveolin 2

chromosome_name

go_id
<NA>

name_1006
<NA>

gene_biotype
3 protein_coding
16 protein_coding
7
lncRNA
X protein_coding
11 protein_coding
<NA>
6 protein_coding GO:0009986 cell surface

<NA>

<NA>

<NA>

<NA>

<NA>

<NA>

<NA>

5.2

Generation of t-SNE coordinates

runCONCLUS generates an object of fourteen (by default) tables with tSNE coordinates.
Fourteen because it will vary seven values of principal components PCs=c(4, 6, 8, 10, 20, 40,
50) and two values of perplexity perplexities=c(30, 40) in all possible combinations.

12

“ScRNA-seq workﬂow CONCLUS: from CONsensus CLUSters to a meaningful CONCLUSion”

The chosen values of PCs and perplexities can be changed if necessary. We found that this
combination works well for sc-RNA-seq datasets with 400-2000 cells. If you have 4000-9000
cells and expect more than 15 clusters, we recommend to use more ﬁrst PCs and higher
perplexity, for example, PCs=c(8, 10, 20, 40, 50, 80, 100) and perplexities=c(200, 240). For
details about perplexities parameter see ‘?Rtsne’.

scr <- generateTSNECoordinates(scr, cores=2)

## Running TSNEs using 2 cores.

## Calculated 14 2D-tSNE plots.

## Building TSNEs objects.

Results can be explored as follows:

tsneList <- getTSNEList(scr)

head(getCoordinates(tsneList[[1]]))

##

X

Y

## c1

-9.183802 -21.488517

## c2

-8.706768 -22.654050

## c3 -13.571749 -7.435195

## c4 -15.555757 -7.763260

## c5 -15.005760 -3.916296

## c6 -14.724732 -4.776731

5.3

Clustering with DB-SCAN
Following the calculation of t-SNE coordinates, DBSCAN is run with a range of epsilon
and MinPoints values which will yield a total of 84 clustering solutions (PCs x perplexities
x MinPoints x epsilon). minPoints is the minimum cluster size which you assume to be
meaningful for your experiment and epsilon is the radius around the cell where the algorithm
will try to ﬁnd minPoints dots. Optimal epsilon must lay on the knee of the k-NN function as
shown in the “test_clustering/distance_graph.pdf” (See Test clustering section above).

scr <- runDBSCAN(scr, cores=2)

Results can be explored as follows:

dbscanList <- getDbscanList(scr)

clusteringList <- lapply(dbscanList, getClustering)

clusteringList[[1]][, 1:10]

##

##

c1 c2 c3 c4 c5 c6 c7 c8

c9 c10

1

1

2

2

2

2

3

2

2

4

5.4

Cell and cluster similarity matrix calculation
The above calculated results are combined together in a matrix called “cell similarity matrix”.
runDBSCAN function returns an object of class scRNASeq with its dbscanList slot updated.
The list represents 84 clustering solutions (which is equal to number of PCs x perplexities
x MinPoints x epsilon). Since the range of cluster varies from result to result, there is no
exact match between numbers in diﬀerent elements of the list. Cells having the same number
within an element are guaranteed to be in one cluster. We can calculate how many times
out of 84 clustering solutions, every two cells were in one cluster and that is how we come
to the similarity matrix of cells. We want to underline that a zero in the dbscan results

13

“ScRNA-seq workﬂow CONCLUS: from CONsensus CLUSters to a meaningful CONCLUSion”

means that a cell was not assigned to any cluster. Hence, cluster numbers start from one.
clusterCellsInternal is a general method that returns an object of class scRNASeq with its
cellsSimilarityMatrix slot updated.

Note that the number of clusters is set to 10 (it was set to 11 in the original study, see
data section). Considering that clusters can be merged afterwards (see Supervised clustering
section), we advise to keep this number. One might want to increase it if the cell similarity
matrix or the tSNE strongly suggest more clusters but this number is suitable for most
experiments in our hands.

scr <- clusterCellsInternal(scr, clusterNumber=10)

## Calculating cells similarity matrix.

## Assigning cells to 10 clusters.

## Cells distribution by clusters:

##

1

2

3

4

5

6

7

8

9

10

## 206 170 340 54 136 34 112

8 123 128

cci <- getCellsSimilarityMatrix(scr)

cci[1:10, 1:10]

##

c1

c2

c3

c4

c5

c6

c7

## c1

1.0000000 1.0000000 0.5357143 0.5119048 0.5119048 0.5357143 0.9166667

## c2

1.0000000 1.0000000 0.5357143 0.5119048 0.5119048 0.5357143 0.9166667

## c3

0.5357143 0.5357143 1.0000000 0.9761905 0.9761905 1.0000000 0.5357143

## c4

0.5119048 0.5119048 0.9761905 0.9761905 0.9761905 0.9761905 0.5119048

## c5

0.5119048 0.5119048 0.9761905 0.9761905 0.9761905 0.9761905 0.5119048

## c6

0.5357143 0.5357143 1.0000000 0.9761905 0.9761905 1.0000000 0.5357143

## c7

0.9166667 0.9166667 0.5357143 0.5119048 0.5119048 0.5357143 1.0000000

## c8

0.5357143 0.5357143 1.0000000 0.9761905 0.9761905 1.0000000 0.5357143

## c9

0.5476190 0.5476190 0.9404762 0.9166667 0.9166667 0.9404762 0.5476190

## c10 0.4404762 0.4404762 0.7142857 0.7142857 0.7142857 0.7142857 0.4404762

##

c8

c9

c10

## c1

0.5357143 0.5476190 0.4404762

## c2

0.5357143 0.5476190 0.4404762

## c3

1.0000000 0.9404762 0.7142857

## c4

0.9761905 0.9166667 0.7142857

## c5

0.9761905 0.9166667 0.7142857

## c6

1.0000000 0.9404762 0.7142857

## c7

0.5357143 0.5476190 0.4404762

## c8

1.0000000 0.9404762 0.7142857

## c9

0.9404762 0.9523810 0.6547619

## c10 0.7142857 0.6547619 0.7976190

After looking at the similarity between elements on the single-cell level, which is useful if we
want to understand if there is any substructure which we did not highlight with our clustering,
a “bulk” level where we pool all cells from a cluster into a representative “pseudo cell” can
also be generated. This gives a clusterSimilarityMatrix :

scr <- calculateClustersSimilarity(scr)

csm <- getClustersSimilarityMatrix(scr)

csm[1:10, 1:10]

##

1

2

3

4

5

6

7

## 1

1.0000000 0.5357143 0.0000000 0.00000000 0.0000000 0.0000000 0.00000000

## 2

0.5357143 1.0000000 0.0000000 0.00000000 0.0000000 0.0000000 0.00000000

14

“ScRNA-seq workﬂow CONCLUS: from CONsensus CLUSters to a meaningful CONCLUSion”

## 3

0.0000000 0.0000000 0.9880952 0.00000000 0.0000000 0.0000000 0.00000000

## 4

0.0000000 0.0000000 0.0000000 1.00000000 0.0000000 0.1785714 0.02380952

## 5

0.0000000 0.0000000 0.0000000 0.00000000 1.0000000 0.1190476 0.11904762

## 6

0.0000000 0.0000000 0.0000000 0.17857143 0.1190476 0.9047619 0.39285714

## 7

0.0000000 0.0000000 0.0000000 0.02380952 0.1190476 0.3928571 1.00000000

## 8

0.0000000 0.0000000 0.0000000 0.00000000 0.0000000 0.1190476 0.14285714

## 9

0.0000000 0.0000000 0.0000000 0.07142857 0.4880952 0.1904762 0.11904762

## 10 0.0000000 0.0000000 0.0000000 0.07142857 0.4166667 0.3095238 0.23809524

##

8

9

10

## 1

0.0000000 0.00000000 0.00000000

## 2

0.0000000 0.00000000 0.00000000

## 3

0.0000000 0.00000000 0.00000000

## 4

0.0000000 0.07142857 0.07142857

## 5

0.0000000 0.48809524 0.41666667

## 6

0.1190476 0.19047619 0.30952381

## 7

0.1428571 0.11904762 0.23809524

## 8

1.0000000 0.00000000 0.11904762

## 9

0.0000000 0.92857143 0.73809524

## 10 0.1190476 0.73809524 0.98214286

5.5

Plotting

5.5.1

t-SNE colored by clusters or conditions

CONCLUS generated 14 tSNE combining diﬀerent values of PCs and perplexities. Each tSNE
can be visualized either using coloring reﬂecting the results of DBScan clustering, the conditions
(if the metadata contain a ‘state’ column) or without colors. Here plotClusteredTSNE is used
to generate all these possibilities of visualization.

tSNEclusters <- plotClusteredTSNE(scr, columnName="clusters",

returnPlot=TRUE, silentPlot=TRUE)

tSNEnoColor <- plotClusteredTSNE(scr, columnName="noColor",

returnPlot=TRUE, silentPlot=TRUE)

tSNEstate <- plotClusteredTSNE(scr, columnName="state",

returnPlot=TRUE, silentPlot=TRUE)

For visualizing the 5th (out of 14) tSNE cluster:

tSNEclusters[[5]]

This tSNE suggests that the cluster 8 corresponds to a rare population of cells. We can also
appreciate that clusters 1 and 2, as clusters 9 and 10 could be considered as single clusters
respectively.

For visualizing the 5th (out of 14) tSNE cluster without colors:

tSNEnoColor[[5]]

For visualizing the 5th (out of 14) tSNE cluster colored by state:

15

“ScRNA-seq workﬂow CONCLUS: from CONsensus CLUSters to a meaningful CONCLUSion”

Figure 4: DBscan results on the 5th tSNE

Figure 5: The 5th tSNE solution without coloring

16

“ScRNA-seq workﬂow CONCLUS: from CONsensus CLUSters to a meaningful CONCLUSion”

tSNEstate[[5]]

Figure 6: The 5th tSNE solution colored by cell condition

One can see that the cluster 8 contains only cells of the YS.

17

“ScRNA-seq workﬂow CONCLUS: from CONsensus CLUSters to a meaningful CONCLUSion”

5.5.2 Cell similarity heatmap

The cellsSimilarityMatrix is then used to generate a heatmap summarizing the results of the
clustering and to show how stable the cell clusters are across the 84 solutions.

plotCellSimilarity(scr)

Figure 7: Cell similarity matrix showing the conservation of clustering across the 84 solutions

CellsSimilarityMatrix is symmetrical and its size proportional to the “number of cells x number
of cells”. Each vertical or horizontal tiny strip is a cell. Intersection shows the proportion
of clustering iterations in which a pair of cells was in one cluster (score between 0 and 1,
between blue and red). We will call this combination “consensus clusters” and use them
everywhere later. We can appreciate that cellsSimilarityMatrix is the ﬁrst evidence showing
that CONCLUS managed not only to distinguish VE-Cad plus cells from the VE-Cad minus
but also ﬁnd sub-populations within these groups.

5.5.3 Cluster similarity heatmap

plotClustersSimilarity(scr)

18

“ScRNA-seq workﬂow CONCLUS: from CONsensus CLUSters to a meaningful CONCLUSion”

Figure 8: Cluster similarity matrix
Each cell belonging to a particular cluster were merged into a pseudo-cell.

In the clusterSimilarityMatrix, we can see that all clusters have a high value of similarity
across all clustering solutions. Red color on the diagonal means that the group is homogenous,
and usually, it is what we want to get. The yellow on the diagonal indicates that either that
group consists of two or more equal sized subgroups. The orange on the diagonal suggests
that groups can be merged. Bluish color points to a cluster of dbscan “outliers” that usually
surrounds dense clouds of cells in t-SNE plots.

As observed previously on the tSNE, clusters 1 and 2 as 9 and 10 are very similar. Clusters 3
and 8 are very diﬀerent.

5.6 Marker genes identiﬁcation

To understand the nature of the consensus clusters identiﬁed by CONCLUS, it is essential to
identify genes which could be classiﬁed as marker genes for each cluster. To this aim, each
gene should be “associated” to a particular cluster. This association is performed by looking
at up-regulated genes in a particular cluster compared to the others (multiple comparisons).
The method rankGenes performs multiple comparisons of all genes from the object and rank
them according to a score reﬂecting a FDR power.

19

“ScRNA-seq workﬂow CONCLUS: from CONsensus CLUSters to a meaningful CONCLUSion”

In summary, the method conclus::rankGenes() gives a list of marker genes for each cluster,
ordered by their signiﬁcance. See ?rankGenes for more details.

scr <- rankGenes(scr)

## Ranking marker genes for each cluster.

## Working on cluster 1

## Working on cluster 2

## Working on cluster 3

## Working on cluster 4

## Working on cluster 5

## Working on cluster 6

## Working on cluster 7

## Working on cluster 8

## Working on cluster 9

## Working on cluster 10

markers <- getMarkerGenesList(scr)

head(markers[[1]])

##

## 1

## 2

Gene

vs_6
Meg3 8.343307e-18 2.284650e-20 7.480243e-23 2.740867e-40 2.524738e-16

vs_5

vs_3

vs_4

vs_2

Lum 2.102234e-07 2.054250e-59 5.675174e-24 4.199109e-39 5.885003e-15

## 3

Col1a2 1.709419e-02 1.999075e-63 6.672556e-29 3.694856e-46 1.999570e-19

## 4

Col1a1 4.678890e-01 1.940152e-68 1.510479e-30 3.755727e-45 2.073039e-19

## 5

Col3a1 1.128049e-02 2.791366e-53 1.054180e-30 1.920425e-47 3.125246e-20

##

## 6 Smarca1 2.570866e-12 5.410950e-37 2.083733e-16 2.120136e-29 7.550241e-12
vs_10 mean_log10_fdr n_05
8

vs_8
## 1 6.241906e-19 0.7562095731 4.618701e-35 1.777810e-38

-22.71305

vs_9

vs_7

## 2 3.723086e-37 0.0011578798 6.598928e-37 1.188391e-40

## 3 9.141608e-44 0.0011118474 1.056232e-47 4.766268e-51

## 4 7.800407e-44 0.0005465644 1.423474e-48 2.777921e-53

## 5 9.141608e-44 0.0153524687 2.071863e-43 1.737900e-50

## 6 4.227191e-25 0.7562095731 7.172849e-27 4.548718e-29

-28.52098

-33.34050

-34.19386

-31.99967

-20.25725

9

9

8

9

8

##

score

## 1 2.152240

## 2 1.823508

## 3 1.772213

## 4 1.729328

## 5 1.715917

## 6 1.702738

The top 10 markers by cluster (default) can be selected with:

scr <- retrieveTopClustersMarkers(scr, removeDuplicates=TRUE)

topMarkers <- getClustersMarkers(scr)

topMarkers

##

## 1

## 2

## 3

## 4

## 5

## 6

geneName clusters

Meg3

Lum

Col1a2

Col1a1

Col3a1

Smarca1

1

1

1

1

1

1

20

“ScRNA-seq workﬂow CONCLUS: from CONsensus CLUSters to a meaningful CONCLUSion”

## 7

## 8

## 9

## 10

## 11

## 13

## 14

## 15

## 16

## 17

## 18

## 19

## 21

## 22

## 23

## 24

## 25

## 26

## 27

## 28

## 29

## 30

## 31

## 32

## 33

## 34

## 35

## 36

## 37

## 38

## 39

## 40

## 41

## 42

## 43

## 44

## 45

## 46

## 47

## 48

## 49

## 50

## 51

## 52

## 53

## 54

## 55

## 56

Colec10

Col5a1

Col5a2

Dcn

Prdx2

Acta2

Rpl41

Gpx1

Fth1

Car2

Nnat

Alas2

Gpc6

Ptn

Tenm3

Mdk

Aff3

Peg3

Foxp2

Zfhx4

Igfbp5

Auts2

Fcer1g

Ctss

Laptm5

Aif1

Tyrobp

Lst1

C1qc

Fcgr3

C1qb

Hcls1

Afp

Apoa2

Ttr

Apoa1

St6galnac3

Mt1

Apob

S100g

Nudt4

Mt2

Mctp1

Mitf

Slc9a9

Cd180

Tbxas1

Ptprj

## 57

1810011H11Rik

## 58

## 59

P2ry12

Runx1

1

1

1

1

2

2

2

2

2

2

2

2

3

3

3

3

3

3

3

3

3

3

4

4

4

4

4

4

4

4

4

4

5

5

5

5

5

5

5

5

5

5

6

6

6

6

6

6

6

6

6

21

“ScRNA-seq workﬂow CONCLUS: from CONsensus CLUSters to a meaningful CONCLUSion”

## 60

## 61

## 62

## 63

## 64

## 66

## 67

## 68

## 69

## 70

## 71

## 72

## 73

## 74

## 75

## 76

## 77

## 78

## 79

## 80

## 81

## 83

## 84

## 85

## 86

## 87

## 90

## 91

## 92

## 93

## 94

## 95

## 96

## 97

## 98

## 99

## 100

F13a1

Stab2

Lyve1

Calcrl

Flt1

Gpr182

Ralgapa2

Tek

Col13a1

Tmem2

Cldn1

A2m

Maob

Serpind1

Krt20

Pcbd1

Klb

F2

Pdzk1

Serpinf2

Cdk8

Camk1d

Epb41

Mir6236

Kel

Slc4a1

Ank1

Ptprm

Pde8a

Ptprg

Col18a1

Pecam1

Tspan18

Cdh5

Mecom

Mast4

Tie1

6

7

7

7

7

7

7

7

7

7

8

8

8

8

8

8

8

8

8

8

9

9

9

9

9

9

9

10

10

10

10

10

10

10

10

10

10

Cluster 8 contains the marker genes A2m, Cldn1, Maob, Pcbd1, Pdzk1, Krt20, Klb, Serpind1,
and F2. Alpha-2-Macroglobulin (A2m) is a large (720 KDa) plasma protein found in the blood
and is mainly produced by the liver; Claudins (CLDNs) are a family of integral membrane
proteins, Cldn1 being expressed by epithelial liver cells; The monoamine oxidase (Maob) is
found in abundance in the liver. All these markers play a role in the liver. This sub-population
is hence called liver-like hereafter.

6

Plot a heatmap with positive marker genes

Following the execution of the retrieveTopClustersMarkers method, CONCLUS oﬀers the
option to visualize the marker genes on a heatmap. Below we chose to show the selected 10
marker genes per cluster which should generate a heatmap with 100 genes (10 marker genes

22

“ScRNA-seq workﬂow CONCLUS: from CONsensus CLUSters to a meaningful CONCLUSion”

x 10 clusters). This is convenient for visualization. In practice, the number of genes in this
heatmap will be less than 100 because some genes were classiﬁed as markers for more than
one cluster. This can happen when several clusters correspond to similar cellular types.

After selecting the top markers with the method retrieveTopClustersMarkers, the method
plotCellHeatmap is used to order clusters and genes by similarity (the same order as in the
clusterSimilarityMatrix ) and show mean-centered normalized data. Mean-centering allows
seeing the relative expression of a gene compared to the mean.

plotCellHeatmap(scr, orderClusters=TRUE, orderGenes=TRUE)

Figure 9: Heatmap showing the expression of the top 10 markers for each cluster
The values are normalized according to the mean.

One can also visualize the heatmap without mean centering and appreciate the importance of
the normalization of colors by row. Indeed, the diﬀerent markers are much harder to identify.

plotCellHeatmap(scr, orderClusters=TRUE, orderGenes=TRUE, meanCentered=FALSE)

Alternative order of clusters is by name or by hierarchical clustering as in the default pheatmap
function.

23

“ScRNA-seq workﬂow CONCLUS: from CONsensus CLUSters to a meaningful CONCLUSion”

Figure 10: Same heatmap as before without normalizing by the mean

7

Plot t-SNE colored by expression of a selected
gene

PlotGeneExpression allows visualizing the normalized expression of one gene in a t-SNE plot.
It can be useful to inspect the speciﬁcity of top markers.

Cluster 8 was identiﬁed as being a liver-like rare population. Below are examples of the
expression of its marker genes:

plotGeneExpression(scr, "Maob", tSNEpicture=5)

plotGeneExpression(scr, "Pcbd1", tSNEpicture=5)

plotGeneExpression(scr, "Serpinf2", tSNEpicture=5)

plotGeneExpression(scr, "Cldn1", tSNEpicture=5)

24

“ScRNA-seq workﬂow CONCLUS: from CONsensus CLUSters to a meaningful CONCLUSion”

Figure 11: Maob Marker gene of cluster 8

Figure 12: Pcbd1 Marker gene of cluster 8

25

“ScRNA-seq workﬂow CONCLUS: from CONsensus CLUSters to a meaningful CONCLUSion”

Figure 13: Serpinf2 Marker gene of cluster 8

Figure 14: Cldn1 Marker gene of cluster 8

26

“ScRNA-seq workﬂow CONCLUS: from CONsensus CLUSters to a meaningful CONCLUSion”

8

8.1

Collect publicly available info about marker genes

Collect information for the top 10 markers for each cluster
retrieveGenesInfo retrieves gene information from NCBI, MGI, and UniProt. It requires the
retrieveTopMarkers method to have been run on the object.

scr <- retrieveGenesInfo(scr)

## # Attempt 1/5 # Connection to Ensembl ...

## Connected with success.

## # Attempt 1/5 # Retrieving information about genes from biomaRt ...

## Information retrieved with success.

## # Attempt 1/5 # Retrieving information about genes from biomaRt ...

## Information retrieved with success.

result <- getGenesInfos(scr)

head(result)

uniprot_gn_symbol clusters external_gene_name
Lum

Lum

1

Col1a2

Col1a1

Col3a1

Smarca1

Colec10

1

1

1

1

1

Col1a2

Col1a1

Col3a1

Smarca1

Colec10

##

## 1

## 2

## 3

## 4

## 5

## 6

##

## 1

## 2

## 3 GO:0005515, GO:0005201, GO:0005615, GO:0046872, GO:0005794, GO:0005737, GO:0005576, GO:0005783, GO:0005581, GO:0031012, GO:0045893, GO:0042802, GO:0048705, GO:0060325, GO:0007605, GO:0030141, GO:0030198, GO:0030199, GO:0001568, GO:0043589, GO:0001501, GO:0030020, GO:0062023, GO:0048706, GO:0090263, GO:0015031, GO:0002020, GO:0038063, GO:0071230, GO:0010812, GO:0030335, GO:0001957, GO:0007601, GO:0032964, GO:0043588, GO:0034505, GO:0010718, GO:0042060, GO:0001503, GO:0034504, GO:0001649, GO:0048407, GO:0001958, GO:0060346, GO:0060351, GO:0007584, GO:0009612, GO:0031667, GO:0031960, GO:0032355, GO:0042493, GO:0042542, GO:0043434, GO:0044344, GO:0044691, GO:0048545, GO:0051591, GO:0055093, GO:0071260, GO:0071300, GO:0071306, GO:0071356, GO:0071364, GO:0071560, GO:1902617, GO:1902618, GO:0005584,

## 4

## 5

## 6

##

## 1

## 2

## 3

## 4

mgi_description
lumican

collagen, type I, alpha 2

collagen, type I, alpha 1

collagen, type III, alpha 1

## 5 SWI/SNF related, matrix associated, actin dependent regulator of chromatin, subfamily a, member 1

## 6

##

## 1

## 2

## 3

## 4

collectin sub-family member 10
entrezgene_description
lumican

collagen, type I, alpha 2

collagen, type I, alpha 1

collagen, type III, alpha 1

## 5 SWI/SNF related, matrix associated, actin dependent regulator of chromatin, subfamily a, member 1

## 6

collectin sub-family member 10

, GO:0005515, GO:0005201, GO:0005615, GO:0060414, GO:0046872, GO:0005576, GO:0005581, GO:0031012, GO:0007507, GO:0030198, GO:0005178, GO:0007160, GO:0030199, GO:0001568, GO:0007179, GO:0046332, GO:0030020, GO:0062023, GO:0048565, GO:0002020, GO:0071230, GO:0034097, GO:0007229, GO:0035025, GO:0018149, GO:0043588, GO:0021987, GO:0009314, GO:0042060, GO:0097435, GO:0048407, GO:0050777, GO:0001501, GO:0009612, GO:2001223, GO:0005586

GO:0005634, GO:0003677, GO:0003676, GO:0005524, GO:0006338, GO:0031491, GO:0043044, GO:0016818, GO:0016787, GO:0000166, GO:0070615, GO:0005654, GO:0043231, GO:0045944, GO:0003682, GO:0004386, GO:0006325, GO:0045893, GO:0007420, GO:0000733, GO:0008094, GO:0008134, GO:0000785, GO:0016589, GO:0006355, GO:0090537, GO:0030182, GO:0036310, GO:2000177,

GO:0005634, GO:0005737, GO:0005794, GO:0005615, GO:0005576, GO:0005581, GO:0005829, GO:0030246, GO:0050918, GO:0006952, GO:0009792, GO:0007157, GO:0005537, GO:0042056, GO:1904888

, GO:0005201, GO:0005615, GO:0046872, GO:0005515, GO:0005576, GO:0005783, GO:0005581, GO:0042802, GO:0030674, GO:0030198, GO:0031012, GO:0007266, GO:0030282, GO:0030199, GO:0032963, GO:0001568, GO:0007179, GO:0046332, GO:0043589, GO:0001501, GO:0030020, GO:0062023, GO:0002020, GO:0071230, GO:0008217, GO:0048407, GO:0085029, GO:0005584, GO:0070208

GO:0005515, GO:0062023, GO:0007601, GO:0030199, GO:0005615, GO:0005576, GO:0045944, GO:0031012, GO:0005518, GO:0030021, GO:0014070, GO:0032914, GO:0051216, GO:0070848, GO:0005583

go_id

gene_biotype chromosome_name
10

Symbol

ensembl_gene_id
Lum ENSMUSG00000036446

mgi_id
MGI:109347

##
## 1 protein_coding
## 2 protein_coding
## 3 protein_coding
## 4 protein_coding
## 5 protein_coding
## 6 protein_coding

6

Col1a2 ENSMUSG00000029661

MGI:88468

11

Col1a1 ENSMUSG00000001506

MGI:88467

1

Col3a1 ENSMUSG00000026043

MGI:88453

X Smarca1 ENSMUSG00000031099 MGI:1935127

15 Colec10 ENSMUSG00000038591 MGI:3606482

27

“ScRNA-seq workﬂow CONCLUS: from CONsensus CLUSters to a meaningful CONCLUSion”

##

## 1

## 2

## 3

## 4

## 5

## 6

entrezgene_id
17022

uniprot_gn_id
P51885

12843

12842

12825

Q01149, Q3TX57, E0CXI2

P11087

P08121, Q3TVI5, A0A087WPJ5

93761 Q6PGB8, Q8BS67, F6QS43, F6Z6F4

239447

Q8CF98

result contains the following columns:

• uniprot_gn_symbol: Uniprot gene symbol.
• clusters: The cluster to which the gene is associated.
• external_gene_name: The complete gene name.
• go_id: Gene Ontology (GO) identiﬁcation number.
• mgi_description: If the species is mouse, description of the gene on MGI.
• entrezgene_description: Description of the gene by the Entrez database.
• gene_biotype: protein coding gene, lincRNA gene, miRNA gene, unclassiﬁed non-coding

RNA gene, or pseudogene.

• chromosome_name: The chromosome on which the gene is located.
• Symbol: Oﬃcial gene symbol.
• ensembl_gene_id: ID of the gene in the ensembl database.
• mgi_id: If the species is mouse, ID of the gene on the MGI database.
• entrezgene_id: ID of the gene on the entrez database.
• uniprot_gn_id: ID of the gene on the uniprot database.

9

Supervised clustering

Until now, we have been using CONCLUS in an unsupervised fashion. This is a good way to
start the analysis of a sc-RNA-seq dataset. However, the knowledge of the biologist remains
a crucial asset to get the maximum of the data. This is why we have included in CONCLUS,
additional options to do supervised analysis (or “manual” clustering) to allow the researcher
to use her/his biological knowledge in the CONCLUS workﬂow. Going back to the example
of the Shvartsman et al. dataset above (cluster similarity heatmap), one can see that some
clusters clearly belong to the same family of cells after examining the clusters_similarity matrix
generated by CONCLUS.

As previously mentioned, clusters 1 and 2 as 9 and 10 are very similar. In order to ﬁgure
out what marker genes are deﬁning these families of clusters, one can use manual clustering
in CONCLUS to fuse clusters of similar nature: i.e. combine clusters 1 and 2 (9 and 10)
together.

## Retrieving the table indicating to which cluster each cell belongs

clustCellsDf <- retrieveTableClustersCells(scr)

## Replace "2/10" by "1/9" to merge 1/2 and 9/10

clustCellsDf$clusters[which(clustCellsDf$clusters == 2)] <- 1

clustCellsDf$clusters[which(clustCellsDf$clusters == 10)] <- 9

## Modifying the object to take into account the new classification

scrUpdated <- addClustering(scr, clusToAdd=clustCellsDf)

28

“ScRNA-seq workﬂow CONCLUS: from CONsensus CLUSters to a meaningful CONCLUSion”

Now we can visualize the new results taking into account the new classiﬁcation:

plotCellSimilarity(scrUpdated)

Figure 15: Updated cells similarity matrix with merged 1/2 and 9/10

plotCellHeatmap(scrUpdated, orderClusters=TRUE, orderGenes=TRUE)

tSNEclusters <- plotClusteredTSNE(scrUpdated, columnName="clusters",

returnPlot=TRUE, silentPlot=TRUE)

tSNEclusters[[5]]

The cell heatmap above shows that Col1a1 is a good marker of cluster 1 and that Cdk8 is a
good marker of cluster 9 (at the bottom). One can visualize them in the t-SNE plots below.

plotGeneExpression(scrUpdated, "Col1a1", tSNEpicture=5)

plotGeneExpression(scrUpdated, "Cdk8", tSNEpicture=5)

29

“ScRNA-seq workﬂow CONCLUS: from CONsensus CLUSters to a meaningful CONCLUSion”

Figure 16: Updated cells heatmap with merged 1/2 and 9/10

30

“ScRNA-seq workﬂow CONCLUS: from CONsensus CLUSters to a meaningful CONCLUSion”

Figure 17: 5th tSNE solution colored by dbscan result showing the merged clusters

Figure 18: Col1a1 Marker gene for cluster 1 (mix of old clusters 1 and 2)

31

“ScRNA-seq workﬂow CONCLUS: from CONsensus CLUSters to a meaningful CONCLUSion”

Figure 19: Cdk8 Marker gene for clusters 9 (mix of old clusters 9 and 10)

32

“ScRNA-seq workﬂow CONCLUS: from CONsensus CLUSters to a meaningful CONCLUSion”

10 Conclusion

Here we demonstrated how to use CONCLUS and combine multiple parameters testing for
sc-RNA-seq analysis. It allowed us to identify a rare population in the data of Shvartsman et
al and will help gaining deeper insights into others.

11

Session info

sessionInfo()

## R version 4.1.0 (2021-05-18)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 20.04.2 LTS

##

## Matrix products: default

## BLAS:

/home/biocbuild/bbs-3.13-bioc/R/lib/libRblas.so

## LAPACK: /home/biocbuild/bbs-3.13-bioc/R/lib/libRlapack.so

##

## locale:

##

##

##

##

[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_GB
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

##
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##

## attached base packages:

## [1] parallel stats4

stats

graphics

grDevices utils

datasets

## [8] methods

base

##

## other attached packages:
## [1] org.Mm.eg.db_3.13.0 AnnotationDbi_1.54.0 IRanges_2.26.0
## [4] S4Vectors_0.30.0
## [7] conclus_1.0.0
##

Biobase_2.52.0
BiocStyle_2.20.0

BiocGenerics_0.38.0

## loaded via a namespace (and not attached):

##

##

##

##

##

##

##

##

##

##

##

##

##

##

[1] utf8_1.2.1
[3] RSQLite_2.2.7
[5] BiocParallel_1.26.0
[7] scatterpie_0.1.6
[9] ScaledMatrix_1.0.0
[11] statmod_1.4.36
[13] withr_2.4.2
[15] GOSemSim_2.18.0
[17] knitr_1.33
[19] robustbase_0.93-7
[21] MatrixGenerics_1.4.0
[23] polyclip_1.10-0
[25] farver_2.1.0
[27] downloader_0.4

tidyselect_1.1.1
grid_4.1.0
Rtsne_0.15
munsell_0.5.0
codetools_0.2-18
scran_1.20.0
colorspace_2.0-1
filelock_1.0.2
SingleCellExperiment_1.14.0
DOSE_3.18.0
GenomeInfoDbData_1.2.6
bit64_4.0.5
pheatmap_1.0.12
vctrs_0.3.8

33

“ScRNA-seq workﬂow CONCLUS: from CONsensus CLUSters to a meaningful CONCLUSion”

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

[29] treeio_1.16.0
[31] xfun_0.23
[33] diptest_0.76-0
[35] doParallel_1.0.16
[37] ggbeeswarm_0.6.0
[39] rsvd_1.0.5
[41] flexmix_2.3-17
[43] cachem_1.0.5
[45] DelayedArray_0.18.0
[47] scales_1.1.1
[49] nnet_7.3-16
[51] beeswarm_0.3.1
[53] beachmat_2.8.0
[55] rlang_0.4.11
[57] lazyeval_0.2.2
[59] BiocManager_1.30.15
[61] reshape2_1.4.4
[63] clusterProfiler_4.0.0
[65] bookdown_0.22
[67] ellipsis_0.3.2
[69] Rcpp_1.0.6
[71] sparseMatrixStats_1.4.0
[73] zlibbioc_1.38.0
[75] RCurl_1.98-1.3
[77] dbscan_1.1-8
[79] cowplot_1.1.1
[81] ggrepel_0.9.1
[83] factoextra_1.0.7
[85] data.table_1.14.0
[87] matrixStats_0.58.0
[89] patchwork_1.1.1
[91] XML_3.99-0.6
[93] gridExtra_2.3
[95] biomaRt_2.48.0
[97] tibble_3.1.2
[99] shadowtext_0.0.8

##
## [101] tidyr_1.1.3
## [103] DBI_1.1.1
## [105] dbplyr_2.1.1
## [107] fpc_2.2-9
## [109] Matrix_1.3-3
## [111] metapod_1.0.0
## [113] GenomicRanges_1.44.0
## [115] rvcheck_0.1.8
## [117] xml2_1.3.2
## [119] ggtree_3.0.0
## [121] dqrng_0.3.0
## [123] stringr_1.4.0
## [125] Biostrings_2.60.0
## [127] fastmatch_1.1-0
## [129] edgeR_3.34.0

generics_0.1.0
BiocFileCache_2.0.0
R6_2.5.0
GenomeInfoDb_1.28.0
graphlayouts_0.7.1
locfit_1.5-9.4
bitops_1.0-7
fgsea_1.18.0
assertthat_0.2.1
ggraph_2.0.5
enrichplot_1.12.0
gtable_0.3.0
tidygraph_1.2.0
splines_4.1.0
GEOquery_2.60.0
yaml_2.2.1
qvalue_2.24.0
tools_4.1.0
ggplot2_3.3.3
RColorBrewer_1.1-2
plyr_1.8.6
progress_1.2.2
purrr_0.3.4
prettyunits_1.1.1
viridis_0.6.1
SummarizedExperiment_1.22.0
cluster_2.1.2
magrittr_2.0.1
DO.db_2.9
hms_1.1.0
evaluate_0.14
mclust_5.4.7
compiler_4.1.0
scater_1.20.0
crayon_1.4.1
htmltools_0.5.1.1
aplot_0.0.6
tweenr_1.0.2
MASS_7.3-54
rappdirs_0.3.3
readr_1.4.0
igraph_1.2.6
pkgconfig_2.0.3
scuttle_1.2.0
foreach_1.5.1
vipor_0.4.5
XVector_0.32.0
digest_0.6.27
rmarkdown_2.8
tidytree_0.3.3
DelayedMatrixStats_1.14.0

34

“ScRNA-seq workﬂow CONCLUS: from CONsensus CLUSters to a meaningful CONCLUSion”

## [131] curl_4.3.1
## [133] modeltools_0.2-23
## [135] nlme_3.1-152
## [137] BiocNeighbors_1.10.0
## [139] limma_3.48.0
## [141] pillar_1.6.1
## [143] KEGGREST_1.32.0
## [145] httr_1.4.2
## [147] GO.db_3.13.0
## [149] png_0.1-7
## [151] iterators_1.0.13
## [153] bit_4.0.4
## [155] class_7.3-19
## [157] blob_1.2.1
## [159] memoise_2.0.0
## [161] irlba_2.3.3

kernlab_0.9-29
lifecycle_1.0.0
jsonlite_1.7.2
viridisLite_0.4.0
fansi_0.4.2
lattice_0.20-44
fastmap_1.1.0
DEoptimR_1.0-8
glue_1.4.2
prabclus_2.3-2
bluster_1.2.0
ggforce_0.3.3
stringi_1.6.2
BiocSingular_1.8.0
dplyr_1.0.6
ape_5.5

35

