# OMICsPCAdata: Supporting data for package OMICsPCA

#### Subhadeep Das

#### 2025-11-04

* [1 Overview](#overview)
* [2 Datasets](#datasets)
* [3 Example of datasets](#example-of-datasets)
  + [3.1 CAGE data](#cage-data)

# 1 Overview

This package contains suporting data for the package OMICsPCA. The datasets included in this package are used to run the examples provided at the vignette and the man pages of the functions of OMICsPCA package.

# 2 Datasets

OMICsPCAdata contains 4 data sets including 1 expression dataset (CAGE) and 3 ChIP-seq experiments of various Histone modifications. Each dataset contains the values corresponding to 28770 GENCODE TSS groups (rows). TSS groups are obtained by merging the neighboring TSSs together. Each column contains either ChIP-seq peak intensities (for Histone modifications) or length of DHS (for DNaseI hypersensitivity) or number of reads (tpm) of CAGE defined TSSs (CTSS), coming from a specific cell line.

The datasets are described below:

Summary of data sets

| Assay | Assay Type | Number of Cell line | Name of cell lines | | Experiment |
| --- | --- | --- | --- | --- |
| CAGE | Expression of Transcription Start Sites(TSS) | 31 | A549 ,AG04450 ,B.Cells\_CD20. ,BJ ,Gm12878 ,H1.hESC ,HAoAF ,HAoEC ,HCH ,HeLaS3 ,HepG2 ,HFDPC ,hMSC.AT ,hMSC.BM ,hMSC.UC ,HOB ,HPC.PL ,HPIEpC ,HSaVEC ,HUVEC ,HVMF ,HWP ,IMR90 ,K562 ,MCF7 ,Monocytes.CD14. ,NHDF ,NHEK ,NHEM.M2 ,SkMC ,SKNSH | Cap Analysis of Gene Expressio |
| H2az | location of Histone modification peaks | 5 | Gm12878 ,Hepg2 ,Hsmm ,K562 ,Osteobl | ChIP-seq |
| H3k9ac | location of Histone modification peaks | 13 | Gm12878 ,H1hesc ,Helas3 ,Hepg2 ,Hmec ,Hsmm ,Hsmmt ,Huvec ,K562 ,Nhdfad ,Nhek ,Nhlf ,Nt2d1 | ChIP-seq |
| H3k4me1 | location of Histone modification peaks | 12 | Gm12878 ,H1hesc ,Hmec ,Hsmm ,Hsmmt ,Huvec ,K562 ,Nha ,Nhek ,Nhlf ,Osteobl ,Nt2d1 | ChIP-seq |

# 3 Example of datasets

Each dataset contains the value of 28770 GENCODE TSS groups in multiple Cell lines. Here is an example:

## 3.1 CAGE data

```
# The CAGE data set contains normalized CAGE data of 28770 GENCODE
#TSS groups in from 31 cell lines

dim(assays$CAGE)
# [1] 154031     31

# Let's look at the first five rows and columns of this dataset
head(assays$CAGE[1:5,1:5])
# # A tibble: 5 × 5
#   A549             AG04450          B.Cells_CD20.    BJ               Gm12878
#   <chr>            <chr>            <chr>            <chr>            <chr>
# 1 0                0                85.8895806558477 0                0
# 2 49.6336910685519 0                0                0                0
# 3 0                0                0                0                0
# 4 61.4568108749758 19.4710468352727 23.969601604456  17.9526438211874 129.28532…
# 5 196.720325095994 121.562481593189 216.782580604901 60.083445046716  74.770012…
```