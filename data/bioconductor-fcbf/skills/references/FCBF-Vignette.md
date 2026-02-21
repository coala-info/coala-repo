# FCBF : Fast Correlation Based Filter for Feature Selection

#### *Tiago Lubiana*

#### *2019-01-04*

```
library(knitr)
knitr::opts_chunk$set(
collapse = TRUE,
comment = "#>"
)
```

# Introduction

The FCBF package is a R implementation of an algorithm developed by Yu and Liu, 2003 : Feature Selection for High-Dimensional Data: A Fast Correlation-Based Filter Solution.

The algorithm described in the article and implemented here uses the idea of “predominant correlation”. It selects features in a classifier-independent manner, selecting features with high correlation with the target variable, but little correlation with other variables. Notably, the correlation used here is not the classical Pearson or Spearman correlations, but Symmetrical Uncertainty (SU).

The symmetrical uncertainty is based on information theory, drawing from the concepts of Shannon entropy and information gain. A detailed description is outside the scope of this vignette, but these details are described comprehensively in the Yu and Liu, 2003.

Initially, the algorithm selects features correlated above a given threshold by SU with the class variable. After this initial filtering, it detects predominant correlations of features with the class. The definition is that, for a predominant feature “X”, no other feature is more correlated to “X” than “X”" is to the class.

The features more correlated with X than with the class are then tested, and either X, or any other feature from this correlation group, emerges as the predominant correlation feature. Once more, the detailed description is available in Yu and Liu, 2003.

# Usage

## Discretizing gene expression

The first step to use FCBF is to install FCBF and load the sample data. Expression data from single macrophages is used as an example of how to apply the method to expression data.

```
BiocManager::install("FCBF")
```

```
library("FCBF")
library(SummarizedExperiment)
#> Loading required package: GenomicRanges
#> Loading required package: stats4
#> Loading required package: BiocGenerics
#> Loading required package: parallel
#>
#> Attaching package: 'BiocGenerics'
#> The following objects are masked from 'package:parallel':
#>
#>     clusterApply, clusterApplyLB, clusterCall, clusterEvalQ,
#>     clusterExport, clusterMap, parApply, parCapply, parLapply,
#>     parLapplyLB, parRapply, parSapply, parSapplyLB
#> The following objects are masked from 'package:stats':
#>
#>     IQR, mad, sd, var, xtabs
#> The following objects are masked from 'package:base':
#>
#>     Filter, Find, Map, Position, Reduce, anyDuplicated, append,
#>     as.data.frame, basename, cbind, colMeans, colSums, colnames,
#>     dirname, do.call, duplicated, eval, evalq, get, grep, grepl,
#>     intersect, is.unsorted, lapply, lengths, mapply, match, mget,
#>     order, paste, pmax, pmax.int, pmin, pmin.int, rank, rbind,
#>     rowMeans, rowSums, rownames, sapply, setdiff, sort, table,
#>     tapply, union, unique, unsplit, which, which.max, which.min
#> Loading required package: S4Vectors
#>
#> Attaching package: 'S4Vectors'
#> The following object is masked from 'package:base':
#>
#>     expand.grid
#> Loading required package: IRanges
#> Loading required package: GenomeInfoDb
#> Loading required package: Biobase
#> Welcome to Bioconductor
#>
#>     Vignettes contain introductory material; view with
#>     'browseVignettes()'. To cite Bioconductor, see
#>     'citation("Biobase")', and for packages 'citation("pkgname")'.
#> Loading required package: DelayedArray
#> Loading required package: matrixStats
#>
#> Attaching package: 'matrixStats'
#> The following objects are masked from 'package:Biobase':
#>
#>     anyMissing, rowMedians
#> Loading required package: BiocParallel
#>
#> Attaching package: 'DelayedArray'
#> The following objects are masked from 'package:matrixStats':
#>
#>     colMaxs, colMins, colRanges, rowMaxs, rowMins, rowRanges
#> The following objects are masked from 'package:base':
#>
#>     aperm, apply
# load expression data
data(scDengue)
exprs <- SummarizedExperiment::assay(scDengue,'logcounts')
#> Loading required package: SingleCellExperiment
head(exprs[,1:4])
#>                 1001700604_A13 1001700604_A16 1001700604_A20
#> ENSG00000000003       6.593133       5.817558       6.985514
#> ENSG00000000419       4.284856       0.000000       5.252389
#> ENSG00000000457       0.000000       4.252808       1.135761
#> ENSG00000000460       0.000000       0.000000       1.135761
#> ENSG00000000971       0.000000       0.000000       0.000000
#> ENSG00000001036       6.071789       7.353848       8.072563
#>                 1001700604_C21
#> ENSG00000000003       6.736407
#> ENSG00000000419       5.579961
#> ENSG00000000457       0.000000
#> ENSG00000000460       0.000000
#> ENSG00000000971       0.000000
#> ENSG00000001036       7.361245
```

This normalized single cell expression can be used in machine learning (ML) models to obtain classifiers for dengue x control macrophage. One of the ideas behind the ML approach to RNA-Seq data is to use features that are important for classification as biomarkers, for experimental characterization and inference of involved pathways. Overfitting and extensive computational time are, thus big problems that feature selection intends to help.

For the feature selection approach implemented here, the gene expression has to be discretized, as the entropy concept behind the symmetrical uncertainty is built upon discrete classes.

There is no consensus of the optimal way of discretizing gene expression, and this is even more true to single cell RNA-Seq. The function simply gets the range of expression (min to max) for each gene and assigns the first third the label of “low” and, to the other two, the label of “high”. In this way, all the zeros and low expression values are assigned the label “low” in a gene-dependent manner.

Notably, this step is only done for variable selection. When you fit machine learning models with those variables, you can still use the original, continuous, numeric, features.

```
# discretize expression data
discrete_expression <- as.data.frame(discretize_exprs(exprs))

head(discrete_expression[,1:4])
#>                   V1   V2   V3   V4
#> ENSG00000000003 high high high high
#> ENSG00000000419 high  low high high
#> ENSG00000000457  low high  low  low
#> ENSG00000000460  low  low  low  low
#> ENSG00000000971  low  low  low  low
#> ENSG00000001036 high high high high
```

## Selecting features

The filter approaches as FCBF do not target a specific machine learning model. However, they are supervised approaches, requiring you to give a target variable as input. In this case, we have two classes: dengue infected and not infected macrophages.

```
#load annotation data
infection <- SummarizedExperiment::colData(scDengue)

# get the class variable
#(note, the order of the samples is the same as in the exprs file)
target <- infection$infection
```

Having a class variable and a discrete, categorical feature table, we can run the function fcbf. The code as follows would run for a minute or two and generate an error.

```
# you only need to run that if you want to see the error for yourself
# fcbf_features <- fcbf(discrete_expression, target, verbose = TRUE)
```

As you can see, we get an error.

That is because the built-in threshold for the SU, 0.25, is too high for this data set. You can use the function to decide for yourself which threshold is the best. In this way you can see the distribution of correlations (as calculated from symmetrical uncertainty) for each variable with the target classes.

```
su_plot(discrete_expression,target)
```

![](data:image/png;base64...)

Seems like 0.05 is something reasonable for this dataset. This changes, of course, the number of features selected. A lower threshold will explore more features, but they will have less relation to the target variable. Let’s run it again with the new threshold.

```
fcbf_features <- fcbf(discrete_expression, target, thresh = 0.05, verbose = TRUE)
#> Calculating symmetrical uncertainties
#> [1] "Number of prospective features =  480"
#> Round 1
#> [1] "first_prime  round ( |s_prime| = 480 )"
#>    0.116359   0.1036008   Removed feature  4589
#>    0.1078977   0.0913877   Removed feature  4660
#>    0.09176242   0.08438722   Removed feature  13222
#>    0.1220288   0.08068918   Removed feature  12449
#>    0.09276006   0.06876466   Removed feature  14910
#>    0.1851523   0.06876466   Removed feature  15070
#>    0.1048565   0.06867071   Removed feature  16243
#>    0.07358359   0.06754892   Removed feature  19112
#>    0.08096923   0.06635711   Removed feature  9474
#>    0.1072117   0.06384414   Removed feature  10497
#>    0.067275   0.0612623   Removed feature  9432
#>    0.08445816   0.05977561   Removed feature  3507
#>    0.06196816   0.05910465   Removed feature  4610
#>    0.06196816   0.05910465   Removed feature  16938
#>    0.06789637   0.05674172   Removed feature  7259
#>    0.06789637   0.05674172   Removed feature  12038
#>    0.06358669   0.05642788   Removed feature  3057
#>    0.06358669   0.05642788   Removed feature  9071
#>    0.06358669   0.05642788   Removed feature  9847
#>    0.06358669   0.05642788   Removed feature  9976
#>    0.06358669   0.05642788   Removed feature  10086
#>    0.1523932   0.05642788   Removed feature  11857
#>    0.06358669   0.05642788   Removed feature  12112
#>    0.06358669   0.05642788   Removed feature  12532
#>    0.06358669   0.05642788   Removed feature  13198
#>    0.06358669   0.05642788   Removed feature  14447
#>    0.1523932   0.05642788   Removed feature  14637
#>    0.06358669   0.05642788   Removed feature  15391
#>    0.06358669   0.05642788   Removed feature  16796
#>    0.06358669   0.05642788   Removed feature  17632
#>    0.06358669   0.05642788   Removed feature  18092
#>    0.06358669   0.05642788   Removed feature  19417
#>    0.05962547   0.05612361   Removed feature  11874
#>    0.07056926   0.05503376   Removed feature  369
#>    0.05986576   0.05486082   Removed feature  2910
#>    0.05707103   0.05404904   Removed feature  2157
#>    0.07959675   0.05285584   Removed feature  1952
#>    0.07268261   0.05105315   Removed feature  10540
#>    0.07268261   0.05105315   Removed feature  18376
#> Round 2
#> [1] "first_prime  round ( |s_prime| = 441 )"
#>    0.1016254   0.09228038   Removed feature  5281
#>    0.08635973   0.08436036   Removed feature  5541
#>    0.08369102   0.07648799   Removed feature  11833
#>    0.08600332   0.06876466   Removed feature  7039
#>    0.08600332   0.06876466   Removed feature  13004
#>    0.08600332   0.06876466   Removed feature  15741
#>    0.079347   0.05768739   Removed feature  11683
#>    0.1174576   0.05766186   Removed feature  10584
#>    0.119875   0.05642788   Removed feature  17794
#>    0.05855997   0.05503376   Removed feature  962
#>    0.06775217   0.05285584   Removed feature  208
#>    0.06799014   0.05247049   Removed feature  3598
#>    0.06799014   0.05247049   Removed feature  17181
#>    0.06019224   0.05127485   Removed feature  4234
#>    0.05252438   0.05127485   Removed feature  8068
#>    0.06019224   0.05127485   Removed feature  12460
#> Round 3
#> [1] "first_prime  round ( |s_prime| = 425 )"
#>    0.1464177   0.07016844   Removed feature  4964
#>    0.0936669   0.06876466   Removed feature  2447
#>    0.0936669   0.06876466   Removed feature  12895
#>    0.0936669   0.06876466   Removed feature  16146
#>    0.0936669   0.06876466   Removed feature  17758
#>    0.06843692   0.0612623   Removed feature  4649
#>    0.0996089   0.05941037   Removed feature  4555
#>    0.0674636   0.05941037   Removed feature  17784
#>    0.1283218   0.05766186   Removed feature  17773
#>    0.1291887   0.05642788   Removed feature  4281
#>    0.1291887   0.05642788   Removed feature  10770
#>    0.1291887   0.05642788   Removed feature  13930
#>    0.1291887   0.05642788   Removed feature  17544
#>    0.07216736   0.05434007   Removed feature  7207
#>    0.05746292   0.05404904   Removed feature  7600
#>    0.07951287   0.05250286   Removed feature  13777
#>    0.07951287   0.05250286   Removed feature  18169
#>    0.06479171   0.05247049   Removed feature  6523
#>    0.05741666   0.05127485   Removed feature  12437
#>    0.08673095   0.05105315   Removed feature  10964
#>    0.08673095   0.05105315   Removed feature  11169
#> Round 4
#> [1] "first_prime  round ( |s_prime| = 404 )"
#>    0.08948074   0.07149493   Removed feature  14142
#>    0.07532123   0.07088179   Removed feature  2574
#>    0.07304717   0.06876466   Removed feature  2706
#>    0.07304717   0.06876466   Removed feature  3289
#>    0.07304717   0.06876466   Removed feature  5964
#>    0.07304717   0.06876466   Removed feature  5973
#>    0.07304717   0.06876466   Removed feature  8808
#>    0.1695358   0.06876466   Removed feature  14141
#>    0.07304717   0.06876466   Removed feature  15571
#>    0.07304717   0.06876466   Removed feature  15751
#>    0.1279643   0.06754892   Removed feature  15481
#>    0.07508596   0.06669289   Removed feature  1803
#>    0.06977783   0.06666784   Removed feature  12761
#>    0.06043125   0.05891998   Removed feature  4210
#>    0.06510715   0.05873235   Removed feature  5835
#>    0.07608747   0.05768739   Removed feature  8122
#>    0.07748155   0.05766186   Removed feature  3166
#>    0.09765531   0.05642788   Removed feature  8181
#>    0.09765531   0.05642788   Removed feature  9883
#>    0.09765531   0.05642788   Removed feature  9936
#>    0.09765531   0.05642788   Removed feature  17987
#>    0.09765531   0.05642788   Removed feature  18968
#>    0.07917611   0.05293989   Removed feature  11048
#>    0.06951454   0.05070877   Removed feature  2269
#> Round 5
#> [1] "first_prime  round ( |s_prime| = 380 )"
#>    0.1109944   0.09228038   Removed feature  13522
#>    0.1356017   0.08068918   Removed feature  10652
#>    0.07892493   0.06885652   Removed feature  636
#>    0.07304717   0.06876466   Removed feature  8044
#>    0.07304717   0.06876466   Removed feature  16005
#>    0.07304717   0.06876466   Removed feature  16048
#>    0.06863258   0.06378771   Removed feature  12031
#>    0.06798671   0.05977865   Removed feature  1138
#>    0.06291829   0.05977561   Removed feature  5016
#>    0.07533398   0.05891998   Removed feature  6999
#>    0.06510715   0.05873235   Removed feature  2266
#>    0.07608747   0.05768739   Removed feature  10268
#>    0.07748155   0.05766186   Removed feature  14405
#>    0.09765531   0.05642788   Removed feature  11739
#>    0.09765531   0.05642788   Removed feature  14317
#>    0.09765531   0.05642788   Removed feature  16344
#>    0.09765531   0.05642788   Removed feature  16610
#>    0.09765531   0.05642788   Removed feature  17878
#>    0.06275961   0.05612361   Removed feature  10515
#>    0.1429983   0.05127485   Removed feature  4404
#>    0.06951454   0.05070877   Removed feature  8141
#> Round 6
#> [1] "first_prime  round ( |s_prime| = 359 )"
#>    0.1041843   0.09734421   Removed feature  1703
#>    0.0914452   0.08296017   Removed feature  1190
#>    0.08315278   0.07746361   Removed feature  820
#>    0.09358797   0.07149493   Removed feature  928
#>    0.07221848   0.06876466   Removed feature  8581
#>    0.09807764   0.06378771   Removed feature  75
#>    0.1283984   0.0614712   Removed feature  2942
#>    0.1041843   0.0612623   Removed feature  15850
#>    0.1205219   0.05766186   Removed feature  15594
#>    0.1092189   0.05766186   Removed feature  16416
#>    0.05925563   0.05642788   Removed feature  4291
#>    0.05925563   0.05642788   Removed feature  8052
#>    0.05925563   0.05642788   Removed feature  16773
#>    0.05925563   0.05642788   Removed feature  16916
#>    0.05925563   0.05642788   Removed feature  18381
#>    0.06604838   0.05404904   Removed feature  6382
#>    0.05657706   0.05404904   Removed feature  17549
#>    0.06089232   0.05285584   Removed feature  5339
#>    0.05417052   0.05267052   Removed feature  3965
#> Round 7
#> [1] "first_prime  round ( |s_prime| = 340 )"
#>    0.1212837   0.06876466   Removed feature  18759
#>    0.07532123   0.06754892   Removed feature  8298
#>    0.09958094   0.05642788   Removed feature  3553
#>    0.09958094   0.05642788   Removed feature  13640
#>    0.09958094   0.05642788   Removed feature  17320
#>    0.06357042   0.05434007   Removed feature  6628
#>    0.07052858   0.05127485   Removed feature  6355
#> Round 8
#> [1] "first_prime  round ( |s_prime| = 333 )"
#>    0.1159096   0.08068918   Removed feature  13343
#>    0.09232719   0.0789382   Removed feature  1258
#>    0.08302952   0.06732315   Removed feature  4823
#>    0.1084441   0.06732315   Removed feature  10115
#>    0.07472244   0.0612623   Removed feature  10825
#>    0.07022355   0.05929839   Removed feature  1740
#>    0.07870591   0.05910465   Removed feature  5481
#>    0.1037059   0.05486082   Removed feature  2776
#>    0.1117818   0.053266   Removed feature  13913
#>    0.0535809   0.05127485   Removed feature  7790
#> Round 9
#> [1] "first_prime  round ( |s_prime| = 323 )"
#>    0.09832649   0.06876466   Removed feature  2421
#>    0.09832649   0.06876466   Removed feature  11971
#>    0.06414081   0.06378771   Removed feature  18562
#>    0.06153282   0.0612623   Removed feature  16022
#>    0.05940665   0.05711994   Removed feature  5219
#>    0.1281063   0.05642788   Removed feature  10461
#>    0.2783288   0.05642788   Removed feature  12847
#>    0.1281063   0.05642788   Removed feature  12873
#>    0.1281063   0.05642788   Removed feature  14245
#>    0.1281063   0.05642788   Removed feature  14280
#>    0.1281063   0.05642788   Removed feature  14976
#>    0.07010613   0.05250286   Removed feature  8549
#>    0.07010613   0.05250286   Removed feature  11510
#> Round 10
#> [1] "first_prime  round ( |s_prime| = 310 )"
#>    0.1770307   0.08068918   Removed feature  6596
#>    0.1770307   0.08068918   Removed feature  12741
#>    0.0802048   0.07746361   Removed feature  9489
#>    0.1301207   0.0760732   Removed feature  10846
#>    0.1097144   0.07016844   Removed feature  10050
#>    0.08023478   0.07000017   Removed feature  4559
#>    0.07333801   0.06885652   Removed feature  19195
#>    0.09832649   0.06876466   Removed feature  2874
#>    0.09832649   0.06876466   Removed feature  5071
#>    0.09832649   0.06876466   Removed feature  13898
#>    0.2176082   0.06876466   Removed feature  16727
#>    0.09832649   0.06876466   Removed feature  17677
#>    0.1448846   0.0629054   Removed feature  727
#>    0.07849356   0.0614712   Removed feature  11414
#>    0.06153282   0.0612623   Removed feature  2213
#>    0.06153282   0.0612623   Removed feature  8736
#>    0.0679099   0.05887071   Removed feature  6546
#>    0.1068115   0.05766186   Removed feature  18552
#>    0.1281063   0.05642788   Removed feature  5934
#>    0.1281063   0.05642788   Removed feature  8785
#>    0.1281063   0.05642788   Removed feature  9405
#>    0.1281063   0.05642788   Removed feature  12341
#>    0.1281063   0.05642788   Removed feature  15078
#>    0.1281063   0.05642788   Removed feature  17685
#>    0.2783288   0.05642788   Removed feature  18017
#>    0.07010613   0.05250286   Removed feature  7891
#>    0.07010613   0.05250286   Removed feature  9203
#>    0.07010613   0.05250286   Removed feature  10498
#>    0.07010613   0.05250286   Removed feature  13893
#> Round 11
#> [1] "first_prime  round ( |s_prime| = 281 )"
#>    0.09832649   0.06876466   Removed feature  3693
#>    0.09832649   0.06876466   Removed feature  11135
#>    0.06414081   0.06378771   Removed feature  294
#>    0.1998421   0.0612623   Removed feature  8367
#>    0.1068115   0.05766186   Removed feature  5789
#>    0.1281063   0.05642788   Removed feature  13638
#>    0.1281063   0.05642788   Removed feature  16663
#>    0.05792393   0.05070877   Removed feature  10481
#> Round 12
#> [1] "first_prime  round ( |s_prime| = 273 )"
#>    0.09164748   0.08068918   Removed feature  16983
#>    0.1149158   0.07866886   Removed feature  5046
#>    0.08512585   0.07016844   Removed feature  7579
#>    0.08512585   0.07016844   Removed feature  9136
#>    0.09184859   0.06669289   Removed feature  2719
#>    0.05910377   0.05766186   Removed feature  6023
#>    0.1214145   0.05642788   Removed feature  13355
#>    0.07432117   0.05612361   Removed feature  7174
#>    0.05655515   0.05285584   Removed feature  3751
#>    0.09261883   0.05267052   Removed feature  13685
#>    0.0822624   0.05250286   Removed feature  4497
#>    0.05389997   0.05127485   Removed feature  16919
#> Round 13
#> [1] "first_prime  round ( |s_prime| = 261 )"
#>    0.09865448   0.08068918   Removed feature  14418
#>    0.07605952   0.07395098   Removed feature  7469
#>    0.06895511   0.05642788   Removed feature  1173
#>    0.06895511   0.05642788   Removed feature  8851
#>    0.06895511   0.05642788   Removed feature  9061
#>    0.06895511   0.05642788   Removed feature  11345
#>    0.06895511   0.05642788   Removed feature  12030
#>    0.06895511   0.05642788   Removed feature  15471
#>    0.06895511   0.05642788   Removed feature  17217
#>    0.07581339   0.05105315   Removed feature  319
#> Round 14
#> [1] "first_prime  round ( |s_prime| = 251 )"
#>    0.08375407   0.08068918   Removed feature  15610
#>    0.1379635   0.06876466   Removed feature  14267
#>    0.09031493   0.0673556   Removed feature  16641
#>    0.1095175   0.05977561   Removed feature  35
#>    0.06228837   0.05766186   Removed feature  19013
#>    0.1133433   0.05642788   Removed feature  16145
#>    0.07908767   0.05250286   Removed feature  16341
#>    0.05294781   0.05200404   Removed feature  9384
#> Round 15
#> [1] "first_prime  round ( |s_prime| = 243 )"
#>    0.1074551   0.07737111   Removed feature  17916
#>    0.07240253   0.06669289   Removed feature  2465
#>    0.07448309   0.06669289   Removed feature  10376
#>    0.1158529   0.0612623   Removed feature  8418
#>    0.09124396   0.05766186   Removed feature  7705
#>    0.09728506   0.05642788   Removed feature  9890
#>    0.09728506   0.05642788   Removed feature  18380
#>    0.08836744   0.05105315   Removed feature  1866
#>    0.059257   0.05105315   Removed feature  9967
#>    0.08836744   0.05105315   Removed feature  10031
#> Round 16
#> [1] "first_prime  round ( |s_prime| = 233 )"
#>    0.08344447   0.06378771   Removed feature  6558
#>    0.06556622   0.05766186   Removed feature  9849
#>    0.1061068   0.05642788   Removed feature  1924
#>    0.1061068   0.05642788   Removed feature  17718
#> Round 17
#> [1] "first_prime  round ( |s_prime| = 229 )"
#>    0.2057366   0.08068918   Removed feature  18817
#>    0.2011996   0.07920144   Removed feature  8691
#>    0.1158938   0.06876466   Removed feature  8271
#>    0.1158938   0.06876466   Removed feature  14426
#>    0.1158938   0.06876466   Removed feature  14428
#>    0.1491991   0.05642788   Removed feature  17961
#>    0.05809932   0.05434007   Removed feature  117
#>    0.1128649   0.053266   Removed feature  4876
#> Round 18
#> [1] "first_prime  round ( |s_prime| = 221 )"
#>    0.09271287   0.08068918   Removed feature  4735
#>    0.09271287   0.08068918   Removed feature  17964
#>    0.1109944   0.06754892   Removed feature  17907
#>    0.1045017   0.05929839   Removed feature  1029
#>    0.08177214   0.05929839   Removed feature  8409
#>    0.1491991   0.05642788   Removed feature  4976
#>    0.1491991   0.05642788   Removed feature  14803
#>    0.05809932   0.05434007   Removed feature  18718
#>    0.07321866   0.05247049   Removed feature  10014
#> Round 19
#> [1] "first_prime  round ( |s_prime| = 212 )"
#>    0.09271287   0.08068918   Removed feature  1315
#>    0.09271287   0.08068918   Removed feature  14463
#>    0.09271287   0.08068918   Removed feature  16059
#>    0.1158938   0.06876466   Removed feature  9979
#>    0.1158938   0.06876466   Removed feature  14547
#>    0.05451909   0.05070877   Removed feature  1096
#> Round 20
#> [1] "first_prime  round ( |s_prime| = 206 )"
#>    0.1727603   0.09228038   Removed feature  16734
#>    0.09564927   0.09132275   Removed feature  12737
#>    0.09336457   0.07578735   Removed feature  1994
#>    0.1158938   0.06876466   Removed feature  11088
#>    0.1158938   0.06876466   Removed feature  12749
#>    0.06771635   0.05977561   Removed feature  12352
#>    0.1491991   0.05642788   Removed feature  6974
#>    0.09336457   0.05127485   Removed feature  922
#> Round 21
#> [1] "first_prime  round ( |s_prime| = 198 )"
#>    0.2057366   0.08068918   Removed feature  15195
#>    0.0798408   0.06689538   Removed feature  3468
#>    0.06771635   0.05977561   Removed feature  2381
#>    0.1491991   0.05642788   Removed feature  15164
#>    0.1491991   0.05642788   Removed feature  17463
#>    0.06073535   0.05105315   Removed feature  15270
#> Round 22
#> [1] "first_prime  round ( |s_prime| = 192 )"
#>    0.0803601   0.07109842   Removed feature  5365
#>    0.09564927   0.06885652   Removed feature  7462
#>    0.1158938   0.06876466   Removed feature  16832
#>    0.1158938   0.06876466   Removed feature  17553
#>    0.1491991   0.05642788   Removed feature  9806
#>    0.1491991   0.05642788   Removed feature  9943
#> Round 23
#> [1] "first_prime  round ( |s_prime| = 186 )"
#>    0.06073877   0.05642788   Removed feature  6170
#>    0.06073877   0.05642788   Removed feature  6246
#>    0.06073877   0.05642788   Removed feature  7210
#>    0.06073877   0.05642788   Removed feature  8511
#>    0.06073877   0.05642788   Removed feature  9162
#>    0.06073877   0.05642788   Removed feature  17032
#>    0.06073877   0.05642788   Removed feature  19296
#> Round 24
#> [1] "first_prime  round ( |s_prime| = 179 )"
#>    0.1025482   0.07385816   Removed feature  4634
#>    0.1015873   0.06664218   Removed feature  4574
#>    0.08181748   0.05766186   Removed feature  4313
#>    0.08103563   0.05642788   Removed feature  9952
#>    0.08103563   0.05642788   Removed feature  14966
#>    0.08103563   0.05642788   Removed feature  15425
#> Round 25
#> [1] "first_prime  round ( |s_prime| = 173 )"
#>    0.08103563   0.05642788   Removed feature  12970
#>    0.0535809   0.05127485   Removed feature  18558
#> Round 26
#> [1] "first_prime  round ( |s_prime| = 171 )"
#>    0.0936669   0.06876466   Removed feature  8250
#>    0.08985756   0.06664218   Removed feature  9410
#>    0.05988121   0.05887071   Removed feature  6960
#>    0.05741666   0.05127485   Removed feature  1762
#> Round 27
#> [1] "first_prime  round ( |s_prime| = 167 )"
#>    0.07668951   0.05642788   Removed feature  766
#>    0.07668951   0.05642788   Removed feature  17098
#> Round 28
#> [1] "first_prime  round ( |s_prime| = 165 )"
#>    0.07271102   0.07149493   Removed feature  6522
#>    0.06391487   0.05766186   Removed feature  17470
#> Round 29
#> [1] "first_prime  round ( |s_prime| = 163 )"
#>    0.06858315   0.05887071   Removed feature  12500
#>    0.05738385   0.05250286   Removed feature  3871
#> Round 30
#> [1] "first_prime  round ( |s_prime| = 161 )"
#>    0.1229451   0.0789382   Removed feature  1725
#>    0.08139068   0.07737111   Removed feature  8055
#>    0.07846352   0.0673556   Removed feature  5931
#>    0.0882765   0.05642788   Removed feature  2020
#>    0.0882765   0.05642788   Removed feature  16492
#>    0.06469703   0.053266   Removed feature  6944
#> Round 31
#> [1] "first_prime  round ( |s_prime| = 155 )"
#>    0.07650454   0.07109842   Removed feature  2654
#>    0.1298068   0.06732315   Removed feature  6683
#>    0.1050428   0.05127485   Removed feature  3135
#> Round 32
#> [1] "first_prime  round ( |s_prime| = 152 )"
#>    0.06265073   0.05674172   Removed feature  6367
#>    0.1027618   0.05642788   Removed feature  7089
#>    0.1027618   0.05642788   Removed feature  11458
#> Round 33
#> [1] "first_prime  round ( |s_prime| = 149 )"
#>    0.0767168   0.07000017   Removed feature  4583
#>    0.1015687   0.06876466   Removed feature  1321
#>    0.07986731   0.05766186   Removed feature  18725
#>    0.08334674   0.05642788   Removed feature  14252
#>    0.1019399   0.05250286   Removed feature  1977
#> Round 34
#> [1] "first_prime  round ( |s_prime| = 144 )"
#>    0.06736833   0.06144617   Removed feature  8575
#>    0.1053812   0.05960901   Removed feature  5186
#>    0.07067511   0.05910465   Removed feature  17357
#> Round 35
#> [1] "first_prime  round ( |s_prime| = 141 )"
#>    0.2430549   0.08068918   Removed feature  4815
#>    0.1506183   0.06732315   Removed feature  10700
#>    0.08475162   0.05200404   Removed feature  4269
#> Round 36
#> [1] "first_prime  round ( |s_prime| = 138 )"
#>    0.1122558   0.08068918   Removed feature  18152
#>    0.089582   0.05977561   Removed feature  15780
#>    0.1764942   0.05642788   Removed feature  17690
#> Round 37
#> [1] "first_prime  round ( |s_prime| = 135 )"
#>    0.1071212   0.05250286   Removed feature  468
#> Round 38
#> [1] "first_prime  round ( |s_prime| = 134 )"
#>    0.1122558   0.08068918   Removed feature  10830
#> Round 39
#> [1] "first_prime  round ( |s_prime| = 133 )"
#>    0.089582   0.05977561   Removed feature  7949
#> Round 40
#> [1] "first_prime  round ( |s_prime| = 132 )"
#>    0.07874919   0.07362505   Removed feature  9130
#>    0.09599254   0.0612623   Removed feature  10444
#>    0.06576629   0.05766186   Removed feature  361
#>    0.06576629   0.05766186   Removed feature  3578
#>    0.06576629   0.05766186   Removed feature  5263
#>    0.07838161   0.05434007   Removed feature  1973
#> Round 41
#> [1] "first_prime  round ( |s_prime| = 126 )"
#>    0.1386618   0.06876466   Removed feature  16346
#>    0.3697696   0.05642788   Removed feature  5500
#> Round 42
#> [1] "first_prime  round ( |s_prime| = 124 )"
#>    0.06187408   0.05941037   Removed feature  3866
#>    0.1192056   0.05127485   Removed feature  18101
#> Round 43
#> [1] "first_prime  round ( |s_prime| = 122 )"
#>    0.1386618   0.06876466   Removed feature  13107
#>    0.1764942   0.05642788   Removed feature  4204
#>    0.1071212   0.05250286   Removed feature  4300
#>    0.1071212   0.05250286   Removed feature  12645
#> Round 44
#> [1] "first_prime  round ( |s_prime| = 118 )"
#>    0.1023116   0.06876466   Removed feature  16354
#>    0.1396706   0.05642788   Removed feature  5250
#>    0.1396706   0.05642788   Removed feature  11516
#>    0.1396706   0.05642788   Removed feature  13874
#> Round 45
#> [1] "first_prime  round ( |s_prime| = 114 )"
#>    0.1515627   0.06876466   Removed feature  6164
#>    0.1515627   0.06876466   Removed feature  11933
#>    0.07872253   0.05960901   Removed feature  11301
#>    0.08632725   0.05642788   Removed feature  2878
#>    0.08632725   0.05642788   Removed feature  4654
#>    0.08632725   0.05642788   Removed feature  15038
#>    0.08632725   0.05642788   Removed feature  19081
#>    0.08632725   0.05642788   Removed feature  19375
#> Round 46
#> [1] "first_prime  round ( |s_prime| = 106 )"
#>    0.1091643   0.06876466   Removed feature  15158
#>    0.075678   0.05642788   Removed feature  10618
#> Round 47
#> [1] "first_prime  round ( |s_prime| = 104 )"
#>    0.06341664   0.05319117   Removed feature  6917
#>    0.05534072   0.05250286   Removed feature  14110
#> Round 48
#> [1] "first_prime  round ( |s_prime| = 102 )"
#> Round 49
#> [1] "first_prime  round ( |s_prime| = 102 )"
#>    0.08710054   0.0612623   Removed feature  6554
#>    0.1464177   0.05910465   Removed feature  12184
#>    0.06168498   0.05642788   Removed feature  3995
#> Round 50
#> [1] "first_prime  round ( |s_prime| = 99 )"
#> Round 51
#> [1] "first_prime  round ( |s_prime| = 99 )"
#>    0.05928048   0.05642788   Removed feature  4493
#>    0.05928048   0.05642788   Removed feature  7778
#>    0.05928048   0.05642788   Removed feature  8412
#>    0.2132579   0.05642788   Removed feature  9649
#>    0.05928048   0.05642788   Removed feature  11364
#>    0.05928048   0.05642788   Removed feature  12608
#>    0.05928048   0.05642788   Removed feature  13936
#>    0.05928048   0.05642788   Removed feature  14702
#>    0.2132579   0.05642788   Removed feature  16211
#>    0.05928048   0.05642788   Removed feature  18222
#> Round 52
#> [1] "first_prime  round ( |s_prime| = 89 )"
#>    0.05928048   0.05642788   Removed feature  1306
#>    0.05928048   0.05642788   Removed feature  2952
#>    0.05928048   0.05642788   Removed feature  13928
#>    0.2132579   0.05642788   Removed feature  15679
#> Round 53
#> [1] "first_prime  round ( |s_prime| = 85 )"
#>    0.1693599   0.06876466   Removed feature  17351
#>    0.05928048   0.05642788   Removed feature  17654
#>    0.05583755   0.05250286   Removed feature  14225
#>    0.1023116   0.05105315   Removed feature  2920
#> Round 54
#> [1] "first_prime  round ( |s_prime| = 81 )"
#>    0.05928048   0.05642788   Removed feature  10387
#>    0.05928048   0.05642788   Removed feature  15165
#>    0.05928048   0.05642788   Removed feature  19055
#>    0.1363759   0.05250286   Removed feature  8048
#> Round 55
#> [1] "first_prime  round ( |s_prime| = 77 )"
#>    0.05928048   0.05642788   Removed feature  15582
#>    0.06551585   0.05200404   Removed feature  6403
#> Round 56
#> [1] "first_prime  round ( |s_prime| = 75 )"
#>    0.07765524   0.05766186   Removed feature  9997
#> Round 57
#> [1] "first_prime  round ( |s_prime| = 74 )"
#> Round 58
#> [1] "first_prime  round ( |s_prime| = 74 )"
#> Round 59
#> [1] "first_prime  round ( |s_prime| = 74 )"
#> Round 60
#> [1] "first_prime  round ( |s_prime| = 74 )"
#> Round 61
#> [1] "first_prime  round ( |s_prime| = 74 )"
#> Round 62
#> [1] "first_prime  round ( |s_prime| = 74 )"
#> Round 63
#> [1] "first_prime  round ( |s_prime| = 74 )"
#> Round 64
#> [1] "first_prime  round ( |s_prime| = 74 )"
#> Round 65
#> [1] "first_prime  round ( |s_prime| = 74 )"
#>    0.07214759   0.05267052   Removed feature  13105
#> Round 66
#> [1] "first_prime  round ( |s_prime| = 73 )"
#>    0.2657888   0.05642788   Removed feature  5093
#>    0.07767568   0.05642788   Removed feature  16642
#> Round 67
#> [1] "first_prime  round ( |s_prime| = 71 )"
#> Round 68
#> [1] "first_prime  round ( |s_prime| = 71 )"
#>    0.07767568   0.05642788   Removed feature  18224
#> Round 69
#> [1] "first_prime  round ( |s_prime| = 70 )"
#> Round 70
#> [1] "first_prime  round ( |s_prime| = 70 )"
```

In the end, this process has selected a very low number of variables in comparison with the original dataset. Now we should see if they are really useful for classification. First, we will get a ‘mini feature table’, just with the selected variables and a table for comparison, with the 100 most variable genes

```
mini_single_cell_dengue_exprs <- exprs[fcbf_features$index,]

vars <- sort(apply(exprs, 1, var, na.rm = TRUE), decreasing = TRUE)
data_top_100_vars <- exprs[names(vars)[1:100], ]
```

The top 100 most variable is a quick-and-dirty unsupervised feature selection. Nevertheless, we can use it to see if the genes selected are really better at classification tasks. With the packages ‘caret’ and ‘mlbench’ we can check if that is true.

```
#first transpose the tables and make datasets as caret likes them

dataset_fcbf <- cbind(as.data.frame(t(mini_single_cell_dengue_exprs)),target_variable = target)
dataset_100_var <- cbind(as.data.frame(t(data_top_100_vars)),target_variable = target)

library('caret')
#> Loading required package: lattice
#> Loading required package: ggplot2
library('mlbench')

control <- trainControl(method="cv", number=5, classProbs=TRUE, summaryFunction=twoClassSummary)
```

In the code above we created a plan to test the classifiers by 5-fold cross validation. Any classifier can be used, but for illustration, here we will use the very popular radial svm. As metric for comparison we will use the area-under-the-curve (AUC) of the receiver operating characteristic (ROC) curve :

```
svm_fcbf <-
train(target_variable ~ .,
metric="ROC",
data = dataset_fcbf,
method = "svmRadial",
trControl = control)

svm_top_100_var <-
train(target_variable ~ .,
metric="ROC",
data = dataset_100_var,
method = "svmRadial",
trControl = control)

svm_fcbf_results <- svm_fcbf$results[svm_fcbf$results$ROC == max(svm_fcbf$results$ROC),]
svm_top_100_var_results <- svm_top_100_var$results[svm_top_100_var$results$ROC == max(svm_top_100_var$results$ROC),]

cat(paste0("For top 100 var: \n",
"ROC = ",  svm_top_100_var_results$ROC, "\n",
"Sensitivity  = ", svm_top_100_var_results$Sens, "\n",
"Specificity  = ", svm_top_100_var_results$Spec, "\n\n",
"For FCBF: \n",
"ROC = ",  svm_fcbf_results$ROC, "\n",
"Sensitivity  = ", svm_fcbf_results$Sens, "\n",
"Specificity  = ", svm_fcbf_results$Spec))
#> For top 100 var:
#> ROC = 0.673611111111111
#> Sensitivity  = 0.7
#> Specificity  = 0.616666666666667
#>
#> For FCBF:
#> ROC = 1
#> Sensitivity  = 1
#> Specificity  = 0.966666666666667 For top 100 var:
#> ROC = 0.673611111111111
#> Sensitivity  = 0.7
#> Specificity  = 0.616666666666667
#>
#> For FCBF:
#> ROC = 1
#> Sensitivity  = 1
#> Specificity  = 1

cat(paste0("For top 100 var: \n",
"ROC = ",  svm_top_100_var_results$ROC, "\n",
"Sensitivity  = ", svm_top_100_var_results$Sens, "\n",
"Specificity  = ", svm_top_100_var_results$Spec, "\n\n",
"For FCBF: \n",
"ROC = ",  svm_fcbf_results$ROC, "\n",
"Sensitivity  = ", svm_fcbf_results$Sens, "\n",
"Specificity  = ", svm_fcbf_results$Spec))
#> For top 100 var:
#> ROC = 0.673611111111111
#> Sensitivity  = 0.7
#> Specificity  = 0.616666666666667
#>
#> For FCBF:
#> ROC = 1
#> Sensitivity  = 1
#> Specificity  = 0.966666666666667 For top 100 var:
#> ROC = 0.673611111111111
#> Sensitivity  = 0.7
#> Specificity  = 0.616666666666667
#>
#> For FCBF:
#> ROC = 1
#> Sensitivity  = 1
#> Specificity  = 1
```

As we can see, the selected variables gave rise to a better SVM model than selecting the top 100 variables (as measured by the area under the curve of the receiver-operating characteristic curve. Notably, running the svm radial with the full exprs set gives an error of the sort : Error: protect(): “protection stack overflow”.

The multiplicity of infection (MOI) of the cells was relatively low (1 virus/cell), so it is expected that some cells were not infected. Thus, due to this overlap o f healthy cells in both groups, the groups are probably non-separable. In any case, FCBF seems to do a reasonably good job at selecting variables.

## Final remarks

Even though tools are available for feature selection in packages such as FSelector (<https://cran.r-project.org/web/packages/FSelector/FSelector.pdf>), up to date, there were no easy implementations in R for FCBF. The article describing FCBF has more than 1800 citations, but almost none from the biomedical community.

We expect that by carefully implementing and documenting FCBF in R, this package might improve usage of filter-based feature selection approaches that aim at reducing redundancy among selected features. Other tools similar to FCBF are available in Weka (<https://www.cs.waikato.ac.nz/ml/weka/>) and Python/scikit learn (<http://featureselection.asu.edu/>). A recent good review, for those interested in going deeper, is the following ref:

Li, J., Cheng, K., Wang, S., Morstatter, F., Trevino, R. P., Tang, J., & Liu, H. (2017). Feature selection: A data perspective. ACM Computing Surveys (CSUR), 50(6), 94.

We note that other techniques based on predominant correlation might be better depending on the dataset and the objectives. FCBF provides a interpretable and robust option, with results that are generally good.

The application of filter-based feature selections for big data analysis in the biomedical sciences can have not only a direct effect in classification efficiency but might lead to interesting biological interpretations and possible quick identification of biomarkers.