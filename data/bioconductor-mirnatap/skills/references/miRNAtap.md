miRNAtap example use

Maciej Pajak, Ian Simpson

October 30, 2025

Contents

1 Introduction

2 Installation

3 Workflow

4 Session Information

References

2

2

3

5

6

1

1

Introduction

miRNAtap package is designed to facilitate implementation of workflows requiring
miRNA prediction. Aggregation of commonly used prediction algorithm outputs
in a way that improves on performance of every single one of them on their own
when compared against experimentally derived targets. microRNA (miRNA)
is a 18-22nt long single strand that binds with RISC (RNA induced silencing
complex) and targets mRNAs effectively reducing their translation rates.

Targets are aggregated from 5 most commonly cited prediction algorithms:
DIANA (Maragkakis et al., 2011), Miranda (Enright et al., 2003), PicTar (Lall
et al., 2006), TargetScan (Friedman et al., 2009), and miRDB (Wong and Wang,
2015).

Programmatic access to sources of data is crucial when streamlining the
workflow of our analysis, this way we can run similar analysis for multiple input
miRNAs or any other parameters. Not only does it allow us to obtain predictions
from multiple sources straight into R but also through aggregation of sources it
improves the quality of predictions.

Finally, although direct predictions from all sources are only available for
Homo sapiens and Mus musculus, this package includes an algorithm that allows
to translate target genes to other speices (currently only Rattus norvegicus)
using homology information where direct targets are not available.

2

Installation

This section briefly describes the necessary steps to get miRNAtap running on
your system. We assume that the user has the R program (see the R project
at http://www.r-project.org) already installed and is familiar with it. You will
need to have R 3.2.0 or later to be able to install and run miRNAtap. The miR-
NAtap package is available from the Bioconductor repository at http://www.bioconductor.org
To be able to install the package one needs first to install the core Bioconductor
packages. If you have already installed Bioconductor packages on your system
then you can skip the two lines below.

> if (!requireNamespace("BiocManager", quietly=TRUE))
+
> BiocManager::install()

install.packages("BiocManager")

Once the core Bioconductor packages are installed, we can install the miR-

NAtap and accompanying database miRNAtap.db package by

install.packages("BiocManager")

> if (!requireNamespace("BiocManager", quietly=TRUE))
+
> BiocManager::install("miRNAtap")
> BiocManager::install("miRNAtap.db")

2

3 Workflow

This section explains how miRNAtap package can be integrated in the workflow
aimed at predicting which processes can be regulated by a given microRNA.

In this example workflow we’ll use miRNAtap as well as another Bioconductor
package topGO together with Gene Ontology (GO) annotations. In case we don’t
have topGO or GO annotations on our machine we need to install them first:

install.packages("BiocManager")

> if (!requireNamespace("BiocManager", quietly=TRUE))
+
> BiocManager::install("topGO")
> BiocManager::install("org.Hs.eg.db")

Then, let’s load the required libraries

> library(miRNAtap)
> library(topGO)
> library(org.Hs.eg.db)

Now we can start the analysis. First, we will obtain predicted targets for

human miRNA miR-10b

> mir = 'miR-10b'
> predictions = getPredictedTargets(mir, species = 'hsa',
+

method = 'geom', min_src = 2)

Let’s inspect the top of the prediction list.

> head(predictions)

627
79741
6095
348980
51365
7022

source_1 source_2 source_3 source_4 source_5 rank_product rank_final
1
NA
2
2
3
NA
4
NA
5
12
6
149

1.416281
2.000000
2.058173
3.535534
3.766392
4.058725

1.0
8.0
73.5
20.0
3.0
5.0

10.0
NA
2.5
2.5
53.0
17.5

103
NA
5
NA
NA
88

1
NA
5
NA
27
3

We are using geometric mean aggregation method as it proves to perform
best when tested against experimental data from MirBase (Griffiths-Jones et al.,
2008).

We can compare it to the top of the list of the output of mimumum method:

> predictions_min = getPredictedTargets(mir, species = 'hsa',
+
> head(predictions_min)

method = 'min', min_src = 2)

3

source_1 source_2 source_3 source_4 source_5 rank_product rank_final
2.0
NA
2.0
NA
2.0
1
5.5
NA
5.5
NA
5.5
2

1.0
282.0
99.5
NA
2.0
8.0

10
183
107
NA
42
NA

103
1
NA
2
NA
NA

1
NA
NA
106
NA
NA

1
1
1
2
2
2

627
8897
79042
7182
10739
79741

Where predictions for rat genes are not available we can obtain predictions
for mouse genes and translate them into rat genes through homology. The oper-
ation happens automatically if we specify species as rno (for Rattus norvegicus)

> predictions_rat = getPredictedTargets(mir, species = 'rno',
+

method = 'geom', min_src = 2)

Now we can use the ranked results as input to GO enrichment analysis. For

that we will use our initial prediction for human miR-10b

> rankedGenes = predictions[,'rank_product']
> selection = function(x) TRUE
> # we do not want to impose a cut off, instead we are using rank information
> allGO2genes = annFUN.org(whichOnto='BP', feasibleGenes = NULL,
+
> GOdata = new('topGOdata', ontology = 'BP', allGenes = rankedGenes,
+
+

annot = annFUN.GO2genes, GO2genes = allGO2genes,
geneSel = selection, nodeSize=10)

mapping="org.Hs.eg.db", ID = "entrez")

In order to make use of the rank information we will use Kolomonogorov
Smirnov (K-S) test instead of Fisher exact test which is based only on counts.

> results.ks = runTest(GOdata, algorithm = "classic", statistic = "ks")
> results.ks

Description:
Ontology: BP
'classic' algorithm with the 'ks' test
537 GO terms scored: 5 terms with p < 0.01
Annotation data:

Annotated genes: 349
Significant genes: 349
Min. no. of genes annotated to a GO: 10
Nontrivial nodes: 537

We can view the most enriched GO terms (and potentially feed them to

further steps in our workflow)

> allRes = GenTable(GOdata, KS = results.ks, orderBy = "KS", topNodes = 20)
> allRes[,c('GO.ID','Term','KS')]

4

Term

GO.ID

KS
GO:0044087 regulation of cellular component biogene... 0.0017
1
GO:0065007
biological regulation 0.0024
2
regulation of biological process 0.0038
GO:0050789
3
muscle cell differentiation 0.0049
GO:0042692
4
GO:0050794
regulation of cellular process 0.0077
5
GO:0051146
striated muscle cell differentiation 0.0117
6
GO:0044089 positive regulation of cellular componen... 0.0144
7
GO:0043085 positive regulation of catalytic activit... 0.0145
8
9
mRNA processing 0.0170
GO:0006397
10 GO:0043254 regulation of protein-containing complex... 0.0180
regulation of catalytic activity 0.0208
11 GO:0050790
12 GO:0036211
protein modification process 0.0216
13 GO:0060255 regulation of macromolecule metabolic pr... 0.0267
14 GO:0006468
protein phosphorylation 0.0312
15 GO:0045893 positive regulation of DNA-templated tra... 0.0342
16 GO:1902680 positive regulation of RNA biosynthetic ... 0.0342
regulation of gene expression 0.0384
17 GO:0010468
18 GO:0044093 positive regulation of molecular functio... 0.0429
19 GO:0008380
RNA splicing 0.0463
cell-cell signaling 0.0469
20 GO:0007267

For more details about GO analysis refer to topGO package vignette (Alexa

and Rahnenfuhrer, 2010).

Finally, we can use our predictions in a similar way for pathway enrich-
ment analysis based on KEGG (Kanehisa and Goto, 2000), for example using
Bioconductor’s KEGGprofile (Zhao, 2012).

4 Session Information

• R version 4.5.1 Patched (2025-08-23 r88802), x86_64-pc-linux-gnu

• Locale: LC_CTYPE=en_US.UTF-8, LC_NUMERIC=C, LC_TIME=en_GB,

LC_COLLATE=C, LC_MONETARY=en_US.UTF-8, LC_MESSAGES=en_US.UTF-8,
LC_PAPER=en_US.UTF-8, LC_NAME=C, LC_ADDRESS=C, LC_TELEPHONE=C,
LC_MEASUREMENT=en_US.UTF-8, LC_IDENTIFICATION=C

• Time zone: America/New_York

• TZcode source: system (glibc)

• Running under: Ubuntu 24.04.3 LTS

• Matrix products: default

• BLAS: /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

5

• LAPACK:

/usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0

• Base packages: base, datasets, grDevices, graphics, methods, stats,

stats4, utils

• Other packages: AnnotationDbi 1.72.0, Biobase 2.70.0,

BiocGenerics 0.56.0, GO.db 3.22.0, IRanges 2.44.0, S4Vectors 0.48.0,
SparseM 1.84-2, generics 0.1.4, graph 1.88.0, miRNAtap 1.44.0,
miRNAtap.db 0.99.10, org.Hs.eg.db 3.22.0, topGO 2.62.0

• Loaded via a namespace (and not attached): Biostrings 2.78.0,

DBI 1.2.3, KEGGREST 1.50.0, R6 2.6.1, RSQLite 2.4.3, Rcpp 1.1.0,
Seqinfo 1.0.0, XVector 0.50.0, bit 4.6.0, bit64 4.6.0-1, blob 1.2.4,
cachem 1.1.0, chron 2.3-62, cli 3.6.5, compiler 4.5.1, crayon 1.5.3,
fastmap 1.2.0, glue 1.8.0, grid 4.5.1, gsubfn 0.7, httr 1.4.7, lattice 0.22-7,
lifecycle 1.0.4, magrittr 2.0.4, matrixStats 1.5.0, memoise 2.0.1,
pkgconfig 2.0.3, plyr 1.8.9, png 0.1-8, proto 1.0.0, rlang 1.1.6,
sqldf 0.4-11, stringi 1.8.7, stringr 1.5.2, tools 4.5.1, vctrs 0.6.5

References

Alexa, A. and Rahnenfuhrer, J. (2010). topGO: topGO: Enrichment analysis

for Gene Ontology. R package version 2.16.0.

Enright, A. J., John, B., Gaul, U., Tuschl, T., Sander, C., and Marks, D. S.

(2003). MicroRNA targets in Drosophila. Genome biology, 5(1):R1.

Friedman, R. C., Farh, K. K.-H., Burge, C. B., and Bartel, D. P. (2009). Most
mammalian mRNAs are conserved targets of microRNAs. Genome research,
19(1):92–105.

Griffiths-Jones, S., Saini, H. K., van Dongen, S., and Enright, A. J. (2008).
miRBase: tools for microRNA genomics. Nucleic acids research, 36(Database
issue):D154–8.

Kanehisa, M. and Goto, S. (2000). KEGG: kyoto encyclopedia of genes and

genomes. Nucleic acids research, 28(1):27–30.

Lall, S., Grün, D., Krek, A., Chen, K., Wang, Y.-L., Dewey, C. N., Sood,
P., Colombo, T., Bray, N., Macmenamin, P., Kao, H.-L., Gunsalus, K. C.,
Pachter, L., Piano, F., and Rajewsky, N. (2006). A genome-wide map of
conserved microRNA targets in C. elegans. Current biology : CB, 16(5):460–
71.

Maragkakis, M., Vergoulis, T., Alexiou, P., Reczko, M., Plomaritou, K., Gousis,
M., Kourtis, K., Koziris, N., Dalamagas, T., and Hatzigeorgiou, A. G. (2011).

6

DIANA-microT Web server upgrade supports Fly and Worm miRNA target
prediction and bibliographic miRNA to disease association. Nucleic acids
research, 39(Web Server issue):W145–8.

Wong, N. and Wang, X. (2015). miRDB: An online resource for microRNA
target prediction and functional annotations. Nucleic Acids Research,
43(D1):D146–D152.

Zhao, S. (2012). KEGGprofile: An annotation and visualization package for
multi-types and multi-groups expression data in KEGG pathway. R package
version 1.6.1.

7

