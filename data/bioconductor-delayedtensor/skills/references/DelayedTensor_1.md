# 1. Concept of DelayedTensor

Koki Tsuyuzaki1 and Itoshi Nikaido1\*

1Laboratory for Bioinformatics Research, RIKEN Center for Biosystems Dynamics Research

\*k.t.the-answer@hotmail.co.jp

#### 29 October 2025

#### Package

DelayedTensor 1.16.0

**Authors**: Koki Tsuyuzaki [aut, cre]
**Last modified:** 2025-10-29 20:12:10.36772
**Compiled**: Wed Oct 29 23:32:57 2025

# 1 Introduction

## 1.1 Heterogenous Biological Data

Biological systems have very complicated structures like this
figure111 <https://f1000research.com/slides/9-1260>.

![](data:image/png;base64...)

Figure 1: Heterogenous Biological Data

For example, in the cell, DNA sequences are folded in cellular nucleus,
RNA molecules are transcripted from the DNA,
proteins are translated from the RNAs,
and finally, the proteins are related to cellular functions.
Outside of the cell, there are also many signals like a bacterial infection,
adding chemical reagents, drugs, lifestyle, and so on.
The change of these molecular types/phenomena finally causes the phenotype
such as disease, BMI, and morphology.
It is not possible to measure all molecular types or phenomena simultaneously,
so one or two of them are chosen and exhaustively measured.
This approach is called omics study and widely used.
For example, genomics measure all DNA sequences, and transcriptomics measure
all RNA molecules.

There is a need for a framework that can handle and analyze such
heterogeneous data structures in a unified manner and
provide biological interpretation.
Tensors are a mathematical framework
that can be very useful in such a situation.

## 1.2 What is Tensor

A tensor can be considered as a generalized form of data
representation222 <https://f1000research.com/slides/9-1260>.
For example, a scalar value, a vector, and a matrix are also called 0th-order
tensor, 1st-order tensor, and 2nd-order tensor, respectively.
If a data has three “modes” (1. height, 2. width, and 3. depth),
it is called a 3rd-order tensor.

![](data:image/png;base64...)

Figure 2: What is Tensor

That’s why any data is basically a tensor,
but in most cases, the term tensor implies 3rd-order or higher-order tensor.

## 1.3 What is Tensor Decomposition

Tensor decomposition is the extension of matrix decomposition.
If we have a third-order tensor,
gene times tissue times condition,
using tensor decomposition, we can extract a small number of
patterns333 <https://f1000research.com/slides/9-1260>.

![](data:image/png;base64...)

Figure 3: What is Tensor Decomposition

Each vector can be summarized to the multiple matrices and
these are called factor matrices.
The scalar values are summarized to a small tensor,
and this is called core tensor.

## 1.4 Concept of DelayedTensor: Block Processing-enabled Tensor Operations

A tensor is more than just a multi-dimensional array; as we will see later,
there are various operations that are specific to tensors, such as reshaping,
mode-wise statistics, and various tensor products.
These operations are essential in the analysis of tensor data and
the implementation of tensor decomposition algorithms.
Although the standard `array` of R language can express
increasing orders of tensors, it does not provide tensor-specific operations.
Therefore, many R users manipulate tensor data by using
the functions implemented in the *[rTensor](https://CRAN.R-project.org/package%3DrTensor)* package for now.
Although *[rTensor](https://CRAN.R-project.org/package%3DrTensor)* is very useful,
it assumes the input object to be an in-memory array.
On the other hand, tensors can easily become huge
as the order and the size of each mode increase,
and may no longer fit in memory.

*[DelayedTensor](https://bioconductor.org/packages/3.22/DelayedTensor)* is implmented for such extreamly huge tensor data.
*[DelayedTensor](https://bioconductor.org/packages/3.22/DelayedTensor)* provides some functions of *[rTensor](https://CRAN.R-project.org/package%3DrTensor)*
by reimplementing them with *[DelayedArray](https://bioconductor.org/packages/3.22/DelayedArray)*.
*[DelayedArray](https://bioconductor.org/packages/3.22/DelayedArray)* is a framework that allows us to use the data
on the disk as if it were a standard array in R.
There are some out-of-core backend file system such as *[HDF5Array](https://bioconductor.org/packages/3.22/HDF5Array)*
and *[TileDBArray](https://bioconductor.org/packages/3.22/TileDBArray)* used in *[DelayedArray](https://bioconductor.org/packages/3.22/DelayedArray)*
and the incremental calculations can be performed
by implementing the functions in support of “block processing”.

The functionality of DelayedTensor is fourfold.
![Figure 4: Concept of DelayedTensor](data:image/png;base64...)

1. **Block-Processing Tensor Reshaping**: Operations such as folding
   and unfolding a higher-order tensor data into a matrix
   can be performed while taking care of the block size.
2. **Block-Processing Tensor Arithmetic**: Calculation of sums and averages
   for each mode, and operations such as Hadamard product, Kronecker product,
   and Khatri-Rao product can be performed while taking care of block size.
3. **Block-Processing Tensor Decomposition**: Some of the tensor decomposition
   algorithms implemented in *[rTensor](https://CRAN.R-project.org/package%3DrTensor)* have been reimplemented using
   reshaping and arithmetic functions of *[DelayedTensor](https://bioconductor.org/packages/3.22/DelayedTensor)*.
4. **Block-Processing einsum**: In addition to the *[rTensor](https://CRAN.R-project.org/package%3DrTensor)*
   functions, the *[einsum](https://CRAN.R-project.org/package%3Deinsum)* function, which is well-known as
   the Numpy (Python) function, has also been reimplemented based on
   *[DelayedArray](https://bioconductor.org/packages/3.22/DelayedArray)* and the block processing framework.
   *[einsum](https://CRAN.R-project.org/package%3Deinsum)* is a very powerful preprocessing method
   to merge multiple tensor data into a single tensor.

Although what is executed inside the functions are very different,
the function name, argument name, and value name are exactly the same
as those of *[rTensor](https://CRAN.R-project.org/package%3DrTensor)*
so that *[rTensor](https://CRAN.R-project.org/package%3DrTensor)* users can easily introduce them.

# Session information

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
## [1] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] digest_0.6.37       R6_2.6.1            bookdown_0.45
##  [4] fastmap_1.2.0       xfun_0.53           cachem_1.1.0
##  [7] knitr_1.50          htmltools_0.5.8.1   rmarkdown_2.30
## [10] lifecycle_1.0.4     cli_3.6.5           sass_0.4.10
## [13] jquerylib_0.1.4     compiler_4.5.1      tools_4.5.1
## [16] evaluate_1.0.5      bslib_0.9.0         yaml_2.3.10
## [19] BiocManager_1.30.26 jsonlite_2.0.0      rlang_1.1.6
```