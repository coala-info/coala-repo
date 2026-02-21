CCREPE: Compositionality Corrected by PEr-
mutation and REnormalization

Emma Schwager, George Weingart, Craig Bielski, Curtis
Huttenhower

October 29, 2025

Contents

1

2

Introduction .

ccrepe .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

General functionality .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

1

2

2

2

4

4

4

6

8

10

11

12

12

12

13

13

13

14

15

16

Arguments .

Output .

Usage .

.

.

.

.

Example 1 .

Example 2 .

Example 3 .

Example 4 .

Example 5 .

Arguments .

Output .

Usage .

.

.

.

.

Example 1 .

Example 2 .

Example 3 .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

2.1

2.2

2.3

2.4

2.5

2.6

2.7

2.8

2.9

3.1

3.2

3.3

3.4

3.5

3.6

3.7

3

nc.score .

.

.

.

.

General Functionality .

ccrepe is a package for analysis of sparse compositional data. Specifically, it determines the
significance of association between features in a composition, using any similarity measure
(e.g. Pearson correlation, Spearman correlation, etc.) The CCREPE methodology stands

4

References .

.

.

1

Introduction

CCREPE: Compositionality Corrected by PErmutation and REnormalization

for Compositionality Corrected by Renormalization and Permutation, as detailed below. The
package also provides a novel similarity measure, the N-dimensional checkerboard score (NC-
score), particularly appropriate to compositions derived from microbial community sequencing
data. This results in p-values and false discovery rate q-values corrected for the effects of
compositionality. The package contains two functions ccrepe and nc.score and is maintained
by the Huttenhower lab (ccrepe-users@googlegroups.com).

2

ccrepe

ccrepe is the main package function.
It calculates compositionality-corrected p-values and
q-values for a user-selected similarity measure, operating on either one or two input matrices.
If given one matrix, all features (columns) in the matrix are compared to each other using
the selected similarity measure. If given two matrices, each feature in the first are compared
against all features in the second.

2.1

General functionality

Compositional data induces spurious correlations between features due to the nonindepen-
dence of values that must sum to a fixed total. CCREPE abrogates this when determining
the significance of a similarity measure for each feature pair using two main steps, permu-
tation/renormalization and bootstrapping. First, given two features to compare, CCREPE
generates a null distribution of the similarity expected just due to compositionality by iter-
atively permuting one feature, renormalizing all samples in the composition to their previ-
ous sum, and computing the resulting similarity measures. Second, CCREPE bootstraps
over sample subsets in order to assess confidence in the "true" similarity measure. Fi-
nally, the two resulting distributions are compared using a pooled-variance Z-test to give
a compositionality-corrected p-value. False discovery rate q-values are additionally calculated
using the Benjamin-Hochberg-Yekutieli procedure. For greater detail, see Faust et al. [2012]
and Schwager and Colleagues.

CCREPE employs several filtering steps before the data are processed. It removes any missing
subjects using na.omit: in the two dataset case, any subjects missing in either dataset will
be removed. Any subjects or features which are all zero are removed as well: an all-zero
subject cannot be normalized (its sum is 0) and an all-zero feature has standard deviation 0
(in addition to being uninteresting biologically).

2.2

Arguments

x First dataframe or matrix containing relative abundances. Columns are features, rows
are samples. Rows should therefore sum to a constant. Row names are used for
identification if present.

y Second dataframe or matrix (optional) containing relative abundances. Columns are fea-
tures, rows are samples. Rows should therefore sum to a constant. If both x and y are
specified, they will be merged by row names. If no row names are specified for either
or both datasets, the default is to merge by row number.

2

CCREPE: Compositionality Corrected by PErmutation and REnormalization

sim.score Similarity measure, such as cor or nc.score. This can be either an existing R
function or user-defined. If the latter, certain properties should be satisfied as detailed
below (also see examples). The default similarity measure is Spearman correlation.

A user-defined similarity measure should mimic the interface of cor:

1. Take either two vector inputs one matrix or dataframe input.

2. In the case of two inputs, return a single number.

3. In the case of one input, return a matrix in which the (i,j)th entry is the similarity

score for column i and column j in the original matrix.

4. The resulting matrix (in the case of one input) must be symmetric.

5. The inputs must be named x and y.

sim.score.args An optional list of arguments for the measurement function. When given,
they are passed to the sim.score function directly. For example, in the case of cor,
the following would be acceptable:

sim.score.args = list(method="spearman", use="complete.obs")

min.subj Minimum number (count) of samples that must be non-missing in order to apply
the similarity measure. This is to ensure that there are sufficient samples to perform a
bootstrap (default: 20).

iterations The number of iterations for both bootstrap and permutation calculations (de-

fault: 1000).

subset.cols.x A vector of column indices from x to indicate which features to compare

subset.cols.y A vector of column indices from y to indicate which features to compare

errthresh If feature has number of zeros greater than errthresh1/n , that feature is ex-

cluded

verbose If TRUE, print periodic progress of the algorithm through the dataset(s), as well as

including more detailed debugging output. (default: FALSE).

iterations.gap If verbose=TRUE, the number of iterations between issuing status messages

(default: 100).

distributions Optional output file for detailed log (if given) of all intermediate permutation

and renormalization distributions.

compare.within.x A boolean value indicating whether to do comparisons given by taking all
subsets of size 2 from subset.cols.x or to do comparisons given by taking all possible
If TRUE but subset.cols.y=NA,
combinations of subset.cols.x and subset.cols.y.
returns all comparisons involving any features in subset.cols.x. This argument is only
used when y=NA.

3

CCREPE: Compositionality Corrected by PErmutation and REnormalization

concurrent.output Optional output file to which each comparison will be written as it is

calculated.

make.output.table A boolean value indicating whether to include table-formatted output.

2.3

Output

ccrepe returns a list containing both the calculation results and the parameters used:

sim.score matrix of simliarity scores for all requested comparisons. The (i,j)th element
corresponds to the similarity score of column i (or the ith column of subset.cols.1)
and column j (or the jth column of subset.cols.1) in one dataset, or to the similarity
score of column i (or the ith column of subset.cols.1) in dataset x and column j (or
the jth column of subset.cols.2) in dataset y in the case of two datasets.

p.values matrix of the corrected p-values for all requested comparisons. The (i,j)th element

corresponds to the p-value of the (i,j)th element of sim.score.

q.values matrix of the Benjamini-Hochberg-Yekutieli corrected p-values. The (i,j)th ele-

ment corresponds to the p-value of the (i,j)th element of sim.score.

z.stat matrix of the z-statistics used in generating the p-values for all requested compar-
isons. The (i,j)th element corresponds to the z-statistic generating the (i,j)th element
of p.values.

2.4

Usage

ccrepe(

x = NA,

y = NA,

sim.score = cor,

sim.score.args = list(),

min.subj = 20,

iterations = 1000,

subset.cols.x = NULL,

subset.cols.y = NULL,

errthresh = 1e-04,

verbose = FALSE,

iterations.gap = 100,

distributions = NA,

compare.within.x = TRUE,

concurrent.output = NA,

make.output.table = FALSE)

2.5

Example 1

An example of how to use ccrepe with one dataset.

4

CCREPE: Compositionality Corrected by PErmutation and REnormalization

data <- matrix(rlnorm(40,meanlog=0,sdlog=1),nrow=10,ncol=4)
data[,1] = 2*data[,2] + rnorm(10,0,0.01)
data.rowsum <- apply(data,1,sum)

data.norm <- data/data.rowsum

apply(data.norm,1,sum) # The rows sum to 1, so the data are normalized

##

[1] 1 1 1 1 1 1 1 1 1 1

test.input <- data.norm

dimnames(test.input) <- list(c(

"Sample 1", "Sample 2","Sample 3","Sample 4","Sample 5",

"Sample 6","Sample 7","Sample 8","Sample 9","Sample 10"),

c("Feature 1", "Feature 2", "Feature 3","Feature 4"))

test.output <- ccrepe(x=test.input, iterations=20, min.subj=10)

par(mfrow=c(1,2))

plot(data[,1],data[,2],xlab="Feature 1",ylab="Feature 2",main="Non-normalized")

plot(data.norm[,1],data.norm[,2],xlab="Feature 1",ylab="Feature 2",

main="Normalized")

Figure 1: Non-normalized and normalized associations between feature 1 and feature 2. In this case
we would expect feature 1 and feature 2 to be associated. In the output we see this by the positive
sim.score value in the [1,2] element of test.output$sim.score and the small q-value in the [1,2] element
of test.output$q.values.

test.output

## $p.values

##

Feature 1

Feature 2

Feature 3 Feature 4

## Feature 1

NA 7.042302e-05 0.14162909 0.8936283

## Feature 2 7.042302e-05

NA 0.03236966 0.6640659

## Feature 3 1.416291e-01 3.236966e-02

NA 0.6922872

## Feature 4 8.936283e-01 6.640659e-01 0.69228722

NA

##

## $z.stat

##

Feature 1 Feature 2 Feature 3

Feature 4

5

05101502468Non−normalizedFeature 1Feature 20.10.20.30.40.50.60.050.150.25NormalizedFeature 1Feature 2CCREPE: Compositionality Corrected by PErmutation and REnormalization

## Feature 1

NA 3.9748521 -1.469751

0.1337146

## Feature 2 3.9748521

NA -2.139816 -0.4343065

## Feature 3 -1.4697514 -2.1398158

NA

0.3957530

## Feature 4 0.1337146 -0.4343065

0.395753

NA

##

## $sim.score

##

Feature 1 Feature 2

Feature 3

Feature 4

## Feature 1

NA 0.9999655 -0.8448833 -0.3262308

## Feature 2 0.9999655

NA -0.8442575 -0.3273149

## Feature 3 -0.8448833 -0.8442575

NA -0.2300496

## Feature 4 -0.3262308 -0.3273149 -0.2300496

NA

##

## $q.values

##

Feature 1

Feature 2 Feature 3 Feature 4

## Feature 1

NA 0.001000982 0.6710316

2.116983

## Feature 2 0.001000982

NA 0.2300487

2.359733

## Feature 3 0.671031584 0.230048731

NA

1.968013

## Feature 4 2.116983116 2.359733335 1.9680135

NA

2.6

Example 2

An example of how to use ccrepe with two datasets.

data <- matrix(rlnorm(40,meanlog=0,sdlog=1),nrow=10,ncol=4)
data[,1] = 2*data[,2] + rnorm(10,0,0.01)
data.rowsum <- apply(data,1,sum)

data.norm <- data/data.rowsum

apply(data.norm,1,sum) # The rows sum to 1, so the data are normalized

##

[1] 1 1 1 1 1 1 1 1 1 1

test.input <- data.norm

data2 <- matrix(rlnorm(105,meanlog=0,sdlog=1),nrow=15,ncol=7)

aligned.rows <- c(seq(1,4),seq(6,9),11,12)

# The datasets dont need

# to have subjects line up exactly

data2[aligned.rows,1] <- 2*data[,3] + rnorm(10,0,0.01)
data2.rowsum <- apply(data2,1,sum)

data2.norm <- data2/data2.rowsum

apply(data2.norm,1,sum)

# The rows sum to 1, so the data are normalized

##

[1] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1

test.input.2 <- data2.norm

dimnames(test.input) <- list(paste("Sample",seq(1,10)),paste("Feature",seq(1,4)))

dimnames(test.input.2) <- list(paste("Sample",c(seq(1,4),11,seq(5,8),12,9,10,13,14,15)),paste("Feature",seq(1,7)))

test.output.two.datasets <- ccrepe(x=test.input, y=test.input.2, iterations=20, min.subj=10)

## Warning in preprocess_data(CA): Removing subjects Sample 11, Sample 12, Sample
13, Sample 14, Sample 15 from dataset y because they are not in dataset x.

6

CCREPE: Compositionality Corrected by PErmutation and REnormalization

Please note that we receive a warning because the subjects don’t match - only paired obser-
vations.

par(mfrow=c(1,2))

plot(data2[aligned.rows,1],data[,3],xlab="dataset 2: Feature 1",ylab="dataset 1: Feature 3",main="Non-normalized")

plot(data2.norm[aligned.rows,1],data.norm[,3],xlab="dataset 2: Feature 1",ylab="dataset 1: Feature 3",

main="Normalized")

Figure 2: Non-normalized and normalized associations between feature 1 and feature 2. In this case
we would expect feature 1 and feature 2 to be associated. In the output we see this by the positive
sim.score value in the [1,2] element of test.output$sim.score and the small q-value in the [1,2] element
of test.output$q.values.

test.output.two.datasets

## $p.values

##

Feature 1 Feature 2 Feature 3 Feature 4 Feature 5

Feature 6

## Feature 1 0.13836568 0.6398654 0.9784659 0.7403977 0.7792876 0.03898452

## Feature 2 0.24076801 0.5385696 0.9370064 0.5067657 0.8652016 0.11640182

## Feature 3 0.00623355 0.1039599 0.3024779 0.9813163 0.5487937 0.75967432

## Feature 4 0.45983222 0.1938616 0.2193266 0.8206599 0.1785757 0.17346372

##

Feature 7

## Feature 1 0.6539183

## Feature 2 0.6134656

## Feature 3 0.8299510

## Feature 4 0.6347784

##

## $z.stat

##

Feature 1 Feature 2

Feature 3

Feature 4

Feature 5

Feature 6

## Feature 1 -1.4819046 0.4678870

0.02699225 -0.33132679

0.2802475

2.0643502

## Feature 2 -1.1730693 0.6149774 -0.07903293 -0.66388219

0.1697566

1.5700571

## Feature 3 2.7352364 -1.6259518 -1.03113426

0.02341866

0.5995688 -0.3059085

## Feature 4 -0.7391232 1.2992399

1.22832081

0.22669635 -1.3451533 -1.3611581

##

Feature 7

## Feature 1 0.4483255

## Feature 2 0.5051327

## Feature 3 0.2147644

## Feature 4 -0.4750120

##

7

1234560.51.52.5Non−normalizeddataset 2: Feature 1dataset 1: Feature 30.10.20.30.40.50.10.30.5Normalizeddataset 2: Feature 1dataset 1: Feature 3CCREPE: Compositionality Corrected by PErmutation and REnormalization

## $sim.score

##

Feature 1 Feature 2

Feature 3

Feature 4

Feature 5

Feature 6

## Feature 1 -0.3758100 0.1311804 -0.10096297 -0.2087226

0.1380325

0.5481042

## Feature 2 -0.3831858 0.1286119 -0.08221618 -0.2061809

0.1266707

0.5402754

## Feature 3 0.7231993 -0.4435892 -0.19434243 -0.1186080

0.1679025 -0.2672597

## Feature 4 -0.1690371 0.2224546

0.27473129

0.3429404 -0.2985752 -0.4113240

##

Feature 7

## Feature 1 0.14498491

## Feature 2 0.15420579

## Feature 3 0.04978776

## Feature 4 -0.21497114

##

## $q.values

##

Feature 1 Feature 2 Feature 3 Feature 4 Feature 5 Feature 6

## Feature 1 3.0292056 3.891226 3.966910

4.052336

3.877444

2.133696

## Feature 2 2.6355373 4.210990 3.944933

4.267114

3.788329

3.185445

## Feature 3 0.6823478 3.793281 3.010033

3.836378

4.004868

3.959848

## Feature 4 4.1945805 2.652603 2.667590

3.905762

2.792510

3.164665

##

Feature 7

## Feature 1 3.767387

## Feature 2 4.197016

## Feature 3 3.785399

## Feature 4 4.087367

2.7

Example 3

An example of how to use ccrepe with nc.score as the similarity score.

data <- matrix(rlnorm(40,meanlog=0,sdlog=1),nrow=10,ncol=4)
data[,1] = 2*data[,2] + rnorm(10,0,0.01)
data.rowsum <- apply(data,1,sum)

data.norm <- data/data.rowsum

apply(data.norm,1,sum) # The rows sum to 1, so the data are normalized

##

[1] 1 1 1 1 1 1 1 1 1 1

test.input <- data.norm

dimnames(test.input) <- list(paste("Sample",seq(1,10)),paste("Feature",seq(1,4)))

test.output.nc.score

<- ccrepe(x=test.input, sim.score=nc.score, iterations=20, min.subj=10)

par(mfrow=c(1,2))

plot(data[,1],data[,2],xlab="Feature 1",ylab="Feature 2",main="Non-normalized")

plot(data.norm[,1],data.norm[,2],xlab="Feature 1",ylab="Feature 2",

main="Normalized")

8

CCREPE: Compositionality Corrected by PErmutation and REnormalization

Figure 3: Non-normalized and normalized associations between feature 1 and feature 2. In this case
we would expect feature 1 and feature 2 to be associated. In the output we see this by the positive
sim.score value in the [1,2] element of test.output$sim.score and the small q-value in the [1,2] element
of test.output$q.values. In this case, however, the sim.score represents the NC-Score between two features
rather than the Spearman correlation.

test.output.nc.score

## $p.values

##

Feature 1

Feature 2

Feature 3

Feature 4

## Feature 1

NA 2.842611e-07 0.15968519 0.144086045

## Feature 2 2.842611e-07

NA 0.21146567 0.005515821

## Feature 3 1.596852e-01 2.114657e-01

NA 0.022456616

## Feature 4 1.440860e-01 5.515821e-03 0.02245662

NA

##

## $z.stat

##

Feature 1 Feature 2 Feature 3 Feature 4

## Feature 1

NA 5.133594 -1.406131 -1.460743

## Feature 2 5.133594

NA -1.249545 -2.775256

## Feature 3 -1.406131 -1.249545

NA

2.282555

## Feature 4 -1.460743 -2.775256 2.282555

NA

##

## $sim.score

##

Feature 1 Feature 2 Feature 3 Feature 4

## Feature 1

NA

1.00000 -0.59375

-1.00000

## Feature 2

1.00000

NA -0.59375

-1.00000

## Feature 3 -0.59375 -0.59375

NA

0.59375

## Feature 4 -1.00000 -1.00000

0.59375

NA

##

## $q.values

##

Feature 1

Feature 2 Feature 3

Feature 4

## Feature 1

NA 4.040444e-06 0.4539483 0.51200439

## Feature 2 4.040444e-06

NA 0.5009569 0.03920053

## Feature 3 4.539483e-01 5.009569e-01

NA 0.10639833

## Feature 4 5.120044e-01 3.920053e-02 0.1063983

NA

9

0246801234Non−normalizedFeature 1Feature 20.10.30.50.050.150.25NormalizedFeature 1Feature 2CCREPE: Compositionality Corrected by PErmutation and REnormalization

2.8

Example 4

An example of how to use ccrepe with a user-defined sim.score function.

data <- matrix(rlnorm(40,meanlog=0,sdlog=1),nrow=10,ncol=4)
data[,1] = 2*data[,2] + rnorm(10,0,0.01)
data.rowsum <- apply(data,1,sum)

data.norm <- data/data.rowsum

apply(data.norm,1,sum) # The rows sum to 1, so the data are normalized

##

[1] 1 1 1 1 1 1 1 1 1 1

test.input <- data.norm

dimnames(test.input) <- list(paste("Sample",seq(1,10)),paste("Feature",seq(1,4)))

my.test.sim.score <- function(x,y=NA,constant=0.5){

if(is.vector(x) && is.vector(y)) return(constant)

if(is.matrix(x) && is.na(y)) return(matrix(rep(constant,ncol(x)^2),ncol=ncol(x)))

if(is.data.frame(x) && is.na(y)) return(matrix(rep(constant,ncol(x)^2),ncol=ncol(x)))

else stop('ERROR')

}

test.output.sim.score

<- ccrepe(x=test.input, sim.score=my.test.sim.score, iterations=20, min.subj=10, sim.score.args = list(constant = 0.6))

par(mfrow=c(1,2))

plot(data[,1],data[,2],xlab="Feature 1",ylab="Feature 2",main="Non-normalized")

plot(data.norm[,1],data.norm[,2],xlab="Feature 1",ylab="Feature 2",

main="Normalized")

Figure 4: Non-normalized and normalized associations between feature 1 and feature 2. In this case we
would expect feature 1 and feature 2 to be associated. Note that the values of sim.score are all 0.6 and
none of the p-values are very small because of the arbitrary definition of the similarity score.

test.output.sim.score

## $p.values

##

Feature 1 Feature 2 Feature 3 Feature 4

## Feature 1

## Feature 2

NA

NaN

NaN

NA

NaN

NaN

NaN

NaN

10

510152468Non−normalizedFeature 1Feature 20.30.40.50.60.150.25NormalizedFeature 1Feature 2CCREPE: Compositionality Corrected by PErmutation and REnormalization

## Feature 3

## Feature 4

##

## $z.stat

NaN

NaN

NaN

NaN

NA

NaN

NaN

NA

##

Feature 1 Feature 2 Feature 3 Feature 4

## Feature 1

## Feature 2

## Feature 3

## Feature 4

##

## $sim.score

NA

NaN

NaN

NaN

NaN

NA

NaN

NaN

NaN

NaN

NA

NaN

NaN

NaN

NaN

NA

##

Feature 1 Feature 2 Feature 3 Feature 4

## Feature 1

## Feature 2

## Feature 3

## Feature 4

##

## $q.values

NA

0.6

0.6

0.6

0.6

NA

0.6

0.6

0.6

0.6

NA

0.6

0.6

0.6

0.6

NA

##

Feature 1 Feature 2 Feature 3 Feature 4

## Feature 1

## Feature 2

## Feature 3

## Feature 4

NA

NaN

NaN

NaN

NaN

NA

NaN

NaN

NaN

NaN

NA

NaN

NaN

NaN

NaN

NA

2.9

Example 5

An example of how to use ccrepe when specifying column subsets.

data <- matrix(rlnorm(40,meanlog=0,sdlog=1),nrow=10,ncol=4)

data.rowsum <- apply(data,1,sum)

data.norm <- data/data.rowsum

apply(data.norm,1,sum) # The rows sum to 1, so the data are normalized

##

[1] 1 1 1 1 1 1 1 1 1 1

test.input <- data.norm

dimnames(test.input) <- list(paste("Sample",seq(1,10)),paste("Feature",seq(1,4)))

test.output.1.3

<- ccrepe(x=test.input, iterations=20, min.subj=10, subset.cols.x=c(1,3))

test.output.1

<- ccrepe(x=test.input, iterations=20, min.subj=10, subset.cols.x=c(1), compare.within.x=FALSE)

test.output.12.3

<- ccrepe(x=test.input, iterations=20, min.subj=10, subset.cols.x=c(1,2),subset.cols.y=c(3), compare.within.x=FALSE)

test.output.1.3$sim.score

##

Feature 1 Feature 3

## Feature 1

NA -0.3430869

## Feature 3 -0.3430869

NA

test.output.1$sim.score

##

Feature 1 Feature 2 Feature 3

Feature 4

## Feature 1

NA -0.4399858 -0.3430869 -0.4422759

## Feature 2 -0.4399858

NA

NA

NA

11

CCREPE: Compositionality Corrected by PErmutation and REnormalization

## Feature 3 -0.3430869

## Feature 4 -0.4422759

NA

NA

NA

NA

NA

NA

test.output.12.3$sim.score

##

Feature 1 Feature 2

Feature 3 Feature 4

## Feature 1

## Feature 2

NA

NA

NA -0.3430869

NA -0.5544563

## Feature 3 -0.3430869 -0.5544563

## Feature 4

NA

NA

NA

NA

NA

NA

NA

NA

3

nc.score

The nc.score similarity measure is an N-dimensional extension of the checkerboard score
particularly suited to similarity score calculations between compositions derived from eco-
logical relative abundance measurements. In such cases, features typically represent species
abundances, and the NC-score discretizes these continuous values into one of N bins before
computing a normalized similarity of co-occurrence or co-exclusion. This can be used as a
standalone function or with ccrepe as above to obtain compositionality-corrected p-values.

3.1

General Functionality

The NC-score is an extension to Diamond’s checkerboard score (see Cody and Diamond
[1975]) to ordinal data, and simplifies to a calculation of Kendall’s τ on binned data instead
of ranked data. Let two features in a dataset with n subjects be denoted by
(cid:20) x1 x2
y2
y1

. . .
. . .

xn
yn

(cid:21)

.

The binning function maps from the original data to b numbered bins in {1, ..., b}. Let the
binning function be denoted by B(·). The co-variation and co-exclusion patterns are the
same as concordant and discordant pairs in Kendall’s τ . Considering a 2 × 2 submatrix of
the form

(cid:20) B(xi) B(xj)
B(yi) B(yj)

(cid:21)

,

a co-variation pattern is counted when (B(xi) − B(xj))(B(yi) − B(yj)) > 0 and a co-
exclusion pattern, conversely, when (B(xi) − B(xj))(B(yi) − B(yj)) < 0. The NC-score
statistic for features x and y is then defined as

(number of co-variation patterns) − (number of co-exclusion patterns),

normalized by the Kendall’s τ normalization factor accounting for ties described in Kendall
[1970].

3.2

Arguments

x First numerical vector, or single dataframe or matrix, containing relative abundances.

If
the latter, columns are features, rows are samples. Rows should therefore sum to a
constant.

12

CCREPE: Compositionality Corrected by PErmutation and REnormalization

y If provided, second numerical vector containing relative abundances. If given, x must be a

vector as well.

nbins A non-negative integer of the number of bins to generate (cutoffs will be generated

by the discretize function from the infotheo package).

bin.cutoffs A list of values demarcating the bin cutoffs. The binning is performed using

the findInterval function.

use An optional character string givinga method for computing covariances in the presence
of missing values. This must be (an abbreviaion of) on of the strings "everything",
"all.obs", "complete.obs","na.or.complete", or "pairwise.complete.obs".

3.3

Output

nc.score returns either a single number (if called with two vectors) or a matrix of all pairwise
scores (if called with a matrix ) of normalized scores. This behaviour is precisely analogous
to the cor function in R

3.4

Usage

nc.score(

x,

y = NULL,

use = "everything",

nbins = NULL,

bin.cutoffs=NULL)

3.5

Example 1

An example of using nc.score to get a single similarity score or a matrix.

data <- matrix(rlnorm(40,meanlog=0,sdlog=1),nrow=10,ncol=4)

data.rowsum <- apply(data,1,sum)
data[,1] = 2*data[,2] + rnorm(10,0,0.01)
data.norm <- data/data.rowsum

apply(data.norm,1,sum) # The rows sum to 1, so the data are normalized

##

##

[1] 1.3283443 1.1637649 2.2316430 1.2454013 0.5825677 0.7839830 2.0151673

[8] 1.1138188 0.8480482 1.4850258

test.input <- data.norm

dimnames(test.input) <- list(paste("Sample",seq(1,10)),paste("Feature",seq(1,4)))

test.output.matrix <- nc.score(x=test.input)

test.output.num

<- nc.score(x=test.input[,1],y=test.input[,2])

par(mfrow=c(1, 2))

plot(data[,1],data[,2],xlab="Feature 1",ylab="Feature 2",main="Non-normalized")

13

CCREPE: Compositionality Corrected by PErmutation and REnormalization

plot(data.norm[,1],data.norm[,2],xlab="Feature 1",ylab="Feature 2",

main="Normalized")

Figure 5: Non-normalized and normalized associations between feature 1 and feature 2 of the second ex-
ample. Again, we expect to observe a positive association between feature 1 and feature 2. In terms of
generalized checkerboard scores, we would expect to see more co-variation patterns than co-exclusion pat-
terns. This is shown by the positive and relatively high value of the [1,2] element of test.output.matrix
(which is identical to test.output.num)

test.output.matrix

##

Feature 1 Feature 2 Feature 3 Feature 4

## Feature 1

1.00000

1.00000

0.125

-0.21875

## Feature 2

1.00000

1.00000

0.125

-0.21875

## Feature 3

0.12500

0.12500

## Feature 4 -0.21875 -0.21875

1.000

0.125

0.12500

1.00000

test.output.num

## [1] 1

3.6

Example 2

An example of using nc.score with an aribitrary bin number.

data <- matrix(rlnorm(40,meanlog=0,sdlog=1),nrow=10,ncol=4)

data.rowsum <- apply(data,1,sum)
data[,1] = 2*data[,2] + rnorm(10,0,0.01)
data.norm <- data/data.rowsum

apply(data.norm,1,sum) # The rows sum to 1, so the data are normalized

##

##

[1] 0.9600917 1.1693288 2.2903563 2.0910976 0.5719043 1.9556880 1.5021242

[8] 1.9466491 1.2622316 0.3485392

test.input <- data.norm

dimnames(test.input) <- list(paste("Sample",seq(1,10)),paste("Feature",seq(1,4)))

test.output <- nc.score(x=test.input,nbins=4)

par(mfrow=c(1, 2))

plot(data[,1],data[,2],xlab="Feature 1",ylab="Feature 2",main="Non-normalized")

plot(data.norm[,1],data.norm[,2],xlab="Feature 1",ylab="Feature 2",

14

123450.51.52.5Non−normalizedFeature 1Feature 20.20.40.60.81.01.21.40.10.40.7NormalizedFeature 1Feature 2CCREPE: Compositionality Corrected by PErmutation and REnormalization

main="Normalized")

Figure 6: Non-normalized and normalized associations between feature 1 and feature 2 of the second ex-
ample. Again, we expect to observe a positive association between feature 1 and feature 2. In terms of
generalized checkerboard scores, we would expect to see more co-variation patterns than co-exclusion pat-
terns. This is shown by the positive and relatively high value in the [1,2] element of test.output. In this
case, the smaller bin number yields a smaller NC-score because of the coarser partitioning of the data.

test.output

##

Feature 1 Feature 2

Feature 3

Feature 4

## Feature 1 1.0000000 1.0000000

0.2857143 -0.3142857

## Feature 2 1.0000000 1.0000000

0.2857143 -0.3142857

## Feature 3 0.2857143 0.2857143

1.0000000 -0.3428571

## Feature 4 -0.3142857 -0.3142857 -0.3428571

1.0000000

3.7

Example 3

An example of using nc.score with user-defined bin edges.

data <- matrix(rlnorm(40,meanlog=0,sdlog=1),nrow=10,ncol=4)

data.rowsum <- apply(data,1,sum)
data[,1] = 2*data[,2] + rnorm(10,0,0.01)
data.norm <- data/data.rowsum

apply(data.norm,1,sum) # The rows sum to 1, so the data are normalized

##

##

[1] 2.6347153 2.0429414 0.8456816 1.1724924 1.4507663 1.3312170 1.4786343

[8] 0.9595209 1.2974579 1.1822927

test.input <- data.norm

dimnames(test.input) <- list(paste("Sample",seq(1,10)),paste("Feature",seq(1,4)))

test.output <- nc.score(x=test.input,bin.cutoffs=c(0.1,0.2,0.3))

par(mfrow=c(1, 2))

plot(data[,1],data[,2],xlab="Feature 1",ylab="Feature 2",main="Non-normalized")

plot(data.norm[,1],data.norm[,2],xlab="Feature 1",ylab="Feature 2",

main="Normalized")

15

24681234Non−normalizedFeature 1Feature 20.00.20.40.60.81.01.21.40.00.30.6NormalizedFeature 1Feature 2CCREPE: Compositionality Corrected by PErmutation and REnormalization

Figure 7: Non-normalized and normalized associations between feature 1 and feature 2 of the second ex-
ample. Again, we expect to observe a positive association between feature 1 and feature 2. In terms of
generalized checkerboard scores, we would expect to see more co-variation patterns than co-exclusion pat-
terns. This is shown by the positive and relatively high value in the [1,2] element of test.output. The bin
edges specified here represent almost absent ([ 0,0.001)), low abundance ([0.001,0.1)), medium abundance
([0.1,0.25)), and high abundance ([0.6,1)).

test.output

##

Feature 1 Feature 2

Feature 3

Feature 4

## Feature 1 1.0000000 0.5570860 -0.4383973 -0.2085144

## Feature 2 0.5570860 1.0000000

0.0000000 -0.3097612

## Feature 3 -0.4383973 0.0000000

1.0000000

0.3427956

## Feature 4 -0.2085144 -0.3097612

0.3427956

1.0000000

4

References

References

Martin Leonard Cody and Jared Mason Diamond. Ecology and evolution of communities.

Harvard University Press, 1975.

Karoline Faust, J Fah Sathirapongsasuti, Jacques Izard, Nicola Segata, Dirk Gevers, Jeroen

Raes, and Curtis Huttenhower. Microbial co-occurrence relationships in the human
microbiome. PLoS computational biology, 8(7):e1002606, 2012.

M.G. Kendall. Rank correlation methods. Charles Griffin & Co., 1970.

Emma Schwager and Colleagues. Detecting statistically significant associtations between

sparse and high dimensional compositional data. In Progress.

16

051015202530350510Non−normalizedFeature 1Feature 20.51.01.50.20.6NormalizedFeature 1Feature 2