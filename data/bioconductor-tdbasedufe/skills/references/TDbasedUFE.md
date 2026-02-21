# TDbasedUFE

Y-h. Taguchi

#### 30 October 2025

# Contents

* [1 Installation](#installation)
* [2 Introduction](#introduction)
* [3 What are tensor and tensor decomposition?](#what-are-tensor-and-tensor-decomposition)
  + [3.1 Tensor decomposition based unsupervised feature extraction.](#tensor-decomposition-based-unsupervised-feature-extraction.)
  + [3.2 Optimization of standard deviation](#optimization-of-standard-deviation)
* [4 Multiomics data analysis](#multiomics-data-analysis)
* [5 Conclusions](#conclusions)

```
library(TDbasedUFE)
```

# 1 Installation

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("TDbasedUFE")
```

# 2 Introduction

TDbasedUFE is a R package that intends to perform various analyses using
Tensor decomposition based unsupervised feature extraction (TDbasedUFE)
(Taguchi [2020](#ref-Taguchi2020))
as much as possible in an user friendly manner.
Although in the future, I am planning to implement all the features possible
by TDbasedUFE in this R package, at the moment, it includes only basic
features.

# 3 What are tensor and tensor decomposition?

Although [tensor]
(<https://bioconductor.org/packages/release/bioc/vignettes/DelayedTensor/inst/doc/DelayedTensor_1.html#12_What_is_Tensor>)
and [tensor decomposition]
(<https://bioconductor.org/packages/release/bioc/vignettes/DelayedTensor/inst/doc/DelayedTensor_1.html#13_What_is_Tensor_Decomposition>)
were fully described in vignettes of
DelayedTensor(Tsuyuzaki [2022](#ref-DelayedTensor)), we also briefly describe these.

Tensor is a natural extension of matrix that has only rows and columns, whereas
tensor has more number of “rows” (or “columns”). For example, three mode tensor,
\(x\_{ijk} \in \mathbb{R}^{N \times M \times K}\), has three suffix,
\(i \in \mathbb{N}, j \in \mathbb{N}\), and \(k \in \mathbb{N}\), each of which
ranges \([1, N], [1, K]\) and \([1,M]\).
This representation fitted with that of genomic datasets, e. g., \(x\_{ijk}\) can
represent gene expression of \(i\)th gene of \(k\)th tissue of \(j\)th subject
(person). If the measurements are performed over multiple conditions, e.g.,
different time points, we can add additional sufix that corresponds to time.
Alternatively, we can also make use of tensor to store multiomics data if we
can add additional suffix that represent which of multiomics data is stored
in the elements of tensor.
Since the experimental design has become more and more complicated, tensor
is an ideal data structure to store modern genomic observations.

Although tensor can store very complicated structure well, it does not always
mean that it has ability to help us to understand these complicated structure.
In order to decompose tensor, tensor decomposition was developed. There are
various way to compose tensor. Usually, tensor decomposition (TD) is to
decompose tensor into product of some of vectors and tensors.

The most popular TD is CP decomposition, which can decompose tensor
into product some of vectors. For example,
\(x\_{ijk} \in \mathbb{R}^{N \times M \times K}\) can
be decomposed into the product sum of three vectors, \(\mathbb{R}^N, \mathbb{R}^M\), and \(\mathbb{R}^K\).

![](data:image/jpeg;base64...)

Tensor Decomposition

which can be mathematically expressed as
\[
x\_{ijk} = \sum\_\ell \lambda\_\ell u\_{\ell i} u\_{\ell j} u\_{\ell k}
\]
Alternatively, more advanced way, tensor train decomposition,
can decomposes the tensor to product of a mixture of matrix and tensor as
\[
x\_{ijk} = \sum\_{\ell\_1} \sum\_{\ell\_2}
R\_{\ell\_1 i} R\_{\ell\_1 \ell\_2 j} R\_{\ell\_2 k}
\]
However, in this specific study, we employed more primitive way of
decomposition, Tucker decomposition, as
\[
x\_{ijk} = \sum\_{\ell\_1} \sum\_{\ell\_2} \sum\_{\ell\_3}
G(\ell\_1 \ell\_2 \ell\_3) u\_{\ell\_1 i} u\_{\ell\_2 j} u\_{\ell\_3 k}
\]
where \(G \in \mathbb{R}^{N \times M \times K}\) is core tensor
that evaluate the weight of product
$ u\_{*1 i} u*{*2 j} u*{\_3 k}$ and
\(u\_{\ell\_1 i} \in \mathbb{R}^{N \times N}, u\_{\ell\_2 j} \in \mathbb{R}^{M \times M}, u\_{\ell\_3 k} \in \mathbb{R}^{K \times K}\)
are singular value matrices and are orthogonal matrices.

Although there are no uniqueness of Tucker decomposition, we specifically
employed higher order singular value decomposition (HOSVD) (Taguchi [2020](#ref-Taguchi2020)) to get
Tucker decomposition.
The reason why we employed Tucker decomposition was fully described in
my book(Taguchi [2020](#ref-Taguchi2020)).

## 3.1 Tensor decomposition based unsupervised feature extraction.

![](data:image/jpeg;base64...)

Tensor decomposition based unsupervised feature extraction

Here we briefly describe how we can make use of HOSVD for the feature
selection. Suppose \(x\_{ijk}\) represents the expression of gene \(i\) of the
\(k\)th tissue of the \(j\)th subject (person) and the task is to select genes
whose expression is distinct between patients and healthy controls only at one
specific tissue. In order that, we need to select \(u\_{\ell\_2 j}\) attributed
to \(j\)th subject which is distinct between healthy control and patients
(see (1)) and \(u\_{\ell\_3 k}\) attributed to \(k\)th tissue is \(k\)th tissue
specific (see (2)). Then we next identify which \(G(\ell\_1 \ell\_2 \ell\_3)\)
has the largest absolute value with fixed \(\ell\_2\) and \(\ell\_3\) that
correspond to distinction between patient and healthy control and tissue
specificity, respectively (see (3)). Finally, with assuming that
\(u\_{\ell\_1 i}\) obeys Gaussian distribution (null hypothesis), \(P\)-values
are attributed to \(i\)th gene.
\(P\)-values are corrected with considering multiple comparison corrections
(specifically, we employed Benjamini Hochberg method(Taguchi [2020](#ref-Taguchi2020))) and
genes associated with adjusted P-values less than 0.01 are usually
selected (see (4) and (5)).

## 3.2 Optimization of standard deviation

Although TD based unsupervised FE was proposed five years ago, it was
successfully applied to wide range of genomic science, together with the
proto type method, principal component analysis (PCA) based unsupervised
FE proposed ten years ago, we recently recognize that the optimization of
the standard deviation (SD) in Gaussian distribution employed as the null
hypothesis drastically improved the performance(Y-H Taguchi and Turki [2022](#ref-Taguchi2022a))
(Taguchi and Turki [2023](#ref-Taguchi2022)) (Roy and Taguchi [2022](#ref-Roy2022)).
How we can optimize SD and why the optimization of SD can improve the
performance is as follows. Previously, we computed SD of
\(u\_{\ell\_1 i}\), \(\sigma\_{\ell\_1}\) as
\[
\sigma\_{\ell\_1} = \sqrt{\frac{1}{N} \sum\_i \left ( u\_{\ell\_1 i} -
\langle u\_{\ell\_1i} \rangle\right)^2}
\]
\[
\langle u\_{\ell\_1 i} \rangle = \frac{1}{N} \sum\_i u\_{\ell\_1 i}.
\]
However, \(\sigma\_{\ell\_1}\) has tendency to be over estimated since some
of \(i\)th does not follow Gaussian distribution and has too large
absolute values.
In order to exclude those \(i\) that does not follow Gaussian, we tried
to minimize SD of \(h\_n\) which is the frequency of \(P\_i\) computed
with assuming that \(u\_{\ell\_1 i}\) obeys Gaussian and falling into
\(n\)th bin of histogram \(P\_i\)
\[
\sigma\_h = \sqrt{ \frac{1}{N\_h} \sum\_n \left
( h\_n - \langle h\_n \rangle \right)^2}
\]
where \(N\_h\) is the number of bins of the histogram of \(P\_i\) and
\[
\langle h\_n \rangle = \frac{1}{N\_h} \sum\_n h\_n
\]
with excluding some of \(P\_i\) which is supposed to be too small
to assume that obeys Gaussian (Null hypothesis). This is because
\(h\_n\) should be constant if all of \(P\_i\) follows Gaussian (Null hypothesis).

![](data:image/jpeg;base64...)

Left: \(\sigma\_h\) as a function of \(\sigma\_{\ell\_1}\).
Right: Histogram, \(h\_n\), of \(1-P\_i\) being computed
with the optimized \(\sigma\_{\ell\_1}\).

The above plot is output of examples of function selectFeature in TDbasedUFE
package and represents the dependence of \(\sigma\_h\) upon \(\sigma\_{\ell\_1}\)
as well as the resulting histogram \(h\_n\) of \(1-P\_i\) when \(u\_{\ell\_1 i}\) is
fully generated from Gaussian. The smallest \(\sigma\_h\) correctly corresponds
to the true \(\sigma\_{\ell\_1} (=0.01)\) and \(h\_n\) is almost independent of \(n\)
as expected.

Thus it is expected that \(\sigma\_h\) will take the smallest value when we
correctly exclude \(i\)s whose \(P\_i\) does not obey Gaussian (Null hypothesis).
The following is the step to optimized \(\sigma\_{\ell\_1}\).

1. Prepare initial \(\sigma\_{\ell\_1}\) and define threshold adjusted \(P\)-value,
   \(P\_0\).
2. Attribute \(P\_i\)s to \(i\)s with assuming Gaussian distribution of
   \(u\_{\ell\_1 i}\) using \(\sigma\_{\ell\_1}\).
3. Attribute adjusted \(P\_i\)s to \(i\)s with using Benjamini-Hochberg criterion.
4. Exclude \(i\)s associated with adjusted \(P\_i\) less than \(P\_0\).
5. Compute histogram of \(1-P\_i\) and \(\sigma\_h\).
6. Modify \(\sigma\_{\ell\_1}\) until \(\sigma\_h\) is minimized.
7. Finally, we identify excluded \(i\)s as the selected features because
   these \(i\)s do not obey Gaussian (Null hypothesis)

# 4 Multiomics data analysis

When we have multiomics data set composed of \(K\) omics data measured on
common \(M\) samples as
\[
x\_{i\_k j k} \in \mathbb{R}^{N\_k \times M \times K}
\]
where \(N\_k\) is the number of features in \(k\)th omics data, we can make
use of a tensor which is a bundle of linear kanel(Y.-h. Taguchi and Turki [2022](#ref-Taguchi2022b)).
In this case, we can generate liner kernel of \(k\)th omics data as
\[
x\_{jj'k} = \sum\_{i\_k} x\_{i\_kjk}x\_{i\_kj'k} \in \mathbb{R}^{M \times M \times K}
\]
to which HOSVD was applied and we get
\[
x\_{jj'k} = \sum\_{\ell\_1} \sum\_{\ell\_2} \sum\_{\ell\_3} G(\ell\_1 \ell\_2 \ell\_3)
u\_{\ell\_1 j} u\_{\ell\_2 j'} u\_{\ell\_3 k}
\]
where \(\ell\_1\) and \(\ell\_2\) are exchangeable, since \(x\_{jj'k} = x\_{j'jk}\).
Singular values attributed to features can be retrieved as
\[
u\_{\ell i\_k} = \sum\_j u\_{\ell j} x\_{i\_kj}
\]
Then the same procedure was applied to \(u\_{\ell i}\) in order to select
features.

![](data:image/jpeg;base64...)

Multiomics analysis

# 5 Conclusions

In this vignettes, we explain how TD based unsupervised FE can work
with optimized SD. In the other vignettes, we introduce how it works
well in the real examples.

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
#>  [1] MOFAdata_1.25.0      tximportData_1.37.5  tximport_1.38.0
#>  [4] readr_2.1.5          rTensor_1.4.9        GenomicRanges_1.62.0
#>  [7] Seqinfo_1.0.0        IRanges_2.44.0       S4Vectors_0.48.0
#> [10] BiocGenerics_0.56.0  generics_0.1.4       TDbasedUFE_1.10.0
#> [13] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] sass_0.4.10         hms_1.1.4           digest_0.6.37
#>  [4] magrittr_2.0.4      evaluate_1.0.5      bookdown_0.45
#>  [7] fastmap_1.2.0       jsonlite_2.0.0      promises_1.4.0
#> [10] BiocManager_1.30.26 jquerylib_0.1.4     cli_3.6.5
#> [13] shiny_1.11.1        rlang_1.1.6         crayon_1.5.3
#> [16] bit64_4.6.0-1       cachem_1.1.0        yaml_2.3.10
#> [19] otel_0.2.0          tools_4.5.1         parallel_4.5.1
#> [22] tzdb_0.5.0          httpuv_1.6.16       vctrs_0.6.5
#> [25] R6_2.6.1            mime_0.13           lifecycle_1.0.4
#> [28] bit_4.6.0           vroom_1.6.6         archive_1.1.12
#> [31] pkgconfig_2.0.3     pillar_1.11.1       bslib_0.9.0
#> [34] later_1.4.4         glue_1.8.0          Rcpp_1.1.0
#> [37] xfun_0.53           tibble_3.3.0        tidyselect_1.2.1
#> [40] knitr_1.50          xtable_1.8-4        htmltools_0.5.8.1
#> [43] rmarkdown_2.30      compiler_4.5.1
```

Roy, Sanjiban Sekhar, and Y-H. Taguchi. 2022. “Tensor Decomposition and Principal Component Analysis-Based Unsupervised Feature Extraction Outperforms State-of-the-Art Methods When Applied to Histone Modification Profiles.” *bioRxiv*. <https://doi.org/10.1101/2022.04.29.490081>.

Taguchi, Y-H. 2020. *Unsupervised Feature Extraction Applied to Bioinformatics*. Springer International Publishing. <https://doi.org/10.1007/978-3-030-22456-1>.

Taguchi, Y-H, and Turki Turki. 2022. “Adapted tensor decomposition and PCA based unsupervised feature extraction select more biologically reasonable differentially expressed genes than conventional methods.” *Scientific Reports* 12 (1): 17438. <https://doi.org/10.1038/s41598-022-21474-z>.

Taguchi, Y.-H., and Turki Turki. 2023. “Principal Component Analysis- and Tensor Decomposition-Based Unsupervised Feature Extraction to Select More Suitable Differentially Methylated Cytosines: Optimization of Standard Deviation Versus State-of-the-Art Methods.” *Genomics*, 110577. [https://doi.org/https://doi.org/10.1016/j.ygeno.2023.110577](https://doi.org/https%3A//doi.org/10.1016/j.ygeno.2023.110577).

Taguchi, Y-h, and Turki Turki. 2022. “Novel feature selection method via kernel tensor decomposition for improved multi-omics data analysis.” *BMC Medical Genomics* 15 (1): 37. <https://doi.org/10.1186/s12920-022-01181-4>.

Tsuyuzaki, Koki. 2022. *DelayedTensor: R Package for Sparse and Out-of-Core Arithmetic and Decomposition of Tensor*. <https://doi.org/10.18129/B9.bioc.DelayedTensor>.