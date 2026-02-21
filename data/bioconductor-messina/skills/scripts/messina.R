# Code example from 'messina' vignette. See references/ for full tutorial.

## ----style-knitr, eval=TRUE, echo=FALSE, results="asis"--------------------
BiocStyle::latex()

## ----setup, include=FALSE, cache=FALSE-------------------------------------
library(knitr)
opts_chunk$set(out.width="0.7\\maxwidth",fig.align="center")

## ----class-loadlibs, message=FALSE-----------------------------------------
library(messina)
library(antiProfilesData)
data(apColonData)
apColonData

## ----class-prepdata--------------------------------------------------------
x = exprs(apColonData)
y = pData(apColonData)$SubType

sel = y %in% c("normal", "tumor")
x = x[,sel]
y = y[sel]

## ----class-fit-------------------------------------------------------------
fit.apColon = messina(x, y == "tumor", min_sens = 0.95, min_spec = 0.85, seed = 1234, silent = TRUE)

## ----class-show------------------------------------------------------------
fit.apColon

## ----class-plot------------------------------------------------------------
plot(fit.apColon, i = 1, plot_type = "point")

## ----class-ranked-plots,out.width="0.4\\maxwidth",fig.show="hold"----------
plot(fit.apColon, i = c(1,2,10,50), plot_type = "point")

## ----de-outlier-example,echo=FALSE-----------------------------------------
library(ggplot2)
temp.x = rep(c(0, 1), each = 6)
set.seed(12345)
temp.y = c(rnorm(6, 4, 0.5), rnorm(1, 4, 0.5), rnorm(5, 9, 0.5))
temp.data = data.frame(y = temp.y, x = 1:length(temp.y), Group = factor(ifelse(temp.x, "Cancer", "Normal")))
ggplot(temp.data, aes(y = y, x = x, fill = Group)) + geom_bar(stat = "identity") + ggtitle("Example of outlier expression") + xlab("Sample") + ylab("Expression in Sample") + theme(axis.text.x = element_blank(), axis.ticks.x = element_blank(), axis.text.y = element_blank())

## ----surv-load-------------------------------------------------------------
library(messina)
library(survival)
data(tcga_kirc_example)

## The data are present as a matrix of expression values, and a Surv object of
## survival times
dim(kirc.exprs)
kirc.surv

## ----surv-fit--------------------------------------------------------------
fit.surv = messinaSurv(kirc.exprs, kirc.surv, obj_func = "tau", obj_min = 0.6, parallel = FALSE, silent = TRUE)

fit.surv

## ----surv-plot-------------------------------------------------------------
plot(fit.surv, bootstrap_type = "ci")

## ----sessionInfo, eval=TRUE------------------------------------------------
sessionInfo()

