A Short Introduction to the Omics-
MarkeR Package

Charles Determan Jr.1

1cdetermanjr@gmail.com

October 30, 2018

A Short Introduction to the Omics-
MarkeR Package

Charles Determan Jr.2

2cdetermanjr@gmail.com

October 30, 2018

1

Introduction

The OmicsMarkeR package contains functions to streamline the analysis of
’omics’ level datasets with the objective to classify groups and determine the
most important features. OmicsMarkeR loads packages as needed and assumes
that they are installed.
I will provide a short tutorial using the both synthetic
datasets created by internal functions as well as the ’Sonar’ dataset.

Install OmicsMarkeR using

if (!requireNamespace("BiocManager", quietly=TRUE))

install.packages("BiocManager")

BiocManager::install("OmicsMarkeR")

to ensure that all the needed packages are installed.

A Short Introduction to the Omics-
MarkeR Package

Charles Determan Jr.3

3cdetermanjr@gmail.com

October 30, 2018

2

Basic Classiﬁcation Example

OmicsMarkeR has a few simpliﬁed functions that attempt to streamline the
classiﬁcation and feature selection process including the addition of stability
metrics. We will ﬁrst generate a synthetic dataset. This includes three func-
tions that can be used to create multivariate datasets that can mimic speciﬁc
omics examples. This can include a null dataset via the create.rand.matrix
to create a random multivarate dataset with nvar = 50 and nsamp = 100.
The create.corr.matrix function induces correlations to the datasets. The
create.discr.matrix function induces variables to be discriminate between
groups. The number of groups can be speciﬁed with num.groups.

library("OmicsMarkeR")

set.seed(123)

dat.discr <- create.discr.matrix(

create.corr.matrix(

create.random.matrix(nvar = 50,

nsamp = 100,

st.dev = 1,

perturb = 0.2)),

D = 10

)

To avoid confusion in the coding, one can isolate the variables and classes from
the newly created synthetic dataset. These two objects are then used in the
I can then choose which algorithm(s) to apply e.g.
fs.stability function.
method = c("plsda", "rf"), the number of top important features f = 20,
the number of bootstrap reptititions for stability analysis k = 3, the number
of k-fold cross-validations k.folds = 10 and if I would like to see the progress
output verbose = TRUE.

A Short Introduction to the OmicsMarkeR Package

Warning: You will receive warnings if you run code exactly as shown in this
vignette. This is intentional as the PLSDA runs with this simple dataset often
only need a single component but you need to indicate 2 to ﬁt the model. This
is provided for the users information.

vars <- dat.discr$discr.mat

groups <- dat.discr$classes

fits <- fs.stability(vars,

groups,

method = c("plsda", "rf"),

f = 10,

k = 3,

k.folds = 10,

verbose = 'none')

## randomForest 4.6-14

## Type rfNews() to see new features/changes/bug fixes.

## Loaded gbm 2.1.4

## Loading required package: cluster

## Loading required package: survival

## Loading required package: Matrix

## Loaded glmnet 2.0-16

## Warning in training(data = trainData, method = method[i], tuneValue

= as.data.frame(bestTune[[i]]), :

PLSDA model contained only 1 component.

##

##

PLSDA requires at least 2 components.

## Model fit with 2 components

## Warning in training(data = trainData, method = method[i], tuneValue

= as.data.frame(bestTune[[i]]), :

PLSDA model contained only 1 component.

##

##

PLSDA requires at least 2 components.

## Model fit with 2 components

## Warning in training(data = trainData, method = method[d], tuneValue

= tuned.methods$bestTune[[d]], :

PLSDA model contained only 1 component.

##

##

PLSDA requires at least 2 components.

## Model fit with 2 components

3

A Short Introduction to the OmicsMarkeR Package

## Warning in training(data = trainData.new[[d]], method = method[d],

tuneValue = as.data.frame(t(unlist(tunedModel.new[[d]]$bestTune))),

:

PLSDA model contained only 1 component.

##

##

PLSDA requires at least 2 components.

## Model fit with 2 components

## Warning in training(data = trainData, method = method[d], tuneValue

= tuned.methods$bestTune[[d]], :

PLSDA model contained only 1 component.

##

##

PLSDA requires at least 2 components.

## Model fit with 2 components

## Warning in training(data = trainData.new[[d]], method = method[d],

tuneValue = as.data.frame(t(unlist(tunedModel.new[[d]]$bestTune))),

:

PLSDA model contained only 1 component.

##

##

PLSDA requires at least 2 components.

## Model fit with 2 components

If I would like to see the performance metrics, I can simply use the perfor
mance.metrics function. This will provide a concise data.frame of confusion
matrix and ROC statistics. Additionally, the Robustness-Performance Trade-oﬀ
value (RPT) is provided with the results.

performance.metrics(fits)

##

## Accuracy

## Kappa

## ROC.AUC

plsda

rf

0.88333333 0.90000000

0.76666667 0.80000000

0.92000000 0.98666667

## Sensitivity

0.86666667 0.93333333

## Specificity

0.90000000 0.86666667

## Pos Pred Value

0.90303030 0.88888889

## Neg Pred Value

0.87777778 0.91666667

## Accuracy SD

0.07637626 0.17320508

## Kappa SD

0.15275252 0.34641016

## ROC.AUC SD

0.07549834 0.02309401

## Sensitivity SD

0.11547005 0.11547005

## Specificity SD

0.10000000 0.23094011

## Pos Pred Value SD 0.10013765 0.19245009

## Neg Pred Value SD 0.10715168 0.14433757

fits$RPT

4

A Short Introduction to the OmicsMarkeR Package

##

plsda

rf

## 0.7933472 0.3272727

If I would want to see the occurance of the features the model identiﬁed as the
most important, this is accomplished by feature.table. This function returns
a simple table reporting the consistency (i.e. how many times identiﬁed) and
frequency (percent identiﬁed in all runs).

feature.table(fits, "plsda")

##

features consistency frequency

## 1

## 2

## 3

## 4

## 5

## 6

## 7

## 8

## 9

## 10

## 11

## 12

## 13

V1

V11

V14

V21

V23

V26

V28

V37

V16

V2

V47

V41

V44

3

3

3

3

3

3

3

3

2

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

1

1

0.667

0.333

0.333

0.333

0.333

If the user is interesting in applying the ﬁtted model (determined by fs.stability)
towards some new data this can be accomplished with predictNewClasses.
This could either be yet another level to evaluate the tuned model’s perfor-
mance or if the user is applying the model in a production type setting where
you are systematically using this model on new data that comes in.

# create some 'new' data

newdata <- create.discr.matrix(

create.corr.matrix(

create.random.matrix(nvar = 50,

nsamp = 100,

st.dev = 1,

perturb = 0.2)),

D = 10

)$discr.mat

# original data combined to a data.frame

orig.df <- data.frame(vars, groups)

5

A Short Introduction to the OmicsMarkeR Package

# see what the PLSDA predicts for the new data

# NOTE, newdata does not require a .classes column

predictNewClasses(fits, "plsda", orig.df, newdata)

Note - This function is not as eﬃcient as I would like at present. Currently
it requires the original dataset to reﬁt the model from the parameters retained
from fs.stability.
I intend to provide the option to retain ﬁtted models so
a user can simply pull them without a need to reﬁt. However, I am concerned
about the potential size of objects (e.g. random forest, gbm, etc.). Thoughts
and contributions are welcome.

6

A Short Introduction to the Omics-
MarkeR Package

Charles Determan Jr.4

4cdetermanjr@gmail.com

October 30, 2018

3

Ensemble Methods

In machine learning ensembles of models can be used to obtain better pre-
dictive performance than any individual model. There are multiple types of
ensemble types including the bayes optimal classiﬁer, bayesian model averaging
(BMA), bayesian model combination (BMC), boostrap aggregation (bagging),
and boosting. Although it is the intention to include all the methods the only
currently implemented method is bagging.

Bagging, in the simplest terms, is deﬁned as giving a set of trained models equal
weight when ’voting’ on an optimal solution. The most familiar application of
this concept is in the random forest algorithm. This technique requires a deﬁned
aggregation technique to combine the set of models.
Implemented methods
include Complete Linear Aggregation (CLA), Ensemble Mean (EM), Ensemble
Stability (ES), and Ensemble Exponential (EE).

To conduct an ensemble analysis, the code is nearly identical to the ﬁrst ex-
ample in Section 1. The fs.ensembl.stability function contains the same
arguments as fs.stability in addition to a few more for the ensemble compo-
nents. Please see ?fs.ensemble.stability for complete details on each. The
two major additional parameters are bags and aggregation.metric. The bags
parameter naturally deﬁnes the number of bagging iterations and the aggrega
tion.metric is a string deﬁning the aggregation method. These arguments
have common defaults predeﬁned so the call can be:

fits <- fs.ensembl.stability(vars,

groups,

method = c("plsda", "rf"),

f = 10,

k = 3,

k.folds = 10,

A Short Introduction to the OmicsMarkeR Package

verbose = 'none')

As in Section 1, the performance.metrics function can be applied for summary
statistics.

8

A Short Introduction to the OmicsMarkeR Package

3.1 Aggregation Methods

If the user wishes to apply an aggregation method manually utilizing results
from an alternative analysis, this can also be done. This package provides
a the wrapper aggregation to apply this analysis. For these methods, the
variables must have been ranked and the rownames assigned as the variable
names. The function then will return that aggregated list of variables with their
new respective ranks.

# test data

ranks <- replicate(5, sample(seq(50), 50))

row.names(ranks) <- paste0("V", seq(50))

head(aggregation(ranks, "CLA"))

##

[,1]

## V46

## V39

## V24

## V4

## V12

## V5

1

2

3

4

5

6

This is used internally in fs.ensembl.stability to optimize which variables
are selected to be included in the ﬁnal optimized model. The only exception to
the format above is with the EE function where the number of variables must
be deﬁned with f.

9

A Short Introduction to the Omics-
MarkeR Package

Charles Determan Jr.5

5cdetermanjr@gmail.com

October 30, 2018

4

Custom Tuning

The default implementation assumes that each model will be tuned with the
same resolution of tuning parameters. For example, a default call with PLSDA
and Random Forest will result in tuning 3 components and 3 mtry for each
respectively. However, let’s say I want to be more ﬁne tuned with my random
forest model. You can create a customized grid using denovo.grid.

# requires data.frame of variables and classes

plsda <- denovo.grid(orig.df, "plsda", 3)

rf <- denovo.grid(orig.df, "rf", 5)

# create grid list

# Make sure to assign appropriate model names

grid <- list(plsda=plsda, rf=rf)

# pass to fs.stability or fs.ensemble.stability

fits <- fs.stability(vars,

groups,

method = c("plsda", "rf"),

f = 10,

k = 3,

k.folds = 10,

verbose = 'none',

grid = grid)

The user can create their own grid completely manually but must use the ap-
propriate names as deﬁned by the functions. These can be check with params.
As an example: paramsmethod="plsda".

A Short Introduction to the OmicsMarkeR Package

Note - the argument names must be preceded by a period. This is to prevent
any unforseen conﬂicts in the code.

11

A Short Introduction to the Omics-
MarkeR Package

Charles Determan Jr.6

6cdetermanjr@gmail.com

October 30, 2018

5

Stability Metrics

5.1 Stability Metric Basics

It is quite possible that a user may already have ﬁtted a model previously or
using a model that has not yet been implemented in this package. However,
they may be interested in applying one or more of the stability metrics deﬁned
within this package. These functions are very simple to use. To demonstrate,
let’s create some sample data consisting of our Metabolite Population.

metabs <- paste("Metabolite", seq(20), sep="_")

Now, let’s say you have run you diﬀerent special model twice on diﬀerent sam-
ples of a dataset. You complete your feature selection and get two lists of
Metabolites. Here I am just randomly sampling.

set.seed(13)

run1 <- sample(metabs, 10)

run2 <- sample(metabs, 10)

The user can now evaluate how similar the sets of metabolites selected are
via multiple possible stability metrics. These include the Jaccard Index (jac
card), Dice-Sorensen (sorensen), Ochiai’s Index (ochiai), Percent of Over-
lapping Features (pof), Kuncheva’s Index (kuncheva), Spearman (spearman),
and Canberra (canberra). The latter two methods are not Set Methods and
do require the same number of features in each vector. The relevant citations
are provided in each function’s documenation.

The general use for most of the functions is:

A Short Introduction to the OmicsMarkeR Package

jaccard(run1, run2)

## [1] 0.25

The exception to this is Kuncheva’s Index. This requires one additional param-
eter, the number of features (e.g. metabolites) in the original dataset. This
metric is designed to account for smaller numbers of variables increasing the
likelihood of matching sets by chance. Naturally, if you have many more vari-
ables it would be far more indicative of signiﬁcance if you see the same small
subset again and again as opposed to a small set seeing the same variables.

# In this case, 20 original variables

kuncheva(run1, run2, 20)

## [1] 0.4

13

A Short Introduction to the OmicsMarkeR Package

5.2 Pairwise Stability

5.2.1 Pairwise Feature Stability

The above examples immediately lead to the question, what if I have more than
two runs? What I have 3, 5, 10, or more bootstrap iterations? This is also know
as a data perturbation ensemble approach. It would be very tedious to have to
call the same function for every single comparison. Therefore a pairwise function
exists to allow a rapid comparison between all sets. This pairwise.stability
is very similar to the individual stability functions in practice. Let’s take an
example consisting of 5 runs.

set.seed(21)

# matrix of Metabolites identified (e.g. 5 trials)

features <- replicate(5, sample(metabs, 10))

Please note that currently only matrix objects are accepted by pairwise.stability.
To use the function, you simply pass your matrix of variables and stability metric
(e.g. sorensen). The only exception is when applying Kuncheva’s Index where
the nc parameter again must be set (which can be ignored otherwise). This will
return all list containing the upper triangular matrix of stability values and an
overall average.

pairwise.stability(features, "sorensen")

## $comparisons

##

Resample.2 Resample.3 Resample.4 Resample.5

0.4

0.0

0.0

0.0

0.4

0.5

0.0

0.0

0.5

0.5

0.5

0.0

0.5

0.5

0.5

0.7

## Resample.1

## Resample.2

## Resample.3

## Resample.4

##

## $overall

## [1] 0.5

14

A Short Introduction to the OmicsMarkeR Package

5.2.2 Pairwise Model Stability

Now, in the spirit of this package, you may have the alternate approach whereby
you have created several bootstrapped data sets and run a diﬀerent statistical
model on each data set. You could compare each one manually, but again
to avoid such tedious work another function is provided for speciﬁcally this
purpose. Let’s take a theoretical example where I have bootstrapped 5 dif-
ferent data sets and applied two models to each dataset (PLSDA and Ran-
dom Forest). Please note that currently only list objects are accepted by pair
wise.model.stability.

Note - here I am only randomly sampling but in practice the each model would
have been trained on the same dataset.

set.seed(999)

plsda <-

replicate(5, paste("Metabolite", sample(metabs, 10), sep="_"))

rf <-

replicate(5, paste("Metabolite", sample(metabs, 10), sep="_"))

features <- list(plsda=plsda, rf=rf)

# nc may be omitted unless using kuncheva

pairwise.model.stability(features, "kuncheva", nc=20)

## $comparisons

##

Resample.1 Resample.2 Resample.3 Resample.4 Resample.5

## plsda.vs.rf

0.3

0.2

0.5

0.3

0.5

##

## $overall

## [1] 0.36

15

A Short Introduction to the OmicsMarkeR Package

6

Permuation Analysis

One additional level of analysis often applied to these datasets is Monte Carlo
Permuations. For example, I would like to check the chance that my data can
distinguish between the groups by chance. This can be done by permuting the
groups in the dataset and applying the model on each permuation. This can be
accomplished with perm.class, which also provides a plot of the classiﬁcation
distribution. Additionally, one may be interested in another way to evaluate the
importance of variables to the distinguishing the groups. Once again, groups
can be permuted, the model reﬁt to the data and the importance of the variables
evaluated. This is accomplished with perm.features.

# permuate class

perm.class(fits, vars, groups, "rf", k.folds=5,

metric="Accuracy", nperm=10)

# permute variables/features

perm.features(fits, vars, groups, "rf",

sig.level = .05, nperm = 10)

16

A Short Introduction to the OmicsMarkeR Package

7

Parallel Analysis

Given the repetitive nature of this analysis there are ample opportunities to level
the power of parallel computing. These include fs.stability, fs.ensembl.stability,
perm.class, and perm.features simply by specifying the parameter allowPar
allel = TRUE in the respective function. However, the parallel backend must
be registered in order to work. There are slight diﬀerences between operating
systems so here are two examples.

For Unix OS, you probably will use doMC

library(doMC)

n <- detectCores()

registerDoMC(n)

For a Windows OS, you likely with use the doSNOW

library(parallel)

library(doSNOW)

# get number of cores

n <- detectCores()

# make clusters

cl <- makeCluster(n)

# register backend

registerDoSNOW(cl)

NOTE - remember to stop your clusters on Windows when you are ﬁnished
with stopCluster(cl).

17

A Short Introduction to the OmicsMarkeR Package

sessionInfo()

## R version 3.5.1 Patched (2018-07-12 r74967)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 16.04.5 LTS

##

## Matrix products: default

## BLAS: /home/biocbuild/bbs-3.8-bioc/R/lib/libRblas.so

## LAPACK: /home/biocbuild/bbs-3.8-bioc/R/lib/libRlapack.so

##

## locale:

##

##

##

##

[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_US.UTF-8
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

##
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##

## attached base packages:

## [1] stats

graphics grDevices utils

datasets

methods

base

##

##

##

## other attached packages:
[1] caTools_1.17.1.1
[4] pamr_1.55
[7] gbm_2.1.4

glmnet_2.0-16
survival_2.43-1
e1071_1.7-0
##
## [10] DiscriMiner_0.1-29 plyr_1.8.4
## [13] OmicsMarkeR_1.14.0
##

## loaded via a namespace (and not attached):

Matrix_1.2-14
cluster_2.0.7-1
randomForest_4.6-14
foreach_1.4.4

##

##

##

##

[1] nlme_3.1-137
[3] lubridate_1.7.4
[5] dimRed_0.1.0
[7] assertive.datetimes_0.0-2
[9] backports_1.1.2

##
## [11] rpart_4.1-13
## [13] colorspace_1.3-2
## [15] nnet_7.3-12
## [17] withr_2.1.2
## [19] tidyselect_0.2.5
## [21] compiler_3.5.1
## [23] assertive.files_0.0-2
## [25] sfsmisc_1.1-2

bitops_1.0-6
assertive.models_0.0-2
rprojroot_1.3-2
tools_3.5.1
R6_2.3.0
lazyeval_0.2.1
permute_0.9-4
assertive.data_0.0-1
assertive.reflection_0.0-4
gridExtra_2.3
assertive.properties_0.0-4
scales_1.0.0
DEoptimR_1.0-8

18

A Short Introduction to the OmicsMarkeR Package

## [27] robustbase_0.93-3
## [29] digest_0.6.18
## [31] assertive.numbers_0.0-2
## [33] htmltools_0.3.6
## [35] rlang_0.3.0.1
## [37] assertive_0.3-5
## [39] dplyr_0.7.7
## [41] magrittr_1.5
## [43] munsell_0.5.0
## [45] stringi_1.2.4
## [47] yaml_2.2.0
## [49] recipes_0.1.3
## [51] pls_2.7-0
## [53] lattice_0.20-35
## [55] splines_3.5.1
## [57] pillar_1.3.0
## [59] stats4_3.5.1
## [61] codetools_0.2-15
## [63] magic_1.5-9
## [65] evaluate_0.12
## [67] BiocManager_1.30.3
## [69] purrr_0.2.5
## [71] kernlab_0.9-27
## [73] assertthat_0.2.0
## [75] DRR_0.0.3
## [77] prodlim_2018.04.18
## [79] assertive.types_0.0-3
## [81] class_7.3-14
## [83] timeDate_3043.102
## [85] tibble_1.4.2
## [87] bindrcpp_0.2.2
## [89] assertive.matrices_0.0-1
## [91] assertive.data.us_0.0-2
## [93] ipred_0.9-7

stringr_1.3.1
rmarkdown_1.10
pkgconfig_2.0.2
highr_0.7
ddalpha_1.3.4
bindr_0.1.1
ModelMetrics_1.2.0
Rcpp_0.12.19
abind_1.4-5
assertive.base_0.0-7
MASS_7.3-51
grid_3.5.1
crayon_1.3.4
assertive.code_0.0-3
knitr_1.20
assertive.sets_0.0-3
reshape2_1.4.3
CVST_0.2-2
glue_1.3.0
data.table_1.11.8
gtable_0.2.0
tidyr_0.8.2
assertive.strings_0.0-3
ggplot2_3.1.0
gower_0.1.2
broom_0.5.0
assertive.data.uk_0.0-2
geometry_0.3-6
RcppRoll_0.3.0
iterators_1.0.10
lava_1.6.3
caret_6.0-80
BiocStyle_2.10.0

19

