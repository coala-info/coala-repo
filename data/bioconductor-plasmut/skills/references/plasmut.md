# Modeling the origin of mutations identified in a liquid biopsy: cancer or clonal hematopoiesis?

Adith S. Arun and Robert B. Scharpf

#### 2025-10-30

#### Abstract

Mutation-based approaches for detection of cancer from cell-free DNA (cfDNA) using liquid biopsies have the potential to track a patient’s response to treatment, enabling effective and timely decisions on therapy. However, mutations arising from clonal hematopoeisis (CH) are common and tumor biopsies for definitive identification of the origin of these mutations is not always available. Sequencing of matched cells from buffy coat and the absence of mutations in these cells has been used as a test to rule-out CH, but uneven sequencing depths between matched cell-free DNA and buffy coat samples and the potential for contamination of buffy coat with circulating tumor cells (CTCs) are not captured by rule-based analyses. This package estimates Bayes factors that weigh the evidence of competing CH- and tumor-origin models of cfDNA mutations detected in cfDNA, requiring only the allele frequencies of high quality alignments available from standard mutation callers.

# Contents

* [1 Motivating example](#motivating-example)
* [2 Installation](#installation)
* [3 Data organization](#data-organization)
* [4 Approach and implementation](#approach-and-implementation)
  + [4.1 Bayesian model](#bayesian-model)
  + [4.2 Implementation](#implementation)
  + [4.3 Efficiency of importance sampler](#efficiency-of-importance-sampler)
* [5 Application to van’t Erve et al.](#application-to-vant-erve-et-al.)
* [6 Session information](#session-information)

# 1 Motivating example

Assume mutation analyses identify four fragments with a *TP53* variant out of 1000 fragments overlapping that position.
In matched WBC sequencing, we observed no fragments with this mutation out of 600 distinct fragments spanning this position.
While *TP53* is a well-known tumor suppressor, mutations in *TP53* are also common in CH.
Given the mutant allele frequencies in cfDNA and matched buffy coat sequencing and prior studies, how strong is the evidence that the *TP53* mutation is tumor-derived?

# 2 Installation

Install the plasmut package from Bioconductor

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("plasmut")
```

# 3 Data organization

```
library(magrittr)
library(tidyverse)
library(plasmut)
knitr::opts_chunk$set(cache=TRUE)
lo <- function(p) log(p/(1-p))
```

We assume the following minimal representation for the mutation data such that each row uniquely identifies a mutation within a sample.

```
## sample data
p53 <- tibble(y=c(4, 0),
              n=c(1000, 600),
              analyte=c("plasma", "buffy coat"),
              mutation="TP53",
              sample_id="id1")
dat <- p53 %>%
    unite("uid", c(sample_id, mutation), remove=FALSE) %>%
    group_by(uid) %>%
    nest()
## required format for plasmut
dat
```

```
## # A tibble: 1 × 2
## # Groups:   uid [1]
##   uid      data
##   <chr>    <list>
## 1 id1_TP53 <tibble [2 × 5]>
```

# 4 Approach and implementation

## 4.1 Bayesian model

Let (\(y\_p\), \(n\_p\)) denote the number of mutant reads and total number of distinct reads in plasma and (\(y\_w\), \(n\_w\)) the corresponding frequencies from the buffy coat.
Assuming that the mutation is either tumor- or CH-derived, the posterior odds is given by
\[\frac{p(S | y\_p, y\_w, n\_p, n\_w)}{p(H | y\_p, y\_w, n\_p, n\_w)} = \frac{p(y\_w, y\_p | n\_p, n\_w, S)}{p(y\_w, y\_p | n\_p, n\_w, H)} \cdot \frac{p(S)}{p(H)}, \]
where *S* indicates the somatic (tumor-derived) model and H denotes the hematopietic (CH-derived) model.
The term \(\frac{p(y\_w, y\_p | n\_p, n\_w, S)}{p(y\_w, y\_p | n\_p, n\_w, H)}\) is the Bayes factor and is a ratio of the marginal likelihoods.
For the denominator, we assume that the unobserved true mutant allele frequency (\(\theta\)) in plasma is the same as the mutant allele frequency in buffy coat and rewrite the marginal likelihood as \(\int\_{\theta} p(y\_p | \theta, n\_p) p(y\_w | \theta, n\_w) p(\theta | H)d\theta\).
We suggest a diffuse prior for \(\theta\) to provide support for both rare and common CH mutations.

For model *S*, the marginal likelihood is factored as \(\int\_{\theta\_p} p(y\_p | n\_p, \theta\_p) p(\theta\_p | S)d\theta\_p\int\_{\theta\_w} p(y\_w | n\_w, \theta\_w) p(\theta\_w | S) d\theta\_w\).
A diffuse prior for \(\theta\_p\) allows support for both rare and common somatic mutations.
Under model \(S\), \(\theta\_W\) is \(> 0\) if circulating tumor cells (CTCs) are inter-mixed with white blood cells in the buffy coat.
As CTCs tend to be uncommon even in patients with late-stage disease, we suggest a prior distribution that concentrates most of the mass near zero (i.e., Beta(1, \(10^3\))).

## 4.2 Implementation

We can compute marginal likelihoods for model \(S\) and \(H\) by simply drawing Monte Carlo samples from the priors and approximating the above integrals by the mean.
However, when the likelihood is much more concentrated than the prior, this sampling approach can be inefficient and numerically unstable.
To mitigate these issues, we implemented an importance sampling approach where the target distribution for the importance sampler is a weighted average of the prior and posterior.
The resulting mixture distribution has a shape similar to the posterior but with fatter tails.
As the target distribution ensures that we sample values of \(\theta\) where the posterior has a positive likelihood, approximation of the marginal likelihoods is more accurate with fewer Monte Carlo simulations.

In the following code block, we assume that
(1) the probability that CTCs are mixed in with the WBCs is small (e.g., 1 CTC per 1,000 cells) using a Beta(1, 10^3) prior,
(2) the prior for \(\theta\_p\) is relatively diffuse (Beta(1, 9)), and
(3) the prior for germline or CHIP variants in WBCs is also relatively diffuse (Beta(1, 9)).
A mixture weight of 0.1 for the prior (`prior.weight`) concentrates most of the mass of the target distribution on the posterior:

```
## Parameters
param.list <- list(ctc=list(a=1, b=10e3),
                   ctdna=list(a=1, b=9),
                   chip=list(a=1, b=9),
                   montecarlo.samples=50e3,
                   prior.weight=0.1)
```

Next, we estimate the marginal likelihood for the mutation frequencies under the \(S\) and \(H\) models and return all Monte Carlo samples in a list.
For running this model on datasets with a large number of candidate tumor-derived mutations, we recommend saving only the marginal likelihoods and Bayes factors by setting `save_montecarlo=FALSE`.

```
stats <- importance_sampler(dat$data[[1]], param.list)
## Just the mutation-level summary statistics (marginal likelihoods and bayes factors)
importance_sampler(dat$data[[1]], param.list, save_montecarlo=FALSE)
```

```
## # A tibble: 1 × 4
##       ctc ctdna  chip bayesfactor
##     <dbl> <dbl> <dbl>       <dbl>
## 1 -0.0583 -4.75 -7.09        2.28
```

We view the plasma MAF of 4/1000 and buffy coat MAF of 0/600 as weak evidence that the mutation is tumor derived (Bayes factor = 9.76).
As previous studies have demonstrated that *TP53* mutations are common in CH, our prior odds is 1 and so the posterior odds for the tumor-origin model is the same as the Bayes factor, 9.76.

## 4.3 Efficiency of importance sampler

As long as `montecarlo.samples` is big enough, we should obtain a similar estimate of the marginal likelihood without importance sampling.
Since our target distribution \(g\) is a mixture of the prior and posterior with weight `prior.weight`, setting `prior.weight=1` just samples \(\theta\)’s from our prior (i.e., importance sampling is not implemented). Below, we compare the stability of the Bayes factor estimate as a function of the Monte Carlo sample size and prior weight:

```
fun <- function(montecarlo.samples, data,
                param.list, prior.weight=0.1){
    param.list$montecarlo.samples <- montecarlo.samples
    param.list$prior.weight <- prior.weight
    res <- importance_sampler(data, param.list,
                              save_montecarlo=FALSE) %>%
        mutate(montecarlo.samples=montecarlo.samples,
               prior.weight=param.list$prior.weight)
    res
}
fun2 <- function(montecarlo.samples, data,
                 param.list, prior.weight=0.1,
                 nreps=100){
    res <- replicate(nreps, fun(montecarlo.samples, data,
                                param.list,
                                prior.weight=prior.weight),
                     simplify=FALSE) %>%
        do.call(bind_rows, .) %>%
        group_by(montecarlo.samples, prior.weight) %>%
        summarize(mean_bf=mean(bayesfactor),
                  sd_bf=sd(bayesfactor),
                  .groups="drop")
    res
}
S <- c(100, 1000, seq(10e3, 50e3, by=10000))
results <- S %>%
    map_dfr(fun2, data=dat$data[[1]], param.list=param.list)
results2 <- S %>%
    map_dfr(fun2, data=dat$data[[1]], param.list=param.list,
            prior.weight=1)
combined <- bind_rows(results, results2)
```

```
combined %>%
    mutate(prior.weight=factor(prior.weight)) %>%
    ggplot(aes(montecarlo.samples, sd_bf)) +
    geom_point(aes(color=prior.weight)) +
    geom_line(aes(group=prior.weight, color=prior.weight)) +
    scale_y_log10() +
    theme_bw(base_size=16) +
    xlab("Monte Carlo samples") +
    ylab("Standard deviation of\n log Bayes Factor")
```

![](data:image/png;base64...)

Note that with importance sampling, relatively stable estimates for the Bayes factor are obtained with as few as 10,000 Monte Carlo samples while sampling from the prior distribution is very unstable for small sample sizes.

```
combined %>%
    mutate(prior.weight=factor(prior.weight)) %>%
    filter(montecarlo.samples > 100) %>%
    ggplot(aes(prior.weight, mean_bf)) +
    geom_point() +
    theme_bw(base_size=16) +
    ylab("Mean log Bayes factor") +
    xlab("Prior weight")
```

![](data:image/png;base64...)

# 5 Application to van’t Erve et al.

We illustrate this approach on a dataset of cfDNA and matched buffy coat sequencing for patients with metastatic colorectal cancer (van ’t Erve et al. [2023](#ref-vanterve2023)).
Below, we select four mutations and run the importance sampler for these candidate mutations independently.

```
data(crcseq, package="plasmut")
crcseq %>% select(-position)
```

```
## # A tibble: 8 × 6
##   patient gene  aa     analyte        y     n
##     <int> <chr> <chr>  <chr>      <int> <int>
## 1      12 APC   E1306* plasma       395  1750
## 2      12 APC   E1306* buffy coat     0   963
## 3      12 HRAS  Y96F   plasma         4  1541
## 4      12 HRAS  Y96F   buffy coat     0   946
## 5      13 FGFR2 428V>E plasma         4  2400
## 6      13 FGFR2 428V>E buffy coat     0  1297
## 7     157 TP53  M237K  plasma        15  2969
## 8     157 TP53  M237K  buffy coat     5  1495
```

```
params <- list(ctdna = list(a = 1, b = 9),
               ctc = list(a = 1, b = 10^3),
               chip = list(a= 1, b = 9),
               montecarlo.samples = 50e3,
               prior.weight = 0.1)
muts <- unite(crcseq, "uid", c(patient, gene), remove = FALSE) %>%
        group_by(uid) %>% nest()
#Each element of the data column contains a table with the variant and total allele counts in plasma and buffy coat.
#Run the importance sampler
muts$IS <- muts$data %>% map(importance_sampler, params)
fun <- function(x){
    result <- x$data %>%
        select(-position) %>%
        mutate(bayes_factor = x$IS$bayesfactor$bayesfactor)
    return(result)
}
bf <- apply(muts, 1, fun)
bf %>% do.call(rbind, .) %>%
    as_tibble() %>%
    select(patient, gene, aa, bayes_factor) %>%
    rename(log_bf=bayes_factor) %>%
    distinct()
```

```
## # A tibble: 4 × 4
##   patient gene  aa     log_bf
##     <int> <chr> <chr>   <dbl>
## 1      12 APC   E1306* 190.
## 2      12 HRAS  Y96F     1.72
## 3      13 FGFR2 428V>E   1.32
## 4     157 TP53  M237K   -1.14
```

For the E1306\* *APC* mutation, 395 of 1750 fragments in cfDNA contain the mutation while zero of 963 fragments from buffy coat contain this mutation.
The evidence that E1306\* is tumor-derived is definitive (log Bayes factor = 190).
For the M237K *TP53* mutation, we observe 5 mutations out of 1495 fragments in buffy coat and 15 mutations out of 2969 fragments in cfDNA.
The observed mutant read rate is roughly equal in WBC and cfDNA, providing further evidence that the variant likely originates from CH.
As indicated by our prior, we feel that a high CTC fraction in buffy coat is very unlikely given the rarity of CTCs relative to white blood cells in buffy coat.
The log Bayes factor (equivalent to the posterior log odds assuming a prior odds of 1) is -1.14.
The probability that the mutation is tumor-derived is only 0.25 (\(\frac{exp(-1.14)}{exp(-1.14) + 1}\) or 0.24).

# 6 Session information

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
##  [1] plasmut_1.8.0    lubridate_1.9.4  forcats_1.0.1    stringr_1.5.2
##  [5] dplyr_1.1.4      purrr_1.1.0      readr_2.1.5      tidyr_1.3.1
##  [9] tibble_3.3.0     ggplot2_4.0.0    tidyverse_2.0.0  magrittr_2.0.4
## [13] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] sass_0.4.10         utf8_1.2.6          generics_0.1.4
##  [4] stringi_1.8.7       hms_1.1.4           digest_0.6.37
##  [7] evaluate_1.0.5      grid_4.5.1          timechange_0.3.0
## [10] RColorBrewer_1.1-3  bookdown_0.45       fastmap_1.2.0
## [13] jsonlite_2.0.0      tinytex_0.57        BiocManager_1.30.26
## [16] scales_1.4.0        codetools_0.2-20    jquerylib_0.1.4
## [19] cli_3.6.5           rlang_1.1.6         withr_3.0.2
## [22] cachem_1.1.0        yaml_2.3.10         tools_4.5.1
## [25] tzdb_0.5.0          vctrs_0.6.5         R6_2.6.1
## [28] lifecycle_1.0.4     magick_2.9.0        pkgconfig_2.0.3
## [31] pillar_1.11.1       bslib_0.9.0         gtable_0.3.6
## [34] glue_1.8.0          Rcpp_1.1.0          xfun_0.53
## [37] tidyselect_1.2.1    knitr_1.50          dichromat_2.0-0.1
## [40] farver_2.1.2        htmltools_0.5.8.1   rmarkdown_2.30
## [43] labeling_0.4.3      compiler_4.5.1      S7_0.2.0
```

van ’t Erve, Iris, Jamie E. Medina, Alessandro Leal, Eniko Papp, Jillian Phallen, Vilmos Adleff, Elaine Jiayuee Chiao, et al. 2023. “Metastatic Colorectal Cancer Treatment Response Evaluation by Ultra-Deep Sequencing of Cell-Free DNA and Matched White Blood Cells.” *Clin Cancer Res* 29 (5): 899–909. <https://doi.org/10.1158/1078-0432.CCR-22-2538>.