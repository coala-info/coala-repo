Code

* Show All Code
* Hide All Code

# The discordant R Package: A Novel Approach to Differential Correlation

Charlotte Siska1\*, Max McGrath1\*\* and Katerina Kechris1\*\*\*

1University of Colorado Anschutz Medical Campus

\*charlotte.siska@ucdenver.edu
\*\*max.mcgrath@ucdenver.edu
\*\*\*katerina.kechris@cuanschutz.edu

#### 29 October 2025

#### Package

discordant 1.34.0

# 1 Introduction

Discordant is an R package that identifies pairs of features that correlate
differently between phenotypic groups, with application to -omics data sets.
Discordant uses a mixture model that “bins” molecular feature pairs based on
their type of coexpression or coabbundance. More information on the algorithm
can be found in
(Siska, Bowler, and Kechris ([2015](#ref-siska1)), Siska. and Kechris ([2016](#ref-siska2))). The final output are posterior probabilities of differential
correlation. This package can be used to determine differential correlation
within one –omics data set or between two –omics data sets (provided that both
–omics data sets were taken from the same samples). Also, the type of data can
be any type of –omics with normal or non-normal distributions. Some examples are
metabolomics, transcriptomic, proteomics, etc.

The functions in the Discordant package provide a simple pipeline for
intermediate R users to determine differentially correlated pairs. The final
output is a table of molecular feature pairs and their respective posterior
probabilities. Functions have been written to allow flexibility for users in how
they interpret results, which will be discussed further. Currently, the package
only supports the comparison between two phenotypic groups (e.g., disease versus
control, mutant versus wildtype).

# 2 Discordant Algorithm

Discordant is originally derived from the Concordant algorithm written by
(Lai et al. ([2007](#ref-lai1)), Lai et al. ([2014](#ref-lai2))). It was used to determine concordance between microarrays. We
have applied it to determine differential correlation of features between groups
(Siska, Bowler, and Kechris ([2015](#ref-siska1)), Siska. and Kechris ([2016](#ref-siska2))).

Using a three component mixture model and the Expectation Maximization (EM)
algorithm, the model predicts
if the correlation coefficients in phenotypic groups 1 and 2 for a molecular
feature pair are dissimilar (Siska, Bowler, and Kechris ([2015](#ref-siska1))). The correlation coefficients are
generated for all possible molecular feature pairs witin an -omics dataset or
between two -omics data sets. The correlation coefficients are transformed into
z scores using Fisher’s transformation. The three components are -, + and 0
which correspond respectively to a negative, positive or no correlation.
Molecular features that have correlation coefficients in *different* components
are considered *differentially* correlated, as opposed to when correlation
coefficients are in the *same* component then they are *equivalently*
correlated.

\[
\begin{array}{c|c c c}
\text{} & \text{0} & \text{-} & \text{+}\\
\hline
0 & 1 & 2 & 3 \\
- & 4 & 5 & 6 \\
+ & 7 & 8 & 9 \\
\end{array}
\]

The class matrix (above) contains the classes that represent all possible
paired-correlation scenarios. These scenarios are based off the components in
the mixture models. Molecular features that have correlation coefficients in
different components are considered differentially correlated, as opposed to
when correlation coefficients are in the same component they are equivalently
correlated. This can be visualized in the class matrix, where the rows represent
the components for group 1 and the columns represent the components for group 2.
The classes on the diagonal represent equivalent correlation (1, 5 and 9), and
classes in the off-diagonal represent differential correlation (2, 3, 4, 6, 8).

After running the EM algorithm, we have 9 posterior probabilities for each
molecular feature pair that correspond to the 9 classes in the class matrix.
Since we want to summarize the probability that the molecular feature pair is
differentially correlated, we sum the posterior probabilities representing the
off-diagonal classes in the class matrix.

# 3 Example Data

The following data sets are provided by *[discordant](https://bioconductor.org/packages/3.22/discordant)* and will be
used in the examples which follow. All data sets are originally from the Cancer
Genome Atlas (TCGA) and can be found at
<http://cancergenome.nih.gov/>.

**TCGA\_GBM\_miRNA\_microarray**
:   miRNA expression values from 10 control and 20 tumor samples for
    a Glioblastoma multiforme (GBM) Agilent miRNA micorarray. The feature size was
    originally 470, but after features with outliers were filtered out feature
    size reduces to 331. In this sample data set provided in the package, we
    randomly selected 10 features.

**TCGA\_GBM\_transcript\_microarray**
:   Transcript (or mRNA) expression values from 10 control and 20
    tumor samples in a GBM Agilent 244k micorarray. The feature size was
    originally 90797, but after features with outliers were filtered out, feature
    size reduces to 72656. In this sample data set provided in the package, we
    randomly selected 20 features.

**TCGA\_Breast\_miRNASeq**
:   miRNA counts from 15 control and 45 tumor samples in a Breast Cancer
    Illumina HiSeq miRNASeq. The feature size was originally 212, but after
    features with outliers were filtered out feature size reduces to 200. In this
    sample data set provided in the package, we randomly selected 100 features.

**TCGA\_Breast\_RNASeq**
:   Transcript (or mRNA) counts from 15 control and 45 tumor samples in a
    Breast Cancer Illumina HiSeq RNASeq. The feature size was originally 19414,
    but after features with outliers were filtered out feature size reduces to
    16656. In this sample data set provided in the package, we randomly selected
    100 features.

**TCGA\_Breast\_miRNASeq\_voom**
:   voom-transformed TCGA\_Breast\_miRNASeq

**TCGA\_Breast\_RNASeq\_voom**
:   voom-transformed TCGA\_Breast\_RNASeq

The data sets are provided as described above with no other modifications.
Throughout this vignette we will use the
data sets `TCGA_GBM_miRNA_microarray` and `TCGA_GBM_transcript_microarray` to
demonstrate *[discordant](https://bioconductor.org/packages/3.22/discordant)*’s essential functionality. They are
loaded as follows:

```
# Load data
data(TCGA_GBM_miRNA_microarray)
data(TCGA_GBM_transcript_microarray)
```

# 4 Before Starting

## 4.1 Types of Analysis

“Within” –omics refers to when Discordant analysis is performed within one
–omics dataset where all molecular features within a -omics dataset are paired
to each other (e.g. transcript-transcript pairs in a transcriptomics
experiment).

“Between” -omics refers to analysis of two -omics data sets. Molecular feature
pairs analyzed are between the two -omics, (e.g. transcript-protein, protein-
metabolite) are paired.

*[discordant](https://bioconductor.org/packages/3.22/discordant)* provides tools for both within and between
-omics analysis that will be described in the sections that follow.

## 4.2 Outliers

In our work, we found that features with outliers would skew correlation and
cause false positives. Our approach was to filter out features that had large
outliers. With normal data, such as in gene expression data from microarrays,
Grubbs’ test can be used.
The null hypothesis is that there are no outliers in the data, and so features
with p-value \(\ge\) 0.05 are kept. A simple R function is found in the
*[outliers](https://CRAN.R-project.org/package%3Doutliers)* R package as `grubbs.test()`.

Determining outliers in non-normal data is more complicated. We used the median
absolute deviation (MAD). Normally, features are filtered if they are outside 2
or 3 MADs from the median (Leys et al. ([2013](#ref-leys))). This is not completely applicable to
sequencing data, because sequencing data has large variance and a non-
symmetrical distribution. Therefore we used the ‘split MAD’ approach (Magwene et al. ([2011](#ref-magwene))).
A left MAD is determined based on data left to the median and a
right MAD is determined based on data to the right of the median. If there are
any feature outside a factor of the left or right MAD from the median, they are
filtered out.

*[discordant](https://bioconductor.org/packages/3.22/discordant)* provides `splitMADOutlier()` to identify features
with outliers using MAD. The
number of MAD outside of the median can be changed with option
`threshold`. Another option is `filter0` which if `TRUE`
will filter out any feature with at least one 0. Arguments returned are
`mat.filtered`, which is the filtered matrix and `index` which
is the index of features that are retained in `mat.filtered`.

```
data(TCGA_Breast_miRNASeq)
mat.filtered <- splitMADOutlier(TCGA_Breast_miRNASeq,
                                filter0 = TRUE,
                                threshold = 4)
```

# 5 Correlation Vectors

To run the Discordant algorithm, correlation vectors respective to each group
are necessary for input, which are easy to create using the function
`createVectors()`. Each correlation coefficient represents the correlation
between two molecular features. The type of molecular feature pairs depends if
a within -omics or between -omics analysis is performed. Correlation between
molecular features in the same -omics dataset is within -omics, and correlation
between molecular features in two different -omics datasets is between -omics.
Whether or not within -omics or between -omics analysis is performed depends on
whether one or two matrices are parameters for this function. The arguments for
`createVectors()` are:

**x**
:   \(m\) by \(n\) matrix where \(m\) are features and \(n\) are samples. If only this
    matrix is provided, a within -omics analysis is performed

**y**
:   \(m\) by \(n\) matrix where \(m\) are features and \(n\) are samples. This is an
    optional argument which will induce between -omics analysis. Samples must be
    matched with those in **x**

    **group**
    :   vector containing 1s and 2s that correspond to the location of samples in
        the columns of **x** (and **y** if provided). For
        example, the control is group 1 and the experimental group 2, and the
        locations of samples corresponding to the two groups matches the locations of
        1s and 2s in the group vector

`createVectors()` is then run as follows:

```
groups <- c(rep(1,10), rep(2,20))

# Within -omics
wthn_vectors <- createVectors(x = TCGA_GBM_transcript_microarray,
                              groups = groups)
# Between -omics
btwn_vectors <- createVectors(x = TCGA_GBM_miRNA_microarray,
                              y = TCGA_GBM_transcript_microarray,
                              groups = groups)
```

`createVectors()` returns a list with two elements, `v1` and `v2`, which are the
correlation vectors of molecular feature pairs corresponding to
samples labeled `1` and `2` using the `groups` argument, respectively. Each
vector is a numeric named vector with names indicating each feature in the pair
separated by an underscore. Below are the first few correlations for each group,
first from the within -omics analysis and second from the between -omics
analysis.

```
# Within -omics
head(wthn_vectors$v1)
```

```
##  A_23_P138644_A_23_P24296 A_23_P138644_A_24_P345312 A_23_P138644_A_24_P571870
##                0.36969697               -0.26060606               -0.13939394
##  A_23_P138644_A_32_P71885  A_23_P138644_A_32_P82889 A_23_P138644_A_23_P105264
##               -0.09090909               -0.04863244               -0.69696970
```

```
head(wthn_vectors$v2)
```

```
##  A_23_P138644_A_23_P24296 A_23_P138644_A_24_P345312 A_23_P138644_A_24_P571870
##               0.216541353              -0.433082707              -0.254135338
##  A_23_P138644_A_32_P71885  A_23_P138644_A_32_P82889 A_23_P138644_A_23_P105264
##              -0.285714286              -0.009022556              -0.154887218
```

```
# Between -omics
head(btwn_vectors$v1)
```

```
## hsa-miR-19b-5p_A_23_P138644  hsa-miR-19b-5p_A_23_P24296
##                  -0.4303030                  -0.6000000
## hsa-miR-19b-5p_A_24_P345312 hsa-miR-19b-5p_A_24_P571870
##                   0.1878788                  -0.3939394
##  hsa-miR-19b-5p_A_32_P71885  hsa-miR-19b-5p_A_32_P82889
##                   0.3818182                  -0.4060606
```

```
head(btwn_vectors$v2)
```

```
## hsa-miR-19b-5p_A_23_P138644  hsa-miR-19b-5p_A_23_P24296
##                  0.44060150                 -0.02857143
## hsa-miR-19b-5p_A_24_P345312 hsa-miR-19b-5p_A_24_P571870
##                 -0.03308271                  0.26015038
##  hsa-miR-19b-5p_A_32_P71885  hsa-miR-19b-5p_A_32_P82889
##                 -0.08571429                 -0.37744361
```

## 5.1 Correlation Metrics

The function `createVectors()` provides several options for correlation metrics
using the argument `cor.method`. The methods provided include `"spearman"` (the
default metric), `"pearson"`, `"bwmc"`, and `"sparcc"`. For information and
comparison of Spearman, Pearson and biweight midcorrelation (bwmc) see
[Song et al](http://bmcbioinformatics.biomedcentral.com/articles/10.1186/1471-2105-13-328)
(Song, Langfelder, and Horvath ([2012](#ref-song))). We have also investigated correlation metrics in Discordant in relation
to sequencing data and found Spearman’s correlation had the best performance
(Siska. and Kechris ([2016](#ref-siska2))).

The algorithm for SparCC was introduced by Friedman et al. (Friedman and Alm ([2012](#ref-friedman))), and we
use code provided by Huaying Fang (Fang et al. ([2015](#ref-fang))).

# 6 Calling Discordant

The Discordant Algorithm is implemented in the the function `discordantRun()`
which requires two correlation vectors and the original data. If the user wishes
to generate their own correlation vector before inputting the data set,
they can do so. However, the function will return an error message if the
dimensions of the data sets inserted do not match the correlation vector.
`discordantRun()` is called as follows:

```
# Within -omics
wthn_result <- discordantRun(v1 = wthn_vectors$v1,
                             v2 = wthn_vectors$v2,
                             x = TCGA_GBM_transcript_microarray)

# Between -omics
btwn_result <- discordantRun(v1 = btwn_vectors$v1,
                             v2 = btwn_vectors$v2,
                             x = TCGA_GBM_miRNA_microarray,
                             y = TCGA_GBM_transcript_microarray)
```

## 6.1 Output

The posterior probability output of the Discordant algorithm are the
differential correlation posterior probabilities (the sum of the off-diagonal of
the class matrix described above). If the user wishes to observe more
detailed information, alternative outputs are available. `discordantRun()` has
six outputs:

**discordPPMatrix**

Matrix of differential correlation posterior probabilities where rows and
columns reflect features. If only x was inputted, then the number of rows and
columns are number of features in x. The rows and column names are the feature
names, and the upper diagonal of the matrix are NAs to avoid repeating
results. If x and y are inputted, the number of rows is the feature size of x
and the number of columns the feature size of y. The row names are features
from x and the column names are features from y.

```
# Within -omics
wthn_result$discordPPMatrix[1:5, 1:4]
```

```
##              A_23_P138644 A_23_P24296 A_24_P345312 A_24_P571870
## A_23_P138644           NA          NA           NA           NA
## A_23_P24296     0.2878537          NA           NA           NA
## A_24_P345312    0.8912767  0.60018437           NA           NA
## A_24_P571870    0.5241415  0.14509976     0.223684           NA
## A_32_P71885     0.6669908  0.09268763     0.808103    0.2945575
```

```
# Between -omics
btwn_result$discordPPMatrix[1:5, 1:4]
```

```
##                 A_23_P138644 A_23_P24296 A_24_P345312 A_24_P571870
## hsa-miR-19b-5p    0.97651996  0.38597448   0.54913355   0.30547498
## hsa-miR-206-5p    0.86697876  0.03064989   0.11030081   0.21411118
## hsa-miR-369-5p    0.04519821  0.08113338   0.90726304   0.04050697
## hsa-miR-374-5p    0.70594948  0.03692205   0.07830365   0.58323497
## hsa-miR-376a-5p   0.21071194  0.04581947   0.90287297   0.05971681
```

**discordPPVector**

Vector of differential correlation posterior probabilities. The length is
the number of feature pairs. The names of the vector are the feature pairs.

```
# Within -omics
head(wthn_result$discordPPVector)
```

```
##  A_23_P138644_A_23_P24296 A_23_P138644_A_24_P345312 A_23_P138644_A_24_P571870
##                0.28785373                0.89127669                0.52414148
##  A_23_P138644_A_32_P71885  A_23_P138644_A_32_P82889 A_23_P138644_A_23_P105264
##                0.66699081                0.03938042                0.89322774
```

```
# Between -omics
head(btwn_result$discordPPVector)
```

```
## hsa-miR-19b-5p_A_23_P138644  hsa-miR-19b-5p_A_23_P24296
##                  0.97651996                  0.86697876
## hsa-miR-19b-5p_A_24_P345312 hsa-miR-19b-5p_A_24_P571870
##                  0.04519821                  0.70594948
##  hsa-miR-19b-5p_A_32_P71885  hsa-miR-19b-5p_A_32_P82889
##                  0.21071194                  0.47601903
```

**classMatrix**

Matrix of classes with the highest posterior probability for each pair.
Row and column names are the same as in `discordPPMatrix` and determined by
whether only x is inputted or both x and y.

```
# Within -omics
wthn_result$classMatrix[1:5,1:4]
```

```
##              A_23_P138644 A_23_P24296 A_24_P345312 A_24_P571870
## A_23_P138644           NA          NA           NA           NA
## A_23_P24296             1          NA           NA           NA
## A_24_P345312            4           3           NA           NA
## A_24_P571870            4           1            1           NA
## A_32_P71885             4           1            3            1
```

```
# Between -omics
btwn_result$classMatrix[1:5,1:4]
```

```
##                 A_23_P138644 A_23_P24296 A_24_P345312 A_24_P571870
## hsa-miR-19b-5p             7           1            2            1
## hsa-miR-206-5p             2           1            9            1
## hsa-miR-369-5p             1           1            2            1
## hsa-miR-374-5p             7           1            1            2
## hsa-miR-376a-5p            1           1            2            1
```

**classVector**

Vector of class with the highest posterior probability for each pair. The
length is the number of feature pairs. Names of vector correspond to the
feature pairs, similar to `discordPPVector`.

```
# Within -omics
head(wthn_result$classVector)
```

```
##  A_23_P138644_A_23_P24296 A_23_P138644_A_24_P345312 A_23_P138644_A_24_P571870
##                         1                         4                         4
##  A_23_P138644_A_32_P71885  A_23_P138644_A_32_P82889 A_23_P138644_A_23_P105264
##                         4                         1                         2
```

```
# Between -omics
head(btwn_result$classVector)
```

```
## hsa-miR-19b-5p_A_23_P138644  hsa-miR-19b-5p_A_23_P24296
##                           7                           2
## hsa-miR-19b-5p_A_24_P345312 hsa-miR-19b-5p_A_24_P571870
##                           1                           7
##  hsa-miR-19b-5p_A_32_P71885  hsa-miR-19b-5p_A_32_P82889
##                           1                           4
```

**probMatrix**

Matrix of all posterior probabilities, where the number of rows is
the number of feature pairs and the columns represent the class within the
class matrix. The number of columns can be 9 or 25, depending on how many
mixture components are chosen (discussed later). The values across each row
add up to 1. Posterior probabilities in `discordPPMatrix` and
`discordPPVector` are the summation of columns that correspond to
differential correlation classes (described above). Each column corresponds
to the respectively numbered element from the class matrix above for three
components or the class matrix described below for five components.

```
# Within -omics
round(head(wthn_result$probMatrix), 2)
```

```
##                           [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9]
## A_23_P138644_A_23_P24296  0.44 0.00 0.24 0.00 0.00    0 0.04 0.00 0.27
## A_23_P138644_A_24_P345312 0.10 0.00 0.00 0.89 0.01    0 0.00 0.00 0.00
## A_23_P138644_A_24_P571870 0.48 0.00 0.01 0.51 0.00    0 0.00 0.00 0.00
## A_23_P138644_A_32_P71885  0.33 0.00 0.01 0.66 0.00    0 0.00 0.00 0.00
## A_23_P138644_A_32_P82889  0.96 0.00 0.03 0.00 0.00    0 0.01 0.00 0.00
## A_23_P138644_A_23_P105264 0.05 0.88 0.00 0.00 0.05    0 0.00 0.01 0.00
```

```
# Between -omics
round(head(btwn_result$probMatrix), 2)
```

```
##                             [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9]
## hsa-miR-19b-5p_A_23_P138644 0.02 0.02 0.00 0.00 0.00    0 0.73 0.22 0.00
## hsa-miR-19b-5p_A_23_P24296  0.13 0.86 0.00 0.00 0.00    0 0.00 0.01 0.00
## hsa-miR-19b-5p_A_24_P345312 0.95 0.00 0.02 0.00 0.00    0 0.02 0.00 0.00
## hsa-miR-19b-5p_A_24_P571870 0.29 0.16 0.00 0.00 0.00    0 0.45 0.09 0.00
## hsa-miR-19b-5p_A_32_P71885  0.78 0.00 0.19 0.01 0.00    0 0.01 0.00 0.01
## hsa-miR-19b-5p_A_32_P82889  0.17 0.11 0.00 0.37 0.35    0 0.00 0.00 0.00
```

**loglik**

The log likelihood from the model fit.

```
# Within -omics
wthn_result$loglik
```

```
## [1] 1199.92
```

```
# Between -omics
btwn_result$loglik
```

```
## [1] 1266.161
```

## 6.2 Subsampling

Subsampling is an option to run the EM algorithm with a random sample of
independent feature pairs. This is repeated for a number of samplings, and then
the average of these parameters are used to maximize posterior probabilities for
all feature pairs. This option was introduced to speed up Discordant method and
to also address the independence assumption.

The argument `subsampling` must be set to `TRUE` for subsampling to be used. By
default, the number of independent feature pairs to be subsampled is half the
total number of features divided by two for within -omics analysis and the
number of features in the data set with fewer features for between -omics
analysis. This number may be altered by users using the `subSize` argument, but
the value set by users cannot exceed the default value, as the default value
is the maximum number of independent sample pairs possible for a given analysis.

The number of random samplings to be run is set by the argument
`iter` which has a default value of 100.

As discussed in the next section, the discordant method requires a sufficient
number of features to estimate components, and using subsampling reduces the
quantity of features used for analysis, so subsampling should be reserved for
larger data sets. For some data sets, certain random samples will be sufficient,
while others may not be. For those data sets, the subsampling algorithm will
allow up to 10% of iterations to fail and be repeated. If more than 10% of
iterations fail, `discordantRun()` will throw an error with potential solutions,
as shown below.

```
# Between -omics
btwn_result <- discordantRun(v1 = btwn_vectors$v1,
                             v2 = btwn_vectors$v2,
                             x = TCGA_GBM_miRNA_microarray,
                             y = TCGA_GBM_transcript_microarray,
                             components = 3,
                             subsampling = TRUE)
```

```
## Error in discordantRun(v1 = btwn_vectors$v1, v2 = btwn_vectors$v2, x = TCGA_GBM_miRNA_microarray, :
## Insufficient data for subsampling. Increase number of
## features, reduce numberof components used, or increase
## subSize if not at default value. Alternatively, set
## subsampling=FALSE.
```

Given the limited number of features in the `TCGA_GBM` data sets, they are not
a suitable candidate for subsampling, so we will instead use the
`TCGA_Breast_miRNASeq` and `TCGA_Breast_RNASeq` data sets to demonstrate
a multi -omics analysis with subsampling. Note that a seed is set prior to
calling `discordantRun()` with `subsampling = TRUE`, as there is a randomness
involved in drawing subsamples, and results may differ using different seeds.

```
# Load Data
data(TCGA_Breast_miRNASeq_voom)
data(TCGA_Breast_RNASeq_voom)

# Prepare groups
groups <- c(rep(1, 15), rep(2, 42))

# Create correlation vectors
sub_vectors <- createVectors(x = TCGA_Breast_miRNASeq_voom,
                             y = TCGA_Breast_RNASeq_voom,
                             groups = groups)

# Run analysis with subsampling
set.seed(126)
sub_result <- discordantRun(sub_vectors$v1, sub_vectors$v2,
                            x = TCGA_Breast_miRNASeq_voom,
                            y = TCGA_Breast_RNASeq_voom,
                            components = 3, subsampling = TRUE)

# Results
round(head(sub_result$probMatrix), 2)
```

```
##                               [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9]
## hsa-mir-1247_MAPK8IP1|9479    0.12 0.00 0.02 0.00 0.00    0 0.53    0 0.34
## hsa-mir-1247_PPWD1|23398      0.98 0.01 0.00 0.00 0.00    0 0.00    0 0.00
## hsa-mir-1247_CEACAM22P|388550 0.94 0.03 0.00 0.00 0.02    0 0.00    0 0.00
## hsa-mir-1247_HTR2A|3356       0.94 0.00 0.01 0.00 0.00    0 0.02    0 0.03
## hsa-mir-1247_SAMD12|401474    0.00 0.00 0.00 0.53 0.47    0 0.00    0 0.00
## hsa-mir-1247_INTS7|25896      0.35 0.00 0.00 0.58 0.07    0 0.00    0 0.00
```

## 6.3 Five Components

We also provide the option to increase component size from three to five in the
mixture model. The number of classes in the class matrix increases, as seen in
the table below. Incorporating the extra components means that it is possible to
identify elevated differential correlation, which is when there are associations
in both groups in the same direction but one is more extreme. Using this option
introduces more parameters, which does have an effect on run-time. We also found
that using the five mixture component mixture model reduces performance compared
to the three component mixture model(Siska. and Kechris ([2016](#ref-siska2))). However, the option is
available if users wish to explore more types of differential correlation.

\[
\begin{array}{c|c c c c c}
\text{} & \text{0} & \text{-} & \text{--} & \text{+} & \text{++} \\
\hline
0 & 1 & 2 & 3 & 4 & 5 \\
- & 6 & 7 & 8 & 9 & 10 \\
-- & 11 & 12 & 13 & 14 & 15 \\
+ & 16 & 17 & 18 & 19 & 20 \\
++ & 21 & 22 & 23 & 24 & 25
\end{array}
\]

By default, `discordantRun()` uses a three component mixture model, but this may
be changed to a five component mixture model by setting the argument
`components = 5`. A greater amount of data (specifically a greater number of
features) is necessary to accurately estimate 5 components compared to 3.
If an insufficient amount of data is used, `discordantRun()` will throw an error
suggesting the user increase the number of features or reduce the chosen
number of components. The data used for the within -omics analysis above does
not have enough features to estimate 5 components, so an error is thrown below.

```
# Within -omics
wthn_result <- discordantRun(v1 = wthn_vectors$v1,
                             v2 = wthn_vectors$v2,
                             x = TCGA_GBM_transcript_microarray,
                             components = 5)
```

```
## Error in discordantRun(v1 = wthn_vectors$v1, v2 = wthn_vectors$v2, x = TCGA_GBM_transcript_microarray, :
## Insufficient data for component estimation. Increase
## number of features or reduce number of components used.
```

However, the between -omics analysis above is a suitable candidate for further
analysis using five components, so an example of such an analysis is provided
below.

```
# Between -omics
btwn_result <- discordantRun(v1 = btwn_vectors$v1,
                             v2 = btwn_vectors$v2,
                             x = TCGA_GBM_miRNA_microarray,
                             y = TCGA_GBM_transcript_microarray,
                             components = 5)

# Between -omics
round(head(btwn_result$probMatrix), 2)
```

```
##                             [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10]
## hsa-miR-19b-5p_A_23_P138644 0.02 0.01 0.00 0.00    0  0.0 0.00    0    0     0
## hsa-miR-19b-5p_A_23_P24296  0.14 0.86 0.00 0.01    0  0.0 0.00    0    0     0
## hsa-miR-19b-5p_A_24_P345312 0.98 0.00 0.01 0.00    0  0.0 0.00    0    0     0
## hsa-miR-19b-5p_A_24_P571870 0.27 0.10 0.00 0.00    0  0.0 0.00    0    0     0
## hsa-miR-19b-5p_A_32_P71885  0.79 0.00 0.21 0.00    0  0.0 0.00    0    0     0
## hsa-miR-19b-5p_A_32_P82889  0.18 0.08 0.00 0.00    0  0.3 0.44    0    0     0
##                             [,11] [,12] [,13] [,14] [,15] [,16] [,17] [,18]
## hsa-miR-19b-5p_A_23_P138644  0.48  0.18     0     0     0     0     0     0
## hsa-miR-19b-5p_A_23_P24296   0.00  0.00     0     0     0     0     0     0
## hsa-miR-19b-5p_A_24_P345312  0.00  0.00     0     0     0     0     0     0
## hsa-miR-19b-5p_A_24_P571870  0.50  0.11     0     0     0     0     0     0
## hsa-miR-19b-5p_A_32_P71885   0.00  0.00     0     0     0     0     0     0
## hsa-miR-19b-5p_A_32_P82889   0.00  0.00     0     0     0     0     0     0
##                             [,19] [,20] [,21] [,22] [,23] [,24] [,25]
## hsa-miR-19b-5p_A_23_P138644     0     0  0.24  0.06     0     0     0
## hsa-miR-19b-5p_A_23_P24296      0     0  0.00  0.00     0     0     0
## hsa-miR-19b-5p_A_24_P345312     0     0  0.00  0.00     0     0     0
## hsa-miR-19b-5p_A_24_P571870     0     0  0.01  0.00     0     0     0
## hsa-miR-19b-5p_A_32_P71885      0     0  0.00  0.00     0     0     0
## hsa-miR-19b-5p_A_32_P82889      0     0  0.00  0.00     0     0     0
```

# 7 Session Info

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
## [1] discordant_1.34.0 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] vctrs_0.6.5         cli_3.6.5           knitr_1.50
##  [4] rlang_1.1.6         xfun_0.53           DEoptimR_1.1-4
##  [7] generics_0.1.4      biwt_1.0.1          gtools_3.9.5
## [10] jsonlite_2.0.0      glue_1.8.0          htmltools_0.5.8.1
## [13] sass_0.4.10         rmarkdown_2.30      Biobase_2.70.0
## [16] tibble_3.3.0        evaluate_1.0.5      jquerylib_0.1.4
## [19] MASS_7.3-65         fastmap_1.2.0       yaml_2.3.10
## [22] lifecycle_1.0.4     bookdown_0.45       BiocManager_1.30.26
## [25] compiler_4.5.1      dplyr_1.1.4         robustbase_0.99-6
## [28] pkgconfig_2.0.3     Rcpp_1.1.0          digest_0.6.37
## [31] R6_2.6.1            tidyselect_1.2.1    pillar_1.11.1
## [34] magrittr_2.0.4      bslib_0.9.0         tools_4.5.1
## [37] BiocGenerics_0.56.0 cachem_1.1.0
```

# References

Fang, Huaying, Chengcheng Huang, Hongyu Zhao, and Minghua Deng. 2015. “CCLasso: Correlation Inference for Compositional Data Through Lasso.” *Bioinformatics* 31 (19): 3172–80.

Friedman, Jonathan, and Eric J. Alm. 2012. “Inferring Correlation Networks from Genomic Survey Data.” *PLoS Computational Biology*.

Lai, Yinglei, Bao-ling Adam, Robert Podolsky, and Jin-Xiong She. 2007. “A Mixture Model Approach to the Tests of Concordance and Discordance Between Two Large-Scale Experiments with Two-Sample Groups.” *Bioinformatics* 23 (10): 1243–50.

Lai, Yinglei, Fanni Zhang, Tapan K. Naya, Reza Modarres, Norman H. Lee, and Timonthy A. McCaffrey. 2014. “Concordant Integrative Gene Set Enrichment Analysis of Multiple Large-Scale Two-Sample Expression Data Sets.” *BMC Genomics* 15.

Leys, Christophe, Olivier Klein, Philippe Bernard, and Laurent Licata. 2013. “Detecting Outliers: Do Not Use Standard Deviation Around the Mean, Use Absolute Deviation Around the Median.” *Journal of Experimental Social Psychology* 49 (4).

Magwene, Paul M., John H. Willis, John K. Kelley, and Adam Siepel. 2011. “The Statistics of Bulk Segregant Analysis Using Next Generation Sequencing.” *PLoS Computational Biology* 7 (11).

Siska, Charlotte, Russ Bowler, and Katerina Kechris. 2015. “The Discordant Method: A Novel Approach for Differential Correlation.” *Bioinformatics* 32 (5): 690–96.

Siska., Charlotte, and Katerina Kechris. 2016. “Differential Correlation for Sequencing Data.”

Song, Lin, Peter Langfelder, and Steve Horvath. 2012. “Comparison of Co-Expression Measures: Mutual Information, Correlation, and Model Based Indices.” *BMC Bioinformatics* 13 (328).