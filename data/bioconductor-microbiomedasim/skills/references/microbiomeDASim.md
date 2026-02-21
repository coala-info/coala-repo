microbiomeDASim: Tools for Simulationg
Longitudinal Differential Abundance

Justin Williams, Hector Corrada Bravo, Jennifer Tom, Joseph Nathaniel Paulson

Modified: September 9, 2019. Compiled: October 30, 2025

Contents

1 Introduction

2 Installation

3 Motivation

4 Statistical Methodology

4.1 Trivial Example . . . . . . . . . . . . . . . . . . . . . . . . . .

5 Session Info

2

2

2

3
5

9

1

1

Introduction

With an increasing emphasis on understanding the dynamics of microbial
communities in various settings, longitudinal sampling studies are underway.
Whole metagenomic shotgun sequencing and marker-gene survey studies
have unique technical artifacts that drive novel statistical methodological
development for estimating time intervals of differential abundance. In de-
signing a study and the frequency of collection prior to a study, one may
wish to model the ability to detect an effect, e.g., there may be issues with
respect to cost, ease of access, etc. Additionally, while every study is unique,
it is possible that in certain scenarios one statistical framework may be more
appropriate than another.

Here, we present a simulation paradigm in a R software package termed
microbiomeDASim. This package allows investigators to simulate longitu-
dinal differential abundance for single features, mvrnorm sim, or a commu-
nity with multiple features, gen norm microbiome. The functions allow the
user to specify a variety of known functional forms (e.g, linear, quadratic,
oscillating, hockey stick) along with flexible parameters to control desired
signal to noise ratio. Different longitudinal correlation structures are avail-
able including AR(1), compound, and independent to account for expected
within individual correlation. Comparing estimation methods or designing
a potential longidutinal investigation for microbiome sequencing data using
microbiomeDASim provides accurate and reproducible results.

2 Installation

To install microbiomeDASim from Bioconductor use the code below:

if (!requireNamespace("BiocManager", quietly = TRUE)) {

install.packages("BiocManager")

}
BiocManager::install("microbiomeDASim")

3 Motivation

In our analyses we want to try and simulate longitudinal differential abun-
dance for microbiome normalized counts generated from 16S rRNA sequenc-
ing in order to compare different methodologies for estimating this differen-
tial abundance. Simulating microbiome data presents a variety of different
challenges based both on biological and technical challenges.

These challenges include:

• Non-negative restriction

2

• Presence of Missing Data/High Number of Zero Reads

• Low Number of Repeated Measurements

• Small Number of Subjects

For our initial simulation design, we are attempting to address many of
these challanges by simulating data across a variety of different parameter
scenarios where each element of the challenges listed above can be investi-
gated. Since many of the methods when analyzing microbiome data involve
normalization procedures and the central limit theory allows us to think
about the normal distribution as an asymptotic ideal, we will treat the
Multivariate Normal Distribution as our best case scenario for simulation
purposes.

4 Statistical Methodology

Assume that we have data generated from the following distribution,

Y ∼ N (µ, Σ)

where

Y =








YT
1
YT
2
...
YT
n








=







































Y11
Y12
...
Y1q1
Y21
...
Y2q2
...
Ynqn

with Yij representing the ith patient at the jth timepoint where each patient
has qi repeated measurements with i ∈ {1, . . . , n} and j ∈ {1, . . . , qi}. We
define the total number of observations as N = (cid:80)n
i=1 qi. Therefore in our
original assumption defined above we can explicitly define the dimension of
our objects as

YN ×1 ∼ NN (µN ×1, ΣN ×N )

In our current simulations we choose to keep the number of repeated
measurements constant, i.e., qi = q ∀ i ∈ {1, . . . , n}. This means that the
total number of obseravtions simplifies to the expression N = qn. However,
we will vary the value of q across the simulations to simulate data generated

3

from a study with a small (q = 3), medium (q = 6), or large (q = 12) num-
ber of repeated observations. Currently most studies with microbiome data
collected fall closest to the small case, but there are a few publically avail-
able datasets that contain a large number of repeated observations for each
individual. For simplicity in the remaining description of the methodology
we will assume constant number of repeated observations.

Without loss of generality we can split the total patients (n) into two
groups, control (n0) vs (n1), with the first n0 patients representing the con-
trol patients and the remaining n−n0 representing the treatment. Partition-
ing our observations in this way allows us to also partition the mean vector
as µ = (µ0, µ1). In our current simulation shown below we assume that the
mean for the control group is constant µ01n0×1, but we allow our mean vec-
tor for the treatment group to vary depending on time µ1ij(t) = µ0+f (tj) for
i = 1, . . . , n1 and j = 1, . . . , q. In our simulation we will choose a parametric
form for the function f (tj) primarly from the polynomial family where

f (tj) = β0 + β1tj + β2t2

j + · · · + βptp

j

for a p dimensional polynomial. For instance, to define a linear polynomial
we would have

f (tj) = β0 + β1tj

where β1 > 0 for an increasing linear trend and β1 < 0 for a decreas-
ing linear trend. For a list of available functional forms currently imple-
mented and the expected form of the input see documentation for ‘micro-
biomeDASim::mean trend‘.

For the covariance matrix, we want to encode our longitudinal dependen-
cies so that observations within an individual are correlated, i.e., Cor(Yij, Yij′) ̸=
0, but that observations between individuals are independent, i.e., Cor(Yij, Yi′j) =
0 ∀i ̸= i′ and j. To accomplish this we define the matrix ΣN ×N as Σ =
bdiag(Σ1, . . . , Σn), where each Σi is a q × q matrix a specific longitudinal
structure.

For instance if we want to specify an autoregressive correlation structure

for individual i we could define their covariance matrix as

Σi = σ2










ρ
1
ρ

1
ρ
ρ2
...

ρ|q−1| ρ|q−2|

ρ2
ρ
1

· · ·

· · ·
· · ·
· · ·
. . .
· · ·










ρ|1−q|
ρ|2−q|

...
1

In this case we are using the first order autoregressive definition and therefore
will refer to this as ”ar1”.

4

Alternatively, for the compound correlation structure for an individual

i′ we could define the covariance matrix as

Σi′ = σ2










ρ
ρ
1

1 ρ
ρ 1
ρ ρ
...
ρ ρ · · ·

· · ·
· · ·
· · ·
. . .
· · ·










ρ
ρ

...
1

Finally, the independent correlation structure for an individual i′′ would

be defined as

Σi′′ = σ2










0
0
1

1 0
0 1
0 0
...
0 0 · · ·

· · ·
· · ·
· · ·
. . .
· · ·










0
0

...
1

4.1 Trivial Example

We can construct a trivial example where n = 2 (n0 = 1 and n1 = 1) and
q = 2, an ar1 correlation structure where ρ = 0.8, σ = 1, a linear functional
form with β = (0, 1)T , control mean is constant at µ0 = 2 and t = (1, 2).







Y ∼ N4







µ0
µ0
µ0 + β0 + β1 × t1
µ0 + β0 + β1 × t2







, σ2







1 ρ 0 0
ρ 1 0 0
0 0 1 ρ
0 0 ρ 1













= N4














2
2


3

4

,







1
0.8
0
0

0.8
1
0
0

0
0
1
0.8













0
0
0.8
1

Next, we can now look at sample data generated for our trivial example,

require(microbiomeDASim)

## Loading required package: microbiomeDASim

triv_ex <- mvrnorm_sim(n_control=10, n_treat=10, control_mean=2,

sigma=1, num_timepoints=2, t_interval=c(1, 2), rho=0.8,
corr_str="ar1", func_form="linear",
beta= c(1, 2), missing_pct=0,
missing_per_subject=0, dis_plot=TRUE)

## ‘geom smooth()‘ using formula = ’y ~ x’

5

Y ID time

head(triv_ex$df)

##
## 1 1.3845507 1
## 2 1.5327903 1
## 3 1.8030231 2
## 4 0.7768406 2
## 5 2.0269612 3
## 6 1.5039227 3

group

Y_obs
1 Control 1.3845507
2 Control 1.5327903
1 Control 1.8030231
2 Control 0.7768406
1 Control 2.0269612
2 Control 1.5039227

triv_ex$Sigma[seq_len(2), seq_len(2)]

## 2 x 2 sparse Matrix of class "dsCMatrix"
##
## [1,] 1.0 0.8
## [2,] 0.8 1.0

Note that there are a variety of flexible choices for the the functional

form of the trend:

• Linear

• Quadratic

• Cubic

• M/W (Oscillating Trends)

6

24680.91.21.51.82.1TimeNormalized ReadsGroupControlTreatmentSimulated Microbiome Data from Multivariate Normal• L up/L down (Hockey Stick Trends)

Below we show an example using a Hockey Stick trend where we graph

the true functional form, and then simulate data with this trend.

true_mean <- mean_trend(timepoints=1:10, form="L_up", beta=0.5, IP=5,

plot_trend=TRUE)

hockey_sim <- mvrnorm_sim(n_control=10, n_treat=10, control_mean=2, sigma=1,

num_timepoints=10, t_interval=c(0, 9), rho=0.8,
corr_str="ar1", func_form="L_up", beta= 0.5, IP=5,
missing_pct=0, missing_per_subject=0, dis_plot=TRUE,
asynch_time=TRUE)

## ‘geom smooth()‘ using formula = ’y ~ x’

7

0.00.51.01.52.02.52.55.07.510.0timepointsmuThe mvrnorm sim method generates a single feature with a specified lon-
gitudinal differential abundance pattern. However, we may want to simu-
late a microboime environment with multiple features where certain features
have differential abundance while others do not.

To address this we can use the function gen microbiome, which specifies
thenumber of features and the number of differentiall abundant features. All
features selected to have differential abundance will have the same type of
functional form.

bug_gen <- gen_norm_microbiome(features=6, diff_abun_features=3, n_control=30,

n_treat=20, control_mean=2, sigma=2,
num_timepoints=4, t_interval=c(0, 3),
rho=0.9, corr_str="compound",
func_form="M", beta=c(4, 3), IP=c(2, 3.3, 6),
missing_pct=0.2, missing_per_subject=2,
miss_val=0)

## Simulating Diff Bugs
## Simulating No-Diff Bugs

head(bug_gen$bug_feat)

ID time

##
## Sample_1 1
## Sample_2 1
## Sample_3 1
## Sample_4 1

group Sample_ID
0 Control Sample_1
1 Control Sample_2
2 Control Sample_3
3 Control Sample_4

8

0123450.02.55.07.5TimeNormalized ReadsGroupControlTreatmentSimulated Microbiome Data from Multivariate Normal## Sample_5 2
## Sample_6 2

0 Control Sample_5
1 Control Sample_6

bug_gen$Y[, 1:5]

Sample_1 Sample_2 Sample_3 Sample_4

Sample_5
##
4.6713175 3.862699 5.196415 4.1022281 2.3557581
## Diff_Bug1
1.9413310 2.075423 2.062152 2.2880649 0.0000000
## Diff_Bug2
## Diff_Bug3
2.4580373 3.194222 3.246816 3.0498517 0.7982714
## NoDiffBug_1 3.1329329 3.315077 4.076031 5.1197513 1.6568760
## NoDiffBug_2 0.7398408 0.940553 1.359774 0.4977191 3.1262012
## NoDiffBug_3 4.1030595 3.549136 4.882748 4.3182941 2.4957854

names(bug_gen)

## [1] "Y"

"bug_feat"

Note that we now have two objects returned in this function.

• Y is our observed feature matrix with rows representing features and

columns indicating our repeated samples

• bug feat identifies the subject ID, time, group (Control vs. Treat-

ment) and corresponding Sample ID from the columns of Y.

5 Session Info

sessionInfo()

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0
##
## locale:
## [1] LC_CTYPE=en_US.UTF-8
## [3] LC_TIME=en_GB
## [5] LC_MONETARY=en_US.UTF-8
## [7] LC_PAPER=en_US.UTF-8
## [9] LC_ADDRESS=C

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

9

LAPACK version 3.12.0

methods

datasets

graphics grDevices utils

## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats
## [7] base
##
## other attached packages:
## [1] microbiomeDASim_1.24.0 knitr_1.50
##
## loaded via a namespace (and not attached):
tidyselect_1.2.1
## [1] ade4_1.7-23
farver_2.1.2
## [3] dplyr_1.1.4
S7_0.2.0
## [5] Biostrings_2.78.0
phyloseq_1.54.0
## [7] bitops_1.0-9
lifecycle_1.0.4
## [9] digest_0.6.37
survival_3.8-3
## [11] cluster_2.1.8.1
magrittr_2.0.4
## [13] statmod_1.5.1
rlang_1.1.6
## [15] compiler_4.5.1
igraph_2.2.1
## [17] tools_4.5.1
## [19] data.table_1.17.8
labeling_0.4.3
## [21] metagenomeSeq_1.52.0 plyr_1.8.9
## [23] RColorBrewer_1.1-3
## [25] withr_3.0.2
## [27] grid_4.5.1
## [29] caTools_1.18.3
## [31] biomformat_1.38.0
## [33] ggplot2_4.0.0
## [35] gtools_3.9.5
## [37] MASS_7.3-65
## [39] cli_3.6.5
## [41] tmvtnorm_1.7
## [43] crayon_1.5.3
## [45] reshape2_1.4.4
## [47] ape_5.8-1
## [49] stringr_1.5.2
## [51] parallel_4.5.1
## [53] XVector_0.50.0
## [55] vctrs_0.6.5
## [57] glmnet_4.1-10
## [59] jsonlite_2.0.0

KernSmooth_2.23-26
BiocGenerics_0.56.0
stats4_4.5.1
multtest_2.66.0
Rhdf5lib_1.32.0
scales_1.4.0
iterators_1.0.14
dichromat_2.0-0.1
mvtnorm_1.3-3
vegan_2.7-2
generics_0.1.4
pbapply_1.7-4
rhdf5_2.54.0
splines_4.5.1
formatR_1.14
matrixStats_1.5.0
sandwich_3.1-1
Matrix_1.7-4
IRanges_2.44.0

10

locfit_1.5-9.12
limma_3.66.0
codetools_0.2-20
gmm_1.9-1
gtable_0.3.6
pillar_1.11.1
gplots_3.2.0

## [61] S4Vectors_0.48.0
## [63] foreach_1.5.2
## [65] glue_1.8.0
## [67] stringi_1.8.7
## [69] shape_1.4.6.1
## [71] tibble_3.3.0
## [73] Seqinfo_1.0.0
## [75] rhdf5filters_1.22.0 R6_2.6.1
## [77] evaluate_1.0.5
## [79] Biobase_2.70.0
## [81] Rcpp_1.1.0
## [83] nlme_3.1-168
## [85] mgcv_1.9-3
## [87] zoo_1.8-14

lattice_0.22-7
highr_0.11
Wrench_1.28.0
permute_0.9-8
xfun_0.53
pkgconfig_2.0.3

11

