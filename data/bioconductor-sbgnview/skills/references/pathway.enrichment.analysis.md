# SBGNview Based Pathway Analysis and Visualization Workflow

#### Xiaoxi Dong

#### Kovidh Vegesna, kvegesna (AT) uncc.edu

#### Weijun Luo, luo\_weijun (AT) yahoo.com

#### 30 October, 2025

# 1 Introduction

SBGNview has collected pathway data and gene sets from the following databases: Reactome, PANTHER Pathway, SMPDB, MetaCyc and MetaCrop. These gene sets can be used for pathway enrichment analysis.

In this vignette, we will show you a complete pathway analysis workflow based on GAGE + SBGNview. Similar workflows have been documented in the [gage package](https://bioconductor.org/packages/gage/) using GAGE + [Pathview](https://bioconductor.org/packages/pathview/).

# 2 Citation

Please cite the following papers when using the open-source SBGNview package. This will help the project and our team:

Luo W, Brouwer C. Pathview: an R/Biocondutor package for pathway-based data integration and visualization. Bioinformatics, 2013, 29(14):1830-1831, [doi: 10.1093/bioinformatics/btt285](https://doi.org/10.1093/bioinformatics/btt285)

Please also cite the GAGE paper when using the gage package:

Luo W, Friedman M, etc. GAGE: generally applicable gene set enrichment for pathway analysis. BMC Bioinformatics, 2009, 10, pp. 161, [doi: 10.1186/1471-2105-10-161](https://doi.org/10.1186/1471-2105-10-161)

# 3 Installation and quick start

Please see the [Quick Start tutorial](https://bioconductor.org/packages/devel/bioc/vignettes/SBGNview/inst/doc/SBGNview.quick.start.html) for installation instructions and quick start examples.

# 4 Complete pathway analysis + visualization workflow

In this example, we analyze a RNA-Seq dataset of IFNg KO mice vs wild type mice. It contains normalized RNA-seq gene expression data described in Greer, Renee L., Xiaoxi Dong, et al, 2016.

## 4.1 Load the gene (RNA-seq) data

The RNA abundance data was quantile normalized and log2 transformed, stored in a [“SummarizedExperiment”](https://bioconductor.org/packages/release/bioc/html/SummarizedExperiment.html) object. SBGNview input user data (gene.data or cpd.data) can be either a numeric matrix or a vector, like those in [pathview](https://bioconductor.org/packages/pathview/). In addition, it can be a “SummarizedExperiment” object, which is commonly used in BioConductor packages.

```
library(SBGNview)
library(SummarizedExperiment)
data("IFNg", "pathways.info")
count.data <- assays(IFNg)$counts
head(count.data)
wt.cols <- which(IFNg$group == "wt")
ko.cols <- which(IFNg$group == "ko")
```

## 4.2 Gene sets from SBGNview pathway collection

### 4.2.1 Load gene set for mouse with ENSEMBL gene IDs

```
ensembl.pathway <- sbgn.gsets(id.type = "ENSEMBL",
                              species = "mmu",
                              mol.type = "gene",
                              output.pathway.name = TRUE
                              )
head(ensembl.pathway[[2]])
```

### 4.2.2 Pathway or gene set analysis using GAGE

```
if(!requireNamespace("gage", quietly = TRUE)) {
  BiocManager::install("gage", update = FALSE)
}

library(gage)
degs <- gage(exprs = count.data,
           gsets = ensembl.pathway,
           ref = wt.cols,
           samp = ko.cols,
           compare = "paired" #"as.group"
           )
head(degs$greater)[,3:5]
head(degs$less)[,3:5]
down.pathways <- row.names(degs$less)[1:10]
head(down.pathways)
```

## 4.3 Visualize perturbations in top SBGN pathways

### 4.3.1 Calculate fold changes or gene perturbations

The abundance values were log2 transformed. Here we calculate the fold change of IFNg KO group v.s. WT group.

```
ensembl.koVsWt <- count.data[,ko.cols]-count.data[,wt.cols]
head(ensembl.koVsWt)

#alternatively, we can also calculate mean fold changes per gene, which corresponds to gage analysis above with compare="as.group"
mean.wt <- apply(count.data[,wt.cols] ,1 ,"mean")
head(mean.wt)
mean.ko <- apply(count.data[,ko.cols],1,"mean")
head(mean.ko)
# The abundance values were on log scale. Hence fold change is their difference.
ensembl.koVsWt.m <- mean.ko - mean.wt
```

### 4.3.2 Visualize pathway perturbations by SBNGview

```
#load the SBGNview pathway collection, which may takes a few seconds.
data(sbgn.xmls)
down.pathways <- sapply(strsplit(down.pathways,"::"), "[", 1)
head(down.pathways)
sbgnview.obj <- SBGNview(
    gene.data = ensembl.koVsWt,
    gene.id.type = "ENSEMBL",
    input.sbgn = down.pathways[1:2],#can be more than 2 pathways
    output.file = "ifn.sbgnview.less",
    show.pathway.name = TRUE,
    max.gene.value = 2,
    min.gene.value = -2,
    mid.gene.value = 0,
    node.sum = "mean",
    output.format = c("png"),

    font.size = 2.3,
    org = "mmu",

    text.length.factor.complex = 3,
    if.scale.compartment.font.size = TRUE,
    node.width.adjust.factor.compartment = 0.04
)
sbgnview.obj
```

![\label{fig:ifng}SBGNview graph of the most down-regulated pathways in IFNg KO experiment](data:image/svg+xml;base64...)

Figure 4.1: SBGNview graph of the most down-regulated pathways in IFNg KO experiment

![\label{fig:ifna}SBGNview graph of the second most down-regulated pathways in IFNg KO experiment](data:image/svg+xml;base64...)

Figure 4.2: SBGNview graph of the second most down-regulated pathways in IFNg KO experiment

## 4.4 SBGNview with SummarizedExperiment object

The ‘cancer.ds’ is a microarray dataset from a breast cancer study. The dataset was adopted from gage package and processed into a SummarizedExperiment object. It is used to demo SBGNview’s visualization ability.

```
data("cancer.ds")
sbgnview.obj <- SBGNview(
    gene.data = cancer.ds,
    gene.id.type = "ENTREZID",
    input.sbgn = "R-HSA-877300",
    output.file = "demo.SummarizedExperiment",
    show.pathway.name = TRUE,
    max.gene.value = 1,
    min.gene.value = -1,
    mid.gene.value = 0,
    node.sum = "mean",
    output.format = c("png"),

    font.size = 2.3,
    org = "hsa",

    text.length.factor.complex = 3,
    if.scale.compartment.font.size = TRUE,
    node.width.adjust.factor.compartment = 0.04
   )
sbgnview.obj
```

![\label{fig:cancerds}SBGNview of a cancer dataset gse16873](data:image/svg+xml;base64...)

Figure 4.3: SBGNview of a cancer dataset gse16873

# 5 Session Info

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
##  [1] gage_2.60.0                 SummarizedExperiment_1.40.0
##  [3] Biobase_2.70.0              GenomicRanges_1.62.0
##  [5] Seqinfo_1.0.0               IRanges_2.44.0
##  [7] S4Vectors_0.48.0            BiocGenerics_0.56.0
##  [9] generics_0.1.4              MatrixGenerics_1.22.0
## [11] matrixStats_1.5.0           SBGNview_1.24.0
## [13] SBGNview.data_1.23.0        pathview_1.50.0
## [15] knitr_1.50
##
## loaded via a namespace (and not attached):
##  [1] sass_0.4.10          SparseArray_1.10.0   xml2_1.4.1
##  [4] bitops_1.0-9         lattice_0.22-7       RSQLite_2.4.3
##  [7] digest_0.6.37        magrittr_2.0.4       evaluate_1.0.5
## [10] grid_4.5.1           KEGGgraph_1.70.0     bookdown_0.45
## [13] GO.db_3.22.0         fastmap_1.2.0        blob_1.2.4
## [16] Matrix_1.7-4         jsonlite_2.0.0       AnnotationDbi_1.72.0
## [19] graph_1.88.0         DBI_1.2.3            httr_1.4.7
## [22] XML_3.99-0.19        Rgraphviz_2.54.0     Biostrings_2.78.0
## [25] jquerylib_0.1.4      abind_1.4-8          Rdpack_2.6.4
## [28] cli_3.6.5            rlang_1.1.6          crayon_1.5.3
## [31] rbibutils_2.3        XVector_0.50.0       bit64_4.6.0-1
## [34] DelayedArray_0.36.0  cachem_1.1.0         yaml_2.3.10
## [37] S4Arrays_1.10.0      tools_4.5.1          memoise_2.0.1
## [40] vctrs_0.6.5          R6_2.6.1             org.Hs.eg.db_3.22.0
## [43] png_0.1-8            lifecycle_1.0.4      KEGGREST_1.50.0
## [46] rsvg_2.7.0           bit_4.6.0            pkgconfig_2.0.3
## [49] bslib_0.9.0          xfun_0.53            htmltools_0.5.8.1
## [52] igraph_2.2.1         rmarkdown_2.30       compiler_4.5.1
## [55] RCurl_1.98-1.17
```