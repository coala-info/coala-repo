# The wateRmelon User’s Guide

Tyler Gorrie-Stone1 and Leonard Schalkwyk2\*

1Diamond Light Source
2University of Essex

\*lschal@essex.ac.uk

#### 30 October 2025

#### Abstract

The comprehensive guide to using the wateRmelon package analysing DNA methylation data.

#### Package

wateRmelon 2.16.0

# Contents

* [1 Introduction](#introduction)
  + [1.1 Citing the wateRmelon R package](#citing-the-watermelon-r-package)
* [2 Installation](#installation)
* [3 Quick Start](#quick-start)
* [4 Data Import](#data-import)
* [5 Quality Control](#quality-control)
  + [5.1 Outlier Detection](#outlier-detection)
  + [5.2 Probe Filtering](#probe-filtering)
* [6 Phenotype Predition](#phenotype-predition)
  + [6.1 Epigenetic Ages](#epigenetic-ages)
  + [6.2 Sex](#sex)
  + [6.3 Cell-type proportions](#cell-type-proportions)
* [7 Normalization & Preprocessing](#normalization-preprocessing)
  + [7.1 Normalization Violence](#normalization-violence)
* [8 Performance Metrics](#performance-metrics)
  + [8.1 SNP Genotypes](#snp-genotypes)
  + [8.2 XCI](#xci)
* [9 Statistical Analysis](#statistical-analysis)
* [Session info](#session-info)

# 1 Introduction

The *[wateRmelon](https://bioconductor.org/packages/3.22/wateRmelon)* provides a set of tools for importing, quality control and normalizing Illumina DNA methylation microarray data. All of the functions described in this vignette are fully compatible with the *[minfi](https://bioconductor.org/packages/3.22/minfi)* package, including any workflows or pipelines that involves it. Additionally wateRmelon extends the *[methylumi](https://bioconductor.org/packages/3.22/methylumi)* package to allow for MethyLumiSet representations of EPIC array data. If you are using many hundreds of arrays, you could consider using the related *[wateRmelon](https://bioconductor.org/packages/3.22/wateRmelon)*.

In addition to our own functions we provide implementations for a variety of age-prediction and cell-type estimations which work for both 450k and EPIC data.

## 1.1 Citing the wateRmelon R package

* If you use wateRmelon please cite (Pidsley et al. [2013](#ref-Pidsley:2013aa)) and our new publication
* If you use adjustedDasen or adjustedFunnorm please cite (Wang et al. [2020](#ref-Wang2020.10.19.345090))
* If you use estimateSex please cite (**???** {Wang2021.09.30.462546)

# 2 Installation

wateRmelon is designed to extend the *[methylumi](https://bioconductor.org/packages/3.22/methylumi)* and *[minfi](https://bioconductor.org/packages/3.22/minfi)* R packages so there is quite the number of dependencies which need to be installed. This can be handled by simply running:

```
install.packages('BiocManager')
BiocManager::install('wateRmelon')
library(wateRmelon)
```

Alternatively, wateRmelon can be installed directly from our [github](https://github.com/schalkwyk/wateRmelon)

```
install.packages('devtools')
devtools::install_github('schalkwyk/wateRmelon')
```

# 3 Quick Start

The package contains a small subset of 450k array data that can be used to explore all the funtions quickly. The `melon` data set is a `MethyLumiSet` containing 12 samples (columns) and 3364 features (rows)

```
data(melon)
dim(melon)
```

```
## Features  Samples
##     3363       12
```

```
# Quality filter using default thresholds
melon.pf <- pfilter(melon)
```

```
## 0 samples having 1 % of sites with a detection p-value greater than 0.05 were removed
## Samples removed:
## 72 sites were removed as beadcount <3 in 5 % of samples
## 40 sites having 1 % of samples with a detection p-value greater than 0.05 were removed
```

```
# Normalize using one of the many available methods
melon.dasen.pf <- dasen(melon.pf)

# Extract Betas for downstream analysis
norm_betas <- betas(melon.dasen.pf)
```

# 4 Data Import

The IDAT reading provided in *[methylumi](https://bioconductor.org/packages/3.22/methylumi)* has been updated to handle EPIC arrays, this is provided within the `readEPIC` function. Ideally, you can then read in a phenotype information that correspond to the idat files you have loaded in.

Alternatively you can read in data using *[minfi](https://bioconductor.org/packages/3.22/minfi)* and work from an `RGChannelSet` or `MethylSet` object, using the [`read_metharray` functions](https://www.bioconductor.org/packages/devel/bioc/vignettes/minfi/inst/doc/minfi.html#3_Reading_data).

```
mlumi <- readEPIC('path/to/idats')
```

# 5 Quality Control

Quality control is a vital part of performing an EWAS, it is important that we are able to easily identify samples that are outliers and could lead to false positive results.
There are many ways to identify outliers. Our preferred method is to use the `outlyx` function which provides a robust and reproducible multivariate method that we feel works well for most data-types.

## 5.1 Outlier Detection

```
outliers <- outlyx(melon, plot=TRUE)
```

![](data:image/png;base64...)

```
print(outliers)
```

```
##                     iqr    mv outliers
## 6057825008_R01C01 FALSE FALSE    FALSE
## 6057825008_R01C02 FALSE FALSE    FALSE
## 6057825008_R02C01 FALSE  TRUE    FALSE
## 6057825008_R02C02 FALSE FALSE    FALSE
## 6057825008_R03C01 FALSE FALSE    FALSE
## 6057825008_R03C02 FALSE FALSE    FALSE
## 6057825008_R04C01 FALSE FALSE    FALSE
## 6057825008_R04C02 FALSE  TRUE    FALSE
## 6057825008_R05C01 FALSE FALSE    FALSE
## 6057825008_R05C02 FALSE FALSE    FALSE
## 6057825008_R06C01 FALSE FALSE    FALSE
## 6057825008_R06C02 FALSE FALSE    FALSE
```

```
# remove outliers with melon[,!outliers$out]
```

Similarly it is important to check the quality control probes to measure how well the experiment performs. For this we provide `bscon` to quickly check the bisulfite conversion probes for each sample to estimate the percentage of DNA that has been successfully converted. Values above 90% are ideally but values above 80% are also acceptable.

```
bsc <- bscon(melon)
hist(bsc, xlab = c(0, 100))
```

![](data:image/png;base64...)

## 5.2 Probe Filtering

Poorly performing probes can be identified from the bead counts and detection p-values using the `pfilter` function

```
melon.pf <- pfilter(melon)
```

```
## 0 samples having 1 % of sites with a detection p-value greater than 0.05 were removed
## Samples removed:
## 72 sites were removed as beadcount <3 in 5 % of samples
## 40 sites having 1 % of samples with a detection p-value greater than 0.05 were removed
```

# 6 Phenotype Predition

wateRmelon now provides functions for three popular methods for generate phenotypic variables. Whether these are needed for quality control or identifying sample mismatch.
Or could even been provided as a missing covariate for analyses

## 6.1 Epigenetic Ages

wateRmelon provides 5 epigenetic age predictors: Horvath, Horvath Skin & Blood, Hannum, PhenoAge and Lin! As an extra measure we provide the number of missing probes for each clock and this can be used to supply your own list of coefficients to calculate different linear age predictions.
!!However!! any normalisation methods that the original age predictors use to predict ages so there will be slight differences compared to the original methods.

```
agep(melon, method='all')
```

```
##                   horvath.horvath.age horvath.horvath.n_missing
## 6057825008_R01C01            36.68182                       351
## 6057825008_R01C02            36.68789                       351
## 6057825008_R02C01            36.72415                       351
## 6057825008_R02C02            36.70512                       351
## 6057825008_R03C01            36.47068                       351
## 6057825008_R03C02            36.72860                       351
## 6057825008_R04C01            36.57890                       351
## 6057825008_R04C02            36.60815                       351
## 6057825008_R05C01            36.66895                       351
## 6057825008_R05C02            36.52764                       351
## 6057825008_R06C01            36.53931                       351
## 6057825008_R06C02            36.56719                       351
##                   hannum.hannum.age hannum.hannum.n_missing
## 6057825008_R01C01                 0                      71
## 6057825008_R01C02                 0                      71
## 6057825008_R02C01                 0                      71
## 6057825008_R02C02                 0                      71
## 6057825008_R03C01                 0                      71
## 6057825008_R03C02                 0                      71
## 6057825008_R04C01                 0                      71
## 6057825008_R04C02                 0                      71
## 6057825008_R05C01                 0                      71
## 6057825008_R05C02                 0                      71
## 6057825008_R06C01                 0                      71
## 6057825008_R06C02                 0                      71
##                   phenoage.phenoage.age phenoage.phenoage.n_missing
## 6057825008_R01C01              60.77928                         511
## 6057825008_R01C02              60.77094                         511
## 6057825008_R02C01              60.77487                         511
## 6057825008_R02C02              60.77373                         511
## 6057825008_R03C01              60.77430                         511
## 6057825008_R03C02              60.78078                         511
## 6057825008_R04C01              60.77005                         511
## 6057825008_R04C02              60.77078                         511
## 6057825008_R05C01              60.77756                         511
## 6057825008_R05C02              60.77066                         511
## 6057825008_R06C01              60.77628                         511
## 6057825008_R06C02              60.77336                         511
##                   skinblood.skinblood.age skinblood.skinblood.n_missing
## 6057825008_R01C01                15.02028                           389
## 6057825008_R01C02                14.91345                           389
## 6057825008_R02C01                15.09054                           389
## 6057825008_R02C02                15.04701                           389
## 6057825008_R03C01                15.18590                           389
## 6057825008_R03C02                15.13731                           389
## 6057825008_R04C01                15.11105                           389
## 6057825008_R04C02                15.06645                           389
## 6057825008_R05C01                15.08693                           389
## 6057825008_R05C02                15.16253                           389
## 6057825008_R06C01                15.23390                           389
## 6057825008_R06C02                15.10623                           389
##                   lin.lin.age lin.lin.n_missing
## 6057825008_R01C01    16.05763                98
## 6057825008_R01C02    16.61655                98
## 6057825008_R02C01    15.88568                98
## 6057825008_R02C02    17.03739                98
## 6057825008_R03C01    16.49062                98
## 6057825008_R03C02    16.40962                98
## 6057825008_R04C01    15.58818                98
## 6057825008_R04C02    16.30653                98
## 6057825008_R05C01    16.76162                98
## 6057825008_R05C02    17.24285                98
## 6057825008_R06C01    15.69054                98
## 6057825008_R06C02    15.78848                98
```

```
agep(melon, method='horvath')
```

```
##                   horvath.age horvath.n_missing
## 6057825008_R01C01    36.68182               351
## 6057825008_R01C02    36.68789               351
## 6057825008_R02C01    36.72415               351
## 6057825008_R02C02    36.70512               351
## 6057825008_R03C01    36.47068               351
## 6057825008_R03C02    36.72860               351
## 6057825008_R04C01    36.57890               351
## 6057825008_R04C02    36.60815               351
## 6057825008_R05C01    36.66895               351
## 6057825008_R05C02    36.52764               351
## 6057825008_R06C01    36.53931               351
## 6057825008_R06C02    36.56719               351
```

## 6.2 Sex

Sexes of samples can be determined like so:

```
estimateSex(betas(melon), do_plot=TRUE)
```

```
## Normalize beta values by Z score...
```

```
## Fishished Zscore normalization.
```

```
## Warning in estimateSex(betas(melon), do_plot = TRUE): Missing 4036 probes!
## cg25813447, cg07779434, cg14959801, cg27263894, cg19605909, cg24888621, cg20851325, cg04369555, cg09192059, cg26055054, cg22069441, cg05422360, cg04836978, cg12594800, cg04596655, cg03590418, cg21159768, cg22417589, cg08130682, cg02285254, cg21258987, cg11185978, cg20439892, cg03672021, cg03370193, cg14022645, cg15906052, cg20015269, cg06302025, cg21113886, cg14332086, cg07381502, cg23277098, cg16594779, cg03460546, cg06936709, cg18102950, cg18011534, cg09070199, cg02213813, cg01674874, cg02354343, cg21142188, cg12166502, cg13115118, cg10256662, cg22750044, cg07865580, cg12030638, cg02770249, cg01062269, cg02869694, cg25910467, cg03332892, cg02161919, cg13443410, cg10670396, cg07256221, cg09523186, cg23696472, cg00735883, cg00416689, cg16697940, cg22238863, cg09055253, cg04225046, cg16315447, cg25790081, cg24978383, cg11663421, cg03905487, cg15848449, cg26628435, cg22332696, cg07388258, cg26552464, cg25930738, cg22569587, cg21604054, cg23299641, cg05073171, cg14783837, cg22474754, cg27548075, cg08785133, cg03554089, cg05032903, cg13616735, cg12165338, cg24559073, cg00264378, cg14510207, cg20497120, cg08955859, cg06720669, cg21019788, cg06939792, cg21988739, cg07748875, cg09791535, cg27124847, cg19505129, cg18395382, cg17339373, cg01187510, cg26583344, cg15858894, cg02169289, cg09086179, cg17676246, cg01166930, cg06408301, cg21456313, cg02871887, cg22522913, cg16414561, cg07629996, cg11308037, cg13786096, cg18377059, cg22569627, cg12377701, cg22850802, cg01924074, cg26359958, cg12865398, cg20775112, cg17878135, cg04026379, cg17558827, cg21016188, cg11111271, cg27513289, cg06172626, cg24550433, cg16115418, cg18159654, cg01913196, cg05558522, cg08882363, cg02265919, cg11647489, cg02971902, cg00723997, cg00583618, cg08902818, cg22527050, cg05799859, cg23554546, cg27054331, cg07867687, cg26327984, cg25622910, cg21932800, cg22823767, cg06544877, cg05835545, cg03517379, cg12440269, cg13613682, cg23612178, cg09146364, cg03941517, cg08965337, cg19180514, cg06098232, cg08609270, cg11179629, cg25063710, cg27488875, cg01758418, cg02725692, cg26059639, cg25225807, cg03959273, cg25364049, cg14308265, cg06409934, cg24392532, cg26738106, cg00810519, cg17832062, cg25697726, cg11902811, cg27260927, cg15755924, cg03104298, cg13918312, cg02821380, cg20971536, cg15874629, cg21595968, cg20792978, cg00142683, cg16722818, cg21362390, cg25514427, cg07828380, cg01293417, cg27296089, cg27375748, cg21887683, cg11005845, cg25987936, cg22575892, cg19415339, cg15024309, cg00140189, cg01996818, cg12058262, cg27080287, cg05223760, cg04811556, cg02805922, cg06139288, cg11704979, cg14349378, cg17195879, cg18990292, cg11272332, cg05803913, cg21156383, cg13839778, cg17036062, cg08195522, cg09890269, cg09100792, cg10649042, cg04128303, cg06152434, cg14430524, cg25587058, cg04025582, cg23408987, cg07187289, cg26104731, cg20979765, cg09867302, cg02239640, cg01825872, cg10174816, cg03422380, cg26510526, cg13182391, cg13569417, cg15841434, cg23967850, cg04675919, cg02859554, cg25237542, cg12537796, cg04924141, cg02510708, cg11441847, cg12591117, cg12935118, cg16510200, cg12419383, cg16617830, cg26376518, cg09310980, cg07368951, cg20498086, cg19911179, cg06462727, cg26333595, cg03705894, cg21880156, cg01600123, cg19548176, cg15517690, cg10293967, cg00936435, cg22069989, cg17292622, cg21080294, cg05511752, cg15867166, cg02120046, cg16680922, cg24341236, cg19513111, cg25881119, cg08405463, cg05134041, cg08422514, cg09034929, cg06097615, cg16248169, cg19481013, cg12823249, cg04665139, cg21501064, cg17865482, cg06783548, cg27470278, cg20540913, cg23137494, cg06558952, cg20457259, cg27151711, cg04791822, cg12813325, cg14230133, cg23503517, cg20350671, cg17562247, cg00920960, cg19137564, cg14261068, cg17503853, cg20359784, cg21480420, cg10403109, cg01555661, cg15454483, cg03983969, cg26342575, cg08358587, cg13185972, cg12228772, cg17155577, cg13974562, cg25614853, cg03670113, cg04702045, cg08479532, cg08757719, cg09072865, cg02012821, cg13571540, cg20546893, cg17033281, cg17192679, cg11434986, cg13012525, cg16107992, cg07806343, cg16809091, cg01108554, cg06657741, cg13674559, cg10070668, cg20081453, cg03679005, cg21142420, cg14463432, cg27350602, cg12584551, cg11509903, cg20442640, cg08591489, cg08757574, cg21509846, cg00767637, cg02921434, cg05418443, cg23722438, cg15904427, cg04700060, cg25165659, cg10274815, cg17152375, cg17565795, cg07796014, cg12763824, cg26032662, cg13915726, cg22682304, cg12709057, cg07428182, cg12938998, cg03161453, cg21202708, cg13214937, cg07674520, cg05445331, cg00267352, cg02161125, cg27453644, cg20074774, cg19859323, cg21602092, cg06551391, cg25452717, cg14873818, cg22343001, cg18834878, cg10510586, cg09261015, cg11854877, cg26909705, cg27123903, cg21010298, cg05892376, cg02864732, cg01817069, cg08615635, cg16857716, cg23356769, cg18016370, cg14460470, cg22618086, cg14470409, cg03939693, cg26927606, cg18885073, cg24183173, cg10519228, cg09965404, cg00466309, cg12707233, cg15661671, cg24054653, cg04031645, cg10950266, cg19718903, cg10549828, cg12536534, cg24748621, cg24052239, cg24000218, cg06411441, cg24536689, cg21978299, cg04032096, cg23726559, cg06438901, cg16158045, cg23443158, cg13208429, cg20396841, cg15067665, cg25528264, cg23896353, cg03202526, cg19218988, cg05127178, cg26004099, cg12039967, cg20958732, cg26674826, cg20589243, cg24925526, cg16626088, cg08447449, cg14004892, cg19616372, cg11901680, cg07253552, cg07374632, cg07822777, cg05424879, cg01043588, cg16161440, cg26695278, cg06538336, cg24831179, cg18414950, cg05045028, cg16429439, cg08464305, cg01828474, cg09521623, cg26121752, cg09990582, cg00745293, cg08221357, cg13582495, cg25911220, cg23417743, cg15757320, cg05673346, cg21491240, cg03575468, cg06775759, cg05143403, cg06915915, cg20332806, cg18769303, cg15356502, cg26936230, cg08848171, cg26382696, cg00374088, cg23527532, cg10047502, cg15706156, cg10401803, cg07653728, cg18102233, cg09210933, cg06779458, cg15802548, cg04484695, cg24597825, cg05184076, cg14113300, cg17914143, cg25075069, cg04703500, cg03576039, cg19797013, cg05941375, cg04189697, cg03050491, cg20121427, cg12622895, cg03706022, cg12194828, cg10873964, cg23907260, cg18717600, cg26381742, cg16967668, cg03157806, cg05088151, cg12373280, cg16412513, cg04216286, cg13797960, cg06650776, cg26555756, cg11049774, cg10869159, cg25656978, cg14812623, cg08836298, cg12152167, cg07109010, cg13628616, cg21290550, cg22625568, cg00412010, cg05091873, cg04029282, cg08963265, cg22044840, cg03213202, cg24275475, cg15579650, cg16641060, cg18536496, cg12125741, cg21762935, cg12472218, cg21030483, cg13532816, cg09411587, cg01758988, cg01142317, cg26778358, cg13190238, cg07929406, cg23860088, cg09285672, cg18796341, cg25896901, cg16832275, cg02773050, cg16998810, cg21400640, cg09778422, cg19800913, cg12290635, cg21294096, cg03759948, cg27264374, cg06323885, cg23181142, cg25933726, cg09610589, cg19041137, cg08798116, cg02799972, cg13663390, cg11825763, cg07946630, cg03100923, cg20767561, cg19238394, cg06104959, cg14970569, cg06614969, cg15236057, cg26580465, cg06295352, cg00116265, cg09186478, cg11844737, cg16314146, cg01039990, cg06140460, cg19741073, cg16529483, cg18107314, cg05414241, cg12308243, cg12454245, cg21905818, cg10956264, cg02179438, cg12047536, cg06899582, cg00525383, cg17399684, cg19787517, cg06444329, cg19944582, cg08786860, cg23954206, cg19168249, cg03683587, cg14306994, cg10914789, cg04763286, cg26457165, cg05600581, cg09227616, cg12592455, cg01081720, cg01999076, cg00116709, cg05526804, cg00829575, cg26746069, cg11442732, cg25698940, cg27326620, cg26482893, cg18091964, cg05288642, cg16250105, cg00818649, cg05184682, cg14541939, cg12054566, cg12842316, cg01813294, cg11654517, cg01314643, cg14541448, cg21183872, cg09513996, cg09407917, cg08817443, cg12687215, cg12689022, cg03210912, cg06746884, cg08983668, cg11764747, cg21040569, cg23623404, cg22975791, cg12614178, cg08539065, cg00621925, cg15410402, cg15043283, cg04144603, cg02615131, cg05085049, cg10418630, cg15855671, cg20104776, cg13431666, cg20455959, cg22858728, cg25402895, cg11165479, cg17571782, cg18641697, cg14295696, cg08348649, cg02480419, cg11703139, cg24126759, cg07452499, cg02055404, cg2726843
```

```
## Warning in estimateSex(betas(melon), do_plot = TRUE): Missing 281 probes!
## cg02842889, cg15281205, cg15345074, cg26983535, cg01900066, cg01073572, cg24183504, cg05230942, cg05544622, cg17837162, cg25538674, cg11898347, cg06065495, cg13252613, cg27611726, cg00975375, cg00243321, cg10799208, cg17741448, cg08053115, cg02012379, cg18077436, cg04448376, cg05621349, cg10835413, cg02839557, cg07731488, cg14526044, cg10422744, cg27578568, cg02577797, cg04958669, cg10338539, cg00214611, cg03441493, cg02004872, cg00271873, cg14741114, cg26488634, cg05128824, cg24393100, cg24837623, cg27433982, cg02011394, cg06479204, cg06322277, cg10213302, cg00543493, cg21106100, cg12456573, cg02522936, cg18032798, cg10267609, cg04023335, cg03767353, cg08673225, cg01311227, cg20474581, cg10620659, cg14492024, cg13808036, cg24016855, cg01215343, cg05480730, cg03750315, cg03258315, cg05890011, cg01911472, cg14671357, cg02050847, cg25705492, cg02606988, cg04042030, cg20864678, cg13765957, cg11684211, cg13365400, cg05098815, cg25640065, cg03827298, cg00213748, cg00212031, cg13268984, cg10646950, cg02056550, cg08258654, cg10959847, cg27509967, cg03052502, cg15935877, cg08739478, cg07795413, cg07607525, cg04303809, cg14442616, cg17939569, cg25914522, cg00272582, cg25059696, cg00762184, cg10841270, cg26475999, cg04493908, cg13861458, cg00576139, cg25427172, cg00455876, cg07851521, cg04559508, cg15059553, cg15422579, cg14029254, cg02126249, cg08596608, cg14778208, cg09732580, cg17651935, cg23834181, cg14005657, cg15462332, cg15516537, cg17834650, cg09898573, cg26046487, cg05672930, cg26517491, cg10252249, cg15810474, cg08820785, cg04016144, cg02730008, cg16552926, cg25704368, cg25518695, cg00676506, cg01644972, cg08680991, cg05964935, cg04576441, cg04831594, cg09748856, cg03769088, cg09228985, cg07765982, cg27545697, cg08242338, cg25012987, cg11225091, cg05954446, cg03359666, cg15662272, cg14180491, cg04790916, cg08702825, cg14933403, cg05367916, cg03683899, cg14931215, cg14248084, cg03443143, cg05408674, cg06237805, cg14972466, cg03155755, cg01984154, cg06576965, cg13805219, cg05051262, cg09408193, cg05530472, cg06636270, cg03535417, cg27248959, cg15329860, cg02129146, cg15700967, cg15849038, cg08816194, cg27254225, cg17660627, cg05865243, cg03278611, cg25667057, cg01426558, cg08265308, cg11131351, cg02402208, cg02272584, cg03695421, cg17560699, cg08593141, cg03416979, cg10691859, cg25815185, cg06587955, cg03515816, cg15746461, cg03601053, cg27049643, cg03430010, cg18168924, cg10363397, cg06231362, cg10239257, cg15197499, cg26928789, cg25071634, cg10172760, cg01828798, cg18163559, cg13419214, cg15429127, cg08160949, cg14303457, cg09829904, cg27325772, cg13618458, cg06855731, cg05378695, cg10698069, cg20256738, cg01523029, cg18058072, cg05999368, cg10067523, cg15682993, cg18085787, cg20764275, cg06865724, cg26497631, cg04193779, cg00599377, cg14273923, cg00308367, cg11021362, cg02105393, cg25363292, cg27355713, cg22051787, cg17972491, cg14151065, cg03123709, cg09460641, cg09350919, cg03533500, cg04351468, cg26983430, cg13851368, cg02107461, cg13845521, cg05725925, cg08528516, cg14742615, cg09546548, cg10811597, cg15682806, cg08357313, cg09081202, cg09804407, cg16626452, cg01757887, cg25443613, cg03266527, cg02616328, cg05678960, cg10051237, cg11816202, cg07747963, cg02233190, cg15431336, cg26058907, cg19244032, cg01463110, cg00789540, cg26198148, cg02340092, cg00639218, cg14133106, cg01209756, cg14157445, cg03905640
```

![](data:image/png;base64...)

```
##                             X           Y predicted_sex
## 6057825008_R01C01 -0.05116010  0.12343032          Male
## 6057825008_R01C02 -0.03852021  0.13125424          Male
## 6057825008_R02C01 -0.04605816  0.11486779          Male
## 6057825008_R02C02 -0.04661608  0.11587946          Male
## 6057825008_R03C01  0.16004834 -0.05563472        Female
## 6057825008_R03C02  0.17358788 -0.04939172        Female
## 6057825008_R04C01  0.14628952 -0.07222119        Female
## 6057825008_R04C02 -0.05122662  0.11274543          Male
## 6057825008_R05C01  0.16784195 -0.04123302        Female
## 6057825008_R05C02 -0.06365946  0.10793467          Male
## 6057825008_R06C01 -0.06126409  0.11465433          Male
## 6057825008_R06C02  0.15132332 -0.06155400        Female
```

## 6.3 Cell-type proportions

wateRmelon is able to compute cell counts for bulk blood (currently only bulk blood).

```
estimateCellCounts.wateRmelon(melon, referencePlatform = "IlluminaHumanMethylation450k")
estimateCellCounts.wateRmelon(melon, referencePlatform = "IlluminaHumanMethylationEPIC") # change reference
```

# 7 Normalization & Preprocessing

| Norm Method | Short Description | Extra Details |
| --- | --- | --- |
| dasen | Best performing normalisation method according to Pidsley 2013 |  |
| nasen | Simpler implemenation of dasen that does not correct for sentrix positions | Can be used on EPIC data without any consequences. |
| adjusted\_dasen | dasen with our interpolatedXY method | `offset_fit = FALSE` performs adjusted\_nasen instead |
| adjusted\_funnorm | funnorm with our interpolatedXY method | Only Available to `RGChannelSet` |
| SWAN | Popular method for normalisation |  |

As such they can be used as such:

```
dasen.melon <- dasen(melon) # Use whichever method you would like to use.
```

## 7.1 Normalization Violence

Normalization aims to align the data across samples to make it ready for analysis.
The degree of normalization across samples is variable, where samples undergo a more dramatic transformation to resemble the rest of the data.
This can be an indicator that a sample has addition-al noise or is an outlier. The qual function provides an estimate of vio-lence that has been introduced through preprocessing and normalization.

```
das <- dasen(melon)
qu <- qual(betas(melon), betas(das))
plot(qu[,1], qu[,2])
```

![](data:image/png;base64...)

# 8 Performance Metrics

TODO…
## Genomic Imprinting

```
dmrse_row(melon.pf)
```

```
## 223 iDMR data rows found
```

```
## [1] 0.005428861
```

```
dmrse_row(melon.dasen.pf) # Slightly better standard errores
```

```
## 223 iDMR data rows found
```

```
## [1] 0.002086381
```

## 8.1 SNP Genotypes

Not available for minfi objects

```
genki(melon.pf)
```

```
## 65SNP data rows found
```

```
## NULL
```

```
## [1] 8.129585e-05 2.020173e-04 7.819409e-05
```

```
genki(melon.dasen.pf)
```

```
## 65SNP data rows found
```

```
## NULL
```

```
## [1] 5.074810e-05 1.255207e-04 4.529896e-05
```

## 8.2 XCI

```
seabi(melon.pf, sex=pData(melon.pf)$sex, X=fData(melon.pf)$CHR=='X')
```

```
## [1] 0.2597014
```

```
seabi(melon.dasen.pf, sex=pData(melon.dasen.pf)$sex, X=fData(melon.dasen.pf)$CHR=='X')
```

```
## [1] 0.1010268
```

# 9 Statistical Analysis

Although we cannot predict what type of analysis you are expecting to perform we have a couple of recommendations that should be considered before you perform statistical testing. Firstly we recommend a final sweep of the normalized data using `pwod`

```
bet <- betas(melon)
pwod_bet <- pwod(bet)
```

```
## 47 probes detected.
```

```
# Statistical Analysis using pwod_bet
```

# Session info

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
## [1] parallel  stats4    stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] wateRmelon_2.16.0
##  [2] illuminaio_0.52.0
##  [3] IlluminaHumanMethylation450kanno.ilmn12.hg19_0.6.1
##  [4] ROC_1.86.0
##  [5] lumi_2.62.0
##  [6] methylumi_2.56.0
##  [7] minfi_1.56.0
##  [8] bumphunter_1.52.0
##  [9] locfit_1.5-9.12
## [10] iterators_1.0.14
## [11] foreach_1.5.2
## [12] Biostrings_2.78.0
## [13] XVector_0.50.0
## [14] SummarizedExperiment_1.40.0
## [15] MatrixGenerics_1.22.0
## [16] FDb.InfiniumMethylation.hg19_2.2.0
## [17] org.Hs.eg.db_3.22.0
## [18] TxDb.Hsapiens.UCSC.hg19.knownGene_3.22.1
## [19] GenomicFeatures_1.62.0
## [20] AnnotationDbi_1.72.0
## [21] GenomicRanges_1.62.0
## [22] Seqinfo_1.0.0
## [23] IRanges_2.44.0
## [24] S4Vectors_0.48.0
## [25] ggplot2_4.0.0
## [26] reshape2_1.4.4
## [27] scales_1.4.0
## [28] matrixStats_1.5.0
## [29] limma_3.66.0
## [30] Biobase_2.70.0
## [31] BiocGenerics_0.56.0
## [32] generics_0.1.4
## [33] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3        jsonlite_2.0.0
##   [3] magrittr_2.0.4            magick_2.9.0
##   [5] farver_2.1.2              rmarkdown_2.30
##   [7] BiocIO_1.20.0             vctrs_0.6.5
##   [9] multtest_2.66.0           memoise_2.0.1
##  [11] Rsamtools_2.26.0          DelayedMatrixStats_1.32.0
##  [13] RCurl_1.98-1.17           askpass_1.2.1
##  [15] tinytex_0.57              htmltools_0.5.8.1
##  [17] S4Arrays_1.10.0           curl_7.0.0
##  [19] Rhdf5lib_1.32.0           SparseArray_1.10.0
##  [21] rhdf5_2.54.0              sass_0.4.10
##  [23] KernSmooth_2.23-26        nor1mix_1.3-3
##  [25] bslib_0.9.0               plyr_1.8.9
##  [27] cachem_1.1.0              GenomicAlignments_1.46.0
##  [29] lifecycle_1.0.4           pkgconfig_2.0.3
##  [31] Matrix_1.7-4              R6_2.6.1
##  [33] fastmap_1.2.0             digest_0.6.37
##  [35] siggenes_1.84.0           reshape_0.8.10
##  [37] RSQLite_2.4.3             base64_2.0.2
##  [39] mgcv_1.9-3                httr_1.4.7
##  [41] abind_1.4-8               compiler_4.5.1
##  [43] beanplot_1.3.1            rngtools_1.5.2
##  [45] bit64_4.6.0-1             withr_3.0.2
##  [47] S7_0.2.0                  BiocParallel_1.44.0
##  [49] DBI_1.2.3                 HDF5Array_1.38.0
##  [51] MASS_7.3-65               openssl_2.3.4
##  [53] DelayedArray_0.36.0       rjson_0.2.23
##  [55] tools_4.5.1               rentrez_1.2.4
##  [57] glue_1.8.0                quadprog_1.5-8
##  [59] h5mread_1.2.0             restfulr_0.0.16
##  [61] nlme_3.1-168              rhdf5filters_1.22.0
##  [63] grid_4.5.1                gtable_0.3.6
##  [65] tzdb_0.5.0                preprocessCore_1.72.0
##  [67] tidyr_1.3.1               data.table_1.17.8
##  [69] hms_1.1.4                 xml2_1.4.1
##  [71] pillar_1.11.1             stringr_1.5.2
##  [73] genefilter_1.92.0         splines_4.5.1
##  [75] dplyr_1.1.4               lattice_0.22-7
##  [77] survival_3.8-3            rtracklayer_1.70.0
##  [79] bit_4.6.0                 GEOquery_2.78.0
##  [81] annotate_1.88.0           tidyselect_1.2.1
##  [83] knitr_1.50                bookdown_0.45
##  [85] xfun_0.53                 scrime_1.3.5
##  [87] statmod_1.5.1             UCSC.utils_1.6.0
##  [89] stringi_1.8.7             yaml_2.3.10
##  [91] evaluate_1.0.5            codetools_0.2-20
##  [93] cigarillo_1.0.0           tibble_3.3.0
##  [95] BiocManager_1.30.26       affyio_1.80.0
##  [97] cli_3.6.5                 xtable_1.8-4
##  [99] jquerylib_0.1.4           GenomeInfoDb_1.46.0
## [101] dichromat_2.0-0.1         Rcpp_1.1.0
## [103] png_0.1-8                 XML_3.99-0.19
## [105] readr_2.1.5               blob_1.2.4
## [107] mclust_6.1.1              doRNG_1.8.6.2
## [109] sparseMatrixStats_1.22.0  bitops_1.0-9
## [111] affy_1.88.0               nleqslv_3.3.5
## [113] purrr_1.1.0               crayon_1.5.3
## [115] rlang_1.1.6               KEGGREST_1.50.0
```

Pidsley, R., C. C. Y Wong, M. Volta, K. Lunnon, J. Mill, and L. C. Schalkwyk. 2013. “A Data-Driven Approach to Preprocessing Illumina 450K Methylation Array Data.” Journal Article. *BMC Genomics* 14: 293. <https://doi.org/10.1186/1471-2164-14-293>.

Wang, Yucheng, Eilis Hannon, Olivia A Grant, Tyler J Gorrie-Stone, Meena Kumari, Jonathan Mill, Xiaojun Zhai, Klaus D McDonald-Maier, and Leonard C Schalkwyk. 2020. “DNA Methylation-Based Sex Classifier to Predict Sex and Identify Sex Chromosome Aneuploidy.” *bioRxiv*. <https://doi.org/10.1101/2020.10.19.345090>.