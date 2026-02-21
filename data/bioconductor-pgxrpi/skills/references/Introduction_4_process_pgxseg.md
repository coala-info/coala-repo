# Introduction\_4\_process\_pgxseg

Hangjia Zhao

#### 2025-10-30

# Contents

* [1 Load library](#load-library)
  + [1.1 `pgxSegprocess` function](#pgxsegprocess-function)
* [2 Extract segment data](#extract-segment-data)
* [3 Extract metadata](#extract-metadata)
* [4 Visualize survival data in metadata](#visualize-survival-data-in-metadata)
* [5 Calculate CNV frequency](#calculate-cnv-frequency)
* [6 Extract all data](#extract-all-data)
* [7 Session Info](#session-info)

[Progenetix](https://progenetix.org/) is an open data resource that provides curated individual cancer copy number variation (CNV) profiles along with associated metadata sourced from published oncogenomic studies and various data repositories. Progenetix uses the “.pgxseg” data format to store variant data, which encompasses CNV (Copy Number Variation) and SNV (Single Nucleotide Variant), as well as the metadata of associated samples. This vignette describes how to work with local “.pgxseg” files using this package. For more details about the “.pgxseg” file format, please refer to the the [documentation](https://docs.progenetix.org/file-formats/#pgxseg-sample-variant-files).

# 1 Load library

```
library(pgxRpi)
library(GenomicRanges) # for pgxfreq object
```

## 1.1 `pgxSegprocess` function

This function extracts segment variants, CNV frequency, and metadata from local “pgxseg” files. Additionally, it supports survival data visualization if survival data is available within the file.

The parameters of this function used in this tutorial:

* `file`: A string specifying the path and name of the “pgxseg” file where the data is to be read.
* `group_id`: A string specifying which id is used for grouping in KM plot or CNV frequency calculation. Default is `"group_id"`.
* `show_KM_plot`: A logical value determining whether to return the Kaplan-Meier plot based on metadata. Default is `FALSE`.
* `return_metadata`: A logical value determining whether to return metadata. Default is `FALSE`.
* `return_seg`: A logical value determining whether to return segment data. Default is `FALSE`.
* `return_frequency`: A logical value determining whether to return CNV frequency data. The frequency calculation is based on segments in segment data and specified group id in metadata. Default is `FALSE`.
* `cnv_column_idx`: Index of the column specifying the CNV state used for calculating CNV frequency. The index must be at least 6, with the default set to `6`. The CNV states should either contain “DUP” for duplications and “DEL” for deletions, or level-specific CNV states represented using Experimental Factor Ontology (EFO) codes.
* `assembly`: A string specifying the genome assembly version to apply to CNV frequency calculation and plotting. Allowed options are “hg19” and “hg38”. Default is `"hg38"`.
* `...` Other parameters relevant to KM plot. These include `pval`, `pval.coord`, `pval.method`, `conf.int`, `linetype`, and `palette` (see ggsurvplot function from *survminer* package)

# 2 Extract segment data

```
# specify the location of the example file
file_name <- system.file("extdata", "example.pgxseg",package = 'pgxRpi')

# extract segment data
seg <- pgxSegprocess(file=file_name,return_seg = TRUE)
```

The segment data looks like this

```
head(seg)
#>   biosample_id reference_name    start       end  log2 variant_type
#> 1 GIST-gun-079             14 17200000 107043718 -1.00          DEL
#> 2 GIST-gun-080              3        0  90900000 -1.00          DEL
#> 3 GIST-gun-080              4 50000000 190214555 -1.00          DEL
#> 4 GIST-gun-080              5        0  48800000  1.32          DUP
#> 5 GIST-gun-080              5 48800000 181538259 -1.00          DEL
#> 6 GIST-gun-080              8        0  45200000 -1.00          DEL
#>   reference_bases alternate_bases variant_state_id variant_state_label
#> 1               .               .      EFO:0030067    copy number loss
#> 2               .               .      EFO:0030067    copy number loss
#> 3               .               .      EFO:0030067    copy number loss
#> 4               .               .      EFO:0030070    copy number gain
#> 5               .               .      EFO:0030067    copy number loss
#> 6               .               .      EFO:0030067    copy number loss
```

# 3 Extract metadata

```
meta <- pgxSegprocess(file=file_name,return_metadata = TRUE)
```

The metadata looks like this

```
head(meta)
#>   biosample_id histological_diagnosis_id histological_diagnosis_label
#> 1 GIST-gun-079               NCIT:C27243                  NCIT:C27243
#> 2 GIST-gun-080               NCIT:C27243                  NCIT:C27243
#> 3 GIST-gun-081               NCIT:C27243                  NCIT:C27243
#> 4 GIST-gun-082               NCIT:C27243                  NCIT:C27243
#> 5 GIST-gun-083               NCIT:C27243                  NCIT:C27243
#> 6 GIST-gun-084               NCIT:C27243                  NCIT:C27243
#>   icdo_morphology_id                     icdo_morphology_label        group_id
#> 1    pgx:icdom-89363 Gastrointestinal stromal tumor, malignant pgx:icdot-C16.9
#> 2    pgx:icdom-89363 Gastrointestinal stromal tumor, malignant pgx:icdot-C16.9
#> 3    pgx:icdom-89363 Gastrointestinal stromal tumor, malignant pgx:icdot-C16.9
#> 4    pgx:icdom-89363 Gastrointestinal stromal tumor, malignant pgx:icdot-C16.9
#> 5    pgx:icdom-89363 Gastrointestinal stromal tumor, malignant pgx:icdot-C16.9
#> 6    pgx:icdom-89363 Gastrointestinal stromal tumor, malignant pgx:icdot-C16.9
#>   icdo_topography_id group_label icdo_topography_label sampled_tissue_id
#> 1    pgx:icdot-C16.9     stomach               stomach    UBERON:0000945
#> 2    pgx:icdot-C16.9     stomach               stomach    UBERON:0000945
#> 3    pgx:icdot-C16.9     stomach               stomach    UBERON:0000945
#> 4    pgx:icdot-C16.9     stomach               stomach    UBERON:0000945
#> 5    pgx:icdot-C16.9     stomach               stomach    UBERON:0000945
#> 6    pgx:icdot-C16.9     stomach               stomach    UBERON:0000945
#>   sampled_tissue_label stage age_iso followup_state_id followup_state_label
#> 1       UBERON:0000945  High    P68Y       EFO:0030041                alive
#> 2       UBERON:0000945  High    P66Y       EFO:0030041                alive
#> 3       UBERON:0000945  High    P74Y       EFO:0030041                alive
#> 4       UBERON:0000945  High    P39Y       EFO:0030041                alive
#> 5       UBERON:0000945  High    P82Y       EFO:0030041                alive
#> 6       UBERON:0000945  High    P72Y       EFO:0030041                alive
#>   followup_time
#> 1          P11M
#> 2          P59M
#> 3          P13M
#> 4         P109M
#> 5          P47M
#> 6          P62M
```

# 4 Visualize survival data in metadata

The KM plot is generated using samples that have available follow-up state and follow-up time information. By default, the grouping is based on the ‘group\_id’ column in the metadata.

```
pgxSegprocess(file=file_name,show_KM_plot = TRUE)
```

![](data:image/png;base64...)

You can try different grouping by `group_id` parameter

```
pgxSegprocess(file=file_name,show_KM_plot = TRUE,group_id = 'histological_diagnosis_id')
```

![](data:image/png;base64...)

You can specify more parameters to modify this plot (see parameter `...` in documentation)

```
pgxSegprocess(file=file_name,show_KM_plot = TRUE,pval=TRUE,palette='npg')
```

![](data:image/png;base64...)

# 5 Calculate CNV frequency

The CNV frequency is calculated from segments of samples with the same group id. The group id is specified in `group_id` parameter. More details about CNV frequency see the vignette *Introduction\_3\_access\_cnv\_frequency*.

```
# Default is "group_id" in metadata
frequency <- pgxSegprocess(file=file_name,return_frequency = TRUE)
# Use different ids for grouping
frequency_2 <- pgxSegprocess(file=file_name,return_frequency = TRUE,
                             group_id ='icdo_morphology_id')
frequency
#> GRangesList object of length 4:
#> $`pgx:icdot-C16.9`
#> GRanges object with 3106 ranges and 2 metadata columns:
#>          seqnames            ranges strand | gain_frequency loss_frequency
#>             <Rle>         <IRanges>  <Rle> |      <numeric>      <numeric>
#>      [1]        1          0-400000      * |              0        28.5714
#>      [2]        1    400000-1400000      * |              0        28.5714
#>      [3]        1   1400000-2400000      * |              0        28.5714
#>      [4]        1   2400000-3400000      * |              0        28.5714
#>      [5]        1   3400000-4400000      * |              0        28.5714
#>      ...      ...               ...    ... .            ...            ...
#>   [3102]        Y 52400000-53400000      * |              0              0
#>   [3103]        Y 53400000-54400000      * |              0              0
#>   [3104]        Y 54400000-55400000      * |              0              0
#>   [3105]        Y 55400000-56400000      * |              0              0
#>   [3106]        Y 56400000-57227415      * |              0              0
#>   -------
#>   seqinfo: 24 sequences from an unspecified genome; no seqlengths
#>
#> ...
#> <3 more elements>
```

The returned object is same as the CNV frequency object with “pgxfreq” format returned by `pgxLoader` function. The CNV frequency is calculated from groups which exist in both metadata and segment data. It is noted that not all groups in metadata must exist in segment data (e.g. some samples don’t have CNV calls).

```
head(frequency[["pgx:icdot-C16.9"]])
#> GRanges object with 6 ranges and 2 metadata columns:
#>       seqnames          ranges strand | gain_frequency loss_frequency
#>          <Rle>       <IRanges>  <Rle> |      <numeric>      <numeric>
#>   [1]        1        0-400000      * |              0        28.5714
#>   [2]        1  400000-1400000      * |              0        28.5714
#>   [3]        1 1400000-2400000      * |              0        28.5714
#>   [4]        1 2400000-3400000      * |              0        28.5714
#>   [5]        1 3400000-4400000      * |              0        28.5714
#>   [6]        1 4400000-5400000      * |              0        28.5714
#>   -------
#>   seqinfo: 24 sequences from an unspecified genome; no seqlengths
```

The associated metadata in CNV frequency objects looks like this

```
mcols(frequency)
#> DataFrame with 4 rows and 3 columns
#>                        group_id            group_label sample_count
#>                     <character>            <character>    <integer>
#> pgx:icdot-C16.9 pgx:icdot-C16.9                stomach           28
#> pgx:icdot-C73.9 pgx:icdot-C73.9          thyroid gland            6
#> pgx:icdot-C50.9 pgx:icdot-C50.9                 breast            2
#> pgx:icdot-C49.9 pgx:icdot-C49.9 connective and soft ..            7
```

```
mcols(frequency_2)
#> DataFrame with 3 rows and 3 columns
#>                        group_id            group_label sample_count
#>                     <character>            <character>    <integer>
#> pgx:icdom-89363 pgx:icdom-89363 Gastrointestinal str..           35
#> pgx:icdom-83353 pgx:icdom-83353   Follicular carcinoma            6
#> pgx:icdom-80753 pgx:icdom-80753 Squamous cell carcin..            2
```

You can visualize the CNV frequency of the interesting group using `pgxFreqplot` function. For more details on this function, see the vignette *Introduction\_3\_access\_cnv\_frequency*.

```
pgxFreqplot(frequency, filters="pgx:icdot-C16.9")
```

![](data:image/png;base64...)

```
pgxFreqplot(frequency, filters="pgx:icdot-C16.9",chrom = c(1,8,14), layout = c(3,1))
```

![](data:image/png;base64...)

```
pgxFreqplot(frequency, filters=c("pgx:icdot-C16.9","pgx:icdot-C73.9"),circos = TRUE)
```

![](data:image/png;base64...)

# 6 Extract all data

If you want to extract different types of data, such as segment variants, metadata, CNV frequency and visualize the survival data simultaneously, you can set the corresponding parameters to TRUE. The returned data will be an object that includes all specified data. Note that in this case, the CNV frequency and KM plot will use the same `group_id`.

```
info <- pgxSegprocess(file=file_name,show_KM_plot = TRUE, return_seg = TRUE,
                      return_metadata = TRUE, return_frequency = TRUE)
```

![](data:image/png;base64...)

```
names(info)
#> [1] "seg"       "meta"      "frequency"
```

# 7 Session Info

```
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
#>  [1] SummarizedExperiment_1.40.0 Biobase_2.70.0
#>  [3] GenomicRanges_1.62.0        Seqinfo_1.0.0
#>  [5] IRanges_2.44.0              S4Vectors_0.48.0
#>  [7] BiocGenerics_0.56.0         generics_0.1.4
#>  [9] MatrixGenerics_1.22.0       matrixStats_1.5.0
#> [11] future_1.67.0               pgxRpi_1.6.0
#> [13] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] tidyselect_1.2.1    dplyr_1.1.4         farver_2.1.2
#>  [4] S7_0.2.0            fastmap_1.2.0       digest_0.6.37
#>  [7] timechange_0.3.0    lifecycle_1.0.4     survival_3.8-3
#> [10] magrittr_2.0.4      compiler_4.5.1      rlang_1.1.6
#> [13] sass_0.4.10         tools_4.5.1         yaml_2.3.10
#> [16] data.table_1.17.8   knitr_1.50          ggsignif_0.6.4
#> [19] S4Arrays_1.10.0     labeling_0.4.3      curl_7.0.0
#> [22] DelayedArray_0.36.0 RColorBrewer_1.1-3  abind_1.4-8
#> [25] withr_3.0.2         purrr_1.1.0         grid_4.5.1
#> [28] ggpubr_0.6.2        colorspace_2.1-2    xtable_1.8-4
#> [31] ggplot2_4.0.0       globals_0.18.0      scales_1.4.0
#> [34] dichromat_2.0-0.1   tinytex_0.57        cli_3.6.5
#> [37] rmarkdown_2.30      crayon_1.5.3        future.apply_1.20.0
#> [40] km.ci_0.5-6         httr_1.4.7          survminer_0.5.1
#> [43] cachem_1.1.0        splines_4.5.1       parallel_4.5.1
#> [46] XVector_0.50.0      BiocManager_1.30.26 survMisc_0.5.6
#> [49] vctrs_0.6.5         Matrix_1.7-4        jsonlite_2.0.0
#> [52] carData_3.0-5       bookdown_0.45       car_3.1-3
#> [55] rstatix_0.7.3       Formula_1.2-5       listenv_0.9.1
#> [58] magick_2.9.0        attempt_0.3.1       tidyr_1.3.1
#> [61] jquerylib_0.1.4     glue_1.8.0          parallelly_1.45.1
#> [64] codetools_0.2-20    shape_1.4.6.1       lubridate_1.9.4
#> [67] gtable_0.3.6        tibble_3.3.0        pillar_1.11.1
#> [70] htmltools_0.5.8.1   circlize_0.4.16     R6_2.6.1
#> [73] KMsurv_0.1-6        evaluate_1.0.5      lattice_0.22-7
#> [76] backports_1.5.0     ggsci_4.1.0         broom_1.0.10
#> [79] bslib_0.9.0         Rcpp_1.1.0          SparseArray_1.10.0
#> [82] gridExtra_2.3       xfun_0.53           GlobalOptions_0.1.2
#> [85] zoo_1.8-14          pkgconfig_2.0.3
```