# methylGSA: Gene Set Analysis for DNA Methylation Datasets

#### Xu Ren and Pei Fen Kuan

#### 2025-10-30

* [Installation](#installation)
* [Introduction](#introduction)
* [Supported gene sets and gene ID types](#supported-gene-sets-and-gene-id-types)
* [Supported array types](#supported-array-types)
* [Description of methylglm](#description-of-methylglm)
  + [Example](#example)
* [Description of methylRRA](#description-of-methylrra)
  + [Example](#example-1)
* [Description of methylgometh](#description-of-methylgometh)
  + [Example](#example-2)
* [Other options](#other-options)
  + [Examples](#examples)
* [Visualization](#visualization)
  + [Example](#example-3)
* [Session info](#session-info)
* [References](#references)

## Installation

To install and load methylGSA

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("methylGSA")
```

```
library(methylGSA)
```

Depending on the DNA methylation array type, other packages may be needed before running the analysis.

If analyzing 450K array, `IlluminaHumanMethylation450kanno.ilmn12.hg19` needs to be loaded.

```
library(IlluminaHumanMethylation450kanno.ilmn12.hg19)
```

If analyzing EPIC array, `IlluminaHumanMethylationEPICanno.ilm10b4.hg19` needs to be loaded.

```
library(IlluminaHumanMethylationEPICanno.ilm10b4.hg19)
```

If analyzing user-supplied mapping between CpG ID and gene name, neither `IlluminaHumanMethylation450kanno.ilmn12.hg19` nor `IlluminaHumanMethylationEPICanno.ilm10b4.hg19` needs to be loaded.

## Introduction

The methylGSA package contains functions to carry out gene set analysis adjusting for the number of CpGs per gene. It has been shown by Geeleher et al [1] that gene set analysis is extremely biased for DNA methylation data. This package contains three main functions to adjust for the bias in gene set analysis.

* methylglm: Incorporating number of CpGs as a covariate in logistic regression.
* methylRRA: Adjusting for multiple p-values of each gene by Robust Rank Aggregation [2], and then apply either over-representation analysis (ORA) or Preranked version of Gene Set Enrichment Analysis (GSEAPreranked) [3] in gene set testing.
* methylgometh: Adjusting the number of CpGs for each gene by weighted resampling and Wallenius non-central hypergeometric approximation (via missMethyl [4]).

## Supported gene sets and gene ID types

* Gene Ontology (via org.Hs.eg.db [5])
* KEGG (via org.Hs.eg.db [5])
* Reactome (via reactome.db [6])
* User-supplied gene sets. Supported gene input ID types:
  + “SYMBOL”
  + “ENSEMBL”
  + “ENTREZID”
  + “REFSEQ”

## Supported array types

* Infinium Human Methylation 450K BeadChip (via IlluminaHumanMethylation450kanno.ilmn12.hg19 [7])
* Infinium Methylation EPIC BeadChip (via IlluminaHumanMethylationEPICanno.ilm10b4.hg19 [8])
* User supplied mapping between CpG ID and gene name

## Description of methylglm

methylglm is an extention of GOglm [9]. GOglm adjusts length bias for RNA-Seq data by incorporating gene length as a covariate in logistic regression model. methylglm adjusts length bias in DNA methylation by the number of CpGs instead of gene length. For each gene set, we fit a logistic regression model:

\[ \text{logit} (\pi\_{i}) = \beta\_{0} + \beta\_{1}x\_{i} + \beta\_{2}c\_{i}\] For each gene \(i\), \(\pi\_{i}\) = Pr(gene \(i\) is in gene set), \(x\_{i}\) represents negative logarithmic transform of its minimum p-value in differential methylation analysis, and \(c\_{i}\) is logarithmic transform of its number of CpGs.

methylglm requires only a simple named vector. This vector contains p-values of each CpG. Names should be their corresponding CpG IDs.

### Example

Here is what the input vector looks like:

```
data(cpgtoy)
head(cpg.pval, 20)
```

```
cg00050873 cg00212031 cg00214611 cg01707559 cg02004872 cg02011394 cg02050847
    0.2876     0.7883     0.4090     0.8830     0.9405     0.0456     0.5281
cg02233190 cg02494853 cg02839557 cg02842889 cg03052502 cg03244189 cg03443143
    0.8924     0.5514     0.4566     0.9568     0.4533     0.6776     0.5726
cg03683899 cg03706273 cg03750315 cg04016144 cg04042030 cg04448376
    0.1029     0.8998     0.2461     0.0421     0.3279     0.9545
```

Please note that the p-values presented here in `cpg.pval` is for illustration purpose only. They are used to show how to utilize the functions in methylGSA. It does not represent p-values from any real data analysis. The actual p-values in differential methylation analysis may be quite different from the p-values in `cpg.pval` in terms of the magnitude.

Run methylglm:

```
res1 = methylglm(cpg.pval = cpg.pval, minsize = 200,
                 maxsize = 500, GS.type = "KEGG")
head(res1, 15)
```

```
         ID                             Description Size    pvalue padj
04080 04080 Neuroactive ligand-receptor interaction  272 0.4811308    1
04060 04060  Cytokine-cytokine receptor interaction  265 0.6961531    1
04010 04010                  MAPK signaling pathway  268 1.0000000    1
04144 04144                             Endocytosis  201 1.0000000    1
04510 04510                          Focal adhesion  200 1.0000000    1
04740 04740                  Olfactory transduction  388 1.0000000    1
04810 04810        Regulation of actin cytoskeleton  213 1.0000000    1
05200 05200                      Pathways in cancer  326 1.0000000    1
```

Result is a data frame ranked by p-values of gene sets. The meaning of each column is given below.

| Column | Explanation |
| --- | --- |
| ID | Gene set ID |
| Description (N/A for user supplied gene set) | Gene set description |
| Size | Number of genes in gene set |
| pvalue | p-value in logistic regression |
| padj | Adjusted p-value |

Bioconductor package [org.Hs.eg.db](https://bioconductor.org/packages/data/annotation/html/org.Hs.eg.db.html) can be used to pull out the genes corresponding a specific pathway. For instance, one of the pathways in the methylglm output above is “Neuroactive ligand-receptor interaction” with KEGG ID 04080. The following code can be used to obtain its genes.

```
library(org.Hs.eg.db)
genes_04080 = select(org.Hs.eg.db, "04080", "SYMBOL", keytype = "PATH")
head(genes_04080)
```

```
   PATH    SYMBOL
1 04080 ADCYAP1R1
2 04080    ADORA1
3 04080   ADORA2A
4 04080   ADORA2B
5 04080    ADORA3
6 04080    ADRA1D
```

The following code can be used to get the genes in all the pathways in methylglm output.

```
# include all the IDs as the 2nd argument in select function
genes_all_pathway = select(org.Hs.eg.db, as.character(res1$ID),
                     "SYMBOL", keytype = "PATH")
head(genes_all_pathway)
```

## Description of methylRRA

Robust rank aggregation [2] is a parameter free model that aggregates several ranked gene lists into a single gene list. The aggregation assumes random order of input lists and assign each gene a p-value based on order statistics. We apply this order statistics idea to adjust for number of CpGs.

For gene \(i\), let \(P\_{1}, P\_{2}, ... P\_{n}\) be the p-values of individual CpGs in differential methylation analysis. Under the null hypothesis, \(P\_{1}, P\_{2}, ... P\_{n} ~ \overset{i.i.d}{\sim} Unif[0, 1]\). Let \(P\_{(1)}, P\_{(2)}, ... P\_{(n)}\) be the order statistics. Define: \[\rho =
\text{min}\{\text{Pr}(P\_{(1)}<P\_{(1)\text{obs}}),
\text{Pr}(P\_{(2)}<P\_{(2)\text{obs}})...,
\text{Pr}(P\_{(n)}<P\_{(n)\text{obs}}) \} \]

methylRRA supports two approaches to adjust for number of CpGs, ORA and GSEAPreranked [3]. In ORA approach, for gene \(i\), conversion from \(\rho\) score into p-value is done by Bonferroni correction [2]. We get a p-value for each gene and these p-values are then corrected for multiple testing use Benjamini & Hochberg procedure [10]. By default, genes with False Discovery Rate (FDR) below 0.05 are considered differentially expressed (DE) genes. If there are no DE genes under FDR 0.05, users are able to use `sig.cut` option to specify a higher FDR cut-off or `topDE` option to declare top genes to be differentially expressed. We then apply ORA based on these DE genes.

In GSEAPreranked approach, for gene \(i\), we also convert \(\rho\) score into p-value by Bonferroni correction. p-values are converted into z-scores. We then apply Preranked version of Gene Set Enrichment Analysis (GSEAPreranked) on the gene list ranked by the z-scores.

### Example

To apply ORA approach, we use argument `method = "ORA"` (default) in methylRRA

```
res2 = methylRRA(cpg.pval = cpg.pval, method = "ORA",
                    minsize = 200, maxsize = 210)
head(res2, 15)
```

The meaning of each column in the output is given below.

| Column | Explanation |
| --- | --- |
| ID | Gene set ID |
| Description (N/A for user supplied gene set) | Gene set description |
| Count | Number of significant genes in the gene set |
| overlap | Names of significant genes in the gene set |
| Size | Number of genes in gene set |
| pvalue | p-value in ORA |
| padj | Adjusted p-value |

To apply GSEAPreranked approach, we use argument `method = "GSEA"` in methylRRA

```
res3 = methylRRA(cpg.pval = cpg.pval, method = "GSEA",
                    minsize = 200, maxsize = 210)
head(res3, 10)
```

The meaning of each column in the output is given below.

| Column | Explanation |
| --- | --- |
| ID | Gene set ID |
| Description (N/A for user supplied gene set) | Gene set description |
| Size | Number of genes in gene set |
| enrichmentScore | Enrichment score (see [3] for details) |
| NES | Normalized enrichment score (see [3] for details) |
| pvalue | p-value in GSEA |
| padj | Adjusted p-value |

## Description of methylgometh

methylgometh calls `gometh` or `gsameth` function in missMethyl package [4] to adjust number of CpGs in gene set testing. `gometh` modifies goseq method [11] by fitting a probability weighting function and resampling from Wallenius non-central hypergeometric distribution.

methylgometh requires two inputs, `cpg.pval` and `sig.cut`. `sig.cut` specifies the cut-off point to declare a CpG as differentially methylated. By default, `sig.cut` is 0.001. Similar to methylRRA, if no CpG is significant, users are able to specify a higher cut-off or use `topDE` option to declare top CpGs to be differentially methylated.

### Example

```
res4 = methylgometh(cpg.pval = cpg.pval, sig.cut = 0.001,
                        minsize = 200, maxsize = 210)
head(res4, 15)
```

## Other options

methylGSA provides many other options for users to customize the analysis.

* `array.type` is to specify which array type to use. It is either “450K” or “EPIC”. Default is “450K”. This argument will be ignored if `FullAnnot` is provided.
* `FullAnnot` is preprocessed mapping between CpG ID and gene name provided by prepareAnnot function. Default is NULL. Check example below for details.
* `group` is the type of CpG to be considered in methylRRA or methylglm. By default, `group` is “all”, which means all CpGs are considered regardless of their gene group. If `group` is “body”, only CpGs on gene body will be considered. If `group` is “promoter1” or “promoter2”, only CpGs on promoters will be considered. Based on the annotation in IlluminaHumanMethylation450kanno.ilmn12.hg19 and IlluminaHumanMethylationEPICanno.ilm10b4.hg19, “body”, “promoter1” and “promoter2” are defined as:
  + body: CpGs whose gene group correspond to “Body” or “1stExon”
  + promoter1: CpGs whose gene group correspond to “TSS1500” or “TSS200”
  + promoter2: CpGs whose gene group correspond to “TSS1500”, “TSS200”, “1stExon”, or “5’UTR”
* `GS.list` is user supplied gene sets to be tested. It should be a list with entry names gene set IDs and elements correpond to genes that gene set contain. If there is no input list, Gene Ontology is used by default.
* `GS.idtype` is the type of gene ID in user supplied gene sets. If `GS.list` is not empty, then the user is expected to provide gene ID type. Supported ID types are “SYMBOL”, “ENSEMBL”, “ENTREZID”, “REFSEQ”. Default is “SYMBOL”.
* `GS.type` is the published gene sets/pathways to be tested if `GS.list` is empty. Supported pathways are “GO” (Gene Ontology), “KEGG”, and “Reactome”. Default is “GO”.
* `minsize` is an integer. If the number of genes in a gene set is less than this integer, this gene set is not tested. Default is 100.
* `maxsize` is also an integer. If the number of genes in a gene set is greater than this integer, this gene set is not tested. Default is 500.
* In methylRRA, `method` is to specify gene set test method. It is either “ORA” or “GSEA” as described in the previous section. Default is “ORA”.
* In methylglm, `parallel` is either `TRUE` or `FALSE` indicating whether parallel should be used. Default is `FALSE`.

### Examples

An example of user supplied gene sets is given below. The gene ID type is gene symbol.

```
data(GSlisttoy)
## to make the display compact, only a proportion of each gene set is shown
head(lapply(GS.list, function(x) x[1:30]), 3)
```

```
$GS1
 [1] "ABCA11P"   "ACOT1"     "ACSM2A"    "ADAMTS4"   "ADH4"      "AGTR2"
 [7] "AMAC1"     "AMY1B"     "AMY2A"     "ANKRD13C"  "ANKRD20A1" "ANKRD20A3"
[13] "ANKRD20A4" "ANXA2P3"   "ANXA8"     "ANXA8L1"   "ARGFXP2"   "ARL17B"
[19] "ATF5"      "ATP5F1"    "BAGE2"     "BCL8"      "BET3L"     "C12orf24"
[25] "C15orf62"  "C16orf93"  "C17orf86"  "C19orf70"  "C1orf182"  "C22orf29"

$GS2
 [1] "KRTAP5-5"     "KRTAP6-1"     "KRTAP9-8"     "KTI12"        "LASS1"
 [6] "LCMT2"        "LGALS9B"      "LOC100093631" "LOC100101115" "LOC100101266"
[11] "LOC100130264" "LOC100130932" "LOC100131193" "LOC100131726" "LOC100132247"
[16] "LOC100132832" "LOC100133920" "LOC100286938" "LOC144438"    "LOC145820"
[21] "LOC148413"    "LOC202781"    "LOC286367"    "LOC339047"    "LOC388499"
[26] "LOC392196"    "LOC399753"    "LOC440895"    "LOC441294"    "LOC441455"

$GS3
 [1] "SNORA17"     "SNORA23"     "SNORA25"     "SNORA2B"     "SNORA31"
 [6] "SNORA36C"    "SNORA64"     "SNORD11"     "SNORD113-5"  "SNORD113-7"
[11] "SNORD114-1"  "SNORD114-16" "SNORD114-17" "SNORD114-18" "SNORD114-21"
[16] "SNORD114-27" "SNORD114-28" "SNORD114-5"  "SNORD114-6"  "SNORD114-8"
[21] "SNORD114-9"  "SNORD116-16" "SNORD116-26" "SNORD116-29" "SNORD12"
[26] "SNORD125"    "SNORD126"    "SNORD16"     "SNORD38B"    "SNORD50A"
```

Below is an example of running methylglm with parallel option

```
library(BiocParallel)
res_p = methylglm(cpg.pval = cpg.pval, minsize = 200,
                  maxsize = 500, GS.type = "KEGG", parallel = TRUE)
```

methylglm and methylRRA support user supplied CpG ID to gene mapping. The mapping is expected to be a matrix, or a data frame or a list. For a matrix or data frame, 1st column should be CpG ID and 2nd column should be gene name. For a list, entry names should be gene names and elements correpond to CpG IDs. Below an example of user supplied CpG to gene mapping.

```
data(CpG2Genetoy)
head(CpG2Gene)
```

```
         CpG   Gene
1 cg00050873  TSPY4
2 cg00212031 TTTY14
3 cg00214611 TMSB4Y
4 cg01707559  TBL1Y
5 cg02004872 TMSB4Y
6 cg02011394  TSPY4
```

To use user supplied mapping in methylglm or methylRRA, first preprocess the mapping by prepareAnnot function

```
FullAnnot = prepareAnnot(CpG2Gene)
```

Test the gene sets using “ORA” in methylRRA, use `FullAnnot` argument to provide the preprocessed CpG ID to gene mapping

```
GS.list = GS.list[1:10]
res5 = methylRRA(cpg.pval = cpg.pval, FullAnnot = FullAnnot, method = "ORA",
                    GS.list = GS.list, GS.idtype = "SYMBOL",
                    minsize = 100, maxsize = 300)
head(res5, 10)
```

```
       ID Count Size pvalue padj
GS1   GS1     0  157      1    1
GS2   GS2     0  257      1    1
GS3   GS3     0  181      1    1
GS4   GS4     0  274      1    1
GS5   GS5     0  285      1    1
GS6   GS6     0  108      1    1
GS7   GS7     0  202      1    1
GS8   GS8     0  273      1    1
GS9   GS9     0  206      1    1
GS10 GS10     0  187      1    1
```

Below is another example testing Reactome pathways using methylglm.

```
res6 = methylglm(cpg.pval = cpg.pval, array.type = "450K",
                    GS.type = "Reactome", minsize = 100, maxsize = 110)
head(res6, 10)
```

## Visualization

Following bar plot implemented in enrichplot [12], we also provide bar plot to visualize the gene set analysis results. The input of `barplot` function can be any result returned by methylglm, methylRRA, or methylgometh. Various options are provided for users to customize the plot.

* `xaxis` is to specify the label in x-axis. It is either “Count” (number of significant genes in gene set) or “Size” (total number of genes in gene set). “Count” option is not available for methylglm and methylRRA(GSEA). Default is “Size”.
* `num` is to specify the number of genes sets to display on the bar plot. Default is 5.
* `colorby` is a string. Either “pvalue” or “padj”. Default is “padj”.
* `title` is a string. The title to display on the bar plot. Default is NULL.

### Example

Below is an example of using barplot to visualize the result of methylglm.

```
barplot(res1, num = 8, colorby = "pvalue")
```

![](data:image/png;base64...)

## Session info

```
sessionInfo()
```

```
R version 4.5.1 Patched (2025-08-23 r88802)
Platform: x86_64-pc-linux-gnu
Running under: Ubuntu 24.04.3 LTS

Matrix products: default
BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0

locale:
 [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
 [3] LC_TIME=en_GB              LC_COLLATE=C
 [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
 [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
 [9] LC_ADDRESS=C               LC_TELEPHONE=C
[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

time zone: America/New_York
tzcode source: system (glibc)

attached base packages:
[1] parallel  stats4    stats     graphics  grDevices utils     datasets
[8] methods   base

other attached packages:
 [1] org.Hs.eg.db_3.22.0
 [2] AnnotationDbi_1.72.0
 [3] IlluminaHumanMethylation450kanno.ilmn12.hg19_0.6.1
 [4] minfi_1.56.0
 [5] bumphunter_1.52.0
 [6] locfit_1.5-9.12
 [7] iterators_1.0.14
 [8] foreach_1.5.2
 [9] Biostrings_2.78.0
[10] XVector_0.50.0
[11] SummarizedExperiment_1.40.0
[12] Biobase_2.70.0
[13] MatrixGenerics_1.22.0
[14] matrixStats_1.5.0
[15] GenomicRanges_1.62.0
[16] Seqinfo_1.0.0
[17] IRanges_2.44.0
[18] S4Vectors_0.48.0
[19] BiocGenerics_0.56.0
[20] generics_0.1.4
[21] methylGSA_1.28.0

loaded via a namespace (and not attached):
  [1] later_1.4.4
  [2] splines_4.5.1
  [3] BiocIO_1.20.0
  [4] bitops_1.0-9
  [5] ggplotify_0.1.3
  [6] tibble_3.3.0
  [7] R.oo_1.27.1
  [8] preprocessCore_1.72.0
  [9] XML_3.99-0.19
 [10] lifecycle_1.0.4
 [11] lattice_0.22-7
 [12] MASS_7.3-65
 [13] base64_2.0.2
 [14] scrime_1.3.5
 [15] magrittr_2.0.4
 [16] limma_3.66.0
 [17] sass_0.4.10
 [18] rmarkdown_2.30
 [19] jquerylib_0.1.4
 [20] yaml_2.3.10
 [21] otel_0.2.0
 [22] httpuv_1.6.16
 [23] ggtangle_0.0.7
 [24] doRNG_1.8.6.2
 [25] askpass_1.2.1
 [26] cowplot_1.2.0
 [27] DBI_1.2.3
 [28] RColorBrewer_1.1-3
 [29] abind_1.4-8
 [30] quadprog_1.5-8
 [31] purrr_1.1.0
 [32] R.utils_2.13.0
 [33] RCurl_1.98-1.17
 [34] yulab.utils_0.2.1
 [35] rappdirs_0.3.3
 [36] gdtools_0.4.4
 [37] enrichplot_1.30.0
 [38] ggrepel_0.9.6
 [39] tidytree_0.4.6
 [40] rentrez_1.2.4
 [41] reactome.db_1.94.0
 [42] genefilter_1.92.0
 [43] annotate_1.88.0
 [44] DelayedMatrixStats_1.32.0
 [45] codetools_0.2-20
 [46] DelayedArray_0.36.0
 [47] DOSE_4.4.0
 [48] xml2_1.4.1
 [49] tidyselect_1.2.1
 [50] aplot_0.2.9
 [51] UCSC.utils_1.6.0
 [52] farver_2.1.2
 [53] beanplot_1.3.1
 [54] illuminaio_0.52.0
 [55] GenomicAlignments_1.46.0
 [56] jsonlite_2.0.0
 [57] multtest_2.66.0
 [58] survival_3.8-3
 [59] RobustRankAggreg_1.2.1
 [60] systemfonts_1.3.1
 [61] missMethyl_1.44.0
 [62] tools_4.5.1
 [63] treeio_1.34.0
 [64] Rcpp_1.1.0
 [65] glue_1.8.0
 [66] SparseArray_1.10.0
 [67] xfun_0.53
 [68] qvalue_2.42.0
 [69] GenomeInfoDb_1.46.0
 [70] dplyr_1.1.4
 [71] HDF5Array_1.38.0
 [72] withr_3.0.2
 [73] fastmap_1.2.0
 [74] rhdf5filters_1.22.0
 [75] openssl_2.3.4
 [76] digest_0.6.37
 [77] mime_0.13
 [78] R6_2.6.1
 [79] gridGraphics_0.5-1
 [80] GO.db_3.22.0
 [81] dichromat_2.0-0.1
 [82] RSQLite_2.4.3
 [83] cigarillo_1.0.0
 [84] R.methodsS3_1.8.2
 [85] h5mread_1.2.0
 [86] tidyr_1.3.1
 [87] fontLiberation_0.1.0
 [88] data.table_1.17.8
 [89] rtracklayer_1.70.0
 [90] htmlwidgets_1.6.4
 [91] httr_1.4.7
 [92] S4Arrays_1.10.0
 [93] pkgconfig_2.0.3
 [94] gtable_0.3.6
 [95] IlluminaHumanMethylationEPICanno.ilm10b4.hg19_0.6.0
 [96] blob_1.2.4
 [97] S7_0.2.0
 [98] siggenes_1.84.0
 [99] clusterProfiler_4.18.0
[100] htmltools_0.5.8.1
[101] fontBitstreamVera_0.1.1
[102] fgsea_1.36.0
[103] scales_1.4.0
[104] png_0.1-8
[105] ggfun_0.2.0
[106] knitr_1.50
[107] tzdb_0.5.0
[108] reshape2_1.4.4
[109] rjson_0.2.23
[110] nlme_3.1-168
[111] curl_7.0.0
[112] cachem_1.1.0
[113] rhdf5_2.54.0
[114] stringr_1.5.2
[115] restfulr_0.0.16
[116] GEOquery_2.78.0
[117] pillar_1.11.1
[118] grid_4.5.1
[119] reshape_0.8.10
[120] vctrs_0.6.5
[121] promises_1.4.0
[122] xtable_1.8-4
[123] evaluate_1.0.5
[124] readr_2.1.5
[125] GenomicFeatures_1.62.0
[126] cli_3.6.5
[127] compiler_4.5.1
[128] Rsamtools_2.26.0
[129] rlang_1.1.6
[130] crayon_1.5.3
[131] rngtools_1.5.2
[132] labeling_0.4.3
[133] nor1mix_1.3-3
[134] mclust_6.1.1
[135] plyr_1.8.9
[136] fs_1.6.6
[137] ggiraph_0.9.2
[138] stringi_1.8.7
[139] BiocParallel_1.44.0
[140] lazyeval_0.2.2
[141] fontquiver_0.2.1
[142] GOSemSim_2.36.0
[143] Matrix_1.7-4
[144] hms_1.1.4
[145] patchwork_1.3.2
[146] sparseMatrixStats_1.22.0
[147] bit64_4.6.0-1
[148] ggplot2_4.0.0
[149] Rhdf5lib_1.32.0
[150] shiny_1.11.1
[151] KEGGREST_1.50.0
[152] statmod_1.5.1
[153] igraph_2.2.1
[154] memoise_2.0.1
[155] bslib_0.9.0
[156] ggtree_4.0.0
[157] fastmatch_1.1-6
[158] bit_4.6.0
[159] gson_0.1.0
[160] ape_5.8-1
```

## References

[1] Geeleher, Paul, Lori Hartnett, Laurance J Egan, Aaron Golden, Raja Affendi Raja Ali, and Cathal Seoighe. 2013. Gene-Set Analysis Is Severely Biased When Applied to Genome-Wide Methylation Data. Bioinformatics 29 (15). Oxford University Press: 1851–7.

[2] Kolde, Raivo, Sven Laur, Priit Adler, and Jaak Vilo. 2012. Robust Rank Aggregation for Gene List Integration and Meta-Analysis. Bioinformatics 28 (4). Oxford University Press: 573–80.

[3] Subramanian, Aravind, Pablo Tamayo, Vamsi K Mootha, Sayan Mukherjee, Benjamin L Ebert, Michael A Gillette, Amanda Paulovich, et al. 2005. Gene Set Enrichment Analysis: A Knowledge-Based Approach for Interpreting Genome-Wide Expression Profiles. Proceedings of the National Academy of Sciences 102 (43). National Acad Sciences: 15545–50.

[4] Phipson, Belinda, Jovana Maksimovic, and Alicia Oshlack. 2015. MissMethyl: An R Package for Analyzing Data from Illumina’s Humanmethylation450 Platform. Bioinformatics 32 (2). Oxford University Press: 286–88.

[5] Carlson M (2018). org.Hs.eg.db: Genome wide annotation for Human. R package version 3.6.0.

[6] Ligtenberg W (2018). reactome.db: A set of annotation maps for reactome. R package version 1.64.0.

[7] Hansen, KD. (2016). IlluminaHumanMethylation450kanno.ilmn12.hg19: Annotation for Illumina’s 450k Methylation Arrays. R Package, Version 0.6.0 1.

[8] Hansen, KD. (2017). IlluminaHumanMethylationEPICanno.ilm10b4.hg19: Annotation for Illumina’s Epic Methylation Arrays. R Package, Version 0.6.0 1.

[9] Mi, Gu, Yanming Di, Sarah Emerson, Jason S Cumbie, and Jeff H Chang. 2012. Length Bias Correction in Gene Ontology Enrichment Analysis Using Logistic Regression. PloS One 7 (10). Public Library of Science: e46128.

[10] Benjamini, Yoav, and Yosef Hochberg. 1995. Controlling the False Discovery Rate: A Practical and Powerful Approach to Multiple Testing. Journal of the Royal Statistical Society. Series B (Methodological). JSTOR, 289–300.

[11] Young, Matthew D, Matthew J Wakefield, Gordon K Smyth, and Alicia Oshlack. 2012. Goseq: Gene Ontology Testing for Rna-Seq Datasets. R Bioconductor.

[12] Yu G (2018). enrichplot: Visualization of Functional Enrichment Result. R package version 1.0.2, <https://github.com/GuangchuangYu/enrichplot>.