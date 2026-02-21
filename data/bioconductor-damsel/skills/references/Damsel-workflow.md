# Damsel-workflow

#### 29 October 2025

# Contents

* [1 1. Introduction](#introduction)
* [2 Installation](#installation)
* [3 Processing the BAM files](#processing-the-bam-files)
  + [3.1 Introducing the GATC region file](#introducing-the-gatc-region-file)
  + [3.2 Extracting the counts within the GATC regions](#extracting-the-counts-within-the-gatc-regions)
  + [3.3 Correlation analysis of samples](#correlation-analysis-of-samples)
  + [3.4 Visualisation of coverage](#visualisation-of-coverage)
* [4 Differential methylation analysis](#differential-methylation-analysis)
  + [4.1 Setting up edgeR analysis](#setting-up-edger-analysis)
  + [4.2 Examining the data - multidimensional scaling plot](#examining-the-data---multidimensional-scaling-plot)
  + [4.3 Identifying differentially methylated regions](#identifying-differentially-methylated-regions)
* [5 Identifying peaks (bridges)](#identifying-peaks-bridges)
  + [5.1 Aggregating the regions](#aggregating-the-regions)
  + [5.2 Plotting](#plotting)
* [6 Identifying genes associated with peaks](#identifying-genes-associated-with-peaks)
  + [6.1 Extract genes](#extract-genes)
    - [6.1.1 A TxDb object](#a-txdb-object)
    - [6.1.2 Accessing the biomaRt resource](#accessing-the-biomart-resource)
  + [6.2 Annotating genes to peaks](#annotating-genes-to-peaks)
  + [6.3 Interpreting results and plotting](#interpreting-results-and-plotting)
* [7 Gene ontology](#gene-ontology)
  + [7.1 GO analysis with goseq](#go-analysis-with-goseq)
* [8 Appendix](#appendix)

# 1 1. Introduction

This document gives an introduction to the R package Damsel, for use in DamID analysis; from BAM file input to gene ontology analysis.

Designed for use with DamID data, the Damsel methodology could be modified for use on any similar technology that seeks to identify enriched regions relative to a control sample.

Utilising the power of edgeR for differential analysis and goseq for gene ontology bias correction, Damsel provides a unique end to end analysis for DamID.

The DamID example data used in this vignette is available in the package and has been taken from Vissers et al., (2018), ‘The Scalloped and Nerfin-1 Transcription Factors Cooperate to Maintain Neuronal Cell Fate’. The fastq files were downloaded from SRA, aligned using `Rsubread::index` and `Rsubread::align`, before sorting and making bai files with Samtools.

# 2 Installation

```
if (!require("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}

BiocManager::install("Damsel")
library(Damsel)
```

# 3 Processing the BAM files

As a DamID analysis tool, Damsel requires a GATC region file for analysis. These regions serve as a guide to extract counts from the BAM files.

## 3.1 Introducing the GATC region file

It can be generated with `getGatcRegions()` using a `BSGenome` object or a FASTA file.

It is a `GRangesList` with the consecutive GATC regions across the genome - representing the region (or the length) between GATC sites, as well as the positions of the sites themselves.

If you have another species of DamID data or would prefer to make your own region file, you can use the following function, providing a BSgenome object or a FASTA file.

```
library(BSgenome.Dmelanogaster.UCSC.dm6)
#> Loading required package: BSgenome
#> Loading required package: BiocGenerics
#> Loading required package: generics
#>
#> Attaching package: 'generics'
#> The following objects are masked from 'package:base':
#>
#>     as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
#>     setequal, union
#>
#> Attaching package: 'BiocGenerics'
#> The following objects are masked from 'package:stats':
#>
#>     IQR, mad, sd, var, xtabs
#> The following objects are masked from 'package:base':
#>
#>     Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,
#>     as.data.frame, basename, cbind, colnames, dirname, do.call,
#>     duplicated, eval, evalq, get, grep, grepl, is.unsorted, lapply,
#>     mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
#>     rank, rbind, rownames, sapply, saveRDS, table, tapply, unique,
#>     unsplit, which.max, which.min
#> Loading required package: S4Vectors
#> Loading required package: stats4
#>
#> Attaching package: 'S4Vectors'
#> The following object is masked from 'package:utils':
#>
#>     findMatches
#> The following objects are masked from 'package:base':
#>
#>     I, expand.grid, unname
#> Loading required package: IRanges
#> Loading required package: Seqinfo
#> Loading required package: GenomicRanges
#> Loading required package: Biostrings
#> Loading required package: XVector
#>
#> Attaching package: 'Biostrings'
#> The following object is masked from 'package:base':
#>
#>     strsplit
#> Loading required package: BiocIO
#> Loading required package: rtracklayer
regions_and_sites <- getGatcRegions(BSgenome.Dmelanogaster.UCSC.dm6)
#> Warning in .local(x, row.names, optional, ...): 'optional' argument was ignored
#> Warning in .local(x, row.names, optional, ...): 'optional' argument was ignored
#> Warning in .local(x, row.names, optional, ...): 'optional' argument was ignored
#> Warning in .local(x, row.names, optional, ...): 'optional' argument was ignored
#> Warning in .local(x, row.names, optional, ...): 'optional' argument was ignored
#> Warning in .local(x, row.names, optional, ...): 'optional' argument was ignored
#> Warning in .local(x, row.names, optional, ...): 'optional' argument was ignored
#> Warning in GenomeInfoDb::renameSeqlevels(x = df_, value = newStyle): invalid
#> seqlevels 'chrM' ignored
regions <- regions_and_sites$regions
knitr::kable(head(regions))
```

| seqnames | start | end | width | strand | Position |
| --- | --- | --- | --- | --- | --- |
| 2L | 82 | 230 | 149 | \* | chr2L-82 |
| 2L | 231 | 371 | 141 | \* | chr2L-231 |
| 2L | 372 | 539 | 168 | \* | chr2L-372 |
| 2L | 540 | 688 | 149 | \* | chr2L-540 |
| 2L | 689 | 829 | 141 | \* | chr2L-689 |
| 2L | 830 | 997 | 168 | \* | chr2L-830 |

```
knitr::kable(head(regions_and_sites$sites))
```

| seqnames | start | end | width | strand | Position |
| --- | --- | --- | --- | --- | --- |
| 2L | 80 | 83 | 4 | \* | chr2L-80 |
| 2L | 229 | 232 | 4 | \* | chr2L-229 |
| 2L | 370 | 373 | 4 | \* | chr2L-370 |
| 2L | 538 | 541 | 4 | \* | chr2L-538 |
| 2L | 687 | 690 | 4 | \* | chr2L-687 |
| 2L | 828 | 831 | 4 | \* | chr2L-828 |

If you already have your own GATC region file, ensure that it has the same format with 6 columns:

* Position: chromosome-start
* seqnames: chromosome name
* start: start of region
* end: end of region
* width: length of region (ensure that is is correct according to `[plyranges::as_granges()])`

## 3.2 Extracting the counts within the GATC regions

Note: Damsel requires BAM files that have been mapped to the reference genome.

Provided the path to a folder of BAM files (and their .bai files) and the appropriate GATC region file, the function `countBamInGATC()` will extract the counts for each region for each available BAM and add them as columns to a data frame. The columns will be named by the BAM file name - please rename them before running the function if they do not make sense.

```
path_to_bams <- system.file("extdata", package = "Damsel")
counts.df <- countBamInGATC(path_to_bams,
    regions = regions
)
```

* If necessary, at this stage please rearrange the BAM file columns so they are ordered in the following way: Dam\_1, Fusion\_1, Dam\_2, Fusion\_2 etc

```
knitr::kable(head(counts.df))
```

| X | Position | seqnames | start | end | width | strand | dam\_1\_SRR7948872.BAM | sd\_1\_SRR7948874.BAM | dam\_2\_SRR7948876.BAM | sd\_2\_SRR7948877.BAM |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | chr2L-82 | chr2L | 82 | 230 | 149 | \* | 1.0 | 0.33 | 0.0 | 0.0 |
| 2 | chr2L-231 | chr2L | 231 | 371 | 141 | \* | 1.5 | 5.67 | 87.0 | 57.5 |
| 3 | chr2L-372 | chr2L | 372 | 539 | 168 | \* | 2.5 | 6.17 | 88.0 | 58.5 |
| 4 | chr2L-540 | chr2L | 540 | 688 | 149 | \* | 2.0 | 4.83 | 0.0 | 0.0 |
| 5 | chr2L-689 | chr2L | 689 | 829 | 141 | \* | 0.0 | 0.00 | 0.5 | 0.5 |
| 6 | chr2L-830 | chr2L | 830 | 997 | 168 | \* | 0.0 | 1.33 | 4.5 | 3.5 |

This example data is also directly available as a counts file via `data`.

```
data("dros_counts")
```

* Do not remove the .bam extension on the column names as this is used as a check in later functions to ensure only the BAM files are selected from the data frame.
* The DamID data captures the ~75bp region extending from each GATC site, so although regions are of differing widths, there is a null to minimal length bias present on the data, and does not require length correction.

## 3.3 Correlation analysis of samples

At this stage, the similarities and differences between the samples can be analysed via correlation.
`plotCorrHeatmap` plots the correlation of all available BAM files Dam and Fusion, to visualise the similarity between files.
The default for all Damsel correlation analysis is the non-parametric “spearman’s” correlation.
The correlation between Dam\_1 and Fusion\_1 can be expected to reach ~ 0.7, whereas the correlation between Dam\_1 & Dam\_3 or Fusion\_1 & Fusion\_2 would be expected to be closer to ~0.9

```
plotCorrHeatmap(df = counts.df, method = "spearman")
```

![](data:image/png;base64...)

Two specific samples can also be compared using `ggscatter` which plots a scatterplot of the two samples, overlaid with the correlation results. [ggpubr::ggscatter()]

## 3.4 Visualisation of coverage

The overall coverage of different samples can be compared

```
plotCountsDistribution(counts.df, constant = 1)
```

![](data:image/png;base64...)

A specific region can be selected to view the counts across samples.

```
plotCounts(counts.df,
    seqnames = "chr2L",
    start_region = 1,
    end_region = 40000,
    layout = "spread"
)
```

![](data:image/png;base64...)
As shown in the following plots, the default layout is `"stacked"`, where the replicates are overlaid. The counts can also be displayed in a log2 ratio with `log2_scale=TRUE`

# 4 Differential methylation analysis

The goal with DamID analysis is to identify regions that are enriched in the fusion sample relative to the control. In Damsel, this step is referred to as differential methylation analysis, and makes use of [`edgeR`].

For ease of use, Damsel has four main edgeR based functions which compile different steps and functions from within edgeR.

## 4.1 Setting up edgeR analysis

`makeDGE` sets up the edgeR analysis for differential methylation testing. Taking the data frame of samples and regions as input, it conducts the following steps:

* it extracts the sample data
* groups the samples (Dam or Fusion)
* filters the samples (remove regions with very low counts, the filtering parameters may be adjusted)
* normalises the data
* establishes the design matrix (this includes the sample group and pairing replicates together - Dam\_1 & Fusion\_1)
* estimates the dispersion

```
dge <- makeDGE(counts.df)
head(dge)
#> An object of class "DGEList"
#> $counts
#>            dam_1_SRR7948872.BAM sd_1_SRR7948874.BAM dam_2_SRR7948876.BAM
#> chr2L-231                  1.50                5.67                 87.0
#> chr2L-372                  2.50                6.17                 88.0
#> chr2L-3578                 4.00                1.50                  6.0
#> chr2L-4494                 1.42                7.83                  8.0
#> chr2L-4952                 3.58                1.83                  5.5
#> chr2L-5120                 4.42                3.00                  6.0
#>            sd_2_SRR7948877.BAM
#> chr2L-231                57.50
#> chr2L-372                58.50
#> chr2L-3578                5.00
#> chr2L-4494                6.00
#> chr2L-4952                5.33
#> chr2L-5120                5.83
#>
#> $samples
#>                       group lib.size norm.factors
#> dam_1_SRR7948872.BAM    Dam  2238419    1.7342299
#> sd_1_SRR7948874.BAM  Fusion  2027147    0.8980197
#> dam_2_SRR7948876.BAM    Dam 10752265    1.2158660
#> sd_2_SRR7948877.BAM  Fusion 11540604    0.5281068
#>
#> $genes
#>              Position seqnames start  end
#> chr2L-231   chr2L-231    chr2L   231  371
#> chr2L-372   chr2L-372    chr2L   372  539
#> chr2L-3578 chr2L-3578    chr2L  3578 3745
#> chr2L-4494 chr2L-4494    chr2L  4494 4661
#> chr2L-4952 chr2L-4952    chr2L  4952 5119
#> chr2L-5120 chr2L-5120    chr2L  5120 5153
#>
#> $design
#>   (Intercept) group V2
#> 1           1     0  1
#> 2           1     1  1
#> 3           1     0  0
#> 4           1     1  0
#> attr(,"assign")
#> [1] 0 1 2
#>
#> $common.dispersion
#> [1] 0.0226594
#>
#> $trended.dispersion
#> [1] 1.484063e-02 1.513608e-02 9.765625e-05 9.765625e-05 9.765625e-05
#> [6] 9.765625e-05
#>
#> $tagwise.dispersion
#> [1] 1.562230e-02 1.570253e-02 9.765625e-05 9.765625e-05 9.765625e-05
#> [6] 9.765625e-05
#>
#> $AveLogCPM
#> [1]  2.583582499  2.620713568  0.004159126  0.388971306 -0.007506024
#> [6]  0.175425183
#>
#> $trend.method
#> [1] "locfit"
#>
#> $prior.df
#> [1] 114.0032 115.4036 121.3211 107.8464 121.3211 121.3211
#>
#> $prior.n
#> [1] 114.0032 115.4036 121.3211 107.8464 121.3211 121.3211
#>
#> $span
#> [1] 0.3758554
```

The output from this step is a DGEList containing all of the information from the steps.

## 4.2 Examining the data - multidimensional scaling plot

It’s important to visualise the differences between the samples.

You would expect the Dam samples to cluster together, and for the Fusion samples to cluster together.
You would expect the majority of the variation to be within the 1st dimension (the x axis), and less variation in the 2nd dimension (y axis)

```
group <- dge$samples$group %>% as.character()
limma::plotMDS(dge, col = as.numeric(factor(group)))
```

![](data:image/png;base64...)

## 4.3 Identifying differentially methylated regions

After exploring the data visually, it’s time to identify the enriched regions. `testDmRegions` compiles the edgeR functions for differential testing with one key modification - it outputs the results with the adjusted p values as well as the raw p values.

`testDmRegions` conducts the following key steps:

* 1. fits a QLF model - quasi likelihood
* 2. tests the model
* 3. conducts p value adjustment and summarises model results by setting regions as either (1,0) (log fold change and p value thresholds can be adjusted)

These results are incorporated with the region data, providing a result for every region. The regions excluded from edgeR analysis are given logFC = 0, and adjust.p = 1
Setting plot=TRUE will plot an [`edgeR::plotSmear()`] alongside the results

```
dm_results <- testDmRegions(dge, p.value = 0.05, lfc = 1, regions = regions, plot = TRUE)
#> Warning in plot.xy(xy.coords(x, y), type = type, ...): "panel.first" is not a
#> graphical parameter
```

![](data:image/png;base64...)

```
dm_results %>%
    dplyr::group_by(meth_status) %>%
    dplyr::summarise(n = dplyr::n())
#> # A tibble: 3 × 2
#>   meth_status       n
#>   <chr>         <int>
#> 1 No_sig        30317
#> 2 Not_included 344362
#> 3 Upreg          8975

knitr::kable(head(dm_results), digits = 32)
```

| Position | seqnames | start | end | width | strand | number | dm | logFC | PValue | adjust.p | meth\_status |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| chr2L-82 | chr2L | 82 | 230 | 149 | \* | 1 | NA | 0.0000000 | 1.00000000 | 1.00000000 | Not\_included |
| chr2L-231 | chr2L | 231 | 371 | 141 | \* | 2 | 0 | 0.7641927 | 0.06406018 | 0.10390347 | No\_sig |
| chr2L-372 | chr2L | 372 | 539 | 168 | \* | 3 | 0 | 0.7516521 | 0.05668672 | 0.09365238 | No\_sig |
| chr2L-540 | chr2L | 540 | 688 | 149 | \* | 4 | NA | 0.0000000 | 1.00000000 | 1.00000000 | Not\_included |
| chr2L-689 | chr2L | 689 | 829 | 141 | \* | 5 | NA | 0.0000000 | 1.00000000 | 1.00000000 | Not\_included |
| chr2L-830 | chr2L | 830 | 997 | 168 | \* | 6 | NA | 0.0000000 | 1.00000000 | 1.00000000 | Not\_included |

The edgeR results can be plotted alongside the counts as well.

```
plotCounts(counts.df,
    seqnames = "chr2L",
    start_region = 1,
    end_region = 40000,
    log2_scale = FALSE
) +
    geom_dm(dm_results.df = dm_results)
```

![](data:image/png;base64...)

Only regions that are fully contained within the provided boundaries will be plotted.

* Add GATC sites

```
gatc_sites <- regions_and_sites$sites

knitr::kable(head(gatc_sites))
```

| seqnames | start | end | width | strand | Position |
| --- | --- | --- | --- | --- | --- |
| 2L | 80 | 83 | 4 | \* | chr2L-80 |
| 2L | 229 | 232 | 4 | \* | chr2L-229 |
| 2L | 370 | 373 | 4 | \* | chr2L-370 |
| 2L | 538 | 541 | 4 | \* | chr2L-538 |
| 2L | 687 | 690 | 4 | \* | chr2L-687 |
| 2L | 828 | 831 | 4 | \* | chr2L-828 |

```
plotCounts(counts.df,
    seqnames = "chr2L",
    start_region = 1,
    end_region = 40000,
    log2_scale = FALSE
) +
    geom_dm(dm_results) +
    geom_gatc(gatc_sites)
```

![](data:image/png;base64...)

# 5 Identifying peaks (bridges)

As you could see from the plot of the differential methylation results, there are 10s of 1000s of enriched regions. To reduce the scale of this data to something that can be more biologically meaningul, enriched regions can be compiled into peaks.

## 5.1 Aggregating the regions

Damsel identifies peaks by aggregating regions of enrichment. As DamID sequencing generally sequences the 75 bp from the GATC site, regions smaller than 150 bp are mostly non-significant in statistical testing. Because of this, gaps between peaks of less than or equal to 150 bp are combined into one longer peak.

The FDR and logFC for each peak is calculated via the theory of [csaw::getBestTest()] where the ‘best’ (smallest) p-value in the regions that make up the peak is selected as representative of the peak. The logFC is therefore the corresponding logFC from the selected region.

```
peaks <- identifyPeaks(dm_results)
nrow(peaks)
#> [1] 700

knitr::kable(head(peaks), digits = 32)
```

| peak\_id | seqnames | start | end | width | strand | rank\_p | logFC\_match | FDR | multiple\_peaks | region\_pos | n\_regions\_dm | n\_regions\_not\_dm |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| PS\_1182 | chr2L | 10488545 | 10489575 | 1031 | \* | 1 | 7.406347 | 5.396903e-07 | 1 | chr2L-10488545 | 3 | 0 |
| PM\_900 | chr2L | 8028432 | 8032164 | 3733 | \* | 2 | 5.595426 | 5.396903e-07 | 2 | chr2L-8029996 | 8 | 1 |
| PS\_1442 | chr2L | 13204670 | 13207893 | 3224 | \* | 3 | 5.085242 | 5.396903e-07 | 1 | chr2L-13206327 | 8 | 0 |
| PM\_947 | chr2L | 8402774 | 8404891 | 2118 | \* | 4 | 4.995976 | 5.396903e-07 | 2 | chr2L-8403504 | 11 | 1 |
| PS\_1505 | chr2L | 13867794 | 13881891 | 14098 | \* | 5 | 4.927108 | 5.396903e-07 | 1 | chr2L-13871337 | 34 | 0 |
| PM\_65 | chr2L | 426798 | 434692 | 7895 | \* | 6 | 4.884309 | 5.396903e-07 | 3 | chr2L-430375 | 21 | 2 |

## 5.2 Plotting

A peak plot layer can be added to our graph

```
plotCounts(counts.df,
    seqnames = "chr2L",
    start_region = 1,
    end_region = 40000
) +
    geom_dm(dm_results) +
    geom_peak(peaks, peak.label = TRUE) +
    geom_gatc(gatc_sites)
```

![](data:image/png;base64...)
The default version will not plot the peak.label

The distribution of counts per sample that have contributed to peaks can be compared.

```
plotCountsInPeaks(counts.df, dm_results, peaks, position = "stack")
```

![](data:image/png;base64...)

# 6 Identifying genes associated with peaks

The peak information itself - while interesting, has no biological meaning. As the peaks represent a region that the Fusion protein interacted with on the DNA, likely as a transcription factor, we wish to identify the gene that is being affected. To do so, we need to associate the peaks with a potential “target” gene.

Note: any gene identified here is only a potential target that must be validated in laboratory procedures. There is no method available that is able to accurately predict the location and target genes of enhancers, so a key and potentially incorrect assumption in this part of the analysis is that all peaks represent binding to a local enhancer or promoter - that it is close or overlapping to the target gene.

It must also be noted that the Drosophila melanogaster genome and transcription factor interactions are different to that of mammals and using the same assumptions means results must be taken cautiously. While mammalian genes are generally spread out with little overlap, there is a large amount of overlap between Drosophila genes, requiring some intuitive interpretation of which gene the peak is potentially targeting.

In the Damsel methodology, peaks are considered to associate with genes if they are within 5kb upstream or downstream. If multiple genes are within these criteria, they are all listed, with the closest gene given the primary position.

## 6.1 Extract genes

The function `collateGenes()` uses two different mechanisms to create a list of genes. It allows for the use of a TxDb object/annotation package, or can access biomaRt.

### 6.1.1 A TxDb object

The simplest approach is to use a TxDb annotation package. A TxDb package is available for most species and has information about the genes, exons, cds, promoters, etc - which can all be accessed using the GenomicFeatures package.
This presentation has a lot of slides on how to use TxDb objects to access different data types: <https://rockefelleruniversity.github.io/Bioconductor_Introduction/presentations/slides/GenomicFeatures_In_Bioconductor.html#10>

However, TxDb libraries contain only the Ensembl gene Ids and not the gene symbol or name. Instead we need to access an org.Db package to transfer them over. org.Db packages contain information about model organisms genome annotation, and can be used to extract various information about the gene name etc. More information can be found here
<https://rockefelleruniversity.github.io/Bioconductor_Introduction/presentations/slides/GenomicFeatures_In_Bioconductor.html#46>

```
BiocManager::install("TxDb.Dmelanogaster.UCSC.dm6.ensGene")
BiocManager::install("org.Dm.eg.db")
```

```
library("TxDb.Dmelanogaster.UCSC.dm6.ensGene")
#> Loading required package: GenomicFeatures
#> Loading required package: AnnotationDbi
#> Loading required package: Biobase
#> Welcome to Bioconductor
#>
#>     Vignettes contain introductory material; view with
#>     'browseVignettes()'. To cite Bioconductor, see
#>     'citation("Biobase")', and for packages 'citation("pkgname")'.
txdb <- TxDb.Dmelanogaster.UCSC.dm6.ensGene::TxDb.Dmelanogaster.UCSC.dm6.ensGene
library("org.Dm.eg.db")
#>
genes <- collateGenes(genes = txdb, regions = regions, org.Db = org.Dm.eg.db)
#>   1 gene was dropped because it has exons located on both strands of the same
#>   reference sequence or on more than one reference sequence, so cannot be
#>   represented by a single genomic range.
#>   Use 'single.strand.genes.only=FALSE' to get all the genes in a GRangesList
#>   object, or use suppressMessages() to suppress this message.
#> 'select()' returned 1:many mapping between keys and columns
#> TSS taken as start of gene, taking strand into account
knitr::kable(head(genes))
```

| seqnames | start | end | width | strand | ensembl\_gene\_id | gene\_name | TSS | n\_regions |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| chr2L | 7529 | 9484 | 1956 | + | FBgn0031208 | CR11023 | 7529 | 3 |
| chr2L | 9839 | 21376 | 11538 | - | FBgn0002121 | l(2)gl | 21376 | 33 |
| chr2L | 21823 | 25155 | 3333 | - | FBgn0031209 | Ir21a | 25155 | 8 |
| chr2L | 21952 | 24237 | 2286 | + | FBgn0263584 | asRNA:CR43609 | 21952 | 6 |
| chr2L | 25402 | 65404 | 40003 | - | FBgn0051973 | Cda5 | 65404 | 93 |
| chr2L | 54817 | 55767 | 951 | + | FBgn0267987 | lncRNA:CR46254 | 54817 | 1 |

Using the TxDb package, Damsel assumes that the TSS (transcription start site) is the same as the start site of the gene, taking the strand into account.

### 6.1.2 Accessing the biomaRt resource

Alternatively, the name of a species listed in biomaRt can be provided, and the version of the genome. The advantage of biomaRt is that a greater amount of information is able to be uncovered, including the canonical transcript.
A guide to understanding more about how biomaRt functions is here: <https://bioconductor.org/packages/release/bioc/vignettes/biomaRt/inst/doc/accessing_ensembl.html>

```
BiocManager::install("biomaRt")
```

```
library(biomaRt)
collateGenes(genes = "dmelanogaster_gene_ensembl", regions = regions, version = 109)
#> GRanges object with 23844 ranges and 5 metadata columns:
#>           seqnames          ranges strand | ensembl_gene_id   gene_name
#>              <Rle>       <IRanges>  <Rle> |     <character> <character>
#>       [1]       2L       7529-9484      + |     FBgn0031208     CR11023
#>       [2]       2L       9726-9859      + |     FBti0060580
#>       [3]       2L      9839-21376      - |     FBgn0002121      l(2)gl
#>       [4]       2L       9888-9949      - |     FBti0059810
#>       [5]       2L     21823-25155      - |     FBgn0031209       Ir21a
#>       ...      ...             ...    ... .             ...         ...
#>   [23840]        Y 3370887-3371602      + |     FBgn0267426     CR45779
#>   [23841]        Y 3376224-3376984      + |     FBgn0267427     CR45780
#>   [23842]        Y 3539437-3540722      - |     FBgn0046698      Pp1-Y2
#>   [23843]        Y 3561745-3618339      + |     FBgn0046323         ORY
#>   [23844]        Y 3649996-3666928      + |     FBgn0267592         CCY
#>           ensembl_transcript_id       TSS n_regions
#>                     <character> <integer> <numeric>
#>       [1]           FBtr0475186      7529         3
#>       [2]        FBti0060580-RA      9726         1
#>       [3]           FBtr0306592     21376        33
#>       [4]        FBti0059810-RA      9949         0
#>       [5]           FBtr0113008     25155         8
#>       ...                   ...       ...       ...
#>   [23840]           FBtr0346754   3370887         0
#>   [23841]           FBtr0346755   3376224         0
#>   [23842]           FBtr0346673   3540722         6
#>   [23843]           FBtr0346720   3561745       114
#>   [23844]           FBtr0347413   3649996        28
#>   -------
#>   seqinfo: 7 sequences from an unspecified genome; no seqlengths
```

* accesses biomaRt using the seqnames of the appropriate GATC region file as a guide
* accesses biomaRt a second time to obtain only the Ensembl canonical sequence information for each gene
* identifies the number of GATC regions that overlap with each gene

## 6.2 Annotating genes to peaks

As stated above, Damsel associates genes with peaks if they are within 5 kb upstream or downstream. This maximum distance is an adjustable parameter within the `annotatePeaksGenes()` function. If set to `NULL` it will output all possible combinations as defined by `plyranges::pair_nearest`. The nature of this function means that the closest gene will be found for every peak, even if that distance is in the millions. If the user sets `max_distance=NULL`, we recommend undergoing some filtering to remove those associations.

To respect that some species have genes with more overlap than others, `annotatePeaksGenes` outputs a list of data frames. The first, closest, outputs information for every peak and it’s closest gene. The second data frame, top\_five, outputs a string of the top five genes (if available) and their distances from each peak. The final data frame, all, provides the raw results and all possible gene and peak associations, as well as all available statistical results.

```
annotation <- annotatePeaksGenes(peaks, genes, regions = regions, max_distance = 5000)

knitr::kable(head(annotation$closest), digits = 32)
```

| seqnames | start | end | width | total\_regions | n\_regions\_dm | peak\_id | rank\_p | gene\_position | ensembl\_gene\_id | gene\_name | midpoint\_is | position |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| chr2L | 5154 | 9484 | 4331 | 8 | 3 | PS\_2 | 607 | chr2L:+:7529-9484 | FBgn0031208 | CR11023 | Upstream | Peak\_upstream |
| chr2L | 9839 | 21376 | 11538 | 33 | 4 | PM\_4 | 627 | chr2L:-:9839-21376 | FBgn0002121 | l(2)gl | Upstream | Peak\_within\_gene |
| chr2L | 9839 | 21376 | 11538 | 33 | 5 | PS\_6 | 12 | chr2L:-:9839-21376 | FBgn0002121 | l(2)gl | Upstream | Peak\_within\_gene |
| chr2L | 9839 | 21643 | 11805 | 34 | 5 | PS\_7 | 18 | chr2L:-:9839-21376 | FBgn0002121 | l(2)gl | Upstream | Peak\_overlap\_downstream |
| chr2L | 21823 | 25155 | 3333 | 8 | 3 | PS\_8 | 552 | chr2L:-:21823-25155 | FBgn0031209 | Ir21a | Upstream | Peak\_within\_gene |
| chr2L | 25402 | 65404 | 40003 | 93 | 3 | PM\_9 | 572 | chr2L:-:25402-65404 | FBgn0051973 | Cda5 | Upstream | Peak\_within\_gene |

```
knitr::kable(head(annotation$top_five), digits = 32)
```

| seqnames | start | end | peak\_id | rank\_p | n\_genes | list\_ensembl | list\_gene | position | distance\_TSS | min\_distance |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| chr2L | 5154 | 9484 | PS\_2 | 607 | 1 | FBgn0031208 | CR11023 | Peak\_upstream | 1512 | 649 |
| chr2L | 9839 | 21376 | PM\_4 | 627 | 1 | FBgn0002121 | l(2)gl | Peak\_within\_gene | 8246.5 | 0 |
| chr2L | 9839 | 21376 | PS\_6 | 12 | 1 | FBgn0002121 | l(2)gl | Peak\_within\_gene | 3489 | 0 |
| chr2L | 9839 | 21643 | PS\_7 | 18 | 1 | FBgn0002121 | l(2)gl | Peak\_overlap\_downstream | 660 | 267 |
| chr2L | 21823 | 25155 | PS\_8 | 552 | 2 | FBgn0031209, FBgn0263584 | Ir21a, asRNA:CR43609 | Peak\_within\_gene, Peak\_within\_gene | 2771, -432 | 0, 0 |
| chr2L | 25402 | 65404 | PM\_9 | 572 | 1 | FBgn0051973 | Cda5 | Peak\_within\_gene | 30177 | 0 |

```
knitr::kable(str(annotation$all), digits = 32)
#> tibble [1,553 × 33] (S3: tbl_df/tbl/data.frame)
#>  $ seqnames        : Factor w/ 1870 levels "chr2L","chr2R",..: 1 1 1 1 1 1 1 1 1 1 ...
#>  $ start           : int [1:1553] 5154 9839 9839 9839 21823 21952 25402 65609 65609 65609 ...
#>  $ end             : int [1:1553] 9484 21376 21376 21643 25155 24237 65404 68330 68330 71390 ...
#>  $ width           : num [1:1553] 4331 11538 11538 11805 3333 ...
#>  $ gene_seqnames   : Factor w/ 1870 levels "chr2L","chr2R",..: 1 1 1 1 1 1 1 1 1 1 ...
#>  $ gene_start      : int [1:1553] 7529 9839 9839 9839 21823 21952 25402 65999 66318 66482 ...
#>  $ gene_end        : int [1:1553] 9484 21376 21376 21376 25155 24237 65404 66242 66524 71390 ...
#>  $ gene_width      : int [1:1553] 1956 11538 11538 11538 3333 2286 40003 244 207 4909 ...
#>  $ gene_strand     : Factor w/ 3 levels "+","-","*": 1 2 2 2 2 1 2 1 1 1 ...
#>  $ peak_seqnames   : Factor w/ 2 levels "chr2L","chr2R": 1 1 1 1 1 1 1 1 1 1 ...
#>  $ peak_start      : int [1:1553] 5154 12694 16957 19789 22097 22097 33758 65609 65609 65609 ...
#>  $ peak_end        : int [1:1553] 6880 13565 18817 21643 22671 22671 36696 68330 68330 68330 ...
#>  $ peak_width      : int [1:1553] 1727 872 1861 1855 575 575 2939 2722 2722 2722 ...
#>  $ peak_strand     : Factor w/ 3 levels "+","-","*": 3 3 3 3 3 3 3 3 3 3 ...
#>  $ ensembl_gene_id : chr [1:1553] "FBgn0031208" "FBgn0002121" "FBgn0002121" "FBgn0002121" ...
#>  $ gene_name       : chr [1:1553] "CR11023" "l(2)gl" "l(2)gl" "l(2)gl" ...
#>  $ TSS             : int [1:1553] 7529 21376 21376 21376 25155 21952 65404 65999 66318 66482 ...
#>  $ n_regions       : num [1:1553] 3 33 33 33 8 6 93 0 0 15 ...
#>  $ peak_id         : chr [1:1553] "PS_2" "PM_4" "PS_6" "PS_7" ...
#>  $ rank_p          : int [1:1553] 607 627 12 18 552 552 572 161 161 161 ...
#>  $ logFC_match     : num [1:1553] 1.39 1.65 4.38 4.47 2.5 ...
#>  $ FDR             : num [1:1553] 3.79e-04 5.61e-04 5.40e-07 5.94e-07 1.93e-04 ...
#>  $ multiple_peaks  : num [1:1553] 1 2 1 1 1 1 2 1 1 1 ...
#>  $ region_pos      : chr [1:1553] "chr2L-5303" "chr2L-12715" "chr2L-17586" "chr2L-20391" ...
#>  $ n_regions_dm    : num [1:1553] 3 4 5 5 3 3 3 7 7 7 ...
#>  $ n_regions_not_dm: num [1:1553] 0 1 0 0 0 0 1 0 0 0 ...
#>  $ peak_midpoint   : num [1:1553] 6017 13130 17887 20716 22384 ...
#>  $ distance_TSS    : num [1:1553] 1512 8246 3489 660 2771 ...
#>  $ midpoint_is     : chr [1:1553] "Upstream" "Upstream" "Upstream" "Upstream" ...
#>  $ n_genes         : int [1:1553] 1 1 1 1 2 2 1 4 4 4 ...
#>  $ position        : chr [1:1553] "Peak_upstream" "Peak_within_gene" "Peak_within_gene" "Peak_overlap_downstream" ...
#>  $ min_distance    : num [1:1553] 649 0 0 267 0 0 0 0 0 873 ...
#>  $ total_regions   : int [1:1553] 8 33 33 34 8 6 93 7 7 18 ...
```

## 6.3 Interpreting results and plotting

Now that we have the genes from `collateGenes()`, this can be added as a layer to the previous plots. This plot requires the gene positions as a guide for a `Txdb` or `EnsDb` object, building off the autoplot generic built by `ggbio`.

```
plotCounts(counts.df,
    seqnames = "chr2L",
    start_region = 1,
    end_region = 40000
) +
    geom_dm(dm_results) +
    geom_peak(peaks) +
    geom_gatc(gatc_sites) +
    geom_genes_tx(genes, txdb)
#> If gene is disproportional to the plot, use gene_limits = c(y1,y2). If gene is too large, recommend setting to c(0,2) and adjusting the plot.height accordingly.
#> Parsing transcripts...
#> Parsing exons...
#> Parsing cds...
#> Parsing utrs...
#> ------exons...
#> ------cdss...
#> ------introns...
#> ------utr...
#> aggregating...
#> Done
#> Constructing graphics...
#> Scale for y is already present.
#> Adding another scale for y, which will replace the existing scale.
```

![](data:image/png;base64...)

* If the scale of the gene plot is disproportional to the height of the overall plot - if it is too large or too squished, it can be adjusted using the `plot.height` argument.

```
plotWrap(
    id = peaks[1, ]$peak_id,
    counts.df = counts.df,
    dm_results.df = dm_results,
    peaks.df = peaks,
    gatc_sites.df = gatc_sites,
    genes.df = genes, txdb = txdb
)
#> If gene is disproportional to the plot, use gene_limits = c(y1,y2). If gene is too large, recommend setting to c(0,2) and adjusting the plot.height accordingly.
#> Parsing transcripts...
#> Parsing exons...
#> Parsing cds...
#> Parsing utrs...
#> ------exons...
#> ------cdss...
#> ------introns...
#> ------utr...
#> aggregating...
#> Done
#> Constructing graphics...
#> Scale for y is already present.
#> Adding another scale for y, which will replace the existing scale.
#> [[1]]
```

![](data:image/png;base64...)

```
plotWrap(
    id = genes[1, ]$ensembl_gene_id,
    counts.df = counts.df,
    dm_results.df = dm_results,
    peaks.df = peaks,
    gatc_sites.df = gatc_sites,
    genes.df = genes, txdb = txdb
)
#> No data available for this region
#> If gene is disproportional to the plot, use gene_limits = c(y1,y2). If gene is too large, recommend setting to c(0,2) and adjusting the plot.height accordingly.
#> Parsing transcripts...
#> Parsing exons...
#> Parsing cds...
#> Parsing utrs...
#> ------exons...
#> ------cdss...
#> ------introns...
#> ------utr...
#> aggregating...
#> Done
#> Constructing graphics...
#> Scale for y is already present.
#> Adding another scale for y, which will replace the existing scale.
#> [[1]]
```

![](data:image/png;base64...)

# 7 Gene ontology

One of the last steps in a typical DamID analysis is gene ontology analysis. However, a key mistake made in this analysis using any common data type - including RNA-seq, is the lack of bias correction. We correct for this by utilising the [goseq] package. Without bias correction, the ontology results would be biased towards longer genes - the longer the gene, the more likely it would be to have a peak associated with it, and therefore be called as significant. We can see this in the plot below.

## 7.1 GO analysis with goseq

`testGeneOntology` identifies the over-represented GO terms from the peak data, correcting for the number of GATC regions matching to each gene.

3 outputs
Plot of goodness of fit of model
signif\_results: data.frame of significant GO category results, ordered by p-value.
prob\_weights: data.frame of probability weights for each gene

```
ontology <- testGeneOntology(annotation$all, genes, regions = regions, extend_by = 2000)
#> Bias will be n_regions that are contained within the gene length
#>
#> Warning in pcls(G): initial point very close to some inequality constraints
```

![](data:image/png;base64...)

```
#> Fetching GO annotations...
#> For 4399 genes, we could not find any categories. These genes will be excluded.
#> To force their use, please run with use_genes_without_cat=TRUE (see documentation).
#> This was the default behavior for version 1.15.1 and earlier.
#> Calculating the p-values...
#> 'select()' returned 1:1 mapping between keys and columns
```

The goodness of fit plot above shows us that there is a length based bias to the data. The x axis shows the number of GATC regions in each gene. The y axis shows the proportion of genes that have that amount of GATC regions and have been identified as significant. And it shows that as the number of GATC regions in the gene increase, as does the proportion of genes that are significant.

```
knitr::kable(head(ontology$signif_results), digits = 32)
```

| category | over\_represented\_pvalue | under\_represented\_pvalue | numDEInCat | numInCat | term | ontology | FDR |
| --- | --- | --- | --- | --- | --- | --- | --- |
| GO:0043231 | 4.576131e-09 | 1.0000000 | 378 | 5380 | intracellular membrane-bounded organelle | CC | 5.383818e-05 |
| GO:0043227 | 1.274654e-08 | 1.0000000 | 388 | 5584 | membrane-bounded organelle | CC | 7.498155e-05 |
| GO:0005622 | 3.497550e-08 | 1.0000000 | 493 | 7547 | intracellular anatomical structure | CC | 1.371622e-04 |
| GO:0043229 | 1.174251e-07 | 1.0000000 | 414 | 6156 | intracellular organelle | CC | 3.453767e-04 |
| GO:0043226 | 2.448953e-07 | 1.0000000 | 419 | 6272 | organelle | CC | 5.762386e-04 |
| GO:0008406 | 1.289884e-06 | 0.9999998 | 15 | 50 | gonad development | BP | 2.167926e-03 |

```
knitr::kable(head(ontology$prob_weights), digits = 32)
```

|  | DEgenes | bias.data | pwf |
| --- | --- | --- | --- |
| FBgn0031208 | 1 | 9 | 0.04042808 |
| FBgn0002121 | 1 | 46 | 0.06715388 |
| FBgn0031209 | 1 | 15 | 0.04524548 |
| FBgn0263584 | 1 | 13 | 0.04365067 |
| FBgn0051973 | 1 | 100 | 0.08392959 |
| FBgn0267987 | 0 | 10 | 0.04123729 |

As expected, significant gene ontology terms surround developmental processes, which is expected as the fusion gene in the example data (Scalloped) is well known to be involved in development.

`plotGeneOntology` can be used to plot the top 10 results.

```
plotGeneOntology(ontology$signif_results)
```

![](data:image/png;base64...)
As shown above, the plot has the category on the y-axis, the FDR on the x-axis, the size of the dot being the number of genes in the GO category, and the colour of the dot being the ontology (Biological Process, Cellular Component, and Molecular Function).

# 8 Appendix

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
#>  [1] biomaRt_2.66.0
#>  [2] org.Dm.eg.db_3.22.0
#>  [3] TxDb.Dmelanogaster.UCSC.dm6.ensGene_3.12.0
#>  [4] GenomicFeatures_1.62.0
#>  [5] AnnotationDbi_1.72.0
#>  [6] Biobase_2.70.0
#>  [7] BSgenome.Dmelanogaster.UCSC.dm6_1.4.1
#>  [8] BSgenome_1.78.0
#>  [9] rtracklayer_1.70.0
#> [10] BiocIO_1.20.0
#> [11] Biostrings_2.78.0
#> [12] XVector_0.50.0
#> [13] GenomicRanges_1.62.0
#> [14] Seqinfo_1.0.0
#> [15] IRanges_2.44.0
#> [16] S4Vectors_0.48.0
#> [17] BiocGenerics_0.56.0
#> [18] generics_0.1.4
#> [19] Damsel_1.6.0
#> [20] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] RColorBrewer_1.1-3          rstudioapi_0.17.1
#>   [3] jsonlite_2.0.0              shape_1.4.6.1
#>   [5] magrittr_2.0.4              magick_2.9.0
#>   [7] farver_2.1.2                rmarkdown_2.30
#>   [9] GlobalOptions_0.1.2         vctrs_0.6.5
#>  [11] memoise_2.0.1               Cairo_1.7-0
#>  [13] Rsamtools_2.26.0            RCurl_1.98-1.17
#>  [15] base64enc_0.1-3             tinytex_0.57
#>  [17] htmltools_0.5.8.1           S4Arrays_1.10.0
#>  [19] progress_1.2.3              curl_7.0.0
#>  [21] SparseArray_1.10.0          Formula_1.2-5
#>  [23] sass_0.4.10                 bslib_0.9.0
#>  [25] htmlwidgets_1.6.4           plyr_1.8.9
#>  [27] httr2_1.2.1                 cachem_1.1.0
#>  [29] GenomicAlignments_1.46.0    lifecycle_1.0.4
#>  [31] iterators_1.0.14            pkgconfig_2.0.3
#>  [33] Matrix_1.7-4                R6_2.6.1
#>  [35] fastmap_1.2.0               MatrixGenerics_1.22.0
#>  [37] clue_0.3-66                 digest_0.6.37
#>  [39] colorspace_2.1-2            OrganismDbi_1.52.0
#>  [41] patchwork_1.3.2             goseq_1.62.0
#>  [43] Hmisc_5.2-4                 RSQLite_2.4.3
#>  [45] filelock_1.0.3              labeling_0.4.3
#>  [47] mgcv_1.9-3                  httr_1.4.7
#>  [49] abind_1.4-8                 compiler_4.5.1
#>  [51] bit64_4.6.0-1               withr_3.0.2
#>  [53] doParallel_1.0.17           backports_1.5.0
#>  [55] htmlTable_2.4.3             S7_0.2.0
#>  [57] BiocParallel_1.44.0         DBI_1.2.3
#>  [59] BiasedUrn_2.0.12            geneLenDataBase_1.45.0
#>  [61] rappdirs_0.3.3              DelayedArray_0.36.0
#>  [63] rjson_0.2.23                tools_4.5.1
#>  [65] foreign_0.8-90              nnet_7.3-20
#>  [67] glue_1.8.0                  restfulr_0.0.16
#>  [69] nlme_3.1-168                grid_4.5.1
#>  [71] checkmate_2.3.3             cluster_2.1.8.1
#>  [73] reshape2_1.4.4              gtable_0.3.6
#>  [75] ensembldb_2.34.0            tidyr_1.3.1
#>  [77] data.table_1.17.8           hms_1.1.4
#>  [79] xml2_1.4.1                  utf8_1.2.6
#>  [81] foreach_1.5.2               pillar_1.11.1
#>  [83] stringr_1.5.2               limma_3.66.0
#>  [85] circlize_0.4.16             splines_4.5.1
#>  [87] dplyr_1.1.4                 BiocFileCache_3.0.0
#>  [89] lattice_0.22-7              bit_4.6.0
#>  [91] biovizBase_1.58.0           RBGL_1.86.0
#>  [93] tidyselect_1.2.1            GO.db_3.22.0
#>  [95] ComplexHeatmap_2.26.0       locfit_1.5-9.12
#>  [97] knitr_1.50                  gridExtra_2.3
#>  [99] bookdown_0.45               ProtGenerics_1.42.0
#> [101] ggbio_1.58.0                edgeR_4.8.0
#> [103] SummarizedExperiment_1.40.0 xfun_0.53
#> [105] statmod_1.5.1               matrixStats_1.5.0
#> [107] stringi_1.8.7               UCSC.utils_1.6.0
#> [109] lazyeval_0.2.2              yaml_2.3.10
#> [111] evaluate_1.0.5              codetools_0.2-20
#> [113] cigarillo_1.0.0             tibble_3.3.0
#> [115] graph_1.88.0                BiocManager_1.30.26
#> [117] cli_3.6.5                   rpart_4.1.24
#> [119] jquerylib_0.1.4             dichromat_2.0-0.1
#> [121] Rcpp_1.1.0                  GenomeInfoDb_1.46.0
#> [123] dbplyr_2.5.1                png_0.1-8
#> [125] XML_3.99-0.19               parallel_4.5.1
#> [127] ggplot2_4.0.0               blob_1.2.4
#> [129] prettyunits_1.2.0           AnnotationFilter_1.34.0
#> [131] plyranges_1.30.0            bitops_1.0-9
#> [133] txdbmaker_1.6.0             VariantAnnotation_1.56.0
#> [135] scales_1.4.0                purrr_1.1.0
#> [137] crayon_1.5.3                GetoptLong_1.0.5
#> [139] rlang_1.1.6                 KEGGREST_1.50.0
```