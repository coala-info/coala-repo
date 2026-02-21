# glmGamPoi Quickstart

Constantin Ahlmann-Eltze

#### 2025-10-30

# Contents

* [1 Installation](#installation)
* [2 Example](#example)
* [3 Benchmark](#benchmark)
  + [3.1 Scalability](#scalability)
  + [3.2 Differential expression analysis](#differential-expression-analysis)
* [4 Session Info](#session-info)

> Fit Gamma-Poisson Generalized Linear Models Reliably.

The core design aims of `gmlGamPoi` are:

* Fit the Gamma-Poisson models on arbitrarily large or small datasets
* Be faster than alternative methods, such as `DESeq2` or `edgeR`
* Calculate exact or approximate results based on user preference
* Support in memory or on-disk data
* Follow established conventions around tools for RNA-seq analysis
* Present a simple user-interface
* Avoid unnecessary dependencies
* Make integration into other tools easy

# 1 Installation

You can install the release version of *[glmGamPoi](https://bioconductor.org/packages/3.22/glmGamPoi)* from BioConductor:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("glmGamPoi")
```

For the latest developments, see the *[GitHub](https://github.com/const-ae/glmGamPoi)* repo.

# 2 Example

Load the glmGamPoi package

```
library(glmGamPoi)
```

To fit a single Gamma-Poisson GLM do:

```
# overdispersion = 1/size
counts <- rnbinom(n = 10, mu = 5, size = 1/0.7)

# design = ~ 1 means that an intercept-only model is fit
fit <- glm_gp(counts, design = ~ 1)
fit
#> glmGamPoiFit object:
#> The data had 1 rows and 10 columns.
#> A model with 1 coefficient was fitted.

# Internally fit is just a list:
as.list(fit)[1:2]
#> $Beta
#>      Intercept
#> [1,]  1.504077
#>
#> $overdispersions
#> [1] 0.3792855
```

The `glm_gp()` function returns a list with the results of the fit. Most importantly, it contains the estimates for the coefficients β and the overdispersion.

Fitting repeated Gamma-Poisson GLMs for each gene of a single cell dataset is just as easy:

I will first load an example dataset using the `TENxPBMCData` package. The dataset has 33,000 genes and 4340 cells. It takes roughly 1.5 minutes to fit the Gamma-Poisson model on the full dataset. For demonstration purposes, I will subset the dataset to 300 genes, but keep the 4340 cells:

```
library(SummarizedExperiment)
library(DelayedMatrixStats)
```

```
# The full dataset with 33,000 genes and 4340 cells
# The first time this is run, it will download the data
pbmcs <- TENxPBMCData::TENxPBMCData("pbmc4k")
#> see ?TENxPBMCData and browseVignettes('TENxPBMCData') for documentation
#> loading from cache

# I want genes where at least some counts are non-zero
non_empty_rows <- which(rowSums2(assay(pbmcs)) > 0)
pbmcs_subset <- pbmcs[sample(non_empty_rows, 300), ]
pbmcs_subset
#> class: SingleCellExperiment
#> dim: 300 4340
#> metadata(0):
#> assays(1): counts
#> rownames(300): ENSG00000126457 ENSG00000109832 ... ENSG00000143819
#>   ENSG00000188243
#> rowData names(3): ENSEMBL_ID Symbol_TENx Symbol
#> colnames: NULL
#> colData names(11): Sample Barcode ... Individual Date_published
#> reducedDimNames(0):
#> mainExpName: NULL
#> altExpNames(0):
```

I call `glm_gp()` to fit one GLM model for each gene and force the calculation to happen in memory.

```
fit <- glm_gp(pbmcs_subset, on_disk = FALSE)
summary(fit)
#> glmGamPoiFit object:
#> The data had 300 rows and 4340 columns.
#> A model with 1 coefficient was fitted.
#> The design formula is: Y~1
#>
#> Beta:
#>             Min 1st Qu. Median 3rd Qu.   Max
#> Intercept -8.51   -6.57  -3.91   -2.59 0.903
#>
#> deviance:
#>  Min 1st Qu. Median 3rd Qu.  Max
#>   14    86.8    657    1686 5507
#>
#> overdispersion:
#>  Min  1st Qu. Median 3rd Qu.   Max
#>    0 1.65e-13  0.288    1.84 24687
#>
#> Shrunken quasi-likelihood overdispersion:
#>    Min 1st Qu. Median 3rd Qu.  Max
#>  0.707   0.991      1    1.04 7.45
#>
#> size_factors:
#>    Min 1st Qu. Median 3rd Qu.  Max
#>  0.117   0.738   1.01    1.32 14.5
#>
#> Mu:
#>       Min 1st Qu. Median 3rd Qu.  Max
#>  2.34e-05 0.00142 0.0185  0.0779 35.8
```

# 3 Benchmark

I compare my method (in-memory and on-disk) with *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)* and *[edgeR](https://bioconductor.org/packages/3.22/edgeR)*. Both are classical methods for analyzing RNA-Seq datasets and have been around for almost 10 years. Note that both tools can do a lot more than just fitting the Gamma-Poisson model, so this benchmark only serves to give a general impression of the performance.

```
# Explicitly realize count matrix in memory so that it is a fair comparison
pbmcs_subset <- as.matrix(assay(pbmcs_subset))
model_matrix <- matrix(1, nrow = ncol(pbmcs_subset))

bench::mark(
  glmGamPoi_in_memory = {
    glm_gp(pbmcs_subset, design = model_matrix, on_disk = FALSE)
  }, glmGamPoi_on_disk = {
    glm_gp(pbmcs_subset, design = model_matrix, on_disk = TRUE)
  }, DESeq2 = suppressMessages({
    dds <- DESeq2::DESeqDataSetFromMatrix(pbmcs_subset,
                        colData = data.frame(name = seq_len(4340)),
                        design = ~ 1)
    dds <- DESeq2::estimateSizeFactors(dds, "poscounts")
    dds <- DESeq2::estimateDispersions(dds, quiet = TRUE)
    dds <- DESeq2::nbinomWaldTest(dds, minmu = 1e-6)
  }), edgeR = {
    edgeR_data <- edgeR::DGEList(pbmcs_subset)
    edgeR_data <- edgeR::calcNormFactors(edgeR_data)
    edgeR_data <- edgeR::estimateDisp(edgeR_data, model_matrix)
    edgeR_fit <- edgeR::glmFit(edgeR_data, design = model_matrix)
  }, check = FALSE, min_iterations = 3
)
#> # A tibble: 4 × 6
#>   expression               min   median `itr/sec` mem_alloc `gc/sec`
#>   <bch:expr>          <bch:tm> <bch:tm>     <dbl> <bch:byt>    <dbl>
#> 1 glmGamPoi_in_memory    1.41s    1.41s    0.603         NA    1.61
#> 2 glmGamPoi_on_disk      4.68s     4.8s    0.201         NA    0.871
#> 3 DESeq2                28.34s    28.9s    0.0341        NA    0.284
#> 4 edgeR                  6.79s    6.84s    0.139         NA    0.923
```

On this dataset, `glmGamPoi` is more than 5 times faster than `edgeR` and more than 18 times faster than `DESeq2`. `glmGamPoi` does **not** use approximations to achieve this performance increase. The performance comes from an optimized algorithm for inferring the overdispersion for each gene. It is tuned for datasets typically encountered in single RNA-seq with many samples and many small counts, by avoiding duplicate calculations.

To demonstrate that the method does not sacrifice accuracy, I compare the parameters that each method estimates. The means and β coefficients are identical, but that the overdispersion estimates from `glmGamPoi` are more reliable:

```
# Results with my method
fit <- glm_gp(pbmcs_subset, design = model_matrix, on_disk = FALSE)

# DESeq2
dds <- DESeq2::DESeqDataSetFromMatrix(pbmcs_subset,
                        colData = data.frame(name = seq_len(4340)),
                        design = ~ 1)
sizeFactors(dds)  <- fit$size_factors
dds <- DESeq2::estimateDispersions(dds, quiet = TRUE)
dds <- DESeq2::nbinomWaldTest(dds, minmu = 1e-6)

#edgeR
edgeR_data <- edgeR::DGEList(pbmcs_subset, lib.size = fit$size_factors)
edgeR_data <- edgeR::estimateDisp(edgeR_data, model_matrix)
edgeR_fit <- edgeR::glmFit(edgeR_data, design = model_matrix)
```

![](data:image/png;base64...)

I am comparing the gene-wise estimates of the coefficients from all three methods. Points on the diagonal line are identical. The inferred Beta coefficients and gene means agree well between the methods, however the overdispersion differs quite a bit. `DESeq2` has problems estimating most of the overdispersions and sets them to `1e-8`. `edgeR` only approximates the overdispersions which explains the variation around the overdispersions calculated with `glmGamPoi`.

## 3.1 Scalability

The method scales linearly, with the number of rows and columns in the dataset. For example: fitting the full `pbmc4k` dataset with subsampling on a modern MacBook Pro in-memory takes ~1 minute and on-disk a little over 4 minutes. Fitting the `pbmc68k` (17x the size) takes ~73 minutes (17x the time) on-disk.

## 3.2 Differential expression analysis

`glmGamPoi` provides an interface to do quasi-likelihood ratio testing to identify differentially expressed genes. To demonstrate this feature, we will use the data from [Kang *et al.* (2018)](https://www.ncbi.nlm.nih.gov/pubmed/29227470) provided by the `MuscData` package. This is a single cell dataset of 8 Lupus patients for which 10x droplet-based scRNA-seq was performed before and after treatment with interferon beta. The `SingleCellExperiment` object conveniently provides the patient id (`ind`), treatment status (`stim`) and cell type (`cell`):

```
sce <- muscData::Kang18_8vs8()
#> see ?muscData and browseVignettes('muscData') for documentation
#> loading from cache
colData(sce)
#> DataFrame with 29065 rows and 5 columns
#>                        ind     stim   cluster            cell multiplets
#>                  <integer> <factor> <integer>        <factor>   <factor>
#> AAACATACAATGCC-1       107     ctrl         5 CD4 T cells        doublet
#> AAACATACATTTCC-1      1016     ctrl         9 CD14+ Monocytes    singlet
#> AAACATACCAGAAA-1      1256     ctrl         9 CD14+ Monocytes    singlet
#> AAACATACCAGCTA-1      1256     ctrl         9 CD14+ Monocytes    doublet
#> AAACATACCATGCA-1      1488     ctrl         3 CD4 T cells        singlet
#> ...                    ...      ...       ...             ...        ...
#> TTTGCATGCTAAGC-1       107     stim         6     CD4 T cells    singlet
#> TTTGCATGGGACGA-1      1488     stim         6     CD4 T cells    singlet
#> TTTGCATGGTGAGG-1      1488     stim         6     CD4 T cells    ambs
#> TTTGCATGGTTTGG-1      1244     stim         6     CD4 T cells    ambs
#> TTTGCATGTCTTAC-1      1016     stim         5     CD4 T cells    singlet
```

For demonstration purpose, I will work on a subset of the genes and cells:

```
set.seed(1)
# Take highly expressed genes and proper cells:
sce_subset <- sce[rowSums(counts(sce)) > 100,
                  sample(which(sce$multiplets == "singlet" &
                              ! is.na(sce$cell) &
                              sce$cell %in% c("CD4 T cells", "B cells", "NK cells")),
                         1000)]
# Convert counts to dense matrix
counts(sce_subset) <- as.matrix(counts(sce_subset))
# Remove empty levels because glm_gp() will complain otherwise
sce_subset$cell <- droplevels(sce_subset$cell)
```

We will identify which genes in CD4 positive T-cells are changed most by the treatment. We will fit a full model including the interaction term `stim:cell`. The interaction term will help us identify cell type specific responses to the treatment:

```
fit <- glm_gp(sce_subset, design = ~ cell + stim +  stim:cell - 1,
              reference_level = "NK cells")
summary(fit)
#> glmGamPoiFit object:
#> The data had 9727 rows and 1000 columns.
#> A model with 6 coefficient was fitted.
#> The design formula is: Y~cell + stim + stim:cell - 1
#>
#> Beta:
#>                    Min   1st Qu. Median 3rd Qu.  Max
#>    cellNK cells -1e+08 -1.00e+08  -3.74   -2.65 4.44
#>     cellB cells -1e+08 -1.00e+08  -3.88   -2.94 4.47
#> cellCD4 T cells -1e+08 -5.13e+00  -4.20   -3.05 4.50
#> ...
#>
#> deviance:
#>  Min 1st Qu. Median 3rd Qu.  Max
#>    0    61.9    114     251 5706
#>
#> overdispersion:
#>  Min 1st Qu. Median 3rd Qu.  Max
#>    0       0  0.528    4.01 2762
#>
#> Shrunken quasi-likelihood overdispersion:
#>    Min 1st Qu. Median 3rd Qu. Max
#>  0.188   0.994      1    1.07 363
#>
#> size_factors:
#>    Min 1st Qu. Median 3rd Qu.  Max
#>  0.489   0.815   1.01     1.2 5.97
#>
#> Mu:
#>  Min 1st Qu. Median 3rd Qu. Max
#>    0 0.00364  0.016  0.0498 537
```

To see how the coefficient of our model are called, we look at the `colnames(fit$Beta)`:

```
colnames(fit$Beta)
#> [1] "cellNK cells"             "cellB cells"
#> [3] "cellCD4 T cells"          "stimstim"
#> [5] "cellB cells:stimstim"     "cellCD4 T cells:stimstim"
```

In our example, we want to find the genes that change specifically in T cells. Finding cell type specific responses to a treatment is a big advantage of single cell data over bulk data. To get a proper estimate of the uncertainty (cells from the same donor are **not** independent replicates), we create a pseudobulk for each sample:

```
# The contrast argument specifies what we want to compare
# We test the expression difference of stimulated and control T-cells
#
# There is no sample label in the colData, so we create it on the fly
# from `stim` and `ind` columns in colData(fit$data).
de_res <- test_de(fit, contrast = `stimstim` + `cellCD4 T cells:stimstim`,
                  pseudobulk_by = paste0(stim, "-", ind))
#> Warning in test_pseudobulk_q(fit$data, design = full_design, aggregate_cells_by = pseudobulk_by, : 'test_pseudobulk_q' is deprecated.
#> Use 'Please use the 'pseudobulk' function instead. 'pseudobulk' produces a summarized 'SingleCellExperiment' object which is passed to `glm_gp()`.' instead.
#> See help("Deprecated")

# The large `lfc` values come from groups were nearly all counts are 0
# Setting them to Inf makes the plots look nicer
de_res$lfc <- ifelse(abs(de_res$lfc) > 20, sign(de_res$lfc) * Inf, de_res$lfc)

# Most different genes
head(de_res[order(de_res$pval), ])
#>       name         pval    adj_pval f_statistic df1      df2      lfc
#> 189   IFI6 1.413962e-07 0.001375361    41.76437   1 37.43569 6.118008
#> 6691 PSME2 2.950026e-07 0.001434745    38.77926   1 37.43569 3.519394
#> 5181 IFIT3 1.235315e-06 0.004005304    33.29872   1 37.43569 7.872549
#> 9689   MX1 8.503835e-06 0.020679201    26.56479   1 37.43569 5.037912
#> 7218 ISG20 1.346646e-05 0.022067412    25.06349   1 37.43569 2.370849
#> 5356  IRF7 1.361206e-05 0.022067412    25.02883   1 37.43569 4.670868
```

The test is successful and we identify interesting genes that are differentially expressed in interferon-stimulated T cells: *IFI6*, *IFIT3*, and *IRF7* literally stand for *Interferon Induced/Regulated Protein*.

To get a more complete overview of the results, we can make a volcano plot that compares the log2-fold change (LFC) vs the logarithmized p-values.

```
library(ggplot2)
#>
#> Attaching package: 'ggplot2'
#> The following object is masked from 'package:glmGamPoi':
#>
#>     vars
ggplot(de_res, aes(x = lfc, y = -log10(pval))) +
  geom_point(size = 0.6, aes(color = adj_pval < 0.1)) +
  ggtitle("Volcano Plot", "Genes that change most through interferon-beta treatment in T cells")
```

![](data:image/png;base64...)

Another important task in single cell data analysis is the identification of marker genes for cell clusters. For this we can also use our Gamma-Poisson fit.

Let’s assume we want to find genes that differ between T cells and the B cells. We can directly compare the corresponding coefficients and find genes that differ in the control condition:

```
marker_genes <- test_de(fit, `cellCD4 T cells` - `cellB cells`, sort_by = pval)
head(marker_genes)
#>                          name          pval      adj_pval f_statistic df1
#> 2873                     CD74 9.417666e-198 9.160564e-194   1411.8323   1
#> 3150  HLA-DRA_ENSG00000204287 7.401834e-180 3.599882e-176   1228.0721   1
#> 3152 HLA-DRB1_ENSG00000196126 1.924020e-121 6.238313e-118    717.8663   1
#> 9116    CD79A_ENSG00000105369  2.309642e-74  5.616472e-71    390.5782   1
#> 3166 HLA-DPA1_ENSG00000231389  3.228962e-70  6.281623e-67    364.8225   1
#> 3167 HLA-DPB1_ENSG00000223865  2.259376e-64  3.662825e-61    329.2859   1
#>           df2       lfc
#> 2873 1070.885 -5.052300
#> 3150 1070.885 -7.143245
#> 3152 1070.885 -6.993047
#> 9116 1070.885 -7.282279
#> 3166 1070.885 -5.004210
#> 3167 1070.885 -4.257008
```

If we want find genes that differ in the stimulated condition, we just include the additional coefficients in the contrast:

```
marker_genes2 <- test_de(fit, (`cellCD4 T cells` + `cellCD4 T cells:stimstim`) -
                               (`cellB cells` + `cellB cells:stimstim`),
                        sort_by = pval)

head(marker_genes2)
#>                          name          pval      adj_pval f_statistic df1
#> 2873                     CD74 8.766770e-187 8.527437e-183   1297.5239   1
#> 3150  HLA-DRA_ENSG00000204287 5.312753e-175 2.583858e-171   1180.6011   1
#> 3152 HLA-DRB1_ENSG00000196126 2.671970e-109 8.663416e-106    626.9904   1
#> 3166 HLA-DPA1_ENSG00000231389  2.975653e-85  7.236044e-82    460.4796   1
#> 3167 HLA-DPB1_ENSG00000223865  1.873116e-71  3.643959e-68    372.4564   1
#> 9116    CD79A_ENSG00000105369  1.328546e-58  2.153794e-55    295.0821   1
#>           df2        lfc
#> 2873 1070.885  -4.753566
#> 3150 1070.885  -6.635859
#> 3152 1070.885  -5.969909
#> 3166 1070.885  -5.207105
#> 3167 1070.885  -5.086061
#> 9116 1070.885 -10.000000
```

We identify many genes related to the human leukocyte antigen (HLA) system that is important for antigen presenting cells like B-cells, but are not expressed by T helper cells. The plot below shows the expression differences.

A note of caution: applying `test_de()` to single cell data without the pseudobulk gives overly optimistic p-values. This is due to the fact that cells from the same sample are not independent replicates! It can still be fine to use the method for identifying marker genes, as long as one is aware of the difficulties interpreting the results.

```
# Create a data.frame with the expression values, gene names, and cell types
tmp <- data.frame(gene = rep(marker_genes$name[1:6], times = ncol(sce_subset)),
                  expression = c(counts(sce_subset)[marker_genes$name[1:6], ]),
                  celltype = rep(sce_subset$cell, each = 6))

ggplot(tmp, aes(x = celltype, y = expression)) +
  geom_jitter(height = 0.1) +
  stat_summary(geom = "crossbar", fun = "mean", color = "red") +
  facet_wrap(~ gene, scales = "free_y") +
  ggtitle("Marker genes of B vs. T cells")
```

![](data:image/png;base64...)

# 4 Session Info

```
sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] ggplot2_4.0.0               muscData_1.23.0
#>  [3] ExperimentHub_3.0.0         AnnotationHub_4.0.0
#>  [5] BiocFileCache_3.0.0         dbplyr_2.5.1
#>  [7] TENxPBMCData_1.27.0         HDF5Array_1.38.0
#>  [9] h5mread_1.2.0               rhdf5_2.54.0
#> [11] SingleCellExperiment_1.32.0 DelayedMatrixStats_1.32.0
#> [13] DelayedArray_0.36.0         SparseArray_1.10.0
#> [15] S4Arrays_1.10.0             abind_1.4-8
#> [17] Matrix_1.7-4                SummarizedExperiment_1.40.0
#> [19] Biobase_2.70.0              GenomicRanges_1.62.0
#> [21] Seqinfo_1.0.0               IRanges_2.44.0
#> [23] S4Vectors_0.48.0            BiocGenerics_0.56.0
#> [25] generics_0.1.4              MatrixGenerics_1.22.0
#> [27] matrixStats_1.5.0           glmGamPoi_1.22.0
#> [29] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] DBI_1.2.3                httr2_1.2.1              rlang_1.1.6
#>  [4] magrittr_2.0.4           compiler_4.5.1           RSQLite_2.4.3
#>  [7] png_0.1-8                vctrs_0.6.5              pkgconfig_2.0.3
#> [10] crayon_1.5.3             fastmap_1.2.0            magick_2.9.0
#> [13] XVector_0.50.0           labeling_0.4.3           utf8_1.2.6
#> [16] rmarkdown_2.30           tinytex_0.57             purrr_1.1.0
#> [19] bit_4.6.0                xfun_0.53                cachem_1.1.0
#> [22] beachmat_2.26.0          jsonlite_2.0.0           blob_1.2.4
#> [25] rhdf5filters_1.22.0      Rhdf5lib_1.32.0          BiocParallel_1.44.0
#> [28] parallel_4.5.1           R6_2.6.1                 bslib_0.9.0
#> [31] RColorBrewer_1.1-3       limma_3.66.0             jquerylib_0.1.4
#> [34] Rcpp_1.1.0               bookdown_0.45            knitr_1.50
#> [37] splines_4.5.1            tidyselect_1.2.1         dichromat_2.0-0.1
#> [40] yaml_2.3.10              codetools_0.2-20         curl_7.0.0
#> [43] lattice_0.22-7           tibble_3.3.0             withr_3.0.2
#> [46] KEGGREST_1.50.0          S7_0.2.0                 evaluate_1.0.5
#> [49] bench_1.1.4              Biostrings_2.78.0        pillar_1.11.1
#> [52] BiocManager_1.30.26      filelock_1.0.3           BiocVersion_3.22.0
#> [55] sparseMatrixStats_1.22.0 scales_1.4.0             glue_1.8.0
#> [58] tools_4.5.1              beachmat.hdf5_1.8.0      locfit_1.5-9.12
#> [61] grid_4.5.1               AnnotationDbi_1.72.0     edgeR_4.8.0
#> [64] cli_3.6.5                rappdirs_0.3.3           dplyr_1.1.4
#> [67] gtable_0.3.6             DESeq2_1.50.0            sass_0.4.10
#> [70] digest_0.6.37            farver_2.1.2             memoise_2.0.1
#> [73] htmltools_0.5.8.1        lifecycle_1.0.4          httr_1.4.7
#> [76] statmod_1.5.1            bit64_4.6.0-1
```