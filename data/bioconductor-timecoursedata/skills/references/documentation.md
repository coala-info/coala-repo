# timecoursedata: Time course gene expression datasets

## Overview

This package provides time course gene expression datasets. The data included
in the package and its processing is described below.

Overview of the datasets included in timecoursedata:

| object | description |
| --- | --- |
| `shoemaker2015` | microarray data from influenza-exposed mice |
| `varoquaux2019leaf` | RNA-seq from leaf samples of *S. bicolor* exposed to drought |
| `varoquaux2019root` | RNA-seq from root samples of *S. bicolor* exposed to drought |

## Data structure

Each datasets in this package are represented by:

* a matrix containing the gene expression data
* a data.frame containing the metadata associated with it

All datasets can also be loaded as SummarizedExperiment objects using the
following functions:

| name | matrix/data.frame | SummarizedExperiment |
| --- | --- | --- |
| `shoemaker2015` | `data(shoemaker2015)` | `load_shoemaker2015()` |
| `varoquaux2019leaf` | `data(varoquaux2019leaf)` | `load_varoquaux2019(sample_type="leaf")` |
| `varoquaux2019root` | `data(varoquaux2019root)` | `load_varoquaux2019(sample_type="root")` |

The metadata contains at least the following information:

| column | description |
| --- | --- |
| `row.names` | name of the sample |
| `Timepoint` | which timepoints this sample belongs to |
| `Group` | which group this sample belongs to |
| `Replicate` (optional) | which replicate this sample belongs to |

## An Ultrasensitive Mechanism Regulates Influenza Virus-Induced Inflammation

This dataset is a microarray time-course experiment, exposing mice to three
different strains of influenza with varying doses. The authors of the
experiment collected three replicates of lung tissue samples during 14
unevenly-spaced time-points after infection, resulting in a dataset of 209
samples.

```
library(timecoursedata)
```

```
## Loading required package: SummarizedExperiment
```

```
## Loading required package: MatrixGenerics
```

```
## Loading required package: matrixStats
```

```
##
## Attaching package: 'MatrixGenerics'
```

```
## The following objects are masked from 'package:matrixStats':
##
##     colAlls, colAnyNAs, colAnys, colAvgsPerRowSet, colCollapse,
##     colCounts, colCummaxs, colCummins, colCumprods, colCumsums,
##     colDiffs, colIQRDiffs, colIQRs, colLogSumExps, colMadDiffs,
##     colMads, colMaxs, colMeans2, colMedians, colMins, colOrderStats,
##     colProds, colQuantiles, colRanges, colRanks, colSdDiffs, colSds,
##     colSums2, colTabulates, colVarDiffs, colVars, colWeightedMads,
##     colWeightedMeans, colWeightedMedians, colWeightedSds,
##     colWeightedVars, rowAlls, rowAnyNAs, rowAnys, rowAvgsPerColSet,
##     rowCollapse, rowCounts, rowCummaxs, rowCummins, rowCumprods,
##     rowCumsums, rowDiffs, rowIQRDiffs, rowIQRs, rowLogSumExps,
##     rowMadDiffs, rowMads, rowMaxs, rowMeans2, rowMedians, rowMins,
##     rowOrderStats, rowProds, rowQuantiles, rowRanges, rowRanks,
##     rowSdDiffs, rowSds, rowSums2, rowTabulates, rowVarDiffs, rowVars,
##     rowWeightedMads, rowWeightedMeans, rowWeightedMedians,
##     rowWeightedSds, rowWeightedVars
```

```
## Loading required package: GenomicRanges
```

```
## Loading required package: stats4
```

```
## Loading required package: BiocGenerics
```

```
## Loading required package: generics
```

```
##
## Attaching package: 'generics'
```

```
## The following objects are masked from 'package:base':
##
##     as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
##     setequal, union
```

```
##
## Attaching package: 'BiocGenerics'
```

```
## The following objects are masked from 'package:stats':
##
##     IQR, mad, sd, var, xtabs
```

```
## The following objects are masked from 'package:base':
##
##     Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,
##     as.data.frame, basename, cbind, colnames, dirname, do.call,
##     duplicated, eval, evalq, get, grep, grepl, is.unsorted, lapply,
##     mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
##     rank, rbind, rownames, sapply, saveRDS, table, tapply, unique,
##     unsplit, which.max, which.min
```

```
## Loading required package: S4Vectors
```

```
##
## Attaching package: 'S4Vectors'
```

```
## The following object is masked from 'package:utils':
##
##     findMatches
```

```
## The following objects are masked from 'package:base':
##
##     I, expand.grid, unname
```

```
## Loading required package: IRanges
```

```
## Loading required package: Seqinfo
```

```
## Loading required package: Biobase
```

```
## Welcome to Bioconductor
##
##     Vignettes contain introductory material; view with
##     'browseVignettes()'. To cite Bioconductor, see
##     'citation("Biobase")', and for packages 'citation("pkgname")'.
```

```
##
## Attaching package: 'Biobase'
```

```
## The following object is masked from 'package:MatrixGenerics':
##
##     rowMedians
```

```
## The following objects are masked from 'package:matrixStats':
##
##     anyMissing, rowMedians
```

```
data(shoemaker2015)
head(shoemaker2015$meta)
```

```
##              Group Replicate Timepoint
## GSM1557140 0     K         1         0
## GSM1557141 1     K         2         0
## GSM1557142 2     K         3         0
## GSM1557143 3     K         1        12
## GSM1557144 4     K         2        12
## GSM1557145 5     K         3        12
```

```
head(shoemaker2015$data)
```

```
##                    GSM1557140 GSM1557141 GSM1557142 GSM1557143 GSM1557144
## NM_009912            4.364173   4.338212   4.467095   4.096020   4.047477
## NM_008725            8.227778   8.318347   8.763661   8.894427   8.940470
## NM_007473            4.656177   5.010798   5.134367   4.651378   4.148347
## ENSMUST00000094955   5.845917   5.631973   5.689894   5.737804   5.855101
## NM_001042489        10.527553  10.391772  10.545010  10.643843  10.748155
## NM_008159            5.178836   4.961242   4.968316   5.008923   5.086048
##                    GSM1557145 GSM1557146 GSM1557147 GSM1557148 GSM1557149
## NM_009912            4.434741   4.423124   4.269806   4.340769   4.459663
## NM_008725            7.503926   8.050293  10.494730   7.824772  10.058947
## NM_007473            4.738783   4.602129   4.668651   4.496141   4.769481
## ENSMUST00000094955   5.600944   5.995875   5.619528   5.445811   5.990237
## NM_001042489        10.850465  10.862142  10.863667  10.863092  10.726463
## NM_008159            4.952627   5.301192   5.223774   4.987974   5.431684
##                    GSM1557150 GSM1557151 GSM1557152 GSM1557153 GSM1557154
## NM_009912            4.075490   4.392139   4.319921   4.036894   4.278102
## NM_008725            7.172212   7.755944   7.539625  10.347932   8.022185
## NM_007473            4.466626   4.730158   4.678658   4.942729   5.142943
## ENSMUST00000094955   5.941696   5.538740   5.532077   5.764879   5.951631
## NM_001042489        11.140806  10.888805  10.695048  10.510220  10.199757
## NM_008159            5.570177   5.444860   5.704597   5.577245   5.563220
##                    GSM1557155 GSM1557156 GSM1557157 GSM1557158 GSM1557159
## NM_009912            4.229525   4.790464   4.618102   4.292883   4.362999
## NM_008725            9.386234   8.011647  11.435488  11.748686  12.490890
## NM_007473            5.591846   6.111549   6.249046   4.822046   5.347795
## ENSMUST00000094955   5.419838   5.450870   5.644346   5.703008   5.502000
## NM_001042489        10.621972  10.900136  10.203150  10.453638  10.814877
## NM_008159            4.617328   5.680736   5.082844   4.890212   4.525892
##                    GSM1557160 GSM1557161 GSM1557162 GSM1557163 GSM1557164
## NM_009912            4.487013   4.914105   4.341961   4.706027   5.555682
## NM_008725           10.632376   7.380812  10.595355   7.370605   7.888910
## NM_007473            4.738201   5.238022   5.466100   4.679871   4.421353
## ENSMUST00000094955   5.644760   5.591560   5.727354   5.696933   5.667284
## NM_001042489        10.533647  10.385112  10.540360  10.463027  10.784618
## NM_008159            4.823083   5.172196   5.288532   5.177787   4.999295
##                    GSM1557165 GSM1557166 GSM1557167 GSM1557168 GSM1557169
## NM_009912            4.745618   4.491622   4.383318   4.777431   4.378846
## NM_008725           12.798337   8.647044  11.393278  11.835689  10.626121
## NM_007473            4.791897   4.287149   4.277924   4.876234   5.130431
## ENSMUST00000094955   5.517760   5.654180   5.754559   5.852834   5.526622
## NM_001042489        10.184721  10.137488  10.400821  11.351745  10.622861
## NM_008159            4.590930   4.798051   4.812678   5.178836   4.857245
##                    GSM1557170 GSM1557171 GSM1557172 GSM1557173 GSM1557174
## NM_009912            4.171708   4.769544   4.977933   4.560899   4.479142
## NM_008725            9.798396   7.239886   8.279798  12.055871  12.070300
## NM_007473            4.706490   4.475112   4.375857   6.219516   4.947267
## ENSMUST00000094955   6.093310   5.973003   5.788523   5.672030   5.755646
## NM_001042489        10.092476  10.488544  10.392167  10.729901  10.970620
## NM_008159            4.948274   4.769544   4.850561   5.056947   5.032845
##                    GSM1557175 GSM1557176 GSM1557177 GSM1557178 GSM1557179
## NM_009912            4.825519   5.185680   4.805229   5.054352   4.797555
## NM_008725           11.797380   8.621139   9.281965  10.488918  10.332053
## NM_007473            4.888116   5.222018   6.099391   4.909978   5.118556
## ENSMUST00000094955   5.676086   5.525499   5.662417   5.747861   5.631346
## NM_001042489        10.448382  10.688269  10.565089  10.430214  10.964179
## NM_008159            5.299177   5.258186   4.588135   4.888349   4.467719
##                    GSM1557180 GSM1557181 GSM1557182 GSM1557183 GSM1557184
## NM_009912            4.591574   5.215763   3.779645   3.814287   3.876829
## NM_008725            7.371657   7.411414   7.336296   8.628212  12.329396
## NM_007473            4.521390   4.591574   4.426017   4.161715   4.660551
## ENSMUST00000094955   5.897702   5.615557   5.429603   5.526809   5.550831
## NM_001042489        10.825507  11.131434  10.326305  10.220033  10.175231
## NM_008159            4.755363   4.887416   4.369025   4.344682   4.154756
##                    GSM1557185 GSM1557186 GSM1557187 GSM1557188 GSM1557189
## NM_009912            4.119044   4.080191   4.228237   3.703268   3.981815
## NM_008725            8.032115   8.668254   8.038815  13.341029   7.029826
## NM_007473            4.370360   4.857542   4.453454   4.614865   4.300260
## ENSMUST00000094955   5.803437   5.569814   5.608358   5.378740   5.965425
## NM_001042489        10.146251  10.213050  10.436663  10.188191  10.489912
## NM_008159            4.291826   4.531201   4.734511   4.457230   4.879403
##                    GSM1557190 GSM1557191 GSM1557192 GSM1557193 GSM1557194
## NM_009912            4.896947   4.782898   4.559143   5.039419   4.434821
## NM_008725            9.343783  10.890933  11.795071  11.656627   8.603541
## NM_007473            4.978535   5.186723   5.665412   5.114626   4.539313
## ENSMUST00000094955   5.618791   5.486148   5.465865   5.576377   5.546515
## NM_001042489        10.998721  10.806703  10.567866  10.966331  10.550902
## NM_008159            4.742591   4.985470   4.916281   4.817952   4.856053
##                    GSM1557195 GSM1557196 GSM1557197 GSM1557198 GSM1557199
## NM_009912            4.349430   5.105131   4.142786   4.052686   3.846554
## NM_008725            8.165527  10.066594  13.111832   9.748929  12.210118
## NM_007473            4.946764   4.594220   4.794573   4.637024   4.464674
## ENSMUST00000094955   6.143985   5.466685   5.749370   5.433921   5.899440
## NM_001042489        10.420457  11.137841  10.392454  10.463301  10.418195
## NM_008159            4.781958   4.972117   4.561630   4.457465   4.604472
##                    GSM1557200 GSM1557201 GSM1557202 GSM1557203 GSM1557204
## NM_009912            4.483545   4.202688   3.720259   3.798996   4.404255
## NM_008725            7.171576   6.798969  10.518543  13.236289  12.706269
## NM_007473            4.833654   4.734511   4.395918   4.459585   6.682213
## ENSMUST00000094955   6.064716   5.797334   5.757720   5.595886   5.801177
## NM_001042489        10.567606  10.290602  10.330799  10.189672  10.555445
## NM_008159            4.551875   4.642562   4.841079   4.665183   4.775605
##                    GSM1557205 GSM1557206 GSM1557207 GSM1557208 GSM1557209
## NM_009912            4.186379   3.911534   4.335138   4.351718   3.783410
## NM_008725           14.746318   8.388004   8.329866  11.823550  12.367629
## NM_007473            4.575304   4.287238   6.269483   5.833289   4.783588
## ENSMUST00000094955   5.659962   5.697897   5.582008   5.709882   5.249910
## NM_001042489        10.552405  10.057967  10.469323  10.575399  10.382377
## NM_008159            4.871171   4.412544   4.393864   4.351718   4.293059
##                    GSM1557210 GSM1557211 GSM1557212 GSM1557213 GSM1557214
## NM_009912            4.428263   4.098843   4.275074   4.498815   4.421997
## NM_008725           12.429596  11.026308   9.778742   9.254200  11.720704
## NM_007473            5.483410   4.715979   4.275074   4.498815   4.347058
## ENSMUST00000094955   5.483410   6.293183   5.616893   5.792576   5.911589
## NM_001042489        10.397636  10.566904  10.517413  10.486989  10.620774
## NM_008159            4.597503   5.036530   4.344002   4.782209   4.850441
##                    GSM1557215 GSM1557216 GSM1557217 GSM1557218 GSM1557219
## NM_009912            4.278102   4.359977   4.231456   4.382491   4.490164
## NM_008725            9.653914  13.248020   9.389719  12.356165   8.931784
## NM_007473            5.202511   4.727034   5.091679   4.544499   4.451089
## ENSMUST00000094955   5.580062   5.672538   5.710245   5.792888   5.818898
## NM_001042489        10.284228  10.877663   9.807760  10.570610  10.718365
## NM_008159            4.591431   4.626090   4.051229   4.829530   4.821802
##                    GSM1557220 GSM1557221 GSM1557222 GSM1557223 GSM1557224
## NM_009912            4.451878   4.543759   3.942168   4.714531   4.388271
## NM_008725           10.479656   8.721105   8.193179   9.991749  10.726615
## NM_007473            4.917595   4.515665   4.283783   5.186249   4.758235
## ENSMUST00000094955   5.699193   5.732816   5.740583   5.632390   5.898543
## NM_001042489        10.738015  10.349175  10.739315  10.585906  10.582356
## NM_008159            4.963567   4.791586   4.803562   4.957470   4.549076
##                    GSM1557225 GSM1557226 GSM1557227 GSM1557228 GSM1557229
## NM_009912            4.566955   4.195827   4.178300   4.479451   4.104872
## NM_008725           10.228634  12.318893   5.659962   5.909207   8.530658
## NM_007473            4.617328   4.944692   4.302535   4.677377   5.833652
## ENSMUST00000094955   6.139950   6.181067   6.185509   6.300034   5.961441
## NM_001042489        10.547606  10.601298  11.348000  11.055633  10.835023
## NM_008159            4.566955   4.833231   4.954521   4.985252   4.539907
##                    GSM1557230 GSM1557231 GSM1557232 GSM1557233 GSM1557234
## NM_009912            4.338895   4.485318   4.271684   4.596576   3.986399
## NM_008725            8.655709   9.740692   7.706644  11.805003  10.480871
## NM_007473            5.128607   4.932876   4.840597   4.869283   4.662460
## ENSMUST00000094955   5.966530   6.280827   6.109401   6.405668   6.612320
## NM_001042489        10.529988  11.044619  10.811322  11.083515  10.860076
## NM_008159            4.700197   4.902439   5.009781   5.494211   5.426557
##                    GSM1557235 GSM1557236 GSM1557237 GSM1557238 GSM1557239
## NM_009912            4.616836   4.749216   4.675015   4.273201   5.020403
## NM_008725            8.830427   9.679068   7.362256   7.071915   6.056961
## NM_007473            4.748060   6.905228   4.632717   4.499807   4.622592
## ENSMUST00000094955   6.143179   6.272634   6.532824   5.680097   5.793386
## NM_001042489        11.125786  11.114015  11.462637  10.157125  10.525139
## NM_008159            5.067383   6.146764   6.222246   5.986350   6.043572
##                    GSM1557240 GSM1557241 GSM1557242 GSM1557243 GSM1557244
## NM_009912            5.251089   4.966550   4.753445   3.941270   4.515665
## NM_008725           10.952893   9.109165  11.171724  12.438175  12.082368
## NM_007473            4.852832   5.357048   4.966219   4.984162   5.262957
## ENSMUST00000094955   5.805906   5.757401   6.151772   6.291113   6.345786
## NM_001042489        10.513729  10.457131  11.096552  10.569988  10.832037
## NM_008159            5.915311   5.857990   4.922212   4.677310   4.729183
##                    GSM1557245 GSM1557246 GSM1557247 GSM1557248 GSM1557249
## NM_009912            5.665276   6.488279   5.640857   5.882101   5.359026
## NM_008725            7.484742  14.269685   9.547562   6.822269   7.454090
## NM_007473            5.261968   5.724288   5.030260   5.556562   5.547032
## ENSMUST00000094955   5.760461   5.552008   5.720658   5.500171   5.418709
## NM_001042489         9.963723  10.001382   9.372102   9.976429   9.394465
## NM_008159            6.021210   6.758634   5.948449   6.103791   5.440692
##                    GSM1557250 GSM1557251 GSM1557252 GSM1557253 GSM1557254
## NM_009912            6.404324   4.609924   4.406698   4.368189   5.777961
## NM_008725            7.842379   8.999277  11.320822  11.470111   7.295824
## NM_007473            5.241174   4.966385   4.721615   6.120460   4.991179
## ENSMUST00000094955   5.557186   6.207257   5.773867   5.922330   5.841799
## NM_001042489         9.967169  10.384140  10.724393  10.699444   9.858504
## NM_008159            6.171807   4.942336   4.740721   4.906875   4.852235
##                    GSM1557255 GSM1557256 GSM1557257 GSM1557258 GSM1557259
## NM_009912            6.741990   5.592597   4.535077   4.554227   4.433064
## NM_008725           10.403716   8.452166  11.171890  12.752098  13.415204
## NM_007473            4.890037   4.692810   5.070211   4.781958   6.381461
## ENSMUST00000094955   5.323305   5.559859   5.843182   6.246366   6.093944
## NM_001042489         9.919964  10.048202  10.777057  10.984228  10.923453
## NM_008159            5.205133   4.894744   4.906875   4.739688   4.762501
##                    GSM1557260 GSM1557261 GSM1557262 GSM1557263 GSM1557264
## NM_009912            5.495435   5.523324   4.905033   5.503599   5.764879
## NM_008725            7.540585   6.174129   6.468902   7.206698   7.649929
## NM_007473            5.804240   4.491009   4.445790   4.689603   4.542871
## ENSMUST00000094955   5.463873   5.473692   5.254483   5.144017   5.022794
## NM_001042489        10.345236   9.972758  10.379279  10.856363  11.025982
## NM_008159            5.495435   4.874823   5.272055   5.503599   5.494555
##                    GSM1557265 GSM1557266 GSM1557267 GSM1557268 GSM1557269
## NM_009912            5.939306   3.987378   4.016140   4.362999   4.456915
## NM_008725            8.105093  10.856860  11.028350   5.770169   7.153733
## NM_007473            4.406861   4.747418   5.261294   4.940483   4.869578
## ENSMUST00000094955   5.460192   5.793043   5.992314   5.854356   6.050855
## NM_001042489        10.953786  10.591246  10.117323  10.522285  10.624859
## NM_008159            5.299966   4.291738   4.673393   4.760211   4.728922
##                    GSM1557270 GSM1557271 GSM1557272 GSM1557273 GSM1557274
## NM_009912            4.024435   4.495147   4.261639   4.117057   4.943234
## NM_008725            6.567563   8.728671   6.848437   6.540968   7.190716
## NM_007473            4.896889   5.013739   4.676230   4.543759   4.418370
## ENSMUST00000094955   6.132760   5.665344   5.861705   5.773677   5.524824
## NM_001042489        10.706000  10.330550  10.946127  10.562018  10.760353
## NM_008159            4.852354   4.670820   4.704770   4.508935   4.773462
##                    GSM1557275 GSM1557276 GSM1557277 GSM1557278 GSM1557279
## NM_009912            4.306029   4.493309   4.890677   4.576606   4.276678
## NM_008725            6.884850   7.983978   7.191790   7.506519   7.680313
## NM_007473            4.785216   4.805476   4.481461   5.256291   5.327737
## ENSMUST00000094955   6.015085   6.003857   6.008156   5.813015   6.027442
## NM_001042489        10.801883  11.138517  10.740201  10.872072  10.562141
## NM_008159            4.887416   4.892073   4.987539   4.850381   4.598287
##                    GSM1557280 GSM1557281 GSM1557282 GSM1557283 GSM1557284
## NM_009912            4.253609   5.618791   4.769608   4.915622   4.259928
## NM_008725            7.800147   8.005089   5.994008   6.118522   6.919488
## NM_007473            4.950843   4.023799   4.134163   4.144738   5.300185
## ENSMUST00000094955   5.832623   6.039170   5.869872   5.938405   5.903482
## NM_001042489        11.068374  10.519977  10.615778  10.512477  10.907005
## NM_008159            4.700197   6.189558   6.523698   6.156064   4.823204
##                    GSM1557285 GSM1557286 GSM1557287 GSM1557288 GSM1557289
## NM_009912            4.234026   4.176488   6.891772   5.346691   5.762242
## NM_008725            7.202261   6.758937  11.773523   8.139015  12.234747
## NM_007473            4.704704   5.033583   4.543759   4.592362   4.854861
## ENSMUST00000094955   5.727060   5.851848   5.805691   5.915711   5.870612
## NM_001042489        10.738422  10.557855  10.166769   9.947642   9.922876
## NM_008159            4.901053   4.675488   6.706266   6.682902   6.596033
##                    GSM1557290 GSM1557291 GSM1557292 GSM1557293 GSM1557294
## NM_009912            4.076104   4.359136   4.322166   5.891725   6.514570
## NM_008725            8.717734   6.613730   7.469349   6.626995  10.107581
## NM_007473            4.812862   4.635775   4.658639   4.542723   4.751396
## ENSMUST00000094955   5.906937   5.731549   5.901895   6.052494   6.017405
## NM_001042489        10.854057  11.067427  10.589244   9.858614  10.173731
## NM_008159            5.075083   5.075953   4.831350   7.018339   7.170199
##                    GSM1557295 GSM1557296 GSM1557297 GSM1557298 GSM1557299
## NM_009912            6.425463   4.728987   4.736843   4.955578   5.651985
## NM_008725            7.355484   7.951215   8.239082   8.481296   7.489405
## NM_007473            4.620629   4.677580   4.604472   4.624692   4.595006
## ENSMUST00000094955   6.197058   5.908030   5.836131   5.785648   6.059861
## NM_001042489         9.815571  10.649139  10.872880  10.682476  10.239906
## NM_008159            7.051797   5.929429   5.458467   5.894717   6.438657
##                    GSM1557300 GSM1557301 GSM1557302 GSM1557303 GSM1557304
## NM_009912            5.366909   5.934206   4.202313   3.974698   4.470994
## NM_008725            6.553279   7.140028   5.760588   7.652478   6.033148
## NM_007473            4.570155   4.131113   4.576461   4.454084   4.829652
## ENSMUST00000094955   6.265965   6.129214   6.000869   5.907800   5.676761
## NM_001042489         9.684611   9.913968  10.550902   9.841509  10.604800
## NM_008159            6.325956   6.779713   4.457073   4.299997   4.406861
##                    GSM1557305 GSM1557306 GSM1557307 GSM1557308 GSM1557309
## NM_009912            4.132393   4.121029   5.515498   5.352998   5.049671
## NM_008725            7.610869   7.349823   7.758313   7.944175   7.151428
## NM_007473            4.797927   4.783713   5.045287   5.150056   5.256968
## ENSMUST00000094955   5.975089   5.681678   5.532227   5.520808   5.770962
## NM_001042489        10.638098  10.179589  10.371040  10.773311  10.676827
## NM_008159            4.797927   4.229709   6.410749   5.928721   5.461642
##                    GSM1557310 GSM1557311 GSM1557312 GSM1557313 GSM1557314
## NM_009912            5.895471   6.117553   5.285084   5.779818   6.473009
## NM_008725            8.142710   6.671533   7.826050   7.355347   7.502631
## NM_007473            3.939021   4.378846   3.824067   5.169129   5.155586
## ENSMUST00000094955   6.060482   5.938827   6.155615   5.614993   5.655070
## NM_001042489         9.896207   9.999910   9.707916  10.435800  10.028116
## NM_008159            5.588012   6.017405   6.046708   6.154682   6.089793
##                    GSM1557315 GSM1557316 GSM1557317 GSM1557318 GSM1557319
## NM_009912            4.894570   6.675795   7.213355   7.448181   4.442302
## NM_008725            8.058749   6.706531   6.931304   8.024846   6.976459
## NM_007473            5.421090   4.210539   4.744202   4.404092   5.456503
## ENSMUST00000094955   5.919225   6.030878   6.261698   6.218404   5.784459
## NM_001042489        11.066946  10.030803   9.910902  10.181236  10.468105
## NM_008159            5.232981   5.594563   5.566030   5.936152   4.679803
##                    GSM1557320 GSM1557321 GSM1557322 GSM1557323 GSM1557324
## NM_009912            4.741495   4.724817   4.178109   4.348753   4.366517
## NM_008725            7.358227  11.398423   7.343479   6.891888   7.612510
## NM_007473            5.202933   4.724817   4.683505   4.753317   4.829288
## ENSMUST00000094955   5.690228   5.928012   6.050021   5.655689   6.032278
## NM_001042489        10.610505  10.088188  10.323816  10.632239  10.360863
## NM_008159            4.764280   4.790962   4.821130   4.985361   4.769354
##                    GSM1557325 GSM1557326 GSM1557327 GSM1557328 GSM1557329
## NM_009912            6.086775   6.649592   7.802700   7.559699   7.029615
## NM_008725           10.211881   8.649701   7.935881   7.052052   8.331449
## NM_007473            4.527165   5.182024   5.097034   4.686926   4.440077
## ENSMUST00000094955   5.732880   5.834892   5.827131   5.933839   5.952802
## NM_001042489         9.773700   9.575058   9.983578   9.732743   9.735889
## NM_008159            5.952718   5.259448   5.641030   5.701682   5.648033
##                    GSM1557330 GSM1557331 GSM1557332 GSM1557333 GSM1557334
## NM_009912            7.145478   4.691341   4.631465   4.735807   4.280324
## NM_008725            7.167500   6.768800   7.260401   7.038833   6.106649
## NM_007473            4.153302   5.367495   5.465982   4.863897   4.561119
## ENSMUST00000094955   5.977967   5.949566   6.030350   6.185082   6.290782
## NM_001042489         9.769932  10.535064  10.754887  10.489776  10.513604
## NM_008159            5.893351   4.835952   4.842163   5.134760   5.005704
##                    GSM1557335 GSM1557336 GSM1557337 GSM1557338 GSM1557339
## NM_009912            4.499426   4.546346   6.242130   6.939626   6.606063
## NM_008725            6.918804   7.572455   6.700037   7.213355   7.566364
## NM_007473            5.023166   5.020669   4.578850   4.421997   4.527689
## ENSMUST00000094955   6.062187   5.884790   5.817063   5.718890   5.834257
## NM_001042489        10.753943   9.977372   9.945485   9.651664   9.596188
## NM_008159            4.985143   4.696741   5.740454   6.106123   5.269641
##                    GSM1557340 GSM1557341 GSM1557342 GSM1557343 GSM1557344
## NM_009912            7.447351   7.344817   7.922137   7.726694   7.846047
## NM_008725            7.331975   7.556927   7.303713   7.310386   8.398339
## NM_007473            4.360481   4.475112   4.416028   4.407186   4.713611
## ENSMUST00000094955   5.758677   5.686011   5.758103   5.502533   5.610762
## NM_001042489         9.958154  10.165567  10.163314  10.120078  10.338992
## NM_008159            4.835650   5.749498   5.449370   5.698628   6.032014
##                    GSM1557345 GSM1557346 GSM1557347 GSM1557348
## NM_009912            8.206850   7.372074   6.531295   7.327079
## NM_008725            7.883068   7.892620   8.579038   7.868487
## NM_007473            4.440872   4.426017   4.786905   4.694543
## ENSMUST00000094955   5.433801   6.073381   5.929202   5.878233
## NM_001042489         9.797462  10.319121   9.178391  10.107715
## NM_008159            5.649718   5.062796   4.856292   4.948274
```

If you use this dataset, please cite:

```
@article{shoemaker:ultrasensitive,
    author={Shoemaker, J. E. AND Fukuyama, S. AND Eisfeld, A. J. AND Zhao,
    Dongming AND Kawakami, Eiryo AND Sakabe, Saori AND Maemura, Tadashi AND Gorai,
    Takeo AND Katsura, Hiroaki AND Muramoto, Yukiko AND Watanabe, Shinji AND
    Watanabe, Tokiko AND Fuji, Ken AND Matsuoka, Yukiko AND Kitano, Hiroaki AND
    Kawaoka, Yoshihiro},
    isbn = {1553-7366},
    issn = {15537374},
    journal = {PLoS Pathogens},
    number = {6},
    pages = {1--25},
    pmid = {26046528},
    title = {{An Ultrasensitive Mechanism Regulates Influenza Virus-Induced Inflammation}},
    volume = {11},
    year = {2015},
}
```

## Transcriptomic analysis of field-droughted sorghum from seedling to maturity reveals biotic and metabolic responses

This pairs of datasets (`varoquaux2019leaf` and `varoquaux2019root`)
corresponds to transcriptomic data from respectively leaf and root samples of
*S. bicolor* exposed to droughts (pre-flowering and post-flowering drougt)
from seedling to maturity. Samples were collected weekly during 15 weeks.
The data provided here is not normalized. Please note that the root and leaf
samples were processed and sequenced as two separate batches. Any comparison
between the two datasets should thus be done with care.

```
data(varoquaux2019leaf)
nrow(varoquaux2019leaf$data)
```

```
## [1] 34211
```

```
ncol(varoquaux2019leaf$data)
```

```
## [1] 197
```

The metadata associated to these datasets are more complete than the
`shoemaker2015` one: it contains 69 fields in total. Amongst the most relevant
are the following:

| column | description |
| --- | --- |
| `Block` | The block the plant was grown into. |
| `Week` | Which week this sample was collected on. |
| `Genotype` | RTx430 (pre-flowering tolerant) or BTx642 (stay-green postflowering resistant). |
| `Condition` | Control, preflowering drought, or postflowering drought. |
| `Day` | Which day this sample was collected on. |
| `Row` | Which row this plant was grown on. |
| `No.plants.pooled` | The number of unique plants collected to create this sample. |
| `Plate` | Sequencing plate. |

For more information, consult the methods and supplementary methods of
Varoquaux et al (2019).

If you use these datasets, please cite:

```
@article{varoquaux:transcriptomic,
        author = {Varoquaux, N. and Cole, B. and Gao, C. and Pierroz, G. and Baker, C. R. and Patel, D. and Madera, M. and Jeffers, T. and Hollingsworth, J. and Sievert, J. and Yoshinaga, Y. and Owiti, J. A. and Singan, V. R. and DeGraaf, S. and Xu, L. and Blow, M. J. and Harrison, M. J. and Visel, A. and Jansson, C. and Niyogi, K. K. and Hutmacher, R. and Coleman-Derr, D. and O{\textquoteright}Malley, R. C. and Taylor, J. W. and Dahlberg, J. and Vogel, J. P. and Lemaux, P. G. and Purdom, E.},
        title = {Transcriptomic analysis of field-droughted sorghum from seedling to maturity reveals biotic and metabolic responses},
        elocation-id = {201907500},
        year = {2019},
        doi = {10.1073/pnas.1907500116},
        publisher = {National Academy of Sciences},
        abstract = {Understanding the molecular response of plants to drought is critical to efforts to improve agricultural yields under increasingly frequent droughts. We grew 2 cultivars of the naturally drought-tolerant food crop sorghum in the field under drought stress. We sequenced the mRNA from weekly samples of these plants, resulting in a molecular profile of drought response over the growing season. We find molecular differences in the 2 cultivars that help explain their differing tolerances to drought and evidence of a disruption in the plant{\textquoteright}s symbiosis with arbuscular mycorrhizal fungi. Our findings are of practical importance for agricultural breeding programs, while the resulting data are a resource for the plant and microbial communities for studying the dynamics of drought response.Drought is the most important environmental stress limiting crop yields. The C4 cereal sorghum [Sorghum bicolor (L.) Moench] is a critical food, forage, and emerging bioenergy crop that is notably drought-tolerant. We conducted a large-scale field experiment, imposing preflowering and postflowering drought stress on 2 genotypes of sorghum across a tightly resolved time series, from plant emergence to postanthesis, resulting in a dataset of nearly 400 transcriptomes. We observed a fast and global transcriptomic response in leaf and root tissues with clear temporal patterns, including modulation of well-known drought pathways. We also identified genotypic differences in core photosynthesis and reactive oxygen species scavenging pathways, highlighting possible mechanisms of drought tolerance and of the delayed senescence, characteristic of the stay-green phenotype. Finally, we discovered a large-scale depletion in the expression of genes critical to arbuscular mycorrhizal (AM) symbiosis, with a corresponding drop in AM fungal mass in the plants{\textquoteright} roots.},
        issn = {0027-8424},
        URL = {https://www.pnas.org/content/early/2019/12/04/1907500116},
        eprint = {https://www.pnas.org/content/early/2019/12/04/1907500116.full.pdf},
        journal = {Proceedings of the National Academy of Sciences}
}
```