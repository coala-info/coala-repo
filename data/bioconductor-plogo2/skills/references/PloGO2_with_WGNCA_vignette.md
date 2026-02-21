Integration of PloGO2 and WGCNA for proteomics

J.Wu and D.Pascovici

April 28, 2020

Abstract

This vignette describes a tailored workﬂow of using WGCNA for protein network analy-
sis. A publicly available protein ratio dataset was used to demonstrate the major workﬂow
steps and its outputs Wu et al. (2016). It also demonstrates that the WGCNA output can
be seamlessly input into PloGO2 and further characterised functionally using PloGO2.

1 WGCNA workﬂow for proteomics

WGCNA Langfelder and Horvath (2008) is a popular correlation network functional analysis
tool which can be used to generate a potentially large number of related data subsets via
clustering. The WGCNA was proposed and mostly used for genomic data correlation analysis.
We tailored the WGCNA workﬂow to be more suitable for proteomic data analysis, and include
this wrapper in the PloGO2 package for completeness.

Our in-house tailored WGNCA workﬂow starts from a protein abundance or ratio dataset.
It is assumed that the data has been properly normalised. The protein expression will be log-
transformed before the analysis starts. Firstly, a soft power was selected for constructing the
weighted correlation matrix by using the approximate scale-free network criteria. A scale free
network is one where the topology is dominated by a few highly connected nodes, which link
the rest of the less connected nodes to the system; it is assumed that most biologically relevant
networks should satisfy this property. By raising the correlation to the selected soft power,
the correlation network becomes scale-free. The cut-oﬀ of the parameter RsquaredCut was set
as 0.85. Signed networks, instead of unsigned for gene network analysis, are constructed using
the soft power selected. Then TOM (topology overlap metrics) distance was calculated from
the network adjacency. Hierarchical clustering was performed based on the TOM distance. A
set of clusters were obtained by using the dynamic tree cutting method with the parameter
value of minClusterSize as 20. An automatic cluster merging function was invoked to merge
the closely correlated clusters from the dynamic tree cutting.

The script for an example WGNCA workﬂow can be found in the script folder of this

package. An example of the input of WGCNA is as follows.

> library(PloGO2)
> library(xtable)
> path <- system.file("files", package = "PloGO2")
> print(xtable(read.csv(file.path(path,"rice.csv"))[1:6,c(1:2,5:7)]))

1

Accession Uniprot
350295 Q0DI31
537402 Q94JF2
5777627 Q7XSU8
6002788 Q9LWY6
9828445 Q6EUD7
11990470 Q9FRU0

1
2
3
4
5
6

R1.X127 N.126 R2X127 N.126 R1.X127 C.126
0.94
1.19
1.02
0.98
0.98
0.73

1.01
0.99
1.02
0.93
0.98
1.01

0.96
1.14
1.01
0.91
0.95
0.95

The included WGNCA workﬂow can be executed using the following command

> source(file.path(system.file("script", package = "PloGO2"), "WGCNA_proteomics.R"))

A number of plots will be produced to visualise the overall weighted correlation network,

cluster proﬁles and eigenprotein boxplots. Some examples are as follows.

Fig 1 shows the cluster dendrogram for the initial and merged clusters.

Figure 1: Cluster dendrogram

Fig 2 shows the boxplots for the top 6 hub proteins for the red cluster.

2

hub proteins - red.png

Figure 2: Boxplot for hub proteins - red

Fig 3 shows the cluster proﬁle for all clusters.

Figure 3: Cluster proﬁle

3

The output of the WGCNA analysis can be summarised in a multi-tab Excel ﬁle which
include the overall data and proteins in every cluster ordered by their kME (fuzzy module
membership) values. Hub proteins will be easily identiﬁed The proteins with the highest kMEs
can be viewed as the hub proteins of that cluster. Therefore, the hub proteins are those on the
top of the list. An example of the result for one cluster, ”red”, is as follows.

> print(xtable(readWorkbook("ResultsWGCNA.xlsx", "red")[1:6,c(1:2,5:7,23:24)]))

Accession Uniprot

R1.X127 N.126 R2X127 N.126 R1.X127 C.126 moduleColors

1
2
3
4
5
6

115453785.00 Q53RM0
115488938.00 Q2QP54
42407940.00 Q6ZJ16
125549171.00 Q7XQQ7
115445929.00 Q6ZG77
125583193.00 A3A9Y5

1.17
1.10
1.08
1.02
1.06
1.22

1.10
1.02
1.08
1.08
1.02
1.23

0.93
0.96
0.93
0.95
0.99
0.92

red
red
red
red
red
red

kMEred
0.96
0.95
0.95
0.94
0.94
0.93

2 Using input from WGCNA workﬂow

The output of the WGCNA can be directly fed into PloGO2 to perform the KEGG pathway
analysis, with pre-processed KEGG pathway DB and optional abundance ﬁle (refer to the
PloGO2 vignette for details).

> annot.folder <- genAnnotationFiles("ResultsWGCNA.xlsx", DB.name = file.path(path, "pathwayDB.csv"))
> res <- PloPathway(reference="AllData", filesPath=annot.folder,
+
+

data.file.name = file.path(path, "Abundance_data.csv"),
datafile.ignore.cols = 1)

References

Peter Langfelder and Steve Horvath. Wgcna: an r package for weighted correlation network

analysis. BMC bioinformatics, 9(1):559, 2008.

Yunqi Wu, Mehdi Mirzaei, Dana Pascovici, Joel M Chick, Brian J Atwell, and Paul A Haynes.
Quantitative proteomic analysis of two diﬀerent rice varieties reveals that drought tolerance
is correlated with reduced abundance of photosynthetic machinery and increased abundance
of clpd1 protease. Journal of proteomics, 143:73–82, 2016.

4

