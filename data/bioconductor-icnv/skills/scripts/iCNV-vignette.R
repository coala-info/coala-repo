# Code example from 'iCNV-vignette' vignette. See references/ for full tutorial.

## ----CODEX_Normalization_1, message=FALSE,results='hide',warning=FALSE--------

### 2.2 code chunk number 1: bambedObj1
library(CODEX)
library(WES.1KG.WUGSC) # Load Toy data from the 1000 Genomes Project.
library(iCNV) 
# Assume your work dir set to demo
dir <- system.file("extdata", package = "WES.1KG.WUGSC") # 'PATH/TO/BAM'
bamFile <- list.files(dir, pattern = '*.bam$')
bamdir <- file.path(dir, bamFile)
sampname <- as.matrix(read.table(file.path(dir, "sampname")))
bedFile <- file.path(dir, "chr22_400_to_500.bed")
chr <- 22
bambedObj <- getbambed(bamdir = bamdir, bedFile = bedFile, 
                   sampname = sampname, projectname = "icnv.demo.", chr)
bamdir <- bambedObj$bamdir; sampname <- bambedObj$sampname
ref <- bambedObj$ref; projectname <- bambedObj$projectname; chr <- bambedObj$chr

### 2.2 code chunk number 2: coverageObj1
coverageObj <- getcoverage(bambedObj, mapqthres = 20)
Y <- coverageObj$Y; readlength <- coverageObj$readlength

### 2.2 code chunk number 3: gcmapp1
gc <- getgc(chr, ref)
mapp <- getmapp(chr, ref)

### 2.2 code chunk number 4: qcObj1
qcObj <- qc(Y, sampname, chr, ref, mapp, gc, cov_thresh = c(20, 4000), 
            length_thresh = c(20, 2000), mapp_thresh = 0.9, gc_thresh = c(20, 80))
Y_qc <- qcObj$Y_qc; sampname_qc <- qcObj$sampname_qc; gc_qc <- qcObj$gc_qc
mapp_qc <- qcObj$mapp_qc; ref_qc <- qcObj$ref_qc; qcmat <- qcObj$qcmat

### 2.2 code chunk number 5: normObj1
normObj <- normalize(Y_qc, gc_qc, K = 1:9)
Yhat <- normObj$Yhat; AIC <- normObj$AIC; BIC <- normObj$BIC
RSS <- normObj$RSS; K <- normObj$K
choiceofK(AIC, BIC, RSS, K, filename = paste0(projectname, chr, "_choiceofK.pdf"))
save(qcObj,normObj,sampname,file=paste0(projectname,'plrObj_', chr,".rda"))
# This saving step is necessary for large dataset, such that you don't need 
# to recompute everything again if you would like to view your choice of K 
# plot. You could just load this as in the next chunk of code.

## ----fig.height=2, fig.width=8, echo=FALSE, out.width = "200%", dpi=200-------
Kmax <- length(AIC)
par(mfrow = c(1, 3))
plot(K, RSS, type = "b", xlab = "Number of latent variables")
plot(K, AIC, type = "b", xlab = "Number of latent variables")
plot(K, BIC, type = "b", xlab = "Number of latent variables")

## ----CODEX_Normalization_2, message=FALSE-------------------------------------
load(paste0(projectname,'plrObj_',chr,".rda"))
optK <- K[which.max(BIC)] # by default or customize given curves

### 2.2 code chunk number 6: plr
Y_qc <- qcObj$Y_qc; sampname_qc <- qcObj$sampname_qc; gc_qc <- qcObj$gc_qc
mapp_qc <- qcObj$mapp_qc; ref_qc <- qcObj$ref_qc; qcmat <- qcObj$qcmat
Yhat <- normObj$Yhat; AIC <- normObj$AIC; BIC <- normObj$BIC
RSS <- normObj$RSS; K <- normObj$K
ref_qc <- qcObj$ref_qc # IRanges object for exon target
sampname_qc <- qcObj$sampname_qc # sample names
Y_norm <- normObj$Yhat[[optK]] # normalized read count under null (no CNV)
plr <- log(pmax(Y_qc,0.0001)/pmax(Y_norm,0.0001)) # log transformed z-scores
ngs_plr <- lapply(seq_len(ncol(plr)), function(i) plr[,i])
ngs_plr.pos <- lapply(seq_len(ncol(plr)),function(x){return(cbind(start(ref_qc),end(ref_qc)))})
save(sampname_qc,ngs_plr,ngs_plr.pos,file=paste0(projectname,'plrObj_',chr,'_',optK,'.rda'))

## ----message=FALSE,results='hide',warning=FALSE-------------------------------
### 2.3 code chunk number 1: bambaf_from_vcf
projectname <- "icnv.demo."
dir <- system.file("extdata", package="iCNV")
bambaf_from_vcf(dir,'bam_vcf.list',chr=22,projectname) 
# ignore chr argement if you want to convert all chromosome 1-22
load(paste0(projectname,'bambaf_22.rda'))

## ----results='hide'-----------------------------------------------------------
### 2.4 code chunk number 1: icnv_array_input
# PATH/TO/FOLDER where you stored the array data
dir <- system.file("extdata", package="iCNV")#PATH/TO/FOLDER where you stored the array data
chr <- 22
projectname <- "icnv.demo."
pattern <- paste0('*.csv.arrayicnv$')
get_array_input(dir,pattern,chr,projectname)
load(paste0(projectname,'array_lrrbaf_',chr,'.rda'))

## ----fig.height=4, fig.width=6, out.width = "200%", dpi=200-------------------
### 2.4 code chunk number 2: svd (optional)
library(iCNV)
projectname <- "icnv.demo."
load(paste0(projectname,'array_lrrbaf_',chr,'.rda'))
# standardize LRR
lrr.sd <- mapply(function(x){
  x=pmax(pmin(x,100),-100);(x-mean(x,na.rm=TRUE))/sd(x,na.rm = TRUE)
  },snp_lrr,SIMPLIFY = TRUE)
# You may want to substitute all the NAs in lrr by rowMeans
lrr.sd.dena <- apply(lrr.sd,2,function(x){x[is.na(x)]=mean(x,na.rm=TRUE);return(x)})

# lrr is LRR matrix, with row as sample and column as positions
lrr.svd <- svd (t(lrr.sd.dena))
save(lrr.svd,file=paste0(projectname,'array_lrrbaf_svd_',chr,'.rda'))

# Plot out the variance explained with K; You can store the plot in a pdf
# pdf(paste0(projectname,'array_lrrbaf_svd_',chr,'.pdf'),height=8,width=10)
plot(x=seq_len(10),y=(lrr.svd$d[1:10])^2/sum(lrr.svd$d^2),
     xlab='rank',ylab='D square',main='Variance explained',type='l')
# dev.off() # Close the plot connection

## ----results='hide',message=FALSE---------------------------------------------
### 2.5 code chunk number 1: iCNV_detection with genotype
str(ngs_plr) # List of n vector, each one is the PLR for an exon
str(ngs_plr.pos) # List of n matrix (p x 2), each one is the start and end location for an exon
str(ngs_baf) # List of n vector, each one is the variants BAF from .bam
str(ngs_baf.pos) # List of n vector, each one is the variants BAF position
str(snp_lrr) # List of n vector, each one is the normalized LRR for a SNP
str(snp_lrr.pos) # List of n vector, each one is a SNP position
str(snp_baf) # List of n vector, each one is the BAF for a SNP
str(snp_baf.pos) # List of n vector, each one is the SNP BAF position
projectname <- 'icnv.demo.'
icnv_res0 <- iCNV_detection(ngs_plr,snp_lrr,
                         ngs_baf,snp_baf,
                         ngs_plr.pos,snp_lrr.pos,
                         ngs_baf.pos,snp_baf.pos,
                         projname=projectname,CN=1,mu=c(-3,0,2),cap=TRUE,visual = 1)
icnv.output <- output_list(icnv_res0,sampname_qc,CN=1)
head(icnv.output)

## ----fig.width=8, fig.height=4,echo=FALSE, out.width = "200%", dpi=200--------
plotHMMscore(icnv_res0,title=projectname)

## -----------------------------------------------------------------------------
### 2.5 code chunk number 2: covert result to Genome Browser input
icnv.output <- output_list(icnv_res=icnv_res0,sampleid=sampname_qc, CN=0, min_size=10000)
gb_input <- icnv_output_to_gb(22,icnv.output)
write.table(gb_input,file=paste0(projectname,'icnv_res_gb_chr',chr,'.tab'),
            quote=FALSE,col.names=FALSE,row.names=FALSE)

## ----fig.width=6, fig.height=3, echo=F, out.width = "100%", dpi=75------------
plot(c(100, 190), c(300, 450), type= "n",xaxt='n',yaxt='n', ann=FALSE, xlab = "", ylab = "")
rect(100, 310, 140, 360, col = "#FF0000") # 
rect(100, 400, 140, 450, col = "#820000") # 
rect(150, 310, 190, 360, col = "#00FF00")
rect(150, 400, 190, 450, col = "#008200")
text(120,390,'Homo Deletion')
text(120,300,'Het Deletion')
text(170,390,'Homo Duplication')
text(170,300,'Het Duplication')

## ----echo=FALSE,fig.height=4, fig.width=8, out.width = "200%", dpi=200--------
plotHMMscore(icnv_res0,title=projectname,col='DGV')

## ----message=FALSE,results='hide',fig.keep='all',fig.height=3, fig.width=8, out.width = "200%", dpi=200----
### 2.5 code chunk number 3: plotindi
I <- 24 # ploting out the 24th individual
plotindi(ngs_plr,snp_lrr,
         ngs_baf,snp_baf,
         ngs_plr.pos,snp_lrr.pos,
         ngs_baf.pos,snp_baf.pos,
         icnv_res0,I)

## ----message=FALSE,results='hide',fig.keep='all',fig.height=4, fig.width=8, out.width = "200%", dpi=200----
### 2.6 code chunk number 1: NGS only iCNV_detection
str(ngs_plr) # List of n vector, each one is the PLR for an exon
str(ngs_plr.pos) # List of n matrix (p x 2), each one is the start and end location for an exon
str(ngs_baf) # List of n vector, each one is the variants BAF from .bam
str(ngs_baf.pos) # List of n vector, each one is the variants BAF position
projectname <- 'icnv.demo.ngs.'
icnv_res0_ngs <- iCNV_detection(ngs_plr=ngs_plr, ngs_baf = ngs_baf, 
                             ngs_plr.pos = ngs_plr.pos,ngs_baf.pos = ngs_baf.pos,
                             projname=projectname,CN=0,mu=c(-3,0,2),cap=TRUE,visual = 2)
icnv.output <- output_list(icnv_res0_ngs,sampname_qc,CN=0)
head(icnv.output)
plotHMMscore(icnv_res0_ngs,title=projectname)

## ----message=FALSE,results='hide',fig.keep='all',fig.height=4, fig.width=8, out.width = "200%", dpi=200----
### 2.6 code chunk number 2: array only iCNV_detection
str(snp_lrr) # List of n vector, each one is the normalized LRR for a SNP
str(snp_lrr.pos) # List of n vector, each one is a SNP position
str(snp_baf) # List of n vector, each one is the BAF for a SNP
str(snp_baf.pos) # List of n vector, each one is the SNP BAF position
projectname <- 'icnv.demo.snp'
icnv_res0_snp <- iCNV_detection(snp_lrr=snp_lrr, snp_baf = snp_baf, 
                             snp_lrr.pos = snp_lrr.pos,snp_baf.pos = snp_baf.pos,
                             projname=projectname,CN=1,mu=c(-3,0,2),cap=TRUE,visual = 2)
icnv.output <- output_list(icnv_res0_snp,sampname_qc,CN=1)
head(icnv.output)
plotHMMscore(icnv_res0_snp,title=projectname)

## -----------------------------------------------------------------------------
sessionInfo()

