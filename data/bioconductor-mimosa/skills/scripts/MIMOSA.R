# Code example from 'MIMOSA' vignette. See references/ for full tutorial.

## ----sims,eval=TRUE,echo=FALSE,fig.keep='high',message=FALSE,fig.width=7,fig.height=4----
suppressPackageStartupMessages(require(MIMOSA))
require(data.table)
set.seed(100)
effect.sizes.fold<-c(3,3,3)
NN<-c(80000,50000,40000)
Nobs<-rep(NN,3)
Nobs<-100000
pu<-rep(1e-4,3)
ps<-pu*effect.sizes.fold
As<-ps*Nobs
Bs<-(Nobs-As)
A0<-pu*Nobs
B0<-(Nobs-A0)

ANTIGEN.STIM<-c("ENV","GAG","POL")
ANTIGEN.UNSTIM<-c("negctrl","negctrl","negctrl")
CYTOKINE=c("IFNg","IFNg","IFNg")
Ncells<-NN
TCELLSUB=c("CD4")
obs<-100
Nobs<-NN
j<-1
ICS<-do.call(rbind,lapply(seq_along(Nobs),function(i){
sim<-MIMOSA:::simulate2(obs=obs,As=As[j],Bs=Bs[j],A0=A0[j],B0=B0[j],NS=NN[i],N0=NN[i],w2=0.5,alternative="greater")
stim<-sim[,c("Ns","ns")]
unstim<-sim[,c("Nu","nu")]
colnames(stim)<-c("NSUB","CYTNUM")
colnames(unstim)<-c("NSUB","CYTNUM")
df<-rbind(stim,unstim)
data.frame(df,ANTIGEN=gl(2,obs,labels=c(ANTIGEN.STIM[i],ANTIGEN.UNSTIM[i])),CYTOKINE=CYTOKINE[i],TCELLSUBSET=TCELLSUB[1],UID=rep(gl(obs,1),2))
}))
ICS<-cbind(ICS,Ntot=factor(ICS$NSUB+ICS$CYTNUM))
ICS$Stim<-factor(ICS$Ntot,labels=c("ENV","GAG","POL"))
ggplot(ICS)+geom_histogram(aes(x=CYTNUM,fill=(ANTIGEN%in%"negctrl")),alpha=0.5,position="identity")+facet_wrap(~Stim)+scale_fill_discrete("stimulation",labels=c("negctrl","Stim"))

## ----loaddata,message=FALSE,warning=FALSE,error=FALSE--------------------
require(MIMOSA)
head(ICS)

## ----Eset,mesage=FALSE,warning=FALSE,error=FALSE-------------------------
E<-ConstructMIMOSAExpressionSet(ICS,
                                reference=ANTIGEN%in%"negctrl",
                                measure.columns=c("CYTNUM","NSUB"),
                                other.annotations=c("CYTOKINE","TCELLSUBSET","ANTIGEN","UID","Ntot"),
                                default.cast.formula=component~UID+ANTIGEN+CYTOKINE+TCELLSUBSET+Ntot,
                                .variables=.(TCELLSUBSET,CYTOKINE,UID,Ntot),
                                featureCols=1,ref.append.replace="_REF")

## ----fit,tidy=FALSE,message=FALSE,results='hide',warning=FALSE-----------
set.seed(100)
result<-MIMOSA(NSUB+CYTNUM~UID+TCELLSUBSET+CYTOKINE+Ntot|ANTIGEN,
               data=E, method="EM")

## ----showz---------------------------------------------------------------
lapply(result,function(x)table(fdr(x)<0.01))
getW(result)

## ----volcanoplot---------------------------------------------------------
volcanoPlot(result,effect_expression=CYTNUM-CYTNUM_REF,facet_var=~ANTIGEN)

## ----rocfun,echo=FALSE---------------------------------------------------
ROC<-do.call(rbind,lapply(seq_along(result),function(i){
  stat<-fdr(result[[i]])
  truth<-gl(2,50)%in%2
  th<-seq(0,1,l=1000)
  tpr<-sapply(th,function(x){
    sum((stat<=x)[truth])
    })
  tpr<-tpr/sum(truth)
  fpr<-sapply(th,function(x){
    sum((stat<=x)[!truth])
  })
  fpr<-fpr/sum(!truth)
  data.frame(TPR=tpr,FPR=fpr,Ntot=names(result)[i])
}))

## ----roccurve------------------------------------------------------------
ggplot(ROC)+geom_line(aes(x=FPR,y=TPR,color=Ntot),lwd=1.5)+theme_bw()

## ----fisher,echo=FALSE---------------------------------------------------
ROC.fisher<-do.call(rbind,lapply(seq_along(result),function(j){
  p<-vector('numeric',100)
  for(i in 1:100){
    #Test that the unstimulated is less than the stimulated..
    p[i]<-fisher.test(matrix(countsTable(result[[j]])[i,],nrow=2,byrow=FALSE),alternative="less")$p
  }
  p<-p.adjust(p,"fdr")
   truth<-gl(2,50)%in%2
  th<-seq(0,1,l=1000)
  tpr<-sapply(th,function(x){
      sum((p<=x)[truth])
  })/sum(truth)
    fpr<-sapply(th,function(x){
      sum((p<=x)[!truth])
  })/sum(!truth)
  data.frame(TPR=tpr,FPR=fpr,Ntot=names(result)[j])
  }))
ROC<-cbind(rbind(ROC,ROC.fisher),Method=gl(2,3000,labels=c("MIMOSA","Fisher")))
ggplot(ROC)+geom_line(aes(x=FPR,y=TPR,color=Method),lwd=1.5)+facet_wrap(~Ntot)+theme_bw()

