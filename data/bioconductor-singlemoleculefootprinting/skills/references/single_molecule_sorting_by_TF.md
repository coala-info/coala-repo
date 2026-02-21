# single\_molecule\_sorting\_by\_TF

## Introduction

This vignette exemplifies how to perform single molecule sorting based on prior TF binding site annotation as per [Sönmezer et al., 2021](https://doi.org/10.1016/j.molcel.2020.11.015) and [Kleinendorst & Barzaghi et al., 2021](https://doi.org/10.1038/s41596-021-00630-1).

## Loading libraries

```
suppressWarnings(library(SingleMoleculeFootprinting))
suppressWarnings(library(BSgenome.Mmusculus.UCSC.mm10))
```

## Sorting by single TF

Sorting by single TF requires designing three bins with coordinates [-35;-25], [-15;+15], [+25,+35] relative to the center of the TF motif.
Here we exemplify the process manually for clarity.

```
RegionOfInterest = GRanges("chr12", IRanges(20464551, 20465050))
Methylation = qs::qread(system.file("extdata", "Methylation_3.qs", package="SingleMoleculeFootprinting"))
TFBSs = qs::qread(system.file("extdata", "TFBSs_3.qs", package="SingleMoleculeFootprinting"))

motif_center = start(IRanges::resize(TFBSs, 1, "center"))
SortingBins = c(
  GRanges("chr1", IRanges(motif_center-35, motif_center-25)),
  GRanges("chr1", IRanges(motif_center-15, motif_center+15)),
  GRanges("chr1", IRanges(motif_center+25, motif_center+35))
)

PlotAvgSMF(
  MethGR = Methylation[[1]], RegionOfInterest = RegionOfInterest,
  TFBSs = TFBSs, SortingBins = SortingBins
  )
## No sorted reads passed...plotting counts from all reads
```

![](data:image/png;base64...)

Sorting molecules involves averaging, for each molecule, the binary methylation values for the cytosines overlapping those bins.
Reducing those averages to integers summarises each molecule to three binary digits.
We sort and plot molecules based on these digits.
The whole process is wrapped in the `SortReadsBySingleTF` function.

```
SortedReads = SortReadsBySingleTF(MethSM = Methylation[[2]], TFBS = TFBSs)
## Designing sorting bins
## Collecting summarized methylation for bins
## Subsetting those reads that cover all bins
## Summarizing reads into patterns
## Splitting reads by pattern
```

N.b.: custom bins can be used by through the argument `bins`.

The function returns a list with one item per sample.
Each of these is itself a list of up to eight items, one per possible combination of three binary digits, i.e. 000, 001, 010, etc.
Each of these items contains the IDs of the molecules sorted.
N.b.: patterns with 0 molecules will not be reported.

```
lapply(SortedReads$SMF_MM_TKO_DE_, head, 2)
## $`000`
## [1] "D00404:273:H5757BCXY:1:1102:2767:29201"
## [2] "D00404:273:H5757BCXY:1:1109:17973:76532"
##
## $`001`
## [1] "D00404:273:H5757BCXY:1:2107:14462:35292"
## [2] "D00404:273:H5757BCXY:1:2116:11877:22847"
##
## $`010`
## [1] "D00404:283:HCFT7BCXY:2:2206:12683:36087"
## [2] "NB501735:9:HLG5VBGX2:2:13108:18702:4995"
##
## $`011`
## [1] "D00404:273:H5757BCXY:1:2103:13490:80813"
## [2] "D00404:273:H5757BCXY:1:2210:11790:19673"
##
## $`100`
## [1] "D00404:273:H5757BCXY:1:1102:2692:28832"
## [2] "D00404:273:H5757BCXY:1:1108:7836:31800"
##
## $`101`
## [1] "D00404:273:H5757BCXY:1:1101:16782:14912"
## [2] "D00404:273:H5757BCXY:1:1103:15983:34280"
##
## $`110`
## [1] "D00404:273:H5757BCXY:1:1203:5101:74304"
## [2] "D00404:273:H5757BCXY:2:2111:8077:43320"
##
## $`111`
## [1] "D00404:273:H5757BCXY:1:1106:20721:33897"
## [2] "D00404:273:H5757BCXY:1:1107:16458:47084"
```

The number of molecules per pattern can be checked using `lenghts`.

```
lengths(SortedReads$SMF_MM_TKO_DE_)
##  000  001  010  011  100  101  110  111
##  216   72    6   19  301 2372   51  932
```

Here most molecules show the 101 pattern.

These patterns are not immediately human readable. For convenience we hard-coded a biological interpretation in the function `SingleTFStates`.

```
SingleTFStates()
## $bound
## [1] "101"
##
## $accessible
## [1] "111"
##
## $closed
## [1] "000" "100" "001"
##
## $unassigned
## [1] "010" "110" "011"
```

This function can be used together with the function `StateQuantification`, to compute the frequencies of the biological states associated with single TF binding.
The function `StateQuantificationBySingleTF` hard-codes the `states` argument for convenience.

```
StateQuantification(SortedReads = SortedReads, states = SingleTFStates())
## # A tibble: 4 × 4
##   Sample         State      Counts Freqs
##   <chr>          <chr>       <int> <dbl>
## 1 SMF_MM_TKO_DE_ bound        2372 59.8
## 2 SMF_MM_TKO_DE_ accessible    932 23.5
## 3 SMF_MM_TKO_DE_ closed        589 14.8
## 4 SMF_MM_TKO_DE_ unassigned     76  1.91
```

Sorted molecules can be visualized with the `PlotSM` function.

```
PlotSM(MethSM = Methylation[[2]], RegionOfInterest = RegionOfInterest, sorting.strategy = "classical", SortedReads = SortedReads)
## Arranging reads according to classical sorting.strategy
## Inferring sorting was performed by single TF
## Warning: Removed 80 rows containing missing values or values outside the scale range
## (`geom_tile()`).
```

![](data:image/png;base64...)

A corresponding barplot can be obtained through the `StateQuantificationPlot` or the `SingleTFStateQuantificationPlot` which hard-codes the `states` parameter.

```
StateQuantificationPlot(SortedReads = SortedReads, states = SingleTFStates())
```

![](data:image/png;base64...)

## Sorting by TF clusters

Similarly to single TFs, sorting by TF motif clusters requires designing bins. Here we draw a [-7;+7] bin around each TF motif, a [-35;-25] bin relative to the most upstream TF motif and a [+25,+35] bin relative to the center of the most downstream TFBS, for a total of \(n+2\) bins, with \(n\) being the number of TF motifs.
Here we exemplify the process manually for clarity.

```
RegionOfInterest = GRanges("chr6", IRanges(88106000, 88106500))
Methylation = qs::qread(system.file("extdata", "Methylation_4.qs", package="SingleMoleculeFootprinting"))
TFBSs = qs::qread(system.file("extdata", "TFBSs_1.qs", package="SingleMoleculeFootprinting"))

motif_center_1 = start(IRanges::resize(TFBSs[1], 1, "center"))
motif_center_2 = start(IRanges::resize(TFBSs[2], 1, "center"))
SortingBins = c(
  GRanges("chr6", IRanges(motif_center_1-35, motif_center_1-25)),
  GRanges("chr6", IRanges(motif_center_1-7, motif_center_1+7)),
  GRanges("chr6", IRanges(motif_center_2-7, motif_center_2+7)),
  GRanges("chr6", IRanges(motif_center_2+25, motif_center_2+35))
)

PlotAvgSMF(
  MethGR = Methylation[[1]], RegionOfInterest = RegionOfInterest, TFBSs = TFBSs, SortingBins = SortingBins
)
## No sorted reads passed...plotting counts from all reads
```

![](data:image/png;base64...)

Sorting molecules involves averaging, for each molecule, the binary methylation values for the cytosines overlapping those bins.
Reducing those averages to integers summarises each molecule to three binary digits.
We sort and plot molecules based on these digits.
The whole process is wrapped in the `SortReadsByTFCluster` function.

```
SortedReads = SortReadsByTFCluster(MethSM = Methylation[[2]], TFBS_cluster = TFBSs)
## Sorting TFBSs by genomic coordinates
## Designing sorting bins
## Collecting summarized methylation for bins
## Subsetting those reads that cover all bins
## Summarizing reads into patterns
## Splitting reads by pattern
```

N.b.: custom bins can be used by through the argument `bins`.

The function returns a list with one item per sample.
Each of these is itself a list of up to 16 items, one per possible combination of three binary digits, i.e. 0000, 0001, 0010, etc.
Each of these items contains the IDs of the molecules sorted.
N.b.: patterns with 0 molecules will not be reported.

```
lapply(SortedReads$SMF_MM_TKO_DE_, head, 2)
## $`0000`
## [1] "D00404:273:H5757BCXY:2:1208:11811:79680"
## [2] "D00404:283:HCFT7BCXY:1:2215:2273:66163"
##
## $`0001`
## [1] "D00404:273:H5757BCXY:2:2112:17179:78420"
## [2] "D00404:283:HCFT7BCXY:1:1110:19551:78460"
##
## $`0101`
## [1] "NB501735:34:H32KCBGX3:3:12504:23493:4814"
##
## $`0111`
## [1] "D00404:273:H5757BCXY:2:2106:19859:63697"
## [2] "NB501735:34:H32KCBGX3:4:11405:8733:10957"
##
## $`1000`
## [1] "NB501735:34:H32KCBGX3:1:21111:15939:10193"
## [2] "NB501735:34:H32KCBGX3:1:21207:15670:17600"
##
## $`1001`
## [1] "D00404:273:H5757BCXY:1:1102:14949:3420"
## [2] "D00404:273:H5757BCXY:1:1205:4416:100764"
##
## $`1010`
## [1] "D00404:283:HCFT7BCXY:1:2106:8461:79305"
## [2] "D00404:283:HCFT7BCXY:1:2210:13980:37090"
##
## $`1011`
## [1] "D00404:273:H5757BCXY:1:1102:20457:73436"
## [2] "D00404:273:H5757BCXY:1:1110:7624:25325"
##
## $`1100`
## [1] "NB501735:9:HLG5VBGX2:1:11204:8511:6241"
## [2] "NB501735:9:HLG5VBGX2:2:13209:15843:20165"
##
## $`1101`
## [1] "D00404:273:H5757BCXY:1:1211:14401:50622"
## [2] "D00404:273:H5757BCXY:2:1101:1697:87040"
##
## $`1110`
## [1] "D00404:273:H5757BCXY:1:1215:8843:22685"
## [2] "D00404:273:H5757BCXY:2:1103:16878:7787"
##
## $`1111`
## [1] "D00404:273:H5757BCXY:2:1102:9323:16615"
## [2] "D00404:273:H5757BCXY:2:1107:2792:41093"
```

The number of molecules per pattern can be checked using `lenghts`.

```
lengths(SortedReads$SMF_MM_TKO_DE_)
## 0000 0001 0101 0111 1000 1001 1010 1011 1100 1101 1110 1111
##    7    9    1    5    5   71    4   40    3   19    9   41
```

Here most molecules show the 1001 pattern.

These patterns are not immediately human readable. For convenience we hard-coded a biological interpretation in the function `SingleTFStates`.

```
TFPairStates()
## $bound_bound
## bound_bound
##      "1001"
##
## $misc_bound
## unassigned_bound accessible_bound
##           "0101"           "1101"
##
## $bound_misc
## bound_unassigned bound_accessible
##           "1010"           "1011"
##
## $misc
## nucleosome_nucleosome      bound_nucleosome unassigned_nucleosome
##                "0000"                "1000"                "0100"
## accessible_nucleosome nucleosome_unassigned unassigned_unassigned
##                "1100"                "0010"                "0110"
## accessible_unassigned      nucleosome_bound nucleosome_accessible
##                "1110"                "0001"                "0011"
## unassigned_accessible accessible_accessible
##                "0111"                "1111"
```

This function can be used together with the function `StateQuantification`, to compute the frequencies of the biological states associated with single TF binding.
The function `StateQuantificationByTFPair` hard-codes the `states` argument for convenience.

```
StateQuantification(SortedReads = SortedReads, states = TFPairStates())
## # A tibble: 4 × 4
##   Sample         State       Counts Freqs
##   <chr>          <chr>        <int> <dbl>
## 1 SMF_MM_TKO_DE_ bound_bound     71 33.2
## 2 SMF_MM_TKO_DE_ misc_bound      20  9.35
## 3 SMF_MM_TKO_DE_ bound_misc      44 20.6
## 4 SMF_MM_TKO_DE_ misc            79 36.9
```

Sorted molecules can be visualized with the `PlotSM` function.

```
PlotSM(MethSM = Methylation[[2]], RegionOfInterest = RegionOfInterest, sorting.strategy = "classical", SortedReads = SortedReads)
## Arranging reads according to classical sorting.strategy
## Inferring sorting was performed by TF pair
```

![](data:image/png;base64...)

A corresponding barplot can be obtained through the `StateQuantificationPlot` or the `TFPairStateQuantificationPlot` which hard-codes the `states` parameter.

```
StateQuantificationPlot(SortedReads = SortedReads, states = TFPairStates())
```

![](data:image/png;base64...)

## Genome-wide wrappers

Performing genome-wide single molecule sorting involves calling methylation at the single molecule level for multiple loci of interest.
Let’s say we wanted to sort single molecules around the first 500 bound KLF4 motifs in chr19.

```
KLF4s = qs::qread(system.file("extdata", "KLF4_chr19.qs", package="SingleMoleculeFootprinting"))
KLF4s
## GRanges object with 500 ranges and 0 metadata columns:
##                 seqnames          ranges strand
##                    <Rle>       <IRanges>  <Rle>
##   TFBS_10755077    chr19 3283483-3283492      +
##   TFBS_10755111    chr19 3297310-3297319      +
##   TFBS_10755159    chr19 3322114-3322123      +
##   TFBS_10755163    chr19 3324079-3324088      +
##   TFBS_10755168    chr19 3325484-3325493      +
##             ...      ...             ...    ...
##   TFBS_10761853    chr19 5990580-5990589      +
##   TFBS_10761855    chr19 5991634-5991643      +
##   TFBS_10761874    chr19 6001105-6001114      +
##   TFBS_10761879    chr19 6003358-6003367      +
##   TFBS_10761890    chr19 6010914-6010923      +
##   -------
##   seqinfo: 66 sequences (1 circular) from mm10 genome
```

Iterating linearly (or in parallel) across several hundreds of thousands of loci can take an impractically long time. This is why we prefer to call methylation at the single molecule level for up to Mb large genomic windows, for which memory requirements are still compatible with most computational infrastructures.
The function `Create_MethylationCallingWindows` outputs a GRanges of large methylation calling windows encompassing multiple of the loci of interest passed as input.

```
Create_MethylationCallingWindows(RegionsOfInterest = KLF4s)
## Group TFBS_clusters that fall within 1e+05bp from each other in broader searching windows
## Trimming searching windows
## GRanges object with 2 ranges and 0 metadata columns:
##       seqnames          ranges strand
##          <Rle>       <IRanges>  <Rle>
##   [1]    chr19 3283188-5166083      *
##   [2]    chr19 5272307-6011218      *
##   -------
##   seqinfo: 66 sequences (1 circular) from mm10 genome
```

Used with default parameters, the function minimizes the number of methylation calling windows in output. The parameters `max_intercluster_distance`, `max_window_width` and `min_cluster_width` can be tuned to customise this behavior.

However, sometimes this leads to highly disproportionate windows, very few of which will overlap with most of the `RegionsOfInterest`. This in turn might cause disproportionate resource allocations during subsequent computations.
This is why the function can forced to output methylation calling windows encompassing an even number of RegionsOfInterest. The parameters `fix.window.size` and `max.window.size` can be used to tune this behavior.

```
Create_MethylationCallingWindows(
  RegionsOfInterest = KLF4s,
  fix.window.size = TRUE, max.window.size = 50
  )
## GRanges object with 10 ranges and 0 metadata columns:
##        seqnames          ranges strand
##           <Rle>       <IRanges>  <Rle>
##    [1]    chr19 3283482-3859342      *
##    [2]    chr19 3864777-4099977      *
##    [3]    chr19 4099997-4228150      *
##    [4]    chr19 4229736-4732743      *
##    [5]    chr19 4748703-5059079      *
##    [6]    chr19 5060902-5375826      *
##    [7]    chr19 5378076-5559346      *
##    [8]    chr19 5560673-5729717      *
##    [9]    chr19 5731830-5924274      *
##   [10]    chr19 5924647-6010924      *
##   -------
##   seqinfo: 66 sequences from an unspecified genome; no seqlengths
```

In case of single molecule sorting by TFBS clusters, it is useful to define the motif clusters ahead of the generation of methylation calling windows.
The function `Arrange_TFBSs_clusters` groups TF motifs by proximity and returns two objects:
`ClusterCoordinates`, which can be input directly to `Create_MethylationCallingWindows` `ClusterComposition` which can be fed to one of the single molecule sorting functions.

```
KLF4_clusters = Arrange_TFBSs_clusters(TFBSs = KLF4s)
## Removing self-overlaps and redundant pairs
## Removing pairs containing overlapping factors
## Constructing GRanges object of clusters coordinates
## Computing number of sites per cluster
## Discaring clusters with more than 6sites
## Creating TFBS_cluster ID on the fly
## Constructing GRangesList of sites per cluster
KLF4_clusters$ClusterCoordinates
## GRanges object with 35 ranges and 1 metadata column:
##                   seqnames          ranges strand | number_of_TF
##                      <Rle>       <IRanges>  <Rle> |    <integer>
##    TFBS_cluster_1    chr19 3325484-3325561      * |            2
##    TFBS_cluster_2    chr19 3388255-3388309      * |            3
##    TFBS_cluster_3    chr19 3849423-3849460      * |            2
##    TFBS_cluster_4    chr19 3972615-3972680      * |            2
##    TFBS_cluster_5    chr19 3986414-3986443      * |            2
##               ...      ...             ...    ... .          ...
##   TFBS_cluster_31    chr19 5803543-5803591      * |            2
##   TFBS_cluster_32    chr19 5806798-5806826      * |            3
##   TFBS_cluster_33    chr19 5850440-5850490      * |            2
##   TFBS_cluster_34    chr19 5875053-5875079      * |            2
##   TFBS_cluster_35    chr19 5990562-5990589      * |            2
##   -------
##   seqinfo: 66 sequences from an unspecified genome; no seqlengths
KLF4_clusters$ClusterComposition
## GRangesList object of length 35:
## $TFBS_cluster_1
## GRanges object with 2 ranges and 0 metadata columns:
##                 seqnames          ranges strand
##                    <Rle>       <IRanges>  <Rle>
##   TFBS_10755168    chr19 3325484-3325493      +
##   TFBS_10755169    chr19 3325552-3325561      +
##   -------
##   seqinfo: 66 sequences (1 circular) from mm10 genome
##
## $TFBS_cluster_2
## GRanges object with 3 ranges and 0 metadata columns:
##                 seqnames          ranges strand
##                    <Rle>       <IRanges>  <Rle>
##   TFBS_10755331    chr19 3388255-3388264      +
##   TFBS_10755332    chr19 3388280-3388289      +
##   TFBS_10755334    chr19 3388300-3388309      +
##   -------
##   seqinfo: 66 sequences (1 circular) from mm10 genome
##
## $TFBS_cluster_3
## GRanges object with 2 ranges and 0 metadata columns:
##                 seqnames          ranges strand
##                    <Rle>       <IRanges>  <Rle>
##   TFBS_10756428    chr19 3849423-3849432      +
##   TFBS_10756431    chr19 3849451-3849460      +
##   -------
##   seqinfo: 66 sequences (1 circular) from mm10 genome
##
## ...
## <32 more elements>
```

The function can be tuned using the parameters `max_intersite_distance`, `min_intersite_distance`, `max_cluster_size` and `max_cluster_width`.

Finally, we provide two convenience wrappers to conduct genome-wide single molecule sorting: `SortReadsBySingleTF_MultiSiteWrapper` and `SortReadsByTFCluster_MultiSiteWrapper`.
Both functions automate the tasks of arranging TFBSs into clusters (if necessary), creating methylation calling windows, calling methylation, sorting molecules and calculating state frequencies.
The relevant arguments of all the inner functions are available for tuning.

```
SortReadsBySingleTF_MultiSiteWrapper(
  sampleFile = "/g/krebs/barzaghi/HTS/SMF/MM/QuasR_input_files/QuasR_input_AllCanWGpooled_dprm_DE_only.txt",
  samples = "SMF_MM_TKO_DE_",
  genome = BSgenome.Mmusculus.UCSC.mm10,
  coverage = 20, ConvRate.thr = NULL,
  CytosinesToMask = NULL,
  TFBSs = KLF4s,
  max_interTF_distance = NULL, max_window_width = NULL, min_cluster_width = NULL,
  fix.window.size = TRUE, max.window.size = 50,
  cores = 4
) -> sorting_results
```

The function outputs a list of three objects: the TFBSs (or TFBS clusters) used to sort, sorted molecules and a data.frame with sorting results.

```
sorting_results = qs::qread(system.file("extdata", "gw_sorting.qs", package="SingleMoleculeFootprinting"))
sorting_results[[1]]
## GRanges object with 500 ranges and 0 metadata columns:
##            seqnames          ranges strand
##               <Rle>       <IRanges>  <Rle>
##     TFBS_1    chr19 3283483-3283492      +
##     TFBS_2    chr19 3297310-3297319      +
##     TFBS_3    chr19 3322114-3322123      +
##     TFBS_4    chr19 3324079-3324088      +
##     TFBS_5    chr19 3325484-3325493      +
##        ...      ...             ...    ...
##   TFBS_496    chr19 5990580-5990589      +
##   TFBS_497    chr19 5991634-5991643      +
##   TFBS_498    chr19 6001105-6001114      +
##   TFBS_499    chr19 6003358-6003367      +
##   TFBS_500    chr19 6010914-6010923      +
##   -------
##   seqinfo: 66 sequences (1 circular) from mm10 genome
# sorting_results[[2]]
sorting_results[[3]]
## # A tibble: 1,165 × 5
##    Sample         State Counts  Freqs TFBS_cluster
##    <chr>          <chr>  <int>  <dbl> <chr>
##  1 <NA>           <NA>      NA NA     TFBS_1
##  2 <NA>           <NA>      NA NA     TFBS_2
##  3 SMF_MM_TKO_DE_ 000      112 44.3   TFBS_3
##  4 SMF_MM_TKO_DE_ 001       12  4.74  TFBS_3
##  5 SMF_MM_TKO_DE_ 010        6  2.37  TFBS_3
##  6 SMF_MM_TKO_DE_ 011        2  0.791 TFBS_3
##  7 SMF_MM_TKO_DE_ 100       62 24.5   TFBS_3
##  8 SMF_MM_TKO_DE_ 101        4  1.58  TFBS_3
##  9 SMF_MM_TKO_DE_ 110       41 16.2   TFBS_3
## 10 SMF_MM_TKO_DE_ 111       14  5.53  TFBS_3
## # ℹ 1,155 more rows
```

The function `SortReadsByTFCluster_MultiSiteWrapper` works analogously, with the addition of arranging TFBS clusters according to parameters

```
SortReadsByTFCluster_MultiSiteWrapper(
  ...,
  max_intersite_distance = , min_intersite_distance = , max_cluster_size = , max_cluster_width = ,
  ...
)
```

## sessionInfo

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
## [1] parallel  stats4    stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] BSgenome.Mmusculus.UCSC.mm10_1.4.3    BSgenome_1.78.0
##  [3] rtracklayer_1.70.0                    BiocIO_1.20.0
##  [5] Biostrings_2.78.0                     XVector_0.50.0
##  [7] SingleMoleculeFootprintingData_1.17.0 lubridate_1.9.4
##  [9] forcats_1.0.1                         stringr_1.5.2
## [11] dplyr_1.1.4                           purrr_1.1.0
## [13] readr_2.1.5                           tidyr_1.3.1
## [15] tibble_3.3.0                          ggplot2_4.0.0
## [17] tidyverse_2.0.0                       GenomicRanges_1.62.0
## [19] Seqinfo_1.0.0                         IRanges_2.44.0
## [21] S4Vectors_0.48.0                      BiocGenerics_0.56.0
## [23] generics_0.1.4                        SingleMoleculeFootprinting_2.4.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3          jsonlite_2.0.0
##   [3] magrittr_2.0.4              GenomicFeatures_1.62.0
##   [5] farver_2.1.2                rmarkdown_2.30
##   [7] vctrs_0.6.5                 memoise_2.0.1
##   [9] Rsamtools_2.26.0            RCurl_1.98-1.17
##  [11] QuasR_1.50.0                ggpointdensity_0.2.0
##  [13] htmltools_0.5.8.1           S4Arrays_1.10.0
##  [15] progress_1.2.3              AnnotationHub_4.0.0
##  [17] curl_7.0.0                  SparseArray_1.10.0
##  [19] sass_0.4.10                 bslib_0.9.0
##  [21] httr2_1.2.1                 cachem_1.1.0
##  [23] GenomicAlignments_1.46.0    lifecycle_1.0.4
##  [25] pkgconfig_2.0.3             Matrix_1.7-4
##  [27] R6_2.6.1                    fastmap_1.2.0
##  [29] MatrixGenerics_1.22.0       digest_0.6.37
##  [31] miscTools_0.6-28            ShortRead_1.68.0
##  [33] patchwork_1.3.2             AnnotationDbi_1.72.0
##  [35] ExperimentHub_3.0.0         RSQLite_2.4.3
##  [37] hwriter_1.3.2.1             labeling_0.4.3
##  [39] filelock_1.0.3              timechange_0.3.0
##  [41] httr_1.4.7                  abind_1.4-8
##  [43] compiler_4.5.1              Rbowtie_1.50.0
##  [45] bit64_4.6.0-1               withr_3.0.2
##  [47] S7_0.2.0                    BiocParallel_1.44.0
##  [49] viridis_0.6.5               DBI_1.2.3
##  [51] qs_0.27.3                   biomaRt_2.66.0
##  [53] rappdirs_0.3.3              DelayedArray_0.36.0
##  [55] rjson_0.2.23                tools_4.5.1
##  [57] glue_1.8.0                  restfulr_0.0.16
##  [59] grid_4.5.1                  cluster_2.1.8.1
##  [61] gtable_0.3.6                tzdb_0.5.0
##  [63] RApiSerialize_0.1.4         hms_1.1.4
##  [65] utf8_1.2.6                  stringfish_0.17.0
##  [67] BiocVersion_3.22.0          ggrepel_0.9.6
##  [69] pillar_1.11.1               vroom_1.6.6
##  [71] BiocFileCache_3.0.0         lattice_0.22-7
##  [73] bit_4.6.0                   deldir_2.0-4
##  [75] tidyselect_1.2.1            knitr_1.50
##  [77] gridExtra_2.3               SummarizedExperiment_1.40.0
##  [79] xfun_0.53                   Biobase_2.70.0
##  [81] matrixStats_1.5.0           stringi_1.8.7
##  [83] UCSC.utils_1.6.0            yaml_2.3.10
##  [85] evaluate_1.0.5              codetools_0.2-20
##  [87] cigarillo_1.0.0             interp_1.1-6
##  [89] GenomicFiles_1.46.0         archive_1.1.12
##  [91] BiocManager_1.30.26         cli_3.6.5
##  [93] RcppParallel_5.1.11-1       jquerylib_0.1.4
##  [95] dichromat_2.0-0.1           Rcpp_1.1.0
##  [97] GenomeInfoDb_1.46.0         dbplyr_2.5.1
##  [99] png_0.1-8                   XML_3.99-0.19
## [101] blob_1.2.4                  prettyunits_1.2.0
## [103] latticeExtra_0.6-31         jpeg_0.1-11
## [105] parallelDist_0.2.7          plyranges_1.30.0
## [107] bitops_1.0-9                pwalign_1.6.0
## [109] txdbmaker_1.6.0             viridisLite_0.4.2
## [111] VariantAnnotation_1.56.0    scales_1.4.0
## [113] crayon_1.5.3                rrapply_1.2.7
## [115] rlang_1.1.6                 KEGGREST_1.50.0
```