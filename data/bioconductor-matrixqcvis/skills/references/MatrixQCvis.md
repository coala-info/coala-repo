# MatrixQCvis: shiny-based interactive data quality exploration of omics data

Thomas Naake and Wolfgang Huber1

1European Molecular Biology Laboratory, Meyerhofstrasse 1, 69117 Heidelberg

#### 30 October 2025

#### Package

MatrixQCvis 1.18.0

# 1 Introduction

Data quality assessment is an integral part of preparatory data analysis
to ensure sound biological information retrieval.
We present here the `MatrixQCvis` package, which provides shiny-based
interactive visualization of data quality metrics at the per-sample and
per-feature level. It is broadly applicable to quantitative omics data types
that come in matrix-like format (features x samples). It enables the detection
of low-quality samples, drifts, outliers and batch effects in data sets.
Visualizations include amongst others bar- and violin plots of the
(count/intensity) values, mean vs standard deviation plots, MA plots,
empirical cumulative distribution function (ECDF) plots, visualizations
of the distances between samples, and multiple types of dimension reduction
plots.
`MatrixQCvis` builds upon the Bioconductor `SummarizedExperiment` S4
class and enables thus the facile integration into existing workflows.

`MatrixQCvis` is especially addressed to analyze the quality of proteomics and
metabolomics data sets that are characterized by missing values as it
allows the user for imputation of missing values and differential expression analysis
using the `proDA` package (Ahlman-Eltze and Anders [2019](#ref-Ahlmann2019)). Besides this, `MatrixQCvis` is
extensible to other type of data(e.g. transcriptomics count data) that can be
represented as a `SummarizedExperiment` object.
Furthermore, the `shiny` application facilitates simple differential
expression analysis using either moderated t-tests (from the `limma` package,
Ritchie et al. ([2015](#ref-Ritchie2015))) or Wald tests (from the `proDA` package, Ahlman-Eltze and Anders ([2019](#ref-Ahlmann2019))).

Within this vignette, the term feature will refer to a probed molecular entity,
e.g. gene, transcript, protein, peptide, or metabolite.

In the following, we will describe the major setup of `MatrixQCvis` and the
navigation through the shiny application, `shinyQC`.

# Questions and bugs

`MatrixQCvis` is currently under active development. If you
discover any bugs, typos or develop ideas of improving
`MatrixQCvis` feel free to raise an issue via
[GitHub](https://github.com/tnaake/MatrixQCvis) or
send a mail to the developer.

# 2 Prepare the environment

To install `MatrixQCvis` enter the following to the `R` console

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("MatrixQCvis")
```

Before starting with the analysis, load the `MatrixQCvis` package. This
will also load the required packages `Biobase`, `BiocGenerics`, `GenomeInfoDb`,
`GenomicRanges`, `ggplot2`, `IRanges`, `MatrixGenerics`,
`parallel`, `matrixStats`, `plotly`, `shiny`, `SummarizedExperiment`, and
`stats4`.

```
library(MatrixQCvis)
```

# 3 Appearance of user interface depends on the data input

Please note: Depending on the supplied `SummarizedExperiment` object the user
interface of `shinyQC` will differ:

* for a `SummarizedExperiment` object containing missing values
  + the tabs `Samples`, `Measured Values`, `Missing Values`, `Values`,
    `Dimension Reduction` and `DE` will be displayed,
  + within the tabs `Values` and `Dimension Reduction` the
    `imputed` data set **will be** visualized,
  + the sidebar panel **includes** a drop-down menu for the imputation method.
* for a `SummarizedExperiment` object containing no missing values (i.e.
  with complete observations)
  + the tabs `Samples`, `Values`, `Dimension Reduction` and `DE`
    will be displayed,
  + within the tabs `Values` and `DE` the `imputed` data set
    **will not** be visualized,
  + the sidebar panel **does not includes** a drop-down menu for the
    imputation method.

In the following, the vignette will be (mainly) described from the point of view
of a `SummarizedExperiment` containing no missing values (RNA-seq dataset)
and missing values (proteomics dataset).

# 4 QC analysis of TCGA RNA-seq data

Here, we will retrieve a `SummarizedExperiment`, `se`, object
from the `ExperimentHub`package. The dataset (GEO accession GSE62944) contains
741 normal samples across 24 cancer types from the TCGA re-processed RNA-seq
data. We will use the dataset obtained by `ExperimentHub` to showcase the
functionality of `shinyQC`.

```
library(ExperimentHub)
```

```
## Loading required package: AnnotationHub
```

```
## Loading required package: BiocFileCache
```

```
## Loading required package: dbplyr
```

```
##
## Attaching package: 'AnnotationHub'
```

```
## The following object is masked from 'package:Biobase':
##
##     cache
```

```
eh <- ExperimentHub()

## the SummarizedExperiment object has the title "RNA-Sequencing and clinical
## data for 741 normal samples from The Cancer Genome Atlas"
eh[eh$title == "RNA-Sequencing and clinical data for 741 normal samples from The Cancer Genome Atlas"]
```

```
## ExperimentHub with 1 record
## # snapshotDate(): 2025-10-29
## # names(): EH1044
## # package(): GSE62944
## # $dataprovider: GEO
## # $species: Homo sapiens
## # $rdataclass: SummarizedExperiment
## # $rdatadateadded: 2017-10-29
## # $title: RNA-Sequencing and clinical data for 741 normal samples from The C...
## # $description: TCGA RNA-seq Rsubread-summarized raw count data for 741 norm...
## # $taxonomyid: 9606
## # $genome: hg19
## # $sourcetype: tar.gz
## # $sourceurl: http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE62944
## # $sourcesize: NA
## # $tags: c("ExperimentData", "Genome", "DNASeqData", "RNASeqData")
## # retrieve record with 'object[["EH1044"]]'
```

```
## in a next step download the SummarizedExperiment object from ExperimentHub
se <- eh[["EH1044"]]
```

```
## Setting options('download.file.method.GEOquery'='auto')
```

```
## Setting options('GEOquery.inmemory.gpl'=FALSE)
```

```
## see ?GSE62944 and browseVignettes('GSE62944') for documentation
```

```
## loading from cache
```

```
## here we will restrain the analysis on 40 samples and remove the features
## that have a standard deviation of 0
se <- se[, seq_len(40)]
se_sds <- apply(assay(se), 1, sd, na.rm = TRUE)
se <- se[!is.na(se_sds) & se_sds > 0, ]
```

The most important function to assess the data quality is the `shinyQC` function
and its most important argument is `se`. `shinyQC` expects a `SummarizedExperiment`
object.

The `shinyQC` function sets the following requirements to the
`SummarizedExperiment` object `se`:
- `rownames(se)` are not allowed to be `NULL` and have to be set to the
feature names,
- `colnames(se)` are not allowed to be `NULL` and have to be set to the
sample names,
- `colnames(se)`, `colnames(assay(se))` and `rownames(colData(se))` all have
to be identical.

If these requirements are not met, `shinyQC` will stop and throw an error.

Alternatively, a `SummarizedExperiment` object can also be loaded from within
`shinyQC` (when no `se` object is supplied to `shinyQC`).

Objects belonging to the `SummarizedExperiment` class are containers for one
or more assays,
which are (numerical) matrices containing the quantitative, measured information
of the experiment. The rows represent features of interest (e.g.
transcripts, peptides, proteins, or metabolites) and the columns represent the
samples. The
`SummarizedExperiment` object stores also information on the features of
interest (accessible by `rowData`) and information on the samples
(accessible by `colData`). The name of samples and features will be accessed
from `colnames(se)` and `rownames(se)`, respectively.

If there is more than one experimental data set (`assay`)
stored in the `SummarizedExperiment` object, a select option will appear in the
sidebar allowing the user to select the `assay`.

The actual shiny application can then be started by entering the following
to the `R` console:

```
qc <- shinyQC(se)
```

The assignment to `qc` or any other object is not mandatory. Upon exiting the
shiny application, `shinyQC` will return a
`SummarizedExperiment` object containing the imputed dataset
that can be in the following further analyzed. The object will only be
returned if the function call was assigned to an object, e.g.
`qc <- shinyQC(se)`.

Now, we will have a closer look on the user interface of the Shiny
application.

## 4.1 Sidebar

The sidebar enables the user to exclude (e.g. in the case of identified outliers)
and select samples (e.g. in the case if there is interest for a specific
sample type). Samples are excluded/selected by entering the sample name
in the input field and pressing `Enter` on the keyboard or by clicking
on the name of the samples in the drop-down menu and activating the
relevant option (`"all"` for all samples; `"exclude"`, `"select"`). If the
option is set to `"select"` at least three samples have to be selected for
the selection to take place.

In addition, in the tabs `Values`,
`Dimension Reduction`, and `DE`, the sidebars allows the user for

* normalization: currently the methods `sum`, `quantile divion`, `quantile`
  and `none`, i.e. no normalization, are supported;
* batch correction: currently the methods `removeBatchEffect` from the `limma`
  package (Ritchie et al. [2015](#ref-Ritchie2015)), `ComBat` from the `sva` package, and
  `none`, i.e. no batch correction, are supported.
  It is highly advised to consult the dimension reduction plots before
  performing any batch correction. Batch correction should not be done based
  solely on (count/intensity) value distributions (boxplots/violin plots);
* transformation: currently the methods `log`, `log2`, `log10`, `vsn`
  (variance stabilizing normalization/transformation, Huber et al. ([2002](#ref-Huber2002))), and `none`, i.e.
  no transformation, are supported;
* imputation (only for `SummarizedExperiment` containing missing values):
  currently the methods `BPCA`, `KNN`, `MLE`, `Min`, `MinDet`,
  and `MinProb` are supported (see also Lazar et al. ([2016](#ref-Lazar2016)) for a review on
  imputation methods for label-free quantitative proteomics data sets).

By clicking on `Generate report` a markdown report will be created
(the progress of rendering is displayed in the bottom right corner). After
rendering there is the possibility to open or to save the report. The
report will take all values as set in the `shinyQC` application - if the
plot was not called yet, default values will be taken for the rendering.

By exiting the shiny application, a `SummarizedExperiment` object
is returned to the `qc` object.
If the supplied `SummarizedExperiment` contains missing values, the
`SummarizedExperiment` with imputed values is returned, otherwise the
`SummarizedExperiment` with batch corrected values is returned.

The `metadata` slot contains information about the method of
- the normalization,
- the batch correction,
- the transformation, and
- the imputation of (count/intensity) values (if the supplied
`SummarizedExperiment` contains missing values).

The sidebar in the last tab (`DE`) is different from the other tabs and will
be explained in the section `Tab: DE`.

## 4.2 Tab: Samples

The tab `Samples` gives general information on the number of samples in the
`se` object.

### 4.2.1 Histogram

The first panel shows a barplot and displays the number of
samples per sample type, treatment, etc. As an example, if we want to display
how many samples are in `se` for the different `type`s (`type` is a
column name in `colData(se)` and any column in `colData(se)` can be selected),
this panel will show the following output:

### 4.2.2 Mosaic plot

The figure in this panel displays the relative proportions of the numbers,
e.g. how many samples (in %) are there for `type` against `arbitrary_values`.
As the dataset was only shipped with a `type` and `sample` column, for
demonstration, we manually added the column `arbitrary_levels` to the `se`
object. This column is filled with the the values `"A"` and `"B"`.

Again, `type` and `arbitrary_values` are columns in `colData(se)` and any
column in `colData(se)` can be selected to create the Mosaic plot.

The figure will tell us to what extent the `se` contains the different types
in a balanced manner depending on `arbitrary_values`:

![](data:image/png;base64...)

## 4.3 Tab: Values

The tab `Values` will take a closer look on the `assay` slot of the
`SummarizedExperiment`.

### 4.3.1 Boxplot/Violin plot

This panel shows the (count/intensity) values for raw (`raw`),
batch corrected (`normalized`), normalized+batch corrected (`batch corrected`),
normalized+batch corrected+transformed (`transformed`), and
normalized+batch corrected+transformed+imputed (`imputed`) (count/intensity)
values (imputation of missing values, `imputed` will only be shown if there are
missing values in the `SummarizedExperiment`). As already mentioned, the
different methods for normalization, batch correction, transformation (and
imputation) are specified in the side panel.

For visualization purposes only, the (count/intensity) values for the raw,
normalized and batch corrected data sets can be `log2` transformed (see the
radio buttons in
`Display log2 values? (only for 'raw', 'normalized' and 'batch corrected')`).

The type of visualization (boxplot or violin plot) can be specified by
selecting `boxplot` or `violin` in the radio button panel (`Type of display`).

The figure (violin plot) using the raw values will look like (log set to `TRUE`)
![](data:image/png;base64...)

### 4.3.2 Trend/drift

This panel shows a trend line for aggregated values to
indicate drifts/trends in data acquisition. It
shows the sum- or median-aggregated values (specified in
`Select aggregation`). The plot displays trends in data
acquisition that originate e.g. from differences in instrument
sensitivity. The panel displays aggregated values for
raw (`raw`), batch corrected (`batch corrected`), batch corrected+normalized
(`normalized`), batch corrected+normalized+transformed (`transformed`), and
batch corrected+normalized+transformed+imputed (`imputed`) (count/intensity) values
(imputation of missing values, `imputed` will only be shown if there are missing
values in the `SummarizedExperiment`).
The different methods for normalization, batch correction, transformation (and
imputation) are specified in the sidebar panel.

The smoothing is calculated from the
selection of samples that are specified by the drop-down menus
`Select variable` and `Select level to highlight`.
The menu `Select variable` corresponds to the `colnames` in
`colData(se)`. Here, we can select for the higher-order variable, e.g.
the type (containing for example `BLCA`, `BRCA`, etc.).
The drop-down menu `Select level to highlight` will specify the actual selection
from which
the trend line will be calculated (e.g. `BLCA`, `BRCA`, etc.). Also,
the menu will always include the level `all`, which will use all points to
calculate the trend line. If we want to calculate the trend line of
aggregated values of all samples belonging to the type `QC`, we select
`QC` in the drop-down menu.

The panel allows the users for further customization after expanding the collapsed box.
The data input is selected in the drop-down menu under `Select data input`.
The smoothing method (either LOESS or linear model) is selected in the drop-down
menu under `Select smoothing method`. The aggregation method is selected
in the drop-down menu `Select smoothing method`.

With the drop-down menu `Select categorical variable to order samples`,
the samples (x-axis) will be ordered alphanumerically according to the
selected level (and the sample name).

Here, we are interested in observing if there is a trend/drift for
samples of `type` `BRCA`. We select `LOESS` as the method for the trend line
and `median` as the aggregation method. The figure will then look as follows:

### 4.3.3 Coefficient of variation

This panel shows the coefficient of variation values for raw (`raw`),
normalized (`normalized`), normalized+batch corrected (`batch corrected`),
normalized+batch corrected+transformed (`transformed`), and
normalized+batch corrected+transformed+imputed (`imputed`)
(count/intensity) values (imputation of missing values, `imputed` will only be shown
if there are missing values in the `SummarizedExperiment`) among the samples.
The different methods for normalization, batch corrected, transformation,
(and imputation) are specified in the sidebar panel.

The panel displays the coefficient of variation values from the samples of the
`SummarizedExperiment` object. The coefficients of variation are calculated
according to the formula `sd(x) / mean(x) * 100` with `x` the sample values
and `sd` the standard deviation. The plot might be useful when looking at the
coefficient of variation values of a specific sample type (e.g. QCs) and trying
to identify outliers.

Here, we shows the plot of coefficient of variation values from the
raw values (as obtained by `assay(se)`), normalized values (using `sum`
normalization), transformed values (using `vsn`), batch corrected values
(using `none`) and imputed values (using the `MinDet` algorithm, Lazar et al. ([2016](#ref-Lazar2016))).

![](data:image/png;base64...)

### 4.3.4 Mean-sd plot

The panel shows the three mean-sd (standard deviation) plots for
normalized+batch corrected+transformed (`transformed`)
and normalized+batch corrected+transformed+imputed (`imputed`) values
(`imputed` will only be shown if there are missing
values in the `SummarizedExperiment`).
The sd and mean are calculated feature-wise from the values of the respective
data set. The plot allows the user to visualize if there is a dependence of the sd on
the mean. The red line depicts the running median estimator (window-width 10%).
In case of sd-mean independence, the running median should be approximately
horizontal.

For the transformed values, the mean-sd plot will look like
![](data:image/png;base64...)

### 4.3.5 MA plot

The panel displays MA plots and Hoeffding’s D statistic.

In the first part of the panel the `A` vs. `M` plots per sample are depicted.

The values are defined as follows

* \(A = \frac{1}{2} \cdot (I\_i + I\_j)\) and
* \(M = I\_i−I\_j\) ,

where \(I\_i\) and \(I\_j\) are per definition `log2`-transformed values.
In the case of `raw`, `normalized`, or `batch corrected` the values are
`log2`-transformed prior to calculating `A` and `M`. In case of `transformed`
or `imputed` the values are taken as they are
(N.B. when the transformation method is set to `none` the values are not
`log2`-transformed).

The values for \(I\_i\) are taken from the sample \(i\). For \(I\_j\), the
feature-wise means are calculated from the values of the `group` \(j\) of
samples specified by the drop-down menu `group`. The sample for calculating
\(I\_i\) is excluded from the group \(j\). The group can be set to
`"all"` (i.e. all samples except sample \(i\) are used to calculate \(I\_j\)) or
any other column in `colData(se)`. For any group except `"all"` the group is
taken to which the sample \(i\) belongs to and the sample \(i\) is excluded from
the feature-wise calculation.

The MA values for all samples are by default displayed facet-wise. The MA plot
can be set to a specific sample by changing the selected value in the
drop-down menu `plot`.

The underlying data set can be selected by the drop-down menu
(`Data set for the MA plot`).

In the second part of the panel, the Hoeffding’s D statistic values are
visualized for the different data sets `raw`, `normalized`, `batch corrected`,
`transformed`, and `imputed` (`imputed` will only be shown if there are
missing values in the `SummarizedExperiment`).

`D` is a measure of the distance between `F(A, M)` and `G(A)H(M)`, where
`F(A, M)` is the joint cumulative distribution function (CDF) of `A` and `M`,
and `G` and `H` are marginal CDFs. The higher the value of `D`, the more
dependent are `A` and `M`. The `D` values are connected for the same
samples along the different data sets (when `lines` is selected), enabling the
user to track the influence of normalization, batch correction,
transformation (and imputation) methods on the `D` values.

The MA plot using the raw values and `group = "all"` will look like the
following (`plot` = “Sample\_1-1”`):

```
## Warning: Removed 1 row containing missing values or values outside the scale range
## (`geom_hex()`).
```

![](data:image/png;base64...)

### 4.3.6 ECDF

The plot shows the ECDF of the values of the sample
\(i\) and the feature-wise mean values of a group \(j\) of samples specified
by the drop-down menu `Group`. The sample for calculating \(I\_i\) is
excluded from the group \(j\). The group can be set to `"all"`
(i.e. all samples except sample \(i\) are used to calculate
\(I\_j\)) or any other column in `colData(se)`. For any group except `"all"` the
group is taken to which the sample \(i\) belongs to and the sample \(i\) is
excluded from the feature-wise calculation.

The underlying data set can be selected by the drop-down menu
`Data set for the MA plot`. The sample \(i\) can be selected by
the drop-down menu `Sample`. The group can be selected by
the drop-down menu `Group`.

The ECDF plot for the sample `"TCGA-K4-A3WV-11A-21R-A22U-07"`,
`group = "all"`, and the
raw values (as obtained by `assay(se)`) will look like:

```
## Warning in ks.test.default(x = value_s, y = value_g, exact = NULL, alternative
## = "two.sided"): p-value will be approximate in the presence of ties
```

![](data:image/png;base64...)

### 4.3.7 Distance matrix

On the left, the panel depicts heatmaps of distances between samples for
the data sets of
raw (`raw`), normalized (`normalized`),
normalized+batch corrected (`batch corrected`),
normalized+batch corrected+transformed (`transformed`), and
normalized+batch corrected+transformed+imputed (`imputed`,
`imputed` will only be shown if there are missing values in the
`SummarizedExperiment`). The annotation of the heatmaps can be adjusted by
the drop-down menu `annotation`.

On the right panel the sum of distances to other samples is depicted.

The distance matrix and sum of distances (for raw values, as obtained by
`assay(se)`) will look like:

![](data:image/png;base64...)

### 4.3.8 Features

The first plot shows the values for each samples along the data
processing steps.
The feature to be displayed is selected via the drop-down menu
**Select feature**.

![](data:image/png;base64...)

The second plot shows the coefficient of variation of the values for all features
in the data set along the data processing steps. The features of same
identity can be connected by lines by clicking on `lines`.

The element in the bottom of the tab panel (`Select features`) will specify
the selection of features in the data set (the selection will be propagated through
all tabs):

* `all`: when selected, all features in the uploaded `SummarizedExperiment`
  object will used,
* `exclude`: when selected, the features specified in the text input field
  will be excluded from the uploaded `SummarizedExperiment`,
* `select`: when selected, the features specified in the text input field
  will be selected from the uploaded `SummarizedExperiment`
  (note: a minimum of three features needs to be selected in order for the
  selection to take place).

## 4.4 Tab: Dimension Reduction

Within this tab several dimension reduction plots are displayed to visualize
the level of similarity of samples of a data set:
principal component analysis (PCA), principal coordinates analysis
(PCoA, also known as multidimensional scaling, MDS),
non-metric multidimensional scaling (NMDS),
t-distributed stochastic neighbor embedding (tSNE, Maaten and Hinton ([2008](#ref-vanderMaaten2008))), and
uniform manifold approximation and projection (UMAP, McInnes, Healy, and Melville ([2018](#ref-McInnes2018))).
Data input for the dimension reduction plots is the `imputed` data set.

### 4.4.1 PCA

The panel depicts a plot of PCA. The data input can be `scale`d and
`center`ed prior to calculating the principal components by adjusting the
respective tick marks. The different PCs can be displayed by changing the
values in the drop-down menus for the x-axis and y-axis.

A scree plot, showing the explained variance per PC, is displayed in the
right panel.

### 4.4.2 PCoA

The panel depicts a plot of PCoA (= multidimensional scaling). Different distance
measures can be used to calculate the distances between the samples
(euclidean, maximum, manhattan, canberra, minkowski).
The different axes of the transformed data can be displayed by changing the
values in the drop-down menus for the x-axis and y-axis.

### 4.4.3 NMDS

The panel depicts a plot of NMDS. Different distance
measures can be used to calculate the distances between the samples
(euclidean, maximum, manhattan, canberra, minkowski).
The different axes of the transformed data can be displayed by changing the
values in the drop-down menus for the x-axis and y-axis.

### 4.4.4 tSNE

The panel depicts a plot of tSNE. The parameters `Perplexity`,
`Number of iterations`, `Number of retained dimensions in initial PCA`,
and `Output dimensionality` required for the tSNE algorithm can be
set with the sliders. For the parameter
`Number of retained dimensions in initial PCA` the panel
`Principal components` can be employed that shows on the left panel a
Scree plot of the data set and permuted values and corresponding p-values
from the permutation (set the number of principal components where the
explained variance is above the permuted data set/where p-values are below
0.05).

The different dimensions of the transformed data can be displayed by changing
the values in the drop-down menus for the x-axis and y-axis (either two or
three dimensions according to the `Output dimensionality`).

### 4.4.5 UMAP

The panel depicts a plot of UMAP. The parameters `Minimum distance`,
`Number of neighbors`, and `Spread`, required for the UMAP algorithm can be
set with the sliders.

The different dimensions of the transformed data can be displayed by changing
the values in the drop-down menus for the x-axis and y-axis.

## 4.5 Tab: DE

This tab enables the user to test for differential expression between conditions.

Currently, two methods/tests are implemented for calculating differential
expression between conditions: moderated t-tests from `limma` and the
Wald test from `proDA`. The approach of `proDA` does not require imputed
values and will take the normalized+transformed+batch corrected
(`batch corrected`) data set as input.

The moderated t-statistic is the ratio of the M-value to its standard error,
where the M-value is the log2-fold change for the feature of interest.
The moderated t-statistic has the same interpretation as
an ordinary t-statistic except that the standard errors have been moderated
across features, borrowing information from the ensemble of features to aid
with inference about each individual feature (Kammers et al. [2015](#ref-Kammers2015)). We use the
`eBayes` function from `limma` to compute the moderated t-statistics
(`trend` and `robust` are set by default to `TRUE`, see `?eBayes` for
further information).

`proDA` (Ahlman-Eltze and Anders [2019](#ref-Ahlmann2019)) was developed for the differential abundance analysis
in label-free proteomics data sets. `proDA` models missing values in an
intensity-dependent probabilistic manner based on a dropout curve
(for further details see Ahlman-Eltze and Anders ([2019](#ref-Ahlmann2019))).

In the input field for levels, the formula for the levels is entered.
The formula has to start with a `~` (tilde) and the `R`-specific symbolic form:

* `+` to add terms,
* `:` to denote an interaction term,
* `*` to denote factor crossing (`a*b` is interpreted as `a+b+a:b`), `a` and `b`
  are columns in `colData(se)`,
* `-` to remove the specified term, e.g. `~ a - 1` to specify no intercept, and
  `a` a column in `colData(se)`,
* `+ 0` to alternatively specify a model without intercept.

The `colnames` of `colData` can be added as terms.

The `colnames` of the model matrix can be used to calculate contrasts, e.g.
`a - b` to specify the contrast between `a` and `b`. The contrasts can be
specified in the input field in the sidebar panel.

The panels `Model matrix` and `Contrast matrix` will show the model and contrast
matrix upon correct specification of the levels and contrasts.
The panel `Top DE` will show the differential features in a tabular format,
while the panel `Volcano plot` will display the information of
log fold change (for `limma`) or difference (for `proDA`) against the
p-values (displayed as `-log10(p-value)`.

In the following, we will look at the different panels with the
`se` input as specified above.

### 4.5.1 Sample meta-data

The panel `Sample meta-data` will show the column data of the `se` object. The
output will help to specify the levels for the model matrix.

The output will look like the following (only the first few rows are shown
here)

```
## DataFrame with 10 rows and 2 columns
##                                              sample     type
##                                         <character> <factor>
## TCGA-K4-A3WV-11A-21R-A22U-07 TCGA-K4-A3WV-11A-21R..     BLCA
## TCGA-49-6742-11A-01R-1858-07 TCGA-49-6742-11A-01R..     LUAD
## TCGA-DD-A3A2-11A-11R-A213-07 TCGA-DD-A3A2-11A-11R..     LIHC
## TCGA-BH-A0DV-11A-22R-A12P-07 TCGA-BH-A0DV-11A-22R..     BRCA
## TCGA-77-8008-11A-01R-2187-07 TCGA-77-8008-11A-01R..     LUSC
## TCGA-BH-A0BC-11A-22R-A089-07 TCGA-BH-A0BC-11A-22R..     BRCA
## TCGA-91-6836-11A-01R-1858-07 TCGA-91-6836-11A-01R..     LUAD
## TCGA-BK-A4ZD-11A-12R-A27V-07 TCGA-BK-A4ZD-11A-12R..     UCEC
## TCGA-H6-A45N-11A-12R-A26U-07 TCGA-H6-A45N-11A-12R..     PAAD
## TCGA-FL-A1YG-11A-12R-A16F-07 TCGA-FL-A1YG-11A-12R..     UCEC
```

### 4.5.2 Model matrix

When entering `~ type + 0` into the input field
`Select levels for Model Matrix`, the `Model matrix` panel will look like
(only the first few rows are shown here):

```
##                              typeBLCA typeBRCA typeCESC typeCHOL typeCOAD
## TCGA-K4-A3WV-11A-21R-A22U-07        1        0        0        0        0
## TCGA-49-6742-11A-01R-1858-07        0        0        0        0        0
## TCGA-DD-A3A2-11A-11R-A213-07        0        0        0        0        0
## TCGA-BH-A0DV-11A-22R-A12P-07        0        1        0        0        0
## TCGA-77-8008-11A-01R-2187-07        0        0        0        0        0
## TCGA-BH-A0BC-11A-22R-A089-07        0        1        0        0        0
##                              typeESCA typeGBM typeHNSC typeKICH typeKIRC
## TCGA-K4-A3WV-11A-21R-A22U-07        0       0        0        0        0
## TCGA-49-6742-11A-01R-1858-07        0       0        0        0        0
## TCGA-DD-A3A2-11A-11R-A213-07        0       0        0        0        0
## TCGA-BH-A0DV-11A-22R-A12P-07        0       0        0        0        0
## TCGA-77-8008-11A-01R-2187-07        0       0        0        0        0
## TCGA-BH-A0BC-11A-22R-A089-07        0       0        0        0        0
##                              typeKIRP typeLIHC typeLUAD typeLUSC typePAAD
## TCGA-K4-A3WV-11A-21R-A22U-07        0        0        0        0        0
## TCGA-49-6742-11A-01R-1858-07        0        0        1        0        0
## TCGA-DD-A3A2-11A-11R-A213-07        0        1        0        0        0
## TCGA-BH-A0DV-11A-22R-A12P-07        0        0        0        0        0
## TCGA-77-8008-11A-01R-2187-07        0        0        0        1        0
## TCGA-BH-A0BC-11A-22R-A089-07        0        0        0        0        0
##                              typePCPG typePRAD typeREAD typeSARC typeSKCM
## TCGA-K4-A3WV-11A-21R-A22U-07        0        0        0        0        0
## TCGA-49-6742-11A-01R-1858-07        0        0        0        0        0
## TCGA-DD-A3A2-11A-11R-A213-07        0        0        0        0        0
## TCGA-BH-A0DV-11A-22R-A12P-07        0        0        0        0        0
## TCGA-77-8008-11A-01R-2187-07        0        0        0        0        0
## TCGA-BH-A0BC-11A-22R-A089-07        0        0        0        0        0
##                              typeSTAD typeTHCA typeTHYM typeUCEC
## TCGA-K4-A3WV-11A-21R-A22U-07        0        0        0        0
## TCGA-49-6742-11A-01R-1858-07        0        0        0        0
## TCGA-DD-A3A2-11A-11R-A213-07        0        0        0        0
## TCGA-BH-A0DV-11A-22R-A12P-07        0        0        0        0
## TCGA-77-8008-11A-01R-2187-07        0        0        0        0
## TCGA-BH-A0BC-11A-22R-A089-07        0        0        0        0
```

### 4.5.3 Contrast matrix

As an example, we are interested in the differential expression between
the samples of typ `BRCA` and `LUAD`. We enter `typeBRCA-typeLUAD` in the input
field `Select contast(s)`. The contrast matrix (only the first few rows
are shown here) will then look like:

```
##           Contrasts
## Levels     typeBRCA-typeLUAD
##   typeBLCA                 0
##   typeBRCA                 1
##   typeCESC                 0
##   typeCHOL                 0
##   typeCOAD                 0
##   typeESCA                 0
```

### 4.5.4 Top DE

Switching to the panel `Top DE`, we will obtain a table with the differentially
expressed features (normalization method is set to `none`,
transformation method to `vsn` and imputation method to `MinDet`).
Here, differential expression is tested via moderated
t-tests (from the `limma` package):

The output will be (only the first 20 rows will be shown here):

```
## Coefficients not estimable: typeCHOL typeESCA typeGBM typeKIRP typePCPG typeREAD typeSARC typeSKCM typeTHYM
```

### 4.5.5 Volcano plot

The last panel of the tab `DE` displays the information from the differential
expression analysis. In the case of moderated t-tests, the plot shows the
log fold changes between the specified contrasts against the p-values.
Using the afore-mentioned specification for the model matrix and the
contrast matrix, the plot will look like:

# 5 QC analysis of proteomics data

We will retrieve a proteomics dataset from the `ExperimentHub` package. The
dataset contains quantitative profiling information of about 12000 proteins
in 375 cell lines spanning 24 primary diseases and 27 lineages. The
dataset was obtained by the Gygilab at Harvard University.
Within the `ExperimentHub`, the dataset is stored as a `tibble` in long
format. We will convert it here to a `SummarizedExperiment` class object.

```
eh[eh$title == "proteomic_20Q2"]
```

```
## ExperimentHub with 1 record
## # snapshotDate(): 2025-10-29
## # names(): EH3459
## # package(): depmap
## # $dataprovider: Broad Institute
## # $species: Homo sapiens
## # $rdataclass: tibble
## # $rdatadateadded: 2020-05-19
## # $title: proteomic_20Q2
## # $description: Quantitative profiling of 12399 proteins in 375 cell lines, ...
## # $taxonomyid: 9606
## # $genome:
## # $sourcetype: CSV
## # $sourceurl: https://gygi.med.harvard.edu/sites/gygi.med.harvard.edu/files/...
## # $sourcesize: NA
## # $tags: c("ExperimentHub", "ExperimentData", "ReproducibleResearch",
## #   "RepositoryData", "AssayDomainData", "CopyNumberVariationData",
## #   "DiseaseModel", "CancerData", "BreastCancerData", "ColonCancerData",
## #   "KidneyCancerData", "LeukemiaCancerData", "LungCancerData",
## #   "OvarianCancerData", "ProstateCancerData", "OrganismData",
## #   "Homo_sapiens_Data", "PackageTypeData", "SpecimenSource",
## #   "CellCulture", "Genome", "Proteome", "StemCell", "Tissue")
## # retrieve record with 'object[["EH3459"]]'
```

```
tbl <- eh[["EH3459"]]
```

```
## see ?depmap and browseVignettes('depmap') for documentation
```

```
## loading from cache
```

```
## reduce the number of files to speed computations up (can be skipped)
cell_line_unique <- dplyr::pull(tbl, "cell_line") |>
    unique()
tbl <- tbl |>
    filter(tbl[["cell_line"]] %in% cell_line_unique[seq_len(40)])

## using the information from protein_id/cell_line calculate the mean expression
## from the protein_expression values,
tbl_mean <- tbl |>
    dplyr::group_by(protein_id, cell_line) |>
    dplyr::summarise(mean_expression = mean(protein_expression, na.rm = TRUE),
        .groups = "drop")

## create wide format from averaged expression data
tbl_mean <- tbl_mean |>
    tidyr::pivot_wider(names_from = cell_line, values_from = mean_expression,
        id_cols = protein_id, names_expand = TRUE)

## add additional information from tbl to tbl_mean, remove first columns
## protein_expression and cell_line, remove the duplicated rows based on
## protein_id, finally add the tbl_mean to tbl_info
tbl_info <- tbl |>
    dplyr::select(-protein_expression, -cell_line) |>
    dplyr::distinct(protein_id, .keep_all = TRUE)
tbl_mean <- dplyr::right_join(tbl_info, tbl_mean,
    by = c("protein_id" = "protein_id"))

## create assay object
cols_a_start <- which(colnames(tbl_mean) == "A2058_SKIN")
a <- tbl_mean[, cols_a_start:ncol(tbl_mean)] |>
    as.matrix()
rownames(a) <- dplyr::pull(tbl_mean, "protein_id")

## create rowData object
rD <- tbl_mean[, seq_len(cols_a_start - 1)] |>
    as.data.frame()
rownames(rD) <- dplyr::pull(tbl_mean, "protein_id")

## create colData object, for the tissue column split the strings in column
## sample by "_", remove the first element (cell_line) and paste the remaining
## elements
cD <- data.frame(
    sample = colnames(tbl_mean)[cols_a_start:ncol(tbl_mean)]
) |>
    mutate(tissue = unlist(lapply(strsplit(sample, split = "_"), function(sample_i)
        paste0(sample_i[-1], collapse = "_"))))
rownames(cD) <- cD$sample

## create the SummarizedExperiment
se <- SummarizedExperiment(assay = a, rowData = rD, colData = cD)

## here we remove the features that have a standard deviation of 0
se_sds <- apply(assay(se), 1, sd, na.rm = TRUE)
se <- se[!is.na(se_sds) & se_sds > 0, ]
```

Again, the shiny application can be started via

```
shinyQC(se)
```

A description of the tabs `Samples`, `Values`, `Dimension Reduction`, and
`DE` can be found above under the section `QC analysis of TCGA RNA-seq data`.
We will focus here on the two tabs that are shown only for data sets that
contain missing values, `Measured Values` and `Missing Values`.

## 5.1 Tab: Measured Values and Missing Values

The tabs `Measured Values` and `Missing Values` are only displayed if the
`SummarizedExperiment` object contains missing values as in the case
of this proteomics dataset.

The layout in the tabs `Measured Values` and `Missing Values` is similar.
Therefore, the two tabs are described here simultaneously and the differences
are pointed out where necessary.

### 5.1.1 Barplot for samples

The plot shows the number of measured or missing values per sample
in the data set (depending on the selected tab). For example for the tab
`Measured Values`, the plot will look like

In this case, the samples show approximately the same number of measured features,
i.e. there is no indication to remove any sample based on this measure.

### 5.1.2 Histogram Features

The plot shows different data depending on which tab
(`Measured Values` or `Missing Values`) is selected. The binwidth will be
determined by the slider input (`Binwidth (Measured Values)` or
`Binwidth (Missing Values)`).

#### 5.1.2.1 Measured Variables

The plot shows how often a feature was measured in a certain number of
samples.

Examples:

1. in the case of one sample (x-axis), the y-axis will denote the number of
   features for which only one feature was measured.
2. in the case of the number of total samples (x-axis), the y-axis will
   denote the number of features with complete observations (i.e. the number
   of features for which the feature was quantified in all samples).

#### 5.1.2.2 Missing Variables

The plot shows how often a feature was missing in a certain number of samples.

Examples:

1. in the case of one sample (x-axis), the y-axis will denote the number of
   features for which only one feature was missing.
2. in the case of the number of total samples (x-axis), the y-axis will
   denote the number of features with completely missing observations
   (i.e. the number of features for which no feature was quantified in all
   samples).

### 5.1.3 Histogram Features along variable

The plot in this panel can be read accordingly to the one in the panel
`Histogram Features`, but, it is segregated for the specified variable
(e.g. it shows the distribution of measured/missing values among the sample
types).

### 5.1.4 UpSet

The plot shows the interaction of sets between different variables
depending on their presence or absence. The dots in the UpSet plot specify
if the criteria for presence/absence are fulfilled (see below for the
definition). In each column the intersections are displayed together with
the number of features regarding the type of intersection. The boxplots in
the rows display the number of present/absent features per set.

All sets present in the data set are displayed. Depending on the data set,
however, not all intersections sets are displayed (see the help page for
the `upset` function from the `UpSetR` package).

#### 5.1.4.1 Measured Values

Presence is defined by a feature being measured in at least one sample of a
set.

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## ℹ The deprecated feature was likely used in the UpSetR package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: The `size` argument of `element_line()` is deprecated as of ggplot2 3.4.0.
## ℹ Please use the `linewidth` argument instead.
## ℹ The deprecated feature was likely used in the UpSetR package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

#### 5.1.4.2 Missing Values

Absence is defined by a feature with only missing values (i.e. no measured
values) of a set.

### 5.1.5 Sets

This panel will retrieve the features specified by intersection of sets.

This panel builds upon the `Upset` panel. By selecting the check boxes,
the names of the features (taken from the `rownames` of the features) are
printed as text that fulfill the defined intersection of sets.

Example: Four sets (`Type_1`, `Type_2`, `Type_3`, and `Type_4`) are found for
a specified variable (here: `type`). When selecting the boxes for `Type_1` and
`Type_2` (while not selecting the boxes for `Type_3` and `Type_4`) the
features that are present/absent for `Type_1` and `Type_2`
(but not in the sets `Type_3` and `Type_4`) are returned.

For the tab `Measured Values`, presence is defined by a feature being
measured in at least one sample of a set.

For the tab `Missing Values`, absence is defined by a feature with only
missing values (i.e. no measured values) of a set.

# Appendix

## Session information

All software and respective versions to build this vignette are listed here:

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
##  [1] depmap_1.23.0               dplyr_1.1.4
##  [3] limma_3.66.0                GSE62944_1.37.0
##  [5] GEOquery_2.78.0             ExperimentHub_3.0.0
##  [7] AnnotationHub_4.0.0         BiocFileCache_3.0.0
##  [9] dbplyr_2.5.1                MatrixQCvis_1.18.0
## [11] shiny_1.11.1                plotly_4.11.0
## [13] ggplot2_4.0.0               SummarizedExperiment_1.40.0
## [15] Biobase_2.70.0              GenomicRanges_1.62.0
## [17] Seqinfo_1.0.0               IRanges_2.44.0
## [19] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [21] generics_0.1.4              MatrixGenerics_1.22.0
## [23] matrixStats_1.5.0           DT_0.34.0
## [25] knitr_1.50                  BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] splines_4.5.1         later_1.4.4           norm_1.0-11.1
##   [4] filelock_1.0.3        tibble_3.3.0          preprocessCore_1.72.0
##   [7] XML_3.99-0.19         rpart_4.1.24          lifecycle_1.0.4
##  [10] httr2_1.2.1           edgeR_4.8.0           doParallel_1.0.17
##  [13] lattice_0.22-7        MASS_7.3-65           crosstalk_1.2.2
##  [16] backports_1.5.0       magrittr_2.0.4        Hmisc_5.2-4
##  [19] sass_0.4.10           rmarkdown_2.30        jquerylib_0.1.4
##  [22] yaml_2.3.10           httpuv_1.6.16         otel_0.2.0
##  [25] askpass_1.2.1         reticulate_1.44.0     DBI_1.2.3
##  [28] RColorBrewer_1.1-3    abind_1.4-8           Rtsne_0.17
##  [31] purrr_1.1.0           nnet_7.3-20           rappdirs_0.3.3
##  [34] sandwich_3.1-1        sva_3.58.0            proDA_1.24.0
##  [37] circlize_0.4.16       rentrez_1.2.4         genefilter_1.92.0
##  [40] umap_0.2.10.0         RSpectra_0.16-2       annotate_1.88.0
##  [43] codetools_0.2-20      DelayedArray_0.36.0   xml2_1.4.1
##  [46] tidyselect_1.2.1      gmm_1.9-1             shape_1.4.6.1
##  [49] farver_2.1.2          base64enc_0.1-3       jsonlite_2.0.0
##  [52] GetoptLong_1.0.5      Formula_1.2-5         survival_3.8-3
##  [55] iterators_1.0.14      foreach_1.5.2         tools_4.5.1
##  [58] Rcpp_1.1.0            glue_1.8.0            gridExtra_2.3
##  [61] SparseArray_1.10.0    xfun_0.53             mgcv_1.9-3
##  [64] shinydashboard_0.7.3  withr_3.0.2           BiocManager_1.30.26
##  [67] fastmap_1.2.0         shinyjs_2.1.0         openssl_2.3.4
##  [70] digest_0.6.37         R6_2.6.1              mime_0.13
##  [73] imputeLCMD_2.1        colorspace_2.1-2      jpeg_0.1-11
##  [76] dichromat_2.0-0.1     RSQLite_2.4.3         UpSetR_1.4.0
##  [79] hexbin_1.28.5         tidyr_1.3.1           data.table_1.17.8
##  [82] httr_1.4.7            htmlwidgets_1.6.4     S4Arrays_1.10.0
##  [85] pkgconfig_2.0.3       gtable_0.3.6          blob_1.2.4
##  [88] ComplexHeatmap_2.26.0 S7_0.2.0              impute_1.84.0
##  [91] XVector_0.50.0        htmltools_0.5.8.1     shinyhelper_0.3.2
##  [94] bookdown_0.45         clue_0.3-66           scales_1.4.0
##  [97] tmvtnorm_1.7          png_0.1-8             rstudioapi_0.17.1
## [100] tzdb_0.5.0            rjson_0.2.23          checkmate_2.3.3
## [103] nlme_3.1-168          curl_7.0.0            cachem_1.1.0
## [106] zoo_1.8-14            GlobalOptions_0.1.2   stringr_1.5.2
## [109] BiocVersion_3.22.0    parallel_4.5.1        foreign_0.8-90
## [112] AnnotationDbi_1.72.0  vsn_3.78.0            pillar_1.11.1
## [115] grid_4.5.1            vctrs_0.6.5           pcaMethods_2.2.0
## [118] promises_1.4.0        xtable_1.8-4          cluster_2.1.8.1
## [121] htmlTable_2.4.3       evaluate_1.0.5        magick_2.9.0
## [124] readr_2.1.5           mvtnorm_1.3-3         cli_3.6.5
## [127] locfit_1.5-9.12       compiler_4.5.1        rlang_1.1.6
## [130] crayon_1.5.3          labeling_0.4.3        affy_1.88.0
## [133] plyr_1.8.9            stringi_1.8.7         viridisLite_0.4.2
## [136] BiocParallel_1.44.0   Biostrings_2.78.0     lazyeval_0.2.2
## [139] Matrix_1.7-4          hms_1.1.4             bit64_4.6.0-1
## [142] KEGGREST_1.50.0       statmod_1.5.1         memoise_2.0.1
## [145] affyio_1.80.0         bslib_0.9.0           bit_4.6.0
```

## References

Ahlman-Eltze, C., and S. Anders. 2019. “ProDA: Probabilistic Dropout Analysis for Identifying Differentially Abundant Proteins in Label-Free Mass Spectrometry.” *bioRxiv*. [https://doi.org/10.1101/661496](https://doi.org/10.1101/661496%20).

Huber, W., A. von Heydebreck, H. Sueltmann, A. Poustka, and M. Vingron. 2002. “Variance Stabilization Applied to Microarray Data Calibration and to the Quantification of Differential Expression.” *Bioinformatics*, S96–S104. <https://doi.org/10.1093/bioinformatics/18.suppl_1.S96>.

Kammers, K., R. N. Cole, C. Tiengwe, and I. Ruczinski. 2015. “Detecting Significant Changes in Protein Abundance.” *EuPA Open Proteomics*, 11–19. <https://doi.org/10.1016/j.euprot.2015.02.002>.

Lazar, C., L. Gatto, M. Ferro, C. Bruley, and T. Burger. 2016. “Accounting for the Multiple Natures of Missing Values in Label-Free Quantitative Proteomics Data Sets to Compare Imputation Strategies.” *J. Proteome Res.*, 1116–26. <https://doi.org/10.1021/acs.jproteome.5b00981>.

Maaten, L. van der, and G. Hinton. 2008. “Visualizing Data Using T-Sne.” *J. Machine Learning Research*, 2579–2605.

McInnes, L., J. Healy, and J. Melville. 2018. “UMAP: Uniform Manifold Approximation and Projection for Dimension Reduction.” *arXiv*, 1802.03426.

Ritchie, M. E., B. Phipson, D. Wu, Y. Hu, C. W. Law, W. Shi, and G. K. Smyth. 2015. “Limma Powers Differential Expression Analyses for Rna-Sequencing and Microarray Studies.” *Nucleic Acids Research*, e47. <https://doi.org/10.1093/nar/gkv007>.