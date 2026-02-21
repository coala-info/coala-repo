# Code example from 'ALDEx2_vignette' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("ALDEx2")

## ----eval=FALSE---------------------------------------------------------------
# install.packages("devtools")
# devtools::install_github("ggloor/ALDEx_bioc")

## ----basecode, eval=T, echo=F, message=F, error=F, warning=F------------------
# this is all the data generated once
# all other data will be displayed but not evaluated

##### RECODE THE SOURCE PRIOR TO PUSHING TO BIOCONDUCTOR
# devtools::load_all('~/Documents/0_git/ALDEx_bioc')
library(ALDEx2)
set.seed(11)

#### BASIC ALDEx2
#subset only the last 400 features for efficiency
data(selex)
selex.sub <- selex[1200:1600,]
conds <- c(rep("NS", 7), rep("S", 7))
x.aldex <- aldex(selex.sub, conds, mc.samples=16, test="t", effect=TRUE, 
  include.sample.summary=FALSE, denom="all", verbose=FALSE, paired.test=FALSE, gamma=NULL)

# using the individual functions
# this is the un-scaled version
x <- aldex.clr(selex.sub, conds, mc.samples=16, denom="all", verbose=F, gamma=1e-3)
x.tt <- aldex.ttest(x, hist.plot=F, paired.test=FALSE, verbose=FALSE)
x.effect <- aldex.effect(x, CI=T, verbose=F, include.sample.summary=F, 
  paired.test=FALSE)
x.all <- data.frame(x.tt,x.effect)

# glm example
covariates <- data.frame("A" = sample(0:1, 14, replace = TRUE),
   "B" = c(rep(0, 7), rep(1, 7)))
mm <- model.matrix(~ A + B, covariates)

# replace the conditions vector with the mm
# data in glm and tt should be identical
x.glm <- x
x.glm@conds <- mm
glm.test <- aldex.glm(x.glm, mm, fdr.method='holm')
glm.eff<- aldex.glm.effect(x.glm)

# now add scale
x.u <- x
x.u.e <- x.effect

# scaled
x.s <- aldex.clr(selex.sub, conds, mc.samples=16, gamma=1, verbose=FALSE)
x.s.e <- aldex.effect(x.s, CI=T)
x.s.tt <- aldex.ttest(x.s)
x.s.all <- cbind(x.s.e, x.s.tt)


## ----echo=T, eval=F-----------------------------------------------------------
# library(ALDEx2)
# #subset only the last 400 features for efficiency
# data(selex)
# selex.sub <- selex[1200:1600,]
# conds <- c(rep("NS", 7), rep("S", 7))
# x.aldex <- aldex(selex.sub, conds, mc.samples=16, test="t", effect=TRUE,
#   include.sample.summary=FALSE, denom="all", verbose=FALSE, paired.test=FALSE, gamma=NULL)

## ----three-plots, echo=T, message=F, error=F, warning=F, fig.cap="MA, Effect and Volcano plots of ALDEx2 output. The left panel is an Bland-Altman or MA plot that shows the relationship between (relative) Abundance and Difference. The middle panel is an effect plot that shows the relationship between Difference and Dispersion; the lines are equal difference and dispersion. The right hand plot is a volcano plot; the lines represent a posterior predictive p-value of 0.001 and 1.5 fold difference. In all plots features that are not significant are in grey or black. Features that are statistically significant are in red. The log-ratio abundance axis is the clr value for the feature."----


# note default is FDR of 0.05
par(mfrow=c(1,3))
aldex.plot(x.aldex, type="MA", test="welch", xlab="Log-ratio abundance",
    ylab="Difference", main='Bland-Altman plot')
aldex.plot(x.aldex, type="MW", test="welch", xlab="Dispersion",
    ylab="Difference", main='Effect plot')
aldex.plot(x.aldex, type="volcano", test="welch", xlab="Difference",
    ylab="-1(log10(q))", main='Volcano plot') 

## ----echo=T, eval=F, fig.cap="First load the libraries and the data."---------
# 
# data(selex)
# #subset only the last 400 features for efficiency
# selex.sub <- selex[1200:1600,]
# conds <- c(rep("NS", 7), rep("S", 7))
# x <- aldex.clr(selex.sub, conds, mc.samples=16, denom="all", verbose=F, gamma=1e-3)
# x.tt <- aldex.ttest(x, hist.plot=F, paired.test=FALSE, verbose=FALSE,)
# x.effect <- aldex.effect(x, CI=T, verbose=F, include.sample.summary=F,
#   paired.test=FALSE, glm.conds=NULL, useMC=F)
# x.all <- data.frame(x.tt,x.effect)
# par(mfrow=c(1,2))
# aldex.plot(x.all, type="MA", test="welch")
# aldex.plot(x.all, type="MW", test="welch")
# 

## ----echo=T, eval=F, message=F, error=F, warning=F, results="hide", fig.cap="the output is in the S3 object 'x'."----
# x <- aldex.clr(selex.sub, conds, mc.samples=16, verbose=F, gamma=1e-3)

## ----echo=TRUE, eval=F, results="hide", fig.cap="the output is a dataframe x.tt"----
# x.tt <- aldex.ttest(x, hist.plot=F, paired.test=FALSE, verbose=FALSE)

## ----echo=T, eval=F, results="hide",fig.cap="the output is a dataframe x.effect"----
# x.effect <- aldex.effect(x, CI=T, verbose=F, include.sample.summary=F,
#   paired.test=FALSE)

## ----three2-plots,fig=TRUE,echo=TRUE,width=7,height=4, fig.cap="Output from aldex.plot function. The left panel is the MA plot, the right is the MW (effect) plot. In both plots red represents features called as differentially abundant with q $<0.05$; grey are abundant, but not differentially abundant; black are rare, but not differentially abundant. This function uses the combined output from the aldex.ttest and aldex.effect functions above"----

# merge into one output for convenience
x.all <- data.frame(x.tt,x.effect)

par(mfrow=c(1,3))
aldex.plot(x.all, type="MA", test="welch", main='MA plot')
aldex.plot(x.all, type="MW", test="welch", main='effect plot')
aldex.plot(x.all, type="volcano", test="welch", main='volcano plot')

## ----plot-feature,fig=TRUE,echo=TRUE,width=7,height=4, fig.cap="Output from aldex.plotFeature function. This plots the posterior distribution, the difference between and within distributions (dispersion) and the effect size distributions. The values reported are the medians of those distributions, but exploration shows that for all but the most separated parts, there is essentially always some overlap or uncertainty in the posteriors. "----

# merge into one output for convenience
# we start with the ouput from aldex.clr
# we provide the name of the row we wish to explore

aldex.plotFeature(x, 'S:E:G:D')


## ----CI,fig=TRUE,echo=FALSE,width=7,height=4, fig.cap="Comparing the mean effect with the 95\\% CI.  The left panel is MA plot, the right is the MW (effect) plot. In both plots red points indicate features that have an expected effect value of $>2$; those with a blue circle have the 95\\% CI that does not overlap 0; and grey are features that are not of interest. Both the raw effect size and the CI test exclude different features from being different. This plot uses only the output of the aldex.effect function. The grey lines in the effect plot show the effect=2 isopleth."----

sgn <- sign(x.effect$effect.low) == sign(x.effect$effect.high)
par(mfrow=c(1,2))
plot(x.effect$rab.all, x.effect$diff.btw, pch=19, cex=0.3, col="grey", xlab="Abundance", ylab="Difference", main="Bland-Altman")
points(x.effect$rab.all[abs(x.effect$effect) >=2], x.effect$diff.btw[abs(x.effect$effect) >=2], pch=19, cex=0.5, col="red")
points(x.effect$rab.all[sgn], x.effect$diff.btw[sgn], cex=0.7, col="blue")

plot(x.effect$diff.win, x.effect$diff.btw, pch=19, cex=0.3, col="grey",xlab="Dispersion", ylab="Difference", main="Effect")
points(x.effect$diff.win[abs(x.effect$effect) >=2], x.effect$diff.btw[abs(x.effect$effect) >=2], pch=19, cex=0.5, col="red")
points(x.effect$diff.win[sgn], x.effect$diff.btw[sgn], cex=0.7, col="blue")
abline(0,2, lty=2, col="grey")
abline(0,-2, lty=2, col="grey")

## ----echo=T, eval=F-----------------------------------------------------------
# 
# data(selex)
# selex.sub <- selex[1200:1600, ]
# covariates <- data.frame("A" = sample(0:1, 14, replace = TRUE),
#    "B" = c(rep(0, 7), rep(1, 7)),
#    "Z" = sample(c(1,2,3), 14, replace=TRUE))
# mm <- model.matrix(~ A + Z + B, covariates)
# x.glm <- aldex.clr(selex.sub, mm, mc.samples=4, denom="all", verbose=T)
# glm.test <- aldex.glm(x.glm, mm, fdr.method='holm')
# glm.eff<- aldex.glm.effect(x.glm)

## ----glm, fig=TRUE,echo=TRUE,width=7,height=4, message=F, error=F, warning=F, fig.cap="The glm output can be plotted with the aldex.glm.plot function. The values should be nearly identical to the t-test in the same dataset. Here we show an effect (MW) plot of the with significant expected p-values for variables output from the glm function with model B (actual study design groups) highlighted in red. This toy model shows how to use a generalized linear model within theALDEx2 framework. All values are the expected value of the test statistic."----

# NEW plot the glm.test and glm.eff data for particular contrasts
aldex.glm.plot(glm.test, eff=glm.eff, contrast='B', type='MW', test='fdr')

## ----echo=TRUE, eval=FALSE, results="hide"------------------------------------
# x.kw <- aldex.kw(x)

## ----echo=TRUE,eval=T, warning=F, message=F, fig.cap="Including scale uncertainty in the posterior model."----
set.seed(11)
data(selex)
selex.sub <- selex[1201:1600,]
conds <- c(rep("NS", 7), rep("S", 7))
# unscaled
x.u <- aldex.clr(selex.sub, conds, mc.samples=16, 
    gamma=1e-3, verbose=FALSE)
x.u.e <- aldex.effect(x.u, CI=T)

# scaled
# this represents and 8-fold difference in scale between groups
mu.mod <- c(rep(1,7), rep(8,7))
scale.model <- aldex.makeScaleMatrix(gamma=0.5, mu=mu.mod, conditions=conds, mc.samples=16, log=FALSE)
x.ss <- aldex.clr(selex.sub, conds, mc.samples=16, 
    gamma=scale.model, verbose=FALSE)
x.ss.e <- aldex.effect(x.ss, CI=T)
x.ss.tt <- aldex.ttest(x.ss)
x.ss.all <- cbind(x.ss.e, x.ss.tt)

## ----scale-pre, fig=TRUE,echo=TRUE,width=7,height=4, message=F, error=F, warning=F, fig.cap="The unscaled posterior distribution plot"----
aldex.plotFeature(x.u, 'S:D:S:D', pooledOnly=T)

## ----post-scale, fig=TRUE,echo=TRUE,width=7,height=4, message=F, error=F, warning=F, fig.cap="The scaled posterior distribution plot. Note the wider dispersion on the x axis"----
aldex.plotFeature(x.ss, 'S:D:S:D', pooledOnly=T)

## ----comp-scale, fig=T, echo=T, width=5, height=3, fig.cap="Comparing unscaled and scaled difference, dispersion and effect size."----
par(mfrow=c(1,3))
plot(x.u.e$diff.btw, x.ss.e$diff.btw, main='diff.btw', 
 xlab='unscaled diff', ylab='scaled diff', pch=19, col='red')
abline(0,1)
plot(x.u.e$diff.win, x.ss.e$diff.win, main='diff.win', 
 xlab='unscaled dispersion', ylab='scaled dispersion', pch=19, col='red')
abline(0,1)
plot(x.u.e$effect, x.ss.e$effect, main='effect size', 
 xlab='unscaled effect', ylab='scaled effect', pch=19, col='red')
abline(0,1)


## ----scale-CI, fig=TRUE,echo=TRUE,width=8,height=4, message=F, error=F, warning=F, fig.cap="Compare the unscaled and scaled plots. Here we see that adding scale uncertainty increases the dispersion with little effect on the difference. As a result, we increase our confidence in the reproducibility of the S:E:G:D feature, which has been shown to have in vitro enzymatic activity. In the third plot, which shows features with a BH valued less than 0.05, the S:E:G:D feature is the clear outlier."----

par(mfrow=c(1,3))
sgn.u <- sign(x.u.e$effect.low) == sign(x.u.e$effect.high)
sgn.s <- sign(x.ss.e$effect.low) == sign(x.ss.e$effect.high)

plot(x.u.e$diff.win, x.u.e$diff.btw, pch=19, cex=0.3,
   col="grey",xlab="Dispersion", ylab="Difference", 
  main="unscaled-CI", xlim=c(0.2,5), ylim=c(-2.5,10))
points(x.u.e$diff.win[abs(x.u.e$effect) >=2], x.u.e$diff.btw[abs(x.u.e$effect) >=2], pch=19, cex=0.5, 
   col="red")
points(x.u.e$diff.win[sgn.u], x.u.e$diff.btw[sgn.u], 
   cex=0.7, col="blue")
text(x.u.e['S:E:G:D', 'diff.win'], 
   x.u.e['S:E:G:D', 'diff.btw']-0.6, labels='S:E:G:D')
abline(0,2, lty=2, col="grey")
abline(0,-2, lty=2, col="grey")

plot(x.ss.e$diff.win, x.ss.e$diff.btw, pch=19, cex=0.3, col="grey",xlab="Dispersion", ylab="Difference", main="scaled-CI",
   xlim=c(0.2,5), ylim=c(-2.5,10))
points(x.ss.e$diff.win[abs(x.ss.e$effect) >=2], 
  x.ss.e$diff.btw[abs(x.ss.e$effect) >=2], pch=19, cex=0.5, col="red")
points(x.ss.e$diff.win[sgn.u], x.ss.e$diff.btw[sgn.u], cex=0.7, 
   col="blue")
text(x.ss.e['S:E:G:D', 'diff.win'], 
   x.ss.e['S:E:G:D', 'diff.btw']-0.6, labels='S:E:G:D')
abline(0,2, lty=2, col="grey")
abline(0,-2, lty=2, col="grey")

aldex.plot(x.ss.all, test='welch', main="scaled-BH", xlim=c(0.2,6))
abline(0,2, lty=2, col="grey")
abline(0,-2, lty=2, col="grey")
text(x.ss.all['S:E:G:D', 'diff.win'], 
   x.ss.all['S:E:G:D', 'diff.btw']-0.6, labels='S:E:G:D')


## ----eval=F, echo=TRUE,width=7,height=4, message=F, error=F, warning=F--------
# conds <- data.frame("A" = sample(0:1, 14, replace = TRUE),
#       "B" = c(rep(0, 7), rep(1, 7)))
# mm <- model.matrix(~ A + B, conds)
# x <- aldex.clr(selex, mm, mc.samples=4)
# glm.test <- aldex.glm(x)
# glm.eff <- aldex.glm.effect(x)

## ----fig=TRUE,echo=TRUE,fig.small=TRUE, fig.cap="Differential abundance in the selex dataset using the Welch's t-test or Wilcoxon rank test. Features identified by both tests shown in red. Features identified by only one test are shown in blue dots.  Non-significant features represent rare features if black and abundant features if grey dots."----

# identify which values are significant in both the t-test and glm tests
found.by.all <- which(x.all$we.eBH < 0.05 & x.all$wi.eBH < 0.05)

# identify which values are significant in fewer than all tests
found.by.one <- which(x.all$we.eBH < 0.05 | x.all$wi.eBH < 0.05)

# plot the within and between variation of the data
plot(x.all$diff.win, x.all$diff.btw, pch=19, cex=0.3, col=rgb(0,0,0,0.3),
 xlab="Dispersion", ylab="Difference")
points(x.all$diff.win[found.by.one], x.all$diff.btw[found.by.one], pch=19,
 cex=0.7, col=rgb(0,0,1,0.5))
points(x.all$diff.win[found.by.all], x.all$diff.btw[found.by.all], pch=19,
 cex=0.7, col=rgb(1,0,0,1))
abline(0,1,lty=2)
abline(0,-1,lty=2)

## ----scale, message=F, error=F, warning=F, fig.cap="Differential abundance in a synthetic dataset using different scale parameters for the clr calculation. In this data 2\\% of the features are modelled to be sparse in one group but not the other and a further 5\\% of the features are differentially abundant. Features determined to be different between two groups are shown in red. Features that are non-significant are in black. Lines of constant effect are drawn at 0, and  $\\pm$ 1."----

set.seed(11)
data(synth2)
# basic ALDEx2
blocks <- c(rep("N", 10),rep("S", 10))
x <- aldex.clr(synth2, blocks, gamma=NULL)
x.e <- aldex.effect(x)

# Add in asymmetry and scale variance
# gamma can be smaller for the same output dispersion
# in the full scale model built here
# make a base scale for group 1 and 2
mu.vec = c(log2(rep(1,10)), log2(rep(1.02,10)))
scale_samples <- aldex.makeScaleMatrix(gamma=0.25, mu=mu.vec, 
  conditions=blocks) 
  
xs <- aldex.clr(synth2, blocks, gamma=scale_samples)
xs.e <- aldex.effect(xs)

# Add in only scale variance with sd=1
xg <- aldex.clr(synth2, blocks, gamma=0.5)
xg.e <- aldex.effect(xg)


par(mfrow=c(1,3))
aldex.plot(x.e, test='effect', main='base', xlim=c(0.1,3))
text(1, 4, labels=paste('median diff =',round(median(x.e$diff.btw),3)))
aldex.plot(xg.e, test='effect', main='ratio=1, sd=0.5', xlim=c(0.1,3))
text(1.6, 4, labels=paste('median diff =',round(median(xg.e$diff.btw),3)))
aldex.plot(xs.e, test='effect', main='ratio=1.02:1, sd=0.5', xlim=c(0.1,3))
text(1.6, 4, labels=paste('median diff =',round(median(xs.e$diff.btw),3)))


## ----session------------------------------------------------------------------
sessionInfo()

