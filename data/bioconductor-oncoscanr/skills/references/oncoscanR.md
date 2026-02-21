# Secondary analyses of CNV data (HRD and more) with oncoscanR

Yann Christinat

#### October 30, 2025

# Contents

* [1 OncoscanR package description](#oncoscanr-package-description)
  + [1.1 Inclusion in Bioconductor](#inclusion-in-bioconductor)
* [2 Getting started](#getting-started)
  + [2.1 Installation](#installation)
  + [2.2 Testing the installation](#testing-the-installation)
* [3 Use cases](#use-cases)
  + [3.1 Loading a ChAS export file and do a bit of cleaning](#loading-a-chas-export-file-and-do-a-bit-of-cleaning)
  + [3.2 Computation of arm-level alteration](#computation-of-arm-level-alteration)
  + [3.3 Global level of alteration](#global-level-of-alteration)
  + [3.4 HRD scores](#hrd-scores)
    - [3.4.1 Score LST](#score-lst)
    - [3.4.2 Score HR-LOH](#score-hr-loh)
    - [3.4.3 Score nLST](#score-nlst)
    - [3.4.4 Score gLOH](#score-gloh)
    - [3.4.5 Example](#example)
  + [3.5 TDplus score](#tdplus-score)
  + [3.6 Main workflow (as used at the Geneva University Hospitals)](#main-workflow-as-used-at-the-geneva-university-hospitals)
  + [3.7 References](#references)
  + [3.8 Session info](#session-info)

# 1 OncoscanR package description

OncoscanR is an R package to handle Copy Number Variation analyses originating
from the Oncoscan assay (Affymetrix). It allows computation of different
homologous recombination deficiency (HRD) scores and the tandem duplication plus
score (TDplus) to identify CDK12-mutated tumors [Popova et al.,
Cancer Res 2016].
The package also allows for identification of arm-level alterations (e.g. gain
of chromosome arm 1p).

## 1.1 Inclusion in Bioconductor

The package allows secondary analysis of biological microarray data. It relies
on existing bioconductor packages to enable rigourous and reproducible analyses.
The package could, for example, be used to compute an HRD score using CNV data
from the `conumee` package.

**IMPORTANT**: The package expects as input the text exported file from ChAS
(Chromosome Analysis Suite; the Affymetrix software to identify CNV segments
from the Oncoscan Assay). The package assumes that all segments given in the
file are correct and true. The ChAS text file has to contain the columns `Type`,
`CN State` and `Full Location` (to setup in ChAS). Any text file that complies
with this structure should work equally well.

Starting with version 1.3.0, ASCAT output files can also be used as input.

Note that the Oncoscan does not cover the p arms of chromosome 13, 14, 15 and
22.
The coverage on the p arm of chromosome 21 is only partial and is not included
in the standard Oncoscan workflow (function `workflow_oncoscan.chas` or script
`bin/oncoscan-workflow.R`).

# 2 Getting started

## 2.1 Installation

OncoscanR is available through Bioconductor. In R, enter the commands:

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")

BiocManager::install("oncoscanR")
```

You can also install the development version via GitHub.:

```
# install.packages('devtools')
install_github('yannchristinat/oncoscanR')
```

Note that the installation of the development version requires the prior
installation of the packages `GenomicRanges` (bioconductor), `magrittr`,
`jsonlite` and `readr`.

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("GenomicRanges")

install.packages(c("magrittr", "jsonlite", "readr"))
```

## 2.2 Testing the installation

Open R and type the following commands:

```
library(oncoscanR)
#> Loading required package: IRanges
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
#> Loading required package: GenomicRanges
#> Loading required package: Seqinfo
#> Loading required package: magrittr
#>
#> Attaching package: 'magrittr'
#> The following object is masked from 'package:GenomicRanges':
#>
#>     subtract
segs.filename <- system.file("extdata", "chas_example.txt",
                             package = "oncoscanR")
res <- workflow_oncoscan.chas(segs.filename)
print(res)
#> $armlevel
#> $armlevel$AMP
#> character(0)
#>
#> $armlevel$LOSS
#> character(0)
#>
#> $armlevel$LOH
#> character(0)
#>
#> $armlevel$GAIN
#> character(0)
#>
#>
#> $scores
#> $scores$HRD
#> [1] "Negative, nLST=1"
#>
#> $scores$TDplus
#> [1] 0
#>
#> $scores$avgCN
#> [1] "2.10"
#>
#>
#> $file
#> [1] "chas_example.txt"
```

If everything is setup fine, `res` should contain a list with no arm-level
alterations and a negative HRD score (nLST=1).

# 3 Use cases

## 3.1 Loading a ChAS export file and do a bit of cleaning

ChAS exports files contain only basic information about the copy number (gain,
loss or LOH), plus the segment may overlap the centromere.
When the file is loaded by OncoscanR (`load_chas` function), all segments are
assigend to a chromosomal arms and split if necessary.
The LOH segments are given by ChAS independently of the copy number variation
segments. Therefore one may have a LOH segment overlapping with a copy loss. As
this information is redundant (a copy loss will always have a LOH), we need to
trim and split these LOH with the `adjust_loh` function.

```
library(magrittr)

# Load the ChAS file
chas.fn <- system.file("extdata", "chas_example.txt", package = "oncoscanR")
segments <- load_chas(chas.fn, oncoscan_na33.cov)

# Clean the segments: restricted to Oncoscan coverage, LOH not overlapping
# with copy loss segments, smooth&merge segments within 300kb and prune
# segments smaller than 300kb.
segs.clean <- trim_to_coverage(segments, oncoscan_na33.cov) %>%
    adjust_loh() %>%
    merge_segments() %>%
    prune_by_size()
```

Of note, the `oncoscan_na33.cov` objects contains the genomic coverage of the
oncoscan assay (start/end for each chromosomal arm, hg19). One could re-compute
the latter by downloading the annotation file from the ThermoFisher website
and process it with the `get_oncoscan_coverage_from_probes`function.

A similar function is available for loading a result file from the ASCAT
program: `load_ascat`. The ASCAT file is expected to have the following column
names:
- ‘chr’ (chromosome number, with or withour “chr”)
- ‘startpos’ (first position of CNV segment)
- ‘endpos’ (last position of CNV segment)
- ‘nMajor’ (Number of copies of the major allele)
- ‘nMinor’ (Number of copies of the minor allele)

```
ascat.fn <- system.file("extdata", "ascat_example.txt", package = "oncoscanR")
ascat.segments <- load_ascat(ascat.fn, oncoscan_na33.cov)
head(ascat.segments)
#> GRanges object with 2 ranges and 2 metadata columns:
#>       seqnames              ranges strand |        cn     cn.type
#>          <Rle>           <IRanges>  <Rle> | <numeric> <character>
#>   [1]       1q 144009053-249212878      * |         3        Gain
#>   [2]       5p      38139-46193462      * |         3        Gain
#>   -------
#>   seqinfo: 43 sequences from an unspecified genome; no seqlengths
```

## 3.2 Computation of arm-level alteration

Function `armlevel_alt`

An arm is declared globally altered if more than 80% of its bases are altered
with a similar CNV type (amplifications [3 extra copies or more], gains [1-2
extra copies], losses or copy-neutral losses of heterozygozity [LOH]). For
instance, “gain of 3p” indicates that there is more than 80% of arm with 3
copies but less than 80% with 5 (otherwise it would be an amplification). Prior
to computation, segments of same copy number and at a distance <300Kbp (Oncoscan
resolution genome-wide) are merged. The remaining segments are filtered to a
minimum size of 300Kbp.

For instance if we want to get all arms that have a global LOH alteration, we
run:

```
chas.fn <- system.file("extdata", "triploide_gene_list_full_location.txt",
                       package = "oncoscanR")
segments <- load_chas(chas.fn, oncoscan_na33.cov)
armlevel.loh <- get_loh_segments(segments) %>%
    armlevel_alt(kit.coverage = oncoscan_na33.cov)
```

The variable `armlevel.loh`is a named vector containing the arms that have
percentage of base with LOH above the threshold (90%). To obtain the percentage
of LOH bases in all arms, one could set the threshold to zero:

```
armlevel.loh <- get_loh_segments(segments) %>%
        armlevel_alt(kit.coverage = oncoscan_na33.cov, threshold = 0)
```

## 3.3 Global level of alteration

Several functions are available to perform such computation:

* `score_avgcn`: compute the average copy number across the genome
* `score_estwgd`: computes an estimation of the number of whole-genome doubling
  events
* `score_mbalt`: computes the total number of Mbp that have an alteration (w/o
  LOH segments)

```
mbalt <- score_mbalt(segments, oncoscan_na33.cov)
percent.alt <- mbalt['sample']/mbalt['kit']
message(paste(mbalt['sample'], 'Mbp altered ->', round(percent.alt*100),
              '% of genome'))
#> 2503 Mbp altered -> 88 % of genome

avgcn <- score_avgcn(segments, oncoscan_na33.cov)
wgd <- score_estwgd(segments, oncoscan_na33.cov)
message(paste('Average copy number:', round(avgcn, 2), '->', wgd['WGD'],
'whole-genome doubling event'))
#> Average copy number: 3.25 -> 1 whole-genome doubling event
```

## 3.4 HRD scores

The package contains several HRD scores described below.

### 3.4.1 Score LST

Function `score_lst`

Procedure based on the paper from Popova et al, Can. Res. 2012 (PMID: 22933060).
First segments smaller than 3Mb are removed, then segments are smoothed with
respect to copy number at a distance of 3Mb.
The number of LSTs is the number of breakpoints (breakpoints closer than 3Mb are
merged) that have a segment larger or equal to 10Mb on each side. This score was
linked to BRCA1/2-deficient tumors.

### 3.4.2 Score HR-LOH

Function `score_loh`

Procedure based on the paper from Abkevich et al., Br J Cancer 2012 (PMID:
23047548).
Number of LOH segments larger than 15Mb but excluding segments on chromosomes
with a global LOH alteration. This score was linked to BRCA1/2-deficient tumors.

### 3.4.3 Score nLST

Function `score_nlst`

HRD score developed at HUG and based on the LST score by Popova et al. but
normalized by an estimation of the number of whole-genome doubling events.
Of note, copy-neutral LOH segments are removed before computation.

`nLST = LST - 7*W/2` where `W` is the number of whole-genome doubling events.

The score is positive if there are at least 15 nLST.

The nLST score has been validated on 469 high grade ovarian cancer samples from
the PAOLA-1 clinical trial and is used in routine at the Geneva University
Hospitals for prediction of PARP inhibitors response.

*How to cite*

Christinat Y, Ho L, Clément S, et al. 2022-RA-567-ESGO The Geneva HRD test:
clinical validation on 469 samples from the PAOLA-1 trial. International Journal
of Gynecologic Cancer 2022;32:A238-A239.

### 3.4.4 Score gLOH

Function `score_gloh`

The percentage genomic LOH score is computed as described in the FoundationFocus
CDx BRCA LOH assay; i.e. the percentage of bases covered by the Oncoscan that
display a loss of heterozygosity independently of the number of copies,
excluding chromosomal arms that have a global LOH (>=90% of arm length). To
compute with the armlevel\_alt function on LOH segments only). This score was
linked to BRCA1/2-deficient tumors.

### 3.4.5 Example

First we need to load and clean the ChAS export file (from a female patient). We
adjust the Oncoscan coverage to exclude the 21p arm as it is only partially
covered.

```
# Load data
chas.fn <- system.file("extdata", "LST_gene_list_full_location.txt",
                       package = "oncoscanR")
segments <- load_chas(chas.fn, oncoscan_na33.cov)

# Clean the segments: restricted to Oncoscan coverage, LOH not overlapping
# with copy loss segments, smooth&merge segments within 300kb and prune
# segments smaller than 300kb.
segs.clean <- trim_to_coverage(segments, oncoscan_na33.cov) %>%
    adjust_loh() %>%
    merge_segments() %>%
    prune_by_size()

# Then we need to compute the arm-level alteration for loss and LOH since many
# scores discard arms that are globally altered.
arms.loss <- names(get_loss_segments(segs.clean) %>%
        armlevel_alt(kit.coverage = oncoscan_na33.cov))
arms.loh <- names(get_loh_segments(segs.clean) %>%
        armlevel_alt(kit.coverage = oncoscan_na33.cov))

# Get the number of LST
lst <- score_lst(segs.clean, oncoscan_na33.cov)

# Get the number of HR-LOH
hrloh <- score_loh(segs.clean, arms.loh, arms.loss, oncoscan_na33.cov)

# Get the genomic LOH score
gloh <- score_gloh(segs.clean, arms.loh, arms.loss, oncoscan_na33.cov)

# Get the number of nLST
wgd <- score_estwgd(segs.clean, oncoscan_na33.cov)  # Get the avg CN, including 21p
nlst <- score_nlst(segs.clean, wgd["WGD"], oncoscan_na33.cov)

print(c(LST=lst, `HR-LOH`=hrloh, gLOH=gloh, nLST=nlst))
#>                 LST              HR-LOH                gLOH           nLST.nLST
#>                "26"                "25" "0.411605161891022"              "22.5"
#>            nLST.HRD
#>          "Positive"
```

## 3.5 TDplus score

function `score_td`

Procedure based on the paper from Popova et al., Cancer Res 2016 (PMID:
26787835). The TDplus score is defined as the number of regions larger than 1Mb
but smaller or equal to 10Mb with a gain of one or two copies. This score was
linked to CDK12-deficient tumors.
They also identified as second category of tandem duplication whose size is
smaller or equal than 1Mb and around 300Kb but could not link it to a phenotype.
Note that due to its resolution the Oncoscan assay will most likely miss this
second category. Nonetheless it is reported by the function but not by the
standard workflow.

```
# Load data
chas.fn <- system.file("extdata", "TDplus_gene_list_full_location.txt",
                       package = "oncoscanR")
segments <- load_chas(chas.fn, oncoscan_na33.cov)

# Clean the segments: restricted to Oncoscan coverage, LOH not overlapping
# with copy loss segments, smooth&merge segments within 300kb and prune
# segments smaller than 300kb.
segs.clean <- trim_to_coverage(segments, oncoscan_na33.cov) %>%
    adjust_loh() %>%
    merge_segments() %>%
    prune_by_size()

td <- score_td(segs.clean)
print(td$TDplus)
#> [1] 93
```

## 3.6 Main workflow (as used at the Geneva University Hospitals)

The main workflow used for routine analysis can be launched either in R via the
`workflow_oncoscan.chas(chas.fn, gender)` function or via the script
`bin/run_oncoscan_workflow.R`:

Usage:
`Rscript path_to_oncoscanR_package/bin/oncoscan-workflow.R CHAS_FILE`
- `CHAS_FILE`: Path to the text export file from ChAS or a compatible text file.

The script will output a JSON string into the terminal with all the computed
information. :

```
{
  "armlevel": {
    "AMP": [],
    "LOSS": ["17p", "2q", "4p"],
    "LOH": ["14q", "5q", "8p", "8q"],
    "GAIN": [19p", "19q", "1q", "20p", "20q", "3q", "5p", "6p", "9p", "9q",
    "Xp", "Xq"]
  },
  "scores": {
    "HRD": "Negative, nLST=12",
    "TDplus": 22,
    "avgCN": "2.43"
  },
  "file": "H19001012_gene_list_full_location.txt"
}
```

Or to launch the workflow within R:

```
segs.filename <- system.file('extdata', 'LST_gene_list_full_location.txt',
                             package = 'oncoscanR')
dat <- workflow_oncoscan.chas(segs.filename)

message(paste('Arms with copy loss:',
              paste(dat$armlevel$LOSS, collapse = ', ')))
#> Arms with copy loss: 15q
message(paste('Arms with copy gains:',
              paste(dat$armlevel$GAIN, collapse = ', ')))
#> Arms with copy gains: 11q, 12p, 12q, 16p, 1q, 20p, 20q, 21q, 2p, 4p, 5p, 6p, 6q, 7p, 7q, 8q, 9q
message(paste('HRD score:', dat$scores$HRD))
#> HRD score: Positive, nLST=22.5
```

A similar function is available for running the workflow from an ASCAT result
file: `workflow_oncoscan.ascat`.

```
library(jsonlite)
segs.filename <- system.file('extdata', 'ascat_example.txt',
                             package = 'oncoscanR')
dat <- workflow_oncoscan.ascat(segs.filename)
toJSON(dat, auto_unbox=TRUE, pretty=TRUE)
#> {
#>   "armlevel": {
#>     "AMP": [],
#>     "LOSS": [],
#>     "LOH": [],
#>     "GAIN": ["1q", "5p"]
#>   },
#>   "scores": {
#>     "HRD": "Negative, nLST=0",
#>     "TDplus": 0,
#>     "avgCN": "2.05"
#>   },
#>   "file": "ascat_example.txt"
#> }
```

Please read the manual for a description of all available R functions.

## 3.7 References

1. “Homologous Recombination Deficiency (HRD) Score Predicts Response to
   Platinum-Containing Neoadjuvant Chemotherapy in Patients with Triple-Negative
   Breast Cancer.”, M. Telli et al., Clin Cancer Res volume 22(15), august 2016.
2. “Ovarian Cancers Harboring Inactivating Mutations in CDK12 Display a Distinct
   Genomic Instability Pattern Characterized by Large Tandem Duplications.”, T.
   Popova et al., Cancer Res volume 76(7), april 2016.
3. “Ploidy and large-scale genomic instability consistently identify basal-like
   breast carcinomas with BRCA1/2 inactivation.”, T. Popova et al., Cancer Res
   volume 72(21), november 2012.
4. “Patterns of genomic loss of heterozygosity predict homologous recombination
   repair defects in epithelial ovarian cancer.”, V. Abkevich et al., Br J Cancer.
   2012 Nov 6;107(10).
5. “Absolute quantification of somatic DNA alterations in human cancer”, S.
   Carter et al., Nat Biotech, 2012 volume 30(5).

## 3.8 Session info

Here is the output of `sessionInfo()` on the system on which this document was
compiled:

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
#>  [1] jsonlite_2.0.0       oncoscanR_1.12.0     magrittr_2.0.4
#>  [4] GenomicRanges_1.62.0 Seqinfo_1.0.0        IRanges_2.44.0
#>  [7] S4Vectors_0.48.0     BiocGenerics_0.56.0  generics_0.1.4
#> [10] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] bit_4.6.0           archive_1.1.12      compiler_4.5.1
#>  [4] BiocManager_1.30.26 crayon_1.5.3        tidyselect_1.2.1
#>  [7] parallel_4.5.1      jquerylib_0.1.4     yaml_2.3.10
#> [10] fastmap_1.2.0       readr_2.1.5         R6_2.6.1
#> [13] knitr_1.50          tibble_3.3.0        bookdown_0.45
#> [16] bslib_0.9.0         pillar_1.11.1       tzdb_0.5.0
#> [19] rlang_1.1.6         cachem_1.1.0        xfun_0.53
#> [22] sass_0.4.10         bit64_4.6.0-1       cli_3.6.5
#> [25] digest_0.6.37       vroom_1.6.6         hms_1.1.4
#> [28] lifecycle_1.0.4     vctrs_0.6.5         evaluate_1.0.5
#> [31] glue_1.8.0          rmarkdown_2.30      tools_4.5.1
#> [34] pkgconfig_2.0.3     htmltools_0.5.8.1
```