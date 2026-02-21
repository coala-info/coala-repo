# R Interface to CoreArray Genomic Data Structure (GDS) Files

#### Dr. Xiuwen Zheng

#### Apr, 2020

* [Introduction](#introduction)
* [Installation of the package gdsfmt](#installation-of-the-package-gdsfmt)
* [High-level R functions](#high-level-r-functions)
  + [Creating a GDS file and variable hierarchy](#creating-a-gds-file-and-variable-hierarchy)
  + [Writing Data](#writing-data)
    - [R function *add.gdsn*](#r-function-add.gdsn)
    - [R function *write.gdsn*](#r-function-write.gdsn)
    - [R function *append.gdsn*](#r-function-append.gdsn)
    - [R function *assign.gdsn*](#r-function-assign.gdsn)
    - [Create a large-scale data set](#create-a-large-scale-data-set)
  + [Reading Data](#reading-data)
    - [Subset reading *read.gdsn* and *readex.gdsn*](#subset-reading-read.gdsn-and-readex.gdsn)
    - [Apply a user-defined function marginally](#apply-a-user-defined-function-marginally)
* [Examples](#examples)
  + [Output to a text file](#output-to-a-text-file)
  + [Transpose a matrix](#transpose-a-matrix)
  + [Floating-point number vs. packed real number](#floating-point-number-vs.-packed-real-number)
  + [Limited random-access of compressed data](#limited-random-access-of-compressed-data)
  + [Sparse Matrix](#sparse-matrix)
  + [Checksum for Data Integrity](#checksum-for-data-integrity)
* [Stylish Terminal Output in R](#stylish-terminal-output-in-r)
* [Session Information](#session-information)

# Introduction

The package gdsfmt provides a high-level R interface to CoreArray Genomic Data Structure (GDS) data files, which are portable across platforms and include hierarchical structure to store multiple scalable array-oriented data sets with metadata information. It is suited for large-scale datasets, especially for data which are much larger than the available random-access memory. The package [gdsfmt](http://www.bioconductor.org/packages/release/bioc/html/gdsfmt.html) offers the efficient operations specifically designed for integers with less than 8 bits, since a single genetic/genomic variant, like single-nucleotide polymorphism (SNP), usually occupies fewer bits than a byte. Data compression and decompression are also supported with relatively efficient random access.

# Installation of the package gdsfmt

To install the package [gdsfmt](http://www.bioconductor.org/packages/release/bioc/html/gdsfmt.html), you need a current version (>=2.14.0) of [R](https://www.r-project.org). After installing R you can run the following commands from the R command shell to install the package [gdsfmt](http://www.bioconductor.org/packages/release/bioc/html/gdsfmt.html).

Install the package from Bioconductor repository:

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("gdsfmt")
```

Install the development version from Github (for developers/testers only):

```
library("devtools")
install_github("zhengxwen/gdsfmt")
```

The `install_github()` approach requires that you build from source, i.e. `make` and compilers must be installed on your system – see the [R FAQ](https://cran.r-project.org/faqs.html) for your operating system; you may also need to install dependencies manually.

# High-level R functions

## Creating a GDS file and variable hierarchy

An empty GDS file can be created by `createfn.gds()`:

```
library(gdsfmt)
gfile <- createfn.gds("test.gds")
```

Now, a file handle associated with “test.gds” is saved in the R variable *gfile*.

The GDS file can contain a hierarchical structure to store multiple GDS variables (or GDS nodes) in the file, and various data types are allowed (see the document of `add.gdsn()`) including integer, floating-point number and character.

```
add.gdsn(gfile, "int", val=1:10000)
add.gdsn(gfile, "double", val=seq(1, 1000, 0.4))
add.gdsn(gfile, "character", val=c("int", "double", "logical", "factor"))
add.gdsn(gfile, "logical", val=rep(c(TRUE, FALSE, NA), 50), visible=FALSE)
add.gdsn(gfile, "factor", val=as.factor(c(NA, "AA", "CC")), visible=FALSE)
add.gdsn(gfile, "bit2", val=sample(0:3, 1000, replace=TRUE), storage="bit2")

# list and data.frame
add.gdsn(gfile, "list", val=list(X=1:10, Y=seq(1, 10, 0.25)))
add.gdsn(gfile, "data.frame", val=data.frame(X=1:19, Y=seq(1, 10, 0.5)))
```

```
folder <- addfolder.gdsn(gfile, "folder")
add.gdsn(folder, "int", val=1:1000)
add.gdsn(folder, "double", val=seq(1, 100, 0.4), visible=FALSE)
```

Users can display the file content by typing `gfile` or `print(gfile)`:

```
gfile
```

```
## File: /tmp/RtmpnYU7XE/Rbuild918ca48c558b8/gdsfmt/vignettes/test.gds (1.1K)
## +    [  ]
## |--+ int   { Int32 10000, 39.1K }
## |--+ double   { Float64 2498, 19.5K }
## |--+ character   { Str8 4, 26B }
## |--+ bit2   { Bit2 1000, 250B }
## |--+ list   [ list ] *
## |  |--+ X   { Int32 10, 40B }
## |  \--+ Y   { Float64 37, 296B }
## |--+ data.frame   [ data.frame ] *
## |  |--+ X   { Int32 19, 76B }
## |  \--+ Y   { Float64 19, 152B }
## \--+ folder   [  ]
##    \--+ int   { Int32 1000, 3.9K }
```

`print(gfile, ...)` has an argument *all* to control the display of file content. By default, *all=FALSE*; if *all=TRUE*, to show all contents in the file including hidden variables or folders. The GDS variables *logical*, *factor* and *folder/double* are hidden.

```
print(gfile, all=TRUE)
```

```
## File: /tmp/RtmpnYU7XE/Rbuild918ca48c558b8/gdsfmt/vignettes/test.gds (64.6K)
## +    [  ]
## |--+ int   { Int32 10000, 39.1K }
## |--+ double   { Float64 2498, 19.5K }
## |--+ character   { Str8 4, 26B }
## |--+ logical   { Int32,logical 150, 600B } *
## |--+ factor   { Int32,factor 3, 12B } *
## |--+ bit2   { Bit2 1000, 250B }
## |--+ list   [ list ] *
## |  |--+ X   { Int32 10, 40B }
## |  \--+ Y   { Float64 37, 296B }
## |--+ data.frame   [ data.frame ] *
## |  |--+ X   { Int32 19, 76B }
## |  \--+ Y   { Float64 19, 152B }
## \--+ folder   [  ]
##    |--+ int   { Int32 1000, 3.9K }
##    \--+ double   { Float64 248, 1.9K } *
```

The asterisk indicates attributes attached to a GDS variable. The attributes can be used in the R environment to interpret the variable as *logical*, *factor*, *data.frame* or *list*.

`index.gdsn()` can locate the GDS variable by a *path*:

```
index.gdsn(gfile, "int")
```

```
## + int   { Int32 10000, 39.1K }
```

```
index.gdsn(gfile, "list/Y")
```

```
## + list/Y   { Float64 37, 296B }
```

```
index.gdsn(gfile, "folder/int")
```

```
## + folder/int   { Int32 1000, 3.9K }
```

```
# close the GDS file
closefn.gds(gfile)
```

## Writing Data

Array-oriented data sets can be written to the GDS file. There are three possible ways to write data to a GDS variable.

```
gfile <- createfn.gds("test.gds")
```

### R function *add.gdsn*

Users could pass an R variable to the function `add.gdsn()` directly. `show()` provides the preview of GDS variable.

```
n <- add.gdsn(gfile, "I1", val=matrix(1:15, nrow=3))
show(n)
```

```
## + I1   { Int32 3x5, 60B }
## Preview:
##  1  4  7 10 13
##  2  5  8 11 14
##  3  6  9 12 15
```

### R function *write.gdsn*

Users can specify the arguments *start* and *count* to write a subset of data. -1 in *count* means the size of that dimension, and the corresponding element in *start* should be 1. The values in *start* and *cound* should be in the dimension range.

```
write.gdsn(n, rep(0,5), start=c(2,1), count=c(1,-1))
show(n)
```

```
## + I1   { Int32 3x5, 60B }
## Preview:
##  1  4  7 10 13
##  0  0  0  0  0
##  3  6  9 12 15
```

### R function *append.gdsn*

Users can append new data to an existing GDS variable.

```
append.gdsn(n, 16:24)
show(n)
```

```
## + I1   { Int32 3x8, 96B }
## Preview:
##  1  4  7 10 13 16 19 22
##  0  0  0  0  0 17 20 23
##  3  6  9 12 15 18 21 24
```

### R function *assign.gdsn*

Users could call `assign.gdsn()` to replace specific values, subset or reorder the data variable.

```
# initialize
n <- add.gdsn(gfile, "mat", matrix(1:48, 6))
show(n)
```

```
## + mat   { Int32 6x8, 192B }
## Preview:
##  1  7 13 19 25 31 37 43
##  2  8 14 20 26 32 38 44
##  3  9 15 21 27 33 39 45
##  4 10 16 22 28 34 40 46
##  5 11 17 23 29 35 41 47
##  6 12 18 24 30 36 42 48
```

```
# substitute
assign.gdsn(n, .value=c(9:14,35:40), .substitute=NA)
show(n)
```

```
## + mat   { Int32 6x8, 192B }
## Preview:
##  1  7 NA 19 25 31 NA 43
##  2  8 NA 20 26 32 NA 44
##  3 NA 15 21 27 33 NA 45
##  4 NA 16 22 28 34 NA 46
##  5 NA 17 23 29 NA 41 47
##  6 NA 18 24 30 NA 42 48
```

```
# subset
assign.gdsn(n, seldim=list(rep(c(TRUE, FALSE),3), rep(c(FALSE, TRUE),4)))
show(n)
```

```
## + mat   { Int32 3x4, 48B }
## Preview:
##  7 19 31 43
## NA 21 33 45
## NA 23 NA 47
```

```
# initialize and subset
n <- add.gdsn(gfile, "mat", matrix(1:48, 6), replace=TRUE)
assign.gdsn(n, seldim=list(c(4,2,6,NA), c(5,6,NA,2,8,NA,4)))
show(n)
```

```
## + mat   { Int32 4x7, 112B }
## Preview:
## 28 34 NA 10 46 NA 22
## 26 32 NA  8 44 NA 20
## 30 36 NA 12 48 NA 24
## NA NA NA NA NA NA NA
```

```
# initialize and sort into descending order
n <- add.gdsn(gfile, "mat", matrix(1:48, 6), replace=TRUE)
assign.gdsn(n, seldim=list(6:1, 8:1))
show(n)
```

```
## + mat   { Int32 6x8, 192B }
## Preview:
## 48 42 36 30 24 18 12  6
## 47 41 35 29 23 17 11  5
## 46 40 34 28 22 16 10  4
## 45 39 33 27 21 15  9  3
## 44 38 32 26 20 14  8  2
## 43 37 31 25 19 13  7  1
```

### Create a large-scale data set

**1)** When the size of dataset is larger than the system memory, users can not add a GDS variable via `add.gdsn()` directly. If the dimension is pre-defined, users can specify the dimension size in `add.gdsn()` to allocate data space. Then call `write.gdsn()` to write a small subset of data space.

```
(n2 <- add.gdsn(gfile, "I2", storage="int", valdim=c(100, 2000)))
```

```
## + I2   { Int32 100x2000, 781.2K }
```

```
for (i in 1:2000)
{
    write.gdsn(n2, seq.int(100*(i-1)+1, length.out=100),
        start=c(1,i), count=c(-1,1))
}

show(n2)
```

```
## + I2   { Int32 100x2000, 781.2K }
## Preview:
##      1    101    201    301    401    501 .. 199401 199501 199601 199701 199801 199901
##      2    102    202    302    402    502 .. 199402 199502 199602 199702 199802 199902
##      3    103    203    303    403    503 .. 199403 199503 199603 199703 199803 199903
##      4    104    204    304    404    504 .. 199404 199504 199604 199704 199804 199904
##      5    105    205    305    405    505 .. 199405 199505 199605 199705 199805 199905
##      6    106    206    306    406    506 .. 199406 199506 199606 199706 199806 199906
## ......
##     95    195    295    395    495    595 .. 199495 199595 199695 199795 199895 199995
##     96    196    296    396    496    596 .. 199496 199596 199696 199796 199896 199996
##     97    197    297    397    497    597 .. 199497 199597 199697 199797 199897 199997
##     98    198    298    398    498    598 .. 199498 199598 199698 199798 199898 199998
##     99    199    299    399    499    599 .. 199499 199599 199699 199799 199899 199999
##    100    200    300    400    500    600 .. 199500 199600 199700 199800 199900 200000
```

**2)** Call `append.gdsn()` to append new data when the initial size is ZERO. If a compression algorithm is specified in `add.gdsn()` (e.g., *compress=“ZIP”*), users should call `append.gdsn()` instead of `write.gdsn()`, since data has to be compressed sequentially.

```
(n3 <- add.gdsn(gfile, "I3", storage="int", valdim=c(100, 0), compress="ZIP"))
```

```
## + I3   { Int32 100x0 ZIP, 0B }
```

```
for (i in 1:2000)
{
    append.gdsn(n3, seq.int(100*(i-1)+1, length.out=100))
}

readmode.gdsn(n3)  # finish writing with the compression algorithm
```

```
## + I3   { Int32 100x2000 ZIP(34.6%), 270.2K }
```

```
show(n3)
```

```
## + I3   { Int32 100x2000 ZIP(34.6%), 270.2K }
## Preview:
##      1    101    201    301    401    501 .. 199401 199501 199601 199701 199801 199901
##      2    102    202    302    402    502 .. 199402 199502 199602 199702 199802 199902
##      3    103    203    303    403    503 .. 199403 199503 199603 199703 199803 199903
##      4    104    204    304    404    504 .. 199404 199504 199604 199704 199804 199904
##      5    105    205    305    405    505 .. 199405 199505 199605 199705 199805 199905
##      6    106    206    306    406    506 .. 199406 199506 199606 199706 199806 199906
## ......
##     95    195    295    395    495    595 .. 199495 199595 199695 199795 199895 199995
##     96    196    296    396    496    596 .. 199496 199596 199696 199796 199896 199996
##     97    197    297    397    497    597 .. 199497 199597 199697 199797 199897 199997
##     98    198    298    398    498    598 .. 199498 199598 199698 199798 199898 199998
##     99    199    299    399    499    599 .. 199499 199599 199699 199799 199899 199999
##    100    200    300    400    500    600 .. 199500 199600 199700 199800 199900 200000
```

```
# close the GDS file
closefn.gds(gfile)
```

## Reading Data

```
gfile <- createfn.gds("test.gds")
add.gdsn(gfile, "I1", val=matrix(1:20, nrow=4))
add.gdsn(gfile, "I2", val=1:100)
closefn.gds(gfile)
```

`read.gdsn()` can load all data to an R variable in memory.

```
gfile <- openfn.gds("test.gds")
n <- index.gdsn(gfile, "I1")

read.gdsn(n)
```

```
##      [,1] [,2] [,3] [,4] [,5]
## [1,]    1    5    9   13   17
## [2,]    2    6   10   14   18
## [3,]    3    7   11   15   19
## [4,]    4    8   12   16   20
```

### Subset reading *read.gdsn* and *readex.gdsn*

A subset of data can be specified via the arguments *start* and *count* in the R function `read.gdsn`. Or specify a list of logical vectors in `readex.gdsn()`.

```
# read a subset
read.gdsn(n, start=c(2, 2), count=c(2, 3))
```

```
##      [,1] [,2] [,3]
## [1,]    6   10   14
## [2,]    7   11   15
```

```
read.gdsn(n, start=c(2, 2), count=c(2, 3), .value=c(6,15), .substitute=NA)
```

```
##      [,1] [,2] [,3]
## [1,]   NA   10   14
## [2,]    7   11   NA
```

```
# read a subset
readex.gdsn(n, list(c(FALSE,TRUE,TRUE,FALSE), c(TRUE,FALSE,TRUE,FALSE,TRUE)))
```

```
##      [,1] [,2] [,3]
## [1,]    2   10   18
## [2,]    3   11   19
```

```
readex.gdsn(n, list(c(1,4,3,NA), c(2,NA,3,1,3,1)))
```

```
##      [,1] [,2] [,3] [,4] [,5] [,6]
## [1,]    5   NA    9    1    9    1
## [2,]    8   NA   12    4   12    4
## [3,]    7   NA   11    3   11    3
## [4,]   NA   NA   NA   NA   NA   NA
```

```
readex.gdsn(n, list(c(1,4,3,NA), c(2,NA,3,1,3,1)), .value=NA, .substitute=-1)
```

```
##      [,1] [,2] [,3] [,4] [,5] [,6]
## [1,]    5   -1    9    1    9    1
## [2,]    8   -1   12    4   12    4
## [3,]    7   -1   11    3   11    3
## [4,]   -1   -1   -1   -1   -1   -1
```

### Apply a user-defined function marginally

A user-defined function can be applied marginally to a GDS variable via `apply.gdsn()`. *margin=1* indicates applying the function row by row, and *margin=2* for applying the function column by column.

```
apply.gdsn(n, margin=1, FUN=print, as.is="none")
```

```
## [1]  1  5  9 13 17
## [1]  2  6 10 14 18
## [1]  3  7 11 15 19
## [1]  4  8 12 16 20
```

```
apply.gdsn(n, margin=2, FUN=print, as.is="none")
```

```
## [1] 1 2 3 4
## [1] 5 6 7 8
## [1]  9 10 11 12
## [1] 13 14 15 16
## [1] 17 18 19 20
```

```
# close the GDS file
closefn.gds(gfile)
```

# Examples

To create a simple GDS file,

```
gfile <- createfn.gds("test.gds")
n1 <- add.gdsn(gfile, "I1", val=1:100)
n2 <- add.gdsn(gfile, "I2", val=matrix(1:20, nrow=4))

gfile
```

```
## File: /tmp/RtmpnYU7XE/Rbuild918ca48c558b8/gdsfmt/vignettes/test.gds (224B)
## +    [  ]
## |--+ I1   { Int32 100, 400B }
## \--+ I2   { Int32 4x5, 80B }
```

## Output to a text file

`apply.gdsn()` can be used to export a GDS variable to a text file. If the GDS variable is a vector,

```
fout <- file("text.txt", "wt")
apply.gdsn(n1, 1, FUN=cat, as.is="none", file=fout, fill=TRUE)
close(fout)

scan("text.txt")
```

```
##   [1]   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15  16  17  18
##  [19]  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34  35  36
##  [37]  37  38  39  40  41  42  43  44  45  46  47  48  49  50  51  52  53  54
##  [55]  55  56  57  58  59  60  61  62  63  64  65  66  67  68  69  70  71  72
##  [73]  73  74  75  76  77  78  79  80  81  82  83  84  85  86  87  88  89  90
##  [91]  91  92  93  94  95  96  97  98  99 100
```

The arguments *file* and *fill* are defined in the function `cat()`.

If the GDS variable is a matrix:

```
fout <- file("text.txt", "wt")
apply.gdsn(n2, 1, FUN=cat, as.is="none", file=fout, fill=4194304)
close(fout)

readLines("text.txt")
```

```
## [1] "1 5 9 13 17"  "2 6 10 14 18" "3 7 11 15 19" "4 8 12 16 20"
```

The number 4194304 is the maximum number of columns on a line used in printing vectors.

## Transpose a matrix

`permdim.gdsn()` can be used to transpose an array by permuting its dimensions. Or `apply.gdsn()` allows that the data returned from the user-defined function *FUN* is directly written to a target GDS node *target.node*, when *as.is=“gdsnode”* and *target.node* are both given. Little *c* in R is a generic function which combines its arguments, and it passes all data to the target GDS node in the following code:

```
n.t <- add.gdsn(gfile, "transpose", storage="int", valdim=c(5,0))

# apply the function over rows of matrix
apply.gdsn(n2, margin=1, FUN=c, as.is="gdsnode", target.node=n.t)

# matrix transpose
read.gdsn(n.t)
```

```
##      [,1] [,2] [,3] [,4]
## [1,]    1    2    3    4
## [2,]    5    6    7    8
## [3,]    9   10   11   12
## [4,]   13   14   15   16
## [5,]   17   18   19   20
```

```
# close the GDS file
closefn.gds(gfile)
```

## Floating-point number vs. packed real number

In computing, floating point is a method of representing an approximation of a real number in a way that can support a trade-off between range and precision, which can be represented exactly is of the following form “*significand* \(\times\) 2*exponent*”. A packed real number in GDS format is defined as “*int* \(\times\) scale \(+\) offset”, where *int* can be a 8-bit, 16-bit or 32-bit signed interger. In some cases, the strategy of packed real numbers can significantly improve the compression ratio for real numbers.

```
set.seed(1000)
val <- sample(seq(0,1,0.001), 50000, replace=TRUE)
head(val)
```

```
## [1] 0.579 0.298 0.213 0.050 0.343 0.284
```

```
gfile <- createfn.gds("test.gds")

add.gdsn(gfile, "N1", val=val)
add.gdsn(gfile, "N2", val=val, compress="ZIP", closezip=TRUE)
add.gdsn(gfile, "N3", val=val, storage="float")
add.gdsn(gfile, "N4", val=val, storage="float", compress="ZIP", closezip=TRUE)
add.gdsn(gfile, "N5", val=val, storage="packedreal16", scale=0.001, offset=0)
add.gdsn(gfile, "N6", val=val, storage="packedreal16", scale=0.001, offset=0, compress="ZIP", closezip=TRUE)

gfile
```

```
## File: /tmp/RtmpnYU7XE/Rbuild918ca48c558b8/gdsfmt/vignettes/test.gds (775.1K)
## +    [  ]
## |--+ N1   { Float64 50000, 390.6K }
## |--+ N2   { Float64 50000 ZIP(24.8%), 96.7K }
## |--+ N3   { Float32 50000, 195.3K }
## |--+ N4   { Float32 50000 ZIP(46.8%), 91.4K }
## |--+ N5   { PackedReal16 50000, 97.7K }
## \--+ N6   { PackedReal16 50000 ZIP(76.1%), 74.3K }
```

| Variable | Type | Compression Method | Size | Ratio | Machine epsilon1 |
| --- | --- | --- | --- | --- | --- |
| **N1** | 64-bit floating-point number | — | 400.0 KB | 100.0% | 0 |
| **N2** | 64-bit floating-point number | zlib | 99.0 KB | 24.8% | 0 |
| **N3** | 32-bit floating-point number | — | 200.0 KB | 50.0% | 9.94e-09 |
| **N4** | 32-bit floating-point number | zlib | 93.5 KB | 23.4% | 9.94e-09 |
| **N5** | 16-bit packed real number | — | 100.0 KB | 25.0% | 0 |
| **N6** | 16-bit packed real number | zlib | 76.1 KB | 19.0% | 0 |

1: the relative error due to rounding in floating point arithmetic.

```
# close the GDS file
closefn.gds(gfile)
```

## Limited random-access of compressed data

* 10,000,000 random 0,1 sequence of 32-bit integers
  + in each 32 bits, one bit stores random 0,1 and others are ZERO
  + lower bound of compression percentage is 1/32 = 3.125%
* Testing:
  + of 10,000 random positions, read a 32-bit integer
  + compression ratio is maximized for each method
  + compression method: none, ZIP, ZIP\_ra, LZ4, LZ4\_ra, LZMA, LZMA\_ra
  + ZIP\_ra, LZ4\_ra and LZMA\_ra: data stored in the file are composed of multiple independent compressed blocks

```
set.seed(100)
# 10,000,000 random 0,1 sequence of 32-bit integers
val <- sample.int(2, 10*1000*1000, replace=TRUE) - 1L
table(val)
```

```
## val
##       0       1
## 4999138 5000862
```

```
# cteate a GDS file
f <- createfn.gds("test.gds")

# compression algorithms (LZMA_ra:32K is the lower bound of LZMA_ra)
compression <- c("", "ZIP.max", "ZIP_ra.max:16K", "LZ4.max", "LZ4_ra.max:16K", "LZMA", "LZMA_ra:32K")

# save
for (i in 1:length(compression))
    print(add.gdsn(f, paste0("I", i), val=val, compress=compression[i], closezip=TRUE))

# close the file
closefn.gds(f)

cleanup.gds("test.gds")
```

* System configuration:
  + MacBook Pro, Retina, 13-inch, Late 2013, 2.8 GHz Intel Core i7, 16 GB 1600 MHz DDR3
  + R 3.2.4

```
# open the GDS file
f <- openfn.gds("test.gds")

# 10,000 random positions
set.seed(1000)
idx <- sample.int(length(val), 10000)

# enumerate each compression method
dat <- vector("list", length(compression))
for (i in seq_len(length(compression)))
{
    cat("Compression:", compression[i], "\n")
    n <- index.gdsn(f, paste0("I", i))
    print(system.time({
        dat[[i]] <- sapply(idx, FUN=function(k) read.gdsn(n, start=k, count=1L))
    }))
}

# check
for (i in seq_len(length(compression)))
    stopifnot(identical(dat[[i]], dat[[1L]]))

# close the file
closefn.gds(f)
```

| Compression Method | Raw | ZIP | ZIP\_ra | LZ4 | LZ4\_ra | LZMA | LZMA\_ra |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Data Size (MB) | 38.1 | 1.9 | 2.1 | 2.8 | 2.9 | 1.4 | 1.4 |
| Compression Percent | 100% | 5.08% | 5.42% | 7.39% | 7.60% | 3.65% | 3.78% |
| Reading Time (second) | 0.21 | 202.64 | 2.97 | 84.43 | 0.84 | 462.1 | 29.7 |

## Sparse Matrix

Sparse array is supported in gdsfmt since v1.24.0. Only non-zero values and indicies are stored in a GDS file, and reading a gds node of sparse matrix returns a `dgCMatrix` object defined in the package [Matrix](https://cran.r-project.org/package%3DMatrix).

```
# create a GDS file
f <- createfn.gds("test.gds")
set.seed(1000)
m <- matrix(sample(c(0:2), 56, replace=T), nrow=4)
(n <- add.gdsn(f, "sparse", m, storage="sp.int"))
```

```
## + sparse   { SparseInt32 4x14, 266B }
```

```
# get a dgCMatrix sparse matrix (.sparse=TRUE by default)
read.gdsn(n)
```

```
## 4 x 14 sparse Matrix of class "dgCMatrix"
##
## [1,] 2 2 1 . 2 2 . 1 2 1 . 1 . 2
## [2,] 1 . . . 1 1 1 2 1 1 1 . 1 1
## [3,] 2 1 1 1 . . 2 2 2 2 . . 2 1
## [4,] . 1 . 1 1 1 . 2 . 2 1 2 2 2
```

```
# get a dense matrix
read.gdsn(n, .sparse=FALSE)
```

```
##      [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10] [,11] [,12] [,13] [,14]
## [1,]    2    2    1    0    2    2    0    1    2     1     0     1     0     2
## [2,]    1    0    0    0    1    1    1    2    1     1     1     0     1     1
## [3,]    2    1    1    1    0    0    2    2    2     2     0     0     2     1
## [4,]    0    1    0    1    1    1    0    2    0     2     1     2     2     2
```

```
closefn.gds(f)
```

## Checksum for Data Integrity

Users can create hash function digests (e.g., md5, sha1, sha256, sha384, sha512) to verify data integrity, and md5 is the default digest algorithm. For example,

```
# create a GDS file
f <- createfn.gds("test.gds")
n <- add.gdsn(f, "raw", rnorm(1115), compress="ZIP", closezip=TRUE)
digest.gdsn(n, action="add")
```

```
##                                md5
## "73ff4a35fd00dac70998570ed654a834"
```

```
print(f, attribute=TRUE)
```

```
## File: /tmp/RtmpnYU7XE/Rbuild918ca48c558b8/gdsfmt/vignettes/test.gds (8.6K)
## +    [  ]
## \--+ raw   { Float64 1115 ZIP.def(96.1%), 8.4K } *< md5: 73ff4a35fd00dac70998570ed654a834
```

```
closefn.gds(f)
```

Reopen the file and verify data integrity:

```
f <- openfn.gds("test.gds")
n <- index.gdsn(f, "raw")

get.attr.gdsn(n)$md5
```

```
## [1] "73ff4a35fd00dac70998570ed654a834"
```

```
digest.gdsn(n, action="verify")  # NA indicates "not applicable"
```

```
##      md5     sha1   sha256   sha384   sha512    md5_r   sha1_r sha256_r
##     TRUE       NA       NA       NA       NA       NA       NA       NA
## sha384_r sha512_r
##       NA       NA
```

```
closefn.gds(f)
```

# Stylish Terminal Output in R

If the R package [crayon](https://cran.r-project.org/package%3Dcrayon) is installed in the R environment, `print()` can display the context of GDS file with different colours. For example, on MacOS, ![crayon output](data:image/jpeg;base64...)

Users can disable crayon terminal output by `options(gds.crayon=FALSE)`,

```
File: 1KG_autosome_phase3_shapeit2_mvncall_integrated_v5_20130502_genotypes.gds (3.4G)
+    [  ] *
|--+ sample.id   { VStr8 2504 ZIP_ra(27.15%), 5.4K }
|--+ snp.id   { Int32 81271745 ZIP_ra(34.58%), 112.4M }
|--+ snp.rs.id   { VStr8 81271745 ZIP_ra(38.67%), 193.1M }
|--+ snp.position   { Int32 81271745 ZIP_ra(39.73%), 129.1M }
|--+ snp.chromosome   { VStr8 81271745 ZIP_ra(0.10%), 190.2K }
|--+ snp.allele   { VStr8 81271745 ZIP_ra(17.05%), 57.3M }
|--+ genotype   { Bit2 2504x81271745 ZIP_ra(5.66%), 2.9G } *
\--+ snp.annot   [  ]
   |--+ qual   { Float32 81271745 ZIP_ra(0.10%), 316.1K }
   \--+ filter   { VStr8 81271745 ZIP_ra(0.15%), 592.0K }
```

# Session Information

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
## [1] Matrix_1.7-4  gdsfmt_1.46.0
##
## loaded via a namespace (and not attached):
##  [1] digest_0.6.37     R6_2.6.1          fastmap_1.2.0     xfun_0.53
##  [5] lattice_0.22-7    cachem_1.1.0      knitr_1.50        htmltools_0.5.8.1
##  [9] rmarkdown_2.30    lifecycle_1.0.4   cli_3.6.5         grid_4.5.1
## [13] sass_0.4.10       jquerylib_0.1.4   compiler_4.5.1    tools_4.5.1
## [17] evaluate_1.0.5    bslib_0.9.0       yaml_2.3.10       crayon_1.5.3
## [21] rlang_1.1.6       jsonlite_2.0.0
```