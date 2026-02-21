# Code example from 'biomvRCNS' vignette. See references/ for full tutorial.

### R code from vignette source 'biomvRCNS.Rnw'

###################################################
### code chunk number 1: loadlib
###################################################
library(biomvRCNS)


###################################################
### code chunk number 2: setwidth
###################################################
options(width = 95)


###################################################
### code chunk number 3: coriellGR
###################################################
data('coriell', package='biomvRCNS')
head(coriell, n=3)
xgr<-GRanges(seqnames=coriell[,2], 
	IRanges(start=coriell[,3], width=1, names=coriell[,1]))
values(xgr)<-DataFrame(coriell[,4:5], row.names=NULL)
xgr<-sort(xgr)
head(xgr, n=3)


###################################################
### code chunk number 4: coriellHsmm
###################################################
rhsmm<-biomvRhsmm(x=xgr, maxbp=1E5, J=3, soj.type='gamma', 
	com.emis=T, emis.type='norm', prior.m='quantile', grp=c(1,2))


###################################################
### code chunk number 5: coriellHsmmres
###################################################
show(rhsmm)


###################################################
### code chunk number 6: coriellHsmmplot
###################################################
obj<-biomvRGviz(exprgr=xgr[seqnames(xgr)=='11', 'Coriell.05296'], 
	seggr=rhsmm@res[mcols(rhsmm@res)[,'SAMPLE']=='Coriell.05296'], tofile=FALSE)


###################################################
### code chunk number 7: coriellSeg
###################################################
rseg<-biomvRseg(x=xgr, maxbp=4E4, maxseg=10, family='norm', grp=c(1,2))


###################################################
### code chunk number 8: coriellSegres
###################################################
head(rseg@res)


###################################################
### code chunk number 9: coriellMGMR
###################################################
rmgmrh<-biomvRmgmr(xgr, q=0.9, high=T, maxgap=1000, minrun=2500, grp=c(1,2))
rmgmrl<-biomvRmgmr(xgr, q=0.1, high=F, maxgap=1000, minrun=2500, grp=c(1,2))
res<-c(rmgmrh@res, rmgmrl@res)


###################################################
### code chunk number 10: buildENCODEcgr (eval = FALSE)
###################################################
## winsize<-25
## cgr<-GRanges("chr17", strand='-', 
## 	IRanges(start=seq(7560001, 7610000, winsize), width =winsize))
## bf<-system.file("extdata", "encodeFiles.txt", package = "biomvRCNS")
## bamfiles<-read.table(bf, header=T, stringsAsFactors=F)
## library(Rsamtools)
## which<-GRanges("chr17", IRanges(7560001, 7610000))
## param<-ScanBamParam(which=which, what=scanBamWhat())
## for(i in seq_len(nrow(bamfiles))){
## 	frd<-scanBam(bamfiles[i,1], param=param)
## 	frdgr<-GRanges("chr17", strand=frd[[1]]$strand,
## 		IRanges(start=frd[[1]]$pos , end = frd[[1]]$pos+frd[[1]]$qwidth-1))
## 	mcols(cgr)<-DataFrame(mcols(cgr), DOC=countOverlaps(cgr, frdgr))
## }


###################################################
### code chunk number 11: buildENCODEcgr1bp (eval = FALSE)
###################################################
## cgr<-GRanges("chr17", strand='-',
## 	IRanges(seq(7560001, 7610000), width=1))
## bf<-system.file("extdata", "encodeFiles.txt", package = "biomvRCNS")
## bamfiles<-read.table(bf, header=T, stringsAsFactors=F)
## library(Rsamtools)
## which<-GRanges("chr17", IRanges(7560001, 7610000))
## param<-ScanBamParam(which=which, flag=scanBamFlag(isMinusStrand=TRUE))
## for(i in seq_len(nrow(bamfiles))){
## 	cod<-coverage(BamFile(bamfiles[i,1]), param=param)[['chr17']][7560001:7610000]
## 	mcols(cgr)<-DataFrame(mcols(cgr), DOC=cod)
## }


###################################################
### code chunk number 12: buildENCODEgmgr (eval = FALSE)
###################################################
## af<-system.file("extdata", "gmodTP53.gff", package = "biomvRCNS")
## gtfsub<-read.table(af, fill=T, stringsAsFactors=F)
## gmgr<-GRanges("chr17", IRanges(start=gtfsub[, 4], end=gtfsub[, 5], 
## 	names=gtfsub[, 13]), strand=gtfsub[, 7], TYPE=gtfsub[, 3])


###################################################
### code chunk number 13: poolENCODEcgr
###################################################
data(encodeTP53)
cgr<-encodeTP53$cgr
gmgr<-encodeTP53$gmgr
mcols(cgr)<-DataFrame(
	Gm12878=1+rowSums(as.matrix(mcols(cgr)[,1:2])), 
	K562=1+rowSums(as.matrix(mcols(cgr)[,3:4])) )


###################################################
### code chunk number 14: ENCODEHsmmTxDbSojourn
###################################################
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
txdb<-TxDb.Hsapiens.UCSC.hg19.knownGene	
rhsmm<-biomvRhsmm(x=cgr, xAnno=txdb, maxbp=1E3, soj.type='gamma', 
	emis.type='pois', prior.m='quantile', q.alpha=0.01)


###################################################
### code chunk number 15: showENCODEHsmm
###################################################
rhsmm@res[mcols(rhsmm@res)[,'STATE']=='exon']


###################################################
### code chunk number 16: plotENCODEHsmmG
###################################################
g<-mcols(rhsmm@res)[,'STATE']=='exon' & mcols(rhsmm@res)[,'SAMPLE']=='Gm12878'
obj<-biomvRGviz(exprgr=cgr[,'Gm12878'], gmgr=gmgr, 
	seggr=rhsmm@res[g], plotstrand='-', regionID='TP53', tofile=FALSE)


###################################################
### code chunk number 17: plotENCODEHsmmK
###################################################
k<-mcols(rhsmm@res)[,'STATE']=='exon' & mcols(rhsmm@res)[,'SAMPLE']=='K562'
obj<-biomvRGviz(exprgr=cgr[,'K562'], gmgr=gmgr, 
  seggr=rhsmm@res[k], plotstrand='-', regionID='TP53', tofile=FALSE)


###################################################
### code chunk number 18: findnew
###################################################
nK2gm<-queryHits(findOverlaps(rhsmm@res[k], gmgr))
nK2G<-queryHits(findOverlaps(rhsmm@res[k], rhsmm@res[g]))
rhsmm@res[k][setdiff(seq_len(sum(k)), unique(c(nK2G, nK2gm)))]


###################################################
### code chunk number 19: ENCODEothers
###################################################
rseg<-biomvRseg(x=cgr, maxbp=1E3, maxseg=20, family='pois')
rmgmr<-biomvRmgmr(x=cgr, q=0.99, maxgap=50, minrun=100)


###################################################
### code chunk number 20: variodata
###################################################
data(variosm)
head(variosm, n=3)


###################################################
### code chunk number 21: varioHsmmrun
###################################################
rhsmm<-biomvRhsmm(x=variosm, maxbp=100, prior.m='cluster', maxgap=100)


###################################################
### code chunk number 22: finddmr
###################################################
hiDiffgr<-rhsmm@res[mcols(rhsmm@res)[,'STATE']!=2 
	& mcols(rhsmm@res)[,'SAMPLE']=='meth.diff']

dirNo<-mcols(hiDiffgr)[,'STATE']=='1' & mcols(hiDiffgr)[,'AVG']>0 |
	mcols(hiDiffgr)[,'STATE']=='3' & mcols(hiDiffgr)[,'AVG']<0	
hiDiffgr<- hiDiffgr[!dirNo]

loPgr<-rhsmm@res[mcols(rhsmm@res)[,'STATE']==1
	& mcols(rhsmm@res)[,'SAMPLE']=='p.val']
	
DMRs<-reduce(intersect(hiDiffgr, loPgr), min.gapwidth=100)
idx<-findOverlaps(variosm, DMRs, type='within')
mcols(DMRs)<-DataFrame(cbind(TYPE='DMR', aggregate(as.data.frame(mcols(variosm[queryHits(idx)])), 
	by=list(DMR=subjectHits(idx)), FUN=median)[,-1]))
names(DMRs)<-paste0('DMRs', seq_along(DMRs))	
DMRs


###################################################
### code chunk number 23: plotdmr
###################################################
plot(rhsmm, gmgr=DMRs, tofile=FALSE)


###################################################
### code chunk number 24: varioHsmmrun2
###################################################
rhsmm<-biomvRhsmm(x=variosm, J=6, maxbp=100, emis.type='mvnorm',
 prior.m='cluster', maxgap=100, com.emis=T)


###################################################
### code chunk number 25: plotdmr2
###################################################
plot(rhsmm, tofile=FALSE)


###################################################
### code chunk number 26: finddmr2
###################################################
DMRs<-reduce(rhsmm@res[mcols(rhsmm@res)[,'STATE']=='6'], min.gapwidth=100)
idx<-findOverlaps(variosm, DMRs, type='within')
mcols(DMRs)<-DataFrame(cbind(TYPE='DMR', aggregate(as.data.frame(mcols(variosm[queryHits(idx)])), 
	by=list(DMR=subjectHits(idx)), FUN=median)[,-1], stringsAsFactors=F))
names(DMRs)<-paste0('DMRs', seq_along(DMRs))
DMRs
cDMRs<-reduce(rhsmm@res[mcols(rhsmm@res)[,'STATE']=='5'], min.gapwidth=100)
idx<-findOverlaps(variosm, cDMRs, type='within')
mcols(cDMRs)<-DataFrame(cbind(TYPE='cDMR', aggregate(as.data.frame(mcols(variosm[queryHits(idx)])), 
	by=list(cDMRs=subjectHits(idx)), FUN=median)[,-1], stringsAsFactors=F))
names(cDMRs)<-paste0('cDMRs', seq_along(cDMRs))
cDMRs
rhsmm@param$emis.par['chr1',][[1]]
rhsmm@param$soj.par['chr1',][[1]]


###################################################
### code chunk number 27: plotdmr3
###################################################
plot(rhsmm, gmgr=c(DMRs, cDMRs), tofile=FALSE)


###################################################
### code chunk number 28: session
###################################################
sessionInfo()


