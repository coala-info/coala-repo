# Code example from 'annotationTools' vignette. See references/ for full tutorial.

### R code from vignette source 'annotationTools.Rnw'

###################################################
### code chunk number 1: style-Sweave
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: annotationTools.Rnw:28-30 (eval = FALSE)
###################################################
## annotation_HGU133Plus2<-read.csv('HG-U133_Plus_2_annot.csv',
## 	colClasses='character',comment.char='#')


###################################################
### code chunk number 3: annotationTools.Rnw:35-39
###################################################
annotationFile<-system.file('extdata','HG-U133_Plus_2_annot_part.csv',
	package='annotationTools')
annotation_HGU133Plus2<-read.csv(annotationFile,colClasses='character',
	comment.char='#')


###################################################
### code chunk number 4: annotationTools.Rnw:44-45
###################################################
myPS<-c('117_at','1007_s_at')


###################################################
### code chunk number 5: annotationTools.Rnw:50-51
###################################################
library(annotationTools)


###################################################
### code chunk number 6: annotationTools.Rnw:54-55
###################################################
getGENESYMBOL(myPS,annotation_HGU133Plus2)


###################################################
### code chunk number 7: annotationTools.Rnw:62-63
###################################################
getGENEONTOLOGY(myPS,annotation_HGU133Plus2)


###################################################
### code chunk number 8: annotationTools.Rnw:68-69
###################################################
getGENEONTOLOGY(myPS,annotation_HGU133Plus2,specifics=2)


###################################################
### code chunk number 9: annotationTools.Rnw:76-77
###################################################
ls(grep('annotationTools',search()))


###################################################
### code chunk number 10: annotationTools.Rnw:82-83
###################################################
colnames(annotation_HGU133Plus2)


###################################################
### code chunk number 11: annotationTools.Rnw:94-97
###################################################
homologeneFile<-system.file('extdata','homologene_part.data',
	package='annotationTools')
homologene<-read.delim(homologeneFile,header=FALSE)


###################################################
### code chunk number 12: annotationTools.Rnw:102-104
###################################################
myGenes<-c(5982,93587)
getHOMOLOG(myGenes,10090,homologene)


###################################################
### code chunk number 13: annotationTools.Rnw:111-120
###################################################
ps_human<-'1053_at'
geneID_human<-getGENEID(ps_human,annotation_HGU133Plus2)
geneID_mouse<-getHOMOLOG(geneID_human,10090,homologene)
annotationFile<-system.file('extdata','Mouse430_2_annot_part.csv',
	package='annotationTools')
annotation_Mouse4302<-read.csv(annotationFile,colClasses='character')
geneID_mouse<-unlist(geneID_mouse)
ps_mouse<-getPROBESET(geneID_mouse,annotation_Mouse4302)
ps_mouse


###################################################
### code chunk number 14: annotationTools.Rnw:131-134
###################################################
gene_orthologsFile<-system.file('extdata','gene_orthologs_part.data',
	package='annotationTools')
gene_orthologs<-read.delim(gene_orthologsFile,header=TRUE)


###################################################
### code chunk number 15: annotationTools.Rnw:139-140
###################################################
getHOMOLOG(myGenes,10090,gene_orthologs,tableType="gene_orthologs")


###################################################
### code chunk number 16: annotationTools.Rnw:147-150
###################################################
affyOrthologFile<-system.file('extdata','HG-U133_Plus_2_ortholog_part.csv',
	package='annotationTools')
orthologs_HGU133Plus2<-read.csv(affyOrthologFile,colClasses='character')


###################################################
### code chunk number 17: annotationTools.Rnw:155-157
###################################################
getHOMOLOG('1053_at','Mouse430_2',orthologs_HGU133Plus2,
	cluster=TRUE,clusterCol=1,speciesCol=4,idCol=3)


###################################################
### code chunk number 18: annotationTools.Rnw:167-168 (eval = FALSE)
###################################################
## orthoTable<-ps2ps(annotation_HGU133Plus2,annotation_Mouse4302,homologene,10090)


###################################################
### code chunk number 19: annotationTools.Rnw:173-190 (eval = FALSE)
###################################################
## annotation_HGU133Plus2<-read.csv('HG-U133_Plus_2_annot.csv',
## 	colClasses='character',comment.char='#')
## annotation_Mouse4302<-read.csv('Mouse430_2_annot.csv',
## 	colClasses='character',comment.char='#')
## homologene<-read.delim('homologene.data',header=F)
## target_species<-10090
## 
## ps_HGU133Plus2<-annotation_HGU133Plus2[,1]
## gid_HGU133Plus2<-getGENEID(ps_HGU133Plus2,annotation_HGU133Plus2)
## length_gid_HGU133Plus2<-sapply(gid_HGU133Plus2,function(x) {length(x)})
## gid_Mouse4302<-getHOMOLOG(unlist(gid_HGU133Plus2),target_species,homologene)
## length_gid_Mouse4302<-sapply(gid_Mouse4302,function(x) {length(x)})
## ps_Mouse4302<-getPROBESET(unlist(gid_Mouse4302),annotation_Mouse4302)
## 
## ps_Mouse4302_1<-compactList(ps_Mouse4302,length_gid_Mouse4302)
## ps_Mouse4302_2<-compactList(ps_Mouse4302_1,length_gid_HGU133Plus2)
## gid_Mouse4302_1<-compactList(gid_Mouse4302,length_gid_HGU133Plus2)


###################################################
### code chunk number 20: annotationTools.Rnw:195-201 (eval = FALSE)
###################################################
## ps_Mouse4302_2<-lapply(ps_Mouse4302_2,function(x) {unique(x)})
## ps_Mouse4302_2<-lapply(ps_Mouse4302_2,function(x) {
## 	if (length(x)>1) na.omit(x) else x})
## gid_Mouse4302_1<-lapply(gid_Mouse4302_1,function(x) {unique(x)})
## gid_Mouse4302_1<-lapply(gid_Mouse4302_1,function(x) {
## 	if (length(x)>1) na.omit(x) else x})


###################################################
### code chunk number 21: annotationTools.Rnw:206-213 (eval = FALSE)
###################################################
## orthoTable<-cbind(ps_HGU133Plus2,listToCharacterVector(gid_HGU133Plus2,sep=','),
## 	listToCharacterVector(gid_Mouse4302_1,sep=','),
## 	listToCharacterVector(ps_Mouse4302_2,sep=','))
## colnames(orthoTable)<-c('ps_HGU133Plus2','gid_HGU133Plus2',
## 	'gid_Mouse4302','ps_Mouse4302')
## write.table(orthoTable,file='HGU133Plus2_Mouse4302.txt',sep='\t',
## 	col.names=T,row.names=F)


###################################################
### code chunk number 22: annotationTools.Rnw:218-221 (eval = FALSE)
###################################################
## orthoTable<-ps2ps(annotation_HGU133Plus2,annotation_Mouse4302,homologene,10090)
## write.table(orthoTable,file='HGU133Plus2_Mouse4302.txt',sep='\t',
## 	col.names=T,row.names=F)


###################################################
### code chunk number 23: annotationTools.Rnw:234-235
###################################################
data(orthologs_example)


###################################################
### code chunk number 24: annotationTools.Rnw:240-243
###################################################
selection<-1:8
ps_mouse<-table_mouse$Probe.Set.ID[selection]
table_mouse[selection,]


###################################################
### code chunk number 25: annotationTools.Rnw:248-250
###################################################
orthops<-getOrthologousProbesets(ps_mouse,table_human,ortho)
orthops[[1]]


###################################################
### code chunk number 26: annotationTools.Rnw:255-256
###################################################
table_human_absM<-data.frame(I(table_human[,1]),I(abs(table_human[,2])))


###################################################
### code chunk number 27: annotationTools.Rnw:261-264
###################################################
orthops_maxAbsM<-getOrthologousProbesets(ps_mouse,table_human_absM,
	ortho,max,forceProbesetSelection=TRUE)
orthops_maxAbsM[[1]]


###################################################
### code chunk number 28: annotationTools.Rnw:269-271
###################################################
orthops_maxAbsM_ind<-match(unlist(orthops_maxAbsM[[1]]),table_human[,1])
table_human[orthops_maxAbsM_ind,2]


###################################################
### code chunk number 29: selectOrtho
###################################################
table_human_absT<-data.frame(I(table_human[,1]),I(abs(table_human[,3])))
orthops_maxAbsT<-getOrthologousProbesets(ps_mouse,table_human_absT,
	ortho,max,forceProbesetSelection=TRUE)
orthops_maxAbsT_ind<-match(unlist(orthops_maxAbsT[[1]]),table_human[,1])
plot(table_mouse[selection,2],table_human[orthops_maxAbsM_ind,2],
	pch=19,col='gray',cex=1.5,xlab='log fold change in mouse',
	ylab='log fold change in human')
abline(h=0)
abline(v=0)
abline(0,1)
points(table_mouse[selection,2],table_human[orthops_maxAbsT_ind,2],pch=3,col=1)


###################################################
### code chunk number 30: annotationTools.Rnw:295-297
###################################################
ps_human<-ortho[match(ps_mouse,ortho[,1]),4]
ps_human


###################################################
### code chunk number 31: annotationTools.Rnw:302-307
###################################################
ps_human<-lapply(ps_human,function(x){strsplit(x,',')[[1]]})
length_ps_human<-sapply(ps_human,length)
gs_human<-lapply(ps_human,function(x){
	listToCharacterVector(getGENESYMBOL(x,annot_HGU133A))})
gs_human


###################################################
### code chunk number 32: annotationTools.Rnw:312-313
###################################################
existing_ps_human<-!is.na(ps_human)


###################################################
### code chunk number 33: annotationTools.Rnw:318-320
###################################################
LFC_mouse<-table_mouse$M[rep(match(ps_mouse[existing_ps_human],
	table_mouse$Probe.Set.ID),length_ps_human[existing_ps_human])]


###################################################
### code chunk number 34: annotationTools.Rnw:325-327
###################################################
LFC_human<-table_human$log2FC.HD.caudate.grade.0.2.vs.controls[
	match(unlist(ps_human[existing_ps_human]),table_human$Probe.Set.ID)]


###################################################
### code chunk number 35: annotationTools.Rnw:332-341 (eval = FALSE)
###################################################
## plot(LFC_mouse,LFC_human,col=rep(1:length(ps_human[existing_ps_human]),
## 	length_ps_human[existing_ps_human]),pch=16,cex=1.5,
## 	xlab='log fold change in mouse',ylab='log fold change in human')
## abline(h=0)
## abline(v=0)
## abline(0,1)
## legend(x=0.25,y=-0.77,legend=lapply(gs_human[existing_ps_human],
## 	function(x){paste(unique(x),sep=',')}),
## 	text.col=1:length(ps_human[existing_ps_human]))


###################################################
### code chunk number 36: scatterplot
###################################################
plot(LFC_mouse,LFC_human,col=rep(1:length(ps_human[existing_ps_human]),
	length_ps_human[existing_ps_human]),pch=16,cex=1.5,
	xlab='log fold change in mouse',ylab='log fold change in human')
abline(h=0)
abline(v=0)
abline(0,1)
legend(x=0.25,y=-0.77,legend=lapply(gs_human[existing_ps_human],
	function(x){paste(unique(x),collapse=',')}),
	text.col=1:length(ps_human[existing_ps_human]))


###################################################
### code chunk number 37: annotationTools.Rnw:366-367
###################################################
sessionInfo()


