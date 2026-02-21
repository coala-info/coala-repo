# scMitoMut demo: CRC dataset

Wenjie Sun

#### 30 October 2025

#### Package

scMitoMut 1.6.0

Install {scMitoMut} from Biocondcutor:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("scMitoMut")
```

or from github:

```
if (!requireNamespace("remotes", quietly = TRUE))
    install.packages("remotes")
remotes::install_github("wenjie1991/scMitoMut")
```

Load required packages.

```
library(scMitoMut)
library(data.table)
library(ggplot2)
library(rhdf5)
```

# 1 Overview

## 1.1 Key functions

Following are the key functions used in the scMitoMut package:

* `parse_mgatk()`: Parses the mgatk output and saves the result in an H5 file.
* `open_h5_file()`: Opens the H5 file and returns a “mtmutObj” object.
* `subset_cell()`: Subsets the cells in the mtmutObj object.
* `run_model_fit()`: Runs the model fitting and saves the results in the H5 file.
* `filter_loc()`: Filters the mutations based on criterias.
* `plot_heatmap()`: Plots a heatmap for p-values, allele frequencies, or binary mutation status.
* `export_df()`, `export_af()`, `export_pval()`, and `export_binary()`: Export the mutation data in `data.frame` format and the allele frequency, p-value, and binary mutation status in `data.matrix` format.

## 1.2 Key conceptions

* Somatic mutation: the mutation that occurs in cells after fertilizatoin.
* AF or VAF: allele frequency (AF) or variant allele frequency (VAF). It is the ratio of the number of reads supporting the variant allele to the total number of reads covering that locus.

**IMPORTANT**: In this vignette, I used the term “mutation” to refer to the lineage-related somatic mutation. For each mutation, I used the dominant allele as the reference allele. If the reference allele frequency is significantly (FDR < 0.05) lower, I will call the **locus** a mutation.

## 1.3 Background

Single-cell genomics technology serves as a powerful tool for gaining insights into cellular heterogeneity and diversity within complex tissues.

Mitochondrial DNA (mtDNA) is characterized by its small size and the presence of multiple copies within a cell. These attributes contribute to achieving robust mtDNA sequencing coverage and depth in single-cell sequencing data, thereby enhancing the detection of somatic mutations without dropout.

In this vignette, the scMitoMut package is used to identify and visualize lineage-related mtDNA single nucleic somatic mutations.

In the following analysis, scMitoMut was used to analyze the allele count data, which is the output of [mgatk](https://github.com/caleblareau/mgatk).
Only a few loci have been selected for demonstration purposes to reduce file size and run time.
The full dataset can be access from {Signac} [vignette](https://github.com/stuart-lab/signac/blob/1.9.0/vignettes/mito.Rmd).

# 2 Loading data

We load the allele count table with the `parse_table` function. The allele count table consists with following columns:

1. `loc`: the locus name
2. `cell_barcode`: the cell barcode in single-cell sequencing data
3. `fwd_depth`: the forward read count of the allele
4. `rev_depth`: the reverse read count of the allele
5. `alt`: the allele name
6. `coverage`: the read count covering the locus
7. `ref`: the reference allele name

Instead of using the table above as input, the output from `mgatk` can also be directly read using the `parse_mgatk` function.

Using the `parse_table` function or `parse_mgatk` function, the allele count data are read and saved into an `H5` file.
The `H5` file works as a database, which does not occupy memory, and data can be randomly accessed by querying.
It helps with better memory usage and faster loading.

The process may take some minutes. The return value is the `H5` file path.

```
## Load the allele count table
f <- system.file("extdata", "mini_dataset.tsv.gz", package = "scMitoMut")
f_h5_tmp <- tempfile(fileext = ".h5")
f_h5 <- parse_table(f, h5_file = f_h5_tmp)
```

```
f_h5
```

```
## [1] "/tmp/RtmpjuIgX3/file2f407f435d779e.h5"
```

After obtaining the `H5` file, the `open_h5_file` function can be utilized to load it, resulting in an object referred to as “mtmutObj”.

**Detail**: On this step, the `mtmutObj` has 6 slots
- `h5f` is the `H5` file handle
- `mut_table` is the allele count table
- `loc_list` is a list of available loci
- `loc_selected` is the selected loci
- `cell_list` is a list of available cell ids
- `cell_selected` is the selected cell ids

```
## Open the h5 file as a scMitoMut object
x <- open_h5_file(f_h5)
str(x)
```

```
## List of 9
##  $ file         : chr "/tmp/RtmpjuIgX3/file2f407f435d779e.h5"
##  $ h5f          :Formal class 'H5IdComponent' [package "rhdf5"] with 2 slots
##   .. ..@ ID    : chr "72057594037927938"
##   .. ..@ native: logi FALSE
##  $ mut_table    :Formal class 'H5IdComponent' [package "rhdf5"] with 2 slots
##   .. ..@ ID    : chr "144115188075855873"
##   .. ..@ native: logi FALSE
##  $ loc_list     : chr [1:16(1d)] "chrM.200" "chrM.204" "chrM.310" "chrM.824" ...
##  $ loc_selected : chr [1:16(1d)] "chrM.200" "chrM.204" "chrM.310" "chrM.824" ...
##  $ cell_list    : chr [1:1359(1d)] "AAACGAAAGAACCCGA-1" "AAACGAAAGTACCTCA-1" "AAACGAACAGAAAGAG-1" "AAACGAAGTGGTCGAA-1" ...
##  $ cell_selected: chr [1:1359(1d)] "AAACGAAAGAACCCGA-1" "AAACGAAAGTACCTCA-1" "AAACGAACAGAAAGAG-1" "AAACGAAGTGGTCGAA-1" ...
##  $ loc_pass     : NULL
##  $ loc_filter   :List of 5
##   ..$ min_cell           : num 1
##   ..$ model              : chr "bb"
##   ..$ p_threshold        : num 0.05
##   ..$ alt_count_threshold: num 0
##   ..$ p_adj_method       : chr "fdr"
##  - attr(*, "class")= chr "mtmutObj"
```

```
## Show what's in the h5 file
h5ls(x$h5f, recursive = FALSE)
```

```
##   group          name       otype dclass  dim
## 0     /     cell_list H5I_DATASET STRING 1359
## 1     / cell_selected H5I_DATASET STRING 1359
## 2     /      loc_list H5I_DATASET STRING   16
## 3     /  loc_selected H5I_DATASET STRING   16
## 4     /     mut_table   H5I_GROUP
```

# 3 Selecting cells

We are only interested in annotated good-quality cells.

So we will select the cells with annotation, which are good quality cells.

```
f <- system.file("extdata", "mini_dataset_cell_ann.csv", package = "scMitoMut")
cell_ann <- read.csv(f, row.names = 1)

## Subset the cells, the cell id can be found by colnames() for the Seurat object
x <- subset_cell(x, rownames(cell_ann))
```

After subsetting the cells, the `cell_selected` slot will be updated.
Only the selected cells will be used in the following p-value calculation.

```
head(x$cell_selected)
```

```
## [1] "AAACGAAAGAACCCGA-1" "AAACGAAAGTACCTCA-1" "AAACGAACAGAAAGAG-1"
## [4] "AAACGAAGTGGTCGAA-1" "AAACGAATCAATCGTG-1" "AAACGAATCCCACGGA-1"
```

Similarly, we can select loci by using the `subset_locus` function. It saves time when we only focus on a few loci.

# 4 Calculating mutation p-value

We built an null-hypothesis that there are not lineage-related mutation for specific locus in all cells.
Then we fit the allele frequency distribution with beta-binomial distribution and calculate the probability of observing allele frequency for a specific locus in a cell.
If the probability is small, we can reject the null hypothesis and conclude that there is a mutation for that locus in the cell.

To calculate the probability value (p-value), we run `run_calling` function, which has 2 arguments:
- `mtmutObj` is the `scMitoMut` object
- `mc.cores` is the number of CPU threads to be used

The process will take some time.
The output will be stored in the `pval` group of the `H5` file.
The result is stored in the hard drive, instead of in memory.
We don’t need to re-run the mutation calling when loading the `H5` file next time.

The mutation calling is based on beta-binomial distribution.
The mutation p-value is the probability that with the null hypothesis: there are no mutations for that locus in the cell.

**Detail**: For each locus, we calculate the p-value using the following steps.
1. Defining the wild-type allele as the allele with the highest median allele frequency among cells.
2. Fitting a 2 components binomial-mixture distribution as classifier to select the likely wild-type cells.
We define the likely wild-type cells if it has a probability >= 0.001 to be the wild type.
3. Using those likely wild-type cells, we fit the beta-binomial model.
4. At last, based on the model, we calculate the p-value of observing the allele frequency of the wild-type allele in specific cell.

```
## Run the model fitting
run_model_fit(x, mc.cores = 1)
```

```
## chrM.200
```

```
## chrM.204
```

```
## chrM.310
```

```
## chrM.824
```

```
## chrM.1000
```

```
## chrM.1001
```

```
## chrM.1227
```

```
## chrM.2285
```

```
## chrM.6081
```

```
## chrM.9429
```

```
## chrM.9728
```

```
## chrM.9804
```

```
## chrM.9840
```

```
## chrM.12889
```

```
## chrM.16093
```

```
## chrM.16147
```

```
##           used (Mb) gc trigger  (Mb) max used  (Mb)
## Ncells 1382446 73.9    2592352 138.5  2592352 138.5
## Vcells 2615292 20.0    8388608  64.0  6873854  52.5
```

```
## The p-value is kept in the pval group of H5 file
h5ls(x$h5f, recursive = FALSE)
```

```
##   group          name       otype   dclass  dim
## 0     /     cell_list H5I_DATASET   STRING 1359
## 1     / cell_selected H5I_DATASET   STRING 1359
## 2     /      loc_list H5I_DATASET   STRING   16
## 3     /  loc_selected H5I_DATASET   STRING   16
## 4     /  model_par_bb H5I_DATASET COMPOUND   16
## 5     /  model_par_bm H5I_DATASET COMPOUND   16
## 6     /     mut_table   H5I_GROUP
## 7     /          pval   H5I_GROUP
```

# 5 Filter mutations

Then we will filter the mutations by using the `mut_filter` function with the following criteria:
- The mutation has at least 5 cells mutant.
- The FDR (false discovery rate) adjusted p-value (mutation quality q-value) is less than 0.05.

The output is a `data.frame` with 2 columns
- `loc` is the locus
- `mut_cell_n` is the cell number

We can see that there are 12 loci after filtering.

**Detail**: The `mut_filter` function has 4 arguments:
- `mtmutObj` is the `mtmutObj` object
- `min_cell` is the minimum number of mutant cells
- `p_adj_method` is the method used to adjust the p-value.
- `p_threshold` is the adjusted p-value (q-value) threshold

```
## Filter mutation
x <- filter_loc(
  mtmutObj = x,
  min_cell = 2,
  model = "bb",
  p_threshold = 0.01,
  p_adj_method = "fdr"
)
x$loc_pass
```

```
##  [1] "chrM.200"   "chrM.204"   "chrM.310"   "chrM.824"   "chrM.1227"
##  [6] "chrM.2285"  "chrM.6081"  "chrM.9429"  "chrM.9728"  "chrM.9804"
## [11] "chrM.9840"  "chrM.12889" "chrM.16093" "chrM.16147"
```

# 6 Visualization

We will visualize the mutation by heatmap using the `plot_heatmap` function.
It can draw a heatmap of q-value, allele frequency, or binarized mutation status.
Its input is the `mtmutObj` object.
It will independently apply all the filters we used in the `mut_filter` function, and select the cells and loci that pass the filter criteria.
In all kinds of figures, the mutation status will be calculated, and the loci and cells are ordered by the mutation status.

**Detail**: The `plot_heatmap` arguments.
- `mtmutObj` is the `scMitoMut` object.
- `pos_list` is the list of loci.
- `cell_ann` is the cell annotation.
- `ann_colors` is the color of the cell annotation.
- `type` is the type of the heatmap which can be `p`, `af`, or `binary`.
- `p_adj_method` is the method used to adjust the p-value.
- `p_threshold` is the adjusted p-value threshold to determine if a cell has mutation when selecting the cells and loci.
- `min_cell_n` is the minimum number of cells that have mutation when selecting the cells and loci.
- `p_binary` is the adjusted p-value threshold to get the binary mutation status.
- `percent_interp` is the percentage overlap threshold between mutations, to determine if two mutations are correlated for interpolating the mutation status
- `n_interp` is the number of overlapped cells to determine if two mutations are correlated for interpolating.

The interpolation is based on the assumption that the mutation are unique, it is rare to have two mutation in the same population.
Therefore, when two mutations are correlated, one of them is likely a subclone of the other one.
The interpolation is utilized primarily for the purpose of ordering cells during visualization.

## 6.1 Binary heatmap

The binary heatmap displays the mutation status of each cell corresponding to each locus.
The color red suggests the presence of a mutant, whereas blue indicates its absence, and white denotes a missing value.

```
## Prepare the color for cell annotation
colors <- c(
  "Cancer Epi" = "#f28482",
  Blood = "#f6bd60"
)
ann_colors <- list("SeuratCellTypes" = colors)
```

```
## binary heatmap
plot_heatmap(x,
  cell_ann = cell_ann, ann_colors = ann_colors, type = "binary",
  percent_interp = 0.2, n_interp = 3
)
```

![](data:image/png;base64...)

Also we can turn off the interpolation by setting `percent_interp = 1`.

```
## binary heatmap
plot_heatmap(x,
  cell_ann = cell_ann, ann_colors = ann_colors, type = "binary",
  percent_interp = 1, n_interp = 3
)
```

![](data:image/png;base64...)

## 6.2 P value heatmap

The p-value heatmap illustrates the adjusted p-values for each cell corresponding to each locus.
The arrangement of the cells and loci is based on their binary mutation status.

```
## p value heatmap
plot_heatmap(x,
  cell_ann = cell_ann, ann_colors = ann_colors, type = "p",
  percent_interp = 0.2, n_interp = 3
)
```

![](data:image/png;base64...)

## 6.3 AF heatmap

The allele frequency heatmap illustrates the allele frequency of each cell at each locus.
The order of the cells and loci are determined by the mutation status too.

```
## allele frequency heatmap
plot_heatmap(x,
  cell_ann = cell_ann, ann_colors = ann_colors, type = "af",
  percent_interp = 0.2, n_interp = 3
)
```

![](data:image/png;base64...)

# 7 Exporting mutation data

We can export the mutation data by using the following functions:

* `export_df` export the mutation data as a `data.frame`
* `export_af` export the AF data as a `data.matrix` with loci as row names and cells as column names.
* `export_pval` export the p-value data as a `data.matrix` with loci as row names and cells as column names.
* `export_binary` export the mutation status data as a `data.matrix` with loci as row names and cells as column names.

Those functions have the same filtering options as the `plot_heatmap` function.

```
## Export the mutation data as data.frame
m_df <- export_df(x)
m_df[1:10, ]
```

```
##          loc       cell_barcode alt_depth fwd_depth rev_depth coverage pval
## 1  chrM.1227 AAACGAAAGAACCCGA-1        90        48        42       91    1
## 2  chrM.1227 AAACGAAAGTACCTCA-1        49        23        26       49    1
## 3  chrM.1227 AAACGAACAGAAAGAG-1        60        25        35       60    1
## 4  chrM.1227 AAACGAAGTGGTCGAA-1        52        25        27       52    1
## 5  chrM.1227 AAACTCGAGGTCGGTA-1        25        15        10       25    1
## 6  chrM.1227 AAACTCGCAGTGGTCC-1        36        21        15       37    1
## 7  chrM.1227 AAACTCGTCGGGCTCA-1        49        24        25       49    1
## 8  chrM.1227 AAACTGCGTGAGGGTT-1        54        27        27       54    1
## 9  chrM.1227 AAAGATGAGTCGCCTG-1        77        32        45       77    1
## 10 chrM.1227 AAAGATGCAGGAGCAT-1        27        15        12       27    1
##          af alt_count mut_status
## 1  0.989011         1      FALSE
## 2  1.000000         0      FALSE
## 3  1.000000         0      FALSE
## 4  1.000000         0      FALSE
## 5  1.000000         0      FALSE
## 6  0.972973         1      FALSE
## 7  1.000000         0      FALSE
## 8  1.000000         0      FALSE
## 9  1.000000         0      FALSE
## 10 1.000000         0      FALSE
```

```
## Export allele frequency data as data.matrix
export_af(x)[1:5, 1:5]
```

```
##            CATTCCGGTACCCACG-1 AAACGAAAGAACCCGA-1 CAAAGCTAGGTCGTTT-1
## chrM.16147          0.8974359          0.3606557          0.8695652
## chrM.310            0.2500000          0.5434783          0.4000000
## chrM.12889          1.0000000          0.9821429          1.0000000
## chrM.9728           1.0000000          1.0000000          1.0000000
## chrM.1227           1.0000000          0.9890110          1.0000000
##            GTCACGGAGCTGCCAC-1 GTCTACCTCTCTATTG-1
## chrM.16147          0.5000000          0.7954545
## chrM.310            0.5405405          0.5102041
## chrM.12889          1.0000000          1.0000000
## chrM.9728           1.0000000          1.0000000
## chrM.1227           1.0000000          1.0000000
```

```
## Export p-value data as data.matrix
export_pval(x)[1:5, 1:5]
```

```
##            CATTCCGGTACCCACG-1 AAACGAAAGAACCCGA-1 CAAAGCTAGGTCGTTT-1
## chrM.16147       0.0099457441       2.972594e-10        0.008205852
## chrM.310         0.0001327973       2.889483e-03        0.004930106
## chrM.12889       1.0000000000       3.559443e-01        1.000000000
## chrM.9728        1.0000000000       1.000000e+00        1.000000000
## chrM.1227        1.0000000000       1.000000e+00        1.000000000
##            GTCACGGAGCTGCCAC-1 GTCTACCTCTCTATTG-1
## chrM.16147       1.253323e-06       0.0006184542
## chrM.310         5.137155e-03       0.0008829350
## chrM.12889       1.000000e+00       1.0000000000
## chrM.9728        1.000000e+00       1.0000000000
## chrM.1227        1.000000e+00       1.0000000000
```

```
## Export binary mutation status data as data.matrix
export_binary(x)[1:5, 1:5]
```

```
##            CATTCCGGTACCCACG-1 AAACGAAAGAACCCGA-1 CAAAGCTAGGTCGTTT-1
## chrM.16147                  1                  1                  1
## chrM.310                    1                  1                  1
## chrM.12889                  0                  0                  0
## chrM.9728                   0                  0                  0
## chrM.1227                   0                  0                  0
##            GTCACGGAGCTGCCAC-1 GTCTACCTCTCTATTG-1
## chrM.16147                  1                  1
## chrM.310                    1                  1
## chrM.12889                  0                  0
## chrM.9728                   0                  0
## chrM.1227                   0                  0
```

# 8 Show the p value, af plot versus cell types

Lastly, we try to show the distribution of p value and allele frequency value versus cell types.

```
## The `m_df` is exported using the `export_df` function above.
m_dt <- data.table(m_df)
m_dt[, cell_type := cell_ann[as.character(m_dt$cell_barcode), "SeuratCellTypes"]]
m_dt_sub <- m_dt[loc == "chrM.1227"]
m_dt_sub[, sum((pval) < 0.01, na.rm = TRUE), by = cell_type]
```

```
##     cell_type    V1
##        <char> <int>
## 1: Cancer Epi    28
## 2:      Blood     0
```

```
m_dt_sub[, sum((1 - af) > 0.05, na.rm = TRUE), by = cell_type]
```

```
##     cell_type    V1
##        <char> <int>
## 1: Cancer Epi    42
## 2:      Blood     2
```

```
## The p value versus cell types
ggplot(m_dt_sub) +
  aes(x = cell_type, y = -log10(pval), color = cell_type) +
  geom_jitter() +
  scale_color_manual(values = colors) +
  theme_bw() +
  geom_hline(yintercept = -log10(0.01), linetype = "dashed") +
  ylab("-log10(FDR)")
```

```
## Warning in FUN(X[[i]], ...): NaNs produced
```

```
## Warning: Removed 4 rows containing missing values or values outside the scale range
## (`geom_point()`).
```

![](data:image/png;base64...)

```
## The allele frequency versus cell types
ggplot(m_dt_sub) +
  aes(x = cell_type, y = 1 - af, color = factor(cell_type)) +
  geom_jitter() +
  scale_color_manual(values = colors) +
  theme_bw() +
  geom_hline(yintercept = 0.05, linetype = "dashed") +
  ylab("1 - Dominant Allele Frequency")
```

![](data:image/png;base64...)

```
## The p value versus allele frequency
ggplot(m_dt_sub) +
    aes(x = -log10(pval), y = 1 - af, color = factor(cell_type)) +
    geom_point() +
    scale_color_manual(values = colors) +
    theme_bw() +
    geom_hline(yintercept = 0.05, linetype = "dashed") +
    geom_vline(xintercept = -log10(0.01), linetype = "dashed") +
    xlab("-log10(FDR)") +
    ylab("1 - Dominant Allele Frequency")
```

```
## Warning in FUN(X[[i]], ...): NaNs produced
## Warning in FUN(X[[i]], ...): Removed 4 rows containing missing values or values outside the scale range
## (`geom_point()`).
```

![](data:image/png;base64...)

# 9 Session Info

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] rhdf5_2.54.0      ggplot2_4.0.0     data.table_1.17.8 scMitoMut_1.6.0
## [5] knitr_1.50        BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] sass_0.4.10         generics_0.1.4      stringi_1.8.7
##  [4] hms_1.1.4           digest_0.6.37       magrittr_2.0.4
##  [7] evaluate_1.0.5      grid_4.5.1          RColorBrewer_1.1-3
## [10] bookdown_0.45       fastmap_1.2.0       R.oo_1.27.1
## [13] plyr_1.8.9          jsonlite_2.0.0      R.utils_2.13.0
## [16] tinytex_0.57        BiocManager_1.30.26 scales_1.4.0
## [19] jquerylib_0.1.4     cli_3.6.5           rlang_1.1.6
## [22] R.methodsS3_1.8.2   withr_3.0.2         cachem_1.1.0
## [25] yaml_2.3.10         tools_4.5.1         parallel_4.5.1
## [28] tzdb_0.5.0          dplyr_1.1.4         Rhdf5lib_1.32.0
## [31] vctrs_0.6.5         R6_2.6.1            lifecycle_1.0.4
## [34] magick_2.9.0        stringr_1.5.2       pkgconfig_2.0.3
## [37] pillar_1.11.1       bslib_0.9.0         gtable_0.3.6
## [40] glue_1.8.0          Rcpp_1.1.0          xfun_0.53
## [43] tibble_3.3.0        tidyselect_1.2.1    dichromat_2.0-0.1
## [46] rhdf5filters_1.22.0 farver_2.1.2        htmltools_0.5.8.1
## [49] labeling_0.4.3      rmarkdown_2.30      readr_2.1.5
## [52] pheatmap_1.0.13     compiler_4.5.1      S7_0.2.0
```