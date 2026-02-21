MoPS - Model-based Periodicity Screening

Philipp Eser, Achim Tresch

April 24, 2017

Contents

1 Overview

2 Installation

3 MoPS Quickstart

4 Basic Usage

5 Speciﬁcation

5.1 Formal description . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
Implementation . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
5.2

6 Case Study - Yeast Cell Cycle

6.1 Detection of periodically expressed genes . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
6.2 Characterisation of cell cycle regulated genes . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

1

1

1

2

4
4
5

7
7
8

1 Overview

The detection and characterization of periodic changes of measurements in time is important in many ﬁelds of
science. This package employs a model-based screening algorithm for the identiﬁcation of periodic ﬂuctuations in
time series datasets. It uses a likelihood ratio statistic to decide whether a time series displays periodic ﬂuctuations
or not. Additionally MoPS infers the best ﬁtting periodic time course for each time series and thus allows the
characterization of various parameters like period length and phase. The algorithm was originally designed to identify
and characterize periodic expression proﬁles in Microarray time series measurements. Hence, the described case study
(section 6) is based on a time series of genome-wide expression measurements during the S.cerevisiae cell cycle [1].

2 Installation

To run the MoPS package, the software R (> 3.0.0) has to be installed. For installation of R, refer to http:
//www.r-project.org. To see how to install add-on R-packages, start R and type in help(INSTALL). To install
the MoPS package, use the function biocLite. Once the package is installed, you can load it by

> library(MoPS)

3 MoPS Quickstart

The application of MoPS essentially requires only two commands, fit.periodic and predictTimecourses: Given
a (noisy, possibly periodic) time series, say

1

MoPS - Model-based Periodicity Screening

2

> y = 2*sin(seq(0,6*pi,length.out=50))
> y.noise = y+rnorm(50,sd=1)

we can estimate a best periodic ﬁt to the time series y.noise by

> res = fit.periodic(y.noise)

the ﬁtted time course can be accessed by

> predicted = predictTimecourses(res)

We visualize the results in a plot:

> plot(y.noise,type="l",col="red")
> points(y,type="l")
> points(predicted,type="l",lwd=2.5,col="limegreen")

4 Basic Usage

This section illustrates the basic usage of MoPS to ﬁt periodic time courses to time series data. We demon-
strate the use of MoPS at the example of 10 time series consisting of 41 consecutive measurements each (see
help(fit.periodic) for more information on how these data were obtained).

> data(basic)
> dim(basic)

[1] 10 41

For illustration, let us plot time course 1 and 10.

> par(mfrow=c(2,1))
> plot(basic[1,],type="l",main="time course No. 1",xlab="",ylab="[arb. units]")
> plot(basic[10,],type="l",main="time course No. 2",xlab="",ylab="[arb. units]")

01020304050−2024Indexy.noiseMoPS - Model-based Periodicity Screening

3

The function fit.periodic performs the ﬁtting of periodic functions to each time series in the data matrix. The
results can be converted to a data.frame that yields the best ﬁtting periodic parameters for each time series.

> res = fit.periodic(basic)
> result.as.dataframe(res)

ID score phi lambda sigma mean amplitude
0.95
0.92
0.97
1.07
0.92
0.93
1.01
1.13
1.12
0.96

7
ID_1 1.12
1
8
ID_2 1.48
2
ID_3 1.76 11
3
ID_4 1.39 13
4
1
ID_5 1.06
5
3
ID_6 1.18
6
6
ID_7 1.72
7
ID_8 1.63
9
8
9
ID_9 1.26 10
10 ID_10 1.26 12

0 0.08
0 -0.03
0 0.05
0 0.06
0 0.01
0 -0.03
0 -0.02
0 0.10
0 0.03
0 0.12

13
14
14
14
14
14
14
13
14
14

For each time series (black line), using the ﬁtted parameters, we can now calculate and plot the predicted time course
(green). By default, predictTimecourses returns a matrix of the same dimension as the input matrix basic that
was used for learning the parameters.

> fitted.mat = predictTimecourses(res)
> dim(fitted.mat)

[1] 10 41

> par(mfrow=c(2,1))
> plot(basic[1,],type="l",main="time course No. 1",xlab="",ylab="[arb. units]")
> points(fitted.mat[1,],type="l",col="limegreen",lwd=2)

010203040−1.50.01.5time course No. 1[arb. units]010203040−1.00.51.5time course No. 2[arb. units]MoPS - Model-based Periodicity Screening

4

> plot(basic[10,],type="l",main="time course No. 2",xlab="",ylab="[arb. units]")
> points(fitted.mat[10,],type="l",col="limegreen",lwd=2)

5 Speciﬁcation

5.1 Formal description

MoPS determines an optimal periodic ﬁt to a given time series. It provides the parameters of the optimal ﬁt, plus
a periodicity score that can be used to rank several time courses according to their periodicity. The central idea
is to compare the best least squares ﬁt among an exhaustive set of periodic test functions with the best ﬁt of a
corresponding set of non-periodic test functions. The log likelihood ratio of these two ﬁts is our periodicity score (see
Figure 1).

MoPS uses periodic curves that are parametrized by a 6-tuple (lambda, sigma, phi, psi, mean, amplitude) of param-
eters. The period length lambda deﬁnes the time duration between two consecutive maxima. The parameter phi
determines the phase, e.g. the time point at which the time course assumes its maximal values. The parameter sigma
determines the magnitude of attenuation of the signal along the complete time course. This can arise if there is
increasing synchrony loss with time, leading to a blurred proﬁle with decreasing amplitude. Finally, the parameter psi
allows the generation of more ﬂexible periodic test functions by deforming the sine wave curves at variable sampling
points (see Figure 2).

Note that we use an equidistant grid of phases which is independent of the period length (lambda). This makes sure
that for each lambda the same phase increment is used and thus does not favor test functions with small lambda.

010203040−1.50.01.5time course No. 1[arb. units]010203040−1.00.51.5time course No. 2[arb. units]MoPS - Model-based Periodicity Screening

5

Figure 1: Scoring of time series according to periodicity. Each input time course is ﬁtted to an exhaustive set of
periodic (left) and non-periodic (right) test functions. The log likelihood ratio of the best ﬁtting test functions is the
periodicity score (taken from [1]).

Figure 2: Fitting of a characteristic periodic proﬁle to time course measurements. See text for a description of the
parameters (taken from [1]).

5.2

Implementation

The main function of the MoPS package is fit.periodic, a method that determines an optimal ﬁt of a periodic
curve to a given time course. The function takes as input a matrix containing time series measurements and optionally
a set of parameters that are used to model the underlying periodicity.

fit.periodic automatically creates periodic test functions based on all possible combinations of the input param-
eters.
It then
It further creates non-periodic test functions that represent a diverse set of constant time courses.
compares each input time course to all periodic and non-periodic test functions with linear regression based on the
lm function to estimate the likelihood of periodic behaviour. Instead of using plain least squares regression, the user
can specify a vector of regression weights for each measurement. This is particularly useful when the magnitude of
the measurement error is not constant for all measurements, as, e.g., for gene expression measurements.

best fitting periodictest-function best fitting non-periodictest-function050100150200−0.2−0.10.00.10.2050100150200−0.3−0.2−0.10.00.10.20.3050100150200−0.20.00.20.4Periodicity score = logL(fg;g)L(fg;g)ff0501001502000.20.40.60.82π0attenuationdue tosynchronyloss σmeasurement time coursepeak time φmeanmRNAlevel mamplitude Aperiod length λt1t2t3t4t0=0t5=2πperiodicity score Pshape parameter Ψfitted time courseMoPS - Model-based Periodicity Screening

6

The screening result is returned as a list object (for a detailed description, see help(fit.periodic)). The ﬁrst slot
contains the screening result for each time series (here only the ﬁrst is shown):

> res$fitted[[1]]

$ID
[1] "ID_1"

$score
[1] 1.122195

$minLossPeriodic
[1] 7.680137

$minLossNonPeriodic
[1] 23.59022

$phi
[1] 7

$psi
NULL

$lambda
[1] 13

$sigma
[1] 0

$a.coef
[1] 0.9513084

$b.coef
[1] 0.08037059

The remaining slots contain information about the screened parameter ranges:

> res[2:6]

$time

[1] 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25

[26] 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41

$cols.mat
[1] 41

$phi

[1] 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25

[26] 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41

$lambda

[1] 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25

[26] 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41

$sigma
[1] 0

This result list serves as input to the function predictTimecourses and thus contains several parameters that need
not necessarily be accessed by the user. The function result.as.dataframe can convert the result object to a
data.frame which includes only the time series speciﬁc best ﬁtting periodic parameters:

> head(result.as.dataframe(res))

MoPS - Model-based Periodicity Screening

7

ID score phi lambda sigma mean amplitude
0.95
0.92
0.97
1.07
0.92
0.93

7
1 ID_1 1.12
2 ID_2 1.48
8
3 ID_3 1.76 11
4 ID_4 1.39 13
1
5 ID_5 1.06
3
6 ID_6 1.18

0 0.08
0 -0.03
0 0.05
0 0.06
0 0.01
0 -0.03

13
14
14
14
14
14

The function predictTimecourses constructs the best ﬁtting periodic time course for each entry. By default, the
resulting matrix of predicted time courses has the same dimensions as the original input matrix. However, the number
of columns changes, if the user chooses a phase grid that has more resolution (less spacing) than the measurements
points.

6 Case Study - Yeast Cell Cycle

The following section illustrates the workﬂow for the identiﬁcation and characterization of cell cycle regulated genes
in expression time series data. We start by loading a data matrix that contains normalized mRNA expression time
series of 200 genes (rows) (subset of data published in [1], ArrayExpress E-MTAB-1908). The values in each column
correspond to the measurements taken at diﬀerent time points after release from cell cycle arrest.
It entails 41
samples that are separated by 5 minutes, covering a total of 205 minutes.

> data(ccycle)
> timepoints = seq(5,205,5)

6.1 Detection of periodically expressed genes

The ﬁrst step in the MoPS screening procedure is the construction of the exhaustive set of periodic test functions.
This is done by specifying a cartesian grid of parameters that deﬁne the test functions.
I.e., for each parameter,
we specify a set of values that will be combined with all other parameter choices. We aim to identify genes that
are expressed in a cell cycle regulated manner and thus show periodic expression proﬁles. We will use the input
parameters phi, lambda and sigma to model this periodic expression. Accordingly, lambda corresponds to the cell
cycle length, phi is the time at which maximal expression is achieved and sigma corresponds to the magnitude of
synchrony loss.
While phi and lambda are basic parameters of periodic functions, sigma is harder to conceive:
it determines the
magnitude of attenuation along the complete time course. Here, this arises from cell cycle length diﬀerences of
individual cells in the population which in turn leads to increasing loss of synchrony after release from cell cycle
arrest.
By choosing meaningful parameter ranges for lambda, phi and sigma we screen our data for cell cycle regulated genes:

> phi = seq(5,80,5)
> lambda = seq(40,80,5)
> sigma = seq(4,8,1)
> res = fit.periodic(ccycle,timepoints=timepoints,phi=phi,lambda=lambda,sigma=sigma)
> res.df = result.as.dataframe(res)
> head(res.df)

1 YPR179C -0.03 15
2 YLR212C 1.28 15
3 YAR003W 1.14 15
4 YGL148W -0.59 30
5 YKL068W -0.08 45
5
6 YDR019C -0.56

ID score phi lambda sigma
8
90.94
5 1288.87
7 539.42
8 5834.10
4 1202.26
5 1307.84

mean amplitude
28.97
578.22
182.85
530.00
49.12
449.30

40
60
65
40
55
50

fit.periodic returns the best-ﬁtting periodic parameter set and periodicity score for each gene. Genes with a
positive score achieve better ﬁts with periodic than non-periodic test functions. However, this does not imply
statistical signiﬁcance, it merely provides a ranking of genes. The ﬁtting results are used to predict the periodic time
courses for all genes:

MoPS - Model-based Periodicity Screening

8

> time.courses = predictTimecourses(res)
> dim(time.courses)

[1] 200 41

This results in a numeric matrix containing the ﬁtted characteristic time courses, which can be plotted for individual
genes.

> id = "YPL133C"
> t = time.courses[id,]
> plot(timepoints,t,type="l",col="limegreen",lwd=2.5,main=id,
+
> points(timepoints,ccycle[id,],type="l",col="black")

xlab="time [min]",ylab="expression",ylim=c(220,580))

Using the gene-speciﬁc best ﬁtting parameters of genes with score > 0, we can derive the median cell cycle length
and variation in the population.

> lambda.global = median(res.df$lambda[res.df$score > 0])
> lambda.global

[1] 60

> sigma.global = median(res.df$sigma[res.df$score > 0])
> sigma.global

[1] 7

6.2 Characterisation of cell cycle regulated genes

The following analyses aim to characterize the periodic time courses of cell cycle regulated genes. MoPS provides
an optional parameter psi that deﬁnes the ﬂexibility to shape the periodic test functions. Using this parameter, the
number of created test functions increases greatly and leads to better ﬁts. The larger the number of psi, the more
ﬂexible but also more time consuming the calculations.

In this case study, the estimated cell cycle length (lambda.global) and its variation in the cell population (sigma.global)
is a common characteristic and should be the same for all genes. Thus we want to ﬁx these global parameters and
ﬁt the gene-speciﬁc phase and shape (psi) of the gene expression time courses.

050100150200250300350400450500550YPL133Ctime [min]expressionMoPS - Model-based Periodicity Screening

9

First we limit the data matrix to genes that are putatively cell cycle regulated (score > 0) which we can derive from
the result of the ﬁrst screening.

> periodic.ids = res.df$ID[res.df$score > 0]
> ccycle = ccycle[periodic.ids,]

To achieve better resolution, it makes sense to decrease the spacing between phases in this screening.

> phi = seq(5,80,2.5)
> res.shape = fit.periodic(ccycle,timepoints=timepoints,
+
+
+
+
> time.courses.shape = predictTimecourses(res.shape)

phi=phi,
lambda=lambda.global,
sigma=sigma.global,
psi=2)

Note that we set the shape-parameter psi to 2 in order to speed up the ﬁtting. The user can set this parameter
to higher values to allow a more ﬂexible ﬁtting. We again plot the expression time course of our example gene
(YPL133C) together with the ﬁtted time course and extract the phase of its maximal epxression.

> t = time.courses.shape[id,]
> predicted.phase = phi[which(t == max(t))]
> plot(timepoints,ccycle[id,],type="l",lwd=2,ylim=c(220,580),
+
+
> new.timepoints = seq(5,205,2.5)
> points(new.timepoints,t,type="l",col="limegreen",lwd=3)
> abline(v=predicted.phase,col="limegreen",lwd=3)

xlab="time [min]",ylab="expression",
main=paste(id,"| peak at",predicted.phase,"min"))

References

[1] Philipp Eser, Carina Demel, Kerstin C. Maier, Bj¨orn Schwalb, Nicole Pirkl, Dietmar E. Martin, Patrick Cramer,
and Achim Tresch. Periodic mrna synthesis and degradation co-operate during cell cycle gene expression. Mol
Syst Biol, 10:717, 2014.

050100150200250300350400450500550YPL133C | peak at 37.5 mintime [min]expression