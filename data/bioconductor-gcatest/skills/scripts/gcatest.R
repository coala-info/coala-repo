# Code example from 'gcatest' vignette. See references/ for full tutorial.

## ----preamble,warning=F-------------------------------------------------------
library(lfa)
library(gcatest)
dim(sim_geno)
length(sim_trait)

## ----lfa----------------------------------------------------------------------
LF <- lfa(sim_geno, 3)
dim(LF)

## ----gcat---------------------------------------------------------------------
gcat_p <- gcat(sim_geno, LF, sim_trait)

## ----gcat2--------------------------------------------------------------------
gcat_p[1:5]

## ----fig1, fig.height=3-------------------------------------------------------
library(ggplot2)
dat <- data.frame(p = gcat_p[6:10000])
ggplot(dat, aes(p, after_stat(density))) + geom_histogram(binwidth=1/20) + theme_bw()

