# Sequence logos for DNA sequence alignments

Oliver Bembom1 and Robert Ivánek2,3\*

1Division of Biostatistics, University of California, Berkeley
2Department of Biomedicine, University of Basel, Basel, Switzerland
3Swiss Institute of Bioinformatics, Basel, Switzerland

\*robert.ivanek@unibas.ch

#### 30 October 2025

#### Package

seqLogo 1.76.0

**Last edited**: 08 May 2020

# 1 Introduction

An alignment of DNA or amino acid sequences is commonly represented in
the form of a position weight matrix (PWM), a \(J \times W\) matrix in
which position \((j,w)\) gives the probability of observing nucleotide
\(j\) in position \(w\) of an alignment of length \(W\). Here \(J\) denotes the
number of letters in the alphabet from which the sequences were derived.
An important summary measure of a given position weight matrix is its
information content profile (Schneider et al. [1986](#ref-Schneider1986)). The information
content at position \(w\) of the motif is given by

\[
IC(w) = \log\_2(J) + \sum\_{j=1}^J p\_{wj}\log\_2(p\_{wj}) = \log\_2(J) - entropy(w).
\]

The information content is measured in bits and, in the case of DNA
sequences, ranges from 0 to 2 bits. A position in the motif at which
all nucleotides occur with equal probability has an information
content of 0 bits, while a position at which only a single nucleotide
can occur has an information content of 2 bits. The information
content at a given position can therefore be thought of as giving a
measure of the tolerance for substitutions in that position: Positions
that are highly conserved and thus have a low tolerance for
substitutions correspond to high information content, while positions
with a high tolerance for substitutions correspond to low information
content.

Sequence logos are a graphical representation of sequence alignments
developed by (Schneider and Stephens [1990](#ref-Schneider1990)). Each logo consists of stacks of symbols,
one stack for each position in the sequence. The overall height of the
stack is proportional to the information content at that position,
while the height of symbols within the stack indicates the relative
frequency of each amino or nucleic acid at that position. In general,
a sequence logo provides a richer and more precise description of, for
example, a binding site, than would a consensus sequence.

# 2 Software implementation

The *[seqLogo](https://bioconductor.org/packages/3.22/seqLogo)* package provides an R implementation for plotting
such sequence logos for alignments consisting of DNA sequences. Before
being able to access this functionality, the user is required to load
the package using the `library()` command:

```
library(seqLogo)
```

## 2.1 The `pwm-class`

The *[seqLogo](https://bioconductor.org/packages/3.22/seqLogo)* package defines the class `pwm` which can
be used to represent position weight matrices. An instance of this
class can be constructed from a simple matrix or a data frame using the
function `makePWM()`:

```
mFile <- system.file("extdata/pwm1", package="seqLogo")
m <- read.table(mFile)
m
##    V1  V2  V3  V4  V5  V6  V7  V8
## 1 0.0 0.0 0.0 0.3 0.2 0.0 0.0 0.0
## 2 0.8 0.2 0.8 0.3 0.4 0.2 0.8 0.2
## 3 0.2 0.8 0.2 0.4 0.3 0.8 0.2 0.8
## 4 0.0 0.0 0.0 0.0 0.1 0.0 0.0 0.0
p <- makePWM(m)
```

`makePWM()` checks that all column probabilities add up to 1.0
and also obtains the information content profile and consensus sequence
for the position weight matrix. These can then be accessed through the
corresponding slots of the created object:

```
slotNames(p)
## [1] "pwm"       "width"     "ic"        "alphabet"  "consensus"
pwm(p)
##     1   2   3   4   5   6   7   8
## A 0.0 0.0 0.0 0.3 0.2 0.0 0.0 0.0
## C 0.8 0.2 0.8 0.3 0.4 0.2 0.8 0.2
## G 0.2 0.8 0.2 0.4 0.3 0.8 0.2 0.8
## T 0.0 0.0 0.0 0.0 0.1 0.0 0.0 0.0
ic(p)
## [1] 1.2780719 1.2780719 1.2780719 0.4290494 0.1535607 1.2780719 1.2780719
## [8] 1.2780719
consensus(p)
## [1] "CGCGCGCG"
```

## 2.2 Plotting sequence logos

The `seqLogo()` function plots sequence logos.

### 2.2.1 Input

1. The position weight matrix for which the sequence logo is to be plotted,
   `pwm`. This may be either an instance of class `pwm`, as defined by the
   package *[seqLogo](https://bioconductor.org/packages/3.22/seqLogo)*, a `matrix`, or a `data.frame`.
2. A `logical` `ic.scale` indicating whether the height
   of each column is to be proportional to its information content, as
   originally proposed by (Schneider et al. [1986](#ref-Schneider1986)). If `ic.scale=FALSE`,
   all columns have the same height.

### 2.2.2 Example

The call `seqLogo(p)` produces the sequence logo shown in figure
[**??**](#seqlogo1). Alternatively, we can use `seqLogo(p, ic.scale=FALSE)`
to obtain the sequence logo shown in figure [**??**](#seqlogo2) in which
all columns have the same height.

```
seqLogo(p)
```

![Sequence logo with column heights proportional to information content.](data:image/png;base64...)

Figure 1: Sequence logo with column heights proportional to information content

```
seqLogo(p, ic.scale=FALSE)
```

![Sequence logo with uniform column heights.](data:image/png;base64...)

Figure 2: Sequence logo with uniform column heights

It is also possible to change the default colors by providing a named character
vector as a `fill` argument `seqLogo` function.

```
seqLogo(p, fill=c(A="#4daf4a", C="#377eb8", G="#ffd92f", T="#e41a1c"),
        ic.scale=FALSE)
```

![Sequence logo with user specified colors.](data:image/png;base64...)

Figure 3: Sequence logo with user specified colors

The RNA logos are supported as well. In this particular case, the `seqLogo`
will either accept `fill` colors specified for `c("A", "C", "G", "U")` letters
or `c("A", "C", "G", "T")` and uses the color specified in element “T”
for letter “U”.

```
r <- makePWM(m, alphabet="RNA")
seqLogo(r, ic.scale=FALSE)
```

![RNA Sequence logo.](data:image/png;base64...)

Figure 4: RNA Sequence logo

## 2.3 Software Design

The following features of the programming approach employed in
*[seqLogo](https://bioconductor.org/packages/3.22/seqLogo)* may be of interest to users.

**Class/method object-oriented programming**. Like many other Bioconductor
packages, *[seqLogo](https://bioconductor.org/packages/3.22/seqLogo)* has adopted the
*S4 class/method objected-oriented programming approach* presented in
(Chambers [1998](#ref-Chambers1998)). In particular, a new class, `pwm`, is defined to represent
a position weight matrix. The plot method for this class is set to produce
the sequence logo corresponding to this class.

**Use of the `grid` package**. The `grid` package is used to draw the sequence
letters from graphical primitives. We note that this should make it easy
to extend the package to amino acid sequences.

# 3 SessionInfo

The following is the session info that generated this vignette:

```
sessionInfo()
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
## [1] grid      stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
## [1] seqLogo_1.76.0   BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] digest_0.6.37       R6_2.6.1            bookdown_0.45
##  [4] fastmap_1.2.0       xfun_0.53           cachem_1.1.0
##  [7] knitr_1.50          htmltools_0.5.8.1   rmarkdown_2.30
## [10] stats4_4.5.1        lifecycle_1.0.4     cli_3.6.5
## [13] sass_0.4.10         jquerylib_0.1.4     compiler_4.5.1
## [16] tools_4.5.1         evaluate_1.0.5      bslib_0.9.0
## [19] yaml_2.3.10         BiocManager_1.30.26 jsonlite_2.0.0
## [22] rlang_1.1.6
```

# References

Chambers, John M. 1998. *Programming with Data: A Guide to the S Language*. Springer.

Schneider, Thomas D., and R.Michael Stephens. 1990. “Sequence logos: a new way to display consensus sequences.” *Nucleic Acids Research* 18 (20): 6097–6100. <https://doi.org/10.1093/nar/18.20.6097>.

Schneider, Thomas D., Gary D. Stormo, Larry Gold, and Andrzej Ehrenfeucht. 1986. “Information Content of Binding Sites on Nucleotide Sequences.” *Journal of Molecular Biology* 188 (3): 415–31. [https://doi.org/https://doi.org/10.1016/0022-2836(86)90165-8](https://doi.org/https%3A//doi.org/10.1016/0022-2836%2886%2990165-8).