# multiHiCcompare Vignette

John C. Stansfield & Mikhail G. Dozmorov

#### 30 October 2025

#### Package

multiHiCcompare 1.28.0

# Contents

* [1 Introduction](#introduction)
* [2 How to use `multiHiCcompare`](#how-to-use-multihiccompare)
  + [2.1 Install `multiHiCcompare` from Bioconductor](#install-multihiccompare-from-bioconductor)
  + [2.2 Getting Hi-C Data](#getting-hi-c-data)
    - [2.2.1 Extracting data from `.hic` files](#extracting-data-from-.hic-files)
    - [2.2.2 Extracting data from `.cool` files](#extracting-data-from-.cool-files)
    - [2.2.3 Using data from HiC-Pro](#using-data-from-hic-pro)
  + [2.3 Parallel Processing](#parallel-processing)
  + [2.4 Creating the `hicexp` object](#hicexp)
    - [2.4.1 Sparse upper triangular format](#sparse-upper-triangular-format)
    - [2.4.2 The `hicexp` object](#the-hicexp-object)
  + [2.5 Normalization](#normalization)
    - [2.5.1 Library scaling](#library-scaling)
    - [2.5.2 Cyclic Loess Normalization](#cyclic-loess-normalization)
    - [2.5.3 Fast Loess Normalization (Fastlo)](#fast-loess-normalization-fastlo)
  + [2.6 Difference Detection](#difference-detection)
    - [2.6.1 Exact Test](#exact-test)
    - [2.6.2 GLM Methods](#glm-methods)
  + [2.7 Downstream analysis](#downstream-analysis)
  + [2.8 Other functions](#other-functions)
* [3 Session Info](#session-info)

# 1 Introduction

`multiHiCcompare` is an extension of the original `HiCcompare` package. It provides functions for the joint normalization and detection of differential chromatin interactions between multiple Hi-C datasets. `multiHiCcompare` operates on processed Hi-C data in the form of chromosome-specific chromatin interaction matrices. It accepts four-column tab-separated text files storing chromatin interaction matrices in a sparse matrix format (see [Creating the hicexp object](#hicexp)). Functions to convert popular Hi-C data formats (`.hic`, `.cool`) to sparse format are available (see `?cooleHCT116_r2sparse`, and the examples below). `multiHiCcompare` differs from other packages that attempt to compare Hi-C data in that it works on processed data in chromatin interaction matrix format instead of raw sequencing data. In addition, `multiHiCcompare` provides a non-parametric method for the joint normalization and removal of biases between multiple Hi-C datasets for comparative analysis. `multiHiCcompare` also provides a general linear model (GLM) based framework for detecting differences in Hi-C data.

# 2 How to use `multiHiCcompare`

## 2.1 Install `multiHiCcompare` from Bioconductor

```
BiocManager::install("multiHiCcompare")
library(multiHiCcompare)
```

## 2.2 Getting Hi-C Data

You will need processed Hi-C data in the form of sparse upper triangular matrices or BEDPE files to use `multiHiCcompare`. Data is available from several sources and two examples for downloading and extracting data are listed below. If you have full Hi-C contact matrices, you can convert them to sparse upper triangular format using the full `full2sparse` function as shown in [additional functions](#addfunc)

### 2.2.1 Extracting data from `.hic` files

Hi-C data is available from several sources and in many formats. `multiHiCcompare` is built to work with the sparse upper triangular matrix format popularized by the lab of Erez Lieberman-Aiden <http://aidenlab.org/data.html>. If you already have Hi-C data either in the form of a sparse upper triangular matrix or a full contact matrix you can skip to the creating the `hicexp` object section. If you obtain data from the Aiden Lab in the `.hic` format you will need to first extract the matrices that you wish to compare.

1. Download the `straw` software from <https://github.com/theaidenlab/straw/wiki> and install it.
2. Use `straw` to extract a Hi-C sparse upper triangular matrix. An example is below:

Say we downloaded and uncompressed the `GSE63525_K562_combined_30.hic` file from GEO <https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE63525>, direct link ftp, [http](https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE63525&format=file&file=GSE63525%5FK562%5Fcombined%5F30%2Ehic%2Egz)

To extract the raw matrix corresponding to chromosome 22 at the 500kb resolution we would use the following command within the terminal

`./straw NONE GSE63525_K562_combined_30.hic 22 22 BP 500000 > K562.chHCT116_r22.500kb.txt`

This will extract the matrix from the `.hic` file and save it to the `K562.chHCT116_r22.500kb.txt` text file, in the sparse upper triangular matrix format. See more examples on how to use `straw` at <https://github.com/theaidenlab/straw/wiki/CPP#running>. Straw requires several inputs for the extraction of data from a `.hic` file.

`<NONE/VC/VC_SQRT/KR> <hicFile(s)> <chr1>[:x1:x2] <chr2>[:y1:y2] <BP/FRAG> <binsize>`

The first argument is the normalization method. For use in `multiHiCcompare` you want the raw data so you should select `NONE`. The second argument is the `.hic` file name. Next is the chromosome numbers of the matrix you want. For an intrachromosomal contact map, both should be the same as in the above example. If you want a matrix of interchromosomal interactions, you can use different chromosomes, i.e. interactions between chromosome 1 and chromosome 2 (Note that `HiCcompare` is only meant to be used on intrachromosomal interactions at this point in development). The next argument is whether you want basepair or fragment files. For `multiHiCcompare` use `BP`. The final argument is the bin size of the matrix (the resolution). To extract a matrix at a resolution of 1MB enter `10000000`. Typical bin sizes are 1MB, 500KB, 100KB, 50KB, 5KB, 1KB. Note that most matrices with resolutions higher than 100KB (i.e., matrices with resolutions of 1KB - 50KB) are typically too sparse (due to insufficient sequencing coverage) for analysis in `multiHiCcompare`.

From here we can import the matrix into R as you would normally for any tab-delimited file.

3. Import the data into R `K562.chr22 <- read.table('K562.chr22.500kb.txt', header=FALSE)`
4. Repeat these steps for any other Hi-C dataset that you wish to compare to the first dataset using `multiHiCcompare`.

### 2.2.2 Extracting data from `.cool` files

The `cooler` software, <http://cooler.readthedocs.io/en/latest/index.html>, allows access to a large collection of Hi-C data. The cooler index ftp://cooler.csail.mit.edu/coolers contains Hi-C data for `hg19` and `mm9` from many different sources. To use data in the `.cool` format in `HiCcompare` follow these steps:

1. Download and install `cooler` from <http://cooler.readthedocs.io/en/latest/index.html>
2. Download a `.cool` file from the cooler index ftp://cooler.csail.mit.edu/coolers.
3. Say we downloaded the `Dixon2012-H1hESC-HindIII-allreps-filtered.1000kb.cool` file. See `cooler dump --help` for data extraction options. To extract the contact matrix we use the following commands in the terminal:
   `cooler dump --join Dixon2012-H1hESC-HindIII-allreps-filtered.1000kb.cool > dixon.hESC.1000kb.txt`
4. Read in the text file as you would any tab-delimited file in R
   `hesc1000kb <- read.table("dixon.hESC.1000kb.txt", header = FALSE)`
5. Convert to a sparse upper triangular matrix using the `HiCcompare::cooler2sparse` function.
   `sparse <- cooler2sparse(hesc1000kb)`
6. Repeat the steps for another Hi-C dataset that you wish to compare to the first dataset.

### 2.2.3 Using data from HiC-Pro

HiC-Pro is another tool for processing raw Hi-C data into usable matrix files. HiC-Pro will produce a `.matrix` file and a `.bed` file for the data. These `.matrix` files are in a sparse upper triangular format similar to the results of Juicer and the dumped contents of a `.hic` file, however instead of using the genomic start coordinates for the first two columns of the sparse matrix they use an ID number. The `.bed` file contains the mappings for each of these IDs to their genomic coordinates. The original `HiCcompare` package includes a function to convert the results of HiC-Pro into a usable format for analysis in `multiHiCcompare`. When using data from HiC-Pro, it is important to use the raw `.matrix` files and NOT the iced `.matrix` files. The iced `.matrix` files have already had ICE normalization applied to them and are not suitable for entry into `multiHiCcompare`. Here we convert HiC-Pro data for input into `multiHiCcompare`:

```
# read in files
mat <- read.table("hic_1000000.matrix")
bed <- read.table("hic_1000000_abs.bed")
# convert to BEDPE
dat <- HiCcompare::hicpro2bedpe(mat, bed)
# NOTE: hicpro2bedpe returns a list of lists.
#   The first list, dat$cis, contains the intrachromosomal contact matrices
# NOTE: dat$trans contains the interchromosomal
#   contact matrix which is not used in multiHiCcompare.
```

See the help using `?HiCcompare::hicpro2bedpe` for more details.

## 2.3 Parallel Processing

Hi-C data is large, especially at high resolutions, and loess normalization is computationally intensive. `multiHiCcompare` was built with parallelization in mind and the best performance when working with large Hi-C experiments (many samples or high resolution) will be achieved when using a computing cluster. Parallel processing can be used for all normalization and comparison functions by setting `parallel = TRUE` in the function options. `multiHiCcompare` uses the Bioconductor `BiocParallel` package for parallel processing. You can set the number of processors to use on Linux with the following command:

```
library(BiocParallel)
numCores <- 20
register(MulticoreParam(workers = numCores), default = TRUE)
```

Or on Windows with:

```
library(BiocParallel)
numCores <- 20
register(SnowParam(workers = numCores), default = TRUE)
```

where `numCores` is the user-set number of processing cores to be used. For parallel processing in `multiHiCcompare`, jobs are split by chromosome and sometimes distance thus the more processors used, the quicker the function will run. For maximum speed, it is recommended to set `numCores` to the maximum number of processors available.

## 2.4 Creating the `hicexp` object

### 2.4.1 Sparse upper triangular format

A sparse matrix format represents a relatively compact and human-readable way to store pair-wise interactions. It is a tab-delimited text format containing three columns: “region1” - a start coordinate (in bp) of the first region, “region2” a start coordinate of the second region, and “IF” - the interaction frequency between them (IFs). Zero IFs are dropped (hence, the *sparse* format). Since the full matrix of chromatin interactions is symmetric, only the upper triangular portion, including the diagonal, is stored. Typically matrices in this format are stored in separate text files for each chromosome. For use in `multiHiCcompare`, you will need to add a column for the chromosome number. The chromosome number should be entered as just the number. Chromosomes such as X, Y, etc. should be entered as 23, 24, etc. If you are planning to analyze data for more than a single chromosome, you will need to concatenate these matrices together. A sparse Hi-C matrix ready to be input into `multiHiCcompare` should look like the following:

```
data("HCT116_r1") # load example sparse matrix
head(HCT116_r1)
#>   "22"       V1       V2 V3
#> 1   22 16000000 16000000 11
#> 2   22 16100000 16100000  1
#> 3   22 16200000 16200000  3
#> 4   22 16300000 16300000 15
#> 5   22 16400000 16400000  3
#> 6   22 16400000 16500000  1
colnames(HCT116_r1) <- c('chr', 'region1', 'region2', 'IF') # rename columns
head(HCT116_r1) # matrix ready to be input into multiHiCcompare
#>   chr  region1  region2 IF
#> 1  22 16000000 16000000 11
#> 2  22 16100000 16100000  1
#> 3  22 16200000 16200000  3
#> 4  22 16300000 16300000 15
#> 5  22 16400000 16400000  3
#> 6  22 16400000 16500000  1
```

If you have full Hi-C contact matrices you can convert them to sparse upper triangular matrices using the `HiCcompare::full2sparse` function and then add a column indicating the chromosome.

Say we have data from 2 experimental conditions with 2 samples each. We can make a `hicexp` object by doing the following.

```
data("HCT116_r1", "HCT116_r2", "HCT116_r3", "HCT116_r4")
hicexp1 <- make_hicexp(HCT116_r1, HCT116_r2, HCT116_r3, HCT116_r4,
                       groups = c(0, 0, 1, 1),
                       zero.p = 0.8, A.min = 5, filter = TRUE,
                       remove.regions = hg19_cyto)
hicexp1
#> Hi-C Experiment Object
#> 2 experimental groups
#> Group 1 has 2 samples
#> Group 2 has 2 samples
```

The `groups` option specifies the experimental groups. You must enter a vector the length of the number of Hi-C matrices with indicators for which group each matrix belongs to. An optional covariate `data.frame` with rows corresponding the Hi-C matrices and columns for each additional covariate can be provided with the `covariates` option.

Filtering can be performed when creating a `hicexp` object using the `zero.p` and `A.min` options in the `make_hicexp` function. The `zero.p` option allows for filtering by the proportion of zero IFs for an interaction. The `A.min` allows for filtering by a minimum average IF value. These options can be used together or individually to filter your data. Filtering is important to remove interactions with lots of 0 IFs and low average expression. These interactions tend to not be very interesting and can easily become a false positive during difference detection. Additionally, removing these interactions will increase the computational speed of `multiHiCcompare`. If for some reason you do not want to filter the data simply set `filter = FALSE`.

Additionally, you can filter out specific genomic regions such as centromeres or blacklisted regions. `multiHiCcompare` comes with built-in regions to be filtered for hg19 and hg38 which can be accessed like so.

```
data("hg19_cyto")
data("hg38_cyto")

hg19_cyto
#> GRanges object with 70 ranges and 2 metadata columns:
#>        seqnames              ranges strand |      arm  feature
#>           <Rle>           <IRanges>  <Rle> | <factor> <factor>
#>    [1]        1 121500000-125000000      * |    p11.1     acen
#>    [2]        1 125000000-128900000      * |    q11       acen
#>    [3]        1 128900000-142600000      * |    q12       gvar
#>    [4]       10   38000000-40200000      * |    p11.1     acen
#>    [5]       10   40200000-42300000      * |    q11.1     acen
#>    ...      ...                 ...    ... .      ...      ...
#>   [66]       23   58100000-60600000      * |    p11.1     acen
#>   [67]       23   60600000-63000000      * |    q11.1     acen
#>   [68]       24   11600000-12500000      * |    p11.1     acen
#>   [69]       24   12500000-13400000      * |    q11.1     acen
#>   [70]       24   28800000-59373566      * |    q12       gvar
#>   -------
#>   seqinfo: 24 sequences from an unspecified genome; no seqlengths
```

By default, the `make_hicexp` object will have the `remove.regions` option set to use the `hg19_cyto` object. If your data was not aligned to hg19 or you want other regions to be removed, you can create a `GenomicRanges` object containing the ranges to be removed and the `remove.regions` option to this object.

### 2.4.2 The `hicexp` object

The `hicexp` S4 class has several slots which can be accessed with the accessor functions `hic_table()`, `results()`, and `meta()`. The `hic_table` slot contains the Hi-C matrix in sparse format. The first four columns are the chromosome, region1 start location, region2 start location, and unit distance. All following chromosomes represent the IFs for that interacting pair from each sample. The `comparison` slot is empty at creation but will be filled following use of one of the comparison functions. It contains the same first four columns as the `hic_table` slot, but also has the logFC - log fold change between conditions, logCPM - log counts per million, p.value, and p.adj - multiple testing corrected p-value columns which indicate the significance of the difference for each interacting pair of regions between the conditions. Access the `comparison` slot using `results()`. The `metadata` slot contains the `data.frame` of covariates for the experiment. Access the `metadata` slot by using `meta()`. The other slots are mainly for internal use, and the typical user does not need to be concerned with them.

## 2.5 Normalization

`multiHiCcompare` comes with a few methods for normalizing your Hi-C data. Our joint normalization methods are again based on the MD plot as in the original `HiCcompare`. The MD plot is similar to the MA plot or the Bland-Altman plot. \(M\) is the \(log2\) difference between the interaction frequencies from the two datasets. \(D\) is the unit distance between the two interacting regions. Loess is performed on the data after it is represented in the MD coordinate system.

### 2.5.1 Library scaling

The simplest form of normalization to compare Hi-C data is library scaling. `multiHiCcompare` provides the `hic_scale()` function to scale the Hi-C libraries from each sample to the size of the smallest library. If you believe that any trends present in your data are important differences and not due to bias, then you can use library scaling for normalizing your data as follows.

```
data("hicexp2")
hicexp2 <- hic_scale(hicexp2)
```

Note that you need to use either simple scaling or loess normalization method. It is recommended to use either cyclic loess or fast loess that will implicitly rescale the libraries and remove unwanted trends.

### 2.5.2 Cyclic Loess Normalization

`multiHiCcompare` provides a cyclic loess method for the joint normalization of multiple Hi-C datasets. The method is based on representing the data on an MD plot. The MD plot is similar to the MA plot (Bland-Altman plot) which is commonly used for the visualization of gene expression differences. \(M\) is defined as the log difference between the two data sets \(M = log\_2(IF\_2/IF\_1)\), where \(IF\_1\) and \(IF\_2\) are interaction frequencies of the first and the second Hi-C datasets, respectively. \(D\) is defined as the distance between two interacting regions, expressed in unit-length of the \(X\) resolution of the Hi-C data. A loess regression curve is fit through the MD plot and used to remove global biases by centering the \(M\) differences around \(M=0\) baseline.

The cyclic loess algorithm proceeds through the following steps.

1. Choose two out of the \(N\) total samples then generate an MD plot.
2. Fit a loess curve \(f(d)\) to the MD plot.
3. Subtract \(f(d)/2\) from the first dataset and add \(f(d)/2\) to the second.
4. Repeat until all unique pairs have been compared.
5. Repeat until convergence.

To perform cyclic loess on your Hi-C data you will need to use the `cyclic_loess()` function as shown below:

```
hicexp1 <- cyclic_loess(hicexp1, verbose = FALSE,
                        parallel = FALSE, span = 0.2)
# make MD plot
MD_hicexp(hicexp1)
```

![](data:image/png;base64...)

As can be seen in the above MD plots, the data for each sample has been jointly normalized with all other samples. Note that the user can set the span option. A user-set span will run quicker than the default option of automatically calculating the span. It is best to use the automatic span calculation if you have not worked with the data before, but if you are familiar with it then setting the span is a way to speed up processing. The `hic_table` slot in the `hicexp` object has also been updated with the normalized IFs.

```
hic_table(hicexp1)
#>          chr  region1  region2     D        IF1        IF2        IF3
#>        <num>    <int>    <int> <num>      <num>      <num>      <num>
#>     1:    22 18000000 18000000     0 4848.93586 5117.56104 5757.67702
#>     2:    22 18000000 18100000     1 1307.53629 1128.57032 1317.91263
#>     3:    22 18000000 18200000     2  715.99832  734.05089  729.32691
#>     4:    22 18000000 18300000     3  352.17410  409.94247  420.22430
#>     5:    22 18000000 18400000     4  296.77137  274.80602  306.21630
#>    ---
#> 43740:    22 51000000 51100000     1 1622.03802 1762.87853 1664.49400
#> 43741:    22 51000000 51200000     2   30.51641   35.06727   31.06704
#> 43742:    22 51100000 51100000     0 3681.72778 4131.14202 4126.33930
#> 43743:    22 51100000 51200000     1   79.15003   63.50592   77.51615
#> 43744:    22 51200000 51200000     0   17.19701   25.33298   28.78896
#>               IF4
#>             <num>
#>     1: 4330.37698
#>     2:  893.55501
#>     3:  743.67190
#>     4:  387.50225
#>     5:  314.82774
#>    ---
#> 43740: 1271.16626
#> 43741:   22.70308
#> 43742: 3604.34388
#> 43743:   57.56003
#> 43744:   36.23247
```

The runtime of cyclic loess can be decreased when multiple processors are available by setting the `parallel` option to `TRUE`. This option splits up the data by chromosome and sends each chromosome’s data to a parallel processor.

### 2.5.3 Fast Loess Normalization (Fastlo)

In addition to the standard cyclic loess method, `multiHiCcompare` also implements the Fast Loess (Fastlo) joint normalization algorithm. Our implementation of fastlo is adapted to Hi-C data on a per-distance basis. To perform “fastlo” on Hi-C data we first split the data into \(p\) pooled matrices. The “progressive pooling” is used to split up the Hi-C matrix by unit distance such that distance 0 is its own pool, distances 1 and 2 are pooled, distance 3, 4, 5 are pooled, and so on until all unit distances belong to one of \(p\) pools. Each matrix will have an \(IF\_{gj}\) value with \(g\) interacting pairs for each of the \(j\) samples. These \(p\) matrices can then be input into the “fastlo” algorithm using the following steps.

1. Create the vector \(\hat{IF}\_{pgj}\), the row means of the \(p^{th}\) matrix. This is the equivalent of creating an average IF at distance pool \(p\).
2. Plot \(\hat{IF}\_{p}\) versus \((IF\_{pg} - \hat{IF\_p})\) for each sample \(j\). This is equivalent to an MA plot at a genomic distance pool \(p\).
3. Fit a loess curve \(f(x)\) to the plot.
4. Subtract \(f(x)\) from sample \(j\).
5. Repeat for all remaining replicates.
6. Repeat until algorithm converges.

You can perform fastlo normalization on your data as follows:

```
data("hicexp2")
# perform fastlo normalization
hicexp2 <- fastlo(hicexp2, verbose = FALSE, parallel = FALSE)
# make MD plot
MD_hicexp(hicexp2)
```

![](data:image/png;base64...)

Again, the above MD plots show the normalized data. `fastlo()` can also make use of parallelization to speed up computation speeds by setting the `parallel` option to `TRUE`. The results of `fastlo()` and `cyclic_loess()` may be slightly different, but both should result in the removal of biases between Hi-C datasets. `fastlo()` will have quicker run times compared to `cyclic_loess()`, but `cyclic_loess()` will likely give a slightly better normalization.

## 2.6 Difference Detection

`multiHiCcompare` provides two main ways to perform a differential comparison between the groups or conditions of your Hi-C experiment. For simple experiments where only a comparison between two groups is being made, the `hic_exactTest()` function can be used. For more complex experiments with covariates or multiple groups, the `hic_glm()` function should be used. Both of these functions make use of the `edgeR` package for fitting negative binomial models to the Hi-C data. For the difference detection steps, `multiHiCcompare` first splits the data up by distance using the progressive pooling described in the fastlo section. Each distance pool is then treated similarly to an independent RNA-seq data matrix on which `edgeR`’s functions are applied to fit the specified model. This process is illustrated in Figure 1 below.

![](data:image/png;base64...)

**Figure 1.** The off-diagonal analysis of multiple Hi-C replicates. Dashed lines represent the off-diagonal vectors of interaction frequencies at a given distance between interacting regions. Right: Converted into a matrix format similar to RNA-seq data, IFs can be loess normalized, variance across replicates can be estimated using an empirical Bayes approach, and differences can be detected using log-linear GLMs.

### 2.6.1 Exact Test

For simple Hi-C experiments the `hic_exactTest()` function can be used as shown below:

```
hicexp1 <- hic_exactTest(hicexp1, p.method = 'fdr',
                         parallel = FALSE)

# plot results
MD_composite(hicexp1)
```

![](data:image/png;base64...)

The above composite MD plot displays where any significant differences are detected between the two groups. This function can also be sped up by using the `parallel` option. The results of the comparison are then saved in the `comparison` slot of the `hicexp` object.

```
results(hicexp1)
#>          chr  region1  region2     D        logFC    logCPM    p.value
#>        <num>    <int>    <int> <num>        <num>     <num>      <num>
#>     1:    22 18000000 18000000     0 -0.002275166 11.162876 0.98366456
#>     2:    22 18000000 18100000     1 -0.166552664  9.056102 0.25182080
#>     3:    22 18000000 18200000     2  0.014618358  8.394195 0.91537281
#>     4:    22 18000000 18300000     3  0.064067062 10.298587 0.60744417
#>     5:    22 18000000 18400000     4  0.098500671  9.903732 0.45680270
#>    ---
#> 43740:    22 51000000 51100000     1 -0.223643329  9.499253 0.07126047
#> 43741:    22 51000000 51200000     2 -0.299659186  3.866202 0.34111042
#> 43742:    22 51100000 51100000     0 -0.027529087 10.798143 0.79810164
#> 43743:    22 51100000 51200000     1 -0.097114616  5.032406 0.71887789
#> 43744:    22 51200000 51200000     0  0.602359974  3.727353 0.07834808
#>            p.adj
#>            <num>
#>     1: 0.9980097
#>     2: 0.6272979
#>     3: 0.9709895
#>     4: 0.9710460
#>     5: 0.9184240
#>    ---
#> 43740: 0.3675414
#> 43741: 0.6850341
#> 43742: 0.9213680
#> 43743: 0.8910640
#> 43744: 0.3740800
```

In this `data.table` the first 3 columns represent the identity of the interaction, then followed by the unit genomic distance (`D`), the log fold change difference between the groups (`logFC`), the log counts per million for the interaction (`logCPM`), the p-value and finally the multiple testing correction p-value (`p.adj`). The type of multiple testing applied can be changed using the `p.method` option. To view what other adjustment methods are available look at the help for `?p.adjust`.

### 2.6.2 GLM Methods

For more complex Hi-C experiments the `hic_glm()` function must be used. To use this function, a design matrix must first be created. Here use the `hicexp2` object with some covariates and create the design matrix.

```
batch <- c(1,2,1,2)
# produce design matrix
d <- model.matrix(~factor(meta(hicexp2)$group) + factor(batch))
```

The design matrix should contain the covariates of interest. Any categorical variables should be entered as factors. Next, the comparison of interest will need to be specified using either the `contrast` or the `coef` option. For this example we are interested in the group difference thus we can set `coef = 2` to test if the group effect is equal to 0. For more information on using `contrast` and `coef` please see the `edgeR` user manual. Now we are ready to perform the comparison.

```
hicexp2 <- hic_glm(hicexp2, design = d, coef = 2, method = "QLFTest", p.method = "fdr", parallel = FALSE)
```

There are three methods by which `hic_glm()` can be performed. The default method is to the use the `QLFTest` which makes use of the quasi-likelihood model. Additionally, there is the `LRTest` which conducts a likelihood ratio test. The final method is the `Treat` method which conducts a test relative to a specified fold change threshold. For this option, the `M` option will need to be used to specify the log2 fold change threshold.

```
# use Treat option
hicexp2 <- hic_glm(hicexp2, design = d, coef = 2, method = "Treat",
                  M = 0.5, p.method = "fdr", parallel = FALSE)
```

## 2.7 Downstream analysis

For downstream analysis of the results of `multiHiCcompare`, you may want to filter the results. This can be accomplished by using the `topDirs` function. Setting the `return_df = 'pairedbed'` will return a table of the interacting pairs filtered by your specifications.

```
td <- topDirs(hicexp1, logfc_cutoff = 0.5, logcpm_cutoff = 0.5,
        p.adj_cutoff = 0.2, return_df = 'pairedbed')
head(td)
#>      chr1   start1     end1   chr2   start2     end2     D   logFC logCPM
#>    <char>    <int>    <num> <char>    <int>    <num> <num>   <num>  <num>
#> 1:  chr22 18500000 18599999  chr22 24700000 24799999    62  1.1694 9.7256
#> 2:  chr22 20200000 20299999  chr22 20300000 20399999     1 -0.5442 6.2774
#> 3:  chr22 22000000 22099999  chr22 32700000 32799999   107 -2.6634 8.2660
#> 4:  chr22 24400000 24499999  chr22 36300000 36399999   119  1.6663 9.4722
#> 5:  chr22 25900000 25999999  chr22 26400000 26499999     5  0.5465 8.7862
#> 6:  chr22 26600000 26699999  chr22 27100000 27199999     5  0.5351 8.9949
#>       p.value      p.adj
#>        <char>     <char>
#> 1: 5.8552E-05 1.5007E-01
#> 2: 2.7270E-03 1.0329E-01
#> 3: 3.3430E-04 1.9105E-01
#> 4: 1.0442E-04 1.1935E-01
#> 5: 1.9882E-03 1.8947E-01
#> 6: 1.5397E-03 1.7042E-01
```

Additionally, you can summarize the regions that were detected as significant at least once by setting `return_df = 'bed'`.

```
counts <- topDirs(hicexp1, logfc_cutoff = 0.5, logcpm_cutoff = 0.5,
                  p.adj_cutoff = 0.2, return_df = 'bed', pval_aggregate = "max")
head(counts)
#>       chr    start      end count  avgD avgLogFC avgLogCPM   avgP.adj
#>    <char>    <int>    <num> <num> <num>    <num>     <num>     <char>
#> 1:  chr22 36300000 36399999     2   117   1.9625    9.0681 1.9105E-01
#> 2:  chr22 18500000 18599999     1    62   1.1694    9.7256 1.5007E-01
#> 3:  chr22 20200000 20299999     1     1  -0.5442    6.2774 1.0329E-01
#> 4:  chr22 20300000 20399999     1     1  -0.5442    6.2774 1.0329E-01
#> 5:  chr22 22000000 22099999     1   107  -2.6634    8.2660 1.9105E-01
#> 6:  chr22 24400000 24499999     1   119   1.6663    9.4722 1.1935E-01
```

The resulting table when `return_df = 'bed'` is used can be input into the following plot function to visualize the p-values of the top differentially interacting regions (DIRs).

```
plot_pvals(counts)
```

![](data:image/png;base64...)

Or to visualize the counts of the top DIRs.

```
plot_counts(counts)
```

![](data:image/png;base64...)

## 2.8 Other functions

There are several other functions included in `multiHiCcompare`. `manhattan_hicexp()` produces a Manhattan plot for the results of a comparison to identify “hotspot” regions of the genome where large numbers of significant differences are found.

```
manhattan_hicexp(hicexp1, p.adj_cutoff = "standard")
```

![](data:image/png;base64...)

There is also the MD plotting function `MD_hicexp()` which will plot MD plots for each unique pair of samples in the `hicexp` object.

```
MD_hicexp(hicexp1, prow = 2, pcol = 3)
```

![](data:image/png;base64...)

The `MD_composite()` function will plot a composite MD plot of the results of a comparison where the significant differences are highlighted.

```
MD_composite(hicexp1)
```

![](data:image/png;base64...)

# 3 Session Info

```
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
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] multiHiCcompare_1.28.0 BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] tidyselect_1.2.1            dplyr_1.1.4
#>  [3] farver_2.1.2                S7_0.2.0
#>  [5] fastmap_1.2.0               digest_0.6.37
#>  [7] lifecycle_1.0.4             statmod_1.5.1
#>  [9] HiCcompare_1.32.0           magrittr_2.0.4
#> [11] compiler_4.5.1              rlang_1.1.6
#> [13] sass_0.4.10                 tools_4.5.1
#> [15] yaml_2.3.10                 calibrate_1.7.7
#> [17] data.table_1.17.8           knitr_1.50
#> [19] S4Arrays_1.10.0             DelayedArray_0.36.0
#> [21] RColorBrewer_1.1-3          abind_1.4-8
#> [23] BiocParallel_1.44.0         KernSmooth_2.23-26
#> [25] BiocGenerics_0.56.0         grid_4.5.1
#> [27] stats4_4.5.1                Rhdf5lib_1.32.0
#> [29] edgeR_4.8.0                 ggplot2_4.0.0
#> [31] scales_1.4.0                gtools_3.9.5
#> [33] MASS_7.3-65                 tinytex_0.57
#> [35] dichromat_2.0-0.1           SummarizedExperiment_1.40.0
#> [37] cli_3.6.5                   rmarkdown_2.30
#> [39] generics_0.1.4              httr_1.4.7
#> [41] pbapply_1.7-4               cachem_1.1.0
#> [43] rhdf5_2.54.0                splines_4.5.1
#> [45] parallel_4.5.1              BiocManager_1.30.26
#> [47] XVector_0.50.0              aggregation_1.0.1
#> [49] matrixStats_1.5.0           vctrs_0.6.5
#> [51] Matrix_1.7-4                jsonlite_2.0.0
#> [53] bookdown_0.45               IRanges_2.44.0
#> [55] S4Vectors_0.48.0            qqman_0.1.9
#> [57] magick_2.9.0                locfit_1.5-9.12
#> [59] limma_3.66.0                jquerylib_0.1.4
#> [61] glue_1.8.0                  codetools_0.2-20
#> [63] gtable_0.3.6                GenomeInfoDb_1.46.0
#> [65] GenomicRanges_1.62.0        UCSC.utils_1.6.0
#> [67] tibble_3.3.0                pillar_1.11.1
#> [69] htmltools_0.5.8.1           Seqinfo_1.0.0
#> [71] rhdf5filters_1.22.0         GenomeInfoDbData_1.2.15
#> [73] R6_2.6.1                    evaluate_1.0.5
#> [75] lattice_0.22-7              Biobase_2.70.0
#> [77] pheatmap_1.0.13             bslib_0.9.0
#> [79] Rcpp_1.1.0                  InteractionSet_1.38.0
#> [81] gridExtra_2.3               SparseArray_1.10.0
#> [83] nlme_3.1-168                mgcv_1.9-3
#> [85] xfun_0.53                   MatrixGenerics_1.22.0
#> [87] pkgconfig_2.0.3
```