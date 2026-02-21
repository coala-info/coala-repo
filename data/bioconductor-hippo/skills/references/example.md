# Feature Selection and Hierarchical Clustering of cells in Zhengmix4eq

## Installing the Package

HIPPO is under review for Bioconductor and CRAN submission. You can download the developer version as below. Please allow up to 5 minutes to completely compile the vignette.

```
devtools::install_github("tk382/HIPPO", build_vignettes = TRUE)
```

## Read the data

The data set is available in the following [link](http://imlspenticton.uzh.ch/robinson_lab/DuoClustering2018/DuoClustering2018.tar.gz), where the detailed explanation is available [here](https://github.com/markrobinsonuzh/scRNAseq_clustering_comparison). Note that the file is very large (3.3GB). We use a subset of Zheng 2017 data set saved as a toydata within this package. Also, we load a reference data that matches ENSG ID to HGNC gene names.

```
data(toydata)
data(ensg_hgnc)
```

Alternatively, you can start from a matrix object.

```
# X = readRDS("zhengmix4eq_counts.rds")
# toydata = SingleCellExperiment(assays = list(counts = X))
```

## Diagnostic Plot

This plot shows the zero inflation compared to the expected Poisson line. If most genes don’t align with the black line, it shows that there is cell heterogeneity driving the zero inflation.

```
hippo_diagnostic_plot(toydata,
                      show_outliers = TRUE,
                      zvalue_thresh = 2)
```

![](data:image/png;base64...)

## Feature Selection and Hierarchical Clustering

HIPPO assumes that the count matrix is placed in toydata@assays@data$counts. Some objects that we found online have the count matrix in toydata@assays$data$counts. In this case, HIPPO will throw an error because it cannot found a count matrix. In this case, you have to create another SingleCellExperiment object to assign the count matrix in the correct slot.

Next, you can run hippo function to do the pre-processing that simutlaneously conducts feature selection and hierarchcial clustering. There are three arguments that help you decide the stopping criterion of clustering procedure.

K is the maximum number of clusters that you want. HIPPO will return the clustering results for all k = 2, 3, …, K, so you can overestimate the number of potential clusters. The default is 10, but users are highly recommended to adjust this.

z\_threshold is the feature selection criterion. For each round of hierarchical clustering, hippo will find outlier genes where the z-value of significance is greater than the threshold. For example, if you would like to select genes with p-values less than 0.05, z\_threshold would be 1.96. The default threshold is 2, but users can use their discretion to change this value.

outlier\_proportion is the number of outlier genes to allow. The default is 0.01 (1%) which means the clustering procedure will automatically stop if there are less than 1% of genes remain as important features. With the example data set, the default choice has empirically worked well.

```
set.seed(20200321)
toydata = hippo(toydata, K = 10,
                z_threshold = 2, outlier_proportion = 0.00001)
```

## Dimension Reduction for Each Round of HIPPO

We offer two dimension reduction methods: umap and tsne. And we offer two separate visualization functions.

```
toydata = hippo_dimension_reduction(toydata, method="umap")
hippo_umap_plot(toydata)
```

![](data:image/png;base64...)

```
toydata = hippo_dimension_reduction(toydata, method="tsne")
hippo_tsne_plot(toydata)
```

![](data:image/png;base64...)

## Visualize the selected features at each round

This function shows how the zero-inflation decreases as HIPPO proceeds in the clustering. This function has arguments called switch\_to\_hgnc and ref. These aim to provide the users an option to change the gene names from ENSG IDs to HGNC symbols for ease of understanding. Many SingleCellExperiment objects have such data embedded in rowData(toydata). Users can create a data frame with ensg and hgnc columns for the genes, and HIPPO will automatically switch the row names of the count matrix from ENSG IDs to HGNC symbols. The default is set to FALSE, assuming that the row names are already HGNC symbols.

```
data(ensg_hgnc)
zero_proportion_plot(toydata,
                     switch_to_hgnc = TRUE,
                     ref = ensg_hgnc)
```

![](data:image/png;base64...)

```
hippo_feature_heatmap(toydata, k = 3,
                      switch_to_hgnc = TRUE,
                      ref = ensg_hgnc,
                      top.n = 20)
```

![](data:image/png;base64...)

## Differential Expression Example

We also offer a differential expression analysis tool.

This function also has an option to switch the gene names to HGNC symbols. top.n argument lets users choose how many top genes to show in the box plot. The default is 5.

The labels of boxplots are aligned with the t-SNE or UMAP plots above. When K is equal to 2, the color codes match with the cell groups as separated in the dimension reduction plot.

```
toydata = hippo_diffexp(toydata,
                  top.n = 5,
                  switch_to_hgnc = TRUE,
                  ref = ensg_hgnc)
```

![](data:image/png;base64...)

Each round of differential expression test results are also saved in the list of data frames.

```
head(get_hippo_diffexp(toydata, 1))
```

```
              genes  meandiff        sd         z
21  ENSG00000087086 16.087318 0.9591965 16.771661
100 ENSG00000101439  8.384615 0.5678778 14.764823
32  ENSG00000011600  5.038462 0.4402124 11.445523
97  ENSG00000196126  4.308732 0.5546155  7.768864
52  ENSG00000204482  2.253638 0.2991452  7.533593
87  ENSG00000158869  2.022869 0.2839227  7.124717
```

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
[1] stats4    stats     graphics  grDevices utils     datasets  methods
[8] base

other attached packages:
 [1] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
 [3] Biobase_2.70.0              GenomicRanges_1.62.0
 [5] Seqinfo_1.0.0               IRanges_2.44.0
 [7] S4Vectors_0.48.0            BiocGenerics_0.56.0
 [9] generics_0.1.4              MatrixGenerics_1.22.0
[11] matrixStats_1.5.0           HIPPO_1.22.0

loaded via a namespace (and not attached):
 [1] gtable_0.3.6        xfun_0.53           bslib_0.9.0
 [4] ggplot2_4.0.0       ggrepel_0.9.6       lattice_0.22-7
 [7] vctrs_0.6.5         tools_4.5.1         tibble_3.3.0
[10] pkgconfig_2.0.3     Matrix_1.7-4        RColorBrewer_1.1-3
[13] S7_0.2.0            lifecycle_1.0.4     compiler_4.5.1
[16] farver_2.1.2        stringr_1.5.2       htmltools_0.5.8.1
[19] sass_0.4.10         yaml_2.3.10         pillar_1.11.1
[22] jquerylib_0.1.4     openssl_2.3.4       DelayedArray_0.36.0
[25] cachem_1.1.0        abind_1.4-8         RSpectra_0.16-2
[28] tidyselect_1.2.1    digest_0.6.37       Rtsne_0.17
[31] stringi_1.8.7       dplyr_1.1.4         reshape2_1.4.4
[34] labeling_0.4.3      fastmap_1.2.0       grid_4.5.1
[37] cli_3.6.5           SparseArray_1.10.0  magrittr_2.0.4
[40] S4Arrays_1.10.0     dichromat_2.0-0.1   withr_3.0.2
[43] scales_1.4.0        rmarkdown_2.30      XVector_0.50.0
[46] umap_0.2.10.0       reticulate_1.44.0   gridExtra_2.3
[49] askpass_1.2.1       png_0.1-8           evaluate_1.0.5
[52] knitr_1.50          irlba_2.3.5.1       rlang_1.1.6
[55] Rcpp_1.1.0          glue_1.8.0          jsonlite_2.0.0
[58] R6_2.6.1            plyr_1.8.9
```