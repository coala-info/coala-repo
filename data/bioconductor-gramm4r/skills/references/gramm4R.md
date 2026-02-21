# gramm4R

#### Mengci Li, Dandan Liang, Tianlu Chen and Wei Jia

#### 2019-10-29

We designed and developed a new strategy, Generalized coRrelation analysis for Metabolome and Microbiome (GRaMM), for inter-correlation pairs discovery among metabolome and microbiome. GRaMM gives considerations to the different characteristics of omics data, the effect of covariates, and the balance of linear and nonlinear correlations, by integrating the classical linear regression, the newly reported maximum information coefficient (MIC), and the centered log-ratio transformation (CLR) algorithms.

4 functions of the package of gramm4R: `Gramm` ,`naiveGramm`, `nlfitGramm` ,`preGramm`

Install the latest version of this package by entering the following in R: if (!requireNamespace(“BiocManager”, quietly = TRUE)) install.packages(“BiocManager”) BiocManager::install(“gramm4R”)

## `preGramm`: A function to reproccess the input data of metabolome and microbiome. Missing values may be imputed and filled. Metabolome data and microbiomedata may be normalized and transformed by logarithm transformation and centered log-ratio (CLR) algorithm.

```
library("gramm4R")
data("metabolites")
data("microbes")
preGramm(metabolites,microbes)
```

```
## $x
##   A@elementMetadata@listData$X       B1       B2       B3       B4
## 1            Hexenoylcarnitine 9.552768 8.584391 9.182565 8.888530
## 2             Pimelylcarnitine 8.580779 9.500569 9.174942 7.751626
## 3            Octanoylcarnitine 9.011043 9.060199 8.847399 9.529479
## 4              Nonaylcarnitine 7.782836 7.894791 8.207796 8.805506
##         B5       B6       C1       C2       C3       C4       C5       C6
## 1 8.732098 9.078178 9.071258 8.685295 9.071083 8.665463 7.894710 8.762774
## 2 8.903600 9.150265 9.046609 8.284917 9.222770 9.007851 8.581387 8.633195
## 3 9.529903 9.136624 8.064311 9.709777 7.762694 9.281701 9.703139 9.515430
## 4 7.894172 7.838238 9.173030 8.201702 9.085645 8.575130 8.634183 8.396093
##         E1       E2       E3       E4       E5       E6       H1       H2
## 1 9.045379 8.681287 8.981209 9.009619 9.073357 8.977414 8.965409 8.755086
## 2 9.308349 8.899611 7.985646 8.767799 8.637477 8.890791 8.944701 9.279427
## 3 8.876721 8.422415 9.350377 9.034031 9.041999 9.121120 8.737896 9.029954
## 4 8.111252 9.412087 8.937235 8.855806 8.881061 8.643064 9.020933 8.433023
##         H3       H4       H5       H6       G1       G2       G3       G4
## 1 8.970399 8.715023 8.744737 8.746996 9.144297 8.877476 8.941661 9.135710
## 2 8.445879 9.144063 9.413919 8.249030 8.656816 8.718640 8.836641 8.743438
## 3 8.811023 8.773310 8.799022 9.008994 9.327506 8.828841 8.700801 9.126854
## 4 9.284858 8.998630 8.484849 9.368372 8.202716 9.199392 9.155943 8.566875
##         G5       G6       I1       I2       I3       I4       I5       I6
## 1 9.331232 9.323636 9.141726 9.063211 9.108429 8.732930 8.844980 8.692177
## 2 8.778594 8.211349 8.756831 9.196487 8.751802 8.832998 8.420404 8.552782
## 3 8.994554 9.263781 8.997703 8.877439 8.567129 8.729164 8.490050 8.688747
## 4 8.334749 8.427907 8.736924 8.375942 9.147913 9.283847 9.522204 9.467381
##         J1       J2       J3       J4       J5       J6
## 1 8.601337 8.719581 8.962944 8.969835 8.651012 9.133823
## 2 8.960894 8.601819 8.285403 9.026727 9.129733 9.281192
## 3 8.891072 8.879977 9.047222 8.850604 8.990789 8.906765
## 4 9.159673 9.328497 9.183505 8.830619 8.858471 7.872712
##
## $y
##   B@elementMetadata@listData$X        B1        B2        B3        B4
## 1                    SMB53 spp 0.9017493 0.9804699 0.9883562 0.8424447
## 2          Dehalobacterium spp 0.9017493 0.9804699 0.9883562 1.1710957
## 3           [Ruminococcus] spp 1.2111423 0.9804699 1.1145526 1.1440149
## 4                  Blautia spp 0.9853591 1.0585903 0.9087351 0.8424447
##          B5        B6        C1        C2        C3        C4       C5
## 1 0.8724414 0.8810233 0.8175422 0.9476685 0.8602898 0.8025745 0.916305
## 2 1.0657312 0.8810233 0.9510893 0.9476685 0.7498621 0.8025745 0.916305
## 3 1.1893861 1.1657949 1.2181834 1.1569944 1.6399861 1.3364325 1.123837
## 4 0.8724414 1.0721585 1.0131851 0.9476685 0.7498621 1.0584184 1.043553
##          C6        E1        E2        E3        E4        E5        E6
## 1 0.9116997 1.3124233 1.0163631 1.0752942 1.4991974 0.7643636 1.1303946
## 2 0.9116997 0.8661043 0.7664429 0.7238145 0.7801605 0.6261252 0.8190216
## 3 1.2649010 0.9553681 1.1866750 1.1970740 0.9404816 1.4292331 1.1019408
## 4 0.9116997 0.8661043 1.0305190 1.0038172 0.7801605 1.1802781 0.9486430
##          H1        H2        H3        H4        H5        H6        G1
## 1 0.9288641 0.8603012 0.9476685 0.9383388 0.9851037 1.0437928 1.1849836
## 2 0.9288641 0.9423882 0.9476685 0.9383388 0.9061714 0.8840121 0.9383388
## 3 1.0876070 1.1728355 1.1569944 1.1849836 1.0774487 1.1082926 0.9383388
## 4 1.0546648 1.0244752 0.9476685 0.9383388 1.0312762 0.9639025 0.9383388
##          G2        G3 G4        G5 G6        I1        I2        I3
## 1 0.8824321 0.9288641  1 0.8774853  1 0.7663518 0.5985237 0.8774853
## 2 0.8824321 0.9288641  1 1.1076517  1 1.0991207 1.2231715 0.8774853
## 3 1.3527036 1.0546648  1 1.1373777  1 1.0763165 1.2674573 1.1373777
## 4 0.8824321 1.0876070  1 0.8774853  1 1.0582111 0.9108476 1.1076517
##          I4        I5        I6        J1        J2        J3 J4        J5
## 1 0.7144864 0.9288641 0.8904594 0.9533868 0.9804699 0.9687605  1 0.9804699
## 2 1.1392418 0.9288641 0.8904594 0.9533868 0.9804699 0.9687605  1 0.9804699
## 3 1.2101599 1.0876070 1.3286218 1.1398397 1.0585903 1.0937186  1 1.0585903
## 4 0.9361120 1.0546648 0.8904594 0.9533868 0.9804699 0.9687605  1 0.9804699
##   J6
## 1  1
## 2  1
## 3  1
## 4  1
```

## `naiveGramm`: A function to test the association among metabolites and microbes. Using linear (linear regression) or nonlinear (Maximal Information Coefficient) methods.

```
data("metabolites")
data("microbes")
data("covariates")
naiveGramm(metabolites,microbes,covariates)
```

```
## $r
##                   SMB53 spp Dehalobacterium spp [Ruminococcus] spp
## Hexenoylcarnitine 0.2144255           0.2709539          0.2245212
## Pimelylcarnitine  0.3044200           0.2257297          0.2184067
## Octanoylcarnitine 0.2289191           0.1954756          0.3960479
## Nonaylcarnitine   0.1889781           0.2887279          0.3153598
##                   Blautia spp
## Hexenoylcarnitine   0.1842551
## Pimelylcarnitine    0.2533221
## Octanoylcarnitine   0.3083661
## Nonaylcarnitine     0.2122221
##
## $p
##                   SMB53 spp Dehalobacterium spp [Ruminococcus] spp
## Hexenoylcarnitine 0.5247525           0.2376238          0.6336634
## Pimelylcarnitine  0.1188119           0.4158416          0.7227723
## Octanoylcarnitine 0.4653465           0.7623762          0.0000000
## Nonaylcarnitine   0.8118812           0.1188119          0.1584158
##                   Blautia spp
## Hexenoylcarnitine   0.8019802
## Pimelylcarnitine    0.3069307
## Octanoylcarnitine   0.1089109
## Nonaylcarnitine     0.6138614
##
## $type
##                   SMB53 spp   Dehalobacterium spp [Ruminococcus] spp
## Hexenoylcarnitine "nonlinear" "nonlinear"         "nonlinear"
## Pimelylcarnitine  "nonlinear" "nonlinear"         "nonlinear"
## Octanoylcarnitine "nonlinear" "nonlinear"         "nonlinear"
## Nonaylcarnitine   "nonlinear" "nonlinear"         "nonlinear"
##                   Blautia spp
## Hexenoylcarnitine "nonlinear"
## Pimelylcarnitine  "nonlinear"
## Octanoylcarnitine "nonlinear"
## Nonaylcarnitine   "nonlinear"
```

r: Matrix of correlation coefficients. p: Matrix of correlation p values. type: Matrix of correlation methods for computing (linear or nonlinear).

## `nlfitGramm` : Plot, draw regression line and confidence interval, and show regression equation, R-square and P-value. The function includes the following models in the latest version: “line2P” (formula as: y=a*x+b), “line3P” (y=a*x^2+b*x+c), “log2P” (y=a*ln(x)+b), “exp2P” (y=a*exp(b*x)),“exp3P” (y=a*exp(b*x)+c), “power2P” (y=a*x^b), “power3P” (y=a*x^b+c), and “S” (y=a/(1+exp((x-b)/c))).

```
data("metabolites")
data("microbes")

nlfitGramm(metabolites,microbes)
```

Of each correlation pairs the figure who has the highest R-square among these models will be saved in a “pdf” file at working dirctory.

## `Gramm`: A function of the entire strategy to get the association between metabolites and microbes, using linear or nonlinear methods, and plot the regression figures.

```
data("metabolites");data("microbes");data("covariates")
Gramm(metabolites,microbes,covariates)
```

A file named “R value top 10 pairs.pdf” will be created automatically (corrlation coefficient top 10 pairs) .