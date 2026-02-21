# A Mass Spec Data set for Targeted Proteomics Performance Evaluation

Tobias Kockmann1, Christian Trachsel1, Christian Panse1,2\*, Jonas Grossmann1,2 and Witold E. Wolski1,2

1Functional Genomics Center Zurich - Swiss Federal Institute of Technology in Zurich
2Swiss Institute of Bioinformatics, Quartier Sorge - Batiment Amphipole, CH-1015 Lausanne, Switzerland

\*cp@fgcz.ethz.ch

#### 2025-11-04

#### Abstract

This document reproduces the Figures presented in ([2016](#ref-msqc1)). For a
description of the theory behind applications shown here we refer to the
original manuscript. The results differ slightly due to technical
changes or bugfixes in *[msqc1](https://bioconductor.org/packages/3.22/msqc1)* that have
been implemented after the manuscript was printed.

#### Package

msqc1 1.38.0

# 1 Introduction

Here we provide an experiment data package containing all the spread sheets used for figures and supplemental figures published in Kockmann et al. ([2016](#ref-msqc1)).
The raw instrument files are accessible for registered users through
<https://fgcz-bfabric.uzh.ch> ([2022](#ref-panse2022bridging))
as project 1959. Raw LC-MS data from all five platforms were imported into
[Skyline 3.1](https://skyline.gs.washington.edu), see MacLean et al. ([2010](#ref-pmid20147306)), processed,
and are available though
<https://panoramaweb.org/labkey/MSQC1.url> when published.
This package contains data.frame objects exported by Skyline making the data available for the R world.

# 2 MSQC1 Peptide properties

## 2.1 Figure - reference L:H ratio versus the on-column amount

![](data:image/png;base64...)

The scatter-plot displays the reference Light:Heavy ratio versus the on-column amount of heavy peptide of the MSQC1 peptide mix. Note, x and y axis are drawn in log scale.

# 3 Data

show the dilution series

```
table(msqc1_dil$relative.amount)
```

```
##
## 0.025  0.05   0.2     1     2     5
##  2550  2550  2550  2550  2550  2550
```

show the peptide frequency

```
table(msqc1_dil$Peptide.Sequence)
```

```
##
##    ADVTPADFSEWSK       ALIVLAHSER AVQQPDGLAVLGIFLK    DGLDAASYYAPVR
##              378              864              828              378
##    EGHLSPDIVAEQK       ESDTSYVSLK        FEDENFILK  FSTVAGESGSADTVR
##             1170              864              684              864
## GAGAFGYFEVTHDITK   GAGSSEPVTGLDAK        GGPFSDSYR     GTFIIDPAAVIR
##              792              378              864              378
##     GTFIIDPGGVIR       GYSIFSYATK   LFLQFGAQGSPFLK        LGGNEQVTR
##              378              648              378              378
##        NLSVEDAAR       SADFTNFDPR           TAENFR     TPVISGGPYEYR
##              828              864              144              378
##     TPVITGAPYEYR    VEATFGVDESNAK        VLDALQAIK        VSFELFADK
##              378              378              864              864
##       YILAGVENSK
##              378
```

show ion types

```
table(msqc1_dil$Fragment.Ion)
```

```
##
##              b8       precursor precursor [M+1] precursor [M+2]             y10
##              72            2106            2106            2106             720
##             y11             y12              y4              y5              y6
##             144             144             396             990            1620
##              y7              y8              y9
##            2106            1638            1152
```

show instruments

```
table(msqc1_dil$instrument)
```

```
##
##   QExactive QExactiveHF       QTRAP   TRIPLETOF  TSQVantage
##        3996        4032        1242        4032        1998
```

# 4 Illustrations

## 4.1 Figure - Sigma mix peptide level signals

![](data:image/png;base64...)

**Sigma mix peptide level signals** - The graph displays the log2 L:H area ratios of eight technical replicates over 14 peptides from five MS platforms. The 14 panels were ordered by the on column amount of heavy peptide per vial (0.8, 4, 20, 40, 80, 200, 500, 1000 fmol). The black line indicates the theoretical L:H ratio as reported in the QC certificate by Sigma-Aldrich. In a perfect setting all data points would be located close to the black line indicating a perfect match between theoretical and measured log2 L:H ratios.
The dark gray boxes correspond to a 0.5 and the light grey boxes to a deviation of 1 from the expected value (black line).

## 4.2 Figure - Volcano Plot

```
S <- .shape_for_volcano(S=msqc1_8rep, peptides)

msqc1:::.figure_setup()

xyplot(-log(p.value, 10) ~ log2FC | instrument, data=S, group=Peptide.Sequence,
       panel = function(...){
         panel.abline(v=c(-1,1), col='lightgray')
         panel.abline(h=-log(0.05,10), col='lightgray')
         panel.xyplot(...)
       },
       ylab='-log10 of p-value',
       xlab='log2 fold change',
       layout=c(1,5),
       auto.key = list(space = "right", points = TRUE, lines = FALSE, cex=1))
```

![](data:image/png;base64...)

## 4.3 Figure - Ratio stability upon analyte dilution

![](data:image/png;base64...)

**Ratio stability upon analyte dilution** - Each scatter-plot panel displays the experimental derived log2 L:H ratios versus the relative amount. The panels are ordered by the SIL on column amount (lower left to upper right).
Color grouping was done by instrument. The loess fit curves were added for visualizing the trend.
The SIL value given in each panel legend is valid for the relative amount of 1.
The horizontal black line indicates the theoretical log2 L:H ratio.

## 4.4 Figure - Accuracy

![](data:image/png;base64...)

**Accuracy** - The graph displays in each panel a sensitivity curves for a given relative amount.

# 5 Session information

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

MacLean, B., D. M. Tomazela, N. Shulman, M. Chambers, G. L. Finney, B. Frewen, R. Kern, D. L. Tabb, D. C. Liebler, and M. J. MacCoss. 2010. “Skyline: an open source document editor for creating and analyzing targeted proteomics experiments.” *Bioinformatics* 26 (7): 966–68.

**Panse, Christian**, Christian Trachsel, and Can Türker. 2022. “Bridging Data Management Platforms and Visualization Tools to Enable Ad-Hoc and Smart Analytics in Life Sciences.” *Journal of Integrative Bioinformatics*. <https://doi.org/10.1515/jib-2022-0031>.