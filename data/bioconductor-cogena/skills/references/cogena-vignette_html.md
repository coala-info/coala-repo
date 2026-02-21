# cogena, a workflow for gene set enrichment analysis of co-expressed genes

#### Zhilong Jia, Michael R. Barnes

#### 2025-10-29

# 1 Abstract

**Co**-expressed **g**ene-set **en**richment **a**nalysis, cogena, is a workflow for gene set enrichment analysis of co-expressed genes. The cogena worklow (Figure 1) proceeds from co-expression analysis using a range of clustering methods, through to gene set enrichment analysis based on a range of pre-defined gene sets. Cogena can be applied to a number of different analytical scenarios dependent on the gene set used. Currently cogena is pre-built with gene sets from Msigdb and Connectivity Map, allowing pathway analysis and drug repositioning analysis respectively, the user can also add custom genes sets to expand analytical functionality further.

![](data:image/png;base64...)

Overview of the cogena workflow

The following sections outline a typical example of the cogena workflow, describing the input data and typical analysis steps required for pathway analysis and drug repositioning analysis.

# 2 A quick start

See examples using the `?cogena` command in R.

# 3 Data Input

```
Note: all the gene names should be gene SYMBOLs since they are used in
the gene set files. Other kinds of gene identifiers can be used
according to the identifiers used in the user-defined gene-set files.
```

## 3.1 Input data required

* A set of differentially expressed genes: These should be in a matrix with genes in rows and samples in columns, data.frame or ExpressionSet object.
* The sample labels indicating the labels, like control and disease, of each sample. A vector with sample names.

## 3.2 Example dataset

The `cogena` package has an example dataset, from the NCBI GEO database [GSE13355](http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE13355). The samples are derived from lesional and non-lesional skin of psoriasis patients. There are two objects in the Psoriasis dataset. See `?Psoriasis` for more details.

```
# library(cogena)
devtools::load_all("./")
```

```
## Warning: replacing previous import 'class::somgrid' by 'kohonen::somgrid' when
## loading 'cogena'
```

```
data(Psoriasis)
# objects in the Psoriasis dataset.
# Note: label of interest should follow the control label as this
# will affect the direction of gene regulation.
# For instance use factor (c("Normal", "Cancer", "Normal"),
# levels=c("Normal", "Cancer")), instead of factor(c("Normal",
# "Cancer","Normal")) since "Cancer" is the label of interest.
```

```
ls()
```

```
## [1] "DEexprs"     "sampleLabel"
```

# 4 Various Analyses

## 4.1 What kind of analysis can be done?

**The gene set used determines the type of analysis.**

There are a variety of gene sets in the `cogena` package, partly collected from [MSigDB](http://www.broadinstitute.org/gsea/msigdb/index.jsp) and [CMap](connectivitymap.org/cmap). Gene sets are summarized in Table 2.

Table 2. Cogena Gene Sets

| Gene Set | Description |
| --- | --- |
| c2.cp.kegg.v7.1.symbols.gmt.xz | KEGG gene sets |
| c2.cp.reactome.v7.1.symbols.gmt.xz | Reactome gene sets |
| c2.cp.v7.0.symbols.gmt.xz | all canonical pathways |
| c5.bp.v7.0.symbols.gmt.xz | GO biological processes |
| c5.mf.v7.0.symbols.gmt.xz | GO molecular functions |
| CmapDn100.gmt.xz | Connectivity map gene sets: top 100 down regulated per drug |
| CmapUp100.gmt.xz | Connectivity map gene sets: top 100 up regulated per drug |

User-defined gene-sets must be formatted gmt and/or compressed by xz, (such as c2.cp.kegg.v7.01.symbols.gmt or c2.cp.kegg.v7.01.symbols.gmt.xz). Gene sets should be copied to the extdata directory in the installation directory of cogena, such as ~/R/x86\_64-pc-linux-gnu- library/3.2/cogena/extdata in Linux), or kindly send to the author of cogena to share with others.

## 4.2 Types of analyses

* Pahtway Analysis
* GO Analysis
* Drug repositioning
* User defined

# 5 Pathway Analysis

Firstly, KEGG Pathway Analysis, will be demonstrated to show the utility of cogena. The other analyses based on cogena are similar to the process of pathway analysis. Here we used the KEGG pathway gene set (c2.cp.kegg.v7.01.symbols.gmt.xz), hierarchical and Pam clustering methods, 10 clusters, 2 CPU cores and “correlation” distance metric to set up the pathway analysis.

## 5.1 Parameter setting

```
# KEGG Pathway gene set
annoGMT <- "c2.cp.kegg.v7.01.symbols.gmt.xz"
# GO biological process gene set
# annoGMT <- "c5.bp.v7.0.symbols.gmt.xz"
annofile <- system.file("extdata", annoGMT, package="cogena")

# the number of clusters. It can be a vector.
# nClust <- 2:20
nClust <- 10
# Making factor "Psoriasis" behind factor "ct" means Psoriasis Vs Control
# is up-regualted
sampleLabel <- factor(sampleLabel, levels=c("ct", "Psoriasis"))

# the number of cores.
# ncore <- 8
ncore <- 2

# the clustering methods
# clMethods <- c("hierarchical","kmeans","diana","fanny","som","model",
# "sota","pam","clara","agnes") # All the methods can be used together.
clMethods <- c("hierarchical","pam")

# the distance metric
metric <- "correlation"

# the agglomeration method used for hierarchical clustering
# (hierarchical and agnes)
method <- "complete"
```

## 5.2 Cogena running

There are two steps for cogena analysis, co-expression analysis and then gene set enrichment analysis (here is pathway anlysis).

```
# Co-expression Analysis
genecl_result <- coExp(DEexprs, nClust=nClust, clMethods=clMethods,
                       metric=metric, method=method, ncore=ncore)

# Enrichment (Pathway) analysis for the co-expressed genes
clen_res <- clEnrich(genecl_result, annofile=annofile, sampleLabel=sampleLabel)
```

```
## Note: 671 out of 706 exist in the genes population.
```

```
summary(clen_res)
```

```
##
## Clustering Methods:
##  hierarchical pam
##
## The Number of Clusters:
##  10
##
## Metric of Distance Matrix:
##  correlation
##
## Agglomeration method for hierarchical clustering (hclust and agnes):
##  complete
##
## Gene set:
##  c2.cp.kegg.v7.01.symbols.gmt.xz
```

## 5.3 Results of pathway analysis

### 5.3.1 Summary of cogena result

After completing the cogena analysis, the user can use `summary` to see the summary of the result of cogena. And `enrichment` caculates the enrichment score of certain clustering methods and certain numbers of cluster.

Cogena does not automatically set the clustering method or the number of clusters. Here we show some principles to guide the user towards optimal selection of method and number of clusters:

* Different clusters should account for different gene sets.
* A gene set should enriched only in one cluster but not two or more.
* The number of genes in a gene set enriched cluster should be the smallest small possible to achieve the highest enrichment score.

```
summary(clen_res)
```

```
##
## Clustering Methods:
##  hierarchical pam
##
## The Number of Clusters:
##  10
##
## Metric of Distance Matrix:
##  correlation
##
## Agglomeration method for hierarchical clustering (hclust and agnes):
##  complete
##
## Gene set:
##  c2.cp.kegg.v7.01.symbols.gmt.xz
```

```
# Here we consider the "pam" method and 10 clusters.
# Always make the number as character, please!
enrichment.table <- enrichment(clen_res, "pam", "10")
```

### 5.3.2 Heatmap of expression profiling with clusters

`heatmapCluster` is developed to show the co-expression of differentially expressed genes. Figure 2 produced by `heatmapCluster` is an enhanced heatmap with co-expression information. Moreover, it is obvious to know which cluster contains up-regulated or down-regulated genes based on the colour.

```
# Always make the number as character, please!
heatmapCluster(clen_res, "pam", "10", maintitle="Psoriasis")
```

```
## The number of genes in each cluster:
## upDownGene
##   1   2
## 468 238
## cluster_size
##   1   2   3   4   5   6   7   8   9  10
## 158  65  38  92  50  67  63  94  61  18
```

![Heatmap of expression profiling with clusters](data:image/png;base64...)

Heatmap of expression profiling with clusters

### 5.3.3 Enrichment heatmap of co-expressed genes

`heatmapPEI` can be used to show the enrichment graph. See Figure 3. See `?heatmapPEI` for more details. Many parameters are configurable, while generally the default will be fine.

```
# The enrichment score for 10 clusters, together with Down-regulated,
# Up-regulated and All DE genes. The values shown in Figure 2 is the -log2(FDR).
#
# Always make the number as character, please!

heatmapPEI(clen_res, "pam", "10", printGS=FALSE, maintitle="Pathway analysis for Psoriasis")
```

```
## Joining with `by = join_by(rowname)`
## Joining with `by = join_by(clusterNumGene, GS)`
```

```
## Warning: The `size` argument of `element_line()` is deprecated as of ggplot2 3.4.0.
## ℹ Please use the `linewidth` argument instead.
## ℹ The deprecated feature was likely used in the cogena package.
##   Please report the issue at <https://github.com/zhilongjia/cogena/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![KEGG pathway enrichment](data:image/png;base64...)

KEGG pathway enrichment

Figure 3A shows the pathway enrichment for each cluster as well as up-regulated, down-regulated and all the differentially expressed genes. The enrichment scores can be ranked by a certain cluster or the max or average scores of all the scores for each pathway.

```
heatmapPEI(clen_res, "pam", "10", printGS=FALSE, maintitle="Pathway analysis for Psoriasis", geom="circle")
```

```
## Joining with `by = join_by(rowname)`
## Joining with `by = join_by(clusterNumGene, GS)`
```

![KEGG pathway enrichment circle visualization](data:image/png;base64...)

KEGG pathway enrichment circle visualization

Figure 3B shows the pathway enrichment using circle plotting.

# 6 Drug repositioning

Pathway analysis demonstrates that specific disease pathways are often represented by a single cluster. Accordingly, we recommend that drug repositioning is performed based on co-expressed gene clusters instead of all the differentially expressed genes. If the input of cogena is disease related data, the drugs enriched should recover the gene expression changed by the disease (the drug should induce an opposite direction in expression to the disease), while if the input is drug related, the enriched drugs should show similar gene expression changes caused by the drug studied. Here we show drugs for treating psoriasis, an autoimmune disease.

## 6.1 Drug repositioning analysis running

The drug repositioning gene set choice of *CmapDn100.gmt.xz* or *CmapUp100.gmt.xz* should be made based on the regulation direction of clusters. For example, as the 7th cluster contains up-regulated genes for psoriasis, the *CmapDn100.gmt.xz* is chosen for drug repositioning of psoriasis to recover the gene expression changes caused by the disease.

```
# A comprehensive way
# cmapDn100_cogena_result <- clEnrich(genecl_result,
# annofile=system.file("extdata", "CmapDn100.gmt.xz", package="cogena"),
# sampleLabel=sampleLabel)

# A quick way
# Based on the pathway analysis results
cmapDn100_cogena_result <- clEnrich_one(genecl_result, "pam", "10",
    annofile=system.file("extdata", "CmapDn100.gmt.xz", package="cogena"),
    sampleLabel=sampleLabel)
```

## 6.2 Original result of drug repositioning

Showing the results ordered by the 7th cluster in Figure 5. The parameter `orderMethod` is used to order the results.

```
heatmapPEI(cmapDn100_cogena_result, "pam", "10", printGS=FALSE,
           orderMethod = "7", maintitle="Drug repositioning for Psoriasis")
```

```
## Joining with `by = join_by(rowname)`
## Joining with `by = join_by(clusterNumGene, GS)`
```

![Drug repositioning](data:image/png;base64...)

Drug repositioning

```
# Results based on cluster 5.
# heatmapPEI(cmapDn100_cogena_result, "pam", "10", printGS=FALSE,
#           orderMethod = "5", maintitle="Drug repositioning for Psoriasis")

# Results based on cluster 9, containing down-regulated genes.
# heatmapPEI(cmapUp100_cogena_result, "pam", "10", printGS=FALSE,
#           orderMethod = "9", maintitle="Drug repositioning for Psoriasis")
```

## 6.3 Multi-instance merged result of drug repositioning

Usually there is more than one instance for a drug with different doses or time-points in the Cmap gene set. `heatmapCmap` can merge the multi-instance results based on parameter *mergeMethod* (“mean” or “max”). Figure 6 shows the multi-instance merged results ordered by the 7th cluster.

```
heatmapCmap(cmapDn100_cogena_result, "pam", "10", printGS=FALSE,
            orderMethod = "7", maintitle="Drug repositioning for Psoriasis")
```

```
## Warning: `funs()` was deprecated in dplyr 0.8.0.
## ℹ Please use a list of either functions or lambdas:
##
## # Simple named list: list(mean = mean, median = median)
##
## # Auto named with `tibble::lst()`: tibble::lst(mean, median)
##
## # Using lambdas list(~ mean(., trim = .2), ~ median(., na.rm = TRUE))
## ℹ The deprecated feature was likely used in the cogena package.
##   Please report the issue at <https://github.com/zhilongjia/cogena/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![Drug repositioning (multi-instance merged)](data:image/png;base64...)

Drug repositioning (multi-instance merged)

## 6.4 Other useful functions

### 6.4.1 Querying genes in a certain cluster

The user can obtain the genes in a certain cluster via `geneInCluster` , enabling other analyses, such as drug target identification.

```
# Always make the number as character, please!
geneC <- geneInCluster(clen_res, "pam", "10", "4")
head(geneC)
```

```
## [1] "CD47"      "SERPINB13" "PNP"       "MPZL2"     "KCNJ15"    "SOX7"
```

### 6.4.2 Gene expression profiling with cluster information

It can be obtained by `geneExpInCluster`. There are two items, `clusterGeneExp` and `label`, in the returned object of `geneExpInCluster`. It can be used for other application.

```
# Always make the number as character, please!
gec <- geneExpInCluster(clen_res, "pam", "10")
gec$clusterGeneExp[1:3, 1:4]
```

```
##         cluster_id GSM337261 GSM337262 GSM337263
## PI3              1  6.556556  6.040479  7.033708
## S100A7A          1  4.989918  4.971686  5.677227
## S100A12          1  4.873823  5.168421  5.255036
```

```
gec$label[1:4]
```

```
## GSM337261 GSM337262 GSM337263 GSM337264
##        ct        ct        ct        ct
## Levels: ct Psoriasis
```

### 6.4.3 The gene correlation in a cluster

The correlation among a cluster can be checked and visulised by `corInCluster`. See Figure 4.

```
# Always make the number as character, please!
corInCluster(clen_res, "pam", "10", "10")
```

![Correlation of genes in a cluster](data:image/png;base64...)

Correlation of genes in a cluster

# 7 Bug Report

<https://github.com/zhilongjia/cogena/issues>

# 8 Citation

[Jia, Zhilong, et al. “Cogena, a novel tool for co-expressed gene-set enrichment analysis, applied to drug repositioning and drug mode of action discovery.” BMC Genomics 17.1 (2016): 1.](http://bmcgenomics.biomedcentral.com/articles/10.1186/s12864-016-2737-8)

# 9 Other Information

System info

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] cogena_1.44.0   kohonen_3.0.12  ggplot2_4.0.0   cluster_2.1.8.1
##
## loaded via a namespace (and not attached):
##  [1] gtable_0.3.6        xfun_0.53           bslib_0.9.0
##  [4] devtools_2.4.6      remotes_2.5.0       caTools_1.18.3
##  [7] corrplot_0.95       Biobase_2.70.0      lattice_0.22-7
## [10] vctrs_0.6.5         tools_4.5.1         bitops_1.0-9
## [13] generics_0.1.4      parallel_4.5.1      tibble_3.3.0
## [16] DEoptimR_1.1-4      pkgconfig_2.0.3     Matrix_1.7-4
## [19] KernSmooth_2.23-26  RColorBrewer_1.1-3  S7_0.2.0
## [22] desc_1.4.3          lifecycle_1.0.4     stringr_1.5.2
## [25] compiler_4.5.1      farver_2.1.2        gplots_3.2.0
## [28] codetools_0.2-20    htmltools_0.5.8.1   usethis_3.2.1
## [31] class_7.3-23        sass_0.4.10         yaml_2.3.10
## [34] crayon_1.5.3        tidyr_1.3.1         pillar_1.11.1
## [37] jquerylib_0.1.4     MASS_7.3-65         ellipsis_0.3.2
## [40] cachem_1.1.0        sessioninfo_1.2.3   iterators_1.0.14
## [43] mclust_6.1.1        foreach_1.5.2       robustbase_0.99-6
## [46] gtools_3.9.5        tidyselect_1.2.1    digest_0.6.37
## [49] stringi_1.8.7       reshape2_1.4.4      dplyr_1.1.4
## [52] purrr_1.1.0         labeling_0.4.3      rprojroot_2.1.1
## [55] fastmap_1.2.0       grid_4.5.1          cli_3.6.5
## [58] magrittr_2.0.4      dichromat_2.0-0.1   pkgbuild_1.4.8
## [61] withr_3.0.2         scales_1.4.0        rmarkdown_2.30
## [64] fastcluster_1.3.0   memoise_2.0.1       evaluate_1.0.5
## [67] knitr_1.50          amap_0.8-20         doParallel_1.0.17
## [70] rlang_1.1.6         Rcpp_1.1.0          glue_1.8.0
## [73] BiocGenerics_0.56.0 biwt_1.0.1          pkgload_1.4.1
## [76] rstudioapi_0.17.1   jsonlite_2.0.0      plyr_1.8.9
## [79] R6_2.6.1            apcluster_1.4.14    fs_1.6.6
```