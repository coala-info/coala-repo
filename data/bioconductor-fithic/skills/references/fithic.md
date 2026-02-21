# How to Use Fit-Hi-C R Package

#### Ruyu Tan

#### 2025-10-29

## Introduction

[Fit-Hi-C](http://genome.cshlp.org/content/24/6/999) is a tool for assigning statistical confidence estimates to intra-chromosomal contact maps produced by genome-wide genome conformation capture assays such as Hi-C as well as newer technologies such as PLAC-seq, HiChIP and region capture Hi-C. When using Fit-Hi-C with Hi-C data, we strongly suggest using bias values from matrix balancing-based normalization methods such as ICE or KR to control for experimental and techical biases in significance estimation. While using bias values, please make sure to use RAW counts and NOT the normalized counts as normalization will be taken into account through bias values. Here we provide an R implementation of Fit-Hi-C. Compared to its original implementation in Python (<https://noble.gs.washington.edu/proj/fit-hi-c>), Fit-Hi-C R port has the following advantages:

* Fit-Hi-C R package is more efficient than Python original by re-writting some logic in C/C++
* Fit-Hi-C R package is easy to use for those familiar with R language and Bioconductor without additional configuration
* Bug fixes on “nan” errors in q-value computation and plotting
* Compatible with output of hicpro2fithic.py script available in [HiCPro 2.8.1](https://github.com/nservant/HiC-Pro/tree/master/bin/utils)

## Install FitHiC

To install this package, start R and enter

```
## try http:// if https:// URLs are not supported
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("FitHiC")
```

## Example I: Yeast (S. cerevisiae) Hi-C data at single restriction enzyme (RE) resolution without bias values

**Duan\_yeast\_EcoRI**

*FRAGSFILE* and *INTERSFILE* are located in `system.file("extdata", "fragmentLists/Duan_yeast_EcoRI.gz", package = "FitHiC")` and `system.file( "extdata", "contactCounts/Duan_yeast_EcoRI.gz", package = "FitHiC")`, respectively. When input data is ready, run as follows:

```
library("FitHiC")
fragsfile <- system.file("extdata", "fragmentLists/Duan_yeast_EcoRI.gz",
    package = "FitHiC")
intersfile <- system.file("extdata", "contactCounts/Duan_yeast_EcoRI.gz",
    package = "FitHiC")
outdir <- file.path(getwd(), "Duan_yeast_EcoRI")
FitHiC(fragsfile, intersfile, outdir, libname="Duan_yeast_EcoRI",
    distUpThres=250000, distLowThres=10000)
```

Internally, Fit-Hi-C will successively call `generate_FragPairs`, `read_ICE_biases`, `read_All_Interactions`, `calculateing_Probabilities`, `fit_Spline` methods. The execution of Fit-Hi-C will be successfully completed till the following log appears:

```
## Fit-Hi-C is processing ...
## Running parse_Fragsfile method ...
## Complete parse_Fragsfile method [OK]
## Running parse_Intersfile method ...
## Complete parse_Intersfile method [OK]
## Running generate_FragPairs method ...
## Complete generate_FragPairs method [OK]
## Running read_All_Interactions method ...
## Complete read_All_Interactions method [OK]
## Running calculating_Probabilities method ...
## Writing Duan_yeast_EcoRI.fithic_pass1.txt
## Complete calculating_Probabilities method [OK]
## Running fit_Spline method ...
## Writing p-values to file Duan_yeast_EcoRI.spline_pass1.significances.txt.gz
## Complete fit_Spline method [OK]
## Running calculating_Probabilities method ...
## Writing Duan_yeast_EcoRI.fithic_pass2.txt
## Complete calculating_Probabilities method [OK]
## Running fit_Spline method ...
## Writing p-values to file Duan_yeast_EcoRI.spline_pass2.significances.txt.gz
## Complete fit_Spline method [OK]
## Execution of Fit-Hi-C completed successfully. [DONE]
## .Primitive("return")
```

The output files come from two internal methods called by Fit-Hi-C.

* **calculate\_Probabilites**

Duan\_yeast\_EcoRI.fithic\_pass1.txt

| avgGenomicDist | contactProbability | standardError | noOfLocusPairs | totalOfContactCounts |
| --- | --- | --- | --- | --- |
| 10105 | 3.12e-05 | 2.7e-06 | 322 | 22212 |
| 10315 | 3.05e-05 | 2.5e-06 | 330 | 22251 |
| 10545 | 2.87e-05 | 2.1e-06 | 350 | 22191 |
| 10779 | 2.97e-05 | 3.0e-06 | 344 | 22583 |
| 10982 | 3.16e-05 | 2.7e-06 | 323 | 22532 |
| 11196 | 3.32e-05 | 2.7e-06 | 302 | 22185 |

Duan\_yeast\_EcoRI.fithic\_pass2.txt

| avgGenomicDist | contactProbability | standardError | noOfLocusPairs | totalOfContactCounts |
| --- | --- | --- | --- | --- |
| 10107 | 1.15e-05 | 8e-07 | 252 | 6428 |
| 10317 | 1.31e-05 | 9e-07 | 266 | 7709 |
| 10546 | 1.43e-05 | 8e-07 | 281 | 8887 |
| 10779 | 1.27e-05 | 8e-07 | 285 | 7974 |
| 10982 | 1.32e-05 | 8e-07 | 255 | 7426 |
| 11196 | 1.40e-05 | 8e-07 | 238 | 7356 |

* **fit\_Spline**

Duan\_yeast\_EcoRI.spline\_pass1.significances.txt.gz

| chr1 | fragmentMid1 | chr2 | fragmentMid2 | contactCount | p\_value | q\_value |
| --- | --- | --- | --- | --- | --- | --- |
| 10 | 100894 | 10 | 150593 | 2 | 0.9988785 | 1 |
| 10 | 100894 | 10 | 162267 | 1 | 0.9985433 | 1 |
| 10 | 100894 | 10 | 169783 | 2 | 0.9708609 | 1 |
| 10 | 100894 | 10 | 179515 | 3 | 0.8072602 | 1 |
| 10 | 100894 | 10 | 182528 | 1 | 0.9831568 | 1 |
| 10 | 100894 | 10 | 185071 | 1 | 0.9795001 | 1 |

Duan\_yeast\_EcoRI.spline\_pass2.significances.txt.gz

| chr1 | fragmentMid1 | chr2 | fragmentMid2 | contactCount | p\_value | q\_value |
| --- | --- | --- | --- | --- | --- | --- |
| 10 | 100894 | 10 | 150593 | 2 | 0.9813195 | 1 |
| 10 | 100894 | 10 | 162267 | 1 | 0.9902851 | 1 |
| 10 | 100894 | 10 | 169783 | 2 | 0.8983241 | 1 |
| 10 | 100894 | 10 | 179515 | 3 | 0.6547083 | 1 |
| 10 | 100894 | 10 | 182528 | 1 | 0.9571117 | 1 |
| 10 | 100894 | 10 | 185071 | 1 | 0.9501637 | 1 |

If `visual` is set to TRUE, corresponding images will be also outputed:

|  |  |
| --- | --- |
| ![](data:image/png;base64...) | ![](data:image/png;base64...) |
| ![](data:image/png;base64...) | ![](data:image/png;base64...) |

**Duan\_yeast\_HindIII**

Similarly, Duan\_yeast\_HindIII can be run as follows:

## Example II: Human ESC Hi-C data at 40kb fixed size resolution (only chr1) without bias values

```
library("FitHiC")
fragsfile <- system.file("extdata",
    "fragmentLists/Dixon_hESC_HindIII_hg18_w40000_chr1.gz",
    package = "FitHiC")
intersfile <- system.file("extdata",
    "contactCounts/Dixon_hESC_HindIII_hg18_w40000_chr1.gz",
    package = "FitHiC")
outdir <- file.path(getwd(), "Dixon_hESC_HindIII_hg18_w40000_chr1")
FitHiC(fragsfile, intersfile, outdir,
    libname="Dixon_hESC_HindIII_hg18_w40000_chr1", noOfBins=50,
    distUpThres=5000000, distLowThres=50000, visual=TRUE)
```

|  |  |
| --- | --- |
| ![](data:image/png;base64...) | ![](data:image/png;base64...) |
| ![](data:image/png;base64...) | ![](data:image/png;base64...) |

## Example III: Human ESC Hi-C data at 10 consecutive RE resolution (only chr1) without bias values

```
library("FitHiC")
fragsfile <- system.file("extdata",
    "fragmentLists/Dixon_hESC_HindIII_hg18_combineFrags10_chr1.gz",
    package = "FitHiC")
intersfile <- system.file("extdata",
    "contactCounts/Dixon_hESC_HindIII_hg18_combineFrags10_chr1.gz",
    package = "FitHiC")
outdir <- file.path(getwd(), "Dixon_hESC_HindIII_hg18_combineFrags10_chr1")
FitHiC(fragsfile, intersfile, outdir,
    libname="Dixon_hESC_HindIII_hg18_combineFrags10_chr1", noOfBins=200,
    distUpThres=5000000, distLowThres=50000, visual=TRUE)
```

|  |  |
| --- | --- |
| ![](data:image/png;base64...) | ![](data:image/png;base64...) |
| ![](data:image/png;base64...) | ![](data:image/png;base64...) |

```
library("FitHiC")
fragsfile <- system.file("extdata",
    "fragmentLists/Dixon_mESC_HindIII_mm9_combineFrags10_chr1.gz",
    package = "FitHiC")
intersfile <- system.file("extdata",
    "contactCounts/Dixon_mESC_HindIII_mm9_combineFrags10_chr1.gz",
    package = "FitHiC")
outdir <- file.path(getwd(), "Dixon_mESC_HindIII_mm9_combineFrags10_chr1")
FitHiC(fragsfile, intersfile, outdir,
    libname="Dixon_mESC_HindIII_mm9_combineFrags10_chr1", noOfBins=200,
    distUpThres=5000000, distLowThres=50000, visual=TRUE)
```

|  |  |
| --- | --- |
| ![](data:image/png;base64...) | ![](data:image/png;base64...) |
| ![](data:image/png;base64...) | ![](data:image/png;base64...) |

## Example IV: Human ESC Hi-C data at 40kb fixed size resolution (only chr1) WITH bias values

```
library("FitHiC")
fragsfile <- system.file("extdata",
    "fragmentLists/Dixon_hESC_HindIII_hg18_w40000_chr1.gz",
    package = "FitHiC")
intersfile <- system.file("extdata",
    "contactCounts/Dixon_hESC_HindIII_hg18_w40000_chr1.gz",
    package = "FitHiC")
outdir <- file.path(getwd(), "Dixon_hESC_HindIII_hg18_w40000_chr1.afterICE")
biasfile <- system.file("extdata",
    "biasPerLocus/Dixon_hESC_HindIII_hg18_w40000_chr1.gz",
    package = "FitHiC")
FitHiC(fragsfile, intersfile, outdir, biasfile,
    libname="Dixon_hESC_HindIII_hg18_w40000_chr1", noOfBins=50,
    distUpThres=5000000, distLowThres=50000, visual=TRUE)
```

|  |  |
| --- | --- |
| ![](data:image/png;base64...) | ![](data:image/png;base64...) |
| ![](data:image/png;base64...) | ![](data:image/png;base64...) |

## Example V: Human MCF7 HiC-Pro data at 5Mb resolution WITH bias values

```
library("FitHiC")
fragsfile <- system.file("extdata", "fragmentLists/data_5000000_abs.bed.gz",
    package = "FitHiC")
intersfile <- system.file("extdata", "contactCounts/data_5000000.matrix.gz",
    package = "FitHiC")
biasfile <- system.file("extdata",
    "biasPerLocus/data_5000000_iced.matrix.biases.gz", package = "FitHiC")
outdir <- file.path(getwd(), "data_5000000")
FitHiC(fragsfile, intersfile, outdir, biasfile, libname="data_5000000",
    distUpThres=500000000, distLowThres=5000000, visual=TRUE, useHiCPro=TRUE)
```

|  |  |
| --- | --- |
| ![](data:image/png;base64...) | ![](data:image/png;base64...) |
| ![](data:image/png;base64...) | ![](data:image/png;base64...) |

## References

1. Fit-Hi-C original manuscript: Ay et al. Genome Research, 2014 - <https://www.ncbi.nlm.nih.gov/pubmed/24501021>
2. Fit-Hi-C Python implementation - <https://noble.gs.washington.edu/proj/fit-hi-c>
3. Budding yeast Hi-C data: Duan et al. Nature, 2010 - <https://www.ncbi.nlm.nih.gov/pubmed/20436457>
4. Human embryonic stem cell Hi-C data: Dixon et al. Nature, 2012 - <https://www.ncbi.nlm.nih.gov/pubmed/22495300>
5. Human MCF7 cell line Hi-C data: Barutcu et al. Genome Biology, 2015 - <https://www.ncbi.nlm.nih.gov/pubmed/26415882>

## Prepare Data

There are two different options for running FitHiC:

1. Use Hi-C pro pipeline;
2. Prepare at least two input files described below:

* **FRAGSFILE** This file stores the information about midpoints (or start indices) of the fragments. It should consist of 5 columns: first column stands for chromosome name; third column stands for the midPoint; fourth column stands for the hitCount; second column and fifth column will be ignored so you can set them to 0. HitCount (4th column) is only used for filtering in conjuction with the “mappabilityThreshold” option. By default setting bins that need to be filtered to “0” and others to “1” and leaving the mappabilityThreshold option to its default value of 1 is enough. You do not need to compute hitCount (4th column) unless you will explicitly filter using a custom threshold on marginal counts set by the “mappabilityThreshold” option.

FRAGSFILE

| Chromosome.Name | Column.2 | Mid.Point | Hit.Count | Column.5 |
| --- | --- | --- | --- | --- |
| chr1 | 0 | 20000 | 1 | 0 |
| chr1 | 0 | 60000 | 1 | 0 |
| chr1 | 0 | 100000 | 1 | 0 |
| chr1 | 0 | 140000 | 1 | 0 |
| chr1 | 0 | 180000 | 1 | 0 |
| chr1 | 0 | 220000 | 1 | 0 |

* **INTERSFILE** This file stores the information about interactions between fragment pairs. It should consist of 5 columns: first column and third column stand for the chromosome names of the fragment pair; second column and fourth column stand for midPoints of the fragment pair; fifth column stands for contact count between the two bins. Make sure that midpoints in this file match those in fragsfile and in biasfile (when normalization is applied). Make sure to use RAW contact counts and NOT the normalized counts. Use BIASFILE if normalization is to be taken into account (Highly suggested).

INTERSFILE

| Chromosome1.Name | Mid.Point.1 | Chromosome2.Name | Mid.Point.2 | Hit.Count |
| --- | --- | --- | --- | --- |
| chr1 | 100020000 | chr1 | 100100000 | 201 |
| chr1 | 100020000 | chr1 | 100140000 | 232 |
| chr1 | 100020000 | chr1 | 100180000 | 138 |
| chr1 | 100020000 | chr1 | 100220000 | 87 |
| chr1 | 100020000 | chr1 | 100260000 | 25 |
| chr1 | 100020000 | chr1 | 100300000 | 44 |

* **BIASFILE** FitHiC works with matrix balancing-based normalization methods such as (ICE, KR or Vanilla Coverage). These methods provide a bias value per bin/locus, the vector of which should be centered on 1 so that:
  bias = 1 (expected amount of count/visibility) bias > 1 (higher than expected count) bias < 1 (lower than expected count)

BIASFILE

| Chromosome.Name | Mid.Point | Bias |
| --- | --- | --- |
| chr1 | 20000 | 1 |
| chr1 | 60000 | 1 |
| chr1 | 100000 | 1 |
| chr1 | 140000 | 1 |
| chr1 | 180000 | 1 |
| chr1 | 220000 | 1 |

Besides, **OUTDIR**, the path where the output files will be stored, is also required to be specified.

## Support

For questions about the use of Fit-Hi-C method, to request pre-processed Hi-C data and/or additional features and scripts, or to report bugs and provide feedback please e-mail Ferhat Ay.

[Ferhat Ay](http://www.lji.org/faculty-research/labs/ay) <ferhatay at lji dot org>

Fit-Hi-C R package maintainer Ruyu Tan <rut003 at ucsd dot edu>