Estimate proliferation in cell-tracking dye studies

Davide Rambaldi

January 4, 2019

Abstract

Background In cells proliferation tracking experiments, cells are stained with a tracking
dye before culture. During cell division, the dye will be divided between daughter cells
so that each daughter cell brings about a halving of ﬂuorescence intensity of the mother.
The ﬂuorescence intensity of a cell, by comparison with the ﬂuorescence intensity of resting
cells, provides an indication of how many divisions the cell has undergone since stimulation.
Analysis of the ﬂorescence of cells in the ﬂow cytometric data ﬁle acquired after some days
of culture (with stimulation of cell proliferation) provides an estimate of the percentage of
cells for generation (Givan et al., 2004), (Wallace et al., 2008).
Methods: This package uses an R implementation of the Levenberg-Marquardt algorithm
(minpack.lm) to ﬁt a set of peaks (corresponding to diﬀerent generations of cells) over the
proliferation-tracking dye distribution in a FACS experiment. The package in integrated
with other Bioconductor softwares for analysis of ﬂow cytometry datasets like ﬂowCore and
ﬂowViz (Klinke and Brundage, 2009).
Results: We have tested the ﬁtting algorithm with three samples of mouse lymphocytes
stained with carboxyﬂuorescein diacetate succinimidyl ester (CFSE), Cell Trace Violet
(CTV) and Cell Proliferation Dye eFluor 670 (CPD) (Quah and Parish, 2012)
keywords Flow Cytometry, high throughput, data ﬁtting

1

1 Introduction

Fluorescent dyes are increasingly being exploited to track cells migration and proliferation.
The typical experimental pipeline with tracking dyes involves the following steps:

1 Label cells with a Proliferation Tracking Dye

2 Culture in vitro +/- stimulus for 0-10 days

3 Counterstain with subset speciﬁc antibodie

4 Analyze by ﬂow cytometry

In the Flow Cytometer:

1 Acquire with FACS a sample of unlabelled cells

2 Acquire with FACS a sample of labeled and unstimulated cells (the Parent Population)

3 Acquire with FACS a sample of labeled and stimulated cells (the Proliferative Population)

In the last 20 years, a set of ﬂuorochromes has been used to track cell proliferation (Parish,
1999). We can divide those dyes in 4 major groups (with some examples):

(cid:136) DNA-binding ﬂuorescent dyes:

– Hoechst 33342
– Thiazole Orange

(cid:136) Cytoplasmic ﬂuorescent dyes:

– Calcein
– BCECF-AM

(cid:136) Covalent coupling ﬂuorescent dyes:

– Carboxyﬂuorescein diacetate succinimidyl ester (CFSE)
– Fluorescein isothiocyanate (FITC)
(cid:136) Membrane-inserting ﬂuorescent dyes:

– PKH26
– CellVue Lavender

If the characteristics of the logarithmic ampliﬁer on the ﬂow cytometer are known, it is possible
to derive, from a histogram of ﬂuorescence intensity, the proportion of cells that have undergone
any particular number of divisions (Givan et al., 1999). Generally, a ﬂow cytometer with 1024
channels (channels range) represents a nominal range of 4 log-decades. The calibration can be
done using standardized beads (for example: Rainbow Beads from Spherotech) (Givan et al.,
2004).
Here we introduce ﬂowFit, an R bioconductor library that ﬁt a set of peaks (corresponding
to diﬀerent generations of cells) over the histogram of ﬂuorescence intensity acquired during
a FACS experiment. The package is integrated with the Bioconductor libraries used for the
analysis of ﬂow cytometry datasets: ﬂowCore and ﬂowViz.

2

2 Methods

2.1 Single Peak Formula

The algorithm ﬁt a set of N peaks on the acquired fcs ﬁles using the minpack.lm. The
Levenberg-Marquardt algorithm provides a numerical solution to the problem of minimizing
a function over a space of parameters. It is an iterative technique that locates the minimum
of a multivariate function. The ”minimum” is expressed as the sum of squares of non-linear
real-valued functions.
We ﬁt an initial single peak on the population of cells labeled and un-stimulated (the Parent
Population) according to this formula:

a2 exp

(x − µ)2
2σ2

Where a2 is proportional to the height of the peak, µ is the peak position on the FACS scale
and σ is proportional to the peak size.
Once we have ﬁtted a single peak on the parent population, we can use the parent peak position
and size as parameters for the ﬁtting on the proliferative population. Given that the tracking
dye is partitioned equally between daughter cells, the noise in the data is mainly due to the
variance in the initial staining. The formula for the next peak (corresponding to cells that have
divided one time) will be:

b2 exp

(x − (µ − D))2
2s2

Where D is the estimated distance between 2 generations of cells.

2.2 Generations Distance, data range and log decades

The distance between two cell generations is deﬁned as the distance between a cell and his
child (that contains half of the dye of the mother). This distance is constant on a logarithmic
scale and depends from the number of data points in the FACS instrument and from the log
decades. We can convert the FACS Fluorescence Intensity (FFI) recorded by the instrument
into a Relative Fluorescence Intensity (RFI) expressed in Molecules of Equivalent Fluorochrome
(MEF):

RF I = 10

F F I·l
c

The inverse formula can be used to convert from RFI to FACS ﬂuorescence:

F F I =

c · log(RF I)
(l · log(10))

Where:

(cid:136) RF I is the Relative Fluorescence Intensity

3

(cid:136) F F I is the ﬂuorescence on the FACS scale

(cid:136) l is the number of log decades in the FACS instrument

(cid:136) c is the number of data points (channels) in the instrument.

Using this formulas it is possible to estimate the spacing between generations on the FACS
scale. The spacing value is automatically computed, based on the number of decades and the
assumption that each generation has one-half of the intensity of the previous generation. In
the ﬂowFit library this spacing is automatically computed with the function generations-
Distance.
The number of log decades represented by the original data’s linear scale can be calculated as
log(R) where R is the acquisition resolution (data range for the detector).
The proliferationFitting and parentFitting functions automatically compute the log
decades from the keywords in the FCS ﬁle or using the logarithm of the data Range ( log(R) ).
If the functions ﬁnd a ”log decades” keyword for the current detector in the FCS ﬁle, they use
the value in the keyword, otherwise log decades are estimated from the detector acquisition
resolution.

2.3 Fitting Formula

The algorithm automatically computes the number of peaks to be ﬁtted on the proliferating
population using the data range for the detector: we ﬁrst estimate the distance between 2
generations of cells using the generationsDistance function, then we estimate the maximum
number of peaks that can be ﬁtted on the FACS instrument scale with the following formula:

N =

D
c

Where:

(cid:136) N is the number of peaks to ﬁt on the dataset

(cid:136) D is the distance between 2 generations of cells

(cid:136) c is the number of data point (channels) in the instrument

The formula for a model with 10 peaks will be:

M = a2 exp

(x − M )2

2s2 +b2 exp

(x − (M − D))2
2s2

+c2 exp

(x − (M − 2D))2
2s2

+d2 exp

(x − (M − 3D))2
2s2

+e2 exp

(x − (M − 4D))2

(x − (M − 5D))2

(x − (M − 6D))2

(x − (M − 7D))2

(x − (M − 8D))2

(x − (M − 9D))2

2s2

+g2 exp

2s2

+h2 exp

2s2

+i2 exp

2s2

+l2 exp

2s2

+f 2 exp

2s2

Where the parameters a,b,c,d,e,f,g,h,i and l are proportional to the height of the peak.
In
the ”ﬁxed model” (options ﬁxedModel=TRUE) the minpack.lm algorithm estimates the height
of each peak but allows the user to keep constant one ore more of these variables: parent
peak position (m), parent peak size (s) and generation’s distance (D). In the ”dynamic model”
(options ﬁxedModel=FALSE) the minpack.lm algorithm uses as parameters all the variables in

4

the model: the height of each peak, the parent peak position (m), the parent peak size (s) and
the generation’s distance (D).
In the Levenberg-Marquadt algorithm implementation we use this formula to estimate the
error between the model and the real data:

residF un = (Observed − M odel)2

2.4 % of cells for generation

With the nls.lm function we have estimated the ”heights” parameter (the height of each peak),
we can use it to get an estimate of the number of cells for generation. We compute the total
number of cells analyzed in the model with a numerical integration on the complete model:

Iall =

(cid:90) w

v

M

Where v and w, the lower and upper limits for numerical integration, are the minRange and
maxRange values for the analyzed fcs column. For each generation, we compute the number of
cells in the peak with a numerical integration. For example, the formula for the ﬁrst generation
of cells is:

I1 =

(cid:90) w

v

a2 exp

(x − µ)2
2σ2

Where v and w, the lower and upper limits for numerical integration, are the minRange and
maxRange values for the analyzed fcs column.
To estimate the % of cells for generation we simply take the ratio between the complete model
numerical integration and the integration of a single generation of cells:

Gen1 =

I1
Iall

∗ 100

2.5 Proliferation Index

To evaluate the proliferation in the sample we can use the proliferationIndex function:
proliferation index is calculated as the sum of the cells in all generations including the parental
divided by the computed number of original parent cells theoretically present at the start of
the experiment.
The proliferation index it’s a measure of the fold increase in cell number in the culture over
the course of the experiment:

(cid:80)i

0 Ni
0 N i/2i

(cid:80)i

Where i is the generation number (parent generation = 0). In the absence of proliferation,
that is, when all cells are in the parent generation, the formula gives:

5

N0
N0/20 = 1

deﬁning the lower limit of the PI.

3 Fitting Flow Cytometry Data

The primary task ofﬂowFit is to estimate the number of cells for generation in a proliferation
tracking dye study. This is accomplished with the functions: parentFitting and prolifer-
ationFitting.
In order to reduce the download size of ﬂowFit, we have moved the example dataset to a
Bioconductor data package (ﬂowFitExampleData) that can be downloaded in the usual way.

> if (!requireNamespace("BiocManager", quietly=TRUE))
+
install.packages("BiocManager")
> BiocManager::install("flowFitExampleData")

First of all we must load the package and the examples:

> library(flowFitExampleData)
> library(flowFit)

We must also load the flowCore package to load some functions used in this vignette:

> library(flowCore)

In this example we will use the package ﬂowFit to calculate the percentage of cells for generation
in a single CD4+ population of lymphocytes labeled with: CFSE, CPD and CTV. ﬂowFit use
the Bioconductor package ﬂowCore to load .FCS ﬁles. For this example, we provide some
example data in the ﬂowFitExampleData that can be loaded in your environment with the
command:

> data(QuahAndParish)

The QuahAndParish dataset contains 4 FCS ﬁles, those ﬁles are the raw data of the ﬁgure
2 (CD4+ subpopulation) in the paper: New and improved methods for measuring
lymphocyte proliferation in vitro and in vivo using CFSE-like ﬂuorescent dyes
(Quah and Parish, 2012).

1. CD4+ labeled with CFSE, CPD and CTV (Non stimulated)

2. CD4+ labeled with CFSE (stimulated)

3. CD4+ labeled with CPD (stimulated)

4. CD4+ labeled with CTV (stimulated)

6

3.1 Parent Fitting

First of all we must estimate the parent population position and size with the function parent-
Fitting. The ﬁrst sample in the ﬂowSet, correspond to the cells non stimulated and stained
with the 3 dyes (parent population):

> QuahAndParish[[1]]

flowFrame object
with 4541 cells and 13 observables:

Fig 2a All CD4 T Nonstim.fcs

’

’

name desc range

FSC-A
$P1
FSC-H
$P2
FSC-W
$P3
SSC-A
$P4
SSC-H
$P5
SSC-W
$P6
<FITC-A>
$P7
<PE-A>
$P8
$P9
<PE-Cy5-A>
$P10 <Alexa Fluor 405-A>
$P11 <Alexa Fluor 430-A>
<APC-A>
$P12
$P13
<APC-Cy7-A>
154 keywords are stored in the

minRange

maxRange
262207 51906.250000 2.622060e+05
262207 47800.500000 2.622060e+05
262207 68451.750000 2.622060e+05
90.194656 2.615870e+05
261588
100.010956 2.999800e+04
29999
262207 47132.250000 2.622060e+05
3.077193 5.417616e+00
261588
3.450857 5.417616e+00
261588
0.000000 5.417616e+00
261588
0.000000 5.417616e+00
261588
0.000000 5.417616e+00
261588
0.000000 5.417616e+00
261588
0.000000 5.417616e+00
261588

’

description

slot

’

We ﬁt a parent population peak for each dye (CFSE, CPD and CTV) (See ﬁgure 1,ﬁgure 2,ﬁg-
ure 3). To estimate position and size of the parent population peak, we must have the following
informations on the FACS instrument:

1. The FCS detector name: the name of the FCS column in the ﬂowFrame

2. The data range for the FCS detector (after transformations).

3. The log decades for the FCS detector: the number of log decades represented by the

original data’s linear scale

7

3.1.1 Fitting And Plots

CFSE Parent Population

> parent.fitting.cfse <- parentFitting(QuahAndParish[[1]], "<FITC-A>")
> plot(parent.fitting.cfse)

Figure 1: CD4+ CELLS PARENT FITTING CFSE

8

Parent Population<FITC−A>Events0204060801e+001e+011e+021e+031e+041e+05Events:  228Deviance: 1283Parent Peak Position: 4.7Parent Peak Size: 0.04> parent.fitting.cpd <- parentFitting(QuahAndParish[[1]], "<APC-A>")
> plot(parent.fitting.cpd)

Figure 2: CD4+ CELLS PARENT FITTING CPD

9

Parent Population<APC−A>Events0204060801001201401e+001e+011e+021e+031e+041e+05Events:  128Deviance: 932Parent Peak Position: 4.81Parent Peak Size: 0.07> parent.fitting.ctv <- parentFitting(QuahAndParish[[1]], "<Alexa Fluor 405-A>")
> plot(parent.fitting.ctv)

Figure 3: CD4+ CELLS PARENT FITTING CTV

10

Parent Population<Alexa Fluor 405−A>Events0501001501e+001e+011e+021e+031e+041e+05Events:  106Deviance: 1399Parent Peak Position: 4.77Parent Peak Size: 0.053.1.2 summary and coef

The summary function produces some result summaries:

> summary(parent.fitting.cfse)

********* flowFit: Parent Population Data Object *********
* Data Range = 5.417616
* Log Decades = 5.417618
* Channel used for fitting = <FITC-A>
* Number of events in flowFrame = 4541
******************** Fitting **********************
* Unfixed model.
* Parent Peak Position = 4.697861
* Parent Peak Size = 0.04219839
* Fitting Deviance = 1283.347
* Termination message:
*
* Iterations: 13
* Residual degrees-of-freedom: 1066
**********************************************************

ftol

’

‘

is too small. No further reduction in the sum of squares is possible.

We can extract the conﬁdence interval for our ﬁtting with the function confint:

> confint(parent.fitting.cfse)

2.5 %

97.5 %
a 9.01517880 9.06282697
M 4.69760377 4.69811748
S 0.04194153 0.04245524

11

3.1.3 dataRange

The data range for the FACS detector is automatically computed from the ”maxRange” slot
in the ﬂowFrame:

> QuahAndParish[[1]]@parameters@data[7,]

$P7 <FITC-A>

name desc range minRange maxRange
261588 3.077193 5.417616

In this experiment we have transformed the <FITC-A> column with a log transformation:

> logTrans <- logTransform(transformationId="log10-transformation",
+ logbase=10, r=1, d=1)

The original range [0 - 261588] was converted to a LOG range [0-5.417616].

3.1.4 logDecades

The number of log decades represented by the original data’s linear scale can be calculated
as log(R) where R is the acquisition resolution (data Range for the detector). The prolif-
erationFitting and parentFitting functions automatically compute the logDecades from
the keywords in the FCS ﬁle or using the log(R) formula. If the functions ﬁnd a log decades
keyword for this detector, they use the value in they keyword. Otherwise log decades are
estimated from the detector acquisition resolution. In the PKH26 example data, log decaedes
are extracted using the function keyword from package ﬂowCore:

> data(PKH26data)
> keyword(PKH26data[[1]])$

‘

‘

$P4M

[1] "

4.00"

In the QuahAndParish example data there is no log decades keyword in the fcs ﬁle, log decades
are estimated with the log(R) formula.

> acquisiton.resolution <- QuahAndParish[[1]]@parameters@data$range[7]
> log10(acquisiton.resolution)

[1] 5.417618

In any case, you can provide your dataRange and logDecades as arguments of the prolifer-
ationFitting and parentFitting functions.

12

3.2 Proliferation Fitting

3.2.1 Input

With the parentFitting function we have estimated the position and size of the parent pop-
ulation. For example, in the CFSE sample:

> parent.fitting.cfse@parentPeakPosition

[1] 4.697861

> parent.fitting.cfse@parentPeakSize

[1] 0.04219839

We can use the estimates as a best guess for the proliferationFitting function:

> fitting.cfse <- proliferationFitting(QuahAndParish[[2]],
"<FITC-A>", parent.fitting.cfse@parentPeakPosition,
+
+
parent.fitting.cfse@parentPeakSize)
> fitting.cfse

********* flowFit: Final Population Data Object *********
* Data Range = 5.417616
* Log Decades = 5.417618
* Channel used for fitting = <FITC-A>
* Number of events in flowFrame = 16556
**********************************************************
* FITTING with:
* Unfixed model.
* Number of Peaks in the model = 10
* Parent Peak Position = 4.617102
* Parent Peak Size = 0.06339392
* Estimated generations distance:0.294378
* Fitting Deviance = 22103.37
*********************** Generations **********************
* generation 1 = 11.42 %
* generation 2 = 20.9 %
* generation 3 = 21.95 %
* generation 4 = 22.6 %
* generation 5 = 19.32 %
* generation 6 = 11.53 %
* generation 7 = 4.07 %
* generation 8 = 0.93 %
* generation 9 = 0.07 %
* generation 10 = 0.02 %
**********************************************************

13

As for the parentFitting-data object, we have access to the functions coef and summary.

> coef(fitting.cfse)

b

a

f
7.15029354 9.67210238 9.91179800 10.05621495 9.29823950 7.18322116
S
4.26702379 2.04458814 0.55925517 0.29099381 4.61710241 0.06339392

M

h

e

j

d

i

g

c

D
0.29437801

> summary(fitting.cfse)

********* flowFit: Final Population Data Object *********
* Data Range = 5.417616
* Log Decades = 5.417618
* Channel used for fitting = <FITC-A>
* Number of events in flowFrame = 16556
******************** Fitting **********************
* Unfixed model.
* Number of Peaks in the model = 10
* Parent Peak Position = 4.617102
* Parent Peak Size = 0.06339392
* Estimated generations distance:0.294378
* Fitting Deviance = 22103.37
******************** Model **********************
* Termination message:

‘

’

*

ptol

is too small. No further improvement in the approximate solution

par

is possible.

‘

’

* Iterations: 28
* Residual degrees-of-freedom: 658
******************** Parameters ********************
a = 7.1502935406806
b = 9.67210237720861
c = 9.91179799572098
d = 10.0562149526454
e = 9.29823950027275
f = 7.18322116176413
g = 4.26702378801487
h = 2.04458813833171
i = 0.559255173329198
j = 0.290993807643987
*********************** Generations **********************
* generation 1 = 11.42 %
* generation 2 = 20.9 %
* generation 3 = 21.95 %
* generation 4 = 22.6 %

14

* generation 5 = 19.32 %
* generation 6 = 11.53 %
* generation 7 = 4.07 %
* generation 8 = 0.93 %
* generation 9 = 0.07 %
* generation 10 = 0.02 %
**********************************************************

3.2.2 Plots

The function proliferationFitting return a proliferationFittingData object, with the
plot function we can generate some graphic output. You can use the parameter which to
select the plots you want to draw. You can plot:

1 Input data

2 Model data and Fitting

3 Fitting and single generations peaks

4 Generations barplot

5 Fitting diagnostics

All plot functions in the ﬂowFit package support these options:

1. main: an overall title for the plot.

2. xlab: a title for the x axis.

3. ylab: a title for the y axis.

4. legend: show/hide messages AND legend.

5. logScale: put a log scale on the x axis.

6. drawGrid: put some dashed lines at the generationsDistance expected positions (proliferationFittingData

object only).

For more info about plots in ﬂowFit:

> library(flowFit)
> ?plot

15

Input Data Plot the observed data extracted from the FCS ﬁle and the data smoothed with
the kz function (kza package).

> plot(fitting.cfse, which=1)

Figure 4: Input Data: plot(fitting.cfse, which=1)

16

Proliferating Population<FITC−A>Events0204060801001201e+001e+011e+021e+031e+041e+05InputSmoothModel data and Fitting Plot the smoothed data and the ﬁtted model function.

> plot(fitting.cfse, which=2)

Figure 5: Model data and Fitting: plot(fitting.cfse, which=2)

17

Proliferating Population<FITC−A>Events0204060801001201e+001e+011e+021e+031e+041e+05InputFittingFitting and single generations peaks Plot the smoothed data, the ﬁtted model function
and a single peak for each generation.

> plot(fitting.cfse, which=3)

Figure 6: Fitting and single generations peaks: plot(ﬁtting.cfse, which=3)

18

Proliferating Population<FITC−A>Events0204060801001201e+001e+011e+021e+031e+041e+05G1G2G3G4G5G6G7G8G9G10Generations barplot Plot the estimated numer of cells for generation (%) as a barplot.

> plot(fitting.cfse, which=4)

Figure 7: Generations barplot: plot(ﬁtting.cfse, which=4)

19

Proliferating PopulationGenerations% of cells0204060801001234567891011.42%20.9%21.95%22.6%19.32%11.53%4.07%0.93%0.07%0.02%Fitting diagnostics Plot the log residual sum of squares against the iteration number and
some informations about the ﬁtting:

1. Number of events

2. Fitting Deviance

3. Parent Population Peak position (before and after modeling)

4. Parent Population Peak size (before and after modeling)

> plot(fitting.cfse, which=5)

Figure 8: Fitting diagnostics: plot(ﬁtting.cfse, which=5)

20

lllllllllllllllllllllllllllll05101520253010111213Proliferating PopulationIterationLog residual sum of squaresEvents:  542Deviance: 22103[Distance] model:  0.29 , guess:  0.3[Parent Peak Position] model:  4.62 , guess:  4.7[Parent Peak Size] model:  0.06 , guess:  0.04Multiple plots We can combine multiple plots removing the legend and using the mfrow
option of par.

> par(mfrow=c(2,2))
> plot(fitting.cfse, which=1:4, legend=FALSE)

Figure 9: Multiple plots: plot(ﬁtting.cfse, which=1:4, legend=FALSE)

> par(mfrow=c(2,1))
> plot(fitting.cfse, which=c(3,5), legend=FALSE)

21

Proliferating Population<FITC−A>Events020601001e+001e+021e+04Proliferating Population<FITC−A>Events020601001e+001e+021e+04Proliferating Population<FITC−A>Events040801201e+001e+021e+04Proliferating PopulationGenerations% of cells02040608012345678910Figure 10: Multiple plots: plot(ﬁtting.cfse, which=c(3,5), legend=FALSE)

22

Proliferating Population<FITC−A>Events040801e+001e+011e+021e+031e+041e+05lllllllllllllllllllllllllllll0510152025301012Proliferating PopulationIterationLog residual sum of squares3.2.3 Cells for generation

The percentage of cells for each generation can be extracted from the proliferationFitting-
Data object with the function getGenerations, the data are in a list.

> gen <- getGenerations(fitting.cfse)
> class(gen)

[1] "list"

We can extract also the percentage of cells for generation as a vector instead of a list. To do
this, you need to use the generations slot in the proliferationFittingData object:

> fitting.cfse@generations

[1] 11.42454596 20.90417230 21.95311193 22.59749518 19.31935681 11.53000997
[7] 4.06856571 0.93412045 0.06988939 0.01892164

We compute the total number of cells analyzed in the model with a numerical integration on
the complete model:

Iall =

(cid:90) w

v

M

Where v and w, the lower and upper limits for numerical integration, are the minRange and
maxRange values for the analyzed fcs column. For each generation, we compute the number of
cells in the peak with a numerical integration. For example, the formula for the ﬁrst generation
of cells is:

I1 =

(cid:90) w

v

a2 exp

(x − µ)2
2σ2

Where v and w, the lower and upper limits for numerical integration, are the minRange and
maxRange values for the analyzed fcs column.
To estimate the % of cells for generation we simply take the ratio between the complete model
numerical integration and the integration of a single generation of cells:

Gen1 =

I1
Iall

∗ 100

3.2.4 Proliferation Index

Finally we can calculate the Proliferation Index (Munson, 2010) for this sample. Proliferation
index is calculated as the sum of the cells in all generations including the parental divided by the
computed number of original parent cells theoretically present at the start of the experiment.

> proliferationIndex(fitting.cfse)

[1] 3.544918

23

The proliferation index it’s a measure of the fold increase in cell number in the culture over
the course of the experiment:

(cid:80)i

0 Ni
0 N i/2i

(cid:80)i

Where i is the generation number (parent generation = 0). In the absence of proliferation,
that is, when all cells are in the parent generation, the formula gives:

deﬁning the lower limit of the PI.

N0
N0/20 = 1

24

3.3 Comparing Samples

We can estimate the % of cells for generation in the 3 samples.

1. lymphocytes CD4+ labeled with CFSE (stimulated)

2. lymphocytes CD4+ labeled with CPD (stimulated)

3. lymphocytes CD4+ labeled with CTV (stimulated)

The 3 samples analyzed came from the same cells population and have proliferated in the same
way. The only diﬀerence in the experiement is the stain used for track the cells proliferation.
We expect to observe the same cells/generation distribution across the 3 samples. To compare
the generation distributions we can extract the % of cells for generation for the 3 samples and
compare those distributions with a chi-squared test.

3.3.1 Proliferation Fitting CTV

A ﬁtting for the CTV sample:

> fitting.ctv <- proliferationFitting(QuahAndParish[[4]],
+
+

"<Alexa Fluor 405-A>", parent.fitting.ctv@parentPeakPosition,
parent.fitting.ctv@parentPeakSize)

> plot(fitting.ctv, which=3)

25

Figure 11: Proliferation Fitting CTV

26

Proliferating Population<Alexa Fluor 405−A>Events0204060801001e+001e+011e+021e+031e+041e+05G1G2G3G4G5G6G7G8G9G10G11G12G13G14G15G163.3.2 Proliferation Fitting CPD

A ﬁtting for the CPD sample. In this sample there are no visible peaks:

> plot(QuahAndParish[[3]],"<APC-A>", breaks=1024, main="CPD sample")

Figure 12: The CPD Sample

27

CPD sample<APC−A>Frequency0123450100200300400To improve the ﬁtting we can keep ﬁxed some parameters from the parentFitting function.
Here we launch the ﬁtting function (proliferationFitting) keeping ﬁxed the parentPeak-
Position:

> fitting.cpd <- proliferationFitting(QuahAndParish[[3]],
+
+
+
+
+

"<APC-A>",
parent.fitting.cpd@parentPeakPosition,
parent.fitting.cpd@parentPeakSize,
fixedModel=TRUE,
fixedPars=list(M=parent.fitting.cpd@parentPeakPosition))

> plot(fitting.cpd, which=3)

Figure 13: Proliferation Fitting CPD

28

Proliferating Population<APC−A>Events01002003004001e+001e+011e+021e+031e+041e+05G1G2G3G4G5G6G7G8G9G10G11G12G13G14G15G163.3.3 Comparing Samples

> perc.cfse <- fitting.cfse@generations
> perc.cpd <- fitting.cpd@generations
> perc.ctv <- fitting.ctv@generations

In the CFSE sample we have estimated 10 generations, while in hte other 2 samples we have
estimated 16 generations. We trim the length of the shorter vector with NA:

> perc.cfse <- c(perc.cfse, rep(0,6))

Chi-squared Test:

> M <- rbind(perc.cfse, perc.cpd, perc.ctv)
> colnames(M) <- 1:16
> (Xsq <- chisq.test(M, B=100000, simulate.p.value=TRUE))

’

Pearson
replicates)

s Chi-squared test with simulated p-value (based on 1e+05

data: M
X-squared = 3.3721, df = NA, p-value = 1

> plot(perc.cfse, type="b", axes=F, ylim=c(0,50), xlab="generations", ylab="Percentage of cells", main="")
> lines(perc.cpd, type="b", col="red")
> lines(perc.ctv, type="b", col="blue")
> legend("topleft", c("CFSE","CPD","CTV"), pch=1, col=c("black","red","blue"), bg =
> axis(2, at=seq(0,50,10), labels=paste(seq(0,50,10),"%"))
> axis(1, at=1:16,labels=1:16)
> text(8,40,paste("Chi-squared Test p=", round(Xsq$p.value, digits=4), sep=""))

gray90

’

’

,text.col = "green4")

According to the Chi-Squared Test, we didn’t observe any eﬀect for the diﬀerent staining
technique in the 3 samples.

29

Figure 14: Comparing the % of cells/generation in the 3 samples

30

llllllllllllllllgenerationsPercentage of cellslllllllllllllllllllllllllllllllllllCFSECPDCTV0 %10 %20 %30 %40 %50 %12345678910121416Chi−squared Test p=14 References

References

A L Givan, J L Fisher, M Waugh, M S Ernstoﬀ, and P K Wallace. A ﬂow cytometric method
to estimate the precursor frequencies of cells proliferating in response to speciﬁc antigens.
Journal of immunological methods, 230(1-2):99–112, November 1999.

Alice L Givan, Jan L Fisher, Mary G Waugh, Nad`ege Bercovici, and Paul K Wallace. Use of
cell-tracking dyes to determine proliferation precursor frequencies of antigen-speciﬁc t cells.
Methods Mol Biol, 263:109–24, Jan 2004. doi: 10.1385/1-59259-773-4:109.

David J Klinke and Kathleen M Brundage.

Scalable analysis of ﬂow cytometry data
using r/bioconductor. Cytometry A, 75(8):699–706, Aug 2009.
doi: 10.1002/cyto.a.
20746. URL http://onlinelibrary.wiley.com/doi/10.1002/cyto.a.20746/abstract;
jsessionid=76D97A544277BAC6BF305F9EA14073E2.d01t02.

Mark E Munson. An improved technique for calculating relative response in cellular prolifer-

ation experiments. Cytometry A, Jul 2010. doi: 10.1002/cyto.a.20935.

C R Parish. Fluorescent dyes for lymphocyte migration and proliferation studies. Immunology

and cell biology, 77(6):499–508, December 1999.

Benjamin J C Quah and Christopher R Parish. New and improved methods for measuring
lymphocyte proliferation in vitro and in vivo using CFSE-like ﬂuorescent dyes. Journal of
immunological methods, 379(1-2):1–14, May 2012.

Paul K Wallace, Joseph D Tario, Jan L Fisher, Stephen S Wallace, Marc S Ernstoﬀ, and
Katharine A Muirhead. Tracking antigen-driven responses by ﬂow cytometry: Monitoring
proliferation by dye dilution. Cytometry, 73A(11):1019–1034, Nov 2008. doi: 10.1002/cyto.
a.20619.

31

