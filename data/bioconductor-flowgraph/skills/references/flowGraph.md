# ***flowGraph***: Identifying differential cell populations in flow cytometry data accounting for marker frequency

Alice Yue

#### September 2020

#### Package

flowGraph 1.18.0

# Contents

* [1 Installing the package](#installing-the-package)
* [2 Citation](#citation)
* [3 Introduction](#introduction)
  + [3.1 Cell population naming convention](#cell-population-naming-convention)
* [4 Workflow: a simple example](#workflow-a-simple-example)
  + [4.1 Data sets contained in the package](#data-sets-contained-in-the-package)
  + [4.2 Initializing a flowGraph object](#initializing-a-flowgraph-object)
    - [4.2.1 Input format](#input-format)
  + [4.3 Retrieving results from a flowGraph object](#retrieving-results-from-a-flowgraph-object)
* [5 Accessing and modifying data in a flowGraph object](#accessing-and-modifying-data-in-a-flowgraph-object)
  + [5.1 Flow cytometry sample meta data](#flow-cytometry-sample-meta-data)
  + [5.2 Feature values](#feature-values)
  + [5.3 Feature summary statistics](#feature-summary-statistics)
* [6 Plotting and visualizing results](#plotting-and-visualizing-results)
* [7 Appendix](#appendix)
  + [7.1 Appendix 1: OTher useful plots](#appendix-1-other-useful-plots)
    - [7.1.1 QQ plot](#qq-plot)
    - [7.1.2 Boxplot](#boxplot)
    - [7.1.3 Logged p-value vs feature difference](#logged-p-value-vs-feature-difference)
    - [7.1.4 Customizing the cell hierarchy plot](#customizing-the-cell-hierarchy-plot)
  + [7.2 Appendix 2: flowGraphSubset, a fast version of the flowGraph constructor](#appendix-2-flowgraphsubset-a-fast-version-of-the-flowgraph-constructor)
* [8 System information](#system-information)
* [References](#references)

[![DOI](data:image/svg+xml; charset=utf-8;base64...)](https://doi.org/10.1101/837765)

[Summary blog post](https://aya49.github.io/2020/09/30/flowGraph/)

flowGraph is an R package used to identify candidate biomarkers for disease diagnosis in flow cytometry data. It does so by identifying driver cell populations whose abundance changes significantly and independently given a disease.

flowGraph takes cell counts as input and outputs SpecEnr values for each cell population within a flow cytometry sample, based on their expected proportion. SpecEnr accounts for dependencies between cell populations such that we can use it to flag only cell populations whose abundance change is incurred wholly or in part because of its association with a sample class (e.g. healthy vs sick).

# 1 Installing the package

**flowGraph** can be installed via Bioconductor.

You can also install the development version directly from Github using BiocManager:

```
if (!require("BiocManager")) install.packages('BiocManager')
BiocManager::install("aya49/flowGraph")
```

# 2 Citation

The theory, proof, and algorithm behind the SpecEnr statistic used in the
flowGraph package can be found in the following [paper](https://www.biorxiv.org/content/10.1101/837765v3.abstract).
Please consider citing if you found it helpful.

bibtex:

```
@article{yue2019identifying,
  title={Identifying differential cell populations in flow cytometry data accounting for marker frequency},
  author={Yue, Alice and Chauve, Cedric and Libbrecht, Maxwell and Brinkman, Ryan},
  journal={BioRxiv},
  pages={837765},
  year={2019},
  publisher={Cold Spring Harbor Laboratory}
}
```

The scripts and data from the paper can be downloaded ons [Zenodo](https://zenodo.org/record/3991166).

# 3 Introduction

The main goal of ***flowGraph*** is to help users interpret which cell populations
are differential between samples of different etiologies. To understand how
flowGraph defines cell populations, we introduce the cell hierarchy model below.
This model will serve as the basis for the analysis done in the
***flowGraph*** package.

```
library(flowGraph)
```

## 3.1 Cell population naming convention

A **cell hierarchy** is a directed acyclic graph that maps out all possible
cell populations. In this graph, each cell population is a node while relations
between cell populations are represented by edges. Each node is labelled by
whether or not its corresponding cell population contains cells that does/not
contain a subset of markers. For example, if the markers used in an experiment
is \(A\), \(B\), \(C\), \(D\), then \(A^-\) and \(A^+\) would represent the cell population
with cells that does/not contain marker \(A\) (e.g. Figure ).

If you are using threshold gates, \(A^+\)/\(A^-\) is the count of cells with a
fluorescent intensity (FI) value higher/lower than the threshold. If you have
multiple thresholds, for example 3 thresholds, for \(A\), then you would have
\(A^-\), \(A^+\), \(A^++\), \(A^+++\) with thresholds in between.

If you are using polygon gates, then \(A\) would be the name of your polygon gate
on any two dimension and \(A^-\) would be the cells inside the gate and \(A^+\)
would be the cells outside the gate.

We also accept cell population names where marker conditions are separated by an
underscore e.g. \(A^+\\_B^+\).

```
no_cores <- 1
data(fg_data_pos2)

meta_cell <- get_phen_meta(colnames(fg_data_pos2$count))
suppressWarnings({ pccell <- flowGraph:::get_phen_list(meta_cell, no_cores) })
gr <- set_layout_graph(list(e=pccell$edf, v=meta_cell)) # layout cell hierarchy

gr <- ggdf(gr)
gr$v$colour <- ifelse(!grepl("[-]",gr$v$phenotype), 1,0)
                     # "nodes with only marker conditions", "other nodes")
gr$v$label <- gr$v$phenotype
gr$v$v_ind <- gr$v$label_ind <- TRUE
gr$e$e_ind <- !grepl("[-]",gr$e$from) & !grepl("[-]",gr$e$to)
```

```
knitr::opts_template$set(figure1=list(fig.height=9, fig.width=9))
plot_gr(gr, main="Example cell hierarchy with markers A, B, C, D")
```

```
## Warning: `aes_()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`
## ℹ The deprecated feature was likely used in the flowGraph package.
##   Please report the issue at <https://github.com/aya49/flowGraph/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

Traditionally, cell populations are quantified by their proportion, or their
cell count over the total cell count. A downside to this analysis is that if
one cell population is differential, then all cell populations that contain
cells that are also in that differential cell population would also be flagged
as significantly differential. By incorporating information on relations
between cell populations, ***flowGraph*** uses the notion of
expected proportions and **SpecEnr** or specific enrichment as a replacement
for proportions to isolate only differential cell populations.

# 4 Workflow: a simple example

This section will run through a simple example of how ***flowGraph*** can be
used to analyze a set of flow cytometry samples.

Typically, one would input a sample x cell population matrix and
a directory where one wants to save all of the flowGraph resuts and plots:

```
no_cores <- 1 # number of cores to parallelize on.
data(fg_data_pos2)
fg <- flowGraph(
    fg_data_pos2$count, # sample x cell population matrix
    meta=fg_data_pos2$meta, # a data frame with each sample's meta data
    path="flowGraph_example", # a directory for flowGraph to output results to
    no_cores=no_cores) # number of cores to use, typically 1 for small data
```

The flowGraph output can be loaded into R from the specified directory as
a flowGraph object `fg`.

```
fg <- fg_load("flowGraph_example")
```

This flowGraph object can be further analyzed and
modified by using methods described in the following sections.

## 4.1 Data sets contained in the package

The package contains two data sets:
- `fg_data_fca` (Aghaeepour et al. [2013](#ref-aghaeepour2013critical)): a real data set comparing healthy
and AML (acute myeloid leukemia) positive subjects; it is known that there is
an outlier sample and that cell population node \(CD34^+\) increases in production
in the AML positive subjects’ samples.
- `fg_data_pos2`: a positive control data set where cell population node
\(A^{+}B^{+}C^+\) is artificially increased by 50%.
- `fg_data_pos30`: a positive control data set where cell population node
\(A^{+...}B^{+...}C^+\) is artificially increased by 50%. Note this data set
contains multiple thresholds for markers \(A\) and \(B\).

Both of these are lists containing elements:
- `count`: a sample x cell population numeric matrix containing cell count data.
- `meta`: a data frame containing meta data on the samples in `count`.
The sample names in the `id` corresponds with the row names in `count`.

```
# data(fg_data_fca)
data(fg_data_pos2)
# data(fg_data_pos30)

# ?fg_data_fca
# ?fg_data_pos2
# ?fg_data_pos30
```

## 4.2 Initializing a flowGraph object

To contain information regarding cell population quantification and the
cell hierarchy structure in one place, we use a **flowGraph** object to conduct
analysis. To initialize a flowGraph object, the user can give as input,
a numeric vector or matrix.
For examples on how all of these options
can be used, see `?flowGraph`.

For our example, we will directly use a numeric matrix as provided by our
`fg_data_pos2` data set. By default, `flowGraph` will calculate all of the
proportion `prop`, and SpecEnr `specenr`.

```
# no_cores <- 1 # number of cores to parallelize on.
data(fg_data_pos2)
fg <- flowGraph(fg_data_pos2$count, meta=fg_data_pos2$meta, no_cores=no_cores)
```

By default, `calculate_summary` is set to `TRUE` so that a default set of
summary statistics will be calculated for the SpecEnr
node feature and `prop` edge feature. Note that if the user decides to do this,
the `class` in `summary_pars` must be the column name in data frame `meta`
with the class labels. This is set to `"class"` by default.
A class in this context is, for example, an experiment or control sample.
If the user does not wish for this to be calculated during construction
of the flowGraph object, the user can set `summary_pars` to `NULL` in the
`flowGraph` function. Note that`summary_pars` must be specified if the fast
version of flowGraph is used.

`meta` can be given/modified at a later time.
Just make sure the meta data is a data frame
containing a `id` column where its values correspond to the row names in
the flowGraph objects’ feature matrices.

```
meta <- fg_get_meta(fg)
head(meta)
```

```
##       id   class train
## 1     a1 control  TRUE
## 2     a2 control  TRUE
## 3     a3 control  TRUE
## 4     a4 control  TRUE
## 5     a5 control  TRUE
## 251 a251 control FALSE
```

```
mcount <- fg_get_feature(fg, "node", "count")
head(rownames(mcount))
```

```
## [1] "a1"   "a2"   "a3"   "a4"   "a5"   "a251"
```

### 4.2.1 Input format

The input to flowGraph is a sample x cell population phenotype matrix containing
the cell count of each cell population for each sample.

The row names of the input matrix should be sample ID, otherwise,
flowGraph will create sample IDs for you.

The column names of the input matrix should be cell population phenotype names
that follow cell population naming conventions.
Markers/measurements must not contain underscores, dashes, or pluses
(`_`, `+`, `-`). If underscores were
used to separate marker/measurement conditions e.g. ssc+\_cd45-, the underscores
will be removed from the column names of the features matrices but will be
saved in `fg_get_meta(fg)$phenotype_`.

To calculate the SpecEnr of a cell population (e.g. A+B+C+),
flowGraph requires that all of its parent (A+B+, B+C+, A+C+)
and grandparent cell populations (A+, B+, C+) are available.

## 4.3 Retrieving results from a flowGraph object

The default summary statistics is calculated using the Wilcoxan signed-rank test and adjusted
using the `byLayer` adjustment method. This adjustment method is a family-wise method that
multiplies the p-value for each cell population by the number of nodes in
its layer and the total number of layers in the cell hierarchy on which there
exists a cell population node.

Below, we retrieve this summary statistic and list out the cell
populations with the most significant p-values as per below.

```
# get feature descriptions
fg_get_summary_desc(fg)
```

```
## $node
##      feat  test_name class label1  label2
## 1 SpecEnr t_diminish class    exp control
```

```
# get a summary statistic
fg_sum <- fg_get_summary(fg, type="node", summary_meta=list(
    node_feature="SpecEnr",
    test_name="t_diminish",
    class="class",
    labels=c("exp","control"))
)
# fg_sum <- fg_get_summary(fg, type="node", index=1) # same as above

# list most significant cell populations
p <- fg_sum$values # p values
head(sort(p),30)
```

```
##           C+       A-B+C-       A-B-C+       A+B-C-         A-C-           C-
## 3.056873e-24 7.288156e-24 7.477194e-24 7.619029e-24 3.037820e-23 3.695281e-23
##       A+B-C+       A-B-C-       A+B+C-         A+C-         A-C+       A-B+C+
## 4.587207e-23 4.741896e-23 5.163705e-23 8.506407e-23 8.817100e-23 9.551743e-23
##           A-           A+           B-         B-C-           B+         B-C+
## 1.766130e-22 2.834309e-22 3.613846e-22 4.738679e-22 7.464646e-22 1.002265e-21
##         B+C-         A+C+         B+C+         A-B-         A+B-         A+B+
## 1.533864e-21 1.760225e-20 3.579112e-20 4.604112e-20 6.378403e-20 1.242345e-19
##         A-B+       A+B+C+                        D-           D+         A-D-
## 1.840404e-19 3.869625e-18 1.000000e+00 1.000000e+00 1.000000e+00 1.000000e+00
```

To make changes to the flowGraph object, see functions that start with `fg_`.

Once we have made all the changes necessary, we can save the flowGraph object to
a folder. Inside the folder, all the feature values and summary statistics
are saved as csv files. Plots for each summary statistic can also optionally
be saved to this folder.

The same folder directory is used to load the flowGraph object when needed again.

```
fg_save(fg, "path/to/user/specified/folder/directory") # save flowGraph object
fg <- fg_load("path/to/user/specified/folder/directory") # load flowGraph object
```

See other flowGraph object initialization options in the Appendix 2.

The following sections will go over additional options for summary statistics,
and result interpretation.

# 5 Accessing and modifying data in a flowGraph object

## 5.1 Flow cytometry sample meta data

The flowGraph object initially contains meta data on the samples and
cell population nodes (phenotypes). The most basic way of understanding what
is inside a flowGraph object is by using `show`. This shows a description of
the flowGraph object and returns a list of data frames containing information
on the node and edge features and the summary statitics performed on them
shortly in this vignette.

```
show(fg)
```

```
## flowGraph object with 4/1 node and 1/0 edge feature(s)/summaries.
## - markers: A, B, C, D
## - contains: 81 cell populations and 216 edges
```

```
## $features
## $features$node
##          feat nrow ncol inf neginf na nan neg  pos zero          max
## 1       count   20   81   0      0  0   0   0 1620    0 3.187880e+05
## 2        prop   20   81   0      0  0   0   0 1620    0 1.000000e+00
## 3 expect_prop   20   81   0      0  0   0   0 1620    0 1.000000e+00
## 4     SpecEnr   20   81   0      0  0   0 800  800   20 1.208772e-01
##             min
## 1  1.838500e+04
## 2  5.767156e-02
## 3  5.729952e-02
## 4 -1.079611e-01
##
## $features$edge
##   feat nrow ncol inf neginf na nan neg  pos zero       max       min
## 1 prop   20  216   0      0  0   0   0 4320    0 0.6050483 0.3949517
##
##
## $summaries
## $summaries$node
##      feat  test_name class label1  label2
## 1 SpecEnr t_diminish class    exp control
```

One can obtain meta data on samples and cell populations as follows.
Note that information on cell populations is given to the user in the form of a
`graph` or a list contianing data frames `v` and `e`. The former represents the
nodes or the cell populatins, and the latter represent edges or the relation
between cell population — note that edges always point from parent to
child cell populations indicative of whether or not a cell population is a
sub-population of another.

```
# get sample meta data
head(fg_get_meta(fg))
```

```
##       id   class train
## 1     a1 control  TRUE
## 2     a2 control  TRUE
## 3     a3 control  TRUE
## 4     a4 control  TRUE
## 5     a5 control  TRUE
## 251 a251 control FALSE
```

```
# modify sample meta data
meta_new <- fg_get_meta(fg)
meta_new$id[1] <- "new_sample_id1"
fg <- fg_replace_meta(fg, meta_new)
```

```
# get cell population meta data
gr <- fg_get_graph(fg)
head(gr$v)
```

```
##   phenotype phenocode phenolayer phenogroup x  y
## 1                0000          0            0 15
## 2        A-      1000          1         A_ 1 12
## 3        A+      2000          1         A_ 1 13
## 4        B-      0100          1         B_ 1 14
## 5        B+      0200          1         B_ 1 15
## 6        C-      0010          1         C_ 1 16
```

```
head(gr$e)
```

```
##   from to marker from.x from.y to.x to.y
## 1      A-     A-      0     15    1   12
## 2      A+     A+      0     15    1   13
## 3      B-     B-      0     15    1   14
## 4      B+     B+      0     15    1   15
## 5      C-     C-      0     15    1   16
## 6      C+     C+      0     15    1   17
```

## 5.2 Feature values

The user can also extract or modify the features inside a flowGraph object.
For adding new features, unless needed, we recommend users stick with the
default feature generation methods that starts with `fg_feat_`.

```
# get feature descriptions
fg_get_feature_desc(fg)
```

```
## $node
##          feat nrow ncol inf neginf na nan neg  pos zero          max
## 1       count   20   81   0      0  0   0   0 1620    0 3.187880e+05
## 2        prop   20   81   0      0  0   0   0 1620    0 1.000000e+00
## 3 expect_prop   20   81   0      0  0   0   0 1620    0 1.000000e+00
## 4     SpecEnr   20   81   0      0  0   0 800  800   20 1.208772e-01
##             min
## 1  1.838500e+04
## 2  5.767156e-02
## 3  5.729952e-02
## 4 -1.079611e-01
##
## $edge
##   feat nrow ncol inf neginf na nan neg  pos zero       max       min
## 1 prop   20  216   0      0  0   0   0 4320    0 0.6050483 0.3949517
```

```
# get count node feature
mc <- fg_get_feature(fg, type="node", feature="count")
dim(mc)
```

```
## [1] 20 81
```

```
# add a new feature;
# input matrix must contain the same row and column names as existing features;
# we recommend users stick with default feature generation methods
# that start with fg_feat_
fg <- fg_add_feature(fg, type="node", feature="count_copy", m=mc)
fg_get_feature_desc(fg)
```

```
## $node
##          feat nrow ncol inf neginf na nan neg  pos zero          max
## 1       count   20   81   0      0  0   0   0 1620    0 3.187880e+05
## 2        prop   20   81   0      0  0   0   0 1620    0 1.000000e+00
## 3 expect_prop   20   81   0      0  0   0   0 1620    0 1.000000e+00
## 4     SpecEnr   20   81   0      0  0   0 800  800   20 1.208772e-01
## 5  count_copy   20   81   0      0  0   0   0 1620    0 3.187880e+05
##             min
## 1  1.838500e+04
## 2  5.767156e-02
## 3  5.729952e-02
## 4 -1.079611e-01
## 5  1.838500e+04
##
## $edge
##   feat nrow ncol inf neginf na nan neg  pos zero       max       min
## 1 prop   20  216   0      0  0   0   0 4320    0 0.6050483 0.3949517
```

```
# remove a feature; note, the count node feature cannot be removed
fg <- fg_rm_feature(fg, type="node", feature="count_copy")
fg_get_feature_desc(fg)
```

```
## $node
##          feat nrow ncol inf neginf na nan neg  pos zero          max
## 1       count   20   81   0      0  0   0   0 1620    0 3.187880e+05
## 2        prop   20   81   0      0  0   0   0 1620    0 1.000000e+00
## 3 expect_prop   20   81   0      0  0   0   0 1620    0 1.000000e+00
## 4     SpecEnr   20   81   0      0  0   0 800  800   20 1.208772e-01
##             min
## 1  1.838500e+04
## 2  5.767156e-02
## 3  5.729952e-02
## 4 -1.079611e-01
##
## $edge
##   feat nrow ncol inf neginf na nan neg  pos zero       max       min
## 1 prop   20  216   0      0  0   0   0 4320    0 0.6050483 0.3949517
```

## 5.3 Feature summary statistics

Once a flowGraph object is created, the user can calculate summary statistics
for any of the features it contains.

We recommend the user use the `fg_summary` function. Its default
summary statistic is the significance T-test along with a `byLayer`
p-value adjustment method. The user can specify other summary statistics or
adjustment methods by providing the name of the method or a function to
parameters `test_custom` or `adjust_custom`.

```
fg_get_summary_desc(fg)
```

```
## $node
##      feat  test_name class label1  label2
## 1 SpecEnr t_diminish class    exp control
```

```
# calculate summary statistic
fg <- fg_summary(fg, no_cores=no_cores, class="class", label1="control",
                 node_features="count", edge_features="NONE",
                 overwrite=FALSE, test_name="t", diminish=FALSE)
```

```
## - claculating summary statistics (for class class: control & exp) t for node feature count
```

```
## 17:41:09-17:41:09 > 19:00:00
```

```
fg_get_summary_desc(fg)
```

```
## $node
##      feat  test_name class  label1  label2
## 1 SpecEnr t_diminish class     exp control
## 2   count          t class control     exp
```

```
# get a summary statistic
fg_sum1 <- fg_get_summary(fg, type="node",  summary_meta=list(
    feature="count", test_name="t",
    class="class", label1="control", label2="exp"))
names(fg_sum1)
```

```
## [1] "values"       "id1"          "id2"          "m1"           "m2"
## [6] "cohensd"      "cohensd_size"
```

```
# remove a summary statistic
fg <- fg_rm_summary(fg, type="node", summary_meta=list(
    feature="count", test_name="t",
    class="class", label1="control", label2="exp"))
fg_get_summary_desc(fg)
```

```
## $node
##      feat  test_name class label1  label2
## 1 SpecEnr t_diminish class    exp control
```

```
# add a new feature summary;
# input list must contain a 'values', 'id1', and 'id2' containing summary
# statistic values and the sample id's compared;
# we recommend users stick with default feature generation method fg_summary
fg <- fg_add_summary(fg, type="node",  summary_meta=list(
    feature="SpecEnr", test_name="t_copy",
    class="class", label1="control", label2="exp"), p=fg_sum1)
fg_get_summary_desc(fg)
```

```
## $node
##      feat  test_name class  label1  label2
## 1 SpecEnr t_diminish class     exp control
## 2 SpecEnr     t_copy class control     exp
```

A summary static statistic, once obtained, is a list containing:
- `values`: a vector of p-values for each node or edge.
- `id1` and `id2`: a vector of sample id’s that were compared.
- `test_fun` and `adjust_fun`: the functions used to test and adjust the
summary statistic.
- `m1` and `m2`: a vector that summarizes one of the sets of samples compared.
These are not contained inside a flowGraph object but can be calculated on
the spot when retreiving a summary using `fg_get_summary` by setting
parameter `summary_fun` to a matrix function (default: `colSums`) and not
`NULL`. This usually does not need to be adjusted.

# 6 Plotting and visualizing results

All of the calculated summaries can be visualized in the form of a
cell hierarchy plot using function `fg_plot`. The plot can also be saved as a
PNG file if the path to this PNG file is provided as a string for its
`path` parameter. Here, we do not save the plot, but we plot the returned
`graph` list `gr` given by `fg_plot` that contains all the plotting columns
using the `plot_gr` function.

```
# plotting functions default to plotting node feature SpecEnr
# labelled with mean expected/proportion (maximum 30 labels are shown for clarity)
# and only significant nodes based on the wilcox_byLayer_diminish summary statistic
# are shown.
# gr <- fg_plot(fg, p_thres=.01, show_bgedges=TRUE, # show background edges
#               node_feature="SpecEnr", edge_feature="prop",
#               test_name="t_diminish", label_max=30)
gr <- fg_plot(fg, index=1, p_thres=.01, show_bgedges=TRUE)
```

```
## use function plot_gr to plot fg_plot output
```

```
# plot_gr(gr)
```

While through `plot_gr`, `fg_plot` uses the `ggplot2` package to create static
plot, the user can
also choose to plot `gr` as an interactive plot by setting the `interactive`
parameter to `TRUE` using the `ggiraph` package.

```
# interactive version in beta
plot_gr(gr, interactive=TRUE)
```

# 7 Appendix

## 7.1 Appendix 1: OTher useful plots

Summary statistics can also be analyzed using other plots.

### 7.1.1 QQ plot

For example, the user can plot a static/interactive
`ggiraph` QQ plot of a chosen summary statistic. This plots the p-values against
a uniform distribution.

```
data(fg_data_pos2)
fg1 <- flowGraph(fg_data_pos2$count, class=fg_data_pos2$meta$class,
                 no_cores=no_cores)
```

```
fg_get_summary_desc(fg)
```

```
## $node
##      feat  test_name class  label1  label2
## 1 SpecEnr t_diminish class     exp control
## 2 SpecEnr     t_copy class control     exp
```

```
fg_plot_qq(fg, type="node", index=1)
```

![](data:image/png;base64...)

```
fg_plot_qq(fg, type="node", index=1, logged=TRUE)
```

![](data:image/png;base64...)

```
# interactive version
fg_plot_qq(fg, type="node", index=1, interactive=TRUE)
```

### 7.1.2 Boxplot

To understand how each p-value was obtained, the user can also plot the
distribution of values as boxplots for a specific feature between features of different
class labels.

```
fg_plot_box(fg, type="node", summary_meta=NULL, index=1, node_edge="A+")
```

```
## Bin width defaults to 1/30 of the range of the data. Pick better value with
## `binwidth`.
```

![](data:image/png;base64...)

### 7.1.3 Logged p-value vs feature difference

Another useful plot is to compare the p-value and the difference between the
mean of a feature value between samples of different classes. This should
look like a volcano plot.

```
fg_plot_pVSdiff(fg, type="node", summary_meta=NULL, index=1)
```

![](data:image/png;base64...)

```
# interactive version
fg_plot_pVSdiff(fg, type="node", summary_meta=NULL, index=1, interactive=TRUE)
```

### 7.1.4 Customizing the cell hierarchy plot

The user can also manually specify how the cell hierarchy plot should look. The columns
needed for plotting in `plot_gr` can be attached onto the `graph` slot of the
`fg` the `flowGraph` object using the `ggdf` function. For more information on
these columns, see `?ggdf`.

```
gr <- fg_get_graph(fg)
gr <- ggdf(gr)

gr$v$colour <- ifelse(!grepl("[-]",gr$v$phenotype), 1, 0)
                     # "nodes with only marker conditions", "other nodes")
gr$v$label <- gr$v$phenotype
gr$v$v_ind <- gr$v$label_ind <- TRUE
gr$e$e_ind <- !grepl("[-]",gr$e$from) & !grepl("[-]",gr$e$to)

plot_gr(gr, main="Example cell hierarchy with markers A, B, C, D")
```

![](data:image/png;base64...)

## 7.2 Appendix 2: flowGraphSubset, a fast version of the flowGraph constructor

If the user is only interested in one set of class labels for a set of samples,
they can choose to use `flowGraphSubset`, a faster version of the default constructor
`flowGraph`. It is fast because the edge list, proportion, expected proportion,
and SpecEnr features are only calculated for cell populations who are in the
0’th and 1st layer, or have a significant parent population. The assumption here
is that cell populations who are significantly differentially abundant
must also have at least one significantly differentially abundant parent
population, which is true for almost all cases.

However, if the user wants to test different sets of sample class labels on the
same set of samples, we recommend using the default `flowGraph` constructor
as it calculates SpecEnr for all cell populations. Since SpecEnr only has to be
calculated once, the user can apply multiple statistically significance tests
and ask questions about different class sets on the same SpecEnr values.

So in summary, ONLY USE THIS OVER flowGraph IF: 1) your data set has more than
10,000 cell populations and you want to speed up your calculation time AND
2) you only have one set of classes you want to test on the
SAME SET OF SAMPLES (e.g. control vs experiment).

The parameters for `flowGraphSubset` is a bit different than those in `flowGraph`.
It is currently in beta, so we recommend reading the manual for it carefully.

```
data(fg_data_pos2)
fg <- flowGraphSubset(fg_data_pos2$count, meta=fg_data_pos2$meta, no_cores=no_cores,
                 summary_pars=flowGraphSubset_summary_pars(),
                 summary_adjust=flowGraphSubset_summary_adjust())
```

```
## Warning in flowGraphSubset(fg_data_pos2$count, meta = fg_data_pos2$meta, : The
## fast version of flowGraph is in beta <(@u@<)
```

```
## preparing input;
```

```
## 17:41:18-17:41:18 > 19:00:00
```

```
## preparing to calculate features
```

```
## 17:41:18-17:41:18 > 19:00:00
```

```
## calculating features + edge lists by + p-values for cell populations with significant parents only (this is the fast version of flowGraph);
```

```
## - 6/24 pops @ layer 2
```

```
## Warning in max(ms_[is.finite(ms_)]): no non-missing arguments to max; returning
## -Inf
```

```
## 17:41:18-17:41:18 > 19:00:00
```

```
## - 24/32 pops @ layer 3
```

```
## Warning in max(ms_[is.finite(ms_)]): no non-missing arguments to max; returning
## -Inf
```

```
## 17:41:18-17:41:18 > 19:00:00
```

```
## - 32/16 pops @ layer 4
```

```
## Warning in max(ms_[is.finite(ms_)]): no non-missing arguments to max; returning
## -Inf
```

```
## 17:41:18-17:41:18 > 19:00:00
```

```
## total time used to calcuate features + edge lists: 17:41:18-17:41:18 > 19:00:00
```

```
## 17:41:18-17:41:18 > 19:00:00
```

```
## calculating summary statistics for SpecEnr
```

```
## 17:41:18-17:41:18 > 19:00:00
```

```
## total time used: 17:41:18-17:41:18 > 19:00:00
```

# 8 System information

The following is an output of `sessionInfo()` on the system on which this
document was compiled.

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
## [1] flowGraph_1.18.0 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] gtable_0.3.6            xfun_0.54               bslib_0.9.0
##  [4] ggplot2_4.0.0           htmlwidgets_1.6.4       visNetwork_2.1.4
##  [7] ggrepel_0.9.6           lattice_0.22-7          vctrs_0.6.5
## [10] tools_4.5.1             Rdpack_2.6.4            generics_0.1.4
## [13] parallel_4.5.1          tibble_3.3.0            pkgconfig_2.0.3
## [16] Matrix_1.7-4            data.table_1.17.8       RColorBrewer_1.1-3
## [19] S7_0.2.0                lifecycle_1.0.4         compiler_4.5.1
## [22] farver_2.1.2            stringr_1.5.2           tinytex_0.57
## [25] codetools_0.2-20        fontquiver_0.2.1        fontLiberation_0.1.0
## [28] htmltools_0.5.8.1       sass_0.4.10             yaml_2.3.10
## [31] crayon_1.5.3            pillar_1.11.1           furrr_0.3.1
## [34] jquerylib_0.1.4         cachem_1.1.0            magick_2.9.0
## [37] parallelly_1.45.1       fontBitstreamVera_0.1.1 tidyselect_1.2.1
## [40] digest_0.6.37           stringi_1.8.7           future_1.67.0
## [43] dplyr_1.1.4             purrr_1.1.0             bookdown_0.45
## [46] listenv_0.9.1           labeling_0.4.3          fastmap_1.2.0
## [49] grid_4.5.1              cli_3.6.5               magrittr_2.0.4
## [52] dichromat_2.0-0.1       effsize_0.8.1           withr_3.0.2
## [55] gdtools_0.4.4           scales_1.4.0            rmarkdown_2.30
## [58] matrixStats_1.5.0       globals_0.18.0          igraph_2.2.1
## [61] gridExtra_2.3           evaluate_1.0.5          knitr_1.50
## [64] rbibutils_2.3           rlang_1.1.6             ggiraph_0.9.2
## [67] Rcpp_1.1.0              glue_1.8.0              BiocManager_1.30.26
## [70] jsonlite_2.0.0          R6_2.6.1                systemfonts_1.3.1
```

# References

Aghaeepour, Nima, Greg Finak, Holger Hoos, Tim R Mosmann, Ryan Brinkman, Raphael Gottardo, Richard H Scheuermann, FlowCAP Consortium, DREAM Consortium, and others. 2013. “Critical Assessment of Automated Flow Cytometry Data Analysis Techniques.” *Nature Methods* 10 (3): 228–38.