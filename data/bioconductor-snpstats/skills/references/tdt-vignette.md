TDT vignette
Use of snpStats in family–based studies

David Clayton

October 30, 2025

Pedigree data

The snpStats package contains some tools for analysis of family-based studies. These assume
that a subject support file provides the information necessary to reconstruct pedigrees in the
well-known format used in the LINKAGE package. Each line of the support file must contain
an identifier of the pedigree to which the individual belongs, together with an identifier
of subject within pedigree, and the within-pedigree identifiers for the subject’s father and
mother. Usually this information, together with phenotype data, will be contained in a
dataframe with rownames which link to the rownames of the SnpMatrix containing the
genotype data. The following commands read some illustrative data on 3,017 subjects and
43 (autosomal) SNPs1. The data consist of a dataframe containing the subject and pedigree
information (pedData) and a SnpMatrix containing the genotype data (genotypes):

> require(snpStats)
> data(families)
> genotypes

A SnpMatrix with
Row names:
Col names:

3017 rows and
id02336 ... id02732
rs91126 ... rs98918

43 columns

> head(pedData)

id02336
id00695
id02750
id01836
id02533
id01069

familyid member father mother sex affected
1
NA
1
NA
2
1
2
1
1
NA
1
NA

fam0005
fam0005
fam0005
fam0005
fam0006
fam0006

NA
NA
2
2
NA
NA

1
2
3
4
1
2

1
2
2
2
2
1

1These data are on a much smaller scale than would arise in genome-wide studies, but serve to illustrate

the available tools. Note, however, that execution speeds are quite adequate for genome-wide data.

1

The first family comprises four individuals: two parents and two sibling offspring. The
parents are “founders” in the pedigree, i.e. there is no data for their parents, so that their
father and mother identifiers are set to NA. This differs from the convention in the LINKAGE
package, which would code these as zero. Otherwise coding is as in LINKAGE: sex is coded
1 for male and 2 for female, and disease status (affected) is coded 1 for unaffected and 2
for affected.

Checking for mis-inheritances

The function misinherits counts non-Mendelian inheritances in the data.
It returns a
logical matrix with one row for each subject who has any mis-inheritances and one column
for each SNP which was ever mis-inherited.

> mis <- misinherits(data=pedData, snp.data=genotypes)
> dim(mis)

[1] 114

37

Thus, 114 of the subjects and 37 of the SNPs had at least one mis-inheritance. The follow-
ing commands count mis-inheritances per subject and plot its frequency distribution, and
similarly, for mis-inheritances per SNP:

> per.subj <- apply(mis, 1, sum, na.rm=TRUE)
> per.snp <- apply(mis, 2, sum, na.rm=TRUE)
> par(mfrow = c(1, 2))
> hist(per.subj,main='Histogram per Subject', xlab='Subject')
> hist(per.snp,main='Histogram per SNP', xlab='SNP')

2

Note that mis-inheritances must be ascribed to offspring, although the error may lie
with the parent data. The following commands first extract the pedigree identifiers for
mis-inheriting subjects and go on to chart the numbers of mis-inheritances per family:

> fam <- pedData[rownames(mis), "familyid"]
> per.fam <- tapply(per.subj, fam, sum)
> par(mfrow = c(1, 1))
> hist(per.fam, main='Histogram per Family', xlab='Family')

3

Histogram per SubjectSubjectFrequency2468020406080Histogram per SNPSNPFrequency0510150246810None of the above analyses suggest serious problems with the data, although there are clearly
a few genotyping errors.

TDT tests

At present, the package only allows testing of discrete disease phenotypes in case–parent trios
— basically the Transmission/Disequilibrium Test (TDT). This is carried out by the function
tdt.snp, which returns the same class of object as that returned by single.snp.tests;
allelic (1 df) and genotypic (2 df) tests are computed. The following commands compute

4

Histogram per FamilyFamilyFrequency246810120102030405060the tests, display the p-values, and plot quantile–quantile plots of the 1 df tests chi-squared
statistics:

> tests <- tdt.snp(data = pedData, snp.data = genotypes)

Analysing 1466 potentially complete trios in 733 different pedigrees

> cbind(p.values.1df = p.value(tests, 1),
p.values.2df = p.value(tests, 2))
+

rs91126
rs62927
rs79960
rs19348
rs99786
rs36984
rs52628
rs6699
rs12373
rs35215
rs41229
rs86267
rs23261
rs69208
rs16483
rs8558
rs55762
rs8124
rs72056
rs82369
rs97686
rs77065
rs53106
rs37378
rs83832
rs35431
rs61158
rs32410
rs85906
rs83977
rs24527
rs73721
rs36088

p.values.1df p.values.2df
1.385e-02
2.810e-01
1.506e-05
2.013e-01
2.713e-02
5.476e-03
2.469e-01
4.812e-05
5.772e-01
4.463e-01
3.931e-02
5.129e-04
5.535e-03
1.671e-01
8.925e-01
5.590e-01
1.913e-01
1.364e-01
7.391e-02
2.131e-01
8.410e-01
NA
5.387e-02
8.937e-03
8.936e-01
4.597e-01
5.050e-01
5.317e-02
4.759e-01
2.069e-01
3.894e-01
9.018e-03
3.061e-02

0.3034837
0.1113713
0.6942913
0.0895551
0.0072618
0.1434326
0.9178502
0.0001807
0.4590596
0.2115224
0.0159203
0.1344540
0.6174657
0.0854324
0.6603136
0.4961518
0.0689901
0.2336604
0.0298914
0.0813984
0.5612452
0.7236736
0.9586501
0.2194916
0.8755190
0.4226781
0.5343400
0.0387410
0.2319977
0.2807488
0.2963307
0.0729240
0.0324330

5

rs32998
rs5566
rs98256
rs29479
rs42938
rs32018
rs39483
rs42367
rs87640
rs98918

0.5571397
0.0672924
0.5858278
0.8193228
0.0611009
0.7280652
0.2304232
0.2674484
0.0223276
0.0581770

7.510e-01
3.919e-02
7.995e-01
2.904e-01
1.147e-05
4.997e-02
4.391e-03
2.496e-01
3.507e-02
2.983e-04

> qq.chisq(chi.squared(tests, 1), df = 1)

N omitted
0.000

43.000

lambda
3.401

6

Since these SNPs were all in a region of known association, the overdispersion of test statistics
is not surprising. Note that, because each family had two affected offspring, there were twice
as many parent-offspring trios as families. In the above tests, the contribution of the two
trios in each family to the test statistic have been assumed to be independent. When there
is linkage between the genetic locus and disease trait, this assumption is incorrect and an
alternative variance estimate can be used by specifying robust=TRUE in the call. However,
in practice, linkage is very rarely strong enough to require this correction.

7

01234502468101214QQ plotExpected distribution: chi−squared (1 df)ExpectedObserved