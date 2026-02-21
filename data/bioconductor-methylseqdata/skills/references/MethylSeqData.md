# Overview of the MethylSeqData dataset collection

Peter Hickey1\*

1Advanced Biology and Technology Division, Walter and Eliza Hall Institute of Medical Research

\*peter.hickey@gmail.com

#### Created: Oct 02, 2020; Compiled: 2025-11-04

#### Package

MethylSeqData 1.20.0

# Contents

* [1 Introduction](#introduction)
* [2 Available data sets](#available-data-sets)
* [3 Adding new data sets](#adding-new-data-sets)
* [References](#references)

# 1 Introduction

The *[MethylSeqData](https://bioconductor.org/packages/3.22/MethylSeqData)* package provides convenient access to several publicly available data sets in the form of *SummarizedExperiment* objects.
The focus of this package is to capture datasets that are not easily read into R with a one-liner from, e.g., `read.csv()`.
Instead, we do the necessary data munging so that users only need to call a single function to obtain a well-formed *SummarizedExperiment*`.
For example:

```
library(MethylSeqData)
brain <- RizzardiHickeyBrain()
brain
```

```
## class: RangedSummarizedExperiment
## dim: 24044157 72
## metadata(0):
## assays(2): M Cov
## rownames: NULL
## rowData names(0):
## colnames(72): 5085_NAcc_unsorted 5086_BA9_unsorted ... 5628_NAcc_neg
##   5628_NAcc_pos
## colData names(3): donor neun tissue
```

Readers are referred to the *[SummarizedExperiment](https://bioconductor.org/packages/3.22/SummarizedExperiment)* documentation
for further information on how to work with *SummarizedExperiment* objects.

# 2 Available data sets

The `listDatasets()` function returns all available datasets in *[MethylSeqData](https://bioconductor.org/packages/3.22/MethylSeqData)*, along with some summary statistics and the necessary R command to load them.

```
out <- listDatasets()
```

| Reference | Taxonomy | Part | Number | Call |
| --- | --- | --- | --- | --- |
| Rizzardi et al. ([2019](#ref-rizzardi2019neuronal)) | Human | brain | 72 | `RizzardiHickeyBrain()` |
| Chen et al. ([2018](#ref-chen2017mammary)) | Mouse | mammary gland | 6 | `ChenMammaryData()` |

# 3 Adding new data sets

Please contact us if you have a data set that you would like to see added to this package.
The only requirement is that your data set has publicly available count matrices and sample annotation.
The more difficult/custom the format, the better, as its inclusion in this package will provide more value for other users in the R/Bioconductor community.

If you have already written code that processes your desired data set in a *SummarizedExperiment*-like form, we would welcome a pull request [here](https://github.com/PeteHaitch/MethylSeqData).
The process can be expedited by ensuring that you have the following files:

* `inst/scripts/make-X-Y-data.Rmd`, a Rmarkdown report that creates all components of a `SingleCellExperiment`.
  `X` should be the last name of the first author of the relevant study while `Y` should be the name of the biological system.
* `inst/scripts/make-X-Y-metadata.R`, an R script that creates a metadata CSV file at `inst/extdata/metadata-X-Y.csv`.
  Metadata files should follow the format described in the *[ExperimentHub](https://bioconductor.org/packages/3.22/ExperimentHub)* documentation.
* `R/XYData.R`, an R source file that defines a function `XYData()` to download the components from ExperimentHub and creates a *SummarizedExperiment* object.

Potential contributors are recommended to examine some of the existing scripts in the package to pick up the coding conventions.
Remember, we’re more likely to accept a contribution if it’s indistinguishable from something we might have written ourselves!

# References

Chen, Y, B Pal, JE Visvader, and GK Smyth. 2018. “Differential Methylation Analysis of Reduced Representation Bisulfite Sequencing Experiments Using edgeR [Version 2; Peer Review: 2 Approved, 1 Approved with Reservations].” *F1000Research* 6 (2055). <https://doi.org/10.12688/f1000research.13196.2>.

Rizzardi, Lindsay F, Peter F Hickey, Varenka Rodriguez DiBlasi, Rakel Tryggvadóttir, Colin M Callahan, Adrian Idrizi, Kasper D Hansen, and Andrew P Feinberg. 2019. “Neuronal Brain-Region-Specific Dna Methylation and Chromatin Accessibility Are Associated with Neuropsychiatric Trait Heritability.” *Nature Neuroscience* 22 (2): 307–16.