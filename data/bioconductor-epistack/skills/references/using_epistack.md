# An overview of the epistack package

Guillaume Devailly

#### 29 October 2025

#### Package

epistack 1.16.0

# Contents

* [1 Introduction](#introduction)
* [2 Epistack visualisation](#epistack-visualisation)
  + [2.1 The `plotEpisatck()` function](#the-plotepisatck-function)
  + [2.2 Custom panel arrangements](#custom-panel-arrangements)
* [3 Example 1: ChIP-seq coverage at peaks](#example-1-chip-seq-coverage-at-peaks)
  + [3.1 data origin](#data-origin)
  + [3.2 data loading](#data-loading)
  + [3.3 Generating coverage matrices](#generating-coverage-matrices)
  + [3.4 Plotting](#plotting)
* [4 Example 2: DNA methylation levels and ChIP-seq coverage at gene promoters sorted according to expression levels](#example-2-dna-methylation-levels-and-chip-seq-coverage-at-gene-promoters-sorted-according-to-expression-levels)
  + [4.1 Obtaining the TSS coordinates](#obtaining-the-tss-coordinates)
  + [4.2 Adding expression data to the TSS coordinates](#adding-expression-data-to-the-tss-coordinates)
  + [4.3 Extracting the epigenetic signals](#extracting-the-epigenetic-signals)
  + [4.4 Epistack plotting](#epistack-plotting)
* [5 Citation](#citation)
* [6 `sessionInfo()`](#sessioninfo)

# 1 Introduction

![](data:image/png;base64...)

Example of epistack outputs

The `epistack` package main objective is the visualizations of stacks
of genomic tracks (such as, but not restricted to, ChIP-seq or
DNA methyation data)
centered at genomic regions of interest. `epistack` needs three
different inputs:

* a genomic score objects, such as ChIP-seq coverage or DNA methylation values,
  provided as a `GRanges` (easily obtained from `bigwig` or `bam` files)
* a list of feature of interest, such as peaks or transcription start sites,
  provided as a `GRanges` (easily obtained from `gtf` or `bed` files)
* a score to sort the features, such as peak height, or gene expression value

Each inputs are then combined in a single `RangedSummarizedExperiment`
object use by epistack’s
ploting functions.

After introducing epistack’s plotting capacity,
this document will present two use cases:

* plotting ChIP-seq signal at peaks, to investigate peak quality
* plotting DNA methylation and ChIP-seq signals at gene promoters
  sorted according to gene expression,
  to investigate the associations between an epigenetic mark and gene expression

# 2 Epistack visualisation

Epistack is a visualisation package. It uses a `RangedSummarizedExperiment`
object as input, with
matrices embeded as assays. We will discuss how to
build such input obects in the next section. For now on, we will focus on
the visualisation functions using the example dataset included in the package.

The dataset can be accessed with:

```
library(GenomicRanges)
library(SummarizedExperiment)
library(epistack)

data("stackepi")
stackepi
#> class: RangedSummarizedExperiment
#> dim: 693 51
#> metadata(0):
#> assays(1): DNAme
#> rownames(693): ENSSSCG00000016737 ENSSSCG00000036350 ...
#>   ENSSSCG00000024209 ENSSSCG00000048227
#> rowData names(3): gene_id exp score
#> colnames(51): window_1 window_2 ... window_50 window_51
#> colData names(0):
```

## 2.1 The `plotEpisatck()` function

This dataset can be visualised with the `plotEpistack()` function.
The first parameter is the input `RangedSummarizedExperiment` object.

The second (optionnal) parameter, `assays` specifies which assay(s)
should be displayed as heatmap(s). In the `stackepi`
dataset, only one track is present, with an assay names `DNAme`.
Note that it is possible to have several different tracks embeded in the
same `RangedSummarizedExperiment` object, as demonstarted in the next sections.

An aditional `metric_col` is used, to display score associated with each
anchor region, such as expression values or peak scores. Optionaly,
the `metric_col` can be transformed before ploting using the
`metric_transfunc` parameters.

```
plotEpistack(
  stackepi,
  assay = "DNAme", metric_col = "exp",
  ylim = c(0, 1), zlim = c(0, 1),
  x_labels = c("-2.5kb", "TSS", "+2.5kb"),
  titles = "DNA methylation", legends = "%mCpG",
  metric_title = "Expression", metric_label = "log10(TPM+1)",
  metric_transfunc = function(x) log10(x+1)
)
```

![](data:image/png;base64...)

If a `bin` column is present, it is used to generate one average profile per bin.

```
stackepi <- addBins(stackepi, nbins = 5)

plotEpistack(
  stackepi,
  assay = "DNAme", metric_col = "exp",
  ylim = c(0, 1), zlim = c(0, 1),
  x_labels = c("-2.5kb", "TSS", "+2.5kb"),
  titles = "DNA methylation", legends = "%mCpG",
  metric_title = "Expression", metric_label = "log10(TPM+1)",
  metric_transfunc = function(x) log10(x+1)
)
```

![](data:image/png;base64...)

Colours can be changed using dedicated parameters:

```
plotEpistack(
  stackepi,
  assay = "DNAme", metric_col = "exp",
  ylim = c(0, 1), zlim = c(0, 1),
  x_labels = c("-2.5kb", "TSS", "+2.5kb"),
  titles = "DNA methylation", legends = "%mCpG",
  metric_title = "Expression", metric_label = "log10(TPM+1)",
  metric_transfunc = function(x) log10(x+1),
  tints = "dodgerblue",
  bin_palette = rainbow
)
```

![](data:image/png;base64...)
Text size, and other graphical parameters, can be changed using `cex` inside of
`plotEpistack()`. Indeed, additional arguments will be passed internaly to
`par()` (see `?par` for more details).

```
plotEpistack(
  stackepi,
  assay = "DNAme", metric_col = "exp",
  ylim = c(0, 1), zlim = c(0, 1),
  x_labels = c("-2.5kb", "TSS", "+2.5kb"),
  titles = "DNA methylation", legends = "%mCpG",
  metric_title = "Expression", metric_label = "log10(TPM+1)",
  metric_transfunc = function(x) log10(x+1),
  cex = 0.4, cex.main = 0.6
)
```

![](data:image/png;base64...)

## 2.2 Custom panel arrangements

Each panel can be plotted individually using dedicated functions.
For example:

```
plotAverageProfile(
  stackepi,
  ylim = c(0, 1),
  assay = "DNAme",
  x_labels = c("-2.5kb", "TSS", "+2.5kb"),
)
```

![](data:image/png;base64...)

And:

```
plotStackProfile(
  stackepi,
  assay = "DNAme",
  x_labels = c("-2.5kb", "TSS", "+2.5kb"),
  palette = hcl.colors,
  zlim = c(0, 1)
)
```

![](data:image/png;base64...)

It is therefore possible to arrange panels as you whish, using the
multipanel framework of your choice (layout, grid, patchwork, etc.).

```
layout(matrix(1:3, ncol = 1), heights = c(1.5, 3, 0.5))
old_par <- par(mar = c(2.5, 4, 0.6, 0.6))

plotAverageProfile(
  stackepi, assay = "DNAme",
  x_labels = c("-2.5kb", "TSS", "+2.5kb"), ylim = c(0, 1),
)

plotStackProfile(
  stackepi, assay = "DNAme",
  x_labels = c("-2.5kb", "TSS", "+2.5kb"), zlim = c(0, 1),
  palette = hcl.colors
)

plotStackProfileLegend(
  zlim = c(0, 1),
  palette = hcl.colors
)

par(old_par)
layout(1)
```

![](data:image/png;base64...)

# 3 Example 1: ChIP-seq coverage at peaks

## 3.1 data origin

In this part, we will use example ChIP-seq data
from the
[2016 CSAMA course](https://www.bioconductor.org/help/course-materials/2016/CSAMA/lab-5-chipseq/Epigenetics.html)
“Basics of ChIP-seq data analysis”
by Aleksandra Pekowska and Simon Anders.
Data can be found in this github repository:
[github.com/Bioconductor/CSAMA2016/tree/master/lab-5-chipseq/EpigeneticsCSAMA/inst/bedfiles](https://github.com/Bioconductor/CSAMA2016/tree/master/lab-5-chipseq/EpigeneticsCSAMA/inst/bedfiles)

There is no need to download the data as it can be remotely parsed.
The data consists of two H3K27ac ChIP-seq replicates, an input control,
and one list of peak for each replicates. It has been generated in
mouse Embryonic Stem cells and been subseted to have only data from chromosome 6
to allow fast vignette generation (but `epistack` can deal with whole genome
ChIP-seq data!).

```
path_reads <- c(
    rep1 = "https://raw.githubusercontent.com/Bioconductor/CSAMA2016/master/lab-5-chipseq/EpigeneticsCSAMA/inst/bedfiles/H3K27ac_rep1_filtered_ucsc_chr6.bed",
    rep2 = "https://raw.githubusercontent.com/Bioconductor/CSAMA2016/master/lab-5-chipseq/EpigeneticsCSAMA/inst/bedfiles/H3K27ac_rep2_filtered_ucsc_chr6.bed",
    input = "https://raw.githubusercontent.com/Bioconductor/CSAMA2016/master/lab-5-chipseq/EpigeneticsCSAMA/inst/bedfiles/ES_input_filtered_ucsc_chr6.bed"
)

path_peaks <- c(
    peak1 = "https://raw.githubusercontent.com/Bioconductor/CSAMA2016/master/lab-5-chipseq/EpigeneticsCSAMA/inst/bedfiles/Rep1_peaks_ucsc_chr6.bed",
    peak2 = "https://raw.githubusercontent.com/Bioconductor/CSAMA2016/master/lab-5-chipseq/EpigeneticsCSAMA/inst/bedfiles/Rep2_peaks_ucsc_chr6.bed"
)
```

## 3.2 data loading

We first read the peaks using *[rtracklayer](https://bioconductor.org/packages/3.22/rtracklayer)*:

```
library(rtracklayer)
peaks <- lapply(path_peaks, import)
```

Peaks from each replicates can be merged using *[GenomicRanges](https://bioconductor.org/packages/3.22/GenomicRanges)*
`union()` function (loaded with *[rtracklayer](https://bioconductor.org/packages/3.22/rtracklayer)*).
We then rescue peaks metadata, and compute a new `mean_score` that we use
to arrange our peak list.

```
merged_peaks <- GenomicRanges::union(peaks[[1]], peaks[[2]])

scores_rep1 <- double(length(merged_peaks))
scores_rep1[findOverlaps(peaks[[1]], merged_peaks, select = "first")] <- peaks[[1]]$score

scores_rep2 <- double(length(merged_peaks))
scores_rep2[findOverlaps(peaks[[2]], merged_peaks, select = "first")] <- peaks[[2]]$score

peak_type <- ifelse(
    scores_rep1 != 0 & scores_rep2 != 0, "Both", ifelse(
        scores_rep1 != 0, "Rep1 only", "Rep2 only"
    )
)

mcols(merged_peaks) <- DataFrame(scores_rep1, scores_rep2, peak_type)
merged_peaks$mean_scores <- apply((mcols(merged_peaks)[, c("scores_rep1", "scores_rep2")]), 1, mean)
merged_peaks <- merged_peaks[order(merged_peaks$mean_scores, decreasing = TRUE), ]
rm(scores_rep1, scores_rep2, peak_type)

merged_peaks
#> GRanges object with 3534 ranges and 4 metadata columns:
#>          seqnames              ranges strand | scores_rep1 scores_rep2
#>             <Rle>           <IRanges>  <Rle> |   <numeric>   <numeric>
#>      [1]     chr6   91638787-91646132      * |     3182.78     3203.04
#>      [2]     chr6   56746391-56748809      * |     3217.75     3100.00
#>      [3]     chr6   29296913-29298755      * |     3132.86     3100.00
#>      [4]     chr6     5445473-5448143      * |     3100.00     3100.00
#>      [5]     chr6   29996830-29999535      * |     3100.00     3100.00
#>      ...      ...                 ...    ... .         ...         ...
#>   [3530]     chr6   94556781-94557433      * |        0.00       50.10
#>   [3531]     chr6 119142482-119143018      * |       50.09        0.00
#>   [3532]     chr6 100424986-100425605      * |       50.08        0.00
#>   [3533]     chr6   66963731-66964304      * |        0.00       50.03
#>   [3534]     chr6   96545103-96545640      * |       50.01        0.00
#>            peak_type mean_scores
#>          <character>   <numeric>
#>      [1]        Both     3192.91
#>      [2]        Both     3158.88
#>      [3]        Both     3116.43
#>      [4]        Both     3100.00
#>      [5]        Both     3100.00
#>      ...         ...         ...
#>   [3530]   Rep2 only      25.050
#>   [3531]   Rep1 only      25.045
#>   [3532]   Rep1 only      25.040
#>   [3533]   Rep2 only      25.015
#>   [3534]   Rep1 only      25.005
#>   -------
#>   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

We then import the ChIP-seq reads. In the example datasets,
they are provided as .bed files, but for ChIP-seq we recommand
importing .bigwig coverage files. Bam files can also be imported using
`GenomicAlignments::readGAlignment*()`.

```
reads <- lapply(path_reads, import)
```

## 3.3 Generating coverage matrices

We generate coverage matrices with ChIP-seq coverage signal
summarized around each ChIP-seq peaks.
Several tools exists to generate such coverage matrices. We will demonstrate the
`normalizeToMatrix()` method from *[EnrichedHeatmap](https://bioconductor.org/packages/3.22/EnrichedHeatmap)*.
Other alternatives include *[Repitools](https://bioconductor.org/packages/3.22/Repitools)*’ `featureScores()`,
or *[seqplots](https://bioconductor.org/packages/3.22/seqplots)*’ `getPlotSetArray()`.

We will focus on the regions around peak centers, extended from +/-5kb with
a window size of 250 bp. We keep track of the extent of our region of interest
in a `xlab` variable, and specify unique column names for each matrix.

Note: when using ChIP-seq data from a bigwig file, use the `value_column` parameter
of the `normalizeToMatrix()` function.

```
library(EnrichedHeatmap)

coverage_matrices <- lapply(
    reads,
    function(x) {
        normalizeToMatrix(
            x,
            resize(merged_peaks, width = 1, fix = "center"),
            extend = 5000, w = 250,
            mean_mode = "coverage"
        )
    }
)

xlabs <- c("-5kb", "peak center", "+5kb")
```

We then add the peak coordinates and each matrix to a
`RangedSummarizedExperiment` object.

```
merged_peaks <- SummarizedExperiment(
    rowRanges = merged_peaks,
    assays = coverage_matrices
)
```

## 3.4 Plotting

The `plotEpistack()` function will use the `merged_peaks` object to generate a
complex representation of the ChIP-seq signals around
the genomic feature of interests (here ChIP-seq peaks).

```
plotEpistack(
    merged_peaks,
    assays = c("rep1", "rep2", "input"),
    tints = c("dodgerblue", "firebrick1", "grey"),
    titles = c("Rep1", "Rep2" , "Input"),
    x_labels = xlabs,
    zlim = c(0, 4), ylim = c(0, 4),
    metric_col = "mean_scores", metric_title = "Peak score",
    metric_label = "score"
)
```

![](data:image/png;base64...)

If a `bin` column is present in the input `GRanges` object, it will
be used to annotate the figure and to generate one average profile per bin
in the lower panels. Here we use the `peak_type` as our bin column.

```
rowRanges(merged_peaks)$bin <- rowRanges(merged_peaks)$peak_type

plotEpistack(
    merged_peaks,
    assays = c("rep1", "rep2", "input"),
    tints = c("dodgerblue", "firebrick1", "grey"),
    titles = c("Rep1", "Rep2" , "Input"),
    x_labels = xlabs,
    zlim = c(0, 4), ylim = c(0, 4),
    metric_col = "mean_scores", metric_title = "Peak score", metric_label = "score",
    bin_palette = colorRampPalette(c("darkorchid1", "dodgerblue", "firebrick1")),
    npix_height = 300
)
```

![](data:image/png;base64...)

We can also sort on the bins first, and then on peak score. Epistack will
respect the order in the `GRanges` object.

```
merged_peaks <- merged_peaks[order(
  rowRanges(merged_peaks)$bin, rowRanges(merged_peaks)$mean_scores,
  decreasing = c(FALSE, TRUE), method = "radix"
), ]

plotEpistack(
    merged_peaks,
    patterns = c("rep1", "rep2", "input"),
    tints = c("dodgerblue", "firebrick1", "grey"),
    titles = c("Rep1", "Rep2" , "Input"),
    x_labels = xlabs,
    zlim = c(0, 4), ylim = c(0, 4),
    metric_col = "mean_scores", metric_title = "Peak score", metric_label = "score",
    bin_palette = colorRampPalette(c("darkorchid1", "dodgerblue", "firebrick1")),
    npix_height = 300
)
```

![](data:image/png;base64...)

# 4 Example 2: DNA methylation levels and ChIP-seq coverage at gene promoters sorted according to expression levels

## 4.1 Obtaining the TSS coordinates

In this part, we will plot the epigenetic signals at gene promoters, or more
precisely around gene Transcription Start Sites (TSS).
TSS coordinates can be obtained from various sources. One can access
the [Ensembl](https://www.ensembl.org/index.html) annotations using
*[biomaRt](https://bioconductor.org/packages/3.22/biomaRt)*, download a `.gtf` file and parse it using *[rtracklayer](https://bioconductor.org/packages/3.22/rtracklayer)*’s `import()`, or use *[AnnotationHub](https://bioconductor.org/packages/3.22/AnnotationHub)* and
*[ensembldb](https://bioconductor.org/packages/3.22/ensembldb)*. It is however important to work with the same genome
version has the one used to align the ChIP-seq reads.

For simplicity, we will use *[EnrichedHeatmap](https://bioconductor.org/packages/3.22/EnrichedHeatmap)* example data.

```
load(
    system.file("extdata", "chr21_test_data.RData",
                package = "EnrichedHeatmap"),
    verbose = TRUE
)
#> Loading objects:
#>   rpkm
#>   H3K4me3
#>   cgi
#>   meth
#>   genes

tss <- promoters(genes, upstream = 0, downstream = 1)
tss$gene_id <- names(tss)

tss
#> GRanges object with 720 ranges and 1 metadata column:
#>                      seqnames    ranges strand |            gene_id
#>                         <Rle> <IRanges>  <Rle> |        <character>
#>    ENSG00000141956.9    chr21  43299591      - |  ENSG00000141956.9
#>   ENSG00000141959.12    chr21  45719934      + | ENSG00000141959.12
#>    ENSG00000142149.4    chr21  33245628      + |  ENSG00000142149.4
#>   ENSG00000142156.10    chr21  47401651      + | ENSG00000142156.10
#>    ENSG00000142166.8    chr21  34696734      + |  ENSG00000142166.8
#>                  ...      ...       ...    ... .                ...
#>    ENSG00000270533.1    chr21  10476061      - |  ENSG00000270533.1
#>    ENSG00000270652.1    chr21  38315567      + |  ENSG00000270652.1
#>    ENSG00000270835.1    chr21  39577700      - |  ENSG00000270835.1
#>    ENSG00000271308.1    chr21  11169720      + |  ENSG00000271308.1
#>    ENSG00000271486.1    chr21  20993009      + |  ENSG00000271486.1
#>   -------
#>   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

## 4.2 Adding expression data to the TSS coordinates

Epistack can work with any units and any scores, not limited to
expression data. Here we will use gene expression data from an RNA-seq
experiment, in RPKM units, as it is the data format available in
*[EnrichedHeatmap](https://bioconductor.org/packages/3.22/EnrichedHeatmap)* example dataset.
To join the expression data to the TSS coordinates, we will use an
*[epistack](https://bioconductor.org/packages/3.22/epistack)* utility function `addMetricAndArrangeGRanges()`:

```
expr <- data.frame(
    gene_id = names(rpkm),
    expr = rpkm
)

epidata <- addMetricAndArrangeGRanges(
    tss, expr,
    gr_key = "gene_id",
    order_key = "gene_id", order_value = "expr"
)

epidata
#> GRanges object with 720 ranges and 2 metadata columns:
#>                      seqnames    ranges strand |            gene_id      expr
#>                         <Rle> <IRanges>  <Rle> |        <character> <numeric>
#>    ENSG00000198618.4    chr21  20230097      + |  ENSG00000198618.4  461.0990
#>    ENSG00000160307.5    chr21  48025121      - |  ENSG00000160307.5  145.4498
#>   ENSG00000142192.16    chr21  27543446      - | ENSG00000142192.16  137.3838
#>    ENSG00000183255.7    chr21  46293752      - |  ENSG00000183255.7  131.7230
#>   ENSG00000142168.10    chr21  33031935      + | ENSG00000142168.10   97.5167
#>                  ...      ...       ...    ... .                ...       ...
#>    ENSG00000205445.3    chr21  45971388      - |  ENSG00000205445.3         0
#>    ENSG00000232698.1    chr21  45627282      - |  ENSG00000232698.1         0
#>    ENSG00000215369.3    chr21  19266802      - |  ENSG00000215369.3         0
#>    ENSG00000237569.1    chr21  24781448      - |  ENSG00000237569.1         0
#>    ENSG00000227438.1    chr21  47517444      - |  ENSG00000227438.1         0
#>   -------
#>   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

We create 5 bins of genes of equal sizes depending on the expression levels,
with *[epistack](https://bioconductor.org/packages/3.22/epistack)* utility function `addBins()`:

```
epidata <- addBins(epidata, nbins = 5)
epidata
#> GRanges object with 720 ranges and 3 metadata columns:
#>                      seqnames    ranges strand |            gene_id      expr
#>                         <Rle> <IRanges>  <Rle> |        <character> <numeric>
#>    ENSG00000198618.4    chr21  20230097      + |  ENSG00000198618.4  461.0990
#>    ENSG00000160307.5    chr21  48025121      - |  ENSG00000160307.5  145.4498
#>   ENSG00000142192.16    chr21  27543446      - | ENSG00000142192.16  137.3838
#>    ENSG00000183255.7    chr21  46293752      - |  ENSG00000183255.7  131.7230
#>   ENSG00000142168.10    chr21  33031935      + | ENSG00000142168.10   97.5167
#>                  ...      ...       ...    ... .                ...       ...
#>    ENSG00000205445.3    chr21  45971388      - |  ENSG00000205445.3         0
#>    ENSG00000232698.1    chr21  45627282      - |  ENSG00000232698.1         0
#>    ENSG00000215369.3    chr21  19266802      - |  ENSG00000215369.3         0
#>    ENSG00000237569.1    chr21  24781448      - |  ENSG00000237569.1         0
#>    ENSG00000227438.1    chr21  47517444      - |  ENSG00000227438.1         0
#>                            bin
#>                      <numeric>
#>    ENSG00000198618.4         1
#>    ENSG00000160307.5         1
#>   ENSG00000142192.16         1
#>    ENSG00000183255.7         1
#>   ENSG00000142168.10         1
#>                  ...       ...
#>    ENSG00000205445.3         5
#>    ENSG00000232698.1         5
#>    ENSG00000215369.3         5
#>    ENSG00000237569.1         5
#>    ENSG00000227438.1         5
#>   -------
#>   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

## 4.3 Extracting the epigenetic signals

As previously described, we use *[EnrichedHeatmap](https://bioconductor.org/packages/3.22/EnrichedHeatmap)*’s
`normalizeToMatrix()` function to extract the signals, rename the signal
colmun names, and add them to the epidata GRanges object:

```
methstack <- normalizeToMatrix(
    meth, epidata, value_column = "meth",
    extend = 5000, w = 250, mean_mode = "absolute"
)

h3k4me3stack <- normalizeToMatrix(
    H3K4me3, epidata, value_column = "coverage",
    extend = 5000, w = 250, mean_mode = "coverage"
)

epidata <- SummarizedExperiment(
    rowRanges = epidata,
    assays = list(DNAme = methstack, H3K4me3 = h3k4me3stack)
)
```

## 4.4 Epistack plotting

The `epidata` GRanges object is now ready to plot:

```
plotEpistack(
    epidata,
    tints = c("dodgerblue", "orange"),
    zlim = list(c(0, 1), c(0, 25)), ylim = list(c(0, 1), c(0, 50)),
    x_labels = c("-5kb", "TSS", "+5kb"),
    legends = c("%mCpG", "Coverage"),
    metric_col = "expr", metric_title = "Gene expression",
    metric_label = "log10(RPKM+1)",
    metric_transfunc = function(x) log10(x + 1),
    npix_height = 300
)
```

![](data:image/png;base64...)

# 5 Citation

To cite {epistack}, please refers to its [HAL entry](https://hal.inrae.fr/hal-03401251):

*Safia Saci, Guillaume Devailly. epistack: An R package
to visualise stack profiles of epigenomic signals. 2021, ⟨hal-03401251v2⟩*

# 6 `sessionInfo()`

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
#> [1] grid      stats4    stats     graphics  grDevices utils     datasets
#> [8] methods   base
#>
#> other attached packages:
#>  [1] EnrichedHeatmap_1.40.0      ComplexHeatmap_2.26.0
#>  [3] rtracklayer_1.70.0          epistack_1.16.0
#>  [5] SummarizedExperiment_1.40.0 Biobase_2.70.0
#>  [7] MatrixGenerics_1.22.0       matrixStats_1.5.0
#>  [9] GenomicRanges_1.62.0        Seqinfo_1.0.0
#> [11] IRanges_2.44.0              S4Vectors_0.48.0
#> [13] BiocGenerics_0.56.0         generics_0.1.4
#> [15] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] shape_1.4.6.1            circlize_0.4.16          rjson_0.2.23
#>  [4] xfun_0.53                bslib_0.9.0              GlobalOptions_0.1.2
#>  [7] lattice_0.22-7           tools_4.5.1              bitops_1.0-9
#> [10] curl_7.0.0               parallel_4.5.1           cluster_2.1.8.1
#> [13] Matrix_1.7-4             RColorBrewer_1.1-3       cigarillo_1.0.0
#> [16] lifecycle_1.0.4          compiler_4.5.1           Rsamtools_2.26.0
#> [19] Biostrings_2.78.0        tinytex_0.57             codetools_0.2-20
#> [22] clue_0.3-66              htmltools_0.5.8.1        sass_0.4.10
#> [25] RCurl_1.98-1.17          yaml_2.3.10              crayon_1.5.3
#> [28] jquerylib_0.1.4          BiocParallel_1.44.0      DelayedArray_0.36.0
#> [31] cachem_1.1.0             magick_2.9.0             iterators_1.0.14
#> [34] abind_1.4-8              foreach_1.5.2            locfit_1.5-9.12
#> [37] digest_0.6.37            restfulr_0.0.16          bookdown_0.45
#> [40] fastmap_1.2.0            colorspace_2.1-2         cli_3.6.5
#> [43] SparseArray_1.10.0       magrittr_2.0.4           S4Arrays_1.10.0
#> [46] XML_3.99-0.19            plotrix_3.8-4            rmarkdown_2.30
#> [49] XVector_0.50.0           httr_1.4.7               GetoptLong_1.0.5
#> [52] png_0.1-8                evaluate_1.0.5           knitr_1.50
#> [55] BiocIO_1.20.0            doParallel_1.0.17        rlang_1.1.6
#> [58] Rcpp_1.1.0               BiocManager_1.30.26      jsonlite_2.0.0
#> [61] R6_2.6.1                 GenomicAlignments_1.46.0
```