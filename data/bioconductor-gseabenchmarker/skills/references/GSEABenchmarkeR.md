# Reproducible GSEA Benchmarking

Ludwig Geistlinger1\*

1Center for Computational Biomedicine, Harvard Medical School

\*ludwig\_geistlinger@hms.harvard.edu

#### 30 October 2025

#### Abstract

The *GSEABenchmarkeR* package implements an extendable framework for reproducible evaluation of set- and network-based methods for enrichment analysis of gene expression data. This includes support for the efficient execution of these methods on comprehensive real data compendia (microarray and RNA-seq) using parallel computation on standard workstations and institutional computer grids. Methods can then be assessed with respect to runtime, statistical significance, and relevance of the results for the phenotypes investigated.

#### Package

GSEABenchmarkeR 1.30.0

# Contents

* [1 Purpose of the package](#purpose-of-the-package)
* [2 Setup](#setup)
* [3 Expression data sources](#expression-data-sources)
  + [3.1 Microarray compendium](#microarray-compendium)
  + [3.2 RNA-seq compendium](#rna-seq-compendium)
  + [3.3 User-defined data compendium](#user-defined-data-compendium)
* [4 Differential expression](#differential-expression)
* [5 Enrichment analysis](#enrichment-analysis)
  + [5.1 User-defined enrichment methods](#user-defined-enrichment-methods)
* [6 Benchmarking](#benchmarking)
  + [6.1 Runtime](#runtime)
  + [6.2 Fraction of significant gene sets](#fraction-of-significant-gene-sets)
  + [6.3 Phenotype relevance](#phenotype-relevance)
* [7 Advanced](#advanced)
  + [7.1 Caching](#caching)
  + [7.2 Parallel computation](#parallel-computation)

# 1 Purpose of the package

The purpose of the *[GSEABenchmarkeR](https://bioconductor.org/packages/3.22/GSEABenchmarkeR)* package is to compare the performance
of different methods for gene set enrichment analysis across many gene expression
datasets.

Users interested in conducting gene set enrichment analysis for a specific dataset
of choice are recommended to use the *[EnrichmentBrowser](https://bioconductor.org/packages/3.22/EnrichmentBrowser)* package instead.

In other words,

* if you are interested in analysing a particular microarray or RNA-seq dataset,
  e.g. a case-control study where you want to find out which GO terms / KEGG pathways
  are enriched for differentially expressed genes, i.e. your primary goal is *biological
  interpretation of a specific dataset under investigation*, then use the
  *[EnrichmentBrowser](https://bioconductor.org/packages/3.22/EnrichmentBrowser)* package.
* if you want to assess the performance (runtime, type I error rate, etc) of
  different enrichment methods across many datasets and in certain simulated setups -
  i.e. your primary goal is to *understand methodological aspects and compare methods against each other*,
  then use the *[GSEABenchmarkeR](https://bioconductor.org/packages/3.22/GSEABenchmarkeR)* package.

# 2 Setup

Although gene set enrichment analysis (GSEA) has become an integral part of
high-throughput gene expression data analysis, the assessment of enrichment
methods remains rudimentary and *ad hoc*.
In the absence of suitable gold standards, the evaluation is commonly restricted
to selected data sets and biological reasoning on the relevance of resulting
enriched gene sets.
However, this is typically incomplete and biased towards a novel method being
presented.

As the evaluation of GSEA methods is thus typically based on self-defined
standards, [Mitrea et al. (2013)](https://doi.org/10.3389/fphys.2013.00278)
identified the lack of gold standards for consistent assessment and comparison
of enrichment methods as a major bottleneck.
Furthermore, it is often cumbersome to reproduce existing assessments for
additional methods, as this typically involves considerable effort of data
processing and method collection.

Leveraging the representative and extendable collection of
enrichment methods available in the *[EnrichmentBrowser](https://bioconductor.org/packages/3.22/EnrichmentBrowser)* package,
the *[GSEABenchmarkeR](https://bioconductor.org/packages/3.22/GSEABenchmarkeR)* package facilitates efficient execution
of these methods on comprehensive real data compendia.
The compendia are curated collections of microarray and RNA-seq datasets
investigating human diseases (mostly specific cancer types), for which
disease-relevant gene sets have been defined *a priori*.

Consistently applied to these datasets, enrichment methods can then be subjected
to a systematic and reproducible assessment of *(i)* computational runtime,
*(ii)* statistical significance, especially how the fraction of
significant gene sets relates to the fraction of differentially expressed genes,
and *(iii)* phenotype relevance, i.e. whether enrichment methods produce gene set
rankings in which phenotype-relevant gene sets accumulate at the top.

In the following, we demonstrate how the package can be used to

* load specific pre-defined and user-defined data compendia,
* carry out differential expression analysis across datasets,
* apply enrichment methods to multiple datasets, and
* benchmark results with respect to the chosen criteria.

We start by loading the package.

```
library(GSEABenchmarkeR)
```

# 3 Expression data sources

The *[GSEABenchmarkeR](https://bioconductor.org/packages/3.22/GSEABenchmarkeR)* package implements a general interface for
loading compendia of expression datasets.
This includes

* the pre-defined GEO2KEGG microarray compendium that consists of 42 datasets
  investigating a total of 19 different human diseases as collected by
  Tarca et al. ([2012](https://doi.org/10.1186/1471-2105-13-136) and
  [2013](https://doi.org/10.1371/journal.pone.0079217)),
* the pre-defined TCGA RNA-seq compendium, consisting of datasets from
  [The Cancer Genome Atlas](https://cancergenome.nih.gov)
  investigating a total of 34 different cancer types, and
* user-defined data from file.

In the following, we describe both pre-defined compendia in more detail and also
demonstrate how user-defined data can be incorporated.

## 3.1 Microarray compendium

Although RNA-seq (read count data) has become the *de facto* standard for
transcriptomic profiling, it is important to know that many methods for
differential expression and gene set enrichment analysis have been originally
developed for microarray data (intensity measurements).
However, differences in data distribution assumptions (microarray: quasi-normal,
RNA-seq: negative binomial) have made adaptations in differential expression
analysis and, to some extent also in gene set enrichment analysis, necessary.

Nevertheless, the comprehensive collection and curation of microarray data in
online repositories such as [GEO](https://www.ncbi.nlm.nih.gov/geo) still
represent a valuable resource.
In particular, Tarca et al. ([2012](https://doi.org/10.1186/1471-2105-13-136)
and [2013](https://doi.org/10.1371/journal.pone.0079217)) compiled 42 datasets
from GEO, each investigating a human disease for which a specific
[KEGG](http://www.genome.jp/kegg) pathway exists.

These pathways are accordingly defined as the target pathways for the various
enrichment methods when applied to the respective datasets. For instance,
methods are expected to rank the
[Alzheimer’s disease pathway](http://www.genome.jp/kegg-bin/show_pathway?hsa05010)
close to the top when applied to
[GSE1297](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE1297),
a case-control study of Alzheimer’s disease.

Furthermore, Tarca et al. made these datasets available in the *Bioconductor*
packages *[KEGGdzPathwaysGEO](https://bioconductor.org/packages/3.22/KEGGdzPathwaysGEO)* and
*[KEGGandMetacoreDzPathwaysGEO](https://bioconductor.org/packages/3.22/KEGGandMetacoreDzPathwaysGEO)*.

The *[GSEABenchmarkeR](https://bioconductor.org/packages/3.22/GSEABenchmarkeR)* package simplifies access to the compendium
and allows to load it into the workspace via

```
geo2kegg <- loadEData("geo2kegg")
```

```
## Loading GEO2KEGG data compendium ...
```

```
names(geo2kegg)
```

```
##  [1] "GSE1297"            "GSE14762"           "GSE15471"
##  [4] "GSE16515"           "GSE18842"           "GSE19188"
##  [7] "GSE19728"           "GSE20153"           "GSE20291"
## [10] "GSE21354"           "GSE3467"            "GSE3585"
## [13] "GSE3678"            "GSE4107"            "GSE5281_EC"
## [16] "GSE5281_HIP"        "GSE5281_VCX"        "GSE6956AA"
## [19] "GSE6956C"           "GSE781"             "GSE8671"
## [22] "GSE8762"            "GSE9348"            "GSE9476"
## [25] "GSE1145"            "GSE11906"           "GSE14924_CD4"
## [28] "GSE14924_CD8"       "GSE16759"           "GSE19420"
## [31] "GSE20164"           "GSE22780"           "GSE23878"
## [34] "GSE24739_G0"        "GSE24739_G1"        "GSE30153"
## [37] "GSE32676"           "GSE38666_epithelia" "GSE38666_stroma"
## [40] "GSE4183"            "GSE42057"           "GSE7305"
```

A specific dataset of the compendium can be obtained via

```
geo2kegg[[1]]
```

```
## ExpressionSet (storageMode: lockedEnvironment)
## assayData: 22283 features, 16 samples
##   element names: exprs
## protocolData: none
## phenoData
##   sampleNames: GSM21215 GSM21217 ... GSM21229 (16 total)
##   varLabels: Sample Group
##   varMetadata: labelDescription
## featureData: none
## experimentData: use 'experimentData(object)'
##   pubMedIds: 14769913
## Annotation: hgu133a
```

which returns, in this example, an `ExpressionSet` (documented in the
*[Biobase](https://bioconductor.org/packages/3.22/Biobase)* package) that contains expression levels of
22,283 probe sets measured for 16 patients.

To prepare the datasets for subsequent analysis, the *[GSEABenchmarkeR](https://bioconductor.org/packages/3.22/GSEABenchmarkeR)*
package provides the function `maPreproc`.
The function invokes `EnrichmentBrowser::probe2gene` on each dataset
to summarize expression levels for probes annotated to the same gene.
Here, we apply the function to the first 5 datasets of the compendium.

```
geo2kegg <- maPreproc(geo2kegg[1:5])
```

```
## Summarizing probe level expression ...
```

Now,

```
geo2kegg[[1]]
```

```
## class: SummarizedExperiment
## dim: 13039 16
## metadata(5): experimentData annotation protocolData dataId dataType
## assays(1): exprs
## rownames(13039): 780 5982 ... 388796 100505915
## rowData names(0):
## colnames(16): GSM21215 GSM21217 ... GSM21213 GSM21229
## colData names(2): Sample GROUP
```

returns a *[SummarizedExperiment](https://bioconductor.org/packages/3.22/SummarizedExperiment)* that contains the summarized
expression values for 12,994 genes. Furthermore, sample groups
are defined in the `colData` column **GROUP**, yielding here 7 cases (1) and
9 controls (0).

```
se <- geo2kegg[[1]]
table(se$GROUP)
```

```
##
## 0 1
## 9 7
```

Note: The `maPreproc` returns datasets consistently mapped to NCBI Entrez
Gene IDs, which is compatible with most downstream applications. However,
mapping to a different ID type such as ENSEMBL IDs or HGNC symbols can also be
done using the function `EnrichmentBrowser::idMap`.

## 3.2 RNA-seq compendium

The Cancer Genome Atlas ([TCGA](https://cancergenome.nih.gov)) project performed
a molecular investigation of various cancer types on an unprecedented scale
including various genomic high-throughput technologies.
In particular, transcriptomic profiling of the investigated cancer types has
comprehensively been carried out with RNA-seq in tumor and adjacent normal tissue.

Among the various resources that redistribute TCGA data,
[Rahman et al. (2015)](https://doi.org/10.1093/bioinformatics/btv377)
consistently preprocessed the RNA-seq data for 24 cancer types and made the data
available in the GEO dataset
[GSE62944](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE62944).

The GSE62944 compendium can be loaded using the `loadEData` function,
which provides the datasets ready for subsequent differential expression and
gene set enrichment analysis.

Here, we load the compendium into the workspace using only two of the datasets.

```
tcga <- loadEData("tcga", nr.datasets=2)
```

```
## Loading TCGA data compendium ...
```

```
## Cancer types with tumor samples:
```

```
## ACC, BLCA, BRCA, CESC, COAD, DLBC, GBM, HNSC, KICH, KIRC, KIRP, LAML, LGG, LIHC, LUAD, LUSC, OV, PRAD, READ, SKCM, STAD, THCA, UCEC, UCS
```

```
## Cancer types with adj. normal samples:
```

```
## BLCA, BRCA, CESC, CHOL, COAD, ESCA, GBM, HNSC, KICH, KIRC, KIRP, LIHC, LUAD, LUSC, PAAD, PCPG, PRAD, READ, SARC, SKCM, STAD, THCA, THYM, UCEC
```

```
## Cancer types with sufficient tumor and adj. normal samples:
```

```
## BLCA, BRCA
```

```
## Creating a SummarizedExperiment for each of them ...
```

```
## BLCA tumor: 19 adj.normal: 19
```

```
## BRCA tumor: 113 adj.normal: 113
```

```
names(tcga)
```

```
## [1] "BLCA" "BRCA"
```

For example, the breast cancer dataset contains RNA-seq read counts for roughly
20,000 genes measured in 1,119 tumor (1) and 113 adjacent normal (0) samples.

```
brca <- tcga[[2]]
brca
```

```
## class: SummarizedExperiment
## dim: 12322 226
## metadata(3): annotation dataId dataType
## assays(1): exprs
## rownames(12322): 1 2 ... 23140 26009
## rowData names(1): SYMBOL
## colnames(226): TCGA-A7-A13G-01A-11R-A13Q-07
##   TCGA-E9-A1N5-01A-11R-A14D-07 ... TCGA-BH-A18M-11A-33R-A12D-07
##   TCGA-BH-A1EW-11B-33R-A137-07
## colData names(4): sample type GROUP BLOCK
```

```
table(brca$GROUP)
```

```
##
##   0   1
## 113 113
```

## 3.3 User-defined data compendium

With easy and fast access to the GEO2KEGG and TCGA compendia, enrichment
methods can be directly applied and assessed on well-studied, standardized
expression datasets.
Nevertheless, benchmarking with the *[GSEABenchmarkeR](https://bioconductor.org/packages/3.22/GSEABenchmarkeR)* package is
designed to be extendable to additional datasets as well.

Therefore, the `loadEData` function also accepts a directory where datasets,
preferably of class *[SummarizedExperiment](https://bioconductor.org/packages/3.22/SummarizedExperiment)*, have been saved as
[RDS](https://stat.ethz.ch/R-manual/R-devel/library/base/html/readRDS.html)
files.

```
data.dir <- system.file("extdata", package="GSEABenchmarkeR")
edat.dir <- file.path(data.dir, "myEData")
edat <- loadEData(edat.dir)
names(edat)
```

```
## [1] "GSE42057x" "GSE7305x"
```

```
edat[[1]]
```

```
## class: SummarizedExperiment
## dim: 50 136
## metadata(5): experimentData annotation protocolData dataType dataId
## assays(1): exprs
## rownames(50): 3310 7318 ... 123036 117157
## rowData names(0):
## colnames(136): GSM1031553 GSM1031554 ... GSM1031683 GSM1031684
## colData names(2): Sample GROUP
```

# 4 Differential expression

To perform differential expression (DE) analysis between sample groups for
selected datasets of a compendium, the *[GSEABenchmarkeR](https://bioconductor.org/packages/3.22/GSEABenchmarkeR)* package
provides the function `runDE`.

The function invokes `EnrichmentBrowser::deAna` on each dataset, which contrasts
the sample groups as defined in the **GROUP** variable.

Here, we apply the function to 5 datasets of the GEO2KEGG compendium.

```
geo2kegg <- runDE(geo2kegg, de.method="limma", padj.method="flexible")
rowData(geo2kegg[[1]], use.names=TRUE)
```

```
## DataFrame with 13039 rows and 4 columns
##                    FC limma.STAT      PVAL  ADJ.PVAL
##             <numeric>  <numeric> <numeric> <numeric>
## 780         0.4321928   2.637640 0.0172941 0.0172941
## 5982        0.0350299   0.537711 0.5977569 0.5977569
## 3310        0.1673362   0.265356 0.7939310 0.7939310
## 7849        0.1450528   1.871119 0.0786690 0.0786690
## 2978       -0.1186515  -0.887406 0.3872621 0.3872621
## ...               ...        ...       ...       ...
## 389677     0.05470002  0.7601744 0.4575800 0.4575800
## 101930105  0.25457063  2.8527835 0.0110216 0.0110216
## 79583      0.06415321  0.3448392 0.7344512 0.7344512
## 388796    -0.00387318 -0.0304954 0.9760277 0.9760277
## 100505915 -0.00572267 -0.0856316 0.9327613 0.9327613
```

Note: DE studies typically report a gene as differentially expressed
if the corresponding DE *p*-value, corrected for multiple testing, satisfies
the chosen significance level.
Enrichment methods that work directly on the list of DE genes are then
substantially influenced by the multiple testing correction.

An example is the frequently used over-representation analysis (ORA), which
assesses the overlap between the DE genes and a gene set under study based
on the hypergeometric distribution (see the vignette of the
*[EnrichmentBrowser](https://bioconductor.org/packages/3.22/EnrichmentBrowser)* package, Appendix A, for an introduction).

ORA is inapplicable if there are few genes satisfying the significance threshold,
or if almost all genes are DE.

Using `padj.method="flexible"` accounts for these cases by applying multiple
testing correction in dependence on the observed degree of differential expression:

* the correction method from
  [Benjamini and Hochberg](http://sci2s.ugr.es/keel/pdf/specific/articulo/Shaffer95MHT.pdf)
  (BH) is applied, if it renders \(\ge 1\%\) and \(\le 25\%\) of all measured
  genes as DE,
* the *p*-values are left unadjusted, if the BH correction results in \(<1\%\)
  DE genes, and
* the more stringent
  [Bonferroni](http://sci2s.ugr.es/keel/pdf/specific/articulo/Shaffer95MHT.pdf)
  correction is applied, if the BH correction results in \(>25\%\) DE genes.

Note that resulting \(p\)-values are not further used for assessing the
statistical significance of DE genes within or between datasets.
They are solely used to determine which genes are included in the analysis with
ORA - where the flexible correction ensures that the fraction of included genes
is roughly in the same order of magnitude across datasets.
Alternative strategies could also be applied (such as taking a constant number of
genes for each dataset or generally excluding ORA methods from the assessment).

# 5 Enrichment analysis

In the following, we demonstrate how to carry out enrichment analysis in a
benchmark setup.
Therefore, we use the collection of human KEGG gene sets as obtained
with `getGenesets` from the *[EnrichmentBrowser](https://bioconductor.org/packages/3.22/EnrichmentBrowser)*
package.

```
library(EnrichmentBrowser)
kegg.gs <- getGenesets(org="hsa", db="kegg")
```

At the core of applying a specific enrichment method to a single dataset is the
`runEA` function, which delegates execution of the chosen method to either
`EnrichmentBrowser::sbea` (set-based enrichment analysis) or
`EnrichmentBrowser::nbea` (network-based enrichment analysis).
In addition, it returns CPU time used and allows saving results for subsequent
assessment.

Here, we carry out ORA on the first dataset of the GEO2KEGG compendium.

```
kegg.ora.res <- runEA(geo2kegg[[1]], method="ora", gs=kegg.gs, perm=0)
kegg.ora.res
```

```
## $ora
## $ora$GSE1297
## $ora$GSE1297$runtime
## elapsed
##   0.832
##
## $ora$GSE1297$ranking
## DataFrame with 360 rows and 4 columns
##                   GENE.SET  NR.GENES NR.SIG.GENES      PVAL
##                <character> <numeric>    <numeric> <numeric>
## 1   hsa00190_Oxidative_p..       106           56  8.23e-13
## 2   hsa05016_Huntington_..       260           97  1.70e-09
## 3   hsa05012_Parkinson_d..       225           86  3.85e-09
## 4   hsa05022_Pathways_of..       410          136  8.10e-09
## 5   hsa05415_Diabetic_ca..       177           68  1.36e-07
## ...                    ...       ...          ...       ...
## 356 hsa04914_Progesteron..        78            5         1
## 357 hsa01521_EGFR_tyrosi..        77            5         1
## 358 hsa04980_Cobalamin_t..        16            0         1
## 359 hsa00232_Caffeine_me..         6            0         1
## 360 hsa00524_Neomycin,_k..         5            0         1
```

The function `runEA` can also be used to carry out several methods on multiple
datasets.
As an example, we carry out ORA and
[CAMERA](https://doi.org/10.1093/nar/gks461)
on 5 datasets of the GEO2KEGG compendium saving the results in a temporary
directory.

```
res.dir <- tempdir()
res <- runEA(geo2kegg, methods=c("ora", "camera"),
                gs=kegg.gs, perm=0, save2file=TRUE, out.dir=res.dir)
res$ora[1:2]
```

```
## $GSE1297
## $GSE1297$runtime
## elapsed
##   0.886
##
## $GSE1297$ranking
## DataFrame with 360 rows and 4 columns
##                   GENE.SET  NR.GENES NR.SIG.GENES      PVAL
##                <character> <numeric>    <numeric> <numeric>
## 1   hsa00190_Oxidative_p..       106           56  8.23e-13
## 2   hsa05016_Huntington_..       260           97  1.70e-09
## 3   hsa05012_Parkinson_d..       225           86  3.85e-09
## 4   hsa05022_Pathways_of..       410          136  8.10e-09
## 5   hsa05415_Diabetic_ca..       177           68  1.36e-07
## ...                    ...       ...          ...       ...
## 356 hsa04914_Progesteron..        78            5         1
## 357 hsa01521_EGFR_tyrosi..        77            5         1
## 358 hsa04980_Cobalamin_t..        16            0         1
## 359 hsa00232_Caffeine_me..         6            0         1
## 360 hsa00524_Neomycin,_k..         5            0         1
##
##
## $GSE14762
## $GSE14762$runtime
## elapsed
##   1.033
##
## $GSE14762$ranking
## DataFrame with 361 rows and 4 columns
##                   GENE.SET  NR.GENES NR.SIG.GENES      PVAL
##                <character> <numeric>    <numeric> <numeric>
## 1       hsa04145_Phagosome       147           46  2.08e-14
## 2   hsa05150_Staphylococ..        84           28  5.61e-10
## 3   hsa05140_Leishmaniasis        74           25  3.46e-09
## 4   hsa04514_Cell_adhesi..       153           35  2.48e-07
## 5   hsa05416_Viral_myoca..        67           21  2.70e-07
## ...                    ...       ...          ...       ...
## 357 hsa00400_Phenylalani..         6            0         1
## 358 hsa00440_Phosphonate..         6            0         1
## 359 hsa00470_D-Amino_aci..         6            0         1
## 360 hsa00750_Vitamin_B6_..         6            0         1
## 361        hsa03264_Virion         6            0         1
```

Note: saving the results to file is typically recommended when carrying out
several methods on multiple datasets for subsequent assessment.
This makes results, potentially obtained from time-consuming computations,
persistent across *R* sessions.
In case of unexpected errors, this also allows resumption from the point of failure.

## 5.1 User-defined enrichment methods

User-defined enrichment methods can easily be plugged into the benchmarking framework.
For demonstration, we define a dummy enrichment method that randomly draws *p*-values
from a uniform distribution.

```
method <- function(se, gs)
{
    ps <- runif(length(gs))
    names(ps) <- names(gs)
    return(ps)
}
```

We then execute this method on two datasets of the GEO2KEGG compendium using `runEA`
as before.

```
res <- runEA(geo2kegg[1:2], method, kegg.gs)
res
```

```
## $method
## $method$GSE1297
## $method$GSE1297$runtime
## elapsed
##   0.199
##
## $method$GSE1297$ranking
## DataFrame with 360 rows and 2 columns
##                   GENE.SET      PVAL
##                <character> <numeric>
## 1       hsa04210_Apoptosis   0.00284
## 2   hsa00071_Fatty_acid_..   0.00785
## 3   hsa05132_Salmonella_..   0.01010
## 4   hsa04670_Leukocyte_t..   0.01100
## 5   hsa05130_Pathogenic_..   0.01260
## ...                    ...       ...
## 356 hsa00260_Glycine,_se..     0.977
## 357 hsa00380_Tryptophan_..     0.984
## 358   hsa03040_Spliceosome     0.986
## 359 hsa05140_Leishmaniasis     0.988
## 360       hsa05144_Malaria     0.990
##
##
## $method$GSE14762
## $method$GSE14762$runtime
## elapsed
##   0.225
##
## $method$GSE14762$ranking
## DataFrame with 361 rows and 2 columns
##                   GENE.SET      PVAL
##                <character> <numeric>
## 1   hsa01230_Biosynthesi..   0.00128
## 2     hsa03040_Spliceosome   0.00402
## 3   hsa04668_TNF_signali..   0.00764
## 4   hsa04261_Adrenergic_..   0.01230
## 5   hsa00360_Phenylalani..   0.01530
## ...                    ...       ...
## 357 hsa05207_Chemical_ca..     0.991
## 358 hsa00240_Pyrimidine_..     0.994
## 359 hsa04310_Wnt_signali..     0.998
## 360 hsa04922_Glucagon_si..     0.998
## 361 hsa00280_Valine,_leu..     0.999
```

# 6 Benchmarking

Once methods have been applied to a chosen benchmark compendium, they can be
subjected to a comparative assessment of runtime, statistical significance,
and phenotype relevance.

To demonstrate how each criterion can be evaluated, we consider the example of
the previous section where we applied ORA and CAMERA on 5 datasets of the
GEO2KEGG compendium.

However, note that this minimal example is used to illustrate the basic
functionality in a time-saving manner - as generally intended in a vignette.
To draw conclusions on the individual performance of both methods, a more
comprehensive assessment, involving application to the full compendium, should be
carried out.

## 6.1 Runtime

Runtime, i.e. CPU time used, is an important measure of the
applicability of a method.
For enrichment methods, runtime mainly depends on whether methods rely on
permutation testing, and how computationally intensive recomputation of
the respective statistic in each permutation is (see
[Figure 4](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4721010/figure/Fig4)
in
[Geistlinger et al., 2016](https://doi.org/10.1186/s12859-016-0884-1)).

To obtain the runtime from the application of ORA and CAMERA to 5 datasets of the
GEO2KEGG compendium, we can use the `readResults` function as we have saved
results to the indicated result directory in the above call of `runEA`.

```
ea.rtimes <- readResults(res.dir, names(geo2kegg),
                            methods=c("ora", "camera"), type="runtime")
ea.rtimes
```

```
## $ora
##  GSE1297 GSE14762 GSE15471 GSE16515 GSE18842
##    0.886    1.033    1.088    1.093    1.109
##
## $camera
##  GSE1297 GSE14762 GSE15471 GSE16515 GSE18842
##    0.394    0.387    0.587    0.342    0.636
```

For visualization of assessment results, the `bpPlot` function can be used to
create customized boxplots for specific benchmark criteria.

```
bpPlot(ea.rtimes, what="runtime")
```

![](data:image/png;base64...)

As both methods are simple gene set tests without permutation, they are among the
fastest in the field - with CAMERA being roughly twice as fast as ORA.

```
mean(ea.rtimes$ora) / mean(ea.rtimes$camera)
```

```
## [1] 2.220375
```

## 6.2 Fraction of significant gene sets

The statistical accuracy of the significance estimation in gene set tests has
been repeatedly debated.
For example, systematic inflation of statistical significance in ORA due to an
unrealistic independence assumption between genes is well-documented
([Goeman and Buehlmann, 2007](https://doi.org/10.1093/bioinformatics/btm051)).
On the other hand, the permutation procedure incorporated in many gene set tests
has been shown to be biased
([Efron and Tibshirani, 2007](https://doi.org/10.1214/07-AOAS101)),
and also inaccurate if permutation \(p\)-values are reported as zero
([Phipson and Smyth, 2010](https://doi.org/10.2202/1544-6115.1585)).

These shortcomings can lead to inappropriately large fractions of significant
gene sets, and can considerably impair prioritization of gene sets in practice.
It is therefore important to evaluate resulting fractions of significant gene
sets in comparison to other methods and with respect to the fraction of
differentially expressed genes as a baseline.

We use the `readResults` function to obtain the saved gene set rankings of ORA
and CAMERA when applied to 5 datasets of the GEO2KEGG compendium (see above call
of `runEA`).

```
ea.ranks <- readResults(res.dir, names(geo2kegg),
                            methods=c("ora", "camera"), type="ranking")
lengths(ea.ranks)
```

```
##    ora camera
##      5      5
```

```
ea.ranks$ora[1:2]
```

```
## $GSE1297
## DataFrame with 360 rows and 4 columns
##                   GENE.SET  NR.GENES NR.SIG.GENES      PVAL
##                <character> <numeric>    <numeric> <numeric>
## 1   hsa00190_Oxidative_p..       106           56  8.23e-13
## 2   hsa05016_Huntington_..       260           97  1.70e-09
## 3   hsa05012_Parkinson_d..       225           86  3.85e-09
## 4   hsa05022_Pathways_of..       410          136  8.10e-09
## 5   hsa05415_Diabetic_ca..       177           68  1.36e-07
## ...                    ...       ...          ...       ...
## 356 hsa04914_Progesteron..        78            5         1
## 357 hsa01521_EGFR_tyrosi..        77            5         1
## 358 hsa04980_Cobalamin_t..        16            0         1
## 359 hsa00232_Caffeine_me..         6            0         1
## 360 hsa00524_Neomycin,_k..         5            0         1
##
## $GSE14762
## DataFrame with 361 rows and 4 columns
##                   GENE.SET  NR.GENES NR.SIG.GENES      PVAL
##                <character> <numeric>    <numeric> <numeric>
## 1       hsa04145_Phagosome       147           46  2.08e-14
## 2   hsa05150_Staphylococ..        84           28  5.61e-10
## 3   hsa05140_Leishmaniasis        74           25  3.46e-09
## 4   hsa04514_Cell_adhesi..       153           35  2.48e-07
## 5   hsa05416_Viral_myoca..        67           21  2.70e-07
## ...                    ...       ...          ...       ...
## 357 hsa00400_Phenylalani..         6            0         1
## 358 hsa00440_Phosphonate..         6            0         1
## 359 hsa00470_D-Amino_aci..         6            0         1
## 360 hsa00750_Vitamin_B6_..         6            0         1
## 361        hsa03264_Virion         6            0         1
```

The `evalNrSigSets` calculates the percentage of significant gene sets given a
significance level `alpha` and a multiple testing correction method `padj`.
We can visualize assessment results as before using `bpPlot`, which demonstrates
here that CAMERA produces substantially larger fractions of significant
gene sets than ORA.

```
sig.sets <- evalNrSigSets(ea.ranks, alpha=0.05, padj="BH")
sig.sets
```

```
##                 ora   camera
## GSE1297   4.4444444 18.88889
## GSE14762 13.5734072 34.62604
## GSE15471  3.8781163 23.26870
## GSE16515  2.7700831 16.89751
## GSE18842  0.8310249 23.54571
```

```
bpPlot(sig.sets, what="sig.sets")
```

![](data:image/png;base64...)

## 6.3 Phenotype relevance

As introduced above, Tarca et al. ([2012](https://doi.org/10.1186/1471-2105-13-136)
and [2013](https://doi.org/10.1371/journal.pone.0079217)) also assigned a target
pathway to each dataset of the GEO2KEGG compendium, which is considered
highly-relevant for the respective phenotype investigated.
However, the relation between dataset, investigated phenotype, and assigned target
pathway is not always clear-cut.
In addition, there is typically more than one pathway that is considered relevant
for the investigated phenotype.

On the other hand, evaluations of published enrichment methods often conclude on
phenotype relevance, if there is *any* association between top-ranked gene sets
and the investigated phenotype.

A more systematic approach is used in the
[MalaCards](https://www.malacards.org) database of human diseases.
Here, relevance of [GO](http://www.geneontology.org)
and [KEGG](http://www.genome.jp/kegg) gene sets is summarized from
(*i*) experimental evidence and (*ii*) co-citation with the respective disease
in the literature.

### 6.3.1 MalaCards disease relevance rankings

The *[GSEABenchmarkeR](https://bioconductor.org/packages/3.22/GSEABenchmarkeR)* package provides MalaCards relevance rankings
for the diseases investigated in the datasets of the GEO2KEGG and TCGA compendia.
Here, we load the relevance rankings for KEGG gene sets and demonstrate how they
can be incorporated in the assessment of phenotype relevance.

We note that the relevance rankings contain different numbers of gene sets for
different diseases, because only gene sets for which evidence/association with the
respective disease has been found are listed in a ranking.

For demonstration, we inspect the relevance rankings for Alzheimer’s disease
(ALZ) and breast cancer (BRCA) containing 57 and 142 gene sets, respectively.

```
mala.kegg.file <- file.path(data.dir, "malacards", "KEGG.rds")
mala.kegg <- readRDS(mala.kegg.file)
sapply(mala.kegg, nrow)
```

```
##  ACC  ALZ BLCA BRCA CESC CHOL  CML COAD  CRC  DCM DLBC DMND ESCA  GBM HNSC HUNT
##    9   57   65  142   22   33   56   28  161   23   52   99   90   99   72   34
## KICH KIRC KIRP LAML  LES  LGG LIHC LUAD LUSC MESO   OV PAAD PARK PCPG PDCO PRAD
##    4    8    8  108   49   24   98   54   23    3   31   70   39   12   31   12
## READ SARC SKCM STAD TGCT THCA THYM UCEC  UCS  UVM
##    2   73   42   24   24   81   61   90   29   55
```

```
mala.kegg$ALZ
```

```
## DataFrame with 57 rows and 4 columns
##                           TITLE REL.SCORE MATCHED.GENES TOTAL.GENES
##                     <character> <numeric>     <integer>   <integer>
## hsa05010     Alzheimers disease     84.12            28         177
## hsa04932 Non-alcoholic fatty ..     84.12             7         160
## hsa04726   Serotonergic synapse     49.19             8         115
## hsa04728   Dopaminergic synapse     49.19             8         130
## hsa04713  Circadian entrainment     49.19             5          98
## ...                         ...       ...           ...         ...
## hsa05310                 Asthma      9.81             1          35
## hsa05416      Viral myocarditis      9.81             2          64
## hsa05330    Allograft rejection      9.81             1          41
## hsa05332 Graft-versus-host di..      9.81             2          45
## hsa05321 Inflammatory bowel d..      9.81             2          67
```

```
mala.kegg$BRCA
```

```
## DataFrame with 142 rows and 4 columns
##                           TITLE REL.SCORE MATCHED.GENES TOTAL.GENES
##                     <character> <numeric>     <integer>   <integer>
## hsa05210      Colorectal cancer     166.1            35          70
## hsa05213     Endometrial cancer     166.1            23          61
## hsa05221 Acute myeloid leukemia     166.1            16          60
## hsa05218               Melanoma     166.1            35          78
## hsa05215        Prostate cancer     166.1            40          95
## ...                         ...       ...           ...         ...
## hsa05020         Prion diseases     13.23             6          43
## hsa05144                Malaria     11.34             6          55
## hsa05143 African trypanosomia..     11.28             5          36
## hsa04720 Long-term potentiation     10.93             7          67
## hsa05134          Legionellosis     10.81             6          59
```

### 6.3.2 Mapping between dataset ID and disease code

To obtain the relevance ranking of the respective disease investigated when
assessing results on a specific dataset, a mapping between dataset and
investigated disease is required.
The function `readDataId2diseaseCodeMap` reads such a mapping from a tabular
text file and turns it into a named vector - where the elements correspond to
the disease codes and the names to the dataset IDs.

Here, we read the mapping between GSE ID and disease code for the GEO2KEGG
compendium.

```
d2d.file <- file.path(data.dir, "malacards", "GseId2Disease.txt")
d2d.map <- readDataId2diseaseCodeMap(d2d.file)
head(d2d.map)
```

```
##      GSE1145     GSE11906      GSE1297     GSE14762 GSE14924_CD4 GSE14924_CD8
##        "DCM"       "PDCO"        "ALZ"       "KIRC"       "LAML"       "LAML"
```

### 6.3.3 Relevance score of a gene set ranking

To evaluate the phenotype relevance of a gene set ranking obtained from the
application of an enrichment method to an expression dataset, the function
`evalRelevance` assesses whether the ranking accumulates phenotype-relevant gene
sets (i.e. gene sets with high relevance scores) at the top.
Therefore, the function first transforms the ranks from the enrichment analysis
to weights - where the greater the weight of a gene set, the more it is ranked
towards the top of the GSEA ranking.
These weights are then multiplied by the corresponding relevance scores and
summed.

Here, we use `evalRelevance` to assess whether ORA, when applied to the GSE1297
dataset, recovers Alzheimer-relevant KEGG pathways.

```
ea.ranks$ora$GSE1297
```

```
## DataFrame with 360 rows and 4 columns
##                   GENE.SET  NR.GENES NR.SIG.GENES      PVAL
##                <character> <numeric>    <numeric> <numeric>
## 1   hsa00190_Oxidative_p..       106           56  8.23e-13
## 2   hsa05016_Huntington_..       260           97  1.70e-09
## 3   hsa05012_Parkinson_d..       225           86  3.85e-09
## 4   hsa05022_Pathways_of..       410          136  8.10e-09
## 5   hsa05415_Diabetic_ca..       177           68  1.36e-07
## ...                    ...       ...          ...       ...
## 356 hsa04914_Progesteron..        78            5         1
## 357 hsa01521_EGFR_tyrosi..        77            5         1
## 358 hsa04980_Cobalamin_t..        16            0         1
## 359 hsa00232_Caffeine_me..         6            0         1
## 360 hsa00524_Neomycin,_k..         5            0         1
```

```
obs.score <- evalRelevance(ea.ranks$ora$GSE1297, mala.kegg$ALZ)
obs.score
```

```
## [1] 822.3566
```

### 6.3.4 Random relevance score distribution

To assess the significance of the observed relevance score of an enrichment
method applied to a specific dataset, i.e. to assess how likely it is to
observe a relevance score equal or greater than the one obtained, the function
`compRand` repeatedly applies `evalRelevance` to randomly drawn gene set rankings.

For demonstration, we compute relevance scores for 50 random gene set rankings
and calculate the *p*-value as for a permutation test.
This demonstrates that the relevance score obtained from applying ORA to GSE1297
significantly exceeds random scores.

```
gs.names <- ea.ranks$ora$GSE1297$GENE.SET
gs.ids <- substring(gs.names, 1, 8)
rand.scores <- compRand(mala.kegg$ALZ, gs.ids, perm=50)
summary(rand.scores)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##   487.5   606.5   657.0   659.5   705.8   815.4
```

```
(sum(rand.scores >= obs.score) + 1) / 51
```

```
## [1] 0.01960784
```

### 6.3.5 Theoretical optimum

The observed relevance score can be used to compare phenotype relevance of
two or more methods when applied to one particular dataset.
However, as the number of gene sets in the relevance rankings differs between
phenotypes (see above Section *5.3.1 MalaCards disease relevance rankings*),
comparison between datasets is not straightforward as resulting relevance scores
scale differently.

Therefore, the function `compOpt` applies `evalRelevance` to the theoretically
optimal case in which the enrichment analysis ranking is identical to the
relevance score ranking. The ratio between observed and optimal score can then
be used to compare observed scores between datasets.

Here, we compute the optimal score for the Alzheimer relevance ranking, which
indicates that the score observed for ORA, when applied to GSE1297, is about 68%
of the optimal score.

```
opt.score <- compOpt(mala.kegg$ALZ, gs.ids)
opt.score
```

```
## [1] 1235
```

```
round(obs.score / opt.score * 100, digits=2)
```

```
## [1] 66.59
```

### 6.3.6 Cross-dataset relevance score distribution

Evaluation of phenotype relevance with `evalRelevance` can also be done for
several methods applied across multiple datasets.
This allows to assess whether certain enrichment methods tend to produce
rankings of higher phenotype relevance than other methods when applied to a
compendium of datasets.
As explained in the previous section, observed relevance scores are always
expressed in relation to the respective optimal score.

For demonstration, we use `evalRelevance` to evaluate phenotype relevance of the
gene set rankings produced by ORA and CAMERA when applied to 5 datasets of the
GEO2KEGG compendium.
We can visualize assessment results as before using `bpPlot`, which demonstrates
here that ORA tends to recover more phenotype-relevant gene sets than CAMERA.

```
all.kegg.res <- evalRelevance(ea.ranks, mala.kegg, d2d.map[names(geo2kegg)])
bpPlot(all.kegg.res, what="rel.sets")
```

![](data:image/png;base64...)

### 6.3.7 User-defined relevance rankings

It is also possible to refine the integrated MalaCards relevance rankings or to
incorporate relevance rankings for additional datasets.

For demonstration, we modify the KEGG relevance ranking for Alzheimer’s disease
by providing a random relevance score for each gene set.

```
rel.ranks <- mala.kegg$ALZ[,1:2]
rel.ranks$REL.SCORE <- runif(nrow(rel.ranks), min=1, max=100)
rel.ranks$REL.SCORE <- round(rel.ranks$REL.SCORE, digits = 2)
ind <- order(rel.ranks$REL.SCORE, decreasing = TRUE)
rel.ranks <- rel.ranks[ind,]
rel.ranks
```

```
## DataFrame with 57 rows and 2 columns
##                           TITLE REL.SCORE
##                     <character> <numeric>
## hsa05012     Parkinsons disease     99.83
## hsa04722 Neurotrophin signali..     98.25
## hsa04728   Dopaminergic synapse     98.03
## hsa04724  Glutamatergic synapse     94.83
## hsa04723 Retrograde endocanna..     94.29
## ...                         ...       ...
## hsa04915 Estrogen signaling p..     10.25
## hsa04662 B cell receptor sign..      8.90
## hsa04310  Wnt signaling pathway      6.68
## hsa05014 Amyotrophic lateral ..      5.47
## hsa04912 GnRH signaling pathway      1.19
```

We can then compute the aggregated relevance score of the ORA ranking according
to the updated relevance ranking using `evalRelevance` as before.

```
evalRelevance(ea.ranks$ora$GSE1297, rel.ranks)
```

```
## [1] 1724.107
```

# 7 Advanced

## 7.1 Caching

Preparing an expression data compendium for benchmarking of enrichment methods
can be time-consuming.
In case of the GEO2KEGG compendium, it requires to summarize probe level
expression on gene level and to subsequently carry out differential expression
analysis for each dataset.

To flexibly save and restore an already processed expression data compendium,
we can use the `cacheResource` function which builds on functionality of the
*[BiocFileCache](https://bioconductor.org/packages/3.22/BiocFileCache)* package.

```
cacheResource(geo2kegg, rname="geo2kegg")
```

This adds the selected 5 datasets of the GEO2KEGG compendium (as processed
throughout this vignette) to the cache, and allows to restore it at a later time
via

```
geo2kegg <- loadEData("geo2kegg", cache=TRUE)
```

```
## Loading GEO2KEGG data compendium ...
```

```
names(geo2kegg)
```

```
## [1] "GSE1297"  "GSE14762" "GSE15471" "GSE16515" "GSE18842"
```

Note: to obtain the original unprocessed version of the compendium, set the
`cache` argument of the `loadEData` function to `FALSE`.

To clear the cache (use with care):

```
cache.dir <- rappdirs::user_cache_dir("GSEABenchmarkeR")
bfc <- BiocFileCache::BiocFileCache(cache.dir)
BiocFileCache::removebfc(bfc)
```

## 7.2 Parallel computation

Leveraging functionality from *[BiocParallel](https://bioconductor.org/packages/3.22/BiocParallel)*, parallel computation
of the functions `maPreproc`, `runDE`, and
especially `runEA`, when applied to multiple datasets is straightforward.
Internally, these functions call `BiocParallel::bplapply`, which triggers parallel
computation as configured in the first element of `BiocParallel::registered()`.
As a result, parallel computation is implicitly incorporated in the above calls
of these functions when carried out on a multi-core machine.
See the vignette of the *[BiocParallel](https://bioconductor.org/packages/3.22/BiocParallel)* package for an introduction.

Inspecting

```
BiocParallel::registered()
```

```
## $MulticoreParam
## class: MulticoreParam
##   bpisup: FALSE; bpnworkers: 4; bptasks: 0; bpjobname: BPJOB
##   bplog: FALSE; bpthreshold: INFO; bpstopOnError: TRUE
##   bpRNGseed: ; bptimeout: NA; bpprogressbar: FALSE
##   bpexportglobals: TRUE; bpexportvariables: FALSE; bpforceGC: FALSE
##   bpfallback: TRUE
##   bplogdir: NA
##   bpresultdir: NA
##   cluster type: FORK
##
## $SnowParam
## class: SnowParam
##   bpisup: FALSE; bpnworkers: 4; bptasks: 0; bpjobname: BPJOB
##   bplog: FALSE; bpthreshold: INFO; bpstopOnError: TRUE
##   bpRNGseed: ; bptimeout: NA; bpprogressbar: FALSE
##   bpexportglobals: TRUE; bpexportvariables: TRUE; bpforceGC: FALSE
##   bpfallback: TRUE
##   bplogdir: NA
##   bpresultdir: NA
##   cluster type: SOCK
##
## $SerialParam
## class: SerialParam
##   bpisup: FALSE; bpnworkers: 1; bptasks: 0; bpjobname: BPJOB
##   bplog: FALSE; bpthreshold: INFO; bpstopOnError: TRUE
##   bpRNGseed: ; bptimeout: NA; bpprogressbar: FALSE
##   bpexportglobals: FALSE; bpexportvariables: FALSE; bpforceGC: FALSE
##   bpfallback: FALSE
##   bplogdir: NA
##   bpresultdir: NA
```

shows that the execution uses a `MulticoreParam` per default (on Windows:
a `SnowParam`), where the `bpnworkers` attribute indicates the number of cores
involved in the computation.

To change the execution mode of functions provided in the
*[GSEABenchmarkeR](https://bioconductor.org/packages/3.22/GSEABenchmarkeR)* package, accordingly configured computation
parameters of class `BiocParallelParam` can either directly be registered via
`BiocParallel::register`, or supplied with the `parallel` argument of the
respective function.

For demonstration, we configure here a `BiocParallelParam` to display a progress
bar

```
bp.par <- BiocParallel::registered()[[1]]
BiocParallel::bpprogressbar(bp.par) <- TRUE
```

and supply `runDE` with the updated computation parameter.

```
geo2kegg <- runDE(geo2kegg, parallel=bp.par)
```

```
##
  |
  |                                                                      |   0%
  |
  |============================                                          |  40%
  |
  |==========================================                            |  60%
  |
  |======================================================================| 100%
```

Users that would like to use distributed computation, on e.g. an institutional
computer cluster, should consult the vignette of the *[BiocParallel](https://bioconductor.org/packages/3.22/BiocParallel)*
package to similarly configure a `BiocParallelParam` for that purpose.