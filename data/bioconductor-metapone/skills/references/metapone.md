# METAbolic pathway testing combining POsitive and NEgative mode data (metapone)

The metapone package conducts pathway tests for untargeted metabolomics data. It has three main characteristics: (1) expanded database combining SMPDB and Mummichog databases, with manual cleaning to remove redundancies; (2) A new weighted testing scheme to address the issue of metabolite-feature matching uncertainties; (3) Can consider positive mode and negative mode data in a single analysis.

Compared to existing methods, the weighted testing scheme allows the user to apply different level of penalty for multiple-mapped features, in order to reduce their undue impact on the results. In addition, considering positive mode and negative mode data simultaneously can improve the statistical power of the test.

```
library(metapone)
#> Loading required package: BiocParallel
#> Loading required package: fields
#> Loading required package: spam
#> Spam version 2.11-1 (2025-01-20) is loaded.
#> Type 'help( Spam)' or 'demo( spam)' for a short introduction
#> and overview of this package.
#> Help for individual functions is also obtained by adding the
#> suffix '.spam' to the function name, e.g. 'help( chol.spam)'.
#>
#> Attaching package: 'spam'
#> The following objects are masked from 'package:base':
#>
#>     backsolve, forwardsolve
#> Loading required package: viridisLite
#> Loading required package: RColorBrewer
#>
#> Try help(fields) to get started.
#> Loading required package: markdown
#> Loading required package: fdrtool
#> Loading required package: fgsea
#> Loading required package: ggplot2
#> Loading required package: ggrepel
#>
#> Attaching package: 'metapone'
#> The following object is masked from 'package:stats':
#>
#>     ftable
```

The input should contain at least three clumns - m/z, retention time, and feature p-value. Here to illustrate the usage of the method, we borrow the test results from our published study “Use of high-resolution metabolomics for the identification of metabolic T signals associated with traffic-related air pollution” in Environment International. 120: 145–154.

The positive mode results are in the object “pos”.

```
data(pos)
head(pos)
#>                  mz     time      p-value F-statistics
#> pos_70.005 70.00462 393.5786 0.5113989716    0.6809306
#> pos_70.068 70.06843 392.4810 0.0001519284   10.8083621
#> pos_70.291 70.29056 431.2095 0.0094772595    5.1889005
#> pos_70.512 70.51164 428.0062 0.4159535303    0.8949039
#> pos_70.569 70.56866 393.4188 0.0009075295    8.2483533
#> pos_70.953 70.95306 388.7599 0.3471977081    1.0837069
```

The negative mode results are in the object “neg”. If both positive mode and negative mode data are present, each is input into the algorithm as a separate matrix

```
data(neg)
head(neg)
#>                  mz     time   p-value F-statistics
#> neg_70.029 70.02878 371.1481 0.4228952    0.8776863
#> neg_70.079 70.07884 373.2138 0.2181511    1.5764905
#> neg_70.288 70.28823 426.4280 0.1292893    2.1438317
#> neg_70.31  70.31043 281.8414 0.1485619    1.9918230
#> neg_70.532 70.53234 375.6303 0.1089732    2.3321718
#> neg_70.563 70.56271 363.9597 0.4777650    0.7511758
```

It is not required that both positive and negative mode results are present. Having a single ion mode is also OK. The test is based on HMDB identification. The common adduct ions are pre-processed and stored in:

```
data(hmdbCompMZ)
head(hmdbCompMZ)
#>       HMDB_ID      m.z ion.type
#> 1 HMDB0059597 1.343218     M+3H
#> 2 HMDB0001362 1.679159     M+3H
#> 3 HMDB0037238 2.341477     M+3H
#> 4 HMDB0005949 3.345944     M+3H
#> 5 HMDB0002387 4.011337     M+3H
#> 6 HMDB0002386 4.677044     M+3H
```

Pathway information that was summarized from Mummichog and smpdb is built-in:

```
data(pa)
head(pa)
#>        database                    pathway.name     HMDB.ID KEGG.ID category
#> 5092 Metapone 1 2-oxocarboxylic acid metabolism HMDB0000243  C00022 combined
#> 5157 Metapone 1 2-oxocarboxylic acid metabolism HMDB0000148  C00025 combined
#> 5200 Metapone 1 2-oxocarboxylic acid metabolism HMDB0000208  C00026 combined
#> 5288 Metapone 1 2-oxocarboxylic acid metabolism HMDB0000223  C00036 combined
#> 5377 Metapone 1 2-oxocarboxylic acid metabolism HMDB0000182  C00047 combined
#> 5407 Metapone 1 2-oxocarboxylic acid metabolism HMDB0000191  C00049 combined
```

The user can specify which adduct ions are allowed by setting the allowed adducts. For example:

```
pos.adductlist = c("M+H", "M+NH4", "M+Na", "M+ACN+H", "M+ACN+Na", "M+2ACN+H", "2M+H", "2M+Na", "2M+ACN+H")
neg.adductlist = c("M-H", "M-2H", "M-2H+Na", "M-2H+K", "M-2H+NH4", "M-H2O-H", "M-H+Cl", "M+Cl", "M+2Cl")
```

It is common for a feature to be matched to multiple metabolites. Assume a feature is matched to m metabolites, metapone weighs the feature by (1/m)^p, where p is a power term to tune the penalty. m can also be capped at a certain level such that the penalty is limited. These are controlled by parameters:

Setting p: fractional.count.power = 0.5 Setting the cap of n: max.match.count = 10

It is easy to see that when p=0, no penalty is assigned for multiple-matching. The higher p is, the larger penalty for features that are multiple matched.

Other parameters include p.threshold, which controls which metabolic feature is considered significant. If use.fgsea = FALSE, then testing is done by permutation. Otherwise, a GSEA type testing is conducted and the parameter use.meta controls using metabolite-based or feature-based testing. Overall, the analysis is conducted this way:

```
dat <- list(pos, neg)
type <- list("pos", "neg")
# permutation test
r<-metapone(dat, type, pa, hmdbCompMZ=hmdbCompMZ, pos.adductlist=pos.adductlist, neg.adductlist=neg.adductlist, p.threshold=0.05,n.permu=200,fractional.count.power=0.5, max.match.count=10, use.fgsea = FALSE)

# GSEA type testing based on metabolites
#r<-metapone(dat, type, pa, hmdbCompMZ=hmdbCompMZ, pos.adductlist=pos.adductlist, neg.adductlist=neg.adductlist, p.threshold=0.05,n.permu=100,fractional.count.power=0.5, max.match.count=10, use.fgsea = TRUE, use.meta = TRUE)

# GSEA type testing based on features
#r<-metapone(dat, type, pa, hmdbCompMZ=hmdbCompMZ, pos.adductlist=pos.adductlist, neg.adductlist=neg.adductlist, p.threshold=0.05,n.permu=100,fractional.count.power=0.5, max.match.count=10, use.fgsea = TRUE, use.meta = FALSE)

hist(ptable(r)[,1])
```

![](data:image/png;base64...)

We can subset the pathways that are significant:

```
selection<-which(ptable(r)[,1]<0.025)
ptable(r)[selection,]
#>                                                 p_value
#> folate metabolism                                 0.005
#> secondary bile acid biosynthesis                  0.000
#> sphingolipid metabolism                           0.000
#> vegf signaling pathway                            0.020
#> c21-steroid hormone biosynthesis and metabolism   0.000
#>                                                 n_significant_metabolites
#> folate metabolism                                              2.64359425
#> secondary bile acid biosynthesis                               2.13636364
#> sphingolipid metabolism                                        7.68044092
#> vegf signaling pathway                                         0.06666667
#> c21-steroid hormone biosynthesis and metabolism                5.89725104
#>                                                 n_mapped_metabolites
#> folate metabolism                                          4.8506736
#> secondary bile acid biosynthesis                           3.3146582
#> sphingolipid metabolism                                   19.2232315
#> vegf signaling pathway                                     0.1254902
#> c21-steroid hormone biosynthesis and metabolism           16.7790953
#>                                                 n_metabolites
#> folate metabolism                                          29
#> secondary bile acid biosynthesis                           18
#> sphingolipid metabolism                                    48
#> vegf signaling pathway                                      6
#> c21-steroid hormone biosynthesis and metabolism            77
#>                                                                                                                                                                                                 significant metabolites
#> folate metabolism                                                                                                                                                                   HMDB0000217,HMDB0000121,HMDB0001396
#> secondary bile acid biosynthesis                                        HMDB0000505,HMDB0000138,HMDB0000518,HMDB0000626,HMDB0000946,HMDB0000811,HMDB0000917,HMDB0000411,HMDB0000361,HMDB0000686,HMDB0000415,HMDB0000364
#> sphingolipid metabolism                         HMDB0001480,HMDB0000217,HMDB0001383,HMDB0004950,HMDB0000252,HMDB0001348,HMDB0010708,HMDB0000140,HMDB0000122,HMDB0004866,HMDB0000024,HMDB0000143,HMDB0004947,HMDB0004833
#> vegf signaling pathway                                                                                                                                                                                      HMDB0001335
#> c21-steroid hormone biosynthesis and metabolism             HMDB0000653,HMDB0004026,HMDB0006760,HMDB0011653,HMDB0003259,HMDB0006754,HMDB0000935,HMDB0006753,HMDB0001231,HMDB0006893,HMDB0000774,HMDB0003193,HMDB0000363
#>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          mapped_metabolites
#> folate metabolism                                                                                                                                                                                                                                                                                                                                                                                                                                                       HMDB0000217,HMDB0000121,HMDB0000538,HMDB0003470,HMDB0001533,HMDB0001396,HMDB0006825
#> secondary bile acid biosynthesis                                                                                                                                                                                                                                                                                                                                                    HMDB0000505,HMDB0000138,HMDB0000518,HMDB0000626,HMDB0000036,HMDB0000951,HMDB0000946,HMDB0000811,HMDB0000917,HMDB0000411,HMDB0000361,HMDB0000686,HMDB0000415,HMDB0000364
#> sphingolipid metabolism                                                                                                                                                                                                                         HMDB0001480,HMDB0000269,HMDB0000217,HMDB0000538,HMDB0001383,HMDB0001551,HMDB0004950,HMDB0000252,HMDB0010699,HMDB0001348,HMDB0006790,HMDB0001565,HMDB0010708,HMDB0000140,HMDB0000122,HMDB0000286,HMDB0000295,HMDB0004866,HMDB0000024,HMDB0000143,HMDB0004947,HMDB0012096,HMDB0000648,HMDB0004833,HMDB0004610
#> vegf signaling pathway                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              HMDB0007099,HMDB0001335
#> c21-steroid hormone biosynthesis and metabolism HMDB0000653,HMDB0000077,HMDB0004026,HMDB0006760,HMDB0000295,HMDB0011653,HMDB0000016,HMDB0004029,HMDB0002961,HMDB0000153,HMDB0000145,HMDB0003259,HMDB0006754,HMDB0000949,HMDB0000268,HMDB0001425,HMDB0003769,HMDB0000935,HMDB0006281,HMDB0006753,HMDB0002829,HMDB0012455,HMDB0001231,HMDB0006203,HMDB0006893,HMDB0006280,HMDB0001457,HMDB0000774,HMDB0000374,HMDB0000067,HMDB0006763,HMDB0006224,HMDB0004484,HMDB0005896,HMDB0000253,HMDB0003193,HMDB0000490,HMDB0000363,HMDB0003069,HMDB0000031,HMDB0006773
#>                                                 lfdr  adjust.p
#> folate metabolism                                  1 0.2862500
#> secondary bile acid biosynthesis                   1 0.0000000
#> sphingolipid metabolism                            1 0.0000000
#> vegf signaling pathway                             1 0.6361111
#> c21-steroid hormone biosynthesis and metabolism    1 0.0000000
```

We note that applying the multiple-matching penalty using parameter fractional.count.power will effectively making fractional counts out of the multiple-matched features. Thus the mapped feature tables, you will see fractional counts, rather than integer counts.

```
ftable(r)[which(ptable(r)[,1]<0.025 & ptable(r)[,2]>=2)]
#> $`folate metabolism`
#>      mz       time     p-value     F-statistics HMDB_ID       m.z
#> [1,] 1511.155 335.4843 0.001683378 7.410698     "HMDB0000217" 1511.156
#> [2,] 924.3137 522.3555 0.02859562  3.857759     "HMDB0000121" 924.3132
#> [3,] 440.1676 73.31135 0.001323347 7.734161     "HMDB0001396" 440.1682
#>      ion.type   counts
#> [1,] "2M+Na"    1
#> [2,] "2M+ACN+H" 0.6435943
#> [3,] "M-H2O-H"  1
#>
#> $`secondary bile acid biosynthesis`
#>       mz       time     p-value    F-statistics HMDB_ID       m.z
#>  [1,] 456.308  96.02325 0.03401312 3.654646     "HMDB0000361" 456.3084
#>  [2,] 456.308  96.02325 0.03401312 3.654646     "HMDB0000411" 456.3084
#>  [3,] 456.308  96.02325 0.03401312 3.654646     "HMDB0000518" 456.3084
#>  [4,] 456.308  96.02325 0.03401312 3.654646     "HMDB0000626" 456.3084
#>  [5,] 456.308  96.02325 0.03401312 3.654646     "HMDB0000686" 456.3084
#>  [6,] 456.308  96.02325 0.03401312 3.654646     "HMDB0000811" 456.3084
#>  [7,] 456.308  96.02325 0.03401312 3.654646     "HMDB0000946" 456.3084
#>  [8,] 826.6231 299.4422 0.03344936 3.674143     "HMDB0000361" 826.6191
#>  [9,] 826.6231 299.4422 0.03344936 3.674143     "HMDB0000411" 826.6191
#> [10,] 826.6231 299.4422 0.03344936 3.674143     "HMDB0000518" 826.6191
#> [11,] 826.6231 299.4422 0.03344936 3.674143     "HMDB0000626" 826.6191
#> [12,] 826.6231 299.4422 0.03344936 3.674143     "HMDB0000686" 826.6191
#> [13,] 826.6231 299.4422 0.03344936 3.674143     "HMDB0000811" 826.6191
#> [14,] 826.6231 299.4422 0.03344936 3.674143     "HMDB0000946" 826.6191
#> [15,] 858.608  295.2427 0.04060484 3.448908     "HMDB0000364" 858.609
#> [16,] 858.608  295.2427 0.04060484 3.448908     "HMDB0000415" 858.609
#> [17,] 858.608  295.2427 0.04060484 3.448908     "HMDB0000505" 858.609
#> [18,] 858.608  295.2427 0.04060484 3.448908     "HMDB0000917" 858.609
#> [19,] 972.6485 410.6006 0.00694524 5.57578      "HMDB0000138" 972.6519
#> [20,] 500.2789 73.83075 0.01139168 4.962465     "HMDB0000138" 500.2784
#>       ion.type   counts
#>  [1,] "M+ACN+Na" 0.09090909
#>  [2,] "M+ACN+Na" 0.09090909
#>  [3,] "M+ACN+Na" 0.09090909
#>  [4,] "M+ACN+Na" 0.09090909
#>  [5,] "M+ACN+Na" 0.09090909
#>  [6,] "M+ACN+Na" 0.09090909
#>  [7,] "M+ACN+Na" 0.09090909
#>  [8,] "2M+ACN+H" 0.1111111
#>  [9,] "2M+ACN+H" 0.1111111
#> [10,] "2M+ACN+H" 0.1111111
#> [11,] "2M+ACN+H" 0.1111111
#> [12,] "2M+ACN+H" 0.1111111
#> [13,] "2M+ACN+H" 0.1111111
#> [14,] "2M+ACN+H" 0.1111111
#> [15,] "2M+ACN+H" 0.0625
#> [16,] "2M+ACN+H" 0.0625
#> [17,] "2M+ACN+H" 0.0625
#> [18,] "2M+ACN+H" 0.0625
#> [19,] "2M+ACN+H" 0.2222222
#> [20,] "M+Cl"     0.25
#>
#> $`sphingolipid metabolism`
#>       mz       time     p-value      F-statistics HMDB_ID       m.z
#>  [1,] 566.5487 339.8191 0.01077019   5.031309     "HMDB0004950" 566.5507
#>  [2,] 717.5996 228.5805 0.023961     4.066429     "HMDB0010708" 717.5987
#>  [3,] 834.6823 410.2771 3.144121e-06 17.13239     "HMDB0000140" 834.6793
#>  [4,] 523.4812 295.2402 0.01671986   4.496276     "HMDB0004947" 523.4833
#>  [5,] 607.5751 370.3215 0.001152875  7.921133     "HMDB0004950" 607.5772
#>  [6,] 773.6387 303.5713 0.01702076   4.474803     "HMDB0001348" 773.6405
#>  [7,] 1612.113 310.8567 0.0299504    3.80341      "HMDB0004866" 1612.118
#>  [8,] 785.5168 286.4947 0.005572923  5.853094     "HMDB0001383" 785.518
#>  [9,] 1511.155 335.4843 0.001683378  7.410698     "HMDB0000217" 1511.156
#> [10,] 179.0553 36.83502 0.02430136   4.049723     "HMDB0000122" 179.0561
#> [11,] 179.0553 36.83502 0.02430136   4.049723     "HMDB0000143" 179.0561
#> [12,] 179.0553 432.7855 0.006187688  5.720927     "HMDB0000122" 179.0561
#> [13,] 179.0553 432.7855 0.006187688  5.720927     "HMDB0000143" 179.0561
#> [14,] 564.5361 379.4879 0.009946984  5.129183     "HMDB0004950" 564.5361
#> [15,] 890.6378 357.302  7.38564e-05  11.90184     "HMDB0000024" 890.6397
#> [16,] 280.2646 404.9412 2.737722e-08 26.54871     "HMDB0000252" 280.264
#> [17,] 280.2646 404.9412 2.737722e-08 26.54871     "HMDB0001480" 280.264
#> [18,] 842.6031 311.6396 0.0001615305 10.7171      "HMDB0004833" 842.5994
#> [19,] 846.6625 444.0693 0.00593383   5.773763     "HMDB0000140" 846.6595
#>       ion.type  counts
#>  [1,] "M+H"     0.2637522
#>  [2,] "M+NH4"   0.00407332
#>  [3,] "M+Na"    0.5946036
#>  [4,] "M+ACN+H" 1
#>  [5,] "M+ACN+H" 0.2637522
#>  [6,] "M+ACN+H" 1
#>  [7,] "2M+H"    1
#>  [8,] "2M+Na"   0.1719822
#>  [9,] "2M+Na"   1
#> [10,] "M-H"     0.07142857
#> [11,] "M-H"     0.07142857
#> [12,] "M-H"     0.07142857
#> [13,] "M-H"     0.07142857
#> [14,] "M-H"     0.3296902
#> [15,] "M-H"     0.09534626
#> [16,] "M-H2O-H" 0.5
#> [17,] "M-H2O-H" 0.5
#> [18,] "M-H2O-H" 0.07692308
#> [19,] "M+Cl"    0.5946036
#>
#> $`c21-steroid hormone biosynthesis and metabolism`
#>       mz       time     p-value      F-statistics HMDB_ID       m.z
#>  [1,] 482.2738 126.6953 0.03922185   3.489025     "HMDB0003193" 482.2748
#>  [2,] 508.3468 127.6048 0.001470928  7.591605     "HMDB0000653" 508.3455
#>  [3,] 508.3465 694.251  0.01177125   4.922325     "HMDB0000653" 508.3455
#>  [4,] 530.33   664.3211 0.005241671  5.930785     "HMDB0000653" 530.3274
#>  [5,] 447.2836 458.7022 4.979651e-06 16.32296     "HMDB0003259" 447.2853
#>  [6,] 447.2836 458.7022 4.979651e-06 16.32296     "HMDB0006753" 447.2853
#>  [7,] 447.2836 458.7022 4.979651e-06 16.32296     "HMDB0006754" 447.2853
#>  [8,] 447.2836 458.7022 4.979651e-06 16.32296     "HMDB0006760" 447.2853
#>  [9,] 479.2574 130.7585 0.001269227  7.79065      "HMDB0000774" 479.2574
#> [10,] 549.3747 130.1223 0.005832964  5.795415     "HMDB0000653" 549.3721
#> [11,] 687.4566 451.9255 0.02257464   4.137142     "HMDB0000363" 687.4595
#> [12,] 687.4566 451.9255 0.02257464   4.137142     "HMDB0004026" 687.4595
#> [13,] 687.4566 451.9255 0.02257464   4.137142     "HMDB0011653" 687.4595
#> [14,] 895.7013 449.1108 0.0006073895 8.805532     "HMDB0001231" 895.6997
#> [15,] 1202.101 722.7504 3.475685e-06 16.95446     "HMDB0000935" 1202.102
#> [16,] 403.3571 272.3139 0.0004006864 9.393566     "HMDB0006893" 403.3582
#> [17,] 501.282  73.84088 0.003108978  6.601882     "HMDB0000653" 501.2811
#>       ion.type   counts
#>  [1,] "M+NH4"    0.5
#>  [2,] "M+ACN+H"  0.3535534
#>  [3,] "M+ACN+H"  0.3535534
#>  [4,] "M+ACN+Na" 0.3535534
#>  [5,] "M+2ACN+H" 0.2222222
#>  [6,] "M+2ACN+H" 0.2222222
#>  [7,] "M+2ACN+H" 0.2222222
#>  [8,] "M+2ACN+H" 0.2222222
#>  [9,] "M+2ACN+H" 0.7071068
#> [10,] "M+2ACN+H" 0.3535534
#> [11,] "2M+Na"    0.1818182
#> [12,] "2M+Na"    0.1818182
#> [13,] "2M+Na"    0.1818182
#> [14,] "2M+Na"    0.3333333
#> [15,] "2M+ACN+H" 0.5773503
#> [16,] "M-H"      0.5773503
#> [17,] "M+Cl"     0.3535534
```

We can also use bbplot1d() and bbplot2d to visualize the pathway testing result.

```
bbplot1d(r@test.result, 0.025)
```

![](data:image/png;base64...)

```
bbplot2d(r@test.result, 0.025)
```

![](data:image/png;base64...)