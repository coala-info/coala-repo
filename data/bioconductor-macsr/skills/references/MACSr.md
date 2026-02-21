# MACSr

#### 30 October 2025

# 1 Introduction

With the improvement of sequencing techniques, chromatin
immunoprecipitation followed by high throughput sequencing (ChIP-Seq)
is getting popular to study genome-wide protein-DNA interactions. To
address the lack of powerful ChIP-Seq analysis method, we presented
the Model-based Analysis of ChIP-Seq (MACS), for identifying
transcript factor binding sites. MACS captures the influence of genome
complexity to evaluate the significance of enriched ChIP regions and
MACS improves the spatial resolution of binding sites through
combining the information of both sequencing tag position and
orientation. MACS can be easily used for ChIP-Seq data alone, or with
a control sample with the increase of specificity. Moreover, as a
general peak-caller, MACS can also be applied to any “DNA enrichment
assays” if the question to be asked is simply: where we can find
significant reads coverage than the random background.

This package is a wrapper of the MACS toolkit based on `basilisk`.

# 2 Load the package

The package is built on
[basilisk](https://bioconductor.org/packages/release/bioc/html/basilisk.html). The
dependent python library
[macs3](https://github.com/macs3-project/MACS) will be installed
automatically inside its conda environment.

```
library(MACSr)
```

# 3 Usage

## 3.1 MACS3 functions

There are 13 functions imported from MACS3. Details of each function
can be checked from its manual.

| Functions | Description |
| --- | --- |
| `callpeak` | Main MACS3 Function to call peaks from alignment results. |
| `bdgpeakcall` | Call peaks from bedGraph output. |
| `bdgbroadcall` | Call broad peaks from bedGraph output. |
| `bdgcmp` | Comparing two signal tracks in bedGraph format. |
| `bdgopt` | Operate the score column of bedGraph file. |
| `cmbreps` | Combine BEDGraphs of scores from replicates. |
| `bdgdiff` | Differential peak detection based on paired four bedGraph files. |
| `filterdup` | Remove duplicate reads, then save in BED/BEDPE format. |
| `predictd` | Predict d or fragment size from alignment results. |
| `pileup` | Pileup aligned reads (single-end) or fragments (paired-end) |
| `randsample` | Randomly choose a number/percentage of total reads. |
| `refinepeak` | Take raw reads alignment, refine peak summits. |
| `callvar` | Call variants in given peak regions from the alignment BAM files. |
| `hmmratac` | Dedicated peak calling based on Hidden Markov Model for ATAC-seq data. |

## 3.2 Function `callpeak`

We have uploaded multipe test datasets from MACS to a data package
`MACSdata` in the `ExperimentHub`. For example, Here we download a
pair of single-end bed files to run the `callpeak` function.

```
eh <- ExperimentHub::ExperimentHub()
eh <- AnnotationHub::query(eh, "MACSdata")
CHIP <- eh[["EH4558"]]
#> see ?MACSdata and browseVignettes('MACSdata') for documentation
#> loading from cache
CTRL <- eh[["EH4563"]]
#> see ?MACSdata and browseVignettes('MACSdata') for documentation
#> loading from cache
```

Here is an example to call narrow and broad peaks on the SE bed files.

```
cp1 <- callpeak(CHIP, CTRL, gsize = 5.2e7, store_bdg = TRUE,
                name = "run_callpeak_narrow0", outdir = tempdir(),
                cutoff_analysis = TRUE)
#> Using Python: /home/biocbuild/.pyenv/versions/3.10.19/bin/python3.10
#> Creating virtual environment '/var/cache/basilisk/1.22.0/MACSr/1.18.0/env_macs' ...
#> + /home/biocbuild/.pyenv/versions/3.10.19/bin/python3.10 -m venv /var/cache/basilisk/1.22.0/MACSr/1.18.0/env_macs
#> Done!
#> Installing packages: pip, wheel, setuptools
#> + /var/cache/basilisk/1.22.0/MACSr/1.18.0/env_macs/bin/python -m pip install --upgrade pip wheel setuptools
#> Installing packages: 'macs3==3.0.2'
#> + /var/cache/basilisk/1.22.0/MACSr/1.18.0/env_macs/bin/python -m pip install --upgrade --no-user 'macs3==3.0.2'
#> Virtual environment '/var/cache/basilisk/1.22.0/MACSr/1.18.0/env_macs' successfully created.
#> INFO  @ 30 Oct 2025 00:56:29: [636 MB]
#> # Command line:
#> # ARGUMENTS LIST:
#> # name = run_callpeak_narrow0
#> # format = AUTO
#> # ChIP-seq file = ['/home/biocbuild/.cache/R/ExperimentHub/d48e779a98ac4_4601']
#> # control file = ['/home/biocbuild/.cache/R/ExperimentHub/d48e7285b852a_4606']
#> # effective genome size = 5.20e+07
#> # band width = 300
#> # model fold = [5.0, 50.0]
#> # qvalue cutoff = 5.00e-02
#> # The maximum gap between significant sites is assigned as the read length/tag size.
#> # The minimum length of peaks is assigned as the predicted fragment length "d".
#> # Larger dataset will be scaled towards smaller dataset.
#> # Range for calculating regional lambda is: 1000 bps and 10000 bps
#> # Broad region calling is off
#> # Additional cutoff on fold-enrichment is: 0.10
#> # Paired-End mode is off
#>
#> INFO  @ 30 Oct 2025 00:56:29: [636 MB] #1 read tag files...
#> INFO  @ 30 Oct 2025 00:56:29: [636 MB] #1 read treatment tags...
#> INFO  @ 30 Oct 2025 00:56:29: [639 MB] Detected format is: BED
#> INFO  @ 30 Oct 2025 00:56:29: [639 MB] * Input file is gzipped.
#> INFO  @ 30 Oct 2025 00:56:29: [642 MB] #1.2 read input tags...
#> INFO  @ 30 Oct 2025 00:56:29: [642 MB] Detected format is: BED
#> INFO  @ 30 Oct 2025 00:56:29: [642 MB] * Input file is gzipped.
#> INFO  @ 30 Oct 2025 00:56:29: [643 MB] #1 tag size is determined as 101 bps
#> INFO  @ 30 Oct 2025 00:56:29: [643 MB] #1 tag size = 101.0
#> INFO  @ 30 Oct 2025 00:56:29: [643 MB] #1  total tags in treatment: 49622
#> INFO  @ 30 Oct 2025 00:56:29: [643 MB] #1 user defined the maximum tags...
#> INFO  @ 30 Oct 2025 00:56:29: [643 MB] #1 filter out redundant tags at the same location and the same strand by allowing at most 1 tag(s)
#> INFO  @ 30 Oct 2025 00:56:29: [643 MB] #1  tags after filtering in treatment: 48047
#> INFO  @ 30 Oct 2025 00:56:29: [643 MB] #1  Redundant rate of treatment: 0.03
#> INFO  @ 30 Oct 2025 00:56:29: [643 MB] #1  total tags in control: 50837
#> INFO  @ 30 Oct 2025 00:56:29: [643 MB] #1 user defined the maximum tags...
#> INFO  @ 30 Oct 2025 00:56:29: [643 MB] #1 filter out redundant tags at the same location and the same strand by allowing at most 1 tag(s)
#> INFO  @ 30 Oct 2025 00:56:29: [643 MB] #1  tags after filtering in control: 50783
#> INFO  @ 30 Oct 2025 00:56:29: [643 MB] #1  Redundant rate of control: 0.00
#> INFO  @ 30 Oct 2025 00:56:29: [643 MB] #1 finished!
#> INFO  @ 30 Oct 2025 00:56:29: [643 MB] #2 Build Peak Model...
#> INFO  @ 30 Oct 2025 00:56:29: [643 MB] #2 looking for paired plus/minus strand peaks...
#> INFO  @ 30 Oct 2025 00:56:29: [643 MB] #2 Total number of paired peaks: 469
#> INFO  @ 30 Oct 2025 00:56:29: [643 MB] #2 Model building with cross-correlation: Done
#> INFO  @ 30 Oct 2025 00:56:29: [643 MB] #2 finished!
#> INFO  @ 30 Oct 2025 00:56:29: [643 MB] #2 predicted fragment length is 228 bps
#> INFO  @ 30 Oct 2025 00:56:29: [643 MB] #2 alternative fragment length(s) may be 228 bps
#> INFO  @ 30 Oct 2025 00:56:29: [643 MB] #2.2 Generate R script for model : /tmp/RtmpvfkVjl/run_callpeak_narrow0_model.r
#> INFO  @ 30 Oct 2025 00:56:29: [643 MB] #3 Call peaks...
#> INFO  @ 30 Oct 2025 00:56:29: [643 MB] #3 Pre-compute pvalue-qvalue table...
#> INFO  @ 30 Oct 2025 00:56:29: [643 MB] #3 Cutoff vs peaks called will be analyzed!
#> INFO  @ 30 Oct 2025 00:56:30: [664 MB] #3 Analysis of cutoff vs num of peaks or total length has been saved in b'/tmp/RtmpvfkVjl/run_callpeak_narrow0_cutoff_analysis.txt'
#> INFO  @ 30 Oct 2025 00:56:30: [664 MB] #3 In the peak calling step, the following will be performed simultaneously:
#> INFO  @ 30 Oct 2025 00:56:30: [664 MB] #3   Write bedGraph files for treatment pileup (after scaling if necessary)... run_callpeak_narrow0_treat_pileup.bdg
#> INFO  @ 30 Oct 2025 00:56:30: [664 MB] #3   Write bedGraph files for control lambda (after scaling if necessary)... run_callpeak_narrow0_control_lambda.bdg
#> INFO  @ 30 Oct 2025 00:56:30: [664 MB] #3   Pileup will be based on sequencing depth in treatment.
#> INFO  @ 30 Oct 2025 00:56:30: [664 MB] #3 Call peaks for each chromosome...
#> INFO  @ 30 Oct 2025 00:56:30: [665 MB] #4 Write output xls file... /tmp/RtmpvfkVjl/run_callpeak_narrow0_peaks.xls
#> INFO  @ 30 Oct 2025 00:56:30: [665 MB] #4 Write peak in narrowPeak format file... /tmp/RtmpvfkVjl/run_callpeak_narrow0_peaks.narrowPeak
#> INFO  @ 30 Oct 2025 00:56:30: [665 MB] #4 Write summits bed file... /tmp/RtmpvfkVjl/run_callpeak_narrow0_summits.bed
#> INFO  @ 30 Oct 2025 00:56:30: [665 MB] Done!
cp2 <- callpeak(CHIP, CTRL, gsize = 5.2e7, store_bdg = TRUE,
                name = "run_callpeak_broad", outdir = tempdir(),
                broad = TRUE)
#>
```

Here are the outputs.

```
cp1
#> macsList class
#> $outputs:
#>  /tmp/RtmpvfkVjl/run_callpeak_narrow0_control_lambda.bdg
#>  /tmp/RtmpvfkVjl/run_callpeak_narrow0_cutoff_analysis.txt
#>  /tmp/RtmpvfkVjl/run_callpeak_narrow0_model.r
#>  /tmp/RtmpvfkVjl/run_callpeak_narrow0_peaks.narrowPeak
#>  /tmp/RtmpvfkVjl/run_callpeak_narrow0_peaks.xls
#>  /tmp/RtmpvfkVjl/run_callpeak_narrow0_summits.bed
#>  /tmp/RtmpvfkVjl/run_callpeak_narrow0_treat_pileup.bdg
#> $arguments: tfile, cfile, gsize, outdir, name, store_bdg, cutoff_analysis
#> $log:
#>  INFO  @ 30 Oct 2025 00:56:29: [636 MB]
#>  # Command line:
#>  # ARGUMENTS LIST:
#>  # name = run_callpeak_narrow0
#>  # format = AUTO
#> ...
cp2
#> macsList class
#> $outputs:
#>  /tmp/RtmpvfkVjl/run_callpeak_broad_control_lambda.bdg
#>  /tmp/RtmpvfkVjl/run_callpeak_broad_model.r
#>  /tmp/RtmpvfkVjl/run_callpeak_broad_peaks.broadPeak
#>  /tmp/RtmpvfkVjl/run_callpeak_broad_peaks.gappedPeak
#>  /tmp/RtmpvfkVjl/run_callpeak_broad_peaks.xls
#>  /tmp/RtmpvfkVjl/run_callpeak_broad_treat_pileup.bdg
#> $arguments: tfile, cfile, gsize, outdir, name, store_bdg, broad
#> $log:
#>
```

## 3.3 The `macsList` class

The `macsList` is designed to contain everything of an execution,
including function, inputs, outputs and logs, for the purpose of
reproducibility.

For example, we can the function and input arguments.

```
cp1$arguments
#> [[1]]
#> callpeak
#>
#> $tfile
#> CHIP
#>
#> $cfile
#> CTRL
#>
#> $gsize
#> [1] 5.2e+07
#>
#> $outdir
#> tempdir()
#>
#> $name
#> [1] "run_callpeak_narrow0"
#>
#> $store_bdg
#> [1] TRUE
#>
#> $cutoff_analysis
#> [1] TRUE
```

The files of all the outputs are collected.

```
cp1$outputs
#> [1] "/tmp/RtmpvfkVjl/run_callpeak_narrow0_control_lambda.bdg"
#> [2] "/tmp/RtmpvfkVjl/run_callpeak_narrow0_cutoff_analysis.txt"
#> [3] "/tmp/RtmpvfkVjl/run_callpeak_narrow0_model.r"
#> [4] "/tmp/RtmpvfkVjl/run_callpeak_narrow0_peaks.narrowPeak"
#> [5] "/tmp/RtmpvfkVjl/run_callpeak_narrow0_peaks.xls"
#> [6] "/tmp/RtmpvfkVjl/run_callpeak_narrow0_summits.bed"
#> [7] "/tmp/RtmpvfkVjl/run_callpeak_narrow0_treat_pileup.bdg"
```

The `log` is especially important for `MACS` to check. Detailed
information was given in the log when running.

```
cat(paste(cp1$log, collapse="\n"))
#> INFO  @ 30 Oct 2025 00:56:29: [636 MB]
#> # Command line:
#> # ARGUMENTS LIST:
#> # name = run_callpeak_narrow0
#> # format = AUTO
#> # ChIP-seq file = ['/home/biocbuild/.cache/R/ExperimentHub/d48e779a98ac4_4601']
#> # control file = ['/home/biocbuild/.cache/R/ExperimentHub/d48e7285b852a_4606']
#> # effective genome size = 5.20e+07
#> # band width = 300
#> # model fold = [5.0, 50.0]
#> # qvalue cutoff = 5.00e-02
#> # The maximum gap between significant sites is assigned as the read length/tag size.
#> # The minimum length of peaks is assigned as the predicted fragment length "d".
#> # Larger dataset will be scaled towards smaller dataset.
#> # Range for calculating regional lambda is: 1000 bps and 10000 bps
#> # Broad region calling is off
#> # Additional cutoff on fold-enrichment is: 0.10
#> # Paired-End mode is off
#>
#> INFO  @ 30 Oct 2025 00:56:29: [636 MB] #1 read tag files...
#> INFO  @ 30 Oct 2025 00:56:29: [636 MB] #1 read treatment tags...
#> INFO  @ 30 Oct 2025 00:56:29: [639 MB] Detected format is: BED
#> INFO  @ 30 Oct 2025 00:56:29: [639 MB] * Input file is gzipped.
#> INFO  @ 30 Oct 2025 00:56:29: [642 MB] #1.2 read input tags...
#> INFO  @ 30 Oct 2025 00:56:29: [642 MB] Detected format is: BED
#> INFO  @ 30 Oct 2025 00:56:29: [642 MB] * Input file is gzipped.
#> INFO  @ 30 Oct 2025 00:56:29: [643 MB] #1 tag size is determined as 101 bps
#> INFO  @ 30 Oct 2025 00:56:29: [643 MB] #1 tag size = 101.0
#> INFO  @ 30 Oct 2025 00:56:29: [643 MB] #1  total tags in treatment: 49622
#> INFO  @ 30 Oct 2025 00:56:29: [643 MB] #1 user defined the maximum tags...
#> INFO  @ 30 Oct 2025 00:56:29: [643 MB] #1 filter out redundant tags at the same location and the same strand by allowing at most 1 tag(s)
#> INFO  @ 30 Oct 2025 00:56:29: [643 MB] #1  tags after filtering in treatment: 48047
#> INFO  @ 30 Oct 2025 00:56:29: [643 MB] #1  Redundant rate of treatment: 0.03
#> INFO  @ 30 Oct 2025 00:56:29: [643 MB] #1  total tags in control: 50837
#> INFO  @ 30 Oct 2025 00:56:29: [643 MB] #1 user defined the maximum tags...
#> INFO  @ 30 Oct 2025 00:56:29: [643 MB] #1 filter out redundant tags at the same location and the same strand by allowing at most 1 tag(s)
#> INFO  @ 30 Oct 2025 00:56:29: [643 MB] #1  tags after filtering in control: 50783
#> INFO  @ 30 Oct 2025 00:56:29: [643 MB] #1  Redundant rate of control: 0.00
#> INFO  @ 30 Oct 2025 00:56:29: [643 MB] #1 finished!
#> INFO  @ 30 Oct 2025 00:56:29: [643 MB] #2 Build Peak Model...
#> INFO  @ 30 Oct 2025 00:56:29: [643 MB] #2 looking for paired plus/minus strand peaks...
#> INFO  @ 30 Oct 2025 00:56:29: [643 MB] #2 Total number of paired peaks: 469
#> INFO  @ 30 Oct 2025 00:56:29: [643 MB] #2 Model building with cross-correlation: Done
#> INFO  @ 30 Oct 2025 00:56:29: [643 MB] #2 finished!
#> INFO  @ 30 Oct 2025 00:56:29: [643 MB] #2 predicted fragment length is 228 bps
#> INFO  @ 30 Oct 2025 00:56:29: [643 MB] #2 alternative fragment length(s) may be 228 bps
#> INFO  @ 30 Oct 2025 00:56:29: [643 MB] #2.2 Generate R script for model : /tmp/RtmpvfkVjl/run_callpeak_narrow0_model.r
#> INFO  @ 30 Oct 2025 00:56:29: [643 MB] #3 Call peaks...
#> INFO  @ 30 Oct 2025 00:56:29: [643 MB] #3 Pre-compute pvalue-qvalue table...
#> INFO  @ 30 Oct 2025 00:56:29: [643 MB] #3 Cutoff vs peaks called will be analyzed!
#> INFO  @ 30 Oct 2025 00:56:30: [664 MB] #3 Analysis of cutoff vs num of peaks or total length has been saved in b'/tmp/RtmpvfkVjl/run_callpeak_narrow0_cutoff_analysis.txt'
#> INFO  @ 30 Oct 2025 00:56:30: [664 MB] #3 In the peak calling step, the following will be performed simultaneously:
#> INFO  @ 30 Oct 2025 00:56:30: [664 MB] #3   Write bedGraph files for treatment pileup (after scaling if necessary)... run_callpeak_narrow0_treat_pileup.bdg
#> INFO  @ 30 Oct 2025 00:56:30: [664 MB] #3   Write bedGraph files for control lambda (after scaling if necessary)... run_callpeak_narrow0_control_lambda.bdg
#> INFO  @ 30 Oct 2025 00:56:30: [664 MB] #3   Pileup will be based on sequencing depth in treatment.
#> INFO  @ 30 Oct 2025 00:56:30: [664 MB] #3 Call peaks for each chromosome...
#> INFO  @ 30 Oct 2025 00:56:30: [665 MB] #4 Write output xls file... /tmp/RtmpvfkVjl/run_callpeak_narrow0_peaks.xls
#> INFO  @ 30 Oct 2025 00:56:30: [665 MB] #4 Write peak in narrowPeak format file... /tmp/RtmpvfkVjl/run_callpeak_narrow0_peaks.narrowPeak
#> INFO  @ 30 Oct 2025 00:56:30: [665 MB] #4 Write summits bed file... /tmp/RtmpvfkVjl/run_callpeak_narrow0_summits.bed
#> INFO  @ 30 Oct 2025 00:56:30: [665 MB] Done!
```

# 4 Resources

More details about `MACS3` can be found: <https://macs3-project.github.io/MACS/>.

# 5 SessionInfo

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
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] MACSdata_1.17.0  MACSr_1.18.0     BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] rappdirs_0.3.3       sass_0.4.10          generics_0.1.4
#>  [4] BiocVersion_3.22.0   RSQLite_2.4.3        lattice_0.22-7
#>  [7] digest_0.6.37        magrittr_2.0.4       evaluate_1.0.5
#> [10] grid_4.5.1           bookdown_0.45        fastmap_1.2.0
#> [13] blob_1.2.4           AnnotationHub_4.0.0  jsonlite_2.0.0
#> [16] Matrix_1.7-4         AnnotationDbi_1.72.0 DBI_1.2.3
#> [19] BiocManager_1.30.26  httr_1.4.7           purrr_1.1.0
#> [22] Biostrings_2.78.0    httr2_1.2.1          jquerylib_0.1.4
#> [25] cli_3.6.5            crayon_1.5.3         rlang_1.1.6
#> [28] XVector_0.50.0       dbplyr_2.5.1         Biobase_2.70.0
#> [31] bit64_4.6.0-1        withr_3.0.2          cachem_1.1.0
#> [34] yaml_2.3.10          tools_4.5.1          dir.expiry_1.18.0
#> [37] parallel_4.5.1       memoise_2.0.1        dplyr_1.1.4
#> [40] filelock_1.0.3       basilisk_1.22.0      ExperimentHub_3.0.0
#> [43] BiocGenerics_0.56.0  curl_7.0.0           reticulate_1.44.0
#> [46] vctrs_0.6.5          R6_2.6.1             png_0.1-8
#> [49] stats4_4.5.1         lifecycle_1.0.4      BiocFileCache_3.0.0
#> [52] Seqinfo_1.0.0        KEGGREST_1.50.0      IRanges_2.44.0
#> [55] S4Vectors_0.48.0     bit_4.6.0            pkgconfig_2.0.3
#> [58] bslib_0.9.0          pillar_1.11.1        glue_1.8.0
#> [61] Rcpp_1.1.0           xfun_0.53            tibble_3.3.0
#> [64] tidyselect_1.2.1     knitr_1.50           htmltools_0.5.8.1
#> [67] rmarkdown_2.30       compiler_4.5.1
```