# SMAD Quick Start

Qingzhou (Johnson) Zhang\*

\*zqzneptune@hotmail.com

#### 2025-10-30

#### Package

SMAD 1.26.0

# 1 Introduction

This R package implements statistical modelling of affinity purification–mass
spectrometry (AP-MS) data to compute confidence scores to identify *bona fide*
protein-protein interactions (PPI).

# 2 Prepare Input Data

Prepare input data into the dataframe *datInput* with the following format:

| idRun | idBait | idPrey | countPrey | lenPrey |
| --- | --- | --- | --- | --- |
| AP-MS run ID | Bait ID | Prey ID | Prey peptide count | Prey protein length |

```
library(SMAD)
#> Loading required package: RcppAlgos
data("TestDatInput")
head(TestDatInput)
#>       idRun idBait idPrey countPrey lenPrey
#> 7452  68982  TIMP2  ACTC1        15     377
#> 8016  66491  CASP1   CDK4         9     303
#> 7162  68486   BTG3  RPL24         3     157
#> 8086  66491  CASP1 IMPDH2         9     514
#> 23653 72934    LUM  THOP1         7     689
#> 9196  67747    FAS   RFC5         9     340
```

The test data is subset from the unfiltered BioPlex 2.0 data, which consists of
apoptosis proteins as baits.

# 3 Methods

## 3.1 CompPASS

Comparative Proteomic Analysis Software Suite (CompPASS) is based on spoke
model. This algorithm was developed by Dr. Mathew Sowa for defining the human
deubiquitinating enzyme interaction landscape [(Sowa, Mathew E., et al.,
2009)](https://doi.org/10.1016/j.cell.2009.04.042). The implementation of this
algorithm was inspired by Dr. Sowa’s [online tutorial](http://besra.hms.harvard.edu/ipmsmsdbs/cgi-bin/tutorial.cgi).
The output includes Z-score, S-score, D-score and WD-score. In its
implementation in BioPlex 1.0 [(Huttlin, Edward L., et al., 2015)](https://doi.org/10.1016/j.cell.2015.06.043) and
BioPlex 2.0 [(Huttlin, Edward L., et al., 2017)](https://www.nature.com/articles/nature22366), a naive
Bayes classifier that learns to distinguish true interacting proteins from
non-specific background and false positive identifications was included in the
compPASS pipline. This function was optimized from the [source code](https://github.com/dnusinow/cRomppass).

```
scoreCompPASS <- CompPASS(TestDatInput)
head(scoreCompPASS)
#>   idBait idPrey AvePSM    scoreZ    scoreS    scoreD Entropy   scoreWD
#> 1  AIFM3  AIFM1     20 7.9382230 36.055513 36.055513       0 1.6903085
#> 2  AIFM3  ALDOA     14 2.6586313  9.095453  9.095453       0 0.2308028
#> 3  AIFM3 ATP5A1      5 0.5826082  5.700877  5.700877       0 0.1529845
#> 4  AIFM3   CALR      4 0.8703043  4.654747  4.654747       0 0.1161689
#> 5  AIFM3   CCT2     24 3.1558989 12.489996 12.489996       0 0.3398374
#> 6  AIFM3   CCT4     20 2.8371693  9.013878  9.013878       0 0.2135599
```

Based on the scores, bait-prey interactions could be ranked and ready for downstream analyses.

![](data:image/png;base64...)

## 3.2 HGScore

HGScore Scoring algorithm based on a hypergeometric distribution error model
[(Hart et al., 2007)](https://doi.org/10.1186/1471-2105-8-236) with incorporation of
NSAF [(Zybailov, Boris, et al., 2006)](https://doi.org/10.1021/pr060161n). This algorithm was first introduced
to predict the protein complex network of Drosophila melanogaster
[(Guruharsha, K. G., et al., 2011)](https://doi.org/10.1016/j.cell.2011.08.047). This scoring algorithm was based on
matrix model. Unlike CompPASS, we need protein length for each prey in
the additional column.

```
scoreHG <- HG(TestDatInput)
head(scoreHG)
#>   InteractorA InteractorB ppiTN tnA  tnB       PPI NMinTn       HG
#> 1         A2M        ACLY     1 122 1197  A2M~ACLY 477317 3.264772
#> 2         A2M         AGK     1 122  940   A2M~AGK 477317 3.707123
#> 3         A2M        AGO1     1 122 1501  A2M~AGO1 477317 2.860551
#> 4         A2M        AHCY     1 122 2349  A2M~AHCY 477317 2.098700
#> 5         A2M       AHSA1     1 122  386 A2M~AHSA1 477317 5.399179
#> 6         A2M       AKAP8     1 122  317 A2M~AKAP8 477317 5.782404
```

![](data:image/png;base64...)

Noted that HG scoring implements matrix models which leads to significant increase of inferred protein-protein interactions.