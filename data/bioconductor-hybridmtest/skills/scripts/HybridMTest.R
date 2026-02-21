# Code example from 'HybridMTest' vignette. See references/ for full tutorial.

### R code from vignette source 'HybridMTest.Rnw'

###################################################
### code chunk number 1: options
###################################################
options(width=60)


###################################################
### code chunk number 2: LoadCorrelationData
###################################################
library(HybridMTest) 
data(correlation.data)
Y<-exprs(correlation.data)
x<-pData(correlation.data)

test.specs<-cbind.data.frame(label=c("pearson","spearman","shapiro"),
                             func.name=c("row.pearson","row.spearman","row.slr.shapiro"),
                             x=rep("x",3),
                             opts=rep("",3))

ebp.def<-cbind.data.frame(wght=c("shapiro.ebp","(1-shapiro.ebp)"),
                          mthd=c("pearson.ebp","spearman.ebp"))
corr.res<-hybrid.test(correlation.data,test.specs,ebp.def)
head(corr.res)


###################################################
### code chunk number 3: LoadComparisonData
###################################################
library(HybridMTest) 
data(GroupComp.data)
brain.express.set <- exprs(GroupComp.data)
brain.pheno.data  <- pData(GroupComp.data)
 brain.express.set[1:5, 1:8]
  head(brain.pheno.data) 

test.specs<-cbind.data.frame(label=c("anova","kw","shapiro"),
                             func.name=c("row.oneway.anova","row.kruskal.wallis","row.kgrp.shapiro"),
                             x=rep("grp",3),
                             opts=rep("",3))

ebp.def<-cbind.data.frame(wght=c("shapiro.ebp","(1-shapiro.ebp)"),
                          mthd=c("anova.ebp","kw.ebp"))

Kgrp.res<-hybrid.test(GroupComp.data,test.specs,ebp.def)

head(Kgrp.res)



