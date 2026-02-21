# The bnbc User’s Guide

Kipper Fletez-Brant and Kasper Daniel Hansen

#### 29 October 2025

#### Abstract

A comprehensive guide to using the bnbc package for normalizing Hi-C replicates.

#### Package

bnbc 1.32.0

# 1 Introduction

The *[bnbc](https://bioconductor.org/packages/3.22/bnbc)* package provides functionality to perform normalization and batch correction **across samples** on data obtained from Hi-C (Lieberman-Aiden et al. [2009](#ref-HiCassay)) experiments.

In this package we implement tools for general subsetting of and data extraction from sets of Hi-C contact matrices, as well as smoothing of contact matrices, cross-sample normalization and cross-sample batch effect correction methods.

*[bnbc](https://bioconductor.org/packages/3.22/bnbc)* expects as input

1. a `GRanges` object representing the genome assayed, with individual ranges having the width that is equal to the bin size used to partition the genome.
2. a `list` of (square) contact matrices.
3. a `DataFrame` object containing sample-level covariates (i.e. gender, date of processing, etc).

## 1.1 Citing bnbc

If you use this package, please cite (Fletez-Brant et al. [2017](#ref-bnbc)).

## 1.2 Terminology

It is well appreciated that Hi-C contact matrices exhibit an exponential decay in observed number of contacts as a function of the distance between the pair of interacting loci. In this work we operate, as has recently been done (i.e. (Yang et al. [2017](#ref-HiCRep))), on the set of all loci interacting at a specific distance, one chromosome at a time. For a given distance \(k\), the relevant set of loci are listed in each contact matrix as the entries comprising the \(k\)-th matrix diagonal (with the main diagonal being referred to as the first diagonal). We refer to these diagonals as matrix “bands”.

## 1.3 Dependencies

This document has the following dependencies

```
library(bnbc)
library(HiCBricks)
library(BSgenome.Hsapiens.UCSC.hg19)

hg19 <- BSgenome.Hsapiens.UCSC.hg19
```

# 2 The ContactGroup class from bnbc

*[bnbc](https://bioconductor.org/packages/3.22/bnbc)* uses the `ContactGroup` class to represent the set of contact matrices for a given set of genomic locis interactions. The class has 3 slots:

* `rowData`: a `GRanges` object that has 1 element for each bin of the partitioned genome.
* `colData`: a `DataFrame` object that contains information on each sample (i.e. gender).
* `contacts`: a `list` of contact matrices.

We expect each `ContactGroup` to represent data from 1 chromosome. We are thinking about a whole-genome container. An example dataset for chromosome 22 is supplied with the package.

```
data(cgEx)
cgEx
```

```
## Object of class `ContactGroup` representing contact matrices with
##  1282 bins
##  40 kb average width per bin
##  14 samples
```

Creating a `ContactGroup` object requires specifying the 3 slots above:

```
cgEx <- ContactGroup(rowData=rowData(cgEx),
                     contacts=contacts(cgEx),
                     colData=colData(cgEx))
```

Note that in this example, we used the accessor methods for each of these slots; there are also corresponding ‘setter’ methods, such as `rowData(cgEx)<-`.

Printing a `ContactGroup` object gives the number of bins represented by the `rowData` slot, the width of the bin in terms of genomic distances (i.e. 100kb) and the number of samples:

```
cgEx
```

```
## Object of class `ContactGroup` representing contact matrices with
##  1282 bins
##  40 kb average width per bin
##  14 samples
```

## 2.1 Alternatives

The *[InteractionSet](https://bioconductor.org/packages/3.22/InteractionSet)* package contains a class called `InteractionSet` which is essentially an extension of the `ContactGroup` class. The internal storage format is different and `InteractionSet` is not restricted to square contact matrices like the `ContactGroup` class. We are interested in porting the `bnbc()` function to using `InteractionSet`, but `bnbc()` extensively uses band matrices and we have optimized *[Rcpp](https://CRAN.R-project.org/package%3DRcpp)*-based routines for getting and setting bands of normal matrices, which means `ContactGroup` is a pretty fast for our purposes.

# 3 Getting your data into bnbc

To get data into *[bnbc](https://bioconductor.org/packages/3.22/bnbc)* you need a list of contact matrices, one per sample. We assume the contact matrices are square, with no missing values. We do not require that data have been transformed or pre-processed by various bias correction software and provide methods for some simple pre-processing techniques.

There is currently no standard Hi-C data format. Instead, different groups produces custom formats, often in forms of text files. Because contact matrices are square, it is common to only distribute the upper or lower triangular matrix. In that case, you can use the following trick to make the matrix square:

```
mat <- matrix(1:9, nrow = 3, ncol = 3)
mat[lower.tri(mat)] <- 0
mat
```

```
##      [,1] [,2] [,3]
## [1,]    1    4    7
## [2,]    0    5    8
## [3,]    0    0    9
```

```
## Now we fill in the lower triangular matrix with the upper triangular
mat[lower.tri(mat)] <- mat[upper.tri(mat)]
mat
```

```
##      [,1] [,2] [,3]
## [1,]    1    4    7
## [2,]    4    5    8
## [3,]    7    8    9
```

Below, we demonstrate the steps needed to convert a set of hypothetical contact matrices into a `ContactGroup` object. The object `upper.mats.list` is supposed to be a list of contact matrices, each represented as an upper triangular matrix. We also suppose `LociData` to be a `GenomicRanges` object containing the loci of the contact matrices, and `SampleData` to be a `DataFrame` of per-sample information (i.e. cell type, sample name etc). We first convert all contact matrices to be symmetric matrices, then use the constructor method `ContactGroup()` to create the object.

```
## Example not run
## Convert upper triangles to symmetry matrix
MatsList <- lapply(upper.mats.list, function(M) {
    M[lower.tri(M)] <- M[upper.tri(M)]
})
## Use ContactGroup constructor method
cg <- ContactGroup(rowData = LociData, contacts = MatsList, colData = SampleData)
```

For this to work, the `contacts` list has to have the same names as the rownames of `colData`.

## 3.1 Getting your data out of `*.cooler` files

The `.cooler` file format is widely adopted and supported by `bnbc`. We assume a simple cooler file format (see `?getChrCGFromCools` for a full description; importantly, we assume the same interactions are observed in all samples, even if some have a value of 0) of one resolution per file, generated by the `cooler` program. Our point of entry is to catalog which interactions are stored in the cooler file. We do this by generating an index of the positions of the file, using the function `getGenomeIdx()`.

```
coolerDir <- system.file("cooler", package = "bnbc")
cools <- list.files(coolerDir, pattern="mcool$", full.names=TRUE)

step <- 4e4

ixns <- bnbc:::getChrIdx(seqlengths(hg19)["chr22"], "chr22", step)
```

We have, as output the `GRanges` object `ixns`. With our index, we can proceed to load our data into memory, one chromosome’s data at a time (at this time our method does not handle -interactions). We emphasize that with all observations from interactions between loci on one chromosome in memory, our algorithm is extremely efficient, with custom routines for matrix updating, and requires only pass over the data.

```
dir.create("tmp")

cool.cg <- bnbc:::getChrCGFromCools(files = cools,
                                    chr = "chr22",
                                    step = step,
                                    index.gr = ixns,
                                    work.dir = "tmp",
                                    exp.name = "example",
                                    coldata = colData(cgEx)[1:2,])
```

```
## GM19238_Rep1.mcool
```

```
## Provided mcool is a version 3 file.
```

```
## All ok! Chrom, Start, End have matching lengths...
```

```
## Warning: The `path` argument of `write_lines()` is deprecated as of readr 1.4.0.
## ℹ Please use the `file` argument instead.
## ℹ The deprecated feature was likely used in the HiCBricks package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Making read indices...
```

```
## Read 822403 records...
```

```
## Row segment: chr22:1:1283; Col segment: chr22:1:1283
```

```
## GM19238_Rep2.mcool
```

```
## Provided mcool is a version 3 file.
```

```
## All ok! Chrom, Start, End have matching lengths...
```

```
## Making read indices...
```

```
## Read 822403 records...
```

```
## Row segment: chr22:1:1283; Col segment: chr22:1:1283
```

```
all.equal(contacts(cgEx)[[1]], contacts(cool.cg)[[1]])
```

```
## [1] "Attributes: < Component \"dim\": Mean relative difference: 0.0007800312 >"
## [2] "Numeric: lengths (1643524, 1646089) differ"
```

In this example, we load the `ContactGroup` object `cgEx` into memory to compare with the representation of it in `cool` files generated by the `cooler` program. We then use the method `getChrCGFromCools()` to load an entire chromosome’s interaction matrices (observed on all subjects) into memory. At this point, users have a valid `ContactGroup` object, and can proceed with their analyses as described in subsequent sections.

# 4 Working with bnbc contact matrices

We provide setter and getter methods for manipulating individual matrix bands for contact matrices as well. First, we have functions for working with bands of individual matrices (not bnbc related):

```
mat.1 <- contacts(cgEx)[[1]]
mat.1[1000:1005, 1000:1005]
```

```
##      [,1] [,2] [,3] [,4] [,5] [,6]
## [1,]    5   30   36   32   53   20
## [2,]   30    7   36   38   50   16
## [3,]   36   36    3   44   51   15
## [4,]   32   38   44    4   89   39
## [5,]   53   50   51   89   36   55
## [6,]   20   16   15   39   55    5
```

```
b1 <- band(mat=mat.1, band.no=2)
band(mat=mat.1, band.no=2) <- b1 + 1
mat.1[1000:1005, 1000:1005]
```

```
##      [,1] [,2] [,3] [,4] [,5] [,6]
## [1,]    5   31   36   32   53   20
## [2,]   31    7   37   38   50   16
## [3,]   36   37    3   45   51   15
## [4,]   32   38   45    4   90   39
## [5,]   53   50   51   90   36   56
## [6,]   20   16   15   39   56    5
```

In this example, the main diagonal of the contact matrix is also the main diagonal of the printed example above. Similarly, band number two, which is also the first off-diagonal, is also the first off-diagonal of the printed example. As can be seen from the printed example, updating a matrix band is a symmetric operation, and updated the first off-diagonal in both the upper and lower triangles of the matrix.

To utilize this across a list of contact matrices, we have the `cgApply()` function which applies the same function to each of the matrices. It supports parallelization using *[parallel](https://CRAN.R-project.org/package%3Dparallel)*.

# 5 Per-Sample Adjustments

To adjust for differences in depth sequencing, we first apply the `logCPM` transform (Law et al. [2014](#ref-voom)) to each contact matrix. This transformation divides each contact matrix by the sum of the upper triangle of that matrix (adding 0.5 to each matrix cell and 1 to sum of the upper triangle), scales the resulting matrix by \(10^6\) and finally takes the log of the scaled matrix (a fudge factor is added to both numerator and denominator prior to taking the logarithm)..

```
cgEx.cpm <- logCPM(cgEx)
```

Additionally, we smooth each contact matrix with a square smoothing kernel to reduce artifacts of the choice of bin width. We support both box and Gaussian smoothers.

```
cgEx.smooth <- boxSmoother(cgEx.cpm, h=5)
## or
## cgEx.smooth <- gaussSmoother(cgEx.cpm, radius=3, sigma=4)
```

# 6 Cross Sample Normalization

BNBC operates on each matrix band separately. For each matrix band \(k\), we extract each sample’s observation on that band and form a matrix \(M\) from those bands; if band \(k\) has \(d\) entries, then after `logCPM` transformation, \(M \in \mathbb{R}^{n \times d}\). For each such matrix, we first apply quantile normalization (Bolstad et al. [2003](#ref-QN)) to correct for distributional differences, and then ComBat (Johnson, Li, and Rabinovic [2007](#ref-ComBat)) to correct for batch effects.

Here we will use *[bnbc](https://bioconductor.org/packages/3.22/bnbc)* to do batch correction on the first 10 matrix bands, beginning with the second matrix band and ending on the eleventh.

```
cgEx.bnbc <- bnbc(cgEx.smooth, batch=colData(cgEx.smooth)$Batch,
                  threshold=1e7, step=4e4, nbands=11, verbose=FALSE)
```

```
## Found 82 genes with uniform expression within a single batch (all zeros); these will not be adjusted for batch.
## Found 79 genes with uniform expression within a single batch (all zeros); these will not be adjusted for batch.
## Found 66 genes with uniform expression within a single batch (all zeros); these will not be adjusted for batch.
## Found 94 genes with uniform expression within a single batch (all zeros); these will not be adjusted for batch.
## Found 86 genes with uniform expression within a single batch (all zeros); these will not be adjusted for batch.
## Found 93 genes with uniform expression within a single batch (all zeros); these will not be adjusted for batch.
## Found 63 genes with uniform expression within a single batch (all zeros); these will not be adjusted for batch.
## Found 78 genes with uniform expression within a single batch (all zeros); these will not be adjusted for batch.
## Found 86 genes with uniform expression within a single batch (all zeros); these will not be adjusted for batch.
## Found 69 genes with uniform expression within a single batch (all zeros); these will not be adjusted for batch.
```

# 7 sessionInfo()

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
## [1] grid      stats4    stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] BSgenome.Hsapiens.UCSC.hg19_1.4.3 BSgenome_1.78.0
##  [3] rtracklayer_1.70.0                BiocIO_1.20.0
##  [5] Biostrings_2.78.0                 XVector_0.50.0
##  [7] HiCBricks_1.28.0                  R6_2.6.1
##  [9] rhdf5_2.54.0                      curl_7.0.0
## [11] bnbc_1.32.0                       SummarizedExperiment_1.40.0
## [13] Biobase_2.70.0                    GenomicRanges_1.62.0
## [15] Seqinfo_1.0.0                     IRanges_2.44.0
## [17] S4Vectors_0.48.0                  MatrixGenerics_1.22.0
## [19] matrixStats_1.5.0                 BiocGenerics_0.56.0
## [21] generics_0.1.4                    BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] DBI_1.2.3                bitops_1.0-9             gridExtra_2.3
##   [4] rlang_1.1.6              magrittr_2.0.4           compiler_4.5.1
##   [7] RSQLite_2.4.3            mgcv_1.9-3               png_0.1-8
##  [10] fftwtools_0.9-11         vctrs_0.6.5              reshape2_1.4.4
##  [13] sva_3.58.0               stringr_1.5.2            pkgconfig_2.0.3
##  [16] crayon_1.5.3             fastmap_1.2.0            Rsamtools_2.26.0
##  [19] rmarkdown_2.30           tzdb_0.5.0               preprocessCore_1.72.0
##  [22] bit_4.6.0                xfun_0.53                cachem_1.1.0
##  [25] cigarillo_1.0.0          jsonlite_2.0.0           blob_1.2.4
##  [28] rhdf5filters_1.22.0      DelayedArray_0.36.0      Rhdf5lib_1.32.0
##  [31] BiocParallel_1.44.0      jpeg_0.1-11              tiff_0.1-12
##  [34] parallel_4.5.1           bslib_0.9.0              stringi_1.8.7
##  [37] RColorBrewer_1.1-3       limma_3.66.0             genefilter_1.92.0
##  [40] jquerylib_0.1.4          Rcpp_1.1.0               bookdown_0.45
##  [43] knitr_1.50               R.utils_2.13.0           readr_2.1.5
##  [46] Matrix_1.7-4             splines_4.5.1            tidyselect_1.2.1
##  [49] dichromat_2.0-0.1        abind_1.4-8              yaml_2.3.10
##  [52] viridis_0.6.5            EBImage_4.52.0           codetools_0.2-20
##  [55] lattice_0.22-7           tibble_3.3.0             plyr_1.8.9
##  [58] KEGGREST_1.50.0          S7_0.2.0                 evaluate_1.0.5
##  [61] archive_1.1.12           survival_3.8-3           pillar_1.11.1
##  [64] BiocManager_1.30.26      vroom_1.6.6              RCurl_1.98-1.17
##  [67] hms_1.1.4                ggplot2_4.0.0            scales_1.4.0
##  [70] xtable_1.8-4             glue_1.8.0               tools_4.5.1
##  [73] data.table_1.17.8        GenomicAlignments_1.46.0 annotate_1.88.0
##  [76] locfit_1.5-9.12          XML_3.99-0.19            AnnotationDbi_1.72.0
##  [79] edgeR_4.8.0              nlme_3.1-168             restfulr_0.0.16
##  [82] cli_3.6.5                S4Arrays_1.10.0          viridisLite_0.4.2
##  [85] dplyr_1.1.4              gtable_0.3.6             R.methodsS3_1.8.2
##  [88] sass_0.4.10              digest_0.6.37            SparseArray_1.10.0
##  [91] rjson_0.2.23             htmlwidgets_1.6.4        farver_2.1.2
##  [94] R.oo_1.27.1              memoise_2.0.1            htmltools_0.5.8.1
##  [97] lifecycle_1.0.4          httr_1.4.7               statmod_1.5.1
## [100] bit64_4.6.0-1
```

# References

Bolstad, B M, R A Irizarry, M Astrand, and T P Speed. 2003. “A Comparison of Normalization Methods for High Density Oligonucleotide Array Data Based on Variance and Bias.” *Bioinformatics* 19: 185–93. <https://doi.org/10.1093/bioinformatics/19.2.185>.

Fletez-Brant, Kipper, Yunjiang Qiu, David U Gorkin, Ming Hu, and Kasper D Hansen. 2017. “Removing Unwanted Variation Between Samples in Hi-C Experiments.” *bioRxiv*, 214361. <https://doi.org/10.1101/214361>.

Johnson, W Evan, Cheng Li, and Ariel Rabinovic. 2007. “Adjusting Batch Effects in Microarray Expression Data Using Empirical Bayes Methods” 8: 118–27. <https://doi.org/10.1093/biostatistics/kxj037>.

Law, Charity W, Yunshun Chen, Wei Shi, and Gordon K Smyth. 2014. “Voom: Precision Weights Unlock Linear Model Analysis Tools for RNA-seq Read Counts.” *Genome Biology* 15: R29. <https://doi.org/10.1186/gb-2014-15-2-r29>.

Lieberman-Aiden, Erez, Nynke L van Berkum, Louise Williams, Maxim Imakaev, Tobias Ragoczy, Agnes Telling, Ido Amit, et al. 2009. “Comprehensive Mapping of Long-Range Interactions Reveals Folding Principles of the Human Genome.” *Science* 326: 289–93. <https://doi.org/10.1126/science.1181369>.

Yang, Tao, Feipeng Zhang, Galip Gurkan Yardimci, Fan Song, Ross C Hardison, William Stafford Noble, Feng Yue, and Qunhua Li. 2017. “HiCRep: Assessing the Reproducibility of Hi-C Data Using a Stratum- Adjusted Correlation Coefficient.” *Genome Research*. <https://doi.org/10.1101/gr.220640.117>.