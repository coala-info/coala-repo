Algorithms and equations utilized in poppr version 2.9.8

Zhian N. Kamvar1 and Niklaus J. Gr¨unwald1,2
1) Department of Botany and Plant Pathology, Oregon State University, Corvallis, OR

2) Horticultural Crops Research Laboratory, USDA-ARS, Corvallis, OR

August 23, 2025

Abstract

This vignette is focused on simply explaining the different algorithms utilized in calculations such as
the index of association and different distance measures. Many of these are previously described in other
papers and it would be prudent to cite them properly if they are used.

1

Contents

1 Mathematical representation of data in adegenet and poppr

1.1 Caveat . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2 The Index of Association

3 Genetic distances

3.1 Distances that assume genetic drift . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.1.1 Nei’s 1978 Distance
3.1.2 Edwards’ angular distance . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.1.3 Reynolds’ coancestry distance . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.2 Distances without assumptions . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.2.1 Rogers’ distance . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.2.2 Prevosti’s absolute genetic distance . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . .
Special cases of Bruvo’s distance . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.4 Tree topology . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

3.3 Bruvo’s distance (stepwise mutation for microsatellites)

3.3.1
3.3.2 Choosing a model

4 AMOVA

5 Genotypic Diversity

5.1 Rarefaction, Shannon-Wiener, Stoddart and Taylor indices . . . . . . . . . . . . . . . . . . . .
5.2 Evenness (E5) . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
5.3 Hexp . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

6 Probability of Genotypes: pgen

7 Probability a genotype is derived from sexual reproduction: psex

2
2

3

5
5
5
5
6
6
6
6
6
7
7
8

9

10
10
10
10

10

11

1 Mathematical representation of data in adegenet and poppr

The sections dealing with the index of association and genetic distances will be based on the same data
structure, a matrix with samples in rows and alleles in columns. The number of columns is equal to the total
number of alleles observed in the data set. Much of this description is derived from adegenet’s dist.genpop
manual page.

1.1 Caveat

The information here describes the data as it would be passed into the distance functions. Data represented
in the genind objects are now counts of alleles instead of frequencies of alleles. Otherwise, these equations
still hold.

Let A be a table containing allelic frequencies with t samples1 (rows) and m alleles (columns).

The above statement describes the table present in genind or genpop object where, instead of having the
number of columns equal the number of loci, the number of columns equals the number of observed alleles
in the entire data set.

1populations or individuals

2

Let ν be the number of loci. The locus j gets m(j) alleles.

m =

ν
(cid:88)

j=1

m(j)

(1)

So, if you had a data set with 5 loci that had 2 alleles each, your table would have ten columns. Of

course, codominant loci like microsatellites have varying numbers of alleles.

For the row i and the modality k of the variable j, notice the value

aijk(1 ≤ i ≤ t, 1 ≤ j ≤ ν, 1 ≤ k ≤ m(j))

aij· =

m(j)
(cid:88)

k=1

aijk

pijk =

aijk
aij·

(2)

(3)

(4)

The above couple of equations are basically defining the allele counts (aijk) and frequency (pijk). Re-
member that i is individual, j is locus, and k is allele. The following continues to describe properties of the
frequency table used for analysis:

pij· =

m(j)
(cid:88)

k=1

pijk = 1

The sum of all allele frequencies for a single population (or individual) at a single locus is one.

The sum of all allele frequencies over all loci is equal to the number of loci.

pi·· =

ν
(cid:88)

j=1

pij· = ν

p··· =

ν
(cid:88)

j=1

pi·· = tν

(5)

(6)

(7)

The the sum of the entire table is the sum of all loci multiplied by the number of populations (or individuals).

2 The Index of Association

The index of association was originally developed by A.H.D. Brown analyzing population structure of wheat
and has been widely used as a tool to detect clonal reproduction within populations (Brown et al., 1980;
Smith et al., 1993). Populations whose members are undergoing sexual reproduction, whether it be selfing
or out-crossing, will produce gametes via meiosis, and thus have a chance to shuffle alleles in the next
generation. Populations whose members are undergoing clonal reproduction, however, generally do so via
mitosis.

The most likely mechanism for a change in genotype, for a clonal organism, is mutation. The rate of
mutation varies from species to species, but it is rarely sufficiently high to approximate a random shuffling

3

of alleles. The index of association is a calculation based on the ratio of the variance of the raw number of
differences between individuals and the sum of those variances over each locus (Smith et al., 1993). It can
also be thought of as the observed variance over the expected variance. If both variances are equal, then the
index is zero after subtracting one (from Maynard-Smith, 1993 (Smith et al., 1993)):

IA =

VO
VE

− 1

(8)

Any sort of marker can be used for this analysis as it only counts differences between pairs of samples. This
can be thought of as a distance whose maximum is equal to the number of loci multiplied by the ploidy of
the sample. This is calculated using an absolute genetic distance.

Remember that in poppr , genetic data is stored in a table where the rows represent samples and the
columns represent potential allelic states grouped by locus. Notice also that the sum of the rows all equal
one. Poppr uses this to calculate distances by simply taking the sum of the absolute values of the differences
between rows.

The calculation for the distance between two individuals at a single locus j with m(j) allelic states and

a ploidy of l is as follows2:

d(a, b) =

l
2

m(j)
(cid:88)

k=1

|pajk − pbjk|

(9)

To find the total number of differences between two individuals over all loci, you just take d over ν loci, a
value we’ll call D:

D(a, b) =

ν
(cid:88)

i=1

di

(10)

An interesting observation: D(a, b)/(lν) is Prevosti’s distance.

These values are calculated over all possible combinations of individuals in the data set, (cid:0)n

(cid:1) after which
(cid:1) values of D. Calculating the observed variances is fairly

you end up with (cid:0)n
straightforward (modified from Agapow and Burt, 2001) (Agapow & Burt, 2001):

(cid:1) · ν values of d and (cid:0)n

2

2

2






(n
2)
(cid:88)

Di


2




(n
2)
(cid:88)

i=1

D2

i −

VO =

i=1
(cid:0)n
2

(cid:1)

(cid:0)n
2

(cid:1)

(11)

Calculating the expected variance is the sum of each of the variances of the individual loci. The calculation
at a single locus, j is the same as the previous equation, substituting values of D for d (Agapow & Burt,
2001):

(n
2)
(cid:88)








2




di

(n
2)
(cid:88)

i=1

d2
i −

varj =

i=1
(cid:0)n
2

(cid:1)

(cid:0)n
2

(cid:1)

(12)

The expected variance is then the sum of all the variances over all ν loci (Agapow & Burt, 2001):

2Individuals with Presence / Absence data will have the l/2 term dropped.

4

VE =

ν
(cid:88)

j=1

varj

(13)

Now you can plug the sums of equations (11) and (13) into equation (8) to get the index of association.
Of course, Agapow and Burt showed that this index increases steadily with the number of loci, so they came
up with an approximation that is widely used, ¯rd (Agapow & Burt, 2001). For the derivation, see the manual
for multilocus. The equation is as follows, utilizing equations (11), (12), and (13) (Agapow & Burt, 2001):

¯rd =

ν
(cid:88)

2

VO − VE
ν
√
(cid:88)

varj · vark

j=1

k̸=j

(14)

3 Genetic distances

Genetic distances are great tools for analyzing diversity in populations as they are the basis for creating
dendrograms with bootstrap support and also for AMOVA. This section will simply present different genetic
distances along with a few notes about them. Most of these distances are derived from the ade4 and
adegenet packages, where they were implemented as distances between populations. Poppr extends the
implementation to individuals as well (with the exception of Bruvo’s distance).

Method
Prevosti

Nei

Edwards
Reynolds
Rogers
Bruvo

Table 1: Distance measures and their respective assumptions
Function
prevosti.dist
diss.dist
nei.dist

Euclidean Citation
No

Assumption
-

(Nei, 1972, 1978)

(Prevosti et al., 1975)

No

Infinite Alleles
Genetic Drift
Genetic Drift
edwards.dist
reynolds.dist Genetic Drift
rogers.dist
bruvo.dist

Yes
Yes
-
Yes
Stepwise Mutation No

(Edwards, 1971)
(Reynolds et al., 1983)
(Rogers, 1972)
(Bruvo et al., 2004)

3.1 Distances that assume genetic drift

3.1.1 Nei’s 1978 Distance

DN ei(a, b) = − ln





(cid:113)(cid:80)ν

k=1

(cid:80)ν

k=1

(cid:80)m(k)

j=1 pajkpbjk

(cid:80)m(k)

j=1 (pajk)2(cid:113)(cid:80)ν

k=1

(cid:80)m(k)

j=1 (pbjk)2





(15)

Note: if comparing individuals in poppr , those that do not share any alleles normally receive a distance
of ∞. As you cannot draw a dendrogram with infinite branch lengths, infinite values are converted to a
value that is equal to an order of magnitude greater than the largest finite value.

3.1.2 Edwards’ angular distance

DEdwards(a, b) =

(cid:118)
(cid:117)
(cid:117)
(cid:116)1 −

1
ν

ν
(cid:88)

m(k)
(cid:88)

√

k=1

j=1

pajkpbjk

(16)

5

3.1.3 Reynolds’ coancestry distance

DReynolds(a, b) =

(cid:118)
(cid:117)
(cid:117)
(cid:117)
(cid:116)

(cid:80)ν

k=1

2 (cid:80)ν

k=1

3.2 Distances without assumptions

3.2.1 Rogers’ distance

(cid:80)m(k)

j=1 (pajk − pbjk)2
1 − (cid:80)m(k)
j=1 pajkpbjk

(cid:16)

DRogers(a, b) =

1
ν

ν
(cid:88)

k=1

(cid:118)
(cid:117)
(cid:117)
(cid:116)

1
2

m(k)
(cid:88)

j=1

(pajk − pbjk)2

3.2.2 Prevosti’s absolute genetic distance

DP revosti(a, b) =

1
2ν

ν
(cid:88)

m(k)
(cid:88)

k=1

j=1

|pajk − pbjk|

Note: for AFLP data, the 2 is dropped.

(cid:17)

(17)

(18)

(19)

3.3 Bruvo’s distance (stepwise mutation for microsatellites)

Bruvo’s distance between two individuals calculates the minimum distance across all combinations of possible
pairs of alleles at a single locus and then averaging that distance across all loci (Bruvo et al., 2004). The
distance between each pair of alleles is calculated as3(Bruvo et al., 2004):

mx = 2−|x|

da = 1 − mx

(20)

(21)

Where x is the number of steps between each allele. So, let’s say we were comparing two haploid (k = 1)
individuals with alleles 228 and 244 at a locus that had a tetranucleotide repeat pattern (CATG)n. The
number of steps for each of these alleles would be 228/4 = 57 and 244/4 = 61, respectively. The number
of steps between them is then | 57 − 61 |= 4. Bruvo’s distance at this locus between these two individuals
is then 1 − 2−4 = 0.9375. For samples with higher ploidy (k), there would be k such distances of which we
would need to take the sum (Bruvo et al., 2004).

si =

k
(cid:88)

a=1

da

(22)

Unfortunately, it’s not as simple as that since we do not assume to know phase. Because of this, we need
to take all possible combinations of alleles into account. This means that we will have k2 values of da, when
we only want k. How do we know which k distances we want? We will have to invoke parsimony for this
and attempt to take the minimum sum of the alleles, of which there are k! possibilities (Bruvo et al., 2004):

dl =

(cid:18)

(cid:19)

min
i...k!

si

1
k

(23)

Finally, after all of this, we can get the average distance over all loci (Bruvo et al., 2004).

3Notation presented unmodified from Bruvo et al, 2004

6

D =

1
l

l
(cid:88)

i=1

di

(24)

This is calculated over all possible combinations of individuals and results in a lower triangle distance matrix
over all individuals.

3.3.1 Special cases of Bruvo’s distance

As shown in the above section, ploidy is irrelevant with respect to calculation of Bruvo’s distance. However,
since it makes a comparison between all alleles at a locus, it only makes sense that the two loci need to have
the same ploidy level. Unfortunately for polyploids, it’s often difficult to fully separate distinct alleles at
each locus, so you end up with genotypes that appear to have a lower ploidy level than the organism (Bruvo
et al., 2004).

To help deal with these situations, Bruvo has suggested three methods for dealing with these differences

in ploidy levels (Bruvo et al., 2004):

(cid:136) Infinite Model - The simplest way to deal with it is to count all missing alleles as infinitely large so
that the distance between it and anything else is 1. Aside from this being computationally simple, it
will tend to inflate distances between individuals.

(cid:136) Genome Addition Model - If it is suspected that the organism has gone through a recent genome
expansion, the missing alleles will be replace with all possible combinations of the observed alleles in
the shorter genotype. For example, if there is a genotype of [69, 70, 0, 0] where 0 is a missing allele,
the possible combinations are: [69, 70, 69, 69], [69, 70, 69, 70], [69, 70, 70, 69], and [69, 70, 70, 70].
The resulting distances are then averaged over the number of comparisons.

(cid:136) Genome Loss Model - This is similar to the genome addition model, except that it assumes that there
was a recent genome reduction event and uses the observed values in the full genotype to fill the
missing values in the short genotype. As with the Genome Addition Model, the resulting distances are
averaged over the number of comparisons.

(cid:136) Combination Model - Combine and average the genome addition and loss models.

As mentioned above, the infinite model is biased, but it is not nearly as computationally intensive as either
of the other models. The reason for this is that both of the addition and loss models requires replacement
of alleles and recalculation of Bruvo’s distance. The number of replacements required is nk where n is the
number of potential replacements and k is the number of alleles to be replaced.

To reduce the number of calculations and assumptions otherwise, Bruvo’s distance will be calculated
using the largest observed ploidy in pairwise comparisons. This means that when comparing [69,70,71,0] and
[59,60,0,0], they will be treated as triploids.

3.3.2 Choosing a model

By default, the implementation of Bruvo’s distance in poppr will utilize the combination model. This is
implemented by setting both the add and loss arguments to TRUE. For other models use the following table
for reference:

Model
Infinite
Genome Addition
Genome Loss
Combination (default)

Arguments
add = FALSE, loss = FALSE
add = TRUE, loss = FALSE
add = FALSE, loss = TRUE
add = TRUE, loss = TRUE

7

3.4 Tree topology

All of these distances were designed for analysis of populations. When applying them to individuals, we
must change our interpretations. For example, with Nei’s distance, branch lengths increase linearly with
mutation (Nei, 1972, 1978). When two populations share no alleles, then the distance becomes infinite.
However, we expect two individuals to segregate for different alleles more often than entire populations, thus
we would expect exaggerated internal branch lengths separating clades. To demonstrate the effect of the
different distances on tree topology, we will use 5 diploid samples at a single locus demonstrating a range of
possibilities:

Genotype
1/1
1/2
2/3
3/4
4/4

Table 2: Table of genotypes to be used for analysis

library("poppr")
dat.df <- data.frame(Genotype = c("1/1", "1/2", "2/3", "3/4", "4/4"))
dat <- as.genclone(df2genind(dat.df, sep = "/", ind.names = dat.df[[1]]))

We will now compute the distances and construct neighbor-joining dendrograms using the package ape.

This allows us to see the effect of the different distance measures on the tree topology.

distances <- c("Nei", "Rogers", "Edwards", "Reynolds", "Prevosti")
dists <- lapply(distances, function(x){

DISTFUN <- match.fun(paste(tolower(x), "dist", sep = "."))
DISTFUN(dat)

})
names(dists) <- distances

# Adding Bruvo's distance at the end because we need to specify repeat length.
dists$Bruvo <- bruvo.dist(dat, replen = 1)
library("ape")
par(mfrow = c(2, 3))
x <- lapply(names(dists), function(x){

plot(nj(dists[[x]]), main = x, type = "unrooted")
add.scale.bar(lcol = "red", length = 0.1)

})

8

4 AMOVA

AMOVA in poppr acts as a wrapper for the ade4 implementation, which is an implementation of Excoffier’s
original formulation (Excoffier et al., 1992). As the calculation relies on a genetic distance matrix, poppr
calculates the distance matrix as the number of differing sites between two genotypes using equation 10. This
is equivalent to Prevosti’s distance multiplied by the ploidy and number of loci. This is also equivalent to
Kronecker’s delta as presented in (Excoffier et al., 1992). As is the practice from Arlequin, within sample
variance is calculated by default. Within sample variance can only be calculated on diploid data.

9

Nei1/11/22/33/44/40.1Rogers1/11/22/33/44/40.1Edwards1/11/22/33/44/40.1Reynolds1/11/22/33/44/40.1Prevosti1/11/22/33/44/40.1Bruvo1/11/22/33/44/40.15 Genotypic Diversity

Many of the calculations of genotypic diversity exist within the package vegan in the diversity function.
Descriptions of most calculations can be found in the paper by Gr¨unwald et al. (2003).

5.1 Rarefaction, Shannon-Wiener, Stoddart and Taylor indices

Stoddart and Taylor’s index is also known as Inverse Simpson’s index. A detailed description of these can
be found in the “Diversity” vignette in vegan. You can access it by typing vignette("diversity-vegan")

5.2 Evenness (E5)

Evenness (E5) is essentially the ratio of the number of abundant genotypes to the number of rarer genotypes.
For the function locus table, these indices represent the abundance of alleles.

This is simply calculated as

E5 =

(1/λ) − 1
eH − 1

(25)

Where 1/λ is Stoddart and Taylor’s index and H is Shannon diversity (Stoddart & Taylor, 1988; Shannon,
1948). The reason for this formulation is because 1/λ is weighted for more abundant genotypes and H is
weighted for rarer genotypes.

5.3 Hexp

Hexp stands for Nei’s 1978 expected heterozygosity, also known as gene diversity (Nei, 1978). Previously, in
poppr , it was calculated over multilocus genotypes, which was more analogous to a correction for Simpson’s
index. This has been corrected in version 2.0 and is now correctly calculated over alleles. The following is
adapted from equations 2 and 3 in (Nei, 1978):

h =

(cid:18) n

(cid:19)

n − 1

1 −

k
(cid:88)

i=1

p2
i

Hexp =

m
(cid:88)

hl/m

(26)

(27)

l=1
where pi is the population frequency of the ith allele in a locus, k is the number of alleles in a particular
locus, n represents the number of observed alleles in the population, and hl is the value of h at the lth
locus.

Nei’s definition originally corrected the sum of squared allele frequencies with 2N/(2N − 1), where N
is the number of diploid samples (Nei, 1978). This definition is still congruent with that since we would
observe 2N alleles in a diploid locus. The only caveat is that populations where allelic dosage is unknown
will have an inflated estimate of allelic diversity due to the inflation of rare alleles.

6 Probability of Genotypes: pgen

The metric pgen represents the probability that a given multilocus genotype will occur in a population (Parks
& Werth, 1993; Arnaud-Haond et al., 2007). For ν loci, it is calculated as:

h =

(cid:40)

1 if heterozygous,
0 if homozygous or haploid

(28)

10

pgen =


2h

ν
(cid:89)

j=1

m(j)
(cid:89)

i=1



pij



(29)

where pij represents the allele frequency of the ith allele present in the sample at the jth locus derived
using the round-robin method (Parks & Werth, 1993; Arnaud-Haond et al., 2007). The round-robin allele
frequencies for a given locus are derived by first clone-correcting with the genotypes found at all other loci
(Parks & Werth, 1993; Arnaud-Haond et al., 2007). Any allele that ends up with a zero frequency are
assigned a value of 1/N , where N is the number of samples.

7 Probability a genotype is derived from sexual reproduction: psex

The probability of a genotype can provide information as to how many times we expect to see that genotype
repeated in our population. Parks & Werth (1993) defined the probability of encountering a genotype a
second time from an independent reproductive event as:

Where G is the number of multilocus genotypes in the data. Finding a genotype n times out of N samples

is derived from the binomial distribution (Parks & Werth, 1993; Arnaud-Haond et al., 2007):

psex = 1 − (1 − pgen)G

(30)

psex =

(cid:19)

N
(cid:88)

i=n

(cid:18)N
i

(pgen)i (1 − pgen)N −i

(31)

The poppr function psex() can calculate both of these quantities.

References

Agapow, Paul-Michael, & Burt, Austin. 2001. Indices of multilocus linkage disequilibrium. Molecular Ecology

Notes, 1(1-2), 101–102.

Arnaud-Haond, Sophie, Duarte, Carlos M, Alberto, Filipe, & Serr˜ao, Ester A. 2007. Standardizing methods

to address clonality in population studies. Molecular Ecology, 16(24), 5115–5139.

Brown, A.H.D., Feldman, M.W., & Nevo, E. 1980. MULTILOCUS STRUCTURE OF NATURAL POPU-

LATIONS OF Hordeum spontaneum. Genetics, 96(2), 523–536.

Bruvo, Ruzica, Michiels, Nicolaas K., D’Souza, Thomas G., & Schulenburg, Hinrich. 2004. A simple method
for the calculation of microsatellite genotype distances irrespective of ploidy level. Molecular Ecology,
13(7), 2101–2106.

Edwards, AWF. 1971. Distances between populations on the basis of gene frequencies. Biometrics, 873–881.

Excoffier, L, Smouse, PE, & Quattro, JM. 1992. Analysis of molecular variance inferred from metric distances
among DNA haplotypes: application to human mitochondrial DNA restriction data. Genetics, 131(2),
479–491.

Gr¨unwald, Niklaus J., Goodwin, Stephen B., Milgroom, Michael G., & Fry, William E. 2003. Analysis of

genotypic diversity data for populations of microorganisms. Phytopathology, 93(6), 738–46.

Nei, Masatoshi. 1972. Genetic distance between populations. American naturalist, 283–292.

Nei, Masatoshi. 1978. Estimation of average heterozygosity and genetic distance from a small number of

individuals. Genetics, 89(3), 583–590.

11

Parks, James C, & Werth, Charles R. 1993. A study of spatial features of clones in a population of bracken

fern, Pteridium aquilinum (Dennstaedtiaceae). American Journal of Botany, 537–544.

Prevosti, Antoni, Oca˜na, Jy, & Alonso, G. 1975. Distances between populations of Drosophila subobscura,

based on chromosome arrangement frequencies. Theoretical and Applied Genetics, 45(6), 231–241.

Reynolds, John, Weir, Bruce S, & Cockerham, C Clark. 1983. Estimation of the coancestry coefficient: basis

for a short-term genetic distance. Genetics, 105(3), 767–779.

Rogers, J S. 1972. Measures of genetic similarity and genetic distances. Pages 145–153 of: Studies in

Genetics. University of Texas Publishers.

Shannon, Claude Elwood. 1948. A mathematical theory of communication. Bell Systems Technical Journal,

27, 379–423,623–656.

Smith, J M, Smith, N H, O’Rourke, M, & Spratt, B G. 1993. How clonal are bacteria? Proceedings of the

National Academy of Sciences, 90(10), 4384–4388.

Stoddart, J.A., & Taylor, J.F. 1988. Genotypic diversity: estimation and prediction in samples. Genetics,

118(4), 705–11.

12

