# miRNA affinity models and the KdModel class

Pierre-Luc Germain1,2, Michael Soutschek3 and Fridolin Gross3

1D-HEST Institute for Neuroscience, ETH
2Lab of Statistical Bioinformatics, UZH
3Lab of Systems Neuroscience, D-HEST Institute for Neuroscience, ETH

#### 30 October 2025

#### Abstract

This vignettes introduces the KdModel and KdModelList classes used for storing
miRNA 12-mer affinities and predicting the dissociation constant of specific
sites.

#### Package

scanMiR 1.16.0

# Contents

* [1 12-mer dissociation rates](#mer-dissociation-rates)
* [2 KdModels](#kdmodels)
  + [2.1 KdModelLists](#kdmodellists)
* [3 Creating a KdModel object](#creating-a-kdmodel-object)
* [4 Common KdModel collections](#common-kdmodel-collections)
* [5 Under the hood](#under-the-hood)
* [Session info](#session-info)

# 1 12-mer dissociation rates

[McGeary, Lin et al. (2019)](https://dx.doi.org/10.1126/science.aav1741) used
RNA bind-n-seq (RBNS) to empirically determine the affinities (i.e. dissoiation
rates) of selected miRNAs towards random 12-nucleotide sequences (termed
12-mers). As expected, bound sequences typically exhibited complementarity to
the miRNA seed region (positions 2-8 from the miRNA’s 5’ end), but the study
also revealed non-canonical bindings and the importance of flanking
di-nucleotides. Based on these data, the authors developed a model which
predicted 12-mer dissociation rates (KD) based on the miRNA sequence. ScanMiR
encodes a compressed version of these prediction in the form of a `KdModel`
object.

The 12-mer is defined as the 8 nucleotides opposite the miRNA’s extended seed
region plus flanking dinucleotides on either side:

![](data:image/png;base64...)

# 2 KdModels

The `KdModel` class contains the information concerning the sequence (12-mer)
affinity of a given miRNA, and is meant to compress and make easily manipulable
the dissociation constants (Kd) predictions from
[McGeary, Lin et al. (2019)](https://dx.doi.org/10.1126/science.aav1741).

We can take a look at the example `KdModel`:

```
library(scanMiR)
data(SampleKdModel)
SampleKdModel
```

```
## A `KdModel` for hsa-miR-155-5p (Conserved across mammals)
##   Sequence: UUAAUGCUAAUCGUGAUAGGGGUU
##   Canonical target seed: AGCATTA(A)
```

In addition to the information necessary to predict the binding affinity to any
given 12-mer sequence, the model contains, minimally, the name and sequence of
the miRNA. Since the `KdModel` class extends the list class, any further
information can be stored:

```
SampleKdModel$myVariable <- "test"
```

An overview of the binding affinities can be obtained with the following plot:

```
plotKdModel(SampleKdModel, what="seeds")
```

![](data:image/png;base64...)

The plot gives the -log(Kd) values of the top 7-mers (including both canonical
and non-canonical sites), with or without the final “A” vis-à-vis the first
miRNA nucleotide.

To predict the dissociation constant (and binding type, if any) of a given
12-mer sequence, you can use the `assignKdType` function:

```
assignKdType("ACGTACGTACGT", SampleKdModel)
```

```
##            type log_kd
## 1 non-canonical      0
```

```
# or using multiple sequences:
assignKdType(c("CTAGCATTAAGT","ACGTACGTACGT"), SampleKdModel)
```

```
##            type log_kd
## 1          8mer  -5129
## 2 non-canonical      0
```

The log\_kd column contains log(Kd) values multiplied by 1000 and stored as an
integer (which is more economical when dealing with millions of sites). In the
example above, -5129
means -5.129, or a dissociation constant of 0.0059225. The
smaller the values, the stronger the relative affinity.

## 2.1 KdModelLists

A `KdModelList` object is simply a collection of `KdModel` objects. We can
build one in the following way:

```
# we create a copy of the KdModel, and give it a different name:
mod2 <- SampleKdModel
mod2$name <- "dummy-miRNA"
kml <- KdModelList(SampleKdModel, mod2)
kml
```

```
## An object of class "KdModelList"
## [[1]]
## A `KdModel` for hsa-miR-155-5p (Conserved across mammals)
##   Sequence: UUAAUGCUAAUCGUGAUAGGGGUU
##   Canonical target seed: AGCATTA(A)
## [[2]]
## A `KdModel` for dummy-miRNA (Conserved across mammals)
##   Sequence: UUAAUGCUAAUCGUGAUAGGGGUU
##   Canonical target seed: AGCATTA(A)
```

```
summary(kml)
```

```
## A `KdModelList` object containing binding affinity models from 2 miRNAs.
##
##               Low-confidence             Poorly conserved
##                            0                            0
##     Conserved across mammals Conserved across vertebrates
##                            2                            0
```

Beyond operations typically performed on a list (e.g. subsetting), some
specific slots of the respective KdModels can be accessed, for example:

```
conservation(kml)
```

```
##           hsa-miR-155-5p              dummy-miRNA
## Conserved across mammals Conserved across mammals
## 4 Levels: Low-confidence Poorly conserved ... Conserved across vertebrates
```

# 3 Creating a KdModel object

`KdModel` objects are meant to be created from a table assigning a log\_kd
values to 12-mer target sequences, as produced by the CNN from McGeary, Lin et
al. (2019). For the purpose of example, we create such a dummy table:

```
kd <- dummyKdData()
head(kd)
```

```
##         X12mer log_kd
## 1 AAAGCAAAAAAA -0.428
## 2 CAAGCACAAACA -0.404
## 3 GAAGCAGAAAGA -0.153
## 4 TAAGCATAAATA -1.375
## 5 ACAGCAACAAAC -0.448
## 6 CCAGCACCAACC -0.274
```

A `KdModel` object can then be created with:

```
mod3 <- getKdModel(kd=kd, mirseq="TTAATGCTAATCGTGATAGGGGTT", name = "my-miRNA")
```

Alternatively, the `kd` argument can also be the path to the output file of the
CNN (and if `mirseq` and `name` are in the table, they can be omitted).

# 4 Common KdModel collections

The [scanMiRData](https://github.com/ETHZ-INS/scanMiRData) package contains
`KdModel` collections corresponding to all human, mouse and rat mirbase miRNAs.

# 5 Under the hood

When calling `getKdModel`, the dissociation constants are stored as an
lightweight overfitted linear model, with base KDs coefficients (stored as
integers in `object$mer8`) for each 1024 partially-matching 8-mers (i.e. at
least 4 consecutive matching nucleotides) to which are added 8-mer-specific
coefficients (stored in `object$fl`) that are multiplied with a flanking score
generated by the flanking di-nucleotides. The flanking score is calculated
based on the di-nucleotide effects experimentally measured by McGeary, Lin et
al. (2019). To save space, the actual 8-mer sequences are not stored but
generated when needed in a deterministic fashion. The 8-mers can be obtained,
in the right order, with the `getSeed8mers` function.

# Session info

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] scanMiR_1.16.0   BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] sass_0.4.10          generics_0.1.4       stringi_1.8.7
##  [4] digest_0.6.37        magrittr_2.0.4       evaluate_1.0.5
##  [7] grid_4.5.1           RColorBrewer_1.1-3   bookdown_0.45
## [10] fastmap_1.2.0        jsonlite_2.0.0       BiocManager_1.30.26
## [13] scales_1.4.0         Biostrings_2.78.0    codetools_0.2-20
## [16] jquerylib_0.1.4      cli_3.6.5            rlang_1.1.6
## [19] crayon_1.5.3         XVector_0.50.0       cowplot_1.2.0
## [22] withr_3.0.2          cachem_1.1.0         yaml_2.3.10
## [25] tools_4.5.1          parallel_4.5.1       BiocParallel_1.44.0
## [28] seqLogo_1.76.0       dplyr_1.1.4          ggplot2_4.0.0
## [31] BiocGenerics_0.56.0  vctrs_0.6.5          R6_2.6.1
## [34] stats4_4.5.1         lifecycle_1.0.4      pwalign_1.6.0
## [37] Seqinfo_1.0.0        S4Vectors_0.48.0     IRanges_2.44.0
## [40] pkgconfig_2.0.3      pillar_1.11.1        bslib_0.9.0
## [43] gtable_0.3.6         glue_1.8.0           data.table_1.17.8
## [46] xfun_0.53            tibble_3.3.0         GenomicRanges_1.62.0
## [49] tidyselect_1.2.1     knitr_1.50           dichromat_2.0-0.1
## [52] farver_2.1.2         htmltools_0.5.8.1    labeling_0.4.3
## [55] rmarkdown_2.30       compiler_4.5.1       S7_0.2.0
```