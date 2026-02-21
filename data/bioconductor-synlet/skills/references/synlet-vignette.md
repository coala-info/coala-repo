# A working Demo for synlet

#### 30 October 2025

# Contents

* [1 Introduction](#introduction)
* [2 Load the package and data.](#load-the-package-and-data.)
* [3 Quality control](#quality-control)
  + [3.1 Z and Z’ factor](#z-and-z-factor)
  + [3.2 Heatmap of screen data](#heatmap-of-screen-data)
  + [3.3 Scatter plot of screen data](#scatter-plot-of-screen-data)
* [4 Hits selection](#hits-selection)
  + [4.1 Student’s t-test](#students-t-test)
  + [4.2 Median +- k*MAD
    Hits selection based on median ± k median absolute deviation (MAD) is widely used in RNAi screen data analysis due to the easy calculation and robustness to outliers in the real data and simulation study [4]. The function* madSelect\* could calculate the median of ratio between normalized treatment and control plates and label the hits based the *k* (the default value is 3). By default *madSelect* will use the fraction of samples normalization method, this could be overridden by specifying the negative control siRNA through the *normMethod* parameter.](#median---kmad-hits-selection-based-on-median-k-median-absolute-deviation-mad-is-widely-used-in-rnai-screen-data-analysis-due-to-the-easy-calculation-and-robustness-to-outliers-in-the-real-data-and-simulation-study-4.-the-function-madselect-could-calculate-the-median-of-ratio-between-normalized-treatment-and-control-plates-and-label-the-hits-based-the-k-the-default-value-is-3.-by-default-madselect-will-use-the-fraction-of-samples-normalization-method-this-could-be-overridden-by-specifying-the-negative-control-sirna-through-the-normmethod-parameter.)
  + [4.3 Rank products method](#rank-products-method)
  + [4.4 Redundant siRNA activity method](#redundant-sirna-activity-method)
  + [4.5 Summary](#summary)
* [5 References](#references)
* **Appendix**

**Package**: **sylsnet**
**Authors**: Chunxuan Shao [aut, cre]
**Compiled**: 2025-10-30

# 1 Introduction

Here is a step-by-step tutorial of the package **synlet**. This package processes data from cellBasedArrays.
In this vignette, we will show a quick tour of using the synlet with dummy/stimulated
data, including quality control, data visualization, and most importantly, hits selection.

# 2 Load the package and data.

First, Let’s have a look at the example data.

```
library(synlet)
data(example_dt)
head(example_dt)
```

```
##      PLATE MASTER_PLATE     WELL_CONTENT_NAME  EXPERIMENT_TYPE
##     <char>       <char>                <char>           <char>
## 1: 1031121         P001              AAK1 si3           sample
## 2: 1031121         P001              PLK1 si1 control_positive
## 3: 1031121         P001            lipid only control_negative
## 4: 1031121         P001 scrambled control si1 control_negative
## 5: 1031121         P001            lipid only control_negative
## 6: 1031121         P001            AARSD1 si3           sample
##    EXPERIMENT_MODIFICATION ROW_NAME COL_NAME READOUT
##                     <char>   <char>   <char>   <int>
## 1:               treatment        C       10     455
## 2:               treatment        C       11     814
## 3:               treatment        C       12     537
## 4:               treatment        C       13     568
## 5:               treatment        C       14     566
## 6:               treatment        C       15     632
```

The **example\_dt** is a data.table containing 8 columns, all of them are mandatory and please do **NOT** change the column names.
Besides that, users are free to add new columns. However, please not that the new columns may not appear in the final results. Users need to generate **example\_dt** like data.table from the screen results.

In the **example\_dt**:

* *PLATE*, the name of individual plate. Must be **character** value.
* *MASTER\_PLATE*, usually there are plate replicates designed in the RNAi screen experiments. Several individual *PLATE* having the identical layout are group to a *MASTER\_PLATE*.
* *WELL\_CONTENT\_NAME*, the name of siRNA used in each cell, in the format of “geneName si(number)”, as usually several siRNAs are available to control for the off-target effect.
* *EXPERIMENT\_TYPE*, indicates the cells are sample (interested knock-down), or negative control (control\_negative), or positive control (control\_positive).
* *EXPERIMENT\_MODIFICATION*, there are two conditions in synthetic lethal RNAi screen, named **treatment** and **control**.
* *ROW\_NAME* and *COL\_NAME*, the position of siRNA reagent in the plate.
* *READOUT*, the output of RNAi screen output for each cell in the plate. Here the data are randomized.

The **example\_dt** contains three *MASTER\_PLATE*, each *MASTER\_PLATE* has three plates for **treatment** and **control**.

# 3 Quality control

## 3.1 Z and Z’ factor

Z’ factor and Z factor are widely used quality metrics in RNAi experiments.

Z’ factor = 1- 3\*(\(\delta\_p\) + \(\delta\_n\)) / |\(\mu\_p\) - \(\mu\_n\)|

Z factor = 1- 3\*(\(\delta\_s\) + \(\delta\_n\)) / |\(\mu\_s\) - \(\mu\_n\)|

In Z’ factor calculation, \(\delta\_p\), \(\delta\_n\), \(\mu\_p\), \(\mu\_n\) are the standard deviation and mean of positive control and negative control signal, respectively; while in Z factor formular \(\delta\_s\), \(\delta\_n\), \(\mu\_s\), \(\mu\_n\) are standard deviation and mean of samples and negative control signal, respectively. From the definition, we could see that Z’ factor measures the quality of optimization of plates, and Z factor accesses the performance of screen on actual samples. Generally, the plates with value >= 0.5 are considered as excellent assay. See [1] and [2] for more information and discussion.

By default \(\mu\) in the denominator are mean value of signals, *zFactor* function offers the option to use median instead, which could be more robust in certain conditions.

Here is an example, we specify negative control is “scrambled control si1”, and positive control is “PLK1 si1”. These informations are stored in *EXPERIMENT\_TYPE* column.

```
res <- zFactor(example_dt, negativeCon = "scrambled control si1", positiveCon = "PLK1 si1")
```

```
## (II) Number of plates to calculate Z/Z' factor: 18
```

```
head(res)
```

```
##            zFactor zPrimeFactor
## 1031121  -10.63422    -41.36325
## 1031122  -33.61931   -605.05780
## 1031123  -23.36894    -30.10812
## 1031124  -32.31388    -14.53770
## 1031125 -115.06929   -137.87408
## 1031126  -23.08053    -51.94333
```

As the *READOUT* are shuffled data, not surprising the Z and Z’ factor are negative value.

## 3.2 Heatmap of screen data

Synlet could plot the screen results in the format of heatmap, in which a dot represents a single cell. All plates are organized together in single figure. This provides a general view of RNAi screen quality.

```
plateHeatmap(example_dt)
```

```
## Warning: The `size` argument of `element_rect()` is deprecated as of ggplot2 3.4.0.
## ℹ Please use the `linewidth` argument instead.
## ℹ The deprecated feature was likely used in the synlet package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

## 3.3 Scatter plot of screen data

Usually in each plate there are negative and positive control siRNAs, which set the bound of siRNA effect. The scatter plot provide a direct way to examine the bound of controls. It is possible to specify multiple positive / negative controls in the function *scatterPlot*, and the output of all plates are arranged in a single plot.

```
scatterPlot(example_dt, controlOnly = FALSE, control_name = c("PLK1 si1", "scrambled control si1", "lipid only"))
```

```
## Warning: Removed 2 rows containing missing values or values outside the scale range
## (`geom_point()`).
```

![](data:image/png;base64...)
## Knock-down effect
It is often intuitive to look at the knock-down effect of a single gene in RNAi screen experiments. The function *siRNAPlot* plot the normalized and raw signals, the positive and negative control signals, and Z’ factor of plates into a single graph. *siRNAPlot* provides the option to specify control siRNAs and normalization methods. The following codes show the knock-down effect of “AAK1”.

We need to calculate the Z’ factor based on mean and median of signals. By default, a pdf file named “AAK1.pdf” will be generated in the working directory, the return value contains all subplot and could be plotted separately.

```
zF_mean <- zFactor(example_dt, negativeCon = "scrambled control si1", positiveCon = "PLK1 si1")
```

```
## (II) Number of plates to calculate Z/Z' factor: 18
```

```
zF_med <- zFactor(example_dt, negativeCon = "scrambled control si1", positiveCon = "PLK1 si1", useMean = FALSE)
```

```
## (II) Number of plates to calculate Z/Z' factor: 18
```

```
siRNAPlot("AAK1", example_dt,
           controlsiRNA = c("lipid only", "scrambled control si1"),
           FILEPATH = ".",  zPrimeMed = zF_med, zPrimeMean = zF_mean,
           treatment = "treatment", control = "control",
           normMethod = c("PLATE", "lipid only", "scrambled control si1"))
```

```
## (==) Processing: AAK1
```

```
## $full_plot
```

![](data:image/png;base64...)

```
##
## $p_norm_boxpl
```

![](data:image/png;base64...)

```
##
## $p_norm_barpl
```

![](data:image/png;base64...)

```
##
## $p_raw_barpl
```

![](data:image/png;base64...)

```
##
## $p_cont_boxplot
```

![](data:image/png;base64...)

```
##
## $p_zprimer_barpl
```

![](data:image/png;base64...)

# 4 Hits selection

The main goal of synthetic lethal RNAi screen experiments is to identify interesting genes led to reliable difference in mortality between treatment and control plates, which is a difficult task because of cell heterogeneity, reagent efficiency and intrinsic character of genes. *Synlet* tries to improve the results of hits selection by employing several algorithms that explore data from different directions, including student’s t-test, median ± k median absolute deviation, rank products and redundant siRNA activity (RSA).

## 4.1 Student’s t-test

Student’s t-test is commonly used to test whether the mean from two samples are identical, thus it could be a helpful strategy in identifying synthetic lethal genes [3]. *Synlet* applies t-test to robust B-score value calculated from raw data of each plates, and the BH method is used to correct for the multiple comparisons.

We start with B-score calculation.

```
bscore_res <- sapply(unique(example_dt$MASTER_PLATE)[1], bScore, example_dt, treatment = "treatment", control = "control", simplify = FALSE)
```

```
## (II) Processing PLATE:1031613
```

```
## 1: 33731
## Final: 33589
```

```
## (II) Processing PLATE:1031614
```

```
## 1: 32981
## 2: 32617.25
## Final: 32546.69
```

```
## (II) Processing PLATE:1031615
```

```
## 1: 37003
## 2: 36509
## Final: 36360.38
```

```
## (II) Processing PLATE:1031121
```

```
## 1: 34257
## Final: 33965.5
```

```
## (II) Processing PLATE:1031122
```

```
## 1: 35666
## Final: 35464.75
```

```
## (II) Processing PLATE:1031123
```

```
## 1: 26858
## Final: 26757
```

```
head(bscore_res$P001)
```

```
##                1031121    1031122    1031123    1031613     1031614    1031615
## AAK1 si3  -0.379059117  1.4344181 -0.8484694 -0.1088711 -1.14224946 -0.0854374
## AAK1 si2   0.703408672 -0.4497696 -0.2156487 -0.7355607  0.01035855  0.2937760
## AAK1 si1  -2.395497309 -1.2288465 -0.8126849  1.0424412 -0.59587991 -0.1999736
## AANAT si2 -0.004689391 -0.4785758  3.0162568 -1.7154010  2.40476344  1.8867009
## AANAT si1  0.740923801 -0.1256998 -0.5395926  0.6960949  0.15450039  1.8628214
## AANAT si3 -0.353267466  1.8881158 -1.4963572 -0.3769663  0.24491823 -0.1728052
```

*bscore\_res* is a list containing B-score of plates belonging to the same master plate. The first three plates are **treament**,
and the following three plates are **control**.

Now let’s apply the student’s t-test to the B-score and combine the results together.

```
t_res <- tTest(bscore_res$P001, 3, 3)
head(t_res)
```

```
##               pvalue  Treat_Cont     p_adj
## AAK1 si3  0.55670002  0.51448255 0.8761181
## AAK1 si2  0.75470866  0.15647216 0.9592663
## AAK1 si1  0.08470045 -1.56120548 0.8761181
## AANAT si2 0.99366232 -0.01435729 0.9936623
## AANAT si1 0.24037426 -0.87926175 0.8761181
## AANAT si3 0.91960090  0.11444817 0.9789864
```

The columns of *bscore.combined* are self-explanatory.

## 4.2 Median +- k*MAD Hits selection based on median ± k median absolute deviation (MAD) is widely used in RNAi screen data analysis due to the easy calculation and robustness to outliers in the real data and simulation study [4]. The function* madSelect\* could calculate the median of ratio between normalized treatment and control plates and label the hits based the *k* (the default value is 3). By default *madSelect* will use the fraction of samples normalization method, this could be overridden by specifying the negative control siRNA through the *normMethod* parameter.

We now apply the madSelect to our example data. *madSelection* is a list containing results for each master plate, and we combine the results together to madSelection.c. In the setting of synthetic lethal screen we are looking for the genes have a stronger knock-down effect, thus “Yes” means the **ratio < Median - k\*MAD**.

```
mad_res <- sapply((unique(example_dt$MASTER_PLATE)),
                  madSelect,
                  example_dt,
                  control   = "control",
                  treatment = "treatment",
                  simplify  = FALSE)
head(mad_res$P001)
```

```
##            MASTER_PLATE treat_cont_ratio treat_median control_median Hits
## A2M si1            P001        0.9427558    1.0201578      1.0821018   No
## A2M si2            P001        0.5500522    0.6324181      1.1497418   No
## A2M si3            P001        1.0504126    0.8768822      0.8347979   No
## A4GALT si1         P001        1.3721300    0.9530558      0.6945813   No
## A4GALT si2         P001        2.0811647    1.6950044      0.8144499   No
## A4GALT si3         P001        1.3238316    1.5751037      1.1898067   No
```

## 4.3 Rank products method

The rank products is a non-parametric statistic method proposed to find consistently up/down-regulated genes between treatment and controls replicates in microarray data, and has been successfully used in the RNAi screen data [5]. It has several advantages over the parametric Student’s t-test, including clear biological meaning, fewer assumptions of the data and improved performance. Detailed information about rank products could be found in [6] and [7].

It is straight forward to use rank product in *synlet*, as showed in the following codes.

```
rp_res <- sapply(unique(example_dt$MASTER_PLATE),
                 rankProdHits,
                 example_dt,
                 control   = "control",
                 treatment = "treatment",
                 simplify  = FALSE)
```

```
## Rank Product analysis for unpaired case
##
##
##  done  Rank Product analysis for unpaired case
##
##
##  done  Rank Product analysis for unpaired case
##
##
##  done
```

```
head(rp_res)
```

```
## $P001
##              MASTER_PLATE pvalue_treat_lowerthan_cont FDR_treat_lowerthan_cont
## A2M si1              P001                0.0611538679                1.1741543
## A2M si2              P001                0.1200339708                1.2129749
## A2M si3              P001                0.3933934135                1.0070871
## A4GALT si1           P001                0.2087136010                1.1786180
## A4GALT si2           P001                0.9343384568                0.9966277
## A4GALT si3           P001                0.4428479489                0.9447423
## A4GNT si1            P001                0.2352760896                1.0755478
## A4GNT si2            P001                0.9228047088                1.0066960
## A4GNT si3            P001                0.8998004099                1.0044284
## AACS si1             P001                0.3054049040                0.9772957
## AACS si2             P001                0.6642589751                0.9886645
## AACS si3             P001                0.9450639665                0.9861537
## AADAC si1            P001                0.2241267197                1.1324297
## AADAC si2            P001                0.2557115095                1.0673176
## AADAC si3            P001                0.2549859487                1.0879400
## AADAT si1            P001                0.4015320339                1.0012227
## AADAT si2            P001                0.4415291352                0.9525123
## AADAT si3            P001                0.9144865218                1.0033224
## AAK1 si1             P001                0.0702343636                1.0373075
## AAK1 si2             P001                0.7011786767                1.0046739
## AAK1 si3             P001                0.5567245403                0.9897325
## AANAT si1            P001                0.4495231341                0.9484444
## AANAT si2            P001                0.3795904558                0.9983749
## AANAT si3            P001                0.7621513910                0.9821011
## AARS si1             P001                0.8311934263                0.9790745
## AARS si2             P001                0.5664377480                0.9797842
## AARS si3             P001                0.9927235933                0.9927236
## AARS2 si1            P001                0.8249212269                0.9899055
## AARS2 si2            P001                0.2671887292                1.0058870
## AARS2 si3            P001                0.8219055608                0.9987713
## AARSD1 si1           P001                0.2712472676                0.9826316
## AARSD1 si2           P001                0.3106924607                0.9621444
## AARSD1 si3           P001                0.5311251957                0.9805388
## AASDH si1            P001                0.2719305356                0.9668641
## AASDH si2            P001                0.5709609575                0.9701284
## AASDH si3            P001                0.4391898005                0.9582323
## AASDHPPT si1         P001                0.9867387011                0.9919049
## AASDHPPT si2         P001                0.3609567310                0.9900527
## AASDHPPT si3         P001                0.4213572157                0.9865925
## AASS si1             P001                0.6290888845                0.9982237
## AASS si2             P001                0.2790412646                0.9741077
## AASS si3             P001                0.6842773282                1.0029103
## AATK si1             P001                0.6013726664                0.9868680
## AATK si2             P001                0.8162471568                1.0046119
## AATK si3             P001                0.7196253504                0.9869148
## ABAT si1             P001                0.1960419929                1.2141956
## ABAT si2             P001                0.5001894626                0.9900657
## ABAT si3             P001                0.1497944029                1.1983552
## ABCA1 si1            P001                0.8991326545                1.0095525
## ABCA1 si2            P001                0.3591885834                0.9994813
## ABCA1 si3            P001                0.3572692240                1.0238163
## ABCA10 si1           P001                0.1109528299                1.3314340
## ABCA10 si2           P001                0.1689068649                1.1582185
## ABCA10 si3           P001                0.5099611586                0.9791254
## ABCA12 si1           P001                0.0535286094                1.1419437
## ABCA12 si2           P001                0.4328784607                0.9777961
## ABCA12 si3           P001                0.2701533133                0.9974892
## ABCA13 si1           P001                0.1503511725                1.1546970
## ABCA13 si2           P001                0.4647227084                0.9594275
## ABCA13 si3           P001                0.5620971599                0.9901161
## ABCA2 si1            P001                0.3151414431                0.9604311
## ABCA2 si2            P001                0.0076765252                0.7369464
## ABCA2 si3            P001                0.7953416138                0.9915947
## ABCA3 si1            P001                0.2167236337                1.1558594
## ABCA3 si2            P001                0.9664377732                0.9766108
## ABCA3 si3            P001                0.2280319137                1.1226187
## ABCA4 si1            P001                0.9420519327                0.9938130
## ABCA4 si2            P001                0.2518575422                1.0990147
## ABCA4 si3            P001                0.3588843330                1.0133205
## ABCA5 si1            P001                0.7055409908                0.9960579
## ABCA5 si2            P001                0.6588382948                0.9882574
## ABCA5 si3            P001                0.7285382871                0.9781773
## ABCA6 si1            P001                0.9255607154                1.0039981
## ABCA6 si2            P001                0.4832342057                0.9766418
## ABCA6 si3            P001                0.5262804807                0.9810277
## ABCA7 si1            P001                0.3401147980                0.9894249
## ABCA7 si2            P001                0.7731312262                0.9896080
## ABCA7 si3            P001                0.7501158797                0.9797432
## ABCA8 si1            P001                0.8409346390                0.9845088
## ABCA8 si2            P001                0.6183631469                0.9893810
## ABCA8 si3            P001                0.5347883030                0.9686732
## ABCA9 si1            P001                0.4391465265                0.9691510
## ABCA9 si2            P001                0.1157995443                1.2351951
## ABCA9 si3            P001                0.9432536263                0.9896431
## ABCB1 si1            P001                0.0668438712                1.0695019
## ABCB1 si2            P001                0.5892017613                0.9752305
## ABCB1 si3            P001                0.2349989681                1.1004830
## ABCB10 si1           P001                0.4795238646                0.9794530
## ABCB10 si2           P001                0.2880067948                0.9372425
## ABCB10 si3           P001                0.3631775498                0.9821139
## ABCB11 si1           P001                0.6569625339                0.9932032
## ABCB11 si2           P001                0.1483593815                1.2947728
## ABCB11 si3           P001                0.9549207343                0.9752382
## ABCB4 si1            P001                0.0824846694                1.0558038
## ABCB4 si2            P001                0.2589079788                1.0576666
## ABCB4 si3            P001                0.9327516009                1.0004933
## ABCB5 si1            P001                0.4291917584                0.9810097
## ABCB5 si2            P001                0.9474828553                0.9833336
## ABCB5 si3            P001                0.3256338019                0.9618722
## ABCB6 si1            P001                0.5160357265                0.9713614
## ABCB6 si2            P001                0.5754592256                0.9691945
## ABCB6 si3            P001                0.7164497769                0.9896285
## ABCB7 si1            P001                0.1127179630                1.2730499
## ABCB7 si2            P001                0.8665724240                0.9962988
## ABCB7 si3            P001                0.0007314109                0.1404309
## ABCB8 si1            P001                0.2664482038                1.0231611
## ABCB8 si2            P001                0.0466184075                1.2786763
## ABCB8 si3            P001                0.9356720956                0.9925361
## ABCB9 si1            P001                0.5330040688                0.9746360
## ABCB9 si2            P001                0.8079487951                1.0008140
## ABCB9 si3            P001                0.4234856661                0.9796295
## ABCC1 si1            P001                0.1464920921                1.3393563
## ABCC1 si2            P001                0.1487018390                1.2413371
## ABCC1 si3            P001                0.5156478693                0.9802415
## ABCC10 si1           P001                0.1793679553                1.1875396
## ABCC10 si2           P001                0.6144479929                0.9913783
## ABCC10 si3           P001                0.2181221620                1.1318772
## ABCC11 si1           P001                0.8908419765                1.0061274
## ABCC11 si2           P001                0.7113807185                0.9897471
## ABCC11 si3           P001                0.5088622782                0.9969547
## ABCC12 si1           P001                0.0368981000                1.1807392
## ABCC12 si2           P001                0.6019396105                0.9794272
## ABCC12 si3           P001                0.3968897086                1.0026687
## ABCC2 si1            P001                0.7231003594                0.9846473
## ABCC2 si2            P001                0.4902567252                0.9805135
## ABCC2 si3            P001                0.1933334509                1.2373341
## MARCH1 si1           P001                0.7381001062                0.9773463
## MARCH1 si2           P001                0.8832415638                1.0094189
## MARCH1 si3           P001                0.0328444605                1.2612273
## MARCH2 si1           P001                0.9534496327                0.9842061
## MARCH2 si2           P001                0.8863307722                1.0069557
## MARCH2 si3           P001                0.6504129495                0.9911054
## MARCH3 si1           P001                0.8178499634                1.0001732
## MARCH3 si2           P001                0.3870007196                1.0041100
## MARCH3 si3           P001                0.8246730705                0.9958316
## MARCH4 si1           P001                0.0646730352                1.1288384
## MARCH4 si2           P001                0.6966002540                1.0056184
## MARCH4 si3           P001                0.6858265069                0.9975658
## MARCH5 si1           P001                0.7947677408                0.9973556
## MARCH5 si2           P001                0.7021583435                0.9986252
## MARCH5 si3           P001                0.8472758188                0.9859210
## MARCH6 si1           P001                0.7407529267                0.9741408
## MARCH6 si2           P001                0.4585494403                0.9569727
## MARCH6 si3           P001                0.8626077040                0.9977149
## MARCH8 si1           P001                0.3226337717                0.9679013
## MARCH8 si2           P001                0.2147337925                1.1779682
## MARCH8 si3           P001                0.6800638399                1.0044020
## MARCH9 si1           P001                0.3078822596                0.9690720
## MARCH9 si2           P001                0.2853717003                0.9446787
## MARCH9 si3           P001                0.6293779038                0.9904964
## PDE12 si1            P001                0.4089955983                0.9694710
## PDE12 si2            P001                0.2636670896                1.0331445
## PDE12 si3            P001                0.2826903397                0.9522201
## RBFOX1 si1           P001                0.1592083439                1.1321482
## RBFOX1 si2           P001                0.9078246102                1.0017375
## RBFOX1 si3           P001                0.9279157416                1.0008979
## SEPT1 si1            P001                0.1999232221                1.1995393
## SEPT1 si2            P001                0.2797291276                0.9590713
## SEPT1 si3            P001                0.9548297208                0.9803599
## SEPT10 si1           P001                0.0719487533                0.9867258
## SEPT10 si2           P001                0.2492449695                1.1129078
## SEPT10 si3           P001                0.7253821653                0.9807984
## SEPT11 si1           P001                0.2600860344                1.0403441
## SEPT11 si2           P001                0.5565055780                0.9985894
## SEPT11 si3           P001                0.4038461426                0.9814995
## SEPT12 si1           P001                0.6324339416                0.9872140
## SEPT12 si2           P001                0.6387281331                0.9810864
## SEPT12 si3           P001                0.7731648325                0.9830970
## SEPT14 si1           P001                0.6385711776                0.9887554
## SEPT14 si2           P001                0.2029940462                1.1810563
## SEPT14 si3           P001                0.4066451771                0.9759484
## SEPT2 si1            P001                0.7340013452                0.9786685
## SEPT2 si2            P001                0.7509977175                0.9742673
## SEPT2 si3            P001                0.4350659593                0.9713100
## SEPT3 si1            P001                0.0471133305                1.1307199
## SEPT3 si2            P001                0.0324993672                1.5599696
## SEPT3 si3            P001                0.1269338151                1.2185646
## SEPT4 si1            P001                0.0133572835                0.8548661
## SEPT4 si2            P001                0.4018825799                0.9892494
## SEPT4 si3            P001                0.9004509202                0.9993444
## SEPT5 si1            P001                0.3744802408                0.9986140
## SEPT5 si2            P001                0.5887543915                0.9829639
## SEPT5 si3            P001                0.8274106647                0.9867258
## SEPT6 si1            P001                0.5627950092                0.9823331
## SEPT6 si2            P001                0.7777102559                0.9823708
## SEPT6 si3            P001                0.8297294660                0.9833831
## SEPT7 si1            P001                0.5096614734                0.9884344
## SEPT7 si2            P001                0.5679417465                0.9736144
## SEPT7 si3            P001                0.9592473342                0.9744735
## SEPT9 si1            P001                0.1518602959                1.1214299
## SEPT9 si2            P001                0.7110991537                0.9965769
## SEPT9 si3            P001                0.2317327874                1.1123174
##              treat_cont_log2FC
## A2M si1           -0.642752923
## A2M si2           -0.471593565
## A2M si3           -0.230002531
## A4GALT si1         0.210760723
## A4GALT si2         0.806341462
## A4GALT si3        -0.098293743
## A4GNT si1         -0.493250613
## A4GNT si2          1.005688215
## A4GNT si3          0.538373735
## AACS si1          -0.326538033
## AACS si2           0.044541120
## AACS si3           1.101071893
## AADAC si1         -0.386775496
## AADAC si2         -0.301894192
## AADAC si3         -0.047546282
## AADAT si1         -0.281953405
## AADAT si2         -0.237892597
## AADAT si3          0.678590774
## AAK1 si1          -0.704448724
## AAK1 si2           0.155395115
## AAK1 si3           0.018494773
## AANAT si1         -0.210320819
## AANAT si2         -0.092241794
## AANAT si3          0.310013278
## AARS si1           0.399325479
## AARS si2           0.330109831
## AARS si3           1.222128665
## AARS2 si1          0.439350505
## AARS2 si2         -0.220401132
## AARS2 si3          0.366154231
## AARSD1 si1         0.080687495
## AARSD1 si2        -0.292866666
## AARSD1 si3        -0.099566839
## AASDH si1         -0.488771511
## AASDH si2         -0.035187708
## AASDH si3         -0.192514564
## AASDHPPT si1       1.107468954
## AASDHPPT si2      -0.340073035
## AASDHPPT si3      -0.145538893
## AASS si1           0.018303544
## AASS si2          -0.379009240
## AASS si3           0.115531491
## AATK si1           0.230937090
## AATK si2           0.332582178
## AATK si3           0.071720559
## ABAT si1          -0.526149889
## ABAT si2          -0.148450169
## ABAT si3          -0.615228726
## ABCA1 si1          0.445900038
## ABCA1 si2         -0.318467263
## ABCA1 si3         -0.166233923
## ABCA10 si1        -0.482137418
## ABCA10 si2        -0.620878314
## ABCA10 si3         0.270638991
## ABCA12 si1        -0.817903254
## ABCA12 si2        -0.064621811
## ABCA12 si3        -0.461765543
## ABCA13 si1        -0.172482198
## ABCA13 si2        -0.146709800
## ABCA13 si3         0.244694446
## ABCA2 si1         -0.367364021
## ABCA2 si2         -1.115620107
## ABCA2 si3          0.221568591
## ABCA3 si1         -0.531452458
## ABCA3 si2          0.768639095
## ABCA3 si3         -0.044547897
## ABCA4 si1          0.654654294
## ABCA4 si2         -0.396901028
## ABCA4 si3          0.172958015
## ABCA5 si1          0.272237146
## ABCA5 si2          0.117514691
## ABCA5 si3          0.192767370
## ABCA6 si1          0.547037914
## ABCA6 si2         -0.199620500
## ABCA6 si3         -0.048623911
## ABCA7 si1         -0.328832254
## ABCA7 si2          0.296397958
## ABCA7 si3          0.262053855
## ABCA8 si1          0.386022884
## ABCA8 si2          0.073919573
## ABCA8 si3          0.053689888
## ABCA9 si1         -0.134418255
## ABCA9 si2         -0.333186803
## ABCA9 si3          0.996799028
## ABCB1 si1         -0.702966064
## ABCB1 si2          0.451240547
## ABCB1 si3         -0.375187690
## ABCB10 si1        -0.089700755
## ABCB10 si2         0.090081742
## ABCB10 si3        -0.039085283
## ABCB11 si1         0.069130778
## ABCB11 si2        -0.553401541
## ABCB11 si3         1.111462655
## ABCB4 si1         -0.232055905
## ABCB4 si2         -0.430213990
## ABCB4 si3          0.727083667
## ABCB5 si1         -0.209274257
## ABCB5 si2          0.860034059
## ABCB5 si3         -0.253454182
## ABCB6 si1         -0.115116689
## ABCB6 si2         -0.069700738
## ABCB6 si3          0.354165952
## ABCB7 si1         -0.635154070
## ABCB7 si2          0.332469490
## ABCB7 si3         -1.746733374
## ABCB8 si1          0.795241401
## ABCB8 si2         -0.776562822
## ABCB8 si3          0.553172527
## ABCB9 si1         -0.125837597
## ABCB9 si2          0.393606060
## ABCB9 si3         -0.079843701
## ABCC1 si1         -0.655892262
## ABCC1 si2         -0.618615145
## ABCC1 si3          0.111667615
## ABCC10 si1        -0.105748945
## ABCC10 si2         0.405956629
## ABCC10 si3        -0.516073326
## ABCC11 si1         0.666982925
## ABCC11 si2         0.118372055
## ABCC11 si3        -0.069326278
## ABCC12 si1        -0.705370770
## ABCC12 si2         0.226446070
## ABCC12 si3        -0.251067085
## ABCC2 si1          0.269424998
## ABCC2 si2         -0.149498040
## ABCC2 si3         -0.431769121
## MARCH1 si1         0.145177413
## MARCH1 si2         0.692886101
## MARCH1 si3        -0.290463445
## MARCH2 si1         0.774885211
## MARCH2 si2         0.445513970
## MARCH2 si3         0.072672116
## MARCH3 si1         0.565269868
## MARCH3 si2        -0.211169787
## MARCH3 si3         0.743504779
## MARCH4 si1        -0.636347499
## MARCH4 si2         0.196685408
## MARCH4 si3         0.046064546
## MARCH5 si1         0.405883950
## MARCH5 si2         0.100751490
## MARCH5 si3         0.551943221
## MARCH6 si1         0.102292402
## MARCH6 si2        -0.142691220
## MARCH6 si3         0.578722602
## MARCH8 si1        -0.167719423
## MARCH8 si2        -0.120903732
## MARCH8 si3         0.064732870
## MARCH9 si1         0.308909616
## MARCH9 si2        -0.421638514
## MARCH9 si3         0.140926982
## PDE12 si1         -0.297765639
## PDE12 si2         -0.319725388
## PDE12 si3         -0.382383482
## RBFOX1 si1        -0.400956406
## RBFOX1 si2         0.496498011
## RBFOX1 si3         0.974177127
## SEPT1 si1         -0.512433396
## SEPT1 si2         -0.170563030
## SEPT1 si3          0.615587790
## SEPT10 si1        -0.375013554
## SEPT10 si2        -0.438648032
## SEPT10 si3         0.291851777
## SEPT11 si1        -0.464925918
## SEPT11 si2         0.058689055
## SEPT11 si3        -0.205555480
## SEPT12 si1        -0.006655006
## SEPT12 si2         0.004863198
## SEPT12 si3         0.353635539
## SEPT14 si1        -0.001675321
## SEPT14 si2        -0.567674976
## SEPT14 si3        -0.148223434
## SEPT2 si1          0.172286382
## SEPT2 si2          0.318410231
## SEPT2 si3         -0.167537814
## SEPT3 si1         -0.860700922
## SEPT3 si2         -1.085586408
## SEPT3 si3         -0.549254745
## SEPT4 si1         -1.187162297
## SEPT4 si2         -0.130367211
## SEPT4 si3          0.385862747
## SEPT5 si1         -0.124258087
## SEPT5 si2         -0.034968284
## SEPT5 si3          0.192394438
## SEPT6 si1          0.291836886
## SEPT6 si2          0.205058935
## SEPT6 si3          0.334184351
## SEPT7 si1         -0.132248579
## SEPT7 si2         -0.050601315
## SEPT7 si3          0.730347563
## SEPT9 si1         -0.660659591
## SEPT9 si2          0.073371845
## SEPT9 si3         -0.497496944
##
## $P002
##             MASTER_PLATE pvalue_treat_lowerthan_cont FDR_treat_lowerthan_cont
## ABCC3 si1           P002                0.5545543906                1.0337325
## ABCC3 si2           P002                0.0836774521                0.8925595
## ABCC3 si3           P002                0.7627071053                0.9634195
## ABCC4 si1           P002                0.5246869303                1.0385556
## ABCC4 si2           P002                0.3217898286                1.1441416
## ABCC4 si3           P002                0.9207189133                0.9931350
## ABCC5 si1           P002                0.2171314466                1.1580344
## ABCC5 si2           P002                0.3660840097                1.0490766
## ABCC5 si3           P002                0.7069008272                0.9906931
## ABCC6 si1           P002                0.6050411668                1.0372134
## ABCC6 si2           P002                0.2234755936                1.1291398
## ABCC6 si3           P002                0.9389664410                0.9797911
## ABCC8 si1           P002                0.3429361816                1.1159957
## ABCC8 si2           P002                0.4528637226                1.0475884
## ABCC8 si3           P002                0.3954793956                1.0261087
## ABCC9 si1           P002                0.3370345251                1.1157005
## ABCC9 si2           P002                0.9684976930                0.9997396
## ABCC9 si3           P002                0.9543710361                0.9904824
## ABCD1 si1           P002                0.0126834222                0.8117390
## ABCD1 si2           P002                0.6829455700                0.9933754
## ABCD1 si3           P002                0.7355483566                0.9875894
## ABCD2 si1           P002                0.0031314196                0.3006163
## ABCD2 si2           P002                0.2598889688                1.1340610
## ABCD2 si3           P002                0.1957962845                1.1747777
## ABCD3 si1           P002                0.3256135551                1.1163893
## ABCD3 si2           P002                0.6121359809                1.0220009
## ABCD3 si3           P002                0.1110709854                0.8885679
## ABCD4 si1           P002                0.4916349857                1.0606058
## ABCD4 si2           P002                0.0133146038                0.6391010
## ABCD4 si3           P002                0.8838457835                1.0222795
## ABCE1 si1           P002                0.5294320137                1.0267772
## ABCE1 si2           P002                0.3768636551                1.0486641
## ABCE1 si3           P002                0.9014451172                0.9890141
## ABCF1 si1           P002                0.0560300624                0.7171848
## ABCF1 si2           P002                0.2732568198                1.1405502
## ABCF1 si3           P002                0.8039208926                0.9831389
## ABCF2 si1           P002                0.0987567904                0.9480652
## ABCF2 si2           P002                0.9376368136                0.9837501
## ABCF2 si3           P002                0.5662270313                1.0353866
## ABCF3 si1           P002                0.3587187468                1.0596000
## ABCF3 si2           P002                0.2383943164                1.1736336
## ABCF3 si3           P002                0.9013616391                0.9946059
## ABCG1 si1           P002                0.8986309849                1.0089892
## ABCG1 si2           P002                0.6679467931                1.0019202
## ABCG1 si3           P002                0.0148000101                0.5683204
## ABCG2 si1           P002                0.3335021452                1.1233756
## ABCG2 si2           P002                0.8570419094                1.0033661
## ABCG2 si3           P002                0.8469664054                1.0038120
## ABCG4 si1           P002                0.9219703464                0.9834350
## ABCG4 si2           P002                0.8284471559                1.0067206
## ABCG4 si3           P002                0.7269147404                0.9898413
## ABCG5 si1           P002                0.3699277973                1.0445020
## ABCG5 si2           P002                0.3978787275                1.0051673
## ABCG5 si3           P002                0.7535227118                0.9645091
## ABCG8 si1           P002                0.1166023195                0.8955058
## ABCG8 si2           P002                0.6188783191                1.0155952
## ABCG8 si3           P002                0.8881544792                1.0211117
## ABHD1 si1           P002                0.5360190542                1.0291566
## ABHD1 si2           P002                0.4955895435                1.0572577
## ABHD1 si3           P002                0.9978243623                0.9978244
## ABHD11 si1          P002                0.6584299436                1.0033218
## ABHD11 si2          P002                0.1110119163                0.9267082
## ABHD11 si3          P002                0.5896568194                1.0292192
## ABHD14B si1         P002                0.1745186807                1.1554340
## ABHD14B si2         P002                0.7652912953                0.9603655
## ABHD14B si3         P002                0.1326634454                0.9433845
## ABHD2 si1           P002                0.5823966339                1.0258730
## ABHD2 si2           P002                0.3213952406                1.1642997
## ABHD2 si3           P002                0.5216729585                1.0433459
## ABHD3 si1           P002                0.4456878066                1.0564452
## ABHD3 si2           P002                0.0210604177                0.6739334
## ABHD3 si3           P002                0.4774901355                1.0537713
## ABHD4 si1           P002                0.7934057438                0.9891812
## ABHD4 si2           P002                0.9188834951                0.9967550
## ABHD4 si3           P002                0.6921036331                0.9991270
## ABHD5 si1           P002                0.8966349116                1.0126700
## ABHD5 si2           P002                0.9347693095                0.9861303
## ABHD5 si3           P002                0.3816123956                1.0319659
## ABHD6 si1           P002                0.9703099825                0.9962541
## ABHD6 si2           P002                0.4292214718                1.0431712
## ABHD6 si3           P002                0.4864258330                1.0612927
## ABHD8 si1           P002                0.3108266816                1.1701710
## ABHD8 si2           P002                0.6734819969                1.0023918
## ABHD8 si3           P002                0.7389059440                0.9717119
## ABI2 si1            P002                0.2838336406                1.1121645
## ABI2 si2            P002                0.4021120506                1.0026690
## ABI2 si3            P002                0.7245530064                1.0008214
## ABI3 si1            P002                0.6097318698                1.0269168
## ABI3 si2            P002                0.7060680108                0.9968019
## ABI3 si3            P002                0.6309125586                1.0179430
## ABL1 si1            P002                0.9758159656                0.9860877
## ABL1 si2            P002                0.9012061504                1.0001825
## ABL1 si3            P002                0.6449875997                1.0068099
## ABL2 si1            P002                0.7982739979                0.9888297
## ABL2 si2            P002                0.1930264709                1.1955188
## ABL2 si3            P002                0.5997461380                1.0373987
## ABLIM1 si1          P002                0.0811308387                0.9163012
## ABLIM1 si2          P002                0.4998045548                1.0430704
## ABLIM1 si3          P002                0.7544821332                0.9593415
## ABLIM2 si1          P002                0.8348312800                1.0080981
## ABLIM2 si2          P002                0.8415499705                1.0098600
## ABLIM2 si3          P002                0.3459479296                1.0888853
## ABLIM3 si1          P002                0.0331027331                0.6355725
## ABLIM3 si2          P002                0.9215082591                0.9884334
## ABLIM3 si3          P002                0.2644531585                1.1283335
## ABO si1             P002                0.6738227506                0.9951844
## ABO si2             P002                0.3078466205                1.1821310
## ABO si3             P002                0.1271732745                0.9391257
## ABP1 si1            P002                0.5497488068                1.0348213
## ABP1 si2            P002                0.2746724500                1.1220662
## ABP1 si3            P002                0.8627301135                1.0039041
## ABR si1             P002                0.2573301458                1.1763664
## ABR si2             P002                0.3769699155                1.0339746
## ABR si3             P002                0.8529525388                1.0047048
## ABTB2 si1           P002                0.7269043425                0.9968974
## ABTB2 si2           P002                0.3450902212                1.1042887
## ABTB2 si3           P002                0.7304659337                0.9876722
## ACAA1 si1           P002                0.6157063722                1.0191002
## ACAA1 si2           P002                0.0318841373                0.6801949
## ACAA1 si3           P002                0.8962286754                1.0182006
## ACAA2 si1           P002                0.7360907974                0.9814544
## ACAA2 si2           P002                0.0250723261                0.6876981
## ACAA2 si3           P002                0.5270328040                1.0325541
## ACACA si1           P002                0.3912043876                1.0432117
## ACACA si2           P002                0.4477419095                1.0483713
## ACACA si3           P002                0.5101410332                1.0310219
## ACACB si1           P002                0.6760791077                0.9908946
## ACACB si2           P002                0.5007539856                1.0338147
## ACACB si3           P002                0.5803352991                1.0317072
## ACAD10 si1          P002                0.3502035078                1.0672869
## ACAD10 si2          P002                0.0341311792                0.5460989
## ACAD10 si3          P002                0.5100272861                1.0417579
## ACAD11 si1          P002                0.6061611096                1.0299375
## ACAD11 si2          P002                0.0415589996                0.5699520
## ACAD11 si3          P002                0.6313897908                1.0102237
## ACAD8 si1           P002                0.7056871867                1.0036440
## ACAD8 si2           P002                0.5460464019                1.0380288
## ACAD8 si3           P002                0.0340396535                0.5941467
## ACAD9 si1           P002                0.3488665208                1.0803608
## ACAD9 si2           P002                0.5795908633                1.0400135
## ACAD9 si3           P002                0.5553662311                1.0252915
## ACADL si1           P002                0.6970992721                0.9988288
## ACADL si2           P002                0.9004509202                1.0051545
## ACADL si3           P002                0.4322864285                1.0374874
## ACADM si1           P002                0.6425743936                1.0112646
## ACADM si2           P002                0.4546043521                1.0390957
## ACADM si3           P002                0.3974437533                1.0174560
## ACADS si1           P002                0.1054787297                0.9643770
## ACADS si2           P002                0.3524883732                1.0574651
## ACADS si3           P002                0.2108882431                1.1908983
## ACADSB si1          P002                0.0674061414                0.8088737
## ACADSB si2          P002                0.7376479898                0.9767477
## ACADSB si3          P002                0.3645484442                1.0605046
## ACADVL si1          P002                0.7227819147                1.0056096
## ACADVL si2          P002                0.6267094649                1.0197307
## ACADVL si3          P002                0.0969078183                0.9792790
## ACAT1 si1           P002                0.4599559766                1.0268785
## ACAT1 si2           P002                0.3231237915                1.1279958
## ACAT1 si3           P002                0.6549055866                1.0140474
## ACAT2 si1           P002                0.8019986820                0.9870753
## ACAT2 si2           P002                0.1658219262                1.1370646
## ACAT2 si3           P002                0.3952631635                1.0395963
## ACBD4 si1           P002                0.6663046630                1.0073267
## ACBD4 si2           P002                0.0008579681                0.1647299
## ACBD4 si3           P002                0.6561197791                1.0078000
## ACBD5 si1           P002                0.8430397012                1.0053641
## ACBD5 si2           P002                0.2556936282                1.1973946
## ACBD5 si3           P002                0.3143249951                1.1605846
## ACBD7 si1           P002                0.0355152352                0.5245327
## ACBD7 si2           P002                0.2575351400                1.1499243
## ACBD7 si3           P002                0.9708648813                0.9915216
## ASIC1 si1           P002                0.6405282944                1.0163755
## ASIC1 si2           P002                0.9800413999                0.9851725
## ASIC1 si3           P002                0.9735369614                0.9889899
## ASIC2 si1           P002                0.4157042479                1.0232720
## ASIC2 si2           P002                0.1094030203                0.9547900
## ASIC2 si3           P002                0.2469280823                1.1852548
## ASIC3 si1           P002                0.8898608388                1.0169838
## ASIC3 si2           P002                0.4561440559                1.0303489
## ASIC3 si3           P002                0.2208373690                1.1459669
## ASIC4 si1           P002                0.2078181983                1.2091241
## ASIC4 si2           P002                0.9258910033                0.9821606
## ASIC4 si3           P002                0.7494626668                0.9722759
## ASIC5 si1           P002                0.7462413810                0.9746826
## ASIC5 si2           P002                0.9032234058                0.9853346
## ASIC5 si3           P002                0.0259576812                0.6229843
## EPHX3 si1           P002                0.5750309247                1.0415654
## EPHX3 si2           P002                0.2112311079                1.1587535
## EPHX3 si3           P002                0.7516128632                0.9685213
## EPHX4 si1           P002                0.4975341403                1.0497424
## EPHX4 si2           P002                0.2788344161                1.1153377
## EPHX4 si3           P002                0.1800220336                1.1521410
##             treat_cont_log2FC
## ABCC3 si1         0.044456432
## ABCC3 si2        -0.760802637
## ABCC3 si3         0.358396601
## ABCC4 si1         0.267931801
## ABCC4 si2        -0.327492585
## ABCC4 si3         0.779763082
## ABCC5 si1        -0.076314991
## ABCC5 si2        -0.282309124
## ABCC5 si3         0.204441978
## ABCC6 si1         0.013722404
## ABCC6 si2         0.393094853
## ABCC6 si3         0.578421782
## ABCC8 si1        -0.005542042
## ABCC8 si2        -0.174731490
## ABCC8 si3        -0.218958943
## ABCC9 si1        -0.219310783
## ABCC9 si2         0.654085148
## ABCC9 si3         0.677203667
## ABCD1 si1        -1.125179351
## ABCD1 si2         0.193299533
## ABCD1 si3         0.981209240
## ABCD2 si1        -1.431438610
## ABCD2 si2        -0.217317723
## ABCD2 si3        -0.456788966
## ABCD3 si1         0.819880560
## ABCD3 si2        -0.024680790
## ABCD3 si3        -0.629989525
## ABCD4 si1        -0.090501041
## ABCD4 si2        -1.381591360
## ABCD4 si3         0.639788489
## ABCE1 si1        -0.112360388
## ABCE1 si2        -0.080918449
## ABCE1 si3         0.437538631
## ABCF1 si1        -0.921272129
## ABCF1 si2        -0.102947288
## ABCF1 si3         0.585318877
## ABCF2 si1        -0.312888370
## ABCF2 si2         0.774845946
## ABCF2 si3         0.093205920
## ABCF3 si1        -0.314432073
## ABCF3 si2        -0.391734685
## ABCF3 si3         0.854337230
## ABCG1 si1         0.585084242
## ABCG1 si2         0.090394283
## ABCG1 si3        -1.251182307
## ABCG2 si1         0.017459657
## ABCG2 si2         0.379954871
## ABCG2 si3         0.422075318
## ABCG4 si1         0.587763766
## ABCG4 si2         0.773145755
## ABCG4 si3         0.216871300
## ABCG5 si1        -0.280006137
## ABCG5 si2         0.129182363
## ABCG5 si3         0.472440767
## ABCG8 si1        -0.680042026
## ABCG8 si2         0.017963946
## ABCG8 si3         0.347747876
## ABHD1 si1         0.162969077
## ABHD1 si2         0.085302532
## ABHD1 si3         1.393706791
## ABHD11 si1        0.083918972
## ABHD11 si2       -0.717691619
## ABHD11 si3       -0.036293016
## ABHD14B si1      -0.439170996
## ABHD14B si2       0.248597742
## ABHD14B si3      -0.597586959
## ABHD2 si1         0.065038842
## ABHD2 si2        -0.312503983
## ABHD2 si3        -0.081481447
## ABHD3 si1        -0.205419896
## ABHD3 si2        -1.179902584
## ABHD3 si3        -0.076286182
## ABHD4 si1         0.263866452
## ABHD4 si2         0.667375117
## ABHD4 si3         0.114754756
## ABHD5 si1         0.703921794
## ABHD5 si2         0.591713192
## ABHD5 si3        -0.057177808
## ABHD6 si1         0.670304416
## ABHD6 si2        -0.193788714
## ABHD6 si3        -0.168639069
## ABHD8 si1        -0.071761444
## ABHD8 si2         0.066793513
## ABHD8 si3         0.503993578
## ABI2 si1         -0.350737178
## ABI2 si2         -0.170799350
## ABI2 si3          0.161161001
## ABI3 si1         -0.032458777
## ABI3 si2          0.114109652
## ABI3 si3          0.169608088
## ABL1 si1          0.810998941
## ABL1 si2          0.756045242
## ABL1 si3          0.097997447
## ABL2 si1          0.258869064
## ABL2 si2         -0.523514706
## ABL2 si3          0.163684520
## ABLIM1 si1       -0.683457325
## ABLIM1 si2        0.125183999
## ABLIM1 si3        0.534979480
## ABLIM2 si1        0.363442411
## ABLIM2 si2        0.315786286
## ABLIM2 si3        0.001937280
## ABLIM3 si1       -0.880693390
## ABLIM3 si2        0.898054996
## ABLIM3 si3       -0.364434288
## ABO si1           0.206667577
## ABO si2          -0.177199044
## ABO si3          -0.281218574
## ABP1 si1          0.014887152
## ABP1 si2          0.036565994
## ABP1 si3          0.455269051
## ABR si1          -0.443655545
## ABR si2          -0.118274133
## ABR si3           0.285198327
## ABTB2 si1         1.162764808
## ABTB2 si2        -0.282304116
## ABTB2 si3         0.149517027
## ACAA1 si1         0.052764006
## ACAA1 si2        -1.012411291
## ACAA1 si3         0.486341376
## ACAA2 si1         0.465151903
## ACAA2 si2        -0.734906859
## ACAA2 si3         0.342300507
## ACACA si1        -0.211815849
## ACACA si2        -0.100766584
## ACACA si3        -0.005799791
## ACACB si1         0.089491198
## ACACB si2         0.241067890
## ACACB si3        -0.051409880
## ACAD10 si1       -0.036458110
## ACAD10 si2       -0.957827735
## ACAD10 si3       -0.071581846
## ACAD11 si1        0.027718084
## ACAD11 si2       -0.885675167
## ACAD11 si3        0.051988851
## ACAD8 si1         0.200749107
## ACAD8 si2        -0.103544464
## ACAD8 si3        -0.770541899
## ACAD9 si1        -0.243170224
## ACAD9 si2         0.043175028
## ACAD9 si3         0.026779967
## ACADL si1         0.243643945
## ACADL si2         0.449085351
## ACADL si3        -0.180493820
## ACADM si1         0.025026745
## ACADM si2        -0.192121106
## ACADM si3        -0.257786830
## ACADS si1        -0.640906681
## ACADS si2        -0.272716052
## ACADS si3         0.056707168
## ACADSB si1       -0.473784934
## ACADSB si2        0.507064969
## ACADSB si3       -0.097113174
## ACADVL si1        0.365873720
## ACADVL si2        0.036025181
## ACADVL si3       -0.489483387
## ACAT1 si1        -0.072012857
## ACAT1 si2        -0.285856336
## ACAT1 si3         0.032240911
## ACAT2 si1         0.565624932
## ACAT2 si2        -0.676201521
## ACAT2 si3        -0.182614353
## ACBD4 si1         0.249093646
## ACBD4 si2        -1.743848199
## ACBD4 si3         0.104378536
## ACBD5 si1         0.306742737
## ACBD5 si2        -0.396079974
## ACBD5 si3        -0.292262982
## ACBD7 si1        -0.575856568
## ACBD7 si2         0.189933993
## ACBD7 si3         1.400125973
## ASIC1 si1         0.312425544
## ASIC1 si2         0.869660062
## ASIC1 si3         0.712949246
## ASIC2 si1        -0.145883683
## ASIC2 si2        -0.374238897
## ASIC2 si3        -0.282852897
## ASIC3 si1         0.523846473
## ASIC3 si2        -0.023835670
## ASIC3 si3        -0.492121964
## ASIC4 si1        -0.438901408
## ASIC4 si2         0.491036204
## ASIC4 si3         0.209365687
## ASIC5 si1         0.179450683
## ASIC5 si2         0.881292671
## ASIC5 si3        -0.927144040
## EPHX3 si1         0.138202543
## EPHX3 si2        -0.251764851
## EPHX3 si3         0.275231494
## EPHX4 si1        -0.104575185
## EPHX4 si2        -0.403204759
## EPHX4 si3        -0.548263677
##
## $P003
##            MASTER_PLATE pvalue_treat_lowerthan_cont FDR_treat_lowerthan_cont
## ACE si1            P003                 0.810069560                0.9660457
## ACE si2            P003                 0.514815200                0.9884452
## ACE si3            P003                 0.290640837                1.0731354
## ACE2 si1           P003                 0.144153637                1.1070999
## ACE2 si2           P003                 0.529993729                0.9976353
## ACE2 si3           P003                 0.550083785                0.9963782
## ACHE si1           P003                 0.266778109                1.0453346
## ACHE si2           P003                 0.144305824                1.0656430
## ACHE si3           P003                 0.553694161                0.9664480
## ACIN1 si1          P003                 0.230020635                1.0771698
## ACIN1 si2          P003                 0.465712871                1.0644866
## ACIN1 si3          P003                 0.023244617                0.5578708
## ACLY si5           P003                 0.987363130                0.9925326
## ACLY si6           P003                 0.196641111                0.9935551
## ACLY si7           P003                 0.580800449                0.9696842
## ACMSD si1          P003                 0.496295778                1.0357477
## ACMSD si2          P003                 0.663588240                0.9725873
## ACMSD si3          P003                 0.256097279                1.0243891
## ACO1 si1           P003                 0.624624299                0.9911394
## ACO1 si2           P003                 0.551004352                0.9887181
## ACO1 si3           P003                 0.988825455                0.9888255
## ACO2 si1           P003                 0.250801111                1.0468220
## ACO2 si2           P003                 0.497356360                1.0268002
## ACO2 si3           P003                 0.721376413                0.9822998
## ACOT11 si1         P003                 0.893907340                0.9807441
## ACOT11 si2         P003                 0.663044876                0.9792663
## ACOT11 si3         P003                 0.499417191                1.0093484
## ACOT12 si1         P003                 0.909098023                0.9806001
## ACOT12 si2         P003                 0.709860393                0.9805266
## ACOT12 si3         P003                 0.817173410                0.9625601
## ACOT2 si1          P003                 0.328857281                1.0886310
## ACOT2 si2          P003                 0.288491816                1.0860868
## ACOT2 si3          P003                 0.729579459                0.9727726
## ACOT4 si1          P003                 0.002723434                0.5228993
## ACOT4 si2          P003                 0.355974248                1.1023719
## ACOT4 si3          P003                 0.008032505                0.7711205
## ACOT7 si1          P003                 0.398543696                1.1252998
## ACOT7 si2          P003                 0.380060562                1.1226404
## ACOT7 si3          P003                 0.513847803                0.9965533
## ACOT8 si1          P003                 0.497534140                1.0162399
## ACOT8 si2          P003                 0.573358163                0.9828997
## ACOT8 si3          P003                 0.429779349                1.1303786
## ACOT9 si1          P003                 0.509653686                1.0087990
## ACOT9 si2          P003                 0.298152094                1.0408219
## ACOT9 si3          P003                 0.191057456                1.0189731
## ACOX1 si1          P003                 0.821290629                0.9615110
## ACOX1 si2          P003                 0.697818133                0.9708774
## ACOX1 si3          P003                 0.728678256                0.9783652
## ACOX2 si1          P003                 0.957714596                0.9993544
## ACOX2 si2          P003                 0.476380384                1.0393754
## ACOX2 si3          P003                 0.742077973                0.9826136
## ACOX3 si1          P003                 0.235696907                1.0774716
## ACOX3 si2          P003                 0.952778400                1.0051289
## ACOX3 si3          P003                 0.851014135                0.9611454
## ACOXL si1          P003                 0.341082085                1.0735698
## ACOXL si2          P003                 0.878687989                0.9808610
## ACOXL si3          P003                 0.429681694                1.1458179
## ACP1 si1           P003                 0.422579083                1.1427491
## ACP1 si2           P003                 0.552357421                0.9819687
## ACP1 si3           P003                 0.830235690                0.9660924
## ACP2 si1           P003                 0.646141188                0.9924729
## ACP2 si2           P003                 0.073622713                1.0096829
## ACP2 si3           P003                 0.103083658                0.9896031
## ACP5 si1           P003                 0.093521860                0.9450630
## ACP5 si2           P003                 0.478000265                1.0311916
## ACP5 si3           P003                 0.969598927                1.0008763
## ACP6 si1           P003                 0.436779661                1.1181559
## ACP6 si2           P003                 0.979544316                0.9898553
## ACP6 si3           P003                 0.619815458                1.0000384
## ACPL2 si1          P003                 0.474043052                1.0583287
## ACPL2 si2          P003                 0.464301282                1.0740463
## ACPL2 si3          P003                 0.677136948                0.9702261
## ACPP si1           P003                 0.510631543                1.0004210
## ACPP si2           P003                 0.379581850                1.1387456
## ACPP si3           P003                 0.432959279                1.1233538
## ACPT si1           P003                 0.770549785                0.9606854
## ACPT si2           P003                 0.693993407                0.9797554
## ACPT si3           P003                 0.442407727                1.0617785
## ACR si1            P003                 0.494599708                1.0435510
## ACR si2            P003                 0.186975437                1.0878571
## ACR si3            P003                 0.753339386                0.9773051
## ACSBG1 si1         P003                 0.594741532                0.9843998
## ACSBG1 si2         P003                 0.808014235                0.9757153
## ACSBG1 si3         P003                 0.577476120                0.9811984
## ACSBG2 si1         P003                 0.013286143                0.6377349
## ACSBG2 si2         P003                 0.756813718                0.9687216
## ACSBG2 si3         P003                 0.631785243                0.9942850
## ACSL1 si1          P003                 0.804936347                0.9781505
## ACSL1 si2          P003                 0.469704385                1.0609793
## ACSL1 si3          P003                 0.649125580                0.9813552
## ACSL3 si1          P003                 0.155994029                1.0696733
## ACSL3 si2          P003                 0.850207113                0.9659158
## ACSL3 si3          P003                 0.759584502                0.9658293
## ACSL4 si1          P003                 0.248084439                1.0584936
## ACSL4 si2          P003                 0.033838091                0.6496913
## ACSL4 si3          P003                 0.322814212                1.1067916
## ACSL5 si1          P003                 0.169799371                1.0516606
## ACSL5 si2          P003                 0.845497457                0.9662828
## ACSL5 si3          P003                 0.187051623                1.0562915
## ACSL6 si1          P003                 0.167354686                1.0710700
## ACSL6 si2          P003                 0.324975138                1.0946531
## ACSL6 si3          P003                 0.404423531                1.1092760
## ACSM1 si1          P003                 0.437660428                1.1056685
## ACSM1 si2          P003                 0.646910377                0.9857682
## ACSM1 si3          P003                 0.294061607                1.0652798
## ACSM2A si1         P003                 0.746644061                0.9752086
## ACSM2A si2         P003                 0.474908294                1.0480735
## ACSM2A si3         P003                 0.151857226                1.0798736
## ACSM2B si1         P003                 0.694781209                0.9737080
## ACSM2B si2         P003                 0.441274787                1.0724653
## ACSM2B si3         P003                 0.069514225                1.0266716
## ACSM3 si1          P003                 0.269731533                1.0357691
## ACSM3 si2          P003                 0.164119192                1.0865822
## ACSM3 si3          P003                 0.724287362                0.9793181
## ACSS1 si1          P003                 0.079627355                1.0192301
## ACSS1 si2          P003                 0.977585414                0.9931026
## ACSS1 si3          P003                 0.114682002                1.0485212
## ACSS2 si1          P003                 0.886345544                0.9836899
## ACSS2 si2          P003                 0.340768027                1.0904577
## ACSS2 si3          P003                 0.404090286                1.1244251
## ACTA1 si1          P003                 0.517738389                0.9842156
## ACTA1 si2          P003                 0.548728383                1.0033890
## ACTA1 si3          P003                 0.643465833                0.9963342
## ACTA2 si1          P003                 0.083416879                0.8897800
## ACTA2 si2          P003                 0.670602765                0.9680882
## ACTA2 si3          P003                 0.809393984                0.9712728
## ACTC1 si1          P003                 0.387449378                1.1271255
## ACTC1 si2          P003                 0.812094684                0.9624826
## ACTC1 si3          P003                 0.128808256                1.0752689
## ACTG1 si1          P003                 0.531126107                0.9900603
## ACTG1 si2          P003                 0.951168156                1.0089740
## ACTG1 si3          P003                 0.833142652                0.9636349
## ACTG2 si1          P003                 0.010218387                0.6539768
## ACTG2 si2          P003                 0.448810138                1.0638463
## ACTG2 si3          P003                 0.082724883                0.9926986
## ACTL6A si1         P003                 0.788753657                0.9707737
## ACTL6A si2         P003                 0.652138816                0.9782082
## ACTL6A si3         P003                 0.456664858                1.0692641
## ACTL6B si1         P003                 0.017410653                0.4775493
## ACTL6B si2         P003                 0.493876577                1.0536034
## ACTL6B si3         P003                 0.505081857                1.0101637
## ACTL7A si1         P003                 0.897841537                0.9794635
## ACTL7A si2         P003                 0.378072458                1.1522208
## ACTL7A si3         P003                 0.038794513                0.6771406
## ACTL7B si1         P003                 0.136098793                1.0887903
## ACTL7B si2         P003                 0.906584959                0.9834142
## ACTL7B si3         P003                 0.014768359                0.5671050
## ACTL8 si1          P003                 0.440444733                1.0841717
## ACTL8 si2          P003                 0.953989565                1.0009071
## ACTL8 si3          P003                 0.840399470                0.9662078
## ACTN1 si1          P003                 0.959714174                0.9960277
## ACTN1 si2          P003                 0.245658542                1.0719645
## ACTN1 si3          P003                 0.203589554                1.0022870
## ACTN2 si1          P003                 0.793304370                0.9701557
## ACTN2 si2          P003                 0.668253951                0.9720057
## ACTN2 si3          P003                 0.083340152                0.9412535
## ACTN3 si1          P003                 0.437959137                1.0920540
## ACTN3 si2          P003                 0.546565650                1.0090443
## ACTN3 si3          P003                 0.929429019                0.9913910
## ACTN4 si1          P003                 0.579146639                0.9754049
## ACTN4 si2          P003                 0.115409635                1.0072114
## ACTN4 si3          P003                 0.552620186                0.9734227
## ACTR10 si1         P003                 0.240587806                1.0742525
## ACTR10 si2         P003                 0.195005930                1.0119227
## ACTR10 si3         P003                 0.598530821                0.9822044
## ACTR1A si1         P003                 0.763604953                0.9645536
## ACTR1A si2         P003                 0.295253678                1.0497909
## ACTR1A si3         P003                 0.891557390                0.9837875
## ACTR1B si1         P003                 0.619991014                0.9919856
## ACTR1B si2         P003                 0.391086592                1.1207258
## ACTR1B si3         P003                 0.017048316                0.5455461
## ACTR2 si1          P003                 0.600124291                0.9764734
## ACTR2 si2          P003                 0.654302459                0.9738455
## ACTR2 si3          P003                 0.219159447                1.0519653
## ACTR3 si1          P003                 0.634430822                0.9903310
## ACTR3 si2          P003                 0.770786612                0.9547808
## ACTR3 si3          P003                 0.067625591                1.0820095
## ACTR3B si1         P003                 0.975518419                0.9962741
## ACTR3B si2         P003                 0.189076607                1.0372202
## ACTR3B si3         P003                 0.684663626                0.9737438
## ACTR5 si1          P003                 0.743909090                0.9782914
## ACTR5 si2          P003                 0.718209650                0.9849732
## ACTR5 si3          P003                 0.754964324                0.9728399
## ACTR6 si1          P003                 0.911158084                0.9773316
## ACTR6 si2          P003                 0.852971341                0.9577222
## ACTR6 si3          P003                 0.565110666                0.9774887
## ACTR8 si1          P003                 0.972333310                0.9983315
## ACTR8 si2          P003                 0.252700042                1.0323066
## ACTR8 si3          P003                 0.769822400                0.9660516
## ACTRT1 si1         P003                 0.179219323                1.0753159
## ACTRT1 si2         P003                 0.029575732                0.6309490
## ACTRT1 si3         P003                 0.330380730                1.0751373
##            treat_cont_log2FC
## ACE si1         0.4333006257
## ACE si2         0.0844739612
## ACE si3        -0.3573622807
## ACE2 si1       -0.7174841691
## ACE2 si2       -0.0827676448
## ACE2 si3        0.0008850614
## ACHE si1       -0.3303339557
## ACHE si2       -0.4400466650
## ACHE si3       -0.0033495591
## ACIN1 si1      -0.3650085502
## ACIN1 si2      -0.1594153394
## ACIN1 si3      -0.7978322059
## ACLY si5        1.2271537311
## ACLY si6        0.0529250362
## ACLY si7        0.1591417376
## ACMSD si1       0.1084406175
## ACMSD si2       0.3926564565
## ACMSD si3      -0.4486922126
## ACO1 si1        0.1483454150
## ACO1 si2        0.1696506295
## ACO1 si3        1.2268067911
## ACO2 si1       -0.0656122562
## ACO2 si2        0.1183854575
## ACO2 si3        0.5361326215
## ACOT11 si1      0.6240093555
## ACOT11 si2      0.1079269297
## ACOT11 si3      0.0140340074
## ACOT12 si1      0.6149884511
## ACOT12 si2      0.3440757295
## ACOT12 si3      0.6261636653
## ACOT2 si1      -0.4232798535
## ACOT2 si2      -0.2857313234
## ACOT2 si3       0.1997114304
## ACOT4 si1      -1.5487654112
## ACOT4 si2      -0.2491704073
## ACOT4 si3      -1.1836534492
## ACOT7 si1      -0.2417836535
## ACOT7 si2       0.8413503641
## ACOT7 si3       0.1604829400
## ACOT8 si1      -0.0678154423
## ACOT8 si2       0.0567421156
## ACOT8 si3      -0.1254724884
## ACOT9 si1       0.2121646700
## ACOT9 si2      -0.2872966756
## ACOT9 si3      -0.4846061632
## ACOX1 si1       0.9414341896
## ACOX1 si2       0.1464588201
## ACOX1 si3       0.3368252241
## ACOX2 si1       0.8584981777
## ACOX2 si2      -0.0682056897
## ACOX2 si3       0.1560271195
## ACOX3 si1      -0.5248625579
## ACOX3 si2       0.6773259294
## ACOX3 si3       0.3489700311
## ACOXL si1      -0.2339952356
## ACOXL si2       0.3975575592
## ACOXL si3      -0.1604547870
## ACP1 si1       -0.2064055333
## ACP1 si2        0.0470607804
## ACP1 si3        0.3260261754
## ACP2 si1        0.3656135646
## ACP2 si2       -0.5006882318
## ACP2 si3       -0.1988024211
## ACP5 si1       -0.4493272952
## ACP5 si2       -0.1454494014
## ACP5 si3        0.9595259606
## ACP6 si1       -0.0375874581
## ACP6 si2        0.8092553053
## ACP6 si3        0.5770228485
## ACPL2 si1      -0.0474140972
## ACPL2 si2       0.1639714839
## ACPL2 si3       0.3786313293
## ACPP si1       -0.0657335781
## ACPP si2       -0.0243645932
## ACPP si3        0.0766522398
## ACPT si1        0.7915266506
## ACPT si2        0.2843823942
## ACPT si3       -0.1379115652
## ACR si1         0.1818829434
## ACR si2        -0.5071285833
## ACR si3         0.2793989609
## ACSBG1 si1      0.0923281457
## ACSBG1 si2      0.2400015930
## ACSBG1 si3      0.0169762389
## ACSBG2 si1     -0.9772830927
## ACSBG2 si2      0.3602033442
## ACSBG2 si3      0.0745930243
## ACSL1 si1       0.3072016332
## ACSL1 si2      -0.1057354937
## ACSL1 si3       0.8890896789
## ACSL3 si1      -0.2896470546
## ACSL3 si2       0.6198467815
## ACSL3 si3       0.5110131501
## ACSL4 si1      -0.3532183393
## ACSL4 si2      -0.4947397017
## ACSL4 si3      -0.1765487391
## ACSL5 si1      -0.3427417837
## ACSL5 si2       0.5874810075
## ACSL5 si3      -0.1756598468
## ACSL6 si1      -0.4833815365
## ACSL6 si2       0.2483484671
## ACSL6 si3      -0.2105453677
## ACSM1 si1      -0.0870632038
## ACSM1 si2       0.6480416783
## ACSM1 si3       0.3509841762
## ACSM2A si1      0.1913379991
## ACSM2A si2     -0.0224704843
## ACSM2A si3     -0.5338234584
## ACSM2B si1      0.3206642701
## ACSM2B si2      0.0993041555
## ACSM2B si3     -0.7110579035
## ACSM3 si1      -0.0247322491
## ACSM3 si2      -0.5618993265
## ACSM3 si3       0.1726793531
## ACSS1 si1      -0.4391968757
## ACSS1 si2       1.0505062086
## ACSS1 si3      -0.3754022324
## ACSS2 si1       0.6750008057
## ACSS2 si2      -0.2563903946
## ACSS2 si3       0.0844092083
## ACTA1 si1      -0.0219258643
## ACTA1 si2       0.0913887628
## ACTA1 si3       0.0789910417
## ACTA2 si1      -0.4651611780
## ACTA2 si2       0.1379289136
## ACTA2 si3       0.5736643529
## ACTC1 si1      -0.2134078378
## ACTC1 si2       0.2787356982
## ACTC1 si3      -0.1841597411
## ACTG1 si1       0.0095072351
## ACTG1 si2       0.7992892016
## ACTG1 si3       0.3714543008
## ACTG2 si1      -1.0421048718
## ACTG2 si2       0.0049684099
## ACTG2 si3      -0.7818945453
## ACTL6A si1      0.4001044742
## ACTL6A si2      0.3142103417
## ACTL6A si3     -0.1485049454
## ACTL6B si1     -1.0919136548
## ACTL6B si2      0.2068464107
## ACTL6B si3     -0.0302153582
## ACTL7A si1      0.6629860859
## ACTL7A si2     -0.2245243478
## ACTL7A si3     -0.9229206161
## ACTL7B si1     -0.3142015814
## ACTL7B si2      0.5603251529
## ACTL7B si3     -1.1022927224
## ACTL8 si1      -0.1804733626
## ACTL8 si2       0.7223029128
## ACTL8 si3       0.4421572016
## ACTN1 si1       0.8786988787
## ACTN1 si2      -0.4561402610
## ACTN1 si3      -0.4618440214
## ACTN2 si1       0.3055256903
## ACTN2 si2       0.1665056189
## ACTN2 si3      -0.6317479432
## ACTN3 si1      -0.0831323549
## ACTN3 si2      -0.0705066496
## ACTN3 si3       0.8414429371
## ACTN4 si1       0.0645177829
## ACTN4 si2      -0.2799849839
## ACTN4 si3      -0.0582432500
## ACTR10 si1     -0.4171049987
## ACTR10 si2     -0.3741925025
## ACTR10 si3      0.1296686032
## ACTR1A si1      0.5244760888
## ACTR1A si2     -0.0601996130
## ACTR1A si3      0.4207186758
## ACTR1B si1      0.0792681460
## ACTR1B si2     -0.2059447676
## ACTR1B si3     -0.9761028687
## ACTR2 si1       0.0308812841
## ACTR2 si2       0.0872939033
## ACTR2 si3      -0.3558643671
## ACTR3 si1       0.0224556455
## ACTR3 si2       0.3834879848
## ACTR3 si3      -0.4760454396
## ACTR3B si1      1.1666001129
## ACTR3B si2     -0.5666646068
## ACTR3B si3      0.2149889541
## ACTR5 si1       0.2231762421
## ACTR5 si2       0.1570354783
## ACTR5 si3       0.2561972114
## ACTR6 si1       0.8895109323
## ACTR6 si2       0.4258319547
## ACTR6 si3       0.0124899564
## ACTR8 si1       0.6958281997
## ACTR8 si2      -0.2480679708
## ACTR8 si3       0.3057647497
## ACTRT1 si1     -0.5235631450
## ACTRT1 si2     -1.0014429414
## ACTRT1 si3     -0.2965465714
```

We could select interesting siRNA hits by FDR or pvalue in the *rankp.c*,

## 4.4 Redundant siRNA activity method

Redundant siRNA activity (RSA) is a novel method proposed for RNAi screen data, which systemically employs the information provided by multiple siRNAs targeting a single gene to reduce the off-target and improve confirmation rate. Briefly, RSA calculates a P-value for the rank distribution of multiple siRNAs silenced the same gene under the background of all siRNA signals in the experiment by iterative hypergeometric distribution formula. Compared to the methods mentioned above, siRNAs targeted the same genes have identical P-value, and genes with several moderately effect siRNAs may have smaller P-value than genes with fewer strong effect siRNAs. *Synlet* provides a wrapper function to use the RSA R codes [8].

```
rsaHits(example_dt, treatment = "treatment", control = "control",
        normMethod = "PLATE", LB = 0.2, UB = 0.8, revHits = FALSE,
        Bonferroni = FALSE, outputFile = "RSAhits.csv")
```

```
## File written to:RSAhits.csv
```

```
## Summary of RSA:
```

```
## Total #Genes =  192
```

```
## Total #Wells =  576
```

```
## Total #Hit Genes =  104
```

```
## Total #Hit Wells =  133
```

The meaning of column names:

* Gene\_ID,Well\_ID,Score: columns from input spreadsheet
* LogP: OPI p-value in log10, i.e., -2 means 0.0
* OPI\_Hit: whether the well is a hit, 1 means yes, 0 means no
* #hitWell: number of hit wells for the gene
* #totalWell: total number of wells for the gene

  + if gene A has three wells w1, w2 and w3, and w1 and w2 are hits, #totalWell should be 3,
  + #hitWell should be 2, w1 and w2 should have OPI\_Hit set as 1
* OPI\_Rank: ranking column to sort all wells for hit picking
* Cutoff\_Rank: ranking column to sort all wells based on Score in the simple activity-based method
* Note: a rank value of 999999 means the well is not a hit

Users could pick up hits based on *rsa.res*, or calculate the FDR from *LogP* to set a stringent cut-off.

## 4.5 Summary

We have went through the process of hits selection in *synlet*. However, the siRNA hits picked by each algorithms may be different.
How to get a reasonable gene lists for further verification? Here are some simple suggestions:

* Rule of thumb, an interesting genes should show significant knock-down effect in at least two siRNA to avoid off-target effect.
* High confidence: genes are picked up by at least two methods.
* Low confidence: Get a union of siRNA identified as hits, then select genes targeted by at least 2 siRNA.
* It is always helpful to check the interested genes by *siRNAPlot*.

# 5 References

# Appendix

[1] Zhang J.H., Chung T.D. & Oldenburg K.R. A simple statistical parameter for use in evaluation and validation of high throughput screening assays. J. Biomol. Screen. B, 4 67-73 (1999).

[2] Birmingham,A. et al. (2009) Statistical methods for analysis of high-throughput RNA interference screens. Nat Methods, 6, 569–575.

[3] Whitehurst,A.W. et al. (2007) Synthetic lethal screen identification of chemosensitizer loci in cancer cells. Nature, 446, 815–819.

[4] Chung,N. et al. (2008) Median Absolute Deviation to Improve Hit Selection for Genome-Scale RNAi Screens. Journal of Biomolecular Screening, 13, 149–158.

[5] Rieber,N. et al. (2009) RNAither, an automated pipeline for the statistical analysis of high-throughput RNAi screens. Bioinformatics, 25, 678–679.

[6] Breitling,R. et al. (2004) Rank products: a simple, yet powerful, new method to detect differentially regulated genes in replicated microarray experiments. FEBS Lett, 573, 83–92.

[7] Hong,F. et al. (2006) RankProd: a bioconductor package for detecting differentially expressed genes in meta-analysis. Bioinformatics, 22, 2825–2827.

[8] Koenig, R. et al. A probability-based approach for the analysis of large-scale RNAi screens. Nat Methods 4, 847-849 (2007).

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
## [1] synlet_2.10.0    BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] gtable_0.3.6        jsonlite_2.0.0      Rmpfr_1.1-2
##  [4] dplyr_1.1.4         compiler_4.5.1      BiocManager_1.30.26
##  [7] crayon_1.5.3        Rcpp_1.1.0          tinytex_0.57
## [10] tidyselect_1.2.1    magick_2.9.0        RankProd_3.36.0
## [13] dichromat_2.0-0.1   jquerylib_0.1.4     scales_1.4.0
## [16] yaml_2.3.10         fastmap_1.2.0       ggplot2_4.0.0
## [19] R6_2.6.1            labeling_0.4.3      generics_0.1.4
## [22] patchwork_1.3.2     knitr_1.50          tibble_3.3.0
## [25] bookdown_0.45       bslib_0.9.0         pillar_1.11.1
## [28] RColorBrewer_1.1-3  rlang_1.1.6         cachem_1.1.0
## [31] xfun_0.53           sass_0.4.10         S7_0.2.0
## [34] cli_3.6.5           withr_3.0.2         magrittr_2.0.4
## [37] digest_0.6.37       grid_4.5.1          gmp_0.7-5
## [40] lifecycle_1.0.4     vctrs_0.6.5         evaluate_1.0.5
## [43] glue_1.8.0          data.table_1.17.8   farver_2.1.2
## [46] rmarkdown_2.30      tools_4.5.1         pkgconfig_2.0.3
## [49] htmltools_0.5.8.1
```