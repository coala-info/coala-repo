# Performing gene set enrichment analyses with sparrow

Steve Lianoglou

#### 30 October 2025

#### Abstract

The sparrow package facilitates the use of gene sets in the analysis of high throughput genomics data. It provides simple execution and comparison of several GSEA approaches through a unified interface within the user’s workspace or interactively via a shiny application provided by the sparrow.shiny package. This package also provides an easy wrapper to single sample gene set scoring and geneset-centric heatmaps for visualization. sparrow package version: 1.16.0

#### Package

sparrow 1.16.0

# Contents

* [1 Overview](#overview)
* [2 Standard Workflow](#standard-workflow)
  + [2.1 Data Setup](#data-setup)
  + [2.2 Data Analysis](#data-analysis)
    - [2.2.1 Differential Gene Expression](#differential-gene-expression)
    - [2.2.2 Gene Set Enrichment Analysis](#gene-set-enrichment-analysis)
    - [2.2.3 Gene Sets to Test](#gene-sets-to-test)
  + [2.3 Running sparrow](#running-sparrow)
  + [2.4 Implicit Differential Expression](#implicit-differential-expression)
  + [2.5 Explicit GSEA](#explicit-gsea)
  + [2.6 Exploring Results](#exploring-results)
  + [2.7 Plotting](#plotting)
    - [2.7.1 Interactive Exploration](#interactive-exploration)
* [3 Singe Sample Gene Set Scoring](#singe-sample-gene-set-scoring)
  + [3.1 Generating Single Sample Gene Set Scores](#generating-single-sample-gene-set-scores)
  + [3.2 Visualizing Single Sample Gene Set Scores](#visualizing-single-sample-gene-set-scores)
* [4 Gene Set Based Heatmap with mgheatmap](#gene-set-based-heatmap-with-mgheatmap)
  + [4.1 Gene level based heatmap (from genesets)](#gene-level-based-heatmap-from-genesets)
  + [4.2 Gene set-based heatmap](#gene-set-based-heatmap)
* [5 The GeneSetDb Class](#the-genesetdb-class)
  + [5.1 Building a GeneSetDb](#building-a-genesetdb)
  + [5.2 Subsetting a GeneSetDb](#subsetting-a-genesetdb)
  + [5.3 Active vs Inactive Gene Sets](#active-vs-inactive-gene-sets)
  + [5.4 Accessing members of a gene set](#accessing-members-of-a-gene-set)
  + [5.5 Mapping of gene set featureIds to target expression containers](#mapping-of-gene-set-featureids-to-target-expression-containers)
* [6 Customizing Analyses](#customizing-analyses)
  + [6.1 Custom Differential Expression](#custom-differential-expression)
  + [6.2 Custom GSEA](#custom-gsea)
* [7 Reproducibility](#reproducibility)

# 1 Overview

The `{sparrow}` package was built to facilitate the use of gene sets in the
analysis of high throughput genomics data (primarily RNA-seq). It does so
by providing these top-line functionalities:

* The `seas` function is a wrapper that orchestrates the execution of any
  number of user-specified gene set enrichment analyses (GSEA) over a particular
  experimental contrast of interest. This will create a `SparrowResult`
  object which stores the results of each GSEA method internally, allowing
  for easy query and retrieval.
* A sister [`{sparrow.shiny}`](https://github.com/lianos/sparrow.shiny) package provides an `explore`
  function, which is invoked on `SparrowResult` objects returned from a call to
  `seas`. The shiny application facilitates interactive exploration of these
  GSEA results. This application can also be deployed to a shiny server and can
  be initialized by uploading a serialized `SparrowResult` `*.rds` file.
* An “over representation analysis” method `ora()` which wraps the biased
  enrichment functionality found within `limma::kegga` and generalizes it to
  work against data.frame inputs with arbitrary genesets.
* The `scoreSingleSamples` function is a wrapper that enables the user to
  generate single sample gene set scores using a variety of different
  single sample gene set scoring methods.
* Convenience gene set collection retrieval functions that return `BiocSet`s
  from widely used databases, like `getMSigCollection()` ([MSigDB](http://software.broadinstitute.org/gsea/msigdb/)),
  `getKeggCollection()` ([KEGG](https://www.genome.jp/kegg/)), `getPantherCollection()`
  ([PANTHER database](pantherdb)), and `getReactomeCollection()`
  ([Reactome](https://reactome.org/)) with support for different organisms and identifier
  types (partially).

The initial GSEA methods that sparrow wrapped were the ones provided by limma
and edgeR. As such, many analyses using sparrow expect you to re-use the same
data objects used for differential expression analysis, namely:

* Expression data (an `EList`, `DGEList`, or expression matrix)
* A design matrix
* A contrast vector/matrix (if your design and comparison require it)

Other methods only require the user to provide a ranked vector of statistics
that represent some differential expression statistic per gene, and the GSEA is
performed by analyzing the ranks of genes within this vector.

The user can invoke one `seas()` call that can orchestrate multiple analyses
of any type.

Currently supported gene set enrichment methods include:

```
##            method test_type package
## 1          camera preranked   limma
## 2        cameraPR preranked   limma
## 3           fgsea preranked   fgsea
## 4             ora       ora     ora
## 5             fry preranked   limma
## 6           roast preranked   limma
## 7           romer preranked   limma
## 8           goseq       ora   goseq
## 9     geneSetTest preranked   limma
## 10          logFC preranked   limma
## 11 svdGeneSetTest      meta sparrow
```

When using these methods in analyses that lead to publication, please cite
the original papers that developed these methods and cite sparrow when its
functionality assisted in your interpretation and analysis.

The sparrow package provides a small example expression dataset extracted from
the TCGA BRCA dataset, which is available via the `exampleExpressionSet`
function. In this vignette we will explore differential expression and gene
set enrichment analysis by examining differences between basal and her2 PAM50
subtypes.

# 2 Standard Workflow

Let’s begin by setting up our work environment for exploratory analysis using
the sparrow package.

```
library(sparrow)
library(magrittr)
library(dplyr)
library(ggplot2)
library(ComplexHeatmap)
library(circlize)
library(edgeR)
library(data.table)
theme_set(theme_bw())
```

Internally, sparrow leverages the
[data.table](https://CRAN.R-project.org/package%3Ddata.table) package for fast
indexing and manipulation over data.frames. All functions that return
data.frame looking objects back have converted it from an data.table prior
to return. All such functions take an `as.dt` argument, which is set to `FALSE`
by default that controls this behavior. If you want `{sparrow}` to return a
data.table back to you from some function, try adding an `as.dt = TRUE` argument
to the end of the function call.

## 2.1 Data Setup

sparrow is most straightforward to use when our data objects and analysis are
performed with either the edgeR or voom/limma pipelines and when we use standard
gene identifiers (like esnemble) as `rownames()` to these objects.

The `exampleExpressionSet` function gives us just such an object. We call it
below in a manner that gives us an object that allows us to explore expression
differences between different subtypes of breast cancer.

```
vm <- exampleExpressionSet(dataset = "tumor-subtype", do.voom = TRUE)
```

Below you’ll find the `$targets` data.frame of the voomed `EList`

```
vm$targets %>%
  select(Patient_ID, Cancer_Status, PAM50subtype)
```

```
##                                Patient_ID Cancer_Status PAM50subtype
## TCGA-A2-A0CM-01A-31R-A034-07 TCGA-A2-A0CM         tumor        Basal
## TCGA-BH-A0RX-01A-21R-A084-07 TCGA-BH-A0RX         tumor        Basal
## TCGA-BH-A18Q-01A-12R-A12D-07 TCGA-BH-A18Q         tumor        Basal
## TCGA-B6-A0RU-01A-11R-A084-07 TCGA-B6-A0RU         tumor        Basal
## TCGA-BH-A18P-01A-11R-A12D-07 TCGA-BH-A18P         tumor         Her2
## TCGA-C8-A275-01A-21R-A16F-07 TCGA-C8-A275         tumor         Her2
## TCGA-C8-A12Z-01A-11R-A115-07 TCGA-C8-A12Z         tumor         Her2
## TCGA-A2-A0T1-01A-21R-A084-07 TCGA-A2-A0T1         tumor         Her2
## TCGA-AC-A3OD-01A-11R-A21T-07 TCGA-AC-A3OD         tumor         LumA
## TCGA-AN-A0XS-01A-22R-A109-07 TCGA-AN-A0XS         tumor         LumA
## TCGA-A2-A0EM-01A-11R-A034-07 TCGA-A2-A0EM         tumor         LumA
## TCGA-AR-A24O-01A-11R-A169-07 TCGA-AR-A24O         tumor         LumA
## TCGA-D8-A4Z1-01A-21R-A266-07 TCGA-D8-A4Z1         tumor         LumA
```

Note that there are many tutorials online that outline how to generate expression matrices
for use with differential expression and analysis, such as the one that is returned from
the `exampleExpressionSet` function. Summarizing assay data into such a format is out
of scope for this vignette, but you can reference the
[airway vignette](http://bioconductor.org/packages/release/data/experiment/vignettes/airway/inst/doc/airway.html)
for full details (among others).

## 2.2 Data Analysis

We will identify the genes and genesets that are differentially expressed
between the basal and her2 subtypes. The `vm` object has already been `voom`d
using this design:

```
vm$design
```

```
##                              Basal Her2 LumA
## TCGA-A2-A0CM-01A-31R-A034-07     1    0    0
## TCGA-BH-A0RX-01A-21R-A084-07     1    0    0
## TCGA-BH-A18Q-01A-12R-A12D-07     1    0    0
## TCGA-B6-A0RU-01A-11R-A084-07     1    0    0
## TCGA-BH-A18P-01A-11R-A12D-07     0    1    0
## TCGA-C8-A275-01A-21R-A16F-07     0    1    0
## TCGA-C8-A12Z-01A-11R-A115-07     0    1    0
## TCGA-A2-A0T1-01A-21R-A084-07     0    1    0
## TCGA-AC-A3OD-01A-11R-A21T-07     0    0    1
## TCGA-AN-A0XS-01A-22R-A109-07     0    0    1
## TCGA-A2-A0EM-01A-11R-A034-07     0    0    1
## TCGA-AR-A24O-01A-11R-A169-07     0    0    1
## TCGA-D8-A4Z1-01A-21R-A266-07     0    0    1
## attr(,"assign")
## [1] 1 1 1
## attr(,"contrasts")
## attr(,"contrasts")$PAM50subtype
## [1] "contr.treatment"
```

We can test for differences between basla and her2 subtypes using the following
contrast:

```
(cm <- makeContrasts(BvH=Basal - Her2, levels=vm$design))
```

```
##        Contrasts
## Levels  BvH
##   Basal   1
##   Her2   -1
##   LumA    0
```

### 2.2.1 Differential Gene Expression

In this section, we first show you the straightforward analysis you would do
if you were only testing for differential gene expression.

With the data we have at hand, you would simply do the following:

```
fit <- lmFit(vm, vm$design) %>%
  contrasts.fit(cm) %>%
  eBayes
tt <- topTable(fit, 'BvH', n=Inf, sort.by='none')
```

### 2.2.2 Gene Set Enrichment Analysis

Given that we now have all of the pieces of data required for a differential
expression analysis, performing GSEA is trivial using the `seas` wrapper
function. We simply need to now define (1) the battery of gene sets we want to
test against, and (2) the GSEA methods we want to explore.

### 2.2.3 Gene Sets to Test

The *sparrow* package provides a `GeneSetDb` class to store collections of
gene sets. The `GeneSetDb` object is used heavily for the internal functionality
of `{sparrow}`, however you can provide sparrow with collections of gene sets
using other containers from the bioconductor universe, like a `BiocSet::BiocSet`
or a `GSEABase::GeneSetCollection`. This package provides convenience methods
to convert between these different types of gene set containers. Please refer
to *[The GeneSetDb Class](#the-genesetdb-class)* section for more details.

The {sparrow} package also provides convenience methods to retrieve gene set
collections from different sourckes, like [MSigDB](http://software.broadinstitute.org/gsea/msigdb/),
[PANTHER](http://pantherdb.org), [KEGG](https://www.genome.jp/kegg/), etc. These methods are named using the following
pattern: `get<CollectionName>Collection()` to return a `BiocSet` with the
gene sets from the collection, or `get<CollectionName>GeneSetDb()` to get
a `GeneSetDb` of the same.

We’ll use the `getMSigGeneSetDb` convenience function provided by the
*sparrow* package to load the [hallmark](http://www.cell.com/cell-systems/abstract/S2405-4712%2815%2900218-5) (`"h"`) and
[c2 (curated)](http://software.broadinstitute.org/gsea/msigdb/collections.jsp#C2) (`"c2"`) gene set collections from [MSigDB](http://software.broadinstitute.org/gsea/msigdb/).

Note that sparrow uses the {msigdbr} package to retrieve genesets from MSigDB.
To get access to all the genesets, you will have to also install the companion
{msigddf} package. As of Q1 2025, msigdbr only includes the Hallmark geneset
inside the package itself.

```
gdb <- getMSigGeneSetDb("H", "human", id.type = "entrez")
```

To retrieve a `BiocSet` of these same collections, you could do:

```
bsc <- getMSigCollection("H", "human", id.type = "entrez")
```

You can view a table of the gene sets defined inside a `GeneSetDb` (`gdb`)object
via its `geneSets(gdb)` accessor:

```
geneSets(gdb) %>%
  head %>%
  select(1:4)
```

```
##   collection                         name active   N
## 1          H        HALLMARK_ADIPOGENESIS  FALSE 200
## 2          H HALLMARK_ALLOGRAFT_REJECTION  FALSE 200
## 3          H   HALLMARK_ANDROGEN_RESPONSE  FALSE 101
## 4          H        HALLMARK_ANGIOGENESIS  FALSE  36
## 5          H     HALLMARK_APICAL_JUNCTION  FALSE 200
## 6          H      HALLMARK_APICAL_SURFACE  FALSE  44
```

## 2.3 Running sparrow

Performing multiple gene set enrichment analyses over your contrast of interest
simply requires you to provide a `GeneSetDb` (or `BiocSet`) object along with
your data and an enumeration of the methods you want to use in your analysis.

The call to `seas()` will perform these analyses and return a
`SparrowResult` object which you can then use for downstream analysis.

```
mg <- seas(
  vm, gdb, c('camera', 'fry', 'ora'),
  design = vm$design, contrast = cm[, 'BvH'],
  # these parameters define which genes are differentially expressed
  feature.max.padj = 0.05, feature.min.logFC = 1,
  # for camera:
  inter.gene.cor = 0.01,
  # specifies the numeric covariate to bias-correct for
  # "size" is found in the vm$genes data.frame, which makes its way to the
  # internal DGE statistics table ... more on that later
  feature.bias = "size")
```

We will unpack the details of the `seas()` call shortly …

## 2.4 Implicit Differential Expression

First, let’s note that in addition to running a plethora of GSEA’s over our data
we’ve also run a standard differential expression analysis. If you’ve passed
a `matrix`, `ExpressionSet` or `EList` into `seas()`, a *limma*-based
`lmFit %>% (eBayes|treat) %>% (topTable|topTreat)` pipeline was run. If a
`DGEList` was passed, then `seas` utilizes the *edgeR*-based
`glmQLFit %>% (glmQLFTest | glmTreat) %>% topTags` pipeline.

The result of the internally run differential expression analysis is accessible
via a call to `logFC` function on the `SparrowResult` object:

```
lfc <- logFC(mg)
lfc %>%
  select(symbol, entrez_id, logFC, t, pval, padj) %>%
  head
```

```
##         symbol entrez_id       logFC          t      pval      padj
## 1         A1BG         1  0.66809511  1.0780690 0.2988989 0.6868020
## 2          ADA       100  0.53929677  0.9257789 0.3699609 0.7409268
## 3         CDH2      1000 -0.08530258 -0.1032531 0.9191999 0.9789454
## 4         AKT3     10000  0.58364973  1.2961656 0.2155001 0.6135691
## 5 LOC100009676 100009676 -0.09578819 -0.2699158 0.7910912 0.9395252
## 6         MED6     10001  0.04470226  0.1497282 0.8830757 0.9701739
```

We can confirm that the statistics generated internally in `seas()` mimic our
explicit analysis above by verifying that the t-statistics generated by both
approaches are identical.

```
comp <- tt %>%
  select(entrez_id, logFC, t, pval=P.Value, padj=adj.P.Val) %>%
  inner_join(lfc, by='entrez_id', suffix=c('.tt', '.mg'))
all.equal(comp$t.tt, comp$t.mg)
```

```
## [1] TRUE
```

The internally performed differential expression analysis within the `seas()`
call can be customized almost as extensively as an explicitly performed analysis
that you would run using limma or edgeR by sending more parameters through
`seas()`’s `...` argument.

See the
*[Custom Differential Expression](#custom-differential-expression)*
section further in the vignette as well as the help available in
`?calculateIndividualLogFC` (which is called inside the `seas()` function)
for more information.

## 2.5 Explicit GSEA

We also have the results of all the GSEA analyses that we specified to our
`seas` call via the `methods` parameter.

```
mg
```

```
## SparrowResult (max FDR by collection set to 0.20%)
## ---------------------------------------------------
##   collection   method geneset_count sig_count sig_up sig_down
## 1          H   camera            50        13      9        4
## 2          H      fry            50         0      0        0
## 3          H      ora            50         3      1        2
## 4          H ora.down            50         4      1        3
## 5          H   ora.up            50         3      3        0
```

The table above enumerates the different GSEA methods run over each geneset
collection in the rows. The columns enumerate the number of genesets that the
collection has in total (`geneset_count`), and how many were found significant
at a given FDR, which is set to 20% by default. The `show` command for the
`SparrowResult` object simply calls the `tabulateResults()` function, which
you can call directly with the value of `max.p` that you might find more
appropriate.

## 2.6 Exploring Results

GSEA results can be examined interactively via the command line, or via a shiny
application. You can use the `resultNames` function to find out what GSEA
methods were run, and therefore available to you, within the the
`SparrowResult` object:

```
resultNames(mg)
```

```
## [1] "camera"   "fry"      "ora"      "ora.down" "ora.up"
```

Note that when running an “over representation analysis” `"ora"` (or `"goseq"`),
it will be run three different ways. The tests will be run first by testing
all differentially expressed genes that meet a given set of min logFC and
max FDR thresholds, then separately for only genes that go up in your contrast,
and a third time for only the genes that go down.

The individual gene set statistics generated by each method are available via
the `result` function (or several can be returned with `results`):

```
cam.res <- result(mg, 'camera')
cam.go.res <- results(mg, c('camera', 'ora.up'))
```

You can identify genesets with the strongest enrichment by filtering and sorting
against the appropriate columns. We can, for instance, identify which hallmark
gene sets show the strongest enrichment as follows:

```
cam.res %>%
  filter(padj < 0.1, collection == 'H') %>%
  arrange(desc(mean.logFC)) %>%
  select(name, n, mean.logFC, padj) %>%
  head
```

```
##                                  name   n mean.logFC         padj
## 1 HALLMARK_WNT_BETA_CATENIN_SIGNALING  37  0.4535764 8.013396e-02
## 2             HALLMARK_MYC_TARGETS_V2  58  0.4461725 5.212575e-05
## 3  HALLMARK_INTERFERON_ALPHA_RESPONSE  96  0.3926231 3.534538e-02
## 4                HALLMARK_E2F_TARGETS 200  0.3466647 5.212575e-05
## 5  HALLMARK_INTERFERON_GAMMA_RESPONSE 191  0.3124457 9.520918e-02
## 6             HALLMARK_MYC_TARGETS_V1 200  0.2093637 7.983604e-03
```

You can also list the members of a geneset and their individual differential
expression statistics for the contrast under test using the `geneSet` function.

```
geneSet(mg, name = 'HALLMARK_WNT_BETA_CATENIN_SIGNALING') %>%
  select(symbol, entrez_id, logFC, pval, padj) %>%
  head()
```

```
##   symbol entrez_id      logFC       pval      padj
## 1  HDAC5     10014  0.8982948 0.02248673 0.2537189
## 2 CSNK1E      1454 -0.1795903 0.52022309 0.8320023
## 3 CTNNB1      1499  0.2550459 0.55233192 0.8481070
## 4   JAG1       182  0.7294585 0.02484332 0.2637074
## 5   DVL2      1856  0.4922199 0.24201091 0.6362804
## 6   DKK1     22943  0.6592946 0.66544200 0.8974061
```

The results provided in the table generated from a call to `geneSet` are
independant of GSEA method. The statistics appended to the gene set members
are simply the ones generated from a differential expression analysis.

## 2.7 Plotting

`{sparrow}` provides a number of interactive plotting facilities to explore the
enrichment of a single geneset under the given contrast. In the boxplots and
density plots shown below, the log fold changes (logFCs) (or t-statistics) for
all genes under the contrast are visualized in the “background” set, and these
same values are shown for the desired geneset under the “geneset” group.

The logFC (or t-statistics) of the genes in the gene set are plotted as points,
which allow you to hover to identify the identity of the genes that land in
the regions of the distributions you care about.

Including interactive plots increases the size of the vignette’s by *a lot* and
will be rejected by the bioconductor build servers, so all plots included in
this vignette are static snapshots of the javascript enabled plots you would
normally get from `iplot()`.

**Boxplot**

```
iplot(mg, 'HALLMARK_WNT_BETA_CATENIN_SIGNALING',
      type = 'boxplot', value = 'logFC')
```

![](data:image/png;base64...)

boxplot of geneset log2FC’s

**Density**

```
iplot(mg, 'HALLMARK_WNT_BETA_CATENIN_SIGNALING',
      type = 'density', value = 'logFC')
```

![](data:image/png;base64...)

density plot of geneset log2FC’s

**GSEA plot**

```
iplot(mg, 'HALLMARK_WNT_BETA_CATENIN_SIGNALING',
      type = 'gsea', value = 'logFC')
```

![](data:image/png;base64...)

gsea plot of geneset log2FC’s

### 2.7.1 Interactive Exploration

A sister [`{sparrow.shiny}`](https://github.com/lianos/sparrow.shiny) package is available that can be used
to interactively explore `SparrowResult` objects to help you try to make sense
of the enrichment hits you get (or not!). The application can be invoked as
follows:

```
sparrow.shiny::explore(mg)
```

![](data:image/png;base64...)

Screen shot of interactive sparrow exploration

Please refer to the `"sparrow-shiny"` vignette in the
[`{sparrow.shiny}`](https://github.com/lianos/sparrow.shiny) package for documentation on the application’s
use.

The `{sparrow.shiny}` package is currently only available to install from
GitHub, but will be available through Bioconductor soon.

# 3 Singe Sample Gene Set Scoring

It can be both convenient and effective to transform a gene-by-sample expression
matrix to a geneset-by-sample expression matrix. By doing so, so we can quickly
identify biological processes that are up/down regulated (loosely speaking) in
each sample.

We can generate single sample gene set scores using the gene sets defined in a
`GeneSetDb` using the `scoreSingleSamples` function. This function takes a
`GeneSetDb`, an expression container, and a `methods` argument, which is
analagous to the `methods` argument in the `seas()` call: it defines
all of the scoring methos the user wants to apply to each sample.

Let’s pick a few gene sets to score our samples with for this exercise. We’ll
take the significant hallmark gene sets, or any other significant gene set that
has a large (on average) log fold change between conditions.

```
sig.res <- cam.res %>%
  filter(padj < 0.05 & (grepl("HALLMARK", name) | abs(mean.logFC) >= 2))
gdb.sub <- gdb[geneSets(gdb)$name %in% sig.res$name]
```

Refer to the [Subsetting a GeneSetDb](#subsetting-a-genesetdb) section to
learn how to subset a `GeneSetDb` object to create a derivative object with
fewer gene sets.

Recall that the GSEA analysis we performed was perfomed between the Basal and
Her2 subtypes, so we will use an expression matrix that only has the samples
from those two groups.

```
vm.bh <- vm[, vm$targets$PAM50subtype %in% c("Basal", "Her2")]
```

## 3.1 Generating Single Sample Gene Set Scores

Once we have a `GeneSetDb` object that contains all of the gene sets we wish
to use to create single sample gene set scores, we can use the
`scoreSingleSamples` function to produce these scores using a variety of
algorithmes, which the user species using the `methods` parameter.

The `scoreSingleSamples` function will return a long `data.frame` with
`length(methods) * ncol(exprs)` rows. Each row represents the score for the
given `sample` using the specified `method`. You can subset against the `method`
column to extract all of the single sample scores for a given method.

```
scores <- scoreSingleSamples(gdb.sub, vm.bh,
                             methods = c('ewm', 'ssgsea', 'zscore'),
                             ssgsea.norm = TRUE, unscale=FALSE, uncenter=FALSE,
                             as.dt = TRUE)
```

We can see how the scores from different methods compare to each other:

```
# We miss you, reshape2::acast
sw <- dcast(scores, name + sample_id ~ method, value.var="score")
corplot(sw[, -(1:2), with = FALSE], cluster=TRUE)
```

![](data:image/png;base64...)

It is, perhaps, interesting to compare how the `ewm` method scores change when
we choose not to “uncenter” and “unscale” them:

```
ewmu <- scoreSingleSamples(gdb.sub, vm.bh,methods = "ewm",
                           unscale = TRUE, uncenter = TRUE, as.dt = TRUE)
ewmu[, method := "ewm_unscale"]
scores.all <- rbind(scores, ewmu)
swa <- dcast(scores.all, name + sample_id ~ method, value.var="score")
corplot(swa[, -(1:2), with = FALSE], cluster=TRUE)
```

![](data:image/png;base64...)

Further exposition on the “ewm” (eigenWeightedMean) scoring method can be
found in the `?eigenWeightedMean` function.

## 3.2 Visualizing Single Sample Gene Set Scores

The “long” data.frame nature of the results produced by `scoreSingleSamples`
makes it convenient to use with graphing libraries like ggplot2 so that we can
create arbitrary visualizations. Creating boxplots for gene sets per subtype
is an easy way to explore these results.

Let’s annotate each row in `scores.all` with the subtype annotation and observe
how these methods score each sample for a few gene sets.

```
all.scores <- scores.all %>%
  inner_join(select(vm.bh$targets, sample_id=Sample_ID, subtype=PAM50subtype),
             by = "sample_id")

some.scores <- all.scores %>%
  filter(name %in% head(unique(all.scores$name), 5))

ggplot(some.scores, aes(subtype, score)) +
  geom_boxplot(outlier.shape=NA) +
  geom_jitter(width=0.25) +
  facet_grid(name ~ method)
```

![](data:image/png;base64...)

# 4 Gene Set Based Heatmap with mgheatmap

We often want to create expression based heatmaps that highlight the behavior of
gene sets across our samples. The `mgheatmap` function uses the
[ComplexHeatmap](http://bioconductor.org/packages/ComplexHeatmap) package to create two different types of heatmaps:

1. Gene based heatmaps, that split the genes (rows) based on their genesets
2. Single sample gene set based heatmaps, optionally split by gene set
   collection.

The `mgheatmap` function has a set of arguments that customize how the heatmap
is to be created (gene level vs. gene set level, whether to split it, etcv) and
will also use the `...` argument to pass any parameters down to the inner
`ComplexHeatmap::Heatmap` function call and customize its behavior. The
`mgheatmap` function returns a `ComplexHeatmap,Heatmap` object for plotting
or combining with other ComplexHeatmap heatmaps or annotations in order to
create arbitrarily complex/informative heatmap figures.

## 4.1 Gene level based heatmap (from genesets)

You can plot a heatmap of the genes from a predefined set of gene sets by
providing the gene sets you want to visualize in a `GeneSetDb` object.

We’ll create a new `GeneSetDb` object using the first two gene sets in `gdb.sub`
and draw a heatmap of their expression.

```
gs.sub <- geneSets(gdb.sub)
gdb.2 <- gdb.sub[geneSets(gdb.sub)$name %in% head(gs.sub$name, 2)]

col.anno <- HeatmapAnnotation(
  df = vm.bh$targets[, 'PAM50subtype', drop = FALSE],
  col = list(PAM50subtype = c(Basal = "gray", Her2 = "black")))

mgheatmap(vm.bh, gdb.2, aggregate.by = "none", split = TRUE,
          show_row_names = FALSE, show_column_names = FALSE,
          recenter = TRUE, top_annotation = col.anno, zlim = c(-3, 3))
```

![](data:image/png;base64...)

## 4.2 Gene set-based heatmap

You can often get a higher information:ink ratio by plotting heatmaps based
on single sample gene set scores as opposed to the genes that make up a
geneset.

Let’s see what the simple 2-geneset version of the heatmap above looks like:

```
mgheatmap(vm.bh, gdb.2, aggregate.by = "ewm", split = FALSE,
          show_row_names = TRUE, show_column_names = FALSE,
          top_annotation = col.anno)
```

![](data:image/png;base64...)

Plotted in this way, we can now show the activity of a greater number of
genesets

```
mgheatmap(vm.bh, gdb.sub,
          aggregate.by = 'ewm', split=TRUE, recenter = TRUE,
          show_row_names=TRUE, show_column_names=FALSE,
          top_annotation=col.anno, zlim = c(-2.5, 2.5))
```

![](data:image/png;base64...)

# 5 The GeneSetDb Class

The GeneSetDb class was developed to address the internal needs of the sparrow
package for fast look up, subsetting, cross reference, etc. of a collection of
gene sets. At the time (~2015), it was developed because the classes used for
this purpose in the bioconductor ecosystem (a `GSEABase::GeneSetCollection`,
or a simple list of gene vectors) didn’t cut the mustard.

More recently, bioc-core has developed a new class called a `BiocSet` that is
feature-rich and shares significant overlap with the features in the
`sparrow::GeneSetDb` class. Although we can’t quite replace the internals of
{sparrow} to use the `BiocSet` just yet, users are encouraged to provide
collections of gene sets in the form of a `BiocSet` everywhere {sparrow}
functions require gene set collections, like `seas()` and
`scoreSingleSamples()`. You can also convert a `sparrow::GeneSetDb()` to a
`BiocSet` via a simple call: `as(gdb, "BiocSet")`.

The remainder of this section provides a quick overview of the `GeneSetDb`
class.

The GeneSetDb object uses the `data.table` package internally for fast lookup.
Internally the collection of gene set information is minimally stored as a
three-column `data.table` in “long form”, which has the following columns:

* collection
* name
* feature\_id

More columns can be added to the internal `data.table` (a “symbol” column,
for instance), but those are the only three you need.

To see what we are talking about, exactly, you can call the `as.data.frame`
function on a `GeneSetDb` object:

```
as.data.frame(gdb)[c(1:5, 201:205),]
```

```
##     collection                         name feature_id symbol
## 1            H        HALLMARK_ADIPOGENESIS      10010   TANK
## 2            H        HALLMARK_ADIPOGENESIS      10113   PREB
## 3            H        HALLMARK_ADIPOGENESIS      10124  ARL4A
## 4            H        HALLMARK_ADIPOGENESIS      10140   TOB1
## 5            H        HALLMARK_ADIPOGENESIS      10162 LPCAT3
## 201          H HALLMARK_ALLOGRAFT_REJECTION      10006   ABI1
## 202          H HALLMARK_ALLOGRAFT_REJECTION      10225   CD96
## 203          H HALLMARK_ALLOGRAFT_REJECTION      10261  IGSF6
## 204          H HALLMARK_ALLOGRAFT_REJECTION       1029 CDKN2A
## 205          H HALLMARK_ALLOGRAFT_REJECTION      10333   TLR6
```

The `(collection,name)` tuple is the primary key of a gene set. The `feature_id`
column stores gene identifiers. For the time being, it will be most natural
for these IDs to simply be ensembl gene identifiers (or entrez ids) as many of
the annotation databases use these identifiers, as well. In reality, you will
want the values in the `feature_id` columns to match with the feature id’s
you have in your data container (ie. the `rownames()` of a
`SummarizedExperiment`, for instance).

## 5.1 Building a GeneSetDb

The sparrow package provides convenience functions to fetch genesets from many
sources and convert them into a GeneSetDb object. The two most useful sources
may be:

* [MSigDB](http://software.broadinstitute.org/gsea/msigdb/) via `getMSigGeneSetDb(...)`. Although the core `sparrow`
  package provides the getter function for these genesets, the main data
  retrieval functionality is provided through the [msigdbr](https://cran.r-project.org/package%3Dmsigdbr) package.
* [PANTHER](http://pantherdb.org) (pathways and GOSLIM) via `getPantherGeneSetDb()`
* [KEGG](https://www.genome.jp/kegg/) via `getKeggGeneSetDb(...)`

We also provide similarly named methos to retrieve these gene set collections
as a `BiocSet`, just substitute `"Collection"` for `"GeneSetDb"`, ie.
`getMsigCollection(...)`, `getPantherCollection(...)`, and
`getKeggCollection(...)`.

You can create a custom `GeneSetDb` via the `GeneSetDb()` constructor, which
accepts the following types of inputs.

1. A `BiocSet`
2. A `GeneSetCollection`
3. A data.frame of geneset membership. This requires `collection`, `name`, and
   `feature_id` columns. Reference the output of `as.data.frame(gdb)` shown
   above.
4. A named list of gene identifier vectors that represent genesets for a
   single collection
5. A named list of (2)-like lists. The top level names are the names of the
   different collections, and each sublist represents the genesets in that
   collection.

Two `GeneSetDb` objects can be combined using the `cobine()` function. For now
it is your responsibility to ensure that the two `GeneSetDb` objects are
“reasonably conformable”, ie. they use the same types of gene identifiers, and
are referencing the same species, etc.

```
msigdb <- getMSigGeneSetDb('H', 'human')
goslimdb <- getPantherGeneSetDb('goslim', 'human')
gdb.uber <- combine(msigdb, goslimdb)
```

See the help and examples in `?GeneSetDb` for more information.

For some reason the `PANTHER.db` package needs to be installed in a
user-writable package location for this to work properly. If you see an error
that speaks to using “rsqlite to write to a readonly database”, you will have to
re-install `PANTHER.db` in a user-writable directory using
`BiocManager::install("PANTHER.db")`

## 5.2 Subsetting a GeneSetDb

The subsetting functionality for a `GeneSetDb` is a bit clunky. We assume
you want to subset a GeneSetDb to include a subset of, well, gene sets.

One way you can do that is to provide a logical vector that is as long as there
are gene sets in the GeneSetDb as an index.

Let’s say we just want to keep genesets that have fewer than 100 genes.

```
keep <- geneSets(gdb)$N < 100
gdb.sub <- gdb[keep]
geneSets(gdb.sub) |> head()
```

```
##   collection                               name active  N  n subcollection
## 1          H              HALLMARK_ANGIOGENESIS  FALSE 36 NA
## 2          H            HALLMARK_APICAL_SURFACE  FALSE 44 NA
## 3          H   HALLMARK_CHOLESTEROL_HOMEOSTASIS  FALSE 74 NA
## 4          H        HALLMARK_HEDGEHOG_SIGNALING  FALSE 36 NA
## 5          H   HALLMARK_IL6_JAK_STAT3_SIGNALING  FALSE 87 NA
## 6          H HALLMARK_INTERFERON_ALPHA_RESPONSE  FALSE 97 NA
##   collection_name geneset_id geneset_url msigdb_collection db_species gs_id
## 1        Hallmark      M5944                             H         HS M5944
## 2        Hallmark      M5916                             H         HS M5916
## 3        Hallmark      M5892                             H         HS M5892
## 4        Hallmark      M5919                             H         HS M5919
## 5        Hallmark      M5897                             H         HS M5897
## 6        Hallmark      M5911                             H         HS M5911
```

You can also subset a `GeneSetDb` to only include gene sets that contain
certain features:

```
gdb.sub2 <- subsetByFeatures(gdb, c('3417', '4609'))
nrow(gdb); nrow(gdb.sub2)
```

```
## [1] 50
```

```
## [1] 18
```

## 5.3 Active vs Inactive Gene Sets

A `GeneSetDb` is used to hold “the universe” of genes that belong to different
gene sets across different collections. Depending on the assay performed to
measure these genes, the set of genes you observe in your study will likely
be a subset of the genes in the `GeneSetDb`. As such, prior to using a
`GeneSetDb` for GSEA, it must be “conformed” to a target object that will be
used for the input to the GESA (either a matrix of expression, or a pre ranked
vector of statistics). This step will index into the target expression object
and identify which rows of the object correspond to which genes in the
`GeneSetDb`.

“Conformation” happens automatically within the `seas()` call, but we call it
explicitly below to outline its functionality. The command below conforms
the `GeneSetDb` to our target “voomed” `EList`, and deactivates gene sets
(i.e. removes them from downstream GSEA) that have less than 10 or more than 100
genes that were found in `vm`:

```
gdbc <- conform(gdb, vm, min.gs.size=10, max.gs.size=100)
head(geneSets(gdbc, active.only=FALSE))
```

```
##   collection                         name active   N   n subcollection
## 1          H        HALLMARK_ADIPOGENESIS  FALSE 200 198
## 2          H HALLMARK_ALLOGRAFT_REJECTION  FALSE 200 167
## 3          H   HALLMARK_ANDROGEN_RESPONSE   TRUE 101  99
## 4          H        HALLMARK_ANGIOGENESIS   TRUE  36  31
## 5          H     HALLMARK_APICAL_JUNCTION  FALSE 200 179
## 6          H      HALLMARK_APICAL_SURFACE   TRUE  44  37
##   collection_name geneset_id geneset_url msigdb_collection db_species gs_id
## 1        Hallmark      M5905                             H         HS M5905
## 2        Hallmark      M5950                             H         HS M5950
## 3        Hallmark      M5908                             H         HS M5908
## 4        Hallmark      M5944                             H         HS M5944
## 5        Hallmark      M5915                             H         HS M5915
## 6        Hallmark      M5916                             H         HS M5916
```

We can see that, only 23 of the 26 genes in the
`(C2,ABBUD_LIF_SIGNALING_1_DN)` were found in the rows of `vm`, and the `(C2,ABBUD_LIF_SIGNALING_2_DN)` was “deactivated.” Deactivated
(`active == FALSE`) gene sets will be ignored during downstream analyses. This
gene set was deactivated because it only has five “conformed” genes, but the
minimum geneset size we wanted to consider (`min.gs.size`) was set to ten in
our call to `conform`.

## 5.4 Accessing members of a gene set

The `geneSet` and `featureIds` functions allow the user to identify the genes
found in a gene set. Both of these functions take an `active.only` argument,
which is `TRUE` by default. This specifies that only the genes that have been
successfully conformed to a gene set should be the ones that are returned.

For instance, we can identify which genes belong to the
`(C2,ABBUD_LIF_SIGNALING_1_DN)`, and which three were not found in `vm` like so:

```
missed <- setdiff(
  featureIds(gdbc, 'H', 'HALLMARK_WNT_BETA_CATENIN_SIGNALING', active.only=FALSE),
  featureIds(gdbc, 'H', 'HALLMARK_WNT_BETA_CATENIN_SIGNALING', active.only=TRUE))
missed
```

```
## [1] "10023" "27121" "7471"  "7475"  "85407"
```

or we can use the `geneSet` function to return a `data.frame` of these results:

```
gdbc %>%
  geneSet('H', 'HALLMARK_WNT_BETA_CATENIN_SIGNALING', active.only = FALSE) %>%
  subset(feature_id %in% missed)
```

```
##    collection                                name active  N  n feature_id
## 2           H HALLMARK_WNT_BETA_CATENIN_SIGNALING   TRUE 42 37      10023
## 12          H HALLMARK_WNT_BETA_CATENIN_SIGNALING   TRUE 42 37      27121
## 29          H HALLMARK_WNT_BETA_CATENIN_SIGNALING   TRUE 42 37       7471
## 30          H HALLMARK_WNT_BETA_CATENIN_SIGNALING   TRUE 42 37       7475
## 38          H HALLMARK_WNT_BETA_CATENIN_SIGNALING   TRUE 42 37      85407
##    symbol
## 2   FRAT1
## 12   DKK4
## 29   WNT1
## 30   WNT6
## 38   NKD1
```

## 5.5 Mapping of gene set featureIds to target expression containers

It may be that the IDs used in a gene set collection are different from the
ones used as the rownames of your expression container. For instance, the IDs
used for a given gene set collection in the `GeneSetDb` might be
Ensembl gene identifiers, but the rownames of the expression object might
be Entrez ID. This is where the `mapping` parameter becomes useful.

The `GeneSetDb` class has a concept of an internal `featureIdMap` to accommodate
these scenarios, which would allow for a non-destructive mapping of the original
IDs to a new “ID space” (entrez to ensembl, for instance).

This functionality is not ready for this release, but it’s just a note to keep
the user aware of some future development of the package. For the
time being, the user is required to manually map the feautreIds in their
expression matrix to be concordant with the ones found in the `GeneSetDb`.

**In the meantime**, a `renameRows` convenience function is provided here
to easily rename the rows of our expression container to different values.
For instance, to rename this is how you might rename the rows of your assay
container to use symbols:

```
vm <- exampleExpressionSet()
vms <- renameRows(vm, "symbol")
head(cbind(rownames(vm), rownames(vms)))
```

```
##      [,1]        [,2]
## [1,] "1"         "A1BG"
## [2,] "100"       "ADA"
## [3,] "1000"      "CDH2"
## [4,] "10000"     "AKT3"
## [5,] "100009676" "LOC100009676"
## [6,] "10001"     "MED6"
```

We grabbed the `symbol` column from `vm$genes` and “smartly” renamed the rows
of `vm` with the values there. Refer to the `?renameRows` man page for more
details. This, of course, still requires you to manually fetch and map
identifiers, but still …

# 6 Customizing Analyses

The internal differential expression analysis as well the gene set enrichment
analyses can be customized by passing parameters through the `...` in the
`seas()` function.

## 6.1 Custom Differential Expression

The internal differential expression pipeline, exported via the
`calculateIndividualLogFC` function allows the end user to configure an
“arbitrarily complex” differential expression analysis using either edgeR’s
quasilikelihood framework (if the input is a DGEList) or a direct limma
analysis (with a pre-voomed EList, expression matrix, or whatever).

User’s should refer to the `?calculateIndividualLogFC` help page to see
which parameters are exposed for a differential expression analysis and
configure them accordingly. When calling `seas()` use these same parameters
in the call and they will be provided to `calculateIndividualLogFC`.

For instance, if you wanted to use limma’s “treat” functionality to specify
a minimal log fold change threshold for statistical significance, you would do
so as follows:

```
mg <- seas(vm, gdb, "goseq", design = vm$design, cm[, 'BvH'],
           treat.lfc=log2(1.5),
           ## feature length vector required for goseq
           feature.bias=setNames(vm$genes$size, rownames(vm)))
```

Using the internal `treat` functionality would really only affect enrichment
tests that first threshold the genes in your experiment as “significant” or not,
like `goseq` and not tests like `camera`.

## 6.2 Custom GSEA

The GSEA methods that are wrapped by `seas()` all take the same parameters
that are defined by their implementation. Simply pass these parameters down
via the `...` in the `seas()` call.

For instance, you can read `?camera` to find that the `camera` method accepts an
`inter.gene.cor` parameter, and `?roast` will tell you that you can specify
the number of rotations used via the `nrot` parameter.

```
mgx <- seas(vm, gdb, c('camera', 'roast'),
            design = vm$design, contrast = cm[, 'BvH'],
            inter.gene.cor = 0.04, nrot = 500)
```

# 7 Reproducibility

Session Information

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
## [1] grid      stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] data.table_1.17.8     edgeR_4.8.0           limma_3.66.0
##  [4] circlize_0.4.16       ComplexHeatmap_2.26.0 ggplot2_4.0.0
##  [7] dplyr_1.1.4           magrittr_2.0.4        sparrow_1.16.0
## [10] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] DBI_1.2.3                   gridExtra_2.3
##   [3] BiasedUrn_2.0.12            GSEABase_1.72.0
##   [5] BiocSet_1.24.0              rlang_1.1.6
##   [7] clue_0.3-66                 GetoptLong_1.0.5
##   [9] msigdbr_25.1.1              matrixStats_1.5.0
##  [11] compiler_4.5.1              RSQLite_2.4.3
##  [13] DelayedMatrixStats_1.32.0   png_0.1-8
##  [15] vctrs_0.6.5                 SpatialExperiment_1.20.0
##  [17] pkgconfig_2.0.3             shape_1.4.6.1
##  [19] crayon_1.5.3                fastmap_1.2.0
##  [21] magick_2.9.0                backports_1.5.0
##  [23] XVector_0.50.0              labeling_0.4.3
##  [25] rmarkdown_2.30              graph_1.88.0
##  [27] tinytex_0.57                purrr_1.1.0
##  [29] bit_4.6.0                   xfun_0.53
##  [31] beachmat_2.26.0             cachem_1.1.0
##  [33] jsonlite_2.0.0              blob_1.2.4
##  [35] rhdf5filters_1.22.0         DelayedArray_0.36.0
##  [37] Rhdf5lib_1.32.0             BiocParallel_1.44.0
##  [39] irlba_2.3.5.1               parallel_4.5.1
##  [41] cluster_2.1.8.1             R6_2.6.1
##  [43] bslib_0.9.0                 RColorBrewer_1.1-3
##  [45] GenomicRanges_1.62.0        jquerylib_0.1.4
##  [47] SummarizedExperiment_1.40.0 assertthat_0.2.1
##  [49] Rcpp_1.1.0                  Seqinfo_1.0.0
##  [51] bookdown_0.45               iterators_1.0.14
##  [53] knitr_1.50                  GSVA_2.4.0
##  [55] IRanges_2.44.0              Matrix_1.7-4
##  [57] tidyselect_1.2.1            abind_1.4-8
##  [59] dichromat_2.0-0.1           yaml_2.3.10
##  [61] viridis_0.6.5               doParallel_1.0.17
##  [63] codetools_0.2-20            curl_7.0.0
##  [65] lattice_0.22-7              tibble_3.3.0
##  [67] plyr_1.8.9                  Biobase_2.70.0
##  [69] withr_3.0.2                 KEGGREST_1.50.0
##  [71] S7_0.2.0                    evaluate_1.0.5
##  [73] ontologyIndex_2.12          Biostrings_2.78.0
##  [75] pillar_1.11.1               BiocManager_1.30.26
##  [77] MatrixGenerics_1.22.0       checkmate_2.3.3
##  [79] foreach_1.5.2               stats4_4.5.1
##  [81] plotly_4.11.0               generics_0.1.4
##  [83] S4Vectors_0.48.0            sparseMatrixStats_1.22.0
##  [85] scales_1.4.0                xtable_1.8-4
##  [87] glue_1.8.0                  lazyeval_0.2.2
##  [89] tools_4.5.1                 BiocIO_1.20.0
##  [91] ScaledMatrix_1.18.0         annotate_1.88.0
##  [93] locfit_1.5-9.12             babelgene_22.9
##  [95] XML_3.99-0.19               Cairo_1.7-0
##  [97] rhdf5_2.54.0                tidyr_1.3.1
##  [99] SingleCellExperiment_1.32.0 AnnotationDbi_1.72.0
## [101] colorspace_2.1-2            HDF5Array_1.38.0
## [103] BiocSingular_1.26.0         rsvd_1.0.5
## [105] cli_3.6.5                   S4Arrays_1.10.0
## [107] viridisLite_0.4.2           gtable_0.3.6
## [109] sass_0.4.10                 digest_0.6.37
## [111] BiocGenerics_0.56.0         SparseArray_1.10.0
## [113] rjson_0.2.23                htmlwidgets_1.6.4
## [115] farver_2.1.2                memoise_2.0.1
## [117] htmltools_0.5.8.1           lifecycle_1.0.4
## [119] h5mread_1.2.0               httr_1.4.7
## [121] GlobalOptions_0.1.2         statmod_1.5.1
## [123] bit64_4.6.0-1
```