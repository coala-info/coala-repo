# BioNAR: Biological Network Analysis in R

Colin Mclean, Anatoly Sorokin, T. I. Simpson, J. Douglas Armstrong and Oksana Sorokina

#### Edited: October, 2022; Compiled: November 20, 2025

#### Package

BioNAR 1.12.2

# Contents

* [1 Introduction](#introduction)
* [2 Overview of capabilities](#overview-of-capabilities)
* [3 Build the network](#build-the-network)
  + [3.1 Build a network from a given data frame](#build-a-network-from-a-given-data-frame)
  + [3.2 Use a predifined network](#use-a-predifined-network)
* [4 Annotate the nodes with node attributes](#annotate-the-nodes-with-node-attributes)
  + [4.1 Gene name](#gene-name)
  + [4.2 Diseases](#diseases)
  + [4.3 Schizopherina related synaptic gene functional annotation.](#schizopherina-related-synaptic-gene-functional-annotation.)
  + [4.4 Presynaptic functional annotation](#presynaptic-functional-annotation)
  + [4.5 Functional annotation with Gene Ontology (GO)](#functional-annotation-with-gene-ontology-go)
* [5 Estimate vertex centrality measures](#estimate-vertex-centrality-measures)
  + [5.1 Estimate centrality measures with values added as vertex attributes.](#estimate-centrality-measures-with-values-added-as-vertex-attributes.)
  + [5.2 Get vertex centralities as a matrix.](#get-vertex-centralities-as-a-matrix.)
  + [5.3 Get the centrality measures for random graph](#get-the-centrality-measures-for-random-graph)
  + [5.4 Power law fit](#power-law-fit)
  + [5.5 Get entropy rate](#get-entropy-rate)
  + [5.6 Get modularity. Normalised modularity.](#get-modularity.-normalised-modularity.)
* [6 Clustering](#clustering)
  + [6.0.1 Reclustering](#reclustering)
  + [6.1 Consensus matrix](#consensus-matrix)
  + [6.2 Cluster robustness](#cluster-robustness)
* [7 Bridgeness](#bridgeness)
  + [7.1 Bridgeness plot](#bridgeness-plot)
* [8 Disease/annotation pairs](#diseaseannotation-pairs)
  + [8.1 Cluster overrepresentation](#cluster-overrepresentation)
* [9 Session Info](#session-info)

# 1 Introduction

Proteomic studies typically generate a massive list of proteins being identified
within a specific tissue, compartment or cell type, often accompanied by
additional qualitative and/or quantitative information. Conversion of these data
into meaningful biological insight requires processing in several stages to
identify possible structural and/or functional dependencies.

One of the most popular ways of representing proteomic data is a protein-protein
interaction network, which allows to study its topology and how it correlates
with functional annotation mapped onto the network.

Many existing packages support different steps of the network building and
analysis process, but few packages combine network analysis methodology into a
single coherent pipeline.

We designed BioNAR to support a range of network analysis functionality,
complementing existing R packages and filling the methodological gaps necessary
to interrogate biomedical networks with respect to functional and disease
domains. For that purpose, we do not implement network reconstruction directly
(unless for synaptic networks), as other tools such as Cytoscape and Network
Analyst do this already. Rathher, we provide a detailed topologically-based
network analysis package, enabling the researcher to load networks generated
from the lab’s own meta-data, thus making the tool as widely applicable and
flexible as possible. We also provide a synaptic proteome network of our own for
validation.

# 2 Overview of capabilities

The BioNAR’s pipeline starts with importing the graph of interest (typically
built from nodes/proteins and edges/PPI interactions), and annotating its
vertices with available metadata [annotate\_vertex].

This is followed by the analysis of general network properties, such as
estimating a network’s “scale-free” property. For this we used the R “PoweRlaw”
package (version 0.50.0) (Gillespie, 2015) [FitDegree] and a network entropy
analysis
(Teschendorff et al, 2014) [getEntopy].

The package allows estimation of the main network vertex centrality measures:
degree, betweenness centrality, clustering coefficient, semilocal centrality,
mean shortest path, page rank, and standard deviation of the shortest path.
Values for centrality values measures can be added as vertex attributes
[calcCentrality] or returned as an R matrix [getCentralityMatrix],
depending on user’s preferences. Any other vertex meta-data, which can be
represented in matrix form, can also be stored as a vertex attribute.

To compare observed networks vertex centrality values against those of
equivalently sized but randomised graphs, we support three varying randomisation
models including G(n,p) Erdos-Renyi model , Barabasi-Albert model, and new
random graph from a given graph by randomly adding/removing edges
[getRandomGraphCentrality].

Additionally, to allow comparison of networks with different structures, we
implemented normalized modularity measure (Parter et al., 2007, Takemoto, 2012,
Takemoto, 2013, Takemoto and Borjigin, 2011)[normModularity].

BioNAR then proceeds to analyse the network’s community structure, which can be
performed via nine different clustering algorithms, simultaneously
[calcAllClustering] or with a chosen algorithm [calcClustering], community
membership being stored as a vertex attribute. In situations where the network
is dense and clusters are large and barely tractable, reclustering can be
applied [calcReclusterMatrix]. The obtained community structure can be
visualized with [layoutByCluster], and communiities further tested for
robustness [getRobustness] by comparing against randomised networks. As a
result, a consensus matrix can be estimated [makeConsensusMatrix], which is
needed for the next step -identifying the “influential” or “bridging” proteins
(Nepusz et al., 2008).

For this, we enabled a function for calculating the “bridgeness”
[getBridgeness] metric, which takes into account the probability a vertex to
belongs to different communities [getBridgeness], such that a vertex can be
ranked under assumption the higher its community membership the more influence
it has to the network topology and signaling (Han et al., 2004). “Bridgeness”
can be plotted against any other centrality measure, e.g. semi-local centrality
(plot is implemented), to enable useful indication of vertex (protein)
importance within the network topology.

To provide a perspective of the molecular signature of multiple diseases (or
biological functions) and how they might interact or overap at the network
level, we implemented a disease-disease overlap analysis by measuring the mean
shortest distance for each disease (⟨d⟩), using the shortest distance between
each gene-disease association (GDA) to its next nearest GDA neighbor
(Menche et al., 2015) [calcDiseasePairs], [runPermDisease] to be used for
obtaining significance values. In the case example of the presynaptic network
we found a set of neurological disorders to overlap with a high significance,
e.g. AD-PD, SCH-BP, ASD-ID, and, indeed, their comorbidity was confirmed by the
literature. Note that while developed for disease-disease correlation, the
analysis can be performed using any in-house vertex meta-data, including
biological function terms.

To study the distribution of the specific annotation(s) over a clustered graph
(typically disease of biologial process/function), we enabled overrepresentation
analysis [clusterORA], which helps identify the network communities enriched for
specific function or disease, or any other annotation.

The case study illustrates the package functionality for the protein-protein
interaction network for the presynaptic compartment of the synapse generated
from Synaptic proteome database (Sorokina et al., 2021) with Synaptome.db
package. The network has 1073 vertices and 6620 edges, step by step analysis is
shown below.

# 3 Build the network

BioNAR allows building a network from a data frame, where the rows correspond to
the edges of the graph; alternatively for our synaptic proteome exemple, a list
of vertices (genes) is needed, for which the information will be retrieved from
SynaptomeDB package.

## 3.1 Build a network from a given data frame

The command listed below builds a graph from provided data frame, simplifies the
graph (removing multiple edges and loops) and return its MCC (maximum connected
component)

```
file <- system.file("extdata", "PPI_Presynaptic.csv", package = "BioNAR")
tbl <- read.csv(file, sep="\t")
head(tbl)
#>   entA  entB We
#> 1  273  1759  1
#> 2  273  1785  1
#> 3  273 26052  1
#> 4  273   824  1
#> 5  273   161  1
#> 6  273  1020  1
gg <- buildNetwork(tbl)
summary(gg)
#> IGRAPH fa0a556 UN-- 1780 6620 --
#> + attr: name (v/c)
```

## 3.2 Use a predifined network

Any predefined network stored as a graph file (e.g. .gml, .graphml) can be
loaded for further analysis using Igraph’s functionality.

```
file <- system.file("extdata", "PPI_Presynaptic.gml", package = "BioNAR")
gg1 <- igraph::read_graph(file,format="gml")
summary(gg1)
#> IGRAPH cec902c UN-- 2169 8673 --
#> + attr: id (v/n), name (v/c), GeneName (v/c), UniProt (v/c), louvain
#> | (v/n), TopOntoOVG (v/c), TopOntoOVGHDOID (v/c)
```

# 4 Annotate the nodes with node attributes

As soon as the graph is loaded it can be annotated with any relevant
annotations, such as protein names [annotateGeneNames], functionality
[annotateGOont], disease associations [annotateTopOntoOVG], or any customized
annotation set [annotate\_vertex {BioNAR}]. We also provide two functional
annotations for synaptic graphs based on published synaptic functional studies
([annotateSCHanno], and [annotatePresynaptic].

## 4.1 Gene name

Adding gene names to vertices.

```
gg<-annotateGeneNames(gg)
summary(gg)
#> IGRAPH fa0a556 UN-- 1780 6620 --
#> + attr: name (v/c), GeneName (v/c)
head(V(gg))
#> + 6/1780 vertices, named, from fa0a556:
#> [1] 273   6455  1759  1785  26052 2923
head(V(gg)$GeneName)
#> [1] "AMPH"   "SH3GL1" "DNM1"   "DNM2"   "DNM3"   "PDIA3"
```

Some of the functions downstream requires non-empty GeneNames, so we have to
check that annotation assign values to all nodes:

```
any(is.na(V(gg)$GeneName))
#> [1] FALSE
```

The result of this command should be FALSE.

```
idx <- which(V(gg)$name == '80273')
V(gg)$GeneName[idx]<-'GRPEL1'
```

## 4.2 Diseases

Adding diseases associations to genes linked to Human Disease Ontology (HDO)
terms extracted from the package
(topOnto.HDO.db)[<https://github.com/hxin/topOnto.HDO.db>].

```
afile<-system.file("extdata", "flatfile_human_gene2HDO.csv", package = "BioNAR")
dis <- read.table(afile,sep="\t",skip=1,header=FALSE,strip.white=TRUE,quote="")
gg <- annotateTopOntoOVG(gg, dis)
summary(gg)
#> IGRAPH fa0a556 UN-- 1780 6620 --
#> + attr: name (v/c), GeneName (v/c), TopOnto_OVG (v/c),
#> | TopOnto_OVG_HDO_ID (v/c)
```

## 4.3 Schizopherina related synaptic gene functional annotation.

Adding the annotation curated from an external file: Schizophrenia annotaion
curatedcurated from Lips et al., (2012) doi:10.1038/mp.2011.117.

```
sfile<-system.file("extdata", "SCH_flatfile.csv", package = "BioNAR")
shan<- read.table(sfile,sep="\t",skip=1,header=FALSE,strip.white=TRUE,quote="")
sgg<-annotateSCHanno(gg,shan)
summary(sgg)
#> IGRAPH fa0a556 UN-- 1780 6620 --
#> + attr: name (v/c), GeneName (v/c), TopOnto_OVG (v/c),
#> | TopOnto_OVG_HDO_ID (v/c), Schanno (v/c)
```

## 4.4 Presynaptic functional annotation

Adding the presynaptic genes functional annotation derived from
Boyken at al. (2013) doi:10.1016/j.neuron.2013.02.027.

```
sfile<-system.file("extdata", "PresynAn.csv", package = "BioNAR")
pres <- read.csv(sfile,skip=1,header=FALSE,strip.white=TRUE,quote="")
sgg <- annotatePresynaptic(gg, pres)
summary(sgg)
```

## 4.5 Functional annotation with Gene Ontology (GO)

GO annotation is specifically supported with the function [annotateGOont]:

```
ggGO <- annotateGOont(gg)
```

```
#however, functionality from GO: BP, MF,CC can be added

sfile<-system.file("extdata", "flatfile.go.BP.csv", package = "BioNAR")
goBP <- read.table(sfile,sep="\t",skip=1,header=FALSE,strip.white=TRUE,quote="")
sgg <- annotateGoBP(gg, goBP)
summary(sgg)
#> IGRAPH fa0a556 UN-- 1780 6620 --
#> + attr: name (v/c), GeneName (v/c), TopOnto_OVG (v/c),
#> | TopOnto_OVG_HDO_ID (v/c), GO_BP_ID (v/c), GO_BP (v/c)

sfile<-system.file("extdata", "flatfile.go.MF.csv", package = "BioNAR")
goMF <- read.table(sfile,sep="\t",skip=1,header=FALSE,strip.white=TRUE,quote="")
sgg <- annotateGoMF(gg, goMF)
summary(sgg)
#> IGRAPH fa0a556 UN-- 1780 6620 --
#> + attr: name (v/c), GeneName (v/c), TopOnto_OVG (v/c),
#> | TopOnto_OVG_HDO_ID (v/c), GO_MF_ID (v/c), GO_MF (v/c)

sfile<-system.file("extdata", "flatfile.go.CC.csv", package = "BioNAR")
goCC <- read.table(sfile,sep="\t",skip=1,header=FALSE,strip.white=TRUE,quote="")
sgg <- annotateGoCC(gg, goCC)
summary(sgg)
#> IGRAPH fa0a556 UN-- 1780 6620 --
#> + attr: name (v/c), GeneName (v/c), TopOnto_OVG (v/c),
#> | TopOnto_OVG_HDO_ID (v/c), GO_CC_ID (v/c), GO_CC (v/c)
```

# 5 Estimate vertex centrality measures

## 5.1 Estimate centrality measures with values added as vertex attributes.

BioNAR supports centrality measures as following:
\* DEG - degree,
\* BET - betweenness,
\* CC - clustering coefficient,
\* SL - semilocal centrality,
\* mnSP - mean shortest path,
\* PR - page rank,
\* sdSP - standard deviation of the shortest path.
These are saved as vertex atrtributes.

```
gg <- calcCentrality(gg)
summary(gg)
#> IGRAPH fa0a556 UN-- 1780 6620 --
#> + attr: name (v/c), GeneName (v/c), TopOnto_OVG (v/c),
#> | TopOnto_OVG_HDO_ID (v/c), DEG (v/n), BET (v/n), CC (v/n), SL (v/n),
#> | mnSP (v/n), PR (v/n), sdSP (v/c)
```

## 5.2 Get vertex centralities as a matrix.

Instead of saving entrality centrality values on the graph, e.g. to provide
different names for the vertex centrality attributes, they can be obtained in a
matrix form:

```
mc <- getCentralityMatrix(gg)
head(mc)
#>      ID DEG        BET         CC     SL  mnSP           PR  sdSP
#> 1   273  12   833.2335 0.10606061  44656 3.424 0.0007855514 0.707
#> 2  6455  22  5444.7102 0.08225108 170211 2.955 0.0013374528 0.683
#> 3  1759  16  1744.9317 0.21666667 150771 3.062 0.0009619764 0.687
#> 4  1785  27 10994.5087 0.07122507 218717 2.890 0.0016436995 0.701
#> 5 26052   6   291.1377 0.13333333  55060 3.503 0.0004051298 0.743
#> 6  2923   7  1225.7092 0.09523810  55104 3.391 0.0005312439 0.758
```

## 5.3 Get the centrality measures for random graph

Sometimes one needs to compare the graph properties of the the properties of an
the observed network to randomised networks of a similar size. The BioNAR
command below provides three ways of generating randomization, randomised
networks given an observed network including: G(n,p) Erdos-Renyi model,
Barabasi-Albert model and new random graph from a given graph by
randomly adding/removing edges.

```
{r}
ggrm <- getRandomGraphCentrality(sgg, type = c("cgnp"))
head(ggrm)
```

## 5.4 Power law fit

To examine a network’s underlying structure (i.e. not random), one can test a
network’s degree distribution for evidence of scale-free structure and compare
this against randomised network models. For this we used the R
“PoweRlaw” package (version 0.50.0) (Gillespie, 2015). For the case study, i.e.
our presynaptic PPI network, we found evidence for disassortative mixing
(Newman, 2002), i.e. a preference for high-degree genes to attach to low-degree
gene(presynaptic: -0.16).

```
pFit <- fitDegree( as.vector(igraph::degree(graph=gg)),threads=1,Nsim=5,
                    plot=TRUE,WIDTH=2480, HEIGHT=2480)
```

![](data:image/png;base64...)

## 5.5 Get entropy rate

Evidence for scale-free structure can also be tested by performing a
perturbation analysis of each of the network’s vertices. In this analysis each
protein is being perturbed through over-expression (red) and under-expression
(green), with the global graph entropy rate (SR) after each proteins
perturbation being plotted against the log of the proteins degree, as shown at
the plot below.
In our case study of the presynaptic PPI network we observe a bi-modal response,
between gene over-expression and degree, and opposing bi-phasic response
relative to over/under-expression between global entropy rate and degree. This
type of bi-modal, bi-phasic behaviour has been observed only in networks with
scale-free or approximate scale-free topology (Teschendorff et al, 2014).

```
ent <- getEntropyRate(gg)
ent
#> $maxSr
#> [1] 3.822764
#>
#> $SRo
#> [1] 2.639026
SRprime <- getEntropy(gg, maxSr = NULL)
head(SRprime)
#>   ENTREZ.ID GENE.NAME DEGREE        UP      DOWN
#> 1       273      AMPH     12 0.6877989 0.6903153
#> 2      6455    SH3GL1     22 0.6884665 0.6899068
#> 3      1759      DNM1     16 0.6892206 0.6899577
#> 4      1785      DNM2     27 0.6896328 0.6895775
#> 5     26052      DNM3      6 0.6891432 0.6902969
#> 6      2923     PDIA3      7 0.6888827 0.6903132
plotEntropy(SRprime, subTIT = "Entropy", SRo = ent$SRo, maxSr = ent$maxSr)
```

![](data:image/png;base64...)

## 5.6 Get modularity. Normalised modularity.

Normalised modularity (Qm) allows the comparison of networks with varying
structure. Qm based on the previous studies by Parter et al., 2007, Takemoto,
2012, Takemoto, 2013, Takemoto and Borjigin, 2011, which was defined as:

\[Qm = \frac{Q\_{real}-Q\_{rand}}{Q\_{max}-Q\_{rand}}\]

Where \(Q\_{real}\) is the network modularity of a real-world signaling network
and, \(Q\_{rand}\) is the average network modularity value obtained from 10,000
randomized networks constructed from its real-world network.
\(Q\_{max}\) was estimated as: \[Q\_{max}=1 − \frac{1}{M}\], where \(M\) is the
number of modules in the real network.

Randomized networks were generated from a real-world network using the
edge-rewiring algorithm (Maslov and Sneppen, 2002).

```
nm<-normModularity(gg,alg='louvain')
nm
#> [1] 0.02025978
```

# 6 Clustering

Clustering, or community detection, in networks has been well studied in the
field of statistical physics with particular attention to methods developed for
social science networks. The underlying assumption(s) of what makes a
community in social science, translates remarkably well to what we think of as a
community (sub-complex, module or cluster) in PPI networks. The possible
algorithms of choice implemented in BioNAR are:
\* “lec”(‘Leading-Eigenvector, Newman, 2006),
\* “wt”(Walktrap, Pons & Latapy, 2006),
\* “fc”(Fast-Greedy Community’ algorithm, Clauset et al., 2004),
\* “infomap” (InfoMAP, Rosvall et al., 2007; Rosvall et al., 2010),
\* “louvain” (Louvain, Blondel et al., 2008),
\* “sgG1”, “sgG2”, “sgG5”(SpinGlass, Reichardt & Bornholdt).
For each algorithm of interest the community membership can be obtained with`'calcMembership` command.
All algorithm implementations, apart from Spectral were performed using the
publicly available R package igraph (Csardi & Nepusz, 2006) (R version 3.4.2,
igraph version 1.1.2). Parameters used in the fc, lec, sg, wt and lourvain
algorithms were chosen as to maximise the measure Modularity
(Newman & Girvan, 2004); infomap seeks the optimal community structure in the
data by maximising the objective function called the Minimum Description
Length (Rissanen, 1978; Grwald et al., 2005)

```
# choose one algorithm from the list
alg = "louvain"
mem <- calcMembership(gg, alg)
pander(head(mem))
```

| names | membership |
| --- | --- |
| 273 | C00000|1 |
| 6455 | C00000|1 |
| 1759 | C00000|1 |
| 1785 | C00000|1 |
| 26052 | C00000|1 |
| 2923 | C00000|2 |

Due to internal random initialisation consecutive invocation of the same
algorithm could produce slightly different community structures:

```
mem2 <- calcMembership(gg, alg)
idx<-match(mem$names,mem2$names)
idnx<-which(as.character(mem$membership)!=as.character(mem2$membership[idx]))
pander(head(cbind(mem[idnx,],mem2[idx[idnx],])))
```

|  | names | membership | names | membership |
| --- | --- | --- | --- | --- |
| **10** | 29993 | C00000|1 | 29993 | C00000|4 |
| **12** | 22895 | C00000|4 | 22895 | C00000|5 |
| **13** | 6548 | C00000|5 | 6548 | C00000|6 |
| **14** | 3303 | C00000|6 | 3303 | C00000|4 |
| **15** | 3265 | C00000|5 | 3265 | C00000|6 |
| **16** | 5898 | C00000|7 | 5898 | C00000|6 |

To avoid inconsistency in downstream analysis we provide two additional
functions `calcClustering` and `calcAllClustering` that use calcMembership to
calculate community memberships and store them within the graph vertices
attributes named after the algorithm. They also calculate modularity values and
store them as graph vertex attributes named after the clustering algorithm.
The difference between `calcClustering` and `calcAllClustering` is that
`calcAllClustering`allows to calculate memberships for all clustering algorithms
simultaneously (may take time), and store them as graph vertices attributes,
while `calcClustering`command will work for a specific algorithm.

```
gg <- calcClustering(gg, alg)
summary(gg)
#> IGRAPH fa0a556 UN-- 1780 6620 --
#> + attr: louvain (g/n), name (v/c), GeneName (v/c), TopOnto_OVG (v/c),
#> | TopOnto_OVG_HDO_ID (v/c), DEG (v/n), BET (v/n), CC (v/n), SL (v/n),
#> | mnSP (v/n), PR (v/n), sdSP (v/c), louvain (v/c)
```

Comminity membership data could be obtained from the graph vertex attribute:

```
mem.df<-data.frame(names=V(gg)$name,membership=factor(V(gg)$louvain))
```

To compare different clustering algorithms,a summary matrix can be calculated
with the following properties:
1. maximum Modularity obtained (mod),
2. number of detected communities (C),
3. the number of communities with size (Cn1) equal to 1,
4. the number of communities >= 100 (Cn100),
5. the fraction of edges lying between communities (mu),
6. the size of the smallest community (Min. C),
7. the size of the largest community (Max. C),
8. the average ( Mean C), median (Median C),
9. first quartile (1st Qu. C), and
10. third quartile (3rd Qu. C) of the community size.

```
ggc <- calcAllClustering(gg)
```

```
m<-clusteringSummary(ggc,att=c('lec','wt','fc',
                                'infomap','louvain',
                                'sgG1','sgG2','sgG5'))
pander(m)
```

Table continues below

|  | N | mod | C | Cn1 | Cn100 | mu | Min. C | 1st Qu. C |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| **lec** | 2169 | 0.2029 | 2 | 0 | 2 | 0.2163 | 552 | 818.2 |
| **wt** | 2169 | 0.3602 | 231 | 116 | 4 | 0.4874 | 1 | 1 |
| **fc** | 2169 | 0.4382 | 26 | 0 | 5 | 0.3682 | 3 | 3.25 |
| **infomap** | 2169 | 0.4179 | 159 | 0 | 2 | 0.5449 | 2 | 5 |
| **louvain** | 2169 | 0.4656 | 15 | 0 | 9 | 0.4313 | 22 | 77.5 |
| **sgG1** | 2169 | 0.4755 | 34 | 0 | 7 | 0.4017 | 2 | 4 |
| **sgG2** | 2169 | 0.4596 | 44 | 0 | 6 | 0.4948 | 3 | 16.25 |
| **sgG5** | 2169 | 0.392 | 97 | 0 | 0 | 0.5909 | 2 | 13 |

|  | Median C | Mean C | 3rd Qu. C | Max. C |
| --- | --- | --- | --- | --- |
| **lec** | 1084 | 1084 | 1351 | 1617 |
| **wt** | 1 | 9.39 | 3 | 594 |
| **fc** | 8 | 83.42 | 31 | 475 |
| **infomap** | 9 | 13.64 | 13 | 181 |
| **louvain** | 152 | 144.6 | 205.5 | 290 |
| **sgG1** | 7.5 | 63.79 | 73.75 | 361 |
| **sgG2** | 44 | 49.3 | 69.25 | 163 |
| **sgG5** | 20 | 22.36 | 28 | 82 |

It is often useful to be able to visualize clusters of the graph. The simplest
way to do this is to color each cluster uniquely and plot the graph:

```
palette <- distinctColorPalette(max(as.numeric(mem.df$membership)))
plot(gg,vertex.size=3,layout=layout_nicely,
        vertex.label=NA,
        vertex.color=palette[as.numeric(mem.df$membership)],
        edge.color='grey95')
legend('topright',legend=names(table(mem.df$membership)),
        col=palette,pch=19,ncol = 2)
```

![](data:image/png;base64...)

On the plot we can see some distinctive clusters but most verices are
indistinguishable within the central part of the plot. So we could layout
graph clusterwise:

```
lay<-layoutByCluster(gg,mem.df,layout = layout_nicely)
plot(gg,vertex.size=3,layout=lay,
        vertex.label=NA,
        vertex.color=palette[as.numeric(mem.df$membership)],
        edge.color='grey95')
legend('topright',legend=names(table(mem.df$membership)),
        col=palette,pch=19,ncol = 2)
```

![](data:image/png;base64...)

It is also possible to visualize the interaction between communities:

```
idx<-match(V(gg)$name,mem.df$names)
cgg<-getCommunityGraph(gg,mem.df$membership[idx])
D0 = unname(degree(cgg))
plot(cgg, vertex.size=sqrt(V(cgg)$size), vertex.cex = 0.8,
vertex.color=round(log(D0))+1,layout=layout_with_kk,margin=0)
```

![](data:image/png;base64...)

### 6.0.1 Reclustering

Reclustering a clustered graph using the same, or different, clustering
algorithm:

```
remem<-calcReclusterMatrix(gg,mem.df,alg,10)
head(remem)
#>   names membership  recluster
#> 1   273   C00000|1 C00000|1|1
#> 2  6455   C00000|1 C00000|1|1
#> 3  1759   C00000|1 C00000|1|1
#> 4  1785   C00000|1 C00000|1|1
#> 5 26052   C00000|1 C00000|1|2
#> 6  2923   C00000|2 C00000|2|1
```

And we can apply second order clustering layout:

```
lay<-layoutByRecluster(gg,remem,layout_nicely)
plot(gg,vertex.size=3,layout=lay,
        vertex.label=NA,
        vertex.color=palette[as.numeric(mem.df$membership)],
        edge.color='grey95')
legend('topright',legend=names(table(mem.df$membership)),
        col=palette,pch=19,ncol = 2)
```

![](data:image/png;base64...)

## 6.1 Consensus matrix

To assess the robustness of obtained clusters, a randomization study can be
performed, which applies the same clustering algorithm to N perturbed networks.
The clustering results are returned as a consensus matrix where each matrix
elements is assigned the frequency with which a pair of nodes vertices is found
in the same cluster.

Where ‘alg’ gives the name of the clustering algorithm, ‘type’ the sampling
scheme (1 sample edges, and 2 sample verices) used, ‘mask’ the percentage of
edges or vertices to mask, and ‘reclust’ whether reclustering should be
performed on the community set found, ‘Cnmin’ minimum cluster size and
‘Cnmax’ the maximum cluster size above which reclustering will be
preformed (if reClust=TRUE).

```
#Build consensus matrix for louvain clustering
conmat <- makeConsensusMatrix(gg, N=5,
                                alg = alg, type = 2,
                                mask = 10,reclust = FALSE,
                                Cnmax = 10)
```

For the sake of timing we use only five randomisation rounds, for the real
analysis you should use at least 500.

##Consensus matrix value distribution

Consensus matrix values can be visualised in the following way:

```
steps <- 100
Fn  <- ecdf(conmat[lower.tri(conmat)])
X<-seq(0,1,length.out=steps+1)
cdf<-Fn(X)
dt<-data.frame(cons=X,cdf=cdf)
ggplot(dt,aes(x=cons,y=cdf))+geom_line()+
        theme(
        axis.title.x=element_text(face="bold",size=rel(2.5)),
        axis.title.y=element_text(face="bold",size=rel(2.5)),
        legend.title=element_text(face="bold",size=rel(1.5)),
        legend.text=element_text(face="bold",size=rel(1.5)),
        legend.key=element_blank())+
    theme(panel.grid.major = element_line(colour="grey40",linewidth=0.2),
            panel.grid.minor = element_line(colour="grey40",linewidth=0.1),
            panel.background = element_rect(fill="white"),
            panel.border = element_rect(linetype="solid",fill=NA))
```

![](data:image/png;base64...)

## 6.2 Cluster robustness

Cluster robustness assesses the robustness of obtained clusters and can help
evaluate the “goodness” of a chosen clustering algorithm.

```
clrob<-getRobustness(gg, alg = alg, conmat)
pander(clrob)
```

| alg | C | Cn | Crob | CrobScaled |
| --- | --- | --- | --- | --- |
| louvain | 1 | 218 | 0.1039 | 1 |
| louvain | 2 | 54 | 0.08273 | 0.2147 |
| louvain | 3 | 85 | 0.0988 | 0.8099 |
| louvain | 4 | 40 | 0.08951 | 0.4657 |
| louvain | 5 | 176 | 0.08919 | 0.4541 |
| louvain | 6 | 34 | 0.09168 | 0.5462 |
| louvain | 7 | 29 | 0.09659 | 0.728 |
| louvain | 8 | 204 | 0.08998 | 0.483 |
| louvain | 9 | 281 | 0.09077 | 0.5124 |
| louvain | 10 | 107 | 0.09118 | 0.5276 |
| louvain | 11 | 181 | 0.0902 | 0.4913 |
| louvain | 12 | 73 | 0.0975 | 0.7616 |
| louvain | 13 | 146 | 0.08194 | 0.1857 |
| louvain | 14 | 71 | 0.07693 | 0 |
| louvain | 15 | 81 | 0.09603 | 0.7073 |

# 7 Bridgeness

Bridging proteins are known to interact with many neighbours simultaneously,
organise function inside the communities they belong to, but also
affect/influence other communities in the network (Nepusz et al., 2008).
Bridgeness can be estimated from the consensus clustering matrix estimated
above and vertex degree to calculate the vertex’s community membership, i.e.
the probability a specific vertex belongs to every community obtained by a given
clustering algorithm.

The Bridgeness measure lies between 0 - implying a vertex clearly belongs in a
single community, and 1 - implying a vertex forms a ‘global bridge’ across every
community with the same strength.

```
br<-getBridgeness(gg,alg = alg,conmat)
pander(head(br))
```

| ID | GENE.NAME | BRIDGENESS.louvain |
| --- | --- | --- |
| 273 | AMPH | 0.04006 |
| 6455 | SH3GL1 | 0.4845 |
| 1759 | DNM1 | 0 |
| 1785 | DNM2 | 0.399 |
| 26052 | DNM3 | 0.1475 |
| 2923 | PDIA3 | 0.5507 |

```
gg<-calcBridgeness(gg,alg = alg,conmat)
vertex_attr_names(gg)
#>  [1] "name"               "GeneName"           "TopOnto_OVG"
#>  [4] "TopOnto_OVG_HDO_ID" "DEG"                "BET"
#>  [7] "CC"                 "SL"                 "mnSP"
#> [10] "PR"                 "sdSP"               "louvain"
#> [13] "BRIDGENESS.louvain"
```

## 7.1 Bridgeness plot

Semi-local centrality measure (Chen et al., 2011) also lies between 0 and 1
indicating whether protein is important globally or locally. By plotting
Bridgeness against semi-local centrality we can categorises the influence
each protein found in our network has on the overall network structure:
\* Region 1, proteins having a ‘global’ rather than ‘local’ influence in the
network (also been called bottle-neck bridges, connector or kinless hubs
(0<Sl<0.5; 0.5<Br<1).
\* Region 2, proteins having ‘global’ and ‘local’ influence (0.5<Sl<1, 0.5<Br<1).
\* Region 3, proteins centred within the community they belong to, but also
communicating with a few other specific communities (0<Sl<0.5; 0.1<Br<0.5).
\* Region 4, proteins with ‘local’ impact , primarily within one or two
communities (local or party hubs, 0.5<Sl<1, 0<Br<0.5).

```
g<-plotBridgeness(gg,alg = alg,
               VIPs=c('8495','22999','8927','8573',
                      '26059','8497','27445','8499'),
               Xatt='SL',
               Xlab = "Semilocal Centrality (SL)",
               Ylab = "Bridgeness (B)",
               bsize = 3,
               spsize =7,
               MainDivSize = 0.8,
               xmin = 0,
               xmax = 1,
               ymin = 0,
               ymax = 1,
               baseColor="royalblue2",
               SPColor="royalblue2")
g
```

![](data:image/png;base64...)

#Interactive view of bridgeness plot

```
library(plotly)
g<-plotBridgeness(gg,alg = alg,
               VIPs=c('8495','22999','8927','8573',
                      '26059','8497','27445','8499'),
               Xatt='SL',
               Xlab = "Semilocal Centrality (SL)",
               Ylab = "Bridgeness (B)",
               bsize = 1,
               spsize =2,
               MainDivSize = 0.8,
               xmin = 0,
               xmax = 1,
               ymin = 0,
               ymax = 1,
               baseColor="royalblue2",
               SPColor="royalblue2")
ggplotly(g)
```

# 8 Disease/annotation pairs

Given that Disease associated genes are connected within the graph, the common
question is to check whether the networks for two different diseases are
overlapping, which may indicate the common molecular mechanisms. Same is valid
for any pair of annotations, e.g. one would ask if two different biological
functions are related.

To address this question, we utilise the algorithm from Menche et al, which
estimates the minimal shortest paths between two distinct annotations and
compares this to the randomly annotated graph.

Below example shows the estimation of disease separation for the following
diseases: DOID:10652 (Alzheimer’s\_disease), (bipolar\_disorder),
DOID:12849 (autistic\_disorder), DOID:1826 (epilepsy). Command
`calcDiseasePairs` quickly estimates the two annotation separation on
the graph and compares it with one randomly reannotated graph. This could be
used for initial guess of the relationships between the annotations.

To assess the significance of the obtained separation values the command `runPermDisease` should be used, where the user can specify the number of
permutations. TExecuting this command, which will take time depending of the
number of permutations, returns table with of p-values, adjusted p-values,
q-values and Bonferroni test for each disease-disease pair.

```
p <- calcDiseasePairs(
    gg,
    name = "TopOnto_OVG_HDO_ID",
    diseases = c("DOID:10652","DOID:3312"),
    permute = "r"
)
pander(p$disease_separation)
```

|  | DOID:10652 | DOID:3312 |
| --- | --- | --- |
| **DOID:10652** | 0 | -0.1503 |
| **DOID:3312** | NA | 0 |

```
r <- runPermDisease(
    gg,
    name = "TopOnto_OVG_HDO_ID",
    diseases = c("DOID:10652","DOID:3312"),
    Nperm = 100,
    alpha = c(0.05, 0.01, 0.001)
)

pander(r$Disease_overlap_sig)
```

Table continues below

| HDO.ID.A | N.A | HDO.ID.B | N.B | sAB | Separated | Overlap | zScore |
| --- | --- | --- | --- | --- | --- | --- | --- |
| DOID:10652 | 259 | DOID:10652 | 259 | 0 | . | . | 0 |
| DOID:10652 | 259 | DOID:3312 | 127 | -0.2495 | . | YES | -2.385 |
| DOID:3312 | 127 | DOID:3312 | 127 | 0 | . | . | 0 |

| pvalue | Separation/Overlap.than.chance | Bonferroni | p.adjusted | q-value |
| --- | --- | --- | --- | --- |
| 1 | larger | . | 1 | 1 |
| 0.01706 | Smaller | . | 0.09381 | 0.05117 |
| 1 | larger | . | 1 | 1 |

## 8.1 Cluster overrepresentation

To identify the clusters with overrepresented function or disease we introduced
the function which calculates the overrepesentation (enrichment for specified
annotation). Based on R package fgsea.

```
ora <- clusterORA(gg, alg, name = 'TopOnto_OVG_HDO_ID', vid = "name",
                  alpha = 0.1, col = COLLAPSE)
```

# 9 Session Info

Platform

* **version**: R version 4.5.2 (2025-10-31)
* **os**: Ubuntu 24.04.3 LTS
* **system**: x86\_64, linux-gnu
* **ui**: X11
* **language**: (EN)
* **collate**: C
* **ctype**: en\_US.UTF-8
* **tz**: America/New\_York
* **date**: 2025-11-20
* **pandoc**: 2.7.3 @ /usr/bin/ (via rmarkdown)
* **quarto**: 1.7.32 @ /usr/local/bin/quarto

Packages

|  | ondiskversion | loadedversion | date | source |
| --- | --- | --- | --- | --- |
| AnnotationDbi | 1.72.0 | 1.72.0 | 2025-11-20 | Bioconductor 3.22 (R 4.5.2) |
| backports | 1.5.0 | 1.5.0 | 2024-05-23 | CRAN (R 4.5.2) |
| base64enc | 0.1.3 | 0.1-3 | 2015-07-28 | CRAN (R 4.5.2) |
| Biobase | 2.70.0 | 2.70.0 | 2025-11-20 | Bioconductor 3.22 (R 4.5.2) |
| BiocGenerics | 0.56.0 | 0.56.0 | 2025-11-20 | Bioconductor 3.22 (R 4.5.2) |
| BiocManager | 1.30.27 | 1.30.27 | 2025-11-14 | CRAN (R 4.5.2) |
| BiocParallel | 1.44.0 | 1.44.0 | 2025-11-20 | Bioconductor 3.22 (R 4.5.2) |
| BiocStyle | 2.38.0 | 2.38.0 | 2025-11-20 | Bioconductor 3.22 (R 4.5.2) |
| BioNAR | 1.12.2 | 1.12.2 | 2025-11-20 | Bioconductor 3.22 (R 4.5.2) |
| Biostrings | 2.78.0 | 2.78.0 | 2025-11-20 | Bioconductor 3.22 (R 4.5.2) |
| bit | 4.6.0 | 4.6.0 | 2025-03-06 | CRAN (R 4.5.2) |
| bit64 | 4.6.0.1 | 4.6.0-1 | 2025-01-16 | CRAN (R 4.5.2) |
| blob | 1.2.4 | 1.2.4 | 2023-03-17 | CRAN (R 4.5.2) |
| bookdown | 0.45 | 0.45 | 2025-10-03 | CRAN (R 4.5.2) |
| bslib | 0.9.0 | 0.9.0 | 2025-01-30 | CRAN (R 4.5.2) |
| cachem | 1.1.0 | 1.1.0 | 2024-05-16 | CRAN (R 4.5.2) |
| checkmate | 2.3.3 | 2.3.3 | 2025-08-18 | CRAN (R 4.5.2) |
| cli | 3.6.5 | 3.6.5 | 2025-04-23 | CRAN (R 4.5.2) |
| cluster | 2.1.8.1 | 2.1.8.1 | 2025-03-12 | CRAN (R 4.5.2) |
| codetools | 0.2.20 | 0.2-20 | 2024-03-31 | CRAN (R 4.5.2) |
| colorspace | 2.1.2 | 2.1-2 | 2025-09-22 | CRAN (R 4.5.2) |
| cowplot | 1.2.0 | 1.2.0 | 2025-07-07 | CRAN (R 4.5.2) |
| crayon | 1.5.3 | 1.5.3 | 2024-06-20 | CRAN (R 4.5.2) |
| crosstalk | 1.2.2 | 1.2.2 | 2025-08-26 | CRAN (R 4.5.2) |
| curl | 7.0.0 | 7.0.0 | 2025-08-19 | CRAN (R 4.5.2) |
| data.table | 1.17.8 | 1.17.8 | 2025-07-10 | CRAN (R 4.5.2) |
| DBI | 1.2.3 | 1.2.3 | 2024-06-02 | CRAN (R 4.5.2) |
| devtools | 2.4.6 | 2.4.6 | 2025-10-03 | CRAN (R 4.5.2) |
| dichromat | 2.0.0.1 | 2.0-0.1 | 2022-05-02 | CRAN (R 4.5.2) |
| digest | 0.6.39 | 0.6.39 | 2025-11-19 | CRAN (R 4.5.2) |
| doParallel | 1.0.17 | 1.0.17 | 2022-02-07 | CRAN (R 4.5.2) |
| dplyr | 1.1.4 | 1.1.4 | 2023-11-17 | CRAN (R 4.5.2) |
| dynamicTreeCut | 1.63.1 | 1.63-1 | 2016-03-11 | CRAN (R 4.5.2) |
| ellipsis | 0.3.2 | 0.3.2 | 2021-04-29 | CRAN (R 4.5.2) |
| evaluate | 1.0.5 | 1.0.5 | 2025-08-27 | CRAN (R 4.5.2) |
| farver | 2.1.2 | 2.1.2 | 2024-05-13 | CRAN (R 4.5.2) |
| fastcluster | 1.3.0 | 1.3.0 | 2025-05-07 | CRAN (R 4.5.2) |
| fastmap | 1.2.0 | 1.2.0 | 2024-05-15 | CRAN (R 4.5.2) |
| fastmatch | 1.1.6 | 1.1-6 | 2024-12-23 | CRAN (R 4.5.2) |
| fgsea | 1.36.0 | 1.36.0 | 2025-11-20 | Bioconductor 3.22 (R 4.5.2) |
| foreach | 1.5.2 | 1.5.2 | 2022-02-02 | CRAN (R 4.5.2) |
| foreign | 0.8.90 | 0.8-90 | 2025-03-31 | CRAN (R 4.5.2) |
| Formula | 1.2.5 | 1.2-5 | 2023-02-24 | CRAN (R 4.5.2) |
| fs | 1.6.6 | 1.6.6 | 2025-04-12 | CRAN (R 4.5.2) |
| generics | 0.1.4 | 0.1.4 | 2025-05-09 | CRAN (R 4.5.2) |
| ggplot2 | 4.0.1 | 4.0.1 | 2025-11-14 | CRAN (R 4.5.2) |
| ggrepel | 0.9.6 | 0.9.6 | 2024-09-07 | CRAN (R 4.5.2) |
| glue | 1.8.0 | 1.8.0 | 2024-09-30 | CRAN (R 4.5.2) |
| GO.db | 3.22.0 | 3.22.0 | 2025-11-17 | Bioconductor |
| graph | 1.88.0 | 1.88.0 | 2025-11-20 | Bioconductor 3.22 (R 4.5.2) |
| gridExtra | 2.3 | 2.3 | 2017-09-09 | CRAN (R 4.5.2) |
| gtable | 0.3.6 | 0.3.6 | 2024-10-25 | CRAN (R 4.5.2) |
| Hmisc | 5.2.4 | 5.2-4 | 2025-10-05 | CRAN (R 4.5.2) |
| htmlTable | 2.4.3 | 2.4.3 | 2024-07-21 | CRAN (R 4.5.2) |
| htmltools | 0.5.8.1 | 0.5.8.1 | 2024-04-04 | CRAN (R 4.5.2) |
| htmlwidgets | 1.6.4 | 1.6.4 | 2023-12-06 | CRAN (R 4.5.2) |
| httr | 1.4.7 | 1.4.7 | 2023-08-15 | CRAN (R 4.5.2) |
| igraph | 2.2.1 | 2.2.1 | 2025-10-27 | CRAN (R 4.5.2) |
| impute | 1.84.0 | 1.84.0 | 2025-11-20 | Bioconductor 3.22 (R 4.5.2) |
| IRanges | 2.44.0 | 2.44.0 | 2025-11-20 | Bioconductor 3.22 (R 4.5.2) |
| iterators | 1.0.14 | 1.0.14 | 2022-02-05 | CRAN (R 4.5.2) |
| jquerylib | 0.1.4 | 0.1.4 | 2021-04-26 | CRAN (R 4.5.2) |
| jsonlite | 2.0.0 | 2.0.0 | 2025-03-27 | CRAN (R 4.5.2) |
| KEGGREST | 1.50.0 | 1.50.0 | 2025-11-20 | Bioconductor 3.22 (R 4.5.2) |
| knitr | 1.50 | 1.50 | 2025-03-16 | CRAN (R 4.5.2) |
| labeling | 0.4.3 | 0.4.3 | 2023-08-29 | CRAN (R 4.5.2) |
| latex2exp | 0.9.6 | 0.9.6 | 2022-11-28 | CRAN (R 4.5.2) |
| lattice | 0.22.7 | 0.22-7 | 2025-04-02 | CRAN (R 4.5.2) |
| lazyeval | 0.2.2 | 0.2.2 | 2019-03-15 | CRAN (R 4.5.2) |
| lifecycle | 1.0.4 | 1.0.4 | 2023-11-07 | CRAN (R 4.5.2) |
| magick | 2.9.0 | 2.9.0 | 2025-09-08 | CRAN (R 4.5.2) |
| magrittr | 2.0.4 | 2.0.4 | 2025-09-12 | CRAN (R 4.5.2) |
| Matrix | 1.7.4 | 1.7-4 | 2025-08-28 | CRAN (R 4.5.2) |
| matrixStats | 1.5.0 | 1.5.0 | 2025-01-07 | CRAN (R 4.5.2) |
| memoise | 2.0.1 | 2.0.1 | 2021-11-26 | CRAN (R 4.5.2) |
| minpack.lm | 1.2.4 | 1.2-4 | 2023-09-11 | CRAN (R 4.5.2) |
| nnet | 7.3.20 | 7.3-20 | 2025-01-01 | CRAN (R 4.5.2) |
| org.Hs.eg.db | 3.22.0 | 3.22.0 | 2025-11-17 | Bioconductor |
| pander | 0.6.6 | 0.6.6 | 2025-03-01 | CRAN (R 4.5.2) |
| pillar | 1.11.1 | 1.11.1 | 2025-09-17 | CRAN (R 4.5.2) |
| pkgbuild | 1.4.8 | 1.4.8 | 2025-05-26 | CRAN (R 4.5.2) |
| pkgconfig | 2.0.3 | 2.0.3 | 2019-09-22 | CRAN (R 4.5.2) |
| pkgload | 1.4.1 | 1.4.1 | 2025-09-23 | CRAN (R 4.5.2) |
| plotly | 4.11.0 | 4.11.0 | 2025-06-19 | CRAN (R 4.5.2) |
| png | 0.1.8 | 0.1-8 | 2022-11-29 | CRAN (R 4.5.2) |
| poweRlaw | 1.0.0 | 1.0.0 | 2025-02-03 | CRAN (R 4.5.2) |
| pracma | 2.4.6 | 2.4.6 | 2025-10-22 | CRAN (R 4.5.2) |
| preprocessCore | 1.72.0 | 1.72.0 | 2025-11-20 | Bioconductor 3.22 (R 4.5.2) |
| purrr | 1.2.0 | 1.2.0 | 2025-11-04 | CRAN (R 4.5.2) |
| R6 | 2.6.1 | 2.6.1 | 2025-02-15 | CRAN (R 4.5.2) |
| randomcoloR | 1.1.0.1 | 1.1.0.1 | 2019-11-24 | CRAN (R 4.5.2) |
| rbibutils | 2.4 | 2.4 | 2025-11-07 | CRAN (R 4.5.2) |
| RColorBrewer | 1.1.3 | 1.1-3 | 2022-04-03 | CRAN (R 4.5.2) |
| Rcpp | 1.1.0 | 1.1.0 | 2025-07-02 | CRAN (R 4.5.2) |
| Rdpack | 2.6.4 | 2.6.4 | 2025-04-09 | CRAN (R 4.5.2) |
| remotes | 2.5.0 | 2.5.0 | 2024-03-17 | CRAN (R 4.5.2) |
| rlang | 1.1.6 | 1.1.6 | 2025-04-11 | CRAN (R 4.5.2) |
| rmarkdown | 2.30 | 2.30 | 2025-09-28 | CRAN (R 4.5.2) |
| rpart | 4.1.24 | 4.1.24 | 2025-01-07 | CRAN (R 4.5.2) |
| RSpectra | 0.16.2 | 0.16-2 | 2024-07-18 | CRAN (R 4.5.2) |
| rSpectral | 1.0.0.10 | 1.0.0.10 | 2023-01-18 | CRAN (R 4.5.2) |
| RSQLite | 2.4.4 | 2.4.4 | 2025-11-10 | CRAN (R 4.5.2) |
| rstudioapi | 0.17.1 | 0.17.1 | 2024-10-22 | CRAN (R 4.5.2) |
| Rtsne | 0.17 | 0.17 | 2023-12-07 | CRAN (R 4.5.2) |
| S4Vectors | 0.48.0 | 0.48.0 | 2025-11-20 | Bioconductor 3.22 (R 4.5.2) |
| S7 | 0.2.1 | 0.2.1 | 2025-11-14 | CRAN (R 4.5.2) |
| sass | 0.4.10 | 0.4.10 | 2025-04-11 | CRAN (R 4.5.2) |
| scales | 1.4.0 | 1.4.0 | 2025-04-24 | CRAN (R 4.5.2) |
| Seqinfo | 1.0.0 | 1.0.0 | 2025-11-20 | Bioconductor 3.22 (R 4.5.2) |
| sessioninfo | 1.2.3 | 1.2.3 | 2025-02-05 | CRAN (R 4.5.2) |
| stringi | 1.8.7 | 1.8.7 | 2025-03-27 | CRAN (R 4.5.2) |
| stringr | 1.6.0 | 1.6.0 | 2025-11-04 | CRAN (R 4.5.2) |
| survival | 3.8.3 | 3.8-3 | 2024-12-17 | CRAN (R 4.5.2) |
| tibble | 3.3.0 | 3.3.0 | 2025-06-08 | CRAN (R 4.5.2) |
| tidyr | 1.3.1 | 1.3.1 | 2024-01-24 | CRAN (R 4.5.2) |
| tidyselect | 1.2.1 | 1.2.1 | 2024-03-11 | CRAN (R 4.5.2) |
| tinytex | 0.58 | 0.58 | 2025-11-19 | CRAN (R 4.5.2) |
| usethis | 3.2.1 | 3.2.1 | 2025-09-06 | CRAN (R 4.5.2) |
| V8 | 8.0.1 | 8.0.1 | 2025-10-10 | CRAN (R 4.5.2) |
| vctrs | 0.6.5 | 0.6.5 | 2023-12-01 | CRAN (R 4.5.2) |
| viridis | 0.6.5 | 0.6.5 | 2024-01-29 | CRAN (R 4.5.2) |
| viridisLite | 0.4.2 | 0.4.2 | 2023-05-02 | CRAN (R 4.5.2) |
| WGCNA | 1.73 | 1.73 | 2024-09-18 | CRAN (R 4.5.2) |
| withr | 3.0.2 | 3.0.2 | 2024-10-28 | CRAN (R 4.5.2) |
| xfun | 0.54 | 0.54 | 2025-10-30 | CRAN (R 4.5.2) |
| XVector | 0.50.0 | 0.50.0 | 2025-11-20 | Bioconductor 3.22 (R 4.5.2) |
| yaml | 2.3.10 | 2.3.10 | 2024-07-26 | CRAN (R 4.5.2) |