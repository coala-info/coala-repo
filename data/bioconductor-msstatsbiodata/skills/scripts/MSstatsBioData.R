# Code example from 'MSstatsBioData' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'-------------------------------
BiocStyle::markdown()

## ----global_options, include=FALSE--------------------------------------------------------------------------
knitr::opts_chunk$set(fig.width=10, fig.height=7, warning=FALSE, message=FALSE)
options(width=110)

## -----------------------------------------------------------------------------------------------------------
## load package
require(MSstatsBioData)

## require SRM_yeast data
data(SRM_yeast)
## look at first lines
head(SRM_yeast)

## -----------------------------------------------------------------------------------------------------------
## Example of using MSstats for differential abundance analysis.
require(MSstats)
input.proposed <- dataProcess(SRM_yeast, 
                            summaryMethod="TMP",
                            cutoffCensored="minFeature", 
                            censoredInt="0", 
                            MBimpute=TRUE,
                            maxQuantileforCensored=0.999)

## -----------------------------------------------------------------------------------------------------------
## set up the comparison that you want.
comparison1<-matrix(c(-1,1,0,0,0,0,0,0,0,0),nrow=1)
comparison2<-matrix(c(-1,0,1,0,0,0,0,0,0,0),nrow=1)
comparison3<-matrix(c(-1,0,0,1,0,0,0,0,0,0),nrow=1)
comparison4<-matrix(c(-1,0,0,0,1,0,0,0,0,0),nrow=1)
comparison5<-matrix(c(-1,0,0,0,0,1,0,0,0,0),nrow=1)
comparison6<-matrix(c(-1,0,0,0,0,0,1,0,0,0),nrow=1)
comparison7<-matrix(c(-1,0,0,0,0,0,0,1,0,0),nrow=1)
comparison8<-matrix(c(-1,0,0,0,0,0,0,0,1,0),nrow=1)
comparison9<-matrix(c(-1,0,0,0,0,0,0,0,0,1),nrow=1)

comparison <- rbind(comparison1,comparison2,comparison3,
                    comparison4,comparison5,comparison6,
                    comparison7,comparison8,comparison9)
row.names(comparison) <- c("T2-T1","T3-T1","T4-T1",
                            "T5-T1","T6-T1","T7-T1",
                            "T8-T1","T9-T1","T10-T1")

## -----------------------------------------------------------------------------------------------------------
## test between comparison you set up.
output.comparison <- groupComparison(contrast.matrix=comparison, 
                            data=input.proposed)

## output.comparison$ComparisonResult include the result of testing.
head(output.comparison$ComparisonResult)

