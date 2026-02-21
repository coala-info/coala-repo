# Annotation for unannotated single-cell RNA-Seq data by `scTGIF`

Koki Tsuyuzaki1 and Itoshi Nikaido1\*

1Laboratory for Bioinformatics Research, RIKEN Center for Biosystems Dynamics Reseach

\*k.t.the-answer@hotmail.co.jp

#### 30 October 2025

#### Package

scTGIF 1.24.0

# Contents

* [1 Introduction](#introduction)
  + [1.1 About scTGIF](#about-sctgif)
* [2 Usage](#usage)
  + [2.0.1 Test data](#test-data)
  + [2.0.2 Parameter setting : settingTGIF](#parameter-setting-settingtgif)
  + [2.0.3 Calculate attention maps and map-related gene functions: calcTGIF](#calculate-attention-maps-and-map-related-gene-functions-calctgif)
  + [2.0.4 HTML Report : reportTGIF](#html-report-reporttgif)
* [Session information](#session-information)

# 1 Introduction

## 1.1 About scTGIF

Here, we explain the concept of *[scTGIF](https://bioconductor.org/packages/3.22/scTGIF)*.
The analysis of single-cell RNA-Seq (scRNA-Seq) has a
potential difficult problem; which data corresponds to what kind of
cell type is not known *a priori*.

Therefore, at the start point of the data analysis of the scRNA-Seq dataset,
each cell is “not colored” (unannotated) (Figure 1).
There some approaches to support users to infer the cell types
such as (1) Known marker gene expression,
(2) BLAST-like gene expression comparison with reference DB,
(3) differentially expressed genes (DEGs)
and over-representative analysis (ORA)
([scRNA-tools](https://www.scrna-tools.org)).

The first approach might be the most popular method,
but this task is based on the expert knowledge about the cell types,
and not always general-purpose.
The second approach is easy and scalable,
but still limited when the cell type is not known
or still not measured by the other research organization.
The third approach can perhaps be used in any situation but ambiguous and
time-consuming task;
this task is based on the cluster label and the true cluster structure,
which is not known and some DEG methods have to be performed in each cluster,
but recent scRNA-Seq dataset has tens to hundreds of cell types.
Besides, a scRNA-Seq dataset can have low-quality cells and artifacts
(e.g. doublet) but it is hard to distinguish from real cell data.
Therefore, in actual data analytical situation, laborious
trial-and-error cycle along with the change of cellular label
cannot be evitable (Figure 1).

*[scTGIF](https://bioconductor.org/packages/3.22/scTGIF)* is developed to reduce this trial-and-error cycle;
This tool directly connects the unannotated cells and
related gene function.
Since this tool does not use reference DB, marker gene list,
and cluster label can be used in any situation without expert knowledge
and is not influenced by the change of cellular label.

![](data:image/png;base64...)

Figure 1: Concept of scTGIF

In *[scTGIF](https://bioconductor.org/packages/3.22/scTGIF)*, three data is required; the gene expression matrix,
2D coordinates of the cells (e.g. t-SNE, UMAP), and geneset of MSigDB.
Firstly, the 2D coordinates are segmented as 50-by-50 grids,
and gene expression is summarized in each grid level (**X1**).
Next, the correspondence between genes and the related gene functions
are summarized as gene-by-function matrix (**X2**).
Here, we support only common genes are used in **X1** and **X2**.
Performing joint non-negative matrix factorization (jNMF) algorithm,
which is implemented in *[nnTensor](https://CRAN.R-project.org/package%3DnnTensor)*,
the shared latent variables (**W**) with the two matrices are estimated.

![](data:image/png;base64...)

Figure 2: Joint NMF

By this algorithm, a grid set and corresponding gene functions are paired.
Lower-dimension (**D**)-by-Grid matrix **H1** works as attention maps to help
users to pay attention the grids, and **D**-by-Function matrix **H2**
shows the gene function enriched in the grids.

![](data:image/png;base64...)

Figure 3: H1 and H2 matrices

*[scTGIF](https://bioconductor.org/packages/3.22/scTGIF)* also supports some QC metrics to distinguish
low-quality cells and artifacts from real cellular data.

# 2 Usage

### 2.0.1 Test data

To demonstrate the usage of *[scTGIF](https://bioconductor.org/packages/3.22/scTGIF)*,
we prepared a testdata of
[distal lung epithelium](https://www.nature.com/articles/nature13173).

```
library("scTGIF")
library("SingleCellExperiment")
library("GSEABase")
library("msigdbr")

data("DistalLungEpithelium")
data("pca.DistalLungEpithelium")
data("label.DistalLungEpithelium")
```

Although this data is still annotated and the cell type label is provided,
*[scTGIF](https://bioconductor.org/packages/3.22/scTGIF)* does not rely on this information.

```
par(ask=FALSE)
plot(pca.DistalLungEpithelium, col=label.DistalLungEpithelium, pch=16,
    main="Distal lung epithelium dataset", xlab="PCA1", ylab="PCA2", bty="n")
text(0.1, 0.05, "AT1", col="#FF7F00", cex=2)
text(0.07, -0.15, "AT2", col="#E41A1C", cex=2)
text(0.13, -0.04, "BP", col="#A65628", cex=2)
text(0.125, -0.15, "Clara", col="#377EB8", cex=2)
text(0.09, -0.2, "Cilliated", col="#4DAF4A", cex=2)
```

![](data:image/png;base64...)

To combine with the gene expression and the related gene function,
we suppose the gene function data is summarized as the object of
*[GSEABase](https://bioconductor.org/packages/3.22/GSEABase)*.
This data is directly downloadable from MSigDB and can be imported like
gmt <- GSEABase::getGmt(“/YOURPATH/h.all.v6.0.entrez.gmt”)

Note that *[scTGIF](https://bioconductor.org/packages/3.22/scTGIF)* only supports NCBI Gene IDs (Entrez IDs)
for now.
When the scRNA-Seq is not about human, the situation is more complicated.
Here, we use *[msigdbr](https://CRAN.R-project.org/package%3Dmsigdbr)* package to retrieve
the mouse MSigDB genesets like below.

```
m_df = msigdbr(species = "Mus musculus",
    category = "H")[, c("gs_name", "entrez_gene")]
```

```
## Using human MSigDB with ortholog mapping to mouse. Use `db_species = "MM"` for mouse-native gene sets.
## This message is displayed once per session.
```

```
## Warning: The `category` argument of `msigdbr()` is deprecated as of msigdbr 10.0.0.
## ℹ Please use the `collection` argument instead.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
hallmark = unique(m_df$gs_name)
gsc <- lapply(hallmark, function(h){
    target = which(m_df$gs_name == h)
    geneIds = unique(as.character(m_df$entrez_gene[target]))
    GeneSet(setName=h, geneIds)
})
gmt = GeneSetCollection(gsc)
gmt = gmt[1:10] # Reduced for this demo
```

### 2.0.2 Parameter setting : settingTGIF

Next, the data matrix is converted to the object of
*[SingleCellExperiment](https://bioconductor.org/packages/3.22/SingleCellExperiment)* package,
and the 2D coordinates are registered as the reducedDims slot.

```
sce <- SingleCellExperiment(assays = list(counts = DistalLungEpithelium))
reducedDims(sce) <- SimpleList(PCA=pca.DistalLungEpithelium)
```

Although the default mode of *[scTGIF](https://bioconductor.org/packages/3.22/scTGIF)* use `count` slot as
the input matrix,
the normalized gene expression data can also be specified.
In such a case, we recommend using `normcounts` slot to register the data.

```
CPMED <- function(input){
    libsize <- colSums(input)
    median(libsize) * t(t(input) / libsize)
}
normcounts(sce) <- log10(CPMED(counts(sce)) + 1)
```

After the registration of the data in `sce`,
`settingTGIF` will work like below.

```
settingTGIF(sce, gmt, reducedDimNames="PCA", assayNames="normcounts")
```

### 2.0.3 Calculate attention maps and map-related gene functions: calcTGIF

After the setting above,
`calcTGIF` calculates the jNMF with the two matrices described above.

```
calcTGIF(sce, ndim=3)
```

```
## Gene x Grid matrix (X) has 334 rows and 78 columns
## Gene x Function matrix (Y) has 334 rows and 10 columns
```

### 2.0.4 HTML Report : reportTGIF

Finally, `reportTGIF` generates the HTML report to summarize
the result of jNMF.

```
reportTGIF(sce,
    html.open=FALSE,
    title="scTGIF Report for DistalLungEpithelium dataset",
    author="Koki Tsuyuzaki")
```

```
## Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`.
## ℹ See also `vignette("ggplot2-in-packages")` for more information.
## ℹ The deprecated feature was likely used in the scTGIF package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## index.Rmd is created...
```

```
## index.Rmd is compiled to index.html...
```

```
## ################################################
## Data files are saved in
## /tmp/RtmpgalJPb
## ################################################
```

Since this function takes some time,
please type `example("reportTGIF")` by your own environment.

# Session information

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
##  [1] plotly_4.11.0               ggplot2_4.0.0
##  [3] msigdbr_25.1.1              GSEABase_1.72.0
##  [5] graph_1.88.0                annotate_1.88.0
##  [7] XML_3.99-0.19               AnnotationDbi_1.72.0
##  [9] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
## [11] Biobase_2.70.0              GenomicRanges_1.62.0
## [13] Seqinfo_1.0.0               IRanges_2.44.0
## [15] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [17] generics_0.1.4              MatrixGenerics_1.22.0
## [19] matrixStats_1.5.0           scTGIF_1.24.0
## [21] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] DBI_1.2.3           tcltk_4.5.1         rlang_1.1.6
##  [4] magrittr_2.0.4      compiler_4.5.1      RSQLite_2.4.3
##  [7] systemfonts_1.3.1   png_0.1-8           vctrs_0.6.5
## [10] maps_3.4.3          nnTensor_1.3.0      pkgconfig_2.0.3
## [13] crayon_1.5.3        fastmap_1.2.0       magick_2.9.0
## [16] XVector_0.50.0      labeling_0.4.3      tagcloud_0.7.0
## [19] rmarkdown_2.30      ragg_1.5.0          tinytex_0.57
## [22] purrr_1.1.0         bit_4.6.0           xfun_0.53
## [25] cachem_1.1.0        jsonlite_2.0.0      blob_1.2.4
## [28] DelayedArray_0.36.0 tweenr_2.0.3        cluster_2.1.8.1
## [31] R6_2.6.1            bslib_0.9.0         RColorBrewer_1.1-3
## [34] schex_1.24.0        jquerylib_0.1.4     Rcpp_1.1.0
## [37] bookdown_0.45       assertthat_0.2.1    knitr_1.50
## [40] fields_17.1         igraph_2.2.1        Matrix_1.7-4
## [43] tidyselect_1.2.1    dichromat_2.0-0.1   abind_1.4-8
## [46] yaml_2.3.10         misc3d_0.9-1        curl_7.0.0
## [49] lattice_0.22-7      tibble_3.3.0        withr_3.0.2
## [52] KEGGREST_1.50.0     S7_0.2.0            evaluate_1.0.5
## [55] polyclip_1.10-7     Biostrings_2.78.0   pillar_1.11.1
## [58] BiocManager_1.30.26 scales_1.4.0        xtable_1.8-4
## [61] rTensor_1.4.9       glue_1.8.0          lazyeval_0.2.2
## [64] tools_4.5.1         hexbin_1.28.5       data.table_1.17.8
## [67] babelgene_22.9      dotCall64_1.2       grid_4.5.1
## [70] tidyr_1.3.1         crosstalk_1.2.2     ggforce_0.5.0
## [73] cli_3.6.5           textshaping_1.0.4   spam_2.11-1
## [76] S4Arrays_1.10.0     plot3D_1.4.2        viridisLite_0.4.2
## [79] dplyr_1.1.4         concaveman_1.2.0    gtable_0.3.6
## [82] sass_0.4.10         digest_0.6.37       SparseArray_1.10.0
## [85] htmlwidgets_1.6.4   farver_2.1.2        entropy_1.3.2
## [88] memoise_2.0.1       htmltools_0.5.8.1   lifecycle_1.0.4
## [91] httr_1.4.7          bit64_4.6.0-1       MASS_7.3-65
```