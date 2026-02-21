# chromVAR

#### Alicia Schep

chromVAR is an R package for the analysis of sparse chromatin accessibility. chromVAR takes as inputs aligned fragments (filtered for duplicates and low quality) from ATAC-seq or DNAse-seq experiments as well as genomic annotations such as motif positions. chromVAR computes for each annotation and each cell or sample a bias corrected “deviation” in accessibility from the expected accessibility based on the average of all the cells or samples.

This vignette covers basic usage of chromVAR with standard inputs. For more detailed documentation covering different options for various inputs and additional applications, view the additional vignettes on the [documentation website](https://greenleaflab.github.io/chromVAR/). For more description of the method and applications, please see the [publication](https://www.nature.com/nmeth/journal/vaop/ncurrent/full/nmeth.4401.html) ([pdf](http://greenleaf.stanford.edu/assets/pdf/nmeth.4401.pdf), [supplement](https://drive.google.com/file/d/0B8eUn6ZURmqvUjBCbE5Hc0p4UFU/view?usp=sharing)).

##Loading the package

Use library or require to load the package and useful additional packages.

```
library(chromVAR)
library(motifmatchr)
library(Matrix)
library(SummarizedExperiment)
library(BiocParallel)
set.seed(2017)
```

##Setting multiprocessing options The package uses BiocParallel to do the multiprocessing. Check the documentation for BiocParallel to see available options. The settings can be set using the register function. For example, to use MulticoreParam with 8 cores:

```
register(MulticoreParam(8))
```

```
## Warning:   'IS_BIOC_BUILD_MACHINE' environment variable detected, setting
##   BiocParallel workers to 4 (was 8)
```

To enable progress bars for multiprocessed tasks, use

```
register(MulticoreParam(8, progressbar = TRUE))
```

```
## Warning:   'IS_BIOC_BUILD_MACHINE' environment variable detected, setting
##   BiocParallel workers to 4 (was 8)
```

For Windows, `MulticoreParam` will not work, but you can use SnowParam:

```
register(SnowParam(workers = 1, type = "SOCK"))
```

Even if you don’t want to use more than one core, it is best to explicitly register that choice using SerialParam:

```
register(SerialParam())
```

Please see the documentation for [BiocParallel](https://bioconductor.org/packages/release/bioc/html/BiocParallel.html) for more information about the `register` function and the various options for multi-processing.

##Reading in inputs

chromVAR takes as input a table of counts of fragments falling in open chromatin peaks. There are numerous software packages that enable the creation of count tables from epigenomics data; chromVAR also provides a method that is tailored for single-cell ATAC-seq counts. To learn more about the options for the count table and how to format a count table computed via other software, see the [Counts section of the documentation website](https://greenleaflab.github.io/chromVAR/articles/Articles/Counts.html).

###Peaks

For using chromVAR, it is recommended to use fixed-width, non-overlapping peaks. The method is fairly robust to the exact choice of peak width, but a width of 250 to 500 bp is recommended. See the [supplement](https://drive.google.com/file/d/0B8eUn6ZURmqvUjBCbE5Hc0p4UFU/view?usp=sharing) of the paper for a disussion section and supplementary figures related to the choice of peak width.

If analyzing single cell data, it can make sense to use peaks derived from bulk ATAC or DNAse-seq data, either from the same population or a similar population (or possibly from a public resource, like the Roadmap Epigenomics project).

If combining multiple peak files from different populations, it is recommended to combine the peaks together. The `filterPeaks` function (demonstrated a bit further down this vignette) will reduce the peaks to a non-overlapping set based on which overlapping peak has stronger signal across all the data.

The function `getPeaks` reads in the peaks as a GenomicRanges object. We will show its use by reading in a tiny sample bed file. We’ll use the `sort_peaks` argument to indicate we want to sort the peaks.

```
peakfile <- system.file("extdata/test_bed.txt", package = "chromVAR")
peaks <- getPeaks(peakfile, sort_peaks = TRUE)
```

```
## Peaks sorted
```

For reading in peaks in the narrowpeak format, chromVAR includes a function, `readNarrowpeaks`, that will read in the file, resize the peaks to a given size based on the `width` argument, and remove peaks that overlap a peak with stronger signal (if `non_overlapping` is set to TRUE – the default).

###Counts

The function `getCounts` returns a chromVARCounts object with a Matrix of fragment counts per sample/cell for each peak in assays. This data can be accessed with `counts(fragment_counts)`.The Matrix package is used so that if the matrix is sparse, the matrix will be stored as a sparse Matrix. We will demonstrate this function with a very tiny set of reads included in the package:

```
bamfile <- system.file("extdata/test_RG.bam", package = "chromVAR")
fragment_counts <- getCounts(bamfile,
                             peaks,
                             paired =  TRUE,
                             by_rg = TRUE,
                             format = "bam",
                             colData = DataFrame(celltype = "GM"))
```

```
## Reading in file: /tmp/RtmpzlbRRD/Rinst3a720a3407a51e/chromVAR/extdata/test_RG.bam
```

Here we passed only one bam file, but we can also pass a vector of bam file names. In that case, for the column data we would specify the appropriate value per file, e.g `DataFrame(celltype = c("GM","K562"))` if we were passing in one file for GM cells and one for K562 cells.

If RG tags are not used for combining multiple samples within a file, use `by_rg = FALSE`. For more on reading in counts, see the [Counts section of the documentation website](https://greenleaflab.github.io/chromVAR/articles/Articles/Counts.html).

## Example data

For the rest of the vignette, we will use a very small (but slightly larger than the previous example) data set of 10 GM cells and 10 H1 cells that has already been read in as a SummarizedExperiment object.

```
data(example_counts, package = "chromVAR")
head(example_counts)
```

```
## class: RangedSummarizedExperiment
## dim: 6 50
## metadata(0):
## assays(1): counts
## rownames: NULL
## rowData names(3): score qval name
## colnames(50): singles-GM12878-140905-1 singles-GM12878-140905-2 ...
##   singles-H1ESC-140820-24 singles-H1ESC-140820-25
## colData names(2): Cell_Type depth
```

##Getting GC content of peaks

The GC content will be used for determining background peaks. The function `addGCBias` returns an updated SummarizedExperiment with a new rowData column named “bias”. The function requires an input of a genome sequence, which can be provided as a BSgenome, FaFile, or DNAStringSet object.

```
library(BSgenome.Hsapiens.UCSC.hg19)
example_counts <- addGCBias(example_counts,
                            genome = BSgenome.Hsapiens.UCSC.hg19)
head(rowData(example_counts))
```

```
## DataFrame with 6 rows and 4 columns
##       score      qval        name      bias
##   <integer> <numeric> <character> <numeric>
## 1       259  25.99629   GM_peak_6     0.652
## 2        82   8.21494   H1_peak_7     0.680
## 3       156  15.65456  GM_peak_17     0.788
## 4        82   8.21494  H1_peak_13     0.674
## 5       140  14.03065  GM_peak_27     0.600
## 6       189  18.99529 GM_peak_29a     0.742
```

Check out `available.genomes` from the BSgenome package for what genomes are available as BSgenome packages. For making your own BSgenome object, check out `BSgenomeForge`.

##Filtering inputs

If working with single cell data, it is advisable to filter out samples with insufficient reads or a low proportion of reads in peaks as these may represent empty wells or dead cells. Two parameters are used for filtering – min\_in\_peaks and min\_depth. If not provided (as above), these cutoffs are estimated based on the medians from the data. min\_in\_peaks is set to 0.5 times the median proportion of fragments in peaks. min\_depth is set to the maximum of 500 or 10% of the median library size.

Unless `plot = FALSE` given as argument to function `filterSamples`, a plot will be generated.

```
#find indices of samples to keep
counts_filtered <- filterSamples(example_counts, min_depth = 1500,
                                 min_in_peaks = 0.15, shiny = FALSE)
```

If shiny argument is set to TRUE (the default), a shiny gadget will pop up which allows you to play with the filtering parameters and see which cells pass filters or not.

To get just the plot of what is filtered, use `filterSamplesPlot`. By default, the plot is interactive– to set it as not interactive use `use_plotly = FALSE`.

```
#find indices of samples to keep
filtering_plot <- filterSamplesPlot(example_counts, min_depth = 1500,
                                    min_in_peaks = 0.15, use_plotly = FALSE)
```

```
## Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`.
## ℹ See also `vignette("ggplot2-in-packages")` for more information.
## ℹ The deprecated feature was likely used in the chromVAR package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
filtering_plot
```

![](data:image/png;base64...)

To instead return the indexes of the samples to keep instead of a new SummarizedExperiment object, use ix\_return = TRUE.

```
ix <- filterSamples(example_counts, ix_return = TRUE, shiny = FALSE)
```

```
## min_in_peaks set to 0.105
```

```
## min_depth set to 1120.65
```

For both bulk and single cell data, peaks should be filtered based on having at least a certain number of fragments. At minimum, each peak should have at least one fragment across all the samples (it might be possible to have peaks with zero reads due to using a peak set defined by other data). Otherwise, downstream functions won’t work. The function `filterPeaks` will also reduce the peak set to non-overlapping peaks (keeping the peak with higher counts for peaks that overlap) if non\_overlapping argument is set to TRUE (which is the default).

```
counts_filtered <- filterPeaks(counts_filtered, non_overlapping = TRUE)
```

## Get motifs and what peaks contain motifs

The function `getJasparMotifs` fetches motifs from the JASPAR database.

```
motifs <- getJasparMotifs()
```

The function getJasparMotifs() by default gets human motifs from JASPAR core database. For other species motifs, change the species argument.

```
yeast_motifs <- getJasparMotifs(species = "Saccharomyces cerevisiae")
```

For using a collection other than core, use the `collection` argument. Options include: “CORE”, “CNE”, “PHYLOFACTS”, “SPLICE”, “POLII”, “FAM”, “PBM”, “PBM\_HOMEO”, “PBM\_HLH”.

The `getJasparMotifs` function is simply a wrapper around `getMatrixSet` from TFBSTools– you can also use that function to fetch motifs from JASPAR if you prefer, and/or check out the documentation for that function for more information.

The function `matchMotifs` from the motifmatchr package finds which peaks contain which motifs. By default, it returns a SummarizedExperiment object, which contains a sparse matrix indicating motif match or not.The function requires an input of a genome sequence, which can be provided as a BSgenome, FaFile, or DNAStringSet object.

```
library(motifmatchr)
motif_ix <- matchMotifs(motifs, counts_filtered,
                        genome = BSgenome.Hsapiens.UCSC.hg19)
```

One option is the p.cutoff for determing how stringent motif calling should be. The default value is 0.00005, which tends to give reasonable numbers of motif matches for human motifs.

Instead of returning just motif matches, the function can also return additional matrices (stored as assays) with the number of motif matches per peak and the maximum motif score per peak. For this additional information, use `out = scores`. To return the actual positions of motif matches, use `out = positions`. Either the output with `out = matches` or `out = scores` can be passed to the computeDeviations function.

If instead of using known motifs, you want to use all kmers of a certain length, the `matchKmers` function can be used. For more about using kmers as inputs, see the the [Annotations section of the documentation website](https://greenleaflab.github.io/chromVAR/articles/Articles/Counts.html).

```
kmer_ix <- matchKmers(6, counts_filtered,
                      genome = BSgenome.Hsapiens.UCSC.hg19)
```

## Compute deviations

The function `computeDeviations` returns a SummarizedExperiment with two “assays”. The first matrix (accessible via `deviations(dev)` or `assays(dev)$deviations`) will give the bias corrected “deviation” in accessibility for each set of peaks (rows) for each cell or sample (columns). This metric represent how accessible the set of peaks is relative to the expectation based on equal chromatin accessibility profiles across cells/samples, normalized by a set of background peak sets matched for GC and average accessability. The second matrix (`deviationScores(dev)` or `assays(deviations)$z`) gives the deviation Z-score, which takes into account how likely such a score would occur if randomly sampling sets of beaks with similar GC content and average accessibility.

```
dev <- computeDeviations(object = counts_filtered, annotations = motif_ix)
```

## Background Peaks

The function computeDeviations will use a set of background peaks for normalizing the deviation scores. This computation is done internally by default and not returned – to have greater control over this step, a user can run the `getBackgroundPeaks` function themselves and pass the result to computeDeviations under the background\_peaks parameter.

Background peaks are peaks that are similar to a peak in GC content and average accessibility.

```
bg <- getBackgroundPeaks(object = counts_filtered)
```

The result from `getBackgroundPeaks` is a matrix of indices, where each column represents the index of the peak that is a background peak.

To use the background peaks computed, simply add those to the call to computeDeviations:

```
dev <- computeDeviations(object = counts_filtered, annotations = motif_ix,
                         background_peaks = bg)
```

## Variability

The function `computeVariability` returns a data.frame that contains the variability (standard deviation of the z scores computed above across all cell/samples for a set of peaks), bootstrap confidence intervals for that variability (by resampling cells/samples), and a p-value for the variability being greater than the null hypothesis of 1.

```
variability <- computeVariability(dev)

plotVariability(variability, use_plotly = FALSE)
```

![](data:image/png;base64...)

`plotVariability` takes the output of `computeVariability` and returns a plot of rank sorted annotation sets and their variability. By default, the plot will be interactive, unless you set `use_plotly = FALSE`.

## Visualizing Deviations

For visualizing cells, it can be useful to project the deviation values into two dimension using TSNE. A convenience function for doing so is provided in `deviationsTsne`. If running in an interactive session, shiny can be set to TRUE to load up a shiny gadget for exploring parameters.

```
tsne_results <- deviationsTsne(dev, threshold = 1.5, perplexity = 10)
```

To plot the results, `plotDeviationsTsne` can be used. If running in an interactive session or an interactive Rmarkdown document, shiny can be set to TRUE to generate a shiny widget. Here we will show static results.

```
tsne_plots <- plotDeviationsTsne(dev, tsne_results,
                                 annotation_name = "TEAD3",
                                   sample_column = "Cell_Type",
                                 shiny = FALSE)
tsne_plots[[1]]
```

![](data:image/png;base64...)

```
tsne_plots[[2]]
```

![](data:image/png;base64...)

# Session Info

```
Sys.Date()
```

```
## [1] "2025-10-29"
```

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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] BSgenome.Hsapiens.UCSC.hg19_1.4.3 BSgenome_1.78.0
##  [3] rtracklayer_1.70.0                BiocIO_1.20.0
##  [5] Biostrings_2.78.0                 XVector_0.50.0
##  [7] BiocParallel_1.44.0               SummarizedExperiment_1.40.0
##  [9] Biobase_2.70.0                    GenomicRanges_1.62.0
## [11] Seqinfo_1.0.0                     IRanges_2.44.0
## [13] S4Vectors_0.48.0                  BiocGenerics_0.56.0
## [15] generics_0.1.4                    MatrixGenerics_1.22.0
## [17] matrixStats_1.5.0                 Matrix_1.7-4
## [19] motifmatchr_1.32.0                chromVAR_1.32.0
##
## loaded via a namespace (and not attached):
##  [1] DBI_1.2.3                   bitops_1.0-9
##  [3] nabor_0.5.0                 rlang_1.1.6
##  [5] magrittr_2.0.4              otel_0.2.0
##  [7] compiler_4.5.1              RSQLite_2.4.3
##  [9] vctrs_0.6.5                 pwalign_1.6.0
## [11] pkgconfig_2.0.3             crayon_1.5.3
## [13] fastmap_1.2.0               labeling_0.4.3
## [15] caTools_1.18.3              Rsamtools_2.26.0
## [17] promises_1.4.0              rmarkdown_2.30
## [19] tzdb_0.5.0                  DirichletMultinomial_1.52.0
## [21] purrr_1.1.0                 bit_4.6.0
## [23] xfun_0.53                   cachem_1.1.0
## [25] cigarillo_1.0.0             jsonlite_2.0.0
## [27] blob_1.2.4                  later_1.4.4
## [29] DelayedArray_0.36.0         parallel_4.5.1
## [31] R6_2.6.1                    bslib_0.9.0
## [33] RColorBrewer_1.1-3          jquerylib_0.1.4
## [35] Rcpp_1.1.0                  knitr_1.50
## [37] readr_2.1.5                 httpuv_1.6.16
## [39] tidyselect_1.2.1            dichromat_2.0-0.1
## [41] abind_1.4-8                 yaml_2.3.10
## [43] codetools_0.2-20            miniUI_0.1.2
## [45] curl_7.0.0                  lattice_0.22-7
## [47] tibble_3.3.0                withr_3.0.2
## [49] shiny_1.11.1                S7_0.2.0
## [51] Rtsne_0.17                  evaluate_1.0.5
## [53] archive_1.1.12              pillar_1.11.1
## [55] DT_0.34.0                   plotly_4.11.0
## [57] vroom_1.6.6                 RCurl_1.98-1.17
## [59] hms_1.1.4                   ggplot2_4.0.0
## [61] scales_1.4.0                gtools_3.9.5
## [63] xtable_1.8-4                glue_1.8.0
## [65] lazyeval_0.2.2              seqLogo_1.76.0
## [67] tools_4.5.1                 TFMPvalue_0.0.9
## [69] data.table_1.17.8           GenomicAlignments_1.46.0
## [71] XML_3.99-0.19               TFBSTools_1.48.0
## [73] grid_4.5.1                  tidyr_1.3.1
## [75] JASPAR2016_1.37.0           restfulr_0.0.16
## [77] cli_3.6.5                   S4Arrays_1.10.0
## [79] viridisLite_0.4.2           dplyr_1.1.4
## [81] gtable_0.3.6                sass_0.4.10
## [83] digest_0.6.37               SparseArray_1.10.0
## [85] rjson_0.2.23                htmlwidgets_1.6.4
## [87] farver_2.1.2                memoise_2.0.1
## [89] htmltools_0.5.8.1           lifecycle_1.0.4
## [91] httr_1.4.7                  mime_0.13
## [93] bit64_4.6.0-1
```