# categoryCompare: High-throughput data meta-analysis using feature annotations

Authored by: **Robert M Flight** `<rflight79@gmail.com>` on 2025-10-29 22:57:11.240353

## Introduction

Current high-throughput molecular biology experiments are generating larger and larger amounts of data. Although there are many different methods to analyze individual experiments, methods that allow the comparison of different data sets are sorely lacking. This is important due to the number of experiments that have been carried out on biological systems that may be amenable to either fusion or comparison. Most of the current tools available focus on finding those genes in experiments that are listed as the same, or that can be shown statistically that it is significant that the gene was listed in the results of both experiments.

However, what many of these tools do not do is consider the similarities (and just as importantly, the differences) between experimental results at the categorical level. Categoical data includes any gene annotation, such as Gene Ontologies, KEGG pathways, chromosome location, etc. categoryCompare has been developed to allow the comparison of high-throughput experiments at a categorical level, and to explore those results in an intuitive fashion.

## Sample Data

To make the concept more concrete, we will examine data from the microarray data set `estrogen` available from Bioconductor. This data set contains 8 samples, with 2 levels of estrogen therapy (present vs absent), and two time points (10 and 48 hours). A pre-processed version of the data is available with this package, the commands used to generate it are below. Note: the preprocessed one keeps only the top 100 genes, if you use it the results will be slightly different than those shown in the vignette.

```
library("affy")
library("hgu95av2.db")
library("genefilter")
library("estrogen")
library("limma")
```

```
datadir <- system.file("extdata", package = "estrogen")
pd <- read.AnnotatedDataFrame(file.path(datadir,"estrogen.txt"),
    header = TRUE, sep = "", row.names = 1)
pData(pd)
```

```
##              estrogen time.h
## low10-1.cel    absent     10
## low10-2.cel    absent     10
## high10-1.cel  present     10
## high10-2.cel  present     10
## low48-1.cel    absent     48
## low48-2.cel    absent     48
## high48-1.cel  present     48
## high48-2.cel  present     48
```

Here you can see the descriptions for each of the arrays. First, we will read in the cel files, and then normalize the data using RMA.

```
filePaths <- file.path(datadir, rownames(pData(pd)))
a <- ReadAffy(filenames=filePaths, phenoData = pd, verbose = TRUE)
```

```
## 1 reading /home/biocbuild/bbs-3.22-bioc/R/site-library/estrogen/extdata/low10-1.cel ...instantiating an AffyBatch (intensity a 409600x8 matrix)...done.
## Reading in : /home/biocbuild/bbs-3.22-bioc/R/site-library/estrogen/extdata/low10-1.cel
## Reading in : /home/biocbuild/bbs-3.22-bioc/R/site-library/estrogen/extdata/low10-2.cel
## Reading in : /home/biocbuild/bbs-3.22-bioc/R/site-library/estrogen/extdata/high10-1.cel
## Reading in : /home/biocbuild/bbs-3.22-bioc/R/site-library/estrogen/extdata/high10-2.cel
## Reading in : /home/biocbuild/bbs-3.22-bioc/R/site-library/estrogen/extdata/low48-1.cel
## Reading in : /home/biocbuild/bbs-3.22-bioc/R/site-library/estrogen/extdata/low48-2.cel
## Reading in : /home/biocbuild/bbs-3.22-bioc/R/site-library/estrogen/extdata/high48-1.cel
## Reading in : /home/biocbuild/bbs-3.22-bioc/R/site-library/estrogen/extdata/high48-2.cel
```

```
eData <- mas5(a)
```

```
## background correction: mas
## PM/MM correction : mas
## expression values: mas
## background correcting...
```

```
## Warning: replacing previous import 'AnnotationDbi::tail' by 'utils::tail' when
## loading 'hgu95av2cdf'
```

```
## Warning: replacing previous import 'AnnotationDbi::head' by 'utils::head' when
## loading 'hgu95av2cdf'
```

```
## done.
## 12625 ids to be processed
## |                    |
## |####################|
```

To make it easier to conceptualize, we will split the data up into two eSet objects by time, and perform all of the manipulations for calculating significantly differentially expressed genes on each eSet object.

So for the 10 hour samples:

```
e10 <- eData[, eData$time.h == 10]
e10 <- nsFilter(e10, remove.dupEntrez=TRUE, var.filter=FALSE,
        feature.exclude="^AFFX")$eset

e10$estrogen <- factor(e10$estrogen)
d10 <- model.matrix(~0 + e10$estrogen)
colnames(d10) <- unique(e10$estrogen)
fit10 <- lmFit(e10, d10)
c10 <- makeContrasts(present - absent, levels=d10)
fit10_2 <- contrasts.fit(fit10, c10)
eB10 <- eBayes(fit10_2)
table10 <- topTable(eB10, number=nrow(e10), p.value=1, adjust.method="BH")
table10$Entrez <- unlist(mget(rownames(table10), hgu95av2ENTREZID, ifnotfound=NA))
```

And the 48 hour samples we do the same thing:

```
e48 <- eData[, eData$time.h == 48]
e48 <- nsFilter(e48, remove.dupEntrez=TRUE, var.filter=FALSE,
        feature.exclude="^AFFX" )$eset

e48$estrogen <- factor(e48$estrogen)
d48 <- model.matrix(~0 + e48$estrogen)
colnames(d48) <- unique(e48$estrogen)
fit48 <- lmFit(e48, d48)
c48 <- makeContrasts(present - absent, levels=d48)
fit48_2 <- contrasts.fit(fit48, c48)
eB48 <- eBayes(fit48_2)
table48 <- topTable(eB48, number=nrow(e48), p.value=1, adjust.method="BH")
table48$Entrez <- unlist(mget(rownames(table48), hgu95av2ENTREZID, ifnotfound=NA))
```

And grab all the genes on the array to have a background set.

```
gUniverse <- unique(union(table10$Entrez, table48$Entrez))
```

For both time points we have generated a list of genes that are differentially expressed in the present vs absent samples. To compare the time-points, we could find the common and discordant genes from both experiments, and then try to interpret those lists. This is commonly done in many meta-analysis studies that attempt to combine the results of many different experiments.

An alternative approach, used in `categoryCompare`, would be to compare the significantly enriched categories from the two gene lists. Currently the package supports two category classes, Gene Ontology, and KEGG pathways. Both are used below.

Note 1: I am not proposing that this is the best way to analyse *this* particular data, it is a sample data set that merely serves to illustrate the functionality of this package. However, there are many different experiments where this type of approach is definitely appropriate, and it is up to the user to determine if their data fits the analytical paradigm advocated here.

## Create Gene List

```
library("categoryCompare")
library("GO.db")
library("KEGGREST")

g10 <- unique(table10$Entrez[table10$adj.P.Val < 0.05])
g48 <- unique(table48$Entrez[table48$adj.P.Val < 0.05])
```

For each list the genes of interest, and a background must be defined. Here we are using those genes with an adjusted P-value of less than 0.05 as the genes of interest, and all of the genes on the chip as the background.

```
list10 <- list(genes=g10, universe=gUniverse, annotation='org.Hs.eg.db')
list48 <- list(genes=g48, universe=gUniverse, annotation='org.Hs.eg.db')

geneLists <- list(T10=list10, T48=list48)
geneLists <- new("ccGeneList", geneLists, ccType=c("BP","KEGG"))
```

```
## Warning in makeValidccLists(.Object): NAs introduced by coercion
```

```
fdr(geneLists) <- 0 # this speeds up the calculations for demonstration
geneLists
```

```
## List:  T10
## Size of gene list:  400
## Size of gene universe:  8776
## Annotation:  org.Hs.eg.db
##
## List:  T48
## Size of gene list:  75
## Size of gene universe:  8776
## Annotation:  org.Hs.eg.db
##
## Types of annotations to examine:  BP; KEGG
## Number of FDR runs to perform:  0
## pValue Cutoff to decide significantly enriched annotations:  0.05
## Testdirection:  over represented
```

## Annotation Enrichment

Now run the enrichment calculations on each list. In this case enrichment will be performed using the biological process (BP) Gene Ontology, and KEGG Pathways.

```
enrichLists <- ccEnrich(geneLists)
```

```
## Performing Enrichment Calculations ....
## T10 : BP
## T48 : BP
## T10 : KEGG
## T48 : KEGG
## Done!!
```

```
enrichLists
```

```
##     Annotation category:  GO   BP
##                FDR runs:  0
## Default p-values to use:  pval
##                 pCutoff:  0.05
##
## List:  T10
## Gene to GO BP  test for over-representation
## 5861 GO BP ids tested (816 have p <= 0.05 & count >= 0)
## Selected gene set size: 393
##     Gene universe size: 8327
##     Annotation package: org.Hs.eg
##
## List:  T48
## Gene to GO BP  test for over-representation
## 2782 GO BP ids tested (656 have p <= 0.05 & count >= 0)
## Selected gene set size: 75
##     Gene universe size: 8327
##     Annotation package: org.Hs.eg
##
##
##     Annotation category:  KEGG
##                FDR runs:  0
## Default p-values to use:  pval
##                 pCutoff:  0.05
##
## List:  T10
## Gene to KEGG  test for over-representation
## 167 KEGG ids tested (16 have p <= 0.05 & count >= 0)
## Selected gene set size: 222
##     Gene universe size: 3499
##     Annotation package: org.Hs.eg
##
## List:  T48
## Gene to KEGG  test for over-representation
## 61 KEGG ids tested (6 have p <= 0.05 & count >= 0)
## Selected gene set size: 43
##     Gene universe size: 2917
##     Annotation package: org.Hs.eg
```

There are a lot of GO BP processes enriched using the p-value cutoff of 0.05, so lets make that more stringent (`0.001`). This is done here merely for speed, in a usual analysis you should choose this number, and the type of cutoff (p-value or fdr) carefully.

```
pvalueCutoff(enrichLists$BP) <- 0.001
enrichLists
```

```
##     Annotation category:  GO   BP
##                FDR runs:  0
## Default p-values to use:  pval
##                 pCutoff:  0.001
##
## List:  T10
## Gene to GO BP  test for over-representation
## 5861 GO BP ids tested (123 have p <= 0.001 & count >= 0)
## Selected gene set size: 393
##     Gene universe size: 8327
##     Annotation package: org.Hs.eg
##
## List:  T48
## Gene to GO BP  test for over-representation
## 2782 GO BP ids tested (63 have p <= 0.001 & count >= 0)
## Selected gene set size: 75
##     Gene universe size: 8327
##     Annotation package: org.Hs.eg
##
##
##     Annotation category:  KEGG
##                FDR runs:  0
## Default p-values to use:  pval
##                 pCutoff:  0.05
##
## List:  T10
## Gene to KEGG  test for over-representation
## 167 KEGG ids tested (16 have p <= 0.05 & count >= 0)
## Selected gene set size: 222
##     Gene universe size: 3499
##     Annotation package: org.Hs.eg
##
## List:  T48
## Gene to KEGG  test for over-representation
## 61 KEGG ids tested (6 have p <= 0.05 & count >= 0)
## Selected gene set size: 43
##     Gene universe size: 2917
##     Annotation package: org.Hs.eg
```

Currently you can see that for T10, there are 123 processes enriched, and 63 for T48. For KEGG, there are 16 and 6 for T10 and T48, respectively.

To see which processes and pathways are enriched, and to compare them, we will run `ccCompare`, after generating a `ccOptions` object to tell the software exactly which comparisons to do.

```
ccOpts <- new("ccOptions", listNames=names(geneLists), outType='none')
ccOpts
```

```
## List Names:  T10; T48
## Comparisons:  T10; T48; T10,T48
## Colors:  #FF7A9E; #89BC00; #00C8EA
## Output Types:  none
```

```
ccResults <- ccCompare(enrichLists,ccOpts)
ccResults
```

```
## ccCompare results for:
##
## Annotation category:  GO   BP
## Main graph: A graphNEL graph with directed edges
## Number of Nodes = 88
## Number of Edges = 2205
##
## Annotation category:  KEGG
## Main graph: A graphNEL graph with directed edges
## Number of Nodes = 17
## Number of Edges = 37
```

The `ccResults` is a list object where for each type of category (Gene Ontologies, KEGG pathways, etc) there are `ccCompareResult` objects containing various pieces, including the output of the enrichments in table form (`mainTable`) with a designation as to which of the geneLists they originated from, a graph that shows how the annotations are connected to each other (`mainGraph`), and which genes belong to which annotation, and which list they originated from (`allAnnotation`).

## Visualization

Currently the easiest way to visualize and interact with this data is by using Cytoscape and the `RCy3` package. To set up `RCy3`, see the [`RCy3` webiste](https://bioconductor.org/packages/release/bioc/html/RCy3.html) .

Error in cyrestPOST(“networks”, parameters = list(title = title, collection = collection), : object ‘res’ not found [1] “No connection to Cytoscape available, subsequent visualizations were not run”

Once you have [Cytoscape](http://cytoscape.org) up and running, then we can examine the results from each category of annotations. First up, GO Biological Process.

**Note on deleting edges in Cytoscape**: As of `RCy3` v 1.7.0 and Cytoscape 3.5.1, deleting nodes *after* putting the graph in Cytoscape is slow. This network contains ~ 20,000 edges to start, most with *very* low weights. Therefore, I recommend removing some low weight edges **before** putting the graph into Cytoscape!

```
ccBP <- breakEdges(ccResults$BP, 0.2)

cw.BP <- ccOutCyt(ccBP, ccOpts)
```

![](data:image/png;base64...)

cwBP results with 0.2 Edges

You should now see something in Cytoscape that somewhat resembles the above figure. Reddish nodes came from T10, green from T48, and the blue ones from both. The edges determine that some of the genes are shared between annotations (nodes), and are weighted by how many genes are shared. The graph is layed out using a *force-directed* layout, and the force on the edges is determined by the number of shared genes. Right now there are a few groupings of nodes, that are probably functionally related. However, there is also a large mass of interconnected nodes in the middle, due to the shared genes in the annotation. We may get a better picture of this if we **break** the edges between nodes that share lower numbers of genes. The weight of the connections is based on the work of Bader and co-workers.

```
breakEdges(cw.BP,0.4)
breakEdges(cw.BP,0.6)
breakEdges(cw.BP,0.8)
```

![](data:image/png;base64...)

After breaking edges with weight less than 0.8

By the time you get to breaking any edges with a weight less than 0.8, you should see some very distinct groups of nodes (see the above figure). Because the numbers of genes shared between these nodes is high, it is likely that these groups of nodes describe a functional “theme” that will hopefully tell you something about the genes involved in the biological process that you are examining. This view also shows that even if there are no nodes that explicitly show up in both lists, if there are a series of annotations from each list in a well connected group, then perhaps there is still some similarity between the lists in this area.

To see a description of the nodes and their listMembership, as well as other information about each node, you can use the **Data Panel** in Cytoscape, and select the node attributes that you want listed when you select a node. To discover the **theme** of a group of nodes, select all the nodes that belong to a group.

To view the GO nodes in the GO directed-acyclic graph (DAG) hierarchy, we need to change the graph type and re-run `ccCompare` function. The output is shown in the next figure.

```
graphType(enrichLists$BP) <- "hierarchical"
ccResultsBPHier <- ccCompare(enrichLists$BP, ccOpts)
ccResultsBPHier
```

```
## Annotation category:  GO   BP
## Main graph: A graphNEL graph with directed edges
## Number of Nodes = 350
## Number of Edges = 683
```

```
cw.BP2 <- ccOutCyt(ccResultsBPHier, ccOpts, "BPHier")
```

![](data:image/png;base64...)

GO BP results using the hierarchical layout

Note that the current hierarchical layout in Cytoscape does not seem to generate layouts that are easy to follow. This layout should only be used when there are small numbers of GO annotations.

We can do a similar process for the KEGG pathways as well.

```
cw.KEGG <- ccOutCyt(ccResults$KEGG,ccOpts)
```

![](data:image/png;base64...)

KEGG pathway results

If you don’t feel that there are enough nodes to work with the data, you may want to change the P-value cutoff used using `pvalueCutoff`, or even the type of P-value, using `pvalueType`.

## Acknowledgements

This package depends heavily on classes and functionality from `Category`, `graph`, and the interactive network visualization capabilities enabled by `RCy3`.

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] KEGGREST_1.50.0        GO.db_3.22.0           categoryCompare_1.54.0
##  [4] hgu95av2cdf_2.18.0     limma_3.66.0           estrogen_1.55.0
##  [7] genefilter_1.92.0      hgu95av2.db_3.13.0     org.Hs.eg.db_3.22.0
## [10] AnnotationDbi_1.72.0   IRanges_2.44.0         S4Vectors_0.48.0
## [13] affy_1.88.0            Biobase_2.70.0         BiocGenerics_0.56.0
## [16] generics_0.1.4
##
## loaded via a namespace (and not attached):
##  [1] IRdisplay_1.1          blob_1.2.4             Biostrings_2.78.0
##  [4] bitops_1.0-9           fastmap_1.2.0          RCurl_1.98-1.17
##  [7] XML_3.99-0.19          digest_0.6.37          base64url_1.4
## [10] lifecycle_1.0.4        survival_3.8-3         statmod_1.5.1
## [13] RSQLite_2.4.3          compiler_4.5.1         rlang_1.1.6
## [16] sass_0.4.10            tools_4.5.1            knitr_1.50
## [19] curl_7.0.0             bit_4.6.0              repr_1.1.7
## [22] RColorBrewer_1.1-3     KernSmooth_2.23-26     pbdZMQ_0.3-14
## [25] hwriter_1.3.2.1        grid_4.5.1             preprocessCore_1.72.0
## [28] caTools_1.18.3         xtable_1.8-4           colorspace_2.1-2
## [31] gtools_3.9.5           cli_3.6.5              rmarkdown_2.30
## [34] crayon_1.5.3           httr_1.4.7             DBI_1.2.3
## [37] cachem_1.1.0           GOstats_2.76.0         splines_4.5.1
## [40] BiocManager_1.30.26    XVector_0.50.0         matrixStats_1.5.0
## [43] base64enc_0.1-3        vctrs_0.6.5            Matrix_1.7-4
## [46] jsonlite_2.0.0         bit64_4.6.0-1          RBGL_1.86.0
## [49] GSEABase_1.72.0        Rgraphviz_2.54.0       jquerylib_0.1.4
## [52] affyio_1.80.0          annotate_1.88.0        glue_1.8.0
## [55] RJSONIO_2.0.0          stringi_1.8.7          Category_2.76.0
## [58] pillar_1.11.1          gplots_3.2.0           htmltools_0.5.8.1
## [61] Seqinfo_1.0.0          RCy3_2.30.0            IRkernel_1.3.2
## [64] graph_1.88.0           R6_2.6.1               evaluate_1.0.5
## [67] AnnotationForge_1.52.0 lattice_0.22-7         png_0.1-8
## [70] backports_1.5.0        memoise_2.0.1          bslib_0.9.0
## [73] uuid_1.2-1             xfun_0.53              fs_1.6.6
## [76] MatrixGenerics_1.22.0  pkgconfig_2.0.3
```