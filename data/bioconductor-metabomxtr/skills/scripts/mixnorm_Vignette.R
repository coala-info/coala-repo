# Code example from 'mixnorm_Vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'mixnorm_Vignette.Rnw'

###################################################
### code chunk number 1: mixnorm_Vignette.Rnw:34-35
###################################################
  library(metabomxtr)


###################################################
### code chunk number 2: mixnorm_Vignette.Rnw:40-44
###################################################
 data(euMetabData)
 class(euMetabData)
 dim(euMetabData)
 head(euMetabData)


###################################################
### code chunk number 3: mixnorm_Vignette.Rnw:51-55
###################################################
data(euMetabCData)
class(euMetabCData)
dim(euMetabCData)
head(euMetabCData)


###################################################
### code chunk number 4: mixnorm_Vignette.Rnw:60-61
###################################################
ynames<-c('pyruvic_acid','malonic_acid')


###################################################
### code chunk number 5: mixnorm_Vignette.Rnw:66-91
###################################################
#get data in suitable format for plotting 
library(plyr)
control.data.copy<-euMetabCData[,c("batch","pheno","pyruvic_acid","malonic_acid")]
control.data.copy$type<-paste("Run Order=",substr(rownames(control.data.copy),6,6),sep="")
revalue(control.data.copy$pheno,c("MOM"="Mother Control","BABY"="Baby Control"))->control.data.copy$pheno
library(reshape2)
control.plot.data<-melt(control.data.copy,measure.vars=c("pyruvic_acid","malonic_acid"),variable.name="Metabolite",value.name="Abundance")
revalue(control.plot.data$Metabolite,c("malonic_acid"="Malonic Acid","pyruvic_acid"="Pyruvic Acid"))->control.plot.data$Metabolite

#get annotation of mean values for mother and baby samples 
control.mean.annotation<-ddply(control.plot.data,c("Metabolite","pheno","batch"),summarize,Abundance=mean(Abundance,na.rm=T))
control.mean.annotation$type<-"Batch Specific Mean"

#merge on to control data 
control.plot.data<-rbind(control.plot.data,control.mean.annotation[,c("batch","pheno","type","Metabolite","Abundance")])

#check for missing values in metabolite abundance
sum(is.na(control.plot.data$Abundance))
control.plot.data[which(is.na(control.plot.data$Abundance)),]

#now for plotting purposes, fill in missing metabolite values with something below the minimum detectable threshold 
#Based on experimental evidence not available here, the minimum detectable threshold for batch 1 was 10.76
min.threshold<-10.76
impute.val<-min.threshold-0.5
control.plot.data[which(is.na(control.plot.data$Abundance)),"Abundance"]<-impute.val


###################################################
### code chunk number 6: fig1
###################################################
#plot abundance by batch and run order
library(ggplot2)

#beginning of plot 
control.plot<-ggplot(control.plot.data,aes(x=batch,y=Abundance,color=pheno,shape=type,group=pheno))+
						geom_point(size=7)+geom_line(data=control.plot.data[which(control.plot.data$type=="Batch Specific Mean"),])+
						scale_color_discrete(name="Sample Type")+scale_shape_manual(name="Point Type",values=c(8,15,16,17))+
						xlab("Analytic Batch")+ylab("Metabolite Abundance")+facet_wrap(~Metabolite)
						
#now add in line segments indicating batch specific thresholds of detectability for the first 4 batches
batch.thresholds1.to.4<-c(10.76,11.51,11.36,10.31)
for (x in 1:4){
	threshold<-batch.thresholds1.to.4[x]
	batch.lower<-x-0.3
	batch.upper<-x+0.3
	control.plot<-control.plot+geom_segment(x=batch.lower,y=threshold,xend=batch.upper,yend=threshold,color="purple",linetype=2)
}

#add in threshold of detectability for the last batch and also add a legend to describe the threshold lines
batch.thresholds5<-11.90
control.plot<-control.plot+geom_segment(aes(x=4.7,y=batch.thresholds5,xend=5.3,yend=batch.thresholds5,linetype="Batch Specific\nThreshold of\nDetectability"),color="purple")+
										scale_linetype_manual(name="",values=2)+guides(color=guide_legend(order=1),shape=guide_legend(order = 2),linetype=guide_legend(order = 3))

#add in annotation for the point below the threshold of detectability 
annotate.df<-data.frame(Metabolite=factor("Malonic Acid",levels=c("Pyruvic Acid","Malonic Acid")),batch=factor(1,levels=1:5),Abundance=impute.val-0.5)
control.plot.final<-control.plot+geom_text(aes(x=batch,y=Abundance,label="(Unknown\nAbundance)",shape=NULL,group=NULL),color="Red",annotate.df,size=7)+
					theme(axis.title=element_text(size=35), axis.text=element_text(size=25),  strip.text=element_text(size=30), legend.title=element_text(size=25), legend.text=element_text(size=25))+
					guides(color=guide_legend(override.aes=list(size=2),order=1, keywidth=0.7, keyheight=0.5,default.unit="inch"), shape=guide_legend(override.aes=list(size=5), order=2,  keywidth=0.7, keyheight=0.5,default.unit="inch"), linetype=guide_legend(order=3),  keywidth=0.7, keyheight=0.5,default.unit="inch")
control.plot.final


###################################################
### code chunk number 7: fig1
###################################################
#plot abundance by batch and run order
library(ggplot2)

#beginning of plot 
control.plot<-ggplot(control.plot.data,aes(x=batch,y=Abundance,color=pheno,shape=type,group=pheno))+
						geom_point(size=7)+geom_line(data=control.plot.data[which(control.plot.data$type=="Batch Specific Mean"),])+
						scale_color_discrete(name="Sample Type")+scale_shape_manual(name="Point Type",values=c(8,15,16,17))+
						xlab("Analytic Batch")+ylab("Metabolite Abundance")+facet_wrap(~Metabolite)
						
#now add in line segments indicating batch specific thresholds of detectability for the first 4 batches
batch.thresholds1.to.4<-c(10.76,11.51,11.36,10.31)
for (x in 1:4){
	threshold<-batch.thresholds1.to.4[x]
	batch.lower<-x-0.3
	batch.upper<-x+0.3
	control.plot<-control.plot+geom_segment(x=batch.lower,y=threshold,xend=batch.upper,yend=threshold,color="purple",linetype=2)
}

#add in threshold of detectability for the last batch and also add a legend to describe the threshold lines
batch.thresholds5<-11.90
control.plot<-control.plot+geom_segment(aes(x=4.7,y=batch.thresholds5,xend=5.3,yend=batch.thresholds5,linetype="Batch Specific\nThreshold of\nDetectability"),color="purple")+
										scale_linetype_manual(name="",values=2)+guides(color=guide_legend(order=1),shape=guide_legend(order = 2),linetype=guide_legend(order = 3))

#add in annotation for the point below the threshold of detectability 
annotate.df<-data.frame(Metabolite=factor("Malonic Acid",levels=c("Pyruvic Acid","Malonic Acid")),batch=factor(1,levels=1:5),Abundance=impute.val-0.5)
control.plot.final<-control.plot+geom_text(aes(x=batch,y=Abundance,label="(Unknown\nAbundance)",shape=NULL,group=NULL),color="Red",annotate.df,size=7)+
					theme(axis.title=element_text(size=35), axis.text=element_text(size=25),  strip.text=element_text(size=30), legend.title=element_text(size=25), legend.text=element_text(size=25))+
					guides(color=guide_legend(override.aes=list(size=2),order=1, keywidth=0.7, keyheight=0.5,default.unit="inch"), shape=guide_legend(override.aes=list(size=5), order=2,  keywidth=0.7, keyheight=0.5,default.unit="inch"), linetype=guide_legend(order=3),  keywidth=0.7, keyheight=0.5,default.unit="inch")
control.plot.final


###################################################
### code chunk number 8: mixnorm_Vignette.Rnw:138-142
###################################################
#execute normalization
euMetabNorm <- mixnorm(ynames, batch="batch", mxtrModel=~pheno+batch|pheno+batch, 
				batchTvals=c(10.76,11.51,11.36,10.31,11.90), cData=euMetabCData,
				data=euMetabData, qc.sd.outliers=2)


###################################################
### code chunk number 9: mixnorm_Vignette.Rnw:147-148
###################################################
euMetabNorm$normParamsZ


###################################################
### code chunk number 10: mixnorm_Vignette.Rnw:153-154
###################################################
head(euMetabNorm$ctlNorm)


###################################################
### code chunk number 11: mixnorm_Vignette.Rnw:159-160
###################################################
head(euMetabNorm$obsNorm)


###################################################
### code chunk number 12: mixnorm_Vignette.Rnw:167-168
###################################################
head(euMetabNorm$conv)


###################################################
### code chunk number 13: fig2
###################################################
plot.list<-lapply(ynames, metabplot, batch="batch", raw.obs.data=euMetabData, raw.cont.data=euMetabCData, 
			norm.obs.data=euMetabNorm$obsNorm, norm.cont.data=euMetabNorm$ctlNorm,
			 color.var="pheno", cont.outlier.sd.thresh=2, norm.outlier.sd.thresh=4)

#just show plot for one of the metabolites 
plot.list[[2]]


###################################################
### code chunk number 14: fig2
###################################################
plot.list<-lapply(ynames, metabplot, batch="batch", raw.obs.data=euMetabData, raw.cont.data=euMetabCData, 
			norm.obs.data=euMetabNorm$obsNorm, norm.cont.data=euMetabNorm$ctlNorm,
			 color.var="pheno", cont.outlier.sd.thresh=2, norm.outlier.sd.thresh=4)

#just show plot for one of the metabolites 
plot.list[[2]]


###################################################
### code chunk number 15: mixnorm_Vignette.Rnw:198-201
###################################################
euMetabNormRC <- mixnorm(ynames, batch="batch", mxtrModel=~pheno+batch|pheno+batch, 
				batchTvals=c(10.76,11.51,11.36,10.31,11.90), cData=euMetabCData,
				removeCorrection="pheno",data=euMetabData)


###################################################
### code chunk number 16: mixnorm_Vignette.Rnw:206-207
###################################################
euMetabNormRC$normParamsZ[rownames(euMetabNormRC$normParamsZ)=="pyruvic_acid", ]


###################################################
### code chunk number 17: fig4
###################################################
metabplot("pyruvic_acid",  batch="batch", raw.obs.data=euMetabData, raw.cont.data=euMetabCData, 
		norm.obs.data=euMetabNormRC$obsNorm, norm.cont.data=euMetabNormRC$ctlNorm, 
		color.var="pheno", cont.outlier.sd.thresh=2, norm.outlier.sd.thresh=4)


###################################################
### code chunk number 18: fig4
###################################################
metabplot("pyruvic_acid",  batch="batch", raw.obs.data=euMetabData, raw.cont.data=euMetabCData, 
		norm.obs.data=euMetabNormRC$obsNorm, norm.cont.data=euMetabNormRC$ctlNorm, 
		color.var="pheno", cont.outlier.sd.thresh=2, norm.outlier.sd.thresh=4)


###################################################
### code chunk number 19: mixnorm_Vignette.Rnw:232-235
###################################################
norm.with.outliers <- mixnorm(ynames, batch="batch", mxtrModel=~pheno+batch|pheno+batch, 
				batchTvals=c(10.76,11.51,11.36,10.31,11.90), cData=euMetabCData,
				data=euMetabData, qc.sd.outliers=Inf)


###################################################
### code chunk number 20: fig5
###################################################
metabplot("malonic_acid",  batch="batch", raw.obs.data=euMetabData, raw.cont.data=euMetabCData, 
		norm.obs.data=norm.with.outliers$obsNorm, norm.cont.data=norm.with.outliers$ctlNorm, 
		color.var="pheno", cont.outlier.sd.thresh=Inf, norm.outlier.sd.thresh=4)


###################################################
### code chunk number 21: fig5
###################################################
metabplot("malonic_acid",  batch="batch", raw.obs.data=euMetabData, raw.cont.data=euMetabCData, 
		norm.obs.data=norm.with.outliers$obsNorm, norm.cont.data=norm.with.outliers$ctlNorm, 
		color.var="pheno", cont.outlier.sd.thresh=Inf, norm.outlier.sd.thresh=4)


###################################################
### code chunk number 22: mixnorm_Vignette.Rnw:257-262
###################################################
cData.missing.batch<-euMetabCData
cData.missing.batch[cData.missing.batch$batch==2, "malonic_acid"]<-NA				
norm.with.missing.batch <- mixnorm(ynames, batch="batch", mxtrModel=~pheno+batch|pheno+batch, 
				batchTvals=c(10.76,11.51,11.36,10.31,11.90), cData=cData.missing.batch,
				data=euMetabData)	


###################################################
### code chunk number 23: mixnorm_Vignette.Rnw:267-268
###################################################
norm.with.missing.batch$normParamsZ[rownames(norm.with.missing.batch$normParamsZ)=="malonic_acid", ]


###################################################
### code chunk number 24: mixnorm_Vignette.Rnw:273-274
###################################################
norm.with.missing.batch$conv


###################################################
### code chunk number 25: fig6
###################################################
metabplot("malonic_acid",  batch="batch", raw.obs.data=euMetabData, raw.cont.data=cData.missing.batch,
		 norm.obs.data=norm.with.missing.batch$obsNorm, 
		 norm.cont.data=norm.with.missing.batch$ctlNorm,  color.var="pheno")


###################################################
### code chunk number 26: fig6
###################################################
metabplot("malonic_acid",  batch="batch", raw.obs.data=euMetabData, raw.cont.data=cData.missing.batch,
		 norm.obs.data=norm.with.missing.batch$obsNorm, 
		 norm.cont.data=norm.with.missing.batch$ctlNorm,  color.var="pheno")


###################################################
### code chunk number 27: mixnorm_Vignette.Rnw:299-308
###################################################
cData.missing.pheno<-euMetabCData
cData.missing.pheno[cData.missing.pheno$pheno=="BABY", "malonic_acid"]<-NA				
norm.missing.pheno <- mixnorm(ynames, batch="batch", mxtrModel=~pheno+batch|pheno+batch, 
				batchTvals=c(10.76,11.51,11.36,10.31,11.90), cData=cData.missing.pheno,
				data=euMetabData)	

norm.missing.pheno$normParamsZ[rownames(norm.missing.pheno$normParamsZ)=="malonic_acid", ]
norm.missing.pheno$conv



###################################################
### code chunk number 28: fig7
###################################################
metabplot("malonic_acid",  batch="batch", raw.obs.data=euMetabData, raw.cont.data=cData.missing.pheno, 
		norm.obs.data=norm.missing.pheno$obsNorm, norm.cont.data=norm.missing.pheno$ctlNorm,
		 color.var="pheno")


###################################################
### code chunk number 29: fig7
###################################################
metabplot("malonic_acid",  batch="batch", raw.obs.data=euMetabData, raw.cont.data=cData.missing.pheno, 
		norm.obs.data=norm.missing.pheno$obsNorm, norm.cont.data=norm.missing.pheno$ctlNorm,
		 color.var="pheno")


###################################################
### code chunk number 30: mixnorm_Vignette.Rnw:329-330
###################################################
toLatex(sessionInfo())


