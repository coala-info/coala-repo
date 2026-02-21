# references

#### 4 November 2025

# Contents

* [1 Overview](#overview)
  + [1.1 Chronological DNAm age (in years)](#chronological-dnam-age-in-years)
  + [1.2 Gestational DNAm age (in weeks)](#gestational-dnam-age-in-weeks)
* [2 How to load data](#how-to-load-data)
* [3 sessionInfo()](#sessioninfo)

# 1 Overview

The methylclockData package is a repository of a few public datasets that
needs the *methylclock* package to estimate chronological and gestational DNA
methylation (DNAm) age as well as biological age using different methylation clocks.

## 1.1 Chronological DNAm age (in years)

* **Horvath’s clock**: It uses 353 CpGs described in @horvath2013dna. It was trained using 27K and 450K arrays in samples from different tissues. Other three different age-related biomarkers are also computed:
  + **AgeAcDiff** (DNAmAge acceleration difference): Difference between DNAmAge and chronological age.
  + **IEAA** (Intrinsic Epigenetic Age Acceleration): Residuals obtained after regressing DNAmAge and chronological age adjusted by cell counts.
  + **EEAA** (Extrinsic Epigenetic Age Acceleration): Residuals obtained after regressing DNAmAge and chronological age. This measure was also known as DNAmAge acceleration residual in the first Horvath’s paper.
* **Hannum’s clock**: It uses 71 CpGs described in @hannum2013genome. It was trained using 450K array in blood samples. Another are-related biomarer is also computed:
  + **AMAR** (Apparent Methylomic Aging Rate): Measure proposed in @hannum2013genome computed as the ratio between DNAm age and the chronological age.
* **BNN**: It uses Horvath’s CpGs to train a Bayesian Neural Network (BNN) to predict DNAm age as described in @alfonso2018.
* **Horvath’s skin+blood clock (Horvath2)**: Epigenetic clock for skin and blood cells. It uses 391 CpGs described in @horvath2018epigenetic. It was trained using 450K EPIC arrays in skin and blood sampels.
* **PedBE clock**: Epigenetic clock from buccal epithelial swabs. It’s intended purpose is buccal samples from individuals aged 0-20 years old. It uses 84 CpGs described in @mcewen2019pedbe. The authors gathered 1,721 genome-wide DNAm profiles from 11 different cohorts with individuals aged 0 to 20 years old.
* **Wu’s clock**: It uses 111 CpGs described in @wu2019dna. It is designed to predict age in children. It was trained using 27K and 450K.
* **BLUP clock**: It uses 319607 CpGs described in @zhang2019improved. It was trained using 450K and EPIC arrays in blood (13402 samples) and saliva (259 samples). Age predictors based on training sets with various sample sizes using Best Linear Unbiased Prediction (BLUP)
* **EN clock**: It uses 514 CpGs described in @zhang2019improved. It was trained using 450K and EPIC arrays in blood (13402 samples) and saliva (259 samples). Age predictors based on training sets with various sample sizes using Elastic Net (EN)

## 1.2 Gestational DNAm age (in weeks)

* **Knight’s clock**: It uses 148 CpGs described in @knight2016epigenetic. It was trained using 27K and 450K arrays in cord blood samples.
* **Bohlin’s clock**: It uses 96 CpGs described in @bohlin2016prediction. It was trained using 450K array in cord blood samples.
* **Mayne’s clock**: It uses 62 CpGs described in @mayne2017accelerated. It was trained using 27K and 450K.
* **EPIC clock**: EPIC-based predictor of gestational age. It uses 176 CpGs described in @haftorn2021epic. It was trained using EPIC arrays in cord blood samples.
* **Lee’s clocks**: Three different biological clocks described in @lee2019placental are implemented. It was trained for 450K and EPIC arrays in placenta samples.
  + **RPC clock**: Robust placental clock (RPC). It uses 558 CpG sites.
  + **CPC clock**: Control placental clock (CPC). It usses 546 CpG sites.
  + **Refined RPC clock**: Useful for uncomplicated term pregnancies (e.g. gestational age >36 weeks). It uses 396 CpG sites.

The biological DNAm clocks implemented in our package are:

* **Levine’s clock** (also know as PhenoAge): It uses 513 CpGs described in @levine2018epigenetic. It was trained using 27K, 450K and EPIC arrays in blood samples.
* **Telomere Length’s clock** (TL): It uses 140 CpGs described in @lu2019dna It was trained using 450K and EPIC arrays in blood samples.

# 2 How to load data

In the below example, we show how one can download this dataset from
ExperimentHub.

```
library(ExperimentHub)
library(methylclockData)

# Get experimentHub records
eh <- ExperimentHub()

# Get data about methylclockData experimentHub
pData <- query(eh , "methylclockData")

# Get information rows about methylclockData
df <- mcols(pData)
df
```

```
## DataFrame with 20 rows and 15 columns
##                         title dataprovider      species taxonomyid      genome
##                   <character>  <character>  <character>  <integer> <character>
## EH3913 Datasets to estimate..           NA Homo sapiens       9606        hg19
## EH6068         CpGs BNN clock           NA Homo sapiens       9606        hg19
## EH6069 Coefficients Bohlin'..           NA Homo sapiens       9606        hg19
## EH6070 Coefficients Hannum'..           NA Homo sapiens       9606        hg19
## EH6071 Coefficients Hobarth..           NA Homo sapiens       9606        hg19
## ...                       ...          ...          ...        ...         ...
## EH6082           Test Dataset           NA Homo sapiens       9606        hg19
## EH6083             References           NA Homo sapiens       9606        hg19
## EH7367 Coefficients BLUPclock           NA Homo sapiens       9606        hg19
## EH7368  Coefficients EN clock           NA Homo sapiens       9606        hg19
## EH7369 Coefficients EPIC cl..           NA Homo sapiens       9606        hg19
##                   description coordinate_1_based             maintainer
##                   <character>          <integer>            <character>
## EH3913 Predefined datasets ..                  0 Juan R Gonzalez <jua..
## EH6068 Horvath’s CpGs to tr..                  0 Juan R Gonzalez <jua..
## EH6069 96 CpGs described in..                  0 Juan R Gonzalez <jua..
## EH6070 71 CpGs described in..                  0 Juan R Gonzalez <jua..
## EH6071 353 CpGs described i..                  0 Juan R Gonzalez <jua..
## ...                       ...                ...                    ...
## EH6082           Test dataset                  0 Juan R Gonzalez <jua..
## EH6083             References                  0 Juan R Gonzalez <jua..
## EH7367 319607 CpGs describe..                  0 Juan R Gonzalez <jua..
## EH7368 514 CpGs described i..                  0 Juan R Gonzalez <jua..
## EH7369 176 CpGs described i..                  0 Juan R Gonzalez <jua..
##        rdatadateadded   preparerclass                                  tags
##           <character>     <character>                                <AsIs>
## EH3913     2020-11-18 methylclockData              GEO,ExperimentHub,Tissue
## EH6068     2021-05-18 methylclockData Homo_sapiens_Data,OrganismData,Tissue
## EH6069     2021-05-18 methylclockData Homo_sapiens_Data,OrganismData,Tissue
## EH6070     2021-05-18 methylclockData Homo_sapiens_Data,OrganismData,Tissue
## EH6071     2021-05-18 methylclockData Homo_sapiens_Data,OrganismData,Tissue
## ...               ...             ...                                   ...
## EH6082     2021-05-18 methylclockData Homo_sapiens_Data,OrganismData,Tissue
## EH6083     2021-05-18 methylclockData Homo_sapiens_Data,OrganismData,Tissue
## EH7367     2022-03-29 methylclockData Homo_sapiens_Data,OrganismData,Tissue
## EH7368     2022-03-29 methylclockData Homo_sapiens_Data,OrganismData,Tissue
## EH7369     2022-03-29 methylclockData Homo_sapiens_Data,OrganismData,Tissue
##         rdataclass              rdatapath              sourceurl  sourcetype
##        <character>            <character>            <character> <character>
## EH3913        List methylclockData/meth.. https://github.com/p..         RDA
## EH6068   character methylclockData/cpgs.. https://github.com/i..         RDA
## EH6069  data.frame methylclockData/coef.. https://github.com/i..         RDA
## EH6070  data.frame methylclockData/coef.. https://github.com/i..         RDA
## EH6071  data.frame methylclockData/coef.. https://github.com/i..         RDA
## ...            ...                    ...                    ...         ...
## EH6082       Lists methylclockData/Test.. https://github.com/i..         RDA
## EH6083  data.frame methylclockData/refe.. https://github.com/i..         RDA
## EH7367  data.frame methylclockData/coef.. https://github.com/i..         RDA
## EH7368  data.frame methylclockData/coef.. https://github.com/i..         RDA
## EH7369  data.frame methylclockData/coef.. https://github.com/i..         RDA
```

```
# Retrieve data with Hobarth's clock coefficients
pData["EH6071"]
```

```
## ExperimentHub with 1 record
## # snapshotDate(): 2025-10-29
## # names(): EH6071
## # package(): methylclockData
## # $dataprovider: NA
## # $species: Homo sapiens
## # $rdataclass: data.frame
## # $rdatadateadded: 2021-05-18
## # $title: Coefficients Hobarth's clock
## # $description: 353 CpGs described in Horvath (2013)
## # $taxonomyid: 9606
## # $genome: hg19
## # $sourcetype: RDA
## # $sourceurl: https://github.com/isglobal-brge/methylclock/blob/master/data
## # $sourcesize: NA
## # $tags: c("Homo_sapiens_Data", "OrganismData", "Tissue")
## # retrieve record with 'object[["EH6071"]]'
```

We also implemented some functions to easy access to the different datasets , for example, we can access to Hovarths CpGs to train a Bayesian Neural Network with function `get_cpgs_bn` or to `get_coefHannum` for Hannum’s clock coefficients

```
#  Hovarths CpGs to train a Bayesian Neural Network
cpgs.bn <- get_cpgs_bn()
head(cpgs.bn)
```

```
## [1] "cg00029931" "cg00043004" "cg00059225" "cg00141845" "cg00143376"
## [6] "cg00152644"
```

```
# Hannum's clock coefficients
coefHannum <- get_coefHannum()
head(coefHannum)
```

```
##    CpGmarker Chrom       Pos        Genes CpG.Island CoefficientTraining
## 1 cg20822990     1  17338766 ATP13A2,SDHB         No              -15.70
## 2 cg22512670     1  26855765      RPS6KA1         No                1.05
## 3 cg25410668     1  28241577 RPA2,SMPDL3B         No                3.87
## 4 cg04400972     1 117665053  TRIM45,TTF2        Yes                9.62
## 5 cg16054275     1 169556022      F5,SELP         No              -11.10
## 6 cg10501210     1 207997020     C1orf132         No               -6.46
```

```
# Hobarth's clock coefficients
coefHorvath <- get_coefHorvath()
head(coefHorvath)
```

```
##     CpGmarker CoefficientTraining CoefficientTrainingShrunk varByCpG minByCpG
## 1 (Intercept)         0.695507258                 0.8869198       NA       NA
## 2  cg00075967         0.129336610                 0.1080961  0.02600   0.0160
## 3  cg00374717         0.005017857                        NA  0.01200   0.0031
## 4  cg00864867         1.599764050                 1.8639686  0.00087   0.0000
## 5  cg00945507         0.056852418                        NA  0.01600   0.0000
## 6  cg01027739         0.102862854                        NA  0.01100   0.0000
##   maxByCpG medianByCpG medianByCpGYoung medianByCpGOld Gene_ID GenomeBuild Chr
## 1       NA          NA               NA             NA      NA          NA  NA
## 2     0.97       0.750            0.720          0.750   64220          36  15
## 3     1.00       0.890            0.870          0.900   22901          36  17
## 4     0.58       0.049            0.045          0.053    5074          36  12
## 5     0.96       0.240            0.230          0.250   23480          36   7
## 6     0.99       0.071            0.067          0.074   57171          36   9
##     MapInfo SourceVersion TSS_Coordinate Gene_Strand Symbol             Synonym
## 1        NA            NA             NA
## 2  72282407          36.1       72282245           -  STRA6 PP14296; FLJ12541;
## 3  63814740          36.1       63815191           +   ARSG          KIAA1001;
## 4  78609399          36.1       78608921           -   PAWR       PAR4; Par-4;
## 5  54795171          36.1       54794433           - SEC61G              SSS1;
## 6 130882559          36.1      130883227           + DOLPP1             LSFR2;
##     Accession         GID
## 1
## 2 NM_022369.2 GI:21314699
## 3 NM_014960.2 GI:45430056
## 4 NM_002583.2 GI:55769532
## 5 NM_014302.3 GI:60279263
## 6 NM_020438.3 GI:48976059
##                                                                                                                                                                                                                                                        Annotation
## 1
## 2                                                                                                                                                                                                                                     synonyms: PP14296; FLJ12541
## 3                                                                                                                       go_function: hydrolase activity; go_function: calcium ion binding; go_function: sulfuric ester hydrolase activity; go_process: metabolism
## 4 ###############################################################################################################################################################################################################################################################
## 5 ###############################################################################################################################################################################################################################################################
## 6 ###############################################################################################################################################################################################################################################################
##                                      Product Marginal.Age.Relationship
## 1
## 2 stimulated by retinoic acid gene 6 homolog                  positive
## 3                            Arylsulfatase G                  positive
## 4            PRKC; apoptosis; WT1; regulator                  positive
## 5                        Sec61 gamma subunit                  positive
## 6       dolichyl pyrophosphate phosphatase 1                  positive
```

```
# Knight's clock coefficients
coefKnightGA <- get_coefKnightGA()
head(coefKnightGA)
```

```
##     CpGmarker CoefficientTraining
## 1 (Intercept)          41.7257976
## 2  cg00022866           0.6935522
## 3  cg00466249          -0.8255749
## 4  cg00546897          -1.3585156
## 5  cg00575744          -3.8292857
## 6  cg00689340           0.9603426
```

```
# Lee's Gestational Age clock coefficients
coefLeeGA <- get_coefLeeGA()
head(coefLeeGA)
```

```
##     CpGmarker Coefficient_RPC Coefficient_CPC Coefficient_refined_RPC
## 1 (Intercept)    24.997721330     13.06182050              30.7496621
## 2  cg00009871    -0.124656981      0.00000000              -0.8186162
## 3  cg00035630    -0.006478271      0.00000000               0.0000000
## 4  cg00056066     0.859460073      0.01974736               0.1672244
## 5  cg00057476     0.372322642      0.78281228               0.3493741
## 6  cg00063979    -0.509028605      0.00000000              -1.0678955
##   Coefficient_sex_classifier
## 1                   1.801244
## 2                   0.000000
## 3                   0.000000
## 4                   0.000000
## 5                   0.000000
## 6                   0.000000
```

```
# Levine's clock coefficients
coefLevine <- get_coefLevine()
head(coefLevine)
```

```
##    CpGmarker Chromosome  Map.Info Gene.Symbol Entrez.ID CoefficientTraining
## 1  Intercept         NA        NA                    NA            60.66400
## 2 cg15611364          3  25806427        OXSM     54995            63.12415
## 3 cg17605084         12  53177758        HEM1      3071           -44.00939
## 4 cg26382071         17   6485627       TXNL5     84817            40.42085
## 5 cg12743894         11  30301513    C11orf46    120534            36.78818
## 6 cg19287114          9 107046432     SLC44A1     23446           -36.49384
##   Univariate.Age.Correlation Horvath.Overlap Hannum.Overlap
## 1                         NA
## 2                0.003807203              No             No
## 3               -0.029169140              No             No
## 4                0.002996738              No             No
## 5               -0.008386638              No             No
## 6               -0.118250325              No             No
```

```
# Mayne's clock coefficients
coefMayneGA <- get_coefMayneGA()
head(coefMayneGA)
```

```
##     CpGmarker CoefficientTraining    Gene Chromosome  Position
## 1 (Intercept)          24.9902644    <NA>         NA        NA
## 2  cg12146151          -1.9282536   ITGB4         17  73716945
## 3  cg16127845         -26.4451900   GPER1          7   1126423
## 4  cg17133388         -17.3515068 FAM162A          3 122102727
## 5  cg13997435          -0.9527281  S100A2          1 153538406
## 6  cg12360736          -5.6655794   MBNL1          3 151985869
##   Correlation.with.GA
## 1                  NA
## 2          -0.6415864
## 3          -0.6350808
## 4          -0.6118330
## 5          -0.6076825
## 6          -0.6018116
```

```
# PedBE's clock coefficients
coefPedBE <- get_coefPedBE()
head(coefPedBE)
```

```
##     CpGmarker CoefficientTraining corAgeTraining corAgeTest
## 1 (Intercept)        -2.097349336             NA         NA
## 2  cg00059225         0.021960020      0.8661036  0.8903716
## 3  cg00085493        -0.100396107     -0.7801136 -0.8090162
## 4  cg00095976         0.007872419      0.6874745  0.7573932
## 5  cg00609333         0.022823643      0.6291968  0.7982873
## 6  cg01287592        -0.055414703     -0.7201259 -0.5782867
```

```
#  Horvath's skin+blood clock coefficients
coefSkin <- get_coefSkin()
head(coefSkin)
```

```
##     CpGmarker CoefficientTraining
## 1 (Intercept)        -0.447119319
## 2  cg12140144         0.363181170
## 3  cg26933021        -0.090500090
## 4  cg20822990        -0.007025234
## 5  cg07312601        -0.135092400
## 6  cg09993145        -0.042639340
```

```
# Telomere Length clock coefficients
coefTL <- get_coefTL()
head(coefTL)
```

```
##    CpGmarker CoefficientTraining CHR    bp19
## 1  Intercept          7.92478005          NA
## 2 cg05528516         -0.03490186   1 1070040
## 3 cg00060374          0.19265502   1 1355235
## 4 cg12711627          0.17826976   1 2025769
## 5 cg06853416          0.05488373   1 2778841
## 6 cg01901101         -0.28813724   1 9486939
##                                            SourceSeq Strand
## 1
## 2 CGGACCCCCACCGGCCTCCAAATGTGCAAACACAGGCGCCTCTCAGGCAC      R
## 3 CGGCTTCATGCTGGTGGCAGCAACAGACTCTCCGCCAGCGCCGGGCCTGT      R
## 4 CGGGCACCACACAGCATCCCAGGCACCATCATGGTAGGAGAAGAGTTCAG      R
## 5 AGAGTCCCCCTCTGGATTCACACACCTGGAGGCGTCTGAGTGACTCCTCG      R
## 6 CAAAAAAACCCCAGCTTTTGTCCAGAGGTTGCTTTTTGTGGGTCTGTACG      F
##   Probe.SNP.based.on.Illumina.annotation            Gene   location
## 1
## 2                                        C1orf159-TTLL10
## 3                                              LOC441869  Body;Body
## 4                                                  PRKCZ Body;5'UTR
## 5                                           MMEL1-ACTRT2
## 6                                         SPSB1-SLC25A33
##   Relation.to..CpGIsland Probe.SNP.based.on.1000.Genome        SNP CHR.SNP
## 1                                                                       NA
## 2                N_Shelf                              N rs74048017       1
## 3                 Island                              N  rs1240717       1
## 4                 Island                                                NA
## 5                S_Shore                              N rs12409348       1
## 6                N_Shore                              N rs10864418       1
##    bp.SNP ALLELE   BSGS.P BSGS.EFFECT BSGS.H2    LBC.P LBC.EFFECT  LBC.R2 mQTL
## 1      NA              NA          NA      NA       NA         NA      NA
## 2 1069602      T 2.61e-42       0.258 0.38864 2.56e-47    0.16960 0.14200  cis
## 3 1346257      A 2.98e-58      -0.440 0.45741 9.87e-84   -0.51230 0.24090  cis
## 4      NA              NA          NA      NA       NA         NA      NA
## 5 2779043      C 2.59e-39      -0.206 0.34692 3.24e-78   -0.24150 0.22670  cis
## 6 9489972      G 8.21e-08       0.037 0.06047 3.51e-17    0.06817 0.05077  cis
```

```
# BLUP clock coefficients
coefBLUP <- get_coefBLUP()
head(coefBLUP)
```

```
##    CpGmarker CoefficientTraining
## 1  Intercept       91.1539600000
## 2 cg18478105       -0.0111273610
## 3 cg14361672        0.0005570068
## 4 cg01763666       -0.0176955658
## 5 cg02115394        0.0090890982
## 6 cg13417420       -0.0163150063
```

```
# EN clock coefficients
coefEN <- get_coefEN()
head(coefEN)
```

```
##    CpGmarker CoefficientTraining
## 1  Intercept        65.792950000
## 2 cg24611351        -0.001810743
## 3 cg24173182        -0.203954555
## 4 cg09604333        -0.703967823
## 5 cg13617776        -0.011524460
## 6 cg09432590         1.048977229
```

```
# EPIC clock coefficients
coefEPIC <- get_coefEPIC()
head(coefEPIC)
```

```
## # A tibble: 6 × 2
##   CpGmarker   CoefficientTraining
##   <chr>                     <dbl>
## 1 (Intercept)            293.
## 2 cg12701018              -0.0916
## 3 cg00078456              -2.31
## 4 cg14958032              -0.479
## 5 cg00735586             -11.7
## 6 cg09035049              -8.51
```

```
#  Wu's clock coefficients
Wu <- get_coefWu()
head(Wu)
```

```
##     CpGmarker CoefficientTraining GeneID GenomeBuild Chr   MapInfo    UGRepAcc
## 1 (Intercept)           2.3768538     NA          NA  NA        NA
## 2  cg00343092          -1.1359977    706          36  22  41877918 NM_000714.4
## 3  cg00563932          -2.2549679   5730          36   9 138990870 NM_000954.5
## 4  cg00571634           1.2051302  54554          36   3 123617510 NM_019069.3
## 5  cg00629217          -1.4431147  84708          36   4  54120106 NM_032622.1
## 6  cg01511567           0.5572547   6749          36  11  56860207 NM_003146.2
##   Symbol
## 1
## 2   TSPO
## 3  PTGDS
## 4  WDR5B
## 5   LNX1
## 6  SSRP1
```

```
# # references
references <- get_references()
load(references)
```

For more information in how loading and use of the data, please, refer to [`MethylClock` vignette](https://github.com/isglobal-brge/methylclock)

# 3 sessionInfo()

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
## [1] methylclockData_1.18.0 futile.logger_1.4.3    ExperimentHub_3.0.0
## [4] AnnotationHub_4.0.0    BiocFileCache_3.0.0    dbplyr_2.5.1
## [7] BiocGenerics_0.56.0    generics_0.1.4         BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1            dplyr_1.1.4
##  [3] blob_1.2.4                  filelock_1.0.3
##  [5] Biostrings_2.78.0           bitops_1.0-9
##  [7] fastmap_1.2.0               RCurl_1.98-1.17
##  [9] GenomicAlignments_1.46.0    XML_3.99-0.19
## [11] digest_0.6.37               lifecycle_1.0.4
## [13] KEGGREST_1.50.0             RSQLite_2.4.3
## [15] magrittr_2.0.4              compiler_4.5.1
## [17] rlang_1.1.6                 sass_0.4.10
## [19] tools_4.5.1                 utf8_1.2.6
## [21] yaml_2.3.10                 lambda.r_1.2.4
## [23] rtracklayer_1.70.0          knitr_1.50
## [25] S4Arrays_1.10.0             bit_4.6.0
## [27] curl_7.0.0                  DelayedArray_0.36.0
## [29] abind_1.4-8                 BiocParallel_1.44.0
## [31] ExperimentHubData_1.36.0    withr_3.0.2
## [33] purrr_1.1.0                 grid_4.5.1
## [35] stats4_4.5.1                SummarizedExperiment_1.40.0
## [37] cli_3.6.5                   rmarkdown_2.30
## [39] crayon_1.5.3                stringdist_0.9.15
## [41] httr_1.4.7                  rjson_0.2.23
## [43] BiocBaseUtils_1.12.0        RUnit_0.4.33.1
## [45] DBI_1.2.3                   cachem_1.1.0
## [47] parallel_4.5.1              AnnotationDbi_1.72.0
## [49] formatR_1.14                BiocManager_1.30.26
## [51] XVector_0.50.0              restfulr_0.0.16
## [53] matrixStats_1.5.0           vctrs_0.6.5
## [55] Matrix_1.7-4                jsonlite_2.0.0
## [57] AnnotationHubData_1.40.0    bookdown_0.45
## [59] IRanges_2.44.0              S4Vectors_0.48.0
## [61] RBGL_1.86.0                 bit64_4.6.0-1
## [63] GenomicFeatures_1.62.0      jquerylib_0.1.4
## [65] glue_1.8.0                  codetools_0.2-20
## [67] GenomeInfoDb_1.46.0         BiocVersion_3.22.0
## [69] BiocCheck_1.46.0            UCSC.utils_1.6.0
## [71] GenomicRanges_1.62.0        BiocIO_1.20.0
## [73] tibble_3.3.0                pillar_1.11.1
## [75] rappdirs_0.3.3              htmltools_0.5.8.1
## [77] Seqinfo_1.0.0               graph_1.88.0
## [79] R6_2.6.1                    httr2_1.2.1
## [81] AnnotationForge_1.52.0      evaluate_1.0.5
## [83] OrganismDbi_1.52.0          Biobase_2.70.0
## [85] lattice_0.22-7              futile.options_1.0.1
## [87] png_0.1-8                   Rsamtools_2.26.0
## [89] cigarillo_1.0.0             memoise_2.0.1
## [91] bslib_0.9.0                 SparseArray_1.10.1
## [93] xfun_0.54                   biocViews_1.78.0
## [95] MatrixGenerics_1.22.0       pkgconfig_2.0.3
```