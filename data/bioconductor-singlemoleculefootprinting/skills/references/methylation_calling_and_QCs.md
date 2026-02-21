# methylation\_calling\_and\_QCs

## Introduction

*SingleMoleculeFootprinting* is an R package for Single Molecule Footprinting (SMF) data.

Starting from an aligned bam file, we show how to

* perform sequencing QCs
* call methylation in bulk and at single molecule level
* perform single molecule TF sorting as per [Sönmezer et al., 2021](https://doi.org/10.1016/j.molcel.2020.11.015) and [Kleinendorst & Barzaghi et al., 2021](https://doi.org/10.1038/s41596-021-00630-1)
* plot SMF
* run genome-wide analyses
* run *FootprintCharter* as per Baderna & Barzaghi et al., 2024 and Barzaghi et al., 2024

For installation, the user can use the following:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("SingleMoleculeFootprinting")
```

For compatibility with our analysis tools, we recommend the user to perform genomic alignments using the [`qAlign`](https://www.rdocumentation.org/packages/QuasR/versions/1.12.0/topics/qAlign) function from *QuasR* as exemplified in the chunk below.
For detailed pre-processing instructions we refer to steps 179 to 186 of [Kleinendorst & Barzaghi et al., 2021](https://doi.org/10.1038/s41596-021-00630-1)

```
clObj <- makeCluster(40)
prj <- QuasR::qAlign(
  sampleFile = sampleFile,
  genome = "BSgenome.Mmusculus.UCSC.mm10",
  aligner = "Rbowtie",
  projectName = "prj",
  paired = "fr",
  bisulfite = "undir",
  alignmentParameter = "-e 70 -X 1000 -k 2 --best -strata",
  alignmentsDir = "./",
  cacheDir = tempdir(),
  clObj = clObj
  )
stopCluster(clObj)
```

## Loading libraries

```
suppressWarnings(library(SingleMoleculeFootprinting))
suppressWarnings(library(SingleMoleculeFootprintingData))
suppressWarnings(library(BSgenome.Mmusculus.UCSC.mm10))
suppressWarnings(library(parallel))
suppressWarnings(library(ggplot2))
```

## Prepare inputs

*SingleMoleculeFootprinting* inherits *QuasR*’s `sampleFile` style of feeding *.bam* files. For instructions, refer to the `qAlign` [documentation](https://www.rdocumentation.org/packages/QuasR/versions/1.12.0/topics/qAlign). Here we show how our sampleFile looks like.
N.b.: This vignette and some functions of *SingleMoleculeFootprinting* depend on data available through the data package *SingleMoleculeFootprintingData*.
For user-friendliness, this data is fetched during the installation of *SingleMoleculeFootprinting* and stored in `tempdir()`.
Please make sure that `tempdir()` has enough storage capacity (~1 Gb). You can check this by running `ExperimentHub::getExperimentHubOption(arg = "CACHE")` and if needed change the location by running `ExperimentHub::setExperimentHubOption(arg = "CACHE", value = "/your/favourite/location")`.

```
sampleFile = paste0(CacheDir, "/NRF1Pair_sampleFile.txt")
knitr::kable(suppressMessages(readr::read_delim(sampleFile, delim = "\t")))
```

| FileName | SampleName |
| --- | --- |
| /home/biocbuild/.cache/R/ExperimentHub/NRF1pair.bam | NRF1pair\_DE\_ |

## Library QCs

### QuasR QC report

For generic sequencing QCs, we refer to *QuasR*’s [`qQCreport`](https://www.rdocumentation.org/packages/QuasR/versions/1.12.0/topics/qQCReport).

### Bait capture efficiency

If a bait capture step was included to enrich for regulatory regions, it is useful to check how efficiently that worked.
Here we calculate the ratio of molecules overlapping the enrichment targets over the total. A Bait capture efficiency below 70% might be problematic.
In that case we refer to the *troubleshooting* section of our [Kleinendorst & Barzaghi et al., 2021](https://doi.org/10.1038/s41596-021-00630-1).

```
BaitRegions <- SingleMoleculeFootprintingData::EnrichmentRegions_mm10.rds()
clObj = makeCluster(4)
BaitCapture(
  sampleFile = sampleFile,
  genome = BSgenome.Mmusculus.UCSC.mm10,
  baits = BaitRegions,
  clObj = clObj
) -> BaitCaptureEfficiency
stopCluster(clObj)
```

### Conversion rate accuracy

The bisulfite conversion step, chemically converts un-methylated cytosines to thymines. This process has a margin of error.
Here we ask what is the percentage of converted cytosines among those which shouldn’t be methylated, i.e. those outside of *CpG* or *GpC* contexts. Normally, we expect a conversion rate of ~95%.
N.b.: this function runs much slower than the one above, which is why we prefer to check this metric for chr19 only.

```
ConversionRate(
  sampleFile = sampleFile,
  genome = BSgenome.Mmusculus.UCSC.mm10,
  chr = 19
) -> ConversionRateValue
```

### Methylation rate sample correlation (high coverage)

It is useful to compare the distribution of cytosine methylation rates across replicates.

```
RegionOfInterest = GRanges(BSgenome.Mmusculus.UCSC.mm10@seqinfo["chr19"])

CallContextMethylation(
  sampleFile = sampleFile,
  samples = samples,
  genome = BSgenome.Mmusculus.UCSC.mm10,
  RegionOfInterest = RegionOfInterest,
  coverage = 20,
  ConvRate.thr = NULL,
  returnSM = FALSE,
  clObj = NULL,
  verbose = FALSE
  ) -> Methylation

Methylation %>%
  elementMetadata() %>%
  as.data.frame() %>%
  dplyr::select(grep("_MethRate", colnames(.))) -> MethylationRate_matrix

png("../inst/extdata/MethRateCorr_AllCs.png", units = "cm", res = 100, width = 20, height = 20)
pairs(
  MethylationRate_matrix,
  upper.panel = panel.cor,
  diag.panel = panel.hist,
  lower.panel = panel.jet,
  labels = gsub("SMF_MM_|DE_|_MethRate", "", colnames(MethylationRate_matrix))
  )
dev.off()
```

```
knitr::include_graphics(system.file("extdata", "MethRateCorr_AllCs.png", package="SingleMoleculeFootprinting"))
```

![](data:image/png;base64...)

It is also useful, especially in the case of single enzyme treatments, to split the genomics contexts of cytosines based on the MTase used.

```
Methylation %>%
  elementMetadata() %>%
  as.data.frame() %>%
  filter(GenomicContext %in% c("DGCHN", "GCH")) %>%
  dplyr::select(grep("_MethRate", colnames(.))) -> MethylationRate_matrix_GCH

png("../inst/extdata/MethRateCorr_GCHs.png", units = "cm", res = 100, width = 20, height = 20)
pairs(MethylationRate_matrix_GCH, upper.panel = panel.cor, diag.panel = panel.hist, lower.panel = panel.jet, labels = colnames(MethylationRate_matrix_GCH))
dev.off()

Methylation %>%
  elementMetadata() %>%
  as.data.frame() %>%
  filter(GenomicContext %in% c("NWCGW", "HCG")) %>%
  dplyr::select(grep("_MethRate", colnames(.))) -> MethylationRate_matrix_HCG

png("../inst/extdata/MethRateCorr_HCGs.png", units = "cm", res = 100, width = 20, height = 20)
pairs(MethylationRate_matrix_HCG, upper.panel = panel.cor, diag.panel = panel.hist, lower.panel = panel.jet, labels = colnames(MethylationRate_matrix_HCG))
dev.off()
```

```
knitr::include_graphics(system.file("extdata", "MethRateCorr_GCHs.png", package="SingleMoleculeFootprinting"))
```

![](data:image/png;base64...)

```
knitr::include_graphics(system.file("extdata", "MethRateCorr_HCGs.png", package="SingleMoleculeFootprinting"))
```

![](data:image/png;base64...)

### Methylation rate sample correlation (low coverage)

Before investing in deep sequencing, it is advisable to shallowly sequence libraries to assess the footprinting quality of the libraries.
However the per-cytosine coverage obtained at shallow sequencing is insufficient to estimate methylation rates for individual cytosines.
A solution is to pile up molecules covering cytosines from genomic loci that are known to behave similarly and compute a “composite” methylation rate.
Such composite methylation rate allows to assess the quality of footprinting at low coverage.

The following chunk exemplifies how to proceed.
First we want to call methylation for the new low depth samples, paying attention to setting the parameter `coverage=1`.
Then we want to call methylation for a reference high coverage sample.
Finally, we can use the wrapper function `CompositeMethylationCorrelation` to extract composite methylation rates.
N.b.: the methylation calling step is quite computationally demanding for full genomes, so we ran this in the background and reported the results only.

```
RegionOfInterest = GRanges(BSgenome.Mmusculus.UCSC.mm10@seqinfo["chr19"])

CallContextMethylation(
  sampleFile = sampleFile_LowCoverage,
  samples = samples_LowCoverage,
  genome = BSgenome.Mmusculus.UCSC.mm10,
  RegionOfInterest = RegionOfInterest,
  coverage = 1,
  ConvRate.thr = NULL,
  returnSM = FALSE,
  clObj = NULL,
  verbose = FALSE
  )$DGCHN -> LowCoverageMethylation

CallContextMethylation(
  sampleFile = sampleFile_HighCoverage_reference,
  samples = samples_HighCoverage_reference,
  genome = BSgenome.Mmusculus.UCSC.mm10,
  RegionOfInterest = RegionOfInterest,
  coverage = 20,
  ConvRate.thr = NULL,
  returnSM = FALSE,
  clObj = NULL,
  verbose = FALSE
  )$DGCHN -> HighCoverageMethylation

CompositeMethylationCorrelation(
  LowCoverage = LowCoverageMethylation,
  LowCoverage_samples = samples_LowCoverage,
  HighCoverage = HighCoverageMethylation,
  HighCoverage_samples = samples_HighCoverage_reference,
  bins = 50,
  returnDF = TRUE,
  returnPlot = TRUE,
  RMSE = TRUE,
  return_RMSE_DF = TRUE,
  return_RMSE_plot = TRUE
  ) -> results
```

The methylation distribution plot reveals that replicates SMF\_MM\_NP\_NO\_R3\_MiSeq and SMF\_MM\_NP\_NO\_R3\_MiSeq deviate fairly from the reference high coverage sample.

```
results <- qs::qread(system.file("extdata", "low_coverage_methylation_correlation.qs",
                                 package="SingleMoleculeFootprinting"))
results$MethylationDistribution_plot +
  scale_color_manual(
    values = c("#00BFC4", "#00BFC4", "#00BFC4", "#F8766D", "#F8766D"),
    breaks = c("SMF_MM_TKO_as_NO_R_NextSeq", "SMF_MM_NP_NO_R1_MiSeq", "SMF_MM_NP_NO_R2_MiSeq",
               "SMF_MM_NP_NO_R3_MiSeq", "SMF_MM_NP_NO_R4_MiSeq"))
## NULL
```

The root mean square error plot quantifies this deviation confirming the poorer quality of these replicates.

```
results$RMSE_plot +
  geom_bar(aes(fill = Sample), stat = "identity") +
  scale_fill_manual(
    values = c("#00BFC4", "#00BFC4", "#00BFC4", "#F8766D", "#F8766D"),
    breaks = c("SMF_MM_TKO_as_NO_R_NextSeq", "SMF_MM_NP_NO_R1_MiSeq", "SMF_MM_NP_NO_R2_MiSeq",
               "SMF_MM_NP_NO_R3_MiSeq", "SMF_MM_NP_NO_R4_MiSeq"))
## NULL
```

## Single locus analysis

### Methylation calling

The function `CallContextMethylation` provides a high-level wrapper to go from alignments to average per-cytosine methylation rates (bulk level) and single molecule methylation matrix.
Under the hood, the function performs the following operations:

* Filter reads by conversion rate (apply only if strictly necessary)
* Collapse strands to increase coverage
* Filter cytosines by coverage
* Filter cytosines in relevant genomic context (based on enzymatic treatment). The type of the experiment should be provided by the user in the form of a sub-string to be included in *SampleName* field of the QuasR *sampleFile* as follows

| ExperimentType | substring | RelevanContext | Notes |
| --- | --- | --- | --- |
| Single enzyme SMF | \_NO\_ | DGCHN & NWCGW | Methylation info is reported separately for each context |
| Double enzyme SMF | \_DE\_ | GCH + HCG | Methylation information is aggregated across the contexts |
| No enzyme (endogenous mCpG only) | \_SS\_ | CG | - |

```
samples <- suppressMessages(unique(readr::read_delim(sampleFile, delim = "\t")$SampleName))
RegionOfInterest <- GRanges("chr6", IRanges(88106000, 88106500))

CallContextMethylation(
  sampleFile = sampleFile,
  samples = samples,
  genome = BSgenome.Mmusculus.UCSC.mm10,
  RegionOfInterest = RegionOfInterest,
  coverage = 20,
  returnSM = FALSE,
  ConvRate.thr = NULL,
  verbose = TRUE,
  clObj = NULL # N.b.: when returnSM = TRUE, clObj should be set to NULL
  ) -> Methylation
## Setting QuasR project
## all necessary alignment files found
## Calling methylation at all Cytosines
## checking if RegionOfInterest contains information at all
## Discard immediately the cytosines not covered in any sample
## Subsetting Cytosines by permissive genomic context (GC, HCG)
## Collapsing strands
## Filtering Cs for coverage
## Detected experiment type: DE
## Subsetting Cytosines by strict genomic context (GCH, GCG, HCG) based on the detected experiment type: DE
## Merging matrixes
```

The output messages can be suppressed setting the argument `verbose=FALSE`.

`CallContextMethylation` returns a `GRanges` object summarizing the methylation rate (bulk) at each cytosine (one cytosine per row)

```
head(Methylation)
## GRanges object with 6 ranges and 3 metadata columns:
##       seqnames    ranges strand | NRF1pair_DE__Coverage NRF1pair_DE__MethRate
##          <Rle> <IRanges>  <Rle> |             <integer>             <numeric>
##   [1]     chr6  88106098      + |                  5323              0.866992
##   [2]     chr6  88106113      + |                  5319              0.741117
##   [3]     chr6  88106115      + |                  5322              0.897595
##   [4]     chr6  88106119      + |                  5322              0.838407
##   [5]     chr6  88106126      + |                  5321              0.543319
##   [6]     chr6  88106139      + |                  5322              0.400601
##       GenomicContext
##          <character>
##   [1]            GCH
##   [2]            GCG
##   [3]            GCG
##   [4]            GCH
##   [5]            HCG
##   [6]            GCH
##   -------
##   seqinfo: 239 sequences (1 circular) from mm10 genome
```

When `returnSM=TRUE`, `Methylation` additionally returns a list of sparse single molecule methylation matrixes, one per sample

```
CallContextMethylation(
  sampleFile = sampleFile,
  samples = samples,
  genome = BSgenome.Mmusculus.UCSC.mm10,
  RegionOfInterest = RegionOfInterest,
  coverage = 20,
  returnSM = TRUE,
  ConvRate.thr = NULL,
  verbose = FALSE,
  clObj = NULL # N.b.: when returnSM = TRUE, clObj should be set to NULL
  ) -> Methylation
## all necessary alignment files found
## 5334 reads found mapping to the - strand, collapsing to +
## 5334 reads found mapping to the - strand, collapsing to +
## Detected experiment type: DE

Methylation[[2]]$NRF1pair_DE_[1:10,20:30]
## 10 x 11 sparse Matrix of class "dgCMatrix"
##   [[ suppressing 11 column names '88106236', '88106240', '88106243' ... ]]
##
## M00758:819:000000000-CB7NB:1:1101:10081:9865  1 2 1 2 1 1 1 1 1 . 2
## M00758:819:000000000-CB7NB:1:1101:10119:12887 1 1 1 1 1 1 1 1 1 . 2
## M00758:819:000000000-CB7NB:1:1101:10172:5248  2 1 1 1 1 1 1 1 1 . 1
## M00758:819:000000000-CB7NB:1:1101:10214:24193 2 1 1 2 1 1 2 1 1 1 1
## M00758:819:000000000-CB7NB:1:1101:10219:24481 2 2 1 2 2 2 2 2 2 . 2
## M00758:819:000000000-CB7NB:1:1101:10408:27375 2 2 1 2 2 2 2 2 2 2 2
## M00758:819:000000000-CB7NB:1:1101:10428:10873 2 2 2 2 2 2 2 2 2 2 2
## M00758:819:000000000-CB7NB:1:1101:10428:22900 2 2 2 2 2 2 2 2 2 2 2
## M00758:819:000000000-CB7NB:1:1101:10453:11606 2 2 2 1 1 1 1 1 1 1 2
## M00758:819:000000000-CB7NB:1:1101:10489:13730 1 2 1 1 1 1 1 1 1 . 2
```

### Plotting single sites

Before moving to single molecule analysis, it is useful to plot the SMF signal in bulk (1 - *methylation rate*), using the function `PlotAvgSMF`.

```
PlotAvgSMF(
  MethGR = Methylation[[1]],
  RegionOfInterest = RegionOfInterest
  )
## No sorted reads passed...plotting counts from all reads
```

![](data:image/png;base64...)

It is possible add information to this plot such as the genomic context of cytosines.

```
PlotAvgSMF(
  MethGR = Methylation[[1]],
  RegionOfInterest = RegionOfInterest,
  ShowContext = TRUE
  )
## No sorted reads passed...plotting counts from all reads
```

![](data:image/png;base64...)

The user can also plot annotated TF binding sites by feeding the argument *TFBSs* with a *GRanges* object.
N.b.: the GRanges should contain at least one metadata column named *TF* which is used to annotate the TFBSs in the plot. An example of suitable GRanges is shown below:

```
TFBSs = qs::qread(system.file("extdata", "TFBSs_1.qs", package="SingleMoleculeFootprinting"))
TFBSs
## GRanges object with 2 ranges and 1 metadata column:
##                seqnames            ranges strand |          TF
##                   <Rle>         <IRanges>  <Rle> | <character>
##   TFBS_4305215     chr6 88106216-88106226      - |        NRF1
##   TFBS_4305216     chr6 88106253-88106263      - |        NRF1
##   -------
##   seqinfo: 66 sequences (1 circular) from mm10 genome
```

N.b.: the GRanges should be subset for the binding sites overlapping the *RegionOfInterest*, as follows:

```
PlotAvgSMF(
  MethGR = Methylation[[1]],
  RegionOfInterest = RegionOfInterest,
  TFBSs = plyranges::filter_by_overlaps(TFBSs, RegionOfInterest)
  )
## No sorted reads passed...plotting counts from all reads
```

![](data:image/png;base64...)

Ultimately, `PlotAvgSMF` returns a `ggplot` object, that can be customized using the ggplot grammar as follows.

```
PlotAvgSMF(
  MethGR = Methylation[[1]],
  RegionOfInterest = RegionOfInterest,
  ) -> smf_plot
## No sorted reads passed...plotting counts from all reads

user_annotation = data.frame(xmin = 88106300, xmax = 88106500, label = "nucleosome")

smf_plot +
  geom_line(linewidth = 1.5) +
  geom_point(size = 3) +
  geom_rect(data = user_annotation, aes(xmin=xmin, xmax=xmax, ymin=-0.09, ymax=-0.04), inherit.aes = FALSE) +
  ggrepel::geom_text_repel(data = user_annotation, aes(x=xmin, y=-0.02, label=label), inherit.aes = FALSE) +
  scale_y_continuous(breaks = c(0,1), limits = c(-.25,1)) +
  scale_x_continuous(breaks = c(start(RegionOfInterest),end(RegionOfInterest)), limits = c(start(RegionOfInterest),end(RegionOfInterest))) +
  theme_bw()
## Scale for y is already present.
## Adding another scale for y, which will replace the existing scale.
## Scale for x is already present.
## Adding another scale for x, which will replace the existing scale.
```

![](data:image/png;base64...)

The function `PlotSM` can be used to plot corresponding single molecule.

```
PlotSM(
  MethSM = Methylation[[2]],
  RegionOfInterest = RegionOfInterest,
  sorting.strategy = "None"
  )
## No sorting passed or specified, will plot unsorted reads
```

![](data:image/png;base64...)

Not much information can be derived from this visualisation.
One useful first step is to perform hierarchical clustering. This can be useful to spot PCR artifacts in amplicon data (n.b. reads will be down-sampled to 500).
Hierarchical clustering can be performed by setting the parameter `SortedReads = "HC"`

```
PlotSM(
  MethSM = Methylation[[2]],
  RegionOfInterest = RegionOfInterest,
  sorting.strategy = "hierarchical.clustering"
  )
## Perfoming hierarchical clustering on single molecules before plotting
```

![](data:image/png;base64...)

This amplicon is not particularly affected by PCR artifacts. Had than been the case, this heatmap would show large blocks of perfectly duplicated methylation patterns across molecules.

### Genetic variation analysis

In Baderna & Barzaghi et al., 2024, two F1 mESC lines where obtained by crossing the reference laboratory strain Bl6 with Cast and Spret respectively.

In such cases of genetic variation SMF data, it is useful to plot SNPs disrupting TFBSs. This can be done by using a GRanges object.
N.b.: this GRanges should be already subset for the SNPs overlapping the region of interest.
N.b.: this GRanges should have two metadata columns named `R` and `A`, indicating the sequence interested by SNPs or indels.
A suitable example follows

```
SNPs = qs::qread(system.file("extdata", "SNPs_1.qs", package="SingleMoleculeFootprinting"))
SNPs
## GRanges object with 5 ranges and 2 metadata columns:
##       seqnames    ranges strand |           R           A
##          <Rle> <IRanges>  <Rle> | <character> <character>
##   [1]    chr16   8470596      * |           T           C
##   [2]    chr16   8470781      * |           C           A
##   [3]    chr16   8470876      * |           G           C
##   [4]    chr16   8470975      * |           T           C
##   [5]    chr16   8470538      * |          CT           C
##   -------
##   seqinfo: 21 sequences from an unspecified genome; no seqlengths
```

This GRanges should be passed to the `SNPs` argument of the `PlotAvgSMF` function

```
Methylation = qs::qread(system.file("extdata", "Methylation_1.qs", package="SingleMoleculeFootprinting"))
TFBSs = qs::qread(system.file("extdata", "TFBSs_2.qs", package="SingleMoleculeFootprinting"))
RegionOfInterest = GRanges("chr16", IRanges(8470511,8471010))

PlotAvgSMF(
  MethGR = Methylation,
  RegionOfInterest = RegionOfInterest,
  TFBSs = TFBSs,
  SNPs = SNPs
  )
## No sorted reads passed...plotting counts from all reads
```

![](data:image/png;base64...)

Occasionally a variant will interest the genomic contexts recognized by the MTase enzymes.
In that case the MTase will still target that cytosine on one allele, but not the other.
This causes artifacts in SMF signals, whereby the mutated cytosine context will appear fully unmethylated (SMF=1).

```
Methylation = qs::qread(system.file("extdata", "Methylation_2.qs", package="SingleMoleculeFootprinting"))
TFBSs = qs::qread(system.file("extdata", "TFBSs_1.qs", package="SingleMoleculeFootprinting"))
SNPs = qs::qread(system.file("extdata", "SNPs_2.qs", package="SingleMoleculeFootprinting"))
RegionOfInterest = GRanges("chr6", IRanges(88106000, 88106500))

PlotAvgSMF(
  MethGR = Methylation,
  RegionOfInterest = RegionOfInterest,
  TFBSs = TFBSs,
  SNPs = SNPs
  ) +
  geom_vline(xintercept = start(SNPs[5]), linetype = 2, color = "grey")
## No sorted reads passed...plotting counts from all reads
```

![](data:image/png;base64...)

It is important to filter out those cytosines in both alleles. This can be done using the function `MaskSNPs`.
This function takes as arguments the `Methylation` object to filter and a GRanges object of `CytosinesToMask`.
`CytosinesToMask` has, for each cytosines, the information of whether it is disrupted by SNPs in the Cast or Spret genomes.

```
CytosinesToMask = qs::qread(system.file("extdata", "cytosines_to_mask.qs", package="SingleMoleculeFootprinting"))
CytosinesToMask
## GRanges object with 64 ranges and 3 metadata columns:
##        seqnames    ranges strand | GenomicContext DisruptedInCast
##           <Rle> <IRanges>  <Rle> |    <character>       <logical>
##    [1]     chr6  88106003      * |           DGCH           FALSE
##    [2]     chr6  88106012      * |            GCG           FALSE
##    [3]     chr6  88106018      * |           DGCH           FALSE
##    [4]     chr6  88106023      * |           DGCH           FALSE
##    [5]     chr6  88106028      * |            GCG           FALSE
##    ...      ...       ...    ... .            ...             ...
##   [60]     chr6  88106435      * |           DGCH           FALSE
##   [61]     chr6  88106445      * |           DGCH           FALSE
##   [62]     chr6  88106456      * |           DGCH           FALSE
##   [63]     chr6  88106493      * |           DGCH            TRUE
##   [64]     chr6  88106496      * |           DGCH           FALSE
##        DisruptedInSpret
##               <logical>
##    [1]            FALSE
##    [2]            FALSE
##    [3]            FALSE
##    [4]            FALSE
##    [5]             TRUE
##    ...              ...
##   [60]            FALSE
##   [61]            FALSE
##   [62]            FALSE
##   [63]            FALSE
##   [64]            FALSE
##   -------
##   seqinfo: 21 sequences from an unspecified genome; no seqlengths
```

The full genomic annotation of disrupted cytosines can be found at `# RESUME HERE`.

N.b.: the `SampleStringMatch` argument should be set to correspond to a string match for `colnames(elementMetadata(Methylation))`

```
MaskSNPs(
  Methylation = Methylation,
  CytosinesToMask = CytosinesToMask,
  MaskSMmat = FALSE,
  SampleStringMatch = list(Cast = "_CTKO", Spret = "_STKO"),
  Experiment = "DE"
  ) -> Methylation_masked
## Masking GRanges in DE mode
## Skipping SM matrix

PlotAvgSMF(
  MethGR = Methylation_masked,
  RegionOfInterest = RegionOfInterest,
  TFBSs = TFBSs,
  SNPs = SNPs
  ) +
  geom_vline(xintercept = start(SNPs[5]), linetype = 2, color = "grey")
## No sorted reads passed...plotting counts from all reads
```

![](data:image/png;base64...)

## Plotting composite sites

It can be useful to plot composite data by piling up heterologous features, such as multiple binding sites for a TF.
It is advisable to select a subset of motifs, such as the top 500 motifs ranked by ChIP-seq score. That is generally sufficient.
Here we exemplify how to do that for the top 500 REST bound motifs.

```
TopMotifs = qs::qread(system.file("extdata", "Top_bound_REST.qs", package="SingleMoleculeFootprinting"))

CollectCompositeData(
  sampleFile = sampleFile,
  samples = samples,
  genome = BSgenome.Mmusculus.UCSC.mm10,
  TFBSs = TopMotifs,
  window = 1000,
  coverage = 20,
  ConvRate.thr = NULL,
  cores = 16
) -> CompositeData

png("../inst/extdata/rest_composite.png", units = "cm", res = 100, width = 24, height = 16)
CompositePlot(CompositeData = CompositeData, span = 0.1, TF = "Rest")
dev.off()
```

N.b.: the `CollectCompositeData` function takes several minutes to run, therefore we advice parallelizing computations using the argument `cores`. For 500 motifs, between `4` and `16` cores are suitable.

```
knitr::include_graphics(system.file("extdata", "rest_composite.png", package="SingleMoleculeFootprinting"))
```

![](data:image/png;base64...)

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