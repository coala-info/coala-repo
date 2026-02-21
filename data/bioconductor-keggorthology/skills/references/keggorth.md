keggorthology: the KEGG orthology as graph

VJ Carey

October 30, 2025

Contents

1 Introduction

2 KOgraph

3 Application to gene filtering

4 Infrastructure considerations

5 Session info

1

Introduction

1

1

3

4

4

KEGG is the Kyoto Encyclopedia of Genes and Genomes. An important product of
the KEGG group is a catalog of pathways. The KEGG Orthology (KO) organizes the
pathways into a conceptual hierarchy. This package encodes the hierarchy as a graph,
and provides some support for deriving sets of array feature identifiers from the hierarchy.

2 KOgraph

> library(keggorthology)
> library(graph)
> data(KOgraph)
> KOgraph

A graphNEL graph with directed edges
Number of Nodes = 358
Number of Edges = 357

> nodes(KOgraph)[1:5]

1

[1] "KO.Feb10root"
[3] "Carbohydrate Metabolism"
[5] "Citrate cycle (TCA cycle)"

"Metabolism"
"Glycolysis / Gluconeogenesis"

The upper component of the hierarchy is:

> adj(KOgraph, nodes(KOgraph)[1])

$KO.Feb10root
[1] "Metabolism"
[2] "Genetic Information Processing"
[3] "Environmental Information Processing"
[4] "Cellular Processes"
[5] "Organismal Systems"
[6] "Human Diseases"

Graph operations can be used to explore the orthology. For example, the context of

the PPAR signaling pathway is found as follows:

> library(RBGL)
> sp.between(KOgraph, nodes(KOgraph)[1], "PPAR signaling pathway")

$`KO.Feb10root:PPAR signaling pathway`
$`KO.Feb10root:PPAR signaling pathway`$length
[1] 3

$`KO.Feb10root:PPAR signaling pathway`$path_detail
[1] "KO.Feb10root"
[4] "PPAR signaling pathway"

"Organismal Systems"

"Endocrine System"

$`KO.Feb10root:PPAR signaling pathway`$length_detail
$`KO.Feb10root:PPAR signaling pathway`$length_detail[[1]]

KO.Feb10root->Organismal Systems
1
Organismal Systems->Endocrine System
1
Endocrine System->PPAR signaling pathway
1

Fixed-length identifiers are used to label pathways. These are available as the ’tag’

nodeData attribute.

> nodeData(KOgraph,,"tag")[1:5]

2

$KO.Feb10root
[1] "NONE"

$Metabolism
[1] "01100"

$`Carbohydrate Metabolism`
[1] "01101"

$`Glycolysis / Gluconeogenesis`
[1] "00010"

$`Citrate cycle (TCA cycle)`
[1] "00020"

The depth of each term is also available.

> nodeData(KOgraph,,"depth")[1:5]

$KO.Feb10root
[1] 0

$Metabolism
[1] 1

$`Carbohydrate Metabolism`
[1] 2

$`Glycolysis / Gluconeogenesis`
[1] 3

$`Citrate cycle (TCA cycle)`
[1] 3

3 Application to gene filtering

Several functions are available for retrieving relevant information from the orthology. If
you know a substring of the pathway name of interest, you can obtain the numerical
tag(s).

> getKOtags("insulin")

Insulin signaling pathway
"04910"

3

We can get probe set identifiers corresponding to a term. The default chip annotation

package used is hgu95av2.db.

> library(hgu95av2.db)
> mp = getKOprobes("Methionine")
> library(ALL)
> data(ALL)
> ALL[mp,]

ExpressionSet (storageMode: lockedEnvironment)
assayData: 30 features, 128 samples

element names: exprs

protocolData: none
phenoData

sampleNames: 01005 01010 ... LAL4 (128 total)
varLabels: cod diagnosis ... date last seen (21 total)
varMetadata: labelDescription

featureData: none
experimentData: use 'experimentData(object)'

pubMedIds: 14684422 16243790

Annotation: hgu95av2

4 Infrastructure considerations

Based on keggorthology read of KEGG orthology, March 2 2010. Specifically, we run
wget on ftp://ftp.genome.jp/pub/kegg/brite/ko/ko00001.keg and use parsing and
modeling code given in inst/keggHTML to generate a data frame respecting the hierar-
chy, and then keggDF2graph function in keggorthology package to construct the graph.

5 Session info

> sessionInfo()

R version 4.5.1 Patched (2025-08-23 r88802)
Platform: x86_64-pc-linux-gnu
Running under: Ubuntu 24.04.3 LTS

Matrix products: default
BLAS:
LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

LAPACK version 3.12.0

locale:

4

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

[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

time zone: America/New_York
tzcode source: system (glibc)

attached base packages:
[1] stats4
[8] base

stats

other attached packages:

graphics

grDevices utils

datasets

methods

[1] ALL_1.51.0
[4] graph_1.88.0
[7] AnnotationDbi_1.72.0 IRanges_2.44.0

RBGL_1.86.0
hgu95av2.db_3.13.0

[10] Biobase_2.70.0

BiocGenerics_0.56.0

keggorthology_2.62.0
org.Hs.eg.db_3.22.0
S4Vectors_0.48.0
generics_0.1.4

loaded via a namespace (and not attached):

[1] crayon_1.5.3
[5] rlang_1.1.6
[9] Biostrings_2.78.0 KEGGREST_1.50.0

vctrs_0.6.5
DBI_1.2.3

[13] memoise_2.0.1
[17] pkgconfig_2.0.3
[21] bit64_4.6.0-1

compiler_4.5.1
XVector_0.50.0
cachem_1.1.0

httr_1.4.7
png_0.1-8
Seqinfo_1.0.0
RSQLite_2.4.3
R6_2.6.1

cli_3.6.5
bit_4.6.0
fastmap_1.2.0
blob_1.2.4
tools_4.5.1

5

