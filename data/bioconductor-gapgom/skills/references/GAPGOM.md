# An Introduction to GAPGOM

#### by Finn Drabløs, Rezvan Ehsani and Casper Peters

#### 2019-05-02

* [Citation](#citation)
* [Introduction](#introduction)
* [Installation](#installation)
* [Expression data interfaces](#expression-data-interfaces)
  + [ID support](#id-support)
  + [Expression data (FANTOM5)](#expression-data-fantom5)
  + [Manually specifying an `ExpressionSet`](#manually-specifying-an-expressionset)
* [LNCRNA2GOA (expression similarity)](#lncrna2goa-expression-similarity)
  + [Background](#background)
    - [Sobolev metric](#sobolev-metric)
    - [Fisher metric](#fisher-metric)
  + [Example](#example)
    - [Scores + Enrichment](#scores-enrichment)
    - [Only scores](#only-scores)
    - [Original dataset](#original-dataset)
* [TopoICSim](#topoicsim)
  + [Background](#background-1)
  + [Examples](#examples)
    - [Custom genes](#custom-genes)
    - [Other notes.](#other-notes.)
* [Parrallel processing and big data](#parrallel-processing-and-big-data)
* [Performance and benchmarks](#performance-and-benchmarks)
* [Contact and support](#contact-and-support)
* [SessionInfo](#sessioninfo)
* [References](#references)

## Citation

When using GAPGOM, please cite the following;

* Ehsani R, Drablos F: **TopoICSim: a new semantic similarity measure based on gene ontology.** *BMC Bioinformatics* 2016, **17**(1):296. DOI: <https://doi.org/10.1186/s12859-016-1160-0>
* Ehsani R, Drablos F: **Measures of co-expression for improved function prediction of long non-coding RNAs**. *BMC Bioinformatics* 2018. Accepted.

## Introduction

GAPGOM (novel **G**ene **A**nnotation **P**rediction and other **GO** **M**etrics) is an R package with tools and algorithms for estimating correlation of gene expression, enriched terms in gene sets, and semantic distance between sets of gene ontology (GO) terms. This package has been made for predicting the annotation of un-annotated gene(s), in particular with respect to GO, and testing such predictions. The prediction is done by comparing expression patterns between a query gene and a library of annotated genes, and annotate the query gene by enriched terms from the set of genes with similar expression pattern (often described as “guilt by association”).

For correlation of gene expression, GAPGOM is introducing LNCRNA2GOA which is a novel tool. The main interface for expression data is currently the [Fantom5 data](http://fantom.gsc.riken.jp/5/), using Bioconductor’s [`ExpressionSet`](https://www.bioconductor.org/packages/3.7/bioc/vignettes/Biobase/inst/doc/ExpressionSetIntroduction.pdf) class.

For semantic similarity of GO terms (in particular for testing predictions), the package is using [TopoICSim](https://doi.org/10.1186/s12859-016-1160-0). It makes use of GO data via the [GOSemSim](https://bioconductor.org/packages/release/bioc/html/GOSemSim.html) package with the `godata()` interface.

GO consists of three main Ontologies; molecular function (MF), biological process (BP) and cellular component (CC).

## Installation

Before installing, the package has quite a few dependencies in both cran and Bioconductor. You can run the following block of code (preferably line-by-line because of prompts) to install these and the package itself.

```
### NEEDED (depends, suggests)

if (!requireNamespace("BiocManager"))
install.packages("BiocManager")
BiocManager::install("GAPGOM", dependencies = TRUE)
```

## Expression data interfaces

### ID support

As of v0.2.7 and up, all `AnnotationDbi` IDs should be supported. However, we recommend usage of `EntrezID`s because this is the most widely supported ID in this and other packages. If you find issues with respect to ID support, please notify this issue on the package repository. If you want to (or have to) convert IDs manually, the [`BiomaRt`](https://www.bioconductor.org/packages/release/bioc/html/biomaRt.html) package is recommended. However, translating IDs to other types is lossy and does not always translate well.

### Expression data (FANTOM5)

As of right now, the package has one main dataset interface for expression data; The Fantom5 dataset. For other datasets, an `ExpressionSet` has to be manually made as described later in this chapter. There are a few helper functions to make this data usable. The Fantom5 dataset is only available for the human and mouse genome. Examples of helper functions/interfaces can be found below;

```
# download the fantom5 data file
fantom_file <- fantom_download("./", organism = "mouse",
noprompt = TRUE) # saves filename
# load the file (use fantom_file variable if doing all at once)
ft5 <- fantom_load_raw("./mm9.cage_peak_phase1and2combined_tpm_ann.osc.txt",
verbose = TRUE)
# remove first two rows from fantom5 data (these are seperate statistis,
# we just need expressionvalues)
ft5$df <- ft5$df[3:nrow(ft5$df),]

# convert the raw fantom table to an ExpressionSet
expset <- fantom_to_expset(ft5, verbose = TRUE)
```

**Do note that all standard columns are necessary when converting to an `ExpressionSet` in this way!**

### Manually specifying an `ExpressionSet`

Because loading expression data right now is a bit limited, this paragraph will describe how to convert expression data to an `ExpressionSet` object. We will give an example with randomly selected expression values and IDs. In some cases if you want something specific, defining it this way can actually be better (More control over extra data that goes into the object/better interoperability between packages).

Minimal requirement for an `ExpressionSet`;

* expression values
* Unique IDs of a certain type. AnnotationDbi keys are the only IDs that are supported right now.

**Each row of expression values should have corresponding IDs, with the ID-type as its column name.**

Random expression value generation;

```
# select x random IDs
x_entries <- 1000

go_data <- GAPGOM::set_go_data("human", "BP", computeIC = FALSE)
#> Loading required package: org.Hs.eg.db
#> Loading required package: AnnotationDbi
#> Loading required package: stats4
#> Loading required package: BiocGenerics
#> Loading required package: parallel
#>
#> Attaching package: 'BiocGenerics'
#> The following objects are masked from 'package:parallel':
#>
#>     clusterApply, clusterApplyLB, clusterCall, clusterEvalQ,
#>     clusterExport, clusterMap, parApply, parCapply, parLapply,
#>     parLapplyLB, parRapply, parSapply, parSapplyLB
#> The following objects are masked from 'package:stats':
#>
#>     IQR, mad, sd, var, xtabs
#> The following objects are masked from 'package:base':
#>
#>     Filter, Find, Map, Position, Reduce, anyDuplicated, append,
#>     as.data.frame, basename, cbind, colnames, dirname, do.call,
#>     duplicated, eval, evalq, get, grep, grepl, intersect,
#>     is.unsorted, lapply, mapply, match, mget, order, paste, pmax,
#>     pmax.int, pmin, pmin.int, rank, rbind, rownames, sapply,
#>     setdiff, sort, table, tapply, union, unique, unsplit, which,
#>     which.max, which.min
#> Loading required package: Biobase
#> Welcome to Bioconductor
#>
#>     Vignettes contain introductory material; view with
#>     'browseVignettes()'. To cite Bioconductor, see
#>     'citation("Biobase")', and for packages 'citation("pkgname")'.
#> Loading required package: IRanges
#> Loading required package: S4Vectors
#>
#> Attaching package: 'S4Vectors'
#> The following object is masked from 'package:base':
#>
#>     expand.grid
#> preparing gene to GO mapping data...
random_ids <- unique(sample(go_data@geneAnno$ENTREZID, x_entries)) # and only keep
# uniques

# make general dataframe.
expressions <- data.frame(random_ids)
colnames(expressions) <- "ENTREZID"
expressions$ID
#> NULL

# n expression values depending on the amount of unique IDs that are present
expressionvalues <- abs(rnorm(length(random_ids)*6))*x_entries
expressions[,2:7] <- expressionvalues
head(expressions)
#>   ENTREZID        V2         V3        V4        V5        V6        V7
#> 1     2047  977.9075  781.63778 1019.6952 2641.1646 1506.5371  635.7274
#> 2    65125 1365.2751   65.30562  336.7877 1849.5753  922.1089  592.2731
#> 3     6531 1567.2573 1051.28188   43.9102  634.3948  372.7208  363.4411
#> 4     6657  643.4315 1257.73833  456.5400  842.1561  349.1980 1000.6480
#> 5      358 1044.5030 2607.72778  135.9698  867.7302   18.4410 1179.3717
#> 6     8829  394.1429  961.68728  237.4838 1235.0147 1674.7981  697.2044
```

Converting the expression dataframe to an ExpressionSet;

```
expression_matrix <- as.matrix(expressions[,2:ncol(expressions)])
rownames(expression_matrix) <- expressions$ENTREZID
featuredat <- as.data.frame(expressions$ENTREZID) # And everything else besides expressionvalues (preferably you don't even need to include the IDs themselves here!)
rownames(featuredat) <- expressions$ENTREZID # because they will be the rownames anyway.
expset <- ExpressionSet(expression_matrix,
featureData = new("AnnotatedDataFrame",
data=featuredat))

# To see how it is structured;
head(expset)
#> ExpressionSet (storageMode: lockedEnvironment)
#> assayData: 1 features, 6 samples
#>   element names: exprs
#> protocolData: none
#> phenoData: none
#> featureData
#>   featureNames: 2047
#>   fvarLabels: expressions$ENTREZID
#>   fvarMetadata: labelDescription
#> experimentData: use 'experimentData(object)'
#> Annotation:
head(assayData(expset)[["exprs"]]) # where expressionvalues are stored.
#>              V2         V3        V4        V5        V6        V7
#> 2047   977.9075  781.63778 1019.6952 2641.1646 1506.5371  635.7274
#> 65125 1365.2751   65.30562  336.7877 1849.5753  922.1089  592.2731
#> 6531  1567.2573 1051.28188   43.9102  634.3948  372.7208  363.4411
#> 6657   643.4315 1257.73833  456.5400  842.1561  349.1980 1000.6480
#> 358   1044.5030 2607.72778  135.9698  867.7302   18.4410 1179.3717
#> 8829   394.1429  961.68728  237.4838 1235.0147 1674.7981  697.2044
head(pData(featureData(expset))) # where other information is stored.
#>       expressions$ENTREZID
#> 2047                  2047
#> 65125                65125
#> 6531                  6531
#> 6657                  6657
#> 358                    358
#> 8829                  8829
```

## LNCRNA2GOA (expression similarity)

### Background

The LNCRNA2GOA (long non-coding RNA to GO Annotation) or `expression_prediction()` uses various methods/measures to determine similar genes with similar expression pattern; `pearson`, `spearman`, `kendall`, `sobolev` and `fisher`. This calculates scores between expression value sets given a query gene. These scores are used to identify genes for the enrichment analysis, which will be sorted by significance before being returned. It is also possible to find similar expression patterns by using the `combined` method. The Sobolev and Fisher metrics are so far unique to this package (at least in the context of this type of analysis), all the others are standard methods from the R `cor()` function. Details of the novel methods are described below (quoted from paper [1], references edited).

#### Sobolev metric

In this section, we use definitions and notations as in [2]. We start with the usual p-inner product. Let \(f\), \(g\) be real-valued functions (in this case \(f\) and \(g\) values are the expression vectors of two genes \(f\) and \(g\)):

\(\langle f,g\rangle\_{p} = (\sum\_{k=1}^{n}\mid f\_k.g\_k\mid^p)^\frac{1}{p}\)

(2)

By this notation, Sobolev inner product, norm and meter of degree \(k\) respectively can be defined by:

\(\langle f,g\rangle\_{p,a}^{S} = \langle f,g\rangle\_p+\alpha\langle D^kf,D^kg\rangle\_p\)

(3)

\(\mid\mid f\mid\mid\_{p,k,\alpha}^S = \sqrt{\langle f,f\rangle\_{p,\alpha}^S}\)

(4)

\(d\_{p,k,\alpha}^S(f,g) = \mid\mid f-g\mid\mid\_{p,k,\alpha}^S\)

(5)

where \(D^k\) is the \(k\)th differential operator. For the special case \(p=2\) and \(\alpha=1\) an interesting connection to the Fourier-transform of analysis can be made; let \(\hat{f}\) be the Fourier-transform \(f\)

\(\hat{f}(\omega\_k) = \sum\_{j=1}^{N-1}g\_jexp(-i\frac{2\pi kj}{N})\)

(6)

Where \(\omega\_k=\frac{2\pi k}{N}\) and \(i=\sqrt{-1}\). Finally the norm can be written as

\(\mid\mid f\mid\mid\_{2,k,1}^S = \sqrt{\sum\_{j=1}^{N-1}(1+\omega\_j)^k\mid \hat{f}(\omega\_j)\mid^2}\)

(7)

In this work metric (5) with norm (7) and \(k=1\) was used.

#### Fisher metric

In this section we use definitions and notations such as in [3]. To define Fisher information metric we first introduce the n-simplex \(P\_n\) defined by

\(P\_n=\{x\in R^{n+1}:\forall i, x\_n \ge0,\sum\_{i=1}^{n+1}xi=1\}\)

(8)

The coordinates \(\{x\_i\}\) describe the probability of observing different outcomes in a single experiment (or expression value of a gene in \(i\)th cell type). The Fisher information metric on \(P\_n\) can be defined by

\(Jij = \sum\_{k=1}^{n+1}\frac{1}{x\_k}\frac{\partial x\_k}{\partial x\_i}\frac{\partial x\_k}{\partial x\_j}\)

(9)

We now define a well-known representation of the Fisher information as a pull-back metric from the positive n-sphere \(S\_n^+\)

\(S\_n^+=\{x\in R^n;\forall i,x\_n\ge0,\sum\_{i=1}^{n+1}x^2=1\}\)

(10)

The transformation \(T: P\_n\to S\_n^+\) defined by

\(T(x)=(\sqrt{x\_1}, \dots, \sqrt{x\_n+1})\)

(11)

pulls back the Euclidean metric on the surface of the sphere to the Fisher information on the multinomial simplex. Actually, the geodesic distance for \(x,y \in P\_n\) under the Fisher information metric may be defined by measuring the length of the great circle on \(S\_n^+\) between \(T(x)\) and \(T(y)\)

\(d(x,y) = acos(\sum\_{i=1}^{n+1}\sqrt{x\_iy\_i})\)

(12)

**The LNCRNA2GOA method can also be used on other novel genes besides lncRNAs.**

### Example

#### Scores + Enrichment

The following example is an arbitrary use-case. Meaning that this is just an example and does not (necessarily) imply a certain question/real life use-case. `id_select_vector` represents a vector of gene ids that you’d want to use for annotation enrichment (if left empty, algorithm will use all available gene ids in the ExpressionSet).

```
# Example with default dataset, take a look at the data documentation
# to fully grasp what's going on with the making of the filter etc. (Biobase
# ExpressionSet)

# keep everything that is a protein coding gene (for annotation)
filter_vector <- fData(GAPGOM::expset)[(
fData(GAPGOM::expset)$GeneType=="protein_coding"),]$GeneID
# set gid and run.
gid <- "ENSG00000228630"

result <- GAPGOM::expression_prediction(gid,
GAPGOM::expset,
"human",
"BP",
id_translation_df =
GAPGOM::id_translation_df,
id_select_vector = filter_vector,
method = "combine",
verbose = TRUE, filter_pvals = TRUE)
#> Looking up GO terms...
#> Calculation time (in seconds):
#> 0.870675086975098
kable(result) %>% kable_styling() %>% scroll_box(width = "100%", height = "500px")
```

| GOID | Ontology | Pvalue | FDR | Term | used\_method |
| --- | --- | --- | --- | --- | --- |
| GO:0006810 | BP | 0.0001042 | 0.0003769 | transport | fisher |
| GO:0007165 | BP | 0.0010725 | 0.0070414 | signal transduction | kendall |
| GO:0006355 | BP | 0.0031231 | 0.0095531 | regulation of transcription, DNA-templated | pearson |
| GO:0045893 | BP | 0.0027479 | 0.0097134 | positive regulation of transcription, DNA-templated | fisher |
| GO:0006366 | BP | 0.0041102 | 0.0122466 | transcription by RNA polymerase II | sobolev |
| GO:0006468 | BP | 0.0091572 | 0.0443554 | protein phosphorylation | spearman |
| GO:0006351 | BP | 0.0158478 | 0.0475434 | transcription, DNA-templated | pearson |

Here we display the results, you can see that it has 6 columns;

* `GOID`

Describing the significantly similar GO terms

* `Ontology` Describing the ontology of the result.
* `Pvalue` The P-value/significance of the result.
* `FDR` bonferoni normalized P-value
* `Term` The description of the GO term.
* `used_method` Used scoring method for getting the result.

Besides this, there is an optional parameter for different GO labeling/annotation; `id_translation_df`. This dataframe should contain the following;

* rownames \(\to\) rownames of the expression set
* first column \(\to\) Gene ID (e.g. EntrezID). Gene should be the same as in the expression dataset.
* second colum \(\to\) GO IDs.

This can also drastically improve calculation time as most of the time is spent on querying for this translation.

#### Only scores

There is also another algorithm that allows you to just calculate scores and skip the enrichment;

```
# Example with default dataset, take a look at the data documentation
# to fully grasp what's going on with making of the filter etc. (Biobase
# ExpressionSet)

# set an artbitrary gene you want to find similarities for. (5th row in this
# case)
gid <- "ENSG00000228630"
result <- GAPGOM::expression_semantic_scoring(gid,
GAPGOM::expset)
kable(result[1:100,]) %>% kable_styling() %>% scroll_box(width = "100%", height = "500px")
```

|  | original\_ids | score | used\_method |
| --- | --- | --- | --- |
| ENSG00000224505 | ENSG00000224505 | 0.2004647 | pearson |
| ENSG00000139144 | ENSG00000139144 | 0.1011604 | pearson |
| ENSG00000265787 | ENSG00000265787 | 0.1247753 | pearson |
| ENSG00000204539 | ENSG00000204539 | 0.1396684 | pearson |
| ENSG00000253563 | ENSG00000253563 | 0.0892708 | pearson |
| ENSG00000188784 | ENSG00000188784 | 0.0863590 | pearson |
| ENSG00000042304 | ENSG00000042304 | 0.0726566 | pearson |
| ENSG00000248787 | ENSG00000248787 | 0.2197304 | pearson |
| ENSG00000269305 | ENSG00000269305 | 0.0561735 | pearson |
| ENSG00000241933 | ENSG00000241933 | 0.0606906 | pearson |
| ENSG00000132640 | ENSG00000132640 | 0.1382561 | pearson |
| ENSG00000137634 | ENSG00000137634 | 0.0981431 | pearson |
| ENSG00000186994 | ENSG00000186994 | 0.1811896 | pearson |
| ENSG00000095906 | ENSG00000095906 | 0.5401186 | pearson |
| ENSG00000187871 | ENSG00000187871 | 0.0167506 | pearson |
| ENSG00000254350 | ENSG00000254350 | 0.0477682 | pearson |
| ENSG00000151247 | ENSG00000151247 | 0.0106081 | pearson |
| ENSG00000109061 | ENSG00000109061 | 0.0682357 | pearson |
| ENSG00000257594 | ENSG00000257594 | 0.0225258 | pearson |
| ENSG00000253720 | ENSG00000253720 | 0.1931214 | pearson |
| ENSG00000180638 | ENSG00000180638 | 0.0566312 | pearson |
| ENSG00000234279 | ENSG00000234279 | 0.1001705 | pearson |
| ENSG00000188032 | ENSG00000188032 | 0.1129793 | pearson |
| ENSG00000171161 | ENSG00000171161 | 0.0709871 | pearson |
| ENSG00000250411 | ENSG00000250411 | 0.0589016 | pearson |
| ENSG00000260244 | ENSG00000260244 | 0.2590438 | pearson |
| ENSG00000063601 | ENSG00000063601 | 0.0637382 | pearson |
| ENSG00000249605 | ENSG00000249605 | 0.0834436 | pearson |
| ENSG00000182368 | ENSG00000182368 | 0.0104575 | pearson |
| ENSG00000224819 | ENSG00000224819 | 0.1137457 | pearson |
| ENSG00000196531 | ENSG00000196531 | 0.0298562 | pearson |
| ENSG00000085377 | ENSG00000085377 | 0.0761354 | pearson |
| ENSG00000129195 | ENSG00000129195 | 0.3678937 | pearson |
| ENSG00000227608 | ENSG00000227608 | 0.1634545 | pearson |
| ENSG00000250043 | ENSG00000250043 | 0.0943256 | pearson |
| ENSG00000269843 | ENSG00000269843 | 0.3473258 | pearson |
| ENSG00000181690 | ENSG00000181690 | 0.4336276 | pearson |
| ENSG00000125246 | ENSG00000125246 | 0.3062198 | pearson |
| ENSG00000262861 | ENSG00000262861 | 0.1053504 | pearson |
| ENSG00000173171 | ENSG00000173171 | 0.1348866 | pearson |
| ENSG00000248455 | ENSG00000248455 | 0.0930772 | pearson |
| ENSG00000265114 | ENSG00000265114 | 0.1114366 | pearson |
| ENSG00000166173 | ENSG00000166173 | 0.2045608 | pearson |
| ENSG00000068489 | ENSG00000068489 | 0.1446615 | pearson |
| ENSG00000183474 | ENSG00000183474 | 0.0317519 | pearson |
| ENSG00000138326 | ENSG00000138326 | 0.1441870 | pearson |
| ENSG00000101096 | ENSG00000101096 | 0.1657225 | pearson |
| ENSG00000235151 | ENSG00000235151 | 0.2721271 | pearson |
| ENSG00000154265 | ENSG00000154265 | 0.1235900 | pearson |
| ENSG00000177946 | ENSG00000177946 | 0.5389089 | pearson |
| ENSG00000225302 | ENSG00000225302 | 0.0224971 | pearson |
| ENSG00000237560 | ENSG00000237560 | 0.1250799 | pearson |
| ENSG00000261195 | ENSG00000261195 | 0.1342620 | pearson |
| ENSG00000235123 | ENSG00000235123 | 0.0486064 | pearson |
| ENSG00000260092 | ENSG00000260092 | 0.1116397 | pearson |
| ENSG00000254431 | ENSG00000254431 | 0.1893861 | pearson |
| ENSG00000118526 | ENSG00000118526 | 0.1717508 | pearson |
| ENSG00000261049 | ENSG00000261049 | 0.0393922 | pearson |
| ENSG00000254489 | ENSG00000254489 | 0.1097308 | pearson |
| ENSG00000176697 | ENSG00000176697 | 0.3079547 | pearson |
| ENSG00000250519 | ENSG00000250519 | 0.0213221 | pearson |
| ENSG00000263821 | ENSG00000263821 | 0.0863590 | pearson |
| ENSG00000065665 | ENSG00000065665 | 0.0021354 | pearson |
| ENSG00000088836 | ENSG00000088836 | 0.0343418 | pearson |
| ENSG00000254514 | ENSG00000254514 | 0.1114366 | pearson |
| ENSG00000149308 | ENSG00000149308 | 0.0458501 | pearson |
| ENSG00000109534 | ENSG00000109534 | 0.0521644 | pearson |
| ENSG00000204187 | ENSG00000204187 | 0.2636256 | pearson |
| ENSG00000102468 | ENSG00000102468 | 0.0711898 | pearson |
| ENSG00000101457 | ENSG00000101457 | 0.1492439 | pearson |
| ENSG00000204837 | ENSG00000204837 | 0.1985665 | pearson |
| ENSGR0000236871 | ENSGR0000236871 | 0.1737215 | pearson |
| ENSG00000113645 | ENSG00000113645 | 0.1680317 | pearson |
| ENSG00000261617 | ENSG00000261617 | 0.0935473 | pearson |
| ENSG00000177947 | ENSG00000177947 | 0.1092690 | pearson |
| ENSG00000233605 | ENSG00000233605 | 0.1114366 | pearson |
| ENSG00000187486 | ENSG00000187486 | 0.0193328 | pearson |
| ENSG00000159593 | ENSG00000159593 | 0.1764208 | pearson |
| ENSG00000230967 | ENSG00000230967 | 0.0863590 | pearson |
| ENSG00000064961 | ENSG00000064961 | 0.3389281 | pearson |
| ENSG00000257922 | ENSG00000257922 | 0.0255902 | pearson |
| ENSG00000241685 | ENSG00000241685 | 0.4240072 | pearson |
| ENSG00000171747 | ENSG00000171747 | 0.0964942 | pearson |
| ENSG00000152749 | ENSG00000152749 | 0.0533820 | pearson |
| ENSG00000183597 | ENSG00000183597 | 0.5322610 | pearson |
| ENSG00000214955 | ENSG00000214955 | 0.1746615 | pearson |
| ENSG00000166710 | ENSG00000166710 | 0.0462278 | pearson |
| ENSG00000149182 | ENSG00000149182 | 0.0432318 | pearson |
| ENSG00000259645 | ENSG00000259645 | 0.8049258 | pearson |
| ENSG00000137561 | ENSG00000137561 | 0.0933173 | pearson |
| ENSG00000175746 | ENSG00000175746 | 0.1013987 | pearson |
| ENSG00000230645 | ENSG00000230645 | 0.0219265 | pearson |
| ENSG00000254438 | ENSG00000254438 | 0.1059758 | pearson |
| ENSG00000233423 | ENSG00000233423 | 0.1607758 | pearson |
| ENSG00000254726 | ENSG00000254726 | 0.0301782 | pearson |
| ENSG00000006128 | ENSG00000006128 | 0.1607405 | pearson |
| ENSG00000259862 | ENSG00000259862 | 0.1016300 | pearson |
| ENSG00000204054 | ENSG00000204054 | 0.0103759 | pearson |
| ENSG00000185608 | ENSG00000185608 | 0.2245409 | pearson |
| ENSG00000163013 | ENSG00000163013 | 0.0495888 | pearson |

We can see that this function returns a different dataframe;

* `original_ids` The identifier of the gene expression row
* `score` The similarity score/correlation calculated by one of the methods.
* `used_method` The used method used to calculate the score.

The rownames also represent the gene expression row. Only the first 100 rows are shown, otherwise the table would be quite big. Enrichment and GO annotation/translation needs to be done manually after this step. However, this should be quite doable with a bit of help from `GOSemSim`.

#### Original dataset

The original publication used the lncRNA2Function data [4], to test if the results are the same, a small script has been made to reproduce the same results and is located at the package install directory under `scripts`. The `script` folder also contains the two original scripts for the algorithm, but not neccesarily its data. The data (along with the scripts) can be found on the following websites:

* <http://tare.medisin.ntnu.no/pred_lncRNA/>
* <https://tare.medisin.ntnu.no/TopoICSim/>

Besides this, the scripts folder also contains a proof-of-concept script for potentially doing the analysis on unannotated transcripts (by finding the closest gene). This is eventually meant as a sort of substitute to the famous [GREAT](http://great.stanford.edu/public/html/) tool.

## TopoICSim

### Background

TopoICSim or Topological Information Content Similarity, is a method to measure the similarity between two GO terms given the information content and topology of the GO DAG tree. Unlike other similar measures, it considers both the shortest **and** longest DAG paths between two terms, not just the longest or shortest path(s). The paths along the GO DAG tree get weighted with the information content between two terms.

For the information content the following forumla is used;

\(IC(t) = -log(p(t))\)

(1)

Where \(t\) is the (GO) term. The IC is calculated by GOSemSim, and based on the frequency of the specific go term (\(p(t)\)).

A GO tree can be described as a triplet \(\Lambda=(G,\Sigma,R)\), where \(G\) is the set of GO terms, \(\Sigma\) is the set of hierarchical relations between GO terms (mostly defined as *is\_a* or *part\_of*) [5], and \(R\) is a triplet \((t\_i, t\_j, \xi)\), where \(t\_i,t\_j\in G\) and \(\xi\in R\) and \(t\_i\xi t\_j\). The \(\xi\) relationship is an oriented child-parent relation. Top level node of the GO rDAG is the Root, which is a direct parent of the MF, BP and CC nodes. These nodes are called aspect-specific roots and we refer to them as root in the following. A path \(P\) of length \(n\) between two terms \(t\_i,t\_j\) can be defined as in (23).

\(P:G\times G\to G\times G\dots\times G=G^{n+1};\\P(t\_i,t\_j) = (t\_i,t\_j+1,\dots,t\_j)\)

(23)

Here \(\forall\) \(s\), \(i\le s<j\), \(\exists\xi\_s\in \Sigma\), \(\exists\tau\_s\in R\), \(r\_s=(t\_s,t\_{s+1}, \xi\_s)\). Because \(G\) is an rDAG, there might be multiple paths between two terms, so we represent all paths between two terms \(t\_i,t\_j\) according to (24).

\(\mathcal{A}(t\_i,t\_j)=\underset{P}{\cup}P(t\_i,t\_j)\)

(24)

We use Inverse Information Content (IIC) values to define shortest and longest paths for two given terms \(t\_i,t\_j\) as shown in (25-27).

\(SP(t\_i,t\_j) = \underset{P\in A(t\_i,t\_j)}{argminIIC(P)}\)

(25)

\(LP(t\_i,t\_j) = \underset{P\in A(t\_i,t\_j)}{argmaxIIC(P)}\)

(26)

\(IIC(P) = \sum\_{t\in P}\frac{1}{IC(t)}\)

(27)

The standard definition was used to calculate \(IC(t)\) as shown in (28)

\(IC(t) = -log\frac{G\_t}{G\_\mathrm{Tot}}\)

(28)

Here \(G\_t\) is the number of genes annotated by the term \(t\) and \(G\_\mathrm{Tot}\) is the total number of genes. The distribution of *IC* is not uniform in the *rDAG*, so it is possible to have two paths with different lengths but with same *IIC*s. To overcome this problem we weight paths by their lengths, so the definitions in (25) and (26) can be updated according to (29) and (30).

\(wSP(t\_i,t\_j)=SP(t\_i,t\_j)\times len(P)\)

(29)

\(wLP(t\_i,t\_j)=LP(t\_i,t\_j)\times len(P)\)

(30)

Now let \(ComAnc(t\_i,t\_j)\) be the set of all common ancestors for two given terms \((t\_i,t\_j)\). First we define the disjuntive common ancestors as a subset of \(ComAnc(t\_i,t\_j)\) as in (31).

\(DisComAnc(t\_i,t\_j) = \{x\in ComAnc(t\_i,t\_j)\mid P(x, root)\cap C(x)=\varnothing\}\)

(31)

Here \(P(x,root)\) is the path between \(x\) and \(root\) and \(C(x)\) is set of all immediate children for \(x\). For each disjuntive common ancestor \(x\) in \(DisComAnc(t\_i,t\_j)\), we define the distance between \(t\_i,t\_j\) as the ratio of the weighted shortest path between \(t\_i,t\_j\) which passes from \(x\) to the weighted longest path between \(x\) and \(root\), as in (32-33).

\(D(t\_i,t\_j,x) = \frac{wSP(t\_i,t\_j,x)}{wLP(x,root)}\)

(32)

\(wSP(t\_i,t\_j,x) = wSP(t\_i,x)+wSP(t\_j,x)\)

(33)

Now the distance for two terms \(t\_i,t\_j\) can be defined according to (34).

\(D(t\_i,t\_j)=\underset{x\in DisComAnc(t\_i,t\_j)}{min}D(t\_i,t\_j,x)\)

(34)

We convert distance values by the \(\frac{Arctan(.)}{\pi/2}\) function, and the measure for two GO terms \(t\_i\) and \(t\_j\) can be defined as in (35).

\(S(t\_i,t\_j) = 1-\frac{Arcatan(D(t\_i,t\_j))}{\pi/2}\)

(35)

Note that \(root\) refers to one of three first levels in the rDAG. So if \(DisComAnc(t\_i,t\_j)=\{root\}\) then \(D(t\_i,t\_j)=\infty\) and \(S(t\_i,t\_j)=0\). Also if \(t\_i = t\_j\) then \(D(t\_i,t\_j)=0\) and \(S(t\_i,t\_j)=1\). Finally let \(S=[s\_{ij}]\_{n\times m}\) be a similarity matrix for two given fenes or gene products \(g1, g2\) with GO terms \(t\_{11},t\_{12},\dots,t\_{1n}\) and \(t\_{21},t\_{12},\dots,t\_{2m}\) where \(s\_{ij}\) is the similarity between the GO terms \(t\_{1i}\) and \(t\_{2j}\). We used a *rcmax* method to calculate similarity between \(g1, g2\), as defined in (36).

\(\begin{aligned}TopoICSim(g\_1,g\_2)&=rcmax(S)\\&=rcmax\left(\frac{\sum\_{i=1}^n\underset{j}{maxs\_{ij}}}{n},\frac{\sum\_{i=1}^m\underset{i}{maxs\_{ij}}}{m}\right)\end{aligned}\)

(36)

We also tested other methods on the similarity matrix, in particular average and BMA, but in general \(rcmax\) gave the best performance for TopoICSim (data not shown).

Besides all this, there’s also an algorithm for the geneset level, you can calculate interset/intraset similarities of these with (13) and (14). Or simply use R’s `mean` on the resulting matrix.

\(IntraSetSim(S\_k)=\frac{\sum\_{i=1}^n\sum\_{j=1}^mSim(g\_{ki},g\_{kj})}{n^2}\)

(13)

\(InterSetSim(S\_k)=\frac{\sum\_{i=1}^n\sum\_{j=1}^mSim(g\_{ki},g\_{kj})}{n\times m}\)

(14)

(13) is equal to (14) in the specific case of comparing the geneset to itself.

All forumulas/explanations are quoted from the paper (references edited) [6].

### Examples

The following example uses the [pfam clan gene set](https://pfam.xfam.org/family/PF00171) to measure intraset similarity. For the single gene, `EntrezID` 218 and 501 are compared.

```
result <- GAPGOM::topo_ic_sim_genes("human", "MF", "218", "501",
progress_bar = FALSE)
kable(result$AllGoPairs) %>% kable_styling() %>% scroll_box(width = "100%", height = "500px")
```

|  | GO:0004029 | GO:0004030 | GO:0005515 | GO:0008106 | GO:0018479 | GO:0008802 | GO:0043878 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| GO:0004029 | 1.000 | 0.892 | NA | 0.112 | 0.800 | 0.800 | 0.894 |
| GO:0004030 | 0.892 | 1.000 | NA | NA | NA | 0.804 | 0.896 |
| GO:0005515 | NA | NA | 1 | NA | NA | NA | NA |
| GO:0008106 | 0.112 | NA | NA | 1.000 | NA | 0.092 | 0.113 |
| GO:0018479 | 0.800 | NA | NA | NA | 1.000 | 0.937 | 0.806 |
| GO:0008802 | 0.800 | 0.804 | NA | 0.092 | 0.937 | 1.000 | NA |
| GO:0043878 | 0.894 | 0.896 | NA | 0.113 | 0.806 | NA | 1.000 |

```
result$GeneSim
#> [1] 0.979
# genelist mode
list1 <- c("126133","221","218","216","8854","220","219","160428","224",
"222","8659","501","64577","223","217","4329","10840","7915","5832")
# ONLY A PART OF THE GENELIST IS USED BECAUSE OF R CHECK TIME CONTRAINTS
result <- GAPGOM::topo_ic_sim_genes("human", "MF", list1[1:3], list1[1:3],
progress_bar = FALSE)
kable(result$AllGoPairs) %>% kable_styling() %>% scroll_box(width = "100%", height = "500px")
```

|  | GO:0016620 | GO:0004029 | GO:0004030 | GO:0005515 | GO:0008106 | GO:0018479 |
| --- | --- | --- | --- | --- | --- | --- |
| GO:0016620 | 1.000 | 0.662 | 0.667 | NA | 0.143 | 0.530 |
| GO:0004029 | 0.662 | 1.000 | 0.892 | NA | 0.112 | 0.800 |
| GO:0004030 | 0.667 | 0.892 | 1.000 | NA | 0.113 | 0.804 |
| GO:0005515 | NA | NA | NA | 1 | NA | NA |
| GO:0008106 | 0.143 | 0.112 | 0.113 | NA | 1.000 | 0.092 |
| GO:0018479 | 0.530 | 0.800 | 0.804 | NA | 0.092 | 1.000 |

```
kable(result$GeneSim) %>% kable_styling() %>% scroll_box(width = "100%", height = "500px")
```

|  | 126133 | 221 | 218 |
| --- | --- | --- | --- |
| 126133 | 1.000 | 0.817 | 0.817 |
| 221 | 0.817 | 1.000 | 1.000 |
| 218 | 0.817 | 1.000 | 1.000 |

```
mean(result$GeneSim)
#> [1] 0.9186667
```

Here we can see the output of TopoICsim, it is a list containg 2 items;

* `AllGoPairs`

The \(n\times m\) matrix of GO terms, including their similarities. Some values might be NA because these were non-occuring pairs. You can add `AllGoPairs` to the parameters next time you run TopoICSim, to possibly speed up computations (they will be used as pre-calculated scores to fill in occurring pairs).

* `GeneSim`

The gene/geneset similarities depending on your input. Can be 1 number, or a matrix displaying all possible combinations. \(\to\) The mean of the geneset matrix shows the intraset/interset similarity.

#### Custom genes

Besides this, you can also define custom genes for TopoICSim. This consists of an arbitrary amount of GO terms. The custom genes have to individually defined in a named list.

```
custom <- list(cus1=c("GO:0016787", "GO:0042802", "GO:0005524"))
result <- GAPGOM::topo_ic_sim_genes("human", "MF", "218", "501",
custom_genes1 = custom, drop = NULL, verbose = TRUE, progress_bar = FALSE)
#> Preparing topoICSim data...
#> Preparing term data.
#> preparing gene to GO mapping data...
#> preparing IC data...
#> Preparing gene/geneset data...
#> Started calculating all go's.
#> Filtering out precalculated values...
#> Resolving common ancestors...
#> Done!
#> Resolving disjunctive common ancestors...
#> Done!
#> Calculating short paths...
#> Done!
#> Calculating long paths...
#> Done!
#> Merging into all_go_pairs...
#> Done!
#> Merging gene(set) results...
#> Done!
#> Calculation time (in seconds):
#> 9.2574999332428
result
#> $GeneSim
#>        501
#> cus1 0.296
#> 218  0.979
#>
#> $AllGoPairs
#>            GO:0004029 GO:0004030 GO:0005515 GO:0008106 GO:0018479
#> GO:0004029      1.000      0.892         NA      0.112      0.800
#> GO:0004030      0.892      1.000         NA         NA         NA
#> GO:0005515         NA         NA      1.000         NA         NA
#> GO:0008106      0.112         NA         NA      1.000         NA
#> GO:0018479      0.800         NA         NA         NA      1.000
#> GO:0008802      0.800      0.804         NA      0.092      0.937
#> GO:0043878      0.894      0.896         NA      0.113      0.806
#> GO:0016787      0.044      0.044         NA      0.032      0.035
#> GO:0042802         NA         NA      0.105         NA         NA
#> GO:0005524         NA         NA      0.125         NA         NA
#>            GO:0008802 GO:0043878 GO:0016787 GO:0042802 GO:0005524
#> GO:0004029      0.800      0.894      0.044         NA         NA
#> GO:0004030      0.804      0.896      0.044         NA         NA
#> GO:0005515         NA         NA         NA      0.105      0.125
#> GO:0008106      0.092      0.113      0.032         NA         NA
#> GO:0018479      0.937      0.806      0.035         NA         NA
#> GO:0008802      1.000      0.806      0.035         NA         NA
#> GO:0043878      0.806      1.000      0.044         NA         NA
#> GO:0016787      0.035      0.044      1.000         NA         NA
#> GO:0042802         NA         NA         NA      1.000         NA
#> GO:0005524         NA         NA         NA         NA      1.000
```

Here we define a custom gene named “cus1” with the GO terms; “GO:0016787”, “GO:0042802”, “GO:0005524”, it will be added to the first gene vector (218). If you want to **only** have a custom gene, you can define an empty vector with `c()` for the respective vector.

#### Other notes.

With TopoICSim there is a pre-calculated score matrix available, this can be turned on/off. The scores might become deprecated however, as soon as one of the `org.DB` packages gets an update. For this reason, we advise mostly to keep this option off. You can also pre-calculate some GO’s yourself using the custom genes. `all_go_pairs` can then be used as a precalculated score matrix, only intersecting/present GO terms will be used.

## Parrallel processing and big data

As of right now, parallel processing is not supported. The other algorithms aren’t parallelized yet, because of implementation difficulties regarding the amount and type of dependencies that the algorithms rely on. Possibly, in the future, parallel processing will be supported. It might however be possible to divide the work in TopoICSim (on gene pair level). It runs for each unique pair of genes, which you may be able to generate using the hidden `GAPGOM:::.unique_combos` function. The `All_go_pairs` object in the result can then be combined together with other results. No support is offered however in regards to trying to make this work. Tip: The `all_go_pairs` argument in `topo_ic_sim_genes()` doesn’t automatically create a new, bigger matrix, it only uses the overlapping or present GO terms of the analysis based on the input genes.

## Performance and benchmarks

The performance of this package is well tested in the [Benchmarks vignette](benchmarks.html), in which benchmarks are also prepared.

## Contact and support

For questions, contact, or support use the [(Bioconductor) git repository](https://github.com/Berghopper/GAPGOM/) or contact us via the Bioconductor forums.

## SessionInfo

```
sessionInfo()
#> R version 3.6.0 (2019-04-26)
#> Platform: x86_64-pc-linux-gnu (64-bit)
#> Running under: Ubuntu 18.04.2 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.9-bioc/R/lib/libRblas.so
#> LAPACK: /home/biocbuild/bbs-3.9-bioc/R/lib/libRlapack.so
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> attached base packages:
#> [1] parallel  stats4    stats     graphics  grDevices utils     datasets
#> [8] methods   base
#>
#> other attached packages:
#> [1] org.Hs.eg.db_3.8.2   AnnotationDbi_1.46.0 IRanges_2.18.0
#> [4] S4Vectors_0.22.0     Biobase_2.44.0       BiocGenerics_0.30.0
#> [7] GAPGOM_1.0.0         kableExtra_1.1.0     knitr_1.22
#>
#> loaded via a namespace (and not attached):
#>  [1] Rcpp_1.0.1          lattice_0.20-38     tidyr_0.8.3
#>  [4] GO.db_3.8.2         assertthat_0.2.1    digest_0.6.18
#>  [7] BiocFileCache_1.8.0 plyr_1.8.4          R6_2.4.0
#> [10] org.Mm.eg.db_3.8.2  RSQLite_2.1.1       evaluate_0.13
#> [13] highr_0.8           httr_1.4.0          pillar_1.3.1
#> [16] rlang_0.3.4         curl_3.3            rstudioapi_0.10
#> [19] data.table_1.12.2   blob_1.1.1          Matrix_1.2-17
#> [22] rmarkdown_1.12      webshot_0.5.1       readr_1.3.1
#> [25] stringr_1.4.0       igraph_1.2.4.1      bit_1.1-14
#> [28] munsell_0.5.0       compiler_3.6.0      xfun_0.6
#> [31] pkgconfig_2.0.2     htmltools_0.3.6     tidyselect_0.2.5
#> [34] tibble_2.1.1        GEOquery_2.52.0     matrixStats_0.54.0
#> [37] viridisLite_0.3.0   crayon_1.3.4        dplyr_0.8.0.1
#> [40] dbplyr_1.4.0        rappdirs_0.3.1      grid_3.6.0
#> [43] RBGL_1.60.0         DBI_1.0.0           magrittr_1.5
#> [46] scales_1.0.0        graph_1.62.0        stringi_1.4.3
#> [49] GOSemSim_2.10.0     limma_3.40.0        xml2_1.2.0
#> [52] fastmatch_1.1-0     tools_3.6.0         bit64_0.9-7
#> [55] glue_1.3.1          purrr_0.3.2         hms_0.4.2
#> [58] prettydoc_0.2.1     yaml_2.2.0          colorspace_1.4-1
#> [61] rvest_0.3.3         memoise_1.1.0
```

## References

* [1] Ehsani R, Drablos F: **Measures of co-expression for improved function prediction of long non-coding RNAs**. *BMC Bioinformatics* 2018. Accepted.
* [2] Villmann T: **Sobolev metrics for learning of functional data - mathematical and theoretical aspects**. In: *Machine Learning Reports.* Edited by Villmann T, Schleif F-M, vol. 1. Leipzig, Germany: Medical Department, University of Leipzig; 2007: 1-13.
* [3] Lebanon G: **Learning riemannian metrics.** In: *Proceedings of the Nineteenth conference on Uncertainty in Artificial Intelligence; Acapulco, Mexico.* Morgan Kaufmann Publishers Inc. 2003: 362-369
* [4] Jian Q: **LncRNA2Function: a comprehensive resource for functional investigation of human lncRNAs based on RNA-seq data.** In: *BMC Genomics* 2015. DOI: [10.1186/1471-2164-16-S3-S2](https://doi.org/10.1186/1471-2164-16-S3-S2)
* [5] Benabderrahmane S, Smail-Tabbone, Poch O, Napoli A, Devignes MD. **IntelliGO: a new vector-based semantic similarity measure including annotation origin.** In: *BMC Bioinformatics*. 2010;11:588.
* [6] Ehsani R, Drablos F: **TopoICSim: a new semantic similarity measure based on gene ontology.** In: *BMC Bioinformatics* 2016, **17**(1):296. DOI: [10.1186/s12859-016-1160-0](https://doi.org/10.1186/s12859-016-1160-0)