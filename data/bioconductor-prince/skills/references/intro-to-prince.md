# Interactome reconstruction from co-elution data with PrInCE

Michael Skinnider1\*

1Michael Smith Laboratories, University of British Columbia, Vancouver, Canada

\*michael.skinnider@msl.ubc.ca

#### 30 October 2025

#### Abstract

Co-elution proteomics refers to a family of high-throughput methods to map protein-protein interaction networks and their dynamics in cellular stimulation or differentiation. These methods, also referred to as co-migration, co-fractionation, or protein correlation profiling, involve separating interacting protein complexes on the basis of their diameter or biochemical properties. Protein-protein interactions can then be inferred for pairs of proteins with similar elution profiles. PrInCE implements a machine-learning approach to identify protein-protein interactions given a set of labelled examples, using features derived exclusively from the data. This allows PrInCE to infer high-quality protein interaction networks from raw proteomics data, without bias towards known interactions or functionally associated proteins, making PrInCE a unique computational resource for discovery. We provide an overview of the key functionalities of the PrInCE R package, and demonstrate an example of the analysis of data from a co-elution experiment investigating the response of the cytoplasmic interactome to Fas-mediated apoptosis.

#### Package

PrInCE 1.26.0

## 0.1 Introduction: What is PrInCE?

Proteins are the central players of life at the molecular level.
Yet cellular functions are rarely accomplished by single proteins acting in
isolation.
Instead, most biological processes are accomplished by the dynamic organization
of proteins and other biological macromolecules, such as RNA and DNA, into
networks of physical interactions.
Systematic maps of these protein interaction networks can provide a
“wiring diagram” to complement the “parts list” revealed by genome sequencing,
placing each protein into a functional context.
However, historically, protein interaction networks were mapped primarily
using labour-intensive methods that involved tagging each protein for affinity
purification, or heterologously expressing them in yeast.
Besides being labour intensive, these approaches also yielded static pictures
of cellular networks that offered little insight into how these networks are
rewired by stimulation or in differentiation.

Recently, a family of proteomic approaches, variously referred to as
co-elution, co-migration, co-fractionation, or protein correlation profiling,
has been developed that allow high-throughput mapping of protein interaction
networks in native cellular conditions
([1](#ref-kristensen2012)–[3](#ref-kirkwood2013)).
A subset of these even enable investigators to identify dynamic rearrangements
in the protein-protein interactome in response to cellular stimulation
([1](#ref-kristensen2012), [4](#ref-scott2017)), or across *in vivo* samples, such as mouse
tissues ([5](#ref-skinnider2018atlas)).
The underlying principle that unifies different experimental protocols is to
separate protein complexes into a number of fractions, on the basis of their
size (diameter) or biochemical properties, and to perform quantitative
proteomic analysis of the fractions.
Proteins with similar “profiles” across fractions can be inferred to
physically interact.
However, because the number of potential pairs grows quadratically with the
number of proteins quantified, and the number of potential complexes grows
even faster, specialized bioinformatic approaches are required to infer
protein interaction networks from the raw proteomics data.

PrInCE is an R package that uses a machine learning approach to infer
protein-protein interaction networks at a user-defined level of precision
from co-elution proteomics data.
The input to PrInCE consists of a matrix derived from a co-elution proteomics
experiment, with quantitations for each protein in each fraction (PrInCE can
also handle more than one such matrix, in the case of biological replicates).
PrInCE also requires a set of ‘gold standard’ protein complexes to learn from.
It then calculates a series of features for each possible protein pair;
importantly, these are derived directly from the data, without incorporating
any external knowledge, a step that minimizes bias towards the rediscovery of
known interactions ([6](#ref-skinnider2018)).
These features, and the accompanying gold standard, are used as input to the
classifier, which learns to distinguish interacting and non-interacting pairs.
A cross-validation procedure is then used to score every potential protein
pair in the dataset, which are then ranked by their score in descending order,
and the precision (defined as the ratio of true positives to true positives
plus false positives) is calculated at every point in this ranked list.
The user can then apply a precision threshold of their choice to this ranked
list to infer the protein-protein interaction network from their experiment.

## 0.2 Example 1: Interactome rearrangements in apoptosis

To demonstrate the use of PrInCE, we will work through a small example that
is derived from a subset of the data presented in Scott *et al.*, 2017
([4](#ref-scott2017)).
In this paper, the authors mapped rearrangements in the cytoplasmic and
membrane interactome during Fas-mediated apoptosis.
Control and stimulated cytoplasmic and membrane interactomes were quantified
in three replicates each, meaning the complete dataset consists of twelve
replicates.
In practice, each set of replicates would be analyzed together (for a total
of four networks).
However, such a complete analysis of the dataset would take over an hour, so
for this vignette we focus on a single replicate.
The replicate in question is the first cytoplasmic replicate from the
Fas-stimulated condition, and is bundled with the PrInCE package; it can be
loaded with the following command:

```
library(PrInCE)
data(scott)
```

The dataset consists of ratiometric protein quantitations, achieved by SILAC
(stable isotope labelling by amino acids in cell culture), for 1,560 proteins
in 55 size exclusion chromatography (SEC) fractions:

```
dim(scott)
```

```
## [1] 1560   55
```

Each protein was quantified in at least one fraction; however, many
measurements are missing:

```
scott[1:10, 1:5]
```

```
##            SEC_1 SEC_2 SEC_3  SEC_4  SEC_5
## A0AVT1       NaN   NaN   NaN    NaN    NaN
## A0MZ66-5     NaN   NaN   NaN    NaN    NaN
## A3KN83       NaN   NaN   NaN    NaN    NaN
## A5YKK6       NaN   NaN   NaN    NaN    NaN
## A6NDG6       NaN   NaN   NaN    NaN    NaN
## A6NG79       NaN   NaN   NaN    NaN    NaN
## A6NHL2-2     NaN   NaN   NaN    NaN    NaN
## A6NHR9       NaN   NaN   NaN 2.5125 1.8817
## A6NIH7       NaN   NaN   NaN    NaN    NaN
## A6NN80   0.22313   NaN   NaN    NaN    NaN
```

This scenario is common in co-elution data: for example, a protein will be
absent entirely from a given SEC fraction if it does not form a complex with
a molecular weight in the mass range of that fraction.

To predict protein-protein interactions using PrInCE’s machine-learning
approach, we also need two additional pieces of information to train the
classifier: a set of true positive interactions, and a set of true negative
interactions.
In practice, we recommend providing a list of experimentally verified protein
complexes: PrInCE assumes intra-complex interactions represent true positives,
and inter-complex interactions represent true negatives.
These can be obtained from a number of sources, such as the CORUM database
([7](#ref-giurgiu2018)), or our own previously reported custom subset of CORUM that
removes complexes which may not remain intact under co-elution conditions
([8](#ref-stacey2018)).
In the PrInCE R package, we provide a third option which is distributed under
a CC-BY license, consisting of a list of 477 human protein complexes
from the Complex Portal ([9](#ref-meldal2018)).

```
data(gold_standard)
head(gold_standard)
```

```
## $`5-hydroxytryptamine-3A/B receptor complex`
## [1] "O95264" "P46098"
##
## $`5-hydroxytryptamine-3A/C receptor complex`
## [1] "P46098" "Q8WXA8"
##
## $`5-hydroxytryptamine-3A/D receptor complex`
## [1] "P46098" "Q70Z44"
##
## $`5-hydroxytryptamine-3A/E receptor complex`
## [1] "P46098" "A5X5Y0"
##
## $`6-phosphofructokinase, M2L2 heterotetramer`
## [1] "P08237" "P17858"
##
## $`ACF complex`
## [1] "Q9NRL2" "O60264"
```

### 0.2.1 Predicting protein-protein interactions: one-step analysis

The main function of the PrInCE package, `PrInCE`, provides an end-to-end
workflow for predicting protein-protein interaction networks from the
raw co-elution data.
Briefly, this function first filters proteins with too little information
to permit data analysis, then cleans the profiles for the remaining proteins
and fits a mixture of Gaussians to each cleaned profile.
PrInCE then calculates six features for each protein pair, from either the raw
profiles, the cleaned profiles, or the fitted Gaussian mixture models, and
concatenates features across replicates if more than one replicate was used.
These features are used as input to a machine learning model, along with the
set of ‘gold standard’ true positive and true negative interactions, which
uses a ten-fold cross-validation procedure to assign scores to each protein
pair.
Protein pairs are ranked by their classifier scores and the precision at each
point in the ranked list is calculated.
The entire list is returned to a user, who can select a precision threshold
that matches their needs.

Once we have loaded a co-elution matrix and list of gold standard protein
complexes into R, inferring the protein-protein interaction network with
PrInCE is therefore as simple as the following command:

```
# set the seed to ensure reproducible output
set.seed(0)
## not evaluated
PrInCE(scott, gold_standard)
```

However, this command is not evaluated in order to provide some information
on a further parameter that the `PrInCE` function takes.
One of the six features that PrInCE uses to score protein-protein interactions
is derived from fitting a mixture of Gaussians to each protein’s elution
profile.
The process of Gaussian fitting also allows PrInCE to filter proteins with
poor-quality elution profiles (i.e., proteins for which a Gaussian mixture
could not be fit with an r2 value above some minimum, set to 0.5 by default).
However, the process of fitting Gaussian mixture models to thousands of
curves is one of the more computationally intensive steps in PrInCE and
consequently, the `PrInCE` function can also take a pre-computed list of
fitted Gaussians, fit using the command `build_gaussians`:

```
# set the seed to ensure reproducible output
set.seed(0)
## not evaluated
build_gaussians(scott)
```

In practice, the ability to provide pre-computed Gaussians can also save
time when trying different parameters in PrInCE, such as different types of
classifiers (described in greater detail in the following section).

We provide a list of fitted Gaussians for the `scott` dataset in the
`scott_gaussians` object:

```
data(scott_gaussians)
str(scott_gaussians[[3]])
```

```
## List of 5
##  $ n_gaussians: int 3
##  $ R2         : num 0.95
##  $ iterations : num 1
##  $ coefs      :List of 3
##   ..$ A    : Named num [1:3] 2.9 1.59 1.21
##   .. ..- attr(*, "names")= chr [1:3] "A1" "A2" "A3"
##   ..$ mu   : Named num [1:3] 16.05 4.91 40.95
##   .. ..- attr(*, "names")= chr [1:3] "mu1" "mu2" "mu3"
##   ..$ sigma: Named num [1:3] 6.74 3.11 3.32
##   .. ..- attr(*, "names")= chr [1:3] "sigma1" "sigma2" "sigma3"
##  $ curveFit   : num [1:55] 0.348 0.701 1.161 1.581 1.789 ...
```

We therefore run PrInCE using our precomputed Gaussian curves with the
following command, allowing PrInCE to print information about the status of
the analysis (`verbose = TRUE`) and limiting the number of cross-validation
folds for the sake of time:

```
# set the seed to ensure reproducible output
set.seed(0)
# one-step analysis
interactions <- PrInCE(scott, gold_standard,
                       gaussians = scott_gaussians,
                       cv_folds = 3,
                       verbose = TRUE)
```

```
## generating features for replicate 1 ...
```

```
##   fit mixtures of Gaussians to 970 of 1560 profiles
```

```
## concatenating features across replicates ...
```

```
## making labels ...
```

```
## training classifiers ...
```

```
head(interactions, 50)
```

```
##                 protein_A protein_B     score label precision
## P12956_P13010      P12956    P13010 0.9977337     1       1.0
## P36578_P40429      P36578    P40429 0.9966806    NA       1.0
## P62258_Q04917      P62258    Q04917 0.9966630    NA       1.0
## P36578_P46778      P36578    P46778 0.9966609    NA       1.0
## P40429_P46778      P40429    P46778 0.9966256    NA       1.0
## D3YTB1_P62424      D3YTB1    P62424 0.9966104    NA       1.0
## P18124_P46778      P18124    P46778 0.9965548    NA       1.0
## P25786_P28066      P25786    P28066 0.9964794    NA       1.0
## P11940_Q08211      P11940    Q08211 0.9964540     0       0.5
## P14868_P41252      P14868    P41252 0.9964416    NA       0.5
## P43686_P62195      P43686    P62195 0.9964398    NA       0.5
## O00231_Q9UNM6      O00231    Q9UNM6 0.9964243    NA       0.5
## P05388_P36578      P05388    P36578 0.9964118    NA       0.5
## E7EPB3_P05388      E7EPB3    P05388 0.9963531    NA       0.5
## P05388_P40429      P05388    P40429 0.9962900    NA       0.5
## C9J4Z3_P36578      C9J4Z3    P36578 0.9962752    NA       0.5
## P62424_Q9Y3U8      P62424    Q9Y3U8 0.9962596    NA       0.5
## P47914_P62913      P47914    P62913 0.9962394    NA       0.5
## P54136_Q15046      P54136    Q15046 0.9962349    NA       0.5
## P24534_P26641      P24534    P26641 0.9962061    NA       0.5
## P62750_P84098      P62750    P84098 0.9961731    NA       0.5
## P35998_Q13200      P35998    Q13200 0.9961714    NA       0.5
## P13796_Q96KP4      P13796    Q96KP4 0.9961656    NA       0.5
## P18124_P36578      P18124    P36578 0.9961590    NA       0.5
## O15067_Q9UNZ2      O15067    Q9UNZ2 0.9961433    NA       0.5
## P61254_P62241      P61254    P62241 0.9961293    NA       0.5
## P07195_P63104      P07195    P63104 0.9961071    NA       0.5
## C9J4Z3_D3YTB1      C9J4Z3    D3YTB1 0.9961065    NA       0.5
## P04075_P31946      P04075    P31946 0.9960961    NA       0.5
## D3YTB1_P36578      D3YTB1    P36578 0.9960820    NA       0.5
## P49207_P62906      P49207    P62906 0.9960814    NA       0.5
## C9J4Z3_P05388      C9J4Z3    P05388 0.9960643    NA       0.5
## P46778_P61313      P46778    P61313 0.9960462    NA       0.5
## P62249_P62263      P62249    P62263 0.9960311    NA       0.5
## E7EPB3_P05387      E7EPB3    P05387 0.9960072    NA       0.5
## D3YTB1_P47914      D3YTB1    P47914 0.9959959    NA       0.5
## P13796_P22392-2    P13796  P22392-2 0.9959923    NA       0.5
## P30520_Q9NY33      P30520    Q9NY33 0.9959870    NA       0.5
## P05387_P05388      P05387    P05388 0.9959828    NA       0.5
## P47914_P62424      P47914    P62424 0.9959807    NA       0.5
## P18124_P40429      P18124    P40429 0.9959782    NA       0.5
## P07814_P54136      P07814    P54136 0.9959722    NA       0.5
## P40429_P62906      P40429    P62906 0.9959695    NA       0.5
## P18124_P61313      P18124    P61313 0.9959678    NA       0.5
## P05388_P46778      P05388    P46778 0.9959540    NA       0.5
## D3YTB1_P05388      D3YTB1    P05388 0.9959445    NA       0.5
## P08590_P60660-2    P08590  P60660-2 0.9959252    NA       0.5
## P26373_P32969      P26373    P32969 0.9959108    NA       0.5
## P13639_P27348      P13639    P27348 0.9959085    NA       0.5
## P05387_P46778      P05387    P46778 0.9958969    NA       0.5
```

The columns in the output are as follows:

* `protein_A`: the identifier of the first protein in the pair;
* `protein_B`: the identifier of the second in the pair;
* `score`: the score assigned to the protein pair by the classifier
* `label`: if the protein pair is in the reference set, this value will be
  `1` (for true positives) or `0` (for true negatives); for all other pairs,
  the value is `NA`
* `precision`: the precision at this point in the ranked list

Note that at the very top of the list, the precision is not defined if no
true positives *and* no true negatives have yet been encountered.

In this toy example, the small size of our dataset and the small size of our
gold-standard complexes mean that the precision curve is unstable below
about 2,000 interactions:

```
precision <- interactions$precision[1:10000]
plot(precision)
```

![](data:image/png;base64...)

In most real examples, the precision curve shows a smoother decline.

For illustrative purposes, we here threshold the network at 50% precision
using the `threshold_precision` function:

```
network <- threshold_precision(interactions, threshold = 0.5)
nrow(network)
```

```
## [1] 7607
```

This results in an unweighted protein-protein interaction network with
7607 interactions.

### 0.2.2 Predicting protein-protein interactions: step-by-step analysis

The `PrInCE` function accepts a large number of arguments that were
omitted from the preceding discussion.
We have strived to set reasonable defaults for each of these parameters,
based on analyses that have involved much of the human co-elution proteomics
data in the public domain.
However, users may wish to change some of these defaults, based on the
properties of their dataset or the biological questions motivating their
investigation.
Here, we provide an alternative workflow for analyzing the `scott` dataset
in a step-by-step manner, and a discussion of some of the most important
parameters.

#### 0.2.2.1 `build_gaussians`

The `build_gaussians` function in PrInCE can be broken down into three steps.
First, profiles are preprocessed by basic filtering and cleaning operations.
Single missing values are imputed as the mean of their two neighboring points,
and profiles with fewer than five consecutive points are filtered from
further analysis.
Profiles are then cleaned by replacing missing values with near-zero noise,
and smoothed with a moving average filter.
Finally, mixtures of one to five Gaussians are fit to each profile using
nonlinear least squares, and model selection is performed to retain the best
mixture model for each curve.
Proteins that could not be fit with a mixture of Gaussians without an r2
value above some minimum are omitted.

This function takes the following parameters:

* `min_consecutive`: the minimum number of consecutive points, after imputing
  single missing values, to retain a profile; defaults to `5`
* `min_points`: the minimum number of total points to retain a profile;
  defaults to `1` so that only the number of consecutive points is used to
  filter profiles
* `impute_NA`: if `FALSE`, skip imputation of single missing values
* `smooth`: if `FALSE`, skip curve smoothing with the moving average filter
* `smooth_width`: width of the moving average filter, in fractions;
  defaults to `4`
* `max_gaussians`: the maximum number of Gaussians with which to fit each
  profile; defaults to `5`
* `criterion`: the criterion used for model selection; defaults to `AICc`,
  the corrected Akaike information criterion; other options are `BIC`
  (Bayesian information criterion) or `AIC` (Akaike information criterion)
* `max_iterations`: the maximum number of iterations to use for curve fitting
  with random restarts
* `min_R_squared`: the minimum r2 value to retain the fitted curve;
  defaults to `0.5`. Profiles that cannot be fit by a mixture of Gaussians are
  assumed to be low-quality and excluded from further analysis by default.
* `method`: method used to select initial conditions for `nls`; can select
  either random parameters (`random`) or make an educated guess based on the
  maximum values in the profile (`guess`, the default)
* `filter_gaussians_center`, `filter_gaussians_height`,
  `filter_gaussians_variance_min`, `filter_gaussians_variance_max`:
  heuristics used to filter poor-quality Gaussian fits. If `TRUE` (default),
  `filter_gaussians_center` will remove Gaussians whose mean falls outside
  the bounds of the chromatogram. `filter_gaussians_height` controls the
  minimum height of the Gaussians, while `filter_gaussians_variance_min` and
  `filter_gaussians_variance_max` control the range of their standard deviation.

All of these parameters except the last four are exposed through the `PrInCE`
function.

As an example, we will re-analyze the `scott` dataset with stricter filtering
criteria, requiring the presence of at least ten (non-imputed) data points
in addition to five consecutive points; fitting with a maximum of three
Gaussians, instead of five; and requiring a better fit than the default
settings.
For the sake of time, we allow only 10 iterations for the curve-fitting
algorithm here, and we elect to fit only the first 500 profiles.

```
data(scott)
# set the seed to ensure reproducible output
set.seed(0)
# fit Gaussians
gauss <- build_gaussians(scott[seq_len(500), ],
                         min_points = 10, min_consecutive = 5,
                         max_gaussians = 3, min_R_squared = 0.75,
                         max_iterations = 10)
```

```
## .. fitting Gaussian mixture models to 255 profiles
```

```
# filter profiles that were not fit
scott <- scott[names(gauss), ]
```

By default, the profile matrix is filtered to exclude proteins whose elution
profiles could not be fit by a mixture of Gaussians prior to featurization.

#### 0.2.2.2 `calculate_features`

Having fitted our co-elution profiles with Gaussians and filtered them
accordingly, the next step is to calculate features for each protein pair.
This is done using the `calculate_features` function.
By default, PrInCE calculates six features from each pair of co-elution
profiles as input to the classifier, including conventional similarity metrics
but also several features specifically adapted to co-elution proteomics.
The complete set of features includes:

1. the Pearson correlation between raw co-elution profiles;
2. the p-value of the Pearson correlation between raw co-elution profiles;
3. the Pearson correlation between cleaned profiles, which are generated by
   imputing single missing values with the mean of their neighbors, replacing
   remaining missing values with random near-zero noise, and smoothing the
   profiles using a moving average filter (see `clean_profile`);
4. the Euclidean distance between cleaned profiles;
5. the ‘co-peak’ score, defined as the distance, in fractions, between the
   maximum values of each profile; and
6. the ‘co-apex’ score, defined as the minimum Euclidean distance between any
   pair of fit Gaussians

In addition to the profile matrix and list of fitted Gaussian mixtures, the
`calculate_features` function takes six parameters that enable the user to
enable or disable each of these six features (in order, `pearson_R_raw`,
`pearson_P`, `pearson_R_cleaned`, `euclidean_distance`, `co_peak`, and
`co_apex`).
By default, all six are enabled.

Continuing our example, if we wanted the classifier to omit the Euclidean
distance, we could disable this feature using the following command:

```
feat <- calculate_features(scott, gauss, euclidean_distance = FALSE)
head(feat)
```

```
##   protein_A protein_B    cor_R_raw cor_R_cleaned       cor_P co_peak   co_apex
## 1    A0AVT1    B3KNT8 1.239943e+00      1.097955 0.504313944      11 10.405282
## 2    B3KNT8    B4DQ14 1.264748e+00      1.262210 0.382046523      32 31.566148
## 3    A0AVT1    B4DQJ8 2.851543e-06      1.018199 0.001520321       2  2.714134
## 4    B3KNT8    B4DQJ8 1.045782e+00      1.110313 0.827969878      13  7.815383
## 5    B4DQ14    B4DQJ8 3.928140e-01      1.064420 0.110395487      45 23.819433
## 6    B3KNT8    B4DVY1 1.577634e+00      1.114307 0.001033478      27  9.043456
```

If we had multiple replicates, we would here concatenate them into a single
feature data frame using the `concatenate_features` function:

```
## not run
# concatenate features from three different `scott` replicates
feat1 <- calculate_features(scott1, gauss1)
feat2 <- calculate_features(scott2, gauss2)
feat3 <- calculate_features(scott3, gauss3)
feat <- concatenate_features(list(feat1, feat2, feat3))
```

#### 0.2.2.3 `predict_interactions`

With our features in hand and a list of gold standard protein complexes, we can
now provide these to a machine-learning classifier to rank potential
interactions.
This is accomplished using the `predict_interactions` function.
In order to score interactions that are also part of the reference set, PrInCE
uses a cross-validation strategy, randomly splitting the reference data into
ten folds, and using each split to score interactions in one of the folds
without including them in the training data.
For interactions that are not part of the training set, the median score over
all ten folds is returned.
In addition, to ensure that the results are not sensitive to the way in which
the dataset is split, PrInCE averages predictions over an ensemble of ten
classifiers, each with different cross-validation splits.
By default, PrInCE uses a naive Bayes classifier.
However, the PrInCE R package also implements three other types of classifiers:
support vector machine, random forest, and logistic regression.
In addition, PrInCE offers an option to ensemble results over multiple
different classifiers (sometimes called “heterogeneous classifier fusion”
([10](#ref-riniker2013))).
In this option, cross-validation and ensembling is performed for all four
types of classifiers independently, then the ranks of each protein pair
across all four classifiers are averaged to return the final ranked list.

These options are controlled using the following parameters:

* `classifier`: the type of classifier to use; one of `NB`, `SVM`, `RF`, `LR`,
  or `ensemble`, corresponding to the options described above
* `models`: the size of the ensemble for each classifier type, i.e., the
  number of models to train, each with a different train-test split
* `cv_folds`: the number of folds to use in k-fold cross-validation
* `trees`: for random forest and heterogeneous classifier fusion only,
  the number of trees in each RF model

Continuing our example, we will demonstrate the use of a support vector
machine to rank potential interactions (`classifier = "SVM"`).
For the sake of time, we use a single model (omitting ensembling; `models = 1`)
and only three-fold cross-validation folds (`cv_folds = 3`).
To use our list of protein complexes as a gold standard, we must first convert
it to an adjacency matrix; this is done using the helper function
`adjacency_matrix_from_list` (see also the related function
`adjacency_matrix_from_data_frame`).

```
data(gold_standard)
reference <- adjacency_matrix_from_list(gold_standard)
# set the seed to ensure reproducible output
set.seed(0)
# predict interactions
ppi <- predict_interactions(feat, reference, classifier = "SVM",
                            models = 1, cv_folds = 3)
```

We can now plot the precision curve over the first 20,000 interactions:

```
precision <- ppi$precision[seq_len(2e4)]
plot(precision)
```

![](data:image/png;base64...)

Finally, we will likely want to keep only the set of high-confidence
interactions for further analysis, where “confidence” is quantified using
precision.
This is accomplished using the `threshold_precision` function.
For example, the following command constructs a protein-protein interaction
network at 70% precision:

```
net <- threshold_precision(ppi, threshold = 0.7)
nrow(net)
```

```
## [1] 4118
```

### 0.2.3 Identifying co-eluting protein complexes

The core functionality of PrInCE involves the use of a machine-learning
framework to predict binary interactions from co-elution data, with discovery
of novel interactions being a primary goal.
However, PrInCE also implements one alternative to this analytical framework,
which asks whether statistically significant co-elution is observed for
*known* protein complexes.
This is achieved using a permutation-based approach, inspired by methods
developed for another proteomic method for interactome profiling,
thermal proximity co-aggregation (TPCA) ([11](#ref-tan2018)).
Briefly, given a list of known complexes, PrInCE calculates the median
Pearson correlation between all pairs of complex members.
(To reduce the effect of spurious correlations between proteins that are
rarely observed in the same fractions, PrInCE requires a certain minimum
number of paired observations to include any given correlation in this
analysis—by default, 10 pairs).
Then, PrInCE simulates a large number of complexes of equivalent size
(by default, 100), and calculates the median Pearson correlation between
pairs of random ‘complexes’.
The resulting null distribution is used to assess the statistical significance
of the observed co-elution profile at the protein complex level.

To identify complexes from the Complex Portal dataset that are significantly
co-eluting in this replicate, we first use PrInCE’s `filter_profiles` and
`clean_profiles` functions:

```
# analyze cleaned profiles
data(scott)
filtered = filter_profiles(scott)
chromatograms = clean_profiles(filtered)
```

The `filter_profiles` function uses a permissive set of filters to discard
chromatograms that do not contain enough information to make inferences
about that protein’s interaction partners.
Similarly, the `clean_profiles` applies some simple preprocessing steps to the
filtered chromatograms.
By default, this function is applied to calculate Pearson correlations
during interaction prediction in PrInCE.
It imputes single missing values as the average of the two neighbors,
remaining missing values with near-zero noise, then passes a moving-average
filter over the chromatogram to smooth it.

We can now test for complex co-elution in the preprocessed chromatogram matrix
using the `detect_complexes` function:

```
# detect significantly co-eluting complexes
set.seed(0)
z_scores = detect_complexes(chromatograms, gold_standard)
```

Complexes that could not be tested (that is, with fewer than three complex
members present in the elution matrix) are given `NA` values, which we remove.

```
# remove complexes that could not be analyzed
z_scores = na.omit(z_scores)
# how many could be tested?
length(z_scores)
```

```
## [1] 23
```

```
# how many were significant at uncorrected, two-tailed p < 0.05?
sum(z_scores > 1.96)
```

```
## [1] 13
```

```
# print the top complexes
head(sort(z_scores, decreasing = TRUE))
```

```
##                                                      COP9 signalosome variant 1
##                                                                        9.083072
##                                                      COP9 signalosome variant 2
##                                                                        6.744865
##                                             CRD-mediated mRNA stability complex
##                                                                        5.806526
##                                                                     MCM complex
##                                                                        5.779922
##                                                             Condensin I complex
##                                                                        4.568462
## Embryonic stem cell-specific SWI/SNF ATP-dependent chromatin remodeling complex
##                                                                        4.256243
```

Of the 23 complexes that could be tested in this (unusually sparse) replicate,
13 were significant at an uncorrected, two-tailed p-value threshold of 0.05

## 0.3 Example 2: Interactome of HeLa cells

As a second example, we can reanalyze another dataset bundled with the PrInCE
R package.
This dataset consists of a subset of the data presented by Kristensen *et al.*,
2012 ([1](#ref-kristensen2012)), who applied SEC-PCP-SILAC to monitor the interactome
of HeLa cell lysates, then mapped interactome rearrangements induced by
epidermal growth factor (EGF) stimulation.
Three biological replicate experiments were performed, and in practice,
all three replicates from each condition would be analyzed together.
However, for the purposes of demonstrating the use of the PrInCE R package,
we limit our analysis to the first replicate from the unstimulated condition.

We first load the data matrix and fitted Gaussians, provided with the PrInCE
R package:

```
data("kristensen")
data("kristensen_gaussians")
dim(kristensen)
```

```
## [1] 1875   48
```

```
length(kristensen_gaussians)
```

```
## [1] 1117
```

The co-elution matrix contains quantifications for 1,875 proteins across 48
SEC fractions.
Mixtures of Gaussians were fit to 1,117 of these.
For the sake of time, we subset this matrix further to the first 500 proteins:

```
kristensen <- kristensen[names(kristensen_gaussians), ]
kristensen <- kristensen[seq_len(500), ]
kristensen_gaussians <- kristensen_gaussians[rownames(kristensen)]
```

We also have to load our reference set of binary interactions or protein
complexes, which in this case is derived from the Complex Portal human
complexes.

```
data("gold_standard")
head(gold_standard, 5)
```

```
## $`5-hydroxytryptamine-3A/B receptor complex`
## [1] "O95264" "P46098"
##
## $`5-hydroxytryptamine-3A/C receptor complex`
## [1] "P46098" "Q8WXA8"
##
## $`5-hydroxytryptamine-3A/D receptor complex`
## [1] "P46098" "Q70Z44"
##
## $`5-hydroxytryptamine-3A/E receptor complex`
## [1] "P46098" "A5X5Y0"
##
## $`6-phosphofructokinase, M2L2 heterotetramer`
## [1] "P08237" "P17858"
```

We can predict interactions in a single step using the main `PrInCE` function,
here using a single model (instead of the default ensemble of ten) and five
cross-validation folds (instead of the default of ten) for time:

```
# set seed for reproducibility
set.seed(0)
# predict interactions
interactions <- PrInCE(profiles = kristensen,
                       gold_standard = gold_standard,
                       gaussians = kristensen_gaussians,
                       models = 1,
                       cv_folds = 5)
```

Finally, we can subset our list of interactions to obtain set of high-confidence
interactions for further analysis, using a relaxed precision cutoff of 50%.

```
network <- threshold_precision(interactions, 0.5)
nrow(network)
```

```
## [1] 1404
```

PrInCE predicts a total of 1,047 interactions at a precision of 50%.

## 0.4 Session info

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
## [1] PrInCE_1.26.0    BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3          rstudioapi_0.17.1
##   [3] jsonlite_2.0.0              MultiAssayExperiment_1.36.0
##   [5] magrittr_2.0.4              magick_2.9.0
##   [7] farver_2.1.2                MALDIquant_1.22.3
##   [9] rmarkdown_2.30              fs_1.6.6
##  [11] vctrs_0.6.5                 base64enc_0.1-3
##  [13] tinytex_0.57                htmltools_0.5.8.1
##  [15] S4Arrays_1.10.0             BiocBaseUtils_1.12.0
##  [17] progress_1.2.3              curl_7.0.0
##  [19] SparseArray_1.10.0          Formula_1.2-5
##  [21] mzID_1.48.0                 TTR_0.24.4
##  [23] sass_0.4.10                 bslib_0.9.0
##  [25] htmlwidgets_1.6.4           naivebayes_1.0.0
##  [27] plyr_1.8.9                  impute_1.84.0
##  [29] zoo_1.8-14                  cachem_1.1.0
##  [31] igraph_2.2.1                lifecycle_1.0.4
##  [33] iterators_1.0.14            pkgconfig_2.0.3
##  [35] Matrix_1.7-4                R6_2.6.1
##  [37] fastmap_1.2.0               rbibutils_2.3
##  [39] MatrixGenerics_1.22.0       clue_0.3-66
##  [41] digest_0.6.37               pcaMethods_2.2.0
##  [43] colorspace_2.1-2            S4Vectors_0.48.0
##  [45] Hmisc_5.2-4                 GenomicRanges_1.62.0
##  [47] Spectra_1.20.0              abind_1.4-8
##  [49] compiler_4.5.1              doParallel_1.0.17
##  [51] speedglm_0.3-5              htmlTable_2.4.3
##  [53] S7_0.2.0                    backports_1.5.0
##  [55] tseries_0.10-58             BiocParallel_1.44.0
##  [57] DBI_1.2.3                   biglm_0.9-3
##  [59] LiblineaR_2.10-24           MASS_7.3-65
##  [61] DelayedArray_0.36.0         mzR_2.44.0
##  [63] tools_4.5.1                 ranger_0.17.0
##  [65] PSMatch_1.14.0              foreign_0.8-90
##  [67] lmtest_0.9-40               quantmod_0.4.28
##  [69] nnet_7.3-20                 glue_1.8.0
##  [71] quadprog_1.5-8              nlme_3.1-168
##  [73] QFeatures_1.20.0            grid_4.5.1
##  [75] checkmate_2.3.3             cluster_2.1.8.1
##  [77] reshape2_1.4.4              generics_0.1.4
##  [79] gtable_0.3.6                preprocessCore_1.72.0
##  [81] tidyr_1.3.1                 data.table_1.17.8
##  [83] hms_1.1.4                   MetaboCoreUtils_1.18.0
##  [85] XVector_0.50.0              BiocGenerics_0.56.0
##  [87] foreach_1.5.2               pillar_1.11.1
##  [89] stringr_1.5.2               limma_3.66.0
##  [91] robustbase_0.99-6           dplyr_1.1.4
##  [93] lattice_0.22-7              tidyselect_1.2.1
##  [95] knitr_1.50                  gridExtra_2.3
##  [97] bookdown_0.45               urca_1.3-4
##  [99] IRanges_2.44.0              Seqinfo_1.0.0
## [101] ProtGenerics_1.42.0         SummarizedExperiment_1.40.0
## [103] forecast_8.24.0             stats4_4.5.1
## [105] xfun_0.53                   Biobase_2.70.0
## [107] statmod_1.5.1               MSnbase_2.36.0
## [109] timeDate_4051.111           matrixStats_1.5.0
## [111] DEoptimR_1.1-4              stringi_1.8.7
## [113] lazyeval_0.2.2              yaml_2.3.10
## [115] evaluate_1.0.5              codetools_0.2-20
## [117] tester_0.3.0                MsCoreUtils_1.22.0
## [119] tibble_3.3.0                BiocManager_1.30.26
## [121] cli_3.6.5                   affyio_1.80.0
## [123] rpart_4.1.24                Rdpack_2.6.4
## [125] jquerylib_0.1.4             dichromat_2.0-0.1
## [127] Rcpp_1.1.0                  XML_3.99-0.19
## [129] parallel_4.5.1              fracdiff_1.5-3
## [131] ggplot2_4.0.0               prettyunits_1.2.0
## [133] AnnotationFilter_1.34.0     scales_1.4.0
## [135] xts_0.14.1                  affy_1.88.0
## [137] ncdf4_1.24                  purrr_1.1.0
## [139] crayon_1.5.3                rlang_1.1.6
## [141] vsn_3.78.0
```

## References

1. Kristensen AR, Gsponer J, Foster LJ (2012) A high-throughput approach for measuring temporal changes in the interactome. *Nature Methods* 9(9):907–909.

2. Havugimana PC, et al. (2012) A census of human soluble protein complexes. *Cell* 150(5):1068–1081.

3. Kirkwood KJ, Ahmad Y, Larance M, Lamond AI (2013) Characterisation of native protein complexes and protein isoform variation using size-fractionation based quantitative proteomics. *Molecular & Cellular Proteomics*:mcp–M113.

4. Scott NE, et al. (2017) Interactome disassembly during apoptosis occurs independent of caspase cleavage. *Molecular Systems Biology* 13(1):906.

5. Skinnider MA, et al. (2018) An atlas of protein-protein interactions across mammalian tissues. *bioRxiv*:351247.

6. Skinnider MA, Stacey RG, Foster LJ (2018) Genomic data integration systematically biases interactome mapping. *PLoS Computational Biology* 14(10):e1006474.

7. Giurgiu M, et al. (2018) CORUM: The comprehensive resource of mammalian protein complexes—2019. *Nucleic Acids Research*.

8. Stacey RG, Skinnider MA, Chik JH, Foster LJ (2018) Context-specific interactions in literature-curated protein interaction databases. *BMC Genomics* 19(1):758.

9. Meldal BH, et al. (2018) Complex portal 2018: Extended content and enhanced visualization tools for macromolecular complexes. *Nucleic Acids Research*.

10. Riniker S, Fechner N, Landrum GA (2013) Heterogeneous classifier fusion for ligand-based virtual screening: Or, how decision making by committee can be a good thing. *Journal of chemical information and modeling* 53(11):2829–2836.

11. Tan CSH, et al. (2018) Thermal proximity coaggregation for system-wide profiling of protein complex dynamics in cells. *Science* 359(6380):1170–1177.