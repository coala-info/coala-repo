CFAssay: Statistics of the Colony Formation Assay

Herbert Braselmann

October 29, 2025

Research Unit Radiation Cytogenetics, Group Integrative Biology
Helmholtz Zentrum München

hbraselmann@online.de

Contents

1 Overview

1.1 The models . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . .
1.2 Remark on intercepts c and plating efficiencies

2 Example: Linear-quadratic model for cell survival curves

2.1 Data input and double-check . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.2 Calculation of cell survival curves . . . . . . . . . . . . . . . . . . . . . . . . . .
2.3 Comparison of the two cell survival curves . . . . . . . . . . . . . . . . . . . . .

1
2
2

3
3
3
6

3 Example: ANOVA for experimental two-way design

3.1 Data input and double-check . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.2 ANOVA model

9
9
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 10

1 Overview

The functions in this package provide tools for statistical analysis along with the colony forma-
tion assay (CFA) (Franken et al., 2006). These allow fitting of the linear-quadratic (LQ) model
for ionizing radiation dependent cell survival curves and ANOVA (analysis of variance) for ex-
perimental two-way designs with one dose level of a treatment factor. Maximum-Likelihood
(ML) based methods are preferred because, theoretically, parameter estimations of ML for
Poisson distributed data come with smaller variances compared to other methods. However,
for the sake of comparability also simple least squares (LS) based methods can be optionally
used. The ML based methods employ the R-function glm for generalised linear modelling,
while LS based methods use the R-function lm. The functions provided by CFAssay intend
to simplify and specialize the general use of that R-functions. The underlying distribution for
the ML based methods is Poisson (Frome and Beauchamp, 1968) and modelling is performed
using the link function "log", i.e. cell survival curves are logarithmically linear with "linear"
parameters α (per dose unit) and β (per squared-dose unit). In the two-way ANOVA model
the dependency of treatment factors is considered as logarithmically additive. Output sum-
maries are adapted from the glm or the lm functions and use the terminology of quantities

1

in the CFA. An accompanying paper is published in Radiation Oncology (Braselmann et al.,
2015).

1.1 The models

Cell survival S as a function of radiation dose using the so called LQ-model is given by

S = S(D) = ec+αD+βD2

(1)

D is the radiation dose and named dose in the code. D2 is named dose2 but has not to
be set by the user. Coefficients α and β appear as "alpha" and "beta" in the print function
of CFAssay. The intercepts c = log(S0) represent the logarithmic plating efficiencies, i.e.
surviving fractions of untreated cells in replicated experiments. They correspond to variable
Exp which is treated as a factor. Due to the positive formulation (1), parameters c, α and β
take negative values in the fit results.

The logarithmically additive 2-way ANOVA with two levels for each of the two factors can

mathematically be formulated as

or as nested parametrization

S = ec+Ax1+Bx2+Dx1x2

S = ec+Ax1+B0x2+(B1−B0)x1x2

(2)

(3)

There x1, x2 take level values 0 or 1 for each of the two factors A or B, where for e.g. 0
means untreated and 1 means treated. D is the factor for potential interaction and is coded
as A:B in R. In the second, nested parametrization B0 is the effect of treatment in control cells
and B1 the treatment effect after after applying A. The interaction D is then the difference
In the function cfa.2way of CFAssay we use per default the nested
between B1 and B0.
version, coded as A/B (see "An Introduction to R", Chapter 11 Statistical models in R). c
represents again the logarithmic plating efficiencies for each experiment.

1.2 Remark on intercepts c and plating efficiencies

By default CFAssay processes plating efficiencies (PE) from replicate experiments as model
parameters, i.e. as intercepts c, controlled by setting the option parameter PEmethod to
"fit". From a statistical point of view, this appears to be preferable, because likewise the
colony counts from treated cells the data from untreated cells are random observations. The
shape parameters α and β can be viewed as averaged over the experiments. The conven-
tional normalization method (PEmethod = "fix") that is applied on experimental replicate
PE measurements is mathematically equivalent to forcing the mean curve of the data to go
through the intercept of each particular replicate curve. In the case of somewhat increased
variation between the shape parameters of different experiments, conventional normalization
results in a larger dispersion parameter in combination with the ML method. In this case,
fitted intercepts c (named PE in the printed output) may deviate from the measured PEs,
however, they result in better overall statistics. On the shape parameter values itself, it has
little influence. Thus, it is more a matter of scale, what can be visualized in the diagnostic
plots using the function plotExp.

2

2 Example: Linear-quadratic model for cell survival curves

The data file contains data sets on irradiation experiments of the two cell lines CAL 33
(Bauer et al., 2010) and OKF6T/TERT1. The data set on CAL 33 comprises 4 repeated
experiments, and that of OKF6T/TERT1 8 experiments. The workflow shown here is divided
in the following three steps: 1. data input and double-check, 2. calculation of cell survival
curves for each of the two cell lines separately, 3. comparison test of the curves for the two
experiments

2.1 Data input and double-check

First we load the library and read the data into the memory. The data file, expl1_cellsurvcurves.txt,
is an unformatted tab-delimited text file and contains the data from the two irradiation ex-
periments.

> library(CFAssay)
> datatab <- read.table(system.file("doc", "expl1_cellsurvcurves.txt",
+

package="CFAssay"), header=TRUE, sep="\t")

The data file contains columns with header names cline, Exp, dose, ncells and ncolonies.

cline distinguishes the curves in the data frame. Exp discriminates replicates within each
curve. The dose column relates to the applied radiation dose, ncells to the number of cells
seeded and ncolonies to the number of counted colonies. The last four names are required by
the CFAssay function. The name of the first column (here "cline") is arbitrary and additional
columns for the distinction of curves may be contained in the data frame, e.g. pre-treatment.

> names(datatab)

[1] "cline"

"Exp"

"dose"

"ncells"

"ncolonies"

> head(datatab, 3)

# First 3 lines

cline Exp dose ncells ncolonies
182
284
323

1 cal33
2 cal33
3 cal33

900
1800
3000

e1
e1
e1

0
1
2

It is advisable to double-check the number of rows, columns and frequencies or cross
frequencies of the data with the R functions dim and table. The output is not shown here.

> dim(datatab)
> table(datatab$cline)
> table(datatab$cline, datatab$Exp)
> table(datatab$cline, datatab$dose)

2.2 Calculation of cell survival curves

With the CFAssay function cellsurvLQfit we calculate the parameters of a linear-quadratic
cell survival curve along with quality or goodness-of-fit statistics. For that purpose the data
frame datatab has to be filtered for data relating to one curve only, because the variable

3

cline is ignored by the fit function. With the function print the result is shown in three
tables, the coefficient table, the observed and fitted plating efficiencies table and a table for
analysis of the residual sum of weighted squares in the replicate experiments. In the coeffi-
cient table the "t value" column represents values of the t-test against zero of the estimated
coefficients ("Estimate") and column "Pr(>|t|)" contains the corresponding p-values. By de-
fault the maximum-likelihood method is used and plating efficiencies are fitted as intercepts.
Other options can be chosen in the argument list of cellsurvLQfit as explained in the help
document.

>
>

X <- subset(datatab, cline=="okf6TERT1")
dim(X)

[1] 48 5

>

fit <- cellsurvLQfit(X)

method = ml
PEmethod = fit

dose

dose2
-0.51937898 -0.02102614
Use 'print' to see detailed results

>

print(fit)

*** Coefficients of LQ-model for cell survival ***
method = ml
PEmethod = fit

Logarithmic plating efficiencies PE fitted as intercepts
see remark in the manual, 1.2

Estimate Std. Error

PEe1 -1.606686
PEe2 -1.693346
PEe3 -2.010377
PEe4 -1.869228
PEe5 -2.052405
PEe6 -2.219654
PEe7 -2.434634
PEe8 -2.109080

Pr(>|t|)
t value
0.1061229 -15.13986 1.112338e-17
0.1090082 -15.53412 4.781145e-18
0.1228551 -16.36380 8.506670e-19
0.1165115 -16.04329 1.644185e-18
0.1069872 -19.18365 3.828727e-21
0.1333357 -16.64711 4.789596e-19
0.1455642 -16.72550 4.091214e-19
0.1258530 -16.75828 3.830883e-19

Shape parameters alpha and beta

Estimate Std. Error

Pr(>|t|)
alpha -0.51937898 0.05889260 -8.819088 9.943331e-11
-0.02102614 0.00978985 -2.147749 3.817362e-02
beta

t value

Observed and fitted plating efficiencies (%):

Experiment

PE PEfitted
20.1

e1 19.0

PEe1

4

PEe2
PEe3
PEe4
PEe5
PEe6
PEe7
PEe8

e2 17.3
e3 10.0
e4 15.0
e5 9.2
e6 17.0
e7 14.3
e8 11.5

18.4
13.4
15.4
12.8
10.9
8.8
12.1

Residual Deviance: 167.8964
Total residual sum of weighted squares rsswTot: 164.8109
Residual Degrees of Freedom: 38
Dispersion parameter: 4.337128

Experiment

Fraction rssw of rsswTot per Experiment
rssw perCent
2.9
9.0
5.5
2.7
21.1
31.7
24.9
2.1

e1 4.84
e2 14.91
e3 9.01
e4 4.51
e5 34.77
e6 52.22
e7 41.09
e8 3.46

1
2
3
4
5
6
7
8

If the dispersion parameter is high, experimental data may have to be removed or replaced.
An appropriate cut-off depends on experience and may vary between different labs. For the
example data, where plating efficiencies were fitted, we recommend a cut-off of 9.0, which
corresponds to 3 Poisson standard deviations. With fixed plating efficiencies a cut-off of 12.0
may be appropriate. For the pure Poisson distribution the expected value of the dispersion
parameter is 1.0.

A plot of the mean curve is generated with plot. Values of plotted mean survival fractions

and error bars are shown with functions sfpmean and pes.

>
>
>
>

plot(fit)
S0 <- pes(X)$S0
names(S0) <- pes(X)$Exp
sfpmean(X, S0)

dose_0

dose_6
0.99275669 0.57563672 0.33274302 0.17935702 0.08517535 0.020704208
SF
stdev 0.03731008 0.04618487 0.03341709 0.02160074 0.01340983 0.004103207

dose_1

dose_4

dose_2

dose_3

5

With plotExp diagnostic plots for each experiment are generated. Here we plot them into

a pdf-file.

>
>
>

>
>
>
>
>
>

pdf("okf6TERT1_experimental_plots.pdf")

plotExp(fit)

dev.off()

The procedure is repeated for the other cell line, "cal33". The result is not shown here.

X <- subset(datatab, cline=="cal33")
dim(X)
fit <- cellsurvLQfit(X)
print(fit)
plot(fit)
plotExp(fit)

2.3 Comparison of the two cell survival curves

The two linear-quadratic cell survival curves are compared with the CFAssay function cellsurvLQdiff.
The required argument curvevar is set to "cline", which is the name of the column in datatab
which distinguishes the two curves to be compared. The function uses an ANOVA test for
comparison of two model fits. In "Model 1", which corresponds to the Null-hypothesis, the

6

01234560.010.020.050.100.200.501.00Dose (Gy)Survival (1 = 100%)dose coefficient (alpha) and the dose-squared coefficient (beta) are independent of the two
curves. In "Model 2" the coefficients are different. Detailed results are printed with function
print.

>

fitcomp <- cellsurvLQdiff(datatab, curvevar="cline")

*** Overall comparison for two linear-quadratic cell survival curves ***
Compared curves:
method: ml
PEmethod: fit

Test used: F-test

Pr(>F)

F
values 7.3509 0.001463 **
---
Signif. codes:
Use 'print' to see detailed results

0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

>

print(fitcomp)

Overall comparison test for coefficients alpha and beta of LQ-models
====================================================================
method = ml
PEmethod = fit

12 PEs fitted as intercepts. To look at, use simple R print function.
Null hypothesis (Model 1): one set of shape parameters alpha and beta for all data
----------------------------------------------------------------------------------

Estimate

Pr(>|t|)
alpha -0.39893900 0.047865098 -8.334653 1.687495e-11
-0.03434671 0.007828292 -4.387510 4.906364e-05
beta

Std. Error

t value

Goodness-of-fit values

Residual Deviance: 317.2604
Total sum of squared weighted residuals rsswTot: 319.7611
Residual Degrees of Freedom: 58
Dispersion parameter: 5.513123

Alternative hypothesis (Model 2): two sets of shape parameters alpha and beta
-----------------------------------------------------------------------------

Estimate

Pr(>|t|)
alpha:curvescal33
-0.26831918 0.062588637 -4.287027 7.206618e-05
alpha:curvesokf6TERT1 -0.51937898 0.059669207 -8.704305 5.439622e-12
-0.04892355 0.010058934 -4.863691 9.739225e-06
beta:curvescal33
beta:curvesokf6TERT1 -0.02102614 0.009918948 -2.119795 3.846873e-02

Std. Error

t value

Goodness-of-fit values

Residual Deviance: 251.804

7

Total sum of squared weighted residuals rsswTot: 249.3271
Residual Degrees of Freedom: 56
Dispersion parameter: 4.452269

Analysis of Variance Table and F-test
Model 2 versus Model 1

Resid. Df Resid. Dev Df Deviance

F

Pr(>F)

58
56

1
2
---
Signif. codes:

317.26
251.80

2

65.456 7.3509 0.001463 **

0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

The two curves are plotted with different colors in one plot, using the option add=TRUE.
Further annotations can be added by the user to the plot with the R functions legend and
text as needed.

>

plot(cellsurvLQfit(subset(datatab, cline=="okf6TERT1")), col=1)

method = ml
PEmethod = fit

dose

dose2
-0.51937898 -0.02102614
Use 'print' to see detailed results

>

plot(cellsurvLQfit(subset(datatab, cline=="cal33")), col=2, add=TRUE)

method = ml
PEmethod = fit

dose

dose2
-0.26831918 -0.04892355
Use 'print' to see detailed results

>

legend(0, 0.02, c("OKF6/TERT1", "CAL 33"), text.col=1:2)

8

3 Example: ANOVA for experimental two-way design

In this section a two-way ANOVA is demonstrated for the human oesophageal adenocarcinoma
cell line OE19 which was treated with the chemotherapeutic drug cisplatin/5-FU before and
after siRNA transfection. The results were previously published in (Aichler et al., 2013).
Of special interest was a potential interaction, i.e. chemosensitisation between the siRNA
transfection and the drug effect.

3.1 Data input and double-check

First the data are read into memory.

> datatab <- read.table(system.file("doc", "exp2_2waycfa.txt", package="CFAssay"),
+

header=TRUE, sep="\t")

The data file contains columns with header names Exp, x5fuCis, siRNA, ncells and
ncolonies. x5fuCis and siRNA stand for the drug and biological treatment, respectively.
They take values 0 for control or 1 for treated. The names of the other columns are as in the
cell survival curve example.

> names(datatab)

9

01234560.010.020.050.100.200.501.00Dose (Gy)Survival (1 = 100%)OKF6/TERT1CAL 33[1] "Exp"

"x5fuCis"

"siRNA"

"ncells"

"ncolonies"

> head(datatab, 3) # First 3 lines

Exp x5fuCis siRNA ncells ncolonies
750
0
546
1
316
0

1000
1000
1000

1 e1a
2 e1a
3 e1a

0
0
1

Again, number of rows and columns and frequencies or cross frequencies of the data may

be checked with R functions dim and table (output not shown).

> dim(datatab)
> table(datatab$x5fuCis)
> table(datatab$siRNA)
> table(datatab$Exp, datatab$x5fuCis)
> table(datatab$Exp, datatab$siRNA)

3.2 ANOVA model

Statistical analysis is performed with CFAssay function cfa2way, using parametrisation option
"A/B" corresponding to formula (3). In the argument list A and B have to be set as shown.
Maximum-likelihood method is default, but least-squares can be chosen optionally. The output
shows the result of a test for interaction.

>

fitcomp <- cfa2way(datatab, A="siRNA", B="x5fuCis", param="A/B")

*** Two-way ANOVA for factors A and B with interaction ***
A= siRNA , B= x5fuCis
Test for interaction: F-test

Pr(>F)

F
values 9.831 0.01202 *
---
Signif. codes:
Use 'print' to see detailed results

0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Detailed results are shown with function print.cfa2wayfit.

In the output A0:B1 and

A1:B1 correspond to B0 and B1 in formula (3).

> print(fitcomp, labels=c(A="siRNA", B="x5fuCis"))

*** Logarithmic linear two-way ANOVA for factors A and B with interaction ***
=============================================================================
A= siRNA , B= x5fuCis
Postscript digits for A or B: 0 inactive, 1 active
surv_percent = exp(Estimate)*100

Null hypothesis (Model 1): no interaction
-----------------------------------------

10

Estimate Std. Error
-6.656944 5.660071e-05
A1 -0.4237844 0.06366051
B1 -1.1187559 0.07738539 -14.456939 4.980588e-08

Pr(>|t|) surv_percent
65.5
32.7

t value

Goodness-of-fit values

Residual Deviance: 77.99569
Total sum of squared weighted residuals ssqwresTot: 75.87275
Residual Degrees of Freedom: 10
Dispersion parameter: 7.587275

Alternative hypothesis (Model 2): interaction
---------------------------------------------
parametrization: A/B

Estimate Std. Error

t value

A1
-0.3484218 0.05266374 -6.615972 9.746888e-05
A0:B1 -0.9757699 0.07170380 -13.608343 2.619891e-07
A1:B1 -1.3432352 0.09470322 -14.183627 1.832336e-07

Pr(>|t|) surv_percent
70.6
37.7
26.1

Goodness-of-fit values

Residual Deviance: 37.15596
Total sum of squared weighted residuals ssqwresTot: 37.38767
Residual Degrees of Freedom: 9
Dispersion parameter: 4.154185

Analysis of Variance Table and F-test
Model 2 versus Model 1

Resid. Df Resid. Dev Df Deviance

F Pr(>F)

10
9

1
2
---
Signif. codes:

77.996
37.156 1

40.84 9.831 0.01202 *

0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Diagnostic plots for repeated experiments are printed to pdf.

pdf("TwoWay_experimental_plots.pdf")

plotExp(fitcomp, labels=c(A="siRNA", B="x5fuCis"))

dev.off()

>
>
>

References

Aichler, M., Elsner, M., Ludyga, N., Feuchtinger, A., Zangen, V., Maier, S. K., Balluff, B.,
Schöne, C., Hierber, L., Braselmann, H., et al. (2013). Clinical response to chemotherapy
in oesophageal adenocarcinoma patients is linked to defects in mitochondria. The Journal
of pathology, 230(4):410–419.

Bauer, V. L., Hieber, L., Schaeffner, Q., Weber, J., Braselmann, H., Huber, R., Walch, A.,
and Zitzelsberger, H. (2010). Establishment and molecular cytogenetic characterization of a
cell culture model of head and neck squamous cell carcinoma (hnscc). Genes, 1(3):388–412.

11

Braselmann, H., Michna, A., Heß, J., and Unger, K. (2015). Cfassay: statistical analysis of

the colony formation assay. Radiation Oncology, 10(1):1.

Franken, N. A., Rodermond, H. M., Stap, J., Haveman, J., and Van Bree, C. (2006). Clono-

genic assay of cells in vitro. Nature protocols, 1(5):2315–2319.

Frome, E. L. and Beauchamp, J. J. (1968). Maximum likelihood estimation of survival curve

parameters. Biometrics, pages 595–605.

12

