# Estimating Enrichment in PhIP-Seq Experiments with BEER

Athena Chen, Kai Kammers, Rob Scharpf and Ingo Ruczinski

#### November 16, 2025

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
  + [2.1 `rjags`](#rjags)
  + [2.2 `beer`](#beer)
* [3 Simulated data](#simulated-data)
* [4 edgeR](#edger)
* [5 BEER (Bayesian Estimation Enrichment in R)](#beer-bayesian-estimation-enrichment-in-r)
  + [5.1 Prior parameters](#prior-parameters)
  + [5.2 Removing super enriched peptides](#removing-super-enriched-peptides)
  + [5.3 Saving MCMC samples](#saving-mcmc-samples)
* [6 Beads-only round robin](#beads-only-round-robin)
* [7 Parallelization](#parallelization)
* [8 Plot Helpers](#plot-helpers)
  + [8.1 `getExpected()`](#getexpected)
  + [8.2 `getBF()`](#getbf)
* [9 `sessionInfo()`](#sessioninfo)

# 1 Introduction

Phage immuno-precipitation sequencing (PhIP-seq) is a high-throughput approach for characterizing antibody responses to a variety of target antigens. A typical component of PhIP-seq analyses involves identifying which peptides elicit enriched antibody responses. `beer` provides two approaches for identifying peptide enrichments.

The first approach is based on [`edgeR`](https://bioconductor.org/packages/release/bioc/html/edgeR.html)’s standard pipeline for identifying differential expression from read count data111 Robinson MD, McCarthy DJ and Smyth GK (2010). edgeR: a Bioconductor package for differential expression analysis of digital gene expression data. Bioinformatics 26, 139-140222 McCarthy DJ, Chen Y and Smyth GK (2012). Differential expression analysis of multifactor RNA-Seq experiments with respect to biological variation. Nucleic Acids Research 40, 4288-4297333 Chen Y, Lun ATL, Smyth GK (2016). From reads to genes to pathways: differential expression analysis of RNA-Seq experiments using Rsubread and the edgeR quasi-likelihood pipeline. F1000Research 5, 1438. Though [`edgeR`](https://bioconductor.org/packages/release/bioc/html/edgeR.html) is remarkably effective at quickly identifying enriched antibody responses, it is less likely to pick up enriched peptides at the lower fold-change range.

The second approach, Bayesian Estimation in R (BEER) was developed specifically for the PhIP-seq setting and implements a Bayesian model to identify peptide enrichments as described in Chen et. al444 Chen A, Kammers K, Larman HB, Scharpf R, Ruczinski I. Detecting antibody reactivities in phage immunoprecipitation sequencing data (2022). *bioRxiv*. <https://www.biorxiv.org/content/10.1101/2022.01.19.476926v1>. Though BEER is more likely to identify enriched peptides at the lower fold-change range, it tends to take much longer to run.

Along with `beer`, we will use the following packages in this vignette:

```
library(ggplot2)
library(dplyr)
```

# 2 Installation

## 2.1 `rjags`

For Bayesian MCMC modeling, `beer` relies on *[rjags](https://CRAN.R-project.org/package%3Drjags)* to interface [Just Another Gibbs Sampler (JAGS)](https://mcmc-jags.sourceforge.io/). JAGS can be downloaded from [this link](https://sourceforge.net/projects/mcmc-jags/files/). [Homebrew](https://brew.sh/) users can install JAGS using,

```
brew install jags
```

For M1 Mac users using Rosetta emulation of intel, Homebrew installation of JAGS will likely work. However, we recommend installing JAGS from source for all other M1 Mac users.

Once JAGS has been installed, *[rjags](https://CRAN.R-project.org/package%3Drjags)* can be installed in `R` via `install.packages("rjags")`.

## 2.2 `beer`

Once `rjags` and `PhIPData` have been installed, the stable release version of `beer` in Bioconductor can be installed using `BiocManager`:

```
BiocManager::install("beer")
```

To load the package:

```
library(beer)
```

# 3 Simulated data

To demonstrate `beer`, we simulate a small toy data set of 10 samples, each with 50 peptides. Four of the ten samples were beads-only samples, and each of the six remaining samples had 5 enriched peptides. Note that since there are rather few beads-only samples, each with very few peptides, the inference is likely to be very poor.

Parameters for non-enriched peptides were derived from beads-only samples run with samples from HIV elite controllers. For the code to generate the data set, see `file.path(package = "beer", "script/sim_data.R")`.

```
data_path <- system.file("extdata/sim_data.rds", package = "beer")
sim_data <- readRDS(data_path)

sim_data
#> class: PhIPData
#> dim: 10 10
#> metadata(8): seed a_pi ... b_c fc
#> assays(8): counts logfc ... true_b true_theta
#> rownames(10): 1 2 ... 9 10
#> rowData names(2): a_0 b_0
#> colnames(10): 1 2 ... 9 10
#> colData names(5): group n_init n true_c true_pi
#> beads-only name(4): beads
```

# 4 edgeR

Differentially enriched peptides between a particular serum sample and all beads-only samples indicate enriched antibody responses to those peptides. Thus, to identify enriched peptides, we can run the standard *[edgeR](https://bioconductor.org/packages/3.22/edgeR)* pipeline for differential expression.

The `runEdgeR()` function estimates peptide-specific dispersion parameters then tests identifies differentially expressed peptides using either the exact test proposed by Robinson and Smyth555 Robinson MD and Smyth GK. Small-sample estimation of negative binomial dispersion, with applications to SAGE data (2008). *Biostatistics*, 9, 321-332. <https://doi.org/10.1093/biostatistics/kxm030> (default, also specified with `de.method = "exactTest"`), or the GLM quasi-likelihood F-test666 Lun, ATL, Chen, Y, and Smyth, GK. It’s DE-licious: a recipe for differential expression analyses of RNA-seq experiments using quasi-likelihood methods in edgeR (2016). *Methods in Molecular Biology*, 1418, 391–416. (specified with `de.method = "glmQLFTest"`). Since peptides are enriched only if average proportion of reads pulled in the serum sample is higher than the average proportion of reads pulled in a beads-only samples, two-sided p-values are converted to one-sided p-values.

edgeR log10 p-values and log2 estimated fold-changes are returned in the assays specified by **`assay.names`**.

```
edgeR_out <- runEdgeR(sim_data,
                      assay.names = c(logfc = "edgeR_logfc",
                                      prob = "edgeR_logpval"))
```

Using BH correction to adjust for multiple testing, enriched peptides are given by the matrix,

```
assay(edgeR_out, "edgeR_hits") <- apply(
  assay(edgeR_out, "edgeR_logpval"), 2,
  function(sample){
    pval <- 10^(-sample)
    p.adjust(pval, method = "BH") < 0.05
  })

colSums(assay(edgeR_out, "edgeR_hits"))
#>  1  2  3  4  5  6  7  8  9 10
#> NA NA NA NA  1  1  1  0  0  1
```

# 5 BEER (Bayesian Estimation Enrichment in R)

BEER uses a Bayesian hierarchical model to derive posterior probabilities of enrichment and estimated fold-changes. Briefly, each sample is run individually in comparison to all beads-only samples as follows:

1. **Define prior parameters.** Though most prior parameters are supplemented by the user (or use the defaults), prior parameters for non-enriched peptides are first approximated using all beads-only samples.
2. **Identify super enriched peptides.** Based on the prior parameters, super enriched peptides are first excluded as these peptides should always have posterior probabilities of enrichment of 1.
3. **Re-estimate beads-only prior parameters.** Prior parameters are then reestimated from the beads-only samples for the remaining peptides.
4. **Initialize and run the MCMCs.** To reduce convergence time, MLE estimates are used to initialize the MCMC sampler, and samples are drawn from the posterior distributions of the unknown parameters.
5. **Summarize and store results.** Posterior samples are summarized using the means of the posterior distribution and are stored in the PhIPData object.

BEER can be easily run with `brew()`. Like with `runEdgeR()`, results are stored in the locations specified by `assay.names`. We can add the existing results to our edgeR output as follows.

```
## Named vector specifying where we want to store the summarized MCMC output
## NULL indicates that the output should not be stored.
assay_locations <- c(
  phi = "beer_fc_marg",
  phi_Z = "beer_fc_cond",
  Z = "beer_prob",
  c = "sampleInfo",
  pi = "sampleInfo"
)

beer_out <- brew(edgeR_out, assay.names = assay_locations)
```

Thus, supposing peptides with posterior probability above 0.5 are enriched and noting that super enriched peptides were not run (and thus are missing entries in the posterior probability matrix), the matrix of enriched peptides is given by,

```
## Define matrix of peptides that were run in BEER
was_run <- matrix(rep(beer_out$group != "beads", each = nrow(beer_out)),
                  nrow = nrow(beer_out))

## Identify super-enriched peptides
## These peptides were in samples that were run, but have missing posterior
## probabilities
are_se <- was_run & is.na(assay(beer_out, "beer_prob"))

## Enriched peptides are peptides with:
## - posterior probability > 0.5, OR
## - super-enriched peptides
assay(beer_out, "beer_hits") <- assay(beer_out, "beer_prob") > 0.5 | are_se

colSums(assay(beer_out, "beer_hits"))
#>  1  2  3  4  5  6  7  8  9 10
#> NA NA NA NA  3  1  1  1  0  1
```

Each of the steps above are controlled by arguments within `brew()` and are described in a bit more detail in the following sections.

## 5.1 Prior parameters

The model relies on the following prior parameters:

* `a_pi`, `b_pi`: shape parameters for a beta distribution that describes the proportion of peptides expected to be enriched in a given sample. The defaults are `a_pi = 2`, `b_pi = 300`.
* `a_phi`, `b_phi`: shape parameters for a gamma distribution that describes fold-change for enriched peptides. This distribution is shifted by `fc` (see below). By default, `a_phi = 1.25`, `b_phi = 0.1`.
* `a_c`, `b_c`: shape parameters for the attenuation constant. The defaults are `a_c = 80`, `b_c = 20`.
* `fc`: minimum fold-change for an enriched peptide, defaults to 1.
* `a_0j`, `b0j`: peptide-specific shape parameters. For peptide \(j\), `a_0j`, `b_0j` are the shape parameters for the beta distribution that describes the proportion of reads pulled presuming the peptide is not enriched.

The default prior distributions for the proportion of enriched peptides in a serum sample, the fold-change for enriched peptides, and the attenuation constants are shown below.

![](data:image/png;base64...)

Prior parameters are specified in the **`prior.params`** argument of `brew()`. Rather than supplying `a_0j` and `b_0j`, the user can alternatively specify a method of deriving `a_0j` and `b_0j` from the beads-only samples. Currently, `beer` supports MOM, MLE, and edgeR estimates for `a_0j`, `b_0j`. Additional parameters for these methods can be supplied using the **`beads.args`** parameter of `brew()`. Alternatively the user can supply custom `a_0j`, `b_0j` to `prior.params`. Note that when `a_0j` and `b_0j` are supplied, the prior parameters are not re-calculated after tossing out clearly enriched peptides.

For convenience, beta parameters can be estimated using MLE or MOM given a vector of proportions using `getAB()`. For any beta distribution, the MCMC sampler may get stuck for shape parameters less than one, so if possible it is safer for beta shape parameters to be greater than one.

## 5.2 Removing super enriched peptides

Super enriched peptides are peptides with MLE or edgeR estimated fold-changes in comparison to beads-only samples above a given threshold, which is defaulted to 15. These peptides should always have posterior probability 1 of being enriched. The more peptides that are identified as super enriched, the faster BEER runs. However, the threshold should be conservatively set such that all peptides are guaranteed to be enriched. In `brew()`, the argument **`se.params`** controls how super enriched peptides are identified.

## 5.3 Saving MCMC samples

JAGS parameters, such as the number of chains, number of iteration, thinning parameters, and more are defined in **`jags.params`** and directly passed to `rjags::jags.model()` and `rjags::coda.samples()`.

By default, if **`sample.dir = NULL`** in `brew()`, the samples from each MCMC run are saved in the `R` temporary directory given by `tempdir()`. Samples can be saved by specifying a non-null sample directory. The posterior samples for each serum sample are saved in an RDS files named after the serum sample ID.

Is is important to note that MCMC parameters are indexed by row and column. Since super enriched peptides are tossed out *before* running the MCMC, the row index of the parameter does not necessarily correspond to the row of the PhIPData object. For example parameter `Z[5, 1]` could in reality correspond to peptide 8 in the PhIPData object if there were three peptides before peptide 8 that were labeled as super-enriched.

# 6 Beads-only round robin

To approximate the false positive rate, we often run each of the beads-only samples against all other beads-only samples. This beads-only round robin also provides a sense of how similar the beads-only samples are to each other.

The beads-only round robin can be included in `brew()` and `runEdgeR()` by specifying `beadsRR = TRUE`.

```
## edgeR with beadsRR
edgeR_beadsRR <- runEdgeR(sim_data, beadsRR = TRUE,
                          assay.names = c(logfc = "edgeR_logfc",
                                          prob = "edgeR_logpval"))
## Calculate hits
assay(edgeR_beadsRR, "edgeR_hits") <- apply(
  assay(edgeR_beadsRR, "edgeR_logpval"), 2,
  function(sample){
    pval <- 10^(-sample)
    p.adjust(pval, method = "BH") < 0.05
  })

## Note samples 1-4 have 0 instead of NA now
colSums(assay(edgeR_beadsRR, "edgeR_hits"))
#>  1  2  3  4  5  6  7  8  9 10
#>  0  0  0  0  1  1  1  0  0  1
```

```
## BEER with beadsRR added to edgeR output
beer_beadsRR <- brew(edgeR_beadsRR, beadsRR = TRUE,
                     assay.names = assay_locations)

## Check BEER hits like before
was_run <- matrix(rep(beer_beadsRR$group != "beads", each = nrow(beer_beadsRR)),
                  nrow = nrow(beer_beadsRR))
are_se <- was_run & is.na(assay(beer_beadsRR, "beer_prob"))
beer_hits <- assay(beer_beadsRR, "beer_prob") > 0.5 | are_se

## Note again that samples 1-4 are not NA
colSums(beer_hits)
#>  1  2  3  4  5  6  7  8  9 10
#>  0  0  0  0  3  1  1  1  0  1
```

Alternatively, one can run `beadsRR()` separately,

```
## edgeR with beadsRR
edgeR_beadsRR <- beadsRR(sim_data, method = "edgeR",
                         assay.names = c(logfc = "edgeR_logfc",
                                         prob = "edgeR_logpval"))
## Calculate hits
assay(edgeR_beadsRR, "edgeR_hits") <- apply(
  assay(edgeR_beadsRR, "edgeR_logpval"), 2,
  function(sample){
    pval <- 10^(-sample)
    p.adjust(pval, method = "BH") < 0.05
  })

## Note samples 5-10 are NA now
colSums(assay(edgeR_beadsRR, "edgeR_hits"))
#>  1  2  3  4  5  6  7  8  9 10
#>  0  0  0  0 NA NA NA NA NA NA
```

```
## BEER with beadsRR added to edgeR output
beer_beadsRR <- beadsRR(edgeR_beadsRR, method = "beer",
                        assay.names = assay_locations)

## Check BEER hits like before
was_run <- matrix(rep(beer_beadsRR$group == "beads", each = nrow(beer_beadsRR)),
                  nrow = nrow(beer_beadsRR))
are_se <- was_run & is.na(assay(beer_beadsRR, "beer_prob"))
beer_hits <- assay(beer_beadsRR, "beer_prob") > 0.5 | are_se

## Note again that samples 5-10 are now NA
colSums(beer_hits)
#>  1  2  3  4  5  6  7  8  9 10
#>  0  0  0  0 NA NA NA NA NA NA
```

# 7 Parallelization

By default, `beer` runs using the first registered back-end for parallelization as returned by `BiocParallel::bpparam()`. Other parallel evaluation environments are supported via the [`BiocParallel`](https://bioconductor.org/packages/release/bioc/html/BiocParallel.html) package (see the [BiocParallel vignette](https://bioconductor.org/packages/release/bioc/vignettes/BiocParallel/inst/doc/Introduction_To_BiocParallel.pdf) for a list of possible parallelization environments). In both `brew()` and `runEdgeR`, the parallel environments are passed via the `BPPARAM` argument which takes a `BiocParallelParam` object.

```
## Run edgeR using different parallel environments
runEdgeR(sim_data, BPPARAM = BiocParallel::SerialParam())
#> class: PhIPData
#> dim: 10 10
#> metadata(8): seed a_pi ... b_c fc
#> assays(8): counts logfc ... true_b true_theta
#> rownames(10): 1 2 ... 9 10
#> rowData names(2): a_0 b_0
#> colnames(10): 1 2 ... 9 10
#> colData names(5): group n_init n true_c true_pi
#> beads-only name(4): beads
runEdgeR(sim_data, BPPARAM = BiocParallel::SnowParam())
#> class: PhIPData
#> dim: 10 10
#> metadata(8): seed a_pi ... b_c fc
#> assays(8): counts logfc ... true_b true_theta
#> rownames(10): 1 2 ... 9 10
#> rowData names(2): a_0 b_0
#> colnames(10): 1 2 ... 9 10
#> colData names(5): group n_init n true_c true_pi
#> beads-only name(4): beads

## Run beer in parallel
brew(sim_data, BPPARAM = BiocParallel::SerialParam())
#> class: PhIPData
#> dim: 10 10
#> metadata(8): seed a_pi ... b_c fc
#> assays(8): counts logfc ... true_b true_theta
#> rownames(10): 1 2 ... 9 10
#> rowData names(2): a_0 b_0
#> colnames(10): 1 2 ... 9 10
#> colData names(7): group n_init ... c pi
#> beads-only name(4): beads
brew(sim_data, BPPARAM = BiocParallel::SnowParam())
#> class: PhIPData
#> dim: 10 10
#> metadata(8): seed a_pi ... b_c fc
#> assays(8): counts logfc ... true_b true_theta
#> rownames(10): 1 2 ... 9 10
#> rowData names(2): a_0 b_0
#> colnames(10): 1 2 ... 9 10
#> colData names(7): group n_init ... c pi
#> beads-only name(4): beads
```

# 8 Plot Helpers

To facilitate visualization of PhIP-Seq analyses, `beer` includes plot helpers that calculate values of interest and stores these values as a new assays in the `PhIPData` object. Currently, these functions include:

* `getExpected()` returns expected reads/proportions pulled by a peptide based on the average proportion of reads pulled across all beads-only samples,
* `getBF()`: returns Bayes factors for the probability of enriched antibody responses for each peptide.

## 8.1 `getExpected()`

To calculate the expected read counts and proportion of reads, we can specify `type = c("rc", "prop")` in `getExpected()`. This resulting `PhIPData` object can be converted to a `DataFrame`/`tibble` which can be plotted using any plotting method of choice. For example, we can visualize the simulated data set by plotting the observed read counts to the expected read counts as follows,

We can visualize the simulated data by plotting the observed versus the expected number of reads.

![Observed versus expected read counts for simulated data. Each point represents a peptide in a given sample. Point in red indicate truly enriched peptides.](data:image/png;base64...)

Figure 1: Observed versus expected read counts for simulated data
Each point represents a peptide in a given sample. Point in red indicate truly enriched peptides.

## 8.2 `getBF()`

Once `brew()` has been run on a `PhIPData` object, we can plot Bayes factors for peptide enrichment using the `getBF()` plot helper. `getBF()` returns a `PhIPData` object with Bayes factors stored as an additional assay. For example, on the simulated data set, a plot of Bayes factors by peptide can be generated as follows,

![Bayes factors for simulated data.](data:image/png;base64...)

Figure 2: Bayes factors for simulated data

# 9 `sessionInfo()`

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
#>  [1] beer_1.14.1                 rjags_4-17
#>  [3] coda_0.19-4.1               PhIPData_1.18.0
#>  [5] SummarizedExperiment_1.40.0 Biobase_2.70.0
#>  [7] GenomicRanges_1.62.0        Seqinfo_1.0.0
#>  [9] IRanges_2.44.0              S4Vectors_0.48.0
#> [11] BiocGenerics_0.56.0         generics_0.1.4
#> [13] MatrixGenerics_1.22.0       matrixStats_1.5.0
#> [15] dplyr_1.1.4                 ggplot2_4.0.1
#> [17] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] gtable_0.3.6        xfun_0.54           bslib_0.9.0
#>  [4] httr2_1.2.1         lattice_0.22-7      vctrs_0.6.5
#>  [7] tools_4.5.1         parallel_4.5.1      curl_7.0.0
#> [10] tibble_3.3.0        RSQLite_2.4.4       blob_1.2.4
#> [13] pkgconfig_2.0.3     Matrix_1.7-4        dbplyr_2.5.1
#> [16] RColorBrewer_1.1-3  S7_0.2.1            lifecycle_1.0.4
#> [19] compiler_4.5.1      farver_2.1.2        tinytex_0.57
#> [22] statmod_1.5.1       codetools_0.2-20    snow_0.4-4
#> [25] htmltools_0.5.8.1   sass_0.4.10         yaml_2.3.10
#> [28] pillar_1.11.1       jquerylib_0.1.4     BiocParallel_1.44.0
#> [31] DelayedArray_0.36.0 cachem_1.1.0        limma_3.66.0
#> [34] magick_2.9.0        abind_1.4-8         tidyselect_1.2.1
#> [37] locfit_1.5-9.12     digest_0.6.38       purrr_1.2.0
#> [40] bookdown_0.45       labeling_0.4.3      splines_4.5.1
#> [43] fastmap_1.2.0       grid_4.5.1          cli_3.6.5
#> [46] SparseArray_1.10.1  magrittr_2.0.4      S4Arrays_1.10.0
#> [49] dichromat_2.0-0.1   edgeR_4.8.0         withr_3.0.2
#> [52] filelock_1.0.3      scales_1.4.0        rappdirs_0.3.3
#> [55] bit64_4.6.0-1       rmarkdown_2.30      XVector_0.50.0
#> [58] bit_4.6.0           progressr_0.18.0    memoise_2.0.1
#> [61] evaluate_1.0.5      knitr_1.50          BiocFileCache_3.0.0
#> [64] rlang_1.1.6         Rcpp_1.1.0          glue_1.8.0
#> [67] DBI_1.2.3           BiocManager_1.30.27 jsonlite_2.0.0
#> [70] R6_2.6.1
```