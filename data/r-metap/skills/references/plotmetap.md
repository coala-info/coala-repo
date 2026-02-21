Plotting in the metap package

Michael Dewey

December 18, 2025

1

Introduction

1.1 What is this document for?

This document describes how and why to plot p–values in the metap package.
Examining the p–values graphically or otherwise before subjecting them to
further analysis is useful to provide a visual impression of their distribution
and to check for excess p–values at both extremes.. Three functions are
provided for this purpose: albatros, plotp, and schweder.

1.2 Example datasets

As our example we use various data-sets:

teachexpect Eﬀect of teacher expectations on student IQ (Becker, 1994)

validity The validity of student ratings of their instructors (Becker, 1994).

zhang The eﬀect of the timing of exercise interventions for patients with

cardiovascular disease (Zhang et al., 2016)

> library(metap)
> data(dat.metap)
> teach <- dat.metap$teachexpect
> validity <- dat.metap$validity$p
> zhang <- dat.metap$zhang
> print(validity)

[1] 0.015223 0.005117 0.224837 0.000669 0.004063 0.549106 0.052925 0.024674
[9] 0.004618 0.287803 0.738475 0.009563 0.071971 0.000003 0.001040 0.031221

[17] 0.005274 0.098791 0.067441 0.250210

1

2 Plotting using plotp

The plotp provides a Q–Q plot of the p–values to detect departure from the
uniform distribution.

> plotp(validity, main = "Validity data")

(a) Q–Q plot from plotp

(b) Legacy Q–Q plot

Figure 1: Plots of validity data

Figure 1a shows the resulting plot. The line represents a ﬁt to the uniform
distribution and the polygon is a simultaneous conﬁdence region such that
if any point lies outside it we reject the null hypothesis that the points are
drawn iid from a uniform. Small p–values are to the left of the plot

The format of plot shown in Figure 1a was ﬁrst introduced in version 1.8 of
metap. The previous plotting function is still available and it is possible to
produce this plot by setting the plotversion parameter to "old" in the call
to plotp. An example is shown in Figure 1b which ﬁrst calls sumlog. The
legacy one will always remain an option.

> plotp(validity, main = "Validity data", plotversion = "old")

Note that the plot method for objects of class "metap" uses the new version
of the plot. This change was introduced in version 1.9 of this package.

There are many possible options which can be passed to the plotting function
and hence to the qqconf plotting routine. The documentation for the qqconf
package should be consulted for details. The qqconf package vignette is also
very helpful. We will look at one of those options here though.

2

0.20.40.60.80.00.20.40.6Validity dataExpected quantilesObserved quantiles0.00.20.40.60.81.00.00.20.40.6Validity dataTheoreticalEmpirical> plotp(teach)

> plotp(teach, log10 = TRUE)

(a) Linear scaling

(b) Log scaling

Figure 2: Teacher expectancy data

Figure 2 shows the teacher expectancy data using the default scaling in sub–
ﬁgure ??.
It is hard to see whether some of the points fall outside the
boundary. However if we use the log–scaling option shown in sub–ﬁgure ??
it becomes much clearer. Note that the scale is reversed between the sub–
plots and in ?? the small p–values are now on the right. So the cluster of
points near the bottom left of the sub–ﬁgure ?? are hard to distinguish as to
whether they lie inside the boundary or not. In the log scaling of sub–ﬁgure
?? where they appear towards the top right it is much clearer that one does
fall outside the boundary and two others are borderline. This reﬂects the
fact that for most of the methods in the metap package the overall p–value
is below 0.05. For instance using the logit method we have

> logitp(teach)

t =

2.763487 with df = 99

p =

0.003409951

3 Plotting using schweder

A function schweder provides plots with a variety of informative lines su-
perimposed. It plots the ordered p–values, p[i] : p[1] ≤
p[k−1] ≤

≤
p[k], against i. Although the original motivation for the plot is

. . . p[2] ≤

. . . p[i] . . .

3

0.20.40.60.80.00.20.40.60.8Expected quantilesObserved quantiles0.00.20.40.60.81.01.20.00.51.01.52.02.53.0−log10(Expected quantiles)−log10(Observed quantiles)Schweder and Spjøtvoll (1982) the function uses a diﬀerent choice of axes
due to Benjamini and Hochberg (2000). We will use an example dataset on
the validity of student ratings quoted in Becker (1994). Figure 3a shows the
plot from schweder.

> schweder(validity)

schweder also oﬀers the possibility of drawing one of a number of straight
line summaries. The three possible straight line summaries are shown in
Figure 3b and are:

• the lowest slope line of Benjaimin and Hochberg which is drawn by

default as solid,

• a least squares line drawn passing through the point k + 1, 1 and using
a speciﬁed fraction of the points which is drawn by default as dotted,
• a line with user speciﬁed intercept and slope which is drawn by default

as dashed.

> schweder(validity, drawline = c("bh", "ls", "ab"),
+

ls.control = list(frac = 0.5), ab.control = list(a = 0, b = 0.01))

(a) Simple graph

(b) With lines

Figure 3: Output from schweder

4 The albatros plot

The albatros plot was introduced in Harrison et al. (2017) which should
be consulted for more details. Basically it consists of plotting a possibly

4

051015200.00.20.40.60.81.0Rank of pp051015200.00.20.40.60.81.0Rank of pptransformed sample size against the transformed p–values. The default is to
use √N for the y–axis and a log transformation for the x–axis. The scale
for the y-axis is user selectable. The original scale in the Stata version is
(log10 n)2 which is obtained by setting yscale to "classic". For small N the
default of "sqrt" is very similar to "classic". The plot also contains contours
of constant eﬀect size. A number of possible options are available for eﬀect
size type: correlation, standardised mean diﬀerence, and odds ratio.

> validity <- dat.metap$validity
> fit.v <- albatros(validity$p, validity$n,
+
+
+
+

axes = list(ylimit = c(1,200),

main = "Validity")

righttext = "Positive correlation"),

contours = list(type = "corr", contvals = c(0.25, 0.5, 0.8), ltys = 1:3),

lefttext = "Negative correlation",

Figure 4: Albatros plot from of the validity data

Figure 4 shows the result. Most of the points clearly correspond to positive
and substantial correlations although a few are in the opposite direction
although not far from the null p–value (0.5).

Of course if the actual eﬀect sizes are available it would be better to use one
of the conventional methods for meta–analysing them. Harrison et al. (2017)
outline possible use cases for this method even so.

If the studies come from diﬀerent groups one might use meta–regression with
a moderator for group membership if one had the eﬀect sizes. In the absence
of eﬀect sizes the albatros plot can display the points using diﬀerent symbols
for groups. This would enable a visual check on whether the groups diﬀered.

> data(dat.metap)
> zhang <- dat.metap$zhang

5

Validityp valueN1e−050.0010.01null0.050.0011e−05151020501002000.250.50.8Negative correlationPositive correlationcontours = list(type = "smd", contvals = c(0.25, 0.5, 1), ltys = 1:3),
plotpars = list(pchs = letters[unclass(zhang$phase)]),
axes = list(lefttext = "Favours control", righttext = "Favours exercise"),
main = "Zhang"

> fit.z <- albatros(zhang$p, zhang$n,
+
+
+
+
+ )
> legend(-4, 11, c("Acute", "Healing", "Healed"),
+
+ )

pch = c("a", "b", "c"), bg = "white"

Figure 5: Albatros plot of the Zhang et al data

Figure 5 shows an example using the Zhang et al data-set. The studies
involved come from three groups corresponding to three diﬀerent periods of
initiation of exercise. The points are labelled accordingly: "a" initiation
during the acute phase, "b" during the healing phase and "c" during the
healed phase. The diﬀerence between the groups is quite clear here. In fact
in Zhang et al. (2016) the results are handled with stratiﬁcation into three
separate analyses and meta–regression was not used.

If some studies had given eﬀect sizes but others did not then an albatros plot
with the points marked for group membership and with appropriate contour
lines would provide a visual check on whether the unavailable eﬀect sizes
were similar to the available ones.

References

B J Becker. Combining signiﬁcance levels. In H Cooper and L V Hedges, ed-
itors, A handbook of research synthesis, chapter 15, pages 215–235. Russell
Sage, New York, 1994.

6

aaaaaaabbbbbbbbcccccccZhangp valueN1e−050.0010.01null0.050.0011e−0420501000.250.51Favours controlFavours exerciseabcAcuteHealingHealedY Benjamini and Y Hochberg. On the adaptive control of the false disovery
rate in multiple testing with independent statistics. Journal of Educational
and Behavioral Statistics, 25:60–83, 2000.

S Harrison, H E Jones, R M Martin, S J Lewis, and J P T Higgins. The
albatros plot: A novel graphical tool for presenting the results of diversely
reported studies in a systematic review. Research Synthesis Methods, 8:
281–289, 2017.

T Schweder and E Spjøtvoll. Plots of p–values to evaluate many tests simul-

taneously. Biometrika, 69:493–502, 1982.

Y-M Zhang, Y Lu, D Yang, H-F Wu, Z-P Bian, J-D Xu, C-R Gu, L-S Wang,
and X-J Chen. The eﬀects of diﬀerent initiation time of exercise training on
left ventricular remodeling and cardiopulmonary rehabilitation in patients
with left ventricular dysfunction after myocardial infarction. Disability and
Rehabilitation, 38:268–276, 2016.

7

