Additional plots for:
Independent filtering
increases power for detecting differentially
expressed genes, Bourgon et al., PNAS (2010)

Richard Bourgon and Wolfgang Huber

October 30, 2025

Contents

1

2

3

4

Introduction .

.

.

.

Data preparation .

.

.

.

.

Filtering volcano plot .

Rejection count plots .

.

.

.

.

.

.

.

.

.

.

.

.

4.1

4.2

Across p-value cutoffs .

Across filtering fractions .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

1

1

2

3

3

4

1

Introduction

This vignette illustrates use of some functions in the genefilter package that provide useful
diagnostics for independent filtering [1]:

• kappa_p and kappa_t

• filtered_p and filtered_R

• filter_volcano

• rejection_plot

2

Data preparation

Load the ALL data set and the genefilter package:

library("genefilter")

library("ALL")

data("ALL")

Reduce to just two conditions, then take a small subset of arrays from these, with 3 arrays
per condition:

3

bcell <- grep("^B", as.character(ALL$BT))

moltyp <- which(as.character(ALL$mol.biol) %in%

c("NEG", "BCR/ABL"))

ALL_bcrneg <- ALL[, intersect(bcell, moltyp)]
ALL_bcrneg$mol.biol <- factor(ALL_bcrneg$mol.biol)
n1 <- n2 <- 3

set.seed(1969)
use <- unlist(tapply(1:ncol(ALL_bcrneg),

subsample <- ALL_bcrneg[,use]

ALL_bcrneg$mol.biol, sample, n1))

We now use functions from genefilter to compute overall standard devation filter statistics
as well as standard two-sample t and releated statistics.

S <- rowSds( exprs( subsample ) )

temp <- rowttests( subsample, subsample$mol.biol )

d <- temp$dm

p <- temp$p.value

t <- temp$statistic

3

Filtering volcano plot

Filtering on overall standard deviation and then using a standard t-statistic induces a lower
bound of fold change, albeit one which varies somewhat with the significance of the t-statistic.
The filter_volcano function allows you to visualize this effect.

The output is shown in the left panel of Fig. 1.

The kappa_p and kappa_t functions, used to make the volcano plot, compute the fold change
bound multiplier as a function of either a t-test p-value or the t-statistic itself. The actual
induced bound on the fold change is κ times the filter’s cutoff on the overall standard
deviation. Note that fold change bounds for values of |T | which are close to 0 are not of
practical interest because we will not reject the null hypothesis with test statistics in this
range.

The plot is shown in the right panel of Fig. 1.

Figure 1: Left panel: plot produced by the filter_volcano function. Right panel: graph of the kappa_t
function.

2

4.2

4

4.1

Rejection count plots

Across p-value cutoffs
The filtered_p function permits easy simultaneous calculation of unadjusted or adjusted
p-values over a range of filtering thresholds (θ). Here, we return to the full “BCR/ABL”
versus “NEG” data set, and compute adjusted p-values using the method of Benjamini and
Hochberg, for a range of different filter stringencies.

table(ALL_bcrneg$mol.biol)

##

## BCR/ABL

##

37

NEG

42

S2 <- rowVars(exprs(ALL_bcrneg))
p2 <- rowttests(ALL_bcrneg, "mol.biol")$p.value
theta <- seq(0, .5, .1)
p_bh <- filtered_p(S2, p2, theta, method="BH")

head(p_bh)

##

0%

10%

20%

30%

## [1,] 0.9185626 0.8943104 0.8624798 0.8278077

40%

NA

50%

NA

## [2,] 0.9585758 0.9460504 0.9304104 0.9059466 0.8874485 0.8709793

## [3,] 0.7022442

NA

NA

NA

## [4,] 0.9806216 0.9747555 0.9680574 0.9567131

## [5,] 0.9506087 0.9349386 0.9123998 0.8836386

NA

NA

NA

NA

NA

NA

## [6,] 0.6339004 0.5896890 0.5440851 0.4951371 0.4497915 0.4102711

The rejection_plot function takes sets of p-values corresponding to different filtering choices
— in the columns of a matrix or in a list — and shows how rejection count (R) relates to
the choice of cutoff for the p-values. For these data, over a reasonable range of FDR cutoffs,
increased filtering corresponds to increased rejections.

rejection_plot(p_bh, at="sample",

xlim=c(0,.3), ylim=c(0,1000),

main="Benjamini & Hochberg adjustment")

The plot is shown in the left panel of Fig. 2.

Figure 2: Left panel: plot produced by the rejection_plot function. Right panel: graph of theta.

3

4

4.2

Across filtering fractions
If we select a fixed cutoff for the adjusted p-values, we can also look more closely at the rela-
tionship between the fraction of null hypotheses filtered and the total number of discoveries.
The filtered_R function wraps filtered_p and just returns rejection counts. It requires a
p-value cutoff.

theta <- seq(0, .80, .01)
R_BH <- filtered_R(alpha=.10, S2, p2, theta, method="BH")

head(R_BH)

##

0% 1% 2% 3% 4% 5%

## 251 251 253 255 255 261

Because overfiltering (or use of a filter which is inappropriate for the application domain)
discards both false and true null hypotheses, very large values of θ reduce power in this
example:

plot(theta, R_BH, type="l",

xlab=expression(theta), ylab="Rejections",

main="BH cutoff = 0.1")

The plot is shown in the right panel of Fig. 2.

Session information

• R version 4.5.1 Patched (2025-08-23 r88802), x86_64-pc-linux-gnu

• Locale: LC_CTYPE=en_US.UTF-8, LC_NUMERIC=C, LC_TIME=en_GB, LC_COLLATE=C,
LC_MONETARY=en_US.UTF-8, LC_MESSAGES=en_US.UTF-8, LC_PAPER=en_US.UTF-8,
LC_NAME=C, LC_ADDRESS=C, LC_TELEPHONE=C, LC_MEASUREMENT=en_US.UTF-8,
LC_IDENTIFICATION=C

• Time zone: America/New_York

• TZcode source: system (glibc)

• Running under: Ubuntu 24.04.3 LTS

• Matrix products: default

• BLAS: /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

• LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0

• Base packages: base, datasets, grDevices, graphics, methods, stats, utils

• Other packages: ALL 1.51.0, Biobase 2.70.0, BiocGenerics 0.56.0, BiocStyle 2.38.0,

class 7.3-23, genefilter 1.92.0, generics 0.1.4, knitr 1.50

• Loaded via a namespace (and not attached): AnnotationDbi 1.72.0,
BiocManager 1.30.26, Biostrings 2.78.0, DBI 1.2.3, IRanges 2.44.0,
KEGGREST 1.50.0, Matrix 1.7-4, MatrixGenerics 1.22.0, R6 2.6.1, RSQLite 2.4.3,
Rcpp 1.1.0, S4Vectors 0.48.0, Seqinfo 1.0.0, XML 3.99-0.19, XVector 0.50.0,
annotate 1.88.0, bit 4.6.0, bit64 4.6.0-1, blob 1.2.4, bookdown 0.45, bslib 0.9.0,
cachem 1.1.0, cli 3.6.5, codetools 0.2-20, compiler 4.5.1, crayon 1.5.3, digest 0.6.37,

4

4

evaluate 1.0.5, fastmap 1.2.0, grid 4.5.1, highr 0.11, htmltools 0.5.8.1, httr 1.4.7,
jquerylib 0.1.4, jsonlite 2.0.0, lattice 0.22-7, lifecycle 1.0.4, magick 2.9.0,
magrittr 2.0.4, matrixStats 1.5.0, memoise 2.0.1, png 0.1-8, rlang 1.1.6,
rmarkdown 2.30, sass 0.4.10, splines 4.5.1, stats4 4.5.1, survival 3.8-3, tinytex 0.57,
tools 4.5.1, vctrs 0.6.5, xfun 0.53, xtable 1.8-4, yaml 2.3.10

References

[1] Richard Bourgon, Robert Gentleman and Wolfgang Huber. Independent filtering

increases power for detecting differentially expressed genes.

5

