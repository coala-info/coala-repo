# moanin: An R Package for Time Course RNASeq Data Analysis

The package moanin was developed to provide a simple and efficient workflow
for long time-course gene expression data. It makes it simple to do
differential expression between conditions based on either individual
condition comparisons per time point, or by fitting spline functions per gene.
There are also functions to help with clustering and visualization.

We do not detail all of the features of the package here, but some of the main
functions. See our more in-depth workflow paper at
<https://github.com/NelleV/2019timecourse-rnaseq-pipeline>.

# Setup

We will work with time course data available in the accompanying
`timecoursedata` package. This is mRNA-Seq timecourse data on a plant,
sorghum. The plants were sampled every week for 17 weeks. The plants were of
two different varieties (i.e. different genotypes), and under three different
watering conditions:

* Control: regular weekly watering
* Preflowering drought: plants under drought under pre-flowering (weeks before
  week 9), and watered like control for week 9 and afterward.
* Postflowering drought: plants were regularly watered pre-flowering (weeks
  through week 9), and then watering withheld weeks 10 onward.

This data is available on both the leaf and the root sampled from the same
plant. We will concentrate on the leaf samples, available as a dataset
`varoquaux2019leaf`.

```
library(moanin)
library(timecoursedata)
data(varoquaux2019leaf)
names(varoquaux2019leaf)
```

```
## [1] "data" "meta"
```

The `data` element contains the gene expression data, while the `meta` data
consists of information regarding the samples.

For simplicity, we are going to focus on comparing the three different
watering conditions within the “BT642” variety (the variety known for
comparative tolerance of pre-flowering drought). We are also going to drop
Week 2, which is only measured in the control samples.

```
whSamples<-with(varoquaux2019leaf$meta,which(Genotype=="BT642" & Week >2))
preData<-varoquaux2019leaf$data[,whSamples]
preMeta<-varoquaux2019leaf$meta[whSamples,]
dim(preData)
```

```
## [1] 34211    97
```

```
dim(preMeta)
```

```
## [1] 97 22
```

# Set up `moanin` class

The first step is to create a moanin class, which uses our meta data to create
the needed information for future analysis. Specifically, in addition to
storing the meta information, the function `create_moanin_model` will define a
splines basis for future calculations. By default the model is given as a
separate spline basis for each level of a factor `Group`, plus a group
intercept with the following R formula

`~Group:ns(Timepoint, df=4) + Group + 0`

```
moaninObject <- create_moanin_model(data=preData, meta=preMeta,
                            group_variable="Condition", time_variable="Week")
moaninObject
```

```
## Moanin object on 97 samples containing the following information:
## Group variable given by 'Condition' with the following levels:
##       Control Postflowering  Preflowering
##            37            21            39
## Time variable given by 'Week'
## Basis matrix with 15 basis_matrix functions
## Basis matrix was constructed with the following spline_formula
## ~Condition + Condition:splines::ns(Week, df = 4) + 0
##
## Information about the data (a SummarizedExperiment object):
## class: SummarizedExperiment
## dim: 34211 97
## metadata(0):
## assays(1): ''
## rownames(34211): Sobic.001G000100.v3.1 Sobic.001G000200.v3.1 ...
##   Sobic.K044420.v3.1 Sobic.K044505.v3.1
## rowData names(0):
## colnames(97): 0622162L06 0622162L14 ... 0928169L11 0928169L19
## colData names(23): Barcode libraryName ... Group WeeklyGroup
```

## Moanin and SummarizedExperiment

`Moanin` extends the `SummarizedExperiment` class, and as such the data as
well as the meta data are saved in one object. This means you can index the
`Moanin` object like a regular matrix, and safely be indexing the related meta
data:

```
moaninObject[,1:2]
```

```
## Moanin object on 2 samples containing the following information:
## Group variable given by 'Condition' with the following levels:
##       Control Postflowering  Preflowering
##             0             0             2
## Time variable given by 'Week'
## Basis matrix with 15 basis_matrix functions
## Basis matrix was constructed with the following spline_formula
## ~Condition + Condition:splines::ns(Week, df = 4) + 0
##
## Information about the data (a SummarizedExperiment object):
## class: SummarizedExperiment
## dim: 34211 2
## metadata(0):
## assays(1): ''
## rownames(34211): Sobic.001G000100.v3.1 Sobic.001G000200.v3.1 ...
##   Sobic.K044420.v3.1 Sobic.K044505.v3.1
## rowData names(0):
## colnames(2): 0622162L06 0622162L14
## colData names(23): Barcode libraryName ... Group WeeklyGroup
```

## Log-tranformation

Because we have count data from mRNA-Seq, we set the argument to
`log_transform=TRUE`. This means that many of the functions will internally
use the transformation `log(x+1)` on the `assay(moaninObject)` for
computations and visualizations. However, for some steps of the DE process the
counts will be used (see below). The user can also just transform the data
herself,

```
logMoaninObject<-moaninObject
assay(logMoaninObject)<-log(assay(moaninObject)+1)
```

# Weekly differential expression analysis

One type of DE analysis we can do is to compare our watering conditions to
each other, for every time point. We do this via a call to `limma` for the DE
analysis, but before we can do this, we need to set up the appropriate
contrasts. For example, “Preflowering - Control” (see `?makeContrasts` in the
limma package). We provide a function to do this for every week, so as to
avoid this step.

```
preContrasts <- create_timepoints_contrasts(moaninObject,"Preflowering", "Control")
```

Notice we also get a warning that timepoint 16 is missing in our Control
Samples (in fact, some of these time points only have a single observations
per time point, which is not particularly appropriate for DE analysis per
week).

We can also create contrasts to compare Postflowering and Control, and
Preflowering and Postflowering. We get many warnings here, because
Post-flowering only has samples after week 9.

```
postContrasts <- create_timepoints_contrasts(
    moaninObject, "Postflowering", "Control" )
prepostContrasts <- create_timepoints_contrasts(
    moaninObject, "Postflowering", "Preflowering")
```

We can run the DE analysis, setting `use_voom_weights=TRUE` to make use of
`limma` correction for low-counts. We will subset to just the first 500 genes
for illustration purposes, though the full set of genes does not take very
long

```
weeklyPre <- DE_timepoints(moaninObject[1:500,],
    contrasts=c(preContrasts,postContrasts,prepostContrasts),
     use_voom_weights=TRUE)
```

By setting `use_voom_weights=TRUE`, the DE step is done after an
`upperquartile` normalization via `limma` using voom weights (see
`?DE_timepoints` for details). Therefore this should only be done if the input
data to the `Moanin` class are counts (or on a count scale, such as expected
counts from TopHat); in this case the user should set `log_transform=TRUE` in
the construction of the `Moanin` object, so that other functions will take the
log appropriately.

The results give the raw p-value (`_pval`), the FDR adjusted p-values
(`_qval`), and the estimate of log-fold-change (`_lfc`) for each week (3
columns for each of the 41.3333333 contrasts):

```
dim(weeklyPre)
```

```
## [1] 500 124
```

```
head(weeklyPre[,1:10])
```

```
##                       Preflowering.3-Control.3_pval
## Sobic.001G000100.v3.1                    0.76536810
## Sobic.001G000200.v3.1                    0.01792812
## Sobic.001G000300.v3.1                    0.75321943
## Sobic.001G000400.v3.1                    0.23603662
## Sobic.001G000501.v3.1                    0.75321943
## Sobic.001G000700.v3.1                    0.05623940
##                       Preflowering.3-Control.3_qval
## Sobic.001G000100.v3.1                     0.9797530
## Sobic.001G000200.v3.1                     0.1846252
## Sobic.001G000300.v3.1                     0.9773063
## Sobic.001G000400.v3.1                     0.6737601
## Sobic.001G000501.v3.1                     0.9773063
## Sobic.001G000700.v3.1                     0.3506479
##                       Preflowering.3-Control.3_stat
## Sobic.001G000100.v3.1                     0.2997152
## Sobic.001G000200.v3.1                    -2.4298499
## Sobic.001G000300.v3.1                     0.3157538
## Sobic.001G000400.v3.1                    -1.1962154
## Sobic.001G000501.v3.1                     0.3157538
## Sobic.001G000700.v3.1                    -1.9445369
##                       Preflowering.3-Control.3_lfc
## Sobic.001G000100.v3.1                    0.1299887
## Sobic.001G000200.v3.1                   -0.2784645
## Sobic.001G000300.v3.1                    0.1299887
## Sobic.001G000400.v3.1                   -0.3489825
## Sobic.001G000501.v3.1                    0.1299887
## Sobic.001G000700.v3.1                   -0.3264107
##                       Preflowering.4-Control.4_pval
## Sobic.001G000100.v3.1                     0.2246243
## Sobic.001G000200.v3.1                     0.9816365
## Sobic.001G000300.v3.1                     0.2010749
## Sobic.001G000400.v3.1                     0.9204185
## Sobic.001G000501.v3.1                     0.2010749
## Sobic.001G000700.v3.1                     0.1981497
##                       Preflowering.4-Control.4_qval
## Sobic.001G000100.v3.1                     0.6582724
## Sobic.001G000200.v3.1                     0.9996358
## Sobic.001G000300.v3.1                     0.6328245
## Sobic.001G000400.v3.1                     0.9923999
## Sobic.001G000501.v3.1                     0.6328245
## Sobic.001G000700.v3.1                     0.6311796
##                       Preflowering.4-Control.4_stat
## Sobic.001G000100.v3.1                   -1.22620835
## Sobic.001G000200.v3.1                   -0.02310767
## Sobic.001G000300.v3.1                   -1.29182582
## Sobic.001G000400.v3.1                   -0.10030257
## Sobic.001G000501.v3.1                   -1.29182582
## Sobic.001G000700.v3.1                    1.30036901
##                       Preflowering.4-Control.4_lfc
## Sobic.001G000100.v3.1                  -0.59288007
## Sobic.001G000200.v3.1                  -0.00294096
## Sobic.001G000300.v3.1                  -0.59288007
## Sobic.001G000400.v3.1                  -0.02930903
## Sobic.001G000501.v3.1                  -0.59288007
## Sobic.001G000700.v3.1                   0.23682625
##                       Preflowering.5-Control.5_pval
## Sobic.001G000100.v3.1                    0.65566564
## Sobic.001G000200.v3.1                    0.03374307
## Sobic.001G000300.v3.1                    0.63855049
## Sobic.001G000400.v3.1                    0.62614311
## Sobic.001G000501.v3.1                    0.63855049
## Sobic.001G000700.v3.1                    0.09088703
##                       Preflowering.5-Control.5_qval
## Sobic.001G000100.v3.1                     0.9479415
## Sobic.001G000200.v3.1                     0.2641503
## Sobic.001G000300.v3.1                     0.9422691
## Sobic.001G000400.v3.1                     0.9392177
## Sobic.001G000501.v3.1                     0.9422691
## Sobic.001G000700.v3.1                     0.4472248
```

## Compare change across two time points

Different types of contrasts are available within `create_timepoint_contrasts` based on the `type` argument. Previously we used the default (`per_timepoint_group_diff`) which gives the group differences per timepoint.

We can also use the same kind of approach to compare within a group the difference between two timepoints. Here we look at the difference between adjacent timepoints in “Postflowering”,

```
preDiffContrasts <- create_timepoints_contrasts(
    moaninObject, "Preflowering" ,type="per_group_timepoint_diff")
head(preDiffContrasts)
```

```
## [1] "Preflowering.4-Preflowering.3" "Preflowering.5-Preflowering.4"
## [3] "Preflowering.6-Preflowering.5" "Preflowering.7-Preflowering.6"
## [5] "Preflowering.8-Preflowering.7" "Preflowering.9-Preflowering.8"
```

We can also compare these time differences between the two groups, a contrast that takes the form of
$$(TP i - TP (i-1))[Group1] - (TP i - TP (i-1))[Group2]$$
These contrasts we can create by setting `type="group_and_timepoint_diff"`

```
preGroupDiffContrasts <- create_timepoints_contrasts(
    moaninObject, "Preflowering", "Control" ,type="group_and_timepoint_diff")
head(preGroupDiffContrasts)
```

```
## [1] "Preflowering.4-Preflowering.3-Control.4+Control.3"
## [2] "Preflowering.5-Preflowering.4-Control.5+Control.4"
## [3] "Preflowering.6-Preflowering.5-Control.6+Control.5"
## [4] "Preflowering.7-Preflowering.6-Control.7+Control.6"
## [5] "Preflowering.8-Preflowering.7-Control.8+Control.7"
## [6] "Preflowering.9-Preflowering.8-Control.9+Control.8"
```

By default the consecutive times are compared, but we could instead compare non-consecutive time points by giving an explicit vector of the timepoints to compare:

```
preGroupDiffContrasts <- create_timepoints_contrasts(
    moaninObject, "Preflowering", "Control" ,
    type="group_and_timepoint_diff",timepoints_before=c(6,8),timepoints_after=c(8,9))
head(preDiffContrasts)
```

```
## [1] "Preflowering.4-Preflowering.3" "Preflowering.5-Preflowering.4"
## [3] "Preflowering.6-Preflowering.5" "Preflowering.7-Preflowering.6"
## [5] "Preflowering.8-Preflowering.7" "Preflowering.9-Preflowering.8"
```

We can again submit these contrasts to `DE_timepoints`

```
weeklyGroupDiffPre <- DE_timepoints(moaninObject[1:500,],
    contrasts=preGroupDiffContrasts,
     use_voom_weights=TRUE)
head(weeklyGroupDiffPre)
```

```
##                       Preflowering.8-Preflowering.6-Control.8+Control.6_pval
## Sobic.001G000100.v3.1                                              0.9612681
## Sobic.001G000200.v3.1                                              0.8165300
## Sobic.001G000300.v3.1                                              0.9591972
## Sobic.001G000400.v3.1                                              0.1581953
## Sobic.001G000501.v3.1                                              0.9591972
## Sobic.001G000700.v3.1                                              0.5374101
##                       Preflowering.8-Preflowering.6-Control.8+Control.6_qval
## Sobic.001G000100.v3.1                                              0.9859861
## Sobic.001G000200.v3.1                                              0.9859861
## Sobic.001G000300.v3.1                                              0.9859861
## Sobic.001G000400.v3.1                                              0.5711023
## Sobic.001G000501.v3.1                                              0.9859861
## Sobic.001G000700.v3.1                                              0.8829429
##                       Preflowering.8-Preflowering.6-Control.8+Control.6_stat
## Sobic.001G000100.v3.1                                            -0.04875335
## Sobic.001G000200.v3.1                                             0.23297007
## Sobic.001G000300.v3.1                                            -0.05136226
## Sobic.001G000400.v3.1                                            -1.42789767
## Sobic.001G000501.v3.1                                            -0.05136226
## Sobic.001G000700.v3.1                                             0.62008344
##                       Preflowering.8-Preflowering.6-Control.8+Control.6_lfc
## Sobic.001G000100.v3.1                                           -0.02997072
## Sobic.001G000200.v3.1                                            0.03705210
## Sobic.001G000300.v3.1                                           -0.02997072
## Sobic.001G000400.v3.1                                           -0.50155205
## Sobic.001G000501.v3.1                                           -0.02997072
## Sobic.001G000700.v3.1                                            0.13191551
##                       Preflowering.9-Preflowering.8-Control.9+Control.8_pval
## Sobic.001G000100.v3.1                                             0.91272717
## Sobic.001G000200.v3.1                                             0.26354443
## Sobic.001G000300.v3.1                                             0.90337595
## Sobic.001G000400.v3.1                                             0.26165476
## Sobic.001G000501.v3.1                                             0.90337595
## Sobic.001G000700.v3.1                                             0.07772335
##                       Preflowering.9-Preflowering.8-Control.9+Control.8_qval
## Sobic.001G000100.v3.1                                              0.9859861
## Sobic.001G000200.v3.1                                              0.6857079
## Sobic.001G000300.v3.1                                              0.9859861
## Sobic.001G000400.v3.1                                              0.6852847
## Sobic.001G000501.v3.1                                              0.9859861
## Sobic.001G000700.v3.1                                              0.4294108
##                       Preflowering.9-Preflowering.8-Control.9+Control.8_stat
## Sobic.001G000100.v3.1                                             -0.1100345
## Sobic.001G000200.v3.1                                             -1.1279932
## Sobic.001G000300.v3.1                                             -0.1218812
## Sobic.001G000400.v3.1                                             -1.1325129
## Sobic.001G000501.v3.1                                             -0.1218812
## Sobic.001G000700.v3.1                                             -1.7929195
##                       Preflowering.9-Preflowering.8-Control.9+Control.8_lfc
## Sobic.001G000100.v3.1                                           -0.06710784
## Sobic.001G000200.v3.1                                           -0.17955292
## Sobic.001G000300.v3.1                                           -0.07105937
## Sobic.001G000400.v3.1                                           -0.39745351
## Sobic.001G000501.v3.1                                           -0.07105937
## Sobic.001G000700.v3.1                                           -0.38408585
```

# Time-course differential expression analysis between two groups

The results of such a weekly analysis can be quite difficult to interpret, the
number of replicates per week can be quite low, and different numbers of
replicates in different weeks can make it difficult to compare the analysis
across weeks.

An alternative approach is to fit a smooth spline to each gene per group, and
perform differential tests as to whether there are differences between the
spline functions between two groups. We provide this function in
`DE_timecourse`, where the user provides a string of comparisons that they
wish to make:

```
timecourseContrasts <- c("Preflowering-Control",
			 "Postflowering-Control",
			 "Postflowering-Preflowering")
splinePre <- DE_timecourse(moaninObject[1:500,], contrasts=timecourseContrasts,
     use_voom_weights=TRUE)
```

Again, because our input data are counts, we set `use_voom_weights=TRUE` to
weight our observations based on their variability. Because we set
`log_transform=TRUE` in our creation of `moaninObject`, the function will
internally take the log of the data for fitting the splines, but use the
counts for creating the voom weights (see `?DE_timecourse`).

Each contrast has a `pval` and a `qval` column:

```
head(splinePre)
```

```
##                       Preflowering-Control_stat Preflowering-Control_pval
## Sobic.001G000100.v3.1                0.01705773                 0.9229855
## Sobic.001G000200.v3.1                0.04164459                 0.6376211
## Sobic.001G000300.v3.1                       NaN                       NaN
## Sobic.001G000400.v3.1                0.07252041                 0.3216344
## Sobic.001G000501.v3.1                       NaN                       NaN
## Sobic.001G000700.v3.1                0.01855565                 0.9090003
##                       Preflowering-Control_qval Postflowering-Control_stat
## Sobic.001G000100.v3.1                 0.9615052                   44473.10
## Sobic.001G000200.v3.1                 0.8386392                   39917.79
## Sobic.001G000300.v3.1                       NaN                        NaN
## Sobic.001G000400.v3.1                 0.7532769                   37281.24
## Sobic.001G000501.v3.1                       NaN                        NaN
## Sobic.001G000700.v3.1                 0.9578671                   15626.66
##                       Postflowering-Control_pval Postflowering-Control_qval
## Sobic.001G000100.v3.1              5.529379e-189              3.738172e-188
## Sobic.001G000200.v3.1              4.643003e-187              2.561657e-186
## Sobic.001G000300.v3.1                        NaN                        NaN
## Sobic.001G000400.v3.1              7.646941e-186              3.989708e-185
## Sobic.001G000501.v3.1                        NaN                        NaN
## Sobic.001G000700.v3.1              2.319492e-170              5.651555e-170
##                       Postflowering-Preflowering_stat
## Sobic.001G000100.v3.1                        47350.91
## Sobic.001G000200.v3.1                        42488.44
## Sobic.001G000300.v3.1                             NaN
## Sobic.001G000400.v3.1                        39383.08
## Sobic.001G000501.v3.1                             NaN
## Sobic.001G000700.v3.1                        16329.55
##                       Postflowering-Preflowering_pval
## Sobic.001G000100.v3.1                   4.228971e-190
## Sobic.001G000200.v3.1                   3.593765e-188
## Sobic.001G000300.v3.1                             NaN
## Sobic.001G000400.v3.1                   8.070841e-187
## Sobic.001G000501.v3.1                             NaN
## Sobic.001G000700.v3.1                   3.819566e-171
##                       Postflowering-Preflowering_qval
## Sobic.001G000100.v3.1                   2.780693e-189
## Sobic.001G000200.v3.1                   1.960236e-187
## Sobic.001G000300.v3.1                             NaN
## Sobic.001G000400.v3.1                   4.210873e-186
## Sobic.001G000501.v3.1                             NaN
## Sobic.001G000700.v3.1                   9.259553e-171
```

There is not a log-fold change column, because it is more complicated to
define the log-fold change over a series of timepoints, where potentially the
means may even switch from being over-expressed to under-expressed. We provide
a function `estimate_log_fold_change` which gives the option of estimating
several kinds of log-fold-change. We demonstrate with the method `abs_sum`,
which gives the sum of the absolute difference in the means across time
points:

```
log_fold_change_timepoints <- estimate_log_fold_change(
    moaninObject[1:500,], contrasts=timecourseContrasts, method="sum")
head(log_fold_change_timepoints)
```

```
##                       Preflowering-Control Postflowering-Control
## Sobic.001G000100.v3.1           -0.3333333            -0.3333333
## Sobic.001G000200.v3.1          212.6666667             7.0000000
## Sobic.001G000300.v3.1            0.0000000             0.0000000
## Sobic.001G000400.v3.1          103.0000000            78.3333333
## Sobic.001G000501.v3.1            0.0000000             0.0000000
## Sobic.001G000700.v3.1          -68.3333333           875.0000000
##                       Postflowering-Preflowering
## Sobic.001G000100.v3.1                    0.00000
## Sobic.001G000200.v3.1                 -205.66667
## Sobic.001G000300.v3.1                    0.00000
## Sobic.001G000400.v3.1                  -24.66667
## Sobic.001G000501.v3.1                    0.00000
## Sobic.001G000700.v3.1                  943.33333
```

See `?estimate_log_fold_change` to see the full set of methods.

# Visualizing Genes of Interest

The package `moanin` also provides a simple utility function
(`plot_splines_data`) to visualize gene time-course data from different
conditions. We use this to plot the 10 genes with the largest log-fold-change
in `Preflowering-Control` contrast (since we only looked at the first top 500,
these aren’t representative of the overall signal in the data set, which is
much stronger).

```
whSig <- which(splinePre[,"Preflowering-Control_qval"]<0.05)
deGenes <- order(abs(
    log_fold_change_timepoints)[whSig,"Preflowering-Control"],
    decreasing=TRUE)[1:10]

plot_splines_data(moaninObject[whSig, ][deGenes,],
    smooth=TRUE, mar=c(1.5,2.5,2,0.1))
```

![plot of chunk unnamed-chunk-18](data:image/png;base64...)

plot of chunk unnamed-chunk-18

# Clustering of time-course data

We can also cluster the data based on their spline fits. Here we would like to
work with the log transform of the counts which are stored in `moaninObject`,
so we set `log_transform=TRUE`.

```
# First fit the kmeans clusters
kmeans_clusters <- splines_kmeans(moaninObject[1:500,], n_clusters=3,
    random_seed=42,
    n_init=20)
```

We then use the `plot_splines_data` function, only now applied to the
centroids of the kmeans clustering, to visualize the centroids of each cluster
obtained with the splines k-means model.

```
plot_splines_data(
    data=kmeans_clusters$centroids, moaninObject,
    smooth=TRUE)
```

![plot of chunk unnamed-chunk-19](data:image/png;base64...)

plot of chunk unnamed-chunk-19

## Assigning genes to clusters

Because there is variability in how well the genes fit a cluster, we would
like to be able to score how well a gene fits a cluster. Furthermore, we often
chose a subset of genes based on a filtering process, and we would like to
have a mechanism to assign all genes to a cluster.

The function `splines_kmeans_score_and_label` gives a goodness-of-fit score
between each gene and each cluster.

```
scores_and_labels <- splines_kmeans_score_and_label(
    object=moaninObject,data=preData[1:2000,], kmeans_clusters=kmeans_clusters)
```

Notice that we used more genes here (first 2000), even though previously we
only used first 500 to make the clusters. These choices were unrealistic,
since in practice we would probably pick high variable genes or differentially
expressed genes, rather than the first 500, but at least give a sense of how
this works.

The result is a list with elements `scores` and `labels`. `scores` gives the
goodness-of-fit score between each gene and each cluster

```
head(scores_and_labels$scores)
```

```
##                            [,1]      [,2]      [,3]
## Sobic.001G000100.v3.1 0.9999882 0.9979535 0.9866289
## Sobic.001G000200.v3.1 0.9999664 0.9999940 0.9029515
## Sobic.001G000300.v3.1 1.0000000 1.0000000 1.0000000
## Sobic.001G000400.v3.1 1.0000000 1.0000000 0.8527001
## Sobic.001G000501.v3.1 1.0000000 1.0000000 1.0000000
## Sobic.001G000700.v3.1 0.9967245 0.9689555 0.9140339
```

`labels` gives the best cluster assignment for each gene, but only if its
score in its best cluster is above a certain threshold (see
`?splines_kmeans_score_and_label`)

```
head(scores_and_labels$labels)
```

```
## Sobic.001G000100.v3.1 Sobic.001G000200.v3.1 Sobic.001G000300.v3.1
##                    NA                     3                    NA
## Sobic.001G000400.v3.1 Sobic.001G000501.v3.1 Sobic.001G000700.v3.1
##                     3                    NA                     3
```

```
# How many are not assigned a label?
sum(is.na(scores_and_labels$labels))
```

```
## [1] 1000
```