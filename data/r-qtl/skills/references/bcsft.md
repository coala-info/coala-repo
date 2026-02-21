Users Guide for New BCsFt Tools for R/qtl

Laura M. Shannon

Brian S. Yandell

Karl Broman

29 January 2013

Introduction

Historically QTL mapping studies have employed a variety of crossing schemes includ-
ing: backcrosses [1], sib-mating [2], selﬁng [3], RI lines [4], and generations of random
mating within mapping populations [5]. Diﬀerent cross designs oﬀer diﬀerent advantages.
Backcrossing allows for the isolation of limited regions of the donor parent genome in an
otherwise recurrent parent background. Selﬁng and sib-mating in an intercross provide
the opportunity to examine all genotype combinations and observe dominance. RI lines
allow for multiple phenotype measures on a single line. Random mating increases recom-
bination frequency. In order to use a combination of these cross types and access their
various beneﬁts, a more ﬂexible analysis approach is needed.

This guide develops methods to analyze advanced backcrosses and lines created by re-
peated selﬁng by extending features of R/qtl [6]. Interval mapping requires estimating
the probable genotype of a putative QTL based on the neighboring markers [7]. The
probability that a loci between two genotyped markers is of a given genotype depends
on the recombination history of the population, which depends on the type of cross. In
Figure 1 we have two markers, A and B, each with two possible allele genotypes, capital
or lower case. Let us assume that markers A and B are spaced such that double crossovers
in a single generation are unlikely. Let Q be the position of the putative QTL between A
and B. When the observed genotypes at A and B are both homozygous capital in an F2
or BC1 the genotype at Q is most likely homozygous capital (Figure 1 part B). However,
in an F3, Q might be heterozygous or homozygous for either parent (Figure 1 part C).
Similarly, in a BC2, Q might be homozygous capital or heterozygous, when the observered
genotype is AB/AB. Each generation brings an additional opportunity for crossing over

1

B.

P1

Observed Genotype

A.

A

A

?

B

B

Recombination history of an F2 or BC1

A

A

B

B

A

a

a

a

B

b

x

A

A

b

b

F1

B

B

F2

BC1

A

A

B

B

QQ
0 crossovers

QQ
0 crossovers

C.

F2

F3

A

A

A

A

Recombination history of an F3

F1

A

a

A

A

A

a

B

b

B

B

B

b

A

a

A

A

B

B

B

B

b

B

B

B

A

a

A

A

B

B

B

B

QQ
0 crossovers

QQ
0 crossovers

QQ or Qq or qq
4 crossovers

QQ or Qq or qq
1 crossover

D. Recombination history of a BC2

A

A

F3

B

B

A

A

BC1
x

A

A

B

B

QQ
0 crossovers

B

B

A

a

B

B

A

A

B

b

A

B

B

A
QQ or Qq
1 crossover

A

A

B

B

QQ or Qq
1 crossover

A

a

A

A

B

b

B

B

QQ
0 crossovers

Figure 1: An illustration of QTL geneotype inference in populations created through
diﬀerent crossing structures. All images are of a chromosome section including 2 markers
(A and B) and a putative QTL (Q). Chromosomal segments are pink when they share
a genotype with the lower case parent and black when they share a genotype with the
capital parent. Regions where the genotype cannot be observed are dashed. Regions
where the genotype is unknown are gray.

2

recombination frequency = 0.5

recombination frequency = 0.1

recombination frequency = 0.01

0.9
0.8
0.7

0.6
0.5
0.4

0.3
0.2
0.1

s
e
i
t
i
l
i

b
a
b
o
r
P
e
p
y
t
o
n
e
G

0
BC1

0.9
0.8
0.7

0.6
0.5
0.4

0.3
0.2
0.1

0

BC2

BC2F1 BC2F2 BC2F3

BC1

BC2

BC2F1 BC2F2 BC2F3

0.9
0.8
0.7

0.6
0.5
0.4

0.3
0.2

0.1

0

BC1

BC2

BC2F1 BC2F2 BC2F3

AQ/AQ

AQ/aQ or AQ/Aq

aQ/aQ or Aq/Aq

AQ/aq

Aq/aQ

aq/aQ or aq/Aq

aq/aq

Figure 2: The probability that a pair of loci is of a given genotype based on the transition
probabilities from the known genotype of marker one (As) to the unknown genotype of
the putative QTL (Bs).

within the interval, increasing the likelihood that Q will not share a genotype with A and
B. This has real consequences when determining genotype probabilities (Figure 2).

Genetic map creation is also based on recombination history. Assuming an F2 or BC1
and suﬃciently close markers to make double crossovers in a single generation improbable,
individuals which are homozygous for the recurrent parent allele at two adjacent markers
exhibit no recombination events between those two markers (ﬁgure 1 part B). However,
in an F3 the state of being homozygous for the recurrent parent allele at neighboring
markers can be accomplished with 0, 1, or 4 recombination events (ﬁgure 1 part C). If an
F3 is treated as an F2, an individual with 2 adjacent markers homozygous for the same
parent will be counted as having undergone 0 recombination events. However, the actual
expected number of recombination events for the described individual is:

r4 +

r(1 − r)
8

≈ r/8 ,

where r is the recombination frequency.

Therefore, treating an F3 as an F2 would artiﬁcially shorten the map length (Figure 3).
The number of recombination events between two markers depends on the recombina-
tion frequency and cross history, and the number of recombination events in agregate
determines the map length.

In this guide we present our method for analyzing mapping populations with advanced
cross histories while avoiding the pitfalls described above. Speciﬁcally, we address popula-
tions resulting from repeated backcrossing (BCs), repeated selﬁng (Ft), and backcrossing

3

recombination frequency = 0.5

recombination frequency = 0.1

recombination frequency = 0.01

0.45
0.40

0.35
0.30
0.25

0.20
0.15
0.10
0.05

t
n
u
o
C
n
o
i
t
a
n
b
m
o
c
e
R

i

0.12

0.10

0.08

0.06

0.04

0.02

0.012

0.010

0.008

0.006

0.004

0.002

0
BC1

BC2

BC2S1 BC2F2 BC2F3

0
BC1

BC2

BC2F1 BC2F2 BC2F3

0

BC1

BC2

BC2F1 BC2F2 BC2F3

AB/AB

AB/aB or AB/Ab

aB/aB or Ab/Ab

AB/ab

Ab/aB

ab/aB or ab/Ab

ab/ab

Figure 3: Estimated recombination counts between pairs of markers with observed geno-
types.

followed by selﬁng (BCsFt). The ﬁrst section is a tutorial on how to use the new tools.
The second section lays out the way we derived the equations for probabilities and re-
combination counts, which allow for the analysis of advanced cross histories. The third
section contains a technical description of the modiﬁcations to the code of the previous
release of R/qtl [6].

Tutorial

These changes to R/qtl are mostly internal. The one thing that does change for the user
is reading in the data. Data can be read in using read.cross() as for all other crosses. We
will use the listeria sample data from R/qtl below.

> library(qtl)
> listeria.bc2s3<-read.cross(format="csv",
+
+

BC.gen=2, F.gen=3)

file=system.file(file.path("sampledata", "listeria.csv"), package = "qtl"),

--Read the following data:

120
133
1

individuals
markers
phenotypes

--Cross type: bcsft

4

Here’s another way to convert a cross. Suppose the R/qtl hyper data was really a BC3
(or BC3F0). You can convert it as follows:

> data(hyper)
> hyper3 <- convert2bcsft(hyper, BC.gen = 3)

--Estimating genetic map

We will brieﬂy highlight the diﬀerence in results between crosses analyzed using the tra-
ditional program and those analyzed using our new tools. However, we do not discuss the
entire process of QTL mapping. Please refer to the tutorials available through rqtl.org
or A Guide to QTL Mapping with R/qtl by Karl Broman [8] for guidence on complete
analysis.

First we compare the maps for the listeria data set (ﬁgure 4).

> listeria.f2<-read.cross(format="csv",
+

file=system.file(file.path("sampledata", "listeria.csv"), package = "qtl"))

--Read the following data:

120
133
1
--Cross type: f2

individuals
markers
phenotypes

> map.bc2s3 <- est.map(listeria.bc2s3)
> map.f2<-est.map(listeria.f2)

Now, we will compare the maps for the hyper data (ﬁgure 5).

> map.bc1 <- est.map(hyper)
> map.bc3<-est.map(hyper3)

5

> plot(map.f2, map.bc2s3, label=FALSE, main="")

0
20
40
60
80
100

)

M
c
(

n
o
i
t
a
c
o
L

1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 X

Chromosome

Figure 4: A comaprison of genetic maps of the listeria data set analyzed as though it were
a F2 (left) and as though it were a BC2F3 (right).

> plot(map.bc1, map.bc3, label=FALSE, main="")

)

M
c
(

n
o
i
t
a
c
o
L

0
20
40
60
80
100
120

1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 X

Chromosome

Figure 5: A comparison of genetic maps of the hyper data set analyzed as though it were
a BC1 (left) and as though it were a BC3(right).

6

> plot(one.f2, one.bc2s3, col=c("red", "purple"))

d
o

l

20
15
10
5
0

1

2

3

4 5 6 7 8 9 10 11 12 13141516171819 X

Chromosome

Figure 6: LOD plots for simple interval mapping with the listeria data set. The red
curves are from analysis as though the population were a F2. The purple curves are from
analysis as though the population were a BC2F3. Both were analyzed using the same
map distances to facilitate comparison

In both cases the map length is smaller when the cross is analyzed as a BCsFt because
the same number of recombination events are attributed to multiple generations.
In
order to demonstrate that the cross history makes a real diﬀerence in outcome of a QTL
analysis, we asign the same map to both cross objects regardless of cross history for
direct comparisson. Comparing identical data sets with identical maps using the scanone
command illustraits that position-wise LOD score also depends on cross history (ﬁgures
6 and 7) .

> listeria.bc2s3<-replace.map(listeria.bc2s3, map.f2)
> listeria.f2<-replace.map(listeria.f2, map.f2)
> listeria.f2<-calc.genoprob(listeria.f2, step=1 )
> one.f2<-scanone(listeria.f2, method="em",pheno.col=1)
> listeria.bc2s3<-calc.genoprob(listeria.bc2s3, step=1 )
> one.bc2s3<-scanone(listeria.bc2s3, method="em",pheno.col=1)

> hyper3<-replace.map(hyper3, map.bc1)
> hyper<-replace.map(hyper, map.bc1)
> hyper<-calc.genoprob(hyper, step=1 )

7

> plot(one.hyp, one.hyp3, col=c("red", "purple"))

d
o

l

8

6

4

2

0

1

2

3 4 5

6 7 8 9 10 11 12 13 1415 16 17 1819 X

Chromosome

Figure 7: LOD plots for simple interval mapping with the hyper data set. The red curves
are from analysis as though the population were a BC1. The purple curves are from
analysis as though the population were a BC3. Both were analyzed using the same map
distances to facilitate comparison

> one.hyp<-scanone(hyper, method="em",pheno.col=1)
> hyper3<-calc.genoprob(hyper3, step=1 )
> one.hyp3<-scanone(hyper3, method="em",pheno.col=1)

Calculations

Allowing for the analysis of BCSFT crosses in R/qtl required two new sets of calculations:
genotype probabilities for diﬀerent cross histories and recombination counts for these
cross histories. The genotype probabilities were derived based on Jiang and Zeng’s [9]
calculations and the recombination counts are estimated using a golden section search.

Genotype Probabilities

Jiang and Zeng [9] provide a guide for calculating genotype frequencies resulting from
several types of crosses of inbred lines. Although they examine many cases (F2, selfed Ft,

8

random mating Ft, backcross from selfed Ft, and BCs) they do not address all possible
cross structures. Most notably, they do not discuss BCsFt crosses. In this section we
derive the equations for calculating genotype probabilities for a BCsFt cross. The equa-
tions we arrived at are heavily based on those of Jiang and Zeng. However they have
been modiﬁed both to address BCsFt cross histories and to function within the context
of the existing R/qtl program. We include all the implemented equations, both new and
modiﬁed, below.

QTL mapping requires estimating the putative QTL genotype based on the observed
genotypes of ﬂanking markers. In all cases there are 2 parental inbred lines. Line 1 will
be indicated by capital letters, while line 2 will be indicated by lower case letters. A
particular descendant of these lines has a known genotype at locus A (indicated with A
or a), however the genotype at locus B (indicated with B or b), the putative QTL, has
not been observed. The genotype at locus B is dependent on the genotype at locus A,
the recombination rate between locus A and locus B (r), and the cross history.

Backcross BCS

The simplest case is a BC1 with line 1 as the reccurrent parent. Let q be a vector of the
frequency of all possible genotypes of loci A and B

q =

(cid:2)

f req( AB

AB ) f req( Ab

AB ) f req( aB

AB ) f req( ab
AB )

=

w
2

r
2

r
2

w
2

(cid:3)

(cid:2)

(cid:3)

where w = 1 − r.

After a subsequent generation of backcrossing the genotype frequencies will change based
on the probability that a pair of loci with a particular genotype will produce oﬀspring of
each genotype when backcrossed to the recurrent parent. We will call this the transition
probability. In order to calculate q for a BC2 we will need transition probabilities for all
possible genotype combinations. Let M be the matrix of transition probabilities.

M =

P

P

P

P

(cid:0)

(cid:0)

(cid:0)

(cid:0)









AB

AB

AB

AB

AB | AB
Ab | AB
aB | AB
ab | AB

AB

AB

AB

AB

P

P

P

P

(cid:0)

(cid:0)

(cid:0)

(cid:0)

(cid:1)

(cid:1)

(cid:1)

(cid:1)

Ab

AB

AB | AB
( AB
Ab | AB
(cid:1)
Ab
aB | AB
AB
ab | AB

AB

Ab

Ab

(cid:1)

(cid:1)

(cid:1)

aB

aB

AB

AB

AB | AB
Ab | AB
aB | AB
ab | AB

AB

AB

aB

aB

P

P

P

P

(cid:0)

(cid:0)

(cid:0)

(cid:0)

P

P

P

P

(cid:0)

(cid:0)

(cid:0)

(cid:0)

(cid:1)

(cid:1)

(cid:1)

(cid:1)

9

ab

ab

AB

AB

AB | AB
Ab | AB
aB | AB
ab | AB

AB

AB

ab

ab

w
2
0

0

0

r
r
2
2
1
2 0
0 1
2
0 0

w
2
1
2
1
2
1

















(cid:1)

(cid:1)

(cid:1)

(cid:1)

=









The frequency vector from the BC1 can then be multiplied by the transition matrix to
arrive at a frequency vector for a BC2:

qBC2 = qM .

With each subsequent generation of backcrossing it is necessary to multiply by the transtion
matrix again. The equation for determining genotype frequencies based on any number
of backcross generations (s) is:

qBCs = qM s−1 .

This can be further simpliﬁed [10]. P (s, 0) is a set of probabilities for all genotype combi-
nations at two loci in a BCs population. It is equivalent to qBCs, but organized diﬀerently
to make it easier to read.

BB Bb

P (s, 0) =

AA A11 A12

Aa A12 A22

A11 = A12 =

w
2

A12 =

r
2

When s = 1

For any value of s

A11 =

A12 =

2s − 2 + ws
2s
1 − ws
2s
ws
2s

A22 =

10

Note the symmetry on the diagonal of recombinant alleles (Ab/AB and aB/AB) but not
on the diagonal with only non-recombinant alleles (AB/AB and ab/AB). This asymmetry
is due to the fact that ab alleles are only introduced in the F1 and therefore all such alleles
remaining in the population have never recombined where as AB alleles are introduced
every generation. Genotype frequencies can be calculated for all types of crosses using a
vector of initial frequencies and a transition matrix.

Repeated Selﬁng Ft

Next, we will discuss the calculations for genotype frequencies from an Ft population
resulting from repeated selﬁng. This crossing structure is also sometimes refered to as
an St, but we are using Ft to be consistant with the notation used by R/qtl. The major
diﬀerence between the calculations for an Ft and a BCs is that while in a backcross
one allele is always AB, so there are only 4 genotype possibilities, in an Ft there are 10
genotype possibilities.

qF1 =

AB
AB

AB
Ab

Ab
Ab

AB
aB

AB
ab

Ab
aB

Ab
ab

aB
aB

aB
ab

ab
ab

=

0 0 0 0 1 0 0 0 0 0

(cid:2)

(cid:3)

(cid:2)

(cid:3)

The transition matrix for an Ft is the same as Jiang and Zeng [9]:

N =

1
1
4
0
1
4
w2
4
r2
4
0

0

0

0


























0
1
2
0

0

rw
2

rw
2
0

0

0

0

0
1
4
1

0
r2
4
w2
4
1
4
0

0

0

0

0

0
1
2

rw
2

rw
2
0

0

0

0

0

0

0

0
w2
2
r2
2
0

0

0

0

0

0

0

0
r2
2
w2
2
0

0

0

0

0

0

0

0

rw
2

rw
2
1
2
0

0

0

0

0

0
1
4
r2
4
w2
4
0

1
1
4
0

0

0

0

0

rw
2

rw
2
0

0
1
2
0

0

0

0

0
w2
4
r2
4
1
4
0
1
4
1


























Again, these can be multiplied to arrive at the probability of all genotypes in the Ft.

11

qFt = qF1N t−1

This can be simpliﬁed. P (0, t) contains the probabilities for all genotype combinations
for two loci in an Ft population (once again it is equivalent to qFt reorganizes).

BB Bb

bB bb

AA B11 B12 B12 B14

P (0, t) =

Aa B12 B22 B23 B12

aA B12 B23 B22 B12

aa B14 B12 B12 B11

The probabilities Bij of ending up in a particular genotype after t generations can be
modeled in terms of generations spent in the double heterozygous stage (at least 1, as
F1 is a double heterozygote), the probability of moving from that genotype to either one
of the intermediate stages or to a double homozygote, the time spent at an intermediate
stage (could be 0), and the probability of moving from an intermediate stage to a double
homozygote. There are four transient states (double heterozygotes), 8 intermediate states
(single heterozygotes) and 4 absorbing states (double heterozygotes).

The only genotypes which can produce all other genotypes are the transient double het-
erozygotes (B22 and B23). Therefore with each generation there is an exponential decay
in the probability of remaining in the double heterozygous state. In order to remain in
the double heterozygous state there either has to be no recombination (w2) or a double
recombination event (r2) in every generation. In order to model this we reparameterize
w2 and r2 as β and γ, speciﬁcally β + γ = w2 while β − γ = r2. β is also the probability
of remaining in a double heterozygous state given that the line started in one of the two
double heterozygous states in a single generation.

B22 =

B23 =

β =

γ =

βt−1 + γt−1
2
βt−1 − γt−1
2
w2 + r2
2
w2 − r2
2

12

The 8 intermediate states, with one locus homozygous and one heterozygous. During
one of the previous generations, one locus was ﬁxed while the other remained heterozy-
gous. There are two exponential decays, with the transition point unknown. After some
simpliﬁcation, this can be expressed asB12:

B12 =

rw

1

2t−1 − βt−1
1 − 2β

(cid:1)

(cid:0)

Finally, the four absorbing states, heterozygous at both loci, can be reached from a number
of paths, involving simultaneous or separate ﬁxation of both loci. The calculations are
more involved, but simplify ty B11 or B14:

w2 (g (β, t) + g (γ, t)) + r2 (g (β, t) − g (γ, t))

+

rw
5

[g (β, t) + g (2β, t − 1)]

B14 = f (r, w)

(cid:3)

B11 = f (w, r) =

1
8

(cid:2)

With:

g (β, t) = (1 − βt−1)/(1 − β) .

Unlike P(s,0), P(0,t) is symmetric on both diagonals because both parental alleles are
equally present in the F1 and never introgressed again.

One major diﬀerence between working with a backcross and an Ft is that while in a
backcross phase is always known, in an Ft phase cannot be observed. When dealing with
phase unknown data the two heterozygote cases can be collapsed as follows:

BB

AA B11

Bb

2B12

bb

B14

Aa 2B12 2 (B22 + B23) 2B12

aa B14

2B12

B11

Since we cannot distinguish between the two heterozygote classes we add them and report
the frequency of both.

13

The ﬁnal diﬀerence between backcross and Ft calculations is that for Ft populations it is
possible to have partially informative markers. Partially informative markers can only be
interpreted as not belonging to a particular homozygous class. For instance if a marker
were measured using the presence or absence of a band on a gel, heterozygotes would be
indistinguishable from the homozygous present class. We will refer to partially informative
markers as either "not AA" or "not aa". In order to calculate the probability of partially
informative markers we add the probabilities of the genotypes we cannot distinguish
between, much like the phase unknown case above. For example, not AA/BB could be
Aa/BB, aA/BB, or aa/BB so we sum all of those probabilties to get 2B12 + B14. All
other genotypes with partially informative markers can be calculated similarly.

Backcrossing followed by selﬁng BCsFt

The described equations for the BCs and the Ft form the basis for the BCsFt. The two
types of crosses can be thought of sequentially. The BCs that forms the ﬁrst steps of the
BCSFt is exactly the same as the BCS on it’s own. The diﬀerence between calculating
an Ft which follows several genetations of backcrossing and one which follows an F1 is
the vector of starting genotype frequencies. In this case the starting genotype frequencies
can be supplied by qBCS = qM s−1. The six genotypes not represented all have starting
frequency 0.

qBCS F0 =

2s−2+ws
2s

1−ws
2s

0 1−ws
2s

ws
2s

0 0 0 0 0

(cid:2)

(cid:3)

The q resulting from this modiﬁcation of qBCS can be multiplied by the Ft transition
matrix. Much like in the previous cases this can be simpliﬁed. P (s, t) contains the proba-
bilities of all possible genotype combinations at two loci for a BCsFt. Below, we explicitly
identify the parts of the equations from the backcross (A) and selﬁng (B) probablities.

BB Bb

bB bb

AA C11 C12 C12 C14

P (s, t) =

Aa C12 C22 C23 C24

aA C12 C23 C22 C24

aa C14 C24 C24 C44

Where:

14

C22 = A22(s)B22(t)

C23 = A22(s)B23(t)

C12 = A22(s)B12(t) + A12(s)

C24 = A22(s)B12(t)

(cid:18)

t

(cid:19)

1
2

t

C11 = A22(s)B11(t) + A12(s)

1 −

1
2

(cid:18)

+ A11(s)

!

(cid:19)

C14 = A22(s)B11(t) + A12(s)

1 −

C44 = A22(s)B11(t)

1
2

(cid:18)

t

!

(cid:19)

Because these probabilities depend on the backcross probabilities there is only symmetry
on one diagonal when s > 0. Partially informative markers and phase unknown data can
be treated the same way as an Ft.

Recombination Counts

In the previous implementation of R/qtl recombination counts were calculated, however
for advanced crossing schemes there is no direct analytic solution. Instead we implemented
a hill climbing algorithm using a golden section search [11] which determines the most
probable recombination frequency, rather than calculating an actual value. The search
space starts between 0 and 0.5 (all possible recombination frequencies). The golden section
search relies on comparing three points (ﬁgure 8). To start with the points are r = 0,
r = 0.5, and r = r1, where the value of r1 is determined so that the ratio of a to a+b is
equal to the ratio of a to b. Then a new point (r = r2) is added in the larger interval so
that the ratio of d to a is equal to the ratio of c to d. The set of 3 r values containing the
highest maximum likelihood (as compared to the null model of unlinked markers r = 0.5)
are kept, and the remaining value is dropped (in this case r = 0.5). The search algorithm
starts again with 0, r1, and r2 as the three points. This process repeats until tolerance
for the minimum improvement in likelihood is reached, then the r value with the highest
likelihood is reported as the maximum likelihodd estimate used in the map. This provides
an accurate estimate of recombination frequency.

15

f4

f2

f3

f1

d
o
o
h

i
l

i

e
k
L
g
o
L

0

r2

r1

0.5

d

a

c

b

Recombination Frequency

Figure 8: An illustration of the golden section search

16

A Note on Intercrosses and Random Matings

These equations are accurate for BCsFt when Ft refers to any number of selfed generations.
We have not implemented code to address advanced intercross lines resulting from sib
mating or random mating within an advanced cross. Below we sketch ideas to develop
these algorithms.

In an F2, selﬁng and sib-mating are interchangeable in terms of calculations because the
entire population has an identical F1 genotype. However after the F2, calculations get
more complicated for sib-mated populations. Each F2 is sib-mated to create an F3. Sib-
mating brings the added complication that we need to think about families instead of
individuals. There are 10 possible F2 genotypes leading to 55 possible combinations of
cross parents and their next generation families. A transition matrix (L) analagous to the
one for selﬁng (N ) would have to be 55 x 55 and account for the probability that a family
that resulted from a cross between a particular set of parents in the Ft−2 would yield a
cross between another set of parents in the Ft−1. This would be multiplied by a vector of
55 starting probabilities for the F1 (q∗
F1), these being probabilities of genotypes for speciﬁc
crosses rather than for individuals. Of course, for the F1, there is only one type of cross
AB/abXAB/ab which can be the parents of the F2, and the probability of the other 54
types of crosses is 0. Multiplying these successively will result in the probabilities of the
crosses that produce the Ft, since our actual question is the probability of the genotypes
of the Ft where one individual is selected from each family, we will need a second matrix,
K. This matrix will give the probability for each of the 10 possible genotypes results based
on the 55 possible crosses. The ﬁnal result will be the probability of the 10 genotypes
(qFt). The equation for the genotype probabilities after t generations of intercrossing,
then is:

qFt = (qF1Lt−2)K .

Note that the selfed Ft is a special case with only the 10 selﬁngs of the 55 possible crosses
being non-zero. In general, this formal equation can be simpliﬁed substantially by using
symmetry arguments, and implemented in a similar manner to the selﬁng case. Transient
and absorbing states can be handled in an analogous but somewhat more complicated
manner to the selfed case. However, the devil is in the details!

We consider the case of random mating after s generations of backcross and t generations
of selﬁng. We begin with the qBCsFt 10-vector of phase-known genotype frequencies, and
multiply by a 10×4 matrix (J) to convert these frequencies into the four possible two-locus
alleles (u). These allele frequencies are cross multiplied (uT u) to create a 4×4 matrix of

17

random mating frequencis of genotypes, which are then reduced to the 10-vector format
of phase-known genotype frequencies (qBCsFtR). Eight of the rows of the matrix J are
simple (0, 0.5 or 1 values), while the middle two involve the possible recombinants and
non-recombinants:

J =

AB Ab aB ab

AB
AB
AB
Ab
Ab
Ab
AB
aB
AB
ab
aB
Ab
ab
Ab
aB
aB
ab
aB
ab
ab

1
1
2
0
1
2
w
2
r
2
0

0

0

0

0
1
2
1

0
r
2
w
2
1
2
0

0

0

0

0

0
1
2
r
2
w
2
0

1
1
2
0

0

0

0

0
w
2
r
2
1
2
0
1
2
1

Extension to sib-mating instead of selﬁng follows directly. Extension to selﬁng or sib-
mating after random mating follows as for the Ft approach outlined earlier. Again, the
devil is in the details.

Code modiﬁcations in R/qtl

Our goal was to make R/qtl fully functional for a wider variety of cross types. Ideally
these changes will be minimally visible to the user after inputing the cross type. In order
to create an identical user experience we had to modify all R routines so that they would
recognize the bcsft cross type. Cross objects in R/qtl all have the attribute "class"
consisting of 2 parts: one which identiﬁes it as a cross object and one which speciﬁes the
cross type (bc, f2, riself, risib, etc.). We added an additional option, bcsft. A major
diﬀerence between the previous cross types and bcsft, all other cross types are speciﬁc.
In that there are no options for types of backcrosses, it’s just a backcross. With the BCsFt
we intentionally created a more ﬂexible cross type, where the generation number can be
set by the user. This means that we don’t have to go back and add a cross type every time
we want to analyze a population with a diﬀerent history. The way we have created this

18

ﬂexibity is by adding the attribute cross.scheme to cross objects. The cross.scheme
consists of two numbers, the ﬁrst is the generations of backcrossing (s), the second is
the generations of selﬁng (t). The addition of a cross type and an attribute allow all R
routines to recognize all types of BCsFt crosses.

The previous sections detailed the way genotype probabilities and recombination counts
are calculated for BCsFt crosses. These calculations are contained within the speciﬁc
init, emit, and step functions for bcsft within the C code. All three of these func-
tions are used in the Hidden Markov Model (HMM). The init function determines the
probability of true genotypes. The emit function determines the probability of observed
genotypes given the true genotypes, while the step function determines the probability
of a genotype at a particular locus given the genotype at a linked locus as described in
the previous section. We created BCsFt versions of all of these functions which follow the
same format and work the same way as the existing versions, except for when they are
called by est.map. We did not ﬁnd a closed form solution for calculating the number
of recombination events between pairs of markers in a BCsFt and so we implemented a
golden section search as part of est.map instead.

There is a second diﬀerence between the way the HMM is implemented for BCsFt and
all other types of crosses, leading to an improvement in eﬃciency with no eﬀect on the
estimates. Previously the probabilities for each pair of markers for each individual were
calculated independently given the recombination rate between those markers in the entire
data set. For the BCsFt the entire set of probabilities is calculated once for a set of markers
given the recombination rate and then applied to all individuals. In a population with
100 lines, this is the diﬀerence between 10 calculations (1 for each possible genotype
combination) and 100 calculations. This method could be readily expanded to analyze
populations with mixed cross histories (where some lines have undergone more generations
of selﬁng or backcrossing than others). Recombination rates could be calculated across all
individuals and then probabilities would be calculated separately for each cross history and
applied to pairs of markers in an individual according to cross history. However, record
keeping about cross histories for each individual line would need to be implemented in
the package.

Genotype probabilities diﬀer for the autosomes and sex chromosomes. While this is not
an issue for selfed populations it could be an issue in an advanced backcross or advanced
intercross populations. We have arranged for proper handling of the X chromosome.
Basically in an Ft the X chromosome is treated as though it were the product of a BCt.
The only real change here is that we created the capacity to keep track of t. All changes
to the program have been unit tested and that code is included in the package.

19

References

[1] Tanksley SD, Nelson JC (1996) Advanced backcross QTL analysis: a method for the
simultaneous discovery and transfer of valuable QTLs from unadapted germplasm
into elite breeding lines. Theoretical and Applied Genetics 92: 191–203.

[2] Xie C, Gessler DDG, Xu S (1998) Sib mating designs for quantitative trait loci.

Genetica 104: 9–19.

[3] Collard BCY, Jahufer MZZ, Brouwer JB, Pang ECK (2005) An introduction to
markers, quantitative trait loci (QTL) mapping and marker-assisted selection for
crop improvement: the basic concepts. Euphytica 142: 169–196.

[4] King EG, Macdonald SJ, Long AD (2012) Properties and power of the Drosophilia
Synthetic Population Resource for the routine dissection of complex traits. Genetics
191: 935–949.

[5] Darvasi A, Soller M (1995) Advanced intercrossing lines, an experimental population

for ﬁne genetic mapping. Genetics 141: 1199–1207.

[6] Broman KW, Wu H, Sen S, Churchill GA (2003) R/qtl: QTL mapping in experi-

mental crosses. Bioinformatics 19: 889–890.

[7] Lander ES, Botstein D (1989) Mapping Mendelian factors underlying quantitative

traits using RFLP linkage maps. Genetics 121: 185–199.

[8] Broman KW, Sen S (2009) A guide to QTL mapping with R/qtl. Springer.

[9] Jiang C, Zeng ZB (1997) Mapping quantitative trait loci with dominant and missing

markers in various crosses from two inbred lines. Gentica 101: 47–58.

[10] Bulmer MG (1985) The Mathmatical Theory of Quantitative Genetics. Oxford Uni-

versity Press.

[11] Kiefer J (1953) Sequential minimax search for a maximum. Proceedings of the Amer-

ican Mathmatical Society 4: 502–506.

20

