Package ‘pwOmics’

April 12, 2018

Type Package

Title Pathway-based data integration of omics data

Version 1.10.1

Date 2014-12-29
Author Astrid Wachter <Astrid.Wachter@med.uni-goettingen.de>
Maintainer Maren Sitte <Maren.Sitte@med.uni-goettingen.de>

Description pwOmics performs pathway-based level-speciﬁc data

comparison of matching omics data sets based on pre-analysed
user-speciﬁed lists of differential genes/transcripts and
phosphoproteins. A separate downstream analysis of phosphoproteomic
data including pathway identiﬁcation, transcription factor
identiﬁcation and target gene identiﬁcation is opposed to
the upstream analysis starting with gene or transcript information
as basis for identiﬁcation of upstream transcription factors
and potential proteomic regulators. The
cross-platform comparative analysis allows for comprehensive
analysis of single time point experiments and time-series
experiments by providing static and dynamic analysis tools for
data integration. In addition, it provides functions to identify
individual signaling axes based on data integration.

License GPL (>= 2)

Depends R (>= 3.2)

Imports data.table, rBiopaxParser, igraph, STRINGdb, graphics, gplots,
Biobase, BiocGenerics, AnnotationDbi, biomaRt, AnnotationHub,
GenomicRanges, graph, grDevices, stats, utils

Suggests ebdbNet, longitudinal, Mfuzz

biocViews SystemsBiology, Transcription, GeneTarget, GeneSignaling

NeedsCompilation no

RoxygenNote 6.0.1

R topics documented:

pwIntOmics-package .
.
addFeedbackLoops .
.
clusterTimeProﬁles .

.
.
.

.
.
.

. .
.
. .

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

3
4
4

1

2

R topics documented:

.

.

.

.

.

.

.
.
.

.
.
.

.
.
.

.
.
.
.

.
.
.
.

.
.
.
.

.
.
.
.

.
.
.
.

.
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
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
.
consDynamicNet
.
7
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
.
createBiopaxnew .
8
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
.
.
createIntIDs .
8
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
ﬁndSignalingAxes .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
9
.
ﬁndxneighborsoverlap .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 10
ﬁndxnextneighbors .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 10
generate_DSSignalingBase .
.
.
genfullConsensusGraph .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 11
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 12
.
genGenelists .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 12
.
.
genGenelistssub .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 13
.
.
.
.
.
genIntIDs .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 13
getAliasfromSTRINGIDs .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 14
.
.
.
getAlias_Ensemble .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 15
.
.
.
getBiopaxModel
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 16
.
.
.
getbipartitegraphInfo .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 16
. .
getConsensusSTRINGIDs
.
.
.
getDS_PWs .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 17
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 18
.
getDS_TFs
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 19
.
getDS_TGs .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 20
.
.
getFCsplines
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 20
.
.
getGenesIntersection .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 21
.
.
getOmicsallGeneIDs
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 22
.
.
getOmicsallProteinIDs
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 23
.
.
.
.
getOmicsDataset
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 23
.
.
getOmicsTimepoints
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 24
.
.
getProteinIntersection .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 25
.
.
.
getSTRING_graph .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 26
.
.
.
.
getTFIntersection .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 27
.
.
.
.
gettpIntersection .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 28
.
.
.
.
getUS_PWs .
.
.
.
.
.
.
getUS_regulators .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 29
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 30
.
.
.
.
.
.
getUS_TFs
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 31
.
get_matching_transcripts .
.
.
.
.
.
identifyPR .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 32
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 33
.
identifyPWs .
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 34
.
.
identifyPWTFTGs
.
.
.
.
identifyRsofTFs .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 35
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 36
.
identifyTFs
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 37
.
.
identPWsofTFs .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 37
.
.
identRegulators .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 38
.
.
identTFs .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 38
.
.
identTFTGsinPWs
.
.
.
.
infoConsensusGraph .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 39
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 40
.
.
loadGenelists .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 40
.
.
.
loadPWs .
.
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 41
.
.
.
OmicsExampleData .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 41
.
.
plotConsDynNet
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 42
.
.
plotConsensusGraph .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 43
.
plotConsensusProﬁles .
.
.
.
plotTimeProﬁleClusters .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 44
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 45
.
.
predictFCvals .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 46
.
.
.
preparePWinfo .

.
.
.
.
.
.
.
.
.

.
.
.
.
.

.
.

.
.

.
.

.
.

.
.

.
.

.
.

.

.

.

.

.

.

.

.

.

.

.

pwIntOmics-package

3

.
.

.
.

.
.

.
.

.
print.OmicsData .
PWidentallprots .
.
PWidentallprotssub .
.
.
PWidenttps
.
readOmics .
.
.
readPhosphodata .
.
.
.
.
readPWdata .
.
.
.
readTFdata
.
.
.
.
readTFtargets .
.
.
selectPWsofTFs .
.
.
staticConsensusNet
.
SteinerTree_cons .
.
temp_correlations .
.
.
TFidentallgenes .
.
.
.
TFidenttps .

.

.

.
.
.
.
.
.
.
.
.
.
.
.
.
.
.

.
.
.
.
.
.
.
.
.
.
.
.
.
.
.

.
.
.
.
.
.
.
.
.
.
.
.
.
.
.

.
.
.
.
.
.
.
.
.
.
.
.
.
.
.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 46
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 47
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 47
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 48
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 48
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 49
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 50
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 51
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 52
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 53
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 53
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 55
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 55
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 57
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 57

Index

58

pwIntOmics-package

Pathway-based data integration of omics data

Description

pwIntOmics performs pathway-based level-speciﬁc data comparison of matching omics data sets
based on pre-analysed user-speciﬁed lists of differential genes/transcripts and proteins. A separate
downstream analysis of proteomic data including pathway identiﬁcation and enrichment analysis,
transcription factor identiﬁcation and target gene identiﬁcation is opposed to the upstream analysis
starting with gene or transcript information as basis for identiﬁcation of upstream transcription fac-
tors and regulators. The cross-platform comparative analysis allows for comprehensive analysis of
single time point experiments and time-series experiments by providing static and dynamic analysis
tools for data integration.

Package:
Type:
Version:
Date:
License: GLP-3

pwIntOmics
Package
1.0
2014-12-29

Details

Author(s)

Astrid Wachter Maintainer: Astrid Wachter <Astrid.Wachter@med.uni-goettingen.de>

4

clusterTimeProﬁles

addFeedbackLoops

Add feedback loops from target genes to proteins/TFs if present.

Description

Add feedback loops from target genes to proteins/TFs if present.

Usage

addFeedbackLoops(ST_net_targets)

Arguments

ST_net_targets full consensus graph.

Value

igraph object with feedback loops added.

clusterTimeProfiles

Clustering of time proﬁles.

Description

Soft clustering of time series data with Mfuzz R package [1]. Filtering of genes with low expres-
sion changes possible via min.std parameter. Expression values are standardized and undergo fuzzy
c-means clustering based on minimization of weighted square error function (see [2]). Fuzziﬁer pa-
rameter m is estimated via mestimate function of [1] based on a relation proposed by Schwaemmle
and Jansen [3]. The optimal number of clusters is determined via the minimum distance between
cluster centroid using Dmin function of [3]. Be aware that the cluster number determination might
be difﬁcult especially for short time series measurements.

Usage

clusterTimeProfiles(dynConsensusNet, min.std = 0, ncenters = 12)

Arguments

dynConsensusNet

min.std

ncenters

result of dynamic analysis: inferred net generated by consDynamicNet function.

threshold parameter to exclude genes with a low standard deviation. All genes
with an expression smaller than min.std will be excluded from clustering. De-
fault value is 0.

integer specifying the maximum number of centers which should be tested in
minimum distance between cluster centroid test; this number is used as initial
number to determine the data-speciﬁc maximal cluster number based on number
of distinct data points.

consDynamicNet

Value

output dataframe of mfuzz function.

References

5

1. L. Kumar and M. Futschik, Mfuzz: a software package for soft clustering of microarray data,
Bioinformation, 2(1) 5-7, 2007.

2. Bezdak JC, Pattern Recognition with Fuzzy Objective Function Algorithms, Plenum Press, New
York, 1981.

3. Schwaemmle and Jensen, Bioinformatics, Vol. 26 (22), 2841-2848, 2010.

Examples

## Not run:
data(OmicsExampleData)
data_omics = readOmics(tp_prots = c(0.25, 1, 4, 8, 13, 18, 24),
tp_genes = c(1, 4, 8, 13, 18, 24), OmicsExampleData,
PWdatabase = c("biocarta", "kegg", "nci", "reactome"),
TFtargetdatabase = c("userspec"))
data_omics = readPhosphodata(data_omics,
phosphoreg = system.file("extdata", "phospho_reg_table.txt",
package = "pwOmics.newupdown"))
data_omics = readTFdata(data_omics,
TF_target_path = system.file("extdata", "TF_targets.txt",
package = "pwOmics.newupdown"))
data_omics_plus = readPWdata(data_omics,
loadgenelists = system.file("extdata/Genelists", package = "pwOmics.newupdown"))

## End(Not run)
## Not run:
data_omics_plus = identifyPR(data_omics_plus)
setwd(system.file("extdata/Genelists", package = "pwOmics.newupdown"))
data_omics = identifyPWs(data_omics_plus)
data_omics = identifyTFs(data_omics)
data_omics = identifyRsofTFs(data_omics,
noTFs_inPW = 1, order_neighbors = 10)
data_omics = identifyPWTFTGs(data_omics)
statConsNet = staticConsensusNet(data_omics)
consDynNet = consDynamicNet(data_omics, statConsNet)
clusterTimeProfiles(consDynNet)

## End(Not run)

consDynamicNet

Dynamic analysis.

Description

Generates continous data for dynamic analysis of protein, TF and gene data via smoothing splines.
50 time points are generated this way. The following nodes are considered: Nodes which are part
of the static consensus graphs from corresponding time points of the two different measurement
types. In case a node is not signiﬁcantly changed at a certain point in time its FC is assumed to

6

consDynamicNet

remain constant at this time point. Calculation of the consensus-based dynamic net parameters
are based on the ebdbNet R package [1]. The number of time points generated via smoothing
splines (50) is based on their results for median AUCs of ROC curves. The number of forward
time units a node is assumed to inﬂuence other nodes can be speciﬁed via the laghankel parameter.
The cutoff determining the percent of total variance explained by the singular values generated by
singular value decomposition (SVD) of the block-Hankel matrix H in order to specify the hidden
state dimension K (for further details see [1]).

Usage

consDynamicNet(data_omics, consensusGraphs, laghankel = 3,

cutoffhankel = 0.9, conv.1 = 0.15, conv.2 = 0.05, conv.3 = 0.05,
verbose = TRUE, max.iter = 100, max.subiter = 200)

Arguments

data_omics
consensusGraphs

OmicsData object.

laghankel

cutoffhankel

conv.1

conv.2

conv.3

verbose

max.iter

max.subiter

result from static analysis: consensus graph generated by staticConsensusNet
function.

integer specifying the maximum relevant time lag to be used in constructing the
block-Hankel matrix.

cutoff to determine desired percent of total variance explained; default = 0.9 as
in [1].

value of convergence criterion 1; default value is 0.15 (for further details see
[1]).

value of convergence criterion 2; default value is 0.05 (for further details see
[1]).

value of convergence criterion 3; default value is 0.05 (for further details see
[1]).

boolean value, verbose output TRUE or FALSE

maximum overall iterations; default value is 100 (for further details see [1]).

maximum iterations for hyperparameter updates; default value is 200 (for further
details see [1]).

Value

list of 2 elements: 1) output parameters of dynamic network inference with ebdbNet package 2)
splines data generated.

References

1. A. Rau, F. Jaffrezic, J.-L. Foulley, R. W. Doerge (2010). An empirical Bayesian method for
estimating biological networks from temporal microarray data. Statistical Applications in Genetics
and Molecular Biology, vol. 9, iss. 1, article 9.

Examples

## Not run:
data(OmicsExampleData)
data_omics = readOmics(tp_prots = c(0.25, 1, 4, 8, 13, 18, 24),

createBiopaxnew

7

tp_genes = c(1, 4, 8, 13, 18, 24), OmicsExampleData,
PWdatabase = c("biocarta", "kegg", "nci", "reactome"),
TFtargetdatabase = c("userspec"))
data_omics = readPhosphodata(data_omics,
phosphoreg = system.file("extdata", "phospho_reg_table.txt",
package = "pwOmics.newupdown"))
data_omics = readTFdata(data_omics,
TF_target_path = system.file("extdata", "TF_targets.txt",
package = "pwOmics.newupdown"))
data_omics_plus = readPWdata(data_omics,
loadgenelists = system.file("extdata/Genelists", package = "pwOmics.newupdown"))

## End(Not run)
## Not run:
data_omics_plus = identifyPR(data_omics_plus)
setwd(system.file("extdata/Genelists", package = "pwOmics.newupdown"))
data_omics = identifyPWs(data_omics_plus)
data_omics = identifyTFs(data_omics)
data_omics = identifyRsofTFs(data_omics,
noTFs_inPW = 1, order_neighbors = 10)
data_omics = identifyPWTFTGs(data_omics)
statConsNet = staticConsensusNet(data_omics)
dynConsNet = consDynamicNet(data_omics, statConsNet)

## End(Not run)

createBiopaxnew

Create a new Biopax model containing all database information.

Description

This function creates a new biopax model depending on which pathway databases are chosen for
analysis.

Usage

createBiopaxnew(intIDs, pwdatabases)

Arguments

intIDs

pwdatabases

Value

output list of genintIDs function.

vector indicating with which pathway database the pathways should be deter-
mined; possible choices are "biocarta", "kegg", "nci", "reactome".

biopax object generated from the speciﬁed pathway databases.

8

ﬁndSignalingAxes

createIntIDs

Create internal IDs.

Description

Create new internal ids in biopax$df:

Usage

createIntIDs(data_omics, PWinfo)

Arguments

data_omics

PWinfo

Value

OmicsData object.

pathway database information from chosen pathway databases as from load-
PWs.

list of internal IDs from speciﬁed pathway databases.

findSignalingAxes

Find downstream signaling axis.

Description

This function determines the regulated downstream structures of a selected phosphoprotein at a
speciﬁed time point.

Usage

findSignalingAxes(data_omics, phosphoprot, tpDS)

Arguments

data_omics

phosphoprot

tpDS

Value

OmicsData object.

character specifying the name of the phosphoprotein that is selected as the start-
ing point for downstream analysis.

integer specifying the time point considered for downstream analysis of phos-
phoprotein data .

list of downstream pathways identiﬁed for this time point of phosphoprotein measurement with
sublists containing information about the transcription factor, the regulation, the target genes of
these transcription factors and the matching transcripts.

ﬁndxneighborsoverlap

Examples

9

## Not run:
data(OmicsExampleData)
data_omics = readOmics(tp_prots = c(0.25, 1, 4, 8, 13, 18, 24),
tp_genes = c(1, 4, 8, 13, 18, 24), OmicsExampleData,
PWdatabase = c("biocarta", "kegg", "nci", "reactome"),
TFtargetdatabase = c("userspec"))
data_omics = readPhosphodata(data_omics,
phosphoreg = system.file("extdata", "phospho_reg_table.txt",
package = "pwOmics.newupdown"))
data_omics = readTFdata(data_omics,
TF_target_path = system.file("extdata", "TF_targets.txt",
package = "pwOmics.newupdown"))
data_omics_plus = readPWdata(data_omics,
loadgenelists = system.file("extdata/Genelists", package = "pwOmics.newupdown"))
setwd(system.file("extdata/Genelists", package = "pwOmics.newupdown"))

## End(Not run)
## Not run:
data_omics_plus = identifyPR(data_omics_plus)
data_omics = identifyPWs(data_omics_plus)
data_omics = identifyTFs(data_omics)
data_omics = identifyPWTFTGs(data_omics)
data_omics = identifyRsofTFs(data_omics, noTFs_inPW = 1, order_neighbors = 10)
SYK_axis = findSignalingAxes(data_omics,phosphoprot = "SYK", tpDS = 2)

## End(Not run)

findxneighborsoverlap Find overlap of next neighbors of transcription factors in identiﬁed

pathways.

Description

Find the overlap of x next neighbors of transcription factors in identiﬁed pathways. Writes the
overlap into a given list called ’regulators’.

Usage

findxneighborsoverlap(neighbors, noTFs_inPW, regul)

Arguments

neighbors

noTFs_inPW

regul

Value

list of x next neighbors for each transcription factor in the pathway as provided
by ﬁndxnextneighbors function.

numeric value specifying number of TFs being at least part of the pathway.

list element of regulators list for current pathway.

list of regulators identiﬁed in x next neighbors of TFs.

10

generate_DSSignalingBase

findxnextneighbors

Find next neighbors of transcription factors in identiﬁed pathways.
Produces a list of x next neighbors for each transcription factor in the
pathway.

Description

Find next neighbors of transcription factors in identiﬁed pathways.

Produces a list of x next neighbors for each transcription factor in the pathway.

Usage

findxnextneighbors(data_omics, pws_morex_TFs, pwxTFs, order_neighbors)

Arguments

data_omics

pws_morex_TFs

pwxTFs
order_neighbors

OmicsData object.

list of transcription factors in identiﬁed pathways.

numeric variable of pathway currently investigated (from pws_morexTFs).

integer speciﬁying the order of the neighborhood: order 1 is TF plus its imme-
diate neighbors.

Value

list of x next neighbors for each TF in the pathway.

generate_DSSignalingBase

Generate a folder with downstream information about all phosphopro-
teins.

Description

This function generates a folder structure with an RData object and csv tables for each timepoint
sepciﬁed for each phosphoprotein considered in the data_omics object.

Usage

generate_DSSignalingBase(data_omics, timepoints = c(0.25, 1, 4, 8, 13, 18,

24))

Arguments

data_omics

timepoints

OmicsData object.

integer vector specifying the timepoints of interest for downstream analysis.

genfullConsensusGraph

Value

11

Folder structure in working directory, containing phosphoprotein downstream information in indi-
vidual folders.

Examples

## Not run:
data(OmicsExampleData)
data_omics = readOmics(tp_prots = c(0.25, 1, 4, 8, 13, 18, 24),
tp_genes = c(1, 4, 8, 13, 18, 24), OmicsExampleData,
PWdatabase = c("biocarta", "kegg", "nci", "reactome"),
TFtargetdatabase = c("userspec"))
data_omics = readPhosphodata(data_omics,
phosphoreg = system.file("extdata", "phospho_reg_table.txt",
package = "pwOmics.newupdown"))
data_omics = readTFdata(data_omics,
TF_target_path = system.file("extdata", "TF_targets.txt",
package = "pwOmics.newupdown"))
data_omics_plus = readPWdata(data_omics,
loadgenelists = system.file("extdata/Genelists", package = "pwOmics.newupdown"))

## End(Not run)
## Not run:
data_omics_plus = identifyPR(data_omics_plus)
setwd(system.file("extdata/Genelists", package = "pwOmics.newupdown"))
data_omics = identifyPWs(data_omics_plus)
data_omics = identifyTFs(data_omics)
data_omics = identifyPWTFTGs(data_omics)
data_omics = identifyRsofTFs(data_omics, noTFs_inPW = 1, order_neighbors = 10)
setwd("~/Signaling_axes/")
generate_DSSignalingBase(data_omics, timepoints = c(0.25, 1, 4, 8, 13, 18, 24))

## End(Not run)

genfullConsensusGraph Combine SteinerNet with bipartite graph to get full consensus net-

work.

Description

Combine SteinerNet with bipartite graph to get full consensus network.

Usage

genfullConsensusGraph(ST_net, ST_TFTG)

Arguments

ST_net

ST_TFTG

steiner tree graph generated by SteinerTree_cons function.

steiner tree graph extended with consensus target genes and the edges between
TFs and target genes.

12

Value

genGenelistssub

igraph object of network comprising steiner tree graph and TF - target gene interactions.

genGenelists

Generate genelists from pathway databases.

Description

This function generates genelists from the chosen pathway databases for further processing in det-
Pathways function.

Usage

genGenelists(intIDs, pwdatabases)

Arguments

intIDs

pwdatabases

Value

list containing Biopax model with newly generated internal IDs as processed
with genintIDs function. The components of the list are biopax models for "bio-
carta", "kegg", "nci", "reactome". In case a database was not chosen the list
entry contains a NA.

vector indicating with which pathway database the pathways should be deter-
mined; possible choices are "biocarta", "kegg", "nci", "reactome".

list of genelists of speciﬁed pathway databases.

genGenelistssub

Generate internally genelists from pathway databases.

Description

This function generates genelists for a particular pathway database for further processing in det-
Pathways function.

Usage

genGenelistssub(intIDs, database_int, PWDB_name)

Arguments

intIDs

database_int

list containing Biopax model with newly generated internal IDs as processed
with genintIDs function. The components of the list are biopax models for "bio-
carta", "kegg", "nci", "reactome". In case a database was not chosen the list
entry contains a NA.

integer indicating database entry in indIDs (output of genintIDs); biocarta = 1,
kegg = 2, nci = 4, reactome = 4.

PWDB_name

character; pathway database name.

genIntIDs

Value

data.table of genelist of particular pathway database.

13

genIntIDs

Internal function for generation of pathway database speciﬁc internal
IDs.

Description

Generates new internal ids (database-speciﬁc) in biopax$df.

Usage

genIntIDs(data_omics, PWinfo, PWinfo_ind, PWDBname)

Arguments

data_omics

OmicsData object.

PWinfo

PWinfo_ind

pathway database information from chosen pathway databases as from load-
PWs.

integer specifying element of loadPWs output matching the chosen pathway
database.

PWDBname

character; pathway database name.

Value

data.table with newly generated internal IDs of biopax model.

getAliasfromSTRINGIDs Map alias names to STRING IDs of consensus graph.

Description

Map alias names to STRING IDs of consensus graph.

Usage

getAliasfromSTRINGIDs(data_omics, ST_net, updown = FALSE, phospho = TRUE,

consSTRINGIDs, tps, string_db)

14

Arguments

getAlias_Ensemble

data_omics

OmicsData object.

ST_net

updown

phospho

consSTRINGIDs

tps

string_db

steiner tree graph generated by SteinerTree_cons function.

boolean value; TRUE in case up- and downregulation should be checked indi-
vidually for intersection. Type of checking is deﬁned with parameter ’phospho’.

boolean value; TRUE in case up- and downregulation should be checked based
on provided downstream phosphoprotein inﬂuence from identifyPR function;
FALSE in case up- and downregulation should be checked for without phospho-
protein database knowledge. Default is TRUE.

ﬁrst element of list generated by getConsensusSTRINGIDs function; a data.frame
including the proteins to be considered as terminal nodes in Steiner tree with col-
names ST_proteins and the corresponding STRING IDs in column ’STRING_id’.

integer specifying current timepoint under consideration.

second element of list generated by getConsensusSTRINGIDs function; species
table (for human) of STRING database.

Value

igraph object with alias name annotation.

getAlias_Ensemble

Get Gene Symbols from Ensemble Gene Accession IDs.

Description

Get Gene Symbols from Ensemble Gene Accession IDs.

Usage

getAlias_Ensemble(ids)

Arguments

ids

Value

vector of Ensemble Gene Accession IDs.

ids character vector of gene symbols.

getBiopaxModel

15

getBiopaxModel

Get upstream regulators of identiﬁed transcription factors.

Description

Get upstream regulators of identiﬁed transcription factors.

Usage

getBiopaxModel(data_omics)

Arguments

data_omics

OmicsData object.

Value

biopax model generated as consensus biopax models from all pathway databases selected for anal-
ysis.

Examples

## Not run:
data(OmicsExampleData)
data_omics = readOmics(tp_prots = c(0.25, 1, 4, 8, 13, 18, 24),
tp_genes = c(1, 4, 8, 13, 18, 24), OmicsExampleData,
PWdatabase = c("biocarta", "kegg", "nci", "reactome"),
TFtargetdatabase = c("userspec"))
data_omics = readPhosphodata(data_omics,
phosphoreg = system.file("extdata", "phospho_reg_table.txt",
package = "pwOmics.newupdown"))
data_omics = readTFdata(data_omics,
TF_target_path = system.file("extdata", "TF_targets.txt",
package = "pwOmics.newupdown"))
data_omics_plus = readPWdata(data_omics,
loadgenelists = system.file("extdata/Genelists", package = "pwOmics.newupdown"))

## End(Not run)
## Not run:
data_omics_plus = identifyPR(data_omics_plus)
setwd(system.file("extdata/Genelists", package = "pwOmics.newupdown"))
data_omics = identifyPWs(data_omics_plus)
getBiopaxModel(data_omics)

## End(Not run)

16

getConsensusSTRINGIDs

getbipartitegraphInfo Get TF-target gene information for the consensus graph.

Description

Get TF-target gene information for the consensus graph.

Usage

getbipartitegraphInfo(data_omics, tps, updown = FALSE, phospho = TRUE)

Arguments

data_omics

OmicsData object.

tps

updown

phospho

integer specifying current timepoint under consideration.

boolean value; TRUE in case up- and downregulation should be checked indi-
vidually for intersection. Type of checking is deﬁned with parameter ’phospho’.

boolean value; TRUE in case up- and downregulation should be checked based
on provided downstream phosphoprotein inﬂuence from identifyPR function;
FALSE in case up- and downregulation should be checked for without phospho-
protein database knowledge. Default is TRUE.

Value

list of transcription factor target gene interactions.

getConsensusSTRINGIDs Get consensus graph in STRING IDs.

Description

Get consensus graph in STRING IDs.

Usage

getConsensusSTRINGIDs(data_omics, tps, string_db, updown = FALSE,

phospho = TRUE)

Arguments

data_omics

tps

string_db

updown

phospho

OmicsData object.

integer specifying current timepoint under consideration.

STRING_db object.

boolean value; TRUE in case up- and downregulation should be checked indi-
vidually for intersection. Type of checking is deﬁned with parameter ’phospho’.

boolean value; TRUE in case up- and downregulation should be checked based
on provided downstream phosphoprotein inﬂuence from identifyPR function;
FALSE in case up- and downregulation should be checked for without phospho-
protein database knowledge. Default is TRUE.

getDS_PWs

Value

17

igraph object consensus graph with STRING IDs (only including proteins and transcription factors).

getDS_PWs

Get downstream analysis pathways.

Description

This function returns pathways identiﬁed in the downstream analysis containing the signiﬁcantly
abundant proteins.

Usage

getDS_PWs(data_omics)

Arguments

data_omics

OmicsData object.

Value

list of length = number of protein time points, each element containing a data frame with the path-
way IDs in the generated biopax model and corresponding pathway names.

Examples

## Not run:
data(OmicsExampleData)
data_omics = readOmics(tp_prots = c(0.25, 1, 4, 8, 13, 18, 24),
tp_genes = c(1, 4, 8, 13, 18, 24), OmicsExampleData,
PWdatabase = c("biocarta", "kegg", "nci", "reactome"),
TFtargetdatabase = c("userspec"))
data_omics = readPhosphodata(data_omics,
phosphoreg = system.file("extdata", "phospho_reg_table.txt",
package = "pwOmics.newupdown"))
data_omics = readTFdata(data_omics,
TF_target_path = system.file("extdata", "TF_targets.txt",
package = "pwOmics.newupdown"))
data_omics_plus = readPWdata(data_omics,
loadgenelists = system.file("extdata/Genelists", package = "pwOmics.newupdown"))

## End(Not run)
## Not run:
data_omics_plus = identifyPR(data_omics_plus)
setwd(system.file("extdata/Genelists", package = "pwOmics.newupdown"))
data_omics = identifyPWs(data_omics_plus)
data_omics = identifyTFs(data_omics)
data_omics = identifyPWTFTGs(data_omics)
getDS_PWs(data_omics)

## End(Not run)

18

getDS_TFs

getDS_TFs

Get downstream analysis transcription factors in pathways.

Description

This function returns the genes identiﬁed in the downstream analysis and a column indicating if the
genes are transcription factors.

Usage

getDS_TFs(data_omics)

Arguments

data_omics

OmicsData object.

Value

list of length = number of protein time points, each element containing a character vector with
identiﬁed transcription factors.

Examples

## Not run:
data(OmicsExampleData)
data_omics = readOmics(tp_prots = c(0.25, 1, 4, 8, 13, 18, 24),
tp_genes = c(1, 4, 8, 13, 18, 24), OmicsExampleData,
PWdatabase = c("biocarta", "kegg", "nci", "reactome"),
TFtargetdatabase = c("userspec"))
data_omics = readPhosphodata(data_omics,
phosphoreg = system.file("extdata", "phospho_reg_table.txt",
package = "pwOmics.newupdown"))
data_omics = readTFdata(data_omics,
TF_target_path = system.file("extdata", "TF_targets.txt",
package = "pwOmics.newupdown"))
data_omics_plus = readPWdata(data_omics,
loadgenelists = system.file("extdata/Genelists", package = "pwOmics.newupdown"))

## End(Not run)
## Not run:
data_omics_plus = identifyPR(data_omics_plus)
setwd(system.file("extdata/Genelists", package = "pwOmics.newupdown"))
data_omics = identifyPWs(data_omics_plus)
data_omics = identifyTFs(data_omics)
data_omics = identifyPWTFTGs(data_omics)
getDS_TFs(data_omics)

## End(Not run)

getDS_TGs

19

getDS_TGs

Get downstream analysis target genes of TFs found in pathways.

Description

Get downstream analysis target genes of TFs found in pathways.

Usage

getDS_TGs(data_omics)

Arguments

data_omics

OmicsData object.

Value

list of length = number of protein time points, each element containing a character vector with
identiﬁed target genes.

Examples

## Not run:
data(OmicsExampleData)
data_omics = readOmics(tp_prots = c(0.25, 1, 4, 8, 13, 18, 24),
tp_genes = c(1, 4, 8, 13, 18, 24), OmicsExampleData,
PWdatabase = c("biocarta", "kegg", "nci", "reactome"),
TFtargetdatabase = c("userspec"))
data_omics = readPhosphodata(data_omics,
phosphoreg = system.file("extdata", "phospho_reg_table.txt",
package = "pwOmics.newupdown"))
data_omics = readTFdata(data_omics,
TF_target_path = system.file("extdata", "TF_targets.txt",
package = "pwOmics.newupdown"))
data_omics_plus = readPWdata(data_omics,
loadgenelists = system.file("extdata/Genelists", package = "pwOmics.newupdown"))

## End(Not run)
## Not run:
data_omics_plus = identifyPR(data_omics_plus)
setwd(system.file("extdata/Genelists", package = "pwOmics.newupdown"))
data_omics = identifyPWs(data_omics_plus)
data_omics = identifyTFs(data_omics)
data_omics = identifyPWTFTGs(data_omics)
getDS_TGs(data_omics)

## End(Not run)

20

getGenesIntersection

getFCsplines

Get fold change splines.

Description

Calculate the splines used for the dynamic analysis.

Usage

getFCsplines(data_omics, nodes, nodetype)

Arguments

data_omics

OmicsData object.

nodes

nodetype

Value

character vector of nodes the fold change splines should be calculated for.

character indicating to calculate splines for "proteins" or "genes".

splines values used in dynamic analysis.

getGenesIntersection Get genes intersection for the omics data on the different time points.

Description

Get genes intersection for the omics data on the different time points.

Usage

getGenesIntersection(data_omics, tp_prot, tp_genes, updown = FALSE,

phospho = TRUE)

Arguments

data_omics

OmicsData object.

tp_prot

tp_genes

updown

phospho

numeric integer deﬁning protein timepoint measurement chosen for comparison.

numeric integer deﬁning gene/transcript timepoint measurement chosen for com-
parison.

boolean value; TRUE in case up- and downregulation should be checked indi-
vidually for intersection. Type of checking is deﬁned with parameter ’phospho’.

boolean value; TRUE in case up- and downregulation should be checked based
on provided downstream phosphoprotein inﬂuence from identifyPR function;
FALSE in case up- and downregulation should be checked for without phospho-
protein database knowledge. Default is TRUE.

getOmicsallGeneIDs

Value

21

list with three elements: 1) character vector of gene IDs identiﬁed in both upstream and downstream
analysis 2) protein time point 3) gene/transcript time point.

Examples

## Not run:
data(OmicsExampleData)
data_omics = readOmics(tp_prots = c(0.25, 1, 4, 8, 13, 18, 24),
tp_genes = c(1, 4, 8, 13, 18, 24), OmicsExampleData,
PWdatabase = c("biocarta", "kegg", "nci", "reactome"),
TFtargetdatabase = c("userspec"))
data_omics = readPhosphodata(data_omics,
phosphoreg = system.file("extdata", "phospho_reg_table.txt",
package = "pwOmics.newupdown"))
data_omics = readTFdata(data_omics,
TF_target_path = system.file("extdata", "TF_targets.txt",
package = "pwOmics.newupdown"))
data_omics_plus = readPWdata(data_omics,
loadgenelists = system.file("extdata/Genelists", package = "pwOmics.newupdown"))

## End(Not run)
## Not run:
data_omics_plus = identifyPR(data_omics_plus)
setwd(system.file("extdata/Genelists", package = "pwOmics.newupdown"))
data_omics = identifyPWs(data_omics_plus)
data_omics = identifyTFs(data_omics)
data_omics = identifyPWTFTGs(data_omics)
data_omics = identifyRsofTFs(data_omics, noTFs_inPW = 1, order_neighbors = 10)
getGenesIntersection(data_omics, tp_prot = 4, tp_genes = 4, updown = FALSE,
phospho = TRUE)

## End(Not run)

getOmicsallGeneIDs

Get all gene IDs.

Description

This function returns the gene IDs of all genes (transcripts) measured.

Usage

getOmicsallGeneIDs(data_omics)

Arguments

data_omics

OmicsData object.

Value

all gene IDs.

22

Examples

getOmicsallProteinIDs

## Not run:
data(OmicsExampleData)
data_omics = readOmics(tp_prots = c(0.25, 1, 4, 8, 13, 18, 24),
tp_genes = c(1, 4, 8, 13, 18, 24), OmicsExampleData,
PWdatabase = c("biocarta", "kegg", "nci", "reactome"),
TFtargetdatabase = c("userspec"))
getOmicsallGeneIDs(data_omics)

## End(Not run)

getOmicsallProteinIDs Get all protein IDs.

Description

This function returns the protein IDs of all proteins measured.

Usage

getOmicsallProteinIDs(data_omics)

Arguments

data_omics

OmicsData object.

Value

all protein IDs.

Examples

## Not run:
data(OmicsExampleData)
data_omics = readOmics(tp_prots = c(0.25, 1, 4, 8, 13, 18, 24),
tp_genes = c(1, 4, 8, 13, 18, 24), OmicsExampleData,
PWdatabase = c("biocarta", "kegg", "nci", "reactome"),
TFtargetdatabase = c("userspec"))
getOmicsallProteinIDs(data_omics)

## End(Not run)

getOmicsDataset

23

getOmicsDataset

Get Omics dataset.

Description

This function returns the omics datasets of the experiment.

Usage

getOmicsDataset(data_omics, writeData = FALSE)

Arguments

data_omics

writeData

Value

OmicsData object.

boolean value indicating if datasets should be written into csv ﬁle.

list with protein data set as ﬁrst element and gene data set as second element; both elements contain
matrices with signiﬁcant proteins/ genes/transcripts at the given time points.

Examples

## Not run:
data(OmicsExampleData)
data_omics = readOmics(tp_prots = c(0.25, 1, 4, 8, 13, 18, 24),
tp_genes = c(1, 4, 8, 13, 18, 24), OmicsExampleData,
PWdatabase = c("biocarta", "kegg", "nci", "reactome"),
TFtargetdatabase = c("userspec"))
getOmicsDataset(data_omics)

## End(Not run)

getOmicsTimepoints

Get Omics timepoints.

Description

This function returns the timepoints of the OmicsData.

Usage

getOmicsTimepoints(data_omics)

Arguments

data_omics

OmicsData object.

Value

list of protein time points and gene time points; in case of single time point measurement experiment
number entered in OmicsData object.

24

Examples

getProteinIntersection

## Not run:
data(OmicsExampleData)
data_omics = readOmics(tp_prots = c(0.25, 1, 4, 8, 13, 18, 24),
tp_genes = c(1, 4, 8, 13, 18, 24), OmicsExampleData,
PWdatabase = c("biocarta", "kegg", "nci", "reactome"),
TFtargetdatabase = c("userspec"))
getOmicsTimepoints(data_omics)

## End(Not run)

getProteinIntersection

Get protein intersection for the omics data on the different time points.
The timepoints or measurement names for comparison have to be de-
ﬁned in tp_prot and tp_genes as given in the readOmics function.

Description

Get protein intersection for the omics data on the different time points.

The timepoints or measurement names for comparison have to be deﬁned in tp_prot and tp_genes
as given in the readOmics function.

Usage

getProteinIntersection(data_omics, tp_prot, tp_genes, updown = FALSE,

phospho = TRUE)

Arguments

data_omics

OmicsData object.

tp_prot

tp_genes

updown

phospho

Value

numeric integer deﬁning protein timepoint measurement chosen for comparison.

numeric integer deﬁning gene/transcript timepoint measurement chosen for com-
parison.

boolean value; TRUE in case up- and downregulation should be checked indi-
vidually for intersection. Type of checking is deﬁned with parameter ’phospho’.

boolean value; TRUE in case up- and downregulation should be checked based
on provided downstream phosphoprotein inﬂuence from identifyPR function;
FALSE in case up- and downregulation should be checked for without phospho-
protein database knowledge. Default is TRUE.

list with three elements: 1) character vector of protein IDs identiﬁed in both upstream and down-
stream analysis 2) protein time point 3) gene/transcript time point.

getSTRING_graph

Examples

25

## Not run:
data(OmicsExampleData)
data_omics = readOmics(tp_prots = c(0.25, 1, 4, 8, 13, 18, 24),
tp_genes = c(1, 4, 8, 13, 18, 24), OmicsExampleData,
PWdatabase = c("biocarta", "kegg", "nci", "reactome"),
TFtargetdatabase = c("userspec"))
data_omics = readPhosphodata(data_omics,
phosphoreg = system.file("extdata", "phospho_reg_table.txt",
package = "pwOmics.newupdown"))
data_omics = readTFdata(data_omics,
TF_target_path = system.file("extdata", "TF_targets.txt",
package = "pwOmics.newupdown"))
data_omics_plus = readPWdata(data_omics,
loadgenelists = system.file("extdata/Genelists", package = "pwOmics.newupdown"))

## End(Not run)
## Not run:
data_omics_plus = identifyPR(data_omics_plus)
setwd(system.file("extdata/Genelists", package = "pwOmics.newupdown"))
data_omics = identifyPWs(data_omics_plus)
data_omics = identifyTFs(data_omics)
data_omics = identifyPWTFTGs(data_omics)
data_omics = identifyRsofTFs(data_omics, noTFs_inPW = 1, order_neighbors = 10)
getProteinIntersection(data_omics, tp_prot = 4, tp_genes = 4,
updown = FALSE, phospho = TRUE)

## End(Not run)

getSTRING_graph

Generate STRING PPI graph.

Description

Generates connected graph with undirected edges from STRING PPI-database.

Usage

getSTRING_graph(string_db)

Arguments

string_db

Value

STRING_db object generated by getConsensusSTRINGIDs function.

igraph object connected graph from STRING PPI database.

26

getTFIntersection

getTFIntersection

Get TF intersection for the omics data on the different time points.

Description

Get TF intersection for the omics data on the different time points.

Usage

getTFIntersection(data_omics, tp_prot, tp_genes, updown = FALSE,

phospho = TRUE)

Arguments

data_omics

tp_prot

tp_genes

updown

phospho

Value

OmicsData object.

numeric integer deﬁning protein timepoint measurement chosen for comparison.

numeric integer deﬁning gene/transcript timepoint measurement chosen for com-
parison.

boolean value; TRUE in case up- and downregulation should be checked indi-
vidually for intersection. Type of checking is deﬁned with parameter ’phospho’.

boolean value; TRUE in case up- and downregulation should be checked based
on provided downstream phosphoprotein inﬂuence from identifyPR function;
FALSE in case up- and downregulation should be checked for without phospho-
protein database knowledge. Default is TRUE.

list with three elements: 1) character vector of transcription factor IDs identiﬁed in both upstream
and downstream analysis 2) protein time point 3) gene/transcript time point.

Examples

## Not run:
data(OmicsExampleData)
data_omics = readOmics(tp_prots = c(0.25, 1, 4, 8, 13, 18, 24),
tp_genes = c(1, 4, 8, 13, 18, 24), OmicsExampleData,
PWdatabase = c("biocarta", "kegg", "nci", "reactome"),
TFtargetdatabase = c("userspec"))
data_omics = readPhosphodata(data_omics,
phosphoreg = system.file("extdata", "phospho_reg_table.txt",
package = "pwOmics.newupdown"))
data_omics = readTFdata(data_omics,
TF_target_path = system.file("extdata", "TF_targets.txt",
package = "pwOmics.newupdown"))
data_omics_plus = readPWdata(data_omics,
loadgenelists = system.file("extdata/Genelists", package = "pwOmics.newupdown"))

## End(Not run)
## Not run:
data_omics_plus = identifyPR(data_omics_plus)
setwd(system.file("extdata/Genelists", package = "pwOmics.newupdown"))
data_omics = identifyPWs(data_omics_plus)

gettpIntersection

27

data_omics = identifyTFs(data_omics)
data_omics = identifyPWTFTGs(data_omics)
data_omics = identifyRsofTFs(data_omics, noTFs_inPW = 1, order_neighbors = 10)
getTFIntersection(data_omics, tp_prot = 4, tp_genes = 4, updown = FALSE,
phospho = TRUE)

## End(Not run)

gettpIntersection

Get omics data intersection on the three levels. Get intersection for the
omics data on all three levels (proteins, TFs, genes) on corresponding
time points.

Description

Get omics data intersection on the three levels.

Get intersection for the omics data on all three levels (proteins, TFs, genes) on corresponding time
points.

Usage

gettpIntersection(data_omics, updown = FALSE, phospho = TRUE)

Arguments

data_omics

updown

phospho

Value

OmicsData object.

boolean value; TRUE in case up- and downregulation should be checked indi-
vidually for intersection. Type of checking is deﬁned with parameter ’phospho’.

boolean value; TRUE in case up- and downregulation should be checked based
on provided downstream phosphoprotein inﬂuence from identifyPR function;
FALSE in case up- and downregulation should be checked for without phospho-
protein database knowledge. Default is TRUE.

list with three elements: 1) protein intersection 2) transcription factor intersection 3) gene intersec-
tion each element contains a list with overlapping time points of both upstream and downstream
analyses.

Examples

## Not run:
data(OmicsExampleData)
data_omics = readOmics(tp_prots = c(0.25, 1, 4, 8, 13, 18, 24),
tp_genes = c(1, 4, 8, 13, 18, 24), OmicsExampleData,
PWdatabase = c("biocarta", "kegg", "nci", "reactome"),
TFtargetdatabase = c("userspec"))
data_omics = readPhosphodata(data_omics,
phosphoreg = system.file("extdata", "phospho_reg_table.txt",
package = "pwOmics.newupdown"))
data_omics = readTFdata(data_omics,
TF_target_path = system.file("extdata", "TF_targets.txt",

28

getUS_PWs

package = "pwOmics.newupdown"))
data_omics_plus = readPWdata(data_omics,
loadgenelists = system.file("extdata/Genelists", package = "pwOmics.newupdown"))

## End(Not run)
## Not run:
data_omics_plus = identifyPR(data_omics_plus)
setwd(system.file("extdata/Genelists", package = "pwOmics.newupdown"))
data_omics = identifyPWs(data_omics_plus)
data_omics = identifyTFs(data_omics)
data_omics = identifyPWTFTGs(data_omics)
data_omics = identifyRsofTFs(data_omics, noTFs_inPW = 1, order_neighbors = 10)
gettpIntersection(data_omics, updown = FALSE, phospho = TRUE)

## End(Not run)

getUS_PWs

Get upstream pathways of identiﬁed transcription factors.

Description

Get upstream pathways of identiﬁed transcription factors.

Usage

getUS_PWs(data_omics)

Arguments

data_omics

OmicsData object.

Value

list of length = number of gene/transcript time points, each element containing a list of transcrip-
tion factors; these transcription factor elements contain data frame with pathway IDs and pathway
names.

Examples

## Not run:
data(OmicsExampleData)
data_omics = readOmics(tp_prots = c(0.25, 1, 4, 8, 13, 18, 24),
tp_genes = c(1, 4, 8, 13, 18, 24), OmicsExampleData,
PWdatabase = c("biocarta", "kegg", "nci", "reactome"),
TFtargetdatabase = c("userspec"))
data_omics = readPhosphodata(data_omics,
phosphoreg = system.file("extdata", "phospho_reg_table.txt",
package = "pwOmics.newupdown"))
data_omics = readTFdata(data_omics,
TF_target_path = system.file("extdata", "TF_targets.txt",
package = "pwOmics.newupdown"))
data_omics_plus = readPWdata(data_omics,
loadgenelists = system.file("extdata/Genelists", package = "pwOmics.newupdown"))
data_omics_plus = identifyPR(data_omics_plus)

getUS_regulators

29

## End(Not run)
## Not run:
setwd(system.file("extdata/Genelists", package = "pwOmics.newupdown"))
data_omics = identifyPWs(data_omics_plus)
data_omics = identifyTFs(data_omics)
data_omics = identifyRsofTFs(data_omics,
noTFs_inPW = 1, order_neighbors = 10)
getUS_PWs(data_omics)

## End(Not run)

getUS_regulators

Get upstream regulators of identiﬁed transcription factors.

Description

Get upstream regulators of identiﬁed transcription factors.

Usage

getUS_regulators(data_omics)

Arguments

data_omics

OmicsData object.

Value

list of length = number of gene/transcript time points, each element containing a vector of protein
regulator IDs.

Examples

## Not run:
data(OmicsExampleData)
data_omics = readOmics(tp_prots = c(0.25, 1, 4, 8, 13, 18, 24),
tp_genes = c(1, 4, 8, 13, 18, 24), OmicsExampleData,
PWdatabase = c("biocarta", "kegg", "nci", "reactome"),
TFtargetdatabase = c("userspec"))
data_omics = readPhosphodata(data_omics,
phosphoreg = system.file("extdata", "phospho_reg_table.txt",
package = "pwOmics.newupdown"))
data_omics = readTFdata(data_omics,
TF_target_path = system.file("extdata", "TF_targets.txt",
package = "pwOmics.newupdown"))
data_omics_plus = readPWdata(data_omics,
loadgenelists = system.file("extdata/Genelists", package = "pwOmics.newupdown"))
data_omics_plus = identifyPR(data_omics_plus)

## End(Not run)
## Not run:
setwd(system.file("extdata/Genelists", package = "pwOmics.newupdown"))
data_omics = identifyPWs(data_omics_plus)

30

getUS_TFs

data_omics = identifyTFs(data_omics)
data_omics = identifyRsofTFs(data_omics,
noTFs_inPW = 1, order_neighbors = 10)
getUS_regulators(data_omics)

## End(Not run)

getUS_TFs

Get upstream TFs.

Description

Get upstream TFs.

Usage

getUS_TFs(data_omics)

Arguments

data_omics

OmicsData object.

Value

list of length = number of gene/transcript time points, each element containing a data frame with
upstream transcription factors.

Examples

## Not run:
data(OmicsExampleData)
data_omics = readOmics(tp_prots = c(0.25, 1, 4, 8, 13, 18, 24),
tp_genes = c(1, 4, 8, 13, 18, 24), OmicsExampleData,
PWdatabase = c("biocarta", "kegg", "nci", "reactome"),
TFtargetdatabase = c("userspec"))
data_omics = readPhosphodata(data_omics,
phosphoreg = system.file("extdata", "phospho_reg_table.txt",
package = "pwOmics.newupdown"))
data_omics = readTFdata(data_omics,
TF_target_path = system.file("extdata", "TF_targets.txt",
package = "pwOmics.newupdown"))
data_omics_plus = readPWdata(data_omics,
loadgenelists = system.file("extdata/Genelists", package = "pwOmics.newupdown"))
data_omics_plus = identifyPR(data_omics_plus)

## End(Not run)
## Not run:
setwd(system.file("extdata/Genelists", package = "pwOmics.newupdown"))
data_omics = identifyPWs(data_omics_plus)
data_omics = identifyTFs(data_omics)
data_omics = identifyRsofTFs(data_omics,
noTFs_inPW = 1, order_neighbors = 10)
getUS_TFs(data_omics)

## End(Not run)

get_matching_transcripts

31

get_matching_transcripts

Summarize table of matching downstream transcripts.

Description

This function returns the summarized table of matching transcripts information based on the result
list from the ﬁndSignalingAxes function.

Usage

get_matching_transcripts(data_omics, axis)

Arguments

data_omics
axis

Value

OmicsData object.
list output of ﬁndSignalingAxes.

dataframe containing the target genes of the axis matching the transcript data in at least one of the
time points in the ﬁrst column, the direction of their regulation inferred from the phosphoproteome
data in the second column, the transcript regulation in the next columns (per time point) and the
summarized matched information in the following columns (per time point).

Examples

## Not run:
data(OmicsExampleData)
data_omics = readOmics(tp_prots = c(0.25, 1, 4, 8, 13, 18, 24),
tp_genes = c(1, 4, 8, 13, 18, 24), OmicsExampleData,
PWdatabase = c("biocarta", "kegg", "nci", "reactome"),
TFtargetdatabase = c("userspec"))
data_omics = readPhosphodata(data_omics,
phosphoreg = system.file("extdata", "phospho_reg_table.txt",
package = "pwOmics.newupdown"))
data_omics = readTFdata(data_omics,
TF_target_path = system.file("extdata", "TF_targets.txt",
package = "pwOmics.newupdown"))
data_omics_plus = readPWdata(data_omics,
loadgenelists = system.file("extdata/Genelists", package = "pwOmics.newupdown"))

## End(Not run)
## Not run:
data_omics_plus = identifyPR(data_omics_plus)
setwd(system.file("extdata/Genelists", package = "pwOmics.newupdown"))
data_omics = identifyPWs(data_omics_plus)
data_omics = identifyTFs(data_omics)
data_omics = identifyPWTFTGs(data_omics)
data_omics = identifyRsofTFs(data_omics, noTFs_inPW = 1, order_neighbors = 10)
SYK_axis = findSignalingAxes(data_omics,phosphoprot = "SYK", tpDS = 2)
SYK_transcripts = get_matching_transcripts(data_omics, SYK_axis)

## End(Not run)

32

identifyPR

identifyPR

Identify phosphorylation regulation inﬂuence downstream

Description

This function identiﬁes the downstream regulation inﬂuence of phosphoprotein regulation for fur-
ther downstream analysis steps.

Usage

identifyPR(data_omics_plus)

Arguments

data_omics_plus

Value

output list of readPWdata function; ﬁrst element contains an OmicsData object,
secons element the genelist data corresponding to the selected pathway database.

OmicsData object: list of 4 elements (OmicsD, PathwayD, TFtargetsD, Status); OmicsD containing
omics data set + results (after analysis); PathwayD containing selected pathway databases + biopax
model; TFtargetsD containing selected TF target gene databases + TF target gene data.

Examples

## Not run:
data(OmicsExampleData)
data_omics = readOmics(tp_prots = c(0.25, 1, 4, 8, 13, 18, 24),
tp_genes = c(1, 4, 8, 13, 18, 24), OmicsExampleData,
PWdatabase = c("biocarta", "kegg", "nci", "reactome"),
TFtargetdatabase = c("userspec"))
data_omics = readPhosphodata(data_omics,
phosphoreg = system.file("extdata", "phospho_reg_table.txt",
package = "pwOmics.newupdown"))
data_omics = readTFdata(data_omics,
TF_target_path = system.file("extdata", "TF_targets.txt",
package = "pwOmics.newupdown"))
data_omics_plus = readPWdata(data_omics,
loadgenelists = system.file("extdata/Genelists", package = "pwOmics.newupdown"))
data_omics_plus = identifyPR(data_omics_plus)

## End(Not run)

identifyPWs

33

identifyPWs

Identify pathway IDs and pathway names of differentially abundant
proteins

Description

This function identiﬁes the pathways of the differentially abundant phosphoproteins dependent on
the chosen database. Requires rBiopaxParser package. Takes a lot of time for a high number of
proteins and/or if all databases are chosen. First, chosen databases are loaded, then new internal
pathway IDs are generated. Afterwards the genelists of the different databases are loaded or gen-
erated, depending on the loadgenelists option. After pathway identiﬁcation for the reference time
point, also pathway identiﬁcation for different time points is performed. Pathway ID mapping takes
some time, especially for such big databases as reactome, so use savegenelists and loadgenelists for
easier and faster usage...

Usage

identifyPWs(data_omics_plus)

Arguments

data_omics_plus

output list of readPWdata function; ﬁrst element contains an OmicsData object,
secons element the genelist data corresponding to the selected pathway database.

Value

OmicsData object: list of 4 elements (OmicsD, PathwayD, TFtargetsD, Status); OmicsD containing
omics data set + results (after analysis); PathwayD containing selected pathway databases + biopax
model; TFtargetsD containing selected TF target gene databases + TF target gene data.

Examples

## Not run:
data(OmicsExampleData)
data_omics = readOmics(tp_prots = c(0.25, 1, 4, 8, 13, 18, 24),
tp_genes = c(1, 4, 8, 13, 18, 24), OmicsExampleData,
PWdatabase = c("biocarta", "kegg", "nci", "reactome"),
TFtargetdatabase = c("userspec"))
data_omics = readPhosphodata(data_omics,
phosphoreg = system.file("extdata", "phospho_reg_table.txt",
package = "pwOmics.newupdown"))
data_omics = readTFdata(data_omics,
TF_target_path = system.file("extdata", "TF_targets.txt",
package = "pwOmics.newupdown"))
data_omics_plus = readPWdata(data_omics,
loadgenelists = system.file("extdata/Genelists", package = "pwOmics.newupdown"))

## End(Not run)
## Not run:
data_omics_plus = identifyPR(data_omics_plus)
setwd(system.file("extdata/Genelists", package = "pwOmics.newupdown"))
data_omics = identifyPWs(data_omics_plus)

34

identifyPWTFTGs

## End(Not run)

identifyPWTFTGs

Identify TFs in pathways and their target genes - downstream analysis.

Description

This function identiﬁes the transcription factors being part of the pathways of downstream analysis.
Subsequently it ﬁnds the target genes of these transcription factors from the selected TF-target gene
database.

Usage

identifyPWTFTGs(data_omics, updown = FALSE)

Arguments

data_omics
updown

Value

OmicsData object.
boolean value; TRUE in case up- and downregulation should be checked in-
dividually for intersection; FALSE = default, if only deregulation should be
checked for.

OmicsData object: list of 4 elements (OmicsD, PathwayD, TFtargetsD, Status); OmicsD containing
omics data set + results (after analysis); PathwayD containing selected pathway databases + biopax
model; TFtargetsD containing selected TF target gene databases + TF target gene data.

Examples

## Not run:
data(OmicsExampleData)
data_omics = readOmics(tp_prots = c(0.25, 1, 4, 8, 13, 18, 24),
tp_genes = c(1, 4, 8, 13, 18, 24), OmicsExampleData,
PWdatabase = c("biocarta", "kegg", "nci", "reactome"),
TFtargetdatabase = c("userspec"))
data_omics = readPhosphodata(data_omics,
phosphoreg = system.file("extdata", "phospho_reg_table.txt",
package = "pwOmics.newupdown"))
data_omics = readTFdata(data_omics,
TF_target_path = system.file("extdata", "TF_targets.txt",
package = "pwOmics.newupdown"))
data_omics_plus = readPWdata(data_omics,
loadgenelists = system.file("extdata/Genelists", package = "pwOmics.newupdown"))
data_omics_plus = identifyPR(data_omics_plus)
setwd(system.file("extdata/Genelists", package = "pwOmics.newupdown"))

## End(Not run)
## Not run:
data_omics = identifyPWs(data_omics_plus)
data_omics = identifyTFs(data_omics)
data_omics = identifyPWTFTGs(data_omics)

## End(Not run)

identifyRsofTFs

35

identifyRsofTFs

Identify regulators of transcription factors - upstream analysis.

Description

This function identiﬁes the regulators upstream of the identiﬁed transcription factors in upstream
analysis. Converting the pathway information to a regulatory graph needs some time... Warnings
regarding the skipping of edges in building the regulatory graph can be ignored.

Usage

identifyRsofTFs(data_omics, noTFs_inPW = 2, order_neighbors = 6)

Arguments

data_omics

noTFs_inPW

order_neighbors

Value

OmicsData object.

integer; only regulators in upstream pathways with more than this number of
TFs are identiﬁed.

integer speciﬁying the order of the neighborhood: order 1 is TF plus its imme-
diate neighbors.

OmicsData object: list of 4 elements (OmicsD, PathwayD, TFtargetsD, Status); OmicsD containing
omics data set + results (after analysis); PathwayD containing selected pathway databases + biopax
model; TFtargetsD containing selected TF target gene databases + TF target gene data.

Examples

## Not run:
data(OmicsExampleData)
data_omics = readOmics(tp_prots = c(0.25, 1, 4, 8, 13, 18, 24),
tp_genes = c(1, 4, 8, 13, 18, 24), OmicsExampleData,
PWdatabase = c("biocarta", "kegg", "nci", "reactome"),
TFtargetdatabase = c("userspec"))
data_omics = readPhosphodata(data_omics,
phosphoreg = system.file("extdata", "phospho_reg_table.txt",
package = "pwOmics.newupdown"))
data_omics = readTFdata(data_omics,
TF_target_path = system.file("extdata", "TF_targets.txt",
package = "pwOmics.newupdown"))
data_omics_plus = readPWdata(data_omics,
loadgenelists = system.file("extdata/Genelists", package = "pwOmics.newupdown"))

## End(Not run)
## Not run:
data_omics_plus = identifyPR(data_omics_plus)
setwd(system.file("extdata/Genelists", package = "pwOmics.newupdown"))
data_omics = identifyPWs(data_omics_plus)
data_omics = identifyTFs(data_omics)
setwd(system.file("extdata/Genelists", package = "pwOmics"))
data_omics = identifyRsofTFs(data_omics,

36

identifyTFs

noTFs_inPW = 1, order_neighbors = 10)

## End(Not run)

identifyTFs

Transcription factor identiﬁcation.

Description

This function identiﬁes the upstream transcription factors of the provided gene IDs.

Usage

identifyTFs(data_omics)

Arguments

data_omics

OmicsData object.

Value

OmicsData object: list of 4 elements (OmicsD, PathwayD, TFtargetsD, Status); OmicsD containing
omics data set + results (after analysis); PathwayD containing selected pathway databases + biopax
model; TFtargetsD containing selected TF target gene databases + TF target gene data.

Examples

## Not run:
data(OmicsExampleData)
data_omics = readOmics(tp_prots = c(0.25, 1, 4, 8, 13, 18, 24),
tp_genes = c(1, 4, 8, 13, 18, 24), OmicsExampleData,
PWdatabase = c("biocarta", "kegg", "nci", "reactome"),
TFtargetdatabase = c("userspec"))
data_omics = readPhosphodata(data_omics,
phosphoreg = system.file("extdata", "phospho_reg_table.txt",
package = "pwOmics.newupdown"))
data_omics = readTFdata(data_omics,
TF_target_path = system.file("extdata", "TF_targets.txt",
package = "pwOmics.newupdown"))
data_omics_plus = readPWdata(data_omics,
loadgenelists = system.file("extdata/Genelists", package = "pwOmics.newupdown"))

## End(Not run)
## Not run:
data_omics_plus = identifyPR(data_omics_plus)
setwd(system.file("extdata/Genelists", package = "pwOmics.newupdown"))
data_omics = identifyPWs(data_omics_plus)
data_omics = identifyTFs(data_omics)

## End(Not run)

identPWsofTFs

37

identPWsofTFs

Identiﬁcation of pathways containing the transcription factors identi-
ﬁed in upstream analysis

Description

Identiﬁcation of pathways containing the transcription factors identiﬁed in upstream analysis

Usage

identPWsofTFs(genelists, tps_TFs)

Arguments

genelists

tps_TFs

Value

data.table as read/loaded by loadGenelist function.

data.table of upstream transcription factors as returned from identTFs function.

list with ﬁrst element being a pathway list and second being a pathway dataframe of pathways
including the TFs of the speciﬁed timepoint.

identRegulators

Identify overlapping upstream regulators of x transcription factors

Description

Identify overlapping upstream regulators of x transcription factors

Usage

identRegulators(pws_morex_TFs, data_omics, order_neighbors, noTFs_inPW)

Arguments

pws_morex_TFs

data_omics
order_neighbors

noTFs_inPW

Value

list of transcription factors in identiﬁed pathways.

OmicsData object.

integer speciﬁying the order of the neighborhood: order 1 is TF plus its imme-
diate neighbors.

integer; only regulators in upstream pathways with more than this number of
TFs are identiﬁed.

list of possible proteomic regulators.

38

identTFTGsinPWs

identTFs

This function provides a data.table of upstream transcription factors.

Description

This function provides a data.table of upstream transcription factors.

Usage

identTFs(data_omics, glen)

Arguments

data_omics

OmicsData object.

glen

numeric value; identiﬁer for current timepoint.

Value

data.table of upstream TFs.

identTFTGsinPWs

Prepare OmicsData object for pathway information.

Description

This function identiﬁes the TFs in the pathway genes and determines their target genes on basis of
the given (chosen) TF-target database(s).

Usage

identTFTGsinPWs(data_omics, temp_genelist)

Arguments

data_omics

OmicsData object.

temp_genelist

dataframe of unique gene IDs in PWs.

Value

list with ﬁrst element being a genelist of the pathways and second being a target gene list of TFs.

infoConsensusGraph

39

infoConsensusGraph

Add Consensus Graph information.

Description

Adds phosphoprotein information based on phosphoprotein data table and redraws Consensus Graph
edges

Usage

infoConsensusGraph(data_omics, consensusGraph, phosphotab)

Arguments

data_omics
consensusGraph result from static analysis: consensus graph generated by staticConsensusNet

OmicsData object.

function.

phosphotab

dataframe with phosphoprotein information annotated in columns ’Gene.names’,
’Amino acid’, ’Position’ (of phosphosite).

Value

graph of igraph class containing complemented consensus graph information

Examples

## Not run:
data(OmicsExampleData)
data_omics = readOmics(tp_prots = c(0.25, 1, 4, 8, 13, 18, 24),
tp_genes = c(1, 4, 8, 13, 18, 24), OmicsExampleData,
PWdatabase = c("biocarta", "kegg", "nci", "reactome"),
TFtargetdatabase = c("userspec"))
data_omics = readPhosphodata(data_omics,
phosphoreg = system.file("extdata", "phospho_reg_table.txt",
package = "pwOmics.newupdown"))
data_omics = readTFdata(data_omics,
TF_target_path = system.file("extdata", "TF_targets.txt",
package = "pwOmics.newupdown"))
data_omics_plus = readPWdata(data_omics,
loadgenelists = system.file("extdata/Genelists", package = "pwOmics.newupdown"))

## End(Not run)
## Not run:
data_omics_plus = identifyPR(data_omics_plus)
setwd(system.file("extdata/Genelists", package = "pwOmics.newupdown"))
data_omics = identifyPWs(data_omics_plus)
data_omics = identifyTFs(data_omics)
data_omics = identifyRsofTFs(data_omics,
noTFs_inPW = 1, order_neighbors = 10)
data_omics = identifyPWTFTGs(data_omics)
statConsNet = staticConsensusNet(data_omics)

## End(Not run)

40

loadPWs

loadGenelists

Loading of genelists

Description

This function automatically loads the genelists corresponding to the selected pathway databases
stored as RData ﬁle in the current working directory.

Usage

loadGenelists()

Value

genelist of speciﬁed pathway database.

loadPWs

Load pathway database information.

Description

This function loads the pathway information from pathway databases. Needed in the identifyPWs
function.

Usage

loadPWs(pwdatabases, biopax_level)

Arguments

pwdatabases

vector indicating with which pathway database the pathways should be deter-
mined; possible choices are "biocarta", "kegg", "nci", "reactome".

biopax_level

integer indicating biopax level of pathway database information to be retrieved.

Value

list of biopax model corresponding to speciﬁed pathway databases.

OmicsExampleData

41

OmicsExampleData

Omics example dataset.

Description

A dataset as input example for readOmics: A list containing two input lists, one for protein data,
one for gene data, both including a vector of all measured IDs as ﬁrst element and a list as second
element including for each tp a dataframe with IDs and log foldchanges per timepoint.

Usage

data(OmicsExampleData)

Format

A list with a ’P’ sublist containing protein data and a ’G’ sublist containing gene/transcript data.
Each of the sublists has a ﬁrst element with all measured protein/gene IDs and a second element
with a list of the length of the number of measured time points. Each of these lists contains a
dataframe with a ﬁrst column of signiﬁcant protein/gene IDs at that time point and a second column
with the corresponding logFCs.

Value

List with 2 sublists.

plotConsDynNet

Plot inferred net based on analysis analysis.

Description

Dynamic analysis result is plotted to pdf ﬁle stored in current working directory.

Usage

plotConsDynNet(dynConsensusNet, sig.level, clarify = "TRUE",

layout = layout.fruchterman.reingold, ...)

Arguments

dynConsensusNet

sig.level

clarify

layout

...

Value

result of dynamic analysis: inferred net generated by consDynamicNet function.

signiﬁcance level for plotting edges in network (between 0 and 1).

indicating if unconnected nodes should be removed; default = "TRUE".

igraph layout parameter; default is layout.fruchterman.reingold.

further plotting/legend parameters.

pdf ﬁle in current working directory.

42

Examples

plotConsensusGraph

## Not run:
data(OmicsExampleData)
data_omics = readOmics(tp_prots = c(0.25, 1, 4, 8, 13, 18, 24),
tp_genes = c(1, 4, 8, 13, 18, 24), OmicsExampleData,
PWdatabase = c("biocarta", "kegg", "nci", "reactome"),
TFtargetdatabase = c("userspec"))
data_omics = readPhosphodata(data_omics,
phosphoreg = system.file("extdata", "phospho_reg_table.txt",
package = "pwOmics.newupdown"))
data_omics = readTFdata(data_omics,
TF_target_path = system.file("extdata", "TF_targets.txt",
package = "pwOmics.newupdown"))
data_omics_plus = readPWdata(data_omics,
loadgenelists = system.file("extdata/Genelists", package = "pwOmics.newupdown"))

## End(Not run)
## Not run:
data_omics_plus = identifyPR(data_omics_plus)
setwd(system.file("extdata/Genelists", package = "pwOmics.newupdown"))
data_omics = identifyPWs(data_omics_plus)
data_omics = identifyTFs(data_omics)
data_omics = identifyRsofTFs(data_omics,
noTFs_inPW = 1, order_neighbors = 10)
data_omics = identifyPWTFTGs(data_omics)
statConsNet = staticConsensusNet(data_omics)
dynConsNet = consDynamicNet(data_omics, statConsNet)
plotConsDynNet(dynConsNet, sig.level = 0.8)

## End(Not run)

plotConsensusGraph

Plot consensus graph(s) from static analysis.

Description

Consensus graph(s) plotted to pdf ﬁle stored in current working directory.

Usage

plotConsensusGraph(consensusGraphs, data_omics, ...)

Arguments

consensusGraphs

result from static analysis: consensus graph generated by staticConsensusNet
function.

data_omics

OmicsData object.

...

Value

further plotting/legend parameters.

pdf ﬁle in current working directory.

plotConsensusProﬁles

Examples

43

## Not run:
data(OmicsExampleData)
data_omics = readOmics(tp_prots = c(0.25, 1, 4, 8, 13, 18, 24),
tp_genes = c(1, 4, 8, 13, 18, 24), OmicsExampleData,
PWdatabase = c("biocarta", "kegg", "nci", "reactome"),
TFtargetdatabase = c("userspec"))
data_omics = readPhosphodata(data_omics,
phosphoreg = system.file("extdata", "phospho_reg_table.txt",
package = "pwOmics.newupdown"))
data_omics = readTFdata(data_omics,
TF_target_path = system.file("extdata", "TF_targets.txt",
package = "pwOmics.newupdown"))
data_omics_plus = readPWdata(data_omics,
loadgenelists = system.file("extdata/Genelists", package = "pwOmics.newupdown"))

## End(Not run)
## Not run:
data_omics_plus = identifyPR(data_omics_plus)
setwd(system.file("extdata/Genelists", package = "pwOmics.newupdown"))
data_omics = identifyPWs(data_omics_plus)
data_omics = identifyTFs(data_omics)
data_omics = identifyRsofTFs(data_omics,
noTFs_inPW = 1, order_neighbors = 10)
data_omics = identifyPWTFTGs(data_omics)
statConsNet = staticConsensusNet(data_omics)
plot(ConsensusGraph, data_omics)

## End(Not run)

plotConsensusProfiles Plot consensus graph proﬁles of static consensus molecules.

Description

Consensus graph proﬁles of static consensus molecules plotted as heatmap to pdf ﬁle stored in
current working directory.

Usage

plotConsensusProfiles(consensusGraphs, data_omics, subsel = TRUE, ...)

Arguments

consensusGraphs

data_omics

subsel

result from static analysis: consensus graph generated by staticConsensusNet
function.

OmicsData object.

character vector of selected consensus molecules for plotting; if TRUE all con-
sensus molecules are plotted

...

further plotting/legend parameters.

44

Value

pdf ﬁle in current working directory.

Examples

plotTimeProﬁleClusters

## Not run:
data(OmicsExampleData)
data_omics = readOmics(tp_prots = c(0.25, 1, 4, 8, 13, 18, 24),
tp_genes = c(1, 4, 8, 13, 18, 24), OmicsExampleData,
PWdatabase = c("biocarta", "kegg", "nci", "reactome"),
TFtargetdatabase = c("userspec"))
data_omics = readPhosphodata(data_omics,
phosphoreg = system.file("extdata", "phospho_reg_table.txt",
package = "pwOmics.newupdown"))
data_omics = readTFdata(data_omics,
TF_target_path = system.file("extdata", "TF_targets.txt",
package = "pwOmics.newupdown"))
data_omics_plus = readPWdata(data_omics,
loadgenelists = system.file("extdata/Genelists", package = "pwOmics.newupdown"))

## End(Not run)
## Not run:
data_omics_plus = identifyPR(data_omics_plus)
setwd(system.file("extdata/Genelists", package = "pwOmics.newupdown"))
data_omics = identifyPWs(data_omics_plus)
data_omics = identifyTFs(data_omics)
data_omics = identifyRsofTFs(data_omics,
noTFs_inPW = 1, order_neighbors = 10)
data_omics = identifyPWTFTGs(data_omics)
statConsNet = staticConsensusNet(data_omics)
plotConsensusProfiles(statConsNet, data_omics, subsel = TRUE)

## End(Not run)

plotTimeProfileClusters

Plot time proﬁle clusters of dynamic analysis result.

Description

Plot time proﬁle clusters of dynamic analysis result.

Usage

plotTimeProfileClusters(fuzzed_matsplines)

Arguments

fuzzed_matsplines

result of dynamic analysis: inferred net generated by consDynamicNet function.

...

further plotting/legend parameters.

predictFCvals

Value

pdf ﬁle in current working directory.

Examples

45

## Not run:
data(OmicsExampleData)
data_omics = readOmics(tp_prots = c(0.25, 1, 4, 8, 13, 18, 24),
tp_genes = c(1, 4, 8, 13, 18, 24), OmicsExampleData,
PWdatabase = c("biocarta", "kegg", "nci", "reactome"),
TFtargetdatabase = c("userspec"))
data_omics = readPhosphodata(data_omics,
phosphoreg = system.file("extdata", "phospho_reg_table.txt",
package = "pwOmics.newupdown"))
data_omics = readTFdata(data_omics,
TF_target_path = system.file("extdata", "TF_targets.txt",
package = "pwOmics.newupdown"))
data_omics_plus = readPWdata(data_omics,
loadgenelists = system.file("extdata/Genelists", package = "pwOmics.newupdown"))

## End(Not run)
## Not run:
data_omics_plus = identifyPR(data_omics_plus)
setwd(system.file("extdata/Genelists", package = "pwOmics.newupdown"))
data_omics = identifyPWs(data_omics_plus)
data_omics = identifyTFs(data_omics)
data_omics = identifyRsofTFs(data_omics,
noTFs_inPW = 1, order_neighbors = 10)
data_omics = identifyPWTFTGs(data_omics)
statConsNet = staticConsensusNet(data_omics)
consDynNet = consDynamicNet(data_omics, statConsNet)
timeprof = clusterTimeProfiles(consDynNet)
plotTimeProfileClusters(timeprof)

## End(Not run)

predictFCvals

Prediction of continous data points via smoothing splines.

Description

Prediction of continous data points via smoothing splines.

Usage

predictFCvals(data_omics, nopredpoints, splineslist, title)

Arguments

data_omics
nopredpoints
splineslist

title

OmicsData object.
integer number; how many timpoints should be predicted?
list of protein or gene nodes for which splines were generated: output of getFC-
splines function.
character vector specifying name of title.

46

Value

list of splines matrix values and calculated times.

print.OmicsData

preparePWinfo

Prepare OmicsData object for pathway information.

Description

This function prepares the OmicsData object for the identiﬁed pathway information.

Usage

preparePWinfo(data_omics, plen)

Arguments

data_omics

OmicsData object.

plen

Value

integer indicating the timepoint currently investigated.

list of OmicsData object, current timepoint and pathways of interest.

print.OmicsData

Print an OmicsData object.

Description

Print an OmicsData object.

Usage

## S3 method for class 'OmicsData'
print(x, ...)

Arguments

x

...

Value

an OmicsData object to print.

further arguments to be passed to print.

prints OmicsData object.

PWidentallprots

47

PWidentallprots

Identiﬁcation of pathwayIDs and pathway names for all proteins.

Description

Identiﬁcation of pathwayIDs and pathway names for all proteins.

Usage

PWidentallprots(data_omics, genelists)

Arguments

data_omics

genelists

Value

OmicsData object.

lists of genelists from chosen pathway databases.

OmicsData object with identiﬁed pathway IDs for list of all proteins.

PWidentallprotssub

Internal subfunction for all protein pathway identiﬁcation.

Description

Internal subfunction for all protein pathway identiﬁcation.

Usage

PWidentallprotssub(data_omics, genelists, genelist_ind, datab)

Arguments

data_omics

genelists

genelist_ind

OmicsData object.

lists of genelists from chosen pathway databases

integer specifying pathway database genelist matching; 1 = biocarta, 2 = kegg,
3 = nci, 4 = reactome.

datab

character vector indicating database name for message.

Value

OmicsData object with identiﬁed pathways for each protein.

48

readOmics

PWidenttps

Identiﬁcation of pathwayIDs and pathway names for proteins at indi-
vidual timepoints.

Description

Take the identiﬁed pathways from the list of all proteins and transfer this information for the indi-
vidual timepoints.

Usage

PWidenttps(data_omics)

Arguments

data_omics

OmicsData object.

Value

data_omics OmicsData object with all pathways identiﬁed for the individual timepoints.

readOmics

Read in omics data.

Description

This function reads omics data: differentially expressed genes and relatively differentially abundant
proteins with corresponding fold changes for each time point.

Usage

readOmics(tp_prots, tp_genes, omics, PWdatabase, TFtargetdatabase)

Arguments

tp_prots

tp_genes

omics

PWdatabase

numeric vector of protein timepoints used in experiment; in case of single time
point experiments simply assign an experiment number (e.g. 1).

numeric vector of gene/transcript timepoints used in experiment; in case of sin-
gle time point experiments simply assign an experiment number (e.g. 1).

list containing protein and gene IDs and fold changes: Input are two lists, one
for protein data, one for gene data, both including a vector of all measured IDs
as ﬁrst element and a list as second element including for each tp a dataframe
with IDs and foldchanges per timepoint.

character vector of pathway database names which should be used for pathway
identiﬁcation, possible choices are "biocarta", "kegg", "nci", "reactome".

TFtargetdatabase

character vector of TF target database names which should be used for tran-
scription factor/target gene identiﬁcation, possible choices are "chea", "pazar",
"userspec". In case the user is able to provide an own list of transcription factor
target gene matches, he can indicate this via "userspec".

readPhosphodata

Value

49

OmicsData object: list of 4 elements (OmicsD, PathwayD, TFtargetsD, Status); OmicsD containing
omics data set + results (after analysis); PathwayD containing selected pathway databases + biopax
model; TFtargetsD containing selected TF target gene databases + TF target gene data.

Examples

## Not run:
data(OmicsExampleData)
data_omics = readOmics(tp_prots = c(0.25, 1, 4, 8, 13, 18, 24),
tp_genes = c(1, 4, 8, 13, 18, 24), OmicsExampleData,
PWdatabase = c("biocarta", "kegg", "nci", "reactome"),
TFtargetdatabase = c("userspec"))

## End(Not run)

readPhosphodata

Reads in phosphoprotein downstream regulation information.

Description

This function reads in phosphoprotein downstream regulation information from a txt ﬁle.

Usage

readPhosphodata(data_omics, phosphoreg)

Arguments

data_omics
phosphoreg

Value

OmicsData object.
txt ﬁle with 2 columns, ﬁrst providing gene names, second giving -1/1 annota-
tion whether downstream regulation of phosphoprotein is inhibiting or activat-
ing, respectively.

OmicsData object: list of 4 elements (OmicsD, PathwayD, TFtargetsD, Status); OmicsD containing
omics data set + results (after analysis); PathwayD containing selected pathway databases + biopax
model; TFtargetsD containing selected TF target gene databases + TF target gene data; PhosphoD
containing optionally phosphoprotein downstream regulation annotation.

Examples

## Not run:
data(OmicsExampleData)
data_omics = readOmics(tp_prots = c(0.25, 1, 4, 8, 13, 18, 24),
tp_genes = c(1, 4, 8, 13, 18, 24), OmicsExampleData,
PWdatabase = c("biocarta", "kegg", "nci", "reactome"),
TFtargetdatabase = c("userspec"))
data_omics = readPhosphodata(data_omics,
phosphoreg = system.file("extdata", "phospho_reg_table.txt",
package = "pwOmics"))

## End(Not run)

50

readPWdata

readPWdata

Read in pathway database data needed for pathway identiﬁcation.

Description

This function reads pathway data of the chosen database(s) via the AnnotationHub [1] package
and rBiopaxParser [2] package. Takes a lot of time for a high number of proteins and/or if all
databases are chosen. First, chosen databases are retrieved, then new internal pathway IDs are
generated. Afterwards the genelists of the different databases are loaded or generated, depending
on the loadgenelists option. Pathway ID mapping takes some time, especially for such big databases
as reactome, so the genelists are automatically stored in the current working folder and can be used
via loadgenelists in case you use this function again for easier and faster usage... Biopax level of
retrieved databases is 2 by default.

Usage

readPWdata(data_omics, loadgenelists, biopax_level = 2)

Arguments

data_omics

loadgenelists

biopax_level

Value

OmicsData object.

path of genelist RData ﬁles stored previously; all genelists stored in this path are
read in and used automatically if path is given; if loadgenelists = FALSE, then
genelists from pathway databases have to be generated ﬁrst.

integer indicating biopax level of pathway database information. default level is
2.

list of OmicsData object and genelists for selected pathway databases.

References

1. Morgan M, Carlson M, Tenenbaum D and Arora S. AnnotationHub: Client to access Annota-
tionHub resources. R package version 1.99.75.

2. Kramer F, Bayerlova M, Klemm F, Bleckmann A and Beissbarth T. rBiopaxParser - an R package
to parse, modify and visualize BioPAX data.

Examples

## Not run:
data(OmicsExampleData)
data_omics = readOmics(tp_prots = c(0.25, 1, 4, 8, 13, 18, 24),
tp_genes = c(1, 4, 8, 13, 18, 24), OmicsExampleData,
PWdatabase = c("biocarta", "kegg", "nci", "reactome"),
TFtargetdatabase = c("userspec"))
data_omics = readPhosphodata(data_omics,
phosphoreg = system.file("extdata", "phospho_reg_table.txt",
package = "pwOmics.newupdown"))
data_omics = readTFdata(data_omics,
TF_target_path = system.file("extdata", "TF_targets.txt",
package = "pwOmics.newupdown"))

readTFdata

51

data_omics_plus = readPWdata(data_omics,
loadgenelists = system.file("extdata/Genelists", package = "pwOmics.newupdown"))

## End(Not run)

readTFdata

Reads in chosen transcription factor target database information.

Description

This function reads in transcription factor information given the selected transcription factor target
gene database. The information is downloaded via the AnnotationHub package and merged, if
necessary.

Usage

readTFdata(data_omics, TF_target_path, cell_match = 0,

TF_filter_threshold = 0)

Arguments

data_omics

OmicsData object.

TF_target_path character vector indicating path of the txt ﬁle of matching transcription factors
and target genes; the ﬁle should be a txt ﬁle with ﬁrst column transcription
factors and second column target gene symbols without a header.

cell_match

character indicating the cell line/cells for which the TF target gene data should
be extracted from the database; this is only possible for chea database. Available
cell-speciﬁc data from chea for matching are "Hs578T", "Raji B cells and iDC",
"MCF7", "THP-1", "Hela cells", "STHdh", "H3396 breast cancer cells","HL60","HESC","T-
ALL", "HPC-7", "ovarian surface epithelium", "HaCaT", "HCT116","U2OS",
"Wilms tumor-derived CCG99-9611", "HepG2","HUMAN INTESTINAL CELL
LINE CACO-2", "HEK293T","K562", "AK7", "NEUROBLASTOMA","JURKAT","T-
47D","LS174T", "MULTIPLE HUMAN CANCER CELL TYPES", "501MEL",
"PC3", "CACO-2", "FETAL_BRAIN", "HELA", "U937_AND_SAOS2", "CD4_POS_T",
"ERYTHROLEUKEMIA", "RHABDOMYOSARCOMA", "293T", "SW620",
"LYMPHOBLASTOID", "VCAP", "SK-N-MC", "CADO-ES1", "MEDULLOBLAS-
TOMA", "M12", "K562_HELA_HEPG2_GM12878", "NT2", "SHEP-21N", "LN229_GBM",
"MCF-7", "MELANOMA", "MYOFIBROBLAST", "NTERA2", "MEGAKARY-
OCYTES", "HMVEC", "ZR75-1", "TREG", "TLL", "A2780", "MONOCYTES",
"BEAS2B", "LNCAP PROSTATE CANCER CELL LINES", "MCF10A", "GC-
B", "BL", "IMR90", "EOC", "PCA", "PROSTATE_CANCER", "OVCAR3",
"MALME-3M", "HFKS", "HEK293", "HELA-AND-SCP4", "CD34+", "IB4-
LCL", "MDA-MB-231", "U87", "T47D", "Z138-A519-JVM2", "DLD1", "ATHEROSCLEROTIC-
FOAM", "LCL-AND-THP1", "NB4", "PFSK-1 AND SK-N-MC", "EP156T","GBM1-
GSC","CD4+", "FIBROSARCOMA", "LGR5+ INTESTINAL STEM CELL","NEUROBLASTOMA
BE2-C". If no tissue is given the data from all cells/cell lines are merged.

TF_filter_threshold

integer deﬁning a threshold number to ﬁlter out those transcription factors hav-
ing higher numbers of target genes than ’TF_ﬁlter_threshold’ from the further
analysis

52

Value

readTFtargets

OmicsData object - a list containing information about the user data (timepoints, IDs, fold changes)
and the selected databases chosen for the analysis.

OmicsData object: list of 4 elements (OmicsD, PathwayD, TFtargetsD, Status); OmicsD containing
omics data set + results (after analysis); PathwayD containing selected pathway databases + biopax
model; TFtargetsD containing selected TF target gene databases + TF target gene data.

Examples

## Not run:
data(OmicsExampleData)
data_omics = readOmics(tp_prots = c(0.25, 1, 4, 8, 13, 18, 24),
tp_genes = c(1, 4, 8, 13, 18, 24), OmicsExampleData,
PWdatabase = c("biocarta", "kegg", "nci", "reactome"),
TFtargetdatabase = c("userspec"))
data_omics = readPhosphodata(data_omics,
phosphoreg = system.file("extdata", "phospho_reg_table.txt",
package = "pwOmics"))
data_omics = readTFdata(data_omics,
TF_target_path = system.file("extdata", "TF_targets.txt",
package = "pwOmics"))

## End(Not run)

readTFtargets

Read in matching transcription factor target gene pairs.

Description

In case the user is able to provide a ﬁle with transcription factor - target gene matches (e.g. from
TRANSFAC database) this function can read in the information. The ﬁle needs to be a txt ﬁle with
ﬁrst column transcription factors and second column target gene symbols without a header.

Usage

readTFtargets(data_omics, TF_target_path)

Arguments

data_omics

OmicsData object.

TF_target_path path of txt ﬁle containing the transcription factor target gene information as

speciﬁed above.

Value

data frame with user-speciﬁed TF target gene information.

selectPWsofTFs

53

selectPWsofTFs

Select pathways with more than x TFs

Description

Select pathways with more than x TFs

Usage

selectPWsofTFs(pathway_list, pathway_frame, noTFs_inPW)

Arguments

pathway_list

pathway_frame

ﬁrst element of list returned from identPWsofTFs function; contains a list of
pathways.

second element of list returned from identPWsofTFs function; contains a data.frame
of pathways.

noTFs_inPW

numeric value specifying number of TFs being at least part of the pathway.

Value

list of pathways with more than x TFs.

staticConsensusNet

Static analysis.

Description

Identify for each corresponding timepoint of the two datasets the consensus network. Protein in-
tersection of the omics data and TF intersection are linked via SteinerTree algorithm applied on
STRING protein-protein interaction database. The Steiner tree algorithm refers to the shortest path
heuristic algorithm of [1,2]. Target genes of this consensus network are identiﬁed via the chosen
TF-target gene database(s). Please note that the consensus graphs can be different as in the Steiner
Tree algorithm the start terminal node is picked arbitrarily and there are always several shortest path
distances. By default the same time points of both data sets are considered.

Usage

staticConsensusNet(data_omics, run_times = 3, updown = FALSE,

tp_prot = NULL, tp_gene = NULL, phospho = TRUE)

Arguments

data_omics

run_times

updown

OmicsData object.

integer specifying number of times to run SP Steiner tree algorithm to ﬁnd min-
imal graph, default is 3.

boolean value; TRUE in case up- and downregulation should be checked indi-
vidually for intersection. Type of checking is deﬁned with parameter ’phospho’.

staticConsensusNet

integer specifying the time point that should be included into the static consensus
net for the phosphoprotein data

integer specifying the time point that should be included into the static consensus
net for the transcriptome data

boolean value; TRUE in case up- and downregulation should be checked based
on provided downstream phosphoprotein inﬂuence from identifyPR function;
FALSE in case up- and downregulation should be checked for without phospho-
protein database knowledge. Default is TRUE.

54

tp_prot

tp_gene

phospho

Value

list of igraph objects; length corresponds to number of overlapping time points from upstream and
downstream analysis.

References

1. Path heuristic and Original path heuristic, Section 4.1.3 of the book "The Steiner tree Problem",
Peter L. Hammer

2. "An approximate solution for the Steiner problem in graphs", H Takahashi, A Matsuyama

Examples

## Not run:
data(OmicsExampleData)
data_omics = readOmics(tp_prots = c(0.25, 1, 4, 8, 13, 18, 24),
tp_genes = c(1, 4, 8, 13, 18, 24), OmicsExampleData,
PWdatabase = c("biocarta", "kegg", "nci", "reactome"),
TFtargetdatabase = c("userspec"))
data_omics = readPhosphodata(data_omics,
phosphoreg = system.file("extdata", "phospho_reg_table.txt",
package = "pwOmics.newupdown"))
data_omics = readTFdata(data_omics,
TF_target_path = system.file("extdata", "TF_targets.txt",
package = "pwOmics.newupdown"))
data_omics_plus = readPWdata(data_omics,
loadgenelists = system.file("extdata/Genelists", package = "pwOmics.newupdown"))

## End(Not run)
## Not run:
data_omics_plus = identifyPR(data_omics_plus)
setwd(system.file("extdata/Genelists", package = "pwOmics.newupdown"))
data_omics = identifyPWs(data_omics_plus)
data_omics = identifyTFs(data_omics)
data_omics = identifyRsofTFs(data_omics,
noTFs_inPW = 1, order_neighbors = 10)
data_omics = identifyPWTFTGs(data_omics)
statConsNet = staticConsensusNet(data_omics)

## End(Not run)

SteinerTree_cons

55

SteinerTree_cons

Steiner tree algorithm.

Description

Use this function to get the Steiner tree based on the STRING protein-protein interaction database.

Usage

SteinerTree_cons(terminal_nodes, PPI_graph, run_times)

Arguments

terminal_nodes character vector of ﬁnal nodes used for generation of Steiner tree.
PPI_graph

igraph object; graph should be connected and have undirected edges.

run_times

integer specifying number of times to run SP Steiner tree algorithm to ﬁnd min-
imal graph.

Value

igraph object including Steiner tree.

temp_correlations

Plot temporal correlations of phosphoprotein expression levels and af-
fected downstream transcripts.

Description

This function plots an overview of consensus phosphoprotein expression level correlations with
those transcripts that are affected downstream in a newly generated folder in the working directory.
The following additional information needs to be provided: Phosphorylation information amino
acid, position and multiplicity with the expression levels for each of the time points the correla-
tions should be plotted for. Furthermore data tables for fold changes/ratios of phosphoproteins and
transcripts that are part of the data_omics object.

Usage

temp_correlations(ConsensusGraph, timepointsprot, timepointstrans,

foldername = "ProtCons_", trans_sign = "signif_single.csv",
trans_sign_names, phospho_sign = "mat_phospho.csv", phospho_sign_names)

Arguments

ConsensusGraph result from static analysis: consensus graph generated by staticConsensusNet

function.

timepointsprot numeric vector with measurement time points in phosphoproteome data set,

which should be used for correlation plots

56

timepointstrans

foldername

trans_sign

trans_sign_names

temp_correlations

numeric vector with measurement time points in transcriptome data set, which
should be used for correlation plots
character vector specifying the name of the folder that will be generated for the
temporal correlations
character vector specifying a tab-delimited ﬁle with the transcriptome expres-
sion levels for all time points in timepointstrans

character vector specifying column names in the transcriptome ﬁle correspond-
ing to the expression levels at different time points.
character vector specifying a tab-delimited ﬁle with the phosphoproteome infor-
mation (columns ’Gene.names’, ’Amino.acid’, ’Position’, ’Multiplicity’) and
expression levels for all time points in timepointstrans

phospho_sign

phospho_sign_names

character vector specifying column names in the phosphoproteome ﬁle corre-
sponding to the expression levels at different time points.
further plotting/legend parameters.

...

Value

pdf ﬁle in current working directory.

Examples

data(OmicsExampleData)
data_omics = readOmics(tp_prots = c(0.25, 1, 4, 8, 13, 18, 24),
tp_genes = c(1, 4, 8, 13, 18, 24), OmicsExampleData,
PWdatabase = c("biocarta", "kegg", "nci", "reactome"),
TFtargetdatabase = c("userspec"))
data_omics = readPhosphodata(data_omics,
phosphoreg = system.file("extdata", "phospho_reg_table.txt",
package = "pwOmics"))
data_omics = readTFdata(data_omics,
TF_target_path = system.file("extdata", "TF_targets.txt",
package = "pwOmics"))
data_omics_plus = readPWdata(data_omics,
loadgenelists = system.file("extdata/Genelists", package = "pwOmics"))
## Not run:
data_omics_plus = identifyPR(data_omics_plus)
setwd(system.file("extdata/Genelists", package = "pwOmics"))
data_omics = identifyPWs(data_omics_plus)
data_omics = identifyTFs(data_omics)
data_omics = identifyRsofTFs(data_omics,
noTFs_inPW = 1, order_neighbors = 10)
data_omics = identifyPWTFTGs(data_omics)
statConsNet = staticConsensusNet(data_omics)
temp_correlations(statConsNet, timepointsprot = c(1,4,8,13,18,24),
timepointstrans = c(1,4,8,13,18,24), foldername = "ProtCons_",
trans_sign = system.file("extdata", "signif_single.csv", package = "pwOmics")
trans_sign_names = c("FC_1", "FC_2", "FC_3", "FC_4"),
phospho_sign = system.file("extdata", "mat_phospho.csv", package = "pwOmics")
phospho_sign_names = c("Rat1", "Rat2", "Rat3", "Rat4")) )

## End(Not run)

TFidentallgenes

57

TFidentallgenes

Identiﬁcation of upstream transcription factors for all genes.

Description

Identiﬁcation of upstream transcription factors for all genes.

Usage

TFidentallgenes(data_omics)

Arguments

data_omics

OmicsData object.

Value

data_omics OmicsData object with upstream TFs identiﬁed for all genes.

TFidenttps

Identiﬁcation of upstream transcription factors.

Description

Identiﬁcation of upstream transcription factors for the differentially expressed genes of the different
timepoints.

Usage

TFidenttps(data_omics)

Arguments

data_omics

OmicsData object.

Value

data_omics OmicsData object with upstream TFs of differentially expressed genes for separate
timepoints identiﬁed.

Index

∗Topic datasets

OmicsExampleData, 41

∗Topic manip

addFeedbackLoops, 4
clusterTimeProfiles, 4
consDynamicNet, 5
createBiopaxnew, 7
createIntIDs, 8
findSignalingAxes, 8
findxneighborsoverlap, 9
findxnextneighbors, 10
generate_DSSignalingBase, 10
genfullConsensusGraph, 11
genGenelists, 12
genGenelistssub, 12
genIntIDs, 13
get_matching_transcripts, 31
getAlias_Ensemble, 14
getAliasfromSTRINGIDs, 13
getBiopaxModel, 15
getbipartitegraphInfo, 16
getConsensusSTRINGIDs, 16
getDS_PWs, 17
getDS_TFs, 18
getDS_TGs, 19
getFCsplines, 20
getGenesIntersection, 20
getOmicsallGeneIDs, 21
getOmicsallProteinIDs, 22
getOmicsDataset, 23
getOmicsTimepoints, 23
getProteinIntersection, 24
getSTRING_graph, 25
getTFIntersection, 26
gettpIntersection, 27
getUS_PWs, 28
getUS_regulators, 29
getUS_TFs, 30
identifyPR, 32
identifyPWs, 33
identifyPWTFTGs, 34
identifyRsofTFs, 35
identifyTFs, 36

identPWsofTFs, 37
identRegulators, 37
identTFs, 38
identTFTGsinPWs, 38
infoConsensusGraph, 39
loadGenelists, 40
loadPWs, 40
plotConsDynNet, 41
plotConsensusGraph, 42
plotConsensusProfiles, 43
plotTimeProfileClusters, 44
predictFCvals, 45
preparePWinfo, 46
print.OmicsData, 46
PWidentallprots, 47
PWidentallprotssub, 47
PWidenttps, 48
readOmics, 48
readPhosphodata, 49
readPWdata, 50
readTFdata, 51
readTFtargets, 52
selectPWsofTFs, 53
staticConsensusNet, 53
SteinerTree_cons, 55
temp_correlations, 55
TFidentallgenes, 57
TFidenttps, 57

∗Topic package

pwIntOmics-package, 3

addFeedbackLoops, 4

clusterTimeProfiles, 4
consDynamicNet, 5
createBiopaxnew, 7
createIntIDs, 8

findSignalingAxes, 8
findxneighborsoverlap, 9
findxnextneighbors, 10

generate_DSSignalingBase, 10
genfullConsensusGraph, 11

58

59

pwIntOmics-package, 3

readOmics, 48
readPhosphodata, 49
readPWdata, 50
readTFdata, 51
readTFtargets, 52

selectPWsofTFs, 53
staticConsensusNet, 53
SteinerTree_cons, 55

temp_correlations, 55
TFidentallgenes, 57
TFidenttps, 57

INDEX

genGenelists, 12
genGenelistssub, 12
genIntIDs, 13
get_matching_transcripts, 31
getAlias_Ensemble, 14
getAliasfromSTRINGIDs, 13
getBiopaxModel, 15
getbipartitegraphInfo, 16
getConsensusSTRINGIDs, 16
getDS_PWs, 17
getDS_TFs, 18
getDS_TGs, 19
getFCsplines, 20
getGenesIntersection, 20
getOmicsallGeneIDs, 21
getOmicsallProteinIDs, 22
getOmicsDataset, 23
getOmicsTimepoints, 23
getProteinIntersection, 24
getSTRING_graph, 25
getTFIntersection, 26
gettpIntersection, 27
getUS_PWs, 28
getUS_regulators, 29
getUS_TFs, 30

identifyPR, 32
identifyPWs, 33
identifyPWTFTGs, 34
identifyRsofTFs, 35
identifyTFs, 36
identPWsofTFs, 37
identRegulators, 37
identTFs, 38
identTFTGsinPWs, 38
infoConsensusGraph, 39

loadGenelists, 40
loadPWs, 40

OmicsExampleData, 41

plotConsDynNet, 41
plotConsensusGraph, 42
plotConsensusProfiles, 43
plotTimeProfileClusters, 44
predictFCvals, 45
preparePWinfo, 46
print.OmicsData, 46
PWidentallprots, 47
PWidentallprotssub, 47
PWidenttps, 48
pwIntOmics (pwIntOmics-package), 3

