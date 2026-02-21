# FASTA p1875 db10 / WU160118 / R444589 - Postprocessing / Summary

Christian Panse1\* and Bernd Roschitzki1

1Functional Genomics Center Zurich

\*cp@fgcz.ethz.ch

#### 2017-11-02, 2017-11-03, 2017-11-04, 2017-11-06, 2017-11-08, 2018-01-30, 2018-02-01, 2018-12-13

#### Abstract

This vignette contains code snippets to display results of the NestLink project (p1875).
Briefly, it analyzes the amno acid frequencies of the in-silico composed and
measured flycodes.

#### Package

NestLink 1.26.0

# Contents

* [1 Load requiered R packages](#load-requiered-r-packages)
* [2 Display ESP](#display-esp)
* [3 Charge State Frequency](#charge-state-frequency)
  + [3.1 Load workunit 160118](#load-workunit-160118)
  + [3.2 FlyCode Mass Distribution](#flycode-mass-distribution)
  + [3.3 Mascot Ion Score Distribution](#mascot-ion-score-distribution)
* [4 Compare Real and in-silico FlyCodes](#compare-real-and-in-silico-flycodes)
  + [4.1 AA design frequency](#aa-design-frequency)
  + [4.2 SSRC Prediction vs. Measured Retention Time](#ssrc-prediction-vs.-measured-retention-time)
  + [4.3 SSRC and Retention Time Distribution](#ssrc-and-retention-time-distribution)
  + [4.4 Mass vs. RT Panels - Mascot Ion Score cut-off](#mass-vs.-rt-panels---mascot-ion-score-cut-off)
* [5 Session info](#session-info)
* [References](#references)

# 1 Load requiered R packages

```
library(NestLink)
```

# 2 Display ESP

ESP\_Prediction was generated using an application <https://genepattern.broadinstitute.org> (**???**).

```
library(ggplot2)
ESP <- rbind(getFC(), getNB())
```

```
## see ?NestLink and browseVignettes('NestLink') for documentation
```

```
## loading from cache
```

```
## see ?NestLink and browseVignettes('NestLink') for documentation
```

```
## loading from cache
```

```
p <- ggplot(ESP, aes(x = ESP_Prediction, fill = cond)) +
  geom_histogram(bins = 50, alpha = 0.4, position="identity") +
  labs(x = "detectability in LC-MS (ESP prediction)") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
      panel.background = element_blank(), axis.line = element_line(colour = "black"))
print(p)
```

![](data:image/png;base64...)

```
ESP <- rbind(getFC(), NB.unambiguous(getNB()))
```

```
## see ?NestLink and browseVignettes('NestLink') for documentation
## loading from cache
```

```
## see ?NestLink and browseVignettes('NestLink') for documentation
```

```
## loading from cache
```

```
p <- ggplot(ESP, aes(x = ESP_Prediction, fill = cond)) +
  geom_histogram(bins = 50, alpha = 0.4, position="identity") +
  labs(x = "detectability in LC-MS (ESP prediction)") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"))
print(p)
```

![](data:image/png;base64...)

```
ESP <- rbind(getFC(), NB.unique(getNB()))
```

```
## see ?NestLink and browseVignettes('NestLink') for documentation
## loading from cache
```

```
## see ?NestLink and browseVignettes('NestLink') for documentation
```

```
## loading from cache
```

```
p <- ggplot(ESP, aes(x = ESP_Prediction, fill = cond)) +
  geom_histogram(bins = 50, alpha = 0.4, position="identity") +
  labs(x = "detectability in LC-MS (ESP prediction)") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"))
print(p)
```

![](data:image/png;base64...)

```
ESP <- rbind(getNB(), NB.unambiguous(getNB()), NB.unique(getNB()))
```

```
## see ?NestLink and browseVignettes('NestLink') for documentation
## loading from cache
```

```
## see ?NestLink and browseVignettes('NestLink') for documentation
```

```
## loading from cache
```

```
## see ?NestLink and browseVignettes('NestLink') for documentation
```

```
## loading from cache
```

```
p <- ggplot(ESP, aes(x = ESP_Prediction, fill = cond)) +
  geom_histogram(bins = 50, alpha = 0.4, position="identity") +
  labs(x = "detectability in LC-MS (ESP prediction)") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"))
print(p)
```

![](data:image/png;base64...)

```
table(ESP$cond)
```

```
##
##             NB NB.unambiguous      NB.unique
##          27681           5832           7705
```

# 3 Charge State Frequency

## 3.1 Load workunit 160118

```
# library(ExperimentHub)
# eh <- ExperimentHub();
# load(query(eh, c("NestLink", "WU160118.RData"))[[1]])

load(getExperimentHubFilename("WU160118.RData"))
WU <- WU160118
```

filtering

```
PATTERN <- "^GS[ASTNQDEFVLYWGP]{7}(WR|WLTVR|WQEGGR|WLR|WQSR)$"

idx <- grepl(PATTERN, WU$pep_seq)
WU <- WU[idx & WU$pep_score > 25,]
```

determine charge state frequency through counting

```
WU$chargeInt <- as.integer(substr(WU$query_charge, 0, 1))
table(WU$chargeInt)
```

```
##
##     2     3     4
## 33392   157     1
```

in percent

```
round(100 * (table(WU$chargeInt) / nrow(WU)), 1)
```

```
##
##    2    3    4
## 99.5  0.5  0.0
```

as histograms

```
library(scales)
ggplot(WU, aes(x = moverz * chargeInt, fill = (query_charge),
               colour = (query_charge))) +
    facet_wrap(~ datfilename, ncol = 2) +
    geom_histogram(binwidth= 10, alpha=.3, position="identity") +
    labs(title = "Precursor mass to charge frequency plot",
      subtitle = "Plotting frequency of precursor masses for each charge state",
      x = "Precursor mass [neutral mass]",
      y = "Frequency [counts]",
      fill = "Charge State",
      colour = "Charge State") +
    scale_x_continuous(breaks = pretty_breaks(8)) +
    theme_light()
```

![](data:image/png;base64...)

We confirmed this prediction by experimental data
and found that 99.9 percent of flycode precursor ions correspond
to doubly charge species (data not shown). The omission of positively charged
residues is also critical in order to render trypsin a site-specific protease.

## 3.2 FlyCode Mass Distribution

```
WU$suffix <- substr(WU$pep_seq, 10, 100)

ggplot(WU, aes(x = moverz * chargeInt, fill = suffix, colour = suffix)) +
    geom_histogram(binwidth= 10, alpha=.2, position="identity") +
    #facet_wrap(~ substr(pep_seq, 10, 100)) +
   theme_light()
```

![](data:image/png;base64...)

```
ggplot(WU, aes(x = moverz * chargeInt, fill = suffix)) +
    geom_histogram(binwidth= 10, alpha=.9, position="identity") +
    facet_wrap(~ substr(pep_seq, 10, 100)) +
   theme_light()
```

![](data:image/png;base64...)

## 3.3 Mascot Ion Score Distribution

```
ggplot(WU, aes(x = pep_score, fill = query_charge, colour = query_charge)) +
    geom_histogram(binwidth= 2, alpha=.5, position="identity") +
    facet_wrap(~ substr(pep_seq, 10, 100)) +
   theme_light()
```

![](data:image/png;base64...)

# 4 Compare Real and in-silico FlyCodes

Reads the flycodes from p1875 db10 fasta file

```
# FC <- read.table(system.file("extdata/FC.tryptic", package = "NestLink"),
#                header = TRUE)
FC <- getFC()
```

```
## see ?NestLink and browseVignettes('NestLink') for documentation
```

```
## loading from cache
```

```
FC$peptide <- (as.character(FC$peptide))
idx <- grep (PATTERN, FC$peptide)

FC$cond <- "FC"
FC$pim <- parentIonMass(FC$peptide)
FC <- FC[nchar(FC$peptide) >2, ]
FC$ssrc <- sapply(FC$peptide, ssrc)
FC$peptideLength <- nchar(as.character(FC$peptide))
FC <- FC[idx,]
head(FC)
```

```
##             peptide ESP_Prediction cond      pim     ssrc peptideLength
## 120  GSAAAAADSWLTVR        0.75450   FC 1375.696 27.80445            14
## 121  GSAAAAATDWLTVR        0.76422   FC 1389.712 29.00445            14
## 122  GSAAAAATGWLTVR        0.65522   FC 1331.707 28.60445            14
## 123    GSAAAAATVWLR        0.65496   FC 1173.637 29.10445            12
## 124  GSAAAAAYEWLTVR        0.72754   FC 1465.743 33.10445            14
## 125 GSAAAADAAWQEGGR        0.53588   FC 1417.645 11.70445            15
```

## 4.1 AA design frequency

```
aa_pool_x7 <- c(rep('A', 18), rep('S', 6), rep('T', 12), rep('N', 1),
  rep('Q', 1), rep('D', 11),  rep('E', 11), rep('V', 12), rep('L', 2),
  rep('F', 1), rep('Y', 4), rep('W', 1), rep('G', 8), rep('P', 12))

aa_pool_x7.post <- c(rep('WR', 20),  rep('WLTVR', 20), rep('WQEGGR', 20),
  rep('WLR', 20), rep('WQSR', 20))
```

```
FC.pep_seq.freq <- table(unlist(strsplit(substr(FC$peptide, 3, 9), "")))
FC.freq <- round(FC.pep_seq.freq / sum(FC.pep_seq.freq) * 100, 3)

FC.pep_seq.freq.post <- table(unlist((substr(FC$peptide, 10, 100))))
FC.freq.post <- round(FC.pep_seq.freq.post / sum(FC.pep_seq.freq.post) * 100, 3)

WU.pep_seq.freq <- table(unlist(strsplit(substr(WU$pep_seq, 3, 9), "")))
WU.freq <- round(WU.pep_seq.freq / sum(WU.pep_seq.freq) * 100,3)

WU.pep_seq.freq.post <- table(unlist(substr(WU$pep_seq, 10, 100)))
WU.freq.post <- round(WU.pep_seq.freq.post / sum(WU.pep_seq.freq.post) *100,3)
```

```
table(aa_pool_x7)
```

```
## aa_pool_x7
##  A  D  E  F  G  L  N  P  Q  S  T  V  W  Y
## 18 11 11  1  8  2  1 12  1  6 12 12  1  4
```

```
FC.freq
```

```
##
##      A      D      E      F      G      L      N      P      Q      S      T
## 16.027 13.452 10.097  0.872  6.918  1.658  0.618 10.662  1.142  5.637 10.663
##      V      W      Y
## 16.533  1.245  4.478
```

```
WU.freq
```

```
##
##      A      D      E      F      G      L      N      P      Q      S      T
## 15.434 16.983 11.939  0.532  7.077  1.165  0.784 11.813  1.484  5.748 10.532
##      V      W      Y
## 12.645  0.773  3.090
```

```
AAfreq1 <- data.frame(aa = table(aa_pool_x7))
names(AAfreq1) <- c('AA', 'freq')

AAfreq1 <-rbind(AAfreq1, df<-data.frame(AA=c('C','H','I','M','K','R'), freq=rep(0,6)))

AAfreq1$cond <- 'theoretical frequency'

AAfreq2 <- data.frame(aa=FC.freq)
names(AAfreq2) <- c('AA', 'freq')
AAfreq2$cond <- "db10.fasta"

AAfreq3 <- data.frame(aa=WU.freq)
names(AAfreq3) <- c('AA', 'freq')
AAfreq3$cond <- "WU"

#FC.all <- read.table(system.file("extdata/FC.tryptic", package = "NestLink"),
#                 header = TRUE)
FC.all <- getFC()
```

```
## see ?NestLink and browseVignettes('NestLink') for documentation
```

```
## loading from cache
```

```
PATTERN.all <- "^GS[A-Z]{7}(WR|WLTVR|WQEGGR|WLR|WQSR)$"
FC.all <- as.character(FC.all$peptide)[grep(PATTERN.all, as.character(FC.all$peptide))]

FC.all.pep_seq.freq <- table(unlist(strsplit(substr(FC.all, 3, 9), "")))
FC.all.freq <- round(FC.all.pep_seq.freq / sum(FC.all.pep_seq.freq) * 100, 3)
FC.all.freq[20] <- 0
names(FC.all.freq) <- c(names(FC.all.freq)[1:19], "K")
AAfreq4 <- data.frame(AA=names(FC.all.freq), freq=as.numeric(FC.all.freq))

AAfreq4$cond <- "sequenced frequency"

AAfreq <- do.call('rbind', list(AAfreq1, AAfreq2, AAfreq3, AAfreq4))
AAfreq$freq <- as.numeric(AAfreq$freq)
```

```
ggplot(data=AAfreq, aes(x=AA, y=freq, fill=cond)) +
  geom_bar(stat="identity", position="dodge") +
  labs(title = "amino acid frequency plot") +
  theme_light()
```

```
## Warning: Removed 5 rows containing missing values or values outside the scale range
## (`geom_bar()`).
```

![](data:image/png;base64...)

```
AAfreq1.post <- data.frame(aa=table(aa_pool_x7.post))
names(AAfreq1.post) <- c('AA', 'freq')
AAfreq1.post$cond <- "aa_pool_x7"

AAfreq2.post <- data.frame(aa=FC.freq.post)
names(AAfreq2.post) <- c('AA', 'freq')
AAfreq2.post$cond <- "db10.fasta"

AAfreq3.post <- data.frame(aa=WU.freq.post)
names(AAfreq3.post) <- c('AA', 'freq')
AAfreq3.post$cond <- "WU"

AAfreq.post <- do.call('rbind', list(AAfreq1.post, AAfreq2.post, AAfreq3.post))
```

```
df<-AAfreq[(AAfreq$cond != 'WU' & AAfreq$cond != 'db10.fasta'), ]
df$freq<- as.numeric(df$freq)
ggplot(data=df, aes(x=AA, y=freq, fill=cond)) +
  geom_bar(stat="identity", position="dodge") +
  labs(title = "Amino acid frequency plot") +
  ylab("Frequency [%]") +
  theme_light()
```

```
## Warning: Removed 5 rows containing missing values or values outside the scale range
## (`geom_bar()`).
```

![](data:image/png;base64...)

```
FCfreq <- data.frame(table(unlist(strsplit(substr(FC$peptide, 3, 9), ""))))
colnames(FCfreq) <- c('AA', 'freq')

ggplot(data=FCfreq, aes(x=AA, y=freq)) +
  geom_bar(stat="identity", position="dodge") +
  labs(title = "Amino acid frequency plot") +
  theme_light()
```

![](data:image/png;base64...)

```
ggplot(data=AAfreq.post, aes(x=AA, y=freq, fill=cond)) +
  geom_bar(stat="identity", position="dodge") +
  labs(title = "suffix frequency plot") +
  theme_light()
```

![](data:image/png;base64...)

## 4.2 SSRC Prediction vs. Measured Retention Time

The RT is predicted using the method described in
Krokhin et al. ([2004](#ref-pmid15238601))
and implemented using the *[specL](https://bioconductor.org/packages/3.22/specL)*
package Panse et al. ([2015](#ref-pmid25712692)).

```
WU$ssrc <- sapply(as.character(WU$pep_seq), ssrc)
WU$suffix <- substr(WU$pep_seq, 10,100)
ggplot(WU, aes(x = RTINSECONDS, y = ssrc)) +
  geom_point(aes(alpha=pep_score, colour = datfilename)) +
  facet_wrap(~ datfilename * suffix, ncol = 5, nrow = 8) +
  geom_smooth(method = 'lm')
```

```
## `geom_smooth()` using formula = 'y ~ x'
```

```
## Warning in qt((1 - level)/2, df): NaNs produced
```

```
## Warning in max(ids, na.rm = TRUE): no non-missing arguments to max; returning
## -Inf
```

![](data:image/png;base64...)

```
cor(WU$RTINSECONDS, WU$ssrc, method = 'spearman')
```

```
## [1] 0.9056695
```

## 4.3 SSRC and Retention Time Distribution

Considers only Mascot Result File F255737

```
WU <- WU160118
PATTERN <- "^GS[ASTNQDEFVLYWGP]{7}(WR|WLTVR|WQEGGR|WLR|WQSR)$"
idx <- grepl(PATTERN, WU$pep_seq)

# Mascot score cut-off valye 25
WU <- WU[idx & WU$pep_score > 25,]
```

```
WU$suffix <- substr(WU$pep_seq, 10, 100)
WU$ssrc <- sapply(as.character(WU$pep_seq), ssrc)

ggplot(WU, aes(x = RTINSECONDS, fill = datfilename)) +
  geom_histogram(bins = 50)
```

![](data:image/png;base64...)

```
ggplot(WU, aes(x = ssrc, fill = datfilename)) +
  geom_histogram(bins = 50)
```

![](data:image/png;base64...)

```
ggplot(WU, aes(x = RTINSECONDS, fill = suffix)) +
  geom_histogram(bins = 50)
```

![](data:image/png;base64...)

```
ggplot(WU, aes(x = ssrc, fill = suffix)) +
  geom_histogram(bins = 50)
```

![](data:image/png;base64...)

```
WU <- WU[WU$datfilename == "F255737",]

WU <- aggregate(WU$RTINSECONDS ~ WU$pep_seq, FUN = min)
names(WU) <-c("pep_seq", "RTINSECONDS")
WU$suffix <- substr(WU$pep_seq, 10, 100)
WU$peptide_mass <- parentIonMass(as.character(WU$pep_seq))
WU$ssrc <- sapply(as.character(WU$pep_seq), ssrc)
WU$datfilename <- "F255737"
```

```
ggplot(WU, aes(x = RTINSECONDS, y = peptide_mass)) +
  geom_point(aes(colour = suffix)) +
  facet_wrap(~ datfilename * suffix, ncol=5)
```

![](data:image/png;base64...)

```
ggplot(WU, aes(x = RTINSECONDS, fill = suffix)) +
  geom_histogram(bins = 20) +
  facet_wrap(~ datfilename * suffix, ncol=5)
```

![](data:image/png;base64...)

```
ggplot(WU, aes(x = ssrc, y = peptide_mass)) +
  geom_point(aes(colour = suffix)) +
  facet_wrap(~ datfilename * suffix,  ncol = 5)
```

![](data:image/png;base64...)

```
ggplot(WU, aes(x = ssrc,fill = suffix)) +
  geom_histogram(bins = 20) +
  facet_wrap(~ datfilename * suffix, ncol=5)
```

![](data:image/png;base64...)

```
ggplot(WU, aes(x = RTINSECONDS, y = peptide_mass)) +
  geom_point(aes(colour = suffix), size = 3.0, alpha = 0.1)
```

![](data:image/png;base64...)

```
ggplot(WU, aes(x = ssrc, y = peptide_mass)) +
  geom_point(aes(colour = suffix),  size = 3.0, alpha = 0.1)
```

![](data:image/png;base64...)

## 4.4 Mass vs. RT Panels - Mascot Ion Score cut-off

```
WU <-  do.call('rbind', lapply(c(25,35,45), function(cutoff){
  WU <- WU160118
  PATTERN <- "^GS[ASTNQDEFVLYWGP]{7}(WR|WLTVR|WQEGGR|WLR|WQSR)$"
  idx <- grepl(PATTERN, WU$pep_seq)

  WU <- WU[idx & WU$pep_score > cutoff, ]

  WU <- WU[WU$datfilename == "F255737",]

  WU <- aggregate(WU$RTINSECONDS ~ WU$pep_seq, FUN=min)
  names(WU) <-c("pep_seq","RTINSECONDS")
  WU$suffix <- substr(WU$pep_seq, 10, 100)
  WU$peptide_mass <- parentIonMass(as.character(WU$pep_seq))
  WU$ssrc <- sapply(as.character(WU$pep_seq), ssrc)
  WU$datfilename <- "F255737"
  WU$mascotScoreCutOff <- cutoff
  WU}))

ggplot(WU, aes(x = RTINSECONDS, y = peptide_mass)) +
  geom_point(aes(colour = suffix),  size = 3.0, alpha = 0.1) +
  facet_wrap(~ mascotScoreCutOff, ncol = 1)
```

![](data:image/png;base64...)

```
ggplot(WU, aes(x = ssrc, y = peptide_mass)) +
  geom_point(aes(colour = suffix),  size = 3.0, alpha = 0.1) +
  facet_wrap(~ mascotScoreCutOff, ncol = 1 )
```

![](data:image/png;base64...)

# 5 Session info

Here is the output of the `sessionInfo()`
command.

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
##  [1] scales_1.4.0                ggplot2_4.0.0
##  [3] NestLink_1.26.0             ShortRead_1.68.0
##  [5] GenomicAlignments_1.46.0    SummarizedExperiment_1.40.0
##  [7] Biobase_2.70.0              MatrixGenerics_1.22.0
##  [9] matrixStats_1.5.0           Rsamtools_2.26.0
## [11] GenomicRanges_1.62.0        BiocParallel_1.44.0
## [13] protViz_0.7.9               gplots_3.2.0
## [15] Biostrings_2.78.0           Seqinfo_1.0.0
## [17] XVector_0.50.0              IRanges_2.44.0
## [19] S4Vectors_0.48.0            ExperimentHub_3.0.0
## [21] AnnotationHub_4.0.0         BiocFileCache_3.0.0
## [23] dbplyr_2.5.1                BiocGenerics_0.56.0
## [25] generics_0.1.4              BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] DBI_1.2.3            bitops_1.0-9         deldir_2.0-4
##  [4] httr2_1.2.1          rlang_1.1.6          magrittr_2.0.4
##  [7] compiler_4.5.1       RSQLite_2.4.3        mgcv_1.9-3
## [10] png_0.1-8            vctrs_0.6.5          pwalign_1.6.0
## [13] pkgconfig_2.0.3      crayon_1.5.3         fastmap_1.2.0
## [16] magick_2.9.0         labeling_0.4.3       caTools_1.18.3
## [19] rmarkdown_2.30       tinytex_0.57         purrr_1.1.0
## [22] bit_4.6.0            xfun_0.54            cachem_1.1.0
## [25] cigarillo_1.0.0      jsonlite_2.0.0       blob_1.2.4
## [28] DelayedArray_0.36.0  jpeg_0.1-11          parallel_4.5.1
## [31] R6_2.6.1             bslib_0.9.0          RColorBrewer_1.1-3
## [34] jquerylib_0.1.4      Rcpp_1.1.0           bookdown_0.45
## [37] knitr_1.50           splines_4.5.1        Matrix_1.7-4
## [40] tidyselect_1.2.1     dichromat_2.0-0.1    abind_1.4-8
## [43] yaml_2.3.10          codetools_0.2-20     hwriter_1.3.2.1
## [46] curl_7.0.0           lattice_0.22-7       tibble_3.3.0
## [49] withr_3.0.2          KEGGREST_1.50.0      S7_0.2.0
## [52] evaluate_1.0.5       pillar_1.11.1        BiocManager_1.30.26
## [55] filelock_1.0.3       KernSmooth_2.23-26   BiocVersion_3.22.0
## [58] gtools_3.9.5         glue_1.8.0           tools_4.5.1
## [61] interp_1.1-6         grid_4.5.1           latticeExtra_0.6-31
## [64] AnnotationDbi_1.72.0 nlme_3.1-168         cli_3.6.5
## [67] rappdirs_0.3.3       S4Arrays_1.10.0      dplyr_1.1.4
## [70] gtable_0.3.6         sass_0.4.10          digest_0.6.37
## [73] SparseArray_1.10.1   farver_2.1.2         memoise_2.0.1
## [76] htmltools_0.5.8.1    lifecycle_1.0.4      httr_1.4.7
## [79] bit64_4.6.0-1
```

# References

Krokhin, O. V., R. Craig, V. Spicer, W. Ens, K. G. Standing, R. C. Beavis, and J. A. Wilkins. 2004. “An improved model for prediction of retention times of tryptic peptides in ion pair reversed-phase HPLC: its application to protein peptide mapping by off-line HPLC-MALDI MS.” *Mol. Cell Proteomics* 3 (9): 908–19.

Panse, C., C. Trachsel, J. Grossmann, and R. Schlapbach. 2015. “specL–an R/Bioconductor package to prepare peptide spectrum matches for use in targeted proteomics.” *Bioinformatics* 31 (13): 2228–31.