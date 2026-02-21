# LC Observations - Retention Time Stability

Tobias Kockmann1, Christian Trachsel1, Christian Panse1,2\* and Bernd Roschitzki1\*\*

1Functional Genomics Center Zurich - Swiss Federal Institute of Technology in Zurich
2Swiss Institute of Bioinformatics

\*cp@fgcz.ethz.ch
\*\*bernd.roschitzki@fgcz.uzh.ch

#### 2025-11-04

#### Abstract

This document extends the work concerning the HPLC systems presented
in ([2016](#ref-msqc1)). We refer to the original manuscript for a
description of the theory behind applications.

#### Package

msqc1 1.38.0

# 1 Introduction

This vignette file is thought to demonstrate the retention time stability of the `msqc1_8rep` and `msqc1_dil` data contained in the *[msqc1](https://bioconductor.org/packages/3.22/msqc1)* R package.

## 1.1 Problem:

**Retention Time (RT) form different LC-MS platforms are often not comparable (duration, offset).**

## 1.2 Solution: Normalization

The iRT concept [proposed in pmid22577012 for the RT normalization is used.
Instead of using the iRT-peptides
MSQC1-peptides are used as reference peptides between the different chromatographic settings and systems.

The normalization is done by applying the following steps:

* define a reference platform (QTRAP)
* for each platform a linear model is build (in the following we use the `stats::lm` function) which maps the RT space of the corresponding platform into reference platform RT space (by using the `stats::predict.lm` method)
* scale the normalized RT values into [0, 1]
* visualize the normalized RT values

The code below shows the used R functions for the applied RT normalization.

```
msqc1:::.normalize_rt
```

```
## function (S, S.training, reference_instrument = "Retention.Time.QTRQP")
## {
##     S.normalized <- S
##     for (instrument in unique(S.normalized$instrument)) {
##         i <- paste("Retention.Time", instrument, sep = ".")
##         rt.out <- S.training[, reference_instrument]
##         rt.in <- S.training[, i]
##         S.fit <- lm(rt.out ~ rt.in)
##         S.normalized[S.normalized$instrument == instrument, "Retention.Time"] <- predict(S.fit,
##             data.frame(rt.in = S.normalized[S.normalized$instrument ==
##                 instrument, "Retention.Time"]))
##     }
##     S.normalized.min <- min(S.normalized$Retention.Time, na.rm = TRUE)
##     S.normalized.delta <- max(S.normalized$Retention.Time, na.rm = TRUE) -
##         S.normalized.min
##     S.normalized$Retention.Time <- (S.normalized$Retention.Time -
##         S.normalized.min)/S.normalized.delta
##     return(S.normalized)
## }
## <bytecode: 0x5be7918e10b0>
## <environment: namespace:msqc1>
```

The `reshape_rt` method is used for reshaping the data from long to wide format which ease the the model building in the `msqc1:::.normalize_rt` method above.

```
msqc1:::.reshape_rt
```

```
## function (S, peptides = peptides, plot = TRUE, ...)
## {
##     S <- S[grep("[by]", S$Fragment.Ion), ]
##     S <- S[S$Peptide.Sequence %in% peptides$Peptide.Sequence,
##         ]
##     S <- aggregate(Retention.Time ~ Peptide.Sequence * instrument,
##         FUN = mean, data = S)
##     S <- droplevels(S)
##     S.training <- reshape(S, direction = "wide", v.names = "Retention.Time",
##         timevar = c("instrument"), idvar = "Peptide.Sequence")
##     if (plot == TRUE) {
##         pairs(S.training[, 2:6], pch = as.integer(S.training$Peptide.Sequence),
##             col = as.integer(S.training$Peptide.Sequence), lower.panel = NULL,
##             ...)
##     }
##     return(S.training)
## }
## <bytecode: 0x5be79138bba8>
## <environment: namespace:msqc1>
```

The following R code listings displays some helper functions designed to ease the visualization of the `msqc1_8rep` and `msqc1_dil` RT values.

```
msqc1:::.plot_rt_8rep
```

```
## function (S, peptides, ...)
## {
##     .figure_setup()
##     S <- S[grep("[by]", S$Fragment.Ion), ]
##     S <- S[S$Peptide.Sequence %in% peptides$Peptide.Sequence,
##         ]
##     S <- aggregate(Retention.Time ~ Peptide.Sequence * File.Name.Id *
##         instrument * relative.amount * Isotope.Label.Type, FUN = mean,
##         data = S)
##     S <- droplevels(S)
##     xyplot(Retention.Time ~ File.Name.Id | Isotope.Label.Type *
##         instrument, data = S, layout = c(10, 1), group = S$Peptide.Sequence,
##         auto.key = list(space = "right", points = TRUE, lines = FALSE,
##             cex = 1), ...)
## }
## <bytecode: 0x5be7916290a0>
## <environment: namespace:msqc1>
```

```
msqc1:::.plot_rt_dil
```

```
## function (S, peptides, ...)
## {
##     .figure_setup()
##     S <- S[grep("[by]", S$Fragment.Ion), ]
##     S <- S[S$Peptide.Sequence %in% peptides$Peptide.Sequence,
##         ]
##     S <- aggregate(Retention.Time ~ Peptide.Sequence * File.Name *
##         instrument * relative.amount * Isotope.Label.Type, FUN = mean,
##         data = S)
##     S <- droplevels(S)
##     xyplot(Retention.Time ~ relative.amount | Isotope.Label.Type *
##         instrument, data = S, layout = c(10, 1), group = S$Peptide.Sequence,
##         scales = list(x = list(rot = 45, log = TRUE, at = sort(unique(S$relative.amount)))),
##         auto.key = list(space = "right", points = TRUE, lines = FALSE,
##             cex = 1), ...)
## }
## <bytecode: 0x5be791695538>
## <environment: namespace:msqc1>
```

# 2 RT plot

## 2.1 8 Technical Replicates RT plot

Prepare the training data for the linear model.

```
S.training.8rep <- msqc1:::.reshape_rt(msqc1_8rep, peptides=peptides, cex=2)
```

![](data:image/png;base64...)

**8 rep Scatterplot Matrices Plot** - Color and icon type indicates the differnet peptides. On an idea plot all values would be on one line.

```
msqc1:::.plot_rt_8rep(msqc1_8rep, peptides=peptides, xlab='Replicate Id')
```

![](data:image/png;base64...)

**8 replicate retention time** - The graph displays the raw retention time (in minutes) versus the replicate Id of each sample. Each panel displays one LC-MS platform. On some platforms the loading phase was recorded (TRIPLETOF, QTRAP) while on the other platforms not.

The following code will apply the retention time normalization for the `msqc_8rep` data:

```
msqc1_8rep.norm <- msqc1:::.normalize_rt(msqc1_8rep, S.training.8rep,
                                reference_instrument = 'Retention.Time.QTRAP')

msqc1:::.plot_rt_8rep(msqc1_8rep.norm,
             peptides=peptides,
             xlab='Replicate Id',
             ylab='Normalized Retention Time')
```

![](data:image/png;base64...)

**Normalized 8 replicate retention time** - The graphics displays the normalized retention time for each peptide (heavy and light) across all platforms. Apart from the *TAENFR* peptide all peptides show excellent elution time stability.

## 2.2 Dilution Series RT plot

```
S.training.dil <- msqc1:::.reshape_rt(msqc1_dil, peptides=peptides, cex=2)
```

![](data:image/png;base64...)

**Dilution Scatterplot Matrices Plot** - Color and icon type indicates the differnet peptides. On an idea plot all values would be on one line.

The graph in displays the raw RT (in minutes)
versus the relative amount (x-axis in log scale) of each sample.
Each panel displays one LC-MS platform for each isotope label typ.
The graph on the bottom displays the normalized RT for each peptide (heavy and light).
*Note*: Since we have used different LC settings for the dilution data as we have used for the 8 rep data, we had to rebuild the linear models for the normalization.

```
msqc1:::.plot_rt_dil(msqc1_dil, peptides, xlab='Replicate Id', ylab='Raw Retention Time')
```

![](data:image/png;base64...)

```
msqc1_dil.norm <- msqc1:::.normalize_rt(msqc1_dil,
                                        S.training.dil,
                                        reference_instrument = 'Retention.Time.QTRAP')

msqc1:::.plot_rt_dil(msqc1_dil.norm, peptides=peptides, ylab="Normalized Retention Time")
```

![](data:image/png;base64...)

## 2.3 LC Gradient Comparison

The graphs compare the LC gradient of each platform by plotting the normalized RT values again the raw RT values for the `msqc1_8rep` (left) and `msqc1_dil` (right) data.

![](data:image/png;base64...)

# 3 Session information

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
## [1] msqc1_1.38.0     lattice_0.22-7   BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] digest_0.6.37       R6_2.6.1            bookdown_0.45
##  [4] fastmap_1.2.0       xfun_0.54           magrittr_2.0.4
##  [7] cachem_1.1.0        knitr_1.50          htmltools_0.5.8.1
## [10] rmarkdown_2.30      tinytex_0.57        lifecycle_1.0.4
## [13] cli_3.6.5           grid_4.5.1          sass_0.4.10
## [16] jquerylib_0.1.4     compiler_4.5.1      tools_4.5.1
## [19] evaluate_1.0.5      bslib_0.9.0         Rcpp_1.1.0
## [22] magick_2.9.0        yaml_2.3.10         BiocManager_1.30.26
## [25] jsonlite_2.0.0      rlang_1.1.6
```

# References

Kockmann, Tobias, Christian Trachsel, Christian Panse, Åsa Wåhlander, Nathalie Selevsek, Jonas Grossmann, Witold E. Wolski, and Ralph Schlapbach. 2016. “Targeted proteomics coming of age - SRM, PRM and DIA performance evaluated from a core facility perspective.” *PROTEOMICS*. <http://onlinelibrary.wiley.com/doi/10.1002/pmic.201500502/full>.