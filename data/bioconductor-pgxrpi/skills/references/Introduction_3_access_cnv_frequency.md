# Introduction\_3\_access\_cnv\_frequency

Hangjia Zhao

#### 2025-10-30

# Contents

* [1 Load library](#load-library)
  + [1.1 `pgxLoader` function](#pgxloader-function)
* [2 Retrieve CNV frequency](#retrieve-cnv-frequency)
  + [2.1 The first output format (`output` = “pgxfreq”)](#the-first-output-format-output-pgxfreq)
  + [2.2 The second output format (`output` = “pgxmatrix”)](#the-second-output-format-output-pgxmatrix)
* [3 Calculate CNV frequency](#calculate-cnv-frequency)
  + [3.1 `segtoFreq` function](#segtofreq-function)
* [4 Visualize CNV frequency](#visualize-cnv-frequency)
  + [4.1 `pgxFreqplot` function](#pgxfreqplot-function)
  + [4.2 CNV frequency plot by genome](#cnv-frequency-plot-by-genome)
    - [4.2.1 Input is `pgxfreq` object](#input-is-pgxfreq-object)
    - [4.2.2 Input is `pgxmatrix` object](#input-is-pgxmatrix-object)
  + [4.3 CNV frequency plot by chromosomes](#cnv-frequency-plot-by-chromosomes)
  + [4.4 CNV frequency circos plot](#cnv-frequency-circos-plot)
* [5 Session Info](#session-info)

[Progenetix](https://progenetix.org/) is an open data resource that provides curated individual cancer copy number variation (CNV) profiles along with associated metadata sourced from published oncogenomic studies and various data repositories. This vignette offers a comprehensive guide on accessing and visualizing CNV frequency data within the Progenetix database. CNV frequency is pre-calculated based on CNV segment data in Progenetix and reflects the CNV pattern in a cohort. It is defined as the percentage of samples showing a CNV for a genomic region (1MB-sized genomic bins in this case) over the total number of samples in a cohort specified by filters.

If your focus lies in cancer cell lines, you can access data from [*cancercelllines.org*](https://cancercelllines.org/) by setting the `domain` parameter to `"cancercelllines.org"` in `pgxLoader` function. This data repository originates from CNV profiling data of cell lines initially collected as part of Progenetix and currently includes additional types of genomic mutations.

# 1 Load library

```
library(pgxRpi)
library(SummarizedExperiment) # for pgxmatrix data
library(GenomicRanges) # for pgxfreq data
```

## 1.1 `pgxLoader` function

This function loads various data from `Progenetix` database via the Beacon v2 API with some extensions (BeaconPlus).

The parameters of this function used in this tutorial:

* `type`: A string specifying output data type. Only `"cnv_frequency"` is used in this tutorial.
* `output`: A string specifying output file format. When the parameter `type` is `"cnv_frequency"`, available options are `"pgxfreq"` (default) or `"pgxmatrix"`.
* `filters`: Identifiers used in public repositories, bio-ontology terms, or custom terms such as `c("NCIT:C7376", "pgx:icdom-85003")`. When multiple filters are used, they are combined using OR logic when the parameter `type` is `"cnv_frequency"`. For more information about filters, see the [documentation](https://docs.progenetix.org/common/beacon-api/#filters-filtering-terms).
* `domain`: A string specifying the domain of the query data resource. For CNV frequency data, the value should be either `"progenetix.org"` or `"cancercelllines.org"`.

# 2 Retrieve CNV frequency

## 2.1 The first output format (`output` = “pgxfreq”)

```
freq_pgxfreq <- pgxLoader(type="cnv_frequency", output ="pgxfreq",
                         filters=c("NCIT:C3058","NCIT:C3493"))

freq_pgxfreq
#> GRangesList object of length 2:
#> $`NCIT:C3058`
#> GRanges object with 3106 ranges and 4 metadata columns:
#>          seqnames            ranges strand | low_gain_frequency
#>             <Rle>         <IRanges>  <Rle> |          <numeric>
#>      [1]        1          0-400000      * |              4.259
#>      [2]        1    400000-1400000      * |              8.131
#>      [3]        1   1400000-2400000      * |              9.399
#>      [4]        1   2400000-3400000      * |             10.130
#>      [5]        1   3400000-4400000      * |             10.639
#>      ...      ...               ...    ... .                ...
#>   [3102]        Y 52400000-53400000      * |              0.262
#>   [3103]        Y 53400000-54400000      * |              0.262
#>   [3104]        Y 54400000-55400000      * |              0.262
#>   [3105]        Y 55400000-56400000      * |              0.262
#>   [3106]        Y 56400000-57227415      * |              0.262
#>          high_gain_frequency low_loss_frequency high_loss_frequency
#>                    <numeric>          <numeric>           <numeric>
#>      [1]               0.358              5.278               0.510
#>      [2]               0.799              8.269               0.469
#>      [3]               0.648              9.427               0.620
#>      [4]               0.841             13.603               0.979
#>      [5]               0.662             15.601               1.171
#>      ...                 ...                ...                 ...
#>   [3102]                   0              0.276                   0
#>   [3103]                   0              0.276                   0
#>   [3104]                   0              0.276                   0
#>   [3105]                   0              0.276                   0
#>   [3106]                   0              0.276                   0
#>   -------
#>   seqinfo: 24 sequences from an unspecified genome; no seqlengths
#>
#> $`NCIT:C3493`
#> GRanges object with 3106 ranges and 4 metadata columns:
#>          seqnames            ranges strand | low_gain_frequency
#>             <Rle>         <IRanges>  <Rle> |          <numeric>
#>      [1]        1          0-400000      * |              2.089
#>      [2]        1    400000-1400000      * |              5.289
#>      [3]        1   1400000-2400000      * |              4.995
#>      [4]        1   2400000-3400000      * |              8.554
#>      [5]        1   3400000-4400000      * |              6.823
#>      ...      ...               ...    ... .                ...
#>   [3102]        Y 52400000-53400000      * |                  0
#>   [3103]        Y 53400000-54400000      * |                  0
#>   [3104]        Y 54400000-55400000      * |                  0
#>   [3105]        Y 55400000-56400000      * |                  0
#>   [3106]        Y 56400000-57227415      * |                  0
#>          high_gain_frequency low_loss_frequency high_loss_frequency
#>                    <numeric>          <numeric>           <numeric>
#>      [1]               0.555              3.918               0.326
#>      [2]               0.555             12.765               0.163
#>      [3]               0.326             13.092               0.196
#>      [4]               1.469             24.584               0.588
#>      [5]               0.555             24.649               0.457
#>      ...                 ...                ...                 ...
#>   [3102]                   0              0.065                   0
#>   [3103]                   0              0.065                   0
#>   [3104]                   0              0.065                   0
#>   [3105]                   0              0.065                   0
#>   [3106]                   0              0.065                   0
#>   -------
#>   seqinfo: 24 sequences from an unspecified genome; no seqlengths
```

The returned data is stored in [*GRangesList*](https://bioconductor.org/packages/release/bioc/html/GenomicRanges.html) container which consists of multiple *GRanges* objects. Each *GRanges* object stores CNV frequency from samples pecified by a particular filter.

Within each GRanges object, annotation columns provide the CNV frequencies for each genomic region, expressed as percentage values across samples (%). These percentages represent level-specific gains and losses that overlap the corresponding genomic intervals. For more details on CNV levels, refer to the [ontology tree](http://www.ebi.ac.uk/efo/EFO_0030066).

These genomic intervals are derived from the partitioning of the entire genome (GRCh38). Most of these bins have a size of 1MB, except for a few bins located near the telomeres. In total, there are 3106 intervals encompassing the genome.

To access the CNV frequency data from specific filters, you could access like this

```
freq_pgxfreq[["NCIT:C3058"]]
#> GRanges object with 3106 ranges and 4 metadata columns:
#>          seqnames            ranges strand | low_gain_frequency
#>             <Rle>         <IRanges>  <Rle> |          <numeric>
#>      [1]        1          0-400000      * |              4.259
#>      [2]        1    400000-1400000      * |              8.131
#>      [3]        1   1400000-2400000      * |              9.399
#>      [4]        1   2400000-3400000      * |             10.130
#>      [5]        1   3400000-4400000      * |             10.639
#>      ...      ...               ...    ... .                ...
#>   [3102]        Y 52400000-53400000      * |              0.262
#>   [3103]        Y 53400000-54400000      * |              0.262
#>   [3104]        Y 54400000-55400000      * |              0.262
#>   [3105]        Y 55400000-56400000      * |              0.262
#>   [3106]        Y 56400000-57227415      * |              0.262
#>          high_gain_frequency low_loss_frequency high_loss_frequency
#>                    <numeric>          <numeric>           <numeric>
#>      [1]               0.358              5.278               0.510
#>      [2]               0.799              8.269               0.469
#>      [3]               0.648              9.427               0.620
#>      [4]               0.841             13.603               0.979
#>      [5]               0.662             15.601               1.171
#>      ...                 ...                ...                 ...
#>   [3102]                   0              0.276                   0
#>   [3103]                   0              0.276                   0
#>   [3104]                   0              0.276                   0
#>   [3105]                   0              0.276                   0
#>   [3106]                   0              0.276                   0
#>   -------
#>   seqinfo: 24 sequences from an unspecified genome; no seqlengths
```

To get metadata such as count of samples used to calculate frequency, use `mcols` function from *GenomicRanges* package:

```
mcols(freq_pgxfreq)
#> DataFrame with 2 rows and 3 columns
#>                 filter                  label sample_count
#>            <character>            <character>    <integer>
#> NCIT:C3058  NCIT:C3058           Glioblastoma         7256
#> NCIT:C3493  NCIT:C3493 Lung Squamous Cell C..         3063
```

## 2.2 The second output format (`output` = “pgxmatrix”)

Choose 8 NCIt codes of interests that correspond to different tumor types

```
code <-c("C3059","C3716","C4917","C3512","C3493","C3771","C4017","C4001")
# add prefix for query
code <- paste0("NCIT:",code)
```

load data with the specified codes

```
freq_pgxmatrix <- pgxLoader(type="cnv_frequency",output ="pgxmatrix",filters=code)
freq_pgxmatrix
#> class: RangedSummarizedExperiment
#> dim: 6212 8
#> metadata(0):
#> assays(2): lowlevel_cnv_frequency highlevel_cnv_frequency
#> rownames(6212): 1 2 ... 6211 6212
#> rowData names(1): type
#> colnames(8): NCIT:C3059 NCIT:C3493 ... NCIT:C4017 NCIT:C4917
#> colData names(3): filter label sample_count
```

The returned data is stored in [*RangedSummarizedExperiment*](https://bioconductor.org/packages/release/bioc/html/SummarizedExperiment.html) object, which is a matrix-like container where rows represent ranges of interest (as a GRanges object) and columns represent filters.

To get metadata such as count of samples used to calculate frequency, use `colData` function from *SummarizedExperiment* package:

```
colData(freq_pgxmatrix)
#> DataFrame with 8 rows and 3 columns
#>                 filter                  label sample_count
#>            <character>            <character>    <integer>
#> NCIT:C3059  NCIT:C3059                 Glioma        14277
#> NCIT:C3493  NCIT:C3493 Lung Squamous Cell C..         3063
#> NCIT:C3512  NCIT:C3512    Lung Adenocarcinoma        14623
#> NCIT:C3716  NCIT:C3716 Primitive Neuroectod..         3040
#> NCIT:C3771  NCIT:C3771 Breast Lobular Carci..         1732
#> NCIT:C4001  NCIT:C4001 Breast Inflammatory ..           28
#> NCIT:C4017  NCIT:C4017 Breast Ductal Carcin..        13851
#> NCIT:C4917  NCIT:C4917 Lung Small Cell Carc..         1299
```

To access the CNV frequency matrix, use `assay` accesssor from *SummarizedExperiment* package

```
head(assay(freq_pgxmatrix,"lowlevel_cnv_frequency"))
#>   NCIT:C3059 NCIT:C3493 NCIT:C3512 NCIT:C3716 NCIT:C3771 NCIT:C4001 NCIT:C4017
#> 1      3.894      2.089      1.963      3.125      0.924      3.571      5.718
#> 2      6.738      5.289      5.997      6.480      1.559      7.143      7.826
#> 3      7.845      4.995      6.093      7.632      1.905      7.143      6.599
#> 4      8.517      8.554     11.154      7.730      3.176      3.571      8.822
#> 5      8.699      6.823      9.882      7.961      2.598      3.571      6.837
#> 6      6.850      6.725      9.868      7.204      1.905      3.571      5.400
#>   NCIT:C4917
#> 1      4.157
#> 2     14.396
#> 3     14.011
#> 4     21.401
#> 5     19.400
#> 6     20.246
```

The matrix has 6212 rows (genomic regions) and 8 columns (filters). The rows comprised 3106 intervals with “gain status” plus 3106 intervals with “loss status”.

The value is the percentage of samples from the corresponding filter having one or more CNV events in the specific genomic intervals. For example, if the value in the second row and first column is 6.839, it means that 6.839% samples from the corresponding filter NCIT:C3059 having one or more low-level duplication events in the genomic interval in chromosome 1: 400000-1400000.

You could get the interval information by `rowRanges` function from *SummarizedExperiment* package.

```
rowRanges(freq_pgxmatrix)
#> GRanges object with 6212 ranges and 1 metadata column:
#>        seqnames            ranges strand |        type
#>           <Rle>         <IRanges>  <Rle> | <character>
#>      1        1          0-400000      * |        gain
#>      2        1    400000-1400000      * |        gain
#>      3        1   1400000-2400000      * |        gain
#>      4        1   2400000-3400000      * |        gain
#>      5        1   3400000-4400000      * |        gain
#>    ...      ...               ...    ... .         ...
#>   6208        Y 52400000-53400000      * |        loss
#>   6209        Y 53400000-54400000      * |        loss
#>   6210        Y 54400000-55400000      * |        loss
#>   6211        Y 55400000-56400000      * |        loss
#>   6212        Y 56400000-57227415      * |        loss
#>   -------
#>   seqinfo: 24 sequences from an unspecified genome; no seqlengths
```

Note: it is different from CNV fraction matrix introduced in *Introduction\_2\_query\_variants*. Value in this matrix is **percentage (%) of samples** having one or more CNVs overlapped with the binned interval while the value in CNV fraction matrix is **fraction in individual samples** to indicate how much the binned interval overlaps with one or more CNVs in one sample.

# 3 Calculate CNV frequency

## 3.1 `segtoFreq` function

This function computes the binned CNV frequency from segment data.

The parameters of this function:

* `data`: Segment data containing CNV states. The first four columns should represent sample ID, chromosome, start position, and end position, respectively. The fifth column can contain the number of markers or other relevant information. The column representing CNV states (with a column index of 6 or higher) should either contain “DUP” for duplications and “DEL” for deletions, or level-specific CNV states such as “EFO:0030072”, “EFO:0030071”, “EFO:0020073”, and “EFO:0030068”, which correspond to high-level duplication, low-level duplication, high-level deletion, and low-level deletion, respectively.
* `cnv_column_idx`: Index of the column specifying CNV state. Default is 6, following the “pgxseg” format used in Progenetix. If the input segment data uses the general `.seg` file format, it might need to be set differently.
* `cohort_name`: A string specifying the cohort name. Default is “unspecified cohort”.
* `assembly`: A string specifying the genome assembly version for CNV frequency calculation. Allowed options are “hg19” or “hg38”. Default is “hg38”.
* `bin_size`: Size of genomic bins used to split the genome, in base pairs (bp). Default is 1,000,000.
* `overlap`: Numeric value defining the amount of overlap between bins and segments considered as bin-specific CNV, in base pairs (bp). Default is 1,000.
* `soft_expansion`: Fraction of `bin_size` to determine merge criteria. During the generation of genomic bins, division starts at the centromere and expands towards the telomeres on both sides. If the size of the last bin is smaller than `soft_expansion` \* bin\_size, it will be merged with the previous bin. Default is 0.1.

Suppose you have segment data from several biosamples:

```
# access variant data
variants <- pgxLoader(type="g_variants",biosample_id = c("pgxbs-kftvhmz9", "pgxbs-kftvhnqz","pgxbs-kftvhupd"),output="pgxseg")
# only keep segment cnv data
segdata <- variants[variants$variant_type %in% c("DUP","DEL"),]
head(segdata)
#>     biosample_id reference_name    start      end    log2 variant_type
#> 1 pgxbs-kftvhmz9              1  3477686  9548738 -0.8340          DEL
#> 2 pgxbs-kftvhmz9              1 12188446 12774437 -0.8604          DEL
#> 3 pgxbs-kftvhmz9              1 24280069 25153245  0.4973          DUP
#> 4 pgxbs-kftvhmz9              1 26555954 28546015 -0.7740          DEL
#> 5 pgxbs-kftvhmz9              1 32300691 32332533 -0.7769          DEL
#> 6 pgxbs-kftvhmz9              1 32397196 32595742 -0.6995          DEL
#>   reference_sequence sequence variant_state_id variant_state_label
#> 1                  .        .      EFO:0030068      low-level loss
#> 2                  .        .      EFO:0030068      low-level loss
#> 3                  .        .      EFO:0030071      low-level gain
#> 4                  .        .      EFO:0030068      low-level loss
#> 5                  .        .      EFO:0030068      low-level loss
#> 6                  .        .      EFO:0030068      low-level loss
```

You can then calculate the CNV frequency for this cohort based on the specified CNV calls. The output will be stored in the “pgxfreq” format.

In the following example, the CNV frequency is calculated based on “DUP” and “DEL” calls:

```
segfreq1 <- segtoFreq(segdata,cnv_column_idx = 6, cohort_name="c1")
segfreq1
#> GRangesList object of length 1:
#> $c1
#> GRanges object with 3106 ranges and 2 metadata columns:
#>          seqnames            ranges strand | gain_frequency loss_frequency
#>             <Rle>         <IRanges>  <Rle> |      <numeric>      <numeric>
#>      [1]        1          0-400000      * |              0         0.0000
#>      [2]        1    400000-1400000      * |              0         0.0000
#>      [3]        1   1400000-2400000      * |              0         0.0000
#>      [4]        1   2400000-3400000      * |              0         0.0000
#>      [5]        1   3400000-4400000      * |              0        33.3333
#>      ...      ...               ...    ... .            ...            ...
#>   [3102]        Y 52400000-53400000      * |              0              0
#>   [3103]        Y 53400000-54400000      * |              0              0
#>   [3104]        Y 54400000-55400000      * |              0              0
#>   [3105]        Y 55400000-56400000      * |              0              0
#>   [3106]        Y 56400000-57227415      * |              0              0
#>   -------
#>   seqinfo: 24 sequences from an unspecified genome; no seqlengths
```

For level-specific CNV calls, set the `cnv_column_idx` parameter to the column containing CNV states represented as [EFO codes](https://www.ebi.ac.uk/efo/).

```
segfreq2 <- segtoFreq(segdata,cnv_column_idx = 9,cohort_name="c1")
segfreq2
#> GRangesList object of length 1:
#> $c1
#> GRanges object with 3106 ranges and 4 metadata columns:
#>          seqnames            ranges strand | low_gain_frequency
#>             <Rle>         <IRanges>  <Rle> |          <numeric>
#>      [1]        1          0-400000      * |                  0
#>      [2]        1    400000-1400000      * |                  0
#>      [3]        1   1400000-2400000      * |                  0
#>      [4]        1   2400000-3400000      * |                  0
#>      [5]        1   3400000-4400000      * |                  0
#>      ...      ...               ...    ... .                ...
#>   [3102]        Y 52400000-53400000      * |                  0
#>   [3103]        Y 53400000-54400000      * |                  0
#>   [3104]        Y 54400000-55400000      * |                  0
#>   [3105]        Y 55400000-56400000      * |                  0
#>   [3106]        Y 56400000-57227415      * |                  0
#>          low_loss_frequency high_gain_frequency high_loss_frequency
#>                   <numeric>           <numeric>           <numeric>
#>      [1]             0.0000                   0                   0
#>      [2]             0.0000                   0                   0
#>      [3]             0.0000                   0                   0
#>      [4]             0.0000                   0                   0
#>      [5]            33.3333                   0                   0
#>      ...                ...                 ...                 ...
#>   [3102]                  0                   0                   0
#>   [3103]                  0                   0                   0
#>   [3104]                  0                   0                   0
#>   [3105]                  0                   0                   0
#>   [3106]                  0                   0                   0
#>   -------
#>   seqinfo: 24 sequences from an unspecified genome; no seqlengths
```

# 4 Visualize CNV frequency

## 4.1 `pgxFreqplot` function

This function provides CNV frequency plots by genome or chromosomes as you request.

The parameters of this function:

* `data`: CNV frequency object returned by `pgxLoader` or `segtoFreq` functions.
* `chrom`: A vector specifying which chromosomes to plot. If NULL, the plot will cover the entire genome.
  #’ If specified, the frequencies are plotted with one panel for each chromosome. Default is NULL.
* `layout`: Number of rows and columns in plot. Only used in plot by chromosome. Default is c(1,1).
* `filters`: Index or string value indicating which filter to plot. The length of filters is limited to one if the parameter `circos` is FALSE. Default is the first filter.
* `circos`: A logical value indicating whether to return a circos plot. If TRUE, it returns a circos plot that can display and compare multiple filters. Default is FALSE.
* `assembly`: A string specifying the genome assembly version to apply to CNV frequency plotting. Allowed options are “hg19” and “hg38”. Default is “hg38”.

## 4.2 CNV frequency plot by genome

### 4.2.1 Input is `pgxfreq` object

```
pgxFreqplot(freq_pgxfreq, filters="NCIT:C3058")
```

![](data:image/png;base64...)

### 4.2.2 Input is `pgxmatrix` object

```
pgxFreqplot(freq_pgxmatrix, filters = "NCIT:C3493")
```

![](data:image/png;base64...)

## 4.3 CNV frequency plot by chromosomes

```
pgxFreqplot(freq_pgxfreq, filters='NCIT:C3058',chrom=c(7,9), layout = c(2,1))
```

![](data:image/png;base64...)

## 4.4 CNV frequency circos plot

The circos plot supports multiple group comparison

```
pgxFreqplot(freq_pgxmatrix,filters= c("NCIT:C3493","NCIT:C3512"),circos = TRUE)
```

![](data:image/png;base64...)

# 5 Session Info

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
#> [76] backports_1.5.0     broom_1.0.10        bslib_0.9.0
#> [79] Rcpp_1.1.0          SparseArray_1.10.0  gridExtra_2.3
#> [82] xfun_0.53           GlobalOptions_0.1.2 zoo_1.8-14
#> [85] pkgconfig_2.0.3
```