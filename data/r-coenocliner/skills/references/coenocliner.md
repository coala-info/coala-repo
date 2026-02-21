coenocliner: a coenocline simulation package for R

Gavin L. Simpson
Department of Animal and Veterinary Science
Aarhus University

Abstract

This vignette provides an introduction to, and user-guide for, the coenocliner package
for R. coenocliner can be used to generated random count or occurrence data from param-
eterised species response curves. The classic Gaussian response and the generalised beta
response functions are provided and simulated count or occurrence data can be generated
via random draws from a number of probability distributions.

Keywords: coenocline simulation, R, ecology, species, Gaussian response, generalized beta
response, Poisson, negative binomial.

1. Introduction

Coenoclines are, according to the Oxford Dictionary of Ecology (Allaby 1998), “gradients of
communities (e.g. in a transect from the summit to the base of a hill), reﬂecting the changing
importance, frequency, or other appropriate measure of diﬀerent species populations”.
In
much ecological research, and that of related ﬁelds, data on these coenoclines are collected
and analysed in a variety of ways. When developing new statistical methods or when trying to
understand the behaviour of existing methods, we often resort to simulating data with known
pattern or structure and then torture whatever method is of interest with the simulated data
to tease out how well methods work or where they breakdown.

There’s a long history of using computers to simulate species abundance data along coeno-
clines but until recently no R packages were available that performed coenocline simulation.
Dave Roberts’ coenoﬂex package was on CRAN for a while but the latest version was unstable
and removed from CRAN because of issues with the FORTRAN1. coenocliner was designed
to ﬁll this gap.
coenocliner can simulate species abundance or occurrence data along one or two gradients
from either a Gaussian or generalised beta response model. Parameters for the response model
are supplied for each species and parameterised species response curves along the gradients
are returned. Simulated abundance or occurrence data can be produced by sampling from
one of several error distributions which use the parameterised species response curves as
the expected count or probability of occurrence for the chosen error distribution. The error
distributions available in coenocliner are

1Dave has since ﬁxed these issues but the updated package is not yet, as of August 2014, re-available from

CRAN.

2

coenocliner

• Poisson

• Negative binomial

• Bernoulli (occurrence; Binomial with denominator m = 1)

• Binomial (counts with speciﬁed denominator m)

• Beta-binomial

• Zero-inﬂated Poisson (ZIP)

• Zero-inﬂated negative binomial (ZINB)

• Zero-inﬂated Binomial (ZIB)

• Zero-inﬂated Beta-Binomial (ZIBB)

This vignette provides a brief overview of the coenocliner package.

2. A brief overview of coenocliner
To begin, load coenocliner and check the start-up message to see if you are using the current
(0.2.4) release of the package

library("coenocliner")

The main function in coenocliner is coenocline(), which provides a relatively simple interface
to coenocline simulation allowing ﬂexible speciﬁcation of gradient locations and response
model parameters for species. Gradient locations are speciﬁed via argument x, which can
be a single vector, or, in the case of two gradients, a matrix or a list containing vectors of
gradient values. The matrix version assumes the ﬁrst gradient’s values are in the ﬁrst column
and those for the second gradient in the second column

xy <- cbind(x = seq(from = 4, to = 7, length.out = 100),

y = seq(from = 1, to = 100, length.out = 100))

Similarly, for the list version, the ﬁrst component contains the values for the ﬁrst gradient
and the second component the values for the second gradient

xy <- list(x = seq(from = 4, to = 6, length.out = 100),

y = seq(from = 1, to = 100, length.out = 100))

The species response model used is indicated via the responseModel argument; available
options are "gaussian" and "beta" for the classic Gaussian response model and the generalise
beta response model respectively. Parameters are supplied to coenocline() via the params
argument. showParams() can be used list the parameters for the desired response model.
The parameters for the Gaussian response model are

Gavin L. Simpson

3

showParams("gaussian")

## Species response model: Gaussian
##
## Parameters:
## [1] opt tol h*
##
## Parameters marked with '*' are only supplied once

As indicated, some parameters are only supplied once per species, regardless of whether there
are one or two gradients. Hence for the Gaussian model, the parameter h is only supplied for
the ﬁrst gradient even if two gradients are required.

Parameters are supplied as a matrix with named columns, or as a list with named components.
For example, for a Gaussian response for each of 3 species we could use either of the two forms

opt <- c(4,5,6)
tol <- rep(0.25, 3)
h <- c(10,20,30)
parm <- cbind(opt = opt, tol = tol, h = h)
parl <- list(opt = opt, tol = tol, h = h)

# matrix form
# list form

In the case of two gradients, a list with two components, one per gradient, is required. The
ﬁrst component contains parameters for the ﬁrst gradient, the second element contains those
for the second gradient. These components can be either a matrix or a list, as described
previously. For example a list with parameters supplied as matrices

opty <- c(25, 50, 75)
tol <- c(5, 10, 20)
pars <- list(px = parm,

py = cbind(opt = opty, tol = tol))

Note that parameter h is not speciﬁed in the second set as this parameter, the height of the
response curve at the gradient optima, applies globally — in the case of two gradients, h
refers to the height of the bell-shaped curve at the bivariate optimum.

Notice also how parameters are speciﬁed at the species level. To evaluate the response curve at
the supplied gradient locations each set of parameters needs to be repeated for each gradient
location. Thankfully coenocline() takes care of this detail for us.

Additional parameters that may be needed for the response model but which are not speciﬁed
at the species level are supplied as a list with named components to argument extraParams.
An example is the correlation between Gaussian response curves in case of two gradients.
This, unfortunately, means that a single correlation between response curves applies to all
species2, and is caused by a poor choice of implementation. Thankfully this is relatively easy
to ﬁx, which will be done for version 0.3-0 along with a ﬁx for a similar issue relating to the
statement of additional parameters for the error distribution used (see below).

2This is not strictly true as you can work out how the species parameters are replicated relative to gradient
values and hence pass a vector of the correct length with the species-speciﬁc values included. Study the outputs
from expand() when supplied gradient locations and parameters to work out how to specify extraParams
appropriately

4

coenocliner

To simulate realistic count data we need to sample with error from the parameterised species
response curves. Which of the distributions (listed earlier) is used is speciﬁed via argument
countModel; available options are

## [1] "poisson"
## [6] "betabinomial" "ZIP"

"negbin"

"bernoulli"
"ZINB"

"binary"
"ZIB"

"binomial"
"ZIBB"

Some of these distributions (all bar "poisson" and "bernoulli") require additional argu-
ments, such as the α parameter for (one parameterisation of) the negative binomial distri-
bution. These arguments are supplied as a list with named components. Again, due to the
same implementation snafu as for extraParams, such parameters act globally for all species3.
The ﬁnal argument is expectation, which defaults to FALSE. When set to TRUE, simulating
species counts or occurrences with error is skipped and the values of the parameterised re-
sponse curve evaluated at the gradient locations are returned. This option is handy if you
want to look at or plot the species response curves used in a simulation.

2.1. Example usage

In the next few sections the basic usage of coenocline() is illustrated.

Gaussian responses along a single gradient

This example, of multiple species responses along a single environmental gradient, illustrates
the simplest usage of coenocline(). The example uses a hypothetical pH gradient with
species optima drawn at random uniformly along the gradient. Species tolerances are the
same for all species. The maximum abundance of each species, h, is drawn from a lognormal
distribution with a mean of ~20 (e3). This simulation will be for a community of 20 species,
evaluated at 100 equally spaced locations. First we set up the parameters

set.seed(2)
M <- 20
ming <- 3.5
maxg <- 7
locs <- seq(ming, maxg, length = 100)
opt
tol
h
pars <- cbind(opt = opt, tol = tol, h = h) # put in a matrix

# number of species
# gradient minimum...
# ...and maximum
# gradient locations
# species optima
# species tolerances
# max abundances

<- runif(M, min = ming, max = maxg)
<- rep(0.25, M)
<- ceiling(rlnorm(M, meanlog = 3))

As a check, before simulating any count data, we can look at the coenocline implied by these
parameters by returning the expectations only from coenocline()

mu <- coenocline(locs, responseModel = "gaussian", params = pars,

expectation = TRUE)

3Again, this is not strictly true as you can work out how the species parameters are replicated relative
to gradient values and hence pass a vector of the correct length with the species-speciﬁc values included.
Study the outputs from expand() when supplied gradient locations and parameters to work out how to specify
countParams appropriately

Gavin L. Simpson

5

This returns a matrix of values obtained by evaluating each species response curve at the
supplied gradient locations. There is one column per species and one row per gradient location

class(mu)

## [1] "coenocline" "matrix"

dim(mu)

## [1] 100

20

mu

Sp9 Sp10 Sp11

Sp7 Sp8

Sp1 Sp2 Sp3

Sp4 Sp5 Sp6

##
## Coenocline simulation of 20 species at 100 gradient locations
##
##
1.08785
## 1
1.55307
## 2
2.17335
## 3
2.98113
## 4
4.00819
## 5
5.28239
## 6
6.82382
## 7
## 8
8.64051
## 9 10.72424
## 10 13.04694
## :
:
##
## Counts for 7 species not shown.
## (Values very close to zero were zapped)

0 9.55419
0 12.21531
0 15.30840
0 18.80486
0 22.64256
0 26.72366
0 30.91585
0 35.05755
0 38.96699
0 42.45484
:
:

0 0.50247
0 0.69384
0 0.93913
0 1.24597
0 1.62033
0 2.06545
0 2.58072
0 3.16069
0 3.79436
0 4.46488
:
:

0 0e+00
0 0e+00
0 0e+00
0 0e+00
0 0e+00
0 0e+00
0 0e+00
0 1e-05
0 2e-05
0 5e-05
:
:

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
:

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
:

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
:

Sp12 Sp13
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
:

0 0.02607
0 0.04142
0 0.06450
0 0.09846
0 0.14732
0 0.21606
0 0.31061
0 0.43770
0 0.60456
0 0.81851
:
:

A quick way to visualise the parameterised species response is to use the plot() method

plot(mu, lty = "solid", type = "l", xlab = "pH", ylab = "Abundance")

The resultant plot is shown in Figure 1.

As this looks OK, we can simulate some count data. The simplest model for doing so is to
make random draws from a Poisson distribution with the mean, λ, for each species set to
value of the response curve evaluated at each gradient location. Hence the values in mu that
we just created can be thought of as the expected count per species at each of the gradient
locations we are interested in. To simulate Poisson count data, use expectation = FALSE or
remove this argument from the call. To be more explicit, we should also state countModel =
"poisson"4.

simp <- coenocline(locs, responseModel = "gaussian", params = pars,

countModel = "poisson")

4countModel = "poisson" is the default so this can be excluded from the call.

6

coenocliner

e
c
n
a
d
n
u
b
A

0
5
1

0
0
1

0
5

0

3.5

4.0

4.5

5.0

5.5

6.0

6.5

7.0

pH

Figure 1: Gaussian species response curves along a hypothetical pH gradient

Again, matplot is useful in visualizing the simulated data

plot(simp, lty = "solid", type = "p", pch = 1:10, cex = 0.8,

xlab = "pH", ylab = "Abundance")

The resultant plot is shown in Figure 2.

Whilst the simulated counts look reasonable and follow the response curves in Figure 1 there
is a problem; the variation around the expected curves is too small. This is due to the
error variance implied by the Poisson distribution encapsulating only that variance which
would arise due to repeated sampling at the gradient locations. Most species abundance data
exhibit much larger degrees of variation than that shown in Figure 2. A solution to this is to
sample from a distribution that incorporates additional variance or overdispersion. A natural
partner to the Poisson that includes overdispersion is the negative binomial. To simulate
count data using the negative binomial distribution we must alter countModel and supply
the overdispersion parameter α to use5 via countParams.

simnb <- coenocline(locs, responseModel = "gaussian", params = pars,

countModel = "negbin", countParams = list(alpha = 0.5))

Using plot it is apparent that the simulated species data are now far more realistic (Figure 3)

plot(simnb, lty = "solid", type = "p", pch = 1:10, cex = 0.8,

xlab = "pH", ylab = "Abundance")

5Recall that this is only easily speciﬁable globally in version 0.1-0 of coenocliner.

Gavin L. Simpson

7

e
c
n
a
d
n
u
b
A

0
5
1

0
0
1

0
5

0

3.5

4.0

4.5

5.0

5.5

6.0

6.5

7.0

pH

Figure 2: Simulated species abundances with Poisson errors from Gaussian response curves
along a hypothetical pH gradient

e
c
n
a
d
n
u
b
A

0
0
4

0
0
3

0
0
2

0
0
1

0

3.5

4.0

4.5

5.0

5.5

6.0

6.5

7.0

pH

Figure 3: Simulated species abundance with negative binomial errors from Gaussian response
curves along a hypothetical pH gradient

8

coenocliner

Generalised beta responses along a single gradient

In this example, I recreate ﬁgure 2 in Minchin (1987) and then simulate species abundances
from the species response curves. The species parameters for the generalised beta response
for the six species in Minchin (1987) are

<- c(5,4,7,5,9,8) * 10
<- c(25,85,10,60,45,60)
<- c(3,3,4,4,6,5) * 10

A0
m
r
alpha <- c(0.1,1,2,4,1.5,1)
gamma <- c(0.1,1,2,4,0.5,4)
locs <- 1:100
pars <- list(m = m, r = r, alpha = alpha,

# max abundance
# location on gradient of modal abundance
# species range of occurrence on gradient
# shape parameter
# shape parameter
# gradient locations

gamma = gamma, A0 = A0)

# species parameters, in list form

To recreate ﬁgure 2 in Minchin (1987) evaluations at the chosen gradient locations, locs, of the
parameterised generalised beta are required and can be generated by passing coenocline()
the gradient locations and the chosen species parameters as before, choosing the generalised
beta response model and using expectation = TRUE

mu <- coenocline(locs, responseModel = "beta", params = pars, expectation = TRUE)

As before mu is a matrix with one column per species

mu

Sp1 Sp2

Sp3 Sp4

##
## Coenocline simulation of 6 species at 100 gradient locations
##
##
## 1
## 2
## 3
## 4
## 5
## 6
## 7
## 8
## 9
## 10
## :
##
## (Values very close to zero were zapped)

0 0.59129
0 1.65820
0 3.01993
0 4.60853
0 6.38285
0 8.31384
0 10.37918
0 12.56073
0 14.84318
0 17.21326
:
:

0 44.52044
0 49.39200
0 53.90044
0 57.96700
0 61.52344
0 64.51200
0 66.88544
0 68.60700
0 69.65044
0 70.00000
:
:

Sp5 Sp6
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
:

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
:

and as such we can use matplot to draw the species responses

plot(mu, lty = "solid", type = "l", xlab = "Gradient", ylab = "Abundance")

Figure 4 is a good facsimile of ﬁgure 2 in Minchin (1987).

Gavin L. Simpson

9

e
c
n
a
d
n
u
b
A

0
8

0
6

0
4

0
2

0

0

20

40

60

80

100

Gradient

Figure 4: Generalised beta function species response curves along a hypothetical environmen-
tal gradient recreating Figure 2 in Minchin (1987).

Gaussian response along two gradients

In this example I illustrate how to simulate species abundance in an environment comprising
two gradients. Parameters for the simulation are deﬁned ﬁrst, including the number of species
and samples required, followed by deﬁnitions of the gradient units and lengths, species optima,
and tolerances for each gradient, and the maximal abundance (h).

set.seed(10)
N <- 30
M <- 20
## First gradient
ming1 <- 3.5
maxg1 <- 7
loc1 <- seq(ming1, maxg1, length = N)
opt1 <- runif(M, min = ming1, max = maxg1)
tol1 <- rep(0.5, M)
<- ceiling(rlnorm(M, meanlog = 3))
h
par1 <- cbind(opt = opt1, tol = tol1, h = h)
## Second gradient
ming2 <- 1
maxg2 <- 100
loc2 <- seq(ming2, maxg2, length = N)
opt2 <- runif(M, min = ming2, max = maxg2)
tol2 <- ceiling(runif(M, min = 5, max = 50))
par2 <- cbind(opt = opt2, tol = tol2)
## Last steps...
pars <- list(px = par1, py = par2)
locs <- expand.grid(x = loc1, y = loc2)

# number of samples
# number of species

# 1st gradient minimum...
# ...and maximum
# 1st gradient locations
# species optima
# species tolerances
# max abundances
# put in a matrix

# 2nd gradient minimum...
# ...and maximum
# 2nd gradient locations
# species optima
# species tolerances
# put in a matrix

# put parameters into a list
# put gradient locations together

10

coenocliner

Notice how the parameter sets for each gradient are individual matrices which are combined
in a list, pars, ready for use. Also diﬀerent this time is the expand.grid() call which is
used to generate all pairwise combinations of the locations on the two gradients. This has the
eﬀect of creating a coordinate pair on the two gradients at which we’ll evaluate the response
curves. In eﬀect this creates a grid of points over the gradient space.
Having set up the parameters, the call to coenocline() is the same as before, except now
we specify a degree of correlation between the two gradients via extraParams = list(corr
= 0.5)

mu2d <- coenocline(locs, responseModel = "gaussian",

params = pars, extraParams = list(corr = 0.5),
expectation = TRUE)

mu2d now contains a matrix of expected species abundances, one column per species as before.
Because of the way the expand.grid() function works, the ordering of species abundances
in each column has the ﬁrst gradient locations varying fastest — the locations on the ﬁrst
gradient are repeated in order for each location on the second gradient

head(locs)

x y
##
## 1 3.500000 1
## 2 3.620690 1
## 3 3.741379 1
## 4 3.862069 1
## 5 3.982759 1
## 6 4.103448 1

As a result, we can reshape the abundances for a single species into a matrix reﬂecting the
grid of locations over the gradient space via a simple matrix() call, setting the number of
columns in the resultant matrix equal to the number of gradient locations in the simulation.
Thankfully this is taken care of for you in the persp() method6. The method will draw
perspective plots for all species in the simulation; it is left to the user to handle how these
should be displayed on the current graphics device. By way of illustration, I plot the expected
abundance for four of the species in mu2d

layout(matrix(1:4, ncol = 2))
op <- par(mar = rep(1, 4))
persp(mu2d, species = c(2, 8, 13, 19), ticktype = "detailed",

zlab = "Abundance")

par(op)
layout(1)

The selected species response curves are shown in Figure 5.
Simulated counts for each species can be produced by removing expectation = TRUE from
the call and choosing an error distribution to make random draws from. For example, for
negative binomial errors with dispersion α = 1 we can use

6The plot() methods for class "coenocline" will use the persp() if you try to plot an object with two

gradients.

Gavin L. Simpson

11

15

A
b
u
n
d
a
n
c
e

10

5

60

50

40

A
b
u
n
d
a
n
c
e

30

20

10

4

100

80

60

locs2

40

5

locs1

6

20

7

4

5

locs1

6

100

80

60

locs2

40

20

7

40

50

30

A
b
u
n
d
a
n
c
e

20

40

A
b
u
n
d
a
n
c
e

30

20

10

4

100

80

60

locs2

40

5

locs1

6

20

7

10

4

100

80

60

locs2

40

5

locs1

6

20

7

Figure 5: Bivariate Gaussian species responses for four selected species.

12

coenocliner

80

200

150
A
b
u
n
100
d
a
n
c
e

50

0

4

100

80

60

A
b
u
n
d
a
n
c
e

40

20

60

A
b
u
n
d
a
n
c
e

40

20

100

80

60

locs2

40

5

locs1

6

20

7

0

4

5

locs1

6

100

80

60

locs2

40

20

7

200

150
A
b
u
n
100
d
a
n
c
e

50

0

4

100

80

60

locs2

40

5

locs1

6

20

7

0

4

5

locs1

6

100

80

60

locs2

40

20

7

Figure 6: Simulated counts using negative binomial errors from bivariate Gaussian species
responses for four selected species.

sim2d <- coenocline(locs, responseModel = "gaussian",

params = pars, extraParams = list(corr = 0.5),
countModel = "negbin", countParams = list(alpha = 1))

The resulting simulated counts for the same four selected species are shown in Figure 6, which
was generated using the code below

layout(matrix(1:4, ncol = 2))
op <- par(mar = rep(1, 4))
persp(sim2d, species = c(2, 8, 13, 19), ticktype = "detailed",

zlab = "Abundance")

par(op)
layout(1)

3. Future directions

coenocliner was designed to be quite modular and hence easy to add new species response
models or probability distributions from which to simulate count or abundance data. The
current release covers the main functionality envisaged when I started to develop coenocliner.

Gavin L. Simpson

13

Some ﬁne-tuning and polishing of the functions is needed as are some methods such as plot
methods and nicer displays of the outputted species data such as row and column labels on
the resultant community matrices.

Beyond this, it would be useful to include options in other community simulator packages,
such as COMPAS, which include competition eﬀects between species etc. Such modiﬁcations
would occur after the simulated counts were generated and would act to modify those counts
in line with ecological theory.

References

Allaby M (1998). A dictionary of ecology. Oxford Paperback Reference, second edition.

Oxford University Press.

Minchin PR (1987). “Simulation of Multidimensional Community Patterns: Towards a Com-

prehensive Model.” Vegetatio, 71(3), 145–156.

4. Appendix

4.1. Computational details

This vignette was created using the following R and add-on package versions

• R version 4.5.2 (2025-10-31), aarch64-apple-darwin20

• Locale: C/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8

• Time zone: Europe/Copenhagen

• TZcode source: internal

• Running under: macOS Tahoe 26.1

• Matrix products: default

• BLAS:

/System/Library/Frameworks/Accelerate.framework/Versions/A/Frameworks/vecLib.framework/Versions/A/libBLAS.dylib

• LAPACK:

/Library/Frameworks/R.framework/Versions/4.5-arm64/Resources/lib/libRlapack.dylib
;

LAPACK version3.12.1

• Base packages: base, datasets, grDevices, graphics, methods, stats, utils

• Other packages: coenocliner 0.2-4, knitr 1.50

• Loaded via a namespace (and not attached): compiler 4.5.2, evaluate 1.0.5, highr 0.11,

tools 4.5.2, xfun 0.53

14

Aﬃliation:

coenocliner

Gavin L. Simpson
Department of Animal and Veterinary Sciences
Aarhus University
Blichers Alle 20
8830 Tjele
Denmark E-mail: ucfagls@gmail.com
URL: http://www.fromthebottomoftheheap.net/

