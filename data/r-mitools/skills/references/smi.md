Combining multiple imputations

Thomas Lumley

April 26, 2019

Carlin et al. (2003) illustrate the use of their Stata texttt for multiple
imputations with data from a cohort study of adolescent health. Five sets
of imputations were done, separately for male and female participants. The
resulting datasets are in mitools/dta.

First we read all the datasets into R, using read.dta from the foreign

package.

> library(mitools)
> data.dir<-system.file("dta",package="mitools")
> ## read in data
> library(foreign)
> women<-imputationList(lapply(list.files(data.dir,
+
+
> men<-imputationList(lapply(list.files(data.dir,
+
+

pattern="f.\\.dta",full=TRUE),

read.dta, warn.missing.labels=FALSE))

pattern="m.\\.dta",full=TRUE),

read.dta, warn.missing.labels=FALSE))

We now combine the imputations for men and women, ﬁrst deﬁning a

sex variable

> ## add sex variable
> women<-update(women,sex=0)
> men<-update(men, sex=1)
> ## combine two sets of imputations
> all<-rbind(women,men)
> all

1

MI data with 5 datasets
Call: rbind(deparse.level, ...)

> colnames(all)

[1] "id"
[7] "alcdhi" "smk"

"wave"

"mmetro" "parsmk" "drkfre" "alcdos"
"cistot" "mdrkfre" "sex"

Now tabulate drinking frequency by sex

> with(all, table(sex, drkfre))

[[1]]

drkfre

sex Non drinker not in last wk <3 days last wk >=3 days last wk
12
35

201
194

282
207

105
134

0
1

[[2]]

drkfre

sex Non drinker not in last wk <3 days last wk >=3 days last wk
14
38

195
200

282
200

109
132

0
1

[[3]]

drkfre

sex Non drinker not in last wk <3 days last wk >=3 days last wk
11
36

202
194

278
209

109
131

0
1

[[4]]

drkfre

sex Non drinker not in last wk <3 days last wk >=3 days last wk
14
33

188
206

284
203

114
128

0
1

[[5]]

drkfre

sex Non drinker not in last wk <3 days last wk >=3 days last wk

2

0
1

288
206

191
192

109
136

12
36

attr(,"call")
with(all, table(sex, drkfre))

and deﬁne a new ‘regular drinking’ variables.

> all<-update(all, drkreg=as.numeric(drkfre)>2)
> ## tables
> with(all, table(sex, drkreg))

[[1]]

drkreg

sex FALSE TRUE
483 117
401 169

0
1

[[2]]

drkreg

sex FALSE TRUE
477 123
400 170

0
1

[[3]]

drkreg

sex FALSE TRUE
480 120
403 167

0
1

[[4]]

drkreg

sex FALSE TRUE
472 128
409 161

0
1

[[5]]

drkreg

sex FALSE TRUE

3

0
1

479 121
398 172

attr(,"call")
with(all, table(sex, drkreg))

We can now ﬁt a logistic regression model for trends over time in drinking:

> ## logistic regression model
> model1<-with(all, glm(drkreg~wave*sex, family=binomial()))
> MIcombine(model1)

Multiple imputation results:

with(all, glm(drkreg ~ wave * sex, family = binomial()))
MIcombine.default(model1)

results

se
(Intercept) -2.25974358 0.26830731
0.24055250 0.06587423
wave
0.64905222 0.34919264
sex
-0.03725422 0.08609199
wave:sex

> summary(MIcombine(model1))

Multiple imputation results:

with(all, glm(drkreg ~ wave * sex, family = binomial()))
MIcombine.default(model1)

results

se

(lower

(Intercept) -2.25974358 0.26830731 -2.78584855 -1.7336386
0.24055250 0.06587423 0.11092461 0.3701804
wave
0.64905222 0.34919264 -0.03537187 1.3334763
sex
-0.03725422 0.08609199 -0.20623121 0.1317228
wave:sex

upper) missInfo
4 %
12 %
1 %
7 %

For model objects with coef and vcov methods the extraction of coeﬃ-

cients and variances is automatic, but MIextract can still be used:

> beta<-MIextract(model1, fun=coef)
> vars<-MIextract(model1, fun=vcov)
> summary(MIcombine(beta,vars))

4

Multiple imputation results:

MIcombine.default(beta, vars)

results

se

(lower

(Intercept) -2.25974358 0.26830731 -2.78584855 -1.7336386
0.24055250 0.06587423 0.11092461 0.3701804
wave
0.64905222 0.34919264 -0.03537187 1.3334763
sex
-0.03725422 0.08609199 -0.20623121 0.1317228
wave:sex

upper) missInfo
4 %
12 %
1 %
7 %

References

Carlin JB, Li N, Greenwood P, Coﬀey C. (2003) Tools for analyzing multiply
imputed datasets. Stata Journal 3:1–20.

5

