# Code example from 'runningSCANVIS' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
library(SCANVIS)
data(SCANVISexamples)
names(gen19)

## -----------------------------------------------------------------------------
head(gbm3)
gbm3.scn<-SCANVISscan(sj=gbm3,gen=gen19,Rcut=5,bam=NULL,samtools=NULL)
head(gbm3.scn)

## -----------------------------------------------------------------------------
head(gbm3.vcf)
gbm3.scnv<-SCANVISlinkvar(gbm3.scn,gbm3.vcf,gen19)
gbm3.scnv[10:23,]

## -----------------------------------------------------------------------------
gbm3.scnv[38:51,]

## -----------------------------------------------------------------------------
gbm3.scnvp<-SCANVISlinkvar(gbm3.scn,gbm3.vcf,gen19,p=100)
table(gbm3.scnv[,'passedMUT'])
table(gbm3.scnvp[,'passedMUT'])

## -----------------------------------------------------------------------------
par(mfrow=c(2,1),mar=c(1,1,1,1))
vis.lusc1<-SCANVISvisual('PPA2',gen19,LUSC[[1]],TITLE=names(LUSC)[1],full.annot=TRUE,bam=NULL,samtools=NULL)
vis.lusc2<-SCANVISvisual('PPA2',gen19,LUSC[[2]],TITLE=names(LUSC)[2],full.annot=TRUE,bam=NULL,samtools=NULL,USJ='RRS')

## -----------------------------------------------------------------------------
ASJ<-tail(vis.lusc2[[2]])[,1:3]
c2<-SCANVISvisual('PPA2',gen19,LUSC[[2]],TITLE=names(LUSC)[2],full.annot=TRUE,SJ.special=ASJ)

## -----------------------------------------------------------------------------
vis.lusc.merged<-SCANVISvisual('PPA2',gen19,LUSC,TITLE='Two LUSC samples, merged',full.annot=TRUE)

## -----------------------------------------------------------------------------
sessionInfo()

