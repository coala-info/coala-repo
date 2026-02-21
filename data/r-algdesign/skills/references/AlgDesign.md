Comments on algorithmic design

Robert E. Wheeler

Copyright '2004-2009 by Robert E. Wheeler

1

Contents

1 Introduction

2 The varieties of designs

2.1 One-way layouts . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2.2 Higher way layouts . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2.3 Factorial Designs . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2.4 Blocked experiments

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

4

5

5

8

8

9

2.5 Response surface experiments

. . . . . . . . . . . . . . . . . . . . . . . . . 11

2.5.1 The form of X . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 11

2.5.2 Design criteria . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 12

2.5.3 Design spaces . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 12

2.5.4 Goals . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 13

2.5.5 Mixture experiments . . . . . . . . . . . . . . . . . . . . . . . . . . 13

2.5.6 Blocking response surface experiments

. . . . . . . . . . . . . . . . 14

3 Confounding

4 Examples using R

15

15

4.1 Approximate theory designs . . . . . . . . . . . . . . . . . . . . . . . . . . 15

4.1.1

Support Points

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . 16

4.1.2 Rounding Approximate Designs . . . . . . . . . . . . . . . . . . . . 18

4.2 Exact Designs . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 19

4.2.1 Classical Designs . . . . . . . . . . . . . . . . . . . . . . . . . . . . 19

4.2.1.1 Fractional Factorial . . . . . . . . . . . . . . . . . . . . . . 19

4.2.1.2 Orthogonal design . . . . . . . . . . . . . . . . . . . . . . 20

4.2.1.3 Central composite

. . . . . . . . . . . . . . . . . . . . . . 20

4.2.1.4

Latin square

. . . . . . . . . . . . . . . . . . . . . . . . . 21

4.2.2 Factorials

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 21

4.2.2.1 Two level Designs . . . . . . . . . . . . . . . . . . . . . . . 21

4.2.2.2 Mixed level designs . . . . . . . . . . . . . . . . . . . . . . 23

2

4.2.3 Response surface designs . . . . . . . . . . . . . . . . . . . . . . . . 24

4.2.3.1 Three variables in a cube

. . . . . . . . . . . . . . . . . . 25

4.2.3.2 Design augmentation . . . . . . . . . . . . . . . . . . . . . 28

4.2.3.3 Mixture designs . . . . . . . . . . . . . . . . . . . . . . . . 29

4.2.3.4

Large problems . . . . . . . . . . . . . . . . . . . . . . . . 30

4.2.3.5 Constrained regions

. . . . . . . . . . . . . . . . . . . . . 33

4.2.4

Starting designs . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 33

4.3 Blocked designs . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 35

4.3.1 Balanced and partially balanced designs

. . . . . . . . . . . . . . . 35

4.3.2 Blocking illustration . . . . . . . . . . . . . . . . . . . . . . . . . . 36

4.3.3

Improving individual blocks with the Dp criterion . . . . . . . . . . 38

4.3.4 Orthogonal Blocking (cid:21) Nguyen’s ideas

. . . . . . . . . . . . . . . . 40

4.3.5 Blocking with whole plot factors (split plots) . . . . . . . . . . . . . 41

4.3.6 Multistratum blocking . . . . . . . . . . . . . . . . . . . . . . . . . 44

5 Appendix A: Federov’s algorithm

6 Appendix B: Blocking designs

48

49

6.1 Background . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 49

6.1.1 Blocking models . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 49

6.1.2

Interblock, intrablock information and optimal blocking.

. . . . . . 51

6.1.3 Measuring intrablock information . . . . . . . . . . . . . . . . . . . 51

6.1.4 Analysis of blocked experiments . . . . . . . . . . . . . . . . . . . . 53

6.1.5 Multistratum models . . . . . . . . . . . . . . . . . . . . . . . . . . 53

6.2 Alternative criteria . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 54

6.3 Updating equations for the Dpc criterion. . . . . . . . . . . . . . . . . . . . 54

6.4 Updating equations for the D criterion. . . . . . . . . . . . . . . . . . . . . 56

6.5 Updating equations for the D criterion when there are interactions between

block factors and within block factors.

. . . . . . . . . . . . . . . . . . . . 57

6.6 Computational note . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 58

3

1

Introduction

This paper has three goals:

1. To brie(cid:29)y describe algorithmic design in a way that will be helpful to those who

primarily use other experimental design methodologies.

2. To provide examples illustrating the use of the functions in AlgDesign.

3. To document the mathematical expressions used in the programs and call attention

to any di(cid:27)erences from those available in the literature.

The general model used for experimental design is

Y = Xβ + Σb

i=1Ziγi + ϵ,

(1)

where Y is a vector of N observations, X is a N × k matrix, Zi, (i = 1 . . . b) are N × mi
matrices. The vectors γi, (i = 1 . . . b) and the N vector ϵ, are random and independent of
each other with variances σ2

ϵ I, respectively.

i Imi and σ2

The variance of Y is V σ2

ϵ . The general-
ized least squares estimator of β is ˆβ = (X T V −1X)−1X T V −1Y , and thus the covariance
is M −1σ2/N , where M = X T V −1X/N .

i + I, and ρi = σ2

ϵ where V = Σb

i=1XiX T

i /σ2

i ρ2

From this it may be seen that the (cid:16)best(cid:17) estimates of the parameters are obtained

when M −1 is made as small as possible in some sense.

Established, or classical, designs that are described in the various textbooks and pa-
pers on the subject, all (cid:28)t within a larger framework wherein designs are constructed to
meet various criteria for the information matrix, region of experimentation, and model.
Algorithmic optimization of these criteria will produce the above mentioned designs. Sim-
ply replaying tables of such designs is not the goal of algorithmic design, but rather the
goal is to extend these criteria to the often awkward conditions of practical experimen-
tation which defy standard designs, and to produce highly e(cid:30)cient designs not in the
canon.

For example, a 36−1 factorial requires 243 observations to estimate 28 terms if the
model is quadratic; thus, there are 215 degrees of freedom for error, which even to the most
conservative experimenter, must seem to be a great many. Of course, power calculations
may indicate that one needs many observations in order to estimate the coe(cid:30)cients with
adequate precision. More commonly, however, one would be satis(cid:28)ed with something like
10 degrees of freedom for error and would like an experiment with about 40 observations.
The canon contains no suitable design, but an algorithmic calculation will create a 40
run design with coe(cid:30)cient variances only 10% larger than those for the 243 observation
fractional factorial.

The model described by equation (1) contains multiple error terms. This is quite
unrealistic. To be sure, in the analysis, estimates of the several variance components

4

can be obtained, but in the design phase, there is very seldom a rational basis for their
speci(cid:28)cation, and the (cid:16)best(cid:17) design does depend on their values. Fortunately, a great
many experimental problems involve only one or at the most two variance components.
The problem of designing with multiple error terms is not one that has not been generally
solved for established designs.

A simply written survey of some of the ideas involved is presented in Chapter 7 of
Cox and Reid [2000], and a longer, but equally simply written, exposition may be found
in the (cid:28)rst part of Atkinson and Donev [1992].

2 The varieties of designs

2.1 One-way layouts

The very (cid:28)rst statistical experiment Peirce and Jastrow [1884] was a simple one-way
layout with equal numbers of observations at each level. The estimates were uncorrelated
because randomization was employed (its (cid:28)rst use in an experimental setting). This simple
experimental arrangement may be represented by a table with observed values yi in the
cells:

level 1
level 2
level 3

y1
y2
y3

For this, the structure of X could be

I =






1 0 0
0 1 0
0 0 1



 ,

which means that M is diagonal, and the estimates uncorrelated. If there are ni replica-
tions at each level, then X comprises replications of the rows of I, and

M =






1
N

n1 0
0
0

0
n2 0
n3
0



 ,

where N = (cid:80) ni.

The estimates of the parameters are easy to compute, being the means of the cells,
˜βi = ¯yi for i = 1, 2, 3. Simplicity of computation was very important in the days before
computers, and many standard designs require nothing more than simple arithmetic for
their analysis. In order to preserve this simplicity, various schemes have been developed
for (cid:16)(cid:28)lling in(cid:17) missing data to preserve the computational protocol: but this is another
topic, and our concern is with design.

5

The only design question is the number of observations in each cell. If N is (cid:28)xed,
then it is easy to see1that the expected variance of any pairwise contrast of the parameter
estimates is minimized by making the ni equal. Almost all of the discussion of e(cid:30)ciency
in the standard texts, such as Cochran and Cox [1950] is in terms of pairwise contrasts,
and by and large this has been the major criterion in constructing designs. It is however
a specialized instance of more general criteria. In particular, maximizing the determinant
of M leads to the same design.

The form of X is not unique, since any non-singular linear transformation of the
parameters, say from Xβ to XT T −1β = Zγ, will leave unchanged the statistical charac-
teristics of the experiment. For example, the F-ratio for the single factor is unchanged by
such a transformation.

A common transformation restates the parameters in terms of deviations from their

mean, producing (cid:16)main e(cid:27)ects.(cid:17) For example, one might use

with

T =






1 −1 −1
1
1
0
0 −1
1



 ,

T −1 =






1
3

1
−1
−1 −1

1
1
2 −1
2



 .

The (cid:28)rst form has a parameter (β1, β2, β3) for each level, while the new one has pa-
rameters representing a mean β. = 1
3(β1 + β2 + β3), and the main e(cid:27)ects (β2 − β.),
(β3−β.). Although apparently asymmetric, all main e(cid:27)ects are estimated, since (β1−β.) =
−(β2 − β.) − (β3 − β.). Each of these main e(cid:27)ects has the same variance, but in contrast
to the original parameters, they are correlated: the expected value of the correlation is
0.67 in this example.

Correlation among parameter estimates is common in experimental design, and can
lead to misinterpretations, since the observed magnitude of an e(cid:27)ect may be due to
a substantial value for another parameter. The usual technique for dealing with this
problem is to use an omnibus test for all parameters of interest and then to follow this
up with multiple comparisons using contrasts among the parameters. That is to rely on
ANOVA. The point is important especially in connection with response surface designs
which can tempt the experimenter into the misinterpretation of individual parameters.

Another transformation that is frequently used is the orthogonal representation

T =






1 −1 −1
0
1
2
1 −1
1



 ,

which produces uncorrelated estimates of the parameters β., (β3 − β1)/2, and (β2 − (β1 +

1The expected variance of a pairwise contrast is proportional to
integral increment or decrement. This is obviously minimized for x = 0.

1

n+x + 1

n−x = 2n2

n2−x2 , where x is an

6

β3)/2)/3. These parameters are interpretable as linear and quadratic components if the
levels of the variable are from a continuum such as time or temperature.

There are basically three types of variables in experimentation: (1) categorical vari-
ables, which assume discrete levels unrelated to each other, such as (cid:16)old men,(cid:17) (cid:16)young
men,(cid:17) etc.; (2) continuous variables such as time or temperature; and (3) random vari-
ables such as (cid:16)(cid:28)rst sample,(cid:17) (cid:16)second sample,(cid:17) etc. For the most part we will be concerned
with categorical and continuous variables, but the distinction is not always clear. In the
Peirce and Jastrow [1884] experiments, the levels were designated by the ratio of two
weights (1.015, 1.030, and 1.060 in one experiment). These can be interpreted as three
categories, (cid:16)small,(cid:17) (cid:16)medium,(cid:17) and (cid:16)large.(cid:17) They could also be interpreted as continu-
ous, and one might even prefer to take logarithms so that they represent an approximate
doubling between steps. Some experimental designs assume that the variables are contin-
uous, and some designs for categorical variables are seldom used for continuous variables,
but in general, the distinction between these two types is not important as far as design
construction is concerned.

For (cid:28)xed N, minimizing the expected variance of pairwise contrasts leads to a design
with equal sample sizes in each cell, but after transformation, optimization in terms of
the parameters is no longer obvious, which serves to indicate that a better understanding
of criteria is needed. At the moment it is useful to note that (cid:28)xed linear transformations
have no e(cid:27)ect on the maximization of the determinant of M ; and the maximization of the
determinant, in this one-way example, leads to equal numbers of observations at each level
regardless of the transformation chosen. The trace of M −1 is proportional to the average
variance of the parameter estimates, and is also a criterion of interest. Its minimization
is not invariant under linear transformation however, and the number of observations per
level which minimize the trace can di(cid:27)er from transformation to transformation.

The original form of X was not particularly interesting, since the parameters repre-
sent expectations of cell means. When one observes several levels in for a factor, one
naturally inquires about the di(cid:27)erences between them, and the original parameters are
not informative in this. The second form, however, with a grand mean and main e(cid:27)ects
as parameters is more informative, in that some of the most interesting contrasts are ex-
pressed as parameters. In times past this was more important than today, since in certain
cases it saved computational labor. It is of little practical importance nowadays, since
one may always compute any contrast of interest, together with its standard error, with
modern computer software.








There are of course many other possible transformations. One could even write X as
1 1 0 0
1 0 1 0
1 0 0 1


, which this has more parameters than data values, leading to multiple

solutions. Except in very special cases, one may as well choose a non-singular transforma-
tion, as in the previous forms, since any function of the parameters is readily computed
from such. For the most part, forms involving a grand mean are preferred. The general
structure of X is then X = [1, Xm], where the column rank of Xm is k − 1.

7

2.2 Higher way layouts

For two factors, one has a two way layout:

y1,1
y2,1
y3,1

y1,2
y2,2
y3,2

y1,3
y2,3
y3,3

The basic parameterization of one parameter per cell is seldom used, rather, more
informative parameterizations are common, such a main e(cid:27)ect, interaction form such as

X = [1, Xme(cid:27), Xint] =

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

1

1 −1 −1 −1 −1
1
1
1
0
1 −1 −1
0
1
1
1
1
0
1 −1 −1
0
1
1
1
0
1

1
0 −1 −1 −1 −1
1 −1 −1
1
1
1
0
0
0

1
1
0
0
0 −1 −1
0
0
0 −1
0 −1
0
0
0
1
0
1
0
0
0
0
0 −1
0 −1
1
0
0
1
0
1
1
0
0
0
1

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

,

where Xint is an interaction expansion of Xme(cid:27) obtained by taking cross products. The
main e(cid:27)ect estimates for the (cid:28)rst factor are (y1. − y.., y2. − y.., y3. − y..), where dots denote
averages, and similar estimates for the other factor. An interaction is a product, a typical
one is (y2. − y..)(y.3 − y..). All these are obtained by simple summation as indicated by
the pattern in X above.

As before, the optimum allocation is equal numbers of observations in each cell of the
two-way layout, which is also the allocation obtained by maximizing the determinant of
M .

2.3 Factorial Designs

As Lorenzen and Anderson [1993] have shown, linear experimental designs may be ex-
pressed as factorial designs involving linear models which are variants of the fundamental
model in equation (1): the usual enhancement is to include additional error terms.

When there are three factors, there will be columns in X representing three way in-
teractions, and as the number of factors increase, so does the order of the maximum
interaction. In practice, designs with several factors require substantial numbers of obser-
vations, and the question arrises as to their utility. One solution is to select rows from X
which will enable the estimation of main e(cid:27)ects and low order interactions. In doing this,
information about the higher order interactions is confounded and they are no longer es-
timable. The complete layout is called a factorial layout, and the reduced layout obtained
by selecting rows from X is called a fractional factorial. The idea was (cid:28)rst addressed by
Finney [1945].

8

Note that the (cid:28)rst three rows for columns 2 and 3 is repeated in the next three rows
and in the last three. Each of these repeats is associated with (cid:28)xed values for the second
factor, hence one can estimate the parameters for the (cid:28)rst factor in each of the three
repeats. Of course these estimates are conditional on the second factor; however, if it
were possible to assume that the second factor had no e(cid:27)ect, then one could use the
estimates from the (cid:28)rst repeat alone. One could even pool the estimates from the three
repeats to obtain greater precision.

When there are several factors in an experiment, patterns enabling the estimation
of low order e(cid:27)ects will be found that are associated with (cid:28)xed values of high order
interactions, and the technique of fractional factorial design consists of selecting one of
the several repeats associated with a (cid:28)xed high order interaction. All this, of course, on
the assumption that the high order interaction is negligible.

An easy illustration of this is the fractioning of a two-level experiment. Part of the

pattern for four two level factors is

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




1
1 −1
1
1 −1 −1
1 −1
1
1

1
1 −1 −1 −1 −1
1
1
1 −1 −1
1
1
1 −1
1
1 −1
1 −1
1
1
1
1
1 −1
1
1
1 −1 −1
1
1
1
1
1
1
1 −1
1 −1 −1 −1
1 −1 −1
1 −1 −1
1 −1 −1 −1
1 −1
1 −1
1 −1
1
1
1 −1 −1 −1 −1
1
1 −1
1 −1
1
1
1 −1
1 −1
1
1
1 −1 −1
1
1
1

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




,

where the two-level factor are coded -1 and 1, and only the mean, main e(cid:27)ect and four-way
interaction columns are shown. The rows have been rearranged according to the levels
of the four-way interactions, and it is easy to see that if the experiment were divided in
two according to the four-way levels, that each half would provide data for estimating the
main e(cid:27)ects of all four factors. Such a fraction is called a half fraction and denoted 24−1.

As before, the allocation that minimizes the variance of an estimate of pairwise con-
trasts is an equal allocation of observations to the cells, and this is also the allocation
that maximizes the determinant of M for a (cid:28)xed number of trials.

2.4 Blocked experiments

One of the (cid:28)rst problems that arose in the early days of experimental design was in the
practical allocation of experimental units. It often happens that the amount of material

9

or time available is inadequate for all experimental trials. Many things happen from trial
to trial which are unrelated to the treatment applied. For the most part these can be
lumped together as (cid:16)experimental error,(cid:17) but this becomes less tenable if the material or
conditions of the experiment change. For example, Peirce and Jastrow [1884] found that
their judgments improved as their experiments progressed, and they did not think it fair
to directly compare results taken from a late series with those from an earlier one.

Early on, the idea of dividing the experiment into (cid:16)blocks(cid:17) arose. In this, one seeks to
arrange the trials in such a way that the comparisons of interest may all be made in close
proximity, so that disparities due to extraneous factors can be avoided. If it is possible
to fraction an experiment so that each fraction (cid:28)ts into a homogeneous block, then one
can estimate the parameters in each block and pool the estimates. To the (cid:28)rst order, the
di(cid:27)erences between blocks will be captured by the constant terms which can be discarded.
If it is not possible to fraction the experiment, then other methods must be used.

In general, for each block there is a constant column, so that X = [Ib, ˜X], where ˜X is
the block centered2 form of the expanded design matrix and Ib is a block diagonal matrix
with columns of unities on the diagonal and zeros o(cid:27)-diagonal. Thus X for a blocked
experiment has as many constant columns as there are blocks. Since the columns of ˜X
and those of Ib are orthogonal, the least squares parameter estimates for the factors do
not depend on the block parameters3 when the number of blocks and their sizes are (cid:28)xed.

The model for a blocked experiment is

˜Y = [Ib, ˜X]β + ˜ϵ,

(2)

b , βT

where ˜Y , ˜X and ˜ϵ correspond to values in equation (1) after centering by block means,
and βT = (βT
X). The uncentered observations have two error components, one within
the block and one between the blocks. The centering cancels the between block error
component. Maximizing the determinant of ˜M = ˜X T ˜X will lead to the same design as
minimizing the variances of pairwise di(cid:27)erences within blocks.

In this formulation, it is assumed that the block parameters βb, are nuisance parame-
ters, of no particular interest. Indeed, they are often random, such as (cid:16)oven load 1,(cid:17) (cid:16)oven
load 2,(cid:17) etc., and although one could treat them in the usual way and estimate variance
components, the number of blocks involved is often so small that the estimates are hardly
worth having.

An incomplete block experiment is one in which the trials are arranged so that con-
trasts of interest can be estimated within the several blocks. For example, suppose that
one can complete only 3 trials per day, but that 7 treatments are to be compared. If 21
trials are arranged as in Table (1), then it may seen that each pair of treatments occurs
together exactly once in the same block. Thus the di(cid:27)erences between treatments may
all be estimated without the error that might be caused by block e(cid:27)ects.

2The block mean is subtracted from each value in the block.
3The least square parameter estimates are (X T X)−1X T Y , and X T X =

(cid:18) ˜X T ˜X

0
0 nI

(cid:19)

, when all

blocks have n trials.

10

Table 1: A balanced incomplete block experiment

block 1
block 2
block 3
block 4
block 5
block 6
block 7

1
2
3
4
1
2
1

2
3
4
5
5
6
3

4
5
6
7
6
7
7

The X matrix for this experiment has 21 rows selected from a contrast matrix for a 7
level factor. Any 7 × 7 matrix of full column rank will do. The default contrast matrix
built into R has a constant column followed by 6 mutually orthogonal columns:

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


1 0 0 0 0 0 0
1 1 0 0 0 0 0
1 0 1 0 0 0 0
1 0 0 1 0 0 0
1 0 0 0 1 0 0
1 0 0 0 0 1 0
1 0 0 0 0 0 0

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


.

The constant column is discarded, because each block has its own constant column. In
this case, the design in Table (1) will be obtained when ˜M is maximized.

The blocks are not always nuisance parameters, and in some practical situations, such
as split-plots, represent factors of interest. The model for this is ˜Y = ˜Xβ + Xbβb + Zθ + ˜ϵ,
where Xb and βb represent the whole plot factors, while Z and θ represent the random
block components. This model is discussed in Appendix B.

There are other, more complicated blocking schemes involving blocks in a two dimen-
sional layout, but these will not be discussed. Blocking of response surface, and factorial
experiments will be discussed later.

2.5 Response surface experiments

2.5.1 The form of X

When the variables are continuous, it is natural to envision the experimental space as a
multidimensional continuum (cid:21) a multidimensional box or sphere. Predictions from the
(cid:16)model(cid:17) may assume any value in the range of the response. Equation (1) still applies,
but now X = [1, F (x)], where F (x) = {f1(x), . . . , fk(x)} for vector valued functions
fi(x), i = 1 . . . k, and x is a set of N design vectors x = {x1, . . . , xN }T , where {xj =
(xj,1, . . . xj,p)T , j = 1 . . . N }.

For example if p = 2, N = 9, and if both design variables range from -1 to 1, then x

11

might look like

x =

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

−1 −1
0
−1
1
−1
0 −1
0
0
0
1
1 −1
0
1
1
1

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

.

The fi() are terms in the model. Frequently, the fi() describe a polynomial, for
j,1, x2

example row j of F (x) might be {xj,1, xj,2, x2

j,2, xj,1xj,2} with k = 6, and

F (x) =

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

−1 −1 1 1 −1
0 1 0
−1
0
1 1 1 −1
−1
0
0 −1 0 1
0
0 0 0
0
0
0
1 0 1
1 −1 1 1 −1
0
0 1 0
1
1
1 1 1
1

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

.

2.5.2 Design criteria

The design problem becomes one of selecting points in the multidimensional region that
will (cid:16)best(cid:17) estimate some important function of the parameters. In this case, there is no
obvious criterion as there was for one-way layouts. See Federov [1972] or Silvey [1980] for
a discussion of this topic.

The one most generally used is the D criterion, which maximizes the determinant of
M = F (x)T F (x) for a (cid:28)xed number of design points. There are several rationales for
using D. For example, a con(cid:28)dence ellipsoid for β is

( ˆβ − β)T M ( ˆβ − β) ≤ constant,

and since the volume of this ellipsoid is proportional to |M |− 1
2 , maximizing M will make
this volume as small as possible. Similarly, the numerator of the F-test when the er-
rors are iid normal, is proportional to ˆβT M ˆβ, which by the same argument leads to the
minimization of M for a (cid:28)xed number of design points.

2.5.3 Design spaces

Although response surface problems are de(cid:28)ned for continuous variables which can assume
any real value in a region, only a subset of the points support the design. Any point not

12

in this set of support points may be exchanged for a point in the set with an increase
in the determinant. For quadratic models, this set of support points is the set of points
of a three level factorial. In general, one can replace the continuous region with a set of
discrete points, such as the points from a factorial with an appropriate number of levels.
The actual support points are always in the neighborhood of the factorial points, and
improvements due to their use are minor Donev and Atkinson [1988].

2.5.4 Goals

There are usually two goals of interest in a response surface experiment: parameter esti-
mation, and prediction.

Although the parameters themselves are of interest, the fact that the model is an
approximation, makes them less interesting than in other forms of experimentation, where
the factors represent important attributes. Polynomial models act as mathematical French
curves to graduate the response surface, and within a given region will usually mimic the
actual underlying functionality, but by themselves have no meaning; and clearly are false
outside the region. It is an error to think of them as Taylor series approximations, which
is a siren that often tempts those new to the (cid:28)eld. One can parcel out the terms in a
polynomial model as if they were factors and interactions and perform ANOVA. For most
response surface designs, the ANOVA sums of squares will not be independent, but they
still provide likelihood ratio tests for the individual sources, and looking at such is a better
practice than attempting to interpret the individual terms.

Prediction is a related, but independent goal. For approximate theory, where fractional
points are allowed, the general equivalence theorem Atkinson and Donev [1992] says that
a D-optimal design is also a G-optimal design, where G is the criterion that minimizes
the maximum variance in the experimental region. Thus, for approximate theory, the
maximum prediction variance will be minimized by maximizing4 |M |. For exact theory,
where one has a discrete set of N points in the design, the two criteria are not equivalent,
although G can be used to bound D.

A criterion that deals speci(cid:28)cally with prediction is the I criterion, which is de(cid:28)ned as
the average prediction variance in the region. In spite of the apparent di(cid:27)erence between
the two criteria, the points chosen by the D and I criterion are similar. The I criterion,
by and large, tends to select its points from the support points for the D criterion.

2.5.5 Mixture experiments

Since the variables are continuous, they may represent mixtures, as for example, mixtures
of components in a paint. In these, the variables are constrained to sum to a constant,
usually unity. An example of a design for three mixture components is shown in Table
(2).

Because of the constraint, ordinary polynomial models will have redundant terms.

4In approximate theory, the fractional weights add to unity, thus ensuring a maximum

13

Table 2: A mixture experiment
0.0
1.0
0.0
0.5
0.0
0.5

1.0
0.0
0.0
0.5
0.5
0.0

0.0
0.0
1.0
0.0
0.5
0.5

This may be dealt with by appending non-estimable constraints to the design, or by
reformulating polynomial models to account for the constraint. The constraint method
may be useful in the analysis in those cases where it is desired to interpret the coe(cid:30)cients.
Cox [1971] treats this problem. For design, there is no advantage in carrying redundant
terms through the calculation, and so reformulated models is appropriate. These have
been given by H. [1958], and elaborated upon by Gorman and Hinman [1962]. The Sche(cid:27)Ø
models for three variables are shown in Table (3). Note that the constant term is omitted
from these models, which among other things, means that they are una(cid:27)ected by block
e(cid:27)ects.

Table 3: Sche(cid:27)Ø models

X1 + X2 + X3

linear
quadratic X1 + X2 + X3 + X1X2 + X1X3 + X2X3
cubic

X1 + X2 + X3 + X1X2 + X1X2 + X2X3+
X1X2(X1 − X2) + X1X3(X1 − X3) + X2X3(X2 − X3)

2.5.6 Blocking response surface experiments

Blocking is often required when using response surface designs which require too many
trials for a single physical test. The division into blocks is seldom symmetrical, and
instead of seeking to balance pairs in the blocks, one seeks to obtain parameter estimates
orthogonal to block e(cid:27)ects. In general, the D criterion is useful; however, when the blocks
are of a size to allow estimation of the parameters within each block, the resulting designs
may be D-optimal in toto, but are not necessarily D-optimum within blocks. An auxiliary
criterion, Dp is then useful, which attempts to maximize the product of the determinants
of the individual blocks. Table (4) shows the cross product matrix for one block of a 24,
blocked into two 8 run blocks by using the D criterion. The model is linear.

Table 4: Cross product of an 8 run block of a 24

8
0
-4
0

0
8
0
0

-4
0
8
0

0
0
0
8

Using the Dp criterion, the crossproduct matrix becomes diagonal, and the block is
shown in Table (5). Note that this is not the usual fractioning of a 24−1 in that no

14

higher order interaction is used to divide the trials. The usual fractioning results in
interaction columns orthogonal to main e(cid:27)ect columns. A Dp design will not usually have
this property.

Table 5: One block from a blocked 24

1
-1
-1
1
-1
1
-1
1

-1
1
-1
-1
1
1
-1
1

-1
-1
1
1
1
1
1
1

-1
-1
-1
-1
-1
-1
1
1

3 Confounding

Confounding is a very important criterion:
it is a dominant factor in the structure of
established designs. The fact that a parameter estimate is signi(cid:28)cant, is always tempered
by the degree to which the parameter may be confounded with other parameters in the
design. Builders of established designs have taken pains to eliminate confounding; but
this often has the side e(cid:27)ect of producing oversize designs.

A measure of confounding it the degree of diagonality of a design. Since positive
de(cid:28)nite information matrices, M , have weighty diagonals5, this may be measured by
comparing |M | with the product of the diagonal elements of M . Diagonality may thus be
de(cid:28)ned as O = [|M |/ (cid:81) diag(M )]1/k, where k is the number of columns of M .

It is important to note that a design which maximized |M | also seems to maximize O,

which means that the confounding is minimized by designs that maximize |M |.

4 Examples using R

4.1 Approximate theory designs

Abstraction and simpli(cid:28)cation are often useful in understanding di(cid:30)cult problems, since
the simpler structure often leeds to insights into the original problem. This is the case
in experimental design, where the X in the basic model, Y = Xβ + ϵ, can assume many
forms, and almost always leads to combinatorial problems of one sort or another. The
useful simpli(cid:28)cation, due I believe to Elfving [1952], is to write the observational weights
as p = 1/N , where N is the number of observations, and then to substitute a probability.
Thus one might write the matrix M = X T X/N = X T P X, where P is a diagonal matrix,

5The 2 × 2 principal minors are positive

15

all of whose diagonal values are p; and then to allow the elements of P to assume any real
values, so long as the trace of P is unity. This is the germ of approximate theory, which
by an large replaces consideration of special combinatorial cases with a uni(cid:28)ed analytical
approach.

4.1.1 Support Points

One of the interesting results that (cid:29)ow from this simpli(cid:28)cation is that only a subset of the
possible points in an experimental region are support points for an experimental design.
Consider a simple quadratic model in three variables, and assume that the variables can
assume seven levels (−3, −2, −1, 0, 1, 2, 3). The candidate set has 37 possible points, and
running optFedrov() with a quadratic model in the following fashion will produce a list
of the support points for the D criterion:

dat<-gen.factorial(levels=7,nVars=3,center=TRUE,varNames=c("A","B","C"))
desD<-optFederov(~quad(.),dat,approximate=TRUE)
desD$design[c(1:5,23:27),]

Proportion

B

C
A
0.069 -3 -3 -3
0 -3 -3
0.029
3 -3 -3
0.072
0 -3
0.022 -3
0 -3
0
0.017

0
0.024
0.020
3
0.071 -3
0
0.024
3
0.075

0
0
3
3
3

3
3
3
3
3

1
4
7
22
25
...
319
322
337
340
343

There are 27 support points in all, and each assumes only the three values (−3, 0, 3). The
support points for a quadratic model in fact correspond to the points of a 3m factorial,
where m is the number of variables. The support points for other criteria are di(cid:27)erent.
For example, the support points for the I criterion in this example are as below, where it
may be seen that points not on the 3m grid are obtained.

desI<-optFederov(~quad(.),dat,approximate=TRUE,criterion="I")
desI$design[c(1:5,27:31),]

1
4
7
22
25
...
322
337

Proportion

B

C
A
0.042 -3 -3 -3
0 -3 -3
0.030
3 -3 -3
0.043
0 -3
0.034 -3
0 -3
0
0.021

3
0.028
0.038 -3

0
3

3
3

16

340
341
343

0.035
0.002
0.040

0
1
3

3
3
3

3
3
3

This result indicates that experimental regions are not quite what they appear to be
with respect to experimental designs. Even though one thinks of a variable as continuous
between some limits, the points in this region are not all candidates for inclusion in an
optimal experimental design. For example the support points for a quadratic polynomial
on the real line are the two extreme points and the mid point. No other points are
involved.

Even after accepting this fact, there are still surprises. The support points on the real
line between 1 and 2 may be obtained as follows. These may be shown to be the support
points on the continuous interval between 1 and 2.

desA<-optFederov(~quad(.),data.frame(A=1+((0:100)/100)),approximate=TRUE)
desA$design

Proportion

A
0.333 1.0
0.333 1.5
0.333 2.0

1
51
101

The slight change caused by running the interval from 1.01 to 2 produces, the following,
in which the proportions are quite di(cid:27)erent from the previous ones, although there still
remain only three support points.

desB<-optFederov(~quad(.),data.frame(A=1+((1:100)/100)),approximate=TRUE)
desB$design

Proportion

A
0.485 1.01
0.029 1.50
0.485 2.00

1
50
100

The di(cid:27)erence between these examples is due to the fact that the precise midpoint is
not included in the second set of candidate points. When it is, the optimum design agrees
with the optimum design on the continuous interval, as the following shows:

desC<-optFederov(~quad(.),data.frame(A=c(1+((1:100)/100),1.505)),approximate=TRUE)
desC$design

Proportion

A
0.333 1.010
0.333 2.000
0.333 1.505

1
100
101

The basic conclusion from these examples is that an optimal design is a function of
the set of candidate points, and if these candidate points fail to include the support
points of the underlying continuum, the design will di(cid:27)er from the optimal design on the
continuum.

17

Atkinson and Donev [1992] give a useful table of support points and their weights for

quadratic models in cubic regions on page 130.

4.1.2 Rounding Approximate Designs

The sample size for an experimental design must be integral, and thus the question of
rounding arises. The proportions in the (cid:28)rst example in the previous section may be
rounded by specifying the nTrials parameter, as follows:

dat<-gen.factorial(levels=7,nVars=3,center=TRUE,varNames=c("A","B","C"))
desDR<-optFederov(~quad(.),dat,approximate=TRUE,nTrials=20)
desDR$design
A
Rep..

B

C
1 -3 -3 -3
0 -3 -3
1
3 -3 -3
1
0 -3
1 -3
0 -3
3
1
3 -3
1 -3
3 -3
1
3
0
1 -3 -3
0
3 -3
1
0
0
1
3
0
3
1 -3
0
3
0
1
3
1 -3 -3
3
0 -3
1
3
3 -3
1
3
0
1 -3
3
0
1
0
3
3
1 -3
3
3
0
1
3
3
3
1

A

C
2 -3 -3 -3
0 -3 -3
1
3 -3 -3
2
0 -3
1 -3
0 -3
0
1

1
4
7
22
28
43
49
148
154
175
190
193
295
298
301
316
319
337
340
343

1
4
7
22
25
...

The unrounded design had 30 support points, but the rounding has discarded ten of
them to produce a 20 run design. Had 40 trials been speci(cid:28)ed, all 30 support points would
have been included and the result would have been:

desDR2<-optFederov(~quad(.),dat,approximate=TRUE,nTrials=40)
desDR2$design[c(1:5,23:27),]
B

Rep..

18

319
322
337
340
343

0
1
1
3
2 -3
0
1
3
2

0
0
3
3
3

3
3
3
3
3

The rounding is done with an algorithm for e(cid:30)cient rounding of experimental designs
by Pukelsheim and Rieder [1992] which produces the smallest loss in e(cid:30)ciency for several
criteria. The efficient.rounding() function is included as part of the package.

4.2 Exact Designs

Away from the world of theory, experimental designs are composed mostly of unique
points. Some replication is done to aid in the estimation of error, but for the most part,
practical constraints dominate and limit the number of points available. The rounding
of approximate theory designs has never been very satisfactory, because such designs can
usually be improved upon when the sample size is (cid:28)xed. In practice, then, one has to
deal with the combinatorial problem; however, insights from approximate theory are very
helpful.

The most successful algorithm for dealing with exact designs is due to Federov [1972].
It starts with a non-singular design matrix, and sequentially exchanges points until a local
optima is found. Since local optimas abound, the process is usually repeated a number
of times and the best design reported.

With the exception of Ge, the criteria e(cid:30)ciencies are not known for exact designs, and
it is therefore not possible to tell from their values whether or not a design is globally
optimal. The e(cid:30)ciencey Ge, is de(cid:28)ned relative to the opimum approximate theory design
and is thus a useful guide when judging an exact design. In particular, a Ge of unity not
only indicates that the exact design is optimum, but that the optimum weights are all
equal.

4.2.1 Classical Designs

Classical designs can be produced algorithmically, since they are almost invariably optimal
designs. It is simply a matter of choosing the correct number of trials and repeating the
algorithmic calculations until the global optimum is found. This section illustrates this.
The advantage of algorithmic design lies, however, in its ability to (cid:28)nd optimal or near
optimal designs for situations in which classical designs do not or can not exist.

4.2.1.1 Fractional Factorial The following design is a one third fraction of a 33.
The confounding de(cid:28)nition is AB2C 2.

dat<-gen.factorial(levels=3,nVars=3,varNames=c("A","B","C"))
desT<-optFederov(~.,dat,nTrials=9)
desT$design

19

A B C
2 1 1
2
3 2 1
6
7
1 3 1
12 3 1 2
13 1 2 2
17 2 3 2
19 1 1 3
23 2 2 3
27 3 3 3

4.2.1.2 Orthogonal design An orthogonal design, similar to a 12 run Plackett-
Burman design can be produced by the following.
If you try this, you may need to
set nRepeats to more than 20 to get an optimum design, which is marked by a Ge of
unity.

dat<-gen.factorial(levels=2,nVars=11,center=TRUE)
desPB<-optFederov(~.,dat,12,nRepeats=20)
desPB$design
$design

1

1

-1 -1

1
1 -1 -1
1
1
1
1 -1 -1
1 -1
1
1 -1

X1 X2 X3 X4 X5 X6 X7 X8 X9 X10 X11
-1
-1
-1
-1
-1
-1
1
1
1
1
1
1

1 -1 1 -1
1
1 -1 -1
1 -1
1
1 -1 -1
-1 -1 -1 -1 -1
1 -1
1
1
1
1 -1 -1 -1 -1
1
1 -1 -1
1 -1
1 -1
1
1
1
1 -1 -1 -1
1
1

180
317
332
609
734
903
-1
1111 -1
1161 -1 -1 -1
1510
1584
1810
2043 -1

1 -1
1
1
1 -1 -1 -1
1
1 -1

1 -1
1 -1 -1 -1
1

-1
-1
-1
1
1
1
-1
-1
-1
1
1
1

1 -1 -1 -1
1 1
1

1 -1 -1
1 -1
1

1 -1
1
1

1

1

4.2.1.3 Central composite A central composite design in three variables may be
obtained. This central composite is an optimal exact design. The D and G e(cid:30)ciencies of
the following, relative to the optimum approximate theory design, are 98% and 89%.

A

dat<-gen.factorial(3,3,center=TRUE,varNames=c("A","B","C"))
desC<-optFederov(~quad(A,B,C),dat,nTrials=14,evaluateI=TRUE,nR=100)
desC$design
C
B
-1 -1 -1
1 -1 -1
0 -1
0
1 -1
-1

1
3
5
7

20

9
1
11
0 -1
13 -1
0
15
1
0
1
0
17
19 -1 -1
1 -1
21
0
0
23
1
25 -1
1
1
27

1 -1
0
0
0
0
1
1
1
1
1

4.2.1.4 Latin square One can even (cid:28)nd Latin squares; although this is more di(cid:30)cult,
which is why it is repeated 1000 times, and that may not be enough if you were to try it.

dat<-gen.factorial(5,3)
desL<-optFederov(~.,dat,nTrials=25,nRepeats=1000)
cs<-xtabs(~.,desL$design)
{xx<-matrix(0,5,5); for (i in 1:5) xx=xx+cs[1:5,1:5,i]*i;xx}

X1

X2

1 2 3 4 5
1 1 3 4 5 2
2 5 1 3 2 4
3 4 2 1 3 5
4 3 5 2 4 1
5 2 4 5 1 3

The reason the above designs appear, is because most classic designs are D-optimal,

and indeed the above designs are D-optimal.

4.2.2 Factorials

According to Lorenzen and Anderson [1993], all linear designs are factorial, and the var-
ious names such as Latin square, split-plot, incomplete block, etc. are due to historical
processes and not to anything essentially di(cid:27)erent in their construction or analysis. There
is considerable justi(cid:28)cation for this viewpoint, and it does eliminate the need to treat a
host of special cases which in essence di(cid:27)er mostly in nomenclature. So let’s consider a
few factorial designs.

4.2.2.1 Two level Designs Two levels designs are very useful. There are statistical
consultants that except for very occasional forays, use nothing else. Such designs certainly
make possible the screening of many variables, as the 12 run orthogonal design, in the
previous section, illustrates. A problem with factorial designs in general is that the
number of experimental trials increases exponentially with the number of variables, while

21

the number of terms of interest increases linearally. Thus the need to fraction such designs,
but even this soon runs into di(cid:30)culties.

Consider a 27 design. A full factorial requires 128 trials, while a half fraction 27−1
requires 64. In both, all two-factor interactions are estimable; however, there are only

1 +

(cid:33)

(cid:32) 7
2

such terms. The remaining 35 degrees of freedom are allocated to error. Surely

this is wasteful, but standard methods of fractioning o(cid:27)er no solution, since a quarter
Instead, consider the
fraction leaves some of the two-factor interactions unestimable.
following design in 34 trials:

dat<-gen.factorial(2,7,center=TRUE)
desF<-optFederov(~.^2,dat,nTrials=34,nRepeats=100)
desF
$D
[1] 0.9223281

$A
[1] 1.181451

$Ge
[1] 0.675

$Dea
[1] 0.617

$design

X1 X2 X3 X4 X5 X6 X7
1 -1 -1 -1 -1 -1 -1
1 -1 -1 -1 -1
1 -1 -1 -1 -1
1 -1 -1 -1
1 -1 -1

1
-1
-1

-1 -1
1
1 -1
1 -1 -1

2
5
8
11
19
...
112
113 -1 -1 -1 -1
1 -1 -1
1
116
1 -1
1
119 -1
1
1
1 -1
126

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
1

1 -1
1
1
1
1

The design is not optimal, but nearly so, since the D value for the optimal design is
unity, making this one 92% e(cid:30)cient. Moreover the confounding is minimal as indicated
by the diagonality of 0.92 and the confounding matrix, shown below. The columns of the
confounding matrix give the regression coe(cid:30)ceints of a variable regressed on the other
variables. If X is a design matrix and C a confounding matrix (−XC) is a matrix of
residuals of each variable regressed on the other variables.

eval.design(~.^2,desF$design,confounding=TRUE)

22

$confounding

[,2]

...
0.0000 0.0000 ...

[,3]

[,1]
(Intercept) -1.0000
x1
x2
...
x5:x6
x5:x7
x6:x7

-0.0278
0.0000

0.0000 -1.0000 -0.0323
0.0000 -0.0323 -1.0000
...

...
0.0323
0.0000 -0.0323
0.0000
0.0000
0.0323 -0.0323

...

[,27]

[,28]
0.0000 -0.0203
... -0.0323 0.0000
...
...
... -1.0000
...
... -0.0323

0.0000 -1.0000

0.0323
...

...

[,29]
0.0000
0.0323
0.0000 -0.0323

0.0000 -0.0323
0.0000
0.0000 -1.0000

...

$determinant
[1] 0.9223281

$A
[1] 1.181451

$diagonality
[1] 0.92

$gmean.variances
[1] 1.179251

This design has 5 degrees of freedom for estimating error, which some may consider
too small. If so, it is easy to create a larger design. However, the power function changes
rapidly and the gains from larger error degrees of freedom are smaller than many suppose.
Most of the power of a design comes not from a large error degrees of freedom, but from
the averaging that occurs in the coe(cid:30)cient estimation; due to the fact that the variance
of a coe(cid:30)cient is proportional to 1/N , where N is the number of trials in the design.

4.2.2.2 Mixed level designs Mixed level factorial designs can be created in the same
way with savings in the number of trials. For example a one half fraction of a 3224 requires
72 trials to estimate 35 terms. The following design does it in 40. Note: It is prefereable
to switch to orthogonal contrasts when judgments about the orthogonality of designs are
of interest.

options(contrasts=c("contr.sum","contr.poly"))

dat<-gen.factorial(c(3,3,2,2,2,2),factors=1:2)
desFM<-optFederov(~.^2,dat,nTrials=40)
desFM[1:4]
$D
[1] 0.5782264

$A
[1] 2.397925

23

$Ge
[1] 0.436

$Dea
[1] 0.274

eval.design(~.^2,desFM$design,confounding=TRUE)
$confounding

[,1]

[,3]
0.0009
0.5154
0.5364 -1.0000

[,2]
(Intercept) -1.0000 -0.0346
X11
-0.0771 -1.0000
X12
...
X4:X5
X4:X6
X5:X6

0.0021
...
0.1364 -0.0603
0.0186
0.0412 -0.1102
0.1850
0.0252 -0.0214 -0.0033

...

...

[,34] [,35]

[,33]
...
0.0247
0.0328
0.0177
...
...
0.2885 -0.1956 -0.0467
... -0.1327 0.3419 -0.0075
...
... -1.0000
...
...

...
...
0.0528
0.0828
0.0986 -1.0000 -0.0185
0.0511 -0.0150 -1.0000

...

$determinant
[1] 0.5782264

$A
[1] 2.397925

$diagonality
[1] 0.801

$gmean.variances
[1] 2.223677

4.2.3 Response surface designs

These designs treat the model as a mathematical French curve for graduating the response,
which is visualized as a surface in multidimensional space. The model is invariably a low
order polynomial, usually quadratic. The model has no validity outside the experimental
region as decribed by the data, and only in exceptional cases can it be assumed to represent
some underlying function. The variables are continuous, although it is reasonable to
incorporate categorical variables into the model to allow for baseline changes.

For such designs, the orthogonality or lack of orthogonality of the design is of small
importance; rather the prediction ability is paramount. However, designs which have good
prediciton ability also have good parameter estimation ability, which leads to designs that
tend to orthogonality. For approximate theory designs, the fundamental theorem says that

24

the two problems are equivalent, in that a design with minimizes the maximum prediction
variance in a region also maximize the determinant of the information matrix: thus the
optimun prediction and parameter estimation designs are the same.

4.2.3.1 Three variables in a cube In this case the experimental region is a cube.
For the D criterion, the support points are the corners and centers of the cube, as the
following shows:

dat<-gen.factorial(7,3)
desCD=optFederov(~quad(.),dat,approximate=TRUE)
dim(desCD$design)
4
[1] 27

apply(desCD$design[,-1],2,table)

x1 x2 x3
9
9
9
9
9
9

9
9
9

-3
0
3

For the A criterion, there are 66 support points using all 5 levels of the variables.

There is some assymetry in the design.

desCA<-optFederov(~quad(.),dat,approximate=TRUE,criterion="A")
dim(desCA$design)
[1] 66
4
apply(desCA$design[,-1],2,table)

7

7

x1 x2 x3
-3 19 19 19
7
-1
0 12 15 15
1
7
3 20 20 18

8

5

For the I criterion, there are 31 support points. There is considerable assymetry due
to the discreteness of the candidate set. The I criterion is a measure most appropriatly
visualized with respect to a continuous region. In such a region, the I optimal design is
symmetric and concentrated on a 53 grid.

desCI<-optFederov(~quad(.),dat,approx=T,criterion="I")
dim(desCI$design)
4
[1] 31
apply(desCI$design[,-1],2,table)
$x1

-3 -1
1

9

0
9

1
3
2 10

$x2

25

-3

0
3
9 11 11

$x3

-3
10

0
9

1
3
1 11

Exact designs for three variables in a cube select points from a grid, which can be a
33 for D, but should be a 53 for A and I. The quadratic model has 10 terms, so 15 trial
designs seem appropriate.

An exact design for D may be obtained as follows. (Using the 53 grid so that D and I
statistics may be compared.) There is little to choose between these designs, except that
the I design requires more levels.

dat<-gen.factorial(5,3)
desDE<-optFederov(~quad(.),dat,nTrials=15,evaluateI=TRUE)
desDE[1:5]
$D
[1] 3.675919

$A
[1] 1.255597

$I
[1] 8.848874

$Ge
[1] 0.775

$Dea
[1] 0.749

The optimum approximate theory D is 3.8, making this design about 97\% efficient.

eval.design(~quad(.),desDE$design)
$determinant
[1] 3.675919

$A
[1] 1.255597

$diagonality
[1] 0.755

$gmean.variances

26

[1] 0.2324225

apply(desDE$design,2,table)

X1 X2 X3
5
6
3
4
7
5

6
3
6

-2
0
2

And one for I as follows:

> desIE<-optFederov(~quad(.),dat,nTrials=15,criterion="I")
> desIE[1:5]
$D
[1] 3.485428

$A
[1] 0.9161151

$I
[1] 8.096772

$Ge
[1] 0.582

$Dea
[1] 0.488

The optimum approximate theory I is 7.57, making this design about 93\% efficient.

> eval.design(~quad(.),desIE$design)
$determinant
[1] 3.485428

$A
[1] 0.9161151

$diagonality
[1] 0.809

$gmean.variances
[1] 0.2452361

> apply(desIE$design,2,table)
$X1

-2 -1
1

5

0
4

2
5

27

$X2

-2
5

$X3

-2
5

0
5

0
4

2
5

1
1

2
5

4.2.3.2 Design augmentation Designs sometimes break because certain variable
combinations are not taken, and sometimes the experimenter desires to include certain
points in the design: both requre design agumentation. A boken design usually requires
the region to be constrained: this is discussed in section (4.2.3.5).

Suppose one wants to include the followng trials in a design:

myData<-data.frame(X1=c(0.5,-0.5,-1.0),X2=c(-.05,0.5,-1.0),X3=c(1.5,-0.5,0.5))
myData

X1

X3
X2
1.5
0.5 -0.5
[1,]
[2,] -0.5 0.5 -0.5
0.5
[3,] -1.0 -1.0

Simply add these to the candidate list, and run optFederov() as follows. This may be

compared with the unaugmented design on page 26.

dat<-rbind(myData,gen.factorial(5,3))
desAG<-optFederov(~quad(.),dat,nTrials=15,rows=1:3,augment=TRUE)
desAG
$D
[1] 3.40889

$A
[1] 0.9248038

$Ge
[1] 0.564

$Dea
[1] 0.462

$design

X1

X2
0.5 -0.05

X3
1.5
0.50 -0.5

-0.5

1
2

28

0.5
-1.0 -1.00
3
-2.0 -2.00 -2.0
4
1.0 -2.00 -2.0
7
0.00 -2.0
2.0
18
2.00 -2.0
-2.0
24
2.00 -2.0
0.0
26
2.00 -2.0
2.0
28
0.0
2.0 -2.00
58
0.0
78
2.00
2.0
2.0
104 -2.0 -2.00
2.0
108
2.0 -2.00
2.0
124 -2.0 2.00
2.0
2.00
2.0
128

4.2.3.3 Mixture designs Mixture variables sum to a constant, usually unity. This
constraint con(cid:28)nes the variables to a multidimensional simplex, and requires an adjust-
ment in the model to accommodate the constraint. The following illustrates a mixture
calculation for a quadratic model: note that the constant term is deleted from the model
in order to remove the singularity caused by the mixture constraint. In general the con-
founding is substantial between linear and interaction terms.

dat<-expand.mixture(4,3)
desMix<-optFederov(~-1+.^2,dat,nTrials=8)
desMix
$D
[1] 0.03623366

$A
[1] 98.34085

$Ge
[1] 0.62

$Dea
[1] 0.541

$design

X1

X2

X3
1.0000000 0.0000000 0.0000000
0.6666667 0.3333333 0.0000000
0.0000000 1.0000000 0.0000000
0.6666667 0.0000000 0.3333333
0.0000000 0.6666667 0.3333333
0.3333333 0.0000000 0.6666667
0.0000000 0.3333333 0.6666667

1
2
4
5
6
8
9

29

10 0.0000000 0.0000000 1.0000000

eval.design(~-1+.^2,desMix$design,confounding=TRUE)
$confounding

[,2]

[,1]

[,3]
-1.0000 -0.0026 -0.0526
-0.0026 -1.0000 -0.0526
-0.0501 -0.0501 -1.0000
1.5079
0.1187
2.3628

[,6]
0.0056
0.1122
0.1072
0.2368 -1.0000 -0.3452 -0.1853
2.3684 -0.2230 -1.0000 -0.2538
2.3684 -0.1197 -0.2538 -1.0000

[,4]
0.0922
0.0463
0.0069

[,5]
0.1122
0.0056
0.1072

3.0040
2.3628
0.1187

X1
X2
X3
X1:X2
X1:X3
X2:X3

$determinant
[1] 0.03623366

$A
[1] 98.34085

$diagonality
[1] 0.748

$gmean.variances
[1] 37.19754

4.2.3.4 Large problems The implementation of algorithmic design in optFederov()
is somewhat wasteful of memory. Nonetheless, the program can deal with substantial
problems. Up to 11 variables in a quadratic model on my machine. A more careful
structuring could no doubt push this up to 12 or 13 variables, but larger problems are
not really feasible with a straightforward application of Federov’s algorithms. To deal
with larger problmes, optMonteCarlo() calls optFederov() with a reduced candidate
list obtained by randomly sampling from the full candidate list. The full candidate list
is never created, only the necessary trials are generated. The result, is in general, quite
satisfactory.

As an example, the following may be compared with the design on page 26.

dat<-data.frame(var=paste("X",1:3,sep=""),low=-2,high=2,

center=0,nLevels=5,round=1,factor=FALSE

dat

var low high center nLevels round factor
FALSE
FALSE
FALSE

-2
-2
-2

X1
X2
X3

2
2
2

0
0
0

1
1
1

5
5
5

1
2
3

desMC<-optMonteCarlo(~quad(.),dat)
desMC

30

$D
[1] 3.192013

$A
[1] 1.173419

$Ge
[1] 0.741

$Dea
[1] 0.705

$design

0
0

2
-2

X1 X2 X3
0
0
1
2
0
2
0
-1 -2
3
2
-2 -2
4
0
2
5
1
2
6
0 -2 -2
7
2
2
2
8
9
2 -2
2
10 -2 -1 -2
2 -2
11 -1
2
12
0 -2
13
0
14
1 -2
15 -2

1 -2
2
2 -2

> eval.design(~quad(.),desMC$design,confounding=TRUE)
$confounding

[,1]

[,3]

[,4]

[,2]

-0.0332
-0.0057

...
(Intercept) -1.0000 0.0557 -0.6953 -0.1220 ...
...
X1
...
X2
...
X3
...
I(X1^2)
...
I(X2^2)
...
I(X3^2)
...
X1:X2
...
X1:X3
...
X2:X3

0.0028 -1.0000 0.1509 0.0301
0.1455 -1.0000 -0.1231
0.0283 -0.1198 -1.0000
0.0924 -0.0072
0.2939 -0.0973
0.1719
0.0835 -0.0418
0.1189
0.1204 -0.0712 -0.0099 -0.1240
0.0673
0.0385
0.0151
0.0912
0.0662 -0.0341 -0.0039

-0.0237
0.0932
-0.0004 -0.1114

0.0181

$determinant
[1] 3.192013

31

$A
[1] 1.173419

$diagonality
[1] 0.78

$gmean.variances
[1] 0.2981729

Now for a really big design, a 20 variable quadratic. This takes some time to calculate.
It’s G e(cid:30)ciency is low, but this is typical of large designs. The diagonality could be better.
The determinant of the optimal approximate design is 0.337, thus this design is about
53% e(cid:30)cient, which is acceptable given the di(cid:30)culty of the problem. Increasing nRepeats
may produce a better design.

dat<-data.frame(var=paste("X",1:20,sep=""),low=-1,high=1,

center=0,nLevels=3,round=0,factor=FALSE)

dat
desBig[1:4]
$D
[1] 0.1785814

$A
[1] 27.70869

$Ge
[1] 0.046

$Dea
[1] 0

eval.design(~quad(.),desBig$design)
$determinant
[1] 0.1785814

$A
[1] 27.70869

$diagonality
[1] 0.455

$gmean.variances
[1] 24.51871

As a (cid:28)nal point in this section, let me call your attention to the parameter nCand
which controls the size of the randomly selected candidate list. It is by default set to

32

100 times the number of terms in the model. This may not be large enough for di(cid:30)cult
problems, so try changing if the designs being produced are not satisfactory.

In practice most response surfaces are de(cid:28)ned over
4.2.3.5 Constrained regions
cubical regions, even though quite a bit of optimal design theory is devoted to spherical
regions. The limits of the variables are usually di(cid:30)cult enough to specify without the
additonal complication of dealing with spheres; however, it is common to have inadmissible
corners in which the mechanism underlying the process changes. One way to handle this
is to edit the candidate list, deleting inadmissible points. A better way is to construct a
boundary and allocate candidate points on this boundary. An e(cid:30)cient algorithm for doing
this exists, but has not been implemented as yet. In the meantime, optMonteCarlo()
will accept a constraint function that may be used to exclude points. The best way to
use it is to create a dense gird of candidate points so that the boundary will be roughly
marked by non-eliminated points near it. The following example cuts o(cid:27) the upper half
of a cubical region.

dat<-data.frame(vars=c("A","B","C"),low=-10,

high=10,center=0,nLevels=21,round=1,factor=FALSE)

dat

vars low high center nLevels round factor
FALSE
FALSE
FALSE

A -10
B -10
C -10

21
21
21

10
10
10

1
1
1

0
0
0

1
2
3

constFcn<-function(x){if (sum(x)<=0) return(TRUE);return(FALSE);}
desCon<-optMonteCarlo(~quad(.),dat,constraint=constFcn,nTrials=15)
desCon
$D
[1] 154.4033
$A
[1] 0.9057725
$Ge
[1] 0.456
$Dea
[1] 0.303

The design is no longer concentrated on the support points of the cube. A plot of the
resulting design is shown in Figure (1). It is useful to note that optMonteCarlo() tends
to underpopulate the corners of experimental regions because the probability of random
points falling therein is low.

4.2.4 Starting designs

There are two ways to start the design calculation: at random or by using nulli(cid:28)cation.
Nulli(cid:28)cation is essentially a Gram-Schmidt orthogonalization of the cadidate list, with at
each step picks the longest vector in the null space. Randomization works well in most

33

Figure 1: Plot of a constrained design.

cases, but on occasion will be unable to (cid:28)nd a starting design. Mixture problems are
frequently of this nature. For example, the following will frequently produce singular
designs for the default number of random starts,

dat<-gen.mixture(4,5)
optFederov(~-1+.^2,dat)

but one can be assured of obtaining a design with

optFederov(~-1+.^2,dat,nullify=TRUE)

or with

optFederov(~-1+.^2,dat,nullify=2)

where the second version introduces some randomness in the process. After a starting
design is found with the number of trials equal to the number of terms, additonal trials
will be selected at random to reach the value of nTerms selected.

34

4.3 Blocked designs

The blocking of expermental designs has always been important, and most tables of
classical designs indicate ways in which this may be done. AlgDesign implements several
types of blocking: (A) It will block an existing design, or construct a blocked design from
a candidate set. (B) It will also block a design in which whole plot variables interact
with within plot variables, or (C) it will block designs with multiple levels of blocking.
Cook and Nachtsheim [1989] and Atkinson and Donev [1992] have developed methods for
(A). Goos and Vandebroek [2003] and Trinca and Gilmour [2000] have investigated (B),
and Trinca and Gilmour [2001] have shown how to do (C). The methodologies used in
AlgDesign are di(cid:27)erent from these, although they make use of a fundamential idea from
Cook and Nachsheim (loc.cit.). The methodologies are detailed in Appendix B.

4.3.1 Balanced and partially balanced designs

One can create a balanced incomplete block design for 7 treatments in 7 blocks of size 3 as
may be seen from the level by level table produced by crossprod(). This is a permutation
of Plan 11.7 in Cochran and Cox [1950]. Note how withinData is recycled to (cid:28)ll out the
blocksize requirements.

BIB<-optBlock(~.,withinData=factor(1:7),blocksize=rep(3,7))
crossprod(table(c(rep(1:7, rep(3,7))),BIB$design[,1]))

1 2 3 4 5 6 7
1 3 1 1 1 1 1 1
2 1 3 1 1 1 1 1
3 1 1 3 1 1 1 1
4 1 1 1 3 1 1 1
5 1 1 1 1 3 1 1
6 1 1 1 1 1 3 1
7 1 1 1 1 1 1 3

A partially balanced incomplete block design with two associate classes:

tr<-factor(1:9)
PBIB<-optBlock(~.,withinData=tr,blocksizes=rep(3,9))
crossprod(table(c(rep(1:9, rep(3,9))),PBIB$rows))

1 2 3 4 5 6 7 8 9
1 3 0 1 0 1 1 1 1 1
2 0 3 1 0 1 1 1 1 1
3 1 1 3 1 1 1 0 1 0
4 0 0 1 3 1 1 1 1 1
5 1 1 1 1 3 0 1 0 1
6 1 1 1 1 0 3 1 0 1
7 1 1 0 1 1 1 3 1 0
8 1 1 1 1 0 0 1 3 1

35

9 1 1 0 1 1 1 0 1 3

4.3.2 Blocking illustration

A di(cid:30)cult two level factorial will be used to illustrate blocking. The usual methods for
constructing half fractions of a 27 completely confound some second order e(cid:27)ects. In the
following design, all second order e(cid:27)ects are estimable, but the design is not particulary
orthogonal.

dat<-gen.factorial(2,7)
desF<-optFederov(~.^2,dat,nTrials=32,nRepeats=100)
desF[1:4]
$D
[1] 0.8868

$A
[1] 1.296784

$Ge
[1] 0.412

$Dea
[1] 0.241

The 32 trials of the design may be blocked into four blocks of eight, as follows:

desFBlk<-optBlock(~.^2,desF$design,rep(8,4),nRepeats=20)
desFBlk[1:3]
$D
[1] 0.8049815

$diagonality
[1] 0.842

$Blocks
$Blocks$B1

X1 X2 X3 X4 X5 X6 X7
1 -1 -1
1 -1 -1
1 -1
1
1
1
1
1

22
1 -1
1 -1
32
1
1
1
1
39
1
-1
1 -1 -1
68
1 -1 -1 -1 -1
1
1 -1
1 -1 -1
83
-1
1 -1
1 -1
1
1
88
1
105 -1 -1 -1
116
1
1
...

1 -1
1

1 -1 -1

36

This is a good blocking with high diagonality. A further evaluation can be found from:

eval.blockdesign(~.^2,desFBlk$design,rep(8,4))
$determinant.all.terms.within.terms.centered
[1] 0.8868

$within.block.efficiencies

1.000
rho
lambda.det
0.926
lambda.trace 0.901

$comment
[1] "Too few blocks to recover interblock information."

$block.centered.properties

df
determinant
gmean.variance
gmean.efficiencies 1.000000

constant
1

within
28
0.804982
1.000000 1.000000 1.476160
0.875

whole
1

1.000

The most important measure of the blocking is the within blocking e(cid:30)ciency, which
shows that the blocking is quite successful in decoupling the whole and within block
e(cid:27)ects. The within.blocking.efficiencies table shows the e(cid:30)ciency for rho=1, when
the whole and within block errors are equal. Other choices for rho may be made when
running the eval.blockdesign() program.
It is good that there is little interblock
information to recover, since the number of blocks is too small to enable such an analysis.

The gmean.efficiencies for the within terms measures the ratio of variances of
centered to block centered designs, and indicates that there is some loss due to blocking.

One can input the entire candidate set to optBlock(), but sometimes, as in the present
case, the optimum blocked design is hard to (cid:28)nd, and the results will be disappointing as
the following illustrates.

desFBlkD<-optBlock(~.^2,dat,rep(8,4),nRepeats=20)
desFBlkD[1:2]
$D
[1] 0.7619454

$diagonality
[1] 0.777

In this case it is better to start optBlock() with a good existing design, as follows.

rr<-as.numeric(rownames(desF$design))
desFBlkD<-optBlock(~.^2,dat,rows=rr,rep(8,4),nRepeats=20)
desFBlkD[1:2]

37

$D
[1] 0.8049815

$diagonality
[1] 0.838

4.3.3

Improving individual blocks with the Dp criterion

Two fractions of a 24 will be obtained from

dat<-gen.factorial(2,4)
od<-optBlock(~.,dat,c(8,8))
od

$D
[1] 1

$diagonality
[1] 1

$Blocks
$Blocks$B1

-1
1

X1 X2 X3 X4
-1 -1 -1 -1
1 -1 -1 -1
1 -1
1 -1
1
1
1
1

1
1
-1 -1 -1
1 -1
1
1

1
2
7
8
9
12
14
15 -1

1
1 -1
1

$Blocks$B2

X1 X2 X3 X4
1 -1 -1
-1
1 -1 -1
1
1 -1
1 -1
1
1
1
1

-1 -1
1 -1
1 -1 -1
1 -1
1
1

3
4
5
6
10
11 -1
13 -1 -1
1
1
16

This is an optimal design. It is orthogonal:

bk<-data.matrix(od$design)
t(bk)%*%bk

38

X1 X2 X3 X4
0
0
0
0 16

0
0 16
0
0

0
0
0 16
0

X1 16
X2
X3
X4

However the individual blocks are not orthogonal:

bk<-data.matrix(od$Blocks$B1)
t(bk)%*%bk

X1 X2 X3 X4
0
0
0
8

0
8
4
0

0
4
8
0

8
0
0
0

X1
X2
X3
X4

One can optimize with the Dp criterion to improve this situation. Either crite-

rion="Dp" or criterion="Dpc" may be used.

od1<-optBlock(~.,dat,c(8,8),criterion="Dpc")
bk<-data.matrix(od1$Blocks$B1)
t(bk)%*%bk

X1 X2 X3 X4
0
0
0
8

0
8
0
0

8
0
0
0

0
0
8
0

X1
X2
X3
X4

The Dp criterion may be used to (cid:28)nd standard fractions; however, there are many
optimal designs in additon to the standard fractions, and these are the most likely result.
For example, the following will sometimes produce half fractions with the de(cid:28)ning con-
trast -X2X3X4, but more often the cross-product matrix will be cluttered, although still
representing an optimum design. Note, the model now contains second order terms.

od2<-optBlock(~.^2,dat,c(8,8),criterion="Dpc",nR=1000)
od2[1:2]
$D
[1] 1

$Dpc
[1] 1

dt<-model.matrix(~.^2,od2$Blocks$B1)
t(dt)%*%dt

39

(Intercept)
X1
X2
X3
X4
X1:X2
X1:X3
X1:X4
X2:X3
X2:X4
X3:X4

(Intercept) X1 X2 X3 X4 X1:X2 X1:X3 X1:X4 X2:X3 X2:X4 X3:X4
0
0
-8
0
0
0
0
0
0
0
8

0
0
0
0
0
0
0
8
0
8
0 0
0 0
0 0
0 -8
0
0

0
0
8
0
0
0
0
0
0
0 -8
0

0
8
0
0
0
0
0
0
0
0
0 -8

0
0
0
0
-8
0
0
0
8
0
0

0
0
0
-8
0
0
0
0
0
8
0

0
0
0
0
0
0
8
0
0
0
0

0
0
0
0
0
0
0
8
0
0
0

0
0
0
0
0
8
0
0
0
0
0

8
0
0
0
0
0
0
0
0
0
0

4.3.4 Orthogonal Blocking (cid:21) Nguyen’s ideas

Orthogonal blocking occurs when the means of the variables within the blocks equal the
means of the variables over all blocks, or what is the same that the means of the variables
are the same within each block. This is (cid:16)orthogonal(cid:17) because if one subtracts the means
from the variables, then their sums within each block will be zero. The Nguyen [2001]
algorithm successively switches trials between blocks until their means become equal.
His criterion is the sum of squares of the centered data. His idea has been extended in
optBlock() to allow for interactions between whole and split block factors and to allow
new points from a candidate list to be exchanged with those in the design (cid:21) Nguyen
considered only rearranging the trials in a (cid:28)xed design.

A simple example will illustrate the method. The blocks are orthogonal in this exam-
ple, but as in previous examples the variables are not mutually orthogonal within blocks.
Note that the minimim value of the sums of squares of the S matrix is reported.

dat<-gen.factorial(2,4)
ob<-optBlock(~.,dat,c(8,8),criterion="OB")
ob[1:3]
$D
[1] 1

$SS
[1] 0

$Blocks
$Blocks$B1

1

X1 X2 X3 X4
-1 -1 -1 -1
1 -1 -1
1 -1
1 -1
1
1

-1 -1
1
1
1 -1 -1
1 -1
1

1
4
5
8
10
12

40

13 -1 -1
15 -1
1
...

1
1

1
1

> bk<-data.matrix(ob$Blocks$B1)
> t(bk)%*%bk

X1 X2 X3 X4
0
4 -4
0
0
8
0
8
0
8
0
0

8
X1
X2
4
X3 -4
0
X4

A more instructive example follows. In this example, a standard fractional factorial

with de(cid:28)ning contrast −X1X3X4 is found.

ob2<-optBlock(~.^2,dat,c(8,8),crit="OB")
dt<-model.matrix(~.^2,ob2$Blocks$B1)
t(dt)%*%dt

(Intercept)
X1
X2
X3
X4
X1:X2
X1:X3
X1:X4
X2:X3
X2:X4
X3:X4

(Intercept) X1 X2 X3 X4 X1:X2 X1:X3 X1:X4 X2:X3 X2:X4 X3:X4
0
-8
0
0
0
0
0
0
0
0
8

0
8
8
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0 -8

0
0
0
0
0
0
0
8
0
8
0 0
0 -8
0
0 0
0 0
0
0

0
0
8
0
0
0
0
0 -8
0
0
0

0
0
0
-8
0
0
0
8
0
0
0

0
0
0
0
-8
0
8
0
0
0
0

0
0
0
0
0
0
0
0
8
0
0

0
0
0
0
0
0
0
0
0
8
0

0
0
0
0
0
8
0
0
0
0
0

4.3.5 Blocking with whole plot factors (split plots)

The blocks are often interesting, representing transitory manufacturing or other constraint
conditions on the experiment.
If for example, one must block an experiment because
only a subset of the trials may be performed each day, then there is little reason to be
interested in the average response on a particular day. Sometimes, however, blocks are
more interesting, and can comprise variables of importance in a study. A common problem
occurs when a variable is di(cid:30)cult or expensive to change, such as a temperature setting
that requires hours to come to equilibrium. In such cases, the experiment can be quite
lengthy if one insists on a full randomization; and it is usual to compromise and repeat
a substantial fraction of the experiment without changing the setting of the (cid:16)di(cid:30)cult(cid:17)
variable. Split plot experiments represent a similar structure, where the experimental

41

factors are divided into (cid:16)whole plot(cid:17) and (cid:16)within plot(cid:17) groups. In these cases, the whole
plot variables are in and of themselves interesting and must be studied with the rest.

Unfortunately, whole plot main e(cid:27)ects seldom have su(cid:30)cient replication and thus have
low power, but this is another problem. The problem of interest is the structure of the
within plot factors and their interactions with the whole plot factors. A design for a
quadratic model is given in Goos and Vandebroek [2003] for a problem of this nature.

data(GVTable1)
GVTable1

w s1 s2 s3 s4
1
1
1 -1
0 -1 -1
1
1 -1
1
1
1

[1,] -1 1 -1 -1
[2,] -1 1
[3,] -1 -1
[4,] -1 1
[5,] -1 -1
...
[38,]
[39,]
[40,]
[41,]
[42,]

1
1 -1
1 -1
1
1 -1
1 -1 -1 -1

1 -1 -1
1
1 -1

1
1 -1
1
1 -1
1

An evaluation of this design reveals the following. There is one whole plot factor, (cid:16)w,(cid:17)
and four within plot factors (cid:16)s1(cid:17) through (cid:16)s4.(cid:17) Thus there are three df for whole plots
and 18 for within plots.

eval.blockdesign(~quad(.),GVTable1,rep(2,21))
$determinant.all.terms.within.terms.centered
[1] 0.4814902

$within.block.efficiencies

1.000
rho
lambda.det
0.732
lambda.trace 0.745

$block.centered.properties

df
determinant
gmean.variance
gmean.efficiencies 1.347614

constant
1

within
18
0.279146
7.000000 3.086710 4.351714
0.500

whole
2

1.234

This design has a non-uniform allocation for the whole plot factor as shown below.
This is due to the fact that the algorithm used, optimized the D criterion for both the
whole and within factors. The whole plot allocation is not optimal for a single factor,
which means that a tradeo(cid:27) in e(cid:30)ciencies has occurred between the whole and within

42

parts in the design construction. In view of the replication di(cid:30)culty for whole plot factors,
mentioned above, one wonders about the wisdom of this.

table(GVTable1[,1])

-1
18

0
1
6 18

The optBlock() design for this problem may be obtained as follows. Note: the whole
plot design used is the optimum design for a single quadratic factor. It may be seen that
the various properties for the two designs are quite similar: the centered determinant
for the GVTable1 design is larger, but the variances are a bit better for the optBlock()
design.

within<-gen.factorial(3,4,varNames=c("s1","s2","s3","s4"))
whole<-data.frame(w=rep(c(-1,0,1),rep(7,3)))
desProt<-optBlock(~quad(.),withinData=within,

wholeBlockData=whole,blocksizes=rep(2,21),nR=100)

eval.blockdesign(~quad(.),desProt$design,rep(2,21))
$determinant.all.terms.within.terms.centered
[1] 0.4559886

$within.block.efficiencies

1.000
rho
0.738
lambda.det
lambda.trace 0.734

$block.centered.properties

df
determinant
gmean.variance
gmean.efficiencies 1.107215

constant
1

within
18
0.268965
3.000000 2.598076 4.055509
0.581

whole
2

1.209

One can of course, optimize the within design before blocking, and as may be seen

from the following, it does not do quite as well in this case as the above.

dat<-gen.factorial(3,5,varNames=c("w","s1","s2","s3","s4"))
des<-optFederov(~quad(.),dat,nT=42,nR=100)
od<-optBlock(~quad(.),with=des$design,who=whole,rep(2,21),nR=100)
eval.blockdesign(~quad(.),od$design,rep(2,21))
$determinant.all.terms.within.terms.centered
[1] 0.4660674

$within.block.efficiencies

rho

1.000

43

0.718
lambda.det
lambda.trace 0.704

$block.centered.properties

df
determinant
gmean.variance
gmean.efficiencies 1.450530

constant
1

within
18
0.267203
3.000000 2.598076 4.306051
0.532

whole
2

1.434

A second example from Goos and Vandebroek [2003] is available as (cid:16)GVTable3,(cid:17) as well
as a design, produced by the Trinca and Gilmour Trinca and Gilmour [2001] methodology
for this problem, in the (cid:28)le(cid:16)TGTable5(cid:17) The reader may like to compare the GVTable3
design with one generated by optBlock().

4.3.6 Multistratum blocking

Most tabled designs are provided with more than one level of blocking. For example the
incomplete block designs given in Chapter 11 of Cochran and Cox [1950] have both blocks
and replicates, with a set of blocks being allocated to each replicate. It is not obvious
how this may be achieved algorithmically without considerable complications. Trinca and
Gilmour [2000] have shown, however, that it is quite easy with the repeated running of
standard algorithms. In essence, they observed that a multidimensional blocking problem
may be viewed in a sequential fashion in which at each step in the sequence one need only
consider the blocking resulting from all previous steps and the current step. Subsequent
steps can be ignored, and the current problem requires only a speci(cid:28)cation of whole and
within block factors using existing algorithms.

This is perhaps best explained by giving an example. The partially balanced incom-
plete block design on page 453 of Cochran and Cox (loc cit) is as follows. This is available
as data set CCTable11.1a.

Table 6: A 3 × 3 Tripple Lattice

Block Rep. I
(1)
(2)
(3)

1
4
7

2
5
8

Rep. II
7
4
1
8
5
2
9
6
3

(4)
(5)
(6)

Rep. III
9
6
1
6
2
7
3
8
4

(7)
(8)
(9)

3
6
9

There are two levels of blocking, Rep, and Block, and the trials are nested in both.
The idea is to construct a blocked design using the (cid:28)rst two variables, Rep and Block,
and then construct the (cid:28)nal design using this to describe the whole block structure. Thus

Rep<-gen.factorial(3,1,factor=1,varName="Rep")
Block<-gen.factorial(3,1,factor=1,varName="Block")
firstDesign<-optBlock(~.,within=Block,whole=Rep,blocks=rep(3,3))
firstDesign$Blocks

44

$B1

1
1.1
1.2

$B2

2
2.1
2.2

$B3

3
3.1
3.2

Rep Block
1
2
3

1
1
1

Rep Block
1
2
3

2
2
2

Rep Block
1
2
3

3
3
3

Of course we could have written this down at once, but the above illustrates the
method. Now a design is created using the (cid:28)rstDesign to describe the whole blocks
structure.

Runs<-gen.factorial(9,1,factor=1,varName="Runs")
finalDesign<-optBlock(~.,within=Runs,whole=firstDesign$design,rep(3,9))

I have tabled the (cid:28)nal design in the same form as in Table 6. The (cid:28)nalDesign is not
as symmetrical as the one from Cochran and Cox, in which there are no duplicate runs
in a replicate, but that aside, its properties seem as good.

Table 7: A 3 × 3 Algorithmic blocking

Block Rep. I
(1)
(2)
(3)

5
3
1

6
4
3

Rep. II
7
4
2
7
5
1
9
8
2

(4)
(5)
(6)

Rep. III
6
2
1
9
5
4
8
7
3

(7)
(8)
(9)

8
6
9

For the Cochran and Cox design, one has:

data(CCTable11a.1a)
eval.blockdesign(~.,CCTable11.1a,rep(3,9),rho=c(0.5,1,10))
$determinant.all.terms.within.terms.centered
[1] 0.2430429

$within.block.efficiencies

0.500 1.000 10.000
rho
0.744
0.808 0.783
lambda.det
0.734
lambda.trace 0.800 0.774

45

$comment
[1] "Too few blocks to recover interblock information."

$block.centered.properties

df
determinant
gmean.variance
gmean.efficiencies 1.000000

constant
1

within
8
0.107887
1.000000 2.000000 11.000000
0.815

whole
4

1.225

Both designs are partially balanced, but it is not possible to recover interblock information
on all terms.

eval.blockdesign(~.,finalDesign$design,rep(3,9),rho=c(.5,1,10))
$determinant.all.terms.within.terms.centered
[1] 0.2400636

$within.block.efficiencies

0.500 1.000 10.000
rho
0.743
lambda.det
0.800 0.778
0.733
lambda.trace 0.791 0.768

$comment
[1] "Too few blocks to recover interblock information."

$block.centered.properties

df
determinant
gmean.variance
gmean.efficiencies 1.000000

constant
1

within
8
0.107887
1.000000 2.000000 11.000000
0.834

whole
4

1.315

Trinca and Gilmore (loc.cit.) give more substantial examples. An evaluation of their
example given in the data set TGTable3 follows. In this problem there are four three level
variables, and three levels of blocking. The (cid:28)rst blocking is into (cid:28)ve blocks. The second
introduces two of the variables with a quadratic model and creates three sub-blocks in
each of the (cid:28)ve blocks. The (cid:28)nal blocking introduces two more variables in a quadratic
model interacting with the (cid:28)rst two and themselves in three sub-sub blocks, for a 45 trial
design.

data(TGTable3)
eval.blockdesign(~Block+quad(X1,X2,X3,X4),TGTable3,rep(3,15))
$determinant.all.terms.within.terms.centered
[1] 0.3808839

$within.block.efficiencies

46

1.000
rho
lambda.det
0.944
lambda.trace 0.939

$comment
[1] "Too few blocks to recover interblock information."

$block.centered.properties

df
determinant
gmean.variance
gmean.efficiencies 1.000000

constant
1

within
9
0.385155
3.857143 3.906399 2.602162
0.938

whole
9

1.018

which may be compared with the following produced by optBlock

Blocks<-data.frame(Block=factor(1:5))
firstVars<-gen.factorial(3,2)
secondVars<-gen.factorial(3,2,varNames=c("X3","X4"))
firstDesign<-optBlock(~Block+quad(X1,X2),

within=firstVars,whole=Blocks,block=rep(3,5),nR=100)

secondDesign<-optBlock(~Block+quad(X1,X2,X3,X4),

within=secondVars,whole=firstDesign$design,rep(3,15),nR=100)

eval.blockdesign(~Block+quad(X1,X2,X3,X4),

secondDesign$design,rep(3,15))

$determinant.all.terms.within.terms.centered
[1] 0.3951278

$within.block.efficiencies

1.000
rho
0.924
lambda.det
lambda.trace 0.907

$comment
[1] "Too few blocks to recover interblock information."

$block.centered.properties

df
determinant
gmean.variance
gmean.efficiencies 1.126339

constant
1

within
9
0.408619
7.145839 3.426712 2.457743
0.970

whole
9

1.061

47

5 Appendix A: Federov’s algorithm

This is a rephrasing of the material inFederov [1972] in the form used by optFederov().
Its primary use is as an aid in maintaining the package. Those interested in the general
ideas will be better served by reading Federov’s book.

Let M be the k × k dispersion matrix of a design, and consider the update involving
removing the k vector y and replacing it with the k vector x. This can be represented as
M + F F T , where F = (x, iy), giving rise to the usual representations:

M −1
1
M −1
1
|M + F F T | = |M ||I2 + F T M −1F |.

= (M + F F T )−1,
= M −1 − M −1F (I2 + F T M −1F )−1F T M −1,

If duv = uT M −1v, and du ≡ duu, then |I2 + F T M −1F | = (1 + dx)(1 − dy) + d2

xy =
xy) − dy] = 1 + ∆D. For the D criterion, max∆D over the candidate

1 + [dx − (dxdy − d2
vectors is used in choosing points to add in the sequential algorithm.

For linear criteria, things are more complicated. A linear criterion, L(), is a function
such that for two dispersion matrices A and B one has L(A + B) = L(A) + L(B). The A
and I criteria are linear. For such criteria, one has

L(M −1

1 ) = L(M −1) − L(M −1F (I2 + F T M −1F )−1F T M −1),

or

L(M −1) − L(M −1

1 ) = ∆L = L(M −1F (I2 + F T M −1F )−1F T M −1),

and the sequential algorithm uses ∆L in choosing points to add in the sequential algo-
rithm. This representation assumes that it is desired to decrease the criterion value by
the addition of new points.

First note that

(I2 + F T M −1F )−1 =

(cid:32) 1 − dy −idxy
1 + dx

−idxy

(cid:33)

/(1 + ∆D).

Then let ϕuv = L(M −1uvT M −1), and ϕu ≡ ϕuu, and from this one can see that

∆L = {(1 − dy)ϕx + dxy[ϕxy + ϕyx] − (1 + dx)ϕy}/(1 + ∆D).

The linear algorithm chooses points to maximize ∆L, and thereby decreases the crite-

rion.

For the A criterion, one has ϕuv = trace(M −1uvT M −1) = vT M −2u, and for the I
criterion, one has ϕuv = trace(BM −1uvT M −1) = vT M −1BM −1u, where B = X T X/N ,
and the N × k matrix X is the matrix of candidate vectors.

48

6 Appendix B: Blocking designs

6.1 Background

6.1.1 Blocking models

One starts with the usual model:

Y = Xβ + ϵ,

where Y is an N × 1 vector of observations, X is an N × k design matrix, ϵ is an N × 1
vector of iid errors with common variance σ2, and β is a k × 1 parameter vector.

In general the rows of X are randomized. Blocking occurs when this randomization
is restricted in a way that causes disjoint sets of the rows of X to be randomized within
sets. As Lorenzen and Anderson [1993] show, this has the e(cid:27)ect of changing the model to

Y = Xβ + Zθ + ϵ,

(3)

where Z is an N × b matrix of block indicator variables, each column containing 1 or 0 as
the corresponding observation appears or not in the block represented by the column, and
θ a b element random vector whose elements are uncorrelated with ϵ, and are mutually
uncorrelated and identically distributed, with common variance σ2
b .

For this model, the variance of Y is V = σ2(I + ρZZ T ), where ρ = σ2

b /σ2, and thus the
generalized least squares estimate of β is ˆβ = (X T V −1X)−1X T V −1Y , and the covariance
matrix of the estimates is

var( ˆβ) = (X T V −1X)−1,

(4)

which unfortunately depends on σ2

b in an essential way.
The aim of algorithmic design is the optimization of some aspect of var( ˆβ), which
becomes di(cid:30)cult when var( ˆβ) depends on an unknown parameter. A straightforward
approach to this problem in which the designs are dependent on the unknown variance
parameter, may be found in Goos and Vandebroek [2003], where the block factors are
(cid:16)slow(cid:17) factors which may not easily be changed, and thus in a sense, force the design
process into a split-plot type model.

In order to deal with the blocking problem it is necessary to inquire more closely into
the structure of the model. The key to the problem is the treatment of intrablock and
interblock information. Intrablock information involves σ2, while interblock information
involves both σ2 and σ2
Indeed, as will be seen, choosing a design that maximizes
b .
intrablock information will in many cases solve the problem. A design in which the blocks
are orthogonal cleanly separates the two types of information

49

An attractive formulation for this problem uses a rewritten version of (3) which de-
couples the within and between block variables. The idea is due to Cook and Nachtsheim
[1989].

The columns of X may be divided into three types, X = [Xb, Xwb, Xw]. The rows in
Xb are constant within blocks and represent block factors. The rows in Xw vary within
blocks, and the rows in Xwb represent interactions between the block factors and the
within block factors. It is convenient to rewrite the model (3) as

Y = Xaβa + Xbβc + Zθ + ϵ,

where Xa = [Xw, Xwb], and the parameters are conformably partitioned as βa and βc.
The matrix Xb often contains only the constant column.

A better representation of the model for our purposes, is the block centered form:

Y = ˜Xaβa + Xbβb + Zθ + ϵ.

(5)

Here ˜Xa is the block centered form of Xa obtained by subtracting block means from each
row of Xa. In this, the parameter βa is unchanged, but the second parameter changes to
βb, representing the change due to absorbing the block means from Xa: the space spanned
by the columns of X is unchanged. It is assumed that no columns of ˜Xa are identically
zero. In this form ˜X T

Xb ≡ 0, and it is easy to see that

a Z ≡ 0, and ˜Xa

T

var( ˆβa) = ( ˜Xa

T ˜Xa)−1σ2,

because σ2V −1 = I − Z(I/ρ + Z T Z)−1Z T .

Thus the estimates ˜βa and their covariances do not depend on ρ.

The interesting thing, is that something similar occurs for βb. Let σ2V = I − ZGZ T ,
where G = (I/ρ + D)−1, and D = Z T Z. Assume that the block sizes are all of size
n, then G is a constant times the identity, and σ2V −1 = I − ρ
1+ρnZZ T . Noting that
nX T

b ZZ T Xb, one has

b Xb = X T

var( ˆβb) = σ2(X T

b Xb −

nρ
1 + ρn

X T

b ZZ T Xb)−1 = σ2(1 + ρn)(X T

b Xb)−1.

(6)

Thus, designs which optimize a criterion for both var( ˆβa) and var( ˆβb) may be found
without reference to ρ. When the block sizes are not constant, this conclusion is no
longer precise, but only approximate. There is considerable merit in keeping the block
sizes constant, since in the analysis the usual residual mean squares may be used to
estimate both variances.

Goos and Vandebroek choose the D criterion, and maximized |X T V −1X|.

In their
formulation the maximizing design depends on ρ. In the model (5) the determinant is
| ˜X T
b Xb|/σ4(1 + ρn), and the maximizing design does not depend on ρ.
a

˜Xa||X T

50

The value of | ˜X T
˜Xa| depends on Xb, which means that simply choosing Xb to maximize
a
|X T
b Xb|, may not lead to a maximal product, and indeed it does not; however, numerical
comparisons show that the e(cid:27)ect is small, and a good strategy would seem to be to use
an Xb that maximizes |X T
b Xb|. An additional point worth noting, is that the variance
for the whole block factors is larger than for the within block factors, and that a design
which does not make |X T

b Xb| as large as possible represents a questionable tradeo(cid:27).

6.1.2

Interblock, intrablock information and optimal blocking.

The matrix ˜X T
˜Xa represents what has traditionally been called, intrablock information.
a
It is maximized when all the block means are equal. Let ˇXa be Xa centered about the
grand mean vector g, then ˇX T
a Xa − N ggT , where N = Σni and the ni are the
a
block sizes. For mi the block means, this gives

ˇXa = X T

˜X T
a

˜Xa = X T

a Xa − Σ(nimimT

i ) = ˇX T

a

ˇXa − Σ[ni(mi − g)(mi − g)T ].

If g is (cid:28)xed, then clearly the trace of ˜X T
a
similar argument can be made about the determinant since | ˜X T
a
Σ[ni(mi − g)(mi − g)T ] is non-negative de(cid:28)nite.

˜Xa is maximized when all mi are equal to g. A
ˇXa| > 0 and

˜Xa| > 0, | ˇX T

a

When the block means are all equal to the grand mean, ˇXa is orthogonal to Z, and

all information about βa is intrablock.

The distinction between interblock and intrablock is best understood in terms of the
analysis. When the block means di(cid:27)er, it is sometimes possible to use the block means to
form an additional estimate of βa, say ˆβ′
a. Such an estimate is referred to as an interblock
estimate, see [Sche(cid:27)Ø, 1959, p170(cid:27)]. The intrablock estimate is ˆβa = ( ˜X T
a Y ,
with the estimate ˆσ2 obtained from the residual variance. The interblock estimate is
formed from the block means of the several matrices, ˆXa, ˆXb, and ˆY in a similar fashion,
a, ˆβb) and the estimate ˆη2 from the residual variance: equation (6) applies
to obtain ( ˆβ′
when the block sizes are equal, and of course, there must be at least as many blocks
as parameters. These estimates are independent when Y is normally distributed. The
(cid:28)nal estimate is ( ˆβa ˆη2 + ˆβ′
aˆσ2)/(ˆη2 + ˆσ2), where E(ˆη2) = σ2(1 + ρn). Sche(cid:27)Ø suggests
that approximate tests may be made by substituting the estimates for their expectations.
Since the variance of the (cid:28)nal estimate, using this approximation, is σ2η2/(σ2 + η2), the
precision of the combined estimate is always smaller than the variance of the intrablock
estimate alone.

˜Xa)−1 ˜X T

a

6.1.3 Measuring intrablock information

The quality of a blocking design may be measured by the amount of interblock informa-
tion absorbed by the block means. Measures of this quality have been used to develop
algorithms for orthogonal blocking,Nguyen [2001].

Consider the model

51

Y = ˇXaβa + Xbβb + Zθ + ϵ.

(7)

which is similar to (5) except that ˇXa is Xa centered about the grand mean instead of
being block centered. We will use the same symbol βb for the block parameter, since in
the case of orthogonal blocking, it is the same as in equation (5).
If the block means
contain no information about βa, then residuals of ˇXa regressed on Xb will be equal to
ˇXa, and thus a measure of the magnitude of these residuals can be used to assess the
quality of the design. The following makes this explicit.

First observe that for non-singular C, the upper left partition of the inverse appears

as follows:

(cid:32) A
B

(cid:33)−1

=

BT
C

(cid:32) (A − BT C −1B)−1

.

(cid:33)

.
.

(8)

Noting that V −1 = I − Z(I/ρ + D)−1Z T = I − ZGZ T with G = (I/ρ + D)−1 and D =
Z T Z, one can write the following expressions for the covariance matrix of the estimates:

C = σ2

(cid:32) ˇX T
X T

a V −1 ˇXa
b V −1 ˇXa

ˇX T
X T

a V −1Xb
b V −1Xb

(cid:33)−1

= σ2

(cid:32) M − ST GS
H T − T T GS

H − ST GT
N − T T GT

(cid:33)−1

,

where M = ˇX T
a

ˇXa, N = X T

b Xb, S = Z T ˇXa, T = Z T Xb, H = ˇX T

a Xb.

For orthogonal blocking S ≡ 0 and H ≡ 0, and thus6

C0 = σ2

(cid:32) M
0

0
N − T T GT

(cid:33)−1

.

A measure of the degree of orthogonal blocking is the ratio of criterion values for the
within block portions of C and C0. Using equation (8) one has the following ratio λD, for
the determinant criterion. (It may help to note that the quantity in the numerator of λD
represents a measurement of the residuals of ˇXa regressed on Xb.)

λD = (|M − ST GS − (H − ST GT )(N − T T GT )−1(H T − T T GS)|/|M |)1/k

Here k is the dimension of M .

When Xb ≡ Z, this simpli(cid:28)es to

λD = (|M − 2ST D−1S + ST D−1GDS|/|M |)1/k,

6It is useful to note, from equation (6), that when all blocks have the same size, n, that N − T T GT =
N
(1+ρn) .

52

and to

λD = (|M − ST D−1S|/|M |)1/k,

when ρ is in(cid:28)nite; that is when the whole blocks are uninformative.

If one interprets λD as a measure of intrablock information, then 1 − λD is a measure

of the interblock information that remains to be recovered by a interblock analysis.

It may be seen that λD is maximized by minimizing S. This is the essence of the
orthogonal blocking algorithm of Nguyen [2001], which he does by minimizing the sum
of squares of S. The idea is easily extended to the case where whole block factors are
present.

6.1.4 Analysis of blocked experiments

The analysis of a blocked experiment is complicated by the fact that there are several
variance components. The usual procedure is to estimate these by REML ,Corbeil and
Searle [1976], which produces a maximum likelihood estimate using the residuals from
a (cid:28)xed e(cid:27)ect analysis. There is in general no closed form and the solution is numerical.
When the block sizes are equal, REML is not needed, because the usual residual estimates
of variance are correct. In many unbalanced cases the error committed by ignoring the
di(cid:27)erence in block sizes is small:
it is sometimes less than the error in the numerical
solution involved in the maximum likelihood calculations.

The parameter σ2 may be estimated from the residual variance when estimating βa in
b + σ2/n, where n is the common block size, may be obtianed

model (5). An estimate of σ2
from the residual variance of the model

ˆY = ˆXbβb + Iθ + ˆϵ,

where the hat’s denote averages over the blocks, and I is the identity matrix.

6.1.5 Multistratum models

The model (5) may be extended to allow for several strata of blocking: see Trinca and
Gilmour [2001]. For two strata, the model is

Y = ˜˜X aβa + ˜Xbβb + Xcβc + Zbθb + Zcθc + ϵ,

where Zb and Zc are matrices of block indicator variables, and ˜Xb and Xc are, respectively,
their matrices of block factors. Here ˜Xb is centered with respect to Zc so that ˜X T
b Zc ≡ 0.
a Zc ≡ 0. The
In additon
algorithmic blocking proceeds sequentially: (cid:28)rst blocking Xa with respect to Zb, and then
(Xa|Xb) with respect to Zc.

˜˜X a is centered for both blocks so that ˜X T

a Zb ≡ 0 and ˜X T

53

6.2 Alternative criteria

a

The D criterion minimizes the determinant of var( ˆβa) or equivalently, maximizes | ˜Ma|,
where ˜Ma = ˜X T
˜Xa. This is an attractive criterion for blocking. Among other attributes
is the fact that D-optimum blocking also tends make the design as orthogonal as possi-
ble. The D criterion minimizes the overall variance of the estimates, but this does not
guarantee that the individual blocks will be maximal in any sense. In situations where
only a subset of the blocks are to be run, the parameters should be well estimated from
the individual blocks. This suggests a criterion like

Dpc =

(cid:32) b
(cid:89)

i

| ˜Mi/ni|1/k

(cid:33)1/b

,

with ˜Mi = ˜X T
to the b blocks of size (ni, i = 1 . . . b). One can also consider the alternative criterion:

˜Xi, where ( ˜Xi|i = 1 . . . b) are the ni × k sub-matrices of ˜Xa corresponding

i

Dp =

(cid:32) b
(cid:89)

i

(cid:33)1/b

|Mi/ni|1/k

,

where Mi = X T
i Xi, and where (Xi|i = 1 . . . b) are the ni × k sub-matrices of Xa corre-
sponding to the b blocks of size (ni, i = 1 . . . b). Depending on one’s viewpoint, this may
or may not seem as attractive from a theoretical point of view.

Of course singularity can occur, but this may be dealt with by taking the determinants
of the largest leading, non-singular submatrices. This will usually mean the leading (ni ×
ni) submatrix of Mi and the leading (ni − 1 × ni − 1) submatrix of ˜Mi when ni ≤ k.

6.3 Updating equations for the Dpc criterion.

In this section, it is assumed that X ≡ Xw. Let X be the unadjusted matrix from
which ˜X is obtained by subtracting block means. Let the means of the columns of Xi be
i 1ni, where 1ni is a column vector of ni unities, then ˜Xi = Xi − 1ni ¯xT
¯xi = 1
i .
ni

X T

Let xT

ri be a row of Xi and xT

rj be a row in some other block. I will develop equations
for updating ˜Xi and the corresponding information matrix, when xri is swapped with xrj .
Let Xi,rirj be Xi after the swap, then Xi,rirj = Xi + αri(xrj − xri)T , where αri is a
column vector of ni elements all of which are zero except the one corresponding to xri,
which is unity. Similarly, the new block mean is ¯xi,rirj = 1
(xrj − xri).
ni

1ni = ¯xi + 1
ni

X T

i,rirj

Combining these expressions gives an expression for the updated centered matrix:

˜Xi,rirj = ˜Xi + (αri −

1
ni

1ni)(xrj − xri)T .

(9)

From this one obtains,

54

˜Xi,rirj = ˜X T

˜Xi + (xri − ¯xi)(xrj − xri)T + (xrj − xri)(xri − ¯xi)T +

)(xrj − xri)(xrj − xri)T ,

(10)

˜X T

i,rirj

or

i
ni − 1
ni

(

˜X T

i,rirj

˜Xi,rirj = ˜X T

i

˜Xi + (xrj − ¯xi)[2] − (xri − ¯xi)[2] −

1
ni

(xrj − xri)[2],

(11)

where a[2] ≡ aaT .

In an obvious fashion we can write the right hand side as

˜X T
i

˜Xi + ViBiV T
i ,

(12)

where Vi is a k by 3 matrix and Bi is diagonal. Let Si = ViBiV T
i be the adjustment,
and note that the columns of Vi are linearly dependent, and can be written as Vi = WiHi
where Wi = [(xrj − ¯xi), (xri − ¯xi)], and

Hi =

(cid:32) 1 0

1
0 1 −1

(cid:33)

,

giving Si = Wi(HiBiH T
-1:

i )W T

i = WiGiW T

i , with Gi a non-singular matrix with determinant

and of course,

Gi =

(cid:32) (ni − 1)
1

1
ni

1
−(ni + 1)

(cid:33)

,

G−1

i =

−1
ni

(cid:32) −(ni + 1)
−1

−1
(ni − 1)

(cid:33)

.

Letting ˜Mi = ˜X T

i

˜Xi, and ˜Mi,rirj = ˜X T

i,rirj

˜Xi,rirj , one has

˜Mi,rirj = ˜Mi + WiGiW T
i ,

and from this (see [Federov, 1972, p99]), assuming ˜Mi is non-singular,

˜M −1
i,rirj

and

= ˜M −1

i − ˜M −1

i Wi(G−1

i + W T
i

˜M −1

i Wi)−1W T
i

˜M −1
i

),

55

(13)

(14)

(15)

| ˜Mi,rirj | = −| ˜Mi||G−1

i + W T
i

˜M −1

i Wi| = | ˜Mi||∆i(ri, rj)|,

(16)

which is a trivial computation since |∆i(ri, rj)| is the determinant of a 2 by 2 matrix.

One thus has (cid:81)b

1 | ˜Mi,rirj | =

(cid:16)(cid:81)b

(cid:17)
1 | ˜Mi|

|∆i(ri, rj)||∆j(rj, ri)| for an exchange involving

blocks i and j.

6.4 Updating equations for the D criterion.

In this section, it is assumed that X ≡ Xw. In a similar fashion to the above, one can
treat the D criterion. If ˜Xj is the other block involved in the swap, the adjustment Sij
is, from equation (10),

[(xri − ¯xi) − (xrj − ¯xj)](xrj − xri)T + (xrj − xri)[(xri − ¯xi) − (xrj − ¯xj)]T +
nj − 1
nj

(xrj − xri)(xrj − xri)T (

ni − 1
ni

+

),

which can be made symmetric by completing the square, giving:

Sij = (¯xj − ¯xi)[2] − [(¯xj − ¯xi) − (xrj − xri)][2] + (1 −

ni + nj
ninj

)(xrj − xri)[2],

or

Sij = VijBijV T
ij ,

(17)

where Vij is a k by 3 matrix and Bij is diagonal and note that the columns of Vij are
linearly dependent, and can be written as Vij = WijHij where Wij = [(¯xj − ¯xi), (xrj −xri)],
and

Hij =

(cid:32) 1

1 0
0 −1 1

(cid:33)

,

giving Sij = Wij(HijBijH T
terminant -1:

ij )W T

ij = WijGijW T

ij , with Gij a non-singular matrix with de-

Gij =

(cid:32) 0

1
1 −C

(cid:33)

,

where C = ni+nj
ninj

.

Letting ˜M = ˜X T ˜X, one has after the swap, ˜Mij,rirj = ˜M + Sij = ˜M + WijGijW T

ij , and

from this

56

˜M −1

ij,rirj

= ˜M −1 − ˜M −1Wij(G−1

ij + W T
ij

˜M −1Wij)−1W T

ij

˜M −1),

and

| ˜Mij,rirj | = −| ˜M ||G−1

ij + W T
ij

˜M −1Wij| = | ˜M ||∆ij(ri, rj)|.

(18)

(19)

One thus has D = | ˜Mij,rirj | = | ˜M ||∆ij(ri, rj)| for an exchange involving blocks i and

j.

6.5 Updating equations for the D criterion when there are inter-
actions between block factors and within block factors.

In this case, the row elements of X = [Xwb, Xrj ] must be modi(cid:28)ed during exchanges,
since Xwb depends on the block factors. One may represent row r of X in the ith block
as xr,i = δixr, where xr involves only within block factors, and δi is a diagonal matrix
involving only block factors. For example, if ui is a factor in block i, and v, w are within
block factors, one might have,

xT
r,i = (v, w, uiv, uiw, vw),

= (v, w, v, w, vw)diag(1, 1, ui, ui, 1)
= xT

r δi.

Splitting xr,i into two multiplicative factors is simple if the factors are continuous
variables. Setting the whole block factors to unity will produce xr, and setting the within
block factors to unity will produce δi. For a categorical factor, the same may be done by
coding the (cid:28)rst level as a vector of unities. Nesting presents a problem, since the contrast
matrix for a nesting factor is the identity matrix, thus it is not possible to code a level
as a vector of unities; however, if Xn is X with nesting factors, and Xm is X in which
the same factors are multiplied, then Xn = XmT , where T is a non-singular matrix with
T ˜Xm| × constant, which means that the
(cid:28)rst column (1, 0, . . . , 0)T . Thus | ˜Xn
optimal design is the same for both codings.

T ˜Xn| = | ˜Xm

The arguments in section (6.3) leading to equation (14) may be used. The updating

equation for exchanging rows r1 and r2 between blocks i and j is

˜Mr1r2 = ˜M + WiGiW T

i + WjGjW T
j ,

(20)

where for l=i,j, Wl = δl[(xr2 − ¯xl), (xr1 − ¯xl)], with ¯xl being the means of the xl’s in each
block, and

Gi =

(cid:32) (ni − 1)
1

1
ni

1
−(ni + 1)

(cid:33)

,

57

Gj =

(cid:32) −(nj + 1)
1

1
nj

1
(nj − 1)

(cid:33)

.

Applying equations (15) and (16), and using di,j = W iT ˜M −1W j, one has

| ˜Mr2,r1| = | ˜M ||∆i||∆j − dj,i∆−1

i di,j|,

where ∆l = G−1

l + dl,l for l = i, j.

6.6 Computational note

A useful numerical method for dealing with matrix problems is to reduce the cross product
matrices to products of triangular matrices. Thus ˜M = ˜X T ˜X = T T T , where T is upper
triangular. The inverse ˜M −1 = T −1(T T )−1 is also the product of triangular matrices. For
such, products of the form vT ˜M −1v, where v is a conformable vector, become (vT T −1)[2]
with some saving in computation. Moreover, the algorithm that reduces ˜X to T is such
that additional weighted rows may be included or removed with small e(cid:27)ort.

It follows that one can update either with equations like (12) or with equations like

(14).

References

A.C. Atkinson and A.N. Donev. Optimum experimental designs. Oxford, New York, 1992.

W.G. Cochran and G.M. Cox. Experimental designs. Wiley, New York, 1950.

R.D. Cook and C. Nachtsheim. Computer-aided blocking of factorial and response-surface

designs. Technometrics, 31(3):339(cid:21)346, 1989.

R.R. Corbeil and R. Searle. Restricted maximum likelihood (reml) estimation of variance

components in the mixed model. Technometrics, 18(1):31(cid:21)38, 1976.

D.R. Cox. A note on polynomial response functions for mixtures. Biometrika, 58(1):

155(cid:21)159, 1971.

D.R. Cox and N. Reid. The theory of the design of experiments. Chapman & Hall, New

York, 2000.

A.N. Donev and A.C. Atkinson. An adjustment algorithm for the construction of exact

d-optimum experimental designs. Technometrics, 30:429(cid:21)33, 1988.

G. Elfving. Optimum allocation in linear regression theory. Ann. Math. Stat., 23:255(cid:21)262,

1952.

58

V.V. Federov. Theory of optimal experiments. Academic Press, New York, 1972.

D.J. Finney. The fractional replication of factorial arrangements. Ann. Eugen., 12:291(cid:21)

301, 1945.

P. Goos and M. Vandebroek. D-optimal split-plot designs with given numbers and sizes

of whole plots. Technometrics, 45(3):235(cid:21)245, 2003.

J.W. Gorman and J.E. Hinman. Simplex lattice designs for multicomponent systems.

Technometrics, 4(4):463(cid:21)487, 1962.

Sche(cid:27)Ø H. Experiments with mixtures. Jour. Roy. Statist. Soc (B), 20:344(cid:21)360, 1958.

T.J. Lorenzen and V.L. Anderson. Design of experiments, a no-name approach. Dekker,

New York, 1993.

Nam-Ky Nguyen. Cutting experimental designs into blocks. AusNZJSt, 43(3):367(cid:21)374,

2001.

C.S. Peirce and J. Jastrow. On small di(cid:27)erences of sensation. Memoirs of the National

Academy of Sciences, 3:75(cid:21)83, 1884.

F. Pukelsheim and Sabine. Rieder. E(cid:30)cient rounding of approximate designs. Biometrika,

79(4):763(cid:21)770, 1992.

H. Sche(cid:27)Ø. The Analysis of Variance. Wiley, New York, 1959.

S.D. Silvey. Optimal Design. Chapman and Hall, New York, 1980.

L.A. Trinca and S.G. Gilmour. An algorithm for arranging response surface designs in

small blocks. Computational Statistics and Data Analysis, 33:25(cid:21)43, 2000.

L.A. Trinca and S.G. Gilmour. Multistratum response surface designs. Technometrics,

43(1):25(cid:21)33, 2001.

59

