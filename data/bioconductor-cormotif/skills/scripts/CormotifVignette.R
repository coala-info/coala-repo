# Code example from 'CormotifVignette' vignette. See references/ for full tutorial.

### R code from vignette source 'CormotifVignette.Rnw'

###################################################
### code chunk number 1: CormotifVignette.Rnw:44-50
###################################################
library(Cormotif)
data(simudata2)
colnames(simudata2)
exprs.simu2<-as.matrix(simudata2[,2:25])
data(simu2_groupid)
simu2_groupid


###################################################
### code chunk number 2: CormotifVignette.Rnw:56-58
###################################################
data(simu2_compgroup)
simu2_compgroup


###################################################
### code chunk number 3: CormotifVignette.Rnw:65-67
###################################################
motif.fitted<-cormotiffit(exprs.simu2,simu2_groupid,simu2_compgroup,
			 K=1:5,max.iter=1000,BIC=TRUE)


###################################################
### code chunk number 4: CormotifVignette.Rnw:71-73
###################################################
motif.fitted$bic
plotIC(motif.fitted)


###################################################
### code chunk number 5: CormotifVignette.Rnw:77-78
###################################################
plotIC(motif.fitted)


###################################################
### code chunk number 6: CormotifVignette.Rnw:91-92
###################################################
plotMotif(motif.fitted)


###################################################
### code chunk number 7: CormotifVignette.Rnw:98-99
###################################################
head(motif.fitted$bestmotif$p.post)


###################################################
### code chunk number 8: CormotifVignette.Rnw:104-106
###################################################
dif.pattern.simu2<-(motif.fitted$bestmotif$p.post>0.5)
head(dif.pattern.simu2)


###################################################
### code chunk number 9: CormotifVignette.Rnw:111-113
###################################################
topgenelist<-generank(motif.fitted$bestmotif$p.post)
head(topgenelist)


###################################################
### code chunk number 10: CormotifVignette.Rnw:118-119
###################################################
misprop<-0.10


###################################################
### code chunk number 11: CormotifVignette.Rnw:123-130
###################################################
fullindex<-1:nrow(exprs.simu2)
##sample index to mimic the merging of studies from different platforms
mis_index1<-sample(fullindex,misprop*length(fullindex))
mis_index2<-sample(fullindex[-mis_index1],misprop*length(fullindex))
exprs.simu2.missing<-exprs.simu2
exprs.simu2.missing[mis_index1,1:12]<-NA
exprs.simu2.missing[mis_index2,13:24]<-NA


###################################################
### code chunk number 12: CormotifVignette.Rnw:134-138
###################################################
motif.fitted.missing<-cormotiffit(exprs.simu2.missing,simu2_groupid,simu2_compgroup,
				  K=1:5,max.iter=1000,BIC=TRUE)
plotIC(motif.fitted.missing)
plotMotif(motif.fitted.missing)


###################################################
### code chunk number 13: CormotifVignette.Rnw:141-142
###################################################
plotIC(motif.fitted.missing)


###################################################
### code chunk number 14: CormotifVignette.Rnw:148-149
###################################################
plotMotif(motif.fitted.missing)


###################################################
### code chunk number 15: CormotifVignette.Rnw:163-164
###################################################
motif.fitted.all<-cormotiffitall(exprs.simu2,simu2_groupid,simu2_compgroup,max.iter=1)


###################################################
### code chunk number 16: CormotifVignette.Rnw:171-172
###################################################
motif.fitted.sep<-cormotiffitsep(exprs.simu2,simu2_groupid,simu2_compgroup,max.iter=1)


###################################################
### code chunk number 17: CormotifVignette.Rnw:177-178
###################################################
motif.fitted.full<-cormotiffitfull(exprs.simu2,simu2_groupid,simu2_compgroup,max.iter=1)


