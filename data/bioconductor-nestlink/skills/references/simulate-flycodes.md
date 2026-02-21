# Derive Peptide Flycodes by Conducting Random Experiment

Christian Panse1\* and Bernd Roschitzki1

1Functional Genomics Center Zurich

\*cp@fgcz.ethz.ch

#### 2015-04-01, 2015-04-28, 2015-04-29, 2015-04-30, 2015-10-24, 2018-12-17

#### Abstract

this is a preliminary in-silico experiment to analyze the
detectability of a proposed flycode family. it considers
the mass range, hydrophobicity and the cycle time of a
mass spec device.

#### Package

NestLink 1.26.0

# Contents

* [1 Input Pool Frequency](#input-pool-frequency)
* [2 Sanity Check](#sanity-check)
* [3 Compose Peptides](#compose-peptides)
  + [3.1 GPGXXXXXXXX(VR|VSR|VFGIR|VSGER) peptide](#gpgxxxxxxxxvrvsrvfgirvsger-peptide)
  + [3.2 GPYYXXXXXXYYR peptide](#gpyyxxxxxxyyr-peptide)
* [4 Generate peptides](#generate-peptides)
* [5 Peptide mass](#peptide-mass)
  + [5.1 Compute peptide mass](#compute-peptide-mass)
  + [5.2 Draw parent ion mass histogram](#draw-parent-ion-mass-histogram)
* [6 Hydrophobicity](#hydrophobicity)
  + [6.1 Compute Hydrophobicity value using SSRC](#compute-hydrophobicity-value-using-ssrc)
  + [6.2 Draw hydrophobicity histogram](#draw-hydrophobicity-histogram)
* [7 Quality Control (QC)](#quality-control-qc)
  + [7.1 QC of composed peptides](#qc-of-composed-peptides)
    - [7.1.1 Input](#input)
    - [7.1.2 Output](#output)
  + [7.2 Count GP patterns](#count-gp-patterns)
  + [7.3 Compute AA frequency table](#compute-aa-frequency-table)
* [8 Session info](#session-info)
* [References](#references)

The following content is descibed in more detail in Egloff et al. ([2018](#ref-NestLink)) (under review NMETH-A35040).

```
library(NestLink)
stopifnot(require(specL))
```

# 1 Input Pool Frequency

```
aa_pool_x8 <- c(rep('A', 12), rep('S', 0), rep('T', 12), rep('N', 12),
    rep('Q', 12), rep('D', 8),  rep('E', 0), rep('V', 12), rep('L', 0),
    rep('F', 0), rep('Y', 8), rep('W', 0), rep('G', 12), rep('P', 12))

aa_pool_1_2_9_10 <- c(rep('A', 8), rep('S', 7), rep('T', 7), rep('N', 6),
    rep('Q', 6), rep('D', 8), rep('E', 8), rep('V', 9), rep('L', 6),
    rep('F', 5), rep('Y', 9), rep('W', 6),  rep('G', 15), rep('P', 0))

aa_pool_3_8 <- c(rep('A', 5), rep('S', 4), rep('T', 5), rep('N', 2),
    rep('Q', 2), rep('D', 8), rep('E', 8), rep('V', 7), rep('L', 5),
    rep('F', 4), rep('Y', 6), rep('W', 4),  rep('G', 12), rep('P', 28))
```

# 2 Sanity Check

```
table(aa_pool_x8)
```

```
## aa_pool_x8
##  A  D  G  N  P  Q  T  V  Y
## 12  8 12 12 12 12 12 12  8
```

```
length(aa_pool_x8)
```

```
## [1] 100
```

```
table(aa_pool_1_2_9_10)
```

```
## aa_pool_1_2_9_10
##  A  D  E  F  G  L  N  Q  S  T  V  W  Y
##  8  8  8  5 15  6  6  6  7  7  9  6  9
```

```
length(aa_pool_1_2_9_10)
```

```
## [1] 100
```

```
table(aa_pool_3_8)
```

```
## aa_pool_3_8
##  A  D  E  F  G  L  N  P  Q  S  T  V  W  Y
##  5  8  8  4 12  5  2 28  2  4  5  7  4  6
```

```
length(aa_pool_3_8)
```

```
## [1] 100
```

# 3 Compose Peptides

## 3.1 GPGXXXXXXXX(VR|VSR|VFGIR|VSGER) peptide

```
replicate(10, compose_GPGx8cTerm(pool=aa_pool_x8))
```

```
##  [1] "GPGQVGVTGDPVSGER" "GPGVYDYTYQNVSR"   "GPGPTAAVPYAVFGIR" "GPGVADAPPNYVSR"
##  [5] "GPGGYQYVNTGVFR"   "GPGVYTAQTVGVFGIR" "GPGGAAGTPYGVFR"   "GPGAVTQDPDVVFGIR"
##  [9] "GPGYQTQTQYPVSR"   "GPGNPTTQAGNVFR"
```

## 3.2 GPYYXXXXXXYYR peptide

```
compose_GPx10R(aa_pool_1_2_9_10, aa_pool_3_8)
```

```
## [1] "GPGGVPYYYFYVR"
```

# 4 Generate peptides

```
set.seed(2)
(sample.size <- 3E+04)
```

```
## [1] 30000
```

```
peptides.GPGx8cTerm <- replicate(sample.size, compose_GPGx8cTerm(pool=aa_pool_x8))
peptides.GPx10R <- replicate(sample.size, compose_GPx10R(aa_pool_1_2_9_10, aa_pool_3_8))
# write.table(peptides.GPGx8cTerm, file='/tmp/pp.txt')
```

# 5 Peptide mass

## 5.1 Compute peptide mass

```
library(protViz)
(smp.peptide <- compose_GPGx8cTerm(aa_pool_x8))
```

```
## [1] "GPGPDDTDTYGVFR"
```

```
parentIonMass(smp.peptide)
```

```
## [1] 1496.665
```

```
pim.GPGx8cTerm <- unlist(lapply(peptides.GPGx8cTerm, function(x){parentIonMass(x)}))
pim.GPx10R <- unlist(lapply(peptides.GPx10R, function(x){parentIonMass(x)}))
pim.iRT <-  unlist(lapply(as.character(iRTpeptides$peptide), function(x){parentIonMass(x)}))
```

## 5.2 Draw parent ion mass histogram

```
(pim.min <- min(pim.GPGx8cTerm, pim.GPx10R))
```

```
## [1] 1037.512
```

```
(pim.max <- max(pim.GPGx8cTerm, pim.GPx10R))
```

```
## [1] 1890.877
```

```
(pim.breaks <- seq(round(pim.min - 1) , round(pim.max + 1) , length=75))
```

```
##  [1] 1037.000 1048.554 1060.108 1071.662 1083.216 1094.770 1106.324 1117.878
##  [9] 1129.432 1140.986 1152.541 1164.095 1175.649 1187.203 1198.757 1210.311
## [17] 1221.865 1233.419 1244.973 1256.527 1268.081 1279.635 1291.189 1302.743
## [25] 1314.297 1325.851 1337.405 1348.959 1360.514 1372.068 1383.622 1395.176
## [33] 1406.730 1418.284 1429.838 1441.392 1452.946 1464.500 1476.054 1487.608
## [41] 1499.162 1510.716 1522.270 1533.824 1545.378 1556.932 1568.486 1580.041
## [49] 1591.595 1603.149 1614.703 1626.257 1637.811 1649.365 1660.919 1672.473
## [57] 1684.027 1695.581 1707.135 1718.689 1730.243 1741.797 1753.351 1764.905
## [65] 1776.459 1788.014 1799.568 1811.122 1822.676 1834.230 1845.784 1857.338
## [73] 1868.892 1880.446 1892.000
```

```
hist(pim.GPGx8cTerm, breaks=pim.breaks, probability = TRUE,
     col='#1111AAAA', xlab='peptide mass [Dalton]', ylim=c(0, 0.006))
hist(pim.GPx10R, breaks=pim.breaks,
     probability = TRUE, add=TRUE, col='#11AA1188')
abline(v=pim.iRT, col='grey')
legend("topleft", c('GPGx8cTerm', 'GPx10R', 'iRT'),
     fill=c('#1111AAAA', '#11AA1133', 'grey'))
```

![](data:image/png;base64...)

# 6 Hydrophobicity

## 6.1 Compute Hydrophobicity value using SSRC

the SSRC model, see Krokhin et al. ([2004](#ref-pmid15238601)), is implemented as `ssrc` function in
*[protViz](https://CRAN.R-project.org/package%3DprotViz)*.

For a sanity check we apply the `ssrc` function
to a real world LC-MS run `peptideStd` consits of a digest of the
`FETUIN_BOVINE`
protein (400 amol) shipped with *[specL](https://bioconductor.org/packages/3.22/specL)* Panse et al. ([2015](#ref-pmid25712692)).

```
library(specL)
ssrc <- sapply(peptideStd, function(x){ssrc(x$peptideSequence)})
rt <- unlist(lapply(peptideStd, function(x){x$rt}))
plot(ssrc, rt); abline(ssrc.lm <- lm(rt ~ ssrc), col='red');
legend("topleft", paste("spearman", round(cor(ssrc, rt, method='spearman'),2)))
```

![](data:image/png;base64...)
here we apply `ssrc` to the simulated flycodes and iRT peptides Escher et al. ([2012](#ref-pmid22577012)).

```
hyd.GPGx8cTerm <- ssrc(peptides.GPGx8cTerm)
hyd.GPx10R <- ssrc(peptides.GPx10R)
hyd.iRT <- ssrc(as.character(iRTpeptides$peptide))

(hyd.min <- min(hyd.GPGx8cTerm, hyd.GPx10R))
```

```
## [1] -7.63055
```

```
(hyd.max <- max(hyd.GPGx8cTerm, hyd.GPx10R))
```

```
## [1] 65.12112
```

```
hyd.breaks <- seq(round(hyd.min - 1) , round(hyd.max + 1) , length=75)
```

## 6.2 Draw hydrophobicity histogram

```
hist(hyd.GPGx8cTerm, breaks = hyd.breaks, probability = TRUE,
     col='#1111AAAA', xlab='hydrophobicity',
     ylim=c(0, 0.06),
     main='Histogram')
hist(hyd.GPx10R, breaks = hyd.breaks, probability = TRUE, add=TRUE, col='#11AA1188')
  abline(v=hyd.iRT, col='grey')
legend("topleft", c('GPGx8cTerm', 'GPx10R', 'iRT'),  fill=c('#1111AAAA', '#11AA1133', 'grey'))
```

![](data:image/png;base64...)

# 7 Quality Control (QC)

## 7.1 QC of composed peptides

### 7.1.1 Input

```
round(table(aa_pool_x8)/length(aa_pool_x8), 2)
```

```
## aa_pool_x8
##    A    D    G    N    P    Q    T    V    Y
## 0.12 0.08 0.12 0.12 0.12 0.12 0.12 0.12 0.08
```

### 7.1.2 Output

```
peptide2aa <- function(seq, from=4, to=4+8){
  unlist(lapply(seq, function(x){strsplit(substr(x, from, to), '')}))
}
peptides.GPGx8cTerm.aa <- peptide2aa(peptides.GPGx8cTerm)
round(table(peptides.GPGx8cTerm.aa)/length(peptides.GPGx8cTerm.aa), 2)
```

```
## peptides.GPGx8cTerm.aa
##    A    D    G    N    P    Q    T    V    Y
## 0.11 0.07 0.11 0.11 0.11 0.11 0.11 0.22 0.07
```

```
peptides.GPx10R.aa <- peptide2aa(peptides.GPx10R, from=3, to=12)
round(table(peptides.GPx10R.aa)/length(peptides.GPx10R.aa), 2)
```

```
## peptides.GPx10R.aa
##    A    D    E    F    G    L    N    P    Q    S    T    V    W    Y
## 0.06 0.08 0.08 0.04 0.13 0.05 0.04 0.17 0.04 0.05 0.06 0.08 0.05 0.07
```

## 7.2 Count GP patterns

```
sample.size
```

```
## [1] 30000
```

```
length(grep('^GP(.*)GP(.*)R$', peptides.GPGx8cTerm))
```

```
## [1] 6319
```

```
length(grep('^GP(.*)GP(.*)R$', peptides.GPx10R))
```

```
## [1] 5959
```

## 7.3 Compute AA frequency table

count the peptides having the same AA composition

```
sample.size
```

```
## [1] 30000
```

```
table(table(tt<-unlist(lapply(peptides.GPGx8cTerm,
  function(x){paste(sort(unlist(strsplit(x, ''))), collapse='')}))))
```

```
##
##    1    2    3    4    5    6    7    8    9   10   11   12   13   14   16   17
## 9541 3606 1607  792  427  204  104   50   34   20    6    5    6    2    1    1
```

```
# write.table(tt, file='GPGx8cTerm.txt')
table(table(unlist(lapply(peptides.GPx10R,
  function(x){paste(sort(unlist(strsplit(x, ''))), collapse='')}))))
```

```
##
##     1     2     3     4     5
## 24844  2104   265    32     5
```

the *[NestLink](https://bioconductor.org/packages/3.22/NestLink)* function `plot_in_silico_LCMS_map` graphs
the LC-MS maps.

```
par(mfrow=c(2, 2))
h <- NestLink:::.plot_in_silico_LCMS_map(peptides.GPGx8cTerm, main='GPGx8cTerm')
h <- NestLink:::.plot_in_silico_LCMS_map(peptides.GPx10R, main='GPx10R')
```

![](data:image/png;base64...)

# 8 Session info

Here is the output of the `sessionInfo()` commmand.

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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] specL_1.44.0                seqinr_4.2-36
##  [3] RSQLite_2.4.3               DBI_1.2.3
##  [5] knitr_1.50                  scales_1.4.0
##  [7] ggplot2_4.0.0               NestLink_1.26.0
##  [9] ShortRead_1.68.0            GenomicAlignments_1.46.0
## [11] SummarizedExperiment_1.40.0 Biobase_2.70.0
## [13] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [15] Rsamtools_2.26.0            GenomicRanges_1.62.0
## [17] BiocParallel_1.44.0         protViz_0.7.9
## [19] gplots_3.2.0                Biostrings_2.78.0
## [21] Seqinfo_1.0.0               XVector_0.50.0
## [23] IRanges_2.44.0              S4Vectors_0.48.0
## [25] ExperimentHub_3.0.0         AnnotationHub_4.0.0
## [27] BiocFileCache_3.0.0         dbplyr_2.5.1
## [29] BiocGenerics_0.56.0         generics_0.1.4
## [31] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] bitops_1.0-9         deldir_2.0-4         httr2_1.2.1
##  [4] rlang_1.1.6          magrittr_2.0.4       ade4_1.7-23
##  [7] compiler_4.5.1       mgcv_1.9-3           png_0.1-8
## [10] vctrs_0.6.5          pwalign_1.6.0        pkgconfig_2.0.3
## [13] crayon_1.5.3         fastmap_1.2.0        magick_2.9.0
## [16] labeling_0.4.3       caTools_1.18.3       rmarkdown_2.30
## [19] tinytex_0.57         purrr_1.1.0          bit_4.6.0
## [22] xfun_0.54            cachem_1.1.0         cigarillo_1.0.0
## [25] jsonlite_2.0.0       blob_1.2.4           DelayedArray_0.36.0
## [28] jpeg_0.1-11          parallel_4.5.1       R6_2.6.1
## [31] bslib_0.9.0          RColorBrewer_1.1-3   jquerylib_0.1.4
## [34] Rcpp_1.1.0           bookdown_0.45        splines_4.5.1
## [37] Matrix_1.7-4         tidyselect_1.2.1     dichromat_2.0-0.1
## [40] abind_1.4-8          yaml_2.3.10          codetools_0.2-20
## [43] hwriter_1.3.2.1      curl_7.0.0           lattice_0.22-7
## [46] tibble_3.3.0         withr_3.0.2          KEGGREST_1.50.0
## [49] S7_0.2.0             evaluate_1.0.5       pillar_1.11.1
## [52] BiocManager_1.30.26  filelock_1.0.3       KernSmooth_2.23-26
## [55] BiocVersion_3.22.0   gtools_3.9.5         glue_1.8.0
## [58] tools_4.5.1          interp_1.1-6         grid_4.5.1
## [61] latticeExtra_0.6-31  AnnotationDbi_1.72.0 nlme_3.1-168
## [64] cli_3.6.5            rappdirs_0.3.3       S4Arrays_1.10.0
## [67] dplyr_1.1.4          gtable_0.3.6         sass_0.4.10
## [70] digest_0.6.37        SparseArray_1.10.1   farver_2.1.2
## [73] memoise_2.0.1        htmltools_0.5.8.1    lifecycle_1.0.4
## [76] httr_1.4.7           MASS_7.3-65          bit64_4.6.0-1
```

# References

Egloff, Pascal, Iwan Zimmermann, Fabian M. Arnold, Cedric A. J. Hutter, Damien Damien Morger, Lennart Opitz, Lucy Poveda, et al. 2018. “Engineered Peptide Barcodes for In-Depth Analyses of Binding Protein Ensembles.” *bioRxiv*. <https://doi.org/10.1101/287813>.

Escher, C., L. Reiter, B. MacLean, R. Ossola, F. Herzog, J. Chilton, M. J. MacCoss, and O. Rinner. 2012. “Using iRT, a normalized retention time for more targeted measurement of peptides.” *Proteomics* 12 (8): 1111–21.

Krokhin, O. V., R. Craig, V. Spicer, W. Ens, K. G. Standing, R. C. Beavis, and J. A. Wilkins. 2004. “An improved model for prediction of retention times of tryptic peptides in ion pair reversed-phase HPLC: its application to protein peptide mapping by off-line HPLC-MALDI MS.” *Mol. Cell Proteomics* 3 (9): 908–19.

Panse, C., C. Trachsel, J. Grossmann, and R. Schlapbach. 2015. “specL–an R/Bioconductor package to prepare peptide spectrum matches for use in targeted proteomics.” *Bioinformatics* 31 (13): 2228–31.