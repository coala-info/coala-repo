PowerExplorer Manual
Xu Qiao, Laura Elo

2019-01-04

Contents

Abstract

Introduction

Input Data Preparation

Power Estimation

Visualization . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
Result Summary . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

Power Predictions

Visualization . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
Result Summary . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

Parallel computation

2

2

3

4
6
7

9
12
13

15

1

Abstract

This vignette demonstrates R package PowerExplorer as a power and sample size estimation tool for RNA-Seq
and quantitative proteomics data.

PowerExplorer contains the following main features:
• Estimation of power based on the current data
• Prediction of power corresponding to the increased sample sizes
• Result visualizations

Introduction

Power and sample size estimation is one of the important principles in designing next-generation sequencing
experiments to discover diﬀerential expressions. PowerExplorer is a power estimation and prediction tool
currently applicable to RNA-Seq and quantitative proteomics experiments.

The calculation procedure starts with estimating the distribution parameters of each gene or protein. With
the obtained prior distribution of each feature, a speciﬁed amount of simulations are executed to generate
data (read counts for RNA-Seq and protein abundance for proteomics) repetitively for each entry based on
null and alternative hypotheses. Furthermore, the corresponding statistical tests (t-test or Wald-test) are
performed and the test statistics are collected. Eventually the statistics will be summarized to calculate the
statistical power.

2

Input Data Preparation

For both RNA-Seq (gene expression levels) and quantitative proteomics (protein abundance levels) datasets,
the data matrix should be arranged as genes/proteins in rows and samples in columns. Here we show a RNA
dataset as an example:

668450
808084
872192
1471498
1412591
1028072

888390
1159451
996873
730004
1075502
1274303

939871
1171040
1041867
976224
832203
1136278

1040976
806536
851849
1102569
1006920
1146456

library(PowerExplorer)
data("exampleProteomicsData")
head(exampleProteomicsData$dataMatrix)
#>
#> Protein_1
#> Protein_2
#> Protein_3
#> Protein_4
#> Protein_5
#> Protein_6
#>
#> Protein_1
#> Protein_2
#> Protein_3
#> Protein_4
#> Protein_5
#> Protein_6
#>
#> Protein_1
#> Protein_2
#> Protein_3
#> Protein_4
#> Protein_5
#> Protein_6

Sample_A_1 Sample_A_2 Sample_A_3 Sample_A_4 Sample_A_5
1008080
775754
889652
1202674
1282106
915348
Sample_B_1 Sample_B_2 Sample_B_3 Sample_B_4 Sample_B_5
4359111
1517852
4050628
2300376
2035877
1366432
Sample_C_1 Sample_C_2 Sample_C_3 Sample_C_4 Sample_C_5
2570479
4058501
3950354
3699732
3234728
8972975

2012186
714079
4604491
1652113
2704702
1134957

1837451
1079945
3265779
1797917
2115544
2438872

3303614
4213595
5350451
4557161
3708197
1837780

3093632
3052050
3180328
2123667
1345427
3957101

4113386
9508269
5616083
1607928
2707825
3608012

2760696
5479397
2329892
1768735
776261
2844246

3723468
5278913
5666823
3850669
3078232
2328815

3974813
4342755
5167265
2938020
2818278
4149520

A grouping vector indicating the sample groups to which all the samples belong should also be created, for
example:

show(exampleProteomicsData$groupVec)
#> [1] "A" "A" "A" "A" "A" "B" "B" "B" "B" "B" "C" "C" "C" "C" "C"

The sample groups corresponding to the data:

colnames(exampleProteomicsData$dataMatrix)
#> [1] "Sample_A_1" "Sample_A_2" "Sample_A_3" "Sample_A_4" "Sample_A_5"
#> [6] "Sample_B_1" "Sample_B_2" "Sample_B_3" "Sample_B_4" "Sample_B_5"
#> [11] "Sample_C_1" "Sample_C_2" "Sample_C_3" "Sample_C_4" "Sample_C_5"

Note that the grouping vector length should be equal to the column number of the data matrix.

3

Power Estimation

Here we use a randomly generated Proteomics dataset exampleProteomicsData as an example to estimate
the current power of the dataset. The input dataset is named as dataMatrix and the grouping vector as
groupVec.
To run the estimation, apart from the input, we still need to specify the following parameters:

• isLogTransformed: FALSE; the input data is not log-transformed.
• dataType: “Proteomics”; the datatype can be declared as “Proteomics” or “RNA-Seq”.
• minLFC: 0.5; the threshold of Log2 Fold Change, proteins with lower LFC will be discarded.
• enableROTS: TRUE; Using Reproducibility-Optimized Test Statistic (ROTS) as the statistical model.
• paraROTS: the parameters to be passed to ROTS (if enabled). Check ROTS documentation for further

details on the parameters.

• alpha: 0.05; the controlled false positive (Type I Error) rate.
• ST: 50; the simulation of each gene will be run 50 times (ST>50 is recommended).
• seed: 345; optional, a seed value for the random number generator to maintain the reproducibility.
• showProcess: FALSE; no detailed processes will be shown, set to TRUE if debug is needed.
• saveSimulatedData: FALSE; if TRUE, save the simulated data in ./savedData directory.

The results will be summaried in barplot, boxplot and summary table.

library(PowerExplorer)
data("exampleProteomicsData")
res <- estimatePower(inputObject = exampleProteomicsData$dataMatrix,

groupVec = exampleProteomicsData$groupVec,
isLogTransformed = FALSE,
dataType = "Proteomics",
minLFC = 0.5,
enableROTS = TRUE,
paraROTS = list(B = 1000, K = NULL),
alpha = 0.05,
ST = 50,
seed = 345,
showProcess = FALSE,
saveResultData = FALSE
)
4 22:11:56 2019 ------##
A, B, C
5, 5, 5
50

0.5

0.05

FALSE

#> ##------ Fri Jan
#> Sample groups:
#> Num. of replicates:
#> Num. of simulations:
#> Min. Log Fold Change:
#> False Postive Rate:
#> Log-transformed:
#> ROTS enabled:
#> Parallel:
#>
#> 0 of 110 entries are filtered due to excessive zero counts
#> [vsn] Transforming data...
#>
#>
#>
#> Log2 Fold Change Quantiles:
#>
90% 100%
20%
#> 0.00 0.01 0.06 0.10 0.14 0.18 0.24 0.31 0.40 0.50 1.82

------ <A.vs.B> ------

30% 40%

0% 10%

FALSE

TRUE

60%

50%

70%

80%

4

60%

50%

70%

40%

80%

0% 10% 20% 30%

------ <A.vs.C> ------

------ <B.vs.C> ------

#>
#> [ROTS] Estimating statistics optimizing parameters...
#> [ROTS] optimization parameters:
#> a1 = 0.22, a2 = 1
#>
#> 11 of 110 proteins are over minLFC threshold 0.5.
#>
#>
#>
#> Log2 Fold Change Quantiles:
#>
90% 100%
#> 0.00 0.03 0.07 0.11 0.15 0.20 0.27 0.34 0.43 0.64 2.39
#>
#> [ROTS] Estimating statistics optimizing parameters...
#> [ROTS] optimization parameters:
#> a1 = 1, a2 = 1
#>
#> 15 of 110 proteins are over minLFC threshold 0.5.
#>
#>
#>
#> Log2 Fold Change Quantiles:
#>
90% 100%
#> 0.00 0.03 0.07 0.13 0.15 0.18 0.23 0.29 0.42 0.60 1.59
#>
#> [ROTS] Estimating statistics optimizing parameters...
#> [ROTS] optimization parameters:
#> a1 = 2.4, a2 = 1
#>
#> 15 of 110 proteins are over minLFC threshold 0.5.
#>
#> Simulation in process, it may take a few minutes...
#>
#> Power Estimation between groups A.vs.B:
#> Completed.
#> Simulation in process, it may take a few minutes...
#>
#> Power Estimation between groups A.vs.C:
#> Completed.
#> Simulation in process, it may take a few minutes...
#>
#> Power Estimation between groups B.vs.C:
#> Completed.

0% 10% 20% 30%

60%

70%

80%

50%

40%

5

Visualization

The estimated results can be summarized using plotEstPwr, the only input needed is the estimatedPower,
which should be the estimated power object returned from estimatePower.
plotEstPwr(res)

The graph contains 3 plots, the barplot vertically shows the number of genes/proteins above the minLFC
threshold, columns indicates the comparison pairs, each column presents the proportions of three power levels
in three colours as indicated in the legend power.level; The boxplot shows the overall power distribution of
each comparsion; And the summary table summarize the power in a numerical way with the same information
shown in the previous two plots.

6

051015A.vs.BA.vs.CB.vs.CComparison pairNum of proteins above minLFCpower.levelhigh (0.8, 1)low (0.4, 0.8)mere (0, 0.4)minLFC threshold: 0.5Barplot0.20.40.60.81.0A.vs.BA.vs.CB.vs.CComparison pairPowercomparisonA.vs.BA.vs.CB.vs.CminLFC threshold: 0.5BoxplotComp.A.vs.BProtein Num.A.vs.CAvg. PowerB.vs.CH (0.8, 1)11L (0.4, 0.8)15M (0, 0.4)150.590.900.764 (36%)13 (87%)9 (60%)2 (18%)1 (7%)4 (27%)5 (45%)1 (7%)2 (13%)Estimated Power SummaryResult Summary

With the result PowerExplorerStorage object, summarized information can be shown by show method.
res
#> ##--Parameters--##
#> -dataType: Proteomics
#> -original repNum: 5, 5, 5
#> -Comparison groups: A, B, C
#> -False positive rate: 0.05
#> -LFC threshold: 0.5
#> -Simulations: 50
#>
#> ##--Log2 Fold Change Range--##
#>
#> minLFC
#> maxLFC
#>
#> ##--Average Estimated Power--##
#>
B.vs.C
#> 0.5945455 0.8973333 0.7600000
#>
#> ##--Average Predicted Power--##
#> NA

A.vs.B A.vs.C B.vs.C
0.00
1.59

0.00
2.39

0.00
1.82

A.vs.C

A.vs.B

If interested in speciﬁc genes/proteins or a ranking list, one can use listEstPwr with the following parameters:

• inputObject: A PowerExplorerStorage returned from PowerExplorer as input
• decreasing: logical; TRUE, decreasing order; FALSE, increasing order.
• top: numeric; the number of genes/proteins in the top list
• selected: default as NA; specify as a list of geneID or protein ID to show power of a list of interested

genes/proteins.

To show the top 10 genes in an example result object exampleObject in decreasing order:
data(exampleObject)
listEstPwr(exampleObject, decreasing = TRUE, top = 10)
#>
#> ENSMUSG00000000402
#> ENSMUSG00000000958
#> ENSMUSG00000001473
#> ENSMUSG00000003477
#> ENSMUSG00000004341
#> ENSMUSG00000006154
#> ENSMUSG00000006403
#> ENSMUSG00000007035
#> ENSMUSG00000015484
#> ENSMUSG00000015852

A.vs.B
1
1
1
1
1
1
1
1
1
1

To show the results of speciﬁc genes:

listEstPwr(exampleObject,

selected = c("ENSMUSG00000000303",

#>
#> ENSMUSG00000000303

"ENSMUSG00000087272",
"ENSMUSG00000089921"))

A.vs.B
0.34

7

#> ENSMUSG00000087272
#> ENSMUSG00000089921

0.25
0.04

8

Power Predictions

With the same dataset, to run a prediction, a diﬀerent parameter is needed:

• rangeSimNumRep: the power of replicate number 5 to 20 will be predicted.

Similar to the estimation process, however, the simulations will be excuted with each sample size speciﬁed
in rangeSimNumRep. (Note: the term sample size in this vignette refers to the replicate number of each
group/case)

It is possible to append the prediction results within the same object by using the same result object as an
input.

data("exampleProteomicsData")
res <- predictPower(inputObject = res,

groupVec = exampleProteomicsData$groupVec,
isLogTransformed = FALSE,
dataType = "Proteomics",
minLFC = 0.5,
rangeSimNumRep = c(5, 10, 15, 20),
enableROTS = TRUE,
paraROTS = list(B = 1000, K = NULL),
alpha = 0.05,
ST = 50,
seed = 345)

50

0.5

TRUE

0.05

FALSE

5, 10, 15, 20

------ <A.vs.B> ------

4 22:12:23 2019 ------##
#> ##------ Fri Jan
#> Sample groups:
A, B, C
#> Replicates of prediction:
#> Num. of simulations:
#> Min. Log Fold Change:
#> False Postive Rate:
FALSE
#> Transformed:
#> ROTS enabled:
#> Parallel:
#>
#> 0 of 110 entries are filtered due to excessive zero counts
#> [vsn] Transforming data...
#>
#>
#>
#> Log2 Fold Change Quantiles:
#>
90% 100%
20%
#> 0.00 0.01 0.06 0.10 0.14 0.18 0.24 0.31 0.40 0.50 1.82
#>
#> [ROTS] Estimating statistics optimizing parameters...
#> [ROTS] optimization parameters:
#> a1 = 0.22, a2 = 1
#>
#> 11 of 110 proteins are over minLFC threshold 0.5.
#>
#>
#>
#> Log2 Fold Change Quantiles:
#>
90% 100%
20%
#> 0.00 0.03 0.07 0.11 0.15 0.20 0.27 0.34 0.43 0.64 2.39

------ <A.vs.C> ------

30% 40%

30% 40%

0% 10%

0% 10%

70%

50%

80%

50%

70%

80%

60%

60%

9

60%

40%

70%

80%

50%

0% 10% 20% 30%

------ <B.vs.C> ------

#>
#> [ROTS] Estimating statistics optimizing parameters...
#> [ROTS] optimization parameters:
#> a1 = 1, a2 = 1
#>
#> 15 of 110 proteins are over minLFC threshold 0.5.
#>
#>
#>
#> Log2 Fold Change Quantiles:
#>
90% 100%
#> 0.00 0.03 0.07 0.13 0.15 0.18 0.23 0.29 0.42 0.60 1.59
#>
#> [ROTS] Estimating statistics optimizing parameters...
#> [ROTS] optimization parameters:
#> a1 = 2.4, a2 = 1
#>
#> 15 of 110 proteins are over minLFC threshold 0.5.
#>
#> ##--Simulation with 5 replicates per group--##
#>
#> [repNum:5] Simulation in process, it may take a few minutes...
#>
#> [repNum:5] Power Estimation between groups A.vs.B:
#> Completed.
#> [repNum:5] Simulation in process, it may take a few minutes...
#>
#> [repNum:5] Power Estimation between groups A.vs.C:
#> Completed.
#> [repNum:5] Simulation in process, it may take a few minutes...
#>
#> [repNum:5] Power Estimation between groups B.vs.C:
#> Completed.
#> ##--Simulation with 10 replicates per group--##
#>
#> [repNum:10] Simulation in process, it may take a few minutes...
#>
#> [repNum:10] Power Estimation between groups A.vs.B:
#> Completed.
#> [repNum:10] Simulation in process, it may take a few minutes...
#>
#> [repNum:10] Power Estimation between groups A.vs.C:
#> Completed.
#> [repNum:10] Simulation in process, it may take a few minutes...
#>
#> [repNum:10] Power Estimation between groups B.vs.C:
#> Completed.
#> ##--Simulation with 15 replicates per group--##
#>
#> [repNum:15] Simulation in process, it may take a few minutes...
#>
#> [repNum:15] Power Estimation between groups A.vs.B:
#> Completed.

10

#> [repNum:15] Simulation in process, it may take a few minutes...
#>
#> [repNum:15] Power Estimation between groups A.vs.C:
#> Completed.
#> [repNum:15] Simulation in process, it may take a few minutes...
#>
#> [repNum:15] Power Estimation between groups B.vs.C:
#> Completed.
#> ##--Simulation with 20 replicates per group--##
#>
#> [repNum:20] Simulation in process, it may take a few minutes...
#>
#> [repNum:20] Power Estimation between groups A.vs.B:
#> Completed.
#> [repNum:20] Simulation in process, it may take a few minutes...
#>
#> [repNum:20] Power Estimation between groups A.vs.C:
#> Completed.
#> [repNum:20] Simulation in process, it may take a few minutes...
#>
#> [repNum:20] Power Estimation between groups B.vs.C:
#> Completed.

11

Visualization

The predicted results can be summaried using plotPredPwr. The input should be the predicted power object
returned from predictPower, the summary can be optionally visualized by setting the following parameters:

• inputObject: A PowerExplorerStorage returned from PowerExplorer as input
• minLFC and maxLFC: to observe power in a speciﬁc range of LFC
• LFCscale: to determine the LFC scale of the observation

Lineplot (LFCscale = 0.5):

plotPredPwr(res, LFCscale = 0.5)

The output ﬁgure contains a lineplot and a summary table. For each comparison, the lineplot shows the
power tendency across every Log2 Fold Change segment resulted from a complete LFC list divided by a
speciﬁed LFCscale. Each dot on the lines represents the average power (y-axis) of the genes/proteins at a
certain sample size (x-axis) within diﬀerent LFC ranges. In addition, a summary table below displays the
average power of each comparison across the sample sizes.

For instance, the line plot here shows the average power at four diﬀerent sample sizes (5 to 30, with increment
of 5) in LFCscale of 0.5. The LFC ranges from 0 to 5, and within each LFC segment, the graph shows the
average power of the genes/proteins. Here, the higher LFC shows higher power, the average power of each
LFC range increases with the larger sample sizes, as expected.

12

A.vs.BA.vs.CB.vs.C5101520510152051015200.50.60.70.80.91.0Replicate NumberAverage powerLFC range[0.5,1)[1.5,2)[1,1.5)[2,2.5)segmented by every 0.5 Log2FoldChange (minLFC: 0.5, maxLFC: 2.39)Average Predicted Power within LFC rangesComp.A.vs.BrepNum:5A.vs.CrepNum:10B.vs.CrepNum:150.61repNum:200.90.690.850.970.870.90.990.940.9910.97Result Summary

With the result PowerExplorerStorage object, summarized information can be shown by show method.
Both estimated and predicted results can be summaried.

A.vs.B

A.vs.C

0.00
2.39

0.00
1.82

A.vs.B A.vs.C B.vs.C
0.00
1.59

res
#> ##--Parameters--##
#> -dataType: Proteomics
#> -original repNum: 5, 5, 5
#> -Comparison groups: A, B, C
#> -False positive rate: 0.05
#> -LFC threshold: 0.5
#> -Simulations: 50
#>
#> ##--Log2 Fold Change Range--##
#>
#> minLFC
#> maxLFC
#>
#> ##--Average Estimated Power--##
#>
B.vs.C
#> 0.5945455 0.8973333 0.7600000
#>
#> ##--Average Predicted Power--##
#> $`repNum: 5`
#>
B.vs.C
#> 0.6072727 0.8973333 0.6866667
#>
#> $`repNum: 10`
#>
B.vs.C
#> 0.8509091 0.9680000 0.8666667
#>
#> $`repNum: 15`
#>
B.vs.C
#> 0.9036364 0.9866667 0.9400000
#>
#> $`repNum: 20`
#>
B.vs.C
#> 0.9854545 0.9973333 0.9693333

A.vs.C

A.vs.C

A.vs.C

A.vs.C

A.vs.B

A.vs.B

A.vs.B

A.vs.B

If interested in speciﬁc genes/proteins or a ranking list of predicted powerat each sample size, one can use
listPrePwr with the following parameters:

• inputObject: A PowerExplorerStorage returned from PowerExplorer as input
• decreasing: logical; TRUE, decreasing order; FALSE, increasing order.
• top: numeric; the number of genes/proteins in the top list
• selected: default as NA; specify as a list of geneID or protein ID to show power of a list of interested

genes/proteins.

To show the top 10 genes in an example result object exampleObject in decreasing order at each sample size:
listPredPwr(exampleObject, decreasing = TRUE, top = 10)
#> $`repNum: 10`
#>
#> ENSMUSG00000000402
#> ENSMUSG00000000958

A.vs.B
1
1

13

#> ENSMUSG00000001473
#> ENSMUSG00000003477
#> ENSMUSG00000004341
#> ENSMUSG00000005553
#> ENSMUSG00000006154
#> ENSMUSG00000006403
#> ENSMUSG00000007035
#> ENSMUSG00000011263
#>
#> $`repNum: 15`
#>
#> ENSMUSG00000000402
#> ENSMUSG00000000958
#> ENSMUSG00000001473
#> ENSMUSG00000001493
#> ENSMUSG00000003477
#> ENSMUSG00000004341
#> ENSMUSG00000005553
#> ENSMUSG00000005681
#> ENSMUSG00000006154
#> ENSMUSG00000006403
#>
#> $`repNum: 20`
#>
#> ENSMUSG00000000402
#> ENSMUSG00000000958
#> ENSMUSG00000001473
#> ENSMUSG00000001493
#> ENSMUSG00000003477
#> ENSMUSG00000004341
#> ENSMUSG00000004709
#> ENSMUSG00000005553
#> ENSMUSG00000005681
#> ENSMUSG00000006154
#>
#> $`repNum: 30`
#>
#> ENSMUSG00000000402
#> ENSMUSG00000000958
#> ENSMUSG00000001473
#> ENSMUSG00000001493
#> ENSMUSG00000003355
#> ENSMUSG00000003477
#> ENSMUSG00000004341
#> ENSMUSG00000004709
#> ENSMUSG00000005553
#> ENSMUSG00000005677

1
1
1
1
1
1
1
1

A.vs.B
1
1
1
1
1
1
1
1
1
1

A.vs.B
1
1
1
1
1
1
1
1
1
1

A.vs.B
1
1
1
1
1
1
1
1
1
1

To show the results of speciﬁc genes at each sample size:

listPredPwr(exampleObject,

selected = c("ENSMUSG00000000303",
"ENSMUSG00000087272",
"ENSMUSG00000089921"))

14

#> $`repNum: 10`
#>
#> ENSMUSG00000000303
#> ENSMUSG00000087272
#> ENSMUSG00000089921
#>
#> $`repNum: 15`
#>
#> ENSMUSG00000000303
#> ENSMUSG00000087272
#> ENSMUSG00000089921
#>
#> $`repNum: 20`
#>
#> ENSMUSG00000000303
#> ENSMUSG00000087272
#> ENSMUSG00000089921
#>
#> $`repNum: 30`
#>
#> ENSMUSG00000000303
#> ENSMUSG00000087272
#> ENSMUSG00000089921

A.vs.B
0.28
0.16
0.01

A.vs.B
0.39
0.17
0.00

A.vs.B
0.37
0.35
0.02

A.vs.B
0.64
0.56
0.01

Parallel computation

The calculation may take much longer time when an input dataset contains more than thousands of features,
especially for the power prediction process. The computational time can be signiﬁcantly shortened by using
parallelised computation, and the simulations will be distributed to multiple cores. This can be done by
loading Bioconductor pacakge BiocParallel and then set the following arguments of estimatePower and
predictPower: parallel=TRUE and BPPARAM=bpparam(). This will distribute the jobs to all the available
cores. One can register the number of cores to be used by setting BPPARAM=MulticoreParam(4), for instance,
distributing simulations (jobs) to 4 cores. However, MulticoreParam() only supports non-Windows platforms.
For Windows platforms, one can use SnowParam() instead. For further details, please check the BiocParallel
documentation.

15

