# Introduction to BASiCS

Catalina Vallejos\* and Nils Eling\*\*

\*cnvallej@uc.cl
\*\*eling@ebi.ac.uk

#### 29 October 2025

#### Package

BASiCS 2.22.0

# Contents

* [1 Introduction](#introduction)
* [2 Quick start](#quick-start)
* [3 Complete workflow](#complete-workflow)
  + [3.1 The input dataset](#the-input-dataset)
  + [3.2 Analysis for a single group of cells](#analysis-for-a-single-group-of-cells)
  + [3.3 Analysis for two groups of cells](#analysis-for-two-groups-of-cells)
* [4 Alternative implementation modes](#alternative-implementation-modes)
  + [4.1 If `WithSpikes = FALSE`](#if-withspikes-false)
  + [4.2 If `Regression = TRUE`](#if-regression-true)
* [5 Additional details](#additional-details)
  + [5.1 Storing and loading MCMC chains](#storing-and-loading-mcmc-chains)
  + [5.2 Convergence assessment](#convergence-assessment)
  + [5.3 Summarising the posterior distribution](#summarising-the-posterior-distribution)
  + [5.4 Normalisation and removal of technical variation](#normalisation-and-removal-of-technical-variation)
* [6 Methodology](#methodology)
* [7 Acknowledgements](#acknowledgements)
* [8 BASiCS *hall of fame*](#basics-hall-of-fame)
* [9 Session information](#session-information)
* [References](#references)

# 1 Introduction

Single-cell mRNA sequencing can uncover novel cell-to-cell heterogeneity in gene
expression levels within seemingly homogeneous populations of cells. However,
these experiments are prone to high levels of technical noise, creating new
challenges for identifying genes that show genuine heterogeneous expression
within the group of cells under study.

![](data:image/png;base64...)

BASiCS (**B**ayesian **A**nalysis of **Si**ngle-**C**ell **S**equencing data)
is an integrated Bayesian hierarchical model that propagates statistical
uncertainty by simultaneously performing data normalisation (global scaling),
technical noise quantification and two types of **supervised** downstream
analyses:

1. **For a single group of cells** (Vallejos, Marioni, and Richardson [2015](#ref-vallejos2015basics)): BASiCS provides a
   criterion to identify highly (and lowly) variable genes within the group.
2. **For two (or more) groups of cells**: BASiCS allows the identification
   of changes in gene expression between the groups. As in traditional
   differential expression tools, BASiCS can uncover changes in mean expression
   between the groups. Besides this, BASiCS can also uncover changes in gene
   expression variability in terms of:

1. **Over-dispersion** (Vallejos, Richardson, and Marioni [2016](#ref-vallejos2016beyond)) — a measure for the excess of
   cell-to-cell variability that is observed with respect to Poisson sampling,
   after accounting for technical noise. This feature has led, for example, to
   novel insights in the context of immune cells across aging
   (Martinez-Jimenez et al. [2017](#ref-martinez2017aging)). However, due to the strong mean/over-dispersion
   confounding that is typically observed for scRNA-seq datasets, the assessment
   of changes in over-dispersion is restricted to genes for which mean expression
   does not change between the groups.
2. **Residual over-dispersion** (Eling et al. [2018](#ref-eling2018correcting)) — a residual measure of
   variability given by departures with respect to a global mean/over-dispersion
   trend. Positive residual over-dispersion indicates that a gene exhibits more
   variation than expected relative to genes with similar expression levels;
   negative residual over-dispersion suggests less variation than expected.
   To use this feature, please set `Regression = TRUE` as a function parameter
   in `BASiCS_MCMC`.

In all cases, a probabilistic output is provided and a decision rule is
calibrated using the expected false discovery rate (EFDR) (Newton et al. [2004](#ref-newton2004detecting)).

A brief description for the statistical model implemented in BASiCS is
provided in Section [6](#methodology) of this document. The original
implementation of BASiCS (Vallejos, Marioni, and Richardson [2015](#ref-vallejos2015basics)) requires the use of **spike-in**
molecules — that are artificially introduced to each cell’s lysate
— to perform these analyses. More recently, Eling et al. ([2018](#ref-eling2018correcting)) extendeded
BASiCS to also address datasets for which spikes-ins are not available
(see Section [4](#alternative-implementation-modes)). To use this feature,
please set `WithSpikes = FALSE` as a function parameter in `BASiCS_MCMC`.

**Important**: BASiCS has been designed in the context of supervised experiments
where the groups of cells (e.g. experimental conditions, cell types) under study
are known a priori (e.g. case-control studies). Therefore, we DO NOT advise the
use of BASiCS in unsupervised settings where the aim is to uncover
sub-populations of cells through clustering.

---

# 2 Quick start

Parameter estimation is performed using the `BASiCS_MCMC` function. Downstream
analyses implemented in BASiCS rely on appropriate post-processing of the
output returned by `BASiCS_MCMC`. Essential parameters for running
`BASiCS_MCMC` are:

* `Data`: a `SingleCellExperiment` object created as in Section
  [3.1](#the-input-dataset)
* `N`: total number of iterations
* `Thin`: length of the thining period (i.e. only every `Thin`
  iterations will be stored in the output of the `BASiCS_MCMC`)
* `Burn`: length of burn-in period (i.e. the initial `Burn`
  iterations that will be discarded from the output of the `BASiCS_MCMC`)
* `Regression`: if this parameter is set equal to `TRUE`, the regression
  BASiCS model will be used (Eling et al. [2018](#ref-eling2018correcting)). The latter infers a global
  regression trend between mean expression and over-dispersion parameters. This
  trend is subsequently used to derive a *residual over-dispersion* measure that
  is defined as departures with respect to this trend. **This is now the
  recommended default setting for BASiCS**\*.

If the optional parameter `PrintProgress` is set to `TRUE`, the R
console will display the progress of the MCMC algorithm.
For other optional parameters refer to `help(BASiCS_MCMC)`.

Here, we illustrate the usage of `BASiCS_MCMC` using a built-in
synthetic dataset.
As the outcome of this function is stochastic, users should expect small
variations across different runs.
To ensure reproducible results, users may consider using a fixed seed (as
illustrated in the following code).

**NOTE: WE USE A SMALL NUMBER OF ITERATIONS FOR ILLUSTRATION PURPOSES ONLY.
LARGER NUMBER OF ITERATIONS ARE USUALLY REQUIRED TO ACHIEVE CONVERGENCE. OUR
RECOMMENDED SETTING IS `N=20000`, `Thin=20` and `Burn=10000`.**

```
set.seed(1)
Data <- makeExampleBASiCS_Data()
Chain <- BASiCS_MCMC(
  Data = Data,
  N = 1000, Thin = 10, Burn = 500,
  PrintProgress = FALSE, Regression = TRUE
)
```

```
## -----------------------------------------------------
## MCMC sampler has been started: 1000 iterations to go.
## -----------------------------------------------------
## -----------------------------------------------------
## End of Burn-in period.
## -----------------------------------------------------
##
## -----------------------------------------------------
## -----------------------------------------------------
## All 1000 MCMC iterations have been completed.
## -----------------------------------------------------
## -----------------------------------------------------
##
## -----------------------------------------------------
## Please see below a summary of the overall acceptance rates.
## -----------------------------------------------------
##
## Minimum acceptance rate among mu[i]'s: 0.46
## Average acceptance rate among mu[i]'s: 0.61496
## Maximum acceptance rate among mu[i]'s: 0.816
##
##
## Minimum acceptance rate among delta[i]'s: 0.43
## Average acceptance rate among delta[i]'s: 0.52244
## Maximum acceptance rate among delta[i]'s: 0.608
##
##
## Acceptance rate for phi (joint): 0.882
##
##
## Minimum acceptance rate among nu[j]'s: 0.424
## Average acceptance rate among nu[j]'s: 0.541133
## Maximum acceptance rate among nu[j]'s: 0.726
##
##
## Minimum acceptance rate among theta[k]'s: 0.736
## Average acceptance rate among theta[k]'s: 0.736
## Maximum acceptance rate among theta[k]'s: 0.736
##
## -----------------------------------------------------
##
```

As a default, the code above runs the original implementation mode of BASiCS
(spikes without regression; see Section [4](#alternative-implementation-modes)).
To use the regression BASiCS model (Eling et al. [2018](#ref-eling2018correcting)), please set
`Regression = TRUE`. To use the no-spikes implementation of BASiCS, please add
`WithSpikes = FALSE` as an additional parameter.

The `Data` and `Chain` (a `BASiCS_Chain` object) objects created by the code
above can be use for subsequent downstream analyses. See Section
[3.2](#analysis-for-a-single-group-of-cells) for highly/lowly variable gene
detection (single group of cells, see also functions `BASiCS_DetectHVG` and
`BASiCS_DetectLVG`) and Section [3.3](#analysis-for-two-groups-of-cells) for
differential expression analyses (two groups of cells, see also function
`BASiCS_TestDE`).

**Important remarks:**

* Please ensure the acceptance rates displayed in the console output of
  `BASiCS_MCMC` are around 0.44. If they are too far from this value, you
  should increase `N` and `Burn`.
* It is **essential** to assess the convergence of the MCMC algorithm
  **before** performing downstream analyses. For guidance regarding this step,
  refer to the ‘Convergence assessment’ section of this vignette

Typically, setting `N=20000`, `Thin=20` and `Burn=10000` leads to
stable results.

# 3 Complete workflow

## 3.1 The input dataset

The input dataset for BASiCS must be stored as an `SingleCellExperiment`
object (see *[SingleCellExperiment](https://bioconductor.org/packages/3.22/SingleCellExperiment)* package).

The generation of the input `SingleCellExperiment` object requires a matrix of
raw counts `Counts` (columns: cells, rows: genes) after quality control
(e.g. removing low quality cells) and filtering of lowly expressed genes. If
spike-in molecules are contained in `Counts`, a logical vector `Tech` is
required to indicate which rows contain technical spike-in molecules and a
`data.frame` object `SpikeInfo` containing the names of the spike-in molecules
in the first column and the absolute number of molecules per well in the second
column. More details are provided in section [3.1](#the-input-dataset). If
spike-ins are not available, a vector `BatchInfo` containing batch information
is required.

### 3.1.1 With spike-in genes

The `newBASiCS_Data` function can be used to create the input data object based
on the following information:

* `Counts`: a matrix of raw expression counts with dimensions \(q\) times \(n\).
  Within this matrix, \(q\_0\) rows must correspond to biological genes and \(q-q\_0\)
  rows must correspond to technical spike-in genes. Gene names must be stored as
  `rownames(Counts)`.
* `Tech`: a logical vector (`TRUE`/`FALSE`) with \(q\) elements. If
  `Tech[i] = FALSE` the gene `i` is biological; otherwise the gene is spike-in.
  This vector must be specified in the same order of genes as in the
  `Counts` matrix.
* `SpikeInfo` (optional): a `data.frame` with \(q-q\_0\) rows. First column must
  contain the names associated to the spike-in genes (as in `rownames(Counts)`).
  Second column must contain the input number of molecules for the spike-in genes
  (amount per cell). If a value for this parameter is not provided when calling
  `newBASiCS_Data`, `SpikeInfo` is set as `NULL` as a default value. In those
  cases, the `BatchInfo` argument has to be provided to allow using the no-spikes
  implementation of BASiCS.
* `BatchInfo` (optional): vector of length \(n\) to indicate batch structure
  (whenever cells have been processed using multiple batches). If a value for this
  parameter is not provided when calling `newBASiCS_Data`, BASiCS will assume
  the data contains a single batch of samples.

For example, the following code generates a synthetic dataset with 50 genes
(40 biological and 10 spike-in) and 40 cells.

```
set.seed(1)
Counts <- matrix(rpois(50 * 40, 2), ncol = 40)
rownames(Counts) <- c(paste0("Gene", 1:40), paste0("Spike", 1:10))
colnames(Counts) <- paste0("Cell", 1:40)

Tech <- c(rep(FALSE, 40), rep(TRUE, 10))
set.seed(2)
SpikeInput <- rgamma(10, 1, 1)
SpikeInfo <- data.frame(
  "SpikeID" = paste0("Spike", 1:10),
  "SpikeInput" = SpikeInput
)

# No batch structure
DataExample <- newBASiCS_Data(Counts, Tech, SpikeInfo)

# With batch structure
DataExample <- newBASiCS_Data(
  Counts, Tech, SpikeInfo,
  BatchInfo = rep(c(1, 2), each = 20)
)
```

To convert an existing `SingleCellExperiment` object (`Data`) into one that can
be used within BASiCS, meta-information must be stored in the object.

* If spike-ins are in use, observed counts must be stored in `altExp(Data)`
* `metadata(Data)`: the `SpikeInfo` object is stored in the
  `metadata` slot of the `SingleCellExperiment` object:
  `metadata(Data) <- list(SpikeInput = SpikeInfo)`.
* `colData(Data)$BatchInfo`: the `BatchInfo` object is stored in the
  `colData` slot of the `SingleCellExperiment` object.

Once the additional information is included,
the object can be used within BASiCS.

NOTE: Input number of molecules for spike-in should be calculated using
experimental information. For each spike-in gene \(i\), we use

\[ \mu\_{i} = C\_i \times 10^{-18} \times (6.022 \times 10^{23})
\times V \times D \hspace{0.5cm} \mbox{where,} \]

* \(C\_i\) is the concentration of the spike \(i\) in the ERCC mix (see
  [here](https://assets.thermofisher.com/TFS-Assets/LSG/manuals/cms_095046.txt))
* \(10^{-18}\) is to convert att to mol
* \(6.022 \times 10^{23}\) is the Avogadro number (mol \(\rightarrow\) molecule)
* \(V\) is the volume added into each chamber (**in microlitres**)
* \(D\) is a dilution factor

### 3.1.2 Without spike-in genes

To run BASiCS without incorporating reads from technical spike-in genes,
and existing `SingleCellExperiment` object can be used. The only modification
to the existing object is to assign the `colData(Data)$BatchInfo` slot.

```
set.seed(1)
CountsNoSpikes <- matrix(rpois(50 * 40, 2), ncol = 40)
rownames(CountsNoSpikes) <- paste0("Gene", 1:50)
colnames(CountsNoSpikes) <- paste0("Cell", 1:40)

# With batch structure
DataExampleNoSpikes <- SingleCellExperiment(
  assays = list(counts = CountsNoSpikes),
  colData = data.frame(BatchInfo = rep(c(1, 2), each = 20))
)
```

Note: BASiCS assumes that a pre-processing quality control step has been applied
to remove cells with poor quality data and/or lowly expressed genes that were
undetected through sequencing. When analysing multiple groups of cells, the gene
filtering step must be jointly applied across all groups to ensure the same
genes are retained.

The function `BASiCS_Filter` can be used to perform this task. For examples,
refer to `help(BASiCS_Filter)`. Moreover, the *[scater](https://bioconductor.org/packages/3.22/scater)* package
provides enhanced functionality for the pre-processing of scRNA-seq datasets.

## 3.2 Analysis for a single group of cells

We illustrate this analysis using a small extract from the MCMC chain obtained
in (Vallejos, Richardson, and Marioni [2016](#ref-vallejos2016beyond)) when analysing the single cell samples provided in
(Grün, Kester, and Oudenaarden [2014](#ref-grun2014validation)). This is included within `BASiCS` as the `ChainSC` dataset.

```
data(ChainSC)
```

The following code is used to identify **highly variable genes (HVG)** and
**lowly variable genes (LVG)** among these cells. The `VarThreshold` parameter
sets a lower threshold for the proportion of variability that is assigned to
the biological component (`Sigma`). In the examples below:

* HVG are defined as those genes for which **at least** 60% of their total
  variability is attributed to the biological variability component.
* LVG are defined as those genes for which **at most** 40% of their total
  variability is attributed to the biological variability component.

For each gene, these functions return posterior probabilities as a measure of
HVG/LVG evidence. A cut-off value for these posterior probabilities is set by
controlling the EFDR (as a default option, EFDR is set as 0.10).

```
HVG <- BASiCS_DetectHVG(ChainSC, VarThreshold = 0.6)
LVG <- BASiCS_DetectLVG(ChainSC, VarThreshold = 0.2)

plot_grid(
  BASiCS_PlotVG(HVG, "Grid"),
  BASiCS_PlotVG(HVG, "VG")
)
```

![](data:image/png;base64...)

```
plot_grid(
  BASiCS_PlotVG(LVG, "Grid"),
  BASiCS_PlotVG(LVG, "VG")
)
```

![](data:image/png;base64...)

To access the results of these tests, please use `as.data.frame`.

```
as.data.frame(HVG)
```

```
##   GeneName GeneIndex       Mu    Delta     Sigma      Prob  HVG
## 1    Amacr        21 7.164534 1.598386 0.6627267 0.6933333 TRUE
## 2   Phlda2       250 9.372955 2.171966 0.7445820 0.9600000 TRUE
## 3   Rhox13       286 9.138169 2.417712 0.7695457 0.9733333 TRUE
```

```
as.data.frame(LVG)
```

```
##         GeneName GeneIndex         Mu      Delta      Sigma      Prob  LVG
## 1  A630072M18Rik         8   76.74158 0.13842019 0.17424707 0.7333333 TRUE
## 2          Actn1        14  143.07299 0.08887830 0.11822042 0.9733333 TRUE
## 3          Ahsa1        20  167.46692 0.06774259 0.09373365 1.0000000 TRUE
## 4           Ass1        30  160.89463 0.09317097 0.12406375 0.9733333 TRUE
## 5         Atp1b1        36  182.63844 0.11706217 0.15493222 0.9200000 TRUE
## 6         Atp5g2        37  344.95180 0.06381609 0.09031420 1.0000000 TRUE
## 7           Btf3        55  263.29872 0.04880375 0.06858356 1.0000000 TRUE
## 8         Chchd2        69  576.15694 0.03078477 0.04702879 1.0000000 TRUE
## 9          Cops6        78   95.28245 0.11270865 0.14890886 0.8400000 TRUE
## 10       Dnajc19       102   69.75996 0.13088091 0.16615340 0.7200000 TRUE
## 11         Eef1d       112  164.97660 0.07334786 0.10212111 0.9866667 TRUE
## 12         Eif3e       115  172.85517 0.09311557 0.12818532 0.9866667 TRUE
## 13         Fkbp4       141  334.41897 0.07084192 0.09779841 1.0000000 TRUE
## 14          Ftl1       147 2296.21095 0.04504962 0.06656123 1.0000000 TRUE
## 15          Gars       150  144.21635 0.11851140 0.15426362 0.8533333 TRUE
## 16       Gm13251       159  214.95780 0.08542479 0.11957642 0.9866667 TRUE
## 17        Gm5506       161 2117.86447 0.06794125 0.09553558 1.0000000 TRUE
## 18        Gm5860       162  879.56308 0.07914106 0.11234069 1.0000000 TRUE
## 19       Hnrnpa3       176  698.74412 0.02606945 0.03976716 1.0000000 TRUE
## 20       Lrrc14b       191   82.26530 0.10443434 0.13761078 0.9200000 TRUE
## 21          Mcm7       199  171.91942 0.09402518 0.12149953 0.9466667 TRUE
## 22          Mlec       205   92.63264 0.09693363 0.12870287 0.9333333 TRUE
## 23          Myh9       214   75.00987 0.12209255 0.15676464 0.7733333 TRUE
## 24         Nedd8       218  140.92099 0.08071945 0.10778409 0.9600000 TRUE
## 25         Nmrk1       223  745.61731 0.13012128 0.16557363 0.8933333 TRUE
## 26         Nop56       225  237.46748 0.06437228 0.09231176 1.0000000 TRUE
## 27         Nop58       226  168.68657 0.13485637 0.16715635 0.7466667 TRUE
## 28      Npm3-ps1       230  167.04112 0.09636922 0.13345401 0.8933333 TRUE
## 29        Nucks1       232  334.69529 0.07277417 0.10074699 1.0000000 TRUE
## 30         Psmc3       269  131.08951 0.09918195 0.13530298 0.9333333 TRUE
## 31         Psmd8       270  106.57423 0.10824779 0.14710745 0.9200000 TRUE
## 32        Ptges3       272  297.56496 0.08525855 0.11596188 1.0000000 TRUE
## 33        Rad23b       275  157.73725 0.06005642 0.08739974 0.9866667 TRUE
## 34         Rbbp4       277  181.18047 0.09990468 0.13249099 0.9466667 TRUE
## 35          Rif1       287  121.96288 0.09407026 0.12419407 0.9200000 TRUE
## 36         Rpl15       290 1479.56150 0.02680944 0.03884788 1.0000000 TRUE
## 37        Rpl23a       291 1328.68382 0.02128793 0.03264723 1.0000000 TRUE
## 38         Rps11       293 1307.43808 0.02753237 0.04070404 1.0000000 TRUE
## 39       Slc23a1       310 1608.25591 0.14337288 0.18284658 0.7333333 TRUE
## 40       Slc25a3       311  371.72673 0.04075325 0.05901678 1.0000000 TRUE
## 41          Snx3       323  123.78433 0.11090234 0.14466506 0.9066667 TRUE
## 42          Snx5       324  152.55332 0.10992735 0.14451260 0.8933333 TRUE
## 43          Sod1       326  636.54334 0.03142035 0.04662697 1.0000000 TRUE
## 44          Sod2       327  222.74992 0.08470952 0.11801915 0.9866667 TRUE
## 45         Srp72       331   71.67213 0.13480074 0.17290929 0.6933333 TRUE
```

```
SummarySC <- Summary(ChainSC)
plot(SummarySC, Param = "mu", Param2 = "delta", log = "xy")
HTable <- as.data.frame(HVG)
LTable <- as.data.frame(LVG)
with(HTable, points(Mu, Delta))
with(LTable, points(Mu, Delta))
```

**Note**: this decision rule implemented in this function has changed with
respect to the original release of BASiCS (where `EviThreshold` was defined
such that EFDR = EFNR). However, the new choice is more stable (sometimes, it
was not posible to find a threshold such that EFDR = EFNR).

## 3.3 Analysis for two groups of cells

To illustrate the use of the differential mean expression and differential
over-dispersion tests between two cell populations, we use extracts from the
MCMC chains obtained in (Vallejos, Richardson, and Marioni [2016](#ref-vallejos2016beyond)) when analysing the
(Grün, Kester, and Oudenaarden [2014](#ref-grun2014validation)) dataset (single cells vs pool-and-split samples). These
were obtained by independently running the `BASiCS_MCMC` function for each
group of cells.

```
data(ChainSC)
data(ChainRNA)
```

```
Test <- BASiCS_TestDE(
  Chain1 = ChainSC, Chain2 = ChainRNA,
  GroupLabel1 = "SC", GroupLabel2 = "PaS",
  EpsilonM = log2(1.5), EpsilonD = log2(1.5),
  EFDR_M = 0.10, EFDR_D = 0.10,
  Offset = TRUE, PlotOffset = TRUE, Plot = TRUE
)
```

In `BASiCS_TestDE`, `EpsilonM` sets the log2 fold change (log2FC) in expression
(\(\mu\)) and `EpsilonD` the log2FC in over-dispersion (\(\delta\)). As a default
option: `EpsilonM = EpsilonD = log2(1.5)` (i.e. the test is set to detect
absolute increases of 50% or above). To adjust for differences in overall mRNA
content, an internal offset correction is performed when `OffSet=TRUE`.
This is the recommended default setting.

Previously, the output of this function was a set of plots and a nested list
structure. The new output is an object of S4 class `BASiCS_ResultsDE`.

```
Test
```

```
## An object of class BASiCS_ResultsDE, containing:
## -------------------------------------------------------------
##   An object of class BASiCS_ResultDE.
## -------------------------------------------------------------
##  0 genes with a change in mean expression
##  - Higher mean expression in SC samples: 0
##  - Higher mean expression in PaS samples: 0
##  - Fold change tolerance = 150 %
##  - Probability threshold = 0.666666666666667
##  - EFDR = NaN %
##  - EFNR = 19.64 %
## -------------------------------------------------------------
##   An object of class BASiCS_ResultDE.
## -------------------------------------------------------------
##  0 genes with a change in over dispersion
##  - Higher over dispersion in SC samples: 0
##  - Higher over dispersion in PaS samples: 0
##  - Fold change tolerance = 150 %
##  - Probability threshold = 0.666666666666667
##  - EFDR = NA %
##  - EFNR = NA %
```

You can access the results of these tests using `as.data.frame`. You must specify which
of the mean, dispersion and residual overdispersion results you want using the
`Which` argument, as follows.

```
head(as.data.frame(Test, Parameter = "Mean"))
```

```
## [1] GeneName       MeanOverall    Mean1          Mean2          MeanFC
## [6] MeanLog2FC     ProbDiffMean   ResultDiffMean
## <0 rows> (or 0-length row.names)
```

```
head(as.data.frame(Test, Parameter = "Disp"))
```

```
## [1] GeneName       DispOverall    Disp1          Disp2          DispFC
## [6] DispLog2FC     ProbDiffDisp   ResultDiffDisp
## <0 rows> (or 0-length row.names)
```

```
## This object doesn't contain residual overdispersion tests as the chains
## were run using the non-regression version of BASiCS
# head(as.data.frame(DE, Parameter = "Disp"))
```

There’s a `rowData` field and accessor, so we can add gene information that
will be added when formatting each of the fields (eg different gene
identifiers).

```
rowData(Test)
```

```
## DataFrame with 350 rows and 1 column
##          GeneName
##       <character>
## 1   1700094D03Rik
## 2   1700097N02Rik
## 3   1810026B05Rik
## 4   2310008H04Rik
## 5   2410137M14Rik
## ...           ...
## 346           Tef
## 347         Terf2
## 348          Tfeb
## 349        Timm22
## 350         Tinf2
```

```
rowData(Test) <- cbind(rowData(Test), Index = 1:nrow(rowData(Test)))
as.data.frame(Test, Parameter = "Mean")
```

```
## [1] GeneName       MeanOverall    Mean1          Mean2          MeanFC
## [6] MeanLog2FC     ProbDiffMean   ResultDiffMean Index
## <0 rows> (or 0-length row.names)
```

As of BASiCS v2, the differential expression plots have been re-done in ggplot2
and can be generated using `BASiCS_PlotDE`.
The default plots are “Grid” (EFDR vs EFNR), “MA”, and “Volcano”.
These are done for “Mean”, “Disp”, and “ResDisp”.
We can choose to plot eg only mean, or mean and
overdispersion, etc, and only MA plot, MA plot and volcano, etc.

```
BASiCS_PlotDE(Test)
```

![](data:image/png;base64...)

```
BASiCS_PlotDE(Test, Plots = c("MA", "Volcano"))
```

![](data:image/png;base64...)

```
BASiCS_PlotDE(Test, Plots = "MA", Parameters = "Mean")
```

![](data:image/png;base64...)

Due to the confounding between mean and over-dispersion that is
typically observed in scRNA-seq datasets, the non-regression BASiCS model
(run using `Regression = FALSE` as a function parameter in `BASiCS_MCMC`)
can only be used to assess changes in over-dispersion for those genes in which
the mean expression does not change between the groups. In this case, we
recommend users to use `EpsilonM = 0` as a conservative option to avoid
changes in over-dispersion to be confounded by mean expression (the genes for
which mean expression changes are marked as `ExcludedFromTesting` in the
`ResultDiffDisp` field).

```
Test <- BASiCS_TestDE(
  Chain1 = ChainSC, Chain2 = ChainRNA,
  GroupLabel1 = "SC", GroupLabel2 = "PaS",
  EpsilonM = 0, EpsilonD = log2(1.5),
  EFDR_M = 0.10, EFDR_D = 0.10,
  Offset = TRUE, PlotOffset = FALSE, Plot = FALSE
)
```

**Note**: If the regression BASiCS model has been
used (`Regression = TRUE` as a function parameter in `BASiCS_MCMC`),
`BASiCS_TestDE` will also report changes in residual over-dispersion
(not confounded by mean expression) between the groups (see Section
[4](#alternative-implementation-modes) in this vignette).

# 4 Alternative implementation modes

Beyond its original implementation, BASiCS has been extended to address
experimental designs in which spike-in molecules are not available as well as
to address the confounding that is typically observed between mean and
over-dispersion for scRNA-seq datasets (Eling et al. [2018](#ref-eling2018correcting)). Alternative
implementation modes are summarised below:

![](data:image/png;base64...)

As a default, the `BASiCS_MCMC` function uses `WithSpikes = TRUE`.

## 4.1 If `WithSpikes = FALSE`

When technical spike-in genes are not available, BASiCS uses a horizontal
integration strategy which borrows information across multiple technical
replicates (Eling et al. [2018](#ref-eling2018correcting)). Therefore, `BASiCS_MCMC` will fail to run if a
single batch of samples is provided. **Note:** batch information must be
provided via the `BatchInfo` argument when using the `newBASiCS_Data` function
or `BatchInfo` must be stored as a slot in `colData(Data)` when using an
existing `SingleCellExperiment` object.

```
DataNoSpikes <- newBASiCS_Data(
  Counts, Tech, SpikeInfo = NULL,
  BatchInfo = rep(c(1, 2), each = 20)
)

# Alternatively
DataNoSpikes <- SingleCellExperiment(
  assays = list(counts = Counts),
  colData = data.frame(BatchInfo = rep(c(1, 2), each = 20))
)

ChainNoSpikes <- BASiCS_MCMC(
  Data = DataNoSpikes, N = 1000,
  Thin = 10, Burn = 500,
  WithSpikes = FALSE,  Regression = TRUE,
  PrintProgress = FALSE
)
```

```
## -----------------------------------------------------
## MCMC sampler has been started: 1000 iterations to go.
## -----------------------------------------------------
## Iteration: 0
## RefGene: 33
## RefGene before update: 2.01778
## sumAux (line 117): 34.019
## RefGene after update: 1.34108
## Iteration: 1
## RefGene: 17
## RefGene before update: 1.9953
## sumAux (line 117): 33.9223
## RefGene after update: 1.47719
## Iteration: 2
## RefGene: 9
## RefGene before update: 1.9953
## sumAux (line 117): 33.4081
## RefGene after update: 2.47039
## Iteration: 3
## RefGene: 48
## RefGene before update: 2.4174
## sumAux (line 117): 33.9961
## RefGene after update: 1.37205
## Iteration: 4
## RefGene: 33
## RefGene before update: 2.4174
## sumAux (line 117): 34.0968
## RefGene after update: 1.24067
## Iteration: 5
## RefGene: 17
## RefGene before update: 2.38188
## sumAux (line 117): 34.4132
## RefGene after update: 0.904141
## Iteration: 6
## RefGene: 15
## RefGene before update: 2.26451
## sumAux (line 117): 33.6945
## RefGene after update: 1.85513
## Iteration: 7
## RefGene: 15
## RefGene before update: 2.26451
## sumAux (line 117): 33.0558
## RefGene after update: 3.51348
## Iteration: 8
## RefGene: 25
## RefGene before update: 1.8864
## sumAux (line 117): 33.5089
## RefGene after update: 2.23352
## Iteration: 9
## RefGene: 16
## RefGene before update: 1.64623
## sumAux (line 117): 34.1356
## RefGene after update: 1.19343
## Iteration: 10
## RefGene: 15
## RefGene before update: 1.6502
## sumAux (line 117): 32.8664
## RefGene after update: 4.24621
## Iteration: 11
## RefGene: 20
## RefGene before update: 1.6502
## sumAux (line 117): 34.3556
## RefGene after update: 0.957799
## Iteration: 12
## RefGene: 15
## RefGene before update: 1.82135
## sumAux (line 117): 33.2928
## RefGene after update: 2.77219
## Iteration: 13
## RefGene: 3
## RefGene before update: 1.61719
## sumAux (line 117): 34.4318
## RefGene after update: 0.887469
## Iteration: 14
## RefGene: 15
## RefGene before update: 1.81402
## sumAux (line 117): 32.7807
## RefGene after update: 4.62634
## Iteration: 15
## RefGene: 9
## RefGene before update: 1.98949
## sumAux (line 117): 33.3532
## RefGene after update: 2.60984
## Iteration: 16
## RefGene: 9
## RefGene before update: 1.98949
## sumAux (line 117): 33.4522
## RefGene after update: 2.36371
## Iteration: 17
## RefGene: 16
## RefGene before update: 1.93262
## sumAux (line 117): 34.01
## RefGene after update: 1.35317
## Iteration: 18
## RefGene: 17
## RefGene before update: 1.78534
## sumAux (line 117): 33.2244
## RefGene after update: 2.96835
## Iteration: 19
## RefGene: 33
## RefGene before update: 1.78534
## sumAux (line 117): 33.4321
## RefGene after update: 2.41176
## Iteration: 20
## RefGene: 17
## RefGene before update: 2.45285
## sumAux (line 117): 33.1901
## RefGene after update: 3.07216
## Iteration: 21
## RefGene: 48
## RefGene before update: 2.15019
## sumAux (line 117): 32.6337
## RefGene after update: 5.35902
## Iteration: 22
## RefGene: 15
## RefGene before update: 2.01018
## sumAux (line 117): 33.2536
## RefGene after update: 2.88298
## Iteration: 23
## RefGene: 15
## RefGene before update: 2.01018
## sumAux (line 117): 32.8196
## RefGene after update: 4.44955
## Iteration: 24
## RefGene: 1
## RefGene before update: 2.15985
## sumAux (line 117): 34.3526
## RefGene after update: 0.960668
## Iteration: 25
## RefGene: 20
## RefGene before update: 0.960668
## sumAux (line 117): 34.4217
## RefGene after update: 0.896487
## Iteration: 26
## RefGene: 1
## RefGene before update: 1.23713
## sumAux (line 117): 33.496
## RefGene after update: 2.26243
## Iteration: 27
## RefGene: 1
## RefGene before update: 2.26243
## sumAux (line 117): 33.8332
## RefGene after update: 1.61486
## Iteration: 28
## RefGene: 33
## RefGene before update: 1.61486
## sumAux (line 117): 33.2222
## RefGene after update: 2.97509
## Iteration: 29
## RefGene: 33
## RefGene before update: 1.69668
## sumAux (line 117): 33.3039
## RefGene after update: 2.74155
## Iteration: 30
## RefGene: 17
## RefGene before update: 1.88631
## sumAux (line 117): 33.6079
## RefGene after update: 2.0229
## Iteration: 31
## RefGene: 16
## RefGene before update: 2.11807
## sumAux (line 117): 33.1691
## RefGene after update: 3.13719
## Iteration: 32
## RefGene: 1
## RefGene before update: 2.11807
## sumAux (line 117): 33.7763
## RefGene after update: 1.7095
## Iteration: 33
## RefGene: 3
## RefGene before update: 1.7095
## sumAux (line 117): 32.7829
## RefGene after update: 4.61621
## Iteration: 34
## RefGene: 1
## RefGene before update: 1.7095
## sumAux (line 117): 33.5299
## RefGene after update: 2.18709
## Iteration: 35
## RefGene: 25
## RefGene before update: 2.18709
## sumAux (line 117): 34.0422
## RefGene after update: 1.3103
## Iteration: 36
## RefGene: 3
## RefGene before update: 2.23014
## sumAux (line 117): 33.4926
## RefGene after update: 2.27025
## Iteration: 37
## RefGene: 15
## RefGene before update: 2.23014
## sumAux (line 117): 34.2845
## RefGene after update: 1.02839
## Iteration: 38
## RefGene: 3
## RefGene before update: 2.23014
## sumAux (line 117): 33.367
## RefGene after update: 2.574
## Iteration: 39
## RefGene: 16
## RefGene before update: 2.25551
## sumAux (line 117): 33.4336
## RefGene after update: 2.40817
## Iteration: 40
## RefGene: 17
## RefGene before update: 2.25551
## sumAux (line 117): 33.2694
## RefGene after update: 2.83792
## Iteration: 41
## RefGene: 9
## RefGene before update: 1.89482
## sumAux (line 117): 34.3003
## RefGene after update: 1.01225
## Iteration: 42
## RefGene: 25
## RefGene before update: 1.89482
## sumAux (line 117): 33.6371
## RefGene after update: 1.96466
## Iteration: 43
## RefGene: 9
## RefGene before update: 2.01504
## sumAux (line 117): 34.0359
## RefGene after update: 1.31853
## Iteration: 44
## RefGene: 48
## RefGene before update: 2.01504
## sumAux (line 117): 33.456
## RefGene after update: 2.35479
## Iteration: 45
## RefGene: 25
## RefGene before update: 2.193
## sumAux (line 117): 32.9929
## RefGene after update: 3.74191
## Iteration: 46
## RefGene: 3
## RefGene before update: 2.10273
## sumAux (line 117): 32.6613
## RefGene after update: 5.21282
## Iteration: 47
## RefGene: 48
## RefGene before update: 1.67018
## sumAux (line 117): 33.4907
## RefGene after update: 2.2745
## Iteration: 48
## RefGene: 20
## RefGene before update: 1.55772
## sumAux (line 117): 34.1168
## RefGene after update: 1.21614
## Iteration: 49
## RefGene: 9
## RefGene before update: 1.68206
## sumAux (line 117): 33.6526
## RefGene after update: 1.93453
## Iteration: 50
## RefGene: 16
## RefGene before update: 1.68206
## sumAux (line 117): 32.8545
## RefGene after update: 4.29708
## Iteration: 51
## RefGene: 9
## RefGene before update: 1.68206
## sumAux (line 117): 34.3276
## RefGene after update: 0.984971
## Iteration: 52
## RefGene: 1
## RefGene before update: 2.53545
## sumAux (line 117): 33.4754
## RefGene after update: 2.30951
## Iteration: 53
## RefGene: 16
## RefGene before update: 2.30951
## sumAux (line 117): 33.2925
## RefGene after update: 2.77297
## Iteration: 54
## RefGene: 9
## RefGene before update: 2.30951
## sumAux (line 117): 33.4646
## RefGene after update: 2.33463
## Iteration: 55
## RefGene: 25
## RefGene before update: 1.94851
## sumAux (line 117): 33.3023
## RefGene after update: 2.74591
## Iteration: 56
## RefGene: 1
## RefGene before update: 2.30363
## sumAux (line 117): 33.1374
## RefGene after update: 3.23841
## Iteration: 57
## RefGene: 25
## RefGene before update: 3.23841
## sumAux (line 117): 33.1477
## RefGene after update: 3.20523
## Iteration: 58
## RefGene: 20
## RefGene before update: 3.33285
## sumAux (line 117): 33.2942
## RefGene after update: 2.76821
## Iteration: 59
## RefGene: 25
## RefGene before update: 3.0583
## sumAux (line 117): 33.4734
## RefGene after update: 2.31427
## Iteration: 60
## RefGene: 25
## RefGene before update: 2.81835
## sumAux (line 117): 33.3578
## RefGene after update: 2.5978
## Iteration: 61
## RefGene: 1
## RefGene before update: 2.57166
## sumAux (line 117): 33.6561
## RefGene after update: 1.92778
## Iteration: 62
## RefGene: 33
## RefGene before update: 1.92778
## sumAux (line 117): 33.1894
## RefGene after update: 3.07412
## Iteration: 63
## RefGene: 33
## RefGene before update: 1.92778
## sumAux (line 117): 32.8142
## RefGene after update: 4.47386
## Iteration: 64
## RefGene: 33
## RefGene before update: 1.78157
## sumAux (line 117): 32.9928
## RefGene after update: 3.74211
## Iteration: 65
## RefGene: 48
## RefGene before update: 1.78157
## sumAux (line 117): 34.4948
## RefGene after update: 0.833306
## Iteration: 66
## RefGene: 17
## RefGene before update: 1.66923
## sumAux (line 117): 33.9391
## RefGene after update: 1.45258
## Iteration: 67
## RefGene: 20
## RefGene before update: 2.10577
## sumAux (line 117): 33.983
## RefGene after update: 1.39017
## Iteration: 68
## RefGene: 1
## RefGene before update: 2.10577
## sumAux (line 117): 33.1205
## RefGene after update: 3.29363
## Iteration: 69
## RefGene: 25
## RefGene before update: 3.29363
## sumAux (line 117): 33.5573
## RefGene after update: 2.12783
## Iteration: 70
## RefGene: 3
## RefGene before update: 3.29363
## sumAux (line 117): 33.2421
## RefGene after update: 2.91645
## Iteration: 71
## RefGene: 1
## RefGene before update: 3.29363
## sumAux (line 117): 33.4546
## RefGene after update: 2.35816
## Iteration: 72
## RefGene: 25
## RefGene before update: 2.35816
## sumAux (line 117): 33.6811
## RefGene after update: 1.88007
## Iteration: 73
## RefGene: 25
## RefGene before update: 2.1891
## sumAux (line 117): 34.0848
## RefGene after update: 1.25568
## Iteration: 74
## RefGene: 20
## RefGene before update: 2.1891
## sumAux (line 117): 33.2542
## RefGene after update: 2.88125
## Iteration: 75
## RefGene: 16
## RefGene before update: 1.92181
## sumAux (line 117): 33.9724
## RefGene after update: 1.40505
## Iteration: 76
## RefGene: 16
## RefGene before update: 1.92181
## sumAux (line 117): 34.3794
## RefGene after update: 0.935231
## Iteration: 77
## RefGene: 16
## RefGene before update: 1.97536
## sumAux (line 117): 34.4868
## RefGene after update: 0.839979
## Iteration: 78
## RefGene: 33
## RefGene before update: 1.97536
## sumAux (line 117): 33.6493
## RefGene after update: 1.94083
## Iteration: 79
## RefGene: 33
## RefGene before update: 1.97536
## sumAux (line 117): 33.2181
## RefGene after update: 2.98719
## Iteration: 80
## RefGene: 25
## RefGene before update: 1.97536
## sumAux (line 117): 33.2818
## RefGene after update: 2.80288
## Iteration: 81
## RefGene: 25
## RefGene before update: 2.24741
## sumAux (line 117): 33.1845
## RefGene after update: 3.08928
## Iteration: 82
## RefGene: 25
## RefGene before update: 2.24741
## sumAux (line 117): 33.5726
## RefGene after update: 2.09572
## Iteration: 83
## RefGene: 33
## RefGene before update: 2.22745
## sumAux (line 117): 33.34
## RefGene after update: 2.6444
## Iteration: 84
## RefGene: 20
## RefGene before update: 2.26068
## sumAux (line 117): 32.7046
## RefGene after update: 4.99208
## Iteration: 85
## RefGene: 25
## RefGene before update: 2.26068
## sumAux (line 117): 33.681
## RefGene after update: 1.88029
## Iteration: 86
## RefGene: 48
## RefGene before update: 2.26068
## sumAux (line 117): 34.9876
## RefGene after update: 0.509087
## Iteration: 87
## RefGene: 48
## RefGene before update: 2.50288
## sumAux (line 117): 34.8195
## RefGene after update: 0.602267
## Iteration: 88
## RefGene: 20
## RefGene before update: 2.23245
## sumAux (line 117): 32.8029
## RefGene after update: 4.52454
## Iteration: 89
## RefGene: 20
## RefGene before update: 2.23245
## sumAux (line 117): 32.6982
## RefGene after update: 5.02408
## Iteration: 90
## RefGene: 20
## RefGene before update: 2.23245
## sumAux (line 117): 32.9761
## RefGene after update: 3.80518
## Iteration: 91
## RefGene: 33
## RefGene before update: 2.23245
## sumAux (line 117): 33.2781
## RefGene after update: 2.81341
## Iteration: 92
## RefGene: 15
## RefGene before update: 2.23245
## sumAux (line 117): 33.6109
## RefGene after update: 2.01696
## Iteration: 93
## RefGene: 20
## RefGene before update: 2.23245
## sumAux (line 117): 33.3947
## RefGene after update: 2.50358
## Iteration: 94
## RefGene: 20
## RefGene before update: 2.23245
## sumAux (line 117): 33.4266
## RefGene after update: 2.42502
## Iteration: 95
## RefGene: 48
## RefGene before update: 2.23245
## sumAux (line 117): 34.6489
## RefGene after update: 0.714267
## Iteration: 96
## RefGene: 20
## RefGene before update: 2.55775
## sumAux (line 117): 33.2512
## RefGene after update: 2.88996
## Iteration: 97
## RefGene: 16
## RefGene before update: 2.44291
## sumAux (line 117): 33.7147
## RefGene after update: 1.81797
## Iteration: 98
## RefGene: 25
## RefGene before update: 1.97114
## sumAux (line 117): 33.1223
## RefGene after update: 3.2875
## Iteration: 99
## RefGene: 25
## RefGene before update: 2.15039
## sumAux (line 117): 32.4204
## RefGene after update: 6.63321
## Iteration: 100
## RefGene: 16
## RefGene before update: 1.99726
## sumAux (line 117): 33.8018
## RefGene after update: 1.66631
## Iteration: 101
## RefGene: 20
## RefGene before update: 1.89007
## sumAux (line 117): 33.8987
## RefGene after update: 1.51245
## Iteration: 102
## RefGene: 33
## RefGene before update: 1.89007
## sumAux (line 117): 33.9107
## RefGene after update: 1.49442
## Iteration: 103
## RefGene: 9
## RefGene before update: 1.77444
## sumAux (line 117): 33.3227
## RefGene after update: 2.69047
## Iteration: 104
## RefGene: 9
## RefGene before update: 1.77444
## sumAux (line 117): 32.8545
## RefGene after update: 4.29707
## Iteration: 105
## RefGene: 9
## RefGene before update: 2.05996
## sumAux (line 117): 33.0032
## RefGene after update: 3.70343
## Iteration: 106
## RefGene: 3
## RefGene before update: 2.05996
## sumAux (line 117): 33.7675
## RefGene after update: 1.72451
## Iteration: 107
## RefGene: 33
## RefGene before update: 2.05996
## sumAux (line 117): 33.1385
## RefGene after update: 3.23471
## Iteration: 108
## RefGene: 3
## RefGene before update: 2.01674
## sumAux (line 117): 33.2767
## RefGene after update: 2.81731
## Iteration: 109
## RefGene: 33
## RefGene before update: 2.01674
## sumAux (line 117): 33.3448
## RefGene after update: 2.63187
## Iteration: 110
## RefGene: 20
## RefGene before update: 1.98705
## sumAux (line 117): 33.5819
## RefGene after update: 2.07625
## Iteration: 111
## RefGene: 17
## RefGene before update: 2.06454
## sumAux (line 117): 33.2449
## RefGene after update: 2.90813
## Iteration: 112
## RefGene: 1
## RefGene before update: 1.98662
## sumAux (line 117): 33.3658
## RefGene after update: 2.57701
## Iteration: 113
## RefGene: 25
## RefGene before update: 2.57701
## sumAux (line 117): 33.8212
## RefGene after update: 1.63436
## Iteration: 114
## RefGene: 16
## RefGene before update: 2.41939
## sumAux (line 117): 33.8483
## RefGene after update: 1.59074
## Iteration: 115
## RefGene: 9
## RefGene before update: 2.41939
## sumAux (line 117): 33.8211
## RefGene after update: 1.63453
## Iteration: 116
## RefGene: 20
## RefGene before update: 2.32767
## sumAux (line 117): 34.7657
## RefGene after update: 0.635529
## Iteration: 117
## RefGene: 17
## RefGene before update: 2.32767
## sumAux (line 117): 32.9877
## RefGene after update: 3.76131
## Iteration: 118
## RefGene: 17
## RefGene before update: 2.17638
## sumAux (line 117): 32.9087
## RefGene after update: 4.07029
## Iteration: 119
## RefGene: 17
## RefGene before update: 1.95956
## sumAux (line 117): 33.2044
## RefGene after update: 3.02835
## Iteration: 120
## RefGene: 16
## RefGene before update: 1.95956
## sumAux (line 117): 33.2052
## RefGene after update: 3.02605
## Iteration: 121
## RefGene: 15
## RefGene before update: 1.96534
## sumAux (line 117): 33.0768
## RefGene after update: 3.44056
## Iteration: 122
## RefGene: 25
## RefGene before update: 2.00231
## sumAux (line 117): 33.3421
## RefGene after update: 2.63878
## Iteration: 123
## RefGene: 3
## RefGene before update: 2.09096
## sumAux (line 117): 33.2396
## RefGene after update: 2.92374
## Iteration: 124
## RefGene: 25
## RefGene before update: 2.09096
## sumAux (line 117): 33.3479
## RefGene after update: 2.62367
## Iteration: 125
## RefGene: 3
## RefGene before update: 2.07836
## sumAux (line 117): 34.2118
## RefGene after update: 1.10585
## Iteration: 126
## RefGene: 48
## RefGene before update: 2.07836
## sumAux (line 117): 33.383
## RefGene after update: 2.53315
## Iteration: 127
## RefGene: 25
## RefGene before update: 2.07836
## sumAux (line 117): 33.6242
## RefGene after update: 1.99028
## Iteration: 128
## RefGene: 20
## RefGene before update: 2.27546
## sumAux (line 117): 33.5825
## RefGene after update: 2.07496
## Iteration: 129
## RefGene: 25
## RefGene before update: 2.17306
## sumAux (line 117): 33.8033
## RefGene after update: 1.66381
## Iteration: 130
## RefGene: 15
## RefGene before update: 1.98817
## sumAux (line 117): 32.7106
## RefGene after update: 4.96216
## Iteration: 131
## RefGene: 1
## RefGene before update: 1.98817
## sumAux (line 117): 33.4607
## RefGene after update: 2.34376
## Iteration: 132
## RefGene: 25
## RefGene before update: 2.34376
## sumAux (line 117): 33.1819
## RefGene after update: 3.09731
## Iteration: 133
## RefGene: 1
## RefGene before update: 2.34376
## sumAux (line 117): 32.6017
## RefGene after update: 5.53335
## Iteration: 134
## RefGene: 1
## RefGene before update: 5.53335
## sumAux (line 117): 32.3273
## RefGene after update: 7.28033
## Iteration: 135
## RefGene: 33
## RefGene before update: 7.28033
## sumAux (line 117): 34.3941
## RefGene after update: 0.921633
## Iteration: 136
## RefGene: 16
## RefGene before update: 7.28033
## sumAux (line 117): 33.044
## RefGene after update: 3.5555
## Iteration: 137
## RefGene: 48
## RefGene before update: 7.28033
## sumAux (line 117): 34.4998
## RefGene after update: 0.829141
## Iteration: 138
## RefGene: 48
## RefGene before update: 7.28033
## sumAux (line 117): 34.0627
## RefGene after update: 1.28369
## Iteration: 139
## RefGene: 3
## RefGene before update: 6.8256
## sumAux (line 117): 33.5515
## RefGene after update: 2.14034
## Iteration: 140
## RefGene: 25
## RefGene before update: 6.8256
## sumAux (line 117): 33.6376
## RefGene after update: 1.96372
## Iteration: 141
## RefGene: 17
## RefGene before update: 6.8256
## sumAux (line 117): 34.0628
## RefGene after update: 1.28362
## Iteration: 142
## RefGene: 17
## RefGene before update: 5.68265
## sumAux (line 117): 32.5828
## RefGene after update: 5.63894
## Iteration: 143
## RefGene: 15
## RefGene before update: 4.14201
## sumAux (line 117): 33.9295
## RefGene after update: 1.46658
## Iteration: 144
## RefGene: 15
## RefGene before update: 3.87193
## sumAux (line 117): 33.9099
## RefGene after update: 1.49566
## Iteration: 145
## RefGene: 25
## RefGene before update: 3.34213
## sumAux (line 117): 34.199
## RefGene after update: 1.12013
## Iteration: 146
## RefGene: 25
## RefGene before update: 3.21314
## sumAux (line 117): 33.8131
## RefGene after update: 1.64767
## Iteration: 147
## RefGene: 16
## RefGene before update: 3.41554
## sumAux (line 117): 33.1915
## RefGene after update: 3.06766
## Iteration: 148
## RefGene: 9
## RefGene before update: 3.41554
## sumAux (line 117): 34.0046
## RefGene after update: 1.36054
## Iteration: 149
## RefGene: 20
## RefGene before update: 3.17753
## sumAux (line 117): 34.2559
## RefGene after update: 1.05819
## Iteration: 150
## RefGene: 17
## RefGene before update: 3.25498
## sumAux (line 117): 32.9916
## RefGene after update: 3.74666
## Iteration: 151
## RefGene: 3
## RefGene before update: 3.25498
## sumAux (line 117): 33.7696
## RefGene after update: 1.72085
## Iteration: 152
## RefGene: 33
## RefGene before update: 3.25498
## sumAux (line 117): 33.0845
## RefGene after update: 3.41438
## Iteration: 153
## RefGene: 48
## RefGene before update: 2.76829
## sumAux (line 117): 34.1177
## RefGene after update: 1.21502
## Iteration: 154
## RefGene: 20
## RefGene before update: 2.98788
## sumAux (line 117): 33.347
## RefGene after update: 2.62588
## Iteration: 155
## RefGene: 20
## RefGene before update: 3.05269
## sumAux (line 117): 33.6358
## RefGene after update: 1.96727
## Iteration: 156
## RefGene: 33
## RefGene before update: 2.55235
## sumAux (line 117): 33.6776
## RefGene after update: 1.88674
## Iteration: 157
## RefGene: 9
## RefGene before update: 2.55235
## sumAux (line 117): 32.4464
## RefGene after update: 6.4626
## Iteration: 158
## RefGene: 25
## RefGene before update: 2.08584
## sumAux (line 117): 33.1755
## RefGene after update: 3.11719
## Iteration: 159
## RefGene: 48
## RefGene before update: 2.08584
## sumAux (line 117): 34.3163
## RefGene after update: 0.99611
## Iteration: 160
## RefGene: 33
## RefGene before update: 2.08584
## sumAux (line 117): 34.103
## RefGene after update: 1.23302
## Iteration: 161
## RefGene: 1
## RefGene before update: 2.08584
## sumAux (line 117): 34.1409
## RefGene after update: 1.18718
## Iteration: 162
## RefGene: 33
## RefGene before update: 1.18718
## sumAux (line 117): 33.9226
## RefGene after update: 1.47679
## Iteration: 163
## RefGene: 48
## RefGene before update: 1.18718
## sumAux (line 117): 34.2669
## RefGene after update: 1.04659
## Iteration: 164
## RefGene: 48
## RefGene before update: 1.26927
## sumAux (line 117): 34.663
## RefGene after update: 0.704296
## Iteration: 165
## RefGene: 20
## RefGene before update: 1.17919
## sumAux (line 117): 32.673
## RefGene after update: 5.15235
## Iteration: 166
## RefGene: 15
## RefGene before update: 1.17919
## sumAux (line 117): 34.4825
## RefGene after update: 0.843652
## Iteration: 167
## RefGene: 48
## RefGene before update: 1.41877
## sumAux (line 117): 33.9129
## RefGene after update: 1.49123
## Iteration: 168
## RefGene: 33
## RefGene before update: 1.57937
## sumAux (line 117): 33.8939
## RefGene after update: 1.51978
## Iteration: 169
## RefGene: 17
## RefGene before update: 1.57937
## sumAux (line 117): 33.2724
## RefGene after update: 2.82922
## Iteration: 170
## RefGene: 3
## RefGene before update: 1.57937
## sumAux (line 117): 34.2174
## RefGene after update: 1.09967
## Iteration: 171
## RefGene: 3
## RefGene before update: 1.57937
## sumAux (line 117): 34.3545
## RefGene after update: 0.958791
## Iteration: 172
## RefGene: 15
## RefGene before update: 1.57937
## sumAux (line 117): 34.3697
## RefGene after update: 0.944341
## Iteration: 173
## RefGene: 48
## RefGene before update: 1.57937
## sumAux (line 117): 33.1828
## RefGene after update: 3.09467
## Iteration: 174
## RefGene: 48
## RefGene before update: 1.6241
## sumAux (line 117): 33.4538
## RefGene after update: 2.35995
## Iteration: 175
## RefGene: 25
## RefGene before update: 1.80159
## sumAux (line 117): 33.7973
## RefGene after update: 1.67388
## Iteration: 176
## RefGene: 15
## RefGene before update: 1.90041
## sumAux (line 117): 34.3997
## RefGene after update: 0.916414
## Iteration: 177
## RefGene: 1
## RefGene before update: 1.73522
## sumAux (line 117): 33.8782
## RefGene after update: 1.54383
## Iteration: 178
## RefGene: 1
## RefGene before update: 1.54383
## sumAux (line 117): 33.2692
## RefGene after update: 2.83852
## Iteration: 179
## RefGene: 16
## RefGene before update: 2.83852
## sumAux (line 117): 33.6625
## RefGene after update: 1.91548
## Iteration: 180
## RefGene: 20
## RefGene before update: 2.83852
## sumAux (line 117): 32.5571
## RefGene after update: 5.7853
## Iteration: 181
## RefGene: 33
## RefGene before update: 2.83852
## sumAux (line 117): 32.915
## RefGene after update: 4.04484
## Iteration: 182
## RefGene: 17
## RefGene before update: 2.45808
## sumAux (line 117): 33.8727
## RefGene after update: 1.55224
## Iteration: 183
## RefGene: 15
## RefGene before update: 2.45808
## sumAux (line 117): 34.0543
## RefGene after update: 1.29452
## Iteration: 184
## RefGene: 33
## RefGene before update: 2.45808
## sumAux (line 117): 33.4919
## RefGene after update: 2.27186
## Iteration: 185
## RefGene: 15
## RefGene before update: 2.45808
## sumAux (line 117): 33.6539
## RefGene after update: 1.93192
## Iteration: 186
## RefGene: 17
## RefGene before update: 2.45808
## sumAux (line 117): 33.7738
## RefGene after update: 1.71362
## Iteration: 187
## RefGene: 20
## RefGene before update: 2.45808
## sumAux (line 117): 33.1802
## RefGene after update: 3.10264
## Iteration: 188
## RefGene: 17
## RefGene before update: 2.42049
## sumAux (line 117): 33.0404
## RefGene after update: 3.56815
## Iteration: 189
## RefGene: 1
## RefGene before update: 2.09655
## sumAux (line 117): 33.4686
## RefGene after update: 2.32522
## Iteration: 190
## RefGene: 16
## RefGene before update: 2.32522
## sumAux (line 117): 33.7621
## RefGene after update: 1.73387
## Iteration: 191
## RefGene: 16
## RefGene before update: 2.03303
## sumAux (line 117): 32.7424
## RefGene after update: 4.80695
## Iteration: 192
## RefGene: 48
## RefGene before update: 2.33673
## sumAux (line 117): 33.6807
## RefGene after update: 1.88095
## Iteration: 193
## RefGene: 16
## RefGene before update: 2.33673
## sumAux (line 117): 33.9607
## RefGene after update: 1.4215
## Iteration: 194
## RefGene: 33
## RefGene before update: 2.33673
## sumAux (line 117): 34.2522
## RefGene after update: 1.06206
## Iteration: 195
## RefGene: 16
## RefGene before update: 2.33673
## sumAux (line 117): 33.1567
## RefGene after update: 3.17653
## Iteration: 196
## RefGene: 48
## RefGene before update: 2.33673
## sumAux (line 117): 33.4984
## RefGene after update: 2.257
## Iteration: 197
## RefGene: 9
## RefGene before update: 1.78091
## sumAux (line 117): 33.8717
## RefGene after update: 1.55392
## Iteration: 198
## RefGene: 25
## RefGene before update: 1.78091
## sumAux (line 117): 34.1892
## RefGene after update: 1.13122
## Iteration: 199
## RefGene: 15
## RefGene before update: 1.78091
## sumAux (line 117): 33.0168
## RefGene after update: 3.65352
## Iteration: 200
## RefGene: 20
## RefGene before update: 1.78091
## sumAux (line 117): 32.6174
## RefGene after update: 5.44685
## Iteration: 201
## RefGene: 25
## RefGene before update: 1.78091
## sumAux (line 117): 33.3037
## RefGene after update: 2.74225
## Iteration: 202
## RefGene: 48
## RefGene before update: 2.12723
## sumAux (line 117): 33.2196
## RefGene after update: 2.98281
## Iteration: 203
## RefGene: 16
## RefGene before update: 2.0781
## sumAux (line 117): 34.5182
## RefGene after update: 0.814014
## Iteration: 204
## RefGene: 3
## RefGene before update: 2.3481
## sumAux (line 117): 33.5141
## RefGene after update: 2.22198
## Iteration: 205
## RefGene: 16
## RefGene before update: 2.3481
## sumAux (line 117): 33.8481
## RefGene after update: 1.59098
## Iteration: 206
## RefGene: 48
## RefGene before update: 1.9368
## sumAux (line 117): 33.1899
## RefGene after update: 3.07254
## Iteration: 207
## RefGene: 33
## RefGene before update: 1.9368
## sumAux (line 117): 34.2461
## RefGene after update: 1.06858
## Iteration: 208
## RefGene: 16
## RefGene before update: 1.84255
## sumAux (line 117): 33.7247
## RefGene after update: 1.79987
## Iteration: 209
## RefGene: 3
## RefGene before update: 2.18178
## sumAux (line 117): 33.0667
## RefGene after update: 3.47542
## Iteration: 210
## RefGene: 25
## RefGene before update: 2.24853
## sumAux (line 117): 33.8571
## RefGene after update: 1.57674
## Iteration: 211
## RefGene: 25
## RefGene before update: 2.24853
## sumAux (line 117): 34.514
## RefGene after update: 0.817467
## Iteration: 212
## RefGene: 3
## RefGene before update: 2.3653
## sumAux (line 117): 33.9043
## RefGene after update: 1.50403
## Iteration: 213
## RefGene: 17
## RefGene before update: 2.3653
## sumAux (line 117): 32.9447
## RefGene after update: 3.92646
## Iteration: 214
## RefGene: 33
## RefGene before update: 2.17703
## sumAux (line 117): 34.6513
## RefGene after update: 0.712587
## Iteration: 215
## RefGene: 25
## RefGene before update: 2.17703
## sumAux (line 117): 33.3457
## RefGene after update: 2.62931
## Iteration: 216
## RefGene: 1
## RefGene before update: 1.83268
## sumAux (line 117): 33.332
## RefGene after update: 2.66572
## Iteration: 217
## RefGene: 15
## RefGene before update: 2.66572
## sumAux (line 117): 33.5715
## RefGene after update: 2.09796
## Iteration: 218
## RefGene: 33
## RefGene before update: 2.66572
## sumAux (line 117): 33.3739
## RefGene after update: 2.55616
## Iteration: 219
## RefGene: 16
## RefGene before update: 2.66572
## sumAux (line 117): 33.3484
## RefGene after update: 2.62231
## Iteration: 220
## RefGene: 20
## RefGene before update: 2.21596
## sumAux (line 117): 32.3746
## RefGene after update: 6.94351
## Iteration: 221
## RefGene: 33
## RefGene before update: 2.21596
## sumAux (line 117): 33.7609
## RefGene after update: 1.73594
## Iteration: 222
## RefGene: 1
## RefGene before update: 2.04561
## sumAux (line 117): 33.5288
## RefGene after update: 2.18935
## Iteration: 223
## RefGene: 15
## RefGene before update: 2.18935
## sumAux (line 117): 33.5982
## RefGene after update: 2.04257
## Iteration: 224
## RefGene: 1
## RefGene before update: 2.07273
## sumAux (line 117): 33.2471
## RefGene after update: 2.90182
## Iteration: 225
## RefGene: 16
## RefGene before update: 2.90182
## sumAux (line 117): 33.9187
## RefGene after update: 1.48255
## Iteration: 226
## RefGene: 25
## RefGene before update: 2.90182
## sumAux (line 117): 33.6852
## RefGene after update: 1.87241
## Iteration: 227
## RefGene: 48
## RefGene before update: 2.6784
## sumAux (line 117): 33.993
## RefGene after update: 1.37631
## Iteration: 228
## RefGene: 33
## RefGene before update: 2.32359
## sumAux (line 117): 33.2105
## RefGene after update: 3.01001
## Iteration: 229
## RefGene: 17
## RefGene before update: 2.13559
## sumAux (line 117): 33.9704
## RefGene after update: 1.40784
## Iteration: 230
## RefGene: 17
## RefGene before update: 1.81815
## sumAux (line 117): 33.6443
## RefGene after update: 1.95058
## Iteration: 231
## RefGene: 3
## RefGene before update: 1.81815
## sumAux (line 117): 33.5155
## RefGene after update: 2.21879
## Iteration: 232
## RefGene: 9
## RefGene before update: 1.94985
## sumAux (line 117): 34.0751
## RefGene after update: 1.26786
## Iteration: 233
## RefGene: 1
## RefGene before update: 1.94985
## sumAux (line 117): 33.6701
## RefGene after update: 1.90099
## Iteration: 234
## RefGene: 16
## RefGene before update: 1.90099
## sumAux (line 117): 33.3708
## RefGene after update: 2.56423
## Iteration: 235
## RefGene: 9
## RefGene before update: 1.90099
## sumAux (line 117): 33.6936
## RefGene after update: 1.8567
## Iteration: 236
## RefGene: 17
## RefGene before update: 1.90099
## sumAux (line 117): 33.4584
## RefGene after update: 2.34904
## Iteration: 237
## RefGene: 48
## RefGene before update: 2.02447
## sumAux (line 117): 33.2758
## RefGene after update: 2.8197
## Iteration: 238
## RefGene: 3
## RefGene before update: 2.02447
## sumAux (line 117): 33.0886
## RefGene after update: 3.40023
## Iteration: 239
## RefGene: 17
## RefGene before update: 2.20068
## sumAux (line 117): 33.7031
## RefGene after update: 1.83919
## Iteration: 240
## RefGene: 17
## RefGene before update: 2.17112
## sumAux (line 117): 33.0069
## RefGene after update: 3.68986
## Iteration: 241
## RefGene: 48
## RefGene before update: 1.98105
## sumAux (line 117): 32.9121
## RefGene after update: 4.05678
## Iteration: 242
## RefGene: 48
## RefGene before update: 1.5354
## sumAux (line 117): 33.2787
## RefGene after update: 2.81173
## Iteration: 243
## RefGene: 3
## RefGene before update: 1.5354
## sumAux (line 117): 33.8727
## RefGene after update: 1.55238
## Iteration: 244
## RefGene: 3
## RefGene before update: 1.58887
## sumAux (line 117): 33.3694
## RefGene after update: 2.56785
## Iteration: 245
## RefGene: 16
## RefGene before update: 1.58887
## sumAux (line 117): 33.9563
## RefGene after update: 1.42777
## Iteration: 246
## RefGene: 16
## RefGene before update: 2.04653
## sumAux (line 117): 33.5274
## RefGene after update: 2.19257
## Iteration: 247
## RefGene: 25
## RefGene before update: 1.68185
## sumAux (line 117): 34.2161
## RefGene after update: 1.10115
## Iteration: 248
## RefGene: 9
## RefGene before update: 1.68626
## sumAux (line 117): 33.842
## RefGene after update: 1.60074
## Iteration: 249
## RefGene: 16
## RefGene before update: 1.68626
## sumAux (line 117): 33.7285
## RefGene after update: 1.7931
## Iteration: 250
## RefGene: 16
## RefGene before update: 2.24158
## sumAux (line 117): 33.7628
## RefGene after update: 1.73259
## Iteration: 251
## RefGene: 25
## RefGene before update: 2.46269
## sumAux (line 117): 34.737
## RefGene after update: 0.654063
## Iteration: 252
## RefGene: 25
## RefGene before update: 2.39036
## sumAux (line 117): 34.6462
## RefGene after update: 0.716251
## Iteration: 253
## RefGene: 17
## RefGene before update: 2.46743
## sumAux (line 117): 33.3664
## RefGene after update: 2.57541
## Iteration: 254
## RefGene: 33
## RefGene before update: 2.46743
## sumAux (line 117): 32.8607
## RefGene after update: 4.2705
## Iteration: 255
## RefGene: 15
## RefGene before update: 2.46743
## sumAux (line 117): 33.0403
## RefGene after update: 3.56855
## Iteration: 256
## RefGene: 9
## RefGene before update: 2.46743
## sumAux (line 117): 33.8601
## RefGene after update: 1.57203
## Iteration: 257
## RefGene: 1
## RefGene before update: 2.00813
## sumAux (line 117): 33.1103
## RefGene after update: 3.32718
## Iteration: 258
## RefGene: 25
## RefGene before update: 3.32718
## sumAux (line 117): 33.845
## RefGene after update: 1.59591
## Iteration: 259
## RefGene: 17
## RefGene before update: 3.22671
## sumAux (line 117): 33.9686
## RefGene after update: 1.41033
## Iteration: 260
## RefGene: 15
## RefGene before update: 3.22671
## sumAux (line 117): 32.7996
## RefGene after update: 4.53986
## Iteration: 261
## RefGene: 33
## RefGene before update: 3.22671
## sumAux (line 117): 33.8021
## RefGene after update: 1.66589
## Iteration: 262
## RefGene: 15
## RefGene before update: 2.57217
## sumAux (line 117): 33.2382
## RefGene after update: 2.92772
## Iteration: 263
## RefGene: 16
## RefGene before update: 2.23019
## sumAux (line 117): 33.646
## RefGene after update: 1.94741
## Iteration: 264
## RefGene: 20
## RefGene before update: 2.0208
## sumAux (line 117): 32.6744
## RefGene after update: 5.14507
## Iteration: 265
## RefGene: 17
## RefGene before update: 2.0208
## sumAux (line 117): 33.3134
## RefGene after update: 2.71576
## Iteration: 266
## RefGene: 3
## RefGene before update: 2.0208
## sumAux (line 117): 34.377
## RefGene after update: 0.937511
## Iteration: 267
## RefGene: 48
## RefGene before update: 1.88688
## sumAux (line 117): 34.1176
## RefGene after update: 1.21507
## Iteration: 268
## RefGene: 9
## RefGene before update: 1.74912
## sumAux (line 117): 33.4343
## RefGene after update: 2.40634
## Iteration: 269
## RefGene: 17
## RefGene before update: 2.01887
## sumAux (line 117): 32.7059
## RefGene after update: 4.98567
## Iteration: 270
## RefGene: 17
## RefGene before update: 2.01887
## sumAux (line 117): 32.7359
## RefGene after update: 4.838
## Iteration: 271
## RefGene: 1
## RefGene before update: 2.01887
## sumAux (line 117): 33.4272
## RefGene after update: 2.42366
## Iteration: 272
## RefGene: 48
## RefGene before update: 2.42366
## sumAux (line 117): 33.5837
## RefGene after update: 2.07248
## Iteration: 273
## RefGene: 48
## RefGene before update: 2.42366
## sumAux (line 117): 33.4315
## RefGene after update: 2.41327
## Iteration: 274
## RefGene: 16
## RefGene before update: 2.42366
## sumAux (line 117): 33.8467
## RefGene after update: 1.59315
## Iteration: 275
## RefGene: 15
## RefGene before update: 1.67975
## sumAux (line 117): 34.3509
## RefGene after update: 0.962261
## Iteration: 276
## RefGene: 20
## RefGene before update: 1.875
## sumAux (line 117): 33.523
## RefGene after update: 2.20219
## Iteration: 277
## RefGene: 48
## RefGene before update: 1.875
## sumAux (line 117): 33.5557
## RefGene after update: 2.13143
## Iteration: 278
## RefGene: 9
## RefGene before update: 1.875
## sumAux (line 117): 33.4234
## RefGene after update: 2.43286
## Iteration: 279
## RefGene: 25
## RefGene before update: 1.94831
## sumAux (line 117): 33.6195
## RefGene after update: 1.99965
## Iteration: 280
## RefGene: 16
## RefGene before update: 1.94831
## sumAux (line 117): 33.8524
## RefGene after update: 1.58418
## Iteration: 281
## RefGene: 1
## RefGene before update: 2.37067
## sumAux (line 117): 33.3528
## RefGene after update: 2.61076
## Iteration: 282
## RefGene: 16
## RefGene before update: 2.61076
## sumAux (line 117): 32.8779
## RefGene after update: 4.19761
## Iteration: 283
## RefGene: 9
## RefGene before update: 2.23131
## sumAux (line 117): 33.194
## RefGene after update: 3.06017
## Iteration: 284
## RefGene: 25
## RefGene before update: 1.80357
## sumAux (line 117): 34.185
## RefGene after update: 1.13593
## Iteration: 285
## RefGene: 25
## RefGene before update: 1.80357
## sumAux (line 117): 34.4264
## RefGene after update: 0.892287
## Iteration: 286
## RefGene: 9
## RefGene before update: 2.16868
## sumAux (line 117): 33.4979
## RefGene after update: 2.25815
## Iteration: 287
## RefGene: 1
## RefGene before update: 1.9101
## sumAux (line 117): 33.56
## RefGene after update: 2.12226
## Iteration: 288
## RefGene: 9
## RefGene before update: 2.12226
## sumAux (line 117): 33.127
## RefGene after update: 3.27211
## Iteration: 289
## RefGene: 9
## RefGene before update: 2.15586
## sumAux (line 117): 33.0016
## RefGene after update: 3.70944
## Iteration: 290
## RefGene: 20
## RefGene before update: 2.15586
## sumAux (line 117): 32.8751
## RefGene after update: 4.20937
## Iteration: 291
## RefGene: 16
## RefGene before update: 2.14063
## sumAux (line 117): 34.0217
## RefGene after update: 1.33737
## Iteration: 292
## RefGene: 3
## RefGene before update: 2.27357
## sumAux (line 117): 33.2473
## RefGene after update: 2.90127
## Iteration: 293
## RefGene: 3
## RefGene before update: 2.27357
## sumAux (line 117): 33.5418
## RefGene after update: 2.16121
## Iteration: 294
## RefGene: 48
## RefGene before update: 1.95637
## sumAux (line 117): 33.8353
## RefGene after update: 1.61142
## Iteration: 295
## RefGene: 16
## RefGene before update: 2.09366
## sumAux (line 117): 32.9194
## RefGene after update: 4.02712
## Iteration: 296
## RefGene: 1
## RefGene before update: 2.09366
## sumAux (line 117): 33.9511
## RefGene after update: 1.43528
## Iteration: 297
## RefGene: 9
## RefGene before update: 1.43528
## sumAux (line 117): 34.0247
## RefGene after update: 1.33338
## Iteration: 298
## RefGene: 9
## RefGene before update: 1.43528
## sumAux (line 117): 34.2519
## RefGene after update: 1.06238
## Iteration: 299
## RefGene: 1
## RefGene before update: 1.48304
## sumAux (line 117): 33.9432
## RefGene after update: 1.44664
## Iteration: 300
## RefGene: 25
## RefGene before update: 1.44664
## sumAux (line 117): 33.5475
## RefGene after update: 2.14886
## Iteration: 301
## RefGene: 25
## RefGene before update: 1.52772
## sumAux (line 117): 33.132
## RefGene after update: 3.25585
## Iteration: 302
## RefGene: 9
## RefGene before update: 1.52772
## sumAux (line 117): 33.603
## RefGene after update: 2.03289
## Iteration: 303
## RefGene: 17
## RefGene before update: 1.52772
## sumAux (line 117): 34.3918
## RefGene after update: 0.923752
## Iteration: 304
## RefGene: 25
## RefGene before update: 1.52772
## sumAux (line 117): 33.3879
## RefGene after update: 2.52066
## Iteration: 305
## RefGene: 9
## RefGene before update: 1.52772
## sumAux (line 117): 33.4549
## RefGene after update: 2.35742
## Iteration: 306
## RefGene: 16
## RefGene before update: 1.52772
## sumAux (line 117): 33.1414
## RefGene after update: 3.22534
## Iteration: 307
## RefGene: 48
## RefGene before update: 1.52752
## sumAux (line 117): 34.428
## RefGene after update: 0.89084
## Iteration: 308
## RefGene: 16
## RefGene before update: 2.00879
## sumAux (line 117): 32.8514
## RefGene after update: 4.31031
## Iteration: 309
## RefGene: 17
## RefGene before update: 2.00879
## sumAux (line 117): 33.1343
## RefGene after update: 3.24826
## Iteration: 310
## RefGene: 16
## RefGene before update: 1.9002
## sumAux (line 117): 32.6922
## RefGene after update: 5.0545
## Iteration: 311
## RefGene: 48
## RefGene before update: 1.87659
## sumAux (line 117): 33.7757
## RefGene after update: 1.71044
## Iteration: 312
## RefGene: 33
## RefGene before update: 1.87659
## sumAux (line 117): 33.7373
## RefGene after update: 1.77745
## Iteration: 313
## RefGene: 15
## RefGene before update: 1.63473
## sumAux (line 117): 34.0319
## RefGene after update: 1.32385
## Iteration: 314
## RefGene: 15
## RefGene before update: 1.63473
## sumAux (line 117): 34.9668
## RefGene after update: 0.519804
## Iteration: 315
## RefGene: 16
## RefGene before update: 1.96027
## sumAux (line 117): 33.0057
## RefGene after update: 3.69431
## Iteration: 316
## RefGene: 15
## RefGene before update: 1.96027
## sumAux (line 117): 33.963
## RefGene after update: 1.41827
## Iteration: 317
## RefGene: 1
## RefGene before update: 1.96027
## sumAux (line 117): 33.9853
## RefGene after update: 1.38703
## Iteration: 318
## RefGene: 17
## RefGene before update: 1.38703
## sumAux (line 117): 33.477
## RefGene after update: 2.30585
## Iteration: 319
## RefGene: 9
## RefGene before update: 1.55437
## sumAux (line 117): 34.4728
## RefGene after update: 0.851812
## Iteration: 320
## RefGene: 17
## RefGene before update: 1.4582
## sumAux (line 117): 33.4547
## RefGene after update: 2.35787
## Iteration: 321
## RefGene: 16
## RefGene before update: 1.46286
## sumAux (line 117): 33.1158
## RefGene after update: 3.30916
## Iteration: 322
## RefGene: 1
## RefGene before update: 1.50184
## sumAux (line 117): 33.3409
## RefGene after update: 2.64208
## Iteration: 323
## RefGene: 25
## RefGene before update: 2.64208
## sumAux (line 117): 32.7788
## RefGene after update: 4.63491
## Iteration: 324
## RefGene: 17
## RefGene before update: 2.27219
## sumAux (line 117): 33.3293
## RefGene after update: 2.67293
## Iteration: 325
## RefGene: 1
## RefGene before update: 2.5014
## sumAux (line 117): 33.0325
## RefGene after update: 3.59657
## Iteration: 326
## RefGene: 15
## RefGene before update: 3.59657
## sumAux (line 117): 33.751
## RefGene after update: 1.75313
## Iteration: 327
## RefGene: 20
## RefGene before update: 3.07313
## sumAux (line 117): 34.1702
## RefGene after update: 1.15292
## Iteration: 328
## RefGene: 25
## RefGene before update: 3.07313
## sumAux (line 117): 32.4541
## RefGene after update: 6.41317
## Iteration: 329
## RefGene: 1
## RefGene before update: 2.56636
## sumAux (line 117): 33.1111
## RefGene after update: 3.32454
## Iteration: 330
## RefGene: 25
## RefGene before update: 3.32454
## sumAux (line 117): 32.8941
## RefGene after update: 4.13037
## Iteration: 331
## RefGene: 9
## RefGene before update: 2.9794
## sumAux (line 117): 32.9704
## RefGene after update: 3.82689
## Iteration: 332
## RefGene: 17
## RefGene before update: 2.9794
## sumAux (line 117): 32.8898
## RefGene after update: 4.1481
## Iteration: 333
## RefGene: 9
## RefGene before update: 2.46587
## sumAux (line 117): 33.1932
## RefGene after update: 3.06258
## Iteration: 334
## RefGene: 20
## RefGene before update: 2.11535
## sumAux (line 117): 34.1435
## RefGene after update: 1.18405
## Iteration: 335
## RefGene: 48
## RefGene before update: 2.11535
## sumAux (line 117): 33.7808
## RefGene after update: 1.70182
## Iteration: 336
## RefGene: 48
## RefGene before update: 2.11535
## sumAux (line 117): 33.3696
## RefGene after update: 2.56728
## Iteration: 337
## RefGene: 17
## RefGene before update: 2.26246
## sumAux (line 117): 33.5803
## RefGene after update: 2.07956
## Iteration: 338
## RefGene: 48
## RefGene before update: 2.52477
## sumAux (line 117): 33.221
## RefGene after update: 2.97873
## Iteration: 339
## RefGene: 15
## RefGene before update: 2.0241
## sumAux (line 117): 34.3495
## RefGene after update: 0.963626
## Iteration: 340
## RefGene: 15
## RefGene before update: 2.04482
## sumAux (line 117): 34.4096
## RefGene after update: 0.907451
## Iteration: 341
## RefGene: 1
## RefGene before update: 2.03391
## sumAux (line 117): 32.4302
## RefGene after update: 6.56816
## Iteration: 342
## RefGene: 48
## RefGene before update: 6.56816
## sumAux (line 117): 34.0472
## RefGene after update: 1.30377
## Iteration: 343
## RefGene: 20
## RefGene before update: 6.56816
## sumAux (line 117): 33.4245
## RefGene after update: 2.43006
## Iteration: 344
## RefGene: 16
## RefGene before update: 6.56816
## sumAux (line 117): 34.2857
## RefGene after update: 1.02708
## Iteration: 345
## RefGene: 33
## RefGene before update: 6.43383
## sumAux (line 117): 34.1586
## RefGene after update: 1.16637
## Iteration: 346
## RefGene: 20
## RefGene before update: 5.9084
## sumAux (line 117): 33.0065
## RefGene after update: 3.69134
## Iteration: 347
## RefGene: 25
## RefGene before update: 5.24001
## sumAux (line 117): 34.2371
## RefGene after update: 1.0783
## Iteration: 348
## RefGene: 9
## RefGene before update: 5.24001
## sumAux (line 117): 33.3642
## RefGene after update: 2.58128
## Iteration: 349
## RefGene: 17
## RefGene before update: 5.24001
## sumAux (line 117): 34.1909
## RefGene after update: 1.12928
## Iteration: 350
## RefGene: 17
## RefGene before update: 5.24001
## sumAux (line 117): 33.892
## RefGene after update: 1.52271
## Iteration: 351
## RefGene: 3
## RefGene before update: 3.92185
## sumAux (line 117): 33.7253
## RefGene after update: 1.79888
## Iteration: 352
## RefGene: 1
## RefGene before update: 3.68113
## sumAux (line 117): 33.0795
## RefGene after update: 3.43121
## Iteration: 353
## RefGene: 3
## RefGene before update: 3.43121
## sumAux (line 117): 34.7471
## RefGene after update: 0.647463
## Iteration: 354
## RefGene: 3
## RefGene before update: 3.19232
## sumAux (line 117): 33.5487
## RefGene after update: 2.14624
## Iteration: 355
## RefGene: 1
## RefGene before update: 3.19232
## sumAux (line 117): 33.3438
## RefGene after update: 2.63443
## Iteration: 356
## RefGene: 3
## RefGene before update: 2.63443
## sumAux (line 117): 33.1374
## RefGene after update: 3.23824
## Iteration: 357
## RefGene: 33
## RefGene before update: 2.69774
## sumAux (line 117): 33.418
## RefGene after update: 2.44588
## Iteration: 358
## RefGene: 1
## RefGene before update: 2.69774
## sumAux (line 117): 33.1298
## RefGene after update: 3.26307
## Iteration: 359
## RefGene: 16
## RefGene before update: 3.26307
## sumAux (line 117): 34.1265
## RefGene after update: 1.20432
## Iteration: 360
## RefGene: 9
## RefGene before update: 3.26123
## sumAux (line 117): 34.2483
## RefGene after update: 1.06621
## Iteration: 361
## RefGene: 16
## RefGene before update: 2.74494
## sumAux (line 117): 33.4632
## RefGene after update: 2.3379
## Iteration: 362
## RefGene: 15
## RefGene before update: 2.74494
## sumAux (line 117): 33.2749
## RefGene after update: 2.82223
## Iteration: 363
## RefGene: 33
## RefGene before update: 2.16046
## sumAux (line 117): 33.1149
## RefGene after update: 3.31189
## Iteration: 364
## RefGene: 17
## RefGene before update: 2.20399
## sumAux (line 117): 32.9816
## RefGene after update: 3.78428
## Iteration: 365
## RefGene: 48
## RefGene before update: 2.21194
## sumAux (line 117): 32.834
## RefGene after update: 4.38601
## Iteration: 366
## RefGene: 1
## RefGene before update: 2.21194
## sumAux (line 117): 33.9468
## RefGene after update: 1.44146
## Iteration: 367
## RefGene: 9
## RefGene before update: 1.44146
## sumAux (line 117): 33.4257
## RefGene after update: 2.42726
## Iteration: 368
## RefGene: 25
## RefGene before update: 1.44146
## sumAux (line 117): 32.9899
## RefGene after update: 3.7531
## Iteration: 369
## RefGene: 1
## RefGene before update: 1.44146
## sumAux (line 117): 34.0885
## RefGene after update: 1.25102
## Iteration: 370
## RefGene: 48
## RefGene before update: 1.25102
## sumAux (line 117): 32.7672
## RefGene after update: 4.68905
## Iteration: 371
## RefGene: 33
## RefGene before update: 1.55658
## sumAux (line 117): 33.312
## RefGene after update: 2.71956
## Iteration: 372
## RefGene: 9
## RefGene before update: 1.97375
## sumAux (line 117): 34.1086
## RefGene after update: 1.22615
## Iteration: 373
## RefGene: 17
## RefGene before update: 1.97375
## sumAux (line 117): 32.7157
## RefGene after update: 4.93703
## Iteration: 374
## RefGene: 15
## RefGene before update: 1.97375
## sumAux (line 117): 34.0719
## RefGene after update: 1.27191
## Iteration: 375
## RefGene: 9
## RefGene before update: 2.04603
## sumAux (line 117): 33.61
## RefGene after update: 2.01869
## Iteration: 376
## RefGene: 17
## RefGene before update: 2.25847
## sumAux (line 117): 33.3023
## RefGene after update: 2.74602
## Iteration: 377
## RefGene: 15
## RefGene before update: 2.25847
## sumAux (line 117): 34.1583
## RefGene after update: 1.16663
## Iteration: 378
## RefGene: 48
## RefGene before update: 2.25847
## sumAux (line 117): 33.3577
## RefGene after update: 2.59793
## Iteration: 379
## RefGene: 20
## RefGene before update: 2.25847
## sumAux (line 117): 31.9264
## RefGene after update: 10.871
## Iteration: 380
## RefGene: 9
## RefGene before update: 2.25847
## sumAux (line 117): 33.7257
## RefGene after update: 1.79811
## Iteration: 381
## RefGene: 25
## RefGene before update: 2.25847
## sumAux (line 117): 33.9045
## RefGene after update: 1.50378
## Iteration: 382
## RefGene: 9
## RefGene before update: 2.25847
## sumAux (line 117): 33.2018
## RefGene after update: 3.03623
## Iteration: 383
## RefGene: 20
## RefGene before update: 2.25847
## sumAux (line 117): 32.3431
## RefGene after update: 7.16617
## Iteration: 384
## RefGene: 48
## RefGene before update: 2.25847
## sumAux (line 117): 33.0228
## RefGene after update: 3.63149
## Iteration: 385
## RefGene: 17
## RefGene before update: 2.25847
## sumAux (line 117): 33.4956
## RefGene after update: 2.26337
## Iteration: 386
## RefGene: 17
## RefGene before update: 2.25847
## sumAux (line 117): 33.104
## RefGene after update: 3.34833
## Iteration: 387
## RefGene: 20
## RefGene before update: 1.95482
## sumAux (line 117): 32.676
## RefGene after update: 5.13671
## Iteration: 388
## RefGene: 15
## RefGene before update: 1.95482
## sumAux (line 117): 32.9439
## RefGene after update: 3.92974
## Iteration: 389
## RefGene: 17
## RefGene before update: 1.95482
## sumAux (line 117): 33.2182
## RefGene after update: 2.98707
## Iteration: 390
## RefGene: 16
## RefGene before update: 1.69245
## sumAux (line 117): 33.6921
## RefGene after update: 1.85959
## Iteration: 391
## RefGene: 16
## RefGene before update: 1.69245
## sumAux (line 117): 33.7792
## RefGene after update: 1.70451
## Iteration: 392
## RefGene: 48
## RefGene before update: 1.69245
## sumAux (line 117): 34.205
## RefGene after update: 1.1134
## Iteration: 393
## RefGene: 20
## RefGene before update: 1.91663
## sumAux (line 117): 32.8789
## RefGene after update: 4.19348
## Iteration: 394
## RefGene: 9
## RefGene before update: 1.80282
## sumAux (line 117): 33.0668
## RefGene after update: 3.47509
## Iteration: 395
## RefGene: 16
## RefGene before update: 2.16104
## sumAux (line 117): 34.1063
## RefGene after update: 1.22897
## Iteration: 396
## RefGene: 48
## RefGene before update: 2.62437
## sumAux (line 117): 33.9654
## RefGene after update: 1.41487
## Iteration: 397
## RefGene: 15
## RefGene before update: 2.62437
## sumAux (line 117): 34.7116
## RefGene after update: 0.670921
## Iteration: 398
## RefGene: 20
## RefGene before update: 2.62437
## sumAux (line 117): 33.2252
## RefGene after update: 2.96598
## Iteration: 399
## RefGene: 25
## RefGene before update: 2.49622
## sumAux (line 117): 33.3296
## RefGene after update: 2.67215
## Iteration: 400
## RefGene: 1
## RefGene before update: 2.49622
## sumAux (line 117): 33.0659
## RefGene after update: 3.47847
## Iteration: 401
## RefGene: 17
## RefGene before update: 3.47847
## sumAux (line 117): 33.3013
## RefGene after update: 2.74868
## Iteration: 402
## RefGene: 48
## RefGene before update: 3.61419
## sumAux (line 117): 33.7806
## RefGene after update: 1.70214
## Iteration: 403
## RefGene: 15
## RefGene before update: 2.84674
## sumAux (line 117): 34.4965
## RefGene after update: 0.831893
## Iteration: 404
## RefGene: 9
## RefGene before update: 2.84674
## sumAux (line 117): 33.6832
## RefGene after update: 1.87612
## Iteration: 405
## RefGene: 17
## RefGene before update: 2.84674
## sumAux (line 117): 32.951
## RefGene after update: 3.90187
## Iteration: 406
## RefGene: 16
## RefGene before update: 2.65676
## sumAux (line 117): 33.8074
## RefGene after update: 1.65707
## Iteration: 407
## RefGene: 17
## RefGene before update: 2.65676
## sumAux (line 117): 33.2751
## RefGene after update: 2.8217
## Iteration: 408
## RefGene: 15
## RefGene before update: 2.65676
## sumAux (line 117): 33.2725
## RefGene after update: 2.82907
## Iteration: 409
## RefGene: 3
## RefGene before update: 2.65676
## sumAux (line 117): 33.6704
## RefGene after update: 1.90035
## Iteration: 410
## RefGene: 1
## RefGene before update: 2.05307
## sumAux (line 117): 33.0249
## RefGene after update: 3.62407
## Iteration: 411
## RefGene: 20
## RefGene before update: 3.62407
## sumAux (line 117): 32.9575
## RefGene after update: 3.87666
## Iteration: 412
## RefGene: 1
## RefGene before update: 3.62407
## sumAux (line 117): 33.2774
## RefGene after update: 2.81521
## Iteration: 413
## RefGene: 3
## RefGene before update: 2.81521
## sumAux (line 117): 33.3721
## RefGene after update: 2.56085
## Iteration: 414
## RefGene: 15
## RefGene before update: 2.65313
## sumAux (line 117): 33.8601
## RefGene after update: 1.57203
## Iteration: 415
## RefGene: 25
## RefGene before update: 2.2231
## sumAux (line 117): 33.5045
## RefGene after update: 2.24334
## Iteration: 416
## RefGene: 48
## RefGene before update: 2.2231
## sumAux (line 117): 33.6446
## RefGene after update: 1.94996
## Iteration: 417
## RefGene: 1
## RefGene before update: 2.2231
## sumAux (line 117): 33.5372
## RefGene after update: 2.17113
## Iteration: 418
## RefGene: 15
## RefGene before update: 2.17113
## sumAux (line 117): 33.2543
## RefGene after update: 2.88103
## Iteration: 419
## RefGene: 33
## RefGene before update: 1.92078
## sumAux (line 117): 34.5113
## RefGene after update: 0.819656
## Iteration: 420
## RefGene: 15
## RefGene before update: 1.92078
## sumAux (line 117): 32.9531
## RefGene after update: 3.89365
## Iteration: 421
## RefGene: 3
## RefGene before update: 1.92078
## sumAux (line 117): 34.2563
## RefGene after update: 1.05774
## Iteration: 422
## RefGene: 3
## RefGene before update: 1.92078
## sumAux (line 117): 34.5593
## RefGene after update: 0.781253
## Iteration: 423
## RefGene: 15
## RefGene before update: 1.98823
## sumAux (line 117): 33.3501
## RefGene after update: 2.61794
## Iteration: 424
## RefGene: 9
## RefGene before update: 1.98823
## sumAux (line 117): 32.1972
## RefGene after update: 8.29191
## Iteration: 425
## RefGene: 15
## RefGene before update: 2.13425
## sumAux (line 117): 33.0971
## RefGene after update: 3.37136
## Iteration: 426
## RefGene: 25
## RefGene before update: 2.13425
## sumAux (line 117): 32.8982
## RefGene after update: 4.11356
## Iteration: 427
## RefGene: 48
## RefGene before update: 2.13425
## sumAux (line 117): 33.7008
## RefGene after update: 1.84346
## Iteration: 428
## RefGene: 33
## RefGene before update: 2.13425
## sumAux (line 117): 34.4885
## RefGene after update: 0.838535
## Iteration: 429
## RefGene: 33
## RefGene before update: 2.13425
## sumAux (line 117): 34.688
## RefGene after update: 0.686892
## Iteration: 430
## RefGene: 1
## RefGene before update: 2.32153
## sumAux (line 117): 33.8373
## RefGene after update: 1.6082
## Iteration: 431
## RefGene: 25
## RefGene before update: 1.6082
## sumAux (line 117): 33.2211
## RefGene after update: 2.97823
## Iteration: 432
## RefGene: 9
## RefGene before update: 2.07653
## sumAux (line 117): 32.5732
## RefGene after update: 5.69302
## Iteration: 433
## RefGene: 20
## RefGene before update: 2.07653
## sumAux (line 117): 34.575
## RefGene after update: 0.769077
## Iteration: 434
## RefGene: 15
## RefGene before update: 2.07653
## sumAux (line 117): 33.814
## RefGene after update: 1.64613
## Iteration: 435
## RefGene: 9
## RefGene before update: 2.07653
## sumAux (line 117): 32.199
## RefGene after update: 8.27677
## Iteration: 436
## RefGene: 3
## RefGene before update: 1.94827
## sumAux (line 117): 33.4064
## RefGene after update: 2.47461
## Iteration: 437
## RefGene: 15
## RefGene before update: 1.95793
## sumAux (line 117): 33.3079
## RefGene after update: 2.73058
## Iteration: 438
## RefGene: 1
## RefGene before update: 2.23065
## sumAux (line 117): 32.4099
## RefGene after update: 6.70277
## Iteration: 439
## RefGene: 20
## RefGene before update: 6.70277
## sumAux (line 117): 34.9487
## RefGene after update: 0.529284
## Iteration: 440
## RefGene: 16
## RefGene before update: 6.70277
## sumAux (line 117): 34.1819
## RefGene after update: 1.13943
## Iteration: 441
## RefGene: 3
## RefGene before update: 6.70277
## sumAux (line 117): 33.5552
## RefGene after update: 2.13249
## Iteration: 442
## RefGene: 16
## RefGene before update: 6.70277
## sumAux (line 117): 33.3084
## RefGene after update: 2.72935
## Iteration: 443
## RefGene: 25
## RefGene before update: 6.70277
## sumAux (line 117): 32.7061
## RefGene after update: 4.9844
## Iteration: 444
## RefGene: 20
## RefGene before update: 6.70277
## sumAux (line 117): 34.5995
## RefGene after update: 0.750442
## Iteration: 445
## RefGene: 1
## RefGene before update: 5.06546
## sumAux (line 117): 33.4831
## RefGene after update: 2.29191
## Iteration: 446
## RefGene: 33
## RefGene before update: 2.29191
## sumAux (line 117): 34.1669
## RefGene after update: 1.15663
## Iteration: 447
## RefGene: 3
## RefGene before update: 2.29191
## sumAux (line 117): 33.7089
## RefGene after update: 1.82857
## Iteration: 448
## RefGene: 1
## RefGene before update: 1.99976
## sumAux (line 117): 33.7981
## RefGene after update: 1.67263
## Iteration: 449
## RefGene: 15
## RefGene before update: 1.67263
## sumAux (line 117): 33.9381
## RefGene after update: 1.45409
## Iteration: 450
## RefGene: 48
## RefGene before update: 1.8507
## sumAux (line 117): 34.725
## RefGene after update: 0.661975
## Iteration: 451
## RefGene: 25
## RefGene before update: 2.60134
## sumAux (line 117): 33.2758
## RefGene after update: 2.81984
## Iteration: 452
## RefGene: 3
## RefGene before update: 2.47138
## sumAux (line 117): 32.92
## RefGene after update: 4.02457
## Iteration: 453
## RefGene: 9
## RefGene before update: 2.40256
## sumAux (line 117): 33.7667
## RefGene after update: 1.72592
## Iteration: 454
## RefGene: 1
## RefGene before update: 2.40256
## sumAux (line 117): 32.9048
## RefGene after update: 4.0865
## Iteration: 455
## RefGene: 17
## RefGene before update: 4.0865
## sumAux (line 117): 32.7758
## RefGene after update: 4.64883
## Iteration: 456
## RefGene: 15
## RefGene before update: 4.0865
## sumAux (line 117): 34.1304
## RefGene after update: 1.19967
## Iteration: 457
## RefGene: 3
## RefGene before update: 4.0865
## sumAux (line 117): 33.8262
## RefGene after update: 1.62616
## Iteration: 458
## RefGene: 25
## RefGene before update: 4.0865
## sumAux (line 117): 33.473
## RefGene after update: 2.31513
## Iteration: 459
## RefGene: 3
## RefGene before update: 3.47798
## sumAux (line 117): 32.8967
## RefGene after update: 4.11976
## Iteration: 460
## RefGene: 33
## RefGene before update: 3.15439
## sumAux (line 117): 33.5083
## RefGene after update: 2.23474
## Iteration: 461
## RefGene: 20
## RefGene before update: 3.15439
## sumAux (line 117): 33.3292
## RefGene after update: 2.67322
## Iteration: 462
## RefGene: 1
## RefGene before update: 3.08354
## sumAux (line 117): 33.201
## RefGene after update: 3.0388
## Iteration: 463
## RefGene: 20
## RefGene before update: 3.0388
## sumAux (line 117): 32.8619
## RefGene after update: 4.2656
## Iteration: 464
## RefGene: 33
## RefGene before update: 2.73901
## sumAux (line 117): 32.6362
## RefGene after update: 5.34549
## Iteration: 465
## RefGene: 48
## RefGene before update: 2.73029
## sumAux (line 117): 34.6146
## RefGene after update: 0.73923
## Iteration: 466
## RefGene: 25
## RefGene before update: 2.73029
## sumAux (line 117): 33.9706
## RefGene after update: 1.40756
## Iteration: 467
## RefGene: 17
## RefGene before update: 2.57896
## sumAux (line 117): 34.3529
## RefGene after update: 0.960397
## Iteration: 468
## RefGene: 48
## RefGene before update: 2.57896
## sumAux (line 117): 33.4897
## RefGene after update: 2.2767
## Iteration: 469
## RefGene: 1
## RefGene before update: 2.45348
## sumAux (line 117): 33.1457
## RefGene after update: 3.21157
## Iteration: 470
## RefGene: 9
## RefGene before update: 3.21157
## sumAux (line 117): 34.1243
## RefGene after update: 1.207
## Iteration: 471
## RefGene: 1
## RefGene before update: 3.20042
## sumAux (line 117): 33.8259
## RefGene after update: 1.62677
## Iteration: 472
## RefGene: 16
## RefGene before update: 1.62677
## sumAux (line 117): 32.6436
## RefGene after update: 5.30626
## Iteration: 473
## RefGene: 16
## RefGene before update: 2.15926
## sumAux (line 117): 33.2413
## RefGene after update: 2.91869
## Iteration: 474
## RefGene: 15
## RefGene before update: 2.15926
## sumAux (line 117): 33.5953
## RefGene after update: 2.04858
## Iteration: 475
## RefGene: 16
## RefGene before update: 2.15926
## sumAux (line 117): 33.5154
## RefGene after update: 2.21888
## Iteration: 476
## RefGene: 15
## RefGene before update: 2.15926
## sumAux (line 117): 32.702
## RefGene after update: 5.00493
## Iteration: 477
## RefGene: 20
## RefGene before update: 1.98748
## sumAux (line 117): 33.1164
## RefGene after update: 3.3071
## Iteration: 478
## RefGene: 15
## RefGene before update: 1.98748
## sumAux (line 117): 34.2691
## RefGene after update: 1.04429
## Iteration: 479
## RefGene: 20
## RefGene before update: 2.27636
## sumAux (line 117): 33.6572
## RefGene after update: 1.92554
## Iteration: 480
## RefGene: 3
## RefGene before update: 2.27636
## sumAux (line 117): 33.5827
## RefGene after update: 2.07452
## Iteration: 481
## RefGene: 33
## RefGene before update: 1.95049
## sumAux (line 117): 33.3245
## RefGene after update: 2.6857
## Iteration: 482
## RefGene: 48
## RefGene before update: 1.95049
## sumAux (line 117): 33.7583
## RefGene after update: 1.74051
## Iteration: 483
## RefGene: 16
## RefGene before update: 2.17141
## sumAux (line 117): 33.7036
## RefGene after update: 1.8384
## Iteration: 484
## RefGene: 9
## RefGene before update: 1.71061
## sumAux (line 117): 32.9349
## RefGene after update: 3.96511
## Iteration: 485
## RefGene: 3
## RefGene before update: 1.92232
## sumAux (line 117): 33.9671
## RefGene after update: 1.41253
## Iteration: 486
## RefGene: 33
## RefGene before update: 1.94524
## sumAux (line 117): 33.61
## RefGene after update: 2.01867
## Iteration: 487
## RefGene: 16
## RefGene before update: 1.94282
## sumAux (line 117): 34.1329
## RefGene after update: 1.19674
## Iteration: 488
## RefGene: 3
## RefGene before update: 2.06514
## sumAux (line 117): 33.0025
## RefGene after update: 3.70591
## Iteration: 489
## RefGene: 20
## RefGene before update: 2.06514
## sumAux (line 117): 33.6428
## RefGene after update: 1.95348
## Iteration: 490
## RefGene: 48
## RefGene before update: 1.8765
## sumAux (line 117): 32.1799
## RefGene after update: 8.43612
## Iteration: 491
## RefGene: 33
## RefGene before update: 1.8765
## sumAux (line 117): 33.0079
## RefGene after update: 3.68606
## Iteration: 492
## RefGene: 3
## RefGene before update: 1.8765
## sumAux (line 117): 33.0385
## RefGene after update: 3.57492
## Iteration: 493
## RefGene: 25
## RefGene before update: 2.26988
## sumAux (line 117): 33.0589
## RefGene after update: 3.50264
## Iteration: 494
## RefGene: 16
## RefGene before update: 2.26988
## sumAux (line 117): 34.6911
## RefGene after update: 0.684798
## Iteration: 495
## RefGene: 20
## RefGene before update: 2.42198
## sumAux (line 117): 33.425
## RefGene after update: 2.42901
## Iteration: 496
## RefGene: 17
## RefGene before update: 2.21347
## sumAux (line 117): 32.5305
## RefGene after update: 5.94123
## Iteration: 497
## RefGene: 3
## RefGene before update: 2.08869
## sumAux (line 117): 33.3726
## RefGene after update: 2.55947
## Iteration: 498
## RefGene: 33
## RefGene before update: 2.08869
## sumAux (line 117): 33.8845
## RefGene after update: 1.53416
## Iteration: 499
## RefGene: 48
## RefGene before update: 2.08869
## sumAux (line 117): 32.0077
## RefGene after update: 10.022
## -----------------------------------------------------
## End of Burn-in period.
## -----------------------------------------------------
## Iteration: 500
## RefGene: 17
## RefGene before update: 2.25833
## sumAux (line 117): 34.0618
## RefGene after update: 1.2848
## Iteration: 501
## RefGene: 33
## RefGene before update: 2.25833
## sumAux (line 117): 33.6411
## RefGene after update: 1.95689
## Iteration: 502
## RefGene: 48
## RefGene before update: 2.25833
## sumAux (line 117): 32.6969
## RefGene after update: 5.03076
## Iteration: 503
## RefGene: 15
## RefGene before update: 2.03374
## sumAux (line 117): 33.3568
## RefGene after update: 2.60023
## Iteration: 504
## RefGene: 1
## RefGene before update: 2.03374
## sumAux (line 117): 33.1432
## RefGene after update: 3.21971
## Iteration: 505
## RefGene: 3
## RefGene before update: 3.21971
## sumAux (line 117): 33.2056
## RefGene after update: 3.02468
## Iteration: 506
## RefGene: 16
## RefGene before update: 2.96647
## sumAux (line 117): 33.2242
## RefGene after update: 2.96921
## Iteration: 507
## RefGene: 15
## RefGene before update: 2.96647
## sumAux (line 117): 33.0986
## RefGene after update: 3.3664
## Iteration: 508
## RefGene: 15
## RefGene before update: 2.89436
## sumAux (line 117): 32.7072
## RefGene after update: 4.97932
## Iteration: 509
## RefGene: 33
## RefGene before update: 2.73936
## sumAux (line 117): 33.9145
## RefGene after update: 1.48875
## Iteration: 510
## RefGene: 33
## RefGene before update: 2.39664
## sumAux (line 117): 34.0122
## RefGene after update: 1.35022
## Iteration: 511
## RefGene: 15
## RefGene before update: 2.56331
## sumAux (line 117): 32.2053
## RefGene after update: 8.22455
## Iteration: 512
## RefGene: 25
## RefGene before update: 2.56331
## sumAux (line 117): 34.434
## RefGene after update: 0.885566
## Iteration: 513
## RefGene: 20
## RefGene before update: 2.56331
## sumAux (line 117): 33.9863
## RefGene after update: 1.38567
## Iteration: 514
## RefGene: 16
## RefGene before update: 2.56331
## sumAux (line 117): 33.1581
## RefGene after update: 3.17189
## Iteration: 515
## RefGene: 17
## RefGene before update: 2.56331
## sumAux (line 117): 34.3518
## RefGene after update: 0.961434
## Iteration: 516
## RefGene: 17
## RefGene before update: 2.56331
## sumAux (line 117): 34.5364
## RefGene after update: 0.799344
## Iteration: 517
## RefGene: 17
## RefGene before update: 2.2904
## sumAux (line 117): 35.2713
## RefGene after update: 0.383322
## Iteration: 518
## RefGene: 15
## RefGene before update: 2.2904
## sumAux (line 117): 31.9304
## RefGene after update: 10.827
## Iteration: 519
## RefGene: 16
## RefGene before update: 2.2904
## sumAux (line 117): 33.2002
## RefGene after update: 3.04127
## Iteration: 520
## RefGene: 16
## RefGene before update: 2.2904
## sumAux (line 117): 33.4038
## RefGene after update: 2.48095
## Iteration: 521
## RefGene: 48
## RefGene before update: 2.2904
## sumAux (line 117): 33.7505
## RefGene after update: 1.75409
## Iteration: 522
## RefGene: 9
## RefGene before update: 2.2904
## sumAux (line 117): 33.9851
## RefGene after update: 1.38724
## Iteration: 523
## RefGene: 25
## RefGene before update: 2.2904
## sumAux (line 117): 34.0107
## RefGene after update: 1.35228
## Iteration: 524
## RefGene: 25
## RefGene before update: 2.04028
## sumAux (line 117): 34.3976
## RefGene after update: 0.918369
## Iteration: 525
## RefGene: 20
## RefGene before update: 2.16975
## sumAux (line 117): 32.8101
## RefGene after update: 4.49218
## Iteration: 526
## RefGene: 1
## RefGene before update: 2.16975
## sumAux (line 117): 32.63
## RefGene after update: 5.37867
## Iteration: 527
## RefGene: 17
## RefGene before update: 5.37867
## sumAux (line 117): 34.2482
## RefGene after update: 1.06638
## Iteration: 528
## RefGene: 15
## RefGene before update: 4.37813
## sumAux (line 117): 32.5154
## RefGene after update: 6.03165
## Iteration: 529
## RefGene: 3
## RefGene before update: 4.37813
## sumAux (line 117): 33.3541
## RefGene after update: 2.60742
## Iteration: 530
## RefGene: 1
## RefGene before update: 4.37813
## sumAux (line 117): 33.5007
## RefGene after update: 2.25191
## Iteration: 531
## RefGene: 20
## RefGene before update: 2.25191
## sumAux (line 117): 33.0142
## RefGene after update: 3.66301
## Iteration: 532
## RefGene: 16
## RefGene before update: 1.87977
## sumAux (line 117): 34.0282
## RefGene after update: 1.32874
## Iteration: 533
## RefGene: 17
## RefGene before update: 1.88257
## sumAux (line 117): 33.9175
## RefGene after update: 1.48438
## Iteration: 534
## RefGene: 1
## RefGene before update: 1.88257
## sumAux (line 117): 32.9056
## RefGene after update: 4.0832
## Iteration: 535
## RefGene: 25
## RefGene before update: 4.0832
## sumAux (line 117): 34.0129
## RefGene after update: 1.34924
## Iteration: 536
## RefGene: 3
## RefGene before update: 4.0832
## sumAux (line 117): 33.0678
## RefGene after update: 3.47186
## Iteration: 537
## RefGene: 9
## RefGene before update: 4.0832
## sumAux (line 117): 34.5407
## RefGene after update: 0.795931
## Iteration: 538
## RefGene: 16
## RefGene before update: 2.95133
## sumAux (line 117): 32.8294
## RefGene after update: 4.40647
## Iteration: 539
## RefGene: 3
## RefGene before update: 2.54441
## sumAux (line 117): 32.7903
## RefGene after update: 4.58209
## Iteration: 540
## RefGene: 17
## RefGene before update: 2.12358
## sumAux (line 117): 33.4796
## RefGene after update: 2.29985
## Iteration: 541
## RefGene: 48
## RefGene before update: 2.12358
## sumAux (line 117): 33.8268
## RefGene after update: 1.62518
## Iteration: 542
## RefGene: 16
## RefGene before update: 2.12358
## sumAux (line 117): 34.6089
## RefGene after update: 0.743453
## Iteration: 543
## RefGene: 16
## RefGene before update: 1.86888
## sumAux (line 117): 33.9582
## RefGene after update: 1.42512
## Iteration: 544
## RefGene: 17
## RefGene before update: 1.86888
## sumAux (line 117): 32.5204
## RefGene after update: 6.00165
## Iteration: 545
## RefGene: 33
## RefGene before update: 1.86888
## sumAux (line 117): 33.4773
## RefGene after update: 2.30517
## Iteration: 546
## RefGene: 33
## RefGene before update: 1.86888
## sumAux (line 117): 33.4769
## RefGene after update: 2.30603
## Iteration: 547
## RefGene: 20
## RefGene before update: 1.86888
## sumAux (line 117): 33.3628
## RefGene after update: 2.58486
## Iteration: 548
## RefGene: 17
## RefGene before update: 1.86888
## sumAux (line 117): 34.0741
## RefGene after update: 1.26918
## Iteration: 549
## RefGene: 33
## RefGene before update: 1.86888
## sumAux (line 117): 34.1013
## RefGene after update: 1.2351
## Iteration: 550
## RefGene: 33
## RefGene before update: 1.86888
## sumAux (line 117): 33.2783
## RefGene after update: 2.81274
## Iteration: 551
## RefGene: 25
## RefGene before update: 1.86888
## sumAux (line 117): 32.9372
## RefGene after update: 3.95605
## Iteration: 552
## RefGene: 9
## RefGene before update: 1.86888
## sumAux (line 117): 33.1681
## RefGene after update: 3.14037
## Iteration: 553
## RefGene: 9
## RefGene before update: 1.99831
## sumAux (line 117): 33.789
## RefGene after update: 1.68786
## Iteration: 554
## RefGene: 20
## RefGene before update: 1.99831
## sumAux (line 117): 33.9467
## RefGene after update: 1.44159
## Iteration: 555
## RefGene: 17
## RefGene before update: 1.88219
## sumAux (line 117): 33.6973
## RefGene after update: 1.84994
## Iteration: 556
## RefGene: 33
## RefGene before update: 1.88219
## sumAux (line 117): 34.1399
## RefGene after update: 1.18837
## Iteration: 557
## RefGene: 17
## RefGene before update: 1.88219
## sumAux (line 117): 33.3682
## RefGene after update: 2.57089
## Iteration: 558
## RefGene: 48
## RefGene before update: 1.88219
## sumAux (line 117): 34.4007
## RefGene after update: 0.915501
## Iteration: 559
## RefGene: 48
## RefGene before update: 2.04152
## sumAux (line 117): 33.829
## RefGene after update: 1.62167
## Iteration: 560
## RefGene: 20
## RefGene before update: 2.03913
## sumAux (line 117): 33.6115
## RefGene after update: 2.01576
## Iteration: 561
## RefGene: 17
## RefGene before update: 2.03913
## sumAux (line 117): 33.5437
## RefGene after update: 2.15705
## Iteration: 562
## RefGene: 33
## RefGene before update: 2.24627
## sumAux (line 117): 33.4526
## RefGene after update: 2.3629
## Iteration: 563
## RefGene: 9
## RefGene before update: 2.24627
## sumAux (line 117): 34.0984
## RefGene after update: 1.23875
## Iteration: 564
## RefGene: 1
## RefGene before update: 1.76542
## sumAux (line 117): 33.7085
## RefGene after update: 1.82941
## Iteration: 565
## RefGene: 48
## RefGene before update: 1.82941
## sumAux (line 117): 33.3994
## RefGene after update: 2.49193
## Iteration: 566
## RefGene: 20
## RefGene before update: 1.82941
## sumAux (line 117): 33.6381
## RefGene after update: 1.96269
## Iteration: 567
## RefGene: 1
## RefGene before update: 2.07687
## sumAux (line 117): 33.145
## RefGene after update: 3.21369
## Iteration: 568
## RefGene: 3
## RefGene before update: 3.21369
## sumAux (line 117): 33.5014
## RefGene after update: 2.25029
## Iteration: 569
## RefGene: 16
## RefGene before update: 3.21369
## sumAux (line 117): 33.2218
## RefGene after update: 2.97614
## Iteration: 570
## RefGene: 15
## RefGene before update: 2.40351
## sumAux (line 117): 33.0404
## RefGene after update: 3.56808
## Iteration: 571
## RefGene: 16
## RefGene before update: 2.40351
## sumAux (line 117): 33.9146
## RefGene after update: 1.4886
## Iteration: 572
## RefGene: 15
## RefGene before update: 2.30053
## sumAux (line 117): 33.6461
## RefGene after update: 1.9472
## Iteration: 573
## RefGene: 17
## RefGene before update: 1.99187
## sumAux (line 117): 33.3407
## RefGene after update: 2.64257
## Iteration: 574
## RefGene: 16
## RefGene before update: 1.96924
## sumAux (line 117): 33.9326
## RefGene after update: 1.46202
## Iteration: 575
## RefGene: 9
## RefGene before update: 2.05194
## sumAux (line 117): 34.3176
## RefGene after update: 0.994863
## Iteration: 576
## RefGene: 16
## RefGene before update: 2.05194
## sumAux (line 117): 33.1272
## RefGene after update: 3.27153
## Iteration: 577
## RefGene: 17
## RefGene before update: 2.05194
## sumAux (line 117): 33.8545
## RefGene after update: 1.58084
## Iteration: 578
## RefGene: 16
## RefGene before update: 1.86186
## sumAux (line 117): 33.699
## RefGene after update: 1.84677
## Iteration: 579
## RefGene: 33
## RefGene before update: 1.86186
## sumAux (line 117): 33.3792
## RefGene after update: 2.54271
## Iteration: 580
## RefGene: 1
## RefGene before update: 1.83256
## sumAux (line 117): 33.547
## RefGene after update: 2.14996
## Iteration: 581
## RefGene: 48
## RefGene before update: 2.14996
## sumAux (line 117): 32.9661
## RefGene after update: 3.84344
## Iteration: 582
## RefGene: 9
## RefGene before update: 2.14996
## sumAux (line 117): 34.0643
## RefGene after update: 1.28163
## Iteration: 583
## RefGene: 33
## RefGene before update: 2.14996
## sumAux (line 117): 33.0329
## RefGene after update: 3.59496
## Iteration: 584
## RefGene: 17
## RefGene before update: 2.14996
## sumAux (line 117): 33.3379
## RefGene after update: 2.65
## Iteration: 585
## RefGene: 9
## RefGene before update: 1.70653
## sumAux (line 117): 34.0349
## RefGene after update: 1.31994
## Iteration: 586
## RefGene: 3
## RefGene before update: 2.27404
## sumAux (line 117): 33.1308
## RefGene after update: 3.25972
## Iteration: 587
## RefGene: 17
## RefGene before update: 1.89965
## sumAux (line 117): 33.1545
## RefGene after update: 3.1835
## Iteration: 588
## RefGene: 25
## RefGene before update: 2.08662
## sumAux (line 117): 33.7342
## RefGene after update: 1.7829
## Iteration: 589
## RefGene: 33
## RefGene before update: 2.08662
## sumAux (line 117): 33.9095
## RefGene after update: 1.49626
## Iteration: 590
## RefGene: 1
## RefGene before update: 2.08662
## sumAux (line 117): 32.7224
## RefGene after update: 4.90414
## Iteration: 591
## RefGene: 20
## RefGene before update: 4.90414
## sumAux (line 117): 33.8367
## RefGene after update: 1.6093
## Iteration: 592
## RefGene: 3
## RefGene before update: 4.90414
## sumAux (line 117): 33.9343
## RefGene after update: 1.45954
## Iteration: 593
## RefGene: 9
## RefGene before update: 4.90414
## sumAux (line 117): 33.3004
## RefGene after update: 2.75122
## Iteration: 594
## RefGene: 1
## RefGene before update: 4.90414
## sumAux (line 117): 32.763
## RefGene after update: 4.70886
## Iteration: 595
## RefGene: 9
## RefGene before update: 4.70886
## sumAux (line 117): 32.9939
## RefGene after update: 3.73791
## Iteration: 596
## RefGene: 48
## RefGene before update: 3.7025
## sumAux (line 117): 34.0305
## RefGene after update: 1.32575
## Iteration: 597
## RefGene: 3
## RefGene before update: 3.7025
## sumAux (line 117): 34.1138
## RefGene after update: 1.21981
## Iteration: 598
## RefGene: 48
## RefGene before update: 3.02517
## sumAux (line 117): 32.7192
## RefGene after update: 4.91965
## Iteration: 599
## RefGene: 9
## RefGene before update: 2.40616
## sumAux (line 117): 33.7907
## RefGene after update: 1.68497
## Iteration: 600
## RefGene: 33
## RefGene before update: 2.40616
## sumAux (line 117): 34.9385
## RefGene after update: 0.534681
## Iteration: 601
## RefGene: 33
## RefGene before update: 2.40616
## sumAux (line 117): 33.4071
## RefGene after update: 2.47285
## Iteration: 602
## RefGene: 9
## RefGene before update: 2.40616
## sumAux (line 117): 33.7835
## RefGene after update: 1.69716
## Iteration: 603
## RefGene: 25
## RefGene before update: 2.40616
## sumAux (line 117): 33.222
## RefGene after update: 2.97554
## Iteration: 604
## RefGene: 9
## RefGene before update: 2.40616
## sumAux (line 117): 33.3316
## RefGene after update: 2.6666
## Iteration: 605
## RefGene: 15
## RefGene before update: 2.40616
## sumAux (line 117): 32.7597
## RefGene after update: 4.72452
## Iteration: 606
## RefGene: 48
## RefGene before update: 1.91888
## sumAux (line 117): 33.5875
## RefGene after update: 2.06467
## Iteration: 607
## RefGene: 16
## RefGene before update: 2.05193
## sumAux (line 117): 33.6605
## RefGene after update: 1.91925
## Iteration: 608
## RefGene: 20
## RefGene before update: 2.05193
## sumAux (line 117): 33.9432
## RefGene after update: 1.44666
## Iteration: 609
## RefGene: 25
## RefGene before update: 2.05193
## sumAux (line 117): 32.5828
## RefGene after update: 5.63861
## Iteration: 610
## RefGene: 17
## RefGene before update: 2.05193
## sumAux (line 117): 32.9591
## RefGene after update: 3.87053
## Iteration: 611
## RefGene: 17
## RefGene before update: 2.05193
## sumAux (line 117): 33.4897
## RefGene after update: 2.27675
## Iteration: 612
## RefGene: 3
## RefGene before update: 2.05193
## sumAux (line 117): 34.058
## RefGene after update: 1.28969
## Iteration: 613
## RefGene: 15
## RefGene before update: 1.94645
## sumAux (line 117): 31.9807
## RefGene after update: 10.2963
## Iteration: 614
## RefGene: 25
## RefGene before update: 1.86486
## sumAux (line 117): 33.9344
## RefGene after update: 1.45948
## Iteration: 615
## RefGene: 3
## RefGene before update: 1.86486
## sumAux (line 117): 33.6146
## RefGene after update: 2.0094
## Iteration: 616
## RefGene: 17
## RefGene before update: 1.86486
## sumAux (line 117): 33.8808
## RefGene after update: 1.53981
## Iteration: 617
## RefGene: 1
## RefGene before update: 1.86486
## sumAux (line 117): 33.8673
## RefGene after update: 1.56065
## Iteration: 618
## RefGene: 17
## RefGene before update: 1.56065
## sumAux (line 117): 32.7557
## RefGene after update: 4.74354
## Iteration: 619
## RefGene: 33
## RefGene before update: 2.53424
## sumAux (line 117): 33.532
## RefGene after update: 2.18247
## Iteration: 620
## RefGene: 25
## RefGene before update: 2.53424
## sumAux (line 117): 34.5275
## RefGene after update: 0.806507
## Iteration: 621
## RefGene: 9
## RefGene before update: 2.45917
## sumAux (line 117): 33.5132
## RefGene after update: 2.2238
## Iteration: 622
## RefGene: 9
## RefGene before update: 2.45917
## sumAux (line 117): 33.3586
## RefGene after update: 2.59578
## Iteration: 623
## RefGene: 20
## RefGene before update: 1.84297
## sumAux (line 117): 33.5405
## RefGene after update: 2.16402
## Iteration: 624
## RefGene: 1
## RefGene before update: 1.87178
## sumAux (line 117): 33.4164
## RefGene after update: 2.44998
## Iteration: 625
## RefGene: 25
## RefGene before update: 2.44998
## sumAux (line 117): 34.4911
## RefGene after update: 0.836384
## Iteration: 626
## RefGene: 17
## RefGene before update: 2.44998
## sumAux (line 117): 33.4407
## RefGene after update: 2.39121
## Iteration: 627
## RefGene: 17
## RefGene before update: 2.44998
## sumAux (line 117): 33.7502
## RefGene after update: 1.7546
## Iteration: 628
## RefGene: 25
## RefGene before update: 2.44998
## sumAux (line 117): 34.136
## RefGene after update: 1.19296
## Iteration: 629
## RefGene: 17
## RefGene before update: 2.44998
## sumAux (line 117): 33.5152
## RefGene after update: 2.21948
## Iteration: 630
## RefGene: 15
## RefGene before update: 2.44998
## sumAux (line 117): 33.2967
## RefGene after update: 2.76133
## Iteration: 631
## RefGene: 20
## RefGene before update: 2.44998
## sumAux (line 117): 33.5595
## RefGene after update: 2.12321
## Iteration: 632
## RefGene: 33
## RefGene before update: 2.44998
## sumAux (line 117): 33.9516
## RefGene after update: 1.43449
## Iteration: 633
## RefGene: 1
## RefGene before update: 2.44998
## sumAux (line 117): 32.9405
## RefGene after update: 3.94295
## Iteration: 634
## RefGene: 9
## RefGene before update: 3.94295
## sumAux (line 117): 33.7002
## RefGene after update: 1.84448
## Iteration: 635
## RefGene: 16
## RefGene before update: 4.02368
## sumAux (line 117): 33.8394
## RefGene after update: 1.60489
## Iteration: 636
## RefGene: 20
## RefGene before update: 3.44392
## sumAux (line 117): 33.2174
## RefGene after update: 2.98935
## Iteration: 637
## RefGene: 1
## RefGene before update: 3.26436
## sumAux (line 117): 32.3759
## RefGene after update: 6.93492
## Iteration: 638
## RefGene: 1
## RefGene before update: 6.93492
## sumAux (line 117): 33.2929
## RefGene after update: 2.77191
## Iteration: 639
## RefGene: 3
## RefGene before update: 2.77191
## sumAux (line 117): 32.7935
## RefGene after update: 4.56732
## Iteration: 640
## RefGene: 1
## RefGene before update: 2.00258
## sumAux (line 117): 33.3513
## RefGene after update: 2.61458
## Iteration: 641
## RefGene: 20
## RefGene before update: 2.61458
## sumAux (line 117): 34.1653
## RefGene after update: 1.15857
## Iteration: 642
## RefGene: 9
## RefGene before update: 2.81167
## sumAux (line 117): 33.8264
## RefGene after update: 1.62585
## Iteration: 643
## RefGene: 16
## RefGene before update: 2.22841
## sumAux (line 117): 33.4784
## RefGene after update: 2.30268
## Iteration: 644
## RefGene: 9
## RefGene before update: 2.22841
## sumAux (line 117): 33.8519
## RefGene after update: 1.58494
## Iteration: 645
## RefGene: 48
## RefGene before update: 2.22841
## sumAux (line 117): 33.9752
## RefGene after update: 1.40106
## Iteration: 646
## RefGene: 9
## RefGene before update: 2.22841
## sumAux (line 117): 32.8943
## RefGene after update: 4.12953
## Iteration: 647
## RefGene: 15
## RefGene before update: 2.4782
## sumAux (line 117): 34.5687
## RefGene after update: 0.773924
## Iteration: 648
## RefGene: 9
## RefGene before update: 2.4782
## sumAux (line 117): 32.3154
## RefGene after update: 7.36704
## Iteration: 649
## RefGene: 33
## RefGene before update: 2.4782
## sumAux (line 117): 33.9674
## RefGene after update: 1.41212
## Iteration: 650
## RefGene: 48
## RefGene before update: 2.21162
## sumAux (line 117): 33.9425
## RefGene after update: 1.44772
## Iteration: 651
## RefGene: 25
## RefGene before update: 1.84636
## sumAux (line 117): 32.5293
## RefGene after update: 5.94828
## Iteration: 652
## RefGene: 3
## RefGene before update: 1.84636
## sumAux (line 117): 33.6355
## RefGene after update: 1.96794
## Iteration: 653
## RefGene: 16
## RefGene before update: 1.84636
## sumAux (line 117): 34.1875
## RefGene after update: 1.13309
## Iteration: 654
## RefGene: 3
## RefGene before update: 1.83075
## sumAux (line 117): 32.8797
## RefGene after update: 4.19021
## Iteration: 655
## RefGene: 25
## RefGene before update: 1.83075
## sumAux (line 117): 33.2223
## RefGene after update: 2.97475
## Iteration: 656
## RefGene: 15
## RefGene before update: 1.83075
## sumAux (line 117): 34.8435
## RefGene after update: 0.587995
## Iteration: 657
## RefGene: 17
## RefGene before update: 1.83075
## sumAux (line 117): 33.1459
## RefGene after update: 3.21086
## Iteration: 658
## RefGene: 48
## RefGene before update: 1.83075
## sumAux (line 117): 32.3871
## RefGene after update: 6.85733
## Iteration: 659
## RefGene: 33
## RefGene before update: 1.98622
## sumAux (line 117): 33.0641
## RefGene after update: 3.48451
## Iteration: 660
## RefGene: 33
## RefGene before update: 1.98622
## sumAux (line 117): 32.7834
## RefGene after update: 4.61377
## Iteration: 661
## RefGene: 25
## RefGene before update: 1.98622
## sumAux (line 117): 33.2293
## RefGene after update: 2.95389
## Iteration: 662
## RefGene: 15
## RefGene before update: 1.98622
## sumAux (line 117): 35.3554
## RefGene after update: 0.3524
## Iteration: 663
## RefGene: 25
## RefGene before update: 1.75677
## sumAux (line 117): 33.0542
## RefGene after update: 3.51915
## Iteration: 664
## RefGene: 1
## RefGene before update: 1.75677
## sumAux (line 117): 33.6238
## RefGene after update: 1.99093
## Iteration: 665
## RefGene: 3
## RefGene before update: 1.99093
## sumAux (line 117): 33.296
## RefGene after update: 2.76324
## Iteration: 666
## RefGene: 16
## RefGene before update: 1.99093
## sumAux (line 117): 33.7528
## RefGene after update: 1.75013
## Iteration: 667
## RefGene: 17
## RefGene before update: 1.99093
## sumAux (line 117): 33.5218
## RefGene after update: 2.20483
## Iteration: 668
## RefGene: 33
## RefGene before update: 1.99093
## sumAux (line 117): 33.3595
## RefGene after update: 2.59343
## Iteration: 669
## RefGene: 1
## RefGene before update: 1.99093
## sumAux (line 117): 33.6319
## RefGene after update: 1.97491
## Iteration: 670
## RefGene: 17
## RefGene before update: 1.97491
## sumAux (line 117): 32.706
## RefGene after update: 4.98488
## Iteration: 671
## RefGene: 1
## RefGene before update: 1.97491
## sumAux (line 117): 33.8726
## RefGene after update: 1.55247
## Iteration: 672
## RefGene: 15
## RefGene before update: 1.55247
## sumAux (line 117): 34.2505
## RefGene after update: 1.06392
## Iteration: 673
## RefGene: 3
## RefGene before update: 1.55247
## sumAux (line 117): 33.6941
## RefGene after update: 1.85586
## Iteration: 674
## RefGene: 9
## RefGene before update: 1.45209
## sumAux (line 117): 32.0976
## RefGene after update: 9.16012
## Iteration: 675
## RefGene: 15
## RefGene before update: 1.63335
## sumAux (line 117): 34.0297
## RefGene after update: 1.32676
## Iteration: 676
## RefGene: 33
## RefGene before update: 1.63335
## sumAux (line 117): 33.5254
## RefGene after update: 2.19689
## Iteration: 677
## RefGene: 48
## RefGene before update: 1.63335
## sumAux (line 117): 34.2025
## RefGene after update: 1.11627
## Iteration: 678
## RefGene: 25
## RefGene before update: 1.63335
## sumAux (line 117): 33.3653
## RefGene after update: 2.5784
## Iteration: 679
## RefGene: 48
## RefGene before update: 1.63335
## sumAux (line 117): 33.6383
## RefGene after update: 1.96244
## Iteration: 680
## RefGene: 3
## RefGene before update: 1.82331
## sumAux (line 117): 34.3256
## RefGene after update: 0.98693
## Iteration: 681
## RefGene: 48
## RefGene before update: 2.07522
## sumAux (line 117): 32.9791
## RefGene after update: 3.79389
## Iteration: 682
## RefGene: 20
## RefGene before update: 2.07522
## sumAux (line 117): 33.2981
## RefGene after update: 2.75758
## Iteration: 683
## RefGene: 20
## RefGene before update: 2.07522
## sumAux (line 117): 33.3658
## RefGene after update: 2.57713
## Iteration: 684
## RefGene: 48
## RefGene before update: 2.04272
## sumAux (line 117): 33.4953
## RefGene after update: 2.26409
## Iteration: 685
## RefGene: 9
## RefGene before update: 2.04272
## sumAux (line 117): 32.8476
## RefGene after update: 4.327
## Iteration: 686
## RefGene: 16
## RefGene before update: 1.80352
## sumAux (line 117): 33.1939
## RefGene after update: 3.06038
## Iteration: 687
## RefGene: 3
## RefGene before update: 1.80352
## sumAux (line 117): 34.014
## RefGene after update: 1.34777
## Iteration: 688
## RefGene: 48
## RefGene before update: 1.80352
## sumAux (line 117): 33.295
## RefGene after update: 2.76625
## Iteration: 689
## RefGene: 16
## RefGene before update: 1.80352
## sumAux (line 117): 34.467
## RefGene after update: 0.85684
## Iteration: 690
## RefGene: 20
## RefGene before update: 1.66263
## sumAux (line 117): 31.6916
## RefGene after update: 13.7471
## Iteration: 691
## RefGene: 48
## RefGene before update: 1.66263
## sumAux (line 117): 34.1523
## RefGene after update: 1.17371
## Iteration: 692
## RefGene: 33
## RefGene before update: 1.80986
## sumAux (line 117): 34.7229
## RefGene after update: 0.66338
## Iteration: 693
## RefGene: 9
## RefGene before update: 2.16531
## sumAux (line 117): 33.2826
## RefGene after update: 2.80054
## Iteration: 694
## RefGene: 15
## RefGene before update: 1.91235
## sumAux (line 117): 33.9786
## RefGene after update: 1.39639
## Iteration: 695
## RefGene: 15
## RefGene before update: 1.91235
## sumAux (line 117): 34.3035
## RefGene after update: 1.00896
## Iteration: 696
## RefGene: 9
## RefGene before update: 1.91235
## sumAux (line 117): 32.8806
## RefGene after update: 4.18653
## Iteration: 697
## RefGene: 1
## RefGene before update: 1.91235
## sumAux (line 117): 34.3145
## RefGene after update: 0.997905
## Iteration: 698
## RefGene: 1
## RefGene before update: 0.997905
## sumAux (line 117): 33.5427
## RefGene after update: 2.15925
## Iteration: 699
## RefGene: 3
## RefGene before update: 2.15925
## sumAux (line 117): 32.7636
## RefGene after update: 4.70627
## Iteration: 700
## RefGene: 25
## RefGene before update: 2.15925
## sumAux (line 117): 34.043
## RefGene after update: 1.30925
## Iteration: 701
## RefGene: 3
## RefGene before update: 2.15925
## sumAux (line 117): 32.562
## RefGene after update: 5.75728
## Iteration: 702
## RefGene: 1
## RefGene before update: 2.15925
## sumAux (line 117): 32.8493
## RefGene after update: 4.31959
## Iteration: 703
## RefGene: 3
## RefGene before update: 4.31959
## sumAux (line 117): 33.2213
## RefGene after update: 2.97757
## Iteration: 704
## RefGene: 48
## RefGene before update: 4.31959
## sumAux (line 117): 32.7517
## RefGene after update: 4.76226
## Iteration: 705
## RefGene: 15
## RefGene before update: 4.31959
## sumAux (line 117): 34.5635
## RefGene after update: 0.777964
## Iteration: 706
## RefGene: 1
## RefGene before update: 4.31959
## sumAux (line 117): 32.8302
## RefGene after update: 4.40296
## Iteration: 707
## RefGene: 16
## RefGene before update: 4.40296
## sumAux (line 117): 34.0272
## RefGene after update: 1.33006
## Iteration: 708
## RefGene: 9
## RefGene before update: 4.42418
## sumAux (line 117): 32.3968
## RefGene after update: 6.79131
## Iteration: 709
## RefGene: 48
## RefGene before update: 4.42418
## sumAux (line 117): 33.9856
## RefGene after update: 1.38657
## Iteration: 710
## RefGene: 17
## RefGene before update: 3.64089
## sumAux (line 117): 34.5625
## RefGene after update: 0.778792
## Iteration: 711
## RefGene: 1
## RefGene before update: 3.43866
## sumAux (line 117): 33.8595
## RefGene after update: 1.57299
## Iteration: 712
## RefGene: 15
## RefGene before update: 1.57299
## sumAux (line 117): 33.4496
## RefGene after update: 2.36984
## Iteration: 713
## RefGene: 33
## RefGene before update: 1.55536
## sumAux (line 117): 33.3543
## RefGene after update: 2.60694
## Iteration: 714
## RefGene: 15
## RefGene before update: 1.92741
## sumAux (line 117): 32.5967
## RefGene after update: 5.56078
## Iteration: 715
## RefGene: 17
## RefGene before update: 2.39544
## sumAux (line 117): 34.4697
## RefGene after update: 0.854498
## Iteration: 716
## RefGene: 25
## RefGene before update: 1.85497
## sumAux (line 117): 33.4745
## RefGene after update: 2.31151
## Iteration: 717
## RefGene: 48
## RefGene before update: 1.46134
## sumAux (line 117): 34.0084
## RefGene after update: 1.35528
## Iteration: 718
## RefGene: 48
## RefGene before update: 1.74685
## sumAux (line 117): 32.7072
## RefGene after update: 4.9789
## Iteration: 719
## RefGene: 15
## RefGene before update: 1.74685
## sumAux (line 117): 32.4778
## RefGene after update: 6.26269
## Iteration: 720
## RefGene: 17
## RefGene before update: 1.74685
## sumAux (line 117): 33.412
## RefGene after update: 2.46071
## Iteration: 721
## RefGene: 16
## RefGene before update: 1.71409
## sumAux (line 117): 34.0204
## RefGene after update: 1.33913
## Iteration: 722
## RefGene: 16
## RefGene before update: 1.83264
## sumAux (line 117): 33.7169
## RefGene after update: 1.81399
## Iteration: 723
## RefGene: 1
## RefGene before update: 1.83264
## sumAux (line 117): 33.4769
## RefGene after update: 2.30607
## Iteration: 724
## RefGene: 48
## RefGene before update: 2.30607
## sumAux (line 117): 33.0474
## RefGene after update: 3.54324
## Iteration: 725
## RefGene: 16
## RefGene before update: 2.45192
## sumAux (line 117): 34.0911
## RefGene after update: 1.2478
## Iteration: 726
## RefGene: 20
## RefGene before update: 2.1001
## sumAux (line 117): 32.8328
## RefGene after update: 4.3916
## Iteration: 727
## RefGene: 25
## RefGene before update: 2.01172
## sumAux (line 117): 33.5183
## RefGene after update: 2.21258
## Iteration: 728
## RefGene: 9
## RefGene before update: 2.01172
## sumAux (line 117): 32.8997
## RefGene after update: 4.10743
## Iteration: 729
## RefGene: 9
## RefGene before update: 2.01172
## sumAux (line 117): 33.0928
## RefGene after update: 3.38587
## Iteration: 730
## RefGene: 15
## RefGene before update: 1.64151
## sumAux (line 117): 33.4245
## RefGene after update: 2.43017
## Iteration: 731
## RefGene: 1
## RefGene before update: 1.64151
## sumAux (line 117): 33.8109
## RefGene after update: 1.65127
## Iteration: 732
## RefGene: 15
## RefGene before update: 1.65127
## sumAux (line 117): 32.2518
## RefGene after update: 7.85096
## Iteration: 733
## RefGene: 16
## RefGene before update: 1.71441
## sumAux (line 117): 33.4759
## RefGene after update: 2.30833
## Iteration: 734
## RefGene: 17
## RefGene before update: 1.88791
## sumAux (line 117): 34.4631
## RefGene after update: 0.860113
## Iteration: 735
## RefGene: 25
## RefGene before update: 1.88791
## sumAux (line 117): 33.0331
## RefGene after update: 3.59427
## Iteration: 736
## RefGene: 3
## RefGene before update: 1.84079
## sumAux (line 117): 33.6939
## RefGene after update: 1.85624
## Iteration: 737
## RefGene: 33
## RefGene before update: 1.84079
## sumAux (line 117): 33.4426
## RefGene after update: 2.38658
## Iteration: 738
## RefGene: 33
## RefGene before update: 1.83623
## sumAux (line 117): 34.4058
## RefGene after update: 0.910908
## Iteration: 739
## RefGene: 16
## RefGene before update: 1.86134
## sumAux (line 117): 33.5398
## RefGene after update: 2.16541
## Iteration: 740
## RefGene: 25
## RefGene before update: 1.8771
## sumAux (line 117): 33.6314
## RefGene after update: 1.97588
## Iteration: 741
## RefGene: 20
## RefGene before update: 1.8771
## sumAux (line 117): 32.4328
## RefGene after update: 6.55105
## Iteration: 742
## RefGene: 1
## RefGene before update: 1.45869
## sumAux (line 117): 34.1156
## RefGene after update: 1.21761
## Iteration: 743
## RefGene: 1
## RefGene before update: 1.21761
## sumAux (line 117): 33.5107
## RefGene after update: 2.22947
## Iteration: 744
## RefGene: 9
## RefGene before update: 2.22947
## sumAux (line 117): 33.5637
## RefGene after update: 2.11445
## Iteration: 745
## RefGene: 48
## RefGene before update: 2.19919
## sumAux (line 117): 34.1964
## RefGene after update: 1.12301
## Iteration: 746
## RefGene: 15
## RefGene before update: 2.19919
## sumAux (line 117): 32.7424
## RefGene after update: 4.80673
## Iteration: 747
## RefGene: 20
## RefGene before update: 2.22337
## sumAux (line 117): 34.199
## RefGene after update: 1.1201
## Iteration: 748
## RefGene: 9
## RefGene before update: 2.22337
## sumAux (line 117): 33.2366
## RefGene after update: 2.93247
## Iteration: 749
## RefGene: 1
## RefGene before update: 2.22337
## sumAux (line 117): 33.1282
## RefGene after update: 3.26837
## Iteration: 750
## RefGene: 9
## RefGene before update: 3.26837
## sumAux (line 117): 33.5082
## RefGene after update: 2.23492
## Iteration: 751
## RefGene: 15
## RefGene before update: 3.26837
## sumAux (line 117): 33.2639
## RefGene after update: 2.85351
## Iteration: 752
## RefGene: 16
## RefGene before update: 3.26837
## sumAux (line 117): 33.1496
## RefGene after update: 3.1991
## Iteration: 753
## RefGene: 3
## RefGene before update: 3.26837
## sumAux (line 117): 33.2858
## RefGene after update: 2.79175
## Iteration: 754
## RefGene: 17
## RefGene before update: 3.26837
## sumAux (line 117): 34.2571
## RefGene after update: 1.05689
## Iteration: 755
## RefGene: 48
## RefGene before update: 3.26837
## sumAux (line 117): 33.9892
## RefGene after update: 1.38157
## Iteration: 756
## RefGene: 15
## RefGene before update: 3.26837
## sumAux (line 117): 32.6643
## RefGene after update: 5.19735
## Iteration: 757
## RefGene: 9
## RefGene before update: 2.70225
## sumAux (line 117): 33.4879
## RefGene after update: 2.2809
## Iteration: 758
## RefGene: 15
## RefGene before update: 2.70225
## sumAux (line 117): 33.1015
## RefGene after update: 3.35662
## Iteration: 759
## RefGene: 20
## RefGene before update: 2.70225
## sumAux (line 117): 33.3547
## RefGene after update: 2.60583
## Iteration: 760
## RefGene: 33
## RefGene before update: 1.7402
## sumAux (line 117): 33.148
## RefGene after update: 3.20429
## Iteration: 761
## RefGene: 25
## RefGene before update: 1.52806
## sumAux (line 117): 32.56
## RefGene after update: 5.76855
## Iteration: 762
## RefGene: 33
## RefGene before update: 1.52806
## sumAux (line 117): 33.3914
## RefGene after update: 2.51185
## Iteration: 763
## RefGene: 20
## RefGene before update: 1.69411
## sumAux (line 117): 33.9774
## RefGene after update: 1.39805
## Iteration: 764
## RefGene: 1
## RefGene before update: 1.69411
## sumAux (line 117): 33.7776
## RefGene after update: 1.70726
## Iteration: 765
## RefGene: 17
## RefGene before update: 1.70726
## sumAux (line 117): 34.4026
## RefGene after update: 0.913811
## Iteration: 766
## RefGene: 25
## RefGene before update: 2.14942
## sumAux (line 117): 32.5664
## RefGene after update: 5.73202
## Iteration: 767
## RefGene: 16
## RefGene before update: 2.14942
## sumAux (line 117): 33.5561
## RefGene after update: 2.13043
## Iteration: 768
## RefGene: 20
## RefGene before update: 2.06588
## sumAux (line 117): 33.3817
## RefGene after update: 2.53643
## Iteration: 769
## RefGene: 15
## RefGene before update: 2.06588
## sumAux (line 117): 34.0458
## RefGene after update: 1.30554
## Iteration: 770
## RefGene: 3
## RefGene before update: 1.96046
## sumAux (line 117): 34.0015
## RefGene after update: 1.36465
## Iteration: 771
## RefGene: 3
## RefGene before update: 1.96046
## sumAux (line 117): 34.4181
## RefGene after update: 0.899721
## Iteration: 772
## RefGene: 16
## RefGene before update: 1.96046
## sumAux (line 117): 34.198
## RefGene after update: 1.12124
## Iteration: 773
## RefGene: 33
## RefGene before update: 1.96046
## sumAux (line 117): 32.998
## RefGene after update: 3.72271
## Iteration: 774
## RefGene: 33
## RefGene before update: 1.96046
## sumAux (line 117): 33.5462
## RefGene after update: 2.15176
## Iteration: 775
## RefGene: 48
## RefGene before update: 1.7805
## sumAux (line 117): 33.6134
## RefGene after update: 2.01185
## Iteration: 776
## RefGene: 33
## RefGene before update: 1.74524
## sumAux (line 117): 33.5842
## RefGene after update: 2.07148
## Iteration: 777
## RefGene: 48
## RefGene before update: 1.74524
## sumAux (line 117): 34.1793
## RefGene after update: 1.14246
## Iteration: 778
## RefGene: 15
## RefGene before update: 1.74524
## sumAux (line 117): 33.312
## RefGene after update: 2.71956
## Iteration: 779
## RefGene: 15
## RefGene before update: 1.7029
## sumAux (line 117): 32.7312
## RefGene after update: 4.86087
## Iteration: 780
## RefGene: 9
## RefGene before update: 1.80244
## sumAux (line 117): 32.9689
## RefGene after update: 3.8327
## Iteration: 781
## RefGene: 15
## RefGene before update: 1.7204
## sumAux (line 117): 33.4081
## RefGene after update: 2.47038
## Iteration: 782
## RefGene: 9
## RefGene before update: 1.9874
## sumAux (line 117): 33.9401
## RefGene after update: 1.4511
## Iteration: 783
## RefGene: 25
## RefGene before update: 1.9874
## sumAux (line 117): 33.4297
## RefGene after update: 2.41761
## Iteration: 784
## RefGene: 48
## RefGene before update: 1.70343
## sumAux (line 117): 32.6872
## RefGene after update: 5.0797
## Iteration: 785
## RefGene: 25
## RefGene before update: 1.83851
## sumAux (line 117): 34.0814
## RefGene after update: 1.25992
## Iteration: 786
## RefGene: 33
## RefGene before update: 2.34839
## sumAux (line 117): 33.5253
## RefGene after update: 2.19707
## Iteration: 787
## RefGene: 48
## RefGene before update: 2.34839
## sumAux (line 117): 33.0749
## RefGene after update: 3.44724
## Iteration: 788
## RefGene: 16
## RefGene before update: 2.34839
## sumAux (line 117): 32.7972
## RefGene after update: 4.55053
## Iteration: 789
## RefGene: 17
## RefGene before update: 1.68815
## sumAux (line 117): 33.5337
## RefGene after update: 2.17867
## Iteration: 790
## RefGene: 48
## RefGene before update: 1.93502
## sumAux (line 117): 33.8173
## RefGene after update: 1.64081
## Iteration: 791
## RefGene: 3
## RefGene before update: 1.93502
## sumAux (line 117): 33.1264
## RefGene after update: 3.27421
## Iteration: 792
## RefGene: 3
## RefGene before update: 1.93502
## sumAux (line 117): 33.0011
## RefGene after update: 3.7111
## Iteration: 793
## RefGene: 9
## RefGene before update: 1.93502
## sumAux (line 117): 32.9666
## RefGene after update: 3.84158
## Iteration: 794
## RefGene: 3
## RefGene before update: 1.73995
## sumAux (line 117): 33.7415
## RefGene after update: 1.76989
## Iteration: 795
## RefGene: 17
## RefGene before update: 1.73995
## sumAux (line 117): 33.5407
## RefGene after update: 2.16348
## Iteration: 796
## RefGene: 25
## RefGene before update: 1.73995
## sumAux (line 117): 33.902
## RefGene after update: 1.50752
## Iteration: 797
## RefGene: 20
## RefGene before update: 1.8334
## sumAux (line 117): 33.9762
## RefGene after update: 1.39967
## Iteration: 798
## RefGene: 33
## RefGene before update: 1.67983
## sumAux (line 117): 33.263
## RefGene after update: 2.85594
## Iteration: 799
## RefGene: 48
## RefGene before update: 1.66107
## sumAux (line 117): 33.1554
## RefGene after update: 3.18045
## Iteration: 800
## RefGene: 25
## RefGene before update: 1.66107
## sumAux (line 117): 33.3278
## RefGene after update: 2.6769
## Iteration: 801
## RefGene: 17
## RefGene before update: 1.7854
## sumAux (line 117): 33.9923
## RefGene after update: 1.37738
## Iteration: 802
## RefGene: 15
## RefGene before update: 1.7854
## sumAux (line 117): 33.735
## RefGene after update: 1.78157
## Iteration: 803
## RefGene: 3
## RefGene before update: 1.7854
## sumAux (line 117): 33.995
## RefGene after update: 1.37356
## Iteration: 804
## RefGene: 16
## RefGene before update: 1.7854
## sumAux (line 117): 33.1591
## RefGene after update: 3.16888
## Iteration: 805
## RefGene: 1
## RefGene before update: 1.91874
## sumAux (line 117): 34.0207
## RefGene after update: 1.33882
## Iteration: 806
## RefGene: 48
## RefGene before update: 1.33882
## sumAux (line 117): 33.4488
## RefGene after update: 2.37178
## Iteration: 807
## RefGene: 33
## RefGene before update: 1.33882
## sumAux (line 117): 33.8982
## RefGene after update: 1.5132
## Iteration: 808
## RefGene: 33
## RefGene before update: 1.87796
## sumAux (line 117): 32.4708
## RefGene after update: 6.30689
## Iteration: 809
## RefGene: 33
## RefGene before update: 1.87796
## sumAux (line 117): 33.521
## RefGene after update: 2.20651
## Iteration: 810
## RefGene: 1
## RefGene before update: 2.06423
## sumAux (line 117): 33.2298
## RefGene after update: 2.95241
## Iteration: 811
## RefGene: 1
## RefGene before update: 2.95241
## sumAux (line 117): 33.4088
## RefGene after update: 2.46865
## Iteration: 812
## RefGene: 48
## RefGene before update: 2.46865
## sumAux (line 117): 33.4556
## RefGene after update: 2.35566
## Iteration: 813
## RefGene: 16
## RefGene before update: 2.46865
## sumAux (line 117): 34.176
## RefGene after update: 1.14615
## Iteration: 814
## RefGene: 20
## RefGene before update: 2.46865
## sumAux (line 117): 32.9268
## RefGene after update: 3.99742
## Iteration: 815
## RefGene: 1
## RefGene before update: 2.46865
## sumAux (line 117): 33.7843
## RefGene after update: 1.69572
## Iteration: 816
## RefGene: 9
## RefGene before update: 1.69572
## sumAux (line 117): 32.9696
## RefGene after update: 3.82988
## Iteration: 817
## RefGene: 17
## RefGene before update: 1.69572
## sumAux (line 117): 33.366
## RefGene after update: 2.5765
## Iteration: 818
## RefGene: 20
## RefGene before update: 1.86457
## sumAux (line 117): 33.3101
## RefGene after update: 2.72467
## Iteration: 819
## RefGene: 33
## RefGene before update: 1.86457
## sumAux (line 117): 33.7636
## RefGene after update: 1.73127
## Iteration: 820
## RefGene: 20
## RefGene before update: 1.86457
## sumAux (line 117): 33.3906
## RefGene after update: 2.51387
## Iteration: 821
## RefGene: 20
## RefGene before update: 1.89497
## sumAux (line 117): 34.1209
## RefGene after update: 1.2111
## Iteration: 822
## RefGene: 20
## RefGene before update: 1.89497
## sumAux (line 117): 33.6633
## RefGene after update: 1.914
## Iteration: 823
## RefGene: 48
## RefGene before update: 1.89497
## sumAux (line 117): 33.2977
## RefGene after update: 2.75878
## Iteration: 824
## RefGene: 15
## RefGene before update: 1.89497
## sumAux (line 117): 33.2297
## RefGene after update: 2.9529
## Iteration: 825
## RefGene: 1
## RefGene before update: 1.89497
## sumAux (line 117): 34.1557
## RefGene after update: 1.16971
## Iteration: 826
## RefGene: 9
## RefGene before update: 1.16971
## sumAux (line 117): 33.497
## RefGene after update: 2.2602
## Iteration: 827
## RefGene: 3
## RefGene before update: 1.16971
## sumAux (line 117): 33.8572
## RefGene after update: 1.57661
## Iteration: 828
## RefGene: 3
## RefGene before update: 1.16971
## sumAux (line 117): 34.3571
## RefGene after update: 0.956375
## Iteration: 829
## RefGene: 48
## RefGene before update: 1.16971
## sumAux (line 117): 33.8324
## RefGene after update: 1.61609
## Iteration: 830
## RefGene: 48
## RefGene before update: 1.16971
## sumAux (line 117): 33.839
## RefGene after update: 1.60547
## Iteration: 831
## RefGene: 1
## RefGene before update: 1.16971
## sumAux (line 117): 32.84
## RefGene after update: 4.36012
## Iteration: 832
## RefGene: 3
## RefGene before update: 4.36012
## sumAux (line 117): 33.9126
## RefGene after update: 1.4916
## Iteration: 833
## RefGene: 48
## RefGene before update: 3.07779
## sumAux (line 117): 33.2556
## RefGene after update: 2.87736
## Iteration: 834
## RefGene: 25
## RefGene before update: 2.93134
## sumAux (line 117): 33.8966
## RefGene after update: 1.51564
## Iteration: 835
## RefGene: 3
## RefGene before update: 2.65843
## sumAux (line 117): 34.4888
## RefGene after update: 0.838357
## Iteration: 836
## RefGene: 20
## RefGene before update: 2.65843
## sumAux (line 117): 33.6654
## RefGene after update: 1.90983
## Iteration: 837
## RefGene: 33
## RefGene before update: 2.65843
## sumAux (line 117): 34.5964
## RefGene after update: 0.75277
## Iteration: 838
## RefGene: 20
## RefGene before update: 2.65843
## sumAux (line 117): 34.4592
## RefGene after update: 0.863505
## Iteration: 839
## RefGene: 17
## RefGene before update: 2.65843
## sumAux (line 117): 33.5283
## RefGene after update: 2.19053
## Iteration: 840
## RefGene: 16
## RefGene before update: 2.65843
## sumAux (line 117): 33.7404
## RefGene after update: 1.77188
## Iteration: 841
## RefGene: 25
## RefGene before update: 1.5552
## sumAux (line 117): 34.1595
## RefGene after update: 1.16525
## Iteration: 842
## RefGene: 20
## RefGene before update: 1.62226
## sumAux (line 117): 33.8996
## RefGene after update: 1.5111
## Iteration: 843
## RefGene: 3
## RefGene before update: 1.66806
## sumAux (line 117): 33.8733
## RefGene after update: 1.55144
## Iteration: 844
## RefGene: 1
## RefGene before update: 1.66806
## sumAux (line 117): 33.8899
## RefGene after update: 1.52579
## Iteration: 845
## RefGene: 9
## RefGene before update: 1.52579
## sumAux (line 117): 33.6582
## RefGene after update: 1.92374
## Iteration: 846
## RefGene: 3
## RefGene before update: 1.5789
## sumAux (line 117): 34.0028
## RefGene after update: 1.36299
## Iteration: 847
## RefGene: 25
## RefGene before update: 1.5789
## sumAux (line 117): 33.8509
## RefGene after update: 1.5866
## Iteration: 848
## RefGene: 25
## RefGene before update: 1.52312
## sumAux (line 117): 33.6219
## RefGene after update: 1.99473
## Iteration: 849
## RefGene: 48
## RefGene before update: 2.46381
## sumAux (line 117): 33.6814
## RefGene after update: 1.8796
## Iteration: 850
## RefGene: 25
## RefGene before update: 1.92615
## sumAux (line 117): 34.0658
## RefGene after update: 1.27975
## Iteration: 851
## RefGene: 9
## RefGene before update: 1.92615
## sumAux (line 117): 33.4981
## RefGene after update: 2.25765
## Iteration: 852
## RefGene: 17
## RefGene before update: 1.92615
## sumAux (line 117): 32.895
## RefGene after update: 4.12655
## Iteration: 853
## RefGene: 20
## RefGene before update: 1.92615
## sumAux (line 117): 34.2176
## RefGene after update: 1.09944
## Iteration: 854
## RefGene: 16
## RefGene before update: 1.92615
## sumAux (line 117): 33.1353
## RefGene after update: 3.24496
## Iteration: 855
## RefGene: 25
## RefGene before update: 1.92615
## sumAux (line 117): 34.573
## RefGene after update: 0.770621
## Iteration: 856
## RefGene: 15
## RefGene before update: 1.92615
## sumAux (line 117): 33.5968
## RefGene after update: 2.04556
## Iteration: 857
## RefGene: 16
## RefGene before update: 1.80696
## sumAux (line 117): 34.0892
## RefGene after update: 1.25016
## Iteration: 858
## RefGene: 20
## RefGene before update: 1.83443
## sumAux (line 117): 34.5644
## RefGene after update: 0.777306
## Iteration: 859
## RefGene: 48
## RefGene before update: 1.83443
## sumAux (line 117): 33.7168
## RefGene after update: 1.81412
## Iteration: 860
## RefGene: 17
## RefGene before update: 1.81383
## sumAux (line 117): 33.4652
## RefGene after update: 2.33317
## Iteration: 861
## RefGene: 25
## RefGene before update: 1.81383
## sumAux (line 117): 33.4818
## RefGene after update: 2.29485
## Iteration: 862
## RefGene: 16
## RefGene before update: 1.73537
## sumAux (line 117): 33.6259
## RefGene after update: 1.98683
## Iteration: 863
## RefGene: 3
## RefGene before update: 1.89008
## sumAux (line 117): 33.9881
## RefGene after update: 1.38316
## Iteration: 864
## RefGene: 3
## RefGene before update: 1.89008
## sumAux (line 117): 33.4618
## RefGene after update: 2.34112
## Iteration: 865
## RefGene: 48
## RefGene before update: 1.81017
## sumAux (line 117): 33.6741
## RefGene after update: 1.89336
## Iteration: 866
## RefGene: 3
## RefGene before update: 1.81017
## sumAux (line 117): 33.0808
## RefGene after update: 3.42694
## Iteration: 867
## RefGene: 17
## RefGene before update: 1.81017
## sumAux (line 117): 33.8407
## RefGene after update: 1.60286
## Iteration: 868
## RefGene: 48
## RefGene before update: 2.06812
## sumAux (line 117): 33.4966
## RefGene after update: 2.26112
## Iteration: 869
## RefGene: 16
## RefGene before update: 1.94234
## sumAux (line 117): 33.3181
## RefGene after update: 2.70298
## Iteration: 870
## RefGene: 48
## RefGene before update: 1.94234
## sumAux (line 117): 33.3438
## RefGene after update: 2.63444
## Iteration: 871
## RefGene: 33
## RefGene before update: 1.94234
## sumAux (line 117): 32.9882
## RefGene after update: 3.7594
## Iteration: 872
## RefGene: 15
## RefGene before update: 1.94234
## sumAux (line 117): 34.3885
## RefGene after update: 0.926741
## Iteration: 873
## RefGene: 3
## RefGene before update: 2.21121
## sumAux (line 117): 33.6366
## RefGene after update: 1.96574
## Iteration: 874
## RefGene: 17
## RefGene before update: 2.03949
## sumAux (line 117): 34.3679
## RefGene after update: 0.946089
## Iteration: 875
## RefGene: 3
## RefGene before update: 2.21299
## sumAux (line 117): 33.7398
## RefGene after update: 1.77289
## Iteration: 876
## RefGene: 1
## RefGene before update: 1.67753
## sumAux (line 117): 33.5445
## RefGene after update: 2.1553
## Iteration: 877
## RefGene: 15
## RefGene before update: 2.1553
## sumAux (line 117): 34.2252
## RefGene after update: 1.09112
## Iteration: 878
## RefGene: 15
## RefGene before update: 1.94748
## sumAux (line 117): 32.9427
## RefGene after update: 3.93427
## Iteration: 879
## RefGene: 20
## RefGene before update: 1.94748
## sumAux (line 117): 33.9625
## RefGene after update: 1.41906
## Iteration: 880
## RefGene: 9
## RefGene before update: 1.94748
## sumAux (line 117): 33.8127
## RefGene after update: 1.64838
## Iteration: 881
## RefGene: 3
## RefGene before update: 1.91392
## sumAux (line 117): 33.9143
## RefGene after update: 1.48902
## Iteration: 882
## RefGene: 1
## RefGene before update: 2.11855
## sumAux (line 117): 34.2074
## RefGene after update: 1.11081
## Iteration: 883
## RefGene: 3
## RefGene before update: 1.11081
## sumAux (line 117): 34.1273
## RefGene after update: 1.20336
## Iteration: 884
## RefGene: 1
## RefGene before update: 1.41508
## sumAux (line 117): 33.9179
## RefGene after update: 1.48376
## Iteration: 885
## RefGene: 1
## RefGene before update: 1.48376
## sumAux (line 117): 33.3722
## RefGene after update: 2.56059
## Iteration: 886
## RefGene: 33
## RefGene before update: 2.56059
## sumAux (line 117): 34.0157
## RefGene after update: 1.34542
## Iteration: 887
## RefGene: 15
## RefGene before update: 2.56059
## sumAux (line 117): 34.2692
## RefGene after update: 1.04418
## Iteration: 888
## RefGene: 48
## RefGene before update: 2.00482
## sumAux (line 117): 33.2942
## RefGene after update: 2.76825
## Iteration: 889
## RefGene: 17
## RefGene before update: 2.00482
## sumAux (line 117): 33.7473
## RefGene after update: 1.75971
## Iteration: 890
## RefGene: 48
## RefGene before update: 2.095
## sumAux (line 117): 33.1252
## RefGene after update: 3.27793
## Iteration: 891
## RefGene: 17
## RefGene before update: 2.095
## sumAux (line 117): 34.1462
## RefGene after update: 1.18086
## Iteration: 892
## RefGene: 25
## RefGene before update: 2.095
## sumAux (line 117): 34.0318
## RefGene after update: 1.32394
## Iteration: 893
## RefGene: 9
## RefGene before update: 2.095
## sumAux (line 117): 34.4468
## RefGene after update: 0.874317
## Iteration: 894
## RefGene: 33
## RefGene before update: 2.095
## sumAux (line 117): 35.0259
## RefGene after update: 0.489929
## Iteration: 895
## RefGene: 16
## RefGene before update: 2.095
## sumAux (line 117): 33.7562
## RefGene after update: 1.74414
## Iteration: 896
## RefGene: 17
## RefGene before update: 2.095
## sumAux (line 117): 33.4375
## RefGene after update: 2.39877
## Iteration: 897
## RefGene: 33
## RefGene before update: 2.095
## sumAux (line 117): 35.0684
## RefGene after update: 0.469559
## Iteration: 898
## RefGene: 20
## RefGene before update: 2.095
## sumAux (line 117): 33.2444
## RefGene after update: 2.90966
## Iteration: 899
## RefGene: 33
## RefGene before update: 2.08926
## sumAux (line 117): 34.976
## RefGene after update: 0.51504
## Iteration: 900
## RefGene: 33
## RefGene before update: 2.08926
## sumAux (line 117): 34.7492
## RefGene after update: 0.646165
## Iteration: 901
## RefGene: 1
## RefGene before update: 2.08926
## sumAux (line 117): 33.9891
## RefGene after update: 1.38176
## Iteration: 902
## RefGene: 1
## RefGene before update: 1.38176
## sumAux (line 117): 33.872
## RefGene after update: 1.55339
## Iteration: 903
## RefGene: 25
## RefGene before update: 1.55339
## sumAux (line 117): 33.039
## RefGene after update: 3.57325
## Iteration: 904
## RefGene: 20
## RefGene before update: 1.61414
## sumAux (line 117): 34.0144
## RefGene after update: 1.34728
## Iteration: 905
## RefGene: 16
## RefGene before update: 2.0745
## sumAux (line 117): 34.2003
## RefGene after update: 1.11869
## Iteration: 906
## RefGene: 20
## RefGene before update: 2.0745
## sumAux (line 117): 33.1546
## RefGene after update: 3.18305
## Iteration: 907
## RefGene: 33
## RefGene before update: 1.69532
## sumAux (line 117): 34.5208
## RefGene after update: 0.811939
## Iteration: 908
## RefGene: 1
## RefGene before update: 1.66097
## sumAux (line 117): 33.2153
## RefGene after update: 2.99575
## Iteration: 909
## RefGene: 20
## RefGene before update: 2.99575
## sumAux (line 117): 33.6987
## RefGene after update: 1.84726
## Iteration: 910
## RefGene: 16
## RefGene before update: 2.99575
## sumAux (line 117): 33.5229
## RefGene after update: 2.20247
## Iteration: 911
## RefGene: 3
## RefGene before update: 2.25266
## sumAux (line 117): 33.526
## RefGene after update: 2.19563
## Iteration: 912
## RefGene: 17
## RefGene before update: 2.25266
## sumAux (line 117): 33.6426
## RefGene after update: 1.95393
## Iteration: 913
## RefGene: 20
## RefGene before update: 2.25266
## sumAux (line 117): 33.6512
## RefGene after update: 1.93721
## Iteration: 914
## RefGene: 33
## RefGene before update: 2.07131
## sumAux (line 117): 33.8101
## RefGene after update: 1.65261
## Iteration: 915
## RefGene: 25
## RefGene before update: 1.97097
## sumAux (line 117): 33.5383
## RefGene after update: 2.16868
## Iteration: 916
## RefGene: 25
## RefGene before update: 1.97097
## sumAux (line 117): 33.3482
## RefGene after update: 2.62276
## Iteration: 917
## RefGene: 1
## RefGene before update: 1.97097
## sumAux (line 117): 33.4943
## RefGene after update: 2.26629
## Iteration: 918
## RefGene: 20
## RefGene before update: 2.26629
## sumAux (line 117): 34.4439
## RefGene after update: 0.876799
## Iteration: 919
## RefGene: 15
## RefGene before update: 2.57769
## sumAux (line 117): 33.4356
## RefGene after update: 2.40327
## Iteration: 920
## RefGene: 17
## RefGene before update: 2.57769
## sumAux (line 117): 33.0919
## RefGene after update: 3.38917
## Iteration: 921
## RefGene: 1
## RefGene before update: 2.57769
## sumAux (line 117): 33.1802
## RefGene after update: 3.10274
## Iteration: 922
## RefGene: 20
## RefGene before update: 3.10274
## sumAux (line 117): 34.2275
## RefGene after update: 1.08869
## Iteration: 923
## RefGene: 1
## RefGene before update: 3.10274
## sumAux (line 117): 33.4729
## RefGene after update: 2.31544
## Iteration: 924
## RefGene: 15
## RefGene before update: 2.31544
## sumAux (line 117): 33.2639
## RefGene after update: 2.85365
## Iteration: 925
## RefGene: 16
## RefGene before update: 1.8905
## sumAux (line 117): 33.7882
## RefGene after update: 1.68923
## Iteration: 926
## RefGene: 17
## RefGene before update: 1.8905
## sumAux (line 117): 33.7791
## RefGene after update: 1.70464
## Iteration: 927
## RefGene: 17
## RefGene before update: 1.91368
## sumAux (line 117): 34.0199
## RefGene after update: 1.33989
## Iteration: 928
## RefGene: 17
## RefGene before update: 1.91368
## sumAux (line 117): 33.2544
## RefGene after update: 2.88082
## Iteration: 929
## RefGene: 20
## RefGene before update: 1.91368
## sumAux (line 117): 33.915
## RefGene after update: 1.48799
## Iteration: 930
## RefGene: 15
## RefGene before update: 1.91368
## sumAux (line 117): 33.7653
## RefGene after update: 1.7283
## Iteration: 931
## RefGene: 15
## RefGene before update: 1.91368
## sumAux (line 117): 34.0203
## RefGene after update: 1.33928
## Iteration: 932
## RefGene: 9
## RefGene before update: 1.91368
## sumAux (line 117): 33.0072
## RefGene after update: 3.68862
## Iteration: 933
## RefGene: 9
## RefGene before update: 1.91368
## sumAux (line 117): 34.1721
## RefGene after update: 1.15064
## Iteration: 934
## RefGene: 3
## RefGene before update: 1.91368
## sumAux (line 117): 33.7021
## RefGene after update: 1.8411
## Iteration: 935
## RefGene: 48
## RefGene before update: 1.91368
## sumAux (line 117): 32.8915
## RefGene after update: 4.14092
## Iteration: 936
## RefGene: 9
## RefGene before update: 1.91368
## sumAux (line 117): 33.9278
## RefGene after update: 1.46915
## Iteration: 937
## RefGene: 3
## RefGene before update: 2.086
## sumAux (line 117): 33.9468
## RefGene after update: 1.44144
## Iteration: 938
## RefGene: 15
## RefGene before update: 2.086
## sumAux (line 117): 33.9452
## RefGene after update: 1.44371
## Iteration: 939
## RefGene: 1
## RefGene before update: 2.086
## sumAux (line 117): 34.4238
## RefGene after update: 0.894588
## Iteration: 940
## RefGene: 15
## RefGene before update: 0.894588
## sumAux (line 117): 33.0672
## RefGene after update: 3.47394
## Iteration: 941
## RefGene: 33
## RefGene before update: 0.894588
## sumAux (line 117): 34.4847
## RefGene after update: 0.841739
## Iteration: 942
## RefGene: 3
## RefGene before update: 0.894588
## sumAux (line 117): 33.1594
## RefGene after update: 3.1678
## Iteration: 943
## RefGene: 20
## RefGene before update: 0.894588
## sumAux (line 117): 33.4376
## RefGene after update: 2.39852
## Iteration: 944
## RefGene: 33
## RefGene before update: 0.963982
## sumAux (line 117): 34.3802
## RefGene after update: 0.934486
## Iteration: 945
## RefGene: 17
## RefGene before update: 0.963982
## sumAux (line 117): 33.6456
## RefGene after update: 1.94811
## Iteration: 946
## RefGene: 15
## RefGene before update: 1.29686
## sumAux (line 117): 33.3645
## RefGene after update: 2.58044
## Iteration: 947
## RefGene: 33
## RefGene before update: 1.29686
## sumAux (line 117): 34.206
## RefGene after update: 1.11234
## Iteration: 948
## RefGene: 17
## RefGene before update: 1.29686
## sumAux (line 117): 33.8036
## RefGene after update: 1.66336
## Iteration: 949
## RefGene: 1
## RefGene before update: 1.29686
## sumAux (line 117): 33.9326
## RefGene after update: 1.46201
## Iteration: 950
## RefGene: 15
## RefGene before update: 1.46201
## sumAux (line 117): 33.9964
## RefGene after update: 1.37174
## Iteration: 951
## RefGene: 25
## RefGene before update: 1.64538
## sumAux (line 117): 34.1581
## RefGene after update: 1.16688
## Iteration: 952
## RefGene: 33
## RefGene before update: 1.9056
## sumAux (line 117): 33.9585
## RefGene after update: 1.42465
## Iteration: 953
## RefGene: 16
## RefGene before update: 1.9056
## sumAux (line 117): 33.3024
## RefGene after update: 2.74565
## Iteration: 954
## RefGene: 9
## RefGene before update: 2.17325
## sumAux (line 117): 33.7264
## RefGene after update: 1.79685
## Iteration: 955
## RefGene: 48
## RefGene before update: 2.17325
## sumAux (line 117): 33.4048
## RefGene after update: 2.47837
## Iteration: 956
## RefGene: 20
## RefGene before update: 2.17325
## sumAux (line 117): 33.8023
## RefGene after update: 1.66557
## Iteration: 957
## RefGene: 15
## RefGene before update: 2.17325
## sumAux (line 117): 33.7192
## RefGene after update: 1.80981
## Iteration: 958
## RefGene: 17
## RefGene before update: 2.0092
## sumAux (line 117): 34.1816
## RefGene after update: 1.13981
## Iteration: 959
## RefGene: 48
## RefGene before update: 2.07006
## sumAux (line 117): 34.4122
## RefGene after update: 0.905066
## Iteration: 960
## RefGene: 15
## RefGene before update: 2.07006
## sumAux (line 117): 34.0797
## RefGene after update: 1.26203
## Iteration: 961
## RefGene: 33
## RefGene before update: 2.07006
## sumAux (line 117): 33.3653
## RefGene after update: 2.57841
## Iteration: 962
## RefGene: 1
## RefGene before update: 2.05558
## sumAux (line 117): 33.3202
## RefGene after update: 2.69733
## Iteration: 963
## RefGene: 20
## RefGene before update: 2.69733
## sumAux (line 117): 33.0499
## RefGene after update: 3.53425
## Iteration: 964
## RefGene: 17
## RefGene before update: 2.69825
## sumAux (line 117): 33.9736
## RefGene after update: 1.4034
## Iteration: 965
## RefGene: 16
## RefGene before update: 2.69825
## sumAux (line 117): 33.7864
## RefGene after update: 1.69232
## Iteration: 966
## RefGene: 9
## RefGene before update: 2.69825
## sumAux (line 117): 33.1835
## RefGene after update: 3.0924
## Iteration: 967
## RefGene: 48
## RefGene before update: 2.69825
## sumAux (line 117): 33.7075
## RefGene after update: 1.83113
## Iteration: 968
## RefGene: 20
## RefGene before update: 2.68011
## sumAux (line 117): 33.7964
## RefGene after update: 1.67534
## Iteration: 969
## RefGene: 17
## RefGene before update: 2.68011
## sumAux (line 117): 34.2021
## RefGene after update: 1.1167
## Iteration: 970
## RefGene: 20
## RefGene before update: 2.68011
## sumAux (line 117): 33.4847
## RefGene after update: 2.28807
## Iteration: 971
## RefGene: 48
## RefGene before update: 2.68011
## sumAux (line 117): 34.3139
## RefGene after update: 0.998523
## Iteration: 972
## RefGene: 3
## RefGene before update: 2.68011
## sumAux (line 117): 33.5947
## RefGene after update: 2.04976
## Iteration: 973
## RefGene: 15
## RefGene before update: 2.68011
## sumAux (line 117): 33.7251
## RefGene after update: 1.79922
## Iteration: 974
## RefGene: 48
## RefGene before update: 2.09329
## sumAux (line 117): 34.5494
## RefGene after update: 0.789031
## Iteration: 975
## RefGene: 3
## RefGene before update: 2.12771
## sumAux (line 117): 33.7982
## RefGene after update: 1.67241
## Iteration: 976
## RefGene: 33
## RefGene before update: 2.12771
## sumAux (line 117): 33.1716
## RefGene after update: 3.12957
## Iteration: 977
## RefGene: 16
## RefGene before update: 2.12771
## sumAux (line 117): 32.9247
## RefGene after update: 4.00591
## Iteration: 978
## RefGene: 16
## RefGene before update: 2.12771
## sumAux (line 117): 33.5059
## RefGene after update: 2.24027
## Iteration: 979
## RefGene: 20
## RefGene before update: 1.84221
## sumAux (line 117): 33.5159
## RefGene after update: 2.21785
## Iteration: 980
## RefGene: 1
## RefGene before update: 1.84221
## sumAux (line 117): 34.1494
## RefGene after update: 1.17708
## Iteration: 981
## RefGene: 20
## RefGene before update: 1.17708
## sumAux (line 117): 33.7394
## RefGene after update: 1.77366
## Iteration: 982
## RefGene: 16
## RefGene before update: 1.17708
## sumAux (line 117): 33.9563
## RefGene after update: 1.42781
## Iteration: 983
## RefGene: 16
## RefGene before update: 1.17708
## sumAux (line 117): 32.6768
## RefGene after update: 5.13294
## Iteration: 984
## RefGene: 1
## RefGene before update: 1.17708
## sumAux (line 117): 33.5098
## RefGene after update: 2.23149
## Iteration: 985
## RefGene: 15
## RefGene before update: 2.23149
## sumAux (line 117): 35.0518
## RefGene after update: 0.477411
## Iteration: 986
## RefGene: 33
## RefGene before update: 2.23149
## sumAux (line 117): 32.7248
## RefGene after update: 4.89202
## Iteration: 987
## RefGene: 20
## RefGene before update: 2.23149
## sumAux (line 117): 33.833
## RefGene after update: 1.61521
## Iteration: 988
## RefGene: 17
## RefGene before update: 2.14016
## sumAux (line 117): 34.1661
## RefGene after update: 1.15755
## Iteration: 989
## RefGene: 25
## RefGene before update: 2.00143
## sumAux (line 117): 33.4388
## RefGene after update: 2.39574
## Iteration: 990
## RefGene: 1
## RefGene before update: 2.00143
## sumAux (line 117): 34.6668
## RefGene after update: 0.701619
## Iteration: 991
## RefGene: 20
## RefGene before update: 0.701619
## sumAux (line 117): 33.0273
## RefGene after update: 3.61533
## Iteration: 992
## RefGene: 15
## RefGene before update: 0.701619
## sumAux (line 117): 34.9985
## RefGene after update: 0.503561
## Iteration: 993
## RefGene: 25
## RefGene before update: 0.924303
## sumAux (line 117): 33.6235
## RefGene after update: 1.99164
## Iteration: 994
## RefGene: 15
## RefGene before update: 0.924303
## sumAux (line 117): 34.4091
## RefGene after update: 0.907854
## Iteration: 995
## RefGene: 15
## RefGene before update: 0.924303
## sumAux (line 117): 34.3693
## RefGene after update: 0.944777
## Iteration: 996
## RefGene: 15
## RefGene before update: 1.10036
## sumAux (line 117): 33.7492
## RefGene after update: 1.75635
## Iteration: 997
## RefGene: 20
## RefGene before update: 1.23942
## sumAux (line 117): 33.2071
## RefGene after update: 3.02023
## Iteration: 998
## RefGene: 1
## RefGene before update: 1.23942
## sumAux (line 117): 33.9442
## RefGene after update: 1.44513
## Iteration: 999
## RefGene: 48
## RefGene before update: 1.44513
## sumAux (line 117): 33.7889
## RefGene after update: 1.68808
##
## -----------------------------------------------------
## -----------------------------------------------------
## All 1000 MCMC iterations have been completed.
## -----------------------------------------------------
## -----------------------------------------------------
##
## -----------------------------------------------------
## Please see below a summary of the overall acceptance rates.
## -----------------------------------------------------
##
## Minimum acceptance rate among mu[i]'s: 0.372
## Average acceptance rate among mu[i]'s: 0.48584
## Maximum acceptance rate among mu[i]'s: 0.62
##
##
## Minimum acceptance rate among delta[i]'s: 0.722
## Average acceptance rate among delta[i]'s: 0.7918
## Maximum acceptance rate among delta[i]'s: 0.838
##
##
## Minimum acceptance rate among nu[jk]'s: 0.884
## Average acceptance rate among nu[jk]'s: 0.935
## Maximum acceptance rate among nu[jk]'s: 0.982
##
##
## Minimum acceptance rate among theta[k]'s: 0.772
## Average acceptance rate among theta[k]'s: 0.785
## Maximum acceptance rate among theta[k]'s: 0.798
##
##
## -----------------------------------------------------
##
```

## 4.2 If `Regression = TRUE`

The BASiCS model uses a joint informative prior formulation to account for the
relationship between mean and over-dispersion gene-specific parameters. The
latter is used to infer a global regression trend between these parameters and,
subsequently, to derive a *residual over-dispersion* measure that is
defined as departures with respect to this trend.

```
DataRegression <- newBASiCS_Data(
  Counts, Tech, SpikeInfo,
  BatchInfo = rep(c(1, 2), each = 20)
)
ChainRegression <- BASiCS_MCMC(
  Data = DataRegression, N = 1000,
  Thin = 10, Burn = 500,
  Regression = TRUE,
  PrintProgress = FALSE
)
```

```
## -----------------------------------------------------
## MCMC sampler has been started: 1000 iterations to go.
## -----------------------------------------------------
## -----------------------------------------------------
## End of Burn-in period.
## -----------------------------------------------------
##
## -----------------------------------------------------
## -----------------------------------------------------
## All 1000 MCMC iterations have been completed.
## -----------------------------------------------------
## -----------------------------------------------------
##
## -----------------------------------------------------
## Please see below a summary of the overall acceptance rates.
## -----------------------------------------------------
##
## Minimum acceptance rate among mu[i]'s: 0.428
## Average acceptance rate among mu[i]'s: 0.49715
## Maximum acceptance rate among mu[i]'s: 0.576
##
##
## Minimum acceptance rate among delta[i]'s: 0.746
## Average acceptance rate among delta[i]'s: 0.78325
## Maximum acceptance rate among delta[i]'s: 0.82
##
##
## Acceptance rate for phi (joint): 0.836
##
##
## Minimum acceptance rate among nu[j]'s: 0.794
## Average acceptance rate among nu[j]'s: 0.8442
## Maximum acceptance rate among nu[j]'s: 0.97
##
##
## Minimum acceptance rate among theta[k]'s: 0.72
## Average acceptance rate among theta[k]'s: 0.73
## Maximum acceptance rate among theta[k]'s: 0.74
##
## -----------------------------------------------------
##
```

This implementation provides additional functionality when performing
downstream analyses. These are illustrated below using a small extract from
the MCMC chain obtained when analysing the dataset provided in
(Grün, Kester, and Oudenaarden [2014](#ref-grun2014validation)) (single cell versus pool-and-split samples). These are
included within `BASiCS` as the `ChainSCReg` and `ChainRNAReg` datasets.

To visualize the fit between over-dispersion \(\delta\_i\) and mean expression $
\_i$ the following function can be used.

```
data("ChainRNAReg")
BASiCS_ShowFit(ChainRNAReg)
```

![](data:image/png;base64...)

The `BASiCS_TestDE` test function will automatically perform differential
variability testing based on the residual over-dispersion parameters
\(\epsilon\_i\) when its output includes two `Chain` objects that were generated
by the regression BASiCS model.

```
data("ChainSCReg")
Test <- BASiCS_TestDE(
  Chain1 = ChainSCReg, Chain2 = ChainRNAReg,
  GroupLabel1 = "SC", GroupLabel2 = "PaS",
  EpsilonM = log2(1.5), EpsilonD = log2(1.5),
  EpsilonR = log2(1.5) / log2(exp(1)),
  EFDR_M = 0.10, EFDR_D = 0.10,
  Offset = TRUE, PlotOffset = FALSE, Plot = FALSE
)
```

This test function outputs an extra slot containing the results of the
differential testing residual over-dispersion test. Only genes that are
expressed in at least 2 cells (in both groups) are included in the test.
Genes that do not satisfy this condition are marked as `ExcludedFromRegression`
in the `ResultDiffResDisp` field. By performing the regression,
all genes can be tested for changes in expression variability independent of
changes in mean expression.

```
head(as.data.frame(Test, Parameter = "ResDisp"))
```

```
## [1] GeneName          ResDispOverall    ResDisp1          ResDisp2
## [5] ResDispDistance   ProbDiffResDisp   ResultDiffResDisp MeanOverall
## <0 rows> (or 0-length row.names)
```

```
BASiCS_PlotDE(Test, Parameters = "ResDisp")
```

![](data:image/png;base64...)

**Note:** Additional parameters for this sampler include: `k` number of
regression components (`k`-2 radial basis functions, one intercept and one
linear component), `Var` the scale parameter influencing the width of the basis
functions and `eta` the degrees of freedom. For additional details about these
choices, please refer to Eling et al. ([2018](#ref-eling2018correcting)).

# 5 Additional details

## 5.1 Storing and loading MCMC chains

To externally store the output of `BASiCS_MCMC` (recommended), additional
parameters `StoreChains`, `StoreDir` and `RunName` are required. For example:

```
Data <- makeExampleBASiCS_Data()
Chain <- BASiCS_MCMC(
  Data,
  N = 1000, Thin = 10, Burn = 500,
  Regression = TRUE, PrintProgress = FALSE,
  StoreChains = TRUE, StoreDir = tempdir(), RunName = "Example"
)
```

```
## -----------------------------------------------------
## MCMC sampler has been started: 1000 iterations to go.
## -----------------------------------------------------
## -----------------------------------------------------
## End of Burn-in period.
## -----------------------------------------------------
##
## -----------------------------------------------------
## -----------------------------------------------------
## All 1000 MCMC iterations have been completed.
## -----------------------------------------------------
## -----------------------------------------------------
##
## -----------------------------------------------------
## Please see below a summary of the overall acceptance rates.
## -----------------------------------------------------
##
## Minimum acceptance rate among mu[i]'s: 0.43
## Average acceptance rate among mu[i]'s: 0.63636
## Maximum acceptance rate among mu[i]'s: 0.772
##
##
## Minimum acceptance rate among delta[i]'s: 0.436
## Average acceptance rate among delta[i]'s: 0.52052
## Maximum acceptance rate among delta[i]'s: 0.616
##
##
## Acceptance rate for phi (joint): 0.906
##
##
## Minimum acceptance rate among nu[j]'s: 0.44
## Average acceptance rate among nu[j]'s: 0.5334
## Maximum acceptance rate among nu[j]'s: 0.696
##
##
## Minimum acceptance rate among theta[k]'s: 0.732
## Average acceptance rate among theta[k]'s: 0.732
## Maximum acceptance rate among theta[k]'s: 0.732
##
## -----------------------------------------------------
##
```

In this example, the output of `BASiCS_MCMC` will be stored as a `BASiCS_Chain`
object in the file “chain\_Example.Rds”, within the `tempdir()` directory.

To load pre-computed MCMC chains,

```
Chain <- BASiCS_LoadChain("Example", StoreDir = tempdir())
```

## 5.2 Convergence assessment

To assess convergence of the chain, the convergence diagnostics provided by the
package `coda` can be used. Additionally, the chains can be visually inspected.
For example:

```
plot(Chain, Param = "mu", Gene = 1, log = "y")
```

![](data:image/png;base64...)

See `help(BASiCS_MCMC)` for example plots associated to other model parameters.
In the figure above:

* Left panels show traceplots for the chains
* Right panels show the autocorrelation function (see `?acf`)

## 5.3 Summarising the posterior distribution

To access the MCMC chains associated to individual parameter use the function
`displayChainBASiCS`. For example,

```
displayChainBASiCS(Chain, Param = "mu")[1:2, 1:2]
```

```
##         Gene1    Gene2
## [1,]  5.35826 14.90511
## [2,] 12.75166 11.77155
```

As a summary of the posterior distribution, the function `Summary` calculates
posterior medians and the High Posterior Density (HPD) intervals for each model
parameter. As a default option, HPD intervals contain 0.95 probability.

```
ChainSummary <- Summary(Chain)
```

The function `displaySummaryBASiCS` extract posterior summaries for individual
parameters. For example

```
head(displaySummaryBASiCS(ChainSummary, Param = "mu"), n = 2)
```

```
##          median    lower     upper
## Gene1  9.692761  5.35826  5.057426
## Gene2 12.643747 14.84602 10.968432
```

The following figures display posterior medians and the corresponding HPD 95%
intervals for gene-specific parameters \(\mu\_i\) (mean) and \(\delta\_i\)
(over-dispersion)

```
par(mfrow = c(1, 2))
plot(ChainSummary, Param = "mu", main = "All genes", log = "y")
plot(ChainSummary, Param = "delta",
     Genes = c(2, 5, 10, 50), main = "5 customized genes"
)
```

![](data:image/png;base64...)

See `help(BASiCS_MCMC)` for example plots associated to other model parameters.

## 5.4 Normalisation and removal of technical variation

It is also possible to produce a matrix of normalised and denoised expression
counts for which the effect of technical variation is removed. For this purpose,
we implemented the function `BASiCS_DenoisedCounts`. For each gene \(i\) and
cell \(j\) this function returns
\[
x^\*\_{ij} = \frac{ x\_{ij} } {\hat{\phi}\_j \hat{\nu}\_j},
\]
where \(x\_{ij}\) is the observed expression count of gene \(i\) in cell \(j\),
\(\hat{\phi}\_j\) denotes the posterior median of \(\phi\_j\) and \(\hat{\nu}\_j\) is
the posterior median of \(\nu\_j\).

```
DenoisedCounts <- BASiCS_DenoisedCounts(Data = Data, Chain = Chain)
DenoisedCounts[1:2, 1:2]
```

```
##           Cell1    Cell2
## Gene1  1.678073 20.53865
## Gene2 10.068436 13.69243
```

**Note: the output of `BASiCS_DenoisedCounts` requires no further
data normalisation.**

Alternativelly, the user can compute the normalised and denoised expression
rates underlying the expression of all genes across cells using
`BASiCS_DenoisedRates`. The output of this function is given by
\[
\Lambda\_{ij} = \hat{\mu\_i} \hat{\rho}\_{ij},
\]
where \(\hat{\mu\_i}\) represents the posterior median of \(\mu\_j\) and
\(\hat{\rho}\_{ij}\) is given by its posterior mean (Monte Carlo estimate based
on the MCMC sample of all model parameters).

```
DenoisedRates <- BASiCS_DenoisedRates(
  Data = Data, Chain = Chain,
  Propensities = FALSE
)
DenoisedRates[1:2, 1:2]
```

```
##           Cell1    Cell2
## Gene1  2.144986 17.52305
## Gene2 10.612366 13.60491
```

Alternative, denoised expression propensities \(\hat{\rho}\_{ij}\) can
also be extracted

```
DenoisedProp <- BASiCS_DenoisedRates(
  Data = Data, Chain = Chain,
  Propensities = TRUE
)
DenoisedProp[1:2, 1:2]
```

```
##           Cell1    Cell2
## Gene1 0.2212977 1.807849
## Gene2 0.8393370 1.076019
```

# 6 Methodology

We first describe the model introduced in [1], which relates to a single group
of cells.

Throughout, we consider the expression counts of \(q\) genes, where \(q\_0\) are
expressed in the population of cells under study (biological genes) and the
remaining \(q-q\_0\) are extrinsic spike-in (technical) genes. Let \(X\_{ij}\) be a
random variable representing the expression count of a gene \(i\) in cell \(j\)

where \(\nu\_j\) and \(\rho\_{ij}\) are mutually independent random effects such that
\(\nu\_j|s\_j,\theta \sim \mbox{Gamma}(1/\theta,1/ (s\_j \theta))\) and
\(\rho\_{ij} | \delta\_i \sim \mbox{Gamma} (1/\delta\_i,1/\delta\_i)\)111 We parametrize the Gamma distribution such that if
\(X \sim \mbox{Gamma}(a,b)\), then \(\mbox{E}(X)=a/b\) and \(\mbox{var}(X)=a/b^2\)..

A graphical representation of this model is displayed below. This is based on
the expression counts of 2 genes (\(i\): biological and \(i'\): technical) at 2
cells (\(j\) and \(j'\)). Squared and circular nodes denote known observed
quantities (observed expression counts and added number of spike-in mRNA
molecules) and unknown elements, respectively. Whereas black circular nodes
represent the random effects that play an intermediate role in our hierarchical
structure, red circular nodes relate to unknown model parameters in the top
layer of hierarchy in our model. Blue, green and grey areas highlight elements
that are shared within a biological gene, technical gene or cell, respectively.

![](data:image/jpeg;base64...)

In this setting, the key parameters to be used for downstream analyses are:

* \(\mu\_i\): mean expression parameter for gene \(i\) in the group of cells under
  study. In case of the spike-in technical genes, \(\mu\_i\) is assumed to be known
  and equal to the input number of molecules of the corresponding spike-in gene).
* \(\delta\_i\): over-dispersion parameter for gene \(i\), a measure for the excess
  of variation that is observed after accounting for technical noise (with respect
  to Poisson sampling)

Additional (nuisance) parameters are interpreted as follows:

* \(\phi\_j\): cell-specific normalizing parameters related to differences in mRNA
  content (identifiability constrain: \(\sum\_{j=1}^n \phi\_j = n\)).
* \(s\_j\): cell-specific normalizing parameters related to technical cell-specific
  biases (for more details regarding this interpretation see
  (Vallejos et al. [2017](#ref-vallejos2017normalizing))).
* \(\theta\): technical over-dispersion parameter, controlling the strenght of
  cell-to-cell technical variability.

When cells from the same group are processed in multiple sequencing batches,
this model is extended so that the technical over-dispersion parameter \(\theta\)
is batch-specific. This extension allows a different strenght of technical noise
to be inferred for each batch of cells.

In Vallejos, Richardson, and Marioni ([2016](#ref-vallejos2016beyond)), this model has been extended to cases where multiple
groups of cells are under study. This is achieved by assuming gene-specific
parameters to be also group-specific. Based on this setup, evidence of
differential expression is quantified through log2-fold changes of gene-specific
parameters (mean and over-dispersion) between the groups. Moreover,
Eling et al. ([2018](#ref-eling2018correcting)) further extended this model by addressing the
mean/over-dispersion confounding that is characteristic of scRNA-seq datasets
as well as experimental designs where spike-ins are not available.

More details regarding the model setup, prior specification and implementation
are described in Vallejos, Marioni, and Richardson ([2015](#ref-vallejos2015basics)), Vallejos, Richardson, and Marioni ([2016](#ref-vallejos2016beyond)) and Eling et al. ([2018](#ref-eling2018correcting)).

---

# 7 Acknowledgements

This work has been funded by the MRC Biostatistics Unit (MRC grant no.
MRC\_MC\_UP\_0801/1; Catalina Vallejos and Sylvia Richardson), EMBL European
Bioinformatics Institute (core European Molecular Biology Laboratory funding;
Catalina Vallejos, Nils Eling and John Marioni), CRUK Cambridge Institute
(core CRUK funding; John Marioni) and The Alan Turing Institute (EPSRC grant no.
EP/N510129/1; Catalina Vallejos).

# 8 BASiCS *hall of fame*

We thank several members of the Marioni laboratory (EMBL-EBI; CRUK-CI) for
support and discussions throughout the development of this R library.
In particular, we are grateful to Aaron Lun (LTLA) for advise and
support during the preparation the Bioconductor submission.

We also acknowledge feedback, bug reports and contributions from (Github aliases
provided within parenthesis): Ben Dulken (bdulken), Chang Xu (xuchang116),
Danilo Horta (Horta), Dmitriy Zhukov (dvzhukov), Jens Preußner (jenzopr),
Joanna Dreux (Joannacodes), Kevin Rue-Albrecht (kevinrue),
Luke Zappia (lazappi), Nitesh Turaga (nturaga), Mike Morgan (MikeDMorgan),
Muad Abd El Hay (Cumol), Simon Anders (s-andrews), Shian Su (Shians),
Yongchao Ge and Yuan Cao (yuancao90), among others.

---

# 9 Session information

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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] ggplot2_4.0.0               cowplot_1.2.0
##  [3] BASiCS_2.22.0               SingleCellExperiment_1.32.0
##  [5] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [7] GenomicRanges_1.62.0        Seqinfo_1.0.0
##  [9] IRanges_2.44.0              S4Vectors_0.48.0
## [11] BiocGenerics_0.56.0         generics_0.1.4
## [13] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [15] knitr_1.50                  BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] gridExtra_2.3        rlang_1.1.6          magrittr_2.0.4
##  [4] otel_0.2.0           compiler_4.5.1       reshape2_1.4.4
##  [7] vctrs_0.6.5          stringr_1.5.2        pkgconfig_2.0.3
## [10] fastmap_1.2.0        magick_2.9.0         backports_1.5.0
## [13] XVector_0.50.0       labeling_0.4.3       scuttle_1.20.0
## [16] promises_1.4.0       rmarkdown_2.30       tinytex_0.57
## [19] xfun_0.53            bluster_1.20.0       cachem_1.1.0
## [22] beachmat_2.26.0      jsonlite_2.0.0       later_1.4.4
## [25] DelayedArray_0.36.0  BiocParallel_1.44.0  irlba_2.3.5.1
## [28] parallel_4.5.1       cluster_2.1.8.1      R6_2.6.1
## [31] stringi_1.8.7        bslib_0.9.0          RColorBrewer_1.1-3
## [34] limma_3.66.0         jquerylib_0.1.4      Rcpp_1.1.0
## [37] bookdown_0.45        assertthat_0.2.1     httpuv_1.6.16
## [40] Matrix_1.7-4         igraph_2.2.1         tidyselect_1.2.1
## [43] dichromat_2.0-0.1    abind_1.4-8          yaml_2.3.10
## [46] viridis_0.6.5        codetools_0.2-20     miniUI_0.1.2
## [49] plyr_1.8.9           lattice_0.22-7       tibble_3.3.0
## [52] withr_3.0.2          shiny_1.11.1         S7_0.2.0
## [55] posterior_1.6.1      coda_0.19-4.1        evaluate_1.0.5
## [58] pillar_1.11.1        BiocManager_1.30.26  tensorA_0.36.2.1
## [61] checkmate_2.3.3      distributional_0.5.0 scales_1.4.0
## [64] xtable_1.8-4         glue_1.8.0           metapod_1.18.0
## [67] tools_4.5.1          hexbin_1.28.5        BiocNeighbors_2.4.0
## [70] ScaledMatrix_1.18.0  locfit_1.5-9.12      scran_1.38.0
## [73] grid_4.5.1           edgeR_4.8.0          BiocSingular_1.26.0
## [76] cli_3.6.5            rsvd_1.0.5           S4Arrays_1.10.0
## [79] viridisLite_0.4.2    dplyr_1.1.4          gtable_0.3.6
## [82] sass_0.4.10          digest_0.6.37        SparseArray_1.10.0
## [85] dqrng_0.4.1          farver_2.1.2         htmltools_0.5.8.1
## [88] lifecycle_1.0.4      statmod_1.5.1        mime_0.13
## [91] ggExtra_0.11.0       MASS_7.3-65
```

---

# References

Eling, Nils, Arianne Richard, Sylvia Richardson, John C Marioni, and Catalina A Vallejos. 2018. “Correcting the Mean-Variance Dependency for Differential Variability Testing Using Single-Cell Rna Sequencing Data.” *Cell Systems*.

Grün, Dominic, Lennart Kester, and Alexander van Oudenaarden. 2014. “Validation of Noise Models for Single-Cell Transcriptomics.” *Nature Methods* 11 (6): 637–40.

Martinez-Jimenez, Celia Pilar, Nils Eling, Hung-Chang Chen, Catalina A Vallejos, Aleksandra A Kolodziejczyk, Frances Connor, Lovorka Stojic, et al. 2017. “Aging Increases Cell-to-Cell Transcriptional Variability Upon Immune Stimulation.” *Science* 355 (6332): 1433–6.

Newton, Michael A, Amine Noueiry, Deepayan Sarkar, and Paul Ahlquist. 2004. “Detecting Differential Gene Expression with a Semiparametric Hierarchical Mixture Method.” *Biostatistics* 5 (2): 155–76.

Vallejos, Catalina A, John C Marioni, and Sylvia Richardson. 2015. “BASiCS: Bayesian Analysis of Single-Cell Sequencing Data.” *PLoS Computational Biology* 11 (6): e1004333.

Vallejos, Catalina A, Sylvia Richardson, and John C Marioni. 2016. “Beyond Comparisons of Means: Understanding Changes in Gene Expression at the Single-Cell Level.” *Genome Biology* 17 (1).

Vallejos, Catalina A, Davide Risso, Antonio Scialdone, Sandrine Dudoit, and John C Marioni. 2017. “Normalizing Single-Cell RNA Sequencing Data: Challenges and Opportunities.” *Nature Methods* 14 (6).