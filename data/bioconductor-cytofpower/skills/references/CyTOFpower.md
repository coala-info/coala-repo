# Power analysis for CyTOF experiments

Anne-Maud Ferreira

Department of Statistics, Stanford University

#### 2025-10-29

#### Package

CyTOFpower 1.16.0

# Contents

* [1 Introduction](#introduction)
* [2 Simulate in-silico data](#simulate-in-silico-data)
* [3 Power computation](#power-computation)
* [4 Shiny app](#shiny-app)
  + [4.1 Precomputed dataset](#precomputed-dataset)
  + [4.2 Personalized dataset](#personalized-dataset)
  + [4.3 Run the app](#run-the-app)
* [5 Session information](#session-information)
* [References](#references)

# 1 Introduction

Mass Spectrometry (or CyTOF) is a single cell technology. It measures up to
50 protein markers on a single cell. The markers are antibodies labeled with
stable isotopes and they might be markers of cell types or phenotypes.

CyTOF might be used to determine if there is any differences in cell abundances
(type markers) or cell phenotypes (state markers) between two experimental
conditions. In this package, we are proposing a tool to predict the power of a
differential state test analysis.

Two packages are available on Bioconductor to perform differential state test
analyses: CytoGLMM (Seiler [2020](#ref-seiler2020cytoglmm)) and diffcyt (Weber [2019](#ref-weber2019diffcyt)).
These models are available in this package and their results, the adjusted p-value
per marker, are used to compute the power an experiment.

# 2 Simulate in-silico data

In-silico CyTOF data are simulated using the following data generation process.
We assumed two conditions for which one condition is the baseline (i.e. a
control condition where no marker is different from the other) and the other
condition contains some signals (i.e. at least one marker is differentially
expressed). The parameters are defined as follow:

* the number of donors: the design of the data is paired, so the number of
  samples will be calculated accordingly, i.e. twice the number of donors;
* the subject effect: it defines how much the donors are different from each
  others;
* the number of cells per samples;
* the total number of markers tested in the experiment;
* the fold change of each differentially expressed marker: it represents
  how much different the marker is expected to be in comparison to the
  control condition. The mean of these markers will be multiplied by in
  the condition containing the differentially expressed markers;
* the distribution parameters for each marker: see details below.

The cell value’s mean of each marker is drawn from a Gamma distribution:
\[\mu\_{0,ij} \sim \Gamma(k, θ)\]
where \(i\) the donor, \(j\) the marker, \(k\) the shape and \(\theta\) the scale.
These two last parameters are defined using the parameters provided by the user:

* cell value mean \(\mu\_{0}\) in the control condition:
  with \(\mu\_{0} = k \cdot \theta > 0\);
* subject effect \(S\): \(S = \sqrt{k \cdot \theta^{2}}\).

The cell value mean of the differentially expressed marker(s) is then multiplied
by the fold change defined earlier: \(\mu\_{1,ij}= \mu\_{0,ij} \cdot \rho\_j\).

The cell values are drawn using a Negative Binomial:

* for non-differentially expressed markers: \(X\_{ij} \sim NB(\mu\_{0,ij}, \sigma)\)
* for differentially expressed markers: \(X\_{ij} \sim NB(\mu\_{1,ij}, \sigma)\)

Some of these parameters might need to be estimated using previous data or publicly
available datasets. For instance, the dispersion and mean parameters of the
negative binomial distribution might be estimated using `fitdistr` from the
`MASS` package for each marker.

# 3 Power computation

The power is computed for the differentially expressed marker(s) (i.e. fold change
different from 1). It is based on the adjusted p-values reported by the models:
counting how many times the null hypothesis is correctly rejected.
It is also important to note that the power returned by these computations uses
the threshold of \(\alpha = 0.05\) as a significance level.

# 4 Shiny app

The shiny app is divided into two tabs: (1) the precomputed dataset tab: the
power was pre-computed for multiple combinations of parameters and the user is
able to search this grid of parameters; (2) the personalized dataset tab: the
data and the power is computed on request based on the parameters chosen by
the user.

## 4.1 Precomputed dataset

This panel allows the user to search a grid of parameters that have been
pre-computed.
The value “NA” displays a power curve for the different values of this parameter.

The available parameters that the user can choose from are the following:

* The number of donors;
* The subject effect;
* The number of cells per sample;
* The total number of markers;
* The marker’s Fold Change (FC): 1.1, 1.2, 1.3, 1.5, 1.8, 2, 3;
* The mean of the Negative Binomial for the marker that is considered;
* The dispersion of the Negative Binomial for the marker that is considered;
* Models to run: CytoGLMM - GLMM; diffcyt - limma with fixed effect;
  diffcyt - limma with random effect; diffcyt - lme4.

## 4.2 Personalized dataset

This panel allows the user to compute the power for a chosen set of parameters.
The data are generated on request and it takes some time to get the results,
especially if the user would like to perform a high number of simulations
with a high number of cells.

The available parameters that the user can choose from are the following:

* The number of donors: at least 3 donors;
* The subject effect that must be different from 0;
* The number of cells per sample (minimum 10 cells);
* The total number of markers (minimum 3 markers);
* For each marker: the fold change, the mean and the dispersion have to be
  specified in the matrix;
* Model to run: CytoGLMM - GLMM; diffcyt - limma with fixed effect;
  diffcyt - limma with random effect; diffcyt - lme4;
* The number of simulations: we recommend at least 10 simulations.

## 4.3 Run the app

The shiny app is run locally by calling the following function:

```
library(CyTOFpower)
CyTOFpower()
```

# 5 Session information

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
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] digest_0.6.37       R6_2.6.1            bookdown_0.45
#>  [4] fastmap_1.2.0       xfun_0.53           cachem_1.1.0
#>  [7] knitr_1.50          htmltools_0.5.8.1   rmarkdown_2.30
#> [10] lifecycle_1.0.4     cli_3.6.5           sass_0.4.10
#> [13] jquerylib_0.1.4     compiler_4.5.1      tools_4.5.1
#> [16] evaluate_1.0.5      bslib_0.9.0         yaml_2.3.10
#> [19] BiocManager_1.30.26 jsonlite_2.0.0      rlang_1.1.6
```

# References

Seiler, Ferreira, C. 2020. “CytoGLMM: Conditional Differential Analysis for Flow and Mass Cytometry Experiments.” *BMC Bioinformatics*.

Weber, Nowicka, L. M. 2019. “Diffcyt: Differential Discovery in High-Dimensional Cytometry via High-Resolution Clustering.” *Communication Biology*.