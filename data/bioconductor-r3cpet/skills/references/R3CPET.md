R3CPET user manual

Mohamed Nadhir Djekidel, Yang Chen et al

djek.nad@gmail.com

October 30, 2025

Contents

1

2

Introduction .

.

.

Using R3CPET .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

Loading data .

Creating indexes .

building networks for DNA regions.

Inferring chromatin maintainer networks .

Cluster DNA interactions by enrichment profile .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.
.
.
.
.
.

.

.
.
.

.

.
.
.
.
.
.

.

.
.
.

.

.
.
.
.
.
.

.

.
.
.

.

.
.
.
.
.
.

.

.
.
.

.

.
.
.
.
.
.

.

.
.
.

.

.
.
.
.
.
.

.

.
.
.

.

.
.
.
.
.
.

.

.
.
.

.

.
.
.
.
.
.

.

.
.
.

.

.
.
.
.
.
.

.

.
.
.

.

.

.

.

.

.

.

.

.
.
.
.
.
.

.

.
.
.

.

.

.

.

.

.

.

.

.
.
.
.
.
.

.

.
.
.

.

.

.

.

.

.

.

.

.
.
.
.
.
.

.

.
.
.

.

.

.

.

.

.

.

.

.
.
.
.
.
.

.

.
.
.

.

.

.

.

.

.

.

.

.
.
.
.
.
.

.

.
.
.

.

.

.

.

.

.

.

.

.
.
.
.
.
.

.

.
.
.

.

.

.

.

.

.

.

.

.
.
.
.
.
.

.

.
.
.

.

.

.

.

.

.

.

.

.
.
.
.
.
.

.

.
.
.

.

.

.

.

.

.

.

.

.
.
.
.
.
.

.

.
.
.

.

.

.

.

.

.

.

.

.
.
.
.
.
.

.

.
.
.

.

.

.

.

.

.

.

.

.
.
.
.
.
.

.

.
.
.

.

.

.

.

.

.

.

.

.
.
.
.
.
.

.

.
.
.

.

.

.

.

.

.

.

.

.
.
.
.
.
.

.

.
.
.

.

.

.

.

.

.

.

.

.
.
.
.
.
.

.

.
.
.

.

.

.

.

.

.

.

.

.
.
.
.
.
.

.

.
.
.

.

.

.

.

.

.

.

.

.
.
.
.
.
.

.

.
.
.

.

.

.

.

.

.

.

.

.
.
.
.
.
.

.

.
.
.

.

.

.

.

.

.

.

.

.
.
.
.
.
.

.

.
.
.

.

.

.

.

.

.

.

.

.
.
.
.
.
.

.

.
.
.

.

.

.

.

.

.

.

.

.
.
.
.
.
.

.

.
.
.

.

.

.

.

.

.

.

.

.
.
.
.
.
.

.

.
.
.

.

.

.

.

.

.

.

.

.
.
.
.
.
.

.

.
.
.

.

.

.

.

.

.

.

2

3

3

6

7

7

. 10

. 10
. 11
. 11
. 12
. 13
. 14

. 14

. 15
. 15
. 15

. 16

.

.
.

.
.

.
.

Visualization .
2.6.1
2.6.2
2.6.3
2.6.4
2.6.5

.
.
Heatmaps.
.
Enrichment curves .
plot networks .
.
Networks similarity .
.
Circos maps .

.

.

.

Gene enrichment .

.

.

.

.

.
.
.
.
.
.

.

.
.
.
.
.
.

.

Using the web interface .
2.8.1
2.8.2

.
Raw data visualization .
.
Results visualization .

.

.

3

Session Info .

.

.

.

.

.

.

.

.

.

.

.

2.1

2.2

2.3

2.4

2.5

2.6

2.7

2.8

1

Introduction

R3CPET user manual

The breakthrough in chromatin conformation study done in the last decade has shed some light on many aspects
of gene transcription mechanisms and revealed that chromatin crosstalk plays an important role in connecting
regulatory sequences to their target promoters through loop formation

However, a key limitation of the existing chromatin conformation assays is that they can just give us the genomic
coordinates of the interacting DNA fragments but don’t tell us on the proteins involved.One used solution is to use
Chip-Seq to get the list of the proteins involved at these borders but one limitation is that not all the proteins can be
captured and some don’t have a specific anti-body.

Thus, computational methods are still useful to give some insight on the protein candidates that can play a role
in maintaining these interactions. R3CPET comes as a tool to fill this gap and try to infer the loop-maintaining
network(s) in a more concise manner.

3CPET is based on the following idea : if we can have the list of the protein networks that maintain all of the DNA-
interactions, then we can infer the set the most enriched networks. One of the widely used statistical model in this
kind of problems is the HLDA model which is a non-parametric Bayesian that enables us to infer the number of
different groups from the data.

In order to apply HLDA, we need to have a corpus of documents and we assign each word to a topic. In our case
each document is a network and each word is an edge in that network. To create a network for each interaction we
use (i) find the set of the proteins involved a the boundaries of a loop and this by using Chip-Seq peaks or motifs
data.

In the next step, we use the information in a background PPI to construct the network connecting the two interacting
DNA fragments.

The networks are then converted into a bag of edges (i.e allow repetition) and fed to the HLDA algorithm.

In this model, we suppose that each network (jn)∞
n=1 is made-up of a mixture of protein complexes each with
different a proportion θn ∼ DP (α, π). To infer the number of clusters, the model suppose that we have an infinite
number of chromatin maintainer networks distributed according to a certain distribution H. To enable the sharing
the complexes (βk) across all the networks, an intermediate discrete distribution is introduced (βk)N
k=1 sampled from
the base distribution H using a stick breaking construction π|γ ∼ GEM (γ).

Figure 1: Illustration of the network construction procedure.

2

Figure 2: HLDA model

R3CPET user manual
2

Using R3CPET

R3CPET package were built to enable the user to upload the data step-by-step and thus giving him a more granular
control of the data that he uses. Maybe it sounds like the use needs more labor, but the user can create an S3
wrapper function that encapsulate the workflow functions into one method.

Four main classes are provided by R3CPET :

1. ChiapetExperimentData - a container for the raw data to use. 3 types of data can be loaded into this class

respectively :ChIA-PET interactions, ChIP-Seq peaks and the background PPI.

2. NetworkCollection - Holds the list of the build networks for each DNA-interaction and their information.

3. HLDAResult - contains the results of the HLDA algorithm.

4. ChromMaintainers - contains the final results after processing the HLDA results (i.e: list of networks and

their nodes).

In addition to these classes additional helper methods for GO enrichment and and gene conversion.

2.1

Loading data

Before starting the analysis different kinds of dataset need be loaded. This can be done using a ChiapetExperi
mentData object.

The user can load the data using the ChiapetExperimentData constructor. By passing: ChIA-PET interactions
data, transcription factors binding site (TFBS) and a protein-protein interaction network. The ChIA-PET interactions
can be passed as path to a file or a GRanges object. The same is for the TFBS.

"HepG2_interactions.txt")

> library(R3CPET)
> petFile <- file.path(system.file("example", package = "R3CPET"),
+
> tfbsFile <- file.path(system.file("example", package = "R3CPET"),
+
> x <- ChiapetExperimentData(pet = petFile, tfbs = tfbsFile, IsBed = FALSE,
+

ppiType = "HPRD", filter = TRUE)

"HepG2_TF.txt.gz")

Three types of data can be loaded :

• ChIA-PET interactions - which can have two formats: (i) the first type is a file in which the first six columns

indicate the left and right interacting parts (generally parsed from the ChIA-PET tool). For example

> petPath <- system.file("example", "HepG2_interactions.txt", package = "R3CPET")
> petFile <- read.table(petPath, sep = "\t", header = TRUE)
> head(petFile)

##
## 1
## 2
## 3

chromleft startleft endleft chromright startright
1283743
1372332
2161279

1282738 1283678
1370817 1371926
2159841 2161268

chr1
chr1
chr1

chr1
chr1
chr1

3

ABLDEFHGXCJK......L                          0.12D    0.10G0.09………A                    0.113E0.08F0.04………X                         0.13K 0.105J0.07………R                           0.17T0.13W0.07………pj,nzj,nθnπβkHαγJnN∞|  ~ () | ,  ~ (,) |  ~ () | ~  | ,()=1∞  ~ ()   chr1
chr1
chr1
endright counts

2159841 2161268
2161279 2162108
9187131 9188440

chr1
chr1
chr1

2162130
2162130
9188469

R3CPET user manual

## 4
## 5
## 6
##
## 1 1284926
## 2 1373312
## 3 2162108
## 4 2163908
## 5 2163908
## 6 9189622

qvalue
pvalue
6 1.075586e-21 8.8e-05
8 3.536936e-26 8.8e-05
18 5.487730e-57 8.8e-05
6 8.048577e-17 8.8e-05
17 2.792212e-55 8.8e-05
7 2.576820e-28 8.8e-05

Here only the 6 first columns are considered. It is up to the user to filter the significant interactions for him.

The second type of files that can be loaded is a four columns file in which the first three columns indicate the
genomic location of a DNA region and the forth column indicate if the region is located at the right or left side.
The IDs in the fourth column should have the pattern PET#\\d+\\.1 for the left side and PET#\\d+\\.2 for
the right side. if the number of the left side interactions is different from the right side an error will be raised.

> petPath <- system.file("example", "HepG2_centered.bed", package = "R3CPET")
> petFile <- read.table(petPath, sep = "\t", header = FALSE, comment.char = "+")
>
> head(petFile)

V3

V1

##
V4
V2
## 1 chr1 1241234 1242234 PET#1.1
## 2 chr1 1242724 1243724 PET#1.2
## 3 chr1 1282708 1283708 PET#2.1
## 4 chr1 1283834 1284834 PET#2.2
## 5 chr1 1370871 1371871 PET#3.1
## 6 chr1 1372322 1373322 PET#3.2

The method loadPETs can be used to load the data

> ## if it has 6 columns format IsBed = FALSE
> petPath <- system.file("example", "HepG2_interactions.txt", package = "R3CPET")
> x <- loadPETs(x, petFile = petPath, IsBed = FALSE)

## 304 interacting DNA regions loaded

if the file is 4 columns BED file you can set IsBed = TRUE

> ## loading a 4 columns BED file
> petPath <- system.file("example", "HepG2_centered.bed", package = "R3CPET")
> x <- loadPETs(x, petFile = petPath, IsBed = TRUE, header = FALSE)

The pet(x) accessor method can be used to read the loaded interactions as GRanges object.

• ChIP-Seq peaks - All the ChIP-Seq peaks of the different TF should be merged into a 4 columns in which the
first 3 columns indicate the position of the peak and the last column indicate the associated TF. The loadTFBS
method can be used to do so.

> ## loading a 4 columns BED file
> TFPath <- system.file("example", "HepG2_TF.txt.gz", package = "R3CPET")

4

> TF <- read.table(TFPath, sep = "\t", header = FALSE)
> head(TF)

R3CPET user manual

V2

V1

V4
##
V3
HEY1
## 1 chr8 67804615 67804862
## 2 chr15 52200521 52200848 FOSL2
## 3 chr15 70820640 70820932 EP300
## 4 chr13 48775200 48775538 EP300
## 5 chr3 23987219 23988231 FOSL2
## 6 chr6 56263941 56265486 FOSL2

> x <- loadTFBS(x, tfbsFile = TFPath)

## a total of 81414 binding sites for 6 TF

were loaded

• Protein interaction - a background PPI is needed to do the networks construction. The package comes with

two build in PPI : the HPRD and the Biogrid PPI.

> data(HPRD)
> data(Biogrid)
>
> PPI.HPRD

## This graph was created by an old(er) igraph version.
## i Call ‘igraph::upgrade_graph()‘ on it to use with the
##
## For now we convert it on the fly...

current igraph version.

[1] ALDH1A1--ALDH1A1 ITGA7
[4] SRGN
--CD44
[7] ERBB2 --DLG4

## IGRAPH 84de311 UN-- 9616 39042 --
## + attr: name (v/c)
## + edges from 84de311 (vertex names):
PPP1R9A--ACTG1
##
ERBB2
##
##
ERBB2
## [10] ERBB2 --ERBB2IP SMURF2 --ARHGAP5 ERBB2
ERBB2
## [13] ERBB2 --CD82
ERBB2
## [16] ERBB2 --TOB1
DDX20
## [19] SMURF2 --TXNIP
## [22] FOXG1 --TLE3
FOXG1
## + ... omitted several edges

--PAK1
--PTPN18
--NF2
--MMP7
--PICK1
--FOXG1
--SMAD1

--ERRFI1
--MUC4
--ETV3
--HDAC1

--CHRNA1
--ERBB2
--PIK3R2

CD44
ERBB2
TLE1
FOXG1

GRB7
ERBB2

> PPI.Biogrid

## This graph was created by an old(er) igraph version.
## i Call ‘igraph::upgrade_graph()‘ on it to use with the
##
## For now we convert it on the fly...

current igraph version.

## IGRAPH 2eeef88 UN-- 16227 169166 --
## + attr: name (v/c)
## + edges from 2eeef88 (vertex names):
##
##

[1] MAP2K4--FLNC
[4] GATA2 --PML

--ACTN2
--STAT3

MYPN
RPA2

ACVR1 --FNTA
--GGA3
ARF1

5

R3CPET user manual

[7] ARF3 --ARFIP2

##
## [10] XRN1 --ALDOA
## [13] CITED2--TFAP2A
## [16] ARRB2 --RALGDS
## [19] LSM1 --NARS
## [22] ADRB1 --GIPC1
## + ... omitted several edges

--ARFIP1
--APPBP2

AKR1A1--EXOSC4
ARF3
APLP1 --DAB1
APP
--MTTP
APOB
TFAP2A--EP300
--PRRC2A
CSF1R --GRB2
GRB2
--BARD1
SLC4A1--SLC4A1AP BCL3
BRCA1 --ATF1

BRCA1 --MSH2

The loadPPI method can be used to load and filter the PPI according to different criteria.

> loadPPI(object, type = c("HPRD", "Biogid"), customPPI = NULL,
+
+

filter = FALSE, term = "GO:0005634", annot = NULL, RPKM = NULL,
threshold = 1)

if customPPI one of the built-in PPI will be used otherwise the user can provide a path to an ncol formatted
graph (two column to indicate interacting nodes) or directly provide an igraph object.

The user can also do some filtering to remove proteins that he thinks are not significant. by default the package
keeps only the proteins that are located at nucleus (term = "GO:0005634"). The user can provide his own
annotation to the annot parameter. In some cases the user want to keep only the cell specific genes, thus he
can filter genes according to their gene expression by providing a two columns gene expression table to the
RPKM parameter and set the threshold.

> ## loading the PPI with GO filtering
> x <- loadPPI(x, type = "HPRD", filter = TRUE)

## This graph was created by an old(er) igraph version.
## i Call ‘igraph::upgrade_graph()‘ on it to use with the
##
## For now we convert it on the fly...
## loading HPRD network, with 9616 nodes

current igraph version.

2.2

Creating indexes

When the user thinks that the data that he loaded is ok, he need to create indexes for processing in the further
steps. Indexes can be created by calling the method createIndexes.

> x <- createIndexes(x)

## [1] "Creating PET table"
## [1] "Sorting Table"
## [1] "Get TF associated with each PETs"
## [1] "Creating Motifs table"
## [1] "Sorting Table"
## [1] "Creating hasMotif table"
## [1] "Sorting Table"

> x

## class: ChiapetExperimentData
## 304
## 6 TF used

interacting regions

6

## Background PPI:
##
nodes: 3447
## indexes tables have been created

edges: 14882

R3CPET user manual

2.3

building networks for DNA regions

One all the data are loaded we can go to the next step and build the protein interaction networks for each chromatin
loop. The buildNetworks is used and a NetworkCollection is returned. When the networks are built, the rare
and the more frequent edges are removed as they are considered to be not specific. By default, edges that appear
in less than 25% or more than 75% of the total networks are removed.

the user can set these values by modifying the minFreq and maxFreq parameters of the buildNetworks method.

> nets <- buildNetworks(x, minFreq = 0.1, maxFreq = 0.9)
> nets

## class NetworkCollection
## 145 network loaded
## 128 diffrent edges has been used

The buildNetworks uses the parallel package to parallelize the processing.If the user has 4 cores, then 4
Rinstances will be lunched at the background each running on a core and handling part of the data.

2.4

Inferring chromatin maintainer networks

At this step the InferNetworks can be used to run the HLDA algorithm and infer the set of the most enriched
chromatin maintainer networks. by default, the algorithm do a maximum of 500 iteration or stops after 1 hour.

InferNetworks(object, thr = 0.5, max_iter = 500L, max_time = 3600L,

eta = 0.01, gamma = 1, alpha = 1)

To control the behaviour of the algorithm, users can modify the values of the HDP algorithm paramters eta, gamma
and alpha. Briefly, eta and alpha control the sparcity of the edge-to-CMN matrix. In other words, smaller values
allow force an edge to belong to a small number of CMNs (ideally one) and larger values (>1) alow them to be
uniformly assigned. gamma controls the number of CMNs, smaller values leads to less prediced CMNs while larger
values leads to more CMNs. Users can check figures S13-S16 of the mauscript.

When the algorithm finishes we get a matrix that indicates the degree of partnership of each edge to the inferred
networks (each network is distribution over edges). Thus, to get the top elements in each network, we use the
parameter thr to select the edges that capture thr% of the network. Thus, more general networks tend to have
bigger number elements and more specific networks have less elements. At the end a ChromMaintainers object
is returned.

> hlda <- InferNetworks(nets)
> hlda

## class: ChromMaintainers
## HLDA Results:
## ------------
## 145 element have been classified into 10 topics
## Number of different words 128

7

The different slots of the hlda object can be accessed using the following accessor methods:

• topEdges : to get the list of the top edges in each network.

R3CPET user manual

• topNodes : to get the list of the top nodes in each network.

• networks : to get a list igraph objects.

> head(topEdges(hlda))

Topic_4

Topic_1

Topic_2

"ESR1_PPARGC1A"

"FOSL2_JUNB"
""

Topic_5
"ESR1_JUND"
"EP300_ESR1"

Topic_3
##
"FOSL2_JUND"
## [1,] "EP300_MYOD1" "ESR1_ESRRA"
"FOSL2_JUN"
"ESR1_NCOA1"
## [2,] "ARNT_EP300"
## [3,] "GABPA_SP1"
"JUN_MYOD1"
"ESRRA_NCOA1"
## [4,] "CREBBP_SMAD3" "NCOA1_PPARGC1A" "JUN_SMAD3"
## [5,] "MYOD1_SP1"
## [6,] "CREBBP_MYOD1" "ESR1_SMAD3"
##
## [1,] "GABPA_SP1"
## [2,] "MAPK1_SP1"
## [3,] "MAPK1_SMAD4" "EP300_SMAD4" "BCL6_EP300"
"ESR1_SMAD3"
## [4,] "MAPK1_SMAD3" "ESR1_SMAD4"
"BRCA1_SMAD3" ""
## [5,] "JUND_MAPK1" "EP300_JDP2"
""
""
## [6,] "BCL6_MAPK1" ""
##
Topic_8
## [1,] "EP300_GABPA" "EP300_NCOA1" "CREBBP_PROX1"
## [2,] "EP300_SP1"
"GTF2B_NCOA1" "MAPK1_PRKCD"
## [3,] "CREBBP_EP300" "ESRRA_GTF2B" "MAPK1_NCOA3"
## [4,] "ATF1_CREBBP" "ESR1_NCOA3"
"MAPK1_NCOA1"
## [5,] "ATF1_GABPA"
## [6,] "CREBBP_GABPA" "EP300_ESR1"

"ESRRA_NCOA3" ""
""

Topic_10

Topic_9

Topic_7
"FOSL2_JUND"

Topic_6
"JUND_SMAD4"
"BRCA1_SMAD4" "EP300_JUN"
"FOSL2_JUN"
"JUN_SMAD3"

> head(topNodes(hlda))

"SMAD3"

Topic_1 Topic_2

Topic_3 Topic_4 Topic_5 Topic_6
"JUND"
"FOSL2" "GABPA" "ESR1"
"SMAD4"
"JUND"
"SP1"
"JUND"
"MAPK1" "EP300" "BRCA1"
"JUN"

##
## [1,] "EP300" "ESR1"
## [2,] "MYOD1" "ESRRA"
## [3,] "ARNT"
"NCOA1"
## [4,] "GABPA" "PPARGC1A" "MYOD1" "SMAD4" "SMAD4" "BCL6"
## [5,] "SP1"
## [6,] "CREBBP" "ARNT"
##
Topic_7 Topic_8 Topic_9 Topic_10
## [1,] "FOSL2" "EP300" "EP300" "CREBBP"
## [2,] "JUND" "GABPA" "NCOA1" "PROX1"
"GTF2B" "MAPK1"
## [3,] "EP300" "SP1"
"CREBBP" "ESRRA" "PRKCD"
## [4,] "JUN"
"ESR1" "NCOA3"
## [5,] "SMAD3" "ATF1"
"NCOA3" "NCOA1"
## [6,] ""

"SMAD3" "SMAD3" "JDP2"
"JUND"
"JUNB"

"EP300"
"ESR1"

""

""

The igraph networks are not created at the beginning, the GenerateNetworks should be used to convert the
topEdges slot into networks.

> hlda <- GenerateNetworks(hlda)
> head(networks(hlda))

8

R3CPET user manual

NCOA1--ARNT

MYOD1 --SP1

ESR1 --ARNT

ESRRA--NCOA1

ESR1 --NCOA1

MYOD1 --CREBBP CREBBP--SMAD3

## $Network1
## IGRAPH 807e5df UN-B 7 6 --
## + attr: name (v/c), type (v/c)
## + edges from 807e5df (vertex names):
## [1] EP300 --MYOD1 EP300 --ARNT
## [4] GABPA --SP1
##
## $Network2
## IGRAPH ef4f667 UN-B 6 9 --
## + attr: name (v/c), type (v/c)
## + edges from ef4f667 (vertex names):
## [1] ESR1 --ESRRA
## [4] ESR1 --PPARGC1A ESRRA--PPARGC1A NCOA1--PPARGC1A
## [7] ESR1 --SMAD3
##
## $Network3
## IGRAPH dfc5a77 UN-B 6 5 --
## + attr: name (v/c), type (v/c)
## + edges from dfc5a77 (vertex names):
## [1] FOSL2--JUND FOSL2--JUN
## [5] FOSL2--JUNB
##
## $Network4
## IGRAPH 1b4ec5c UN-B 11 15 --
## + attr: name (v/c), type (v/c)
## + edges from 1b4ec5c (vertex names):
##
##
##
--TBP
## [13] SP1 --BRCA1 TBP --ESR1
##
## $Network5
## IGRAPH e1d196a UN-B 5 5 --
## + attr: name (v/c), type (v/c)
## + edges from e1d196a (vertex names):
## [1] ESR1 --JUND ESR1 --EP300 ESR1 --SMAD4 EP300--SMAD4
## [5] EP300--JDP2
##
## $Network6
## IGRAPH e706280 UN-B 7 5 --
## + attr: name (v/c), type (v/c)
## + edges from e706280 (vertex names):
## [1] JUND --SMAD4 SMAD4--BRCA1 BCL6 --EP300 BRCA1--SMAD3
## [5] ESR1 --SMAD3

SP1 --MAPK1 SP1
SP1
SP1
MAPK3--ESR1

[1] GABPA--SP1
[5] MAPK1--SMAD3 MAPK1--JUND
[9] SP1

--SMAD4 MAPK1--SMAD4
--BCL6
--MAPK3 JUND --MAPK3

MAPK1--BCL6

--MYOD1 JUN

JUND --TBP

--SMAD3

JUN

if the user wants to annotate each protein in the network by its gene expression he can use the annotateExpres
sion method. To use this method the user needs to provide a data.frame object, that contains the names of the
genes in the first column and their expression value in the second.

> data(RPKMS)
> hlda <- annotateExpression(hlda, RPKMS)

9

> networks(hlda)[[1]]

R3CPET user manual

## IGRAPH 807e5df UN-B 7 6 --
## + attr: name (v/c), type (v/c), RPKM (v/n)
## + edges from 807e5df (vertex names):
## [1] EP300 --MYOD1 EP300 --ARNT
## [4] GABPA --SP1

MYOD1 --CREBBP CREBBP--SMAD3

MYOD1 --SP1

We can notice that the RPKM attribute was added to the network.

2.5

Cluster DNA interactions by enrichment profile

Till the moment we can say ok, we got the list of out networks and we can do further biological examination to check
the results, however,it would be nice if we can know which DNA interactions are enriched for same networks. Thus,
the package provide a clustering feature to further analysis.

The clusterInteractions can be used to do so. The sota method of the clValid package is used.

The clusterInteractions is defined as follow:

clusterInteractions(object, method = "sota", nbClus = 20)

> ## clustering
> hlda <- clusterInteractions(hlda, method = "sota", nbClus = 6)

## clusterInteractions : checking
## clusterInteractions : reading args
## using clValid

## DNA interactions have been clustered into 6 cluster

2.6

Visualization

The package comes with a bunch of visualization plots to enable the exploration of data mainly through the
plot3CPETRes method.

plot3CPETRes(object, path = "", W = 14, H = 7, type = c("heatmap",

"clusters", "curve", "avgCurve", "netSim", "networks"), byEdge = TRUE,
layoutfct = layout.kamada.kawai, ...)

To get the genomic coordinates of the regions involved in each cluster the methods getRegionsIncluster can
be used. To use it the initial initial interaction data should be provided.

> getRegionsIncluster(hlda, x, cluster = 3)

## GRanges object with 38 ranges and 1 metadata column:
##
##
##
##
##
##

PET_ID
<Rle> | <character>
PET#11.1
PET#11.2
PET#14.1
PET#14.2

<IRanges>
20832660-20834660
20833954-20835954
24116461-24118461
24117714-24119714

seqnames
<Rle>
chr1
chr1
chr1
chr1

ranges strand |

[1]
[2]
[3]
[4]

* |
* |
* |
* |

10

chr1
...

##
##
##
R3CPET user manual
##
##
##
##
##
##

38155583-38157583
...
chr3 101293007-101295007
chr3 133378968-133380968
chr3 133380114-133382114
chr5 110427069-110429069
chr5 110428082-110430082

[5]
...
[34]
[35]
[36]
[37]
[38]
-------
seqinfo: 6 sequences from an unspecified genome; no seqlengths

PET#26.1
...
PET#222.2
PET#232.1
PET#232.2
PET#287.1
PET#287.2

* |
... .
* |
* |
* |
* |
* |

2.6.1 Heatmaps

After clustering the enrichment map can be visualized using the heatmap option in the plot3CPETRes method.
Here each column represent a chromatin-chromatin interaction and each row represents a chromatin maintainer
network. The colors indicate the probability that a chromatin-chromatin interaction is maintained by a chromatin
maintainer network.

> plot3CPETRes(hlda, type = "heatmap")

2.6.2 Enrichment curves

An other way to check the enrichment of the different chromatin interactions in the different clusters is by plotting
the enrichment and average enrichment curves in of the chromatin interactions in each clusters.

if the type parameter of the plot3CPETRes method is set to curve the enrichment profile of all the interactions
per cluster is displayed as shown bellow:

> ## plotting curves
> plot3CPETRes(hlda, type = "curve")

11

Topic1Topic2Topic3Topic4Topic5Topic6Topic7Topic8Topic9Topic10ClusterClustercluster1cluster2cluster3cluster4cluster5cluster600.20.40.60.81R3CPET user manual

if type = "avgCurve" then the average curves are displayed.

> ## plotting Average curves
> plot3CPETRes(hlda, type = "avgCurve")

## curves and avgCurves are only plotted for clues objects.

function kept for legacy

2.6.3

plot networks

if type ="networks" is used, a pdf file AllGraphs.pdf is created and contains one networks per page. This
method returns a ggplot list (one for each network). By default the layout.kamada.kawai from the igraph
package is used by the user can pass any other function through the layoutfct parameter.

12

2468100.00.40.8Cluster  1Expr. Level52  Elements2468100.00.40.8Cluster  2Expr. Level40  Elements2468100.00.40.8Cluster  3Expr. Level19  Elements2468100.00.40.8Cluster  4Expr. Level19  Elements2468100.00.40.8Cluster  5Expr. Level6  Elements2468100.00.40.8Cluster  6Expr. Level9  Elements2468100.00.40.8Cluster  1Expr. Level52  Elements2468100.00.40.8Cluster  2Expr. Level40  Elements2468100.00.40.8Cluster  3Expr. Level19  Elements2468100.00.40.8Cluster  4Expr. Level19  Elements2468100.00.40.8Cluster  5Expr. Level6  Elements2468100.00.40.8Cluster  6Expr. Level9  Elements> nets_plot <- plot3CPETRes(hlda, type = "networks")
> plot(nets_plot[[4]])

R3CPET user manual

2.6.4 Networks similarity

To the degree to which the infered networks share some common edges we can set type = "netSim". of course,
the smaller the similarity the better.

> plot3CPETRes(hlda, type = "netSim")

13

GABPASP1MAPK1SMAD4SMAD3JUNDBCL6TBPMAPK3BRCA1ESR1−101−1.0−0.50.00.51.0Network 4Network4Network3Network7Network5Network9Network2Network6Network1Network8Network10Network4Network3Network7Network5Network9Network2Network6Network1Network8Network1000.20.40.60.812.6.5 Circos maps

R3CPET also enable the user to plot a basic circos map for a given cluster through the method visualizeCircos.
The initial data should be passed in the data parameter as a ChiapetExperimentData object.

R3CPET user manual

visualizeCircos(object, data, cluster = 1, chrLenghts = NULL)

By default, the human chromosome lengths are used, if the user is using different species he can provide his own
chromosome lengths as a two columns data.frame that contains the name of the chromosome in the first column
and the length in the second one.

> visualizeCircos(hlda, x, cluster = 4)

2.7

Gene enrichment

R3CPET enable uses to do a GO analysis using the DAVID web service. Two types of enrichment can be done:

• GO enrichment analysis of the proteins of the inferred networks using the GOEnrich.networks method.

14

chr1chr2chr3chr4chr5chr19Interactions in cluster 4• GO enrichment of the chromatin interaction clusters using the GOEnrich.folder method.

2.8
R3CPET user manual

Using the web interface

After getting all the results (HLDA, clustering, ... etc), the user can display the results using a web browser developed
using the shiny package. This can be done thought the method createServer.

createServer(x, nets, hlda)

In the website the user can have some information about the raw data, such as the used TF, how many regeions
each TF binds, the distribution of interaction per cluster, .... etc. Some of the features are explained in the flowing
points

2.8.1 Raw data visualization

Statistics about the 3 types of raw data data (chromatin interactions, TFBS, PPI) can be displayed. Two select
options are available under the "Raw Data" panel:

Figure 3: Example showing the histogram of the number of interacting region per chromosome

• data type selection option: in which the user selects the type of data he wants analyze : Interactions, TFBS or

PPI.

• statistics selection option : in which the user selects the type of the plot he wants to generate (Figure 4)

2.8.2 Results visualization

This panel also enables the user to interactively analyze his results. Two types of results can be analyzed : The
concerning the Chromatin maintainer networks, and the other one about the clustered genomic regions. For exam-
ple, Figure 5. shows a screenshot in which the user selects a Chromatin maintainer network and display it in an
interactive manner using the D3js javascript library.

15

R3CPET user manual

Figure 4: Example of the plots in the web interface

3

Session Info
sessionInfo()

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_GB
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C

## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0
##
## locale:
##
##
##
##
##
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats4
## [6] datasets methods
##
## other attached packages:
##
##
##
##
##

[1] ggplot2_4.0.0
[3] Rcpp_1.1.0
[5] GenomicRanges_1.62.0 Seqinfo_1.0.0
[7] IRanges_2.44.0
[9] BiocGenerics_0.56.0 generics_0.1.4

R3CPET_1.42.0
igraph_2.2.1

graphics
base

S4Vectors_0.48.0

grDevices utils

stats

LAPACK version 3.12.0

16

[1] DBI_1.2.3
[2] bitops_1.0-9
[3] RBGL_1.86.0
[4] gridExtra_2.3
[5] formatR_1.14
[6] rlang_1.1.6
[7] magrittr_2.0.4
[8] biovizBase_1.58.0
[9] matrixStats_1.5.0

##
## loaded via a namespace (and not attached):
##
R3CPET user manual
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

[10] compiler_4.5.1
[11] RSQLite_2.4.3
[12] GenomicFeatures_1.62.0
[13] png_0.1-8
[14] vctrs_0.6.5
[15] reshape2_1.4.4
[16] ProtGenerics_1.42.0
[17] stringr_1.5.2
[18] pkgconfig_2.0.3
[19] crayon_1.5.3
[20] fastmap_1.2.0
[21] backports_1.5.0
[22] XVector_0.50.0
[23] labeling_0.4.3
[24] Rsamtools_2.26.0
[25] rmarkdown_2.30
[26] graph_1.88.0
[27] UCSC.utils_1.6.0
[28] tinytex_0.57
[29] bit_4.6.0
[30] xfun_0.53
[31] cachem_1.1.0
[32] cigarillo_1.0.0
[33] GenomeInfoDb_1.46.0
[34] jsonlite_2.0.0
[35] blob_1.2.4
[36] highr_0.11
[37] DelayedArray_0.36.0
[38] BiocParallel_1.44.0
[39] parallel_4.5.1
[40] cluster_2.1.8.1
[41] VariantAnnotation_1.56.0
[42] R6_2.6.1
[43] stringi_1.8.7
[44] RColorBrewer_1.1-3
[45] rtracklayer_1.70.0
[46] rpart_4.1.24
[47] SummarizedExperiment_1.40.0
[48] knitr_1.50
[49] base64enc_0.1-3

17

##
##
##
R3CPET user manual
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
## [100] AnnotationFilter_1.34.0

[50] Matrix_1.7-4
[51] nnet_7.3-20
[52] tidyselect_1.2.1
[53] rstudioapi_0.17.1
[54] dichromat_2.0-0.1
[55] abind_1.4-8
[56] yaml_2.3.10
[57] codetools_0.2-20
[58] curl_7.0.0
[59] lattice_0.22-7
[60] tibble_3.3.0
[61] plyr_1.8.9
[62] withr_3.0.2
[63] Biobase_2.70.0
[64] KEGGREST_1.50.0
[65] S7_0.2.0
[66] evaluate_1.0.5
[67] foreign_0.8-90
[68] Biostrings_2.78.0
[69] pillar_1.11.1
[70] BiocManager_1.30.26
[71] MatrixGenerics_1.22.0
[72] checkmate_2.3.3
[73] OrganismDbi_1.52.0
[74] RCurl_1.98-1.17
[75] ensembldb_2.34.0
[76] scales_1.4.0
[77] BiocStyle_2.38.0
[78] ggbio_1.58.0
[79] class_7.3-23
[80] glue_1.8.0
[81] clValid_0.7
[82] pheatmap_1.0.13
[83] Hmisc_5.2-4
[84] lazyeval_0.2.2
[85] tools_4.5.1
[86] BiocIO_1.20.0
[87] data.table_1.17.8
[88] BSgenome_1.78.0
[89] GenomicAlignments_1.46.0
[90] XML_3.99-0.19
[91] grid_4.5.1
[92] AnnotationDbi_1.72.0
[93] colorspace_2.1-2
[94] htmlTable_2.4.3
[95] restfulr_0.0.16
[96] Formula_1.2-5
[97] cli_3.6.5
[98] S4Arrays_1.10.0
[99] dplyr_1.1.4

18

R3CPET user manual

## [101] gtable_0.3.6
## [102] digest_0.6.37
## [103] SparseArray_1.10.0
## [104] rjson_0.2.23
## [105] htmlwidgets_1.6.4
## [106] farver_2.1.2
## [107] memoise_2.0.1
## [108] htmltools_0.5.8.1
## [109] lifecycle_1.0.4
## [110] httr_1.4.7
## [111] bit64_4.6.0-1

19

