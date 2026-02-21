# Code example from 'coGPS' vignette. See references/ for full tutorial.

### R code from vignette source 'coGPS.Rnw'

###################################################
### code chunk number 1: loading
###################################################
library(coGPS)
data(Exon_exprs_matched)
data(Methy_exprs_matched)
data(CNV_exprs_matched)
data(Exon_classlab_matched)
data(Methy_classlab_matched)
data(CNV_classlab_matched)
head(Exon_exprs_matched[,1:5])
head(Methy_exprs_matched[,1:5])
head(CNV_exprs_matched[,1:5])


###################################################
### code chunk number 2: transforming
###################################################
#exprslist[[i]]$exprs should be in matrix format
Exon_exprs<-as.matrix(Exon_exprs_matched)
Methy_exprs<-as.matrix(Methy_exprs_matched)
CNV_exprs<-as.matrix(CNV_exprs_matched)

#exprslist[[i]]$classlab should be in vector format
Exon_classlab<-unlist(Exon_classlab_matched)
Methy_classlab<-unlist(Methy_classlab_matched)
CNV_classlab<-unlist(CNV_classlab_matched)

#make an exprslist consisting 3 studies
trylist<-list()
trylist[[1]]<-list(exprs=Exon_exprs,classlab=Exon_classlab)
trylist[[2]]<-list(exprs=Methy_exprs,classlab=Methy_classlab)
trylist[[3]]<-list(exprs=CNV_exprs,classlab=CNV_classlab)


###################################################
### code chunk number 3: subtypeanalysis
###################################################
a7<-PCOPA(trylist,0.05,side=c("up","down","up"),type="subtype")


###################################################
### code chunk number 4: uniformanalysis
###################################################
a8<-PCOPA(trylist,0.05,side=c("up","down","up"),type="uniform")


###################################################
### code chunk number 5: plotPCOPA
###################################################
PlotTopPCOPA(trylist,a8,topcut=1,typelist=c("Exon","Methy","CNV"))


###################################################
### code chunk number 6: coGPS.Rnw:195-196
###################################################
PlotTopPCOPA(trylist,a8,topcut=1,typelist=c("Exon","Methy","CNV"))


###################################################
### code chunk number 7: permutation
###################################################
perma7<-permCOPA(trylist,0.05,side=c("up","down","up"),type="subtype",perms=2)


###################################################
### code chunk number 8: pvaluecal1
###################################################
pvaluea7<-sapply(1:length(a7),function(i) 
	length(which(perma7[i,]>a7[i]))/ncol(perma7))


###################################################
### code chunk number 9: pvaluecal2
###################################################
dista7<-as.vector(perma7)
pvaluea7<-sapply(1:length(a7),function(i) 
	length(which(dista7>a7[i]))/length(dista7))


###################################################
### code chunk number 10: GSA
###################################################
library(limma)
data(human_c1)
genename<-rownames(Exon_exprs)
test_set1_a7<-rep(1,length(Hs.gmtl.c1))
for(i in 1:length(Hs.gmtl.c1))
{
	set<-Hs.gmtl.c1[[i]]
 	matched<-match(genename,set)
	index<-is.na(matched)==FALSE
	if(sum(as.numeric(index))>0)
	{
		test_set1_a7[i]<-wilcoxGST(index,a7)
	}
	else
	{
		test_set1_a7[i]<-NA
	}
}


###################################################
### code chunk number 11: PatientSpecific
###################################################
IndividualList7<-PatientSpecificGeneList(trylist,0.05,side=c("down","up","down"),
type="subtype",TopGeneNum=100)


###################################################
### code chunk number 12: Patient1
###################################################
IndividualList7[[1]]


###################################################
### code chunk number 13: patient7
###################################################
IndividualList7[[33]]


