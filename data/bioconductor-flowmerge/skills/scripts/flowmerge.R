# Code example from 'flowmerge' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
  ,fig.width=8,fig.height=6
)

## ----stage0-------------------------------------------------------------------
library(flowMerge)

## ----stage1-------------------------------------------------------------------
data(rituximab)
summary(rituximab)
flowClust.res <- flowClust(rituximab, varNames=c(colnames(rituximab)[1:2]), K=1:6,trans=1,nu.est=1,randomStart=20);

## ----stage2-------------------------------------------------------------------
plot(flowMerge:::BIC(flowClust.res),
main="BIC for 1 through 5 cluster flowClust solutions",xlab="K",ylab="BIC",type="o");
flowClust.maxBIC<-flowClust.res[[which.max(BIC(flowClust.res))]];

## ----stage3-------------------------------------------------------------------
flowClust.flowobj<-flowObj(flowClust.maxBIC,rituximab);
flowClust.merge<-merge(flowClust.flowobj,metric="entropy");
i<-fitPiecewiseLinreg(flowClust.merge);

## ----stage4-------------------------------------------------------------------
par(mfrow=c(2,2));
flowClust.mergeopt<-flowClust.merge[[i]];
plot(flowClust.res[[4]],data=rituximab,main="Max BIC solution");
plot(flowClust.res[[which.max(flowMerge:::ICL(flowClust.res))]],data=rituximab,main="Max ICL solution");
plot(flowClust.mergeopt,level=0.75,pch=20,main="Merged Solution");

## ----stage5-------------------------------------------------------------------
pop<-which(apply(apply(getEstimates(flowClust.mergeopt)$locations,2,function(x)order(x,decreasing=TRUE)==2),1,all));
lymphocytes<-split(flowClust.mergeopt,population=list("lymphocytes"=pop))$lymphocytes;
lymphocytes<-lymphocytes[,c(3,5)];
l.flowC<-flowClust(lymphocytes,varNames=c("FL1.H","FL3.H"),K=1:8,B=1000,B.init=100,tol=1e-5,tol.init=1e-2,randomStart=50,nu=4,nu.est=1,trans=1);

## ----stage6-------------------------------------------------------------------
par(mfrow=c(2,2));
l.flowO<-flowObj(l.flowC[[which.max(flowMerge:::BIC(l.flowC))]],lymphocytes);
plot(l.flowO,main="max BIC solution",new.window=F,pch=20,level=0.9);
plot(flowObj(l.flowC[[which.max(flowMerge:::ICL(l.flowC))]],lymphocytes),main="max ICL solution",new.window=F,pch=20,level=0.9);
l.flowM<-merge(l.flowO);
i<-fitPiecewiseLinreg(l.flowM,plot=T);
plot(l.flowM[[i]],new.window=F,main="Best Merged Solution",pch=20,level=0.9);

## ----stage7-------------------------------------------------------------------
require(Rgraphviz)
f<-ptree("l.flowM",fitPiecewiseLinreg(l.flowM));
par(mfrow=c(1,2))
f(1);
f(2);

