# 01 BiocHail – GWAS tutorial from hail.is

Vincent J. Carey, stvjc at channing.harvard.edu

#### October 29, 2025

# Contents

* [1 Introduction](#introduction)
* [2 Installing `BiocHail`](#installing-biochail)
* [3 Acquire a slice of the 1000 genomes genotypes and annotations](#acquire-a-slice-of-the-1000-genomes-genotypes-and-annotations)
  + [3.1 Initialization, data acquisition, rendering](#initialization-data-acquisition-rendering)
  + [3.2 Helper functions](#helper-functions)
  + [3.3 Acquiring `column fields`](#acquiring-column-fields)
  + [3.4 Adding the sample annotation to the MatrixTable; aggregation](#adding-the-sample-annotation-to-the-matrixtable-aggregation)
* [4 Working with variants; quality assessment](#working-with-variants-quality-assessment)
  + [4.1 A histogram of read depths](#a-histogram-of-read-depths)
  + [4.2 Quality summaries](#quality-summaries)
  + [4.3 Filtering](#filtering)
    - [4.3.1 Sample quality](#sample-quality)
    - [4.3.2 Genotype quality](#genotype-quality)
    - [4.3.3 Variant characteristics](#variant-characteristics)
* [5 GWAS execution](#gwas-execution)
  + [5.1 Association test for quantitative response](#association-test-for-quantitative-response)
  + [5.2 Evaluating population stratification](#evaluating-population-stratification)
* [6 Conclusions](#conclusions)
* [SessionInfo](#sessioninfo)

# 1 Introduction

This document explores using Hail 0.2 with R
via basilisk.

The computations follow the
[GWAS tutorial](https://hail.is/docs/0.2/tutorials/01-genome-wide-association-study.html)
in the hail documentation. We won’t do all the computations
there, and we add some material dealing with R-python
interfacing. We’ll note that the actual computations on
large data are done in Spark, but we don’t interact directly
with Spark at all in this document.

Most of the computations are done via reticulate
calls to python; the access to the hail environment
is through basilisk. We also take advantage of
R markdown’s capacity to execute python code directly.
If an R chunk computes `x`, a python chunk can refer
to it as `r.x`. If a python chunk computes `r.x`,
an R chunk can refer to this value as `x`.

# 2 Installing `BiocHail`

`BiocHail` should be installed as follows:

```
if (!require("BiocManager"))
    install.packages("BiocManager")
BiocManager::install("BiocHail")
```

As of 1.0.0, a JDK for Java version `<=` 11.0 is necessary
to use the version of Hail that is installed with the package.
This package should be usable on MacOS with suitable java
support. If Java version `>=` 8.x is used, warnings from
Apache Spark may be observed. To the best of our knowledge
the conditions to which the warnings pertain do not affect program performance.

# 3 Acquire a slice of the 1000 genomes genotypes and annotations

In this section we import the 1000 genomes VCF slice
distributed by the hail project. `hail_init` uses basilisk,
which ensures that a specific version of hail and
its dependencies are available in an isolated virtual environment.

```
library(BiocHail)
library(ggplot2)
```

## 3.1 Initialization, data acquisition, rendering

Here is a curiosity of R-hail interaction. Note that
the following chunk computes `mt`, a MatrixTable
representation of 1000 genomes data, but our
attempt to print it in markdown fails.

```
hl <- hail_init()
mt <- get_1kg(hl)
mt
print(mt$rows()$select()$show(5L)) # limited info
```

We can use the python syntax in a `python` R markdown
chunk to see what we want. We use prefix `r.` to
find references defined in our R session (compiling
the vignette).

```
r.mt.rows().select().show(5) # python chunk!
```

The sample IDs:

```
r.mt.s.show(5)  # python chunk!
```

## 3.2 Helper functions

Some methods return data
immediately useful in R.

```
mt$count()
```

We can thus define a function `dim` to behave with
hail MatrixTable instances
in a familiar way, along with some others.

```
dim.hail.matrixtable.MatrixTable <- function(x) {
  tmp <- x$count()
  c(tmp[[1]], tmp[[2]])
}
dim(mt)
ncol.hail.matrixtable.MatrixTable <- function(x) {
 dim(x)[2]
}
nrow.hail.matrixtable.MatrixTable <- function(x) {
 dim(x)[1]
}
nrow(mt)
```

These can be useful on their own, or when calling python methods.

## 3.3 Acquiring `column fields`

```
annopath <- path_1kg_annotations()
tab <- hl$import_table(annopath, impute=TRUE)$key_by("Sample")
```

```
r.tab.describe()# python chunk!
r.tab.show(width=100)
```

## 3.4 Adding the sample annotation to the MatrixTable; aggregation

We combine the `tab` defined above, with the MatrixTable instance,
using python code reaching to R via `r.`.

```
r.mt = r.mt.annotate_cols(pheno = r.tab[r.mt.s])   # python chunk!
r.mt.col.describe()
```

Aggregation methods can be used to obtain contingency tables or descriptive statistics.

First, we get the frequencies of superpopulation membership:

```
mt$aggregate_cols(hl$agg$counter(mt$pheno$SuperPopulation))
```

Then statistics on caffeine consumption:

```
uu <- mt$aggregate_cols(hl$agg$stats(mt$pheno$CaffeineConsumption))
names(uu)
uu$mean
uu$stdev
```

# 4 Working with variants; quality assessment

The significance of the aggregation functions is that the computations
are performed by Spark, on potentially huge distributed data structures.

Now we aggregate over rows (SNPs). We’ll use python directly:

```
from pprint import pprint  # python chunk!
snp_counts = r.mt.aggregate_rows(r.hl.agg.counter(r.hl.Struct(ref=r.mt.alleles[0], alt=r.mt.alleles[1])))
pprint(snp_counts)
```

## 4.1 A histogram of read depths

Hail uses the concept of ‘entries’ for matrix elements, and each ‘entry’
is a ‘struct’ with potentially many fields.

Here we’ll use R to compute a histogram of sequencing depths
over all samples and variants.

```
p_hist <- mt$aggregate_entries(
     hl$expr$aggregators$hist(mt$DP, 0L, 30L, 30L))
names(p_hist)
length(p_hist$bin_edges)
length(p_hist$bin_freq)
midpts <- function(x) diff(x)/2+x[-length(x)]
dpdf <- data.frame(x=midpts(p_hist$bin_edges), y=p_hist$bin_freq)
ggplot(dpdf, aes(x=x,y=y)) + geom_col() + ggtitle("DP") + ylab("Frequency")
```

An exercise: produce a function `mt_hist` that produces
a histogram of measures from any of the relevant
VCF components of a MatrixTable instance.

Note also all the aggregators available:

```
names(hl$expr$aggregators)
```

We’d also note that hail has a [direct interface to ggplot2](https://hail.is/docs/0.2/tutorials/09-ggplot.html).

## 4.2 Quality summaries

A high-level function adds quality metrics to the MatrixTable.

```
mt <- hl$sample_qc(mt)
```

```
r.mt.col.describe()  # python!
```

The call rate histogram is given by:

```
callrate <- mt$sample_qc$call_rate$collect()
graphics::hist(callrate)
```

## 4.3 Filtering

### 4.3.1 Sample quality

We’ll use the python code given for filtering, in which per-sample
mean read depth and call rate are must exceed (arbitrarily chosen) thresholds.

```
# python chunk!
r.mt = r.mt.filter_cols((r.mt.sample_qc.dp_stats.mean >= 4) & (r.mt.sample_qc.call_rate >= 0.97))
print('After filter, %d/284 samples remain.' % r.mt.count_cols())
```

### 4.3.2 Genotype quality

Again we use the python code for filtering according to

* relative purity of reads underlying homozygous reference or alt calls
* good balance of ref/alt counts for het calls

```
ab = r.mt.AD[1] / r.hl.sum(r.mt.AD)

filter_condition_ab = ((r.mt.GT.is_hom_ref() & (ab <= 0.1)) |
                        (r.mt.GT.is_het() & (ab >= 0.25) & (ab <= 0.75)) |
                        (r.mt.GT.is_hom_var() & (ab >= 0.9)))

fraction_filtered = r.mt.aggregate_entries(r.hl.agg.fraction(~filter_condition_ab))
print(f'Filtering {fraction_filtered * 100:.2f}% entries out of downstream analysis.')
r.mt = r.mt.filter_entries(filter_condition_ab)
```

Note that filtering *entries* does not change MatrixTable shape.

```
dim(mt)
```

### 4.3.3 Variant characteristics

Allele frequencies, Hardy-Weinberg equilibrium test results
and other summaries are obtained using the `variant_qc` function.

```
mt = hl$variant_qc(mt)
```

```
r.mt.row.describe()  #! python
```

# 5 GWAS execution

A built-in procedure for testing for association between the
(simulated) caffeine consumption measure and genotype
will be used.

The following commands eliminate variants with minor allele frequency
less than 0.01, along with those with small \(p\)-values in
tests of Hardy-Weinberg equilibrium.

```
r.mt = r.mt.filter_rows(r.mt.variant_qc.AF[1] > 0.01)
r.mt = r.mt.filter_rows(r.mt.variant_qc.p_value_hwe > 1e-6)
r.mt.count()
```

## 5.1 Association test for quantitative response

Now we perform a naive test of association. The Manhattan
plot generated by hail can be displayed for interaction
using bokeh. We comment this out for now; it should
be possible to embed the bokeh display in this document but the details
are not ready-to-hand.

```
r.gwas = r.hl.linear_regression_rows(y=r.mt.pheno.CaffeineConsumption,
                                 x=r.mt.GT.n_alt_alleles(),
                                 covariates=[1.0])
# r.pl = r.hl.plot.manhattan(r.gwas.p_value)
# import bokeh
# bokeh.plotting.show(r.pl)
```

The “QQ plot” that helps evaluate adequacy of the analysis
can be formed using `hl.plot.qq` for very large applications;
here we collect the results for plotting in R.

First we estimate \(\lambda\_{GC}\)

```
pv = gwas$p_value$collect()
x2 = stats::qchisq(1-pv,1)
lam = stats::median(x2, na.rm=TRUE)/stats::qchisq(.5,1)
lam
```

And the qqplot:

```
qqplot(-log10(ppoints(length(pv))), -log10(pv), xlim=c(0,8), ylim=c(0,8),
  ylab="-log10 p", xlab="expected")
abline(0,1)
```

There is hardly any point to examining a Manhattan plot in
this situation. But let’s see how it might be done.
We’ll use igvR to get an interactive and extensible display.

```
locs <- gwas$locus$collect()
conts <- sapply(locs, function(x) x$contig)
pos <- sapply(locs, function(x) x$position)
library(igvR)
mytab <- data.frame(chr=as.character(conts), pos=pos, pval=pv)
gt <- GWASTrack("simp", mytab, chrom.col=1, pos.col=2, pval.col=3)
igv <- igvR()
setGenome(igv, "hg19")
displayTrack(igv, gt)
```

## 5.2 Evaluating population stratification

An approach to assessing population stratification
is provided as `hwe_normalized_pca`. See
the hail [methods docs](https://hail.is/docs/0.2/methods/genetics.html#hail.methods.hwe_normalized_pca)
for details.

We are avoiding a tuple assignment in the tutorial document.

```
r.pcastuff = r.hl.hwe_normalized_pca(r.mt.GT)
r.mt = r.mt.annotate_cols(scores=r.pcastuff[1][r.mt.s].scores)
```

We’ll collect the key information and plot.

```
sc <- pcastuff[[2]]$scores$collect()
pc1 = sapply(sc, "[", 1)
pc2 = sapply(sc, "[", 2)
fac = mt$pheno$SuperPopulation$collect()
myd = data.frame(pc1, pc2, pop=fac)
library(ggplot2)
ggplot(myd, aes(x=pc1, y=pc2, colour=factor(pop))) + geom_point()
```

Now repeat the association test with adjustments for
population of origin and gender.

```
r.gwas2 = r.hl.linear_regression_rows(
    y=r.mt.pheno.CaffeineConsumption,
    x=r.mt.GT.n_alt_alleles(),
    covariates=[1.0,r.mt.pheno.isFemale,r.mt.scores[0],
        r.mt.scores[1], r.mt.scores[2]])
```

New value of \(\lambda\_{GC}\):

```
pv = gwas2$p_value$collect()
x2 = stats::qchisq(1-pv,1)
lam = stats::median(x2, na.rm=TRUE)/stats::qchisq(.5,1)
lam
```

A manhattan plot for chr8:

```
locs <- gwas2$locus$collect()
conts <- sapply(locs, function(x) x$contig)
pos <- sapply(locs, function(x) x$position)
mytab <- data.frame(chr=as.character(conts), pos=pos, pval=pv)
ggplot(mytab[mytab$chr=="8",], aes(x=pos, y=-log10(pval))) + geom_point()
```

# 6 Conclusions

The tutorial document proceeds with some illustrations of
arbitrary aggregations. We will skip these for now.

Additional vignettes will address

* A more realistic higher-volume VCF
* Working with UKBB Summary statistics in GCP
  + <https://pan.ukbb.broadinstitute.org/docs/hail-format/index.html>
* Representing linkage disequilibrium
  + <https://pan-dev.ukbb.broadinstitute.org/docs/ld/index.html>
* Simulating variant collections using Balding-Nichols
* Simulating variant collections using Pritchard-Stephens-Donnelly
* Connecting genotypes with phenotype data in FHIR

# SessionInfo

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
## [1] ggplot2_4.0.0    BiocHail_1.10.0  BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] rappdirs_0.3.3      sass_0.4.10         generics_0.1.4
##  [4] RSQLite_2.4.3       lattice_0.22-7      digest_0.6.37
##  [7] magrittr_2.0.4      RColorBrewer_1.1-3  evaluate_1.0.5
## [10] grid_4.5.1          bookdown_0.45       fastmap_1.2.0
## [13] blob_1.2.4          jsonlite_2.0.0      Matrix_1.7-4
## [16] DBI_1.2.3           BiocManager_1.30.26 scales_1.4.0
## [19] httr2_1.2.1         jquerylib_0.1.4     cli_3.6.5
## [22] rlang_1.1.6         dbplyr_2.5.1        bit64_4.6.0-1
## [25] withr_3.0.2         cachem_1.1.0        yaml_2.3.10
## [28] tools_4.5.1         dir.expiry_1.18.0   parallel_4.5.1
## [31] memoise_2.0.1       dplyr_1.1.4         filelock_1.0.3
## [34] basilisk_1.22.0     BiocGenerics_0.56.0 curl_7.0.0
## [37] reticulate_1.44.0   vctrs_0.6.5         R6_2.6.1
## [40] png_0.1-8           BiocFileCache_3.0.0 lifecycle_1.0.4
## [43] bit_4.6.0           pkgconfig_2.0.3     gtable_0.3.6
## [46] pillar_1.11.1       bslib_0.9.0         glue_1.8.0
## [49] Rcpp_1.1.0          xfun_0.53           tibble_3.3.0
## [52] tidyselect_1.2.1    dichromat_2.0-0.1   knitr_1.50
## [55] farver_2.1.2        htmltools_0.5.8.1   rmarkdown_2.30
## [58] compiler_4.5.1      S7_0.2.0
```