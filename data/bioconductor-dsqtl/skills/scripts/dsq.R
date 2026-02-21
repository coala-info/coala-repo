# Code example from 'dsq' vignette. See references/ for full tutorial.

### R code from vignette source 'dsq.Rnw'

###################################################
### code chunk number 1: doone (eval = FALSE)
###################################################
## library(geuvPack)
## library(dsQTL)
## tf17 = gtpath(17, useS3=TRUE)
## data(DHStop5_hg19)
## dhs17 = DHStop5_hg19[ seqnames(DHStop5_hg19) == "chr17", ]
## seqlevelsStyle(dhs17) = "NCBI"
## library(gQTLstats)
## c17_1 = cisAssoc(dhs17[1:5,], tf17, cisradius=5000)
## c17_1


###################################################
### code chunk number 2: lkd (eval = FALSE)
###################################################
## library(dsQTL)
## data(DSQ_17)
## metadata(DSQ_17)
## metadata(DSQ_17)[[1]]


###################################################
### code chunk number 3: lkd2 (eval = FALSE)
###################################################
## data(DSQ_2)
## names(assays(DSQ_2))
## assays(DSQ_2)[[1]][1:5,1:5]
## rowRanges(DSQ_2)


###################################################
### code chunk number 4: lkd3 (eval = FALSE)
###################################################
## data(eset, package="dsQTL")
## ex


###################################################
### code chunk number 5: lkf (eval = FALSE)
###################################################
## library(Biobase)
## fData(ex)[1:5,,drop=FALSE]


###################################################
### code chunk number 6: domo (eval = FALSE)
###################################################
## library(GGBase)
## ds2 = getSS("dsQTL", "roundGT_2")


###################################################
### code chunk number 7: dose (eval = FALSE)
###################################################
## # need to get rid of SNPlocs package getSNPlocs
## getSNPlocs = dsQTL::getSNPlocs  # force
## library(GGtools)
## #library(parallel)
## #options(mc.cores=12)
## n1 = best.cis.eQTLs(smpack="dsQTL", radius=2000, geneannopk="dsQTL",
##   snpannopk="dsQTL", chrnames="2", smchrpref="roundGT_",
##   smFilter = function(x) GTFfilter(x, lower=0.05)[23810:23830,], 
## #  geneApply=mclapply)
##   geneApply=lapply)


###################################################
### code chunk number 8: lkpr (eval = FALSE)
###################################################
## n1


###################################################
### code chunk number 9: lkhi (eval = FALSE)
###################################################
## plot_EvG(probeId("dhs_2_45370802"), rsid("chr2.45370846"), getSS("dsQTL", "roundGT_2",
##   wrapperEndo=function(x){annotation(x)="dsQTL"; x}))


###################################################
### code chunk number 10: showp1 (eval = FALSE)
###################################################
## proc1 = function(x) {
##  library(rtracklayer)
##  tmp = import(paste(x, ".qnorm.bed.gz", sep=""))
##  stt = split(tmp, space(tmp))
##  obn = paste(x, "_dsq_chr2", sep="")
##  assign(obn, stt[["chr2"]])
##  save(list=obn, file=paste(obn, ".rda", sep=""))
##  NULL
## }


###################################################
### code chunk number 11: lks
###################################################
sessionInfo()


