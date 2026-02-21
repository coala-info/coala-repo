Code

* Show All Code
* Hide All Code

# Single Cell Proteomics data modelling using scplainer

Laurent Gatto and Christophe Vanderaa

#### 30 October 2025

#### Package

scp 1.20.0

# 1 Introduction

In this tutorial, we’ll walk you through the process of modelling
single-cell proteomics (SCP) data using the *scplainer* approach
(Vanderaa and Gatto ([2024](#ref-Vanderaa2023-scplainer))). By the end of this vignette, you will be
able to:

* Define and estimate a model suitable for SCP data
* Filter peptides based on the patterns of missing values
* Exploring the model output through analysis of variance
* Exploring the model output through differential abundance analysis
* Exploring the model output through component analysis
* Perform batch correction to remove unwanted technical artefacts

The last point will allow you to generate SCP data that is suitable
for downstream analysis, such as clustering or trajectory inference.
The figure below provides a roadmap of the workflow:

![](data:image/png;base64...)

scplainer modelling workflow

The vignette will start with the processed data extracted as a
`SingleCellExperiment` object from a processed `QFeatures` object.
Note that using a `SummarizedExperiment` will also work, it will
automatically be converted to a `SingleCellExperiment` object
with `scpModelWorkflow`.
We will not cover data processing as it is covered in another vignette.

```
library("scp")
library("SingleCellExperiment")
library("patchwork")
library("ggplot2")
```

# 2 Example data set

The example data set is a subset of the `leduc2022_pSCoPE` data set
(see `?scpdata::leduc2022_pSCoPE` for more info). The data is acquired
using TMT-18 multiplexing and data-dependent acquisition (DDA). The
data has been processed using a minimal workflow:

* Any zero value has been replaced by NA.
* Any peptide was removed from the data set if it matched to a decoy or
  contaminant peptide, had low spectral purity, had low identification
  confidence, or had a high sample to carrier ratio.
* Any cell was removed from the data set if it had a high coefficient of
  variation, had an abberrant median intensity, or had few identified
  peptides.
* PSM data were combined into peptide data. When multiple PSM match to
  the same peptide, the median intensity was taken.
* Intensities were log2 transformed
* To limit intensive computation, we have limited the data set to 200
  peptides in 73 cells.

We suggest using this minimal processing workflow, although the
approach presented here is agnostic of previous processing and allows
for other custom workflows. The data processing was conducted with
`QFeatures` and `scp`.

```
data("leduc_minimal")
leduc_minimal
#> class: SingleCellExperiment
#> dim: 200 73
#> metadata(1): model
#> assays(1): ''
#> rownames(200): SAVEDEGLK APNVVVTR ... FLLAVSRDR EASMVITESPAALQLR
#> rowData names(6): Sequence Reverse ... Leading.razor.protein.symbol
#>   gene
#> colnames(73): eAL00219RI5 eAL00219RI6 ... wAL00286RI17 wAL00286RI18
#> colData names(12): Set Channel ... MedianCV passQC
#> reducedDimNames(0):
#> mainExpName: NULL
#> altExpNames(0):
```

The data set is formatted as a `SingleCellExperiment` object. The data
set consists of 200 peptides and 73 cells. Peptide annotations can be
retrieved from the `rowData` and cell annotations can be retrieved
from the `colData`. The cell annotation will be used during modelling.

A full reanalysis of Leduc’s nPOP dataset is also available
[here](https://uclouvain-cbio.github.io/SCP.replication/articles/scplainer_leduc2022.html).

# 3 Data modelling

The core of the approach relies on statistical modelling of the data
using linear regression. Under the hood, the model fetches as
input the intensity matrix stored in `assay(leduc_minimal)`.
The cell annotations are retrieved using `colData(leduc_minimal)`.
They describe known technical and biological variables that may
influence the acquired peptide intensities. The annotations are used
to build a regression model with \(p\) parameters. Then, the model
estimates the coefficients. Coefficients provide the contributions of
each parameter to the expression of each of peptide as well as the
uncertainty of the estimation. These will be explored in the following
section.

We’ll start by defining the variables to include in the model. Recall
that the example data set contains TMT-labeled cells. This means that
each MS acquisition run contains multiple cells. Each run is subject
to technical fluctuations that can lead to undesired variation, this is
known as a batch effect.

```
table(leduc_minimal$Set)
#>
#> eAL00219 eAL00220 eAL00221 wAL00284 wAL00285 wAL00286
#>       13       12       12       12       12       12
```

The labelling reagent (`Channel`) can also
lead to undesired systematic effects and will also be considered as a
source for batch effects.

```
table(leduc_minimal$Channel)
#>
#>  TMT126 TMT127N TMT127C TMT128N TMT128C TMT129N TMT129C TMT130N TMT130C TMT131N
#>       0       0       0       0       6       5       6       6       5       4
#> TMT131C TMT132N TMT132C TMT133N TMT133C TMT134N TMT134C TMT135N
#>       5       5       5       6       5       5       5       5
```

Finally, each cell is processed individually and the amount of peptide
material recovered from each cell may lead to undesired variation as
well. This issue is usually solved through normalization, such as
removing the median intensity from each cell. Normalization was
internationally omitted in the minimal data processing so that we can
account for it during modelling. The median intensity were already
computed (`MedianIntensity`).

```
hist(leduc_minimal$MedianIntensity, breaks = 10)
```

![](data:image/png;base64...)

Finally, the biological variable of interest in the example data set
is the cell type that is known because cells come from 2 cell lines
(`SampleType`).

```
table(leduc_minimal$SampleType)
#>
#> Melanoma Monocyte
#>       37       36
```

We create a `formula` object that will define which variable must be
modelled in our analysis.

```
f <- ~ 1 + ## intercept
    Channel + Set + ## batch variables
    MedianIntensity + ## normalization
    SampleType ## biological variable
```

Note that the formula can be adapted to the data set. For instance, no
labelling reagents is used for LFQ experiments, so it can be dropped.
Similarly, each cell in an LFQ experiment is acquired in a single run
so MS run cannot be used as a batch effect variable. The day of
acquisition could be used instead.

Once a model is defined, we fit it with `scpModelWorkflow()`.

```
leduc_minimal <- scpModelWorkflow(leduc_minimal, formula = f)
#> Warning in scpModelWorkflow(leduc_minimal, formula = f): An element called
#> 'model' is already present in the metadata. The associated content will be
#> overwritten.
```

You can always retrieve the formula that was used to fit model using

```
scpModelFormula(leduc_minimal)
#> ~1 + Channel + Set + MedianIntensity + SampleType
```

The data that is modelled by each variable are contained in the
so-called effect matrices.

```
scpModelEffects(leduc_minimal)
#> List of length 4
#> names(4): Channel Set MedianIntensity SampleType
```

Similarly, the data that could not be captured by the model are
contained in the residual matrix.

```
scpModelResiduals(leduc_minimal)[1:5, 1:5]
#>                eAL00219RI5 eAL00219RI6 eAL00219RI7 eAL00219RI8 eAL00219RI9
#> SAVEDEGLK               NA          NA          NA          NA          NA
#> APNVVVTR        -0.2112685   0.2569749 -0.08076257 -0.03317054  0.06679681
#> IVVVTAGVR               NA          NA          NA          NA          NA
#> GFQEVVTPNIFNSR   0.6375780  -0.3356473  0.34648412 -0.80982152  0.96378484
#> ENAYDLEANLAVLK          NA          NA          NA          NA          NA
```

Finally, the input data used to model the can also be retrieved.

```
scpModelInput(leduc_minimal)[1:5, 1:5]
#>                eAL00219RI5 eAL00219RI6 eAL00219RI7 eAL00219RI8 eAL00219RI9
#> SAVEDEGLK               NA          NA          NA          NA          NA
#> APNVVVTR          13.56997    13.85389   13.362218   13.110304    14.03041
#> IVVVTAGVR               NA          NA          NA          NA          NA
#> GFQEVVTPNIFNSR    10.78733     9.36700    9.815223    7.878296    11.01890
#> ENAYDLEANLAVLK          NA          NA          NA          NA          NA
```

Note that the number of peptides changed. This is the consequence of
peptide filtering.

```
dim(scpModelInput(leduc_minimal))
#> [1] 140  73
```

# 4 Peptide filtering

The proportion of missing values for each features is high in
single-cell proteomics data.

```
table(missing = is.na(assay(leduc_minimal)))
#> missing
#> FALSE  TRUE
#>  5954  8646
```

Many features can typically contain more coefficients to estimate than
observed values. These features cannot be estimated and will be
ignored during further steps. These features are identified by
computing the ratio between the number of observed values and the
number of coefficients to estimate. We call it the n/p ratio.
You can extract the n/p ratio for each feature:

```
head(scpModelFilterNPRatio(leduc_minimal))
#>      SAVEDEGLK       APNVVVTR      IVVVTAGVR GFQEVVTPNIFNSR ENAYDLEANLAVLK
#>       1.277778       3.476190       1.411765       2.333333       1.235294
#>      IGPLGLSPK
#>       1.888889
```

Once the model is estimated, use `scpModelFilterPlot()` to explore the
distribution of n/p ratios across the features.

```
scpModelFilterPlot(leduc_minimal)
#> To change the threshold, use:
#> scpModelFilterThreshold(object, name) <- threshold
```

![](data:image/png;base64...)

By default, any feature that has an n/p ration greater than 1 is
included in the analysis. However, feature with an n/p ratio close to
1 may lead to unreliable outcome because there are not enough observed
data. You could consider the n/p ratio as the average number of
replicate per coefficient to estimate. Therefore, you may want to
increase the n/p threshold.

```
scpModelFilterThreshold(leduc_minimal) ## default is 1
#> [1] 1
scpModelFilterThreshold(leduc_minimal) <- 1.5
scpModelFilterThreshold(leduc_minimal) ## threshold is now 1.5
#> [1] 1.5
```

The plot is automatically updated.

```
scpModelFilterPlot(leduc_minimal)
#> To change the threshold, use:
#> scpModelFilterThreshold(object, name) <- threshold
```

![](data:image/png;base64...)

There is no guidelines for defining a suitable threshold. If too low,
you may include noisy peptides that have too few observations. If too
high, you may remove many informative peptides. The definition of the
threshold relies on a trade off between precision and sensitivity.

# 5 Model exploration: analysis of variance

The variance analysis reports the relative amount of information that
is captured by each cell annotation included in the model. The model
also includes the residual information that is not captured by the
model. This offers a first glimpse into what information is contained
in the data.

```
(vaRes <- scpVarianceAnalysis(leduc_minimal))
#> DataFrameList of length 5
#> names(5): Residuals Channel Set MedianIntensity SampleType
```

The results are a list of tables, one table for each variable. Each
table reports for each peptide the variance captures (`SS`), the
residual degrees of freedom for estimating the variance (`df`) and the
percentage of total variance explained (`percentExplainedVar`).

```
vaRes$SampleType
#> DataFrame with 95 rows and 4 columns
#>           feature         SS        df percentExplainedVar
#>       <character>  <numeric> <numeric>           <numeric>
#> 1        APNVVVTR 27.8682309        52           33.052188
#> 2   GFQEVVTPNI...  0.1106189        28            0.392004
#> 3       IGPLGLSPK  0.0442532        16            0.242434
#> 4   VAETANEEEV...  0.4973533        11            2.694342
#> 5   IDATSASVLA...  0.9271610        36            2.174504
#> ...           ...        ...       ...                 ...
#> 91  SVPTSTVFYP...    1.88199        48             4.60836
#> 92      HIVENAVQK    1.05939        19             4.80442
#> 93  TDMDNQIVVS...    4.31709         9            24.56762
#> 94       AILGSVER    2.51736        16            15.90057
#> 95     LGAEVYHTLK    2.47027        15            10.14771
```

By default, we explore the variance for all peptides combined:

```
scpVariancePlot(vaRes)
```

![](data:image/png;base64...)

We explore the top 20 peptides that are have the highest percentage of
variance explained by the biological variable (top) or by the batch
variable (bottom).

```
scpVariancePlot(
    vaRes, top = 10, by = "percentExplainedVar", effect = "SampleType",
    decreasing = TRUE, combined = FALSE
) +
    scpVariancePlot(
    vaRes, top = 10, by = "percentExplainedVar", effect = "Set",
    decreasing = TRUE, combined = FALSE
) +
    plot_layout(ncol = 1, guides = "collect")
```

![](data:image/png;base64...)

We can also group the peptide by protein. To do so, we first need to
add the peptides annotations available from the `rowData`.

```
vaRes <- scpAnnotateResults(
    vaRes, rowData(leduc_minimal), by = "feature", by2 = "Sequence"
)
vaRes$SampleType
#> DataFrame with 95 rows and 9 columns
#>           feature         SS        df percentExplainedVar     Reverse
#>       <character>  <numeric> <numeric>           <numeric> <character>
#> 1        APNVVVTR 27.8682309        52           33.052188
#> 2   GFQEVVTPNI...  0.1106189        28            0.392004
#> 3       IGPLGLSPK  0.0442532        16            0.242434
#> 4   VAETANEEEV...  0.4973533        11            2.694342
#> 5   IDATSASVLA...  0.9271610        36            2.174504
#> ...           ...        ...       ...                 ...         ...
#> 91  SVPTSTVFYP...    1.88199        48             4.60836
#> 92      HIVENAVQK    1.05939        19             4.80442
#> 93  TDMDNQIVVS...    4.31709         9            24.56762
#> 94       AILGSVER    2.51736        16            15.90057
#> 95     LGAEVYHTLK    2.47027        15            10.14771
#>     Potential.contaminant Leading.razor.protein.id Leading.razor.protein.symbol
#>               <character>              <character>                  <character>
#> 1                                           P52566                        GDIR2
#> 2                                           P26639                         SYTC
#> 3                                           P30050                         RL12
#> 4                                           P61221                        ABCE1
#> 5                                           P13667                        PDIA4
#> ...                   ...                      ...                          ...
#> 91                                          P29401                          TKT
#> 92                                          O00410                         IPO5
#> 93                                          P50991                         TCPD
#> 94                                          P26639                         SYTC
#> 95                                          P09104                         ENOG
#>            gene
#>     <character>
#> 1       ARHGDIB
#> 2          TARS
#> 3         RPL12
#> 4         ABCE1
#> 5         PDIA4
#> ...         ...
#> 91          TKT
#> 92         IPO5
#> 93         CCT4
#> 94         TARS
#> 95         ENO2
```

Then, we draw the same plot, but this time we provide the `fcol`
argument.

```
scpVariancePlot(
    vaRes, top = 10, by = "percentExplainedVar", effect = "SampleType",
    decreasing = TRUE, combined = FALSE, fcol = "gene"
) +
    scpVariancePlot(
    vaRes, top = 10, by = "percentExplainedVar", effect = "Set",
    decreasing = TRUE, combined = FALSE, fcol = "gene"
) +
    plot_layout(ncol = 1, guides = "collect")
```

![](data:image/png;base64...)

In this example dataset, we retrieve peptides that all belong to a
different protein, however grouping becomes interesting when analyzing
real data sets.

Alternatively, we can generate protein level results by aggregating
peptide level results.

```
vaProtein <- scpVarianceAggregate(vaRes, fcol = "gene")
scpVariancePlot(
    vaProtein, effect = "SampleType", top = 10, combined = FALSE
)
```

![](data:image/png;base64...)

# 6 Model exploration: differential abundance analysis

Differential abundance analysis dives deeper into the exploration of
the data, namely for exploring the biological effects. Given two
groups of interest, such as two cell types or two treatment groups,
the differential analysis derives estimated fold changes from the
linear model’s coefficients. This provides information, for each
peptide or protein, the amount of change between the two groups and
the direction of the change. Moreover, the model provides the
uncertainty of the differences, enabling the assessment of the
statistical significance.

The difference of interest is specified using the `contrast` argument.
The first element points to the variable to test and the two following
element are the groups of interest to compare. You can provide
multiple contrast in a list.

```
(daRes <- scpDifferentialAnalysis(
    leduc_minimal,
    contrasts = list(c("SampleType", "Melanoma", "Monocyte"))
))
#> DataFrameList of length 1
#> names(1): SampleType_Melanoma_vs_Monocyte
```

Similarly to variance analysis, the results are a list of tables, one
table for each contrast. Each table reports for each peptide the
estimated difference between the two groups, the standard error
associated to the estimation, the degrees of freedom, the
t-statistics, the associated p-value and the p-value FDR-adjusted for
multiple testing across all peptides.

```
daRes$SampleType_Melanoma_vs_Monocyte
#> DataFrame with 95 rows and 7 columns
#>           feature   Estimate        SE        Df tstatistic      pvalue
#>       <character>  <numeric> <numeric> <numeric>  <numeric>   <numeric>
#> 1        APNVVVTR  1.2357291  0.140225        52   8.812466 6.77782e-12
#> 2   GFQEVVTPNI... -0.0950269  0.312985        28  -0.303615 7.63666e-01
#> 3       IGPLGLSPK -0.0721544  0.375395        16  -0.192209 8.49997e-01
#> 4   VAETANEEEV... -0.2619169  0.486300        11  -0.538591 6.00898e-01
#> 5   IDATSASVLA... -0.2573437  0.249598        36  -1.031031 3.09404e-01
#> ...           ...        ...       ...       ...        ...         ...
#> 91  SVPTSTVFYP...  -0.330304  0.202807        48  -1.628658    0.109932
#> 92      HIVENAVQK   0.338421  0.495880        19   0.682466    0.503181
#> 93  TDMDNQIVVS...   0.814964  1.103851         9   0.738292    0.479146
#> 94       AILGSVER   0.544206  0.368422        16   1.477127    0.159054
#> 95     LGAEVYHTLK   0.547198  0.521144        15   1.049995    0.310344
#>            padj
#>       <numeric>
#> 1   6.43893e-10
#> 2   8.91820e-01
#> 3   9.06232e-01
#> 4   8.64161e-01
#> 5   6.81383e-01
#> ...         ...
#> 91     0.521039
#> 92     0.810207
#> 93     0.789070
#> 94     0.521039
#> 95     0.681383
```

We then visualize the results using a volcano plot. The function below
return a volcano plot for each contrast.

```
scpVolcanoPlot(daRes)
#> $SampleType_Melanoma_vs_Monocyte
```

![](data:image/png;base64...)

Since we subset the data set for only a few cell, we lack statistical
power. Still, two peptides come out as significant. Again, to better
explore the results, we add peptide annotations available from the
`rowData`, but we also add the n/p ratio as annotation.

```
daRes <- scpAnnotateResults(
    daRes, rowData(leduc_minimal),
    by = "feature", by2 = "Sequence"
)
np <- scpModelFilterNPRatio(leduc_minimal)
daRes <- scpAnnotateResults(
    daRes, data.frame(feature = names(np), npRatio = np),
    by = "feature"
)
```

We plot the same volcano plot, but instead of labeling points with
the peptide sequence, we will show the associated gene symbol. Also,
we can control for point aesthetics by providing a list of
`ggplot2::geom_point()` arguments. For example, we can colour each
point based on the n/p ratio, and adjust point size and shape.

```
scpVolcanoPlot(
    daRes, top = 30, textBy = "gene",
    pointParams = list(aes(colour = npRatio), size = 1.5, shape = 3)
)
#> $SampleType_Melanoma_vs_Monocyte
#> Warning: ggrepel: 13 unlabeled data points (too many overlaps). Consider
#> increasing max.overlaps
```

![](data:image/png;base64...)

We can also provide protein-level results. To do so, the
`scpDifferentialAggregate()` relies on the `metapod` package. We here
combine the statistical test results for peptides that belong to the
same protein using Simes’ method. Simes’ method will reject the
combined null hypothesis (that is the mean **protein** intensities are
identical between two groups) if any of the peptide nulls are
rejected.

```
byProteinDA <- scpDifferentialAggregate(
    daRes, fcol = "gene", method = "simes"
)
byProteinDA$SampleType_Melanoma_vs_Monocyte
#> DataFrame with 86 rows and 10 columns
#>         feature   Estimate    pvalue      padj     Reverse
#>     <character>  <numeric> <numeric> <numeric> <character>
#> 1         ABCE1 -0.2619169 0.6008984  0.856797
#> 2          ACLY -1.0078958 0.0564024  0.404217
#> 3         ACTN4 -0.0576889 0.8105808  0.910420
#> 4         AIFM1  0.4300612 0.1488197  0.530259
#> 5         APMAP  0.0683780 0.7445601  0.901862
#> ...         ...        ...       ...       ...         ...
#> 82         TPP2 -0.2494580 0.4703385  0.812359
#> 83       TUBA1C -0.6951016 0.0492061  0.384702
#> 84         VAT1 -0.4073205 0.0691403  0.457390
#> 85        XRCC6  0.0289353 0.8832055  0.915129
#> 86        YWHAG -0.0979855 0.6550366  0.873363
#>     Potential.contaminant Leading.razor.protein.id Leading.razor.protein.symbol
#>               <character>              <character>                  <character>
#> 1                                           P61221                        ABCE1
#> 2                                           P53396                         ACLY
#> 3                                           O43707                        ACTN4
#> 4                                           O95831                        AIFM1
#> 5                                           Q9HDC9                        APMAP
#> ...                   ...                      ...                          ...
#> 82                                          P29144                         TPP2
#> 83                                          Q9BQE3                        TBA1C
#> 84                                          Q99536                         VAT1
#> 85                                          P12956                        XRCC6
#> 86                                          P61981                        1433G
#>            gene        .n
#>     <character> <integer>
#> 1         ABCE1         1
#> 2          ACLY         1
#> 3         ACTN4         1
#> 4         AIFM1         1
#> 5         APMAP         1
#> ...         ...       ...
#> 82         TPP2         1
#> 83       TUBA1C         1
#> 84         VAT1         2
#> 85        XRCC6         1
#> 86        YWHAG         1
```

# 7 Model exploration: component analysis

Variance and differential analysis are not specific to single-cell
applications and explore the data without considering cellular
heterogeneity. The purpose of the component analysis is to dive into
the cellular heterogeneity by representing highly dimensional data in
a few informative dimensions for visual exploration. We integrate the
component analysis with the linear regression model thanks to the
APCA+ (extended ANOVA-simultaneous component analysis) framework
developed by [Thiel et al. 2017](http://dx.doi.org/10.1002/cem.2895).
Briefly, APCA+ explores the reconstructed data that is captured by each variable
separately in the presence of the unmodelled data. The advantage of
this framework is it is generic and works for any linear model. Also,
this approach is well suited for single-cell applications as it
enables the visualization and exploration of the effects of a known
variable along the unmodelled information that contains cellular
heterogeneity.

```
(caRes <- scpComponentAnalysis(
    leduc_minimal, ncomp = 20, method = "APCA", effect = "SampleType"
))
#> List of length 2
#> names(2): bySample byFeature
```

The results are contained in a list with 2 elements. `bySample`
contains the PC scores, that is the component results in cell space.
`byFeature` contains the eigenvectors, that is the component results
in peptide space. Each of the two elements contains components results
for the data before modelling (`unmodelled`), for the residuals or for
the APCA on the sample type variable (`APCA_SampleType`).

```
(caResCells <- caRes$bySample)
#> List of length 3
#> names(3): unmodelled residuals APCA_SampleType
caResCells[[1]]
#> DataFrame with 73 rows and 21 columns
#>                    PC1       PC2       PC3       PC4        PC5       PC6
#>              <numeric> <numeric> <numeric> <numeric>  <numeric> <numeric>
#> eAL00219RI5   1.652635  3.711020  -4.21156 -1.079196  0.0666983  1.408647
#> eAL00219RI6   0.122763  5.156328  -5.49091  0.184137 -0.3458518  1.048142
#> eAL00219RI7  -1.356183  6.042980  -5.04466  0.372945 -2.1629620  0.234317
#> eAL00219RI8  -2.700162  4.483173  -5.34451  0.548601 -1.5492215 -0.345117
#> eAL00219RI9   2.546416  0.572361  -5.35620  0.723007 -0.1841323  4.479647
#> ...                ...       ...       ...       ...        ...       ...
#> wAL00286RI12  -7.98580 -1.856855  0.757797  2.716883   0.389962  1.670132
#> wAL00286RI14  -8.20192 -0.746896  1.535207 -1.595404   2.795661  0.498499
#> wAL00286RI16  -1.81072 -2.407762  3.963677 -1.732718   0.143329 -0.745458
#> wAL00286RI17  -2.86441 -3.393967 -1.515343 -1.529139  -2.434284  0.121065
#> wAL00286RI18  -2.25612 -4.270107  0.987672 -0.145896  -1.382700 -1.306674
#>                    PC7       PC8       PC9       PC10       PC11        PC12
#>              <numeric> <numeric> <numeric>  <numeric>  <numeric>   <numeric>
#> eAL00219RI5   -1.40664 -0.569028  1.816091  -0.335920  -3.425797   -0.261528
#> eAL00219RI6   -2.03264  0.242179  2.257062   0.808499  -1.271131    0.486000
#> eAL00219RI7   -1.26036 -1.921333 -0.241230   0.825305  -1.820185    2.704122
#> eAL00219RI8   -1.31727 -0.876115 -0.826323   2.179410   2.105049    0.760836
#> eAL00219RI9    1.28303  0.785622 -0.545883  -0.625327  -0.676794   -0.943669
#> ...                ...       ...       ...        ...        ...         ...
#> wAL00286RI12  1.117698 -0.812645 -0.223081 -0.4827100  1.1006363 -0.99808069
#> wAL00286RI14  0.979609 -0.959699  3.834839 -0.9982881  0.3246867 -0.00491314
#> wAL00286RI16  3.800138 -1.646333  1.374409 -1.5396094 -0.8875749  2.42672153
#> wAL00286RI17  1.894991 -0.681766 -0.612739  0.0177883 -0.4717603  1.93884428
#> wAL00286RI18  1.586430 -1.000224 -0.140993  0.8425007 -0.0447968  1.01835905
#>                    PC13       PC14      PC15      PC16       PC17      PC18
#>               <numeric>  <numeric> <numeric> <numeric>  <numeric> <numeric>
#> eAL00219RI5   1.3248564 -0.6213675  0.275210 -0.376301  0.2819763 -0.112223
#> eAL00219RI6  -0.0312991  0.1282374 -0.977545 -0.638003 -0.0905137  0.443276
#> eAL00219RI7   0.2210126 -0.8594984 -1.371305  0.293012 -1.2920848 -0.211974
#> eAL00219RI8  -0.1068177 -0.0299786 -0.293472 -1.618090  1.0066113  0.699695
#> eAL00219RI9  -0.1327679  0.8920529  0.332752 -1.424903  0.2110955  0.484973
#> ...                 ...        ...       ...       ...        ...       ...
#> wAL00286RI12   1.258691  -1.038123  0.715850  0.594017 -0.0320364  0.386167
#> wAL00286RI14  -1.463484  -1.115054  1.304641  0.471641 -1.2468862  1.135240
#> wAL00286RI16  -0.128652   0.438629  0.405675 -1.249913  0.8714631 -0.245134
#> wAL00286RI17  -2.385663  -0.696050 -0.636856 -0.639397 -0.5319913  0.677671
#> wAL00286RI18   0.286674   0.861364 -0.262798  1.071512 -0.0554080 -0.132846
#>                    PC19       PC20          cell
#>               <numeric>  <numeric>   <character>
#> eAL00219RI5  -0.2408148 -0.4442979 eAL00219RI...
#> eAL00219RI6  -0.0921259  0.0940622 eAL00219RI...
#> eAL00219RI7  -0.3802431  0.7556116 eAL00219RI...
#> eAL00219RI8   0.2000259 -0.5325636 eAL00219RI...
#> eAL00219RI9  -1.0358553  1.0556220 eAL00219RI...
#> ...                 ...        ...           ...
#> wAL00286RI12  -0.244162  1.4868339 wAL00286RI...
#> wAL00286RI14   0.602194  0.0939671 wAL00286RI...
#> wAL00286RI16  -1.108754  0.3540490 wAL00286RI...
#> wAL00286RI17   0.955012  0.7391520 wAL00286RI...
#> wAL00286RI18   2.147393  0.3731584 wAL00286RI...
```

Let’s explore the component analysis in cell space. Similarly to the
previous explorations, we annotate the results.

```
leduc_minimal$cell <- colnames(leduc_minimal)
caResCells <- scpAnnotateResults(
    caResCells, colData(leduc_minimal), by = "cell"
)
```

We then generate the component plot. Providing the `pointParams`
argument, we can shape the points by `SampleType`. To assess the
impact of batch effects, we also colour the points according to
the MS acquisition run.

```
scpComponentPlot(
    caResCells,
    pointParams = list(aes(shape = SampleType, colour = Set))
) |>
    wrap_plots(ncol = 1, guides = "collect")
```

![](data:image/png;base64...)

While the data before modelling is mainly driven by batch effects, the
APCA clearly separates the two cell populations. The plot can however
only show 2 components at a time. We can explore more components using
a subsequent dimension reduction, such as t-SNE. The `scater` package
offers a comprehensive set of tools for dimension reduction on data
contained in a `SingleCellExperiment` object and requires the
components to be stored in the `reducedDim` slot. This is streamlined
thanks to `addReducedDims()`.

```
leduc_minimal <- addReducedDims(leduc_minimal, caResCells)
reducedDims(leduc_minimal)
#> List of length 3
#> names(3): unmodelled residuals APCA_SampleType
```

We can now explore the `SampleType` effects for the 20 computed
components through t-SNE.

```
library("scater")
leduc_minimal <- runTSNE(leduc_minimal, dimred = "APCA_SampleType")
plotTSNE(leduc_minimal, colour_by = "Set", shape_by = "SampleType") +
    ggtitle("t-SNE on 20 APCA components")
```

![](data:image/png;base64...)

The two cell populations remain clearly separated with an
excellent mixing of the acquisition runs, even when considering the
20 first APCA components.

We use the same approach to explore the component results in peptide
space.

```
caResPeps <- caRes$byFeature
caResPeps <- scpAnnotateResults(
    caResPeps, rowData(leduc_minimal), by = "feature", by2 = "Sequence"
)
scpComponentPlot(
    caResPeps, pointParams = list(size = 0.8, alpha = 0.4)
) |>
    wrap_plots(ncol = 1)
```

![](data:image/png;base64...)

This exploration may identify groups of covarying peptides, although
no clear patterns appear in the example data set.

We can also combine the exploration of the components in cell and
peptide space. This is possible thanks to biplots.

```
scpComponentBiplot(
    caResCells, caResPeps,
    pointParams = list(aes(colour = SampleType)),
    labelParams = list(size = 1.5, max.overlaps = 15),
    textBy = "gene", top = 10
) |>
    wrap_plots(ncol = 1, guides = "collect")
```

![](data:image/png;base64...)

Finally, we offer functionality to aggregate the results at the
protein level instead of the peptide level.

```
caResProts <- scpComponentAggregate(caResPeps, fcol = "gene")
#> Components may no longer be orthogonal after aggregation.
caResProts$APCA_SampleType
#> DataFrame with 86 rows and 26 columns
#>                PC1        PC2        PC3        PC4         PC5          PC6
#>          <numeric>  <numeric>  <numeric>  <numeric>   <numeric>    <numeric>
#> ABCE1   -0.0523935 -0.0136777  0.0903348  0.1693285   0.0665345    0.0493461
#> ACLY    -0.2188357  0.0295186 -0.2475794 -0.0555763  -0.1122432    0.0431707
#> ACTN4   -0.0119062  0.0384471  0.2774156 -0.0797822  -0.0941029   -0.1243163
#> AIFM1    0.1006538 -0.0362258  0.1976476  0.0301861  -0.1747488    0.0622619
#> APMAP    0.0195111  0.0211236  0.0436172  0.0675338   0.0634203    0.1031632
#> ...            ...        ...        ...        ...         ...          ...
#> TPP2   -0.05528458 -0.0310194  0.0431430 -0.1027764 -0.08156241 -0.015980101
#> TUBA1C -0.14532912 -0.0163971  0.0198204  0.0211471 -0.02163806 -0.000503111
#> VAT1   -0.08475507 -0.0831661  0.1167588  0.0591425 -0.00581566 -0.013318437
#> XRCC6   0.00292548  0.0614277  0.1692137  0.0295988 -0.02905814 -0.000397610
#> YWHAG  -0.00908836  0.1134883 -0.2952287  0.0902165 -0.12814301  0.008616979
#>               PC7        PC8        PC9        PC10       PC11       PC12
#>         <numeric>  <numeric>  <numeric>   <numeric>  <numeric>  <numeric>
#> ABCE1   0.0288414  0.0154912 -0.0128954  -0.0168423  0.0485774 -0.0481859
#> ACLY    0.0716542 -0.1018500 -0.0276287  -0.0739296  0.0719484  0.1163738
#> ACTN4  -0.0886529  0.0746792 -0.0886262  -0.2615099 -0.0949204  0.2439664
#> AIFM1   0.0447698 -0.1740009  0.0274838   0.0931568 -0.0445237  0.1537508
#> APMAP  -0.0839194  0.0436465 -0.0291126  -0.1366302  0.0780494 -0.0467466
#> ...           ...        ...        ...         ...        ...        ...
#> TPP2   0.01002283  0.0613254 -0.0657707 -0.02449126 -0.0726705  0.0386026
#> TUBA1C 0.02632304 -0.0177832  0.0100838 -0.00880753 -0.0311755  0.0127917
#> VAT1   0.00580065 -0.0525127 -0.0188442 -0.13095970  0.1962062  0.0253535
#> XRCC6  0.10658824 -0.0676993 -0.0815302  0.23972712  0.1148027  0.0353619
#> YWHAG  0.01593590 -0.0617372 -0.0961599  0.18878619  0.0708525  0.1197667
#>                PC13       PC14        PC15       PC16        PC17       PC18
#>           <numeric>  <numeric>   <numeric>  <numeric>   <numeric>  <numeric>
#> ABCE1  -0.001663287  0.0343296   0.0343627  0.0990232  0.01865067 -0.0327103
#> ACLY    0.192738461  0.1474133  -0.1739438  0.1289705  0.05033950  0.0287668
#> ACTN4  -0.133406589  0.0132553  -0.0693790 -0.0808312 -0.08205540  0.2087751
#> AIFM1  -0.077020737 -0.0493539  -0.1162488  0.0365235  0.00510608 -0.1441099
#> APMAP  -0.000121253 -0.1390497  -0.0867093 -0.0410053 -0.11611495  0.1792133
#> ...             ...        ...         ...        ...         ...        ...
#> TPP2     0.07597089  0.0558818 -0.00337644 -0.0121018  0.04283655  0.0476116
#> TUBA1C  -0.02998746 -0.0217296 -0.00789350  0.0565058 -0.00373714 -0.0119916
#> VAT1    -0.05204097 -0.0852005 -0.02017030  0.0952139 -0.16910390 -0.0715073
#> XRCC6   -0.00257737  0.0259900  0.10724778 -0.0564281  0.08246124  0.0499968
#> YWHAG    0.03318137  0.0621676 -0.05404994  0.0792021 -0.12921509 -0.0384467
#>              PC19       PC20     Reverse Potential.contaminant
#>         <numeric>  <numeric> <character>           <character>
#> ABCE1  -0.0365880 -0.0681561
#> ACLY    0.1118103 -0.0208683
#> ACTN4   0.0596604  0.0966149
#> AIFM1  -0.2174666  0.1085721
#> APMAP  -0.0331397  0.1518794
#> ...           ...        ...         ...                   ...
#> TPP2   -0.0150711  0.0560492
#> TUBA1C -0.0269349  0.0296168
#> VAT1    0.0480006  0.1489793
#> XRCC6   0.0529253 -0.0198865
#> YWHAG  -0.1012201  0.1127549
#>        Leading.razor.protein.id Leading.razor.protein.symbol        gene
#>                     <character>                  <character> <character>
#> ABCE1                    P61221                        ABCE1       ABCE1
#> ACLY                     P53396                         ACLY        ACLY
#> ACTN4                    O43707                        ACTN4       ACTN4
#> AIFM1                    O95831                        AIFM1       AIFM1
#> APMAP                    Q9HDC9                        APMAP       APMAP
#> ...                         ...                          ...         ...
#> TPP2                     P29144                         TPP2        TPP2
#> TUBA1C                   Q9BQE3                        TBA1C      TUBA1C
#> VAT1                     Q99536                         VAT1        VAT1
#> XRCC6                    P12956                        XRCC6       XRCC6
#> YWHAG                    P61981                        1433G       YWHAG
#>               .n
#>        <integer>
#> ABCE1          1
#> ACLY           1
#> ACTN4          1
#> AIFM1          1
#> APMAP          1
#> ...          ...
#> TPP2           1
#> TUBA1C         1
#> VAT1           2
#> XRCC6          1
#> YWHAG          1
```

Note that the aggregated tables in `caResProts` can be explored with
the visualisation function `scpComponentPlot()`.

# 8 Batch correction

Based on the estimated model, we generate batch-corrected data, that
is data with only the effect of cell type and the residual data. We
also remove the intercept.

```
(leduc_batchCorrect <- scpRemoveBatchEffect(
    leduc_minimal, effects = c("Set", "Channel", "MedianIntensity"),
    intercept = TRUE
))
#> class: SingleCellExperiment
#> dim: 95 73
#> metadata(0):
#> assays(1): ''
#> rownames(95): APNVVVTR GFQEVVTPNIFNSR ... AILGSVER LGAEVYHTLK
#> rowData names(6): Sequence Reverse ... Leading.razor.protein.symbol
#>   gene
#> colnames(73): eAL00219RI5 eAL00219RI6 ... wAL00286RI17 wAL00286RI18
#> colData names(13): Set Channel ... passQC cell
#> reducedDimNames(0):
#> mainExpName: NULL
#> altExpNames(0):
```

Note that the batch-corrected data still contain missing values. The
`leduc_batchCorrect` object can be used for downstream analysis.

# Session information

```
R version 4.5.1 Patched (2025-08-23 r88802)
Platform: x86_64-pc-linux-gnu
Running under: Ubuntu 24.04.3 LTS

Matrix products: default
BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0

locale:
 [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
 [3] LC_TIME=en_GB              LC_COLLATE=C
 [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
 [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
 [9] LC_ADDRESS=C               LC_TELEPHONE=C
[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

time zone: America/New_York
tzcode source: system (glibc)

attached base packages:
[1] stats4    stats     graphics  grDevices utils     datasets  methods
[8] base

other attached packages:
 [1] patchwork_1.3.2             scater_1.38.0
 [3] scuttle_1.20.0              SingleCellExperiment_1.32.0
 [5] sva_3.58.0                  BiocParallel_1.44.0
 [7] genefilter_1.92.0           mgcv_1.9-3
 [9] nlme_3.1-168                dplyr_1.1.4
[11] scpdata_1.17.1              ExperimentHub_3.0.0
[13] AnnotationHub_4.0.0         BiocFileCache_3.0.0
[15] dbplyr_2.5.1                ggplot2_4.0.0
[17] scp_1.20.0                  QFeatures_1.20.0
[19] MultiAssayExperiment_1.36.0 SummarizedExperiment_1.40.0
[21] Biobase_2.70.0              GenomicRanges_1.62.0
[23] Seqinfo_1.0.0               IRanges_2.44.0
[25] S4Vectors_0.48.0            BiocGenerics_0.56.0
[27] generics_0.1.4              MatrixGenerics_1.22.0
[29] matrixStats_1.5.0           BiocStyle_2.38.0

loaded via a namespace (and not attached):
  [1] RColorBrewer_1.1-3      jsonlite_2.0.0          magrittr_2.0.4
  [4] ggbeeswarm_0.7.2        farver_2.1.2            rmarkdown_2.30
  [7] vctrs_0.6.5             memoise_2.0.1           htmltools_0.5.8.1
 [10] S4Arrays_1.10.0         BiocBaseUtils_1.12.0    curl_7.0.0
 [13] BiocNeighbors_2.4.0     SparseArray_1.10.0      sass_0.4.10
 [16] bslib_0.9.0             plyr_1.8.9              httr2_1.2.1
 [19] impute_1.84.0           cachem_1.1.0            igraph_2.2.1
 [22] lifecycle_1.0.4         pkgconfig_2.0.3         rsvd_1.0.5
 [25] Matrix_1.7-4            R6_2.6.1                fastmap_1.2.0
 [28] clue_0.3-66             digest_0.6.37           fdrtool_1.2.18
 [31] AnnotationDbi_1.72.0    irlba_2.3.5.1           lpsymphony_1.38.0
 [34] RSQLite_2.4.3           beachmat_2.26.0         filelock_1.0.3
 [37] labeling_0.4.3          httr_1.4.7              abind_1.4-8
 [40] compiler_4.5.1          bit64_4.6.0-1           withr_3.0.2
 [43] S7_0.2.0                viridis_0.6.5           DBI_1.2.3
 [46] MASS_7.3-65             rappdirs_0.3.3          DelayedArray_0.36.0
 [49] tools_4.5.1             vipor_0.4.7             beeswarm_0.4.0
 [52] glue_1.8.0              grid_4.5.1              Rtsne_0.17
 [55] cluster_2.1.8.1         reshape2_1.4.4          gtable_0.3.6
 [58] tidyr_1.3.1             BiocSingular_1.26.0     ScaledMatrix_1.18.0
 [61] metapod_1.18.0          XVector_0.50.0          ggrepel_0.9.6
 [64] BiocVersion_3.22.0      pillar_1.11.1           stringr_1.5.2
 [67] limma_3.66.0            splines_4.5.1           lattice_0.22-7
 [70] FNN_1.1.4.1             survival_3.8-3          bit_4.6.0
 [73] annotate_1.88.0         tidyselect_1.2.1        locfit_1.5-9.12
 [76] Biostrings_2.78.0       knitr_1.50              gridExtra_2.3
 [79] bookdown_0.45           ProtGenerics_1.42.0     edgeR_4.8.0
 [82] IHW_1.38.0              xfun_0.53               statmod_1.5.1
 [85] stringi_1.8.7           lazyeval_0.2.2          yaml_2.3.10
 [88] evaluate_1.0.5          codetools_0.2-20        nipals_1.0
 [91] MsCoreUtils_1.22.0      tibble_3.3.0            BiocManager_1.30.26
 [94] cli_3.6.5               uwot_0.2.3              xtable_1.8-4
 [97] jquerylib_0.1.4         dichromat_2.0-0.1       Rcpp_1.1.0
[100] png_0.1-8               XML_3.99-0.19           parallel_4.5.1
[103] blob_1.2.4              AnnotationFilter_1.34.0 viridisLite_0.4.2
[106] slam_0.1-55             scales_1.4.0            purrr_1.1.0
[109] crayon_1.5.3            rlang_1.1.6             cowplot_1.2.0
[112] KEGGREST_1.50.0
```

# License

This vignette is distributed under a
[CC BY-SA license](https://creativecommons.org/licenses/by-sa/2.0/)
license.

# Reference

Vanderaa, Christophe, and Laurent Gatto. 2024. “scplainer: Using Linear Models to Understand Mass Spectrometry-Based Single-Cell Proteomics Data.” *bioRxiv*. <https://doi.org/10.1101/2023.12.14.571792>.