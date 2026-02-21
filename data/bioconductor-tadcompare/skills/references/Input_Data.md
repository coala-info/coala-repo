# Input data formats

Kellen Cresswell1 and Mikhail Dozmorov1

1Department of Biostatistics, Virginia Commonwealth University, Richmond, VA

#### 30 October 2025

# Contents

* [1 Introduction](#introduction)
* [2 Getting Started](#getting-started)
  + [2.1 Installation](#installation)
* [3 Working with different types of data](#working-with-different-types-of-data)
  + [3.1 Working with \(n \times n\) matrices](#working-with-n-times-n-matrices)
  + [3.2 Working with \(n \times (n+3)\) matrices](#working-with-n-times-n3-matrices)
  + [3.3 Working with sparse 3-column matrices](#working-with-sparse-3-column-matrices)
  + [3.4 Working with other data types](#working-with-other-data-types)
  + [3.5 Working with .hic files](#working-with-.hic-files)
  + [3.6 Working with .cool files](#working-with-.cool-files)
  + [3.7 Working with HiC-Pro files](#working-with-hic-pro-files)
  + [3.8 Effect of matrix type on runtime](#effect-of-matrix-type-on-runtime)
* [4 Session Info](#session-info)
* [References](#references)

# 1 Introduction

TADCompare is an R package for differential analysis of TAD boundaries. It is designed to work on a wide range of formats and resolutions of Hi-C data. TADCompare package contains four functions: `TADCompare`, `TimeCompare`, `ConsensusTADs`, and `DiffPlot`. `TADCompare` function allows for the identification of differential TAD boundaries between [two contact matrices](TADCompare.html#tadcompare). `TimeCompare` function takes a set of contact matrices, one matrix per time point, identifies TAD boundaries, and classifies [how they change over time](TADCompare.html#timecompare). `ConsensusTADs` function takes a list of TADs and identifies a consensus of TAD boundaries across all matrices using our [novel consensus boundary score](TADCompare.html#consensustads). `DiffPlot` allows for [visualization of TAD boundary differences](TADCompare.html#visualization) between two matrices. The required input includes matrices in sparse 3-column format, \(n \times n\), or \(n \times (n+3)\) formats. This vignette provides a complete overview of input data formats.

# 2 Getting Started

## 2.1 Installation

```
BiocManager::install("TADCompare")
```

```
library(dplyr)
```

```
##
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:stats':
##
##     filter, lag
```

```
## The following objects are masked from 'package:base':
##
##     intersect, setdiff, setequal, union
```

```
library(SpectralTAD)
library(TADCompare)
```

# 3 Working with different types of data

## 3.1 Working with \(n \times n\) matrices

\(n \times n\) contact matrices are most commonly associated with data coming from the Bing Ren lab (<http://chromosome.sdsc.edu/mouse/hi-c/download.html>). These contact matrices are square and symmetric with entry \(ij\) corresponding to the number of contacts between region \(i\) and region \(j\). Below is an example of a \(5 \times 5\) region of an \(n \times n\) contact matrix derived from Rao et al. 2014 data, GM12878 cell line (Rao et al. [2014](#ref-Rao:2014aa)), chromosome 22, 50kb resolution. Note the symmetry around the diagonal - the typical shape of chromatin interaction matrix. The figure was created using the [pheatmap](https://cran.r-project.org/web/packages/pheatmap/index.html) package.

![](data:image/png;base64...)

## 3.2 Working with \(n \times (n+3)\) matrices

\(n \times (n+3)\) matrices are commonly associated with the `TopDom` TAD caller (<http://zhoulab.usc.edu/TopDom/>). These matrices consist of an \(n \times n\) matrix but with three additional leading columns containing the chromosome, the start of the region and the end of the region. Regions in this case are determined by the resolution of the data. The subset of a typical \(n \times (n+3)\) matrix is shown below.

```
##     chr    start      end X18500000 X18550000 X18600000 X18650000
## 1 chr22 18500000 18550000     13313      4817      1664        96
## 2 chr22 18550000 18600000      4817     15500      5120       178
## 3 chr22 18600000 18650000      1664      5120     11242       316
## 4 chr22 18650000 18700000        96       178       316       162
```

## 3.3 Working with sparse 3-column matrices

Sparse 3-column matrices are matrices where the first and second columns refer to region \(i\) and region \(j\) of the chromosome, and the third column is the number of contacts between them. This style is becoming increasingly popular and is associated with raw data from Lieberman-Aiden lab (e.g., <https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE63525>), and is the data output produced by the Juicer tool (Durand et al. [2016](#ref-Durand:2016aa)). 3-column matrices are handled internally in the package by converting them to \(n \times n\) matrices using the [HiCcompare](https://bioconductor.org/packages/release/bioc/html/HiCcompare.html) package’s `sparse2full()` function. The first 5 rows of a typical sparse 3-column matrix are shown below.

```
##     region1  region2    IF
##       <num>    <num> <num>
## 1: 16050000 16050000    12
## 2: 16200000 16200000     4
## 3: 16150000 16300000     1
## 4: 16200000 16300000     1
## 5: 16250000 16300000     1
## 6: 16300000 16300000    10
```

## 3.4 Working with other data types

## 3.5 Working with .hic files

.hic files are a common form of files generally associated with the lab of Erez Lieberman-Aiden (<http://aidenlab.org/data.html>). To use .hic files you must use the following steps.

1. Download `straw` from <https://github.com/aidenlab/straw/> and follow instalation instructions.
2. Download .hic data files. Here, we use data from Rao 2014 and download them using the following commands:

`wget ftp://ftp.ncbi.nlm.nih.gov/geo/series/GSE63nnn/GSE63525/suppl/GSE63525_GM12878_insitu_primary_30.hic`

`wget ftp://ftp.ncbi.nlm.nih.gov/geo/series/GSE63nnn/GSE63525/suppl/GSE63525_GM12878_insitu_replicate.hic`

3. Extract chromosome 22 at 50kb resolution with no normalization:

`./straw NONE GSE63525_GM12878_insitu_primary_30.hic 22 22 BP 50000 > primary.chr22.50kb.txt`

`./straw NONE GSE63525_GM12878_insitu_replicate_30.hic 22 22 BP 50000 > replicate.chr22.50kb.txt`

4. Analyze normally:

```
#Read in data
primary = read.table('primary.chr22.50kb.txt', header = FALSE)
replicate = read.table('replicate.chr22.50kb.txt', header = FALSE)
#Run TADCompare
tad_diff=TADCompare(primary, replicate, resolution=50000)
```

## 3.6 Working with .cool files

Users can also find TADs from data output by `cooler` (<http://cooler.readthedocs.io/en/latest/index.html>) and HiC-Pro (<https://github.com/nservant/HiC-Pro>) with minor pre-processing using the [HiCcompare](https://bioconductor.org/packages/release/bioc/html/HiCcompare.html) package.

The cooler software can be downloaded from <https://mirnylab.github.io/cooler/>. A catalog of popular HiC datasets can be found at ftp://cooler.csail.mit.edu/coolers. We can extract chromatin interaction data from .cool files using the following steps:

1. Follow instructions to install the cooler software, <https://mirnylab.github.io/cooler/>
2. Download the first contact matrix wget ftp://cooler.csail.mit.edu/coolers/hg19/Zuin2014-HEK293CtcfControl-HindIII-allreps-filtered.50kb.cool
3. Convert the first matrix to a text file using `cooler dump --join Zuin2014-HEK293CtcfControl-HindIII-allreps-filtered.50kb.cool > Zuin.HEK293.50kb.Control.txt`
4. Download the second contact matrix wget ftp://cooler.csail.mit.edu/coolers/hg19/Zuin2014-HEK293CtcfDepleted-HindIII-allreps-filtered.50kb.cool
5. Convert the matrix to a text file using `cooler dump --join Zuin2014-HEK293CtcfDepleted-HindIII-allreps-filtered.50kb.cool > Zuin.HEK293.50kb.Depleted.txt`
6. Run the code below

```
# Read in data
cool_mat1 <- read.table("Zuin.HEK293.50kb.Control.txt")
cool_mat2 <- read.table("Zuin.HEK293.50kb.Depleted.txt")

# Convert to sparse 3-column matrix using cooler2sparse from HiCcompare
sparse_mat1 <- HiCcompare::cooler2sparse(cool_mat1)
sparse_mat2 <- HiCcompare::cooler2sparse(cool_mat2)

# Run TADCompare
diff_tads = lapply(names(sparse_mat1), function(x) {
  TADCompare(sparse_mat1[[x]], sparse_mat2[[x]], resolution = 50000)
})
```

## 3.7 Working with HiC-Pro files

HiC-Pro data is represented as two files, the `.matrix` file and the `.bed` file. The `.bed` file contains four columns (chromosome, start, end, ID). The `.matrix` file is a three-column matrix where the 1st and 2nd columns contain region IDs that map back to the coordinates in the bed file, and the third column contains the number of contacts between the two regions. In this example we analyze two matrix files `sample1_100000.matrix` and `sample2_100000.matrix`and their corresponding bed files `sample1_100000_abs.bed` and `sample2_100000_abs.bed`. We do not include HiC-Pro data in the package, so these serve as placeholders for the traditional files output by HiC-Pro. The steps for analyzing these files is shown below:

```
# Read in both files
mat1 <- read.table("sample1_100000.matrix")
bed1 <- read.table("sample1_100000_abs.bed")

# Matrix 2

mat2 <- read.table("sample2_100000.matrix")
bed2 <- read.table("sample2_100000_abs.bed")

# Convert to modified bed format
sparse_mats1 <- HiCcompare::hicpro2bedpe(mat1,bed1)
sparse_mats2 <- HiCcompare::hicpro2bedpe(mat2,bed2)

# Remove empty matrices if necessary
# sparse_mats$cis = sparse_mats$cis[sapply(sparse_mats, nrow) != 0]

# Go through all pairwise chromosomes and run TADCompare
sparse_tads = lapply(1:length(sparse_mats1$cis), function(z) {
  x <- sparse_mats1$cis[[z]]
  y <- sparse_mats2$cis[[z]]

  #Pull out chromosome
  chr <- x[, 1][1]
  #Subset to make three column matrix
  x <- x[, c(2, 5, 7)]
  y <- y[, c(2, 5, 7)]
  #Run SpectralTAD
  comp <- TADCompare(x, y, resolution = 100000)
  return(list(comp, chr))
})

# Pull out differential TAD results
diff_res <- lapply(sparse_tads, function(x) x$comp)
# Pull out chromosomes
chr      <- lapply(sparse_tads, function(x) x$chr)
# Name list by corresponding chr
names(diff_res) <- chr
```

## 3.8 Effect of matrix type on runtime

The type of matrix input into the algorithm can affect runtimes for the algorithm. \(n \times n\) matrices require no conversion and are the fastest. Meanwhile, \(n \times (n+3)\) matrices take slightly longer to run due to the need to remove the first 3 columns. Sparse 3-column matrices have the highest runtimes due to the complexity of converting them to an \(n \times n\) matrix. The times are summarized below, holding all other parameters constant.

```
library(microbenchmark)
# Reading in the second matrix
data("rao_chr22_rep")
# Converting to sparse
prim_sparse <- HiCcompare::full2sparse(rao_chr22_prim)
rep_sparse  <- HiCcompare::full2sparse(rao_chr22_rep)
# Converting to nxn+3
# Primary
prim_n_n_3 <- data.frame(chr = "chr22",
                         start = as.numeric(colnames(rao_chr22_prim)),
                         end = as.numeric(colnames(rao_chr22_prim))+50000,
                         rao_chr22_prim)

# Replicate
rep_n_n_3 <- data.frame(chr = "chr22",
                        start = as.numeric(colnames(rao_chr22_rep)),
                        end = as.numeric(colnames(rao_chr22_rep))+50000,
                        rao_chr22_rep)
# Defining each function
# Sparse
sparse <- TADCompare(cont_mat1 = prim_sparse, cont_mat2 = rep_sparse, resolution = 50000)
# NxN
n_by_n <- TADCompare(cont_mat1 = prim_sparse, cont_mat2 = rep_sparse, resolution = 50000)
# Nx(N+3)
n_by_n_3 <- TADCompare(cont_mat1 = prim_n_n_3, cont_mat2 = rep_n_n_3, resolution = 50000)

# Benchmarking different parameters
bench <- microbenchmark(
# Sparse
sparse <- TADCompare(cont_mat1 = prim_sparse, cont_mat2 = rep_sparse, resolution = 50000),
# NxN
n_by_n <- TADCompare(cont_mat1 = rao_chr22_prim, cont_mat2 = rao_chr22_rep, resolution = 50000),
# Nx(N+3)
n_by_n_3 <- TADCompare(cont_mat1 = prim_n_n_3, cont_mat2 = rep_n_n_3, resolution = 50000), times = 5, unit = "s"
)

summary_bench <- summary(bench) %>% dplyr::select(mean, median)
rownames(summary_bench) <- c("sparse", "n_by_n", "n_by_n_3")
summary_bench
```

```
##               mean    median
## sparse   0.5057464 0.2645563
## n_by_n   0.1702899 0.1666969
## n_by_n_3 0.1765728 0.1765290
```

The table above shows the mean and median of runtimes for different types of contact matrices measured in seconds. As we see, `TADCompare` is extremely fast irrespectively of the parameters. However, sparse matrix inputs will slow down the algorithm. This can become more apparent as the size of the contact matrices increase.

# 4 Session Info

```
sessionInfo()
```

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
## [1] microbenchmark_1.5.0 TADCompare_1.20.0    SpectralTAD_1.26.0
## [4] dplyr_1.1.4          BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1            farver_2.1.2
##  [3] S7_0.2.0                    fastmap_1.2.0
##  [5] TH.data_1.1-4               digest_0.6.37
##  [7] lifecycle_1.0.4             cluster_2.1.8.1
##  [9] survival_3.8-3              HiCcompare_1.32.0
## [11] magrittr_2.0.4              compiler_4.5.1
## [13] rlang_1.1.6                 sass_0.4.10
## [15] tools_4.5.1                 yaml_2.3.10
## [17] data.table_1.17.8           knitr_1.50
## [19] ggsignif_0.6.4              S4Arrays_1.10.0
## [21] PRIMME_3.2-6                DelayedArray_0.36.0
## [23] plyr_1.8.9                  RColorBrewer_1.1-3
## [25] multcomp_1.4-29             abind_1.4-8
## [27] BiocParallel_1.44.0         KernSmooth_2.23-26
## [29] withr_3.0.2                 purrr_1.1.0
## [31] BiocGenerics_0.56.0         grid_4.5.1
## [33] stats4_4.5.1                ggpubr_0.6.2
## [35] Rhdf5lib_1.32.0             ggplot2_4.0.0
## [37] MASS_7.3-65                 scales_1.4.0
## [39] gtools_3.9.5                tinytex_0.57
## [41] dichromat_2.0-0.1           SummarizedExperiment_1.40.0
## [43] mvtnorm_1.3-3               cli_3.6.5
## [45] rmarkdown_2.30              generics_0.1.4
## [47] reshape2_1.4.4              cachem_1.1.0
## [49] rhdf5_2.54.0                stringr_1.5.2
## [51] splines_4.5.1               parallel_4.5.1
## [53] BiocManager_1.30.26         XVector_0.50.0
## [55] matrixStats_1.5.0           vctrs_0.6.5
## [57] sandwich_3.1-1              Matrix_1.7-4
## [59] carData_3.0-5               jsonlite_2.0.0
## [61] bookdown_0.45               car_3.1-3
## [63] IRanges_2.44.0              S4Vectors_0.48.0
## [65] rstatix_0.7.3               Formula_1.2-5
## [67] magick_2.9.0                jquerylib_0.1.4
## [69] tidyr_1.3.1                 glue_1.8.0
## [71] codetools_0.2-20            cowplot_1.2.0
## [73] stringi_1.8.7               gtable_0.3.6
## [75] GenomicRanges_1.62.0        tibble_3.3.0
## [77] pillar_1.11.1               htmltools_0.5.8.1
## [79] Seqinfo_1.0.0               rhdf5filters_1.22.0
## [81] R6_2.6.1                    evaluate_1.0.5
## [83] lattice_0.22-7              Biobase_2.70.0
## [85] backports_1.5.0             pheatmap_1.0.13
## [87] broom_1.0.10                bslib_0.9.0
## [89] Rcpp_1.1.0                  InteractionSet_1.38.0
## [91] gridExtra_2.3               SparseArray_1.10.0
## [93] nlme_3.1-168                mgcv_1.9-3
## [95] xfun_0.53                   zoo_1.8-14
## [97] MatrixGenerics_1.22.0       pkgconfig_2.0.3
```

# References

Durand, Neva C., Muhammad S. Shamim, Ido Machol, Suhas S. P. Rao, Miriam H. Huntley, Eric S. Lander, and Erez Lieberman Aiden. 2016. “Juicer Provides a One-Click System for Analyzing Loop-Resolution Hi-c Experiments.” *Cell Systems* 3 (1): 95–98. <https://doi.org/10.1016/j.cels.2016.07.002>.

Rao, Suhas S.P., Miriam H. Huntley, Neva C. Durand, Elena K. Stamenova, Ivan D. Bochkov, James T. Robinson, Adrian L. Sanborn, et al. 2014. “A 3D Map of the Human Genome at Kilobase Resolution Reveals Principles of Chromatin Looping.” *Cell* 159 (7): 1665–80. <https://doi.org/10.1016/j.cell.2014.11.021>.