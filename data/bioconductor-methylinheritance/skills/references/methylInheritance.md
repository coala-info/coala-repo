# Inferring inheritance of differentially methylated changes across multiple generations

Astrid Deschênes, Pascal Belleau and Arnaud Droit

#### 30 October 2025

# Contents

* [1 Licensing](#licensing)
* [2 Citing](#citing)
* [3 Introduction](#introduction)
* [4 Loading methylInheritance package](#loading-methylinheritance-package)
* [5 Description of the permutation analysis](#description-of-the-permutation-analysis)
* [6 Case study](#case-study)
  + [6.1 The multigenerational dataset](#the-multigenerational-dataset)
  + [6.2 Observation analysis](#observation-analysis)
  + [6.3 Permutation analysis](#permutation-analysis)
  + [6.4 Merging observation and permutation analysis](#merging-observation-and-permutation-analysis)
  + [6.5 Extract a specific analysis](#extract-a-specific-analysis)
  + [6.6 Significant level and visual representation](#significant-level-and-visual-representation)
* [7 Possibility to restart a permutation analysis](#possibility-to-restart-a-permutation-analysis)
* [8 Format multigenerational dataset into an input](#format-multigenerational-dataset-into-an-input)
* [9 Acknowledgment](#acknowledgment)
* [10 Session info](#session-info)
* [References](#references)

**Package**: *methylInheritance*
**Authors**: Astrid Deschênes [cre, aut] (ORCID:
<https://orcid.org/0000-0001-7846-6749>),
Pascal Belleau [aut] (ORCID: <https://orcid.org/0000-0002-0802-1071>),
Arnaud Droit [aut]
**Version**: 1.34.0
**Compiled date**: 2025-10-30
**License**: Artistic-2.0

# 1 Licensing

The *[methylInheritance](https://bioconductor.org/packages/3.22/methylInheritance)* package and the underlying
*[methylInheritance](https://bioconductor.org/packages/3.22/methylInheritance)* code
are distributed under the Artistic license 2.0. You are free to use and
redistribute this software.

# 2 Citing

If you use this package for a publication, we would ask you to cite the
following:

> Pascal Belleau, Astrid Deschênes, Marie-Pier Scott-Boyer, Romain Lambrot, Mathieu Dalvai, Sarah Kimmins, Janice Bailey, Arnaud Droit; Inferring and modeling inheritance of differentially methylated changes across multiple generations, Nucleic Acids Research, Volume 46, Issue 14, 21 August 2018, Pages e85. DOI: <https://doi.org/10.1093/nar/gky362>

# 3 Introduction

DNA methylation plays an important role in the biology of tissue development
and diseases. High-throughput sequencing techniques enable genome-wide
detection of differentially methylated elements (DME), commonly sites (DMS) or
regions (DMR). The analysis of treatment effects on DNA methylation, from
one generation to the next (inter-generational) and across generations that
were not exposed to the initial environment (trans-generational) represent
complex designs. Due to software design, the detection of DME is usually
made on each generation separately. However, the common DME between
generations due to randomness is not negligible when the number of DME
detected in each generation is high. To judge the effect on DME that is
inherited from a treatment in previous generation, the observed number of
conserved DME must be compared to the randomly expected number.

We present a permutation analysis, based on Monte Carlo sampling, aim to infer
a relation between the number of conserved DME from one generation to the next
to the inheritance effect of treatment and to dismiss stochastic effect. It
is used as a robust alternative to inference based on parametric assumptions.

The *[methylInheritance](https://bioconductor.org/packages/3.22/methylInheritance)* package can perform a permutation
analysis on both differentially methylated sites (DMS) and differentially
methylated tiles (DMT) using the *[methylKit](https://bioconductor.org/packages/3.22/methylKit)* package.

# 4 Loading methylInheritance package

As with any R package, the *[methylInheritance](https://bioconductor.org/packages/3.22/methylInheritance)* package should
first be loaded with the following command:

```
library(methylInheritance)
```

# 5 Description of the permutation analysis

The permutation analysis is a statistical significance test in which
the distribution of the test statistic under the null hypothesis is obtained
by calculating the values of the test statistic under rearrangement of
the labels on the observed data points. The rearrangement of the labels is
done through repeated random sampling (Legendre and Legendre [1998](#ref-Legendre1998), 142–57).

**Null Hypothesis**: The number of conserved DME correspond to a number that
can be obtained through a randomness analysis.

**Alternative Hypothesis**: The number of conserved DME do not correspond to a
number that can be obtained through a randomness analysis.

A typical **methylInheritance** analysis consists of the following steps:

1. Process to a differentially methylation analysis on each generation
   separately using real dataset with the *[methylKit](https://bioconductor.org/packages/3.22/methylKit)* package.
2. Calculate the number of conserved differentially methylated elements
   between two consecutive generations (F1 and F2, F2 and F3, etc..). The number
   of conserved differentially methylated elements is also calculated for three
   or more consecutive generations, always starting with the first generation
   (F1 and F2 and F3, F1 and F2 and F3 and F4, etc..).
   Those results are considered the reference values.
3. Fix a threshold (conventionally 0.05) that is used as a cutoff between the
   null and alternative hypothesis.
4. Process to a differential methylation analysis on each shuffled dataset.
   Each generation is analysed separately using the *[methylKit](https://bioconductor.org/packages/3.22/methylKit)*
   package.
5. Calculate the significant level for each consecutive subset of generations.
   The significant level is defined as the percentage of results equal or higher
   than the reference values. The reference values are added to the analysis so
   that it becomes impossible for the test to conclude that no value is
   as extreme as, or more extreme than the reference values.

All those steps have been encoded in the
**methylInheritance** package.

# 6 Case study

## 6.1 The multigenerational dataset

A dataset containing methylation data (6 cases and 6 controls) over three
generations has been generated using the
*methInheritSim* package.

```
## Load dataset containing information over three generations
data(demoForTransgenerationalAnalysis)

## The length of the dataset corresponds to the number of generation
## The generations are stored in order (first entry = first generation,
## second entry = second generation, etc..)
length(demoForTransgenerationalAnalysis)
## [1] 3

## All samples related to one generation are contained in a methylRawList
## object.
## The methylRawList object contains two Slots:
## 1- treatment: a numeric vector denoting controls and cases.
## 2- .Data: a list of methylRaw objects. Each object stores the raw
##           mehylation data of one sample.

## A section of the methylRaw object containing the information of the
## first sample from the second generation
head(demoForTransgenerationalAnalysis[[2]][[1]])
##   chr start  end strand coverage numCs numTs
## 1   S  1000 1000      +       88    87     1
## 2   S  1038 1038      +       77    76     1
## 3   S  1061 1061      +       84    84     0
## 4   S  1098 1098      +      100    46    54
## 5   S  1758 1758      +       93    93     0
## 6   S  1801 1801      +       77    76     1

## The treatment vector for each generation
## The number of treatments and controls is the same in each generation
## However, it could also be different.
## Beware that getTreatment() is a function from the methylKit package.
getTreatment(demoForTransgenerationalAnalysis[[1]])
##  [1] 0 0 0 0 0 0 1 1 1 1 1 1
getTreatment(demoForTransgenerationalAnalysis[[2]])
##  [1] 0 0 0 0 0 0 1 1 1 1 1 1
getTreatment(demoForTransgenerationalAnalysis[[3]])
##  [1] 0 0 0 0 0 0 1 1 1 1 1 1
```

## 6.2 Observation analysis

The observation analysis can be run on all generations using the
*runObservation()* function.

The observation results are stored in a RDS file. The *outputDir* parameter
must be given a directory path.

```
## The observation analysis is only done on differentially methylated sites
runObservation(methylKitData = demoForTransgenerationalAnalysis,
                        type = "sites",     # Only sites
                        outputDir = "demo_01",   # RDS result files are saved
                                                 # in the directory
                        nbrCores = 1,       # Number of cores used
                        minReads = 10,      # Minimum read coverage
                        minMethDiff = 10,   # Minimum difference in methylation
                                            # to be considered DMS
                        qvalue = 0.01,
                        vSeed = 2101)       # Ensure reproducible results
## [1] 0

## The results can be retrived using loadAllRDSResults() method
observedResults <- loadAllRDSResults(
                    analysisResultsDir = "demo_01/",  # Directory containing
                                                      # the observation
                                                      # results
                    permutationResultsDir = NULL,
                    doingSites = TRUE,
                    doingTiles = FALSE)

observedResults
## Permutation Analysis
##
## Number of Generations:  3
## Number of Permutations:  0
##
## Observation Results:
##        SOURCE ELEMENT ANALYSIS   TYPE RESULT
## 1 OBSERVATION   SITES       i2 HYPER1     16
## 2 OBSERVATION   SITES       i2 HYPER2     16
## 3 OBSERVATION   SITES       i2  HYPO1      2
## 4 OBSERVATION   SITES       i2  HYPO2      4
## 5 OBSERVATION   SITES     iAll  HYPER     14
## 6 OBSERVATION   SITES     iAll   HYPO      2
```

## 6.3 Permutation analysis

The permutation analysis can be run on all generations using the
*runPermutation()* function.

The observation and the permutation analysis can be run together by
setting the *runObservationAnalysis = TRUE* in the
*runPermutation()* function.

All permutations are saved in RDS files. The *outputDir* parameter
must be given a directory path.

At last, the name of the RDS file that contains the methylKit object can also
be used as an argument to the *runPermutation()* function.

```
## The permutation analysis is only done on differentially methylated sites
runPermutation(methylKitData = demoForTransgenerationalAnalysis, # multi-generational dataset
                        type = "sites",     # Only sites
                        outputDir = "demo_02",   # RDS permutation files are
                                                 # saved in the directory
                        runObservationAnalysis = FALSE,
                        nbrCores = 1,           # Number of cores used
                        nbrPermutations = 2,    # Should be much higher for a
                                                # real analysis
                        minReads = 10,          # Minimum read coverage
                        minMethDiff = 10,   # Minimum difference in methylation
                                            # to be considered DMS
                        qvalue = 0.01,
                        vSeed = 2101)         # Ensure reproducible results
## [1] 0

## The results can be retrived using loadAllRDSResults() method
permutationResults <- loadAllRDSResults(
                    analysisResultsDir = NULL,
                    permutationResultsDir = "demo_02",   # Directory containing
                                                    # the permutation
                                                    # results
                    doingSites = TRUE,
                    doingTiles = FALSE)

permutationResults
## Permutation Analysis
##
## Number of Generations:  0
## Number of Permutations:  2
##
## Observation Results:
##  No observation result.
```

## 6.4 Merging observation and permutation analysis

The observation and permutation results can be merged using the
*mergePermutationAndObservation()* function.

```
## Merge observation and permutation results
allResults <- mergePermutationAndObservation(permutationResults =
                                                    permutationResults,
                                    observationResults = observedResults)
allResults
## Permutation Analysis
##
## Number of Generations:  3
## Number of Permutations:  2
##
## Observation Results:
##        SOURCE ELEMENT ANALYSIS   TYPE RESULT
## 1 OBSERVATION   SITES       i2 HYPER1     16
## 2 OBSERVATION   SITES       i2 HYPER2     16
## 3 OBSERVATION   SITES       i2  HYPO1      2
## 4 OBSERVATION   SITES       i2  HYPO2      4
## 5 OBSERVATION   SITES     iAll  HYPER     14
## 6 OBSERVATION   SITES     iAll   HYPO      2
```

When observation and permutation analysis have been run together using the
*runPermutation()* function, this step can be skipped.

## 6.5 Extract a specific analysis

The *runPermutation()* and *runObservation()* functions
calculate the number of conserved differentially methylated elements
between two consecutive generations (F1 and F2, F2 and F3, etc..). The
number of conserved differentially methylated elements is also
calculated for three or more consecutive generations, always starting with the
first generation (F1 and F2 and F3, F1 and F2 and F3 and F4, etc..).

A specific analysis can be extracted from the results using
*extractInfo()* function.

The *type* parameter can be set to extract one of those elements:

* *“sites”*: differentially methylated sites
* *“tiles”*: differentially methylated tiles

The *inter* parameter can be set to extract one of those analysis type:

* *“i2”*: the analysis between two consecutive generations (F1 and F2, F2 and
  F3, etc..)
* *“iAll”*: the analysis between three or more generations (F1 and F2 and F3,
  F1 and F2 and F3 and F4, etc..)

```
## Conserved differentially methylated sites between F1 and F2 generations
F1_and_F2_results <- extractInfo(allResults = allResults, type = "sites",
                                    inter = "i2", position = 1)

head(F1_and_F2_results)
##    TYPE RESULT      SOURCE
## 1  HYPO      2 OBSERVATION
## 2 HYPER     16 OBSERVATION
## 3  HYPO     13 PERMUTATION
## 4 HYPER      2 PERMUTATION
## 5  HYPO      0 PERMUTATION
## 6 HYPER      1 PERMUTATION
```

## 6.6 Significant level and visual representation

The permutation analysis has been run on the *demoForTransgenerationalAnalysis*
dataset with 1000 permutations (*nbrPermutation = 1000*). The results of
those permutations will be used to generate the significant levels and
the visual representations.

```
## Differentially conserved sites between F1 and F2 generations
F1_and_F2 <- extractInfo(allResults = demoResults, type = "sites",
                            inter = "i2", position = 1)
## Differentially conserved sites between F2 and F3 generations
F2_and_F3 <- extractInfo(allResults = demoResults, type = "sites",
                            inter = "i2", position = 2)
## Differentially conserved sites between F1 and F2 and F3 generations
F2_and_F3 <- extractInfo(allResults = demoResults, type = "sites",
                            inter = "iAll", position = 1)
```

```
## Show graph and significant level for differentially conserved sites
## between F1 and F2
output <- plotGraph(F1_and_F2)
```

![](data:image/png;base64...)

# 7 Possibility to restart a permutation analysis

When a large number of permutations is processed, the time needed to
process them all may be long (especially when the number of available CPU is
limited). Furthermore, some permutations can fail due to parallelization
problems.

The **methylInheritance** package offers the possibility to restart
an analysis and run only missing permutation results. To take advantage of this
option, the *outputDir* parameter must not be *NULL* so that permutation
results are saved in RDS files. When the *restartCalculation* is set to *TRUE*,
the method will load the permutation results present in RDS files (when
available) and only rerun permutations that don’t have an associated RDS file.

```
## The permutation analysis is only done on differentially methylated tiles
## The "output" directory must be specified
## The "vSeed" must be specified to ensure reproducible results
## The "restartCalculation" is not important the first time the analysis is run
permutationResult <- runPermutation(
                        methylKitData = demoForTransgenerationalAnalysis, # multi-generational dataset
                        type = "tiles",     # Only tiles
                        outputDir = "test_restart",   # RDS files are created
                        runObservationAnalysis = TRUE,
                        nbrCores = 1,           # Number of cores used
                        nbrPermutations = 2,    # Should be much higher for a
                                                # real analysis
                        vSeed = 212201,     # Ensure reproducible results
                        restartCalculation = FALSE)

## Assume that the process was stopped before it has done all the permutations

## The process can be restarted
## All parameters must be identical to the first analysis except "restartCalculation"
## The "restartCalculation" must be set to TRUE
permutationResult <- runPermutation(
                        methylKitData = demoForTransgenerationalAnalysis, # multi-generational dataset
                        type = "tiles",     # Only tiles
                        outputDir = "test_restart",   # RDS files are created
                        runObservationAnalysis = TRUE,
                        nbrCores = 1,           # Number of cores used
                        nbrPermutations = 2,    # Should be much higher for a
                                                # real analysis
                        vSeed = 212201,     # Ensure reproducible results
                        restartCalculation = TRUE)
```

# 8 Format multigenerational dataset into an input

The permutation analysis needs a *list* of *methylRawList* objects
as input. A *methylRawList* is a *list* of *methylRaw* objects.
The *methylRawList* and *methylRaw* objects are defined in the
*[methylKit](https://bioconductor.org/packages/3.22/methylKit)* package.

To create a *methylRawList*, all samples (cases and controls) from the same
generation must be first separately transformed into a *methylRaw* object.
The S4 *methylRaw* class extends *data.frame* class and has been created to
store raw methylation data. The raw methylation is essentially percent
methylation values and read coverage values per base or region.

Excluding the *data.frame* section, the slots present in the *methylRaw*
class are:

* sample.id: a string, the sample identification
* assembly: a string, the genomic assembly
* context: a string, the methylation context, as an exemple, CpG, CpH, etc…
* resolution: a string, the resolution of methylation information,
  mainly ‘base’ or ‘region’

```
## The list of methylRaw objects for all controls and cases related to F1
f1_list <- list()
f1_list[[1]] <- new("methylRaw",
                    data.frame(chr = c("chr21", "chr21"),
                    start = c(9764513, 9764542),
                    end = c(9764513, 9764542), strand = c("+", "-"),
                    coverage = c(100, 15), numCs = c(88, 2),
                    numTs = c(100, 15) - c(88, 2)),
                    sample.id = "F1_control_01", assembly = "hg19",
                    context = "CpG", resolution = 'base')
f1_list[[2]] <- new("methylRaw",
                    data.frame(chr = c("chr21", "chr21"),
                    start = c(9764513, 9764522),
                    end = c(9764513, 9764522), strand = c("-", "-"),
                    coverage = c(38, 21), numCs = c(12, 2),
                    numTs = c(38, 21) - c(12, 2)),
                    sample.id = "F1_case_02", assembly = "hg19",
                    context = "CpG", resolution = 'base')

## The list of methylRaw objects for all controls and cases related to F2
f2_list <- list()
f2_list[[1]] <- new("methylRaw",
                    data.frame(chr = c("chr21", "chr21"),
                    start = c(9764514, 9764522),
                    end = c(9764514, 9764522), strand = c("+", "+"),
                    coverage = c(40, 30), numCs = c(0, 2),
                    numTs = c(40, 30) - c(0, 2)),
                    sample.id = "F2_control_01", assembly = "hg19",
                    context = "CpG", resolution = 'base')
f2_list[[2]] <- new("methylRaw",
                    data.frame(chr = c("chr21", "chr21"),
                    start = c(9764513, 9764533),
                    end = c(9764513, 9764533), strand = c("+", "-"),
                    coverage = c(33, 23), numCs = c(12, 1),
                    numTs = c(33, 23) - c(12, 1)),
                    sample.id = "F2_case_01", assembly = "hg19",
                    context = "CpG", resolution = 'base')

## The list to use as input for methylInheritance
final_list <- list()

## The methylRawList for F1 - the first generation is on the first position
final_list[[1]] <- new("methylRawList", f1_list, treatment = c(0,1))
## The methylRawList for F2 - the second generation is on the second position
final_list[[2]] <- new("methylRawList", f2_list, treatment = c(0,1))

## A list of methylRawList ready for methylInheritance
final_list
## [[1]]
## methylRawList object with 2 methylRaw objects
##
## methylRaw object with 2 rows
## --------------
##     chr   start     end strand coverage numCs numTs
## 1 chr21 9764513 9764513      +      100    88    12
## 2 chr21 9764542 9764542      -       15     2    13
## --------------
## sample.id: F1_control_01
## assembly: hg19
## context: CpG
## resolution: base
##
## methylRaw object with 2 rows
## --------------
##     chr   start     end strand coverage numCs numTs
## 1 chr21 9764513 9764513      -       38    12    26
## 2 chr21 9764522 9764522      -       21     2    19
## --------------
## sample.id: F1_case_02
## assembly: hg19
## context: CpG
## resolution: base
##
## treatment: 0 1
##
## [[2]]
## methylRawList object with 2 methylRaw objects
##
## methylRaw object with 2 rows
## --------------
##     chr   start     end strand coverage numCs numTs
## 1 chr21 9764514 9764514      +       40     0    40
## 2 chr21 9764522 9764522      +       30     2    28
## --------------
## sample.id: F2_control_01
## assembly: hg19
## context: CpG
## resolution: base
##
## methylRaw object with 2 rows
## --------------
##     chr   start     end strand coverage numCs numTs
## 1 chr21 9764513 9764513      +       33    12    21
## 2 chr21 9764533 9764533      -       23     1    22
## --------------
## sample.id: F2_case_01
## assembly: hg19
## context: CpG
## resolution: base
##
## treatment: 0 1
```

Another approach is to transform the files that contain the raw methylation
information into a format that can be read by the *[methylKit](https://bioconductor.org/packages/3.22/methylKit)*
*methRead* function. The *methRead* function implements methods that enable
the creation of *methylRawList* objects.

Here is one valid file format among many (tab separated):

```
chrBase     chr     base    strand  coverage    freqC   freqT
1.176367    1       176367  R       29          100.00  0.00
1.176392    1       176392  R       58          100.00  0.00
1.176422    1       176422  R       29          3.45    96.55
1.176552    1       176552  R       58          96.55   3.45
```

```
library(methylKit)

## The methylRawList for F1
generation_01 <- methRead(location = list("demo/F1_control_01.txt", "demo/F1_case_01.txt"),
                    sample.id = list("F1_control_01", "F1_case_01"),
                    assembly = "hg19", treatment = c(0, 1), context = "CpG")

## The methylRawList for F2
generation_02 <- methRead(location = list("demo/F2_control_01.txt", "demo/F2_case_01.txt"),
                    sample.id = list("F2_control_01", "F2_case_01"),
                    assembly = "hg19", treatment = c(0, 1), context = "CpG")

## A list of methylRawList ready for methylInheritance
final_list <- list(generation_01, generation_02)
final_list
## [[1]]
## methylRawList object with 2 methylRaw objects
##
## methylRaw object with 2 rows
## --------------
##   chr   start     end strand coverage numCs numTs
## 1  21 9764513 9764513      +      100    88    12
## 2  21 9764542 9764542      -       15     2    13
## --------------
## sample.id: F1_control_01
## assembly: hg19
## context: CpG
## resolution: base
##
## methylRaw object with 2 rows
## --------------
##   chr   start     end strand coverage numCs numTs
## 1  21 9764513 9764513      -       38    12    26
## 2  21 9764522 9764522      -       21     2    19
## --------------
## sample.id: F1_case_01
## assembly: hg19
## context: CpG
## resolution: base
##
## treatment: 0 1
##
## [[2]]
## methylRawList object with 2 methylRaw objects
##
## methylRaw object with 2 rows
## --------------
##   chr   start     end strand coverage numCs numTs
## 1  21 9764514 9764514      +       40     0    40
## 2  21 9764522 9764522      +       30     2    28
## --------------
## sample.id: F2_control_01
## assembly: hg19
## context: CpG
## resolution: base
##
## methylRaw object with 2 rows
## --------------
##   chr   start     end strand coverage numCs numTs
## 1  21 9764513 9764513      +       33    12    21
## 2  21 9764533 9764533      -       23     1    22
## --------------
## sample.id: F2_case_01
## assembly: hg19
## context: CpG
## resolution: base
##
## treatment: 0 1
```

More information about methRead function can be found in the documentation of
the *[methylKit](https://bioconductor.org/packages/3.22/methylKit)* package.

# 9 Acknowledgment

We thank Marie-Pier Scott-Boyer for her advice on the vignette content.

# 10 Session info

Here is the output of sessionInfo() on the system on which this document
was compiled:

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## Random number generation:
##  RNG:     L'Ecuyer-CMRG
##  Normal:  Inversion
##  Sample:  Rejection
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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] methylInheritance_1.34.0 methylKit_1.36.0         GenomicRanges_1.62.0
##  [4] Seqinfo_1.0.0            IRanges_2.44.0           S4Vectors_0.48.0
##  [7] BiocGenerics_0.56.0      generics_0.1.4           knitr_1.50
## [10] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] bitops_1.0-9                gridExtra_2.3
##  [3] rlang_1.1.6                 magrittr_2.0.4
##  [5] matrixStats_1.5.0           rebus.base_0.0-3
##  [7] compiler_4.5.1              mgcv_1.9-3
##  [9] vctrs_0.6.5                 reshape2_1.4.4
## [11] stringr_1.5.2               pkgconfig_2.0.3
## [13] crayon_1.5.3                fastmap_1.2.0
## [15] magick_2.9.0                XVector_0.50.0
## [17] labeling_0.4.3              Rsamtools_2.26.0
## [19] rebus_0.1-3                 rmarkdown_2.30
## [21] tinytex_0.57                xfun_0.53
## [23] cachem_1.1.0                cigarillo_1.0.0
## [25] jsonlite_2.0.0              DelayedArray_0.36.0
## [27] BiocParallel_1.44.0         parallel_4.5.1
## [29] R6_2.6.1                    bslib_0.9.0
## [31] stringi_1.8.7               RColorBrewer_1.1-3
## [33] limma_3.66.0                rtracklayer_1.70.0
## [35] jquerylib_0.1.4             numDeriv_2016.8-1.1
## [37] Rcpp_1.1.0                  bookdown_0.45
## [39] SummarizedExperiment_1.40.0 R.utils_2.13.0
## [41] Matrix_1.7-4                splines_4.5.1
## [43] tidyselect_1.2.1            qvalue_2.42.0
## [45] dichromat_2.0-0.1           abind_1.4-8
## [47] yaml_2.3.10                 codetools_0.2-20
## [49] curl_7.0.0                  lattice_0.22-7
## [51] tibble_3.3.0                rebus.datetimes_0.0-2
## [53] plyr_1.8.9                  Biobase_2.70.0
## [55] withr_3.0.2                 S7_0.2.0
## [57] coda_0.19-4.1               evaluate_1.0.5
## [59] rebus.numbers_0.0-1.1       mclust_6.1.1
## [61] Biostrings_2.78.0           pillar_1.11.1
## [63] BiocManager_1.30.26         MatrixGenerics_1.22.0
## [65] RCurl_1.98-1.17             emdbook_1.3.14
## [67] ggplot2_4.0.0               scales_1.4.0
## [69] gtools_3.9.5                glue_1.8.0
## [71] tools_4.5.1                 BiocIO_1.20.0
## [73] data.table_1.17.8           GenomicAlignments_1.46.0
## [75] mvtnorm_1.3-3               XML_3.99-0.19
## [77] grid_4.5.1                  bbmle_1.0.25.1
## [79] bdsmatrix_1.3-7             nlme_3.1-168
## [81] rebus.unicode_0.0-2.1       restfulr_0.0.16
## [83] cli_3.6.5                   fastseg_1.56.0
## [85] S4Arrays_1.10.0             dplyr_1.1.4
## [87] gtable_0.3.6                R.methodsS3_1.8.2
## [89] sass_0.4.10                 digest_0.6.37
## [91] SparseArray_1.10.0          rjson_0.2.23
## [93] farver_2.1.2                htmltools_0.5.8.1
## [95] R.oo_1.27.1                 lifecycle_1.0.4
## [97] httr_1.4.7                  statmod_1.5.1
## [99] MASS_7.3-65
```

# References

Legendre, Pierre, and Louis Legendre. 1998. *Numerical ecology*. Amsterdam: Elsevier Science BV.