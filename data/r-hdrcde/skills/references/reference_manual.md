Package ‘hdrcde’

January 11, 2026

Type Package

Title Highest Density Regions and Conditional Density Estimation

Version 3.5.0

BugReports https://github.com/robjhyndman/hdrcde/issues

Depends R (>= 2.15)

Imports locfit, ash, ks, KernSmooth, ggplot2, RColorBrewer

LazyData yes

LazyLoad yes

Description Computation of highest density regions in one and two dimensions, kernel estima-

tion of univariate density functions conditional on one covariate,and multimodal regression.

License GPL-3

URL https://pkg.robjhyndman.com/hdrcde/,

https://github.com/robjhyndman/hdrcde

RoxygenNote 7.3.3

Encoding UTF-8

Suggests testthat (>= 3.0.0)

Config/testthat/edition 3

NeedsCompilation yes

Author Rob Hyndman [aut, cre, cph] (ORCID:

<https://orcid.org/0000-0002-2140-5352>),
Jochen Einbeck [aut] (ORCID: <https://orcid.org/0000-0002-9457-2020>),
Matthew Wand [aut] (ORCID: <https://orcid.org/0000-0003-2555-896X>),
Simon Carrignon [ctb] (ORCID: <https://orcid.org/0000-0002-4416-1389>),
Fan Cheng [ctb] (ORCID: <https://orcid.org/0000-0003-0009-3262>)

Maintainer Rob Hyndman <Rob.Hyndman@monash.edu>

Repository CRAN

Date/Publication 2026-01-11 06:11:14 UTC

1

2

Contents

BoxCox

.

.
.

.
.

.
.

.
.

.
BoxCox .
cde .
.
.
.
.
cde.bandwidths .
.
.
.
hdr .
.
.
.
.
hdr.2d .
.
.
hdr.boxplot
.
.
hdr.cde .
.
.
.
hdr.den .
.
.
.
hdrbw .
.
hdrconf
.
.
.
hdrscatterplot
.
.
lane2 .
.
.
.
maxtemp .
.
.
modalreg .
.
.
plot.cde .
.
.
plot.hdrcde
.
.
plot.hdrconf .

.
.
.
.
.
.
.
.
.
.
.
.
.
.

.
.
.
.

.

.

.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.

.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.

.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.

.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.

.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.

.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.

2
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
5
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
7
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
9
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 11
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 13
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 14
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 16
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 17
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 18
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 19
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 20
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 21
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 23
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 24
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 26

Index

27

BoxCox

Box Cox Transformation

Description

BoxCox() returns a transformation of the input variable using a Box-Cox transformation. InvBox-
Cox() reverses the transformation.

Usage

BoxCox(x, lambda)

Arguments

x

lambda

Details

a numeric vector or time series

transformation parameter

The Box-Cox transformation is given by

if λ ̸= 0. For λ = 0,

fλ(x) =

xλ − 1
λ

f0(x) = log(x).

3

cde

Value

a numeric vector of the same length as x.

Author(s)

Rob J Hyndman

References

Box, G. E. P. and Cox, D. R. (1964) An analysis of transformations. JRSS B 26 211–246.

cde

Conditional Density Estimation

Description

Calculates kernel conditional density estimate using local polynomial estimation.

Usage

cde(
x,
y,
deg = 0,
link = "identity",
a,
b,
mean = NULL,
x.margin,
y.margin,
x.name,
y.name,
use.locfit = FALSE,
fw = TRUE,
rescale = TRUE,
nxmargin = 15,
nymargin = 100,
a.nndefault = 0.3,
...

)

Arguments

x

y

deg

Numerical vector or matrix: the conditioning variable(s).

Numerical vector: the response variable.

Degree of local polynomial used in estimation.

4

link

a

b

mean

x.margin

y.margin

x.name

y.name

use.locfit

fw

rescale

nxmargin

nymargin

a.nndefault

...

Details

cde

Link function used in estimation. Default "identity". The other possibility is
"log" which is recommended if degree > 0.

Optional bandwidth in x direction.

Optional bandwidth in y direction.

Estimated mean of y|x. If present, it will adjust conditional density to have this
mean.

Values in x-space on which conditional density is calculated. If not specified, an
equi-spaced grid of nxmargin values over the range of x is used. If x is a matrix,
x.margin should be a list of two numerical vectors.

Values in y-space on which conditional density is calculated. If not specified, an
equi-spaced grid of nymargin values over the range of y is used.
Optional name of x variable used in plots.

Optional name of y variable used in plots.
If TRUE, will use locfit::locfit() for estimation. Otherwise stats::ksmooth()
is used. locfit::locfit() is used if degree>0 or link not the identity or the
dimension of x is greater than 1 even if use.locfit=FALSE.
If TRUE (default), will use fixed window width estimation. Otherwise nearest
neighbourhood estimation is used. If the dimension of x is greater than 1, nearest
neighbourhood must be used.

If TRUE (default), will rescale the conditional densities to integrate to one.
Number of values used in x.margin by default.
Number of values used in y.margin by default.
Default nearest neighbour bandwidth (used only if fw=FALSE and a is missing.).
Additional arguments are passed to locfit.

If bandwidths are omitted, they are computed using normal reference rules described in Bashtannyk
and Hyndman (2001) and Hyndman and Yao (2002). Bias adjustment uses the method described
in Hyndman, Bashtannyk and Grunwald (1996). If deg>1 then estimation is based on the local
parametric estimator of Hyndman and Yao (2002).

Value

A list with the following components:

x

y

z

a

b

grid in x direction on which density evaluated. Equal to x.margin if specified.

grid in y direction on which density is evaluated. Equal to y.margin if specified.

value of conditional density estimate returned as a matrix.

window width in x direction.

window width in y direction.

x.name

y.name

Name of x variable to be used in plots.

Name of y variable to be used in plots.

cde.bandwidths

Author(s)

Rob J Hyndman

References

5

Hyndman, R.J., Bashtannyk, D.M. and Grunwald, G.K. (1996) "Estimating and visualizing condi-
tional densities". Journal of Computational and Graphical Statistics, 5, 315-336.

Bashtannyk, D.M., and Hyndman, R.J. (2001) "Bandwidth selection for kernel conditional density
estimation". Computational statistics and data analysis, 36(3), 279-298.

Hyndman, R.J. and Yao, Q. (2002) "Nonparametric estimation and symmetry tests for conditional
density functions". Journal of Nonparametric Statistics, 14(3), 259-278.

See Also

cde.bandwidths()

Examples

# Old faithful data
faithful.cde <- cde(faithful$waiting, faithful$eruptions,

x.name = "Waiting time", y.name = "Duration time"

)
plot(faithful.cde)
plot(faithful.cde, plot.fn = "hdr")

# Melbourne maximum temperatures with bias adjustment
x <- maxtemp[1:3649]
y <- maxtemp[2:3650]
maxtemp.cde <- cde(x, y,

x.name = "Today's max temperature", y.name = "Tomorrow's max temperature"

)
# Assume linear mean
fit <- lm(y ~ x)
fit.mean <- list(x = 6:45, y = fit$coef[1] + fit$coef[2] * (6:45))
maxtemp.cde2 <- cde(x, y,

mean = fit.mean,
x.name = "Today's max temperature", y.name = "Tomorrow's max temperature"

)
plot(maxtemp.cde)

cde.bandwidths

Bandwidth calculation for conditional density estimation

Description

Calculates bandwidths for kernel conditional density estimates. Methods described in Bashtannyk
and Hyndman (2001) and Hyndman and Yao (2002).

cde.bandwidths

6

Usage

cde.bandwidths(

x,
y,
deg = 0,
link = "identity",
method = 1,
y.margin,
passes = 2,
ngrid = 8,
min.a = NULL,
ny = 25,
use.sample = FALSE,
GCV = TRUE,
b = NULL,
...

)

Arguments

x

y

deg

link

method

y.margin

passes

ngrid

min.a

ny

Numerical vector: the conditioning variable.

Numerical vector: the response variable.

Degree of local polynomial used in estimation.

Link function used in estimation. Default "identity". The other possibility is
"log" which is recommended if degree > 0.

method = 1: Hyndman-Yao algorithm if deg>0; Bashtannyk-Hyndman algo-

rithm if deg=0;

method = 2: Normal reference rules;
method = 3: Bashtannyk-Hyndman regression method if deg=0;
method = 4: Bashtannyk-Hyndman bootstrap method if deg=0.

Values in y-space on which conditional density is calculated. If not specified, an
equi-spaced grid of 50 values over the range of y is used.

Number of passes through Bashtannyk-Hyndman algorithm.

Number of values of smoothing parameter in grid.

Smallest value of a to consider if method=1.
Number of values to use for y margin if y.margin is missing.

use.sample

Used when regression method (3) is chosen.

GCV

b

...

Generalized cross-validation. Used only if method=1 and deg>0. If GCV=FALSE,
method=1 and deg=0, then the AIC is used instead. The argument is ignored if
deg=0 or method>1.

Value of b can be specified only if method=1 and deg>0. For deg=0 or method>1,
this argument is ignored.

Other arguments control details for individual methods.

hdr

Details

7

Details of the various algorithms are in Bashtannyk and Hyndman (2001) and Hyndman and Yao
(2002).

Window width in x direction.
Window width in y direction.

Value

a
b

Author(s)

Rob J Hyndman

References

Hyndman, R.J., Bashtannyk, D.M. and Grunwald, G.K. (1996) "Estimating and visualizing condi-
tional densities". Journal of Computational and Graphical Statistics, 5, 315-336.
Bashtannyk, D.M., and Hyndman, R.J. (2001) "Bandwidth selection for kernel conditional density
estimation". Computational statistics and data analysis, 36(3), 279-298.
Hyndman, R.J. and Yao, Q. (2002) "Nonparametric estimation and symmetry tests for conditional
density functions". Journal of Nonparametric Statistics, 14(3), 259-278.

See Also

cde()

Examples

bands <- cde.bandwidths(faithful$waiting, faithful$eruptions, method = 2)
plot(cde(faithful$waiting, faithful$eruptions, a = bands$a, b = bands$b))

hdr

Highest Density Regions

Description

Calculates highest density regions in one dimension

Usage

hdr(

x = NULL,
prob = c(0.5, 0.95, 0.99),
den = NULL,
h = hdrbw(BoxCox(x, lambda), mean(prob)),
lambda = 1,
nn = 5000,
all.modes = FALSE

)

8

Arguments

x

prob
den

h
lambda
nn
all.modes

Details

hdr

Numeric vector containing data. If x is missing then den must be provided, and
the HDR is computed from the given density.
Probability coverage required for HDRs
Density of data as list with components x and y. If omitted, the density is esti-
mated from x using stats::density().
Optional bandwidth for calculation of density.
Box-Cox transformation parameter where 0 ≤ λ ≤ 1.
Number of random numbers used in computing f-alpha quantiles.
Return all local modes or just the global mode?

Either x or den must be provided. When x is provided, the density is estimated using kernel density
estimation. A Box-Cox transformation is used if lambda!=1, as described in Wand, Marron and
Ruppert (1991). This allows the density estimate to be non-zero only on the positive real line. The
default kernel bandwidth h is selected using the algorithm of Samworth and Wand (2010).
Hyndman’s (1996) density quantile algorithm is used for calculation.

Value

A list of three components:

hdr
mode
falpha

The endpoints of each interval in each HDR
The estimated mode of the density.
The value of the density at the boundaries of each HDR.

Author(s)

Rob J Hyndman

References

Hyndman, R.J. (1996) Computing and graphing highest density regions. American Statistician, 50,
120-126.

Samworth, R.J. and Wand, M.P. (2010). Asymptotics and optimal bandwidth selection for highest
density region estimation. The Annals of Statistics, 38, 1767-1792.
Wand, M.P., Marron, J S., Ruppert, D. (1991) Transformations in density estimation. Journal of the
American Statistical Association, 86, 343-353.

See Also

hdr.den(), hdr.boxplot()

Examples

# Old faithful eruption duration times
hdr(faithful$eruptions)

hdr.2d

9

hdr.2d

Bivariate Highest Density Regions

Description

Calculates and plots highest density regions in two dimensions, including the bivariate HDR box-
plot.

Usage

hdr.2d(
x,
y,
prob = c(0.5, 0.95, 0.99),
den = NULL,
kde.package = c("ash", "ks"),
h = NULL,
xextend = 0.15,
yextend = 0.15

)

hdr.boxplot.2d(

x,
y,
prob = c(0.5, 0.99),
kde.package = c("ash", "ks"),
h = NULL,
xextend = 0.15,
yextend = 0.15,
xlab = "",
ylab = "",
shadecols = "darkgray",
pointcol = 1,
outside.points = TRUE,
...

)

## S3 method for class 'hdr2d'
plot(
x,
shaded = TRUE,
show.points = FALSE,
outside.points = FALSE,
pch = 20,
shadecols = gray(rev(seq_along(x$alpha))/(length(x$alpha) + 1)),
pointcol = 1,
...

10

)

Arguments

x

y

prob

den

kde.package

h

xextend

yextend

xlab

ylab

shadecols

pointcol

hdr.2d

Numeric vector
Numeric vector of same length as x.

Probability coverage required for HDRs

Bivariate density estimate (a list with elements x, y and z where x and y are grid
values and z is a matrix of density values). If NULL, the density is estimated.
Package to be used in calculating the kernel density estimate when den=NULL.
Pair of bandwidths passed to either ash::ash2() or ks::kde(). If NULL, a
reasonable default is used. Ignored if den is not NULL.
Proportion of range of x. The density is estimated on a grid extended by xextend
beyond the range of x.
Proportion of range of y. The density is estimated on a grid extended by yextend
beyond the range of y.

Label for x-axis.

Label for y-axis.

Colors for shaded regions

Color for outliers and mode

outside.points If TRUE, the observations lying outside the largest HDR are shown.
...

Other arguments to be passed to plot.
If TRUE, the HDR contours are shown as shaded regions.
If TRUE, the observations are plotted over the top of the HDR contours.

The plotting character used for observations.

shaded

show.points

pch

Details

The density is estimated using kernel density estimation. Either ash::ash2() or ks::kde() is used
to do the calculations. Then Hyndman’s (1996) density quantile algorithm is used to compute the
HDRs.
hdr.2d returns an object of class hdr2d containing all the information needed to compute the HDR
contours. This object can be plotted using plot.hdr2d.
hdr.boxplot.2d produces a bivariate HDR boxplot. This is a special case of applying plot.hdr2d
to an object computed using hdr.2d.

Value

Some information about the HDRs is returned. See code for details.

Author(s)

Rob J Hyndman

hdr.boxplot

References

11

Hyndman, R.J. (1996) Computing and graphing highest density regions American Statistician, 50,
120-126.

See Also

hdr.boxplot()

Examples

x <- c(rnorm(200, 0, 1), rnorm(200, 4, 1))
y <- c(rnorm(200, 0, 1), rnorm(200, 4, 1))
hdr.boxplot.2d(x, y)

hdrinfo <- hdr.2d(x, y)
plot(hdrinfo, pointcol = "red", show.points = TRUE, pch = 3)

hdr.boxplot

Highest Density Region Boxplots

Description

Calculates and plots a univariate highest density regions boxplot.

Usage

hdr.boxplot(

x,
prob = c(0.99, 0.5),
h = hdrbw(BoxCox(x, lambda), mean(prob)),
lambda = 1,
boxlabels = "",
col = rev(gray(seq(9)/10)),
main = "",
xlab = "",
ylab = "",
pch = 1,
border = 1,
outline = TRUE,
space = 0.25,
...

)

12

Arguments

x

prob

h

lambda

boxlabels

col

main

xlab

ylab

pch

border

outline

space

...

Details

hdr.boxplot

Numeric vector containing data or a list containing several vectors.
Probability coverage required for HDRs stats::density().
Optional bandwidth for calculation of density.

Box-Cox transformation parameter where 0 ≤ λ ≤ 1.

Label for each box plotted.

Colours for regions of each box.

Overall title for the plot.

Label for x-axis.

Label for y-axis.

Plotting character.

Width of border of box.
If not TRUE, the outliers are not drawn.
The space between each box, between 0 and 0.5.

Other arguments passed to plot.

The density is estimated using kernel density estimation. A Box-Cox transformation is used if
lambda!=1, as described in Wand, Marron and Ruppert (1991). This allows the density estimate
to be non-zero only on the positive real line. The default kernel bandwidth h is selected using the
algorithm of Samworth and Wand (2010).

Hyndman’s (1996) density quantile algorithm is used for calculation.

Value

nothing.

Author(s)

Rob J Hyndman

References

Hyndman, R.J. (1996) Computing and graphing highest density regions. American Statistician, 50,
120-126.

Samworth, R.J. and Wand, M.P. (2010). Asymptotics and optimal bandwidth selection for highest
density region estimation. The Annals of Statistics, 38, 1767-1792.

Wand, M.P., Marron, J S., Ruppert, D. (1991) Transformations in density estimation. Journal of the
American Statistical Association, 86, 343-353.

See Also

hdr.boxplot.2d(), hdr(), hdr.den()

13

hdr.cde

Examples

# Old faithful eruption duration times
hdr.boxplot(faithful$eruptions)

# Simple bimodal example
x <- c(rnorm(100, 0, 1), rnorm(100, 5, 1))
par(mfrow = c(1, 2))
boxplot(x)
hdr.boxplot(x)

# Highly skewed example
x <- exp(rnorm(100, 0, 1))
par(mfrow = c(1, 2))
boxplot(x)
hdr.boxplot(x, lambda = 0)

Calculate highest density regions continuously over some conditioned
variable.

hdr.cde

Description

Calculates and plots highest density regions for a conditional density estimate. Uses output from
cde().

Usage

hdr.cde(den, prob = c(0.5, 0.95, 0.99), plot = TRUE, nn = 1000, ...)

Arguments

den

prob

plot

nn

...

Value

hdr

Conditional density in the same format as the output from cde().

Probability coverage level for HDRs

Should HDRs be plotted? If FALSE, results are returned.

Number of points to be sampled from each density when estimating the HDRs.
Other arguments passed to plot.hdrcde().

array (a,b,c) where where a specifies conditioning value, b gives the HDR end-
points and c gives the probability coverage.

modes

estimated mode of each conditional density

The result is returned invisibly if plot=TRUE.

14

Author(s)

Rob J Hyndman

References

hdr.den

Hyndman, R.J., Bashtannyk, D.M. and Grunwald, G.K. (1996) "Estimating and visualizing condi-
tional densities". Journal of Computational and Graphical Statistics, 5, 315-336.

See Also

plot.hdrcde(), cde(),

Examples

faithful.cde <- cde(faithful$waiting, faithful$eruptions)
faithful.hdr <- hdr.cde(faithful.cde, prob = c(0.50, 0.95))
faithful.hdr
plot(faithful.hdr, xlab = "Waiting time", ylab = "Duration time")

hdr.den

Density plot with Highest Density Regions

Description

Plots univariate density with highest density regions displayed

Usage

hdr.den(
x,
prob = c(0.5, 0.95, 0.99),
den,
h = hdrbw(BoxCox(x, lambda), mean(prob)),
lambda = 1,
xlab = NULL,
ylab = "Density",
ylim = NULL,
plot.lines = TRUE,
col = 2:8,
bgcol = "gray",
legend = FALSE,
...

)

hdr.den

Arguments

x

prob
den

h
lambda
xlab
ylab
ylim
plot.lines
col
bgcol

legend
...

Details

15

Numeric vector containing data. If x is missing then den must be provided, and
the HDR is computed from the given density.
Probability coverage required for HDRs
Density of data as list with components x and y. If omitted, the density is esti-
mated from x using stats::density().
Optional bandwidth for calculation of density.
Box-Cox transformation parameter where 0 ≤ λ ≤ 1.
Label for x-axis.
Label for y-axis.
Limits for y-axis.
If TRUE, will show how the HDRs are determined using lines.
Colours for regions.
Colours for the background behind the boxes. Default "gray", if NULL no box
is drawn.
If TRUE add a legend on the right of the boxes.
Other arguments passed to plot.

Either x or den must be provided. When x is provided, the density is estimated using kernel density
estimation. A Box-Cox transformation is used if lambda!=1, as described in Wand, Marron and
Ruppert (1991). This allows the density estimate to be non-zero only on the positive real line. The
default kernel bandwidth h is selected using the algorithm of Samworth and Wand (2010).
Hyndman’s (1996) density quantile algorithm is used for calculation.

Value

a list of three components:

hdr
mode
falpha

The endpoints of each interval in each HDR
The estimated mode of the density.
The value of the density at the boundaries of each HDR.

Author(s)

Rob J Hyndman

References

Hyndman, R.J. (1996) Computing and graphing highest density regions. American Statistician, 50,
120-126.

Samworth, R.J. and Wand, M.P. (2010). Asymptotics and optimal bandwidth selection for highest
density region estimation. The Annals of Statistics, 38, 1767-1792.
Wand, M.P., Marron, J S., Ruppert, D. (1991) Transformations in density estimation. Journal of the
American Statistical Association, 86, 343-353.

hdrbw

16

See Also

hdr(), hdr.boxplot()

Examples

# Old faithful eruption duration times
hdr.den(faithful$eruptions)

# Simple bimodal example
x <- c(rnorm(100, 0, 1), rnorm(100, 5, 1))
hdr.den(x)

hdrbw

Highest Density Region Bandwidth

Description

Estimates the optimal bandwidth for 1-dimensional highest density regions

Usage

hdrbw(x, HDRlevel, gridsize = 801, nMChdr = 1e+06, graphProgress = FALSE)

Arguments

x

HDRlevel

gridsize

nMChdr

Numerical vector containing data.

HDR-level as defined in Hyndman (1996). Setting ‘HDRlevel’ equal to p (0<p<1)
corresponds to a probability of 1-p of inclusion in the highest density region.

the number of equally spaced points used for binned kernel density estimation.

the size of the Monte Carlo sample used for density quantile approximation of
the highest density region, as described in Hyndman (1996).

graphProgress

logical flag: if ‘TRUE’ then plots showing the progress of the bandwidth selec-
tion algorithm are produced.

Details

This is a plug-in rule for bandwidth selection tailored to highest density region estimation

Value

A numerical vector of length 1.

Author(s)

Matt Wand

hdrconf

References

17

Hyndman, R.J. (1996). Computing and graphing highest density regions. The American Statisti-
cian, 50, 120-126.

Samworth, R.J. and Wand, M.P. (2010). Asymptotics and optimal bandwidth selection for highest
density region estimation. The Annals of Statistics, 38, 1767-1792.

Examples

HDRlevelVal <- 0.55
x <- faithful$eruptions
hHDR <- hdrbw(x, HDRlevelVal)
HDRhat <- hdr.den(x, prob = 100 * (1 - HDRlevelVal), h = hHDR)

hdrconf

HDRs with confidence intervals

Description

Calculates Highest Density Regions with confidence intervals.

Usage

hdrconf(x, den, prob = 0.9, conf = 0.95)

Arguments

x

den

prob

conf

Value

Numeric vector containing data.
Density of data as list with components x and y.

Probability coverage for for HDRs.

Confidence for limits on HDR.

hdrconf returns list containing the following components:

hdr

hdr.lo

hdr.hi

falpha

Highest density regions

Highest density regions corresponding to lower confidence limit.

Highest density regions corresponding to upper confidence limit.

Values of fα corresponding to HDRs.

falpha.ci

Values of fα corresponding to lower and upper limits.

Author(s)

Rob J Hyndman

18

References

hdrscatterplot

Hyndman, R.J. (1996) Computing and graphing highest density regions American Statistician, 50,
120-126.

See Also

hdr(), plot.hdrconf()

Examples

x <- c(rnorm(100, 0, 1), rnorm(100, 4, 1))
den <- density(x, bw = hdrbw(x, 50))
hdr_conf <- hdrconf(x, den)
plot(hdr_conf, den, main = "50% HDR with 95% CI")

hdrscatterplot

Scatterplot showing bivariate highest density regions

Description

Produces a scatterplot where the points are coloured according to the bivariate HDRs in which they
fall.

Usage

hdrscatterplot(

x,
y,
levels = c(1, 50, 99),
kde.package = c("ash", "ks"),
noutliers = NULL,
label = NULL

)

Arguments

x

y

Numeric vector or matrix with 2 columns.
Numeric vector of same length as x.

levels

kde.package

noutliers

label

Percentage coverage for HDRs
Package to be used in calculating the kernel density estimate when den=NULL.

Number of outliers to be labelled. By default, all points outside the largest HDR
are labelled.
Label of outliers of same length as x and y. By default, all outliers are labelled
as the row index of the point (x, y).

lane2

Details

19

The bivariate density is estimated using kernel density estimation. Either ash::ash2() or ks::kde()
is used to do the calculations. Then Hyndman’s (1996) density quantile algorithm is used to com-
pute the HDRs. The scatterplot of (x,y) is created where the points are coloured according to which
HDR they fall. A ggplot object is returned.

Author(s)

Rob J Hyndman

See Also

hdr.boxplot.2d()

Examples

x <- c(rnorm(200, 0, 1), rnorm(200, 4, 1))
y <- c(rnorm(200, 0, 1), rnorm(200, 4, 1))
hdrscatterplot(x, y)
hdrscatterplot(x, y, label = paste0("p", seq_along(x)))

lane2

Speed-Flow data for Californian Freeway

Description

These are two data sets collected in 1993 on two individual lanes (lane 2 and lane 3) of the 4-lane
Californian freeway I-880. The data were collected by loop detectors, and the time units are 30
seconds per observation (see Petty et al., 1996, for details).

Usage

lane2; lane3

Format

Two data frames (lane2 and lane3) each with 1318 observations on the following two variables:

flow a numeric vector giving the traffic flow in vehicles per lane per hour.

speed a numeric vector giving the speed in miles per hour.

Details

The data is examined in Einbeck and Tutz (2006), using a nonparametric approach to multi-valued
regression based on conditional mean shift.

20

Source

maxtemp

Petty, K.F., Noeimi, H., Sanwal, K., Rydzewski, D., Skabardonis, A., Varaiya, P., and Al-Deek, H.
(1996). "The Freeway Service Patrol Evaluation Project: Database Support Programs, and Acces-
sibility". Transportation Research Part C: Emerging Technologies, 4, 71-85.

The data is provided by courtesy of CALIFORNIA PATH, Institute of Transportation Studies, Uni-
versity of California, Berkeley.

References

Einbeck, J., and Tutz, G. (2006). "Modelling beyond regression functions: an application of mul-
timodal regression to speed-flow data". Journal of the Royal Statistical Society, Series C (Applied
Statistics), 55, 461-475.

Examples

plot(lane2)
plot(lane3)

maxtemp

Daily maximum temperatures in Melbourne, Australia

Description

Daily maximum temperatures in Melbourne, Australia, from 1981-1990. Leap days have been
omitted.

Usage

maxtemp

Format

Time series of frequency 365.

Source

Hyndman, R.J., Bashtannyk, D.M. and Grunwald, G.K. (1996) "Estimating and visualizing condi-
tional densities". Journal of Computational and Graphical Statistics, 5, 315-336.

Examples

plot(maxtemp)

modalreg

21

modalreg

Nonparametric Multimodal Regression

Description

Nonparametric multi-valued regression based on the modes of conditional density estimates.

Usage

modalreg(

x,
y,
xfix = seq(min(x), max(x), l = 50),
a,
b,
deg = 0,
iter = 30,
P = 2,
start = "e",
prun = TRUE,
prun.const = 10,
plot.type = c("p", 1),
labels = c("", "x", "y"),
pch = 20,
...

)

Arguments

x

y

xfix

a

b

deg

iter

P

start

prun

Numerical vector: the conditioning variable.

Numerical vector: the response variable.

Numerical vector corresponding to the input values of which the fitted values
shall be calculated.
Optional bandwidth in x-direction.
Optional bandwidth in y-direction.

Degree of local polynomial used in estimation (0 or 1).

Positive integer giving the number of mean shift iterations per point and branch.

Maximal number of branches.
Character determining how the starting points are selected. "q": proportional to
quantiles; "e": equidistant; "r": random. All, "q", "e", and "r", give starting
points which are constant over x. As an alternative, the choice "v" gives vari-
able starting points, which are equal to "q" for the smallest x, and equal to the
previously fitted values for all subsequent x.
Boolean. If TRUE, parts of branches are dismissed (in the plotted output) where
their associated kernel density value falls below the threshold 1/(prun.const*(max(x)-min(x))*(max(y)-min(y))).

22

prun.const

plot.type

labels

pch

...

Details

modalreg

Numerical value giving the constant used above (the higher, the less pruning)

Vector with two elements. The first one is character-valued, with possible values
"p", "l", and "n". If equal to "n", no plotted output is given at all. If equal to
"p", fitted curves are symbolized as points in the graphical output, otherwise as
lines. The second vector component is a numerical value either being 0 or 1. If
1, the position of the starting points is depicted in the plot, otherwise omitted.

Vector of three character strings. The first one is the "main" title of the graphical
output, the second one is the label of the x axis, and the third one the label of
the y axis.

Plotting character. The default corresponds to small bullets.
Other arguments passed to cde.bandwidths().

Computes multi-modal nonparametric regression curves based on the maxima of conditional density
estimates. The tool for the estimation is the conditional mean shift as outlined in Einbeck and Tutz
(2006). Estimates of the conditional modes might fluctuate highly if deg=1. Hence, deg=0 is recom-
mended. For bandwidth selection, the hybrid rule introduced by Bashtannyk and Hyndman (2001)
is employed if deg=0. This corresponds to the setting method=1 in function cde.bandwidths. For
deg=1 automatic bandwidth selection is not supported.

Value

A list with the following components:

xfix

Grid of predictor values at which the fitted values are calculated.

fitted.values A P x length(xfix) matrix with fitted j-th branch in the j-th row (1 ≤ j ≤ P )
bandwidths

A vector with bandwidths a and b.
A [P x length(xfix)]- matrix with estimated kernel densities. This will only
be computed if prun=TRUE.

density

threshold

The pruning threshold.

Author(s)

Jochen Einbeck (2007)

References

Einbeck, J., and Tutz, G. (2006) "Modelling beyond regression functions: an application of mul-
timodal regression to speed-flow data". Journal of the Royal Statistical Society, Series C (Applied
Statistics), 55, 461-475.

Bashtannyk, D.M., and Hyndman, R.J. (2001) "Bandwidth selection for kernel conditional density
estimation". Computational Statistics and Data Analysis, 36(3), 279-298.

See Also

cde.bandwidths()

plot.cde

Examples

23

lane2.fit <- modalreg(lane2$flow, lane2$speed, xfix = seq(55) * 40, a = 100, b = 4)

plot.cde

Plots conditional densities

Description

Produces stacked density plots or highest density region plots for a univariate density conditional
on one covariate.

Usage

## S3 method for class 'cde'
plot(
x,
firstvar = 1,
mfrow = n2mfrow(dim(x$z)[firstvar]),
plot.fn = "stacked",
x.name,
margin = NULL,
...

)

Arguments

x

firstvar

mfrow

plot.fn

x.name

margin

...

Value

Output from cde().
If there is more than one conditioning variable, firstvar specifies which vari-
able to fix first.
If there is more than one conditioning variable, mfrow is passed to graphics::par()
before plotting.

Specifies which plotting function to use: "stacked" results in stacked conditional
densities and "hdr" results in highest density regions.

Name of x (conditioning) variable for use on x-axis.

Marginal density of conditioning variable. If present, only conditional densities
corresponding to non-negligible marginal densities will be plotted.

Additional arguments to plot.

If plot.fn=="stacked" and there is only one conditioning variable, the function returns the output
from graphics::persp(). If plot.fn=="hdr" and there is only one conditioning variable, the
function returns the output from hdr.cde(). When there is more than one conditioning variable,
nothing is returned.

24

Author(s)

Rob J Hyndman

References

plot.hdrcde

Hyndman, R.J., Bashtannyk, D.M. and Grunwald, G.K. (1996) "Estimating and visualizing condi-
tional densities". Journal of Computational and Graphical Statistics, 5, 315-336.

See Also

hdr.cde(), cde(), hdr()

Examples

faithful.cde <- cde(faithful$waiting, faithful$eruptions,

x.name = "Waiting time", y.name = "Duration time"

)
plot(faithful.cde)
plot(faithful.cde, plot.fn = "hdr")

plot.hdrcde

Plots highest density regions continuously over some conditioned vari-
able.

Description

Plots highest density regions continuously over some conditioned variable.

Usage

## S3 method for class 'hdrcde'
plot(
x,
plot.modes = TRUE,
mden,
threshold = 0.05,
xlim,
ylim,
xlab,
ylab,
border = TRUE,
font = 1,
cex = 1,
...

)

25

Output from hdr.cde().

Should modes be plotted as well as HDRs?
Marginal density in the x direction. When small, the HDRs won’t be plotted.
Default is uniform so all HDRs are plotted.
Threshold for margin density. HDRs are not plotted if the margin density mden
is lower than this value.

Limits for x-axis.

Limits for y-axis.

Label for x-axis.

Label for y-axis.

Show border of polygons

Font to be used in plot.

Size of characters.

Other arguments passed to plotting functions.

plot.hdrcde

Arguments

x

plot.modes

mden

threshold

xlim

ylim

xlab

ylab

border

font

cex

...

Value

None.

Author(s)

Rob J Hyndman

References

Hyndman, R.J., Bashtannyk, D.M. and Grunwald, G.K. (1996) "Estimating and visualizing condi-
tional densities". Journal of Computational and Graphical Statistics, 5, 315-336.

See Also

hdr.cde(), cde(),

Examples

faithful.cde <- cde(faithful$waiting, faithful$eruptions)
faithful.hdr <- hdr.cde(faithful.cde, prob = c(0.50, 0.95), plot = FALSE)
plot(faithful.hdr, xlab = "Waiting time", ylab = "Duration time")

26

plot.hdrconf

plot.hdrconf

Plot HDRs with confidence intervals

Description

Plots Highest Density Regions with confidence intervals.

Usage

## S3 method for class 'hdrconf'
plot(x, den, ...)

Output from hdrconf.
Density of data as list with components x and y.
Other arguments are passed to plot.

Arguments

x
den
...

Value

None

Author(s)

Rob J Hyndman

References

Hyndman, R.J. (1996) Computing and graphing highest density regions American Statistician, 50,
120-126.

See Also

hdrconf()

Examples

x <- c(rnorm(100, 0, 1), rnorm(100, 4, 1))
den <- density(x, bw = bw.SJ(x))
trueden <- den
trueden$y <- 0.5 * (exp(-0.5 * (den$x * den$x)) + exp(-0.5 * (den$x - 4)^2)) / sqrt(2 * pi)

par(mfcol = c(2, 2))
for (conf in c(50, 95)) {

m <- hdrconf(x, trueden, conf = conf)
plot(m, trueden, main = paste(conf, "% HDR from true density"))
m <- hdrconf(x, den, conf = conf)
plot(m, den, main = paste(conf, "% HDR from empirical density\n(n=200)"))

}

Index

∗ datasets

lane2, 19
maxtemp, 20

∗ distribution
cde, 3
cde.bandwidths, 5
hdr, 7
hdr.2d, 9
hdr.boxplot, 11
hdr.cde, 13
hdr.den, 14
hdrbw, 16
hdrconf, 17
hdrscatterplot, 18
plot.cde, 23
plot.hdrcde, 24
plot.hdrconf, 26

∗ hplot

cde, 3
hdr.2d, 9
hdr.boxplot, 11
hdr.cde, 13
hdr.den, 14
hdrscatterplot, 18
plot.cde, 23
plot.hdrcde, 24
plot.hdrconf, 26

∗ math

BoxCox, 2
∗ nonparametric
modalreg, 21

∗ regression

modalreg, 21

∗ smooth

cde, 3
cde.bandwidths, 5
hdr, 7
hdr.2d, 9
hdr.boxplot, 11

hdr.cde, 13
hdr.den, 14
hdrbw, 16
hdrconf, 17
hdrscatterplot, 18
plot.cde, 23
plot.hdrcde, 24
plot.hdrconf, 26

ash::ash2(), 10, 19

BoxCox, 2

cde, 3
cde(), 7, 13, 14, 23–25
cde.bandwidths, 5
cde.bandwidths(), 5, 22

graphics::par(), 23
graphics::persp(), 23

hdr, 7
hdr(), 12, 16, 18, 24
hdr.2d, 9
hdr.boxplot, 11
hdr.boxplot(), 8, 11, 16
hdr.boxplot.2d (hdr.2d), 9
hdr.boxplot.2d(), 12, 19
hdr.cde, 13
hdr.cde(), 23–25
hdr.den, 14
hdr.den(), 8, 12
hdrbw, 16
hdrconf, 17
hdrconf(), 26
hdrscatterplot, 18

InvBoxCox (BoxCox), 2

ks::kde(), 10, 19

27

INDEX

28

lane2, 19
lane3 (lane2), 19
locfit::locfit(), 4

maxtemp, 20
modalreg, 21

plot.cde, 23
plot.hdr2d (hdr.2d), 9
plot.hdrcde, 24
plot.hdrcde(), 13, 14
plot.hdrconf, 26
plot.hdrconf(), 18

stats::density(), 8, 12, 15
stats::ksmooth(), 4

