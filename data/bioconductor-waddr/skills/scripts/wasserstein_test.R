# Code example from 'wasserstein_test' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(waddR)

spec.output<-c("pval","d.wass^2","perc.loc","perc.size","perc.shape")

## ----diff_loc-----------------------------------------------------------------
set.seed(24)
ctrl<-rnorm(300,0,1)
dd1<-rnorm(300,1,1)
set.seed(32)
wasserstein.test(ctrl,dd1,method="SP",permnum=10000)[spec.output]
wasserstein.test(ctrl,dd1,method="ASY")[spec.output]

## ----diff_size----------------------------------------------------------------
set.seed(24)
ctrl<-rnorm(300,0,1)
dd2<-rnorm(300,0,2)
set.seed(32)
wasserstein.test(ctrl,dd2)[spec.output]
wasserstein.test(ctrl,dd2,method="ASY")[spec.output]

## ----diff_shape---------------------------------------------------------------
set.seed(24)
ctrl<-rnorm(300,6.5,sqrt(13.25))
sam1<-rnorm(300,3,1)
sam2<-rnorm(300,10,1)
dd3<-sapply(1:300, 
              function(n) {
                sample(c(sam1[n],sam2[n]),1,prob=c(0.5, 0.5))})
set.seed(32)                
wasserstein.test(ctrl,dd3)[spec.output]
wasserstein.test(ctrl,dd3,method="ASY")[spec.output]

## ----no_diff------------------------------------------------------------------
set.seed(24)
ctrl<-rnorm(300,0,1)
nodd<-rnorm(300,0,1)
set.seed(32)
wasserstein.test(ctrl,nodd)[spec.output]
wasserstein.test(ctrl,nodd,method="ASY")[spec.output]

## ----session-info-------------------------------------------------------------
sessionInfo()

