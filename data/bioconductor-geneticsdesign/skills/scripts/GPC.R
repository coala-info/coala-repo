# Code example from 'GPC' vignette. See references/ for full tutorial.

### R code from vignette source 'GPC.Rnw'

###################################################
### code chunk number 1: GPC.Rnw:58-59
###################################################
library(GeneticsDesign)


###################################################
### code chunk number 2: GPC.Rnw:63-79
###################################################
set1<-seq(from=0.1, to=0.5, by=0.1)
set2<-c(1.25, 1.5, 1.75, 2.0)
len1<-length(set1)
len2<-length(set2)
mat<-matrix(0, nrow=len1, ncol=len2)
rownames(mat)<-paste("MAF=", set1, sep="")
colnames(mat)<-paste("RRAA=", set2, sep="")
for(i in 1:len1)
{ a<-set1[i]
  for(j in 1:len2)
  { b<-set2[j]
    res<-GPC.default(pA=a,pD=0.1,RRAa=(1+b)/2, RRAA=b, Dprime=1,pB=a, quiet=T)
    mat[i,j]<-res$power
  }
}
print(round(mat,3))


