Two-phase designs in epidemiology

Thomas Lumley

August 28, 2025

This document explains how to analyse case–cohort and two-phase case–control studies with
the “survey” package, using examples from http://faculty.washington.edu/norm/software.
html. Some of the examples were published by Breslow & Chatterjee (1999).

The data are relapse rates from the National Wilm’s Tumor Study (NWTS). Wilm’s Tumour
is a rare cancer of the kidney in children. Intensive treatment cures the majority of cases, but
prognosis is poor when the disease is advanced at diagnosis and for some histological subtypes.
The histological characterisation of the tumour is difficult, and histological group as determined
by the NWTS central pathologist predicts much better than determinations by local institution
pathologists. In fact, local institution histology can be regarded statistically as a pure surrogate
for the central lab histology.

In these examples we will pretend that the (binary) local institution histology determination
(instit) is avavailable for all children in the study and that the central lab histology (histol)
is obtained for a probability sample of specimens in a two-phase design. We treat the initial
sampling of the study as simple random sampling from an infinite superpopulation. We also
have data on disease stage, a four-level variable; on relapse; and on time to relapse.

Case–control designs

Breslow & Chatterjee (1999) use the NWTS data to illustrate two-phase case–control designs.
The data are available at http://faculty.washington.edu/norm/software.html in compressed
form; we first expand to one record per patient.

> library(survey)
> load(system.file("doc","nwts.rda",package="survey"))
> nwtsnb<-nwts
> nwtsnb$case<-nwts$case-nwtsb$case
> nwtsnb$control<-nwts$control-nwtsb$control
> a<-rbind(nwtsb,nwtsnb)
> a$in.ccs<-rep(c(TRUE,FALSE),each=16)
> b<-rbind(a,a)
> b$rel<-rep(c(1,0),each=32)
> b$n<-ifelse(b$rel,b$case,b$control)
> index<-rep(1:64,b$n)
> nwt.exp<-b[index,c(1:3,6,7)]
> nwt.exp$id<-1:4088

As we actually do know histol for all patients we can fit the logistic regression model with

full sampling to compare with the two-phase analyses

> glm(rel~factor(stage)*factor(histol), family=binomial, data=nwt.exp)

1

Call:

glm(formula = rel ~ factor(stage) * factor(histol), family = binomial,

data = nwt.exp)

Coefficients:

(Intercept)
-2.7066
factor(stage)3
0.7747

factor(stage)2
0.7679
factor(stage)4
1.0506
factor(histol)2 factor(stage)2:factor(histol)2
0.1477
factor(stage)4:factor(histol)2
1.2619

1.3104
factor(stage)3:factor(histol)2
0.5942

Degrees of Freedom: 4087 Total (i.e. Null);
Null Deviance:
Residual Deviance: 2943

AIC: 2959

3306

4080 Residual

The second phase sample consists of all patients with unfavorable histology as determined by
local institution pathologists, all cases, and a 20% sample of the remainder. Phase two is thus a
stratified random sample without replacement, with strata defined by the interaction of instit
and rel.

> dccs2<-twophase(id=list(~id,~id),subset=~in.ccs,
+
> summary(svyglm(rel~factor(stage)*factor(histol),family=binomial,design=dccs2))

strata=list(NULL,~interaction(instit,rel)),data=nwt.exp)

Call:
svyglm(formula = rel ~ factor(stage) * factor(histol), design = dccs2,

family = binomial)

Survey design:
twophase2(id = id, strata = strata, probs = probs, fpc = fpc,

subset = subset, data = data, pps = pps)

Coefficients:

Estimate Std. Error t value Pr(>|t|)

< 2e-16 ***

(Intercept)
factor(stage)2
factor(stage)3
factor(stage)4
factor(histol)2
factor(stage)2:factor(histol)2
factor(stage)3:factor(histol)2
factor(stage)4:factor(histol)2
---
Signif. codes: 0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

0.1288 -19.955
0.1979
0.2032
0.2592
0.3107
0.4410
0.4241
0.6214

-2.5701
0.5482
0.4791
1.0037
1.3505
0.1152
0.5066
0.9785

2.769 0.005708 **
2.359 0.018515 *
3.872 0.000114 ***
4.346 1.51e-05 ***
0.261 0.793876
1.194 0.232548
1.575 0.115615

(Dispersion parameter for binomial family taken to be 1.000876)

Number of Fisher Scoring iterations: 4

2

Disease stage at the time of surgery is also recorded. It could be used to further stratify the
sampling, or, as in this example, to post-stratify. We can analyze the data either pretending
that the sampling was stratified or using calibrate to post-stratify the design.

> dccs8<-twophase(id=list(~id,~id),subset=~in.ccs,
+
> gccs8<-calibrate(dccs2,phase=2,formula=~interaction(instit,stage,rel))
> summary(svyglm(rel~factor(stage)*factor(histol),family=binomial,design=dccs8))

strata=list(NULL,~interaction(instit,stage,rel)),data=nwt.exp)

Call:
svyglm(formula = rel ~ factor(stage) * factor(histol), design = dccs8,

family = binomial)

Survey design:
twophase2(id = id, strata = strata, probs = probs, fpc = fpc,

subset = subset, data = data, pps = pps)

Coefficients:

Estimate Std. Error t value Pr(>|t|)
-2.71604
(Intercept)
0.78141
factor(stage)2
0.80093
factor(stage)3
1.07293
factor(stage)4
factor(histol)2
1.45836
factor(stage)2:factor(histol)2 -0.04743
0.28064
factor(stage)3:factor(histol)2
factor(stage)4:factor(histol)2
0.90983
---
Signif. codes: 0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

0.10827 -25.085
0.14726
0.15250
0.17817
0.31780
0.43495
0.41298
0.63774

< 2e-16 ***
5.306 1.35e-07 ***
5.252 1.80e-07 ***
6.022 2.33e-09 ***
4.589 4.96e-06 ***

-0.109
0.680
1.427

0.913
0.497
0.154

(Dispersion parameter for binomial family taken to be 1.000876)

Number of Fisher Scoring iterations: 4

> summary(svyglm(rel~factor(stage)*factor(histol),family=binomial,design=gccs8))

Call:
svyglm(formula = rel ~ factor(stage) * factor(histol), design = gccs8,

family = binomial)

Survey design:
calibrate(dccs2, phase = 2, formula = ~interaction(instit, stage,

rel))

Coefficients:

(Intercept)
factor(stage)2
factor(stage)3
factor(stage)4
factor(histol)2

Estimate Std. Error t value Pr(>|t|)
-2.71604
0.78141
0.80093
1.07293
1.45836

0.10878 -24.968
0.14729
0.15212
0.17905
0.31757

< 2e-16 ***
5.305 1.35e-07 ***
5.265 1.68e-07 ***
5.993 2.77e-09 ***
4.592 4.88e-06 ***

3

factor(stage)2:factor(histol)2 -0.04743
0.28064
factor(stage)3:factor(histol)2
factor(stage)4:factor(histol)2
0.90983
---
Signif. codes: 0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

0.43432
0.41231
0.63187

-0.109
0.681
1.440

0.913
0.496
0.150

(Dispersion parameter for binomial family taken to be 1.000876)

Number of Fisher Scoring iterations: 4

Case–cohort designs

In the case–cohort design for survival analysis, a P % sample of a cohort is taken at recruitment
for the second phase, and all participants who experience the event (cases) are later added to
the phase-two sample.

Viewing the sampling design as progressing through time in this way, as originally proposed,
gives a double sampling design at phase two. It is simpler to view the process sub specie ae-
ternitatis, and to note that cases are sampled with probability 1, and controls with probability
P/100. The subcohort will often be determined retrospectively rather than at recruitment, giv-
ing stratified random sampling without replacement, stratified on case status. If the subcohort is
determined prospectively we can use the same analysis, post-stratifying rather than stratifying.
There have been many analyses proposed for the case–cohort design (Therneau & Li, 1999).
We consider only those that can be expressed as a Horvitz–Thompson estimator for the Cox
model.

First we load the data and the necessary packages. The version of the NWTS data that

includes survival times is not identical to the data set used for case–control analyses above.

> library(survey)
> library(survival)
> data(nwtco)
> ntwco<-subset(nwtco, !is.na(edrel))

Again, we fit a model that uses histol for all patients, to compare with the two-phase design

> coxph(Surv(edrel, rel)~factor(stage)+factor(histol)+I(age/12),data=nwtco)

Call:
coxph(formula = Surv(edrel, rel) ~ factor(stage) + factor(histol) +

I(age/12), data = nwtco)

factor(stage)2 0.66730
factor(stage)3 0.81737
factor(stage)4 1.15373
factor(histol)2 1.58389
0.06789
I(age/12)

z

coef exp(coef) se(coef)
1.94898 0.12156
2.26455 0.12077
3.16999 0.13490
4.87387
1.07025

p
5.490 4.03e-08
6.768 1.31e-11
< 2e-16
8.553
0.08869 17.859
< 2e-16
0.01492 4.549 5.39e-06

Likelihood ratio test=395.4
n= 4028, number of events= 571

on 5 df, p=< 2.2e-16

We define a two-phase survey design using simple random superpopulation sampling for the
first phase, and sampling without replacement stratified on rel for the second phase. The subset

4

argument specifies that observations are in the phase-two sample if they are in the subcohort
or are cases. As before, the data structure is rectangular, but variables measured at phase two
may be NA for participants not included at phase two.

We compare the result to that given by survival::cch for Lin & Ying’s (1993) approach to

the case–cohort design.

> (dcch<-twophase(id=list(~seqno,~seqno), strata=list(NULL,~rel),
+

subset=~I(in.subcohort | rel), data=nwtco))

Two-phase sparse-matrix design:

twophase2(id = id, strata = strata, probs = probs, fpc = fpc,

subset = subset, data = data, pps = pps)

Phase 1:
Independent Sampling design (with replacement)
svydesign(ids = ~seqno)
Phase 2:
Stratified Independent Sampling design
svydesign(ids = ~seqno, strata = ~rel, fpc = `*phase1*`)

> svycoxph(Surv(edrel,rel)~factor(stage)+factor(histol)+I(age/12),
+

design=dcch)

Call:
svycoxph(formula = Surv(edrel, rel) ~ factor(stage) + factor(histol) +

I(age/12), design = dcch)

coef exp(coef) se(coef) robust se

factor(stage)2 0.69266
factor(stage)3 0.62685
factor(stage)4 1.29951
factor(histol)2 1.45829
0.04609
I(age/12)

1.99902 0.22688
1.87171 0.22873
3.66751 0.25017
0.16844
4.29861
0.02732
1.04717

Likelihood ratio test=
n= 1154, number of events= 571

on 5 df, p=

z

p
0.16279 4.255 2.09e-05
0.16823 3.726 0.000194
0.18898 6.877 6.13e-12
0.14548 10.024 < 2e-16
2.002 0.045233
0.02302

> subcoh <- nwtco$in.subcohort
> selccoh <- with(nwtco, rel==1|subcoh==1)
> ccoh.data <- nwtco[selccoh,]
> ccoh.data$subcohort <- subcoh[selccoh]
> cch(Surv(edrel, rel) ~ factor(stage) + factor(histol) + I(age/12),
+
+

data =ccoh.data, subcoh = ~subcohort, id=~seqno,
cohort.size=4028, method="LinYing")

Case-cohort analysis,x$method, LinYing

with subcohort of 668 from cohort of 4028

Call: cch(formula = Surv(edrel, rel) ~ factor(stage) + factor(histol) +
I(age/12), data = ccoh.data, subcoh = ~subcohort, id = ~seqno,
cohort.size = 4028, method = "LinYing")

Coefficients:

5

Value

p
SE
4.252581 2.113204e-05
factor(stage)2 0.69265646 0.16287906
3.743260 1.816478e-04
factor(stage)3 0.62685179 0.16746144
6.849016 7.436052e-12
factor(stage)4 1.29951229 0.18973707
factor(histol)2 1.45829267 0.14429553 10.106291 0.000000e+00
2.066006 3.882790e-02
I(age/12)

0.04608972 0.02230861

Z

Barlow (1994) proposes an analysis that ignores the finite population correction at the second
phase. This simplifies the standard error estimation, as the design can be expressed as one-phase
stratified superpopulation sampling. The standard errors will be somewhat conservative. More
data preparation is needed for this analysis as the weights change over time.

> nwtco$eventrec<-rep(0,nrow(nwtco))
> nwtco.extra<-subset(nwtco, rel==1)
> nwtco.extra$eventrec<-1
> nwtco.expd<-rbind(subset(nwtco,in.subcohort==1),nwtco.extra)
> nwtco.expd$stop<-with(nwtco.expd,
+
> nwtco.expd$start<-with(nwtco.expd,
+
> nwtco.expd$event<-with(nwtco.expd,
+
> nwtco.expd$pwts<-ifelse(nwtco.expd$event, 1, 1/with(nwtco,mean(in.subcohort | rel)))

ifelse(rel & !eventrec, edrel-0.001,edrel))

ifelse(rel & eventrec, edrel-0.001, 0))

ifelse(rel & eventrec, 1, 0))

The analysis corresponds to a cluster-sampled design in which individuals are sampled strat-
ified by subcohort membership and then time periods are sampled stratified by event status.
Having individual as the primary sampling unit is necessary for correct standard error calcula-
tion.

> (dBarlow<-svydesign(id=~seqno+eventrec, strata=~in.subcohort+rel,
+

data=nwtco.expd, weight=~pwts))

Stratified 2 - level Cluster Sampling design (with replacement)
With (1154, 1239) clusters.
svydesign(id = ~seqno + eventrec, strata = ~in.subcohort + rel,

data = nwtco.expd, weight = ~pwts)

> svycoxph(Surv(start,stop,event)~factor(stage)+factor(histol)+I(age/12),
+

design=dBarlow)

Call:
svycoxph(formula = Surv(start, stop, event) ~ factor(stage) +

factor(histol) + I(age/12), design = dBarlow)

coef exp(coef) se(coef) robust se

z

p
0.16985 4.333 1.47e-05
0.17529 3.409 0.000651
0.20777 6.693 2.18e-11
0.16407 9.170 < 2e-16
0.02425 1.779 0.075191

factor(stage)2 0.73589
factor(stage)3 0.59763
factor(stage)4 1.39068
factor(histol)2 1.50450
0.04315
I(age/12)

2.08734 0.18571
1.81780 0.18876
4.01757 0.20500
0.13945
4.50191
0.02228
1.04410

Likelihood ratio test=
n= 1239, number of events= 571

on 5 df, p=

6

In fact, as the finite population correction is not being used the second stage of the cluster
sampling could be ignored. We can also produce the stratified bootstrap standard errors of
Wacholder et al (1989), using a replicate weights analysis

> (dWacholder <- as.svrepdesign(dBarlow,type="bootstrap",replicates=500))

Call: as.svrepdesign.default(dBarlow, type = "bootstrap", replicates = 500)
Survey bootstrap with 500 replicates.

> svycoxph(Surv(start,stop,event)~factor(stage)+factor(histol)+I(age/12),
+

design=dWacholder)

Call:
svycoxph.svyrep.design(formula = Surv(start, stop, event) ~ factor(stage) +

factor(histol) + I(age/12), design = dWacholder)

factor(stage)2 0.73589
factor(stage)3 0.59763
factor(stage)4 1.39068
factor(histol)2 1.50450
0.04315
I(age/12)

coef exp(coef) se(coef)

z

p
2.08734 0.17878 4.116 3.85e-05
1.81780 0.17220 3.471 0.000519
4.01757 0.21219 6.554 5.60e-11
0.17267 8.713
4.50191
< 2e-16
0.02661 1.622 0.104795
1.04410

Likelihood ratio test=NA
n= 1239, number of events= 571

on 5 df, p=NA

Exposure-stratified designs

Borgan et al (2000) propose designs stratified or post-stratified on phase-one variables. The
examples at http://faculty.washington.edu/norm/software.html use a different subcohort
sample for this stratified design, so we load the new subcohort variable

> load(system.file("doc","nwtco-subcohort.rda",package="survey"))
> nwtco$subcohort<-subcohort
> d_BorganII <- twophase(id=list(~seqno,~seqno),
+
+
> (b2<-svycoxph(Surv(edrel,rel)~factor(stage)+factor(histol)+I(age/12),
+

strata=list(NULL,~interaction(instit,rel)),
data=nwtco, subset=~I(rel |subcohort))

design=d_BorganII))

Call:
svycoxph(formula = Surv(edrel, rel) ~ factor(stage) + factor(histol) +

I(age/12), design = d_BorganII)

coef exp(coef) se(coef) robust se

p
z
0.01049
0.18087 2.559
0.17848 3.267
0.00109
0.20524 5.163 2.43e-07
0.13342 11.973 < 2e-16
0.36972
0.897
0.03337

factor(stage)2 0.46286
factor(stage)3 0.58309
factor(stage)4 1.05967
factor(histol)2 1.59744
0.02994
I(age/12)

1.58861 0.23762
1.79156 0.23965
2.88541 0.26182
0.17688
4.94035
0.02942
1.03039

Likelihood ratio test=
n= 1062, number of events= 571

on 5 df, p=

7

We can further post-stratify the design on disease stage and age with calibrate

> d_BorganIIps <- calibrate(d_BorganII, phase=2, formula=~age+interaction(instit,rel,stage))
> svycoxph(Surv(edrel,rel)~factor(stage)+factor(histol)+I(age/12),
+

design=d_BorganIIps)

Call:
svycoxph(formula = Surv(edrel, rel) ~ factor(stage) + factor(histol) +

I(age/12), design = d_BorganIIps)

coef exp(coef) se(coef) robust se

z

p
0.14263 4.698 2.63e-06
0.14228 5.337 9.45e-08
0.15176 8.371
< 2e-16
0.12999 12.101 < 2e-16
0.349
0.937
0.03346

factor(stage)2 0.67006
factor(stage)3 0.75935
factor(stage)4 1.27046
factor(histol)2 1.57302
0.03135
I(age/12)

1.95436 0.23776
2.13689 0.23952
3.56249 0.26150
0.17627
4.82121
0.02984
1.03185

Likelihood ratio test=
n= 1062, number of events= 571

on 5 df, p=

References

Barlow WE (1994). Robust variance estimation for the case-cohort design. Biometrics 50:
1064-1072

Borgan Ø, Langholz B, Samuelson SO, Goldstein L and Pogoda J (2000). Exposure stratified

case-cohort designs, Lifetime Data Analysis 6:39-58

Breslow NW and Chatterjee N. (1999) Design and analysis of two-phase studies with binary

outcome applied to Wilms tumour prognosis. Applied Statistics 48:457-68.

Lin DY, and Ying Z (1993). Cox regression with incomplete covariate measurements. Journal

of the American Statistical Association 88: 1341-1349.

Therneau TM and Li H., Computing the Cox model for case-cohort designs. Lifetime Data

Analysis 5:99-112, 1999

Wacholder S, Gail MH, Pee D, and Brookmeyer R (1989) Alternate variance and efficiency

calculations for the case-cohort design Biometrika, 76, 117-123

8

