# periodicDNA

#### Jacques Serizay

#### 2025-10-30

### Introduction to periodicDNA

Short DNA sequence motifs provide key information for interpreting the instructions in DNA, for example by providing binding sites for proteins or altering the structure of the double-helix. A less studied but important feature of DNA sequence motifs is their periodicity. A famous example is the 10-bp periodicity of many k-mers in nucleosome positioning (reviewed in Travers et al. 2010 or in Struhl and Segal 2013).

periodicDNA provides a framework to quantify the periodicity of k-mers of interest in DNA sequences. For a chosen k-mer, periodicDNA can identify which periods are statistically enriched in a set of sequences, by using a randomized shuffling approach to compute an empirical p-value. It can also generate continuous linear tracks of k-mer periodicity strength over genomic loci.

### Internal steps of periodicDNA

To estimate the periodicity strength of a given k-mer in one or several sequences, periodicDNA performs the following steps:

1. The k-mer occurrences are mapped and their pairwise distances are calculated.
2. The distribution of all the resulting pairwise distances (also called “distogram”) is generated.
3. The distogram is transformed into a frequency histogram and smoothed using a moving window of 3 to mask the universal three-base genomic periodicity. To normalize the frequency for distance decay, the local average (obtained by averaging the frequency with a moving window of 10) is then subtracted from the smoothed frequency.
4. Finally, the power spectral density (PSD) is estimated by applying a Fast Fourier Transform (Figure 1F) over the normalized frequency histogram. The magnitude of the PSD values indicates the contribution of a given period to the overall periodicity of the k-mer of interest.

![](data:image/png;base64...)

### Quantifying k-mer periodicity over a set of sequences

#### Basic usage

The main goal of periodicDNA is to quantify periodicity of a given k-mer in a set of sequences. For instance, one can assess the periodicity of TT dinucleotides in sequences around TSSs of ubiquitous promoters using `getPeriodicity()`.

In the following example, `getPeriodicity()` is directly ran using a GRanges object, specifying from which genome this GRanges comes from.

```
library(ggplot2)
library(magrittr)
library(periodicDNA)
#
data(ce11_TSSs)
periodicity_result <- getPeriodicity(
    ce11_TSSs[['Ubiq.']][1:500],
    genome = 'BSgenome.Celegans.UCSC.ce11',
    motif = 'TT',
    BPPARAM = setUpBPPARAM(1)
)
#> - Mapping k-mers.
#> - 523903 pairwise distances measured.
#> - Calculating pairwise distance distribution.
#> - Normalizing distogram vector.
#> - Applying Fast Fourier Transform to the normalized distogram.
```

The main output of `getPeriodicity()` is a table of power spectral density (PSD) values associated with discrete frequencies, computed using a Fast Fourier Transform. For a given frequency, a high PSD score indicates a high periodicity of the k-mer of interest.

In the previous example, TT dinucleotides in sequences around TSSs of ubiquitous promoters are highly periodic, with a periodicity of 10 bp.

```
head(periodicity_result$PSD)
#>    freq    period          PSD
#> 1 0.005 200.00000 6.256976e-08
#> 2 0.010 100.00000 2.204282e-08
#> 3 0.015  66.66667 2.215522e-09
#> 4 0.020  50.00000 1.108237e-08
#> 5 0.025  40.00000 4.649689e-09
#> 6 0.030  33.33333 2.661198e-08
subset(periodicity_result$periodicityMetrics, Period == 10)
#>    Freq Period          PSD
#> 20  0.1     10 3.633071e-06
```

Graphical output of `getPeriodicity()` can be obtained using the `plotPeriodicityResults()` function:

```
plotPeriodicityResults(periodicity_result)
#> Warning: The `size` argument of `element_line()` is deprecated as of ggplot2 3.4.0.
#> ℹ Please use the `linewidth` argument instead.
#> ℹ The deprecated feature was likely used in the periodicDNA package.
#>   Please report the issue at <https://github.com/js2264/periodicDNA/issues>.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
#> Warning: The `size` argument of `element_rect()` is deprecated as of ggplot2 3.4.0.
#> ℹ Please use the `linewidth` argument instead.
#> ℹ The deprecated feature was likely used in the periodicDNA package.
#>   Please report the issue at <https://github.com/js2264/periodicDNA/issues>.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
```

![](data:image/png;base64...)

The first plot shows the raw distribution of distances between pairs of ‘TT’ in the sequences of the provided GRanges. The second plot shows the decay-normalised distribution. Finally, the third plot shows the PSD scores of the ‘TT’ k-mer, measured from the normalised distribution.

#### Repeated shuffling of input sequences

periodicDNA provides an approach to compare the periodicity of a given k-mer in a set of sequences compared to background. For a given k-mer at a period T in a set of input sequences, the fold-change over background of its PSD is estimated by iteratively shuffling the input sequences and estimating the resulting PSD values.
Eventually, the log2 fold-change (l2FC) between the observed PSD and the median of the PSD values measured after shuffling is computed as follows:

l2FC = log2(observed PSD / median(shuffled PSDs)).

```
periodicity_result <- getPeriodicity(
    ce11_TSSs[['Ubiq.']][1:500],
    genome = 'BSgenome.Celegans.UCSC.ce11',
    motif = 'TT',
    n_shuffling = 5
)
#> - Calculating observed PSD
#> - Mapping k-mers.
#> - 523903 pairwise distances measured.
#> - Calculating pairwise distance distribution.
#> - Normalizing distogram vector.
#> - Applying Fast Fourier Transform to the normalized distogram.
#> - Shuffling 1/5
#> - Shuffling 2/5
#> - Shuffling 3/5
#> - Shuffling 4/5
#> - Shuffling 5/5
#> Only 5 shufflings. Cannot compute accurate empirical p-values. To compute empirical p-values, set up n_shuffling to at least 100. Only l2FC values are returned
head(periodicity_result$periodicityMetrics)
#>    Freq    Period PSD_observed       l2FC pval fdr
#> 1 0.005 200.00000     6.26e-08 -1.1862969   NA  NA
#> 2 0.010 100.00000     2.20e-08 -0.3065527   NA  NA
#> 3 0.015  66.66667     2.22e-09 -2.1704040   NA  NA
#> 4 0.020  50.00000     1.11e-08  0.8120648   NA  NA
#> 5 0.025  40.00000     4.65e-09 -0.6184262   NA  NA
#> 6 0.030  33.33333     2.66e-08  2.0561242   NA  NA
subset(periodicity_result$periodicityMetrics, Period == 10)
#>    Freq Period PSD_observed     l2FC pval fdr
#> 20  0.1     10     3.63e-06 8.070639   NA  NA
plotPeriodicityResults(periodicity_result)
#> Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
#> ℹ Please use `linewidth` instead.
#> ℹ The deprecated feature was likely used in the periodicDNA package.
#>   Please report the issue at <https://github.com/js2264/periodicDNA/issues>.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
#> Warning: The `<scale>` argument of `guides()` cannot be `FALSE`. Use "none" instead as
#> of ggplot2 3.3.4.
#> ℹ The deprecated feature was likely used in the periodicDNA package.
#>   Please report the issue at <https://github.com/js2264/periodicDNA/issues>.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
```

![](data:image/png;base64...)

If `n_shuffling >= 100`, an associated empirical p-value is calculated as well (North et al 2002). This metric indicates, for each individual period T, whether the observed PSD is significantly greater than the PSD values measured after shuffling the input sequences. Note that empirical p-values are only an estimation of the real p-value. Notably, small p-values are systematically under-estimated (North et al 2002).

#### Note

`getPeriodicity()` can also be ran directly on a set of sequences of interest as follows:

```
data(ce11_proms_seqs)
periodicity_result <- getPeriodicity(
    ce11_proms_seqs,
    motif = 'TT',
    BPPARAM = setUpBPPARAM(1)
)
#> - Mapping k-mers.
#> - 117630 pairwise distances measured.
#> - Calculating pairwise distance distribution.
#> - Normalizing distogram vector.
#> - Applying Fast Fourier Transform to the normalized distogram.
subset(periodicity_result$periodicityMetrics, Period == 10)
#>    Freq Period         PSD
#> 20  0.1     10 1.16806e-06
```

### Track of periodicity over a set of Genomic Ranges

The other aim of periodicDNA is to generate continuous linear tracks of k-mer periodicity strength over genomic loci of interest. `getPeriodicityTrack()` can be used to generate suck genomic tracks. In the following example,

```
WW_10bp_track <- getPeriodicityTrack(
    genome = 'BSgenome.Celegans.UCSC.ce11',
    granges = ce11_proms,
    motif = 'WW',
    period = 10,
    BPPARAM = setUpBPPARAM(1),
    bw_file = 'WW-10-bp-periodicity_over-proms.bw'
)
```

When plotted over sets of ubiquitous, germline or somatic TSSs, the resulting track clearly shows increase of WW 10-bp periodicity above the ubiquitous and germline TSSs, whereas somatic TSSs do not show such increase.

```
data(ce11_TSSs)
plotAggregateCoverage(
    WW_10bp_track,
    ce11_TSSs,
    xlab = 'Distance from TSS',
    ylab = '10-bp periodicity strength (forward proms.)'
)
```

![](data:image/png;base64...)

## Session info

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
#>  [1] BSgenome.Celegans.UCSC.ce11_1.4.2 periodicDNA_1.20.0
#>  [3] BiocParallel_1.44.0               BSgenome_1.78.0
#>  [5] rtracklayer_1.70.0                BiocIO_1.20.0
#>  [7] Biostrings_2.78.0                 XVector_0.50.0
#>  [9] magrittr_2.0.4                    ggplot2_4.0.0
#> [11] GenomicRanges_1.62.0              Seqinfo_1.0.0
#> [13] IRanges_2.44.0                    S4Vectors_0.48.0
#> [15] BiocGenerics_0.56.0               generics_0.1.4
#>
#> loaded via a namespace (and not attached):
#>  [1] SummarizedExperiment_1.40.0 gtable_0.3.6
#>  [3] rjson_0.2.23                xfun_0.53
#>  [5] bslib_0.9.0                 Biobase_2.70.0
#>  [7] lattice_0.22-7              vctrs_0.6.5
#>  [9] tools_4.5.1                 bitops_1.0-9
#> [11] curl_7.0.0                  parallel_4.5.1
#> [13] tibble_3.3.0                pkgconfig_2.0.3
#> [15] Matrix_1.7-4                RColorBrewer_1.1-3
#> [17] S7_0.2.0                    cigarillo_1.0.0
#> [19] lifecycle_1.0.4             compiler_4.5.1
#> [21] farver_2.1.2                Rsamtools_2.26.0
#> [23] codetools_0.2-20            htmltools_0.5.8.1
#> [25] sass_0.4.10                 RCurl_1.98-1.17
#> [27] yaml_2.3.10                 pillar_1.11.1
#> [29] crayon_1.5.3                jquerylib_0.1.4
#> [31] cachem_1.1.0                DelayedArray_0.36.0
#> [33] abind_1.4-8                 tidyselect_1.2.1
#> [35] digest_0.6.37               dplyr_1.1.4
#> [37] restfulr_0.0.16             labeling_0.4.3
#> [39] cowplot_1.2.0               fastmap_1.2.0
#> [41] grid_4.5.1                  cli_3.6.5
#> [43] SparseArray_1.10.0          S4Arrays_1.10.0
#> [45] dichromat_2.0-0.1           XML_3.99-0.19
#> [47] withr_3.0.2                 scales_1.4.0
#> [49] rmarkdown_2.30              httr_1.4.7
#> [51] matrixStats_1.5.0           zoo_1.8-14
#> [53] evaluate_1.0.5              knitr_1.50
#> [55] rlang_1.1.6                 glue_1.8.0
#> [57] jsonlite_2.0.0              R6_2.6.1
#> [59] MatrixGenerics_1.22.0       GenomicAlignments_1.46.0
```