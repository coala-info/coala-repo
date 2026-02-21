# ImpulseDE2 Tutorial

David S. Fischer

#### *2019-01-04*

# Contents

* [1 Introduction](#introduction)
* [2 Case-only differential expression analysis](#case-only-differential-expression-analysis)
* [3 Batch effects](#batch-effects)
* [4 Plot gene-wise trajectories](#plot-gene-wise-trajectories)
* [5 Case-control differential expression analysis](#case-control-differential-expression-analysis)
* [6 Transiently regulated genes](#transiently-regulated-genes)
* [7 Plot global heat map of expression trajectories](#plot-global-heat-map-of-expression-trajectories)
* [8 Session information](#session-information)

# 1 Introduction

ImpulseDE2 is a differential expression algorithm for longitudinal count data sets which arise in sequencing experiments such as RNA-seq, ChIP-seq, ATAC-seq and DNaseI-seq.
ImpulseDE2 is based on a negative binomial noise model with dispersion trend smoothing by DESeq2 and uses the impulse model to constrain the mean expression trajectory of each gene.
ImpulseDE2 can correct for batch effects (from multiple confounding variables) and library depth.
We distinguish case-only and case-control differential expression analysis:
Case-only differential expression analysis tests, whether the expression level of a gene changes over time.
Case-control differential expression analysis tests, whether the expression trajectory of a gene over time differs between samples from a case and samples from a control condition.
Here, we demonstrate the usage of ImpulseDE2 in different scenarios based on simulated data.

To run ImpulseDE2 on bulk sequencing count data, a user should consider the minimal parameter set for
the wrapper function runImpulseDE2:

* matCountData
* dfAnnotation
* boolCaseCtrl
* vecConfounders

Additionally, one can provide:

* scaNProc to set the number of processes for parallelization.
* scaQThres to set the cut off for your DE gene list.
* vecDispersionsExternal to supply external dispersion parameters
  which may be necessary depending on your confounding factors (runImpulseDE2
  will tell you if it is necessary).
* vecSizeFactorsExternal to supply external size factors.
* boolVerbose to control stdout output.

# 2 Case-only differential expression analysis

Here, we present a case-only differential expression scenario without batch effects.
We simulate data from 8 time points (1 to 8 with arbitrary unit) with three replicates each (vecTimepointsA).
We simulate 300 constant expression trajectories (scaNConst),
100 impulse trajectories (scaNImp),
100 linear expression trajectories (scaNLin)
and 100 sigmoid expression trajectories (scaNSig).
The full results of the simulation are stored in dirOurSimulation.

The integer count matrix (matCountData) and the sample meta data table (dfAnnotation)
are created by the simulation function and handed directly to the ImpulseDE2 wrapper (runImpulseDE2).
This analysis is a case-only differential expression analysis (boolCaseCtrl is FALSE).
We assume that there is no batch structure (vecBatchesA) and
do accordingly not give any confounding variables (vecConfounders) to ImpulseDE2.
One could parallelize ImpulseDE2 by allowing more than one thread for runImpulseDE2 (scaNProc).

The differential expression results can be accessed as a data frame in the output object
via objectImpulseDE2$dfImpulseDE2Results.
The output object is an instance of the class ImpulseDE2Object which carries additional internal data
which can be accessed via accessor functions starting with “get\_”.

```
library(ImpulseDE2)
lsSimulatedData <- simulateDataSetImpulseDE2(
  vecTimePointsA   = rep(seq(1,8),3),
  vecTimePointsB   = NULL,
  vecBatchesA      = NULL,
  vecBatchesB      = NULL,
  scaNConst        = 30,
  scaNImp          = 10,
  scaNLin          = 10,
  scaNSig          = 10,
  scaMuBatchEffect = NULL,
  scaSDBatchEffect = NULL,
  dirOutSimulation = NULL)
```

```
lsSimulatedData$dfAnnotation
```

```
##            Sample Condition Time  Batch
## A_1_Rep1 A_1_Rep1      case    1 B_NULL
## A_2_Rep1 A_2_Rep1      case    2 B_NULL
## A_3_Rep1 A_3_Rep1      case    3 B_NULL
## A_4_Rep1 A_4_Rep1      case    4 B_NULL
## A_5_Rep1 A_5_Rep1      case    5 B_NULL
## A_6_Rep1 A_6_Rep1      case    6 B_NULL
## A_7_Rep1 A_7_Rep1      case    7 B_NULL
## A_8_Rep1 A_8_Rep1      case    8 B_NULL
## A_1_Rep2 A_1_Rep2      case    1 B_NULL
## A_2_Rep2 A_2_Rep2      case    2 B_NULL
## A_3_Rep2 A_3_Rep2      case    3 B_NULL
## A_4_Rep2 A_4_Rep2      case    4 B_NULL
## A_5_Rep2 A_5_Rep2      case    5 B_NULL
## A_6_Rep2 A_6_Rep2      case    6 B_NULL
## A_7_Rep2 A_7_Rep2      case    7 B_NULL
## A_8_Rep2 A_8_Rep2      case    8 B_NULL
## A_1_Rep3 A_1_Rep3      case    1 B_NULL
## A_2_Rep3 A_2_Rep3      case    2 B_NULL
## A_3_Rep3 A_3_Rep3      case    3 B_NULL
## A_4_Rep3 A_4_Rep3      case    4 B_NULL
## A_5_Rep3 A_5_Rep3      case    5 B_NULL
## A_6_Rep3 A_6_Rep3      case    6 B_NULL
## A_7_Rep3 A_7_Rep3      case    7 B_NULL
## A_8_Rep3 A_8_Rep3      case    8 B_NULL
```

```
objectImpulseDE2 <- runImpulseDE2(
  matCountData    = lsSimulatedData$matObservedCounts,
  dfAnnotation    = lsSimulatedData$dfAnnotation,
  boolCaseCtrl    = FALSE,
  vecConfounders  = NULL,
  scaNProc        = 1 )
```

```
head(objectImpulseDE2$dfImpulseDE2Results)
```

```
##        Gene         p      padj loglik_full loglik_red df_full df_red
## gene1 gene1 0.8858939 0.9325199   -141.4427  -142.3046       7      2
## gene2 gene2 0.2158914 0.4466718   -143.3442  -146.8764       7      2
## gene3 gene3 0.8345166 0.8945266   -158.0070  -159.0592       7      2
## gene4 gene4 0.4712136 0.7641302   -162.9350  -165.2175       7      2
## gene5 gene5 0.5801036 0.7863045   -135.3573  -137.2521       7      2
## gene6 gene6 0.4593621 0.7641302   -168.6884  -171.0161       7      2
##            mean converge_impulse converge_const allZero
## gene1  274.7356                0              0   FALSE
## gene2  396.0095                0              0   FALSE
## gene3  560.7779                0              0   FALSE
## gene4  901.2443                0              0   FALSE
## gene5  222.8498                0              0   FALSE
## gene6 1073.7825                0              0   FALSE
```

# 3 Batch effects

Here, we present a case-only differential expression scenario with batch effects.
Refer to “Case-only differential expression analysis” for details.
In addition, we simulate batch effects (vecBatchesA):
Here we assume that three batches of replicates was sampled with each batch sampled at each time point.
Such a batch structure could arise if patient-derived cell cultures are sampled over a time course,
each batch would be one patient.
Another scenario is that all samples originate from the same cell culture but were handled separately.

This confounding variable imposing the batch structure on the expression observations
is called “Batch” in the meta data table (dfAnnotation).
By handing this confounding variable to ImpulseDE2 via the vector vecConfounders,
we turn on ImpulseDE2 batch effect correction for this confounding variable.

```
library(ImpulseDE2)
lsSimulatedData <- simulateDataSetImpulseDE2(
  vecTimePointsA   = rep(seq(1,8),3),
  vecTimePointsB   = NULL,
  vecBatchesA      = c(rep("B1",8), rep("B2",8), rep("B3",8)),
  vecBatchesB      = NULL,
  scaNConst        = 30,
  scaNImp          = 10,
  scaNLin          = 10,
  scaNSig          = 10,
  scaMuBatchEffect = 1,
  scaSDBatchEffect = 0.2,
  dirOutSimulation = NULL)
```

```
lsSimulatedData$dfAnnotation
```

```
##            Sample Condition Time Batch
## A_1_Rep1 A_1_Rep1      case    1    B1
## A_2_Rep1 A_2_Rep1      case    2    B1
## A_3_Rep1 A_3_Rep1      case    3    B1
## A_4_Rep1 A_4_Rep1      case    4    B1
## A_5_Rep1 A_5_Rep1      case    5    B1
## A_6_Rep1 A_6_Rep1      case    6    B1
## A_7_Rep1 A_7_Rep1      case    7    B1
## A_8_Rep1 A_8_Rep1      case    8    B1
## A_1_Rep2 A_1_Rep2      case    1    B2
## A_2_Rep2 A_2_Rep2      case    2    B2
## A_3_Rep2 A_3_Rep2      case    3    B2
## A_4_Rep2 A_4_Rep2      case    4    B2
## A_5_Rep2 A_5_Rep2      case    5    B2
## A_6_Rep2 A_6_Rep2      case    6    B2
## A_7_Rep2 A_7_Rep2      case    7    B2
## A_8_Rep2 A_8_Rep2      case    8    B2
## A_1_Rep3 A_1_Rep3      case    1    B3
## A_2_Rep3 A_2_Rep3      case    2    B3
## A_3_Rep3 A_3_Rep3      case    3    B3
## A_4_Rep3 A_4_Rep3      case    4    B3
## A_5_Rep3 A_5_Rep3      case    5    B3
## A_6_Rep3 A_6_Rep3      case    6    B3
## A_7_Rep3 A_7_Rep3      case    7    B3
## A_8_Rep3 A_8_Rep3      case    8    B3
```

```
objectImpulseDE2 <- runImpulseDE2(
  matCountData    = lsSimulatedData$matObservedCounts,
  dfAnnotation    = lsSimulatedData$dfAnnotation,
  boolCaseCtrl    = FALSE,
  vecConfounders  = c("Batch"),
  scaNProc        = 1 )
```

```
head(objectImpulseDE2$dfImpulseDE2Results)
```

```
##        Gene         p      padj loglik_full loglik_red df_full df_red
## gene1 gene1 0.8984501 0.9294846   -144.5361  -145.3476       9      4
## gene2 gene2 0.3306831 0.6613661   -146.7998  -149.6778       9      4
## gene3 gene3 0.7756156 0.8461261   -159.2241  -160.4770       9      4
## gene4 gene4 0.7044508 0.8453410   -166.4532  -167.9387       9      4
## gene5 gene5 0.5833712 0.8274777   -137.0297  -138.9134       9      4
## gene6 gene6 0.4728468 0.8189169   -171.8352  -174.1116       9      4
##            mean converge_impulse converge_const allZero
## gene1  329.0601                0              0   FALSE
## gene2  482.1762                0              0   FALSE
## gene3  709.0049                0              0   FALSE
## gene4 1070.8700                0              0   FALSE
## gene5  217.4998                0              0   FALSE
## gene6 1137.2637                0              0   FALSE
```

# 4 Plot gene-wise trajectories

Here, we present the visualization of gene-wise expression trajectory fits.
Refer to “Batch effects” for details on the data and the inferred model.

The user can decide whether to plot the expression trajectories with the lowest q-values (set the number of trajectories to plot, scaNTopIDs) or
to plot specific trajectories (supply a vector of gene identifiers, row names of matCounts via vecGeneIDs).
The central input to plotGenes is an ImpulseDE2 output object (objectImpulseDE2) which carries fits and data.
The user can specify whether case and control fits are to be plotted (boolCaseCtrl).

The plots can be annotated with p- or q-values from an alternative differential expression algorithm:
Supply a vector of the alternative p-values (vecRefPval) named with the row names (gene identifiers) of matCounts
and a name of the alternative method to the plotGenes (strNameRefMethod).
The values will are added into the plot title.

The plots are printed to a .pdf if an output directory (dirOut) and file name (strFileName) is given.
Alternatively, the user can also directly access the plot objects made with ggplot2 via the output list
of ggplot2 plots.

Note that the observations in the plot are size factor normalized to guide the evaluation of the model.
The model is not fit on normalized data but the model is normalized itself based on the factors used for data normalization here.

```
# Continue script of "Batch effects"
library(ggplot2)
lsgplotsGenes <- plotGenes(
  vecGeneIDs       = NULL,
  scaNTopIDs       = 10,
  objectImpulseDE2 = objectImpulseDE2,
  boolCaseCtrl     = FALSE,
  dirOut           = NULL,
  strFileName      = NULL,
  vecRefPval       = NULL,
  strNameRefMethod = NULL)
print(lsgplotsGenes[[1]])
```

![](data:image/png;base64...)

# 5 Case-control differential expression analysis

Here, we present a case-control differential expression scenario with batch effects.
Refer to “Batch effects” for details.
Building on the scenarios presented previously, we now have samples from two conditions
(vecTimePointsA (case) and vecTimePointsB (control)) with 8 time points and three replicates each, one replicate per batch.
Here, the batches do not overlap the conditions.

```
lsSimulatedData <- simulateDataSetImpulseDE2(
  vecTimePointsA   = rep(seq(1,8),3),
  vecTimePointsB   = rep(seq(1,8),3),
  vecBatchesA      = c(rep("B1",8), rep("B2",8), rep("B3",8)),
  vecBatchesB      = c(rep("C1",8), rep("C2",8), rep("C3",8)),
  scaNConst        = 30,
  scaNImp          = 10,
  scaNLin          = 10,
  scaNSig          = 10,
  scaMuBatchEffect = 1,
  scaSDBatchEffect = 0.1,
  dirOutSimulation = NULL)
```

```
lsSimulatedData$dfAnnotation
```

```
##            Sample Condition Time Batch
## A_1_Rep1 A_1_Rep1      case    1    B1
## A_2_Rep1 A_2_Rep1      case    2    B1
## A_3_Rep1 A_3_Rep1      case    3    B1
## A_4_Rep1 A_4_Rep1      case    4    B1
## A_5_Rep1 A_5_Rep1      case    5    B1
## A_6_Rep1 A_6_Rep1      case    6    B1
## A_7_Rep1 A_7_Rep1      case    7    B1
## A_8_Rep1 A_8_Rep1      case    8    B1
## A_1_Rep2 A_1_Rep2      case    1    B2
## A_2_Rep2 A_2_Rep2      case    2    B2
## A_3_Rep2 A_3_Rep2      case    3    B2
## A_4_Rep2 A_4_Rep2      case    4    B2
## A_5_Rep2 A_5_Rep2      case    5    B2
## A_6_Rep2 A_6_Rep2      case    6    B2
## A_7_Rep2 A_7_Rep2      case    7    B2
## A_8_Rep2 A_8_Rep2      case    8    B2
## A_1_Rep3 A_1_Rep3      case    1    B3
## A_2_Rep3 A_2_Rep3      case    2    B3
## A_3_Rep3 A_3_Rep3      case    3    B3
## A_4_Rep3 A_4_Rep3      case    4    B3
## A_5_Rep3 A_5_Rep3      case    5    B3
## A_6_Rep3 A_6_Rep3      case    6    B3
## A_7_Rep3 A_7_Rep3      case    7    B3
## A_8_Rep3 A_8_Rep3      case    8    B3
## B_1_Rep1 B_1_Rep1   control    1    C1
## B_2_Rep1 B_2_Rep1   control    2    C1
## B_3_Rep1 B_3_Rep1   control    3    C1
## B_4_Rep1 B_4_Rep1   control    4    C1
## B_5_Rep1 B_5_Rep1   control    5    C1
## B_6_Rep1 B_6_Rep1   control    6    C1
## B_7_Rep1 B_7_Rep1   control    7    C1
## B_8_Rep1 B_8_Rep1   control    8    C1
## B_1_Rep2 B_1_Rep2   control    1    C2
## B_2_Rep2 B_2_Rep2   control    2    C2
## B_3_Rep2 B_3_Rep2   control    3    C2
## B_4_Rep2 B_4_Rep2   control    4    C2
## B_5_Rep2 B_5_Rep2   control    5    C2
## B_6_Rep2 B_6_Rep2   control    6    C2
## B_7_Rep2 B_7_Rep2   control    7    C2
## B_8_Rep2 B_8_Rep2   control    8    C2
## B_1_Rep3 B_1_Rep3   control    1    C3
## B_2_Rep3 B_2_Rep3   control    2    C3
## B_3_Rep3 B_3_Rep3   control    3    C3
## B_4_Rep3 B_4_Rep3   control    4    C3
## B_5_Rep3 B_5_Rep3   control    5    C3
## B_6_Rep3 B_6_Rep3   control    6    C3
## B_7_Rep3 B_7_Rep3   control    7    C3
## B_8_Rep3 B_8_Rep3   control    8    C3
```

```
objectImpulseDE2 <- runImpulseDE2(
  matCountData    = lsSimulatedData$matObservedCounts,
  dfAnnotation    = lsSimulatedData$dfAnnotation,
  boolCaseCtrl    = TRUE,
  vecConfounders  = c("Batch"),
  scaNProc        = 1 )
```

```
head(objectImpulseDE2$dfImpulseDE2Results)
```

```
##        Gene          p      padj loglik_full loglik_red df_full df_red
## gene1 gene1 0.50831664 0.9454785   -272.1727  -274.3182      17     12
## gene2 gene2 0.51596598 0.9454785   -285.6561  -287.7741      17     12
## gene3 gene3 0.50091542 0.9454785   -311.1775  -313.3498      17     12
## gene4 gene4 1.00000000 1.0000000   -336.5281  -335.9455      17     12
## gene5 gene5 0.03955016 0.1695007   -256.2735  -262.1101      17     12
## gene6 gene6 0.42403478 0.9454785   -328.9031  -331.3700      17     12
##            mean converge_combined converge_case converge_control allZero
## gene1  234.9687                 0             0                0   FALSE
## gene2  364.3831                 0             0                0   FALSE
## gene3  517.8059                 0             0                0   FALSE
## gene4 1139.5563                 0             0                0   FALSE
## gene5  193.6466                 0             0                0   FALSE
## gene6  656.0563                 0             0                0   FALSE
```

# 6 Transiently regulated genes

Here, we present the identification of transiently regulated genes.
Refer to “Batch effects” for details.
Setting boolIdentifyTransients = TRUE causes the wrapper runImpulseDE2 to also fit sigmoid models
and to perform the additional model selection yielding transiently and permanently regulated genes.
The results of this analysis are are also in the results table objectImpulseDE2$dfImpulseDE2Results.

```
library(ImpulseDE2)
lsSimulatedData <- simulateDataSetImpulseDE2(
  vecTimePointsA   = rep(seq(1,8),3),
  vecTimePointsB   = NULL,
  vecBatchesA      = c(rep("B1",8), rep("B2",8), rep("B3",8)),
  vecBatchesB      = NULL,
  scaNConst        = 0,
  scaNImp          = 100,
  scaNLin          = 0,
  scaNSig          = 0,
  scaMuBatchEffect = 1,
  scaSDBatchEffect = 0.2,
  dirOutSimulation = NULL)
objectImpulseDE2 <- runImpulseDE2(
  matCountData           = lsSimulatedData$matObservedCounts,
  dfAnnotation           = lsSimulatedData$dfAnnotation,
  boolCaseCtrl           = FALSE,
  vecConfounders         = c("Batch"),
  boolIdentifyTransients = TRUE,
  scaNProc               = 1 )
```

```
head(objectImpulseDE2$dfImpulseDE2Results)
```

```
##        Gene            p         padj loglik_full loglik_red df_full df_red
## gene1 gene1 6.166960e-03 1.258563e-02  -168.66269 -176.78739       9      4
## gene2 gene2 8.897499e-01 9.079081e-01   -69.01662  -69.86324       9      4
## gene3 gene3 2.508407e-04 5.972399e-04  -145.31655 -157.15324       9      4
## gene4 gene4 2.873420e-08 1.512326e-07  -156.42709 -178.19642       9      4
## gene5 gene5 4.263580e-05 1.121995e-04  -172.97566 -186.79986       9      4
## gene6 gene6 1.674230e-04 4.185574e-04  -136.72009 -149.01335       9      4
##             mean converge_impulse converge_const converge_sigmoid
## gene1 1049.17083                0              0                0
## gene2    7.39855                0              0                0
## gene3  427.71940                0              0                0
## gene4  670.21304                0              0                0
## gene5 1524.06243                0              0                0
## gene6  253.35891                0              0                0
##       impulseTOsigmoid_p impulseTOsigmoid_padj sigmoidTOconst_p
## gene1       0.2879049767           0.648034883     3.252020e-03
## gene2       0.8762002644           0.977325267     6.987695e-01
## gene3       0.6416499130           0.812215080     4.475120e-05
## gene4       0.0301252641           0.212668421     5.774191e-08
## gene5       0.1366720742           0.531200758     2.930061e-05
## gene6       0.0000287201           0.001436005     2.992884e-01
##       sigmoidTOconst_padj isTransient isMonotonous allZero
## gene1        6.919192e-03       FALSE        FALSE   FALSE
## gene2        7.764106e-01       FALSE        FALSE   FALSE
## gene3        1.243089e-04       FALSE         TRUE   FALSE
## gene4        2.624632e-07       FALSE         TRUE   FALSE
## gene5        8.371603e-05       FALSE         TRUE   FALSE
## gene6        4.215330e-01       FALSE        FALSE   FALSE
```

# 7 Plot global heat map of expression trajectories

Here, we present the visualization of global expression patterns via a heat map.
We base this analysis on a classification of differentially expressed genes by the transient regulation scheme.
Refer to “Transiently regulated genes” for details.

The function plotHeatmap takes an output object of the class ImpulseDE2Object.
If sigmoid model were fit and a the results table includes analysis results of transient regulation
(i.e. the output of runImpulseDE2 with boolIdentifyTransients = TRUE),
the heat map can be grouped by the results of the transient regulation analysis (boolIdentifyTransients = TRUE).
If transient regulation analysis was not performed, a simple heat map of the global expression profiles is created.
The condition to which sigmoids were fit and based on which
the transient analysis was performed has to be indicated (strCondition),
this is usually the case condition.
Finally, a false-discovery rate corrected p-value threshold for the model selection of the transient regulation analysis has to be set via scaQThres.

The output of plotHeatmap includes two objects of the class ComplexHeatmap which can be plotted with draw().

```
# Continuing script of "Transiently regulated genes"
library(ComplexHeatmap)
lsHeatmaps <- plotHeatmap(
  objectImpulseDE2       = objectImpulseDE2,
  strCondition           = "case",
  boolIdentifyTransients = TRUE,
  scaQThres              = 0.01)
draw(lsHeatmaps$complexHeatmapRaw) # Heatmap based on normalised counts
```

![](data:image/png;base64...)

# 8 Session information

```
sessionInfo()
```