# kmcut\_intro

Igor B. Kuznetsov1\*

1University at Albany, State University of New York

\*ikuznetsov@albany.edu

#### 30 October 2025

#### Abstract

Introduction to the kmcut package

#### Package

kmcut 1.4.0

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Preparing the input data](#preparing-the-input-data)
* [4 Running the package and interpreting the output](#running-the-package-and-interpreting-the-output)
  + [4.1 ‘create\_se\_object’](#create_se_object)
  + [4.2 ‘km\_opt\_pcut’](#km_opt_pcut)
  + [4.3 ‘km\_opt\_scut’](#km_opt_scut)
  + [4.4 ‘km\_qcut’](#km_qcut)
  + [4.5 ‘km\_ucut’](#km_ucut)
  + [4.6 ‘km\_val\_cut’](#km_val_cut)
  + [4.7 ‘ucox\_batch’](#ucox_batch)
  + [4.8 ‘ucox\_pred’](#ucox_pred)
* [5 Table manipulation](#table-manipulation)
  + [5.1 ‘extract\_rows’](#extract_rows)
  + [5.2 ‘extract\_columns’](#extract_columns)
  + [5.3 ‘transpose\_table’](#transpose_table)
* [6 Session Information](#session-information)
* [7 References](#references)
* **Appendix**

# 1 Introduction

This document provides a brief tutorial for the R package ‘kmcut’. The
main purpose of the package is to identify potential prognostic
biomarkers and an optimal numeric cutoff for each biomarker that can be
used to stratify a group of test subjects (samples) into two sub-groups
with significantly different survival (better vs. worse). Originally,
the package was intended to be used with variables that describe gene
expression, such as microarray or RNA-seq expression levels of
individual genes or gene signatures, such as single-sample Gene Set
Enrichment Analysis (ssGSEA) signatures. However, it can be used with
any quantitative variable that has a sufficiently large proportion of
unique values. The main requirement of the package is that for a group
of test subjects (samples) two types of data are available: (a)
right-censored survival time data and (b) at least one gene
expression-like feature with a large proportion of unique numeric values
describing each test subject (sample).

# 2 Installation

The package can be installed from Bioconductor by utilizing the code below:

```
BiocManager::install("kmcut")
```

After installation, load the package:

```
library(kmcut)
```

# 3 Preparing the input data

The package requires input data to be in two tab-delimited text files:

1. A file with right-censored survival data and
2. A file with gene expression-like features. *The sample identifiers
   in both files must be exactly the same.* The package contains
   built-in example files with survival data and RNA-seq gene
   expression data that describe neuroblastoma tumor samples
   (Zhang et al, 2015).

1. The file with survival data must contain at least three columns
   labeled ‘sample\_id’, ‘stime’, and ‘scens’. Column ‘sample\_id’
   contains a unique identifier of each sample (test subject) and must be
   the first column in the file. Column ‘stime’ contains the survival
   time for each sample. Column ‘scens’ contains the censoring variable
   for each sample (0 or 1). If other columns are present in
   the file, they will be ignored. ‘stime’ and ‘scens’ can be in any
   column in the file, except the first. An example file with survival
   data is provided with the package, its content can be printed as
   follows (*the output of the code is not provided because it is too
   long*):

```
sdat <- system.file("extdata", "survival_data.txt", package = "kmcut")
```

|  |  |  |
| --- | --- | --- |
| sample\_id | stime | scens |
| SEQC\_NB001 | 1362 | 1 |
| SEQC\_NB002 | 2836 | 1 |
| SEQC\_NB003 | 1191 | 1 |
| SEQC\_NB004 | 220 | 1 |
| SEQC\_NB005 | 2217 | 0 |

Table 1. An illustration of the survival data file format for five
samples.

2. The file with gene expression-like features must contain samples
   (subjects) in columns and features in rows. The first column must
   contain gene identifiers and the first row must contain sample
   identifiers. An example file with gene expression features provided
   with the package, its content can be printed as follows (*the output
   of the code is not provided because it is too long*):

```
fdat <- system.file("extdata", "example_genes.txt", package = "kmcut")
```

|  |  |  |  |  |  |
| --- | --- | --- | --- | --- | --- |
| tracking\_id | SEQC\_NB001 | SEQC\_NB002 | SEQC\_NB003 | SEQC\_NB004 | SEQC\_NB005 |
| MYCN | 4.16347458 | 3.464994927 | 8.494631614 | 8.438018327 | 5.509974474 |
| MYH2 | 0.006539622 | 0.009077256 | 0 | 4.111214977 | 0.008735951 |

Table 2. An illustration of the file format for expression data with
two genes and five samples.

# 4 Running the package and interpreting the output

## 4.1 ‘create\_se\_object’

Expression and survival data are stored in a [SummarizedExperiment](https://bioconductor.org/packages/SummarizedExperiment/)
object. The function ‘create\_se\_object’ reads a file with expression data and
a file with survival data, and returns a SummarizedExperiment object.

```
# Read names of the built-in gene expression data file and survival data file
fdat = system.file("extdata", "example_genes.txt", package = "kmcut")
sdat = system.file("extdata", "survival_data.txt", package = "kmcut")

# Create a SummarizedExperiment object 'se'
se = create_se_object(efile = fdat, sfile = sdat)
```

## 4.2 ‘km\_opt\_pcut’

This function uses each distinct value of every feature from the dataset
as a stratification cutoff to select a cutoff that results in the
maximum separation of the Kaplan-Meier survival curves, and then
estimates the statistical significance of this optimal cutoff by means
of the permutation test. A detailed description of the steps implemented
in this function is provided below and is also available in our original
publication (Wei et al, 2018).

First, an ordered list C of all distinct values of a given feature
observed in the group of test subjects (samples) is created, all values
in the list being sorted from smallest to largest. Then, each value from
the list is used as a stratification cutoff: samples with the feature
below or equal to the cutoff are labeled as ‘low’ and above the cutoff
as ‘high’. To avoid edge effects, if for a particular cutoff the size of
low or high sub-group is smaller than ‘min\_fraction’ of the total number
of samples, this cutoff is discarded from the list. The log-rank test is
applied to compare survival distributions between the low and high
groups for each stratification cutoff, and the value of the test
statistic is recorded. After all stratification cutoffs from the list
are tested, the vector of the observed values of the test statistic is
created, O=(o1, o2 ,…, on), where oi is the observed value of
the test statistic for the cutoff ci in the list C=(c1, c2 ,…,
cn). The cutoff that results in the largest value of the test
statistic, OMAX, is selected as the optimal cutoff, COPT. If two or
more cutoffs result in the same observed value of the test statistic,
the cutoff closest to the median is selected.

Additionally, the shape of the plot of the observed values of the test
statistic is compared to the expected “ideal” plot. The empirical
assumption behind this comparison is that the “ideal” optimization
should produce a plot of the observed values of the test statistic with
exactly one peak, meaning that the values monotonically increase before
the peak and monotonically decrease after the peak. Initially, three
possible expected plots are defined: E1, E2, and E3. Each plot
consists of cutoff points from C, has a single peak, with the height of
this peak being equal to OMAX. In the plot E1 the peak is located at
the 25th percentile of all distinct values of the feature, in the plot
E2 at the 50th percentile, and in the plot E3 at the 75th
percentile. The final expected plot, E, is selected from (E1, E2,
E3) to minimize the distance from the location of its peak to COPT.
The similarity of is quantified by the Spearman rank correlation between
the vectors of the observed and expected values, r(O, E).

The statistical significance of the stratification cutoff COPT
obtained from the optimization procedure for a given feature is
estimated by means of a random permutation test run for ‘n\_iter’
iterations. On each iteration i, the sample labels in the survival data
and in the feature data are randomly shuffled, the same optimization
procedure is applied to the randomized data, and the largest value of
the observed test statistic ORAND(i) and the Spearman rank correlation
between the observed and expected plot rRAND(i) are recorded. After
all ‘n\_iter’ iterations are completed, the p-value is calculated as
follows:

![](data:image/x-ms-bmp;base64...)

The equation used to calculate the p-value.

where d[ORAND(i) OMAX AND rRAND(i) r(O, E)] = 1 if on random iteration *i*
the largest value of the observed test statistic is equal to or greater than
OMAX and the Spearman rank correlation between the observed and the expected
plot is equal to or greater than r(O, E). Otherwise,
d[ORAND(i) OMAX AND rRAND(i) r(O, E)] = 0.

The random permutation test described above is time-consuming. It is recommended
that the users first run the [‘km\_opt\_scut’](#km_opt_scut) function to identify a relatively
small sub-set of candidate genes, and then apply ‘km\_opt\_pcut’ to this sub-set.

The ‘km\_opt\_pcut’ function can be run in parallel on multiple processors by
setting the `nproc` argument to the desired number of processors. The graph
below shows how the run time of the ‘km\_opt\_pcut’ function decreases when the
number of processors is increased. The results were obtained by using a data set
of 200 genes and 215 samples, with 10000 iterations per gene.
Benchmarking utilized the NIH High Performance Computing cluster
[Biowulf.](http://hpc.nih.gov)

![](data:image/png;base64...)

The run time vs. the number of processors.

An example of how to run ‘km\_opt\_pcut’ on 1 processor with the data files
included in the package:

```
# Read names of the built-in gene expression data file and survival data file
fdat = system.file("extdata", "example_genes.txt", package = "kmcut")
sdat = system.file("extdata", "survival_data.txt", package = "kmcut")

# Create SummarizedExperiment object
se = create_se_object(efile = fdat, sfile = sdat)

# Run the permutation test for 10 iterations for each gene, use 1 processor
km_opt_pcut(obj = se, bfname = "test", n_iter = 10, wlabels = TRUE,
                wpdf = FALSE, verbose = FALSE, nproc = 1)
```

```
## Running on 1 CPU(s)
```

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)
Two graphs are created for each gene, MYCN and MYH2.

One graph shows the observed optimization plot (blue circles) and the expected
optimization plot (green triangles). The optimal stratification cutoff is
highlighted by the red circle. The Spearman rank correlation between the
observed and the expected plots is printed after gene name. For instance, in
the case of MYCN the correlation is high, R = 0.909, indicating good
optimization. In the case of MYH2, the correlation is low and negative,
R = -0.043, indicating poor optimization.
The other graph shows the Kaplan-Meier survival curves for groups with low and
high gene expression groups stratified using the optimal cutoff. The value of
this optimal cutoff and the p-value are printed after gene name. For instance,
in the case of MYCN gene, the optimal cutoff is 5.84464 and the p-value is 0
(*note that in the figure the p-value is shown as exactly 0 because only 10
iterations of the permutation test were used in this example*).

The MYCN oncogene expression is known to be a strong predictor of
survival outcome for neuroblastoma patients - low expression levels
correspond to better survival, high expression levels correspond to poor
survival (Norris et al, 1997). The significant results of the optimization
for MYCN confirm this information.

The MYH2 gene encodes the myosin heavy chain 2, which is a protein found
in the muscle tissue and the level of its expression has nothing to do
with neuroblastoma survival (Smerdu et al, 1994). The statistically not
significant results of the optimization for MYH2 confirm this information.

Additionally, this run will create the following two output files in the current
working directory (the names of output files will be created automatically by
adding the run information to the base name ‘bfname’).

**a) Tab-delimited text file with the results**
“test\_KMoptp\_minf\_0.10\_iter\_10.txt”

|  |  |  |  |  |  |  |  |
| --- | --- | --- | --- | --- | --- | --- | --- |
| tracking\_id | CUTOFF | CHI\_SQ | LOW\_N | HIGH\_N | R | P | FDR\_P |
| MYCN | 5.84464174 | 70.91 | 49 | 44 | 0.909 | 0 | 0 |
| MYH2 | 0.00219771 | 2.52 | 42 | 51 | -0.043 | 0.1 | 0.1 |

Table 3. An illustration of the file format for tab-delimited text
file with the results for two genes. 1st column – gene id, 2nd –
optimal stratification cutoff, 3rd – test statistic calculated for the
optimal cutoff, 4th – number of samples in low-expression sub-group,
5th - number of samples in high-expression sub-group, 6th – permutation
test p-value, 7th – FDR-adjusted p-value.

**b) CSV file with low/high sample labels**
“test\_KMoptp\_minf\_0.10\_iter\_10\_labels.csv”

| sample\_id | MYCN | MYH2 |
| --- | --- | --- |
| SEQC\_NB003 | 2 | 1 |
| SEQC\_NB005 | 2 | 2 |
| SEQC\_NB006 | 1 | 2 |
| SEQC\_NB016 | 1 | 2 |
| SEQC\_NB051 | 1 | 1 |

Table 4. An illustration of the file format for the CVS file with
low/high labels for two genes and five samples. 1st column – sample
ids, all subsequent columns contain low/high labels for each gene, where
1 and 2 correspond to low- and high-expression sub-groups, respectively
(‘low’ means below the cutoff and ‘high’ means above the cutoff).

## 4.3 ‘km\_opt\_scut’

This function uses each distinct value of a given feature observed in
the dataset as a stratification cutoff to select a cutoff that results
in the maximum separation of the Kaplan-Meier survival curves, but does
not use the permutation test to estimate the statistical significance of
this optimal cutoff. ‘km\_opt\_scut’ produces graphs and output files virtually
identical to the output of [‘km\_opt\_pcut’](#km_opt_pcut) (except for the permutation
test p-value) and is meant to be used as a fast exploratory alternative
to [‘km\_opt\_pcut’](#km_opt_pcut). An example of how to use ‘km\_opt\_scut’ with the data
files included in the package:

```
# Read names of the built-in gene expression data file and survival data file
fdat = system.file("extdata", "example_genes.txt", package = "kmcut")
sdat = system.file("extdata", "survival_data.txt", package = "kmcut")

# Create SummarizedExperiment object
se <- create_se_object(efile = fdat, sfile = sdat)

# Search for optimal cutoffs
km_opt_scut(obj = se, bfname = "test", wpdf = FALSE, verbose = FALSE)
```

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)
Two graphs are created for each gene, MYCN and MYH2.

Additionally, this run will create the following two output files in the current
working directory (the names of output files will be created automatically by
adding the run information to the base name ‘bfname’).

**a) Tab-delimited text file with the results**
"test\_KMopt\_minf\_0.10.txt

**b) CSV file with low/high sample labels**
“test\_KMopt\_minf\_0.10\_labels.csv”

The format of these files is identical to the output files
described for function [‘km\_opt\_pcut’](#km_opt_pcut). The only difference is that the
tab-delimited file with the results in column ‘P’ and the PDF file with
Kaplan-Meier curves contain the p-value obtained from the log-rank test
performed with the optimal cutoff. *This p-value is provided for
information purposes only and should not be treated as an actual p-value
because it does not reflect the calculation of multiple test statistics
involved in the optimization procedure applied to select the optimal
cutoff.*

## 4.4 ‘km\_qcut’

For each feature, this function uses the cutoff supplied as a quantile
(from 0 to 100) to stratify samples into 2 groups (below and above this
quantile), plots Kaplan-Meier survival curves for these two groups and
calculates the log-rank test p-value. Since for each feature only one
cutoff corresponding to the specified quantile is used, it is equivalent
to performing one log-rank test per feature (that is, no optimization is
performed). An example of how to use ‘km\_qcut’ with the data files
included in the package:

```
# Read names of the built-in gene expression data file and survival data file
fdat = system.file("extdata", "example_genes.txt", package = "kmcut")
sdat = system.file("extdata", "survival_data.txt", package="kmcut")

# Create SummarizedExperiment object
se <- create_se_object(efile = fdat, sfile = sdat)

# Use the 50th quantile (the median) to stratify the samples
km_qcut(obj = se, bfname = "test", quant = 50, wpdf = FALSE)
```

![](data:image/png;base64...)![](data:image/png;base64...)
A graph with Kaplan-Meier curves will be created for each gene, MYCN and MYH2.

Additionally, this run will create the following two output files in the current
working directory (the names of output files will be created automatically by
adding the run information to the base name ‘bfname’).

**a) Tab-delimited text file with the results**
“test\_KM\_quant\_50.txt”

**b) CSV file with low/high sample labels**
“test\_KM\_quant\_50\_labels.csv”

The format of these two files is identical to the output files
described for function [‘km\_opt\_pcut’](#km_opt_pcut).

## 4.5 ‘km\_ucut’

For each feature, this function applies the user-supplied fixed value as
a cutoff to stratify samples into 2 groups (below/above this cutoff),
plots Kaplan-Meier survival curves for these two groups, and calculates
the log-rank test p-value. Since for each feature the same fixed cutoff
is used, it is equivalent to performing one log-rank test per feature
(no optimization is performed). An example of how to use ‘km\_ucut’ with
the data files included in the package:

```
# Read names of the built-in gene expression data file and survival data file
fdat = system.file("extdata", "example_genes.txt", package = "kmcut")
sdat = system.file("extdata", "survival_data.txt", package = "kmcut")

# Create SummarizedExperiment object
se <- create_se_object(efile = fdat, sfile = sdat)

# Use the cutoff = 5 to stratify the samples and remove features that have
# less than 90% unique values (this removes the MYH2 gene from the analysis)
km_ucut(obj = se, bfname = "test", cutoff = 5, min_uval = 90, wpdf = FALSE)
```

![](data:image/png;base64...)
A graph with Kaplan-Meier curves is created for gene (there is only MYCN here).

Additionally, this run will create the following two output files in the current
working directory (the names of output files will be created automatically by
adding the run information to the base name ‘bfname’).

**a) Tab-delimited text file with the results**
“test\_KM\_ucut\_5.txt”

**b) CSV file with low/high sample labels**
“test\_KM\_ucut\_5\_labels.csv”

The format of these two files is identical to the output files described for
function [‘km\_opt\_pcut’](#km_opt_pcut).

## 4.6 ‘km\_val\_cut’

This function creates Kaplan-Meier survival curves for each feature in a
validation data file by using a file with previously determined
stratification cutoffs (one cutoff per feature) and calculates the
log-rank test p-value. Since for each feature only one previously
determined cutoff is used, it is equivalent to performing one log-rank
test per feature (no optimization is performed). The file with
previously determined stratification cutoffs is a tab-delimited file
with the table that contains one or more feature and a stratification
cutoff for each feature (the table is generated by functions
[‘km\_opt\_scut’](#km_opt_scut), [‘km\_opt\_pcut’](#km_opt_pcut), [‘km\_qcut’](#km_qcut) or [‘km\_ucut’](#km_ucut)). It must have
first two columns named as ‘tracking\_id’ and ‘CUTOFF’. The ‘tracking\_id’
column contains gene (feature) names, the ‘CUTOFF’ column contains
stratification cutoff for each gene (feature). An example of how to use
‘km\_val\_cut’ to validate stratification cutoffs determined by
[‘km\_qcut’](#km_qcut):

```
# Read names of training (fdat1) and validation (fdat2) gene expression data
# files and survival data file (sdat).
fdat1 <- system.file("extdata", "expression_data_1.txt", package = "kmcut")
fdat2 <- system.file("extdata", "expression_data_2.txt", package = "kmcut")
sdat <- system.file("extdata", "survival_data.txt", package = "kmcut")

# Create SummarizedExperiment object with training data
se1 <- create_se_object(efile = fdat1, sfile = sdat)

# Step 1: Run 'km_qcut' on the training data in 'se1'
km_qcut(obj = se1, bfname = "training_data", quant = 50, min_uval = 40)
```

**Step 1 will create three output files in the current working directory:**

1. PDF file with plots
   “training\_data\_KM\_quant\_50.pdf”
2. Tab-delimited text file with the cutoffs
   “training\_data\_KM\_quant\_50.txt”
3. CSV file with low/high sample labels
   “training\_data\_KM\_quant\_50.csv”

The format of these three files is identical to the output files
described for function [‘km\_opt\_pcut’](#km_opt_pcut). *The only difference is that the
PDF file does not contain observed vs. expected optimization plots.*

```
# Create SummarizedExperiment object with test data
se2 <- create_se_object(efile = fdat2, sfile = sdat)

# Step 2: Validate the thresholds from "training_data_KM_quant_50.txt" on
# the test data in 'se2'.
km_val_cut(infile = "training_data_KM_quant_50.txt", obj = se2,
             bfname = "test", wpdf = TRUE, min_uval = 40)
```

**Step 2 will create three output files in the current working directory:**

1. PDF file with plots “test\_KM\_val.pdf”
2. Tab-delimited text file with the validation results
   “test\_KM\_val.txt”
3. CSV file with low/high sample labels
   “test\_KM\_val\_labels.csv”

The format of these three files is identical to the output files
described for function [‘km\_opt\_pcut’](#km_opt_pcut). *The only difference is that the
PDF file does not contain observed vs. expected optimization plots.*

## 4.7 ‘ucox\_batch’

This function fits a univariate Cox proportional hazard regression model and
performs the likelihood ratio test for each feature in the dataset.
An example of how to use ‘ucox\_batch’ with the data files included in the
package:

```
# Read names of the built-in gene expression data file (fdat) and
# survival data file (sdat)
fdat = system.file("extdata", "example_genes.txt", package = "kmcut")
sdat = system.file("extdata", "survival_data.txt", package = "kmcut")

# Create SummarizedExperiment object
se <- create_se_object(efile = fdat, sfile = sdat)

# Perform the regression on the data in 'se'
ucox_batch(obj = se, bfname = "test")
```

```
## Processing 1 of 2
```

```
## Processing 2 of 2
```

This will create in the current working directory a tab-delimited text file
with results “test\_ucoxbatch.txt”

|  |  |  |  |  |
| --- | --- | --- | --- | --- |
| tracking\_id | CC | HR | P | FDR\_P |
| MYCN | 0.78532 | 1.82512 | 1.6284328112261e-14 | 3.25686562245233e-14 |
| MYH2 | 0.46433 | 1.43 | 0.318152334987645 | 0.318152334987645 |

Table 5. An illustration of the file format for the tab-delimited text
file with Cox regression summary. 1st column – gene id, 2nd –
concordance coefficient, 3rd – hazard ratio, 4th – likelihood ratio
test p-value, 5th – FDR-adjusted p-value.

## 4.8 ‘ucox\_pred’

This function fits a univariate Cox proportional hazard regression model
for each feature in the training dataset and then uses the models to
calculate risk scores for the same features in the test dataset. An
example of how to use ‘ucox\_pred’ with the data files included in the
package:

```
# Read names of the built-in training (fdat1) and test (fdat2)
# gene expression data files and survival data file (sdat)
fdat1 = system.file("extdata", "expression_data_1.txt", package = "kmcut")
fdat2 = system.file("extdata", "expression_data_2.txt", package = "kmcut")
sdat = system.file("extdata", "survival_data.txt", package = "kmcut")

# Create SummarizedExperiment object with training data
se1 <- create_se_object(efile = fdat1, sfile = sdat)
# Create SummarizedExperiment object with test data
se2 <- create_se_object(efile = fdat2, sfile = sdat)

# Fit Cox model on the training data in 'se1' and use it to calculate the risk
# scores for the test data in 'se2'.
ucox_pred(obj1 = se1, obj2 = se2, bfname = "demo", min_uval = 40)
```

```
## Processing 1 of 2
```

```
## Processing 2 of 2
```

This will create three output files in the current working directory:

**a) Tab-delimited text file with Cox regression summary for the training data**
“demo\_cox\_train\_sum.txt”

|  |  |  |  |  |
| --- | --- | --- | --- | --- |
| tracking\_id | CC | HR | P | FDR\_P |
| MYCN | 0.66449 | 1.29795 | 5.8280601452252e-06 | 1.16561202904505e-05 |
| MYH2 | 0.45961 | 1.89406 | 0.127377383432028 | 0.127377383432028 |

Table 6. An illustration of the file format for the tab-delimited text
file with Cox regression summary. 1st column – gene id, 2nd –
concordance coefficient, 3rd – hazard ratio, 4th – likelihood ratio
test p-value, 5th – FDR-adjusted p-value.

**b) Tab-delimited text file with the risk scores for the training data**
“demo\_train\_score.txt”
In this file, rows are genes (features) and columns are samples.

**c) Tab-delimited text file with the risk scores for the test data**
“demo\_test\_score.txt”
In this file, rows are genes (features) and columns are samples.

# 5 Table manipulation

The package also contains the following functions that can be used to
manipulate data tables.

## 5.1 ‘extract\_rows’

This function extracts a sub-set of rows (such as a group of genes) from
a data table. All columns will be preserved. Names of the rows to be
extracted must be in a text file, one name per line (the exact names,
case-sensitive, no extra symbols are allowed). An example of how to use
the function with the data files included in the package:

```
# Read the name of the built-in gene expression data file with 2 genes (2 rows)
fdat = system.file("extdata", "example_genes.txt", package = "kmcut")
# Read the name of the built-in list file that contains one gene id (MYCN)
idlist = system.file("extdata", "rowids.txt", package = "kmcut")

# Run the function
extract_rows(fnamein = fdat, fids = idlist,
            fnameout = "example_genes_subset.txt")
```

This will create a tab-delimited text file “example\_genes\_subset.txt”
with one row “MYCN” in the current working directory.

## 5.2 ‘extract\_columns’

This function extracts a sub-set of columns (such as a group of samples)
from a data table. All rows will be preserved. Names of the columns to
be extracted must be in a text file, one name per line (the exact names,
case-sensitive, no extra symbols are allowed). An example of how to use
the function with the data files included in the package:

```
# Read the name of the built-in gene expression data file with 2 genes (2 rows)
fdat = system.file("extdata", "example_genes.txt", package = "kmcut")
# Read the name of the built-in list file that contains a sub-set of
# column (sample) ids
idlist = system.file("extdata", "columnids.txt", package = "kmcut")

# Run the function
extract_columns(fnamein = fdat, fids = idlist,
                    fnameout = "example_samples_subset.txt")
```

This will create a tab-delimited text file “example\_samples\_subset.txt”
in the current working directory. This file will contain columns (samples)
from the list.

## 5.3 ‘transpose\_table’

This function transposes a data table (that is, converts rows to columns
and columns to rows). Row names will become column names, and column
names will become row names. An example of how to use the function with
the data file included in the package:

```
# Read the name of the built-in gene expression data file.
# In this file, genes are rows and samples are columns.
fdat = system.file("extdata", "example_genes.txt", package = "kmcut")

# Run the function
transpose_table(fnamein = fdat, fnameout = "example_genes_transposed.txt")
```

This will create a tab-delimited text file “example\_genes\_295\_transposed.txt”
with the transposed table in the current working directory. In this file,
genes (features) are columns and samples are rows.

# 6 Session Information

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
## [1] kmcut_1.4.0      BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] Matrix_1.7-4                jsonlite_2.0.0
##  [3] compiler_4.5.1              BiocManager_1.30.26
##  [5] Rcpp_1.1.0                  tinytex_0.57
##  [7] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [9] magick_2.9.0                GenomicRanges_1.62.0
## [11] parallel_4.5.1              jquerylib_0.1.4
## [13] splines_4.5.1               IRanges_2.44.0
## [15] Seqinfo_1.0.0               yaml_2.3.10
## [17] fastmap_1.2.0               lattice_0.22-7
## [19] XVector_0.50.0              R6_2.6.1
## [21] S4Arrays_1.10.0             generics_0.1.4
## [23] knitr_1.50                  BiocGenerics_0.56.0
## [25] iterators_1.0.14            DelayedArray_0.36.0
## [27] bookdown_0.45               MatrixGenerics_1.22.0
## [29] bslib_0.9.0                 rlang_1.1.6
## [31] cachem_1.1.0                xfun_0.53
## [33] sass_0.4.10                 doParallel_1.0.17
## [35] SparseArray_1.10.0          cli_3.6.5
## [37] magrittr_2.0.4              digest_0.6.37
## [39] foreach_1.5.2               grid_4.5.1
## [41] lifecycle_1.0.4             S4Vectors_0.48.0
## [43] evaluate_1.0.5              pracma_2.4.6
## [45] codetools_0.2-20            abind_1.4-8
## [47] survival_3.8-3              stats4_4.5.1
## [49] rmarkdown_2.30              matrixStats_1.5.0
## [51] tools_4.5.1                 htmltools_0.5.8.1
```

# 7 References

# Appendix

1. Zhang, W., Yu, Y., Hertwig, F., et al. (2015) [Comparison of RNA-seq and
   microarray-based models for clinical endpoint prediction.]
   *Genome Biol.* **16**, 133.
   (<https://genomebiology.biomedcentral.com/articles/10.1186/s13059-015-0694-1>)
2. Wei, J.S., Kuznetsov, I.B., Zhang, S., et al. (2018) [Clinically Relevant
   Cytotoxic Immune Cell Signatures and Clonal Expansion of T-Cell Receptors in
   High-Risk MYCN-Not-Amplified Human Neuroblastoma.]
   *Clin. Cancer Res.* **24(22)**, 5673-5684.
   (<https://clincancerres.aacrjournals.org/content/24/22/5673.long>)
3. Norris, M.D., Bordow, S.B., Haber, P.S., et al. (1997) [Evidence that the
   MYCN oncogene regulates MRP gene expression in neuroblastoma.]
   *Eur. J. Cancer* **33(12)**, 1911-1916.
   (<https://pubmed.ncbi.nlm.nih.gov/9516823/>)
4. Smerdu, V., Karsch-Mizrachi, I., Campione, M., et al. (1994) [Type IIx
   myosin heavy chain transcripts are expressed in type IIb fibers of human
   skeletal muscle.]
   *Am. J. Physiol.* **267(6 Pt 1)**, C1723-1728.
   (<https://pubmed.ncbi.nlm.nih.gov/7545970/>)