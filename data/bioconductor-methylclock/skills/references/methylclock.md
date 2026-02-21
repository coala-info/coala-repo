# Chronological and gestational DNAm age estimation using different methylation-based clocks

### Dolors Pelegri and Juan R Gonzalez

Institute for Global Health (ISGlobal), Barcelona, Spain
Bioinformatics Research Group in Epidemiolgy (BRGE)
http://brge.isglobal.org

#### 2025-10-30

#### Package

methylclock 1.16.0

# Contents

* [1 Description of implemented clocks](#description-of-implemented-clocks)
  + [1.1 Chronological DNAm age (in years)](#chronological-dnam-age-in-years)
  + [1.2 Gestational DNAm age (in weeks)](#gestational-dnam-age-in-weeks)
* [2 Getting started](#getting-started)
* [3 DNA Methylation clocks](#dna-methylation-clocks)
  + [3.1 Data format](#data-format)
  + [3.2 Data nomalization](#data-nomalization)
  + [3.3 Missing individual’s data](#missing-individuals-data)
  + [3.4 Missing CpGs of DNAm clocks](#section-missingCpGs)
  + [3.5 Cell counts](#cell-counts)
* [4 Chronological and biological DNAm age estimation](#chronological-and-biological-dnam-age-estimation)
  + [4.1 Data in Horvath’s format (e.g. `csv` with CpGs in rows)](#section-example)
  + [4.2 Age acceleration](#age-acceleration)
  + [4.3 Chronological age prediction using `ExpressionSet` data](#chronological-age-prediction-using-expressionset-data)
  + [4.4 Use of DNAmAge in association studies](#use-of-dnamage-in-association-studies)
  + [4.5 Use of DNAm age in children](#use-of-dnam-age-in-children)
* [5 Gestational DNAm age estimation](#gestational-dnam-age-estimation)
  + [5.1 Model predicion](#model-predicion)
* [6 Correlation among DNAm clocks](#correlation-among-dnam-clocks)
* [7 References](#references)
* **Appendix**

# 1 Description of implemented clocks

This manual describes how to estimate chronological and gestational DNA
methylation (DNAm) age as well as biological age using different methylation
clocks. The package includes the following estimators:

## 1.1 Chronological DNAm age (in years)

* **Horvath’s clock**: It uses 353 CpGs described in Horvath ([2013](#ref-horvath2013dna)).
  It was trained using 27K and 450K arrays in samples from different tissues.
  Other three different age-related biomarkers are also computed:
  + **AgeAcDiff** (DNAmAge acceleration difference): Difference between
    DNAmAge and chronological age.
  + **IEAA** Residuals obtained after regressing DNAmAge and chronological
    age adjusted by cell counts.
  + **EEAA** Residuals obtained after regressing DNAmAge and chronological
    age. This measure was also known as DNAmAge acceleration residual in the
    first Horvath’s paper.
* **Hannum’s clock**: It uses 71 CpGs described in Hannum et al. ([2013](#ref-hannum2013genome)). It was
  trained using 450K array in blood samples. Another are-related biomarer is
  also computed:
  + **AMAR** (Apparent Methylomic Aging Rate): Measure proposed in
    Hannum et al. ([2013](#ref-hannum2013genome)) computed as the ratio between DNAm age and the
    chronological age.
* **BNN**: It uses Horvath’s CpGs to train a Bayesian Neural Network
  (BNN) to predict DNAm age as described in Alfonso and Gonzalez ([2020](#ref-alfonso2018)).
* **Horvath’s skin+blood clock (skinHorvath)**: Epigenetic clock for skin
  and blood cells. It uses 391 CpGs described in Horvath et al. ([2018](#ref-horvath2018epigenetic)).
  It was trained using 450K EPIC arrays in skin and blood sampels.
* **PedBE clock**: Epigenetic clock from buccal epithelial swabs. It’s
  intended purpose is buccal samples from individuals aged 0-20 years old.
  It uses 84 CpGs described in McEwen et al. ([2019](#ref-mcewen2019pedbe)). The authors gathered 1,721
  genome-wide DNAm profiles from 11 different cohorts with individuals aged
  0 to 20 years old.
* **Wu’s clock**: It uses 111 CpGs described in Wu et al. ([2019](#ref-wu2019dna)). It is designed
  to predict age in children. It was trained using 27K and 450K.
* **BLUP clock**: It uses 319607 CpGs described in Zhang et al. ([2019](#ref-zhang2019improved)).
  It was trained using 450K and EPIC arrays in blood (13402 samples) and
  saliva (259 samples). Age predictors based on training sets with various
  sample sizes using Best Linear Unbiased Prediction (BLUP)
* **EN clock**: It uses 514 CpGs described in Zhang et al. ([2019](#ref-zhang2019improved)). It was
  trained using 450K and EPIC arrays in blood (13402 samples) and saliva
  (259 samples). Age predictors based on training sets with various sample
  sizes using Elastic Net (EN)

## 1.2 Gestational DNAm age (in weeks)

* **Knight’s clock**: It uses 148 CpGs described in Knight et al. ([2016](#ref-knight2016epigenetic)).
  It was trained using 27K and 450K arrays in cord blood samples.
* **Bohlin’s clock**: It uses 96 CpGs described in Bohlin et al. ([2016](#ref-bohlin2016prediction)).
  It was trained using 450K array in cord blood samples.
* **Mayne’s clock**: It uses 62 CpGs described in Mayne et al. ([2017](#ref-mayne2017accelerated)).
  It was trained using 27K and 450K.
* **EPIC clock**: EPIC-based predictor of gestational age. It uses 176
  CpGs described in Haftorn et al. ([2021](#ref-haftorn2021epic)). It was trained using EPIC arrays in
  cord blood samples.
* **Lee’s clocks**: Three different biological clocks described in
  Lee et al. ([2019](#ref-lee2019placental)) are implemented. It was trained for 450K and EPIC
  arrays in placenta samples.
* **RPC clock**: Robust placental clock (RPC). It uses 558 CpG sites.
* **CPC clock**: Control placental clock (CPC). It usses 546 CpG sites.
* **Refined RPC clock**: Useful for uncomplicated term pregnancies
  (e.g. gestational age >36 weeks). It uses 396 CpG sites.

The biological DNAm clocks implemented in our package are:

* **Levine’s clock** (also know as PhenoAge): It uses 513 CpGs described
  in Levine et al. ([2018](#ref-levine2018epigenetic)). It was trained using 27K, 450K and EPIC arrays
  in blood samples.
* **Telomere Length’s clock** (TL): It uses 140 CpGs described in Lu et al. ([2019](#ref-lu2019dna))
  It was trained using 450K and EPIC arrays in blood samples.

The main aim of this package is to facilitate the interconnection with R and
Bioconductor’s infrastructure and, hence, avoiding submitting data to online
calculators. Additionally, `methylclock` also provides an unified way of
computing DNAm age to help downstream analyses.

# 2 Getting started

The package depends on some R packages that can be previously installed into
your computer by:

```
install.packages(c("tidyverse", "impute", "Rcpp"))
```

Then `methylclock` package is installed into your computer by executing:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
                        install.packages("BiocManager")

BiocManager::install("methylclock")
```

The package is loaded into R as usual:

```
library(methylclockData)
library(methylclock)
```

These libraries are required to reproduce this document:

```
library(Biobase)
library(tibble)
library(impute)
library(ggplot2)
library(ggpmisc)
library(GEOquery)
```

# 3 DNA Methylation clocks

The main function to estimate chronological and biological mDNA age is called
`DNAmAge` while the gestational DNAm age is estimated using `DNAmGA` function.
Both functions have similar input arguments. Next subsections detail some of
the important issues to be consider before computind DNAm clocks.

## 3.1 Data format

The methylation data is given in the argument `x`. They can be either beta or
M values. The argument `toBetas` should be set to TRUE when M values are
provided. The `x` object can be:

* A **matrix** with CpGs in rows and individuals in columns having the name
  of the CpGs in the rownames.
* A **data frame** or a **tibble** with CpGs in rows and individuals in columns
  having the name of the CpGs in the first column (e.g. cg00000292, cg00002426,
  cg00003994, …) as required in the Horvath’s DNA Methylation Age Calculator
  website (<https://dnamage.genetics.ucla.edu/home>).
* A **GenomicRatioSet** object, the default method to encapsulate methylation
  data in `minfi` Bioconductor package.
* An **ExpressionSet** object as obtained, for instance, when downloading
  methylation data from GEO (<https://www.ncbi.nlm.nih.gov/geo/>).

## 3.2 Data nomalization

In principle, data can be normalized by using any of the existing standard
methods such as QN, ASMN, PBC, SWAN, SQN, BMIQ (see a revision of those
methods in Wang et al. ([2015](#ref-wang2015systematic))). `DNAmAge` function includes the BMIQ method
proposed by Teschendorff et al. ([2012](#ref-teschendorff2012beta)) using Horvath’s robust implementation that
basically consists of an optimal R code implementation and optimization
procedures. This normalization is recommended by Horvath since it improves
the predictions for his clock. This normalization procedure is very
time-consuming. In order to overcome these difficulties, we have parallelize
this process using `BiocParallel` library. This step is not mandatory, so that,
you can use your normalized data and set the argument `normalize` equal to
FALSE (default).

## 3.3 Missing individual’s data

All the implemented methods require complete cases. `DNAmAge` function has an
imputation method based on KNN implemented in the function `knn.impute` from
`impute` Bioconductor package. This is performed when missing data is present
in the CpGs used in any of the computed clocks. There is also another option
based on a fast imputation method that imputes missing values by the median of
required CpGs as recommended in Bohlin et al. ([2016](#ref-bohlin2016prediction)). This is recommended when
analyzing 450K arrays since `knn.impute` for large datasets may be very time
consuming. Fast imputation can be performed by setting `fastImp=TRUE` which is
not the default value.

## 3.4 Missing CpGs of DNAm clocks

By default the package computes the different clocks when there are more than
80% of the required CpGs of each method. Nothing is required when having
missing CpGs since the main functions will return NA for those estimators
when this criteria is not meet. Let us use a test dataset (`TestDataset`)
which is available within the package to illustrate the type of information
we are obtaining:

```
# Get TestDataset data
TestDataset <- get_TestDataset()

cpgs.missing <- checkClocks(TestDataset)
```

```
          clock Cpgs_in_clock missing_CpGs percentage
  1     Horvath           353            2        0.6
  2      Hannum            71           64       90.1
  3      Levine           513            3        0.6
  4 SkinHorvath           391          283       72.4
  5       PedBE            94           91       96.8
  6          Wu           111            2        1.8
  7          TL           140          137       97.9
  8        BLUP        319607       300288       94.0
  9          EN           514          476       92.6
```

```
cpgs.missing.GA <- checkClocksGA(TestDataset)
```

```
     clock Cpgs_in_clock missing_CpGs percentage
  1 Knight           148            0        0.0
  2 Bohlin            87           87      100.0
  3  Mayne            62            0        0.0
  4    Lee          1125         1072       95.3
  5   EPIC           176          170       96.6
```

The objects `cpgs.missing` and `cpgs.missing.GA` are lists having the missing
CpGs of each clock

```
names(cpgs.missing)
```

```
  [1] "Horvath"     "Hannum"      "Levine"      "skinHorvath" "PedBE"
  [6] "Wu"          "TL"          "BLUP"        "EN"
```

We can see which are those CpGs for a given clock (for example Hannum) with
the function `commonClockCpgs` :

```
commonClockCpgs(cpgs.missing, "Hannum" )
```

```
   [1] "cg20822990"      "cg22512670"      "cg25410668"      "cg04400972"
   [5] "cg16054275"      "cg10501210"      "ch.2.30415474F"  "cg22158769"
   [9] "cg02085953"      "cg06639320"      "cg22454769"      "cg24079702"
  [13] "cg23606718"      "cg22016779"      "cg03607117"      "cg07553761"
  [17] "cg00481951"      "cg25478614"      "cg25428494"      "cg02650266"
  [21] "cg08234504"      "cg23500537"      "cg20052760"      "cg16867657"
  [25] "cg06685111"      "cg00486113"      "cg13001142"      "cg20426994"
  [29] "cg14361627"      "cg08097417"      "cg07955995"      "cg22285878"
  [33] "cg03473532"      "cg08540945"      "cg07927379"      "cg16419235"
  [37] "cg07583137"      "cg22796704"      "cg19935065"      "cg23091758"
  [41] "cg23744638"      "cg04940570"      "cg11067179"      "cg22213242"
  [45] "cg06419846"      "cg02046143"      "cg00748589"      "cg18473521"
  [49] "cg01528542"      "ch.13.39564907R" "cg03032497"      "cg04875128"
  [53] "cg09651136"      "cg03399905"      "cg04416734"      "cg07082267"
  [57] "cg14692377"      "cg06874016"      "cg21139312"      "cg02867102"
  [61] "cg19283806"      "cg14556683"      "cg07547549"      "cg08415592"
```

```
commonClockCpgs(cpgs.missing.GA, "Bohlin" )
```

```
   [1] "cg00153101" "cg00602416" "cg00711496" "cg01190109" "cg01635555"
   [6] "cg01833485" "cg02324006" "cg02405476" "cg02567958" "cg02642822"
  [11] "cg03108070" "cg03281561" "cg03337084" "cg03507326" "cg03710860"
  [16] "cg03729251" "cg03773820" "cg03963689" "cg04347477" "cg04685228"
  [21] "cg05053327" "cg05544807" "cg05877497" "cg06753281" "cg06897661"
  [26] "cg07106169" "cg07676709" "cg07738730" "cg07749613" "cg07788865"
  [31] "cg07835443" "cg08326019" "cg08620426" "cg08943494" "cg09447786"
  [36] "cg10308785" "cg11124260" "cg11294761" "cg11864574" "cg12880227"
  [41] "cg12999267" "cg13036381" "cg13066703" "cg13433246" "cg13641317"
  [46] "cg13733403" "cg13959344" "cg13982823" "cg14276580" "cg14427590"
  [51] "cg15035133" "cg15131146" "cg15165154" "cg15908709" "cg16187883"
  [56] "cg16348385" "cg17022232" "cg18183624" "cg18217136" "cg18954401"
  [61] "cg19057830" "cg19439123" "cg19875532" "cg20301308" "cg20303561"
  [66] "cg20816447" "cg21081878" "cg21143441" "cg21155834" "cg21221899"
  [71] "cg21707172" "cg21878650" "cg22761205" "cg22796593" "cg22797644"
  [76] "cg23051248" "cg23346945" "cg23403099" "cg23457357" "cg24041556"
  [81] "cg24087613" "cg24366564" "cg25150953" "cg25531857" "cg25639749"
  [86] "cg26077811" "cg26092675"
```

In Section [4.1](#section-example) we describe how to change this 80% threshold.

## 3.5 Cell counts

The EEAA method requires to estimate cell counts. We use the package `meffil`
(Min et al. ([2018](#ref-min2018meffil))) that provides some functions to estimate cell counts using
predefined datasets. This is performed by setting `cell.count=TRUE` (default
value). The reference panel is passed through the argument
`cell.count.reference`. So far, the following options are available:

* **“blood gse35069 complete”**: methylation profiles from
  Reinius et al. ([2012](#ref-reinius2012differential)) for purified blood cell types. It includes CD4T, CD8T,
  Mono, Bcell, NK, Neu and Eos.
* **“blood gse35069”**: methylation profiles from Reinius et al. ([2012](#ref-reinius2012differential)) for
  purified blood cell types. It includes CD4T, CD8T, Mono, Bcell, NK and Gran.
* **“blood gse35069 chen”**: methylation profiles from Chen et al. ([2017](#ref-chen2017epigenome)) blood
  cell types. It includes CD4T, CD8T, Mono, Bcell, NK, Neu and Eos.
* **“andrews and bakulski cord blood”**. Cord blood reference from

1. It includes Bcell, CD4T, CD8T, Gran, Mono, NK and nRBC.

* **“cord blood gse68456”** Cord blood methylation profiles from

2. It includes CD4T, CD8T, Mono, Bcell, NK, Neu, Eos and RBC.

* **“gervin and lyle cord blood”** Cord blood reference generated by Kristina
  Gervin and Robert Lyle, available at `miffil` package. It includes CD14, Bcell,
  CD4T, CD8T, NK, Gran.
* **“saliva gse48472”**: Reference generated from the multi-tissue pannel from

3. It includes Buccal, CD4T, CD8T, Mono, Bcell, NK,
   Gran.

* **“guintivano dlpfc”**: Reference generated from Guintivano, Aryee, and Kaminsky ([2013](#ref-guintivano2013cell)). It
  includes dorsolateral prefrontal cortex, NeuN\_neg and NeuN\_pos.
* **“combined cord blood”**: References generated based in samples assayed by
  Bakulski et al, Gervin et al., de Goede et al., and Lin et al. It includes
  umbilical cord blood, Bcell, CD4T, CD8T, Gran, Mono, NK and nRBC

# 4 Chronological and biological DNAm age estimation

Next we illustrate how to estimate the chronological DNAm age using several
datasets which aim to cover different data input formats.

**IMPORTANT NOTE**: On some systems we can find an error in the `DNAmAge()`
function when parameter `cell.count = TRUE`. This error is related to
`preprocessCore` package and can be fixed by disabling multi-threading
when installing the preprocessCore package using the command

```
BiocManager::install("preprocessCore",
                     configure.args = "--disable-threading",
                     force = TRUE)
```

## 4.1 Data in Horvath’s format (e.g. `csv` with CpGs in rows)

Let us start by reproducing the results proposed in Horvath ([2013](#ref-horvath2013dna)). It uses
the format available in the file ’MethylationDataExample55.csv" from his
tutorial (available [here](https://dnamage.genetics.ucla.edu/home)). These data
are available at `methylclock` package. Although these data can be loaded into
R by using standard functions such as `read.csv` we hihgly recommend to use
functions from `tidiverse`, in particular `read_csv` from `readr` package.
The main reason is that currently researchers are analyzing Illumina 450K
or EPIC arrays that contains a huge number of CpGs that can take a long time
to be loaded when using basic importing R function. These functions import
`csv` data as tibble which is one of the possible formats of `DNAmAge` function

```
library(tidyverse)
MethylationData <- get_MethylationDataExample()
MethylationData
```

```
  # A tibble: 27,578 × 17
     ProbeID GSM946048 GSM946049 GSM946052 GSM946054 GSM946055 GSM946056 GSM946059
     <chr>       <dbl>     <dbl>     <dbl>     <dbl>     <dbl>     <dbl>     <dbl>
   1 cg0000…    0.706    0.730     0.705     0.751     0.715     0.634     0.682
   2 cg0000…    0.272    0.274     0.311     0.279     0.178     0.269     0.330
   3 cg0000…    0.0370   0.0147    0.0171    0.0290    0.0163    0.0243    0.0127
   4 cg0000…    0.133    0.120     0.121     0.107     0.110     0.129     0.102
   5 cg0000…    0.0309   0.0192    0.0217    0.0132    0.0181    0.0243    0.0199
   6 cg0000…    0.0700   0.0715    0.0655    0.0719    0.0914    0.0508    0.0294
   7 cg0000…    0.993    0.993     0.993     0.994     0.991     0.994     0.993
   8 cg0000…    0.0215   0.0202    0.0187    0.0169    0.0162    0.0143    0.0172
   9 cg0000…    0.0105   0.00518   0.00410   0.00671   0.00758   0.00518   0.00543
  10 cg0001…    0.634    0.635     0.621     0.639     0.599     0.591     0.594
  # ℹ 27,568 more rows
  # ℹ 9 more variables: GSM946062 <dbl>, GSM946064 <dbl>, GSM946065 <dbl>,
  #   GSM946066 <dbl>, GSM946067 <dbl>, GSM946073 <dbl>, GSM946074 <dbl>,
  #   GSM946075 <dbl>, GSM946076 <dbl>
```

*IMPORTANT NOTE*: Be sure that the first column contains the CpG names.
Sometimes, your imported data look like this one (it can happen, for
instance, if the `csv` file was created in R without indicating
`row.names=FALSE`)

```
> mydata

# A tibble: 473,999 x 6
    X1 Row.names BIB_15586_1X BIB_33043_1X EDP_5245_1X KAN_584_1X
    <int> <chr>            <dbl>        <dbl>       <dbl>      <dbl>
1     1 cg000000~       0.635        0.575       0.614      0.631
2     2 cg000001~       0.954        0.948       0.933      0.950
3     3 cg000001~       0.889        0.899       0.901      0.892
4     4 cg000001~       0.115        0.124       0.107      0.123
5     5 cg000002~       0.850        0.753       0.806      0.815
6     6 cg000002~       0.676        0.771       0.729      0.665
7     7 cg000002~       0.871        0.850       0.852      0.863
8     8 cg000003~       0.238        0.174       0.316      0.206
```

If so, the first column must be removed before being used as the input
object in `DNAmAge` funcion. It can be done using `dplyr` function

```
> mydata2 <- select(mydata, -1)

# A tibble: 473,999 x 5
    Row.names BIB_15586_1X BIB_33043_1X EDP_5245_1X KAN_584_1X
    <chr>            <dbl>        <dbl>       <dbl>      <dbl>
1    cg000000~       0.635        0.575       0.614      0.631
2    cg000001~       0.954        0.948       0.933      0.950
3    cg000001~       0.889        0.899       0.901      0.892
4    cg000001~       0.115        0.124       0.107      0.123
5    cg000002~       0.850        0.753       0.806      0.815
6    cg000002~       0.676        0.771       0.729      0.665
7    cg000002~       0.871        0.850       0.852      0.863
8    cg000003~       0.238        0.174       0.316      0.206
```

In any case, if you use the object `mydata` that contains the CpGs in the
second column, you will see this error message:

```
> DNAmAge(mydata)
Error in DNAmAge(mydata) : First column should contain CpG names
```

Once data is in the proper format, DNAmAge can be estimated by simply:

```
age.example55 <- DNAmAge(MethylationData)
```

```
  Warning in predAge(cpgs.imp, coefHannum, intercept = FALSE, min.perc): The number of missing CpGs forHannumclock exceeds 80%.
    ---> This DNAm clock will be NA.
```

```
   rows : 353 cols : 16
```

```
  Warning in predAge(cpgs.imp, coefSkin, intercept = TRUE, min.perc): The number of missing CpGs forSkinclock exceeds 80%.
    ---> This DNAm clock will be NA.
```

```
  Warning in predAge(cpgs.imp, coefPedBE, intercept = TRUE, min.perc): The number of missing CpGs forPedBEclock exceeds 80%.
    ---> This DNAm clock will be NA.
```

```
  Warning in predAge(cpgs.imp, coefTL, intercept = TRUE, min.perc): The number of missing CpGs forTLclock exceeds 80%.
    ---> This DNAm clock will be NA.
```

```
  Warning in predAge(cpgs.imp, coefBLUP, intercept = TRUE, min.perc): The number of missing CpGs forBLUPclock exceeds 80%.
    ---> This DNAm clock will be NA.
```

```
  Warning in predAge(cpgs.imp, coefEN, intercept = TRUE, min.perc): The number of missing CpGs forENclock exceeds 80%.
    ---> This DNAm clock will be NA.
```

```
age.example55
```

```
  # A tibble: 16 × 11
     id      Horvath Hannum Levine   BNN skinHorvath PedBE    Wu TL    BLUP  EN
     <chr>     <dbl> <lgl>   <dbl> <dbl> <lgl>       <lgl> <dbl> <lgl> <lgl> <lgl>
   1 GSM946…   51.8  NA      -30.3 56.4  NA          NA    1.08  NA    NA    NA
   2 GSM946…   39.8  NA      -29.6 42.1  NA          NA    0.808 NA    NA    NA
   3 GSM946…   26.4  NA      -33.3 25.6  NA          NA    0.772 NA    NA    NA
   4 GSM946…   34.0  NA      -36.0 28.0  NA          NA    0.941 NA    NA    NA
   5 GSM946…   10.1  NA      -52.8 13.4  NA          NA    0.456 NA    NA    NA
   6 GSM946…   20.4  NA      -42.2 16.7  NA          NA    0.621 NA    NA    NA
   7 GSM946…    6.00 NA      -44.8  7.54 NA          NA    0.258 NA    NA    NA
   8 GSM946…   34.6  NA      -23.2 34.6  NA          NA    0.624 NA    NA    NA
   9 GSM946…    7.91 NA      -49.8 12.0  NA          NA    0.237 NA    NA    NA
  10 GSM946…    4.72 NA      -48.2  6.43 NA          NA    0.396 NA    NA    NA
  11 GSM946…   29.6  NA      -39.9 28.5  NA          NA    0.413 NA    NA    NA
  12 GSM946…    1.38 NA      -48.3  3.48 NA          NA    0.122 NA    NA    NA
  13 GSM946…   56.0  NA      -26.7 47.3  NA          NA    0.714 NA    NA    NA
  14 GSM946…   24.0  NA      -39.7 23.3  NA          NA    0.676 NA    NA    NA
  15 GSM946…    9.38 NA      -45.4 11.9  NA          NA    0.251 NA    NA    NA
  16 GSM946…   38.8  NA      -27.5 41.4  NA          NA    0.599 NA    NA    NA
```

As mention in Section [3.4](#section-missingCpGs) some clocks returns NA when
there are more than 80% of the required CpGs are missing as we can see when
typing

```
missCpGs <- checkClocks(MethylationData)
```

```
          clock Cpgs_in_clock missing_CpGs percentage
  1     Horvath           353            0        0.0
  2      Hannum            71           64       90.1
  3      Levine           513            0        0.0
  4 SkinHorvath           391          282       72.1
  5       PedBE            94           91       96.8
  6          Wu           111            0        0.0
  7          TL           140          137       97.9
  8        BLUP        319607       300192       93.9
  9          EN           514          476       92.6
```

Here we can observe that 72.1% of the required CpGs for SkinHorvath clock are
missing. We could estimate DNAm age using this clock just changing the argument
`min.perc` in `DNAmAge`. For example, we can indicate that the minimum amount
of required CpGs for computing a given clock should be 25%.

```
age.example55.2 <- DNAmAge(MethylationData, min.perc = 0.25)
```

```
  Warning in predAge(cpgs.imp, coefHannum, intercept = FALSE, min.perc): The number of missing CpGs forHannumclock exceeds 25%.
    ---> This DNAm clock will be NA.
```

```
   rows : 353 cols : 16
```

```
  Warning in predAge(cpgs.imp, coefPedBE, intercept = TRUE, min.perc): The number of missing CpGs forPedBEclock exceeds 25%.
    ---> This DNAm clock will be NA.
```

```
  Warning in predAge(cpgs.imp, coefTL, intercept = TRUE, min.perc): The number of missing CpGs forTLclock exceeds 25%.
    ---> This DNAm clock will be NA.
```

```
  Warning in predAge(cpgs.imp, coefBLUP, intercept = TRUE, min.perc): The number of missing CpGs forBLUPclock exceeds 25%.
    ---> This DNAm clock will be NA.
```

```
  Warning in predAge(cpgs.imp, coefEN, intercept = TRUE, min.perc): The number of missing CpGs forENclock exceeds 25%.
    ---> This DNAm clock will be NA.
```

```
age.example55.2
```

```
  # A tibble: 16 × 11
     id      Horvath Hannum Levine   BNN skinHorvath PedBE    Wu TL    BLUP  EN
     <chr>     <dbl> <lgl>   <dbl> <dbl>       <dbl> <lgl> <dbl> <lgl> <lgl> <lgl>
   1 GSM946…   51.8  NA      -30.3 56.4         7.15 NA    1.08  NA    NA    NA
   2 GSM946…   39.8  NA      -29.6 42.1         7.09 NA    0.808 NA    NA    NA
   3 GSM946…   26.4  NA      -33.3 25.6         5.93 NA    0.772 NA    NA    NA
   4 GSM946…   34.0  NA      -36.0 28.0         6.34 NA    0.941 NA    NA    NA
   5 GSM946…   10.1  NA      -52.8 13.4         5.76 NA    0.456 NA    NA    NA
   6 GSM946…   20.4  NA      -42.2 16.7         5.79 NA    0.621 NA    NA    NA
   7 GSM946…    6.00 NA      -44.8  7.54        5.64 NA    0.258 NA    NA    NA
   8 GSM946…   34.6  NA      -23.2 34.6         5.55 NA    0.624 NA    NA    NA
   9 GSM946…    7.91 NA      -49.8 12.0         5.06 NA    0.237 NA    NA    NA
  10 GSM946…    4.72 NA      -48.2  6.43        5.48 NA    0.396 NA    NA    NA
  11 GSM946…   29.6  NA      -39.9 28.5         6.19 NA    0.413 NA    NA    NA
  12 GSM946…    1.38 NA      -48.3  3.48        4.91 NA    0.122 NA    NA    NA
  13 GSM946…   56.0  NA      -26.7 47.3         7.07 NA    0.714 NA    NA    NA
  14 GSM946…   24.0  NA      -39.7 23.3         6.23 NA    0.676 NA    NA    NA
  15 GSM946…    9.38 NA      -45.4 11.9         5.57 NA    0.251 NA    NA    NA
  16 GSM946…   38.8  NA      -27.5 41.4         6.69 NA    0.599 NA    NA    NA
```

In that case, we see as SkinHorvath clock is estimated (though it can be
observed that the estimation is not very accurate - this is why we considered
at least having 80% of the required CpGs).

By default all available clocks (Hovarth, Hannum, Levine, BNN, skinHorvath,…)
are estimated. One may select a set of clocks by using the argument `clocks`
as follows:

```
age.example55.sel <- DNAmAge(MethylationData, clocks=c("Horvath", "BNN"))
```

```
   rows : 353 cols : 16
```

```
age.example55.sel
```

```
  # A tibble: 16 × 3
     id        Horvath   BNN
     <chr>       <dbl> <dbl>
   1 GSM946048   51.8  56.4
   2 GSM946049   39.8  42.1
   3 GSM946052   26.4  25.6
   4 GSM946054   34.0  28.0
   5 GSM946055   10.1  13.4
   6 GSM946056   20.4  16.7
   7 GSM946059    6.00  7.54
   8 GSM946062   34.6  34.6
   9 GSM946064    7.91 12.0
  10 GSM946065    4.72  6.43
  11 GSM946066   29.6  28.5
  12 GSM946067    1.38  3.48
  13 GSM946073   56.0  47.3
  14 GSM946074   24.0  23.3
  15 GSM946075    9.38 11.9
  16 GSM946076   38.8  41.4
```

## 4.2 Age acceleration

However, in epidemiological studies one is interested in assessing whether age
acceleration is associated with a given trait or condition. Three different
measures can be computed:

* **ageAcc**: Difference between DNAmAge and chronological age.
* **ageAcc2**: Residuals obtained after regressing chronological age and
  DNAmAge (similar to IEAA).
* **ageAcc3**: Residuals obtained after regressing chronological age and
  DNAmAge adjusted for cell counts (similar to EEAA).

All this estimates can be obtained for each clock when providing chronological
age through `age` argument. This information is normally provided in a
different file including different covariates (metadata or sample annotation
data). In this example data are available at ‘SampleAnnotationExample55.csv’
file that is also available at `methylclock` package:

```
library(tidyverse)
path <- system.file("extdata", package = "methylclock")
covariates <- read_csv(file.path(path, "SampleAnnotationExample55.csv"))
covariates
```

```
  # A tibble: 16 × 14
     OriginalOrder id      title geo_accession TissueDetailed Tissue diseaseStatus
             <dbl> <chr>   <chr> <chr>         <chr>          <chr>          <dbl>
   1             3 GSM946… Auti… GSM946048     Fresh frozen … occip…             1
   2             4 GSM946… Cont… GSM946049     Fresh frozen … occip…             0
   3             7 GSM946… Auti… GSM946052     Fresh frozen … occip…             1
   4             9 GSM946… Auti… GSM946054     Fresh frozen … occip…             1
   5            10 GSM946… Auti… GSM946055     Fresh frozen … occip…             1
   6            11 GSM946… Auti… GSM946056     Fresh frozen … occip…             1
   7            14 GSM946… Cont… GSM946059     Fresh frozen … occip…             0
   8            17 GSM946… Cont… GSM946062     Fresh frozen … occip…             0
   9            19 GSM946… Auti… GSM946064     Fresh frozen … occip…             1
  10            20 GSM946… Auti… GSM946065     Fresh frozen … occip…             1
  11            21 GSM946… Auti… GSM946066     Fresh frozen … occip…             1
  12            22 GSM946… Cont… GSM946067     Fresh frozen … occip…             0
  13            28 GSM946… Cont… GSM946073     Fresh frozen … occip…             0
  14            29 GSM946… Cont… GSM946074     Fresh frozen … occip…             0
  15            30 GSM946… Cont… GSM946075     Fresh frozen … occip…             0
  16            31 GSM946… Cont… GSM946076     Fresh frozen … occip…             0
  # ℹ 7 more variables: Age <dbl>, PostMortemInterval <dbl>, CauseofDeath <chr>,
  #   individual <dbl>, Female <dbl>, Caucasian <lgl>, FemaleOriginal <lgl>
```

In this case, chronological age is available at `Age` column:

```
age <- covariates$Age
head(age)
```

```
  [1] 60 39 28 39  8 22
```

The different methylation clocks along with their age accelerated estimates
can be simply computed by:

```
age.example55 <- DNAmAge(MethylationData, age=age, cell.count=TRUE)
```

```
  Warning in predAge(cpgs.imp, coefHannum, intercept = FALSE, min.perc): The number of missing CpGs forHannumclock exceeds 80%.
    ---> This DNAm clock will be NA.
```

```
   rows : 353 cols : 16
```

```
  Warning in predAge(cpgs.imp, coefSkin, intercept = TRUE, min.perc): The number of missing CpGs forSkinclock exceeds 80%.
    ---> This DNAm clock will be NA.
```

```
  Warning in predAge(cpgs.imp, coefPedBE, intercept = TRUE, min.perc): The number of missing CpGs forPedBEclock exceeds 80%.
    ---> This DNAm clock will be NA.
```

```
  Warning in predAge(cpgs.imp, coefTL, intercept = TRUE, min.perc): The number of missing CpGs forTLclock exceeds 80%.
    ---> This DNAm clock will be NA.
```

```
  Warning in predAge(cpgs.imp, coefBLUP, intercept = TRUE, min.perc): The number of missing CpGs forBLUPclock exceeds 80%.
    ---> This DNAm clock will be NA.
```

```
  Warning in predAge(cpgs.imp, coefEN, intercept = TRUE, min.perc): The number of missing CpGs forENclock exceeds 80%.
    ---> This DNAm clock will be NA.
```

```
age.example55
```

```
  # A tibble: 16 × 24
     id       Horvath ageAcc.Horvath ageAcc2.Horvath ageAcc3.Horvath Hannum Levine
     <chr>      <dbl>          <dbl>           <dbl>           <dbl> <lgl>   <dbl>
   1 GSM9460…   51.8          -8.22          -4.45            -4.91  NA      -30.3
   2 GSM9460…   39.8           0.754          2.00             1.59  NA      -29.6
   3 GSM9460…   26.4          -1.59          -1.67            -1.86  NA      -33.3
   4 GSM9460…   34.0          -5.00          -3.76            -0.463 NA      -36.0
   5 GSM9460…   10.1           2.06          -0.428            2.82  NA      -52.8
   6 GSM9460…   20.4          -1.61          -2.42            -2.88  NA      -42.2
   7 GSM9460…    6.00          2.00          -0.971           -0.827 NA      -44.8
   8 GSM9460…   34.6           6.65           6.57             5.32  NA      -23.2
   9 GSM9460…    7.91          2.91           0.0589          -2.61  NA      -49.8
  10 GSM9460…    4.72          2.72          -0.489            1.46  NA      -48.2
  11 GSM9460…   29.6          -0.427         -0.268           -1.37  NA      -39.9
  12 GSM9460…    1.38          0.375         -2.95            -2.19  NA      -48.3
  13 GSM9460…   56.0          -4.01          -0.242            1.62  NA      -26.7
  14 GSM9460…   24.0           2.03           1.23            -0.669 NA      -39.7
  15 GSM9460…    9.38          1.38          -1.11            -0.885 NA      -45.4
  16 GSM9460…   38.8           8.76           8.92             5.85  NA      -27.5
  # ℹ 17 more variables: ageAcc.Levine <dbl>, ageAcc2.Levine <dbl>,
  #   ageAcc3.Levine <dbl>, BNN <dbl>, ageAcc.BNN <dbl>, ageAcc2.BNN <dbl>,
  #   ageAcc3.BNN <dbl>, skinHorvath <lgl>, PedBE <lgl>, Wu <dbl>,
  #   ageAcc.Wu <dbl>, ageAcc2.Wu <dbl>, ageAcc3.Wu <dbl>, TL <lgl>, BLUP <lgl>,
  #   EN <lgl>, age <dbl>
```

By default, the argument `cell.count` is set equal to TRUE and, hence, can
be omitted. This implies that `ageAcc3` will be computed for all clocks.
In some occassions this can be very time consuming. In such cases one can
simply estimate DNAmAge, accAge and accAge2 by setting `cell.count=FALSE`.
NOTE: see section 3.5 to see the reference panels available to estimate
cell counts.

Then, we can investigate, for instance, whether the accelerated age is
associated with Autism. In that example we will use a non-parametric
test (NOTE: use t-test or linear regression for large sample sizes)

```
autism <- covariates$diseaseStatus
kruskal.test(age.example55$ageAcc.Horvath ~ autism)
```

```
    Kruskal-Wallis rank sum test

  data:  age.example55$ageAcc.Horvath by autism
  Kruskal-Wallis chi-squared = 1.3346, df = 1, p-value = 0.248
```

```
kruskal.test(age.example55$ageAcc2.Horvath ~ autism)
```

```
    Kruskal-Wallis rank sum test

  data:  age.example55$ageAcc2.Horvath by autism
  Kruskal-Wallis chi-squared = 3.1875, df = 1, p-value = 0.0742
```

```
kruskal.test(age.example55$ageAcc3.Horvath ~ autism)
```

```
    Kruskal-Wallis rank sum test

  data:  age.example55$ageAcc3.Horvath by autism
  Kruskal-Wallis chi-squared = 2.8235, df = 1, p-value = 0.09289
```

## 4.3 Chronological age prediction using `ExpressionSet` data

One may be interested in assessing association between chronologial age and DNA
methylation age or evaluating how well chronological age is predicted by
DNAmAge. In order to illustrate this analysis we downloaded data from GEO
corresponding to a set of healthy individuals (GEO accession number GSE58045).
Data can be retrieved into R by using `GEOquery` package as an `ExpressionSet`
object that can be the input of our main function.

```
# To avoid connection buffer size
Sys.setenv("VROOM_CONNECTION_SIZE" = 131072 * 10)

# Download data
dd <- GEOquery::getGEO("GSE58045")
gse58045 <- dd[[1]]

# Restore connection buffer size
Sys.setenv("VROOM_CONNECTION_SIZE" = 131072)
```

```
gse58045
```

```
  ExpressionSet (storageMode: lockedEnvironment)
  assayData: 27578 features, 172 samples
    element names: exprs
  protocolData: none
  phenoData
    sampleNames: GSM1399890 GSM1399891 ... GSM1400061 (172 total)
    varLabels: title geo_accession ... twin:ch1 (43 total)
    varMetadata: labelDescription
  featureData
    featureNames: cg00000292 cg00002426 ... cg27665659 (27578 total)
    fvarLabels: ID Name ... ORF (38 total)
    fvarMetadata: Column Description labelDescription
  experimentData: use 'experimentData(object)'
    pubMedIds: 22532803
  Annotation: GPL8490
```

The chronological age is obtained by using `pData` function from `Biobase`
package that is able to deal with `ExpressionSet` objects:

```
pheno <- pData(gse58045)
age <- as.numeric(pheno$`age:ch1`)
```

And the different DNA methylation age estimates are obtained by using `DNAmAge`
function (NOTE: as there are missing values, the program automatically runs
`impute.knn` function to get complete cases):

```
age.gse58045 <- DNAmAge(gse58045, age=age)
```

```
  Imputing missing data of the entire matrix ....
  Data imputed. Starting DNAm clock estimation ...
```

```
  Warning in predAge(cpgs.imp, coefHannum, intercept = FALSE, min.perc): The number of missing CpGs forHannumclock exceeds 80%.
    ---> This DNAm clock will be NA.
```

```
   rows : 353 cols : 172
```

```
  Warning in predAge(cpgs.imp, coefSkin, intercept = TRUE, min.perc): The number of missing CpGs forSkinclock exceeds 80%.
    ---> This DNAm clock will be NA.
```

```
  Warning in predAge(cpgs.imp, coefPedBE, intercept = TRUE, min.perc): The number of missing CpGs forPedBEclock exceeds 80%.
    ---> This DNAm clock will be NA.
```

```
  Warning in predAge(cpgs.imp, coefTL, intercept = TRUE, min.perc): The number of missing CpGs forTLclock exceeds 80%.
    ---> This DNAm clock will be NA.
```

```
  Warning in predAge(cpgs.imp, coefBLUP, intercept = TRUE, min.perc): The number of missing CpGs forBLUPclock exceeds 80%.
    ---> This DNAm clock will be NA.
```

```
  Warning in predAge(cpgs.imp, coefEN, intercept = TRUE, min.perc): The number of missing CpGs forENclock exceeds 80%.
    ---> This DNAm clock will be NA.
```

```
age.gse58045
```

```
  # A tibble: 172 × 24
     id       Horvath ageAcc.Horvath ageAcc2.Horvath ageAcc3.Horvath Hannum Levine
     <chr>      <dbl>          <dbl>           <dbl>           <dbl> <lgl>   <dbl>
   1 GSM1399…    65.6          1.07            4.58            5.46  NA       50.7
   2 GSM1399…    66.3          0.197           4.06            5.06  NA       51.3
   3 GSM1399…    53.9         -5.31           -2.98           -2.42  NA       40.5
   4 GSM1399…    40.6         -5.23           -5.89           -6.14  NA       31.3
   5 GSM1399…    50.1          0.982           1.06            1.28  NA       41.1
   6 GSM1399…    63.7         -0.895           2.64            2.92  NA       48.1
   7 GSM1399…    44.7         -0.875          -1.59           -1.76  NA       29.2
   8 GSM1399…    59.7         -8.55           -4.20           -3.48  NA       41.0
   9 GSM1399…    48.4         -5.84           -4.63           -2.50  NA       43.8
  10 GSM1399…    59.3         -3.93           -0.719          -0.609 NA       46.1
  # ℹ 162 more rows
  # ℹ 17 more variables: ageAcc.Levine <dbl>, ageAcc2.Levine <dbl>,
  #   ageAcc3.Levine <dbl>, BNN <dbl>, ageAcc.BNN <dbl>, ageAcc2.BNN <dbl>,
  #   ageAcc3.BNN <dbl>, skinHorvath <lgl>, PedBE <lgl>, Wu <dbl>,
  #   ageAcc.Wu <dbl>, ageAcc2.Wu <dbl>, ageAcc3.Wu <dbl>, TL <lgl>, BLUP <lgl>,
  #   EN <lgl>, age <dbl>
```

Figure shows the correlation between DNAmAge obtained
from Horvath’s method and the chronological age, while Figure
depicts the correlation of a new method based on fitting a Bayesian Neural
Network to predict DNAmAge based on Horvath’s CpGs.

```
plotDNAmAge(age.gse58045$Horvath, age)
```

![](data:image/png;base64...)

```
plotDNAmAge(age.gse58045$BNN, age, tit="Bayesian Neural Network")
```

![](data:image/png;base64...)

## 4.4 Use of DNAmAge in association studies

Let us illustrate how to use DNAmAge information in association studies
(e.g case/control, smokers/non-smokers, responders/non-responders, …).
GEO number GSE19711 contains transcriptomic and epigenomic data of a study
in lung cancer. Data can be retrieved into R by

```
# To avoid connection buffer size
Sys.setenv("VROOM_CONNECTION_SIZE" = 131072 * 10)

# Download data
dd <- GEOquery::getGEO("GSE19711")
gse19711 <- dd[[1]]

# Restore connection buffer size
Sys.setenv("VROOM_CONNECTION_SIZE" = 131072)
```

The object `gse19711`is an `ExpressionSet` that can contains CpGs and
phenotypic (e.g clinical) information

```
gse19711
```

```
  ExpressionSet (storageMode: lockedEnvironment)
  assayData: 27578 features, 540 samples
    element names: exprs
  protocolData: none
  phenoData
    sampleNames: GSM491937 GSM491938 ... GSM492476 (540 total)
    varLabels: title geo_accession ... stage:ch1 (58 total)
    varMetadata: labelDescription
  featureData
    featureNames: cg00000292 cg00002426 ... cg27665659 (27578 total)
    fvarLabels: ID Name ... ORF (38 total)
    fvarMetadata: Column Description labelDescription
  experimentData: use 'experimentData(object)'
    pubMedIds: 20219944
  Annotation: GPL8490
```

Let us imagine we are interested in comparing the accelerated age between
cases and controls. Age and case/control status information can be obtained by:

```
pheno <- pData(gse19711)
age <- as.numeric(pheno$`ageatrecruitment:ch1`)
disease <- pheno$`sample type:ch1`
table(disease)
```

```
  disease
     bi-sulphite converted genomic whole blood DNA from Case
                                                         266
  bi-sulphite converted genomic whole blood DNA from Control
                                                         274
```

```
disease[grep("Control", disease)] <- "Control"
disease[grep("Case", disease)] <- "Case"
disease <- factor(disease, levels=c("Control", "Case"))
table(disease)
```

```
  disease
  Control    Case
      274     266
```

The DNAmAge estimates of different methods is computed by

```
age.gse19711 <- DNAmAge(gse19711, age=age)
```

```
  Imputing missing data of the entire matrix ....
  Data imputed. Starting DNAm clock estimation ...
```

```
  Warning in predAge(cpgs.imp, coefHannum, intercept = FALSE, min.perc): The number of missing CpGs forHannumclock exceeds 80%.
    ---> This DNAm clock will be NA.
```

```
   rows : 353 cols : 540
```

```
  Warning in predAge(cpgs.imp, coefSkin, intercept = TRUE, min.perc): The number of missing CpGs forSkinclock exceeds 80%.
    ---> This DNAm clock will be NA.
```

```
  Warning in predAge(cpgs.imp, coefPedBE, intercept = TRUE, min.perc): The number of missing CpGs forPedBEclock exceeds 80%.
    ---> This DNAm clock will be NA.
```

```
  Warning in predAge(cpgs.imp, coefTL, intercept = TRUE, min.perc): The number of missing CpGs forTLclock exceeds 80%.
    ---> This DNAm clock will be NA.
```

```
  Warning in predAge(cpgs.imp, coefBLUP, intercept = TRUE, min.perc): The number of missing CpGs forBLUPclock exceeds 80%.
    ---> This DNAm clock will be NA.
```

```
  Warning in predAge(cpgs.imp, coefEN, intercept = TRUE, min.perc): The number of missing CpGs forENclock exceeds 80%.
    ---> This DNAm clock will be NA.
```

We can observe there are missing data. The funcion automatically impute those
using `impute.knn` function from `impute` package since complete cases are
required to compute the different methylation clocks. The estimates are:

```
age.gse19711
```

```
  # A tibble: 540 × 24
     id       Horvath ageAcc.Horvath ageAcc2.Horvath ageAcc3.Horvath Hannum Levine
     <chr>      <dbl>          <dbl>           <dbl>           <dbl> <lgl>   <dbl>
   1 GSM4919…    62.9          -5.14          -0.351          -1.10  NA       61.1
   2 GSM4919…    68.8         -12.2           -2.85           -2.13  NA       57.0
   3 GSM4919…    60.0           3.96           4.54            4.37  NA       43.0
   4 GSM4919…    57.9          -4.13          -1.45           -1.38  NA       40.9
   5 GSM4919…    59.0         -13.0           -6.79           -6.98  NA       57.0
   6 GSM4919…    57.0          -4.00          -1.66           -1.09  NA       44.7
   7 GSM4919…    61.9          -3.08           0.657           0.183 NA       47.9
   8 GSM4919…    59.1         -11.9           -6.07           -5.53  NA       50.0
   9 GSM4919…    60.7         -16.3           -8.33           -9.33  NA       47.7
  10 GSM4919…    51.1          -7.93          -6.30           -6.33  NA       52.5
  # ℹ 530 more rows
  # ℹ 17 more variables: ageAcc.Levine <dbl>, ageAcc2.Levine <dbl>,
  #   ageAcc3.Levine <dbl>, BNN <dbl>, ageAcc.BNN <dbl>, ageAcc2.BNN <dbl>,
  #   ageAcc3.BNN <dbl>, skinHorvath <lgl>, PedBE <lgl>, Wu <dbl>,
  #   ageAcc.Wu <dbl>, ageAcc2.Wu <dbl>, ageAcc3.Wu <dbl>, TL <lgl>, BLUP <lgl>,
  #   EN <lgl>, age <dbl>
```

The association between disease status and DNAmAge estimated using Horvath’s
method can be computed by

```
mod.horvath1 <- glm(disease ~ ageAcc.Horvath ,
                    data=age.gse19711,
                    family="binomial")
summary(mod.horvath1)
```

```
  Call:
  glm(formula = disease ~ ageAcc.Horvath, family = "binomial",
      data = age.gse19711)

  Coefficients:
                 Estimate Std. Error z value Pr(>|z|)
  (Intercept)    -0.10995    0.09771  -1.125   0.2605
  ageAcc.Horvath -0.02023    0.01154  -1.753   0.0795 .
  ---
  Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

  (Dispersion parameter for binomial family taken to be 1)

      Null deviance: 748.48  on 539  degrees of freedom
  Residual deviance: 745.25  on 538  degrees of freedom
  AIC: 749.25

  Number of Fisher Scoring iterations: 4
```

```
mod.skinHorvath <- glm(disease ~ ageAcc2.Horvath ,
                       data=age.gse19711,
                       family="binomial")
summary(mod.skinHorvath)
```

```
  Call:
  glm(formula = disease ~ ageAcc2.Horvath, family = "binomial",
      data = age.gse19711)

  Coefficients:
                  Estimate Std. Error z value Pr(>|z|)
  (Intercept)     -0.02970    0.08617  -0.345    0.730
  ageAcc2.Horvath -0.01315    0.01209  -1.087    0.277

  (Dispersion parameter for binomial family taken to be 1)

      Null deviance: 748.48  on 539  degrees of freedom
  Residual deviance: 747.27  on 538  degrees of freedom
  AIC: 751.27

  Number of Fisher Scoring iterations: 3
```

```
mod.horvath3 <- glm(disease ~ ageAcc3.Horvath ,
                    data=age.gse19711,
                    family="binomial")
summary(mod.horvath3)
```

```
  Call:
  glm(formula = disease ~ ageAcc3.Horvath, family = "binomial",
      data = age.gse19711)

  Coefficients:
                  Estimate Std. Error z value Pr(>|z|)
  (Intercept)     -0.02993    0.08626  -0.347    0.729
  ageAcc3.Horvath -0.01927    0.01283  -1.502    0.133

  (Dispersion parameter for binomial family taken to be 1)

      Null deviance: 748.48  on 539  degrees of freedom
  Residual deviance: 746.13  on 538  degrees of freedom
  AIC: 750.13

  Number of Fisher Scoring iterations: 4
```

We do not observe statistical significant association between age acceleration
estimated using Horvath method and the risk of developing lung cancer. It is
worth to notice that Horvath’s clock was created to predict chronological age
and the impact of age acceleration of this clock on disease may be limited.
On the other hand, Levine’s clock aimed to distinguish risk between same-aged
individuals. Let us evaluate whether this age acceleration usin Levine’s clock
is associated with lung cancer

```
mod.levine1 <- glm(disease ~ ageAcc.Levine , data=age.gse19711,
                    family="binomial")
summary(mod.levine1)
```

```
  Call:
  glm(formula = disease ~ ageAcc.Levine, family = "binomial", data = age.gse19711)

  Coefficients:
                Estimate Std. Error z value Pr(>|z|)
  (Intercept)    0.40956    0.17894   2.289  0.02209 *
  ageAcc.Levine  0.03178    0.01133   2.806  0.00502 **
  ---
  Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

  (Dispersion parameter for binomial family taken to be 1)

      Null deviance: 748.48  on 539  degrees of freedom
  Residual deviance: 740.17  on 538  degrees of freedom
  AIC: 744.17

  Number of Fisher Scoring iterations: 4
```

```
mod.levine2 <- glm(disease ~ ageAcc2.Levine , data=age.gse19711,
                    family="binomial")
summary(mod.levine2)
```

```
  Call:
  glm(formula = disease ~ ageAcc2.Levine, family = "binomial",
      data = age.gse19711)

  Coefficients:
                 Estimate Std. Error z value Pr(>|z|)
  (Intercept)    -0.02925    0.08718  -0.336 0.737225
  ageAcc2.Levine  0.04430    0.01234   3.589 0.000332 ***
  ---
  Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

  (Dispersion parameter for binomial family taken to be 1)

      Null deviance: 748.48  on 539  degrees of freedom
  Residual deviance: 734.49  on 538  degrees of freedom
  AIC: 738.49

  Number of Fisher Scoring iterations: 4
```

```
mod.levine3 <- glm(disease ~ ageAcc3.Levine , data=age.gse19711,
                    family="binomial")
summary(mod.levine3)
```

```
  Call:
  glm(formula = disease ~ ageAcc3.Levine, family = "binomial",
      data = age.gse19711)

  Coefficients:
                 Estimate Std. Error z value Pr(>|z|)
  (Intercept)    -0.02962    0.08622  -0.344    0.731
  ageAcc3.Levine  0.01679    0.01244   1.350    0.177

  (Dispersion parameter for binomial family taken to be 1)

      Null deviance: 748.48  on 539  degrees of freedom
  Residual deviance: 746.62  on 538  degrees of freedom
  AIC: 750.62

  Number of Fisher Scoring iterations: 3
```

Here we observe as the risk of developing lung cancer increases
3.23 percent per each unit in the
age accelerated variable (`ageAcc`). Similar conclusion is obtained when using
`ageAcc2` and `ageAcc3` variables.

In some occasions cell composition should be used to assess association. This
information is calculated in `DNAmAge` function and it can be incorporated in
the model by:

```
cell <- attr(age.gse19711, "cell_proportion")
mod.cell <- glm(disease ~ ageAcc.Levine + cell, data=age.gse19711,
                    family="binomial")
summary(mod.cell)
```

```
  Call:
  glm(formula = disease ~ ageAcc.Levine + cell, family = "binomial",
      data = age.gse19711)

  Coefficients:
                 Estimate Std. Error z value Pr(>|z|)
  (Intercept)   -9.768206   4.380382  -2.230 0.025748 *
  ageAcc.Levine  0.003959   0.012208   0.324 0.745746
  cellCD4T      -3.339693   3.833531  -0.871 0.383656
  cellMono      10.165096   4.594096   2.213 0.026922 *
  cellNeu       16.319534   4.584745   3.560 0.000372 ***
  cellNK        -0.882134   4.296498  -0.205 0.837326
  ---
  Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

  (Dispersion parameter for binomial family taken to be 1)

      Null deviance: 748.48  on 539  degrees of freedom
  Residual deviance: 686.56  on 534  degrees of freedom
  AIC: 698.56

  Number of Fisher Scoring iterations: 4
```

Here we observe as the positive association disapears after adjusting
for cell counts.

## 4.5 Use of DNAm age in children

```
dd <- GEOquery::getGEO("GSE109446")
gse109446 <- dd[[1]]
```

```
controls <- pData(gse109446)$`diagnosis:ch1`=="control"
gse <- gse109446[,controls]
age <- as.numeric(pData(gse)$`age:ch1`)
age.gse <- DNAmAge(gse, age=age)
```

```
   rows : 353 cols : 29
```

```
plotCorClocks(age.gse)
```

![](data:image/png;base64...)

# 5 Gestational DNAm age estimation

## 5.1 Model predicion

Let us start by reproducing the example provided in Knight et al. ([2016](#ref-knight2016epigenetic)) as
a test data set (file ‘TestDataset.csv’). It consists on 3 individuals whose
methylation data are available as supplementary data of their paper. The data
is also available at `methylclock` package as a data frame.

```
TestDataset[1:5,]
```

```
       CpGName    Sample1    Sample2    Sample3
  1 cg00000292 0.72546496 0.72350947 0.69023377
  2 cg00002426 0.85091763 0.80077888 0.80385777
  3 cg00003994 0.05125853 0.05943935 0.05559333
  4 cg00005847 0.08775420 0.11722333 0.10845113
  5 cg00006414 0.03982478 0.06146891 0.03491992
```

The Gestational Age (in months) is simply computed by

```
ga.test <- DNAmGA(TestDataset)
```

```
  Warning in DNAmGA(TestDataset): CpGs in all Gestational Age clocks are not present in your
          data. Try 'checkClocksGA' function to find the missing CpGs of
                  each method.
```

```
  Warning in predAge(cpgs.imp, coefBohlin, intercept = TRUE, min.perc): The number of missing CpGs forBohlinclock exceeds 80%.
    ---> This DNAm clock will be NA.
```

```
  Warning in predAge(cpgs.imp, coefEPIC, intercept = TRUE, min.perc): The number of missing CpGs forEPICclock exceeds 80%.
    ---> This DNAm clock will be NA.
```

```
  Warning in DNAmGA(TestDataset): The number of missing CpGs for Lee clocks exceeds 80%.

    ---> This DNAm clock will be NA.
```

```
ga.test
```

```
  # A tibble: 3 × 6
    id      Knight Bohlin Mayne EPIC  Lee
    <chr>    <dbl>  <dbl> <dbl> <lgl> <lgl>
  1 Sample1   38.2     NA  35.8 NA    NA
  2 Sample2   38.8     NA  36.5 NA    NA
  3 Sample3   40.0     NA  36.6 NA    NA
```

like in DNAmAge we can use the parameter `min.perc` to set the minimum missing
percentage.

The results are the same as those described in the additional file 7
of Knight et al. ([2016](#ref-knight2016epigenetic)) (link [here]
([https://static-content.springer.com/esm/art%3A10.1186%2Fs13059-016-1068-z/MediaObjects/13059\_2016\_1068\_MOESM7\_ESM.docx](https://static-content.springer.com/esm/art%3A10.1186/s13059-016-1068-z/MediaObjects/13059_2016_1068_MOESM7_ESM.docx)))

Let us continue by illustrating how to compute GA of real examples.
The PROGRESS cohort data is available in the additional file 8 of
Knight et al. ([2016](#ref-knight2016epigenetic)). It is available at `methylclock` as a `tibble`:

```
data(progress_data)
```

This file also contains different variables that are available in this
`tibble`.

```
data(progress_vars)
```

The Clinical Variables including clinical assesment of gestational age
(EGA) are available at this `tibble`.

The Gestational Age (in months) is simply computed by

```
ga.progress <- DNAmGA(progress_data)
```

```
  Warning in DNAmGA(progress_data): CpGs in all Gestational Age clocks are not present in your
          data. Try 'checkClocksGA' function to find the missing CpGs of
                  each method.
```

```
  Warning in predAge(cpgs.imp, coefBohlin, intercept = TRUE, min.perc): The number of missing CpGs forBohlinclock exceeds 80%.
    ---> This DNAm clock will be NA.
```

```
  Warning in predAge(cpgs.imp, coefMayneGA, intercept = TRUE, min.perc): The number of missing CpGs forMayneclock exceeds 80%.
    ---> This DNAm clock will be NA.
```

```
  Warning in predAge(cpgs.imp, coefEPIC, intercept = TRUE, min.perc): The number of missing CpGs forEPICclock exceeds 80%.
    ---> This DNAm clock will be NA.
```

```
  Warning in DNAmGA(progress_data): The number of missing CpGs for Lee clocks exceeds 80%.

    ---> This DNAm clock will be NA.
```

```
ga.progress
```

```
  # A tibble: 150 × 6
     id    Knight Bohlin Mayne EPIC  Lee
     <chr>  <dbl>  <dbl> <lgl> <lgl> <lgl>
   1 784     38.8     NA NA    NA    NA
   2 1052    37.2     NA NA    NA    NA
   3 1048    40.3     NA NA    NA    NA
   4 1017    39.2     NA NA    NA    NA
   5 956     38.9     NA NA    NA    NA
   6 1038    39.2     NA NA    NA    NA
   7 989     37.2     NA NA    NA    NA
   8 946     35.4     NA NA    NA    NA
   9 941     33.5     NA NA    NA    NA
  10 1024    37.4     NA NA    NA    NA
  # ℹ 140 more rows
```

We can compare these results with the clinical GA available in the variable EGA

```
plotDNAmAge(ga.progress$Knight, progress_vars$EGA,
            tit="GA Knight's method",
            clock="GA")
```

![](data:image/png;base64...)

Figure 3b (only for PROGRESS dataset) in Knight et al. ([2016](#ref-knight2016epigenetic)) representing
the correlation between GA acceleration and birthweight can be reproduced by

```
library(ggplot2)
progress_vars$acc <- ga.progress$Knight - progress_vars$EGA
p <- ggplot(data=progress_vars, aes(x = acc, y = birthweight)) +
    geom_point() +
    geom_smooth(method = "lm", se=FALSE, color="black") +
    xlab("GA acceleration") +
    ylab("Birthweight (kgs.)")
p
```

![](data:image/png;base64...)

Finally, we can also estimate the “accelerated gestational age” using two
of the the three different estimates previously described (`accAge`, `accAge2`)
by provinding information of gestational age through `age` argument. Notice
that in that case `accAge3` cannot be estimates since we do not have all the
CpGs required by the default reference panel to estimate cell counts for
gestational age which is “andrews and bakulski cord blood”.

```
accga.progress <- DNAmGA(progress_data,
                        age = progress_vars$EGA,
                        cell.count=FALSE)
```

```
  Warning in DNAmGA(progress_data, age = progress_vars$EGA, cell.count = FALSE): CpGs in all Gestational Age clocks are not present in your
          data. Try 'checkClocksGA' function to find the missing CpGs of
                  each method.
```

```
  Warning in predAge(cpgs.imp, coefBohlin, intercept = TRUE, min.perc): The number of missing CpGs forBohlinclock exceeds 80%.
    ---> This DNAm clock will be NA.
```

```
  Warning in predAge(cpgs.imp, coefMayneGA, intercept = TRUE, min.perc): The number of missing CpGs forMayneclock exceeds 80%.
    ---> This DNAm clock will be NA.
```

```
  Warning in predAge(cpgs.imp, coefEPIC, intercept = TRUE, min.perc): The number of missing CpGs forEPICclock exceeds 80%.
    ---> This DNAm clock will be NA.
```

```
  Warning in DNAmGA(progress_data, age = progress_vars$EGA, cell.count = FALSE): The number of missing CpGs for Lee clocks exceeds 80%.

    ---> This DNAm clock will be NA.
```

```
accga.progress
```

```
  # A tibble: 150 × 9
     id    Knight ageAcc.Knight ageAcc2.Knight Bohlin Mayne EPIC  Lee     age
     <chr>  <dbl>         <dbl>          <dbl>  <dbl> <lgl> <lgl> <lgl> <dbl>
   1 784     38.8         0.792          1.27      NA NA    NA    NA     38
   2 1052    37.2        -1.05          -0.488     NA NA    NA    NA     38.3
   3 1048    40.3         2.29           2.77      NA NA    NA    NA     38
   4 1017    39.2         0.643          1.28      NA NA    NA    NA     38.6
   5 956     38.9         1.75           1.99      NA NA    NA    NA     37.1
   6 1038    39.2         1.09           1.61      NA NA    NA    NA     38.1
   7 989     37.2        -0.774         -0.292     NA NA    NA    NA     38
   8 946     35.4        -2.36          -1.96      NA NA    NA    NA     37.7
   9 941     33.5        -3.18          -3.06      NA NA    NA    NA     36.7
  10 1024    37.4        -1.12          -0.486     NA NA    NA    NA     38.6
  # ℹ 140 more rows
```

One can also check which clocks can be estimated given the CpGs available
in the methylation data by

```
checkClocksGA(progress_data)
```

```
     clock Cpgs_in_clock missing_CpGs percentage
  1 Knight           148            0        0.0
  2 Bohlin            94           94      100.0
  3  Mayne            62           61       98.4
  4    Lee          1125         1125      100.0
  5   EPIC           176          176      100.0
```

# 6 Correlation among DNAm clocks

We can compute the correlation among biological clocks using the function
`plotCorClocks` that requires the package `ggplot2` and `ggpubr` to be
installed in your computer.

We can obtain, for instance, the correlation among the clocks estimated for
the healthy individuals study previosuly analyze (GEO accession number
GSE58045) by simply executing:

```
plotCorClocks(age.gse58045)
```

![](data:image/png;base64...)

# 7 References

Alfonso, Gerardo, and Juan R Gonzalez. 2020. “Bayesian Neural Networks Improve Methylation Age Estimates.” *bioRxiv*.

Bohlin, Jon, Siri Eldevik Håberg, Per Magnus, Sarah E Reese, Håkon K Gjessing, Maria Christine Magnus, Christine Louise Parr, CM Page, Stephanie J London, and Wenche Nystad. 2016. “Prediction of Gestational Age Based on Genome-Wide Differentially Methylated Regions.” *Genome Biology* 17 (1): 207.

Chen, Wei, Ting Wang, Maria Pino-Yanes, Erick Forno, Liming Liang, Qi Yan, Donglei Hu, et al. 2017. “An Epigenome-Wide Association Study of Total Serum Ige in Hispanic Children.” *Journal of Allergy and Clinical Immunology* 140 (2): 571–77.

Guintivano, Jerry, Martin J Aryee, and Zachary A Kaminsky. 2013. “A Cell Epigenotype Specific Model for the Correction of Brain Cellular Heterogeneity Bias and Its Application to Age, Brain Region and Major Depression.” *Epigenetics* 8 (3): 290–302.

Haftorn, Kristine L, Yunsung Lee, William RP Denault, Christian M Page, Haakon E Nustad, Robert Lyle, Håkon K Gjessing, et al. 2021. “An Epic Predictor of Gestational Age and Its Application to Newborns Conceived by Assisted Reproductive Technologies.” *Clinical Epigenetics* 13 (1): 1–13.

Hannum, Gregory, Justin Guinney, Ling Zhao, Li Zhang, Guy Hughes, SriniVas Sadda, Brandy Klotzle, et al. 2013. “Genome-Wide Methylation Profiles Reveal Quantitative Views of Human Aging Rates.” *Molecular Cell* 49 (2): 359–67.

Horvath, Steve. 2013. “DNA Methylation Age of Human Tissues and Cell Types.” *Genome Biology* 14 (10): 3156.

Horvath, Steve, Junko Oshima, George M Martin, Ake T Lu, Austin Quach, Howard Cohen, Sarah Felton, et al. 2018. “Epigenetic Clock for Skin and Blood Cells Applied to Hutchinson Gilford Progeria Syndrome and Ex Vivo Studies.” *Aging (Albany NY)* 10 (7): 1758.

Knight, Anna K, Jeffrey M Craig, Christiane Theda, Marie Bækvad-Hansen, Jonas Bybjerg-Grauholm, Christine S Hansen, Mads V Hollegaard, et al. 2016. “An Epigenetic Clock for Gestational Age at Birth Based on Blood Methylation Data.” *Genome Biology* 17 (1): 206.

Lee, Yunsung, Sanaa Choufani, Rosanna Weksberg, Samantha L Wilson, Victor Yuan, Amber Burt, Carmen Marsit, et al. 2019. “Placental Epigenetic Clocks: Estimating Gestational Age Using Placental Dna Methylation Levels.” *Aging (Albany NY)* 11 (12): 4238.

Levine, Morgan E, Ake T Lu, Austin Quach, Brian H Chen, Themistocles L Assimes, Stefania Bandinelli, Lifang Hou, et al. 2018. “An Epigenetic Biomarker of Aging for Lifespan and Healthspan.” *Aging (Albany NY)* 10 (4): 573.

Lu, Ake T, Anne Seeboth, Pei-Chien Tsai, Dianjianyi Sun, Austin Quach, Alex P Reiner, Charles Kooperberg, et al. 2019. “DNA Methylation-Based Estimator of Telomere Length.” *Aging (Albany NY)* 11 (16): 5895.

Mayne, Benjamin T, Shalem Y Leemaqz, Alicia K Smith, James Breen, Claire T Roberts, and Tina Bianco-Miotto. 2017. “Accelerated Placental Aging in Early Onset Preeclampsia Pregnancies Identified by Dna Methylation.” *Epigenomics* 9 (3): 279–89.

McEwen, Lisa M, Kieran J O?Donnell, Megan G McGill, Rachel D Edgar, Meaghan J Jones, Julia L MacIsaac, David Tse Shen Lin, et al. 2019. “The Pedbe Clock Accurately Estimates Dna Methylation Age in Pediatric Buccal Cells.” *Proceedings of the National Academy of Sciences*, 201820843.

Min, JL, G Hemani, G Davey Smith, C Relton, M Suderman, and John Hancock. 2018. “Meffil: Efficient Normalization and Analysis of Very Large Dna Methylation Datasets.” *Bioinformatics*.

Reinius, Lovisa E, Nathalie Acevedo, Maaike Joerink, Göran Pershagen, Sven-Erik Dahlén, Dario Greco, Cilla Söderhäll, Annika Scheynius, and Juha Kere. 2012. “Differential Dna Methylation in Purified Human Blood Cells: Implications for Cell Lineage and Studies on Disease Susceptibility.” *PloS One* 7 (7): e41361.

Teschendorff, Andrew E, Francesco Marabita, Matthias Lechner, Thomas Bartlett, Jesper Tegner, David Gomez-Cabrero, and Stephan Beck. 2012. “A Beta-Mixture Quantile Normalization Method for Correcting Probe Design Bias in Illumina Infinium 450 K Dna Methylation Data.” *Bioinformatics* 29 (2): 189–96.

Wang, Ting, Weihua Guan, Jerome Lin, Nadia Boutaoui, Glorisa Canino, Jianhua Luo, Juan Carlos Celedón, and Wei Chen. 2015. “A Systematic Study of Normalization Methods for Infinium 450K Methylation Data Using Whole-Genome Bisulfite Sequencing Data.” *Epigenetics* 10 (7): 662–69.

Wu, Xiaohui, Weidan Chen, Fangqin Lin, Qingsheng Huang, Jiayong Zhong, Huan Gao, Yanyan Song, and Huiying Liang. 2019. “DNA Methylation Profile Is a Quantitative Measure of Biological Aging in Children.” *Aging (Albany NY)* 11 (22): 10031.

Zhang, Qian, Costanza L Vallerga, Rosie M Walker, Tian Lin, Anjali K Henders, Grant W Montgomery, Ji He, et al. 2019. “Improved Precision of Epigenetic Clock Estimates Across Tissues and Its Implication for Biological Ageing.” *Genome Medicine* 11 (1): 1–11.

# Appendix

```
utils::sessionInfo()
```