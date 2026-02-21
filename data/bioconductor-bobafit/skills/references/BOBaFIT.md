# BOBaFIT

Gaia Mazzocchetti1\*

1University of Bologna - DIMES

\*bioinformatics.seragnoli@gmail.com

#### 2025-10-29

#### Abstract

Good practices for BOBaFIT package

#### Package

BOBaFIT 1.14.0

# Contents

* [1 Introduction](#introduction)
* [2 Data](#data)
* [3 BOBaFIT Workflow](#bobafit-workflow)
  + [3.1 ComputeNormalChromosome](#computenormalchromosome)
  + [3.2 DRrefit](#drrefit)
    - [3.2.1 The Dataframes](#the-dataframes)
  + [3.3 DRrefit\_plot](#drrefit_plot)
* [4 PlotChrCluster](#plotchrcluster)
  + [4.1 The Dataframes](#the-dataframes-1)
* [Session info](#session-info)
* [Reference](#reference)

# 1 Introduction

The R package BoBafit is composed of four functions which allow the refit and the recalibration of copy number profile of tumor sample. In particular, the package was built to check, and possibly correct, the diploid regions. The wrong diploid region is a phenomenon that very often affects the profiles of samples with a very complex karyotype.

The principal and refitting function was named `DRrefit`, which - throughout a chromosome clustering method and a list of unaltered chromosomes (chromosome list) - recalibrates the copy number values. BoBafit also contains three secondary functions: `ComputeNormalChromosome`, which generates the chromosome list; `PlotChrCluster`, where is possible to visualize the cluster; and `Popeye`, which affixes its chromosomal arm to each segment (see in “Data Preparation” vignette).

# 2 Data

The package checks the diploid region assessment working on pre-estimated segment information, as the copy number and their position. We included a data set `TCGA_BRCA_CN_segments` where are showed all the information necessary. The data correspond to segments about 100 breast tumors samples obtained by the project TCGA-BRCA (Tomczak, Czerwińska, and Wiznerowicz [2015](#ref-Tomczak2015)). In the “Data Preparation” vingnette is shown how we download and prepare the dataset for the following analysis.

```
## Warning: replacing previous import 'ggplot2::geom_segment' by
## 'ggbio::geom_segment' when loading 'BOBaFIT'
```

# 3 BOBaFIT Workflow

Once the dataset has been prepared, the next step is to generate the chromosome list. The chromosome list is a vector containing all chromosomal arm which are the least affected by SCNAs in the tumor analyzed. Together with the clustering, the chromosome list is one the operating principles to rewrite the diploid region. The list can be manually created or by using the function `ComputeNormalChromosome`*.* We suggest these two sequential steps to allow the right refit and recalibration of sample’s diploid region:

1. `ComputeNormalChromosome()`
2. `DRrefit()`

Here we performed this analysis workflow on the dataset `TCGA_BRCA_CN_segments` described above.

## 3.1 ComputeNormalChromosome

The chromosome list is a vector specific for each tumor (type and subtype) . The chromosome arms included in this list must be selected based on how many CNA events they are subject to and how many times their CN falls into a “diploid range”. According to this principle, *ComputeNormalChromosome* write the chromosome list. The function allows to set the chromosomal alteration rate (`tolerance_val`), which corresponds to a minimum percentage of alterations that one wants to tolerate per arm.

With a little dataframe (less than 200 samples), we suggest an alteration rate of 5% (0.5) ; on the contrary, With a big dataframe (about 1000 samples), we suggest as maximum rate 20-25% (0.20-0.25) . The function input is a sample cohort with their segments.

Here we performed the function in the data set `TCGA_BRCA_CN_segments`, using an alteration rate of 25%.

```
chr_list
```

[1] “10q” “12q” “15q” “2p” “2q” “3p” “4q” “9q”

Storing the result in the variable `chr_list`, it will be a vector containing the chromosomal arms which present an alteration rate under the indicated `tolerance_val` value.

The function also plots in the Viewer a histogram where is possible observe the chromosomal alteration rate of each chromosomal arms and which one have been selected in the chromosome list (blue bars). The tolerance value has been set at 0.25 (dotted line).

\end{kframe}\begin{adjustwidth}{}{0mm}
\includegraphics[width=100%]{/tmp/RtmpbAdN01/Rbuild37490a61e7c34f/BOBaFIT/vignettes/BOBaFIT\_files/figure-html/chrlist plot-1} \end{adjustwidth}\begin{kframe}

## 3.2 DRrefit

To create a tumor-specific method that refit and recalibrate the tumor copy number profile, we developed the function `DRrefit`. It uses as input the sample’s segments - **cohort** or **single sample**-, and the chromosome list.

As said before, `DRrefit` estimates the right diploid region using two operating principle: a clustering function `NbClust` (Charrad et al. [2014](#ref-charrad2014)), which allow to estimete the best number of cluster in the sample, and the chromosome list. The clustering method can be sets with the argument `clust_method`. The options are: “ward.D”, “ward.D2”, “single”, “complete”, “average”, “mcquitty”, “median”, “centroid” and “kmeans”.

In this example, the `TCGA_BRCA_CN_segments`data table and the `chr_list` previously generated are used. The default value of `maxCN` (6) and `clust_method` (ward.d2) are used.

```
results <- DRrefit (segments_chort = TCGA_BRCA_CN_segments, chrlist = chr_list)
```

### 3.2.1 The Dataframes

* The data frame `corrected_segments` reports the CN corrected of the segments by the correction factor (CR) - value estimated for each sample by the function to correct the diploid region-

```
results$corrected_segments[1,]
```

| chr | start | end | ID | arm | chrarm | CN | CN\_corrected |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | 62920 | 21996664 | 01428281-1653-4839-b5cf-167bc62eb147 | p | 1p | 1.098 | 1.171 |

It is similar to the input one and report the new CN value of each segment calculated by DRrefit (`CN_corrected`).

* The data frame `report` contains all the information about the clustering as the outcome,the number of clusters found in that sample, the chromosome list and the CR used for the adjustment of the diploid region. Sample are also divided in three classes, based on their CR: No changes (CR<0.1); Recalibrated (0.1<CR<0.5); Refitted (CR >0.5). The class label is also reported in the data frame `report`.

```
results$report[1,]
```

| sample | clustering | ref\_clust\_chr | num\_clust | correction\_factor | correction\_class |
| --- | --- | --- | --- | --- | --- |
| 01428281-1653-4839-b5cf-167bc62eb147 | SUCCEDED | 10p, 10q, 11p, 13q, 14q, 15q, 16p, 16q, 17p, 18p, 18q, 19p, 19q, 1p, 20p, 20q, 21q, 22q, 2p, 2q, 3p, 4p, 4q, 5p, 5q, 6p, 6q, 7p, 7q, 8p, 9p, 9q | 3 | 0.0722233 | NO CHANGES |

When the column `clustering` reports FAIL, it indicates that , NbClust fails the chromosome clustering in that sample. In this case, the sample will not present clusters, so the input chromosome list will be kept as reference . When the column `clustering` reports SUCCED, NbClust succeeds and and the new chromosome list is chosen. The chromosome list used for each sample are all reported in the column `ref_clust_chr`.

## 3.3 DRrefit\_plot

Thanks to the function `DRrefit_plot` is possible appreciate the CN profile before and after the correction made by`DRrefit`. It makes a plot for each sample with the old and new segments positions. The x-axes represent the chromosomes with their genomic position, and the y-axes the copy number value. Above the plot are reported the sample name, the CR and the chromosomal arm used as reference to estimate the new diploid region.

```
corrected_segments <- results$corrected_segments
report <- results$report
```

```
# the plot is diplayed on the R viewer
DRrefit_plot(corrected_segments = corrected_segments,
             DRrefit_report = report,
             plot_viewer = TRUE,
             plot_save = FALSE )

# how to save the plot
DRrefit_plot(corrected_segments = corrected_segments,
             DRrefit_report = report,
             plot_save = TRUE, plot_format = "pdf", plot_path = "/my_path" )
```

Based on the CR value two plots can be displayed:

* CR ≤ 0.1: the new segment and the old segments are orange and red colored, respectively;

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## ℹ The deprecated feature was likely used in the ggbio package.
##   Please report the issue at <https://github.com/lawremi/ggbio/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: The `size` argument of `element_rect()` is deprecated as of ggplot2 3.4.0.
## ℹ Please use the `linewidth` argument instead.
## ℹ The deprecated feature was likely used in the BOBaFIT package.
##   Please report the issue at
##   <https://github.com/andrea-poletti-unibo/BOBaFIT/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: Removed 81 rows containing missing values or values outside the scale range
## (`geom_segment()`).
```

```
## Warning: Removed 82 rows containing missing values or values outside the scale range
## (`geom_segment()`).
```

\end{kframe}\begin{adjustwidth}{}{0mm}
\includegraphics[width=100%]{/tmp/RtmpbAdN01/Rbuild37490a61e7c34f/BOBaFIT/vignettes/BOBaFIT\_files/figure-html/DRrefit\_plot 1-1} \end{adjustwidth}\begin{kframe}

* CR > 0.1: the new segment and the old segments are green and red colored, respectively;

```
## Warning: Removed 52 rows containing missing values or values outside the scale range
## (`geom_segment()`).
```

```
## Warning: Removed 48 rows containing missing values or values outside the scale range
## (`geom_segment()`).
```

\end{kframe}\begin{adjustwidth}{}{0mm}
\includegraphics[width=100%]{/tmp/RtmpbAdN01/Rbuild37490a61e7c34f/BOBaFIT/vignettes/BOBaFIT\_files/figure-html/DRrefit\_plot 2-1} \end{adjustwidth}\begin{kframe}

# 4 PlotChrCluster

Another accessory function is `PlotChrCluster`. It can be used to visualize the chromosomal cluster in a single sample or in a sample cohort. The input data is always a .tsv file, as the data frame `TCGA_BRCA_CN_segments`. The option of `clust_method` argument are the same of `DRrefit`(“ward.D”, “ward.D2”, “single”, “complete”, “average”, “mcquitty”, “median”, “centroid” and “kmeans”).

```
Cluster <- PlotChrCluster(segs = TCGA_BRCA_CN_segments,
                       clust_method = "ward.D2",
                       plot_output= TRUE)
```

We suggest to store the output on a variable (in this example we use `Cluster`) to view and possibly save the data frame generated. The `PlotCuster` will automatically save the plot in the folder indicated by the variable `path` of the argument `plot_path`.

In the `PlotChrCluster` plot, the chromosomal arms are labeled and colored according to the cluster they belong to. The y-axis reports the arm CN.

![](data:image/png;base64...)

## 4.1 The Dataframes

The outputs `report` summarizes the outcome of clustering for each sample (fail or succeeded, the number of clusters), similar to DRrefit report output. The second output, `plot tables`, is a list of data frames (one per sample) and reports in which clustering the chromosomes of the sample have been placed.

```
head(Cluster$report)

#select plot table per sample
head(Cluster$plot_tables$`01428281-1653-4839-b5cf-167bc62eb147`)
```

```
knitr::kable(head(Cluster$report))
```

| sample | clustering | num\_clust |
| --- | --- | --- |
| 01428281-1653-4839-b5cf-167bc62eb147 | SUCCEDED | 3 |
| 01bc5261-bf91-4f7b-a6b4-0e727c5e31d2 | SUCCEDED | 2 |
| 05afee4e-9acd-44f1-8a0c-ffa34d772b9c | SUCCEDED | 3 |
| 091f70c0-586a-49e8-a0e5-0b60caa72c1b | SUCCEDED | 3 |
| 0941a978-c8aa-467b-8464-9f979d1f0418 | SUCCEDED | 2 |

```
#select plot table per sample
knitr::kable(head(Cluster$plot_tables$`01428281-1653-4839-b5cf-167bc62eb147`))
```

| chr | cluster | CN |
| --- | --- | --- |
| 1p | cluster1 | 1.670236 |
| 1q | cluster2 | 3.140345 |
| 2p | cluster1 | 1.906657 |
| 2q | cluster1 | 1.911449 |
| 3p | cluster1 | 1.996745 |
| 3q | cluster2 | 2.624881 |

# Session info

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
## [1] dplyr_1.1.4      BOBaFIT_1.14.0   BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] DBI_1.2.3                   bitops_1.0-9
##   [3] RBGL_1.86.0                 gridExtra_2.3
##   [5] rlang_1.1.6                 magrittr_2.0.4
##   [7] biovizBase_1.58.0           matrixStats_1.5.0
##   [9] compiler_4.5.1              RSQLite_2.4.3
##  [11] GenomicFeatures_1.62.0      png_0.1-8
##  [13] vctrs_0.6.5                 reshape2_1.4.4
##  [15] ProtGenerics_1.42.0         stringr_1.5.2
##  [17] pkgconfig_2.0.3             crayon_1.5.3
##  [19] fastmap_1.2.0               magick_2.9.0
##  [21] backports_1.5.0             XVector_0.50.0
##  [23] labeling_0.4.3              Rsamtools_2.26.0
##  [25] rmarkdown_2.30              graph_1.88.0
##  [27] UCSC.utils_1.6.0            tinytex_0.57
##  [29] purrr_1.1.0                 bit_4.6.0
##  [31] xfun_0.53                   cachem_1.1.0
##  [33] cigarillo_1.0.0             GenomeInfoDb_1.46.0
##  [35] jsonlite_2.0.0              blob_1.2.4
##  [37] DelayedArray_0.36.0         tweenr_2.0.3
##  [39] BiocParallel_1.44.0         parallel_4.5.1
##  [41] cluster_2.1.8.1             plyranges_1.30.0
##  [43] VariantAnnotation_1.56.0    R6_2.6.1
##  [45] bslib_0.9.0                 stringi_1.8.7
##  [47] RColorBrewer_1.1-3          rtracklayer_1.70.0
##  [49] rpart_4.1.24                GenomicRanges_1.62.0
##  [51] jquerylib_0.1.4             Rcpp_1.1.0
##  [53] Seqinfo_1.0.0               bookdown_0.45
##  [55] SummarizedExperiment_1.40.0 knitr_1.50
##  [57] base64enc_0.1-3             IRanges_2.44.0
##  [59] Matrix_1.7-4                nnet_7.3-20
##  [61] tidyselect_1.2.1            rstudioapi_0.17.1
##  [63] dichromat_2.0-0.1           abind_1.4-8
##  [65] yaml_2.3.10                 codetools_0.2-20
##  [67] curl_7.0.0                  lattice_0.22-7
##  [69] tibble_3.3.0                plyr_1.8.9
##  [71] withr_3.0.2                 Biobase_2.70.0
##  [73] KEGGREST_1.50.0             S7_0.2.0
##  [75] evaluate_1.0.5              foreign_0.8-90
##  [77] polyclip_1.10-7             Biostrings_2.78.0
##  [79] pillar_1.11.1               BiocManager_1.30.26
##  [81] MatrixGenerics_1.22.0       checkmate_2.3.3
##  [83] stats4_4.5.1                OrganismDbi_1.52.0
##  [85] generics_0.1.4              RCurl_1.98-1.17
##  [87] ensembldb_2.34.0            S4Vectors_0.48.0
##  [89] ggplot2_4.0.0               scales_1.4.0
##  [91] ggbio_1.58.0                glue_1.8.0
##  [93] Hmisc_5.2-4                 lazyeval_0.2.2
##  [95] tools_4.5.1                 BiocIO_1.20.0
##  [97] data.table_1.17.8           BSgenome_1.78.0
##  [99] GenomicAlignments_1.46.0    XML_3.99-0.19
## [101] grid_4.5.1                  tidyr_1.3.1
## [103] AnnotationDbi_1.72.0        colorspace_2.1-2
## [105] ggforce_0.5.0               restfulr_0.0.16
## [107] htmlTable_2.4.3             Formula_1.2-5
## [109] cli_3.6.5                   NbClust_3.0.1
## [111] S4Arrays_1.10.0             AnnotationFilter_1.34.0
## [113] gtable_0.3.6                sass_0.4.10
## [115] digest_0.6.37               BiocGenerics_0.56.0
## [117] SparseArray_1.10.0          rjson_0.2.23
## [119] htmlwidgets_1.6.4           farver_2.1.2
## [121] memoise_2.0.1               htmltools_0.5.8.1
## [123] lifecycle_1.0.4             httr_1.4.7
## [125] MASS_7.3-65                 bit64_4.6.0-1
```

# Reference

Charrad, Malika, Nadia Ghazzali, Véronique Boiteau, and Azam Niknafs. 2014. “NbClust: AnRPackage for Determining the Relevant Number of Clusters in a Data Set.” *Journal of Statistical Software* 61 (6). <https://doi.org/10.18637/jss.v061.i06>.

Tomczak, Katarzyna, Patrycja Czerwińska, and Maciej Wiznerowicz. 2015. “Review the Cancer Genome Atlas (Tcga): An Immeasurable Source of Knowledge.” *Współczesna Onkologia* 1A: 68–77. <https://doi.org/10.5114/wo.2014.47136>.