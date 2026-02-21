# An introduction to scMerge2

Yingxin Lin1

1School of Mathematics and Statistics, The University of Sydney, Australia

#### 30 October 2025

#### Package

BiocStyle 2.38.0

# 1 Introduction

The scMerge algorithm allows batch effect removal and normalisation for single cell RNA-Seq data. It comprises of three key components including:

1. The identification of stably expressed genes (SEGs) as “negative controls” for estimating unwanted factors;
2. The construction of pseudo-replicates to estimate the effects of unwanted factors; and
3. The adjustment of the datasets with unwanted variation using a fastRUVIII model.

The purpose of this vignette is to illustrate some uses of `scMerge` and explain its key components.

# 2 Loading Packages and Data

We will load the `scMerge` package. We designed our package to be consistent with the popular BioConductor’s single cell analysis framework, namely the `SingleCellExperiment` and `scater` package.

```
suppressPackageStartupMessages({
    library(SingleCellExperiment)
    library(scMerge)
    library(scater)
})
```

We provided an illustrative mouse embryonic stem cell (mESC) data in our package, as well as a set of pre-computed stably expressed gene (SEG) list to be used as negative control genes.

The full curated, unnormalised mESC data can be found [here](http://www.maths.usyd.edu.au/u/yingxinl/wwwnb/scMergeData/sce_mESC.rda). The `scMerge` package comes with a sub-sampled, two-batches version of this data (named “batch2” and “batch3” to be consistent with the full data) .

```
## Subsetted mouse ESC data
data("example_sce", package = "scMerge")
data("segList_ensemblGeneID", package = "scMerge")
```

In this mESC data, we pooled data from 2 different batches from three different cell types. Using a PCA plot, we can see that despite strong separation of cell types, there is also a strong separation due to batch effects. This information is stored in the `colData` of `example_sce`.

```
example_sce = runPCA(example_sce, exprs_values = "logcounts")

scater::plotPCA(example_sce,
                colour_by = "cellTypes",
                shape_by = "batch")
```

![](data:image/png;base64...)

# 3 scMerge2

## 3.1 Unsupervised `scMerge2`

In unsupervised `scMerge2`, we will perform graph clustering on shared nearest neighbour graphs within each batch to obtain pseudo-replicates. This requires the users to supply a `k_celltype` vector with the number of neighbour when constructed the nearest neighbour graph in each of the batches. By default, this number is 10.

```
scMerge2_res <- scMerge2(exprsMat = logcounts(example_sce),
                         batch = example_sce$batch,
                         ctl = segList_ensemblGeneID$mouse$mouse_scSEG,
                         verbose = FALSE)
#> Warning in (function (A, nv = 5, nu = nv, maxit = 1000, work = nv + 7, reorth =
#> TRUE, : You're computing too large a percentage of total singular values, use a
#> standard svd instead.
#> Warning in (function (A, nv = 5, nu = nv, maxit = 1000, work = nv + 7, reorth =
#> TRUE, : You're computing too large a percentage of total singular values, use a
#> standard svd instead.

assay(example_sce, "scMerge2") <- scMerge2_res$newY

set.seed(2022)
example_sce <- scater::runPCA(example_sce, exprs_values = 'scMerge2')
scater::plotPCA(example_sce, colour_by = 'cellTypes', shape = 'batch')
```

![](data:image/png;base64...)

## 3.2 Semi-supervised `scMerge2`

When cell type information are known (e.g. results from cell type classification using reference), scMerge2 can use this information to construct pseudo-replicates and identify mutual nearest groups with `cellTypes` input.

```
scMerge2_res <- scMerge2(exprsMat = logcounts(example_sce),
                         batch = example_sce$batch,
                         cellTypes = example_sce$cellTypes,
                         ctl = segList_ensemblGeneID$mouse$mouse_scSEG,
                         verbose = FALSE)

assay(example_sce, "scMerge2") <- scMerge2_res$newY

example_sce = scater::runPCA(example_sce, exprs_values = 'scMerge2')
scater::plotPCA(example_sce, colour_by = 'cellTypes', shape = 'batch')
```

![](data:image/png;base64...)

# 4 More details of scMerge2

## 4.1 Number of pseudobulk

The number of pseudobulk constructed within each cell grouping is set via `k_pseudoBulk`. By default, this number is set as 30. A larger number will create more pseudo-bulk data in model estimation, with longer time in estimation.

```
scMerge2_res <- scMerge2(exprsMat = logcounts(example_sce),
                         batch = example_sce$batch,
                         ctl = segList_ensemblGeneID$mouse$mouse_scSEG,
                         k_pseudoBulk = 50,
                         verbose = FALSE)
#> Warning in (function (A, nv = 5, nu = nv, maxit = 1000, work = nv + 7, reorth =
#> TRUE, : You're computing too large a percentage of total singular values, use a
#> standard svd instead.
#> Warning in (function (A, nv = 5, nu = nv, maxit = 1000, work = nv + 7, reorth =
#> TRUE, : You're computing too large a percentage of total singular values, use a
#> standard svd instead.

assay(example_sce, "scMerge2") <- scMerge2_res$newY

set.seed(2022)
example_sce <- scater::runPCA(example_sce, exprs_values = 'scMerge2')
scater::plotPCA(example_sce, colour_by = 'cellTypes', shape = 'batch')
```

![](data:image/png;base64...)

## 4.2 Return matrix by batch

When working with large data, we can get the adjusted matrix for a smaller subset of cells each time. This can be achieved by setting `return_matrix` to `FALSE` in `scMerge2()` function, which the function then will not return the adjusted whole matrix but will output the estimated `fullalpha`.
Then to get the adjusted matrix using the estimated `fullalpha`, we first need to performed cosine normalisation on the logcounts matrix and then calculate the row-wise (gene-wise) mean of the cosine normalised matrix (This is because by default, `scMerge2()` perform cosine normalisation on the log-normalised matrix before `RUVIII` step). Then we can use `getAdjustedMat()` to adjust the matrix of a subset of cells each time.

```
scMerge2_res <- scMerge2(exprsMat = logcounts(example_sce),
                         batch = example_sce$batch,
                         ctl = segList_ensemblGeneID$mouse$mouse_scSEG,
                         verbose = FALSE,
                         return_matrix = FALSE)
#> Warning in (function (A, nv = 5, nu = nv, maxit = 1000, work = nv + 7, reorth =
#> TRUE, : You're computing too large a percentage of total singular values, use a
#> standard svd instead.
#> Warning in (function (A, nv = 5, nu = nv, maxit = 1000, work = nv + 7, reorth =
#> TRUE, : You're computing too large a percentage of total singular values, use a
#> standard svd instead.

cosineNorm_mat <- batchelor::cosineNorm(logcounts(example_sce))
adjusted_means <- DelayedMatrixStats::rowMeans2(cosineNorm_mat)

newY <- list()
for (i in levels(example_sce$batch)) {
    newY[[i]] <- getAdjustedMat(cosineNorm_mat[, example_sce$batch == i],
                                scMerge2_res$fullalpha,
                                ctl = segList_ensemblGeneID$mouse$mouse_scSEG,
                                ruvK = 20,
                                adjusted_means = adjusted_means)
}
newY <- do.call(cbind, newY)

assay(example_sce, "scMerge2") <- newY[, colnames(example_sce)]

set.seed(2022)
example_sce <- scater::runPCA(example_sce, exprs_values = 'scMerge2')
scater::plotPCA(example_sce, colour_by = 'cellTypes', shape = 'batch')
```

![](data:image/png;base64...)

Note that we can also adjust only a subset of genes by input a gene list in `return_subset_genes` in
both `getAdjustedMat()` and `scMerge2()`.

## 4.3 Hierarchical scMerge2

scMerge2 provides a hierarchical merging strategy for data integration that requires multiple level adjustment through function `scMerge2h()`. For example, for the dataset with multiple samples, we may want to remove the sample effect first within the dataset before integrate it with other datasets. Below, we will illustrate how we can build a hierarchical merging order as input for `scMerge2h()`.

For illustration purpose, here I first create a fake sample information for the sample data. Now, each batch has two samples.

```
# Create a fake sample information
example_sce$sample <- rep(c(1:4), each = 50)
table(example_sce$sample, example_sce$batch)
#>
#>     batch2 batch3
#>   1     50      0
#>   2     50      0
#>   3      0     50
#>   4      0     50
```

To perform `scMerge2h`, we need to create

1. a hierarchical index list that indicates the indices of the cells that are going into merging;
2. a batch information list that indicates the batch information of each merging.

### 4.3.1 Scenario 1

We will first illustrate that a two-level merging case, where the first level refers to the sample effect removal within each batch, and the second level refers to the merging of two batches.

First, we will construct the hierarchical index list (`h_idx_list`). The hierarchical index list is a list that indicates for each level, which indices of the cells are going into merging. The number of the element of the list should be the same with the number of level of merging. For each element, it should contain a list of vectors of indices of each merging.

```
# Construct a hierarchical index list
h_idx_list <- list(level1 = split(seq_len(ncol(example_sce)), example_sce$batch),
                   level2 = list(seq_len(ncol(example_sce))))
```

On level 1, we will perform two merging, one for each batch. Therefore, we have a list of two vectors of indices. Each indicates the indices of the cells of the batches.

```
h_idx_list$level1
#> $batch2
#>   [1]   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15  16  17  18
#>  [19]  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34  35  36
#>  [37]  37  38  39  40  41  42  43  44  45  46  47  48  49  50  51  52  53  54
#>  [55]  55  56  57  58  59  60  61  62  63  64  65  66  67  68  69  70  71  72
#>  [73]  73  74  75  76  77  78  79  80  81  82  83  84  85  86  87  88  89  90
#>  [91]  91  92  93  94  95  96  97  98  99 100
#>
#> $batch3
#>   [1] 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118
#>  [19] 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136
#>  [37] 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154
#>  [55] 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172
#>  [73] 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190
#>  [91] 191 192 193 194 195 196 197 198 199 200
```

On level 2, we will perform one merging to merge two batches. Therefore, we have a list of one vector of indices, indicates all the indices of the cells of the full data.

```
h_idx_list$level2
#> [[1]]
#>   [1]   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15  16  17  18
#>  [19]  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34  35  36
#>  [37]  37  38  39  40  41  42  43  44  45  46  47  48  49  50  51  52  53  54
#>  [55]  55  56  57  58  59  60  61  62  63  64  65  66  67  68  69  70  71  72
#>  [73]  73  74  75  76  77  78  79  80  81  82  83  84  85  86  87  88  89  90
#>  [91]  91  92  93  94  95  96  97  98  99 100 101 102 103 104 105 106 107 108
#> [109] 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126
#> [127] 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144
#> [145] 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162
#> [163] 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180
#> [181] 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198
#> [199] 199 200
```

Next, we need to create the batch information list (`batch_list`), which has the same structure with the `h_idx_list`, but indicates the batch label of the `h_idx_list`.

```
# Construct a batch information list
batch_list <- list(level1 = split(example_sce$sample, example_sce$batch),
                   level2 = list(example_sce$batch))
```

We can see `batch_list` indicates the batch label for level of the merging.

```
batch_list$level1
#> $batch2
#>   [1] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
#>  [38] 1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2
#>  [75] 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2
#>
#> $batch3
#>   [1] 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3
#>  [38] 3 3 3 3 3 3 3 3 3 3 3 3 3 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4
#>  [75] 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4
```

Now, we can input the `batch_list` and `h_idx_list` in `scMerge2h` to merge the data hierarchically.
We also need to input a `ruvK_list`, a vector of number of unwanted variation (k in RUV model) for each level of the merging. We suggest a lower `ruvK` in the first level. Here we set `ruvK_list = c(2, 5)` which indicates we will set RUV’s k equal to 2 in the first level and 5 in the second level.

```
scMerge2_res <- scMerge2h(exprsMat = logcounts(example_sce),
                          batch_list = batch_list,
                          h_idx_list = h_idx_list,
                          ctl = segList_ensemblGeneID$mouse$mouse_scSEG,
                          ruvK_list = c(2, 5),
                          verbose = FALSE)
```

The output of `scMerge2h` is a list of matrices indicates the adjusted matrix from each level.

```
length(scMerge2_res)
#> [1] 2
lapply(scMerge2_res, dim)
#> [[1]]
#> [1] 1047  200
#>
#> [[2]]
#> [1] 1047  200
```

Here we will use the adjusted matrix from the last level as the final adjusted matrix.

```
assay(example_sce, "scMerge2") <- scMerge2_res[[length(h_idx_list)]]
set.seed(2022)
example_sce <- scater::runPCA(example_sce, exprs_values = 'scMerge2')
scater::plotPCA(example_sce, colour_by = 'cellTypes', shape = 'batch')
```

![](data:image/png;base64...)

### 4.3.2 Scenario 2

scMerge2h can handle a flexible merging strategy input. For example, on level 1 above, we can only merge data for one batch. As an example, we can start from modify the batch index list and hierarchical index list to remove the list of batch 2 on level 1.

```
h_idx_list2 <- h_idx_list
batch_list2 <- batch_list
h_idx_list2$level1$batch2 <- NULL
batch_list2$level1$batch2 <- NULL
print(h_idx_list2)
#> $level1
#> $level1$batch3
#>   [1] 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118
#>  [19] 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136
#>  [37] 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154
#>  [55] 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172
#>  [73] 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190
#>  [91] 191 192 193 194 195 196 197 198 199 200
#>
#>
#> $level2
#> $level2[[1]]
#>   [1]   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15  16  17  18
#>  [19]  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34  35  36
#>  [37]  37  38  39  40  41  42  43  44  45  46  47  48  49  50  51  52  53  54
#>  [55]  55  56  57  58  59  60  61  62  63  64  65  66  67  68  69  70  71  72
#>  [73]  73  74  75  76  77  78  79  80  81  82  83  84  85  86  87  88  89  90
#>  [91]  91  92  93  94  95  96  97  98  99 100 101 102 103 104 105 106 107 108
#> [109] 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126
#> [127] 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144
#> [145] 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162
#> [163] 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180
#> [181] 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198
#> [199] 199 200
print(batch_list2)
#> $level1
#> $level1$batch3
#>   [1] 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3
#>  [38] 3 3 3 3 3 3 3 3 3 3 3 3 3 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4
#>  [75] 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4
#>
#>
#> $level2
#> $level2[[1]]
#>   [1] batch2 batch2 batch2 batch2 batch2 batch2 batch2 batch2 batch2 batch2
#>  [11] batch2 batch2 batch2 batch2 batch2 batch2 batch2 batch2 batch2 batch2
#>  [21] batch2 batch2 batch2 batch2 batch2 batch2 batch2 batch2 batch2 batch2
#>  [31] batch2 batch2 batch2 batch2 batch2 batch2 batch2 batch2 batch2 batch2
#>  [41] batch2 batch2 batch2 batch2 batch2 batch2 batch2 batch2 batch2 batch2
#>  [51] batch2 batch2 batch2 batch2 batch2 batch2 batch2 batch2 batch2 batch2
#>  [61] batch2 batch2 batch2 batch2 batch2 batch2 batch2 batch2 batch2 batch2
#>  [71] batch2 batch2 batch2 batch2 batch2 batch2 batch2 batch2 batch2 batch2
#>  [81] batch2 batch2 batch2 batch2 batch2 batch2 batch2 batch2 batch2 batch2
#>  [91] batch2 batch2 batch2 batch2 batch2 batch2 batch2 batch2 batch2 batch2
#> [101] batch3 batch3 batch3 batch3 batch3 batch3 batch3 batch3 batch3 batch3
#> [111] batch3 batch3 batch3 batch3 batch3 batch3 batch3 batch3 batch3 batch3
#> [121] batch3 batch3 batch3 batch3 batch3 batch3 batch3 batch3 batch3 batch3
#> [131] batch3 batch3 batch3 batch3 batch3 batch3 batch3 batch3 batch3 batch3
#> [141] batch3 batch3 batch3 batch3 batch3 batch3 batch3 batch3 batch3 batch3
#> [151] batch3 batch3 batch3 batch3 batch3 batch3 batch3 batch3 batch3 batch3
#> [161] batch3 batch3 batch3 batch3 batch3 batch3 batch3 batch3 batch3 batch3
#> [171] batch3 batch3 batch3 batch3 batch3 batch3 batch3 batch3 batch3 batch3
#> [181] batch3 batch3 batch3 batch3 batch3 batch3 batch3 batch3 batch3 batch3
#> [191] batch3 batch3 batch3 batch3 batch3 batch3 batch3 batch3 batch3 batch3
#> Levels: batch2 batch3
```

```
scMerge2_res <- scMerge2h(exprsMat = logcounts(example_sce),
                          batch_list = batch_list2,
                          h_idx_list = h_idx_list2,
                          ctl = segList_ensemblGeneID$mouse$mouse_scSEG,
                          ruvK_list = c(2, 5),
                          verbose = FALSE)
```

```
assay(example_sce, "scMerge2") <- scMerge2_res[[length(h_idx_list)]]
set.seed(2022)
example_sce <- scater::runPCA(example_sce, exprs_values = 'scMerge2')
scater::plotPCA(example_sce, colour_by = 'cellTypes', shape = 'batch')
```

![](data:image/png;base64...)

# 5 Session Info

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
#>  [1] BiocSingular_1.26.0         scater_1.38.0
#>  [3] ggplot2_4.0.0               scuttle_1.20.0
#>  [5] scMerge_1.26.0              SingleCellExperiment_1.32.0
#>  [7] SummarizedExperiment_1.40.0 Biobase_2.70.0
#>  [9] GenomicRanges_1.62.0        Seqinfo_1.0.0
#> [11] IRanges_2.44.0              S4Vectors_0.48.0
#> [13] BiocGenerics_0.56.0         generics_0.1.4
#> [15] MatrixGenerics_1.22.0       matrixStats_1.5.0
#> [17] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] RColorBrewer_1.1-3        rstudioapi_0.17.1
#>   [3] jsonlite_2.0.0            magrittr_2.0.4
#>   [5] magick_2.9.0              ggbeeswarm_0.7.2
#>   [7] farver_2.1.2              rmarkdown_2.30
#>   [9] vctrs_0.6.5               DelayedMatrixStats_1.32.0
#>  [11] base64enc_0.1-3           tinytex_0.57
#>  [13] htmltools_0.5.8.1         S4Arrays_1.10.0
#>  [15] curl_7.0.0                BiocNeighbors_2.4.0
#>  [17] SparseArray_1.10.0        Formula_1.2-5
#>  [19] sass_0.4.10               StanHeaders_2.32.10
#>  [21] reldist_1.7-2             KernSmooth_2.23-26
#>  [23] bslib_0.9.0               htmlwidgets_1.6.4
#>  [25] cachem_1.1.0              ResidualMatrix_1.20.0
#>  [27] sfsmisc_1.1-22            igraph_2.2.1
#>  [29] lifecycle_1.0.4           startupmsg_1.0.0
#>  [31] pkgconfig_2.0.3           M3Drop_1.36.0
#>  [33] rsvd_1.0.5                Matrix_1.7-4
#>  [35] R6_2.6.1                  fastmap_1.2.0
#>  [37] digest_0.6.37             numDeriv_2016.8-1.1
#>  [39] colorspace_2.1-2          dqrng_0.4.1
#>  [41] irlba_2.3.5.1             Hmisc_5.2-4
#>  [43] beachmat_2.26.0           labeling_0.4.3
#>  [45] abind_1.4-8               mgcv_1.9-3
#>  [47] compiler_4.5.1            withr_3.0.2
#>  [49] htmlTable_2.4.3           S7_0.2.0
#>  [51] backports_1.5.0           inline_0.3.21
#>  [53] BiocParallel_1.44.0       viridis_0.6.5
#>  [55] QuickJSR_1.8.1            pkgbuild_1.4.8
#>  [57] gplots_3.2.0              MASS_7.3-65
#>  [59] proxyC_0.5.2              DelayedArray_0.36.0
#>  [61] bluster_1.20.0            gtools_3.9.5
#>  [63] caTools_1.18.3            loo_2.8.0
#>  [65] distr_2.9.7               tools_4.5.1
#>  [67] vipor_0.4.7               foreign_0.8-90
#>  [69] beeswarm_0.4.0            nnet_7.3-20
#>  [71] glue_1.8.0                batchelor_1.26.0
#>  [73] nlme_3.1-168              cvTools_0.3.3
#>  [75] grid_4.5.1                checkmate_2.3.3
#>  [77] cluster_2.1.8.1           gtable_0.3.6
#>  [79] data.table_1.17.8         metapod_1.18.0
#>  [81] ScaledMatrix_1.18.0       XVector_0.50.0
#>  [83] ggrepel_0.9.6             pillar_1.11.1
#>  [85] stringr_1.5.2             limma_3.66.0
#>  [87] robustbase_0.99-6         splines_4.5.1
#>  [89] dplyr_1.1.4               lattice_0.22-7
#>  [91] densEstBayes_1.0-2.2      ruv_0.9.7.1
#>  [93] tidyselect_1.2.1          locfit_1.5-9.12
#>  [95] knitr_1.50                gridExtra_2.3
#>  [97] V8_8.0.1                  bookdown_0.45
#>  [99] edgeR_4.8.0               xfun_0.53
#> [101] statmod_1.5.1             DEoptimR_1.1-4
#> [103] rstan_2.32.7              stringi_1.8.7
#> [105] yaml_2.3.10               evaluate_1.0.5
#> [107] codetools_0.2-20          bbmle_1.0.25.1
#> [109] tibble_3.3.0              BiocManager_1.30.26
#> [111] cli_3.6.5                 RcppParallel_5.1.11-1
#> [113] rpart_4.1.24              jquerylib_0.1.4
#> [115] dichromat_2.0-0.1         Rcpp_1.1.0
#> [117] bdsmatrix_1.3-7           parallel_4.5.1
#> [119] rstantools_2.5.0          scran_1.38.0
#> [121] sparseMatrixStats_1.22.0  bitops_1.0-9
#> [123] viridisLite_0.4.2         mvtnorm_1.3-3
#> [125] scales_1.4.0              rlang_1.1.6
#> [127] cowplot_1.2.0
```