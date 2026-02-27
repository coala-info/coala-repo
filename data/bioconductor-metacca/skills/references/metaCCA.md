metaCCA: Package for summary statistics-based
multivariate meta-analysis
of genome-wide association studies
using canonical correlation analysis

Anna Cichonska

October 30, 2025

Contents

1 Introduction

2 Input data

2.1 Univariate summary statistics SXY
2.2 Genotypic correlation structure SXX

. . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . .

3 metaCCA - workflow

3.1 Estimation of phenotypic correlation structure SY Y . . . . . . . . . . . . .
3.2 Genotype-phenotype association analysis . . . . . . . . . . . . . . . . . . .
3.2.1
Single-SNP–multi-trait analysis . . . . . . . . . . . . . . . . . . . .
3.2.2 Multi-SNP–multi-trait analysis . . . . . . . . . . . . . . . . . . . .

4 Summary

1

Introduction

1

2
3
4

4
4
5
5
9

12

A dominant approach to genome-wide association studies (GWAS) is to perform univari-
ate tests between genotype-phenotype pairs. However, analysing related traits together
results in increased statistical power and certain complex associations become detectable
only when several variants are tested jointly. Currently, modest sample sizes of individ-
ual cohorts and restricted availability of individual-level genotype-phenotype data across
the cohorts limit conducting multivariate tests. metaCCA allows to conduct multivariate
analysis of a single or multiple GWAS based on univariate regression coefficients. It allows
multivariate representation of both phenotype and genotype.

1

metaCCA extends the statistical technique of canonical correlation analysis to the set-
ting where the original individual-level data are not available. Instead, metaCCA operates
on three pieces of the full data covariance matrix: SXY of univariate genotype-phenotype
association
SY Y
of phenotype-phenotype correlations. SXX is estimated from a reference database match-
ing the study population, e.g., the 1000 Genomes (www.1000genomes.org), and SY Y
is estimated from SXY .

genotype-genotype

correlations,

results,

SXX

This vignette explains how to use the metaCCA package. For more details about

and

of

the method, see [1].

2

Input data

The package contains a simulated toy data set. Here, we will work with it to show
an example of the meta-analysis of two studies using metaCCA. We will
focus
on the analysis of 10 SNPs and 10 traits (phenotypic variables). We will use univari-
ate summary statistics across 1000 SNPs to estimate phenotypic correlation structures
SY Y (here, correlations between 10 traits). You can have a look at the list of variables
provided by typing:

library(metaCCA)
data( package = 'metaCCA' )

• N1 - number of individuals in study 1.

• N2 - number of individuals in study 2.

• S XY full study1 - univariate summary statistics of 10 traits across 1000 SNPs

(study 1).

• S XY full study2 - univariate summary statistics of 10 traits across 1000 SNPs

(study 2).

• S XY study1 - univariate summary statistics of 10 traits across 10 SNPs

(study 1).

• S XY study2 - univariate summary statistics of 10 traits across 10 SNPs

(study 2).

• S XX study1 - correlations between 10 SNPs corresponding to the population un-

derlying study 1.

• S XX study2 - correlations between 10 SNPs corresponding to the population un-

derlying study 2.

Tab-separated text files containing the data can be found in the inst/extdata folder
(except N1 and N2 which are just numerical values). They could be read to R using
read.table function with options header=TRUE and row.names=1.

2

# Number of individuals in study 1
print( N1 )

## [1] 1000

# Number of individuals in study 2
print( N2 )

## [1] 2000

In metaCCA, we consider the following two types of the multivariate association
analysis.

• Single-SNP–multi-trait analysis

One genetic variant tested for an association with a set of phenotypic variables
(genotypic correlation structure SXX not needed).

• Multi-SNP–multi-trait analysis

A set of genetic variants tested for an association with a set of phenotypic
variables.

2.1 Univariate summary statistics SXY
Data frame S XY with row names corresponding to SNP IDs (e.g., position or rs id) and
the following columns.

• allele 0 - allele 0 (string composed of ”A”, ”C”, ”G” or ”T”).

• allele 1 - allele 1 (string composed of ”A”, ”C”, ”G” or ”T”).

• Two columns for each trait to be included in the analysis:

– traitID b - univariate regression coefficients;
– traitID se - corresponding standard errors;

(”traitID” in the column name must be an ID of a trait specified by a user.
Do not use underscores ” ” in trait IDs outside ” b”/” se” in order for the IDs
to be processed correctly.)

# Part of the S_XY data frame for study 1

print( head(S_XY_study1[,1:6]), digits = 3 )

##
## rs10
## rs80
## rs140
## rs170
## rs172
## rs174

allele_0 allele_1 trait1_b trait1_se trait2_b trait2_se
0.0449
0.0608
0.0433
0.0483
0.0481
0.0480

-0.0256
0.0595
0.0157
0.0136
0.0163
0.0143

-0.0196
0.0624
0.0239
0.0214
0.0205
0.0187

0.0448
0.0607
0.0432
0.0483
0.0481
0.0479

G
G
A
A
A
T

T
T
C
T
T
G

3

2.2 Genotypic correlation structure SXX
Data frame S XX containing correlations between SNPs.
It is needed only in case
of multi-SNP–multi-trait analysis. Row names (and, optionally, column names) must
correspond to SNP IDs. You can estimate correlations between SNPs from a reference
database matching
1000 Genomes project
(www.1000genomes.org).

study population,

e.g.,

the

the

# Part of the S_XX data frame for study 1

print( head(S_XX_study1[,1:6]), digits = 3 )

rs80

rs10

rs140 rs170
1.0000 -0.465 0.0878 0.119

rs174
##
0.149
## rs10
0.3161 0.171 -0.221 -0.226
## rs80 -0.4646 1.000
1.0000 0.536 -0.214 -0.216
0.0878 0.316
## rs140
0.406
0.1187 0.171
## rs170
0.5360 1.000
0.998
0.1456 -0.221 -0.2142 0.406
## rs172
1.000
0.1490 -0.226 -0.2156 0.406
## rs174

0.406
1.000
0.998

rs172
0.146

3 metaCCA - workflow

3.1 Estimation of phenotypic correlation structure SY Y
In metaCCA, correlations between traits are estimated from univariate summary statistics
SXY . Specifically, each entry of the phenotypic correlation matrix SY Y corresponds to a
Pearson correlation between univariate regression coefficients of two phenotypic variables
across genetic variants. The higher the number of genetic variants, the lower the error of
the estimate. See [1] for more details.

Here, we will estimate correlations between 10 traits using estimateSyy function.
In each case, we will use summary statistics of 1000 SNPs. However, in practice, summary
statistics of at least one chromosome should be used in order to ensure good quality
of SY Y estimate. estimateSyy can be used no matter if the univariate analysis has been
performed on standardised data (meaning that the genotypes were standardised before
regression coefficients and standard errors were computed) or non-standardised data.

The function takes one argument - S XY - data frame with univariate summary statis-

tics in the form described in section 2.1 of this vignette.

# Estimating phenotypic correlation structure of study 1
S_YY_study1 = estimateSyy( S_XY = S_XY_full_study1 )

# Estimating phenotypic correlation structure of study 2
S_YY_study2 = estimateSyy( S_XY = S_XY_full_study2 )

4

estimateSyy returns a matrix S YY containing correlations between traits given

as input; here, 10 traits. Let’s display a part of the resulting matrix for study 1.

print( head(S_YY_study1[,1:6]), digits = 3 )

##
## trait1
## trait2
## trait3
## trait4
## trait5
## trait6

trait1 trait2 trait3 trait4 trait5 trait6
0.949
0.933
0.807
0.922
0.898
1.000

1.000 0.995
0.995 1.000
0.912 0.942
0.991 0.998
0.977 0.991
0.949 0.933

0.912
0.942
1.000
0.955
0.977
0.807

0.991
0.998
0.955
1.000
0.996
0.922

0.977
0.991
0.977
0.996
1.000
0.898

3.2 Genotype-phenotype association analysis

The package contains two functions for performing the association analysis:

• metaCcaGp - runs the analysis according to metaCCA algorithm;

• metaCcaPlusGp - runs the analysis according to a variant of metaCCA, namely
metaCCA+, where the full covariance matrix is shrunk beyond the level guarantee-
ing its positive semidefinite property (see [1] for more details).

Both functions require the same inputs, and they have the same output format.
They accept a varying number of inputs, depending on the type of the association anal-
ysis. Traits and SNPs included in the analysis must be the same for the studies that are
meta-analysed together.

In the next

step, we will perform a meta-analysis of

two studies, where
traits
we will
(single-SNP–multi-trait analysis). At the end, we will also analyse several SNPs
jointly (multi-SNP–multi-trait analysis).

an association with a

single SNPs

group of

test

for

10

3.2.1 Single-SNP–multi-trait analysis

By default, metaCcaGp and metaCcaPlusGp perform single-SNP–multi-trait analysis, where
each given SNP is analysed in turn against all given phenotypic variables.
The required inputs are as follows.

• nr studies - number of studies analysed.

• S XY - a list of data frames (one for each study) with univariate summary statis-
tics corresponding to SNPs and traits to be included in the analysis (in the form
described in section 2.1);

5

• std info - a vector with indicators (one for each study) if the univariate analysis has
been performed on standardised (1) or non-standardised (0) data (most likely the
data were not standardised - the genotypes were not standardised before univariate
regression coefficients and standard errors were computed - option 0 should be used);

• S YY - a list of matrices (one for each study), estimated using estimateSyy function,

containing correlations between traits to be included in the analysis;

• N - a vector with numbers of individuals in each study.

We will first run the default single-SNP–multi-trait analysis of two studies using pro-
vided toy data. Each of 10 SNPs will be tested for an association with the group
of 10 traits.

# Default single-SNP--multi-trait meta-analysis of 2 studies

# Association analysis according to metaCCA algorithm
metaCCA_res1 = metaCcaGp( nr_studies = 2,

S_XY = list( S_XY_study1, S_XY_study2 ),
std_info = c( 0, 0 ),
S_YY = list( S_YY_study1, S_YY_study2 ),
N = c( N1, N2) )

# Association analysis according to metaCCA+ algorithm
metaCCApl_res1 = metaCcaPlusGp( nr_studies = 2,

S_XY = list( S_XY_study1, S_XY_study2 ),
std_info = c( 0, 0 ),
S_YY = list( S_YY_study1, S_YY_study2 ),
N = c( N1, N2 ) )

The output is a data frame with row names corresponding to SNP IDs. The columns
contain the following information for each analysed SNP:

• r 1 - leading canonical correlation value,

• -log10(p-val) - p-value in the -log10 scale,

• trait weights - trait-wise canonical weights,

• snp weights - SNP-wise canonical weights (only for multi-SNP–multi-trait analy-

sis).

6

# Result of metaCCA
print( metaCCA_res1[1:2], digits = 2 )

##
0.045
## rs10
## rs80
0.036
## rs140 0.077
## rs170 0.076
## rs172 0.050
## rs174 0.050
## rs176 0.072
## rs178 0.073
## rs180 0.071
## rs200 0.052

r_1 -log10(p-val)
0.089
0.020
1.232
1.154
0.162
0.162
0.929
1.007
0.889
0.211

print( metaCCA_res1[3], digits = 1 )

##
## rs10
## rs80
## rs140
## rs170
## rs172
## rs174
## rs176
## rs178
## rs180
## rs200

trait_weights
-7.89, 5.84, -6.13, -6.07, 16.01, 0.06, -3.12, 6.76, -5.97, 0.56
-2.3, -3.1, 2.1, 4.4, 0.3, -1.0, -2.9, 0.8, 1.6, 0.4
6.4, -10.4, 2.0, 2.6, -1.0, 5.0, 0.7, -2.3, -0.5, -3.3
4.1, -3.6, 5.3, 3.6, -8.8, 4.1, -0.5, -6.3, 4.3, -2.3
-9.7, 22.0, 5.7, -4.3, -11.4, -1.3, -1.2, -1.9, 0.9, 2.2
-10.0, 22.0, 5.8, -3.4, -12.1, -1.2, -1.0, -1.5, 0.3, 2.1
-4.0, 3.2, -5.6, -5.2, 11.1, -4.1, 0.4, 6.9, -4.9, 2.4
-12.5, 22.3, -0.2, -6.5, -1.7, -7.4, -1.0, 3.1, -0.5, 5.3
-12.6, 13.7, -6.0, -2.7, 7.9, 1.1, 1.8, 10.6, -14.5, 0.7
2, -2, 7, 9, -16, -5, -3, -5, 12, 2

# Result of metaCCA+
print( metaCCApl_res1[1:2], digits = 2 )

##
0.034
## rs10
## rs80
0.031
## rs140 0.070
## rs170 0.069
## rs172 0.034
## rs174 0.034
## rs176 0.064
## rs178 0.047
## rs180 0.046
## rs200 0.038

r_1 -log10(p-val)
0.0147
0.0062
0.8683
0.7728
0.0147
0.0152
0.5762
0.1196
0.1050
0.0319

print( metaCCApl_res1[3], digits = 1 )

##
## rs10
## rs80

trait_weights
1.0, -1.0, 0.9, -1.0, -1.2, -0.6, 3.6, -1.8, -0.4, 0.6
-1.6, -1.2, 2.2, 0.8, 1.1, -0.8, -2.0, 0.7, 0.7, 0.4

7

## rs140
0.55, -1.63, 0.89, 0.42, -0.07, 2.14, 0.56, -1.76, -0.50, -1.31
## rs170 -0.02, -0.67, 1.72, -0.14, -0.28, 2.36, 0.61, -2.38, -0.32, -0.97
-1.3, 3.5, 2.4, -3.0, -1.1, 1.6, 0.8, -0.5, -1.3, -0.4
## rs172
## rs174
-1.3, 3.5, 2.3, -2.9, -1.1, 1.7, 0.8, -0.5, -1.4, -0.4
0.10, -0.63, 1.54, -0.03, -0.39, 2.47, 0.72, -2.56, -0.28, -1.07
## rs176
-1.19, 3.46, 0.15, -2.23, -0.54, -3.20, -0.37, 2.76, -0.04, 1.86
## rs178
1.1, -3.2, 2.4, 0.2, -0.3, -1.9, 0.3, -1.3, 1.5, 1.6
## rs180
-0.4, -1.8, 1.9, 0.2, -0.1, -2.8, -1.0, 1.7, 1.8, 1.1
## rs200

You can also run the association analysis of only one selected SNP. In such case, two
additional inputs need to be given:

• analysis type - indicator of the analysis type: 1;

• SNP id - ID of the SNP of interest.

Let’s run the analysis for a SNP with ID ’rs80’; it will be tested for an association with
the group of 10 provided traits.

# Single-SNP--multi-trait meta-analysis of 2 studies
# and one selected SNP

# metaCCA
metaCCA_res2 = metaCcaGp( nr_studies = 2,

S_XY = list( S_XY_study1, S_XY_study2 ),
std_info = c( 0, 0 ),
S_YY = list( S_YY_study1, S_YY_study2 ),
N = c( N1, N2 ),
analysis_type = 1,
SNP_id = 'rs80' )

# Result of metaCCA
print( metaCCA_res2, digits = 2 )

r_1 -log10(p-val)
0.02

##
## rs80 0.036
##
trait_weights
## rs80 -2.27, -3.10, 2.13, 4.38, 0.34, -0.97, -2.93, 0.85, 1.56, 0.41

8

# metaCCA+
metaCCApl_res2 = metaCcaPlusGp( nr_studies = 2,

S_XY = list( S_XY_study1, S_XY_study2 ),
std_info = c( 0, 0 ),
S_YY = list( S_YY_study1, S_YY_study2 ),
N = c( N1, N2 ),
analysis_type = 1,
SNP_id = 'rs80' )

# Result of metaCCA+
print( metaCCApl_res2, digits = 2 )

r_1 -log10(p-val)
0.0062

##
## rs80 0.031
##
trait_weights
## rs80 -1.55, -1.20, 2.22, 0.83, 1.08, -0.76, -2.04, 0.73, 0.67, 0.41

3.2.2 Multi-SNP–multi-trait analysis

In order to analyse multiple SNPs jointly, you need to provide the following additional
inputs:

• analysis type - indicator of the analysis type: 2;

• SNP id - a vector with IDs of SNPs to be analysed jointly;

• S XX - a list of data frames (one for each study) containing correlations between

SNPs to be analysed (in the form described in section 2.2).

Here, we will run the analysis of 5 SNPs with IDs ’rs10’,
and ’rs172’. They will be tested jointly for an association with the group of 10 traits.

’rs140’, rs170’

’rs80’,

# Multi-SNP--multi-trait meta-analysis of 2 studies

# metaCCA
metaCCA_res3 = metaCcaGp( nr_studies = 2,

S_XY = list( S_XY_study1, S_XY_study2 ),
std_info = c( 0, 0 ),
S_YY = list( S_YY_study1, S_YY_study2 ),
N = c( N1, N2 ),
analysis_type = 2,
SNP_id = c( 'rs10', 'rs80', 'rs140',

'rs170', 'rs172' ),
S_XX = list( S_XX_study1, S_XX_study2 ) )

9

# Result of metaCCA
print( metaCCA_res3[1:2], digits = 2 )

##
## c("rs10", "rs80", "rs140", "rs170", "rs172") 0.087

r_1 -log10(p-val)
0.14

print( metaCCA_res3[3], digits = 2, row.names = FALSE )

##
trait_weights
## 6.90, -8.95, 4.10, 4.31, -6.70, 4.30, 0.66, -5.23, 2.98, -2.87

print( metaCCA_res3[4], digits = 2, row.names = FALSE )

##
snp_weights
## -0.312, 0.019, -0.462, -0.614, 0.150

# metaCCA+
metaCCApl_res3 = metaCcaPlusGp( nr_studies = 2,

S_XY = list( S_XY_study1, S_XY_study2 ),
std_info = c( 0, 0 ),
S_YY = list( S_YY_study1, S_YY_study2 ),
N = c( N1, N2 ),
analysis_type = 2,
SNP_id = c( 'rs10', 'rs80', 'rs140',

'rs170', 'rs172' ),

S_XX = list( S_XX_study1, S_XX_study2 ))

# Result of metaCCA+
print( metaCCApl_res3[1:2], digits = 2 )

##
## c("rs10", "rs80", "rs140", "rs170", "rs172") 0.079

r_1 -log10(p-val)
0.01

print( metaCCApl_res3[3], digits = 1, row.names = FALSE )

trait_weights
##
## 0.56, -1.28, 1.49, -0.08, -0.51, 2.11, 1.00, -2.23, -0.39, -1.04

print( metaCCApl_res3[4], digits = 1, row.names = FALSE )

snp_weights
##
## -0.27, -0.04, -0.57, -0.47, -0.07

10

If all studies included in the meta-analysis have the same underlying population
(e.g., Finnish), only one genotypic correlation structure is needed. Let’s assume that
this is the case for two studies in our example.

S_XX_common = S_XX_study1

Then, association analysis according to metaCCA and metaCCA+ would be run
as follows.

# metaCCA
metaCCA_res4 = metaCcaGp( nr_studies = 2,

S_XY = list( S_XY_study1, S_XY_study2 ),
std_info = c( 0, 0 ),
S_YY = list( S_YY_study1, S_YY_study2 ),
N = c( N1, N2 ),
analysis_type = 2,
SNP_id = c( 'rs10', 'rs80', 'rs140',

'rs170', 'rs172' ),
S_XX = list( S_XX_common, S_XX_common ) )

# Result of metaCCA
print( metaCCA_res4[1:2], digits = 2 )

##
## c("rs10", "rs80", "rs140", "rs170", "rs172") 0.086

r_1 -log10(p-val)
0.13

print( metaCCA_res4[3], digits = 2, row.names = FALSE )

##
trait_weights
## 6.57, -8.51, 4.03, 4.02, -6.37, 4.39, 0.57, -5.04, 2.70, -2.89

print( metaCCA_res4[4], digits = 2, row.names = FALSE )

##
snp_weights
## -0.247, 0.024, -0.503, -0.587, 0.102

# metaCCA+
metaCCApl_res4 = metaCcaPlusGp( nr_studies = 2,

S_XY = list( S_XY_study1, S_XY_study2 ),
std_info = c( 0, 0 ),
S_YY = list( S_YY_study1, S_YY_study2 ),
N = c( N1, N2 ),
analysis_type = 2,
SNP_id = c( 'rs10', 'rs80', 'rs140',

'rs170', 'rs172' ),

S_XX = list( S_XX_common, S_XX_common ))

# Result of metaCCA+
print( metaCCApl_res4[1:2], digits = 2 )

11

##
## c("rs10", "rs80", "rs140", "rs170", "rs172") 0.079

r_1 -log10(p-val)
0.0097

print( metaCCApl_res4[3], digits = 1, row.names = FALSE )

##
trait_weights
## 0.5, -1.2, 1.5, -0.1, -0.5, 2.2, 0.9, -2.2, -0.4, -1.1

print( metaCCApl_res4[4], digits = 1, row.names = FALSE )

##
snp_weights
## -0.22, -0.04, -0.60, -0.46, -0.10

4 Summary

In this vignette, we have followed the procedure for association testing between
multivariate genotype and multivariate phenotype based on univariate summary
statistics using metaCCA algorithm and its variant metaCCA+. We used a simulated
data set to demonstrate an example of meta-analysis of two genome-wide association
studies.

For more information on the method, see [1].

References

[1] A Cichonska, J Rousu, P Marttinen, AJ Kangas, P Soininen, T Lehtim¨aki,
OT Raitakari, MR J¨arvelin, V Salomaa, M Ala-Korpela, S Ripatti, M Pirinen
(2016) metaCCA: Summary statistics-based multivariate meta-analysis of genome-wide
association studies using canonical correlation analysis. Bioinformatics, 32(13):1981-
1989.

12

