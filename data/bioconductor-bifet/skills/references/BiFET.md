# A Guide to using BiFET

#### Ahrim Youn

#### 2025-10-29

* [Introduction](#introduction)
* [1. Obtaining a Peak File](#obtaining-a-peak-file)
* [2. Obtaining a Matrix of Footprint Calls](#obtaining-a-matrix-of-footprint-calls)
* [3. Calculating enrichment p-value](#calculating-enrichment-p-value)
* [Citing BiFET](#citing-bifet)
* [References](#references)

## Introduction

`BiFET` (Bias-free Footprint Enrichment Test) aims to identify TFs whose footprints are over-represented in target regions compared to background regions after correcting for differences in read counts and GC contents between target and background regions, where regions represent ATAC-seq or DNAse-seq peaks. In this example, we used BiFET to detect TFs associated with cell-specific open chromatin regions by analyzing ATAC-seq data from human PBMCs *(Ucar, et al., 2017)* and pancreatic islets *(Khetan, et al., 2017)*.

In order to use `BiFET`, the user will need an input file with two `GRanges` objects:

* The first object `GRpeaks` represents a matrix of ATAC-seq or DNase-seq peaks in GRanges class where each row represents the location of each peak. In addition there must be 3 metadata columns called “reads” (representing read counts in each peak), “GC” (representing the GC content), and lastly “peaktype” which designates each peak as either (“target”,“background”,“no”).
* The second object `GRmotif` represents footprint calls from any footprint algorithms in GRanges class where each row represents the location of each PWM occurrence. The footprint calls in the forward strand and those in the backward strand from the same PWM are not differentiated. The row names of GRmotif are the motif IDs (e.g. MA01371 STAT1).

## 1. Obtaining a Peak File

```
# Load necessary libraries
suppressPackageStartupMessages(library(BiFET))
suppressPackageStartupMessages(library(GenomicRanges))
library(BiFET)
library(GenomicRanges)
peak_file <- system.file("extdata", "input_peak_motif.Rdata",
                         package = "BiFET")
load(peak_file)

# Display the first few rows and columns of the peak file
head(GRpeaks)
```

```
## GRanges object with 6 ranges and 3 metadata columns:
##       seqnames              ranges strand |     reads        GC peaktype
##          <Rle>           <IRanges>  <Rle> | <numeric> <numeric> <factor>
##   [1]     chr5   89854368-89854568      * |      18.4     0.700   no
##   [2]    chr12 109027603-109027803      * |     449.0     0.575   target
##   [3]     chr8 102149556-102149756      * |     360.2     0.525   target
##   [4]     chr1 226850693-226850893      * |     363.6     0.520   target
##   [5]     chr7 142506550-142506750      * |     427.0     0.555   target
##   [6]     chr1 161039655-161039855      * |     372.8     0.585   target
##   -------
##   seqinfo: 24 sequences from an unspecified genome; no seqlengths
```

In this example, the file *input\_peak\_motif.Rdata* was obtained as follows: we used ATAC-seq data obtained from five human PBMC *(Ucar, et al., 2017)* and five human islet samples *(Khetan, et al., 2017)* and called peaks using **MACS version 2.1.0** *(Zhang, et al., 2008)* with parameters **-nomodel -f BAMPE**. The peak sets from all samples were merged to generate one consensus peak set (N = 57,108 peaks) by using **R package DiffBind\_2.2.5**. *(Ross-Innes, et al., 2012)*, where only the peaks present at least in any two samples were included in the analysis. We used the **summits** option to re-center each peak around the point of greatest enrichment and obtained consensus peaks of same width **(200bp)**.

Out of these consensus peaks, we defined regions that are specifically accessible in PBMC samples as regions where at least 4 PBMC samples have a peak, whereas none of the islet samples have a peak (n=4106 peaks; these regions are used as target regions in this example). Similarly, we defined islet-specific peaks as those that were called as a peak in at least 4 islet samples but none in any of the PBMC samples (n=12886 peaks). The rest of the peaks excluding the PBMC/islet-specific peaks were used as the background (i.e., non-specific) peaks in our analyses (n=40116 peaks). For each peak, GC content was obtained using peak annotation program **annotatePeaks.pl** from the **HOMER** software *(Heinz. et al., 2010)*.

## 2. Obtaining a Matrix of Footprint Calls

```
# Display the first few rows and columns of the motif file
head(GRmotif)
```

```
## GRanges object with 6 ranges and 0 metadata columns:
##                 seqnames            ranges strand
##                    <Rle>         <IRanges>  <Rle>
##   MA01371 STAT1    chr10   5753014-5753028      *
##   MA01371 STAT1    chr10 11646933-11646947      *
##   MA01371 STAT1    chr10 13142872-13142886      *
##   MA01371 STAT1    chr10 13142965-13142979      *
##   MA01371 STAT1    chr10 22291541-22291555      *
##   MA01371 STAT1    chr10 29058099-29058113      *
##   -------
##   seqinfo: 24 sequences from an unspecified genome; no seqlengths
```

In this example, TF footprints were called using **PIQ** algorithm *(Sherwood, et al., 2014)* using the pooled islet samples and pooled PBMC samples to increase the detection power for TF footprints. We used only the TF footprints that have a purity score greater than 0.9. The example file contains footprint calls for only five PWMs from the JASPAR database to reduce computing time.

## 3. Calculating enrichment p-value

The function `calculate_enrich_p` calculates p-value testing if footprints of a TF are over-represented in the target set of peaks compared to the background set of peaks correcting for the bias arising from the imbalance of GC-content and read counts between target and background set. The function requires two GRanges objects as input parameters: `GRpeaks` and `GRmotif`.

```
# call the function “calculate_enrich_p” to return a list of
# parameter alpha_k, enrichment p values from BiFET algorithm
  # and enrichment p values from the hypergeometric test :
result <- calculate_enrich_p(GRpeaks, GRmotif)
```

```
## [1] "PWM 1 out of 5 PWMs"
## [1] "PWM 2 out of 5 PWMs"
## [1] "PWM 3 out of 5 PWMs"
## [1] "PWM 4 out of 5 PWMs"
## [1] "PWM 5 out of 5 PWMs"
```

```
head(result)
```

```
## $alpha_k
## [1] 2.565596e-02 3.719668e-03 1.000000e+08 7.653988e-04 2.460048e-03
##
## $p.bifet
## MA01371 STAT1  MA06461 GCM1 MA01481 FOXA1 MA08081 TEAD3  MA07081 MSX2
##  2.536685e-05  9.639756e-01  3.014782e-02  8.260924e-07  1.000000e+00
##
## $p.hyper
## MA01371 STAT1  MA06461 GCM1 MA01481 FOXA1 MA08081 TEAD3  MA07081 MSX2
##  4.374279e-14  8.122715e-01  2.361607e-02  3.885781e-15  1.000000e+00
```

## Citing BiFET

BiFET: A Bias-free Transcription Factor Footprint Enrichment Test, Ahrim Youn, Eladio J Marquez, Nathan Lawlor, Michael L Stitzel, Duygu Ucar, bioRxiv 2018:324277 (<https://www.biorxiv.org/content/early/2018/05/16/324277>)

---

## References

1. Khetan, S., et al. Chromatin accessibility profiling uncovers genetic-and T2D disease state-associated changes in cis-regulatory element use in human islets. bioRxiv 2017:192922.
2. Ross-Innes, C.S., et al. Differential oestrogen receptor binding is associated with clinical outcome in breast cancer. Nature 2012;481(7381):389-393.
3. Ucar, D., et al. The chromatin accessibility signature of human immune aging stems from CD8+ T cells. Journal of Experimental Medicine 2017;jem 20170416.
4. Sherwood, et al. Discovery of Directional and Nondirectional Pioneer Transcription Factors by Modeling DNase Profile Magnitude and Shape. Nature Biotechnology 32, no. 2 (February 2014): 171.
5. Heinz, et al. Simple Combinations of Lineage-Determining Transcription Factors Prime Cis-Regulatory Elements Required for Macrophage and B Cell Identities. Molecular Cell 38, no. 4 (May 28, 2010): 576–89.
6. Zhang, et al. Model-Based Analysis of ChIP-Seq (MACS). Genome Biology 9 (2008): R137.
7. Ross-Innes, et al. Differential Oestrogen Receptor Binding Is Associated with Clinical Outcome in Breast Cancer. Nature 481, no. 7381 (January 19, 2012): 389–93.