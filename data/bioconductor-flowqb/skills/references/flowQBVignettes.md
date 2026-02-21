ﬂowQB – Automated Quadratic Characterization of Flow
Cytometer Instrument Sensitivity*

Josef Spidlen1, Wayne Moore2, Faysal El Khettabi,
David Parks2, Ryan Brinkman1

1Terry Fox Laboratory, British Columbia Cancer Agency
Vancouver, BC, Canada
2Genetics Department, Stanford University School of Medicine
Stanford, California, USA

January 4, 2019

1 Abstract

This package provides methods to calculate ﬂow cytometer’s detection eﬃciency (Q) and back-
ground illumination (B) by analyzing LED pulses and multi-level bead sets. The method im-
proves on previous formulations Wood (1998); Hoﬀman and Wood (2007); Chase and Hoﬀman
(1998) by ﬁtting a full quadratic model with appropriate weighting, and by providing standard
errors and peak residuals as well as the ﬁtted parameters themselves. K-means clustering is
incorporated for automated peak detection of multi-peak data. Overall, this method is suc-
cessful in providing good estimates of the Spe scales and backgrounds for all of the ﬂuorescence
channels on instruments with good linearity. Known photoelectron scales and measurement
channel backgrounds make it possible to estimate the precision of measurements at diﬀerent
signal levels and the eﬀects of compensated spectral overlap on measurement quality.

2

Introduction

The basic measurement capabilities of a ﬂuorescence cytometer measurement channel can be
estimated by knowing just two values: Q, the statistical number of photoelectrons (Spe) gen-
erated per unit of dye in the sample, and B, the background light in dye equivalents that sets
the minimum variance that underlies all measurements. From these the minimum detectable
amount of dye and the precision of measurements at diﬀerent signal levels can be calculated.
Therefore, measurements of Q and B are the key to making valid comparisons between diﬀerent
instruments and among diﬀerent channels on an instrument.

*This project was supported by the Terry Fox Foundation, the Terry Fox Research Institute and the Canadian

Cancer Society. Josef Spidlen is an ISAC Marylou Ingram Scholar.

1

We can achieve full speciﬁcation of Q and B in two steps by evaluating photoelectron
scales for the measurement channels of interest and relating those to measurements on dye
reference samples. There are problems and challenges in implementing each step in a way
that is convenient and accurate in routine use. Here we address the photoelectron scale aspect
by providing reliable automated software for obtaining the needed information from LED or
multi-level, multi-dye bead data.

When a cell or particle moves through a sensing area on a ﬂow cytometer, a focused laser
beam excites ﬂuorescent dyes that emit a pulse of light in all directions. The optical system
collects some of this light and passes it through optical ﬁlters to the cathodes of one or more
PMT detectors where a fraction of the photons generate photoelectrons. The photoelectrons are
ampliﬁed through a series of dynodes to produce an output current pulse. The photoelectron
production is a Poisson process, so the variance of signals at a particular level is proportional
to the signal level itself. Since the ampliﬁcation process through the dynodes introduces some
additional variance, we introduce the term “statistical photoelectrons” or Spe to denote the
eﬀective Poisson number relating signal levels and their variances.

Since it is diﬃcult to measure photoelectron counts directly, the usual method for esti-
mating photoelectron scales has been to measure uniform light signals at various levels and
ﬁt the measured means and variances to a statistical model involving the Poisson distribu-
tion expectations for the relation between them. Historically, two kinds of signal source have
been used: an LED light source producing very uniform pulses at adjustable signal levels or
microspheres (also called “beads”) labeled with several diﬀerent concentrations of a mixture
of ﬂuorescent dyes. The model can be expressed as a second-degree (quadratic) polynomial
relating the observed signal means and variances to Q, B and, for microsphere samples, CV0,
a common non-statistical variability in the measurements of the diﬀerent microsphere peaks.
For measurements on a population of similar particles like one of the populations in a multi-
level bead set, the observed variance should be the sum of the electronic noise, background light
not associated with the particles, Poisson variance related to the signal levels of the particles,
the variation in dye amount among the particles and illumination variations due to particles
taking diﬀerent ﬂow paths through the laser beam. The electronic noise and background light
combine into a variance contribution that is not dependent on the signal level. The Poisson
variance is proportional to the signal level, and the dye and illumination variations combine
to form CV0 whose contribution to the variances goes with the square of the signal level.
Therefore, the general equation for the observed variance can be expressed as

V (MI ) = c0 + c1MI + c2M 2
I

where MI is the mean signal of the population in measurement intensity units, and V (MI ) is
the observed variance of a population with mean MI . Methods implemented in this package
ﬁt sets of mean and variance data points with this equation to obtain the parameters c0, c1
and c2. If we scale the signal levels in Spe, we can deﬁne BSpe as the eﬀective background level
in Spe and MSpe as the mean signal in Spe. Then, deﬁning QI as the Spe per intensity unit,
as explained in our paper Parks et al. (2016), we can calculate

BSpe = c0/c2
1

QI = 1/c1
CV 2
0 = c2

2

3 Requirements

The ﬂowQB package requires the ﬂowCore library in order to read FCS ﬁles Spidlen et al.
(2010), the stats package for its model ﬁtting and also K-means clustering functionality, the
extremevalues package to determine outliers, and it also makes use of some basic functions
and classes from the methods and BiocGenerics packages. In addition, we suggest installing
the ﬂowQBData package, which contains example data sets to demonstrate the functionality
of this package. Alternatively, one can use the FlowRepositoryR package in order to work
directly with data stored in FlowRepository. In addition, we recommend the xlsx package in
order to parse house-keeping information from MS Excel spreadsheets. Finally, we use the
RUnit package in order to implement unit tests assuring consistency and reproducibility of
the ﬂowQB functionality over time. Let’s start by loading the ﬂowQB package as well as the
ﬂowQBData package with data to demonstrate the functionality of this package.

> library("flowQB")
> library("flowQBData")

4 Fitting LED pulser data

An LED light pulser is producing very uniform pulses at adjustable signal levels. White LEDs
provide some signal at all visible wavelengths, but the far-red emission is weak. A given LED
pulse level will generate quite diﬀerent photoelectron signals on diﬀerent detectors, so it is
important to collect data over a wide range of LED levels to assure that the measurement
series on each detector will include the low, middle and high level signals needed for optimal
results in the ﬁtting procedure. The fit_led function assumes that data generated by diﬀerent
LED levels are provided as separate FCS ﬁles. These ﬁles are passed to the fit_led function
in the form of a vector of FCS ﬁle paths. In addition, house keeping details about the data
and the way the ﬁtting procedure should be performed need to be provided, resulting in the
following list of arguments:

(cid:136) fcs_file_path_list – A vector of FCS ﬁle paths pointing to data generated by an LED
pulser set to a range of LED levels; diﬀerent levels generated diﬀerent FCS ﬁles, all data
coming from a single instrument.

(cid:136) ignore_channels – A vector of short channel names (values of the $PnN keywords)
specifying channels that should not be considered for the ﬁtting procedure. Normally,
those should be all non-ﬂuorescence channels, such as the time and the (forward and
side) scatter channels.

(cid:136) dyes – A vector of dye names that you would normally use with the detectors speciﬁed
below. This value does not aﬀect the ﬁtting, but those dyes will be “highlighted” in the
provided results.

(cid:136) detectors – A vector of short channel names (values of the $PnN keywords) specifying
channels matching to the dyes speciﬁed above. The length of this vector shall correspond
to the length of the dyes vector. These channels should be all of the same type as speciﬁed
by the signal_type below, i.e., area, or height of the measured signal.

3

(cid:136) signal_type – The type of the signal speciﬁed as the “area” or “height”. This should
match to the signal type that is being captured by the channels speciﬁed in the detectors
argument. The signal type is being used in order to trigger type-speciﬁc peak validity
checks. Currently, if signal type equals to “height” then peaks with a mean value lower
than the lowest peak mean value are omitted from the ﬁtting. In addition, peaks that are
not suﬃciently narrow (i.e., exceeding a speciﬁc maximum CV) are also omitted from
the ﬁtting. Currently, the maximum allowed CV is set to 0.65, but the code is designed
to make this user-conﬁgurable and signal type dependent eventually.

(cid:136) instrument_name – The make/model of the instrument. The purpose if this argument
is to allow for instrument-speciﬁc peak validity checks. At this point, if “BD Accuri” is
passed as the instrument type, then peaks with a mean value lower than the lowest peak
mean value are omitted from the ﬁtting. Additional instrument-speciﬁc peak validity
checks may be implemented in the future.

(cid:136) bounds – On some instruments, the lowest LED peaks may be cut oﬀ at a data baseline so
that the peak statistics will not be valid. Therefore, peaks too close to the baseline need
to be excluded from the ﬁtting. Also, many instruments do not maintain good linearity to
the full top of scale, so it is also important to specify a maximum level for good linearity
and, on each ﬂuorescence channel, exclude any peak that is above that maximum. The
bounds argument shall provide a list specifying the minimum and maximum value for
the means of valid peaks; peaks with means outsize of this range will be ignored for that
particular channel.

(cid:136) minimum_useful_peaks – Diﬀerent peaks may be omitted for diﬀerent channels due to
various validity checks described above. This argument speciﬁes the minimal number of
valid peaks required in order for the ﬁtting procedure to be performed on a particular
ﬂuorescence channel. Generally, ﬁtting the three quadratic parameters requires three
valid points to obtain a ﬁt at all, and 4 or more points are needed to obtain error
estimates. Requiring higher values would exclude some of your data but likely produce
better results.

(cid:136) max_iterations – The peaks have a wide range of variances, so unweighted least squares
ﬁtting is not appropriate, and we need to apply appropriate weights in the ﬁtting proce-
dure. In particular, the populations with lower variances get more weight since having
the ﬁt miss them by any particular amount is worse than missing a high variance popu-
lation by the same amount. This argument speciﬁes the maximum number of iterations
for the iterative ﬁtting approach with appropriate weight recalculations. In most cases,
the ﬁtting converges relatively fast. The iterating stops when either the maximum of
iterations is used or if none of the coeﬃcients of the model changed more than 0.00005.
The default maximum of 10 iterations seems to be enough in most cases. You can also
explore your results in order to see how many iterations were actually done for each of
the all of the ﬁtting.

> ## Example is based on LED data from the flowQBData package
> fcs_directory <- system.file("extdata", "SSFF_LSRII", "LED_Series",
+

package="flowQBData")

4

> fcs_file_path_list <- list.files(fcs_directory, "*.fcs", full.names= TRUE)
> ## We are working with these FCS files:
> basename(fcs_file_path_list)

[1] "935281.fcs" "935283.fcs" "935285.fcs" "935287.fcs" "935289.fcs"
[6] "935291.fcs" "935293.fcs" "935295.fcs" "935297.fcs" "935299.fcs"
[11] "935301.fcs" "935303.fcs" "935305.fcs" "935307.fcs" "935309.fcs"
[16] "935311.fcs" "935313.fcs" "935315.fcs" "935317.fcs"

"PerCP-Cy55", "V450", "V500-C")

channels, such as the time and the scatter channels

"FSC-A", "FSC-W", "FSC-H",
"SSC-A", "SSC-W", "SSC-H")

"PerCP-Cy5-5-A", "PerCP-Cy5-5-A", "Pacific Blue-A", "Aqua Amine-A")

> ## Various house keeping information
> ## - Which channels should be ignored, typically the non-fluorescence
> ##
> ignore_channels <- c("Time",
+
+
> ## - Which dyes would you typically use with the detectors
> dyes <- c("APC", "APC-Cy7", "APC-H7", "FITC", "PE", "PE-Cy7", "PerCP",
+
> ## - What are the corresponding detectors, provide a vector of short channel
> ## names, i.e., values of the $PnN FCS keywords.
> detectors <- c("APC-A", "APC-Cy7-A", "APC-Cy7-A", "FITC-A", "PE-A", "PE-Cy7-A",
+
> ## - The signal type that you are looking at (Area or Height)
> signal_type <- "Area"
> ## - The instrument make/model
> instrument_name <-
> ## - Set the minimum and maximum values, peaks with mean outsize of this range
> ## will be ignored
> bounds <- list(minimum = -100, maximum = 100000)
> ## - The minimum number of usable peaks (represented by different FCS files
> ## in case of an LED pulser) required in order for a fluorescence channel
> ## to be included in the fitting. Peaks with mean expression outside of the
> ## bounds specified above are omitted and therefore not considered useful.
> ## Fitting the three quadratic parameters requires three valid points to obtain
> ## a fit at all, and 4 or more points are needed to obtain error estimates.
> minimum_fcs_files <- 3
> ## - What is the maximum number of iterations for iterative fitting with
> ## weight adjustments
> max_iterations <- 10 # The default 10 seems to be enough in typical cases
> ## Now, let
> led_results <- fit_led(fcs_file_path_list, ignore_channels, dyes,
+
+

detectors, signal_type, instrument_name, bounds = bounds,
minimum_useful_peaks = minimum_fcs_files, max_iterations = max_iterations)

s calculate the fitting

LSRII

’

’

’

The results of the fit_led function is a list with the following components:

5

(cid:136) peak_stats – A list with summary stats for each of the channels for all the diﬀerent peaks
(represented by diﬀerent FCS ﬁles). For each of the channels, peak stats are captured by
a data frame with rows corresponding to the diﬀerent peaks (FCS ﬁles) and the following
columns:

– N: the number of events in the peak

– M: the mean expression value for that peak

– SD: the standard deviation for that peak

– V: the variance for that peak (square of standard deviation)

– W: the weight of that peak

– Omit: was the peak omitted from the ﬁtting? (TRUE or FALSE)

– QR: the residuals of the quadratic ﬁtting

– LR: the residuals of the linear ﬁtting

– QR-I: the residuals of the iterative quadratic ﬁtting

– LR-I: the residuals of the iterative linear ﬁtting

The values of W, QR, LR, QR-I and LR-I will be NA if Omit is TRUE.

> ## We have stats for these channels
> names(led_results$peak_stats)

"PerCP-Cy5-5-A"
"Aqua Amine-A"

"FITC-H"
"Pacific Blue-H"

[1] "FITC-A"
[5] "Pacific Blue-A"
[9] "Pacific Orange-A" "Pacific Orange-H" "QDot 585-A"
"QDot 655-A"
"QDot 800-A"
"APC-Cy5-5-A"
"PE-A"
"PE-Cy5-A"
"PE-Cy7-A"

[13] "QDot 605-A"
[17] "QDot 705-A"
[21] "APC-A"
[25] "APC-Cy7-A"
[29] "PE-Texas-Red-A"
[33] "PE-Cy5-5-A"

"QDot 605-H"
"QDot 705-H"
"APC-H"
"APC-Cy7-H"
"PE-Texas-Red-H"
"PE-Cy5-5-H"

"PerCP-Cy5-5-H"
"Aqua Amine-H"
"QDot 585-H"
"QDot 655-H"
"QDot 800-H"
"APC-Cy5-5-H"
"PE-H"
"PE-Cy5-H"
"PE-Cy7-H"

> ## Explore the peak stats for a randomly chosen channel (PE-Cy7-A)
> ## Showing only the head in order to limit the output for the vignette
> head(led_results$peak_stats$

PE-Cy7-A

)

‘

‘

M

N

SD

QR
935317.fcs 20000 -0.5010081 9.528568 90.79362 1.185752 FALSE -1.20479986
935315.fcs 20000 -0.1618319 9.601269 92.18437 1.158282 FALSE -0.84294789
935313.fcs 20000 -0.1530719 9.747344 95.01072 1.157585 FALSE 2.12762764
935311.fcs 20000 0.1040706 9.725790 94.59100 1.137409 FALSE 0.83263629
935309.fcs 20000 0.3962075 9.724028 94.55672 1.115120 FALSE -0.18153222
935307.fcs 20000 1.2300957 9.870086 97.41861 1.054984 FALSE 0.05119513

W Omit

V

LR-I
935317.fcs -1.07790750 -1.25053314 -1.13032225

QR-I

LR

6

935315.fcs -0.72646204 -0.89612903 -0.78545387
935313.fcs 2.24043554 2.11516783 2.22559969
935311.fcs 0.93967230 0.77984233 0.88319772
935309.fcs -0.08158402 -0.24178740 -0.14632077
935307.fcs 0.12847364 -0.01031727 0.06347347

(cid:136) bg_stats – A data frame with background stats for each channel. These stats are a
convenience way to look at peak stats of the lowest peak. The columns of the data frame
correspond to the diﬀerent channels, and there are the following rows:

– N: the number of events in the lowest peak

– M: the mean expression value for the lowest peak

– SD: the standard deviation for the lowest peak

(cid:136) dye_bg_stats – A data frame with background stats for each “dye”. These are the
same stats as bg_stats described above, but the columns will only be restricted to the
detectors/dyes that were listed as arguments of the fit_led call. The column headings
are converted from channel names (detectors) to “dyes” as per the mapping supplied by
the detectors and dyes arguments. The rows of the data frame are the same as with the
bg_stats described above.

> ## Explore bg_stats
> led_results$bg_stats

FITC-A

FITC-H PerCP-Cy5-5-A PerCP-Cy5-5-H Pacific Blue-A
N 20000.0000000 20000.00000 20000.000000 20000.000000 20000.0000000
-0.3744112
M
17.8146682
SD

-0.8332625
9.7062341

26.646125
8.643326

-1.111162
9.747792

38.63056
11.90040

Pacific Blue-H Aqua Amine-A Aqua Amine-H Pacific Orange-A Pacific Orange-H
20000.00000
34.76437
10.44929

20000.00000 20000.000000 20000.000000
20.142750
8.927228

20000.000000
-1.203446
18.467343

-1.280468
14.559881

15.21394
11.18833

N
M
SD

QDot 585-A QDot 585-H

QDot 655-A
N 20000.0000000 20000.00000 20000.0000000 20000.00000 20000.000000
-1.803142
M
18.171769
SD

-0.8643112
20.3773439

-0.6880162
17.3267758

QDot 605-A QDot 605-H

44.99687
14.20982

34.03956
11.74433
QDot 705-A

QDot 655-H

QDot 705-H QDot 800-A

26.253562
8.664091
APC-H

APC-A
N 20000.000000 20000.000000 20000.000000 20000.00000 20000.000000 20000.000000
-0.246810
M
6.573055
SD

23.668875
5.910596
APC-Cy7-H
N 20000.00000 20000.0000000 20000.000000 20000.0000000 20000.00000
52.15225
M
17.67756
SD

21.961750
6.917544
APC-Cy5-5-A APC-Cy5-5-H

-0.5468437
7.1165577

-0.2929444
8.3373448

22.264688
6.874049

-1.064498
16.448360

-1.27788
16.10045

12.98700
10.73828

QDot 800-H

APC-Cy7-A

PE-A

PE-H PE-Texas-Red-A PE-Texas-Red-H

PE-Cy5-A
20000.000000 20000.0000000

N 20000.0000000 20000.00000 20000.0000000

7

M
SD

-0.4951225
9.0874925
PE-Cy5-H

29.07625
10.85304
PE-Cy5-5-A

-0.3655931
8.6312379

20.473813
8.508663

-0.3232075
7.9929231

PE-Cy7-H
N 20000.000000 20000.0000000 20000.000000 20000.0000000 20000.00000
23.38338
M
5.85905
SD

-0.5010081
9.5285685

-0.8774144
8.2633285

20.687125
8.345979

23.230500
5.985114

PE-Cy5-5-H

PE-Cy7-A

> ## Explore dye_bg_stats
> led_results$dye_bg_stats

APC

APC-H7

APC-Cy7

-0.246810
6.573055

PE
N 20000.000000 20000.0000000 20000.0000000 20000.0000000 20000.0000000
-0.4951225
M
9.0874925
SD
V500-C
N 20000.0000000 20000.000000 20000.000000 20000.0000000 20000.000000
-1.280468
M
14.559881
SD

-0.5468437
7.1165577
PerCP

-0.3744112
17.8146682

-0.8332625
9.7062341

-0.5468437
7.1165577

-0.5010081
9.5285685

-1.111162
9.747792

-1.111162
9.747792

PerCP-Cy55

PE-Cy7

V450

FITC

(cid:136) fits – For the LED analysis, results are reported for both quadratic ﬁtting and linear
ﬁtting (eﬀectively ﬁxing CV0 = 0). Since the uniformity of LED signal outputs is likely
to be better than the ability of the cytometer electronics to evaluate them, the c2 term
in a quadratic ﬁt should be very close to zero with a small standard error. If the results
of the quadratic ﬁt are consistent with CV0 = 0, we can rely on the linear ﬁt results
whose standard errors on c1 will generally be smaller than the c1 standard errors of the
quadratic ﬁt.

The fits item contains a data frame with ﬁts for each of the channels. The columns of
the data frame correspond to the diﬀerent channels. The rows of the data frame capture
the coeﬃcients of both, quadratic ﬁtting and linear ﬁtting as follows:

– c0: value of the c0 coeﬃcient of the quadratic ﬁtting
– c0 SE: standard error of the c0 coeﬃcient of the quadratic ﬁtting
– c0 P: the P-value for the c0 coeﬃcient of the quadratic ﬁtting
– c1: value of the c1 coeﬃcient of the quadratic ﬁtting
– c1 SE: standard error of the c1 coeﬃcient of the quadratic ﬁtting
– c1 P: the P-value for the c1 coeﬃcient of the quadratic ﬁtting
– c2: value of the c2 coeﬃcient of the quadratic ﬁtting
– c2 SE: standard error of the c2 coeﬃcient of the quadratic ﬁtting
– c2 P: the P-value for the c2 coeﬃcient of the quadratic ﬁtting
– c0’: value of the c0 coeﬃcient of the linear ﬁtting
– c0’ SE: standard error of the c0 coeﬃcient of the linear ﬁtting
– c0’ P: the P-value for the c0 coeﬃcient of the linear ﬁtting

8

– c1’: value of the c1 coeﬃcient of the linear ﬁtting
– c1’ SE: standard error of the c1 coeﬃcient of the linear ﬁtting
– c1’ P: the P-value for the c1 coeﬃcient of the linear ﬁtting

(cid:136) dye_fits – A data frame with ﬁts for each “dye”. These are the same stats as fits
described above, but the columns will only be restricted to the detectors/dyes that were
listed as arguments of the fit_led call. The column headings are converted from channel
names (detectors) to “dyes” as per the mapping supplied by the detectors and dyes
arguments. The rows of the data frame are the same as with the fits described above.

(cid:136) iterated_fits – A data frame with ﬁts for each of the channels in the same way as for

the fits described above, but based on iterative ﬁtting with weights adjustments.

(cid:136) iterated_dye_fits – A data frame with ﬁts for each of the “dyes” in the same way as
for the dye_fits described above, ut based on iterative ﬁtting with weights adjustments.

> ## Explore dye_fits
> ## fits are the same rows but columns corresponding to all channels
> led_results$dye_fits

APC

FITC

APC-H7

APC-Cy7

PE
4.368815e+01 5.477754e+01 5.477754e+01 9.754561e+01 8.439980e+01
4.812990e-01 4.564552e-01 4.564552e-01 5.416996e-01 6.314557e-01
5.656393e-22 4.520073e-25 4.520073e-25 1.968745e-26 1.717097e-24
4.044031e+00 1.081528e+01 1.081528e+01 1.102905e+00 1.195372e+00
2.527669e-02 6.757263e-02 6.757263e-02 7.257972e-03 8.717425e-03
1.159142e-25 4.526262e-27 4.526262e-27 2.509067e-25 1.169986e-24
-2.294861e-06 7.032025e-06 7.032025e-06 -6.559561e-07 -1.287684e-06
9.089420e-07 8.538107e-06 8.538107e-06 2.760284e-07 2.423281e-07
2.333568e-02 4.222715e-01 4.222715e-01 3.123057e-02 8.674452e-05
4.385277e+01 5.474020e+01 5.474020e+01 9.770330e+01 8.484485e+01
SE 5.511624e-01 4.498809e-01 4.498809e-01 6.107272e-01 1.028855e+00
3.208452e-22 1.934574e-26 1.934574e-26 4.560539e-27 1.811370e-22
P
4.009714e+00 1.084554e+01 1.084554e+01 1.092493e+00 1.167484e+00
SE 2.463186e-02 5.616915e-02 5.616915e-02 6.573080e-03 1.144239e-02
3.453168e-27 7.581340e-30 7.581340e-30 2.476072e-27 6.043250e-24
P

c0
c0 SE
c0 P
c1
c1 SE
c1 P
c2
c2 SE
c2 P
’
c0
’
c0
’
c0
’
c1
’
c1
’
c1

V450

PerCP

PE-Cy7

PerCP-Cy55

V500-C
c0
9.347386e+01 1.034479e+02 1.034479e+02 3.126289e+02 2.244819e+02
c0 SE 6.384700e-01 8.019667e-01 8.019667e-01 2.405814e+00 1.886606e+00
1.882844e-26 1.425151e-25 1.425151e-25 5.609481e-23 1.924009e-22
c0 P
3.166298e+00 5.177552e+00 5.177552e+00 1.600167e+00 2.897033e+00
c1
c1 SE 3.099756e-02 3.121567e-02 3.121567e-02 1.701602e-02 2.762522e-02
5.935317e-24 2.559302e-27 2.559302e-27 5.166657e-21 1.125459e-21
c1 P
c2
1.184771e-05 -1.113595e-06 -1.113595e-06 -2.235478e-07 -1.058619e-06
c2 SE 1.067342e-05 1.199479e-06 1.199479e-06 5.894364e-07 1.304526e-06
2.833950e-01 3.669957e-01 3.669957e-01 7.101874e-01 4.306614e-01
c2 P

9

’
’
’
’
’
’

c0
c0
c0
c1
c1
c1

9.337021e+01 1.035287e+02 1.035287e+02 3.127628e+02 2.246683e+02
SE 6.359027e-01 7.939806e-01 7.939806e-01 2.310853e+00 1.851124e+00
P 7.952267e-28 5.975684e-27 5.975684e-27 1.422970e-24 7.288398e-24
3.189371e+00 5.161481e+00 5.161481e+00 1.596009e+00 2.883559e+00
SE 2.315150e-02 2.587050e-02 2.587050e-02 1.263500e-02 2.182520e-02
P 2.348968e-27 4.346829e-30 4.346829e-30 4.004664e-24 2.042470e-24

> ## Explore iterated_dye_fits
> ## iterated_fits are the same rows but columns corresponding to all channels
> led_results$iterated_dye_fits

APC

FITC

APC-H7

APC-Cy7

PE
4.373702e+01 5.485236e+01 5.485236e+01 9.757420e+01 8.448122e+01
4.927771e-01 4.486962e-01 4.486962e-01 5.370821e-01 6.389481e-01
7.916529e-22 3.362482e-25 3.362482e-25 1.724002e-26 2.019751e-24
4.045917e+00 1.081741e+01 1.081741e+01 1.103480e+00 1.195688e+00
2.587943e-02 6.650987e-02 6.650987e-02 7.211628e-03 8.805424e-03
1.638819e-25 3.501722e-27 3.501722e-27 2.261596e-25 1.354680e-24
-2.319832e-06 6.918162e-06 6.918162e-06 -6.642736e-07 -1.290090e-06
9.324947e-07 8.429915e-06 8.429915e-06 2.754594e-07 2.441059e-07
2.510422e-02 4.238943e-01 4.238943e-01 2.916096e-02 9.163236e-05
4.390061e+01 5.481847e+01 5.481847e+01 9.772848e+01 8.489757e+01
SE 5.586205e-01 4.421346e-01 4.421346e-01 6.043944e-01 1.014942e+00
3.907590e-22 1.405896e-26 1.405896e-26 3.844500e-27 1.443102e-22
P
4.012548e+00 1.084728e+01 1.084728e+01 1.093281e+00 1.169980e+00
SE 2.491698e-02 5.529722e-02 5.529722e-02 6.506622e-03 1.129094e-02
4.104294e-27 5.795695e-30 5.795695e-30 2.080562e-27 4.720601e-24
P

c0
c0 SE
c0 P
c1
c1 SE
c1 P
c2
c2 SE
c2 P
’
c0
’
c0
’
c0
’
c1
’
c1
’
c1

V450

PerCP

PE-Cy7

PerCP-Cy55

V500-C
c0
9.352994e+01 1.035370e+02 1.035370e+02 3.129652e+02 2.248232e+02
c0 SE 6.358298e-01 8.060501e-01 8.060501e-01 2.384735e+00 1.909144e+00
1.745326e-26 1.524545e-25 1.524545e-25 4.885665e-23 2.223895e-22
c0 P
c1
3.169426e+00 5.179237e+00 5.179237e+00 1.600835e+00 2.897208e+00
c1 SE 3.079347e-02 3.132667e-02 3.132667e-02 1.682641e-02 2.791201e-02
5.257193e-24 2.694713e-27 2.694713e-27 4.391862e-21 1.299215e-21
c1 P
c2
1.126357e-05 -1.126435e-06 -1.126435e-06 -2.374796e-07 -1.056184e-06
c2 SE 1.056842e-05 1.201127e-06 1.201127e-06 5.847438e-07 1.310125e-06
c2 P
3.023441e-01 3.622815e-01 3.622815e-01 6.907897e-01 4.336259e-01
’
9.343071e+01 1.036238e+02 1.036238e+02 3.130964e+02 2.250229e+02
c0
’
SE 6.309986e-01 7.983035e-01 7.983035e-01 2.295434e+00 1.872126e+00
c0
’
P 6.895985e-28 6.451561e-27 6.451561e-27 1.266708e-24 8.429249e-24
c0
’
3.191705e+00 5.163059e+00 5.163059e+00 1.596507e+00 2.883799e+00
c1
’
SE 2.297232e-02 2.594998e-02 2.594998e-02 1.254114e-02 2.204240e-02
c1
’
P 2.033137e-27 4.555707e-30 4.555707e-30 3.564513e-24 2.366284e-24
c1

The Q, B and intrinsic CV0 can be extracted from the ﬁts using the equations shown
in the introduction. For your convenience, this is implemented in the qb_from_fits

10

function as shown below in this vignette.

(cid:136) iteration_numbers – A data frame with rows corresponding to all the diﬀerent channels
and 2 columns, Q and L, showing the number of iterations used for the quadratic and
linear ﬁtting, resp. This data frame can be reviewed in order to make sure the ﬁtting is
converging fast enough and the max_iterations parameter is set large enough.

> ## Explore iteration numbers
> ## Showing only the head in order to limit the output for the vignette
> head(led_results$iteration_numbers)

Q L
3 2
FITC-A
FITC-H
2 2
PerCP-Cy5-5-A 3 2
PerCP-Cy5-5-H 3 3
Pacific Blue-A 3 2
Pacific Blue-H 4 4

5 Fitting bead data

The fit_beads function performs quadratic ﬁtting for multi-level, multi-dye bead sets. In addi-
tion, the fit_spherotech function performs ﬁtting for the Sph8 particle sets from Spherotech,
and the fit_thermo_fisher function performs ﬁtting for the 6-level (TF6) Thermo Fisher set.
Internally, this is the same fit_beads function except that the number of expected peaks is
predeﬁned to 8 and 6, resp.

The parameters for the bead data ﬁtting functions are similar to those required for the LED
ﬁtting. The main diﬀerence is that a single FCS ﬁle (supplied by the fcs_file_path argument)
is expected because the bead sets are provided as a mixture of the diﬀerent populations and
therefore, acquiring data from a single sample will naturally result in all the peaks contained
within a single FCS ﬁle. All the beads are expected to have the same (or very similar) light
scatter properties. Therefore, we perform automated gating on the forward and side scatter
channels in order to isolate the main population. In order to do that, the method requires
a scatter_channels argument that speciﬁes which 2 channels shall be used for the scatter
gating. After the main population is isolated, we use K-means clustering to separate the
expression peaks generated by diﬀerent beads. The number of clusters is pre-deﬁned as 8 for
the fit_spherotech function, 6 for the fit_thermo_fisher function, and provided by the
user in the form of the N_peaks argument in case of the fit_beads function. This clustering
is performed on data transformed with the Logicle transformation Parks et al. (2006); Moore
and Parks (2012). Generally, the Logicle width (w parameter) of 1.0 has been working well for
all our data, but users can change the default by providing a diﬀerent logicle_width value.
The rest of the arguments is the same as with LED ﬁtting; the complete list of arguments is a
follows:

(cid:136) fcs_file_path – A character string specifying the ﬁle path to the FCS ﬁle with the

acquired bead data.

11

(cid:136) scatter_channels – A vector of 2 short channel names (values of the $PnN keywords)
specifying the 2 channels that should not be used to gate the main bead population. The
ﬁrst channel should be a forward scatter channel, the second one should be a side scatter
channel.

(cid:136) ignore_channels – A vector of short channel names (values of the $PnN keywords)
specifying channels that should not be considered for the ﬁtting procedure. Normally,
those should be all non-ﬂuorescence channels, such as the time and the (forward and
side) scatter channels.

(cid:136) N_peaks – The number of peaks (diﬀerent beads) to look for. This argument is applicable
to the fit_beads function only; the fit_spherotech and fit_thermo_fisher functions
have the number of peaks predeﬁned to 8 and 6, resp.

(cid:136) dyes – A vector of dye names. This value does not aﬀect the ﬁtting, but those dyes will

be “highlighted” in the provided results.

(cid:136) detectors – A vector of short channel names (values of the $PnN keywords) specifying
channels matching to the dyes speciﬁed above. The length of this vector shall correspond
to the length of the dyes vector. These channels should be all of the same type as speciﬁed
by the signal_type below, i.e., area or height of the measured signal.

(cid:136) signal_type – The type of the signal speciﬁed as the “area” or “height”. This should
match to the signal type that is being captured by the channels speciﬁed in the detectors
argument. The signal type is being used in order to trigger type-speciﬁc peak validity
checks. Currently, if signal type equals to “height” then peaks with a mean value lower
than the lowest peak mean value are omitted from the ﬁtting. In addition, peaks that are
not suﬃciently narrow (i.e., exceeding a speciﬁc maximum CV) are also omitted from
the ﬁtting. Currently, the maximum allowed CV is set to 0.65, but the code is designed
to make this user-conﬁgurable and signal type dependent eventually.

(cid:136) instrument_name – The make/model of the instrument. The purpose if this argument
is to allow for instrument-speciﬁc peak validity checks. At this point, if “BD Accuri” is
passed as the instrument type, then peaks with a mean value lower than the lowest peak
mean value are omitted from the ﬁtting. Additional instrument-speciﬁc peak validity
checks may be implemented in the future.

(cid:136) bounds – On some instruments, the lowest LED peaks may be cut oﬀ at a data baseline so
that the peak statistics will not be valid. Therefore, peaks too close to the baseline need
to be excluded from the ﬁtting. Also, many instruments do not maintain good linearity to
the full top of scale, so it is also important to specify a maximum level for good linearity
and, on each ﬂuorescence channel, exclude any peak that is above that maximum. The
bounds argument shall provide a list specifying the minimum and maximum value for
the means of valid peaks; peaks with means outsize of this range will be ignored for that
particular channel.

(cid:136) minimum_useful_peaks – Diﬀerent peaks may be omitted for diﬀerent channels due to
various validity checks described above. This argument speciﬁes the minimal number of

12

valid peaks required in order for the ﬁtting procedure to be performed on a particular
ﬂuorescence channel.

(cid:136) max_iterations – The maximum number of iterations for the iterative ﬁtting approach

with appropriate weight recalculations.

(cid:136) logicle_width – The data clustering part is performed on data transformed with the
Logicle transformation Parks et al. (2006); Moore and Parks (2012). Generally, the
Logicle width (w parameter) of 1.0 has been working well for all our data, but users can
change the default by providing a diﬀerent value.

> ## Example of fitting bead data based on Sph8 particle sets from Spherotech
> fcs_file_path <- system.file("extdata", "SSFF_LSRII", "Other_Tests",
+
"933745.fcs", package="flowQBData")
> scatter_channels <- c("FSC-A", "SSC-A")
> ## Depending on your hardware and input, this may take a few minutes, mainly
> ## due to the required clustering stage of the algorithm.
> spherotech_results <- fit_spherotech(fcs_file_path, scatter_channels,
+
+
+
> ## This is the same as if we were running
> ## fit_beads(fcs_file_path, scatter_channels,
> ##
> ##
> ##

ignore_channels, 8, dyes, detectors, bounds,
signal_type, instrument_name, minimum_useful_peaks = 3,
max_iterations = max_iterations, logicle_width = 1.0)

ignore_channels, dyes, detectors, bounds,
signal_type, instrument_name, minimum_useful_peaks = 3,
max_iterations = max_iterations, logicle_width = 1.0)

Next, let’s explore the results of this function. Unlike with the LED data, only the results
of quadratic ﬁtting are provided for ﬁtting bead data by the fit_beads (and fit_spherotech,
fit_thermo_fisher) functions. This is because linear ﬁtting does not account for the intrinsic
CV0 of the beads and is not appropriate for bead data, which always has a signiﬁcant non-linear
component.

The results of the fit_beads (and fit_spherotech, Rfunctionﬁt thermo ﬁsher) functions

is a list with the following components:

(cid:136) transformed_data – A ﬂowCore’s ﬂowFrame object capturing the data from the input
FCS ﬁle after the Logicle transformation. This may be reviewed if one wanted to check
that the Logicle transformation was appropriate for the input FCS ﬁle.

(cid:136) peaks – A list of ﬂowCore’s ﬂowFrame objects capturing the diﬀerent peaks identiﬁed
in the input FCS ﬁle by the K-means clustering algorithm. This may be reviewed if one
wanted to check that the clustering algorithm identiﬁed the peaks correctly.

(cid:136) peak_clusters – The result of the kmeans call. This shows the assignment of cluster
numbers to input data points and also provides additional details about the clustering;
see the documentation for the kmeans function for additional details.

13

Note that you may see a warning message saying that
Warning message:
Quick-TRANSfer stage steps exceeded maximum (= 3762700)
According to kmeans documentation, in some cases, when some of the points (rows of
‘x’) are extremely close, the algorithm may not converge in the “Quick-Transfer” stage,
signaling a warning. Based on our experience, this has not negatively aﬀected the result
of the clustering. By default, we use the Hartigan and Wong algorithm. We tried other
algorithms as well, but those were signiﬁcantly slower. We also tried to round up the
data as advised in the kmeans documentation, but that has not resolved the warning.
Below, we demonstrate one way of a simple visual inspection of the clustering results.

> library("flowCore")
> plot(
+
+
+

exprs(spherotech_results$transformed_data[,"FITC-A"]),
exprs(spherotech_results$transformed_data[,"Pacific Blue-A"]),
col=spherotech_results$peak_clusters$cluster, pch=

)

.

’

’

Figure 1: Result of K-means clustering on bead data.

(cid:136) peak_stats – A list with summary stats for each of the channels for all the diﬀerent
peaks identiﬁed by the K-means clustering algorithm. For each of the channels, peak
stats are captured by a data frame with rows corresponding to the diﬀerent peaks and
the following columns:

14

– N: the number of events in the peak
– M: the mean expression value for that peak
– SD: the standard deviation for that peak
– V: the variance for that peak (square of standard deviation)
– W: the weight of that peak
– Omit: was the peak omitted from the ﬁtting? (TRUE or FALSE)
– QR: the residuals of the quadratic ﬁtting
– QR-I: the residuals of the iterative quadratic ﬁtting

The values of W, QR, and QR-I will be NA if Omit is TRUE.

> ## We have stats for these channels
> names(spherotech_results$peak_stats)

"PerCP-Cy5-5-A"
"Aqua Amine-A"

"FITC-H"
"Pacific Blue-H"

[1] "FITC-A"
[5] "Pacific Blue-A"
[9] "Pacific Orange-A" "Pacific Orange-H" "QDot 585-A"
"QDot 655-A"
"QDot 800-A"
"APC-Cy5-5-A"
"PE-A"
"PE-Cy5-A"
"PE-Cy7-A"

[13] "QDot 605-A"
[17] "QDot 705-A"
[21] "APC-A"
[25] "APC-Cy7-A"
[29] "PE-Texas-Red-A"
[33] "PE-Cy5-5-A"

"QDot 605-H"
"QDot 705-H"
"APC-H"
"APC-Cy7-H"
"PE-Texas-Red-H"
"PE-Cy5-5-H"

"PerCP-Cy5-5-H"
"Aqua Amine-H"
"QDot 585-H"
"QDot 655-H"
"QDot 800-H"
"APC-Cy5-5-H"
"PE-H"
"PE-Cy5-H"
"PE-Cy7-H"

> ## Explore the peak stats for a randomly chosen channel (PE-Cy7-A)
> spherotech_results$peak_stats$

PE-Cy7-A

‘

‘

V

M

W Omit

SD
2.969811 12.16330
53.089314 17.76156
125.823738 23.33198
364.936465 36.91832
955.949085 59.54898

N
QR
3 8077
147.9459 1.870088e-01 FALSE 0.4344676
2 9921
315.4732 5.034972e-02 FALSE 0.3882033
7 9838
544.3815 1.576308e-02 FALSE -1.7906609
8 9563
1362.9621 2.496317e-03 FALSE -1.0138917
3546.0806 3.889869e-04 FALSE -0.2286548
6 9864
1 9929 2920.874056 112.00451 12545.0092 3.336749e-05 FALSE 2.0298835
4 9392 10513.486601 260.68607 67957.2246 1.084721e-06 FALSE 2.2925293
5 8670 31827.619940 613.35520 376204.6074 2.879756e-08 FALSE -1.9087620

QR-I
3 0.4332335
2 0.3609676
7 -1.7842795
8 -1.0468524
6 -0.2861496
1 2.0100835
4 2.2536615
5 -1.9956686

15

(cid:136) fits – A a data frame with ﬁts for each of the channels. The columns of the data frame
correspond to the diﬀerent channels. The rows of the data frame capture the coeﬃcients
of the quadratic ﬁtting as follows:

– c0: value of the c0 coeﬃcient
– c0 SE: standard error of the c0 coeﬃcient
– c0 P: the P-value for the c0 coeﬃcient
– c1: value of the c1 coeﬃcient
– c1 SE: standard error of the c1 coeﬃcient
– c1 P: the P-value for the c1 coeﬃcient
– c2: value of the c2 coeﬃcient
– c2 SE: standard error of the c2 coeﬃcient
– c2 P: the P-value for the c2 coeﬃcient

(cid:136) dye_fits – A data frame with ﬁts for each “dye”. These are the same stats as fits
described above, but the columns will only be restricted to the detectors/dyes that were
listed as arguments of the fit_beads (or fit_spherotech or Rfunctionﬁt thermo ﬁsher)
call. The column headings are converted from channel names (detectors) to “dyes” as per
the mapping supplied by the detectors and dyes arguments. The rows of the data frame
are the same as with the fits described above.

(cid:136) iterated_fits – A data frame with ﬁts for each of the channels in the same way as for

the fits described above, but based on iterative ﬁtting with weights adjustments.

(cid:136) iterated_dye_fits – A data frame with ﬁts for each of the “dyes” in the same way as
for the dye_fits described above, ut based on iterative ﬁtting with weights adjustments.

> ## Explore fits
> ## Selecting just a few columns to limit the output for the vignette
> spherotech_results$fits[,c(1,3,5,7)]

c0
2.279202e+02 1.734879e+02
c0 SE 6.336731e+00 7.841752e+00
c0 P 3.126987e-07 3.503995e-06
c1
1.182330e+00 5.254038e+00
c1 SE 3.439979e-02 9.963396e-02
c1 P 3.921558e-07 4.636633e-08
1.577893e-04 1.659749e-04
c2
c2 SE 5.698240e-06 8.127431e-06
c2 P 1.149662e-06 5.209133e-06

FITC-A PerCP-Cy5-5-A Pacific Blue-A Aqua Amine-A
1.085179e+03 2.796467e+02
2.219616e+02 2.658224e+01
4.517310e-03 1.339868e-04
2.130883e+00 2.993364e+00
3.057509e-01 1.018094e-01
9.354467e-04 8.532510e-07
5.548891e-05 4.313149e-05
1.239132e-05 4.816474e-06
6.530494e-03 2.894913e-04

> ## Explore iterated_fits
> spherotech_results$iterated_fits[,c(1,3,5,7)]

16

c0
2.284268e+02 1.736666e+02
c0 SE 6.298450e+00 7.716872e+00
c0 P 3.000582e-07 3.219470e-06
c1
1.180748e+00 5.262220e+00
c1 SE 3.449458e-02 9.939750e-02
c1 P 4.002286e-07 4.546503e-08
c2
1.585357e-04 1.662474e-04
c2 SE 5.782606e-06 8.210081e-06
c2 P 1.208137e-06 5.432316e-06

FITC-A PerCP-Cy5-5-A Pacific Blue-A Aqua Amine-A
1.107388e+03 2.796647e+02
2.183508e+02 2.787112e+01
3.861810e-03 1.681702e-04
2.100554e+00 2.996135e+00
3.202972e-01 1.083045e-01
1.235579e-03 1.155231e-06
6.644599e-05 4.429834e-05
1.451048e-05 5.232664e-06
5.951955e-03 3.777046e-04

The Q, B and intrinsic CV0 can be extracted from the ﬁts using the equations shown
in the introduction. For your convenience, this is implemented in the qb_from_fits
function as shown below in this vignette.

(cid:136) iteration_numbers – A data frame with rows corresponding to all the diﬀerent channels
and a column, Q, showing the number of iterations used for the quadratic ﬁtting. This
data frame can be reviewed in order to make sure the ﬁtting is converging fast enough
and the max_iterations parameter is set large enough.

> ## Explore iteration numbers
> ## Showing only the head in order to limit the output for the vignette
> head(spherotech_results$iteration_numbers)

Q
3
FITC-A
FITC-H
2
PerCP-Cy5-5-A 2
PerCP-Cy5-5-H 2
Pacific Blue-A 6
Pacific Blue-H 6

6 Calculating Q and B from ﬁts

The qb_from_fits function can be used to calculate Q and B using the equations shown in the
introduction. As arguments, the qb_from_fits function can take results from both, LED data
ﬁtting (fit_led function) and bead data ﬁtting (fit_beads, fit_spherotech function and
fit_thermo_fisher functions). You can calculate based on any of the ﬁts (fits, dye_fits,
iterated_fits and iterated_dye_fits).

> ## 1 QB from both quadratic and linear fits of LED data
> qb_from_fits(led_results$iterated_dye_fits)

APC
0.2471628

q_QI
q_BSpe 2.67187

APC-Cy7
0.0924436
0.4687583

APC-H7
0.0924436
0.4687583

FITC
0.9062239
80.13201

PE
0.8363383
59.09138

17

q_CV0sq -2.319832e-06 6.918162e-06 6.918162e-06 -6.642736e-07 -1.29009e-06
l_QI
l_BSpe 2.726655

0.09218902
0.465892

0.914678
81.76315

0.2492182

PE-Cy7
0.3155145

PerCP
0.1930786
3.859794

q_QI
q_BSpe 9.310852
q_CV0sq 1.126357e-05 -1.126435e-06 -1.126435e-06 -2.374796e-07 -1.056184e-06
l_QI
l_BSpe 9.171582

0.3467648
27.05806

0.6263673
122.839

0.1936836
3.887277

0.1936836
3.887277

0.3133122

V450
0.624674
122.1246

0.09218902
0.465892
PerCP-Cy55
0.1930786
3.859794

0.8547152
62.02091
V500-C
0.3451598
26.78439

> ## 2 QB from quadratic fitting of bead data
> qb_from_fits(spherotech_results$iterated_dye_fits)

APC
0.2471561

q_QI
q_BSpe 6.361819
q_CV0sq 0.0005171358 0.000528445 0.000528445 0.0001585357 0.0003145017

APC-Cy7
0.07570052 0.07570052 0.8469206
4.833385
4.833385

PE
0.7647581
134.2726

163.8447

APC-H7

FITC

PE-Cy7
0.3016751

q_QI
q_BSpe 12.47693
q_CV0sq 0.0002787022 0.0001662474 0.0001662474 6.644599e-05 4.429834e-05

PerCP-Cy55
0.1900339
6.271601

V450
0.4760648
250.976

V500-C
0.3337633
31.15408

PerCP
0.1900339
6.271601

The result of this function is a matrix with columns corresponding to the names of the ﬁts

used (e.g. dyes or detectors). In case of LED ﬁts, the rows will contain the following items:

(cid:136) q_QI The calculated QI value of the quadratic ﬁtting.

(cid:136) q_BSpe The calculated BSpe value of the quadratic ﬁtting.

(cid:136) q_CV0sq The calculated CV 2

0 value of the quadratic ﬁtting.

(cid:136) l_QI The calculated QI value of the linear ﬁtting.

(cid:136) l_BSpe The calculated BSpe value of the linear ﬁtting.

As expected, you can see that the estimated CV 2

0 values for the LED data are very close
to 0 and therefore, the linear model may be preferable. Note that the estimated value can also
be small negative since; this is OK since those are just estimates from our model. The true
CV 2
0 should be very close to 0 unless there is something wrong with the instrument or LED
data collection.

In case of bead data ﬁts, the rows will contain the following items:

(cid:136) q_QI The calculated QI value of the quadratic ﬁtting.

(cid:136) q_BSpe The calculated BSpe value of the quadratic ﬁtting.

(cid:136) q_CV0sq The calculated CV 2

0 value of the quadratic ﬁtting.

18

7 Parsing house-keeping information from spreadsheets

We designed a simple MS Excel template in order to keep track of FCS ﬁles along with the
necessary metadata to facilitate fully automated processing of bead and LED data generated
by many diﬀerent instruments. An example of this template is shown in the
inst/extdata/140126_InstEval_Stanford_LSRIIA2.xlsx ﬁle of the ﬂowQBData package.
This spreadsheet self-explanatory and captures details, such as the instrument name, location,
data folder and ﬁle names, dyes or sample names, which channels are ﬂuorescence based and
which aren’t. Below, we show an example of how the xlsx package can be used in order to
process metadata from the spreadsheet and perform the ﬁtting based on that.

"140126_InstEval_Stanford_LSRIIA2.xlsx", package="flowQBData")

ignore_channels[[i]] <- xlsx[[i+4]][[ignore_channels_row]]
i <- i + 1

> ## Example of fitting based on house-keeping information in a spreadsheet
> library(xlsx)
> ## LED Fitting first
> inst_xlsx_path <- system.file("extdata",
+
> xlsx <- read.xlsx(inst_xlsx_path, 1, headers=FALSE, stringsAsFactors=FALSE)
> ignore_channels_row <- 9
> ignore_channels <- vector()
> i <- 1
> while(!is.na(xlsx[[i+4]][[ignore_channels_row]])) {
+
+
+ }
> instrument_folder_row <- 9
> instrument_folder_col <- 2
> instrument_folder <- xlsx[[instrument_folder_col]][[instrument_folder_row]]
> folder_column <- 18
> folder_row <- 14
> folder <- xlsx[[folder_column]][[folder_row]]
> fcs_directory <- system.file("extdata", instrument_folder,
+
> fcs_file_path_list <- list.files(fcs_directory, "*.fcs", full.names= TRUE)
> bounds_min_col <- 6
> bounds_min_row <- 7
> bounds_max_col <- 7
> bounds_max_row <- 7
> bounds <- list()
> if (is.na(xlsx[[bounds_min_col]][[bounds_min_row]])) {
+
+ } else {
+
+ }
> if (is.na(xlsx[[bounds_max_col]][[bounds_max_row]])) {
+
+ } else {

bounds$minimum <- as.numeric(xlsx[[bounds_min_col]][[bounds_min_row]])

folder, package="flowQBData")

bounds$maximum <- 100000

bounds$minimum <- -100

19

bounds$maximum <- as.numeric(xlsx[[bounds_max_col]][[bounds_max_row]])

+
+ }
> signal_type_col <- 3
> signal_type_row <- 19
> signal_type <- xlsx[[signal_type_col]][[signal_type_row]]
> instrument_name_col <- 2
> instrument_name_row <- 5
> instrument_name <- xlsx[[instrument_name_col]][[instrument_name_row]]
> channel_cols <- 3:12
> dye_row <- 11
> detector_row <- 13
> dyes <- as.character(xlsx[dye_row,channel_cols])
> detectors <- as.character(xlsx[detector_row,channel_cols])
> ## Now we do the LED fitting
> led_results <- fit_led(fcs_file_path_list, ignore_channels, dyes,
+
+
> led_results$iterated_dye_fits

detectors, signal_type, instrument_name, bounds = bounds,
minimum_useful_peaks = 3, max_iterations = 10)

APC

FITC

APC-H7

APC-Cy7

PE
4.373702e+01 5.485236e+01 5.485236e+01 9.757420e+01 8.448122e+01
4.927771e-01 4.486962e-01 4.486962e-01 5.370821e-01 6.389481e-01
7.916529e-22 3.362482e-25 3.362482e-25 1.724002e-26 2.019751e-24
4.045917e+00 1.081741e+01 1.081741e+01 1.103480e+00 1.195688e+00
2.587943e-02 6.650987e-02 6.650987e-02 7.211628e-03 8.805424e-03
1.638819e-25 3.501722e-27 3.501722e-27 2.261596e-25 1.354680e-24
-2.319832e-06 6.918162e-06 6.918162e-06 -6.642736e-07 -1.290090e-06
9.324947e-07 8.429915e-06 8.429915e-06 2.754594e-07 2.441059e-07
2.510422e-02 4.238943e-01 4.238943e-01 2.916096e-02 9.163236e-05
4.390061e+01 5.481847e+01 5.481847e+01 9.772848e+01 8.489757e+01
SE 5.586205e-01 4.421346e-01 4.421346e-01 6.043944e-01 1.014942e+00
3.907590e-22 1.405896e-26 1.405896e-26 3.844500e-27 1.443102e-22
P
4.012548e+00 1.084728e+01 1.084728e+01 1.093281e+00 1.169980e+00
SE 2.491698e-02 5.529722e-02 5.529722e-02 6.506622e-03 1.129094e-02
4.104294e-27 5.795695e-30 5.795695e-30 2.080562e-27 4.720601e-24
P

c0
c0 SE
c0 P
c1
c1 SE
c1 P
c2
c2 SE
c2 P
’
c0
’
c0
’
c0
’
c1
’
c1
’
c1

V450

PerCP

PE-Cy7

PerCP-Cy55

V500-C
9.352994e+01 1.035370e+02 1.035370e+02 3.129652e+02 2.248232e+02
c0
c0 SE 6.358298e-01 8.060501e-01 8.060501e-01 2.384735e+00 1.909144e+00
1.745326e-26 1.524545e-25 1.524545e-25 4.885665e-23 2.223895e-22
c0 P
3.169426e+00 5.179237e+00 5.179237e+00 1.600835e+00 2.897208e+00
c1
c1 SE 3.079347e-02 3.132667e-02 3.132667e-02 1.682641e-02 2.791201e-02
5.257193e-24 2.694713e-27 2.694713e-27 4.391862e-21 1.299215e-21
c1 P
c2
1.126357e-05 -1.126435e-06 -1.126435e-06 -2.374796e-07 -1.056184e-06
c2 SE 1.056842e-05 1.201127e-06 1.201127e-06 5.847438e-07 1.310125e-06
3.023441e-01 3.622815e-01 3.622815e-01 6.907897e-01 4.336259e-01
c2 P

20

’
’
’
’
’
’

c0
c0
c0
c1
c1
c1

9.343071e+01 1.036238e+02 1.036238e+02 3.130964e+02 2.250229e+02
SE 6.309986e-01 7.983035e-01 7.983035e-01 2.295434e+00 1.872126e+00
P 6.895985e-28 6.451561e-27 6.451561e-27 1.266708e-24 8.429249e-24
3.191705e+00 5.163059e+00 5.163059e+00 1.596507e+00 2.883799e+00
SE 2.297232e-02 2.594998e-02 2.594998e-02 1.254114e-02 2.204240e-02
P 2.033137e-27 4.555707e-30 4.555707e-30 3.564513e-24 2.366284e-24

> qb_from_fits(led_results$iterated_dye_fits)

APC
0.2471628

APC-Cy7
0.0924436
0.4687583

APC-H7
0.0924436
0.4687583

FITC
0.9062239
80.13201

q_QI
q_BSpe 2.67187
q_CV0sq -2.319832e-06 6.918162e-06 6.918162e-06 -6.642736e-07 -1.29009e-06
l_QI
l_BSpe 2.726655

0.09218902
0.465892

0.914678
81.76315

0.2492182

PE
0.8363383
59.09138

PE-Cy7
0.3155145

PerCP
0.1930786
3.859794

q_QI
q_BSpe 9.310852
q_CV0sq 1.126357e-05 -1.126435e-06 -1.126435e-06 -2.374796e-07 -1.056184e-06
l_QI
l_BSpe 9.171582

0.3467648
27.05806

0.6263673
122.839

0.1936836
3.887277

0.1936836
3.887277

0.3133122

V450
0.624674
122.1246

0.09218902
0.465892
PerCP-Cy55
0.1930786
3.859794

0.8547152
62.02091
V500-C
0.3451598
26.78439

filename, package="flowQBData")

ignore_channels, dyes, detectors, bounds,
signal_type, instrument_name, minimum_useful_peaks = 3,
max_iterations = 10, logicle_width = 1.0)

> ## Next we do the bead fitting; this example is with Thermo-fisher beads
> folder_column <- 17
> folder <- xlsx[[folder_column]][[folder_row]]
> filename <- xlsx[[folder_column]][[folder_row+1]]
> fcs_file_path <- system.file("extdata", instrument_folder, folder,
+
> thermo_fisher_results <- fit_thermo_fisher(fcs_file_path, scatter_channels,
+
+
+
> ## The above is the same as this:
> ## N_peaks <- 6
> ## thermo_fisher_results <- fit_beads(fcs_file_path, scatter_channels,
> ##
> ##
> ##
>
> thermo_fisher_results$iterated_dye_fits

ignore_channels, N_peaks, dyes, detectors, bounds,
signal_type, instrument_name, minimum_useful_peaks = 3,
max_iterations = 10, logicle_width = 1.0)

APC

APC-Cy7

PE
c0
4.296208e+01 1.018574e+03 1.018574e+03 3.125905e+02 2.386214e+02
c0 SE 2.587192e+01 3.634355e+01 3.634355e+01 9.567809e+00 1.635296e+01
c0 P 2.386789e-01 9.972140e-05 9.972140e-05 6.302575e-05 4.663665e-03
4.552617e+00 1.110474e+01 1.110474e+01 1.314029e+00 1.439678e+00
c1

APC-H7

FITC

21

PerCP

PE-Cy7

c1 SE 1.644068e-01 2.900420e-01 2.900420e-01 3.659697e-02 1.081177e-01
c1 P 1.301574e-03 3.919791e-05 3.919791e-05 4.750944e-05 5.592521e-03
1.541674e-04 4.098777e-04 4.098777e-04 6.163210e-05 2.880279e-04
c2
c2 SE 1.084120e-05 2.000478e-05 2.000478e-05 2.273383e-06 1.601052e-05
c2 P 4.908653e-03 2.542125e-04 2.542125e-04 1.101398e-04 3.075632e-03
V500-C
1.459466e+02 1.900378e+02 1.900378e+02 1.391498e+03 3.066774e+02
c0
c0 SE 3.956221e+00 9.592507e+00 9.592507e+00 3.086424e+02 3.486027e+01
c0 P 4.381092e-05 2.810462e-04 2.810462e-04 2.038735e-02 3.094400e-03
c1
3.051857e+00 5.142074e+00 5.142074e+00 1.773569e+00 2.907502e+00
c1 SE 7.456814e-02 1.664320e-01 1.664320e-01 6.846720e-01 2.902937e-01
c1 P 3.210002e-05 7.449568e-05 7.449568e-05 8.104654e-02 2.118624e-03
c2
3.278930e-04 1.534763e-04 1.534763e-04 3.670452e-04 4.565748e-04
c2 SE 1.638842e-05 1.105824e-05 1.105824e-05 6.917897e-05 5.936109e-05
c2 P 2.728937e-04 8.097429e-04 8.097429e-04 1.307095e-02 4.566928e-03

PerCP-Cy55

V450

> qb_from_fits(thermo_fisher_results$iterated_dye_fits)

APC
0.2196539

q_QI
q_BSpe 2.072827
q_CV0sq 0.0001541674 0.0004098777 0.0004098777 6.16321e-05 0.0002880279

APC-H7
0.09005164
8.259919

FITC
0.7610181
181.0364

PE
0.6945996
115.1273

APC-Cy7
0.09005164
8.259919

PE-Cy7
0.3276693

q_QI
q_BSpe 15.66988
q_CV0sq 0.000327893 0.0001534763 0.0001534763 0.0003670452 0.0004565748

PerCP-Cy55
0.1944741
7.187262

V450
0.5638348
442.3708

V500-C
0.3439379
36.27788

PerCP
0.1944741
7.187262

8 Using data from FlowRepository

We have collected over 900 FCS ﬁles from running multi-level beads and LED generated data
on over 30 diﬀerent instruments. This dataset has been uploaded to FlowRepository, it has
the public identiﬁer FR-FCM-ZZTF and it will be released along with the publication of a paper
describing this work. MS Excel spredsheets with all the required metadata to perform the
calculations of Q, B and related characteristics are included with that data set. Here, we
will demonstrate how to access the data directly from within R in order to perform such
calculations.

be required once the data is publicly available; see the
FlowRepositoryR vignette for further details.

> library("FlowRepositoryR")
> ## 1) Specify your credentials to work with FlowRepository, this will not
> ##
> ##
> setFlowRepositoryCredentials(email="your@email.com", password="password")
> ##
> ## 2) Get the dataset from FlowRepository
> ##
> ##

Note that this does not download the data. You could download all
data by running

22

’

function(a) { endsWith(a@name, ".xlsx") })))

t want to download everythink, just one of the files

qbDataset <- download(flowRep.get("FR-FCM-ZZTF"))
but note that this will download about 3 GB of data

> ##
> ##
> qbDataset <- flowRep.get("FR-FCM-ZZTF")
> ##
> summary(qbDataset)
> ## A flowRepData object (FlowRepository dataset) Asilomar Instrument
> ## Standardization
> ## 911 FCS files, 36 attachments, NOT downloaded
> ##
> ## 3) See which of the files are MS Excell spredsheets
> spreadsheet_indexes <- which(unlist(lapply(qbDataset@attachments,
+
> ##
> ## 4) Download a random spreadsheet, say the 5th spreadsheet
> ## This is a bit ugly at this point since the data is not public
> ## plus we don
> library(RCurl)
> h <- getCurlHandle(cookiefile="")
> FlowRepositoryR:::flowRep.login(h)
> ## Once the data is public, only this line and without the curlHandle
> ## argument will be needed:
> qbDataset@attachments[[spreadsheet_indexes[5]]] <- xslx5 <- download(
+
> ## File 140126_InstEval_NIH_Aria_B2.xlsx downloaded.
> ##
> ## 5) Read the spreadsheet
> library(xlsx)
> xlsx <- read.xlsx(xslx5@localpath, 1, headers=FALSE, stringsAsFactors=FALSE)
> ##
> ## 6) Which FCS file contains the Spherotech data?
> ##
> ##
> instrument_row <- 9
> instrument_col <- 2
> instrument_name <- xlsx[[instrument_folder_col]][[instrument_folder_row]]
> fol_col <- 16
> fol_row <- 14
> fol_name <- xlsx[[fol_col]][[fol_row]]
> fcsFilename <- paste(instrument_name, fol_name,
xlsx[[fol_col]][[fol_row+1]], sep="_")
+
> fcsFilename
> ## [1] "NIH Aria_B 140127_Other Tests_BEADS_Spherotech Rainbow1X_012.fcs"
> ##
> ## 7) Let
> ##

This is based on how we create the Excel spreadsheets and
the FCS file names.

Again, the curlHandle is only needed since the file is not public yet

qbDataset@attachments[[spreadsheet_indexes[5]]], curlHandle=h)

s locate the file in our dataset and let

s download it

’

’

23

f@name == fcsFilename })))

xlsx[[fol_col]][[fol_row+2]],
xlsx[[fol_col]][[fol_row+3]])

ignore_channels[[i]] <- xlsx[[i+4]][[ignore_channels_row]]
i <- i + 1

> fcsFileIndex = which(unlist(lapply(qbDataset@fcs.files, function(f) {
+
> qbDataset@fcs.files[[fcsFileIndex]] <- fcsFile <- download(
+
qbDataset@fcs.files[[fcsFileIndex]], curlHandle=h)
> # File NIH Aria_B 140127_Other Tests_BEADS_Spherotech Rainbow1X_012.fcs
> # downloaded.
> ##
> ## 8) Read in some more metadata from the spreadsheet
> scatter_channels <- c(
+
+
> ignore_channels_row <- 9
> ignore_channels <- vector()
> i <- 1
> while(!is.na(xlsx[[i+4]][[ignore_channels_row]])) {
+
+
+ }
> bounds_min_col <- 6
> bounds_min_row <- 7
> bounds_max_col <- 7
> bounds_max_row <- 7
> bounds <- list()
> if (is.na(xlsx[[bounds_min_col]][[bounds_min_row]])) {
+
+ } else {
+
+ }
> if (is.na(xlsx[[bounds_max_col]][[bounds_max_row]])) {
+
+ } else {
+
+ }
> signal_type_col <- 3
> signal_type_row <- 19
> signal_type <- xlsx[[signal_type_col]][[signal_type_row]]
> channel_cols <- 3:12
> dye_row <- 11
> detector_row <- 13
> dyes <- as.character(xlsx[dye_row,channel_cols])
> detectors <- as.character(xlsx[detector_row,channel_cols])
> ##
> ## 9) Let
> multipeak_results <- fit_spherotech(fcsFile@localpath, scatter_channels,
+

ignore_channels, dyes, detectors, bounds,

bounds$maximum <- 100000

bounds$minimum <- -100

s calculate the fits

’

bounds$minimum <- as.numeric(xlsx[[bounds_min_col]][[bounds_min_row]])

bounds$maximum <- as.numeric(xlsx[[bounds_max_col]][[bounds_max_row]])

24

APC
0.2406655

signal_type, instrument_name)

+
> ##
> ## 10) And same as before, we can extract Q, B and CV0 from the fits
> qb_from_fits(multipeak_results$iterated_dye_fits)
> #
> # q_QI
> # q_BSpe 34.33642
> # q_CV0sq 0.0006431427 0.0004931863 0.0004931863 0.001599552 0.001065658
> #
> # q_QI
> # q_BSpe 11.15762
> # q_CV0sq 0.001286111 0.001622208 0.001622208 0.005127177 0.004315592

PerCP
0.08987149 0.08987149 0.07051216 0.192678
8.167175

PE
0.9014326
812.5968

FITC
0.2034718
21.57055

APC-Cy7
0.1291517
21.47796

APC-H7
0.1291517
21.47796

PE-Cy7
0.2754679

PerCP-Cy55 V450

24.81647

8.167175

63.4188

V500-C

The example shown above processes the Spherotech beads. In order to process the Thermo
Fisher beads, one would need to change fol_col to 17 in order to determine the proper ﬁlename
with Thermo Fisher beads results. This is due to how the MS Excel spreadsheet templeta is
created. Then, one would use the fit_thermo_fisher instead of the fit_spherotech function.
If one wanted to process the LED data described by this spredsheet, one would look at
columns 3 to 12 to extact the fol_name from row 14 and the last part of the ﬁlename from
row 15. Same as shown in the example above, the instrument name, fol_name and the last
part of the ﬁle name would need to be appended to obtain the complete ﬁle name that can be
looked up among FCS ﬁles in the QB dataset. Speciﬁcally, one could lookup the LED FCS
ﬁles referenced by the spreadsheet as follows:

> LEDfcsFileIndexes <- which(unlist(lapply(qbDataset@fcs.files, function(f)
+ {
+
+ })))
> # [1] 173 174 175 176 177 178 179 180 181 182

f@name %in% paste(instrument_name, xlsx[14, 3:12], xlsx[15, 3:12], sep="_")

These can than be downloaded and processed analogically to what has been shown above,

e.g.,

qbDataset@fcs.files[[i]] <- download(qbDataset@fcs.files[[i]],

> dir <- tempdir()
> cwd <- getwd()
> setwd(dir)
> lapply(LEDfcsFileIndexes, function(i) {
+
+
+ })
> setwd(cwd)
> fcs_file_path_list <- list.files(dir, "*.fcs", full.names= TRUE)
> led_results <- fit_led(fcs_file_path_list, ignore_channels, dyes,
+

detectors, signal_type, instrument_name, bounds = bounds)

curlHandle=h)

25

9 Package version

The ﬂowQB package and its functionality have been changed signiﬁcantly between this and
past versions. Functionality described above is only applicable if you have the latest version
as shown below.

> ## This vignette has been created with the following configuration
> sessionInfo()

R version 3.5.2 (2018-12-20)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Ubuntu 16.04.5 LTS

Matrix products: default
BLAS: /home/biocbuild/bbs-3.8-bioc/R/lib/libRblas.so
LAPACK: /home/biocbuild/bbs-3.8-bioc/R/lib/libRlapack.so

locale:

[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_US.UTF-8
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=en_US.UTF-8

[11] LC_MEASUREMENT=en_US.UTF-8

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=en_US.UTF-8
LC_TELEPHONE=en_US.UTF-8
LC_IDENTIFICATION=en_US.UTF-8

attached base packages:
[1] stats

graphics grDevices utils

datasets methods

base

other attached packages:
[1] xlsx_0.6.1

flowCore_1.48.1 flowQBData_1.8.0 flowQB_2.10.1

loaded via a namespace (and not attached):

[1] graph_1.60.0
Rcpp_1.0.0
[4] BiocGenerics_0.28.0 gWidgetstcltk_0.0-55 MASS_7.3-51.1
[7] lattice_0.20-38

cluster_2.0.7-1

[10] tcltk_3.5.2
[13] gWidgets_0.0-54
[16] Biobase_2.42.0
[19] digest_0.6.18
[22] robustbase_0.93-3
[25] stats4_3.5.2

References

rrcov_1.4-7
tools_3.5.2
parallel_3.5.2
corpcor_1.6.9
rJava_0.9-10
compiler_3.5.2
mvtnorm_1.0-8

pcaPP_1.9-73
extremevalues_2.3.2
grid_3.5.2
matrixStats_0.54.0
xlsxjars_0.6.1
DEoptimR_1.0-8

E. S. Chase and R. A. Hoﬀman. Resolution of dimly ﬂuorescent particles: a practical measure

of ﬂuorescence sensitivity. Cytometry, 33(2):267–279, Oct 1998.

26

R. A. Hoﬀman and J. C. Wood. Characterization of ﬂow cytometer instrument sensitivity.

Curr Protoc Cytom, Chapter 1:Unit1.20, Apr 2007.

W. A. Moore and D. R. Parks. Update for the logicle data scale including operational code

implementations. Cytometry A, 81(4):273–277, Apr 2012.

D. R. Parks, M. Roederer, and W. A. Moore. A new ”Logicle” display method avoids deceptive
eﬀects of logarithmic scaling for low signals and compensated data. Cytometry A, 69(6):
541–551, Jun 2006.

D. R. Parks, F. El Khettabi, W. A. Moore, J. Spidlen, R. R. Brinkman, J. C. S. Wood,
S. Perfetto, R. A. Hoﬀman, and E. Chase. Evaluating ﬂow cytometer performance with
weighted quadratic least squares analysis of LED and multi-level bead data. (to be submitted),
2016.

J. Spidlen, W. Moore, D. Parks, M. Goldberg, C. Bray, P. Bierre, P. Gorombey, B. Hyun,
M. Hubbard, S. Lange, R. Lefebvre, R. Leif, D. Novo, L. Ostruszka, A. Treister, J. Wood,
R. F. Murphy, M. Roederer, D. Sudar, R. Zigon, and R. R. Brinkman. Data File Standard
for Flow Cytometry, version FCS 3.1. Cytometry A, 77(1):97–100, Jan 2010.

J. C. Wood. Fundamental ﬂow cytometer properties governing sensitivity and resolution.

Cytometry, 33(2):260–266, Oct 1998.

27

