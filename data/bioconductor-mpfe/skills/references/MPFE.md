MPFE

Conrad Burden, Sylvain Forêt, Peijie Lin

October 30, 2025

Many of the known mechanisms driving gene regulation fall into the category of
epigenomic modifications. DNA methylation is a common epigenomic modification, in
which a cytosine (C) in the genomic DNA sequence can be altered by the addition
of a methyl group. Methylation patterns can be are detected by treating DNA with
bisulphite, which converts unmethylated cytosines to uracils while leaving methylated
cytosines intact. This can be carried out at the whole genome level (whole-genome bisul-
fite sequencing) or at specific loci (PCR amplicons, capture or reduced representation
bisulfite sequencing). The resulting reads can be mapped to a reference and methylation
patterns inferred.

However, the bisulphite conversion is not 100% efficient, and this introduces errors
in the observed distribution of methylation patterns. A second source of errors is the
sequencing error. MPFE (for Methylation Patterns Frequency Estimation) [1] calculates
the estimated distribution over methylation patterns based on an input of methylation
pattern count data, an incomplete conversion rate and site-dependent read error rates.
The main component of the package is the function estimatePatterns(), which
generates a table of estimates ˆθi of the distribution over methylation patterns, and a
Input to the function is a data frame listing
list of patterns identified as spurious.
the methylation patterns in the first column followed by a number of columns of count
data (one column per sample). Estimation will be performed on all columns by default
unless specified by the variable column. The non-conversion and sequencing error rates
are specified by the parameters epsilon and eta respectively. The parameter eta
can be specified globally or as a site-dependent array with length equal to the number
of CpG sites in sequence of interest. The boolean variable fast enables either a fast
implementation (default) which ignores those patterns for which the observed read count
is zero or a slow implementation. The parameters steps and reltol are passed to the
function constrOptim() to control the accuracy of the determination of the maximum
log-likelihood.

A second function in the package is plotPatterns(). Input to this function is a data
frame, obtained from the output of estimatePatterns(). The output of plotPatterns()
is a plot that compares the observed read distribution with the estimated distribution.
The parameters yLimit1 and yLimit2 control the range of the y-axis on the plots pro-
duced.

1

In the following example, the input is the table of counts patternsExample. We
analyse the second column. The parameter epsilon is 0.01, while the parameter eta is
not specified and by default is 0.

> library(MPFE)
> data(patternsExample)
> patternsExample

mPattern

k1

k2
m00000 629 2257
90
m00001 26
75
m00010 20
m00011
3
2
82
m00100 24
3
m00101
0
11
1
m00110
0
0
m00111
80
m01000 23
0
0
m01001
1
1
m01010
0
0
m01011
5
1
m01100
0
m01110
0
69
28
m10000
2
1
m10001
2
0
m10010
0
0
m10011
7
0
m10100
1
3
m11000
0
0
m11001

1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21

> estimatePatterns(patternsExample, epsilon=0.01, column=2)

[[1]]

pattern coverage observedDistribution estimatedDistribution spurious
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
TRUE

0.8405959032
0.0335195531
0.0279329609
0.0011173184
0.0305400372
0.0040968343
0.0297951583
0.0003724395

0.8841394834
0.0253622332
0.0201750634
0.0005735316
0.0226431744
0.0035802381
0.0217187544
0.0000000000

00000
00001
00010
00011
00100
00110
01000
01010

2257
90
75
3
82
11
80
1

1
2
3
4
5
6
7
8

2

9
10
11
12
13
14

01100
10000
10001
10010
10100
11000

5
69
2
2
7
1

0.0018621974
0.0256983240
0.0007448790
0.0007448790
0.0026070764
0.0003724395

0.0013301642
0.0178634739
0.0002242079
0.0002760796
0.0021135959
0.0000000000

FALSE
FALSE
FALSE
FALSE
FALSE
TRUE

Note that in this example two patterns have been identified as spurious; they are

patterns 01010 and 11000.

The following example uses the same input table. The column variable is not speci-
fied, so the function estimatePatterns() by default applies to both columns of counts.
The sequencing error rate eta is specified as a site-dependent array.

> estimates <- estimatePatterns(patternsExample,
+
+
> estimates

epsilon=0.01,
eta=c(0.008, 0.01, 0.01, 0.01, 0.008))

[[1]]

pattern coverage observedDistribution estimatedDistribution spurious
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE

0.9088748331
0.0200854806
0.0099129217
0.0017646709
0.0155305960
0.0030002140
0.0004654103
0.0141238683
0.0004935455
0.0003809915
0.0221025625
0.0002793763
0.0029855293

0.825459318
0.034120735
0.026246719
0.002624672
0.031496063
0.003937008
0.001312336
0.030183727
0.001312336
0.001312336
0.036745407
0.001312336
0.003937008

00000
00001
00010
00011
00100
00101
00110
01000
01010
01100
10000
10001
11000

629
26
20
2
24
3
1
23
1
1
28
1
3

1
2
3
4
5
6
7
8
9
10
11
12
13

[[2]]

pattern coverage observedDistribution estimatedDistribution spurious
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE

0.8405959032
0.0335195531
0.0279329609
0.0011173184
0.0305400372
0.0040968343
0.0297951583

0.9257433597
0.0183957879
0.0115868249
0.0002262905
0.0141488595
0.0032974071
0.0127240011

00000
00001
00010
00011
00100
00110
01000

2257
90
75
3
82
11
80

1
2
3
4
5
6
7

3

> plotPatterns(estimates[[2]])

Figure 1: Plot of observed and estimated frequencies with plotPatterns

8
9
10
11
12
13
14

01010
01100
10000
10001
10010
10100
11000

1
5
69
2
2
7
1

0.0003724395
0.0018621974
0.0256983240
0.0007448790
0.0007448790
0.0026070764
0.0003724395

0.0000000000
0.0009915809
0.0110383332
0.0000000000
0.0000000000
0.0018475551
0.0000000000

TRUE
FALSE
FALSE
TRUE
TRUE
FALSE
TRUE

The ouput is a list of two data frames. We plot the observed and estimated pattern
of the second data frame on figure 1. Two plots are produced: the lower plot is the
expanded version of the upper plot.

We can also plot a map of the patterns and their frequencies. For instance, figure 2

illustrates different ways to plot all the patterns with frequency of 50% or less.

4

24681012140.00.20.40.60.81.0patternproportion050015002500coverageobserved distributionestimated distribution24681012140.0000.0100.0200.030patternproportion0116982coveragemaxFreq=0.5,
main='Estimated frequencies')

estimatedDistribution=FALSE,
maxFreq=0.5,
topDown=FALSE,
main='Observed frequencies')

> par(mfrow=c(2, 2))
> patternMap(estimates[[1]],
+
+
> patternMap(estimates[[1]],
+
+
+
+
> patternMap(estimates[[1]],
+
+
+
+
> patternMap(estimates[[1]],
+
+
+
+
+

estimatedDistribution=FALSE,
maxFreq=0.5,
methCol=c('bisque4', 'azure4'),
unMethCol=c('beige', 'azure'),
main='Observed frequencies')

maxFreq=0.5,
methCol=colorRampPalette(c('red', 'blue')),
unMethCol='lightgrey',
main='Estimated frequencies')

5

Figure 2: Different ways to plot the estimated frequencies with patternMap

123450.000.040.08Estimated frequenciesCpGProportion123450.000.050.100.15Observed frequenciesCpGProportion123450.000.040.08Estimated frequenciesCpGProportion123450.000.050.100.15Observed frequenciesCpGProportionReferences

[1] Lin, P., Forêt, S., Wilson, S.R. and Burden, C.J., Estimation of the methylation
pattern distribution from deep sequencing data. BMC Bioinformatics 2015, 16:145
doi:10.1186/s12859-015-0600-6

6

