# Code example from 'GGtools' vignette. See references/ for full tutorial.

### R code from vignette source 'GGtools.Rnw'

###################################################
### code chunk number 1: loadm
###################################################
suppressPackageStartupMessages(library(GGtools))
library(parallel)


###################################################
### code chunk number 2: getd
###################################################
g20 = getSS("GGdata", "20")


###################################################
### code chunk number 3: lkc
###################################################
g20
class(g20)


###################################################
### code chunk number 4: doex
###################################################
exprs(g20)[1:5,1:5]
pData(g20)[1:4,]


###################################################
### code chunk number 5: lksm
###################################################
smList(g20)
as(smList(g20)[[1]][1:5,1:5], "matrix")


###################################################
### code chunk number 6: lksm2
###################################################
as(smList(g20)[[1]][1:5,1:5], "numeric")
as(smList(g20)[[1]][1:5,1:5], "character")


###################################################
### code chunk number 7: dopeer (eval = FALSE)
###################################################
## library(peer)
## model = PEER()
## PEER_setPhenoMean(model, t(exprs(g20)))
## PEER_setNk(model, 10)
## PEER_setCovariates(model, matrix(1*g20$male,nc=1))
## PEER_update(model)
## resid=t(PEER_getResiduals(model))
## rownames(resid) = featureNames(g20)
## colnames(resid) = sampleNames(g20)
## g20peer10 = g20
## g20peer10@assayData = assayDataNew("lockedEnvironment", exprs=resid)


###################################################
### code chunk number 8: dot
###################################################
t1 = gwSnpTests(genesym("CPNE1")~male, g20, chrnum("20"))
t1
topSnps(t1)


###################################################
### code chunk number 9: dopl
###################################################
pdf(file="t1.pdf")
plot(t1, snplocsDefault())
dev.off()
pdf(file="t1evg.pdf")
plot_EvG(genesym("CPNE1"), rsid("rs17093026"), g20)
dev.off()


###################################################
### code chunk number 10: dol (eval = FALSE)
###################################################
## plot(t1, snplocsDefault())
## plot_EvG(genesym("CPNE1"), rsid("rs17093026"), g20)


###################################################
### code chunk number 11: doloc (eval = FALSE)
###################################################
## library(snplocsDefault(), character.only=TRUE)
## sl = get(snplocsDefault())
## S20 = snplocs(sl, "ch20", as.GRanges=TRUE)
## GR20 = makeGRanges(t1, S20)
## library(rtracklayer)
## export(GR20, "~/cpne1new.wig")


###################################################
### code chunk number 12: do20
###################################################
g20 = GGtools:::restrictProbesToChrom(g20, "20")
mads = apply(exprs(g20),1,mad)
oo = order(mads, decreasing=TRUE)
g20 = g20[oo[1:50],]
tf = tempfile()
dir.create(tf)
e1 = eqtlTests(MAFfilter(g20, lower=0.05), ~male, 
    geneApply=mclapply, targdir=tf)
e1


###################################################
### code chunk number 13: gettop
###################################################
pm1 = colnames(e1@fffile)
tops = sapply(pm1, function(x) topFeats(probeId(x), mgr=e1, n=1)) 
top6 = sort(tops, decreasing=TRUE)[1:6]


###################################################
### code chunk number 14: dopr6
###################################################
print(top6)


###################################################
### code chunk number 15: gettab
###################################################
nms = strsplit(names(top6), "\\.")
gn = sapply(nms,"[",1)
sn = sapply(nms,"[",2)
tab = data.frame(snp=sn,score=as.numeric(top6))
rownames(tab) = gn
tab


###################################################
### code chunk number 16: ddstr
###################################################
data(strMultPop)
strMultPop[ strMultPop$rsid %in% tab$snp, ]


###################################################
### code chunk number 17: getfn
###################################################
fn = probeId(featureNames(g20))


###################################################
### code chunk number 18: doc (eval = FALSE)
###################################################
## if (file.exists("db2")) unlink("db2", recursive=TRUE)
## fn = probeId(featureNames(g20))
## exTx = function(x) MAFfilter( x[fn, ], lower=0.05)
## b1 = best.cis.eQTLs("GGdata", ~male,  radius=1e6,
##    folderstem="db2", nperm=2, geneApply=mclapply,
##    smFilter= exTx, chrnames="20", snpannopk=snplocsDefault())


###################################################
### code chunk number 19: lkc
###################################################
data(b1)


###################################################
### code chunk number 20: lkb1
###################################################
b1


###################################################
### code chunk number 21: doopt
###################################################
options("showHeadLines"=3)
options("showTailLines"=1)


###################################################
### code chunk number 22: doconf
###################################################
suppressPackageStartupMessages(library(GGtools))
ini = new("CisConfig")
ini
radius(ini) = 75000L
smFilter(ini) = function(x) nsFilter(x, var.cutoff=.98)
smpack(ini) = "GGtools"
chrnames(ini) = "20"
library(parallel)  # to define mclapply
geneApply(ini) = mclapply
ini


###################################################
### code chunk number 23: dosearch
###################################################
options(mc.cores=max(1, detectCores()-3))
system.time(t20 <- All.cis(ini))
t20


###################################################
### code chunk number 24: dos2 (eval = FALSE)
###################################################
## chrnames(ini) = "21"
## system.time(t21 <- All.cis(ini))


###################################################
### code chunk number 25: dosa
###################################################
td = tempdir()
save(t20, file=paste0(td, "/t20.rda"))
#save(t21, file=paste0(td, "/t21.rda"))


###################################################
### code chunk number 26: docomb
###################################################
fns = dir(td, full=TRUE, patt="^t2.*rda$")
cf = collectFiltered(fns, mafs=c(.02,.03,.1), hidists=c(1000,10000,75000))
class(cf)
names(cf)  # MAFs are primary organization, distances secondary
names(cf[[1]])
sapply(cf, sapply, function(x) sum(x$fdr <= 0.05))  # best per gene
of = order(cf[[3]][[1]]$fdr)
cf[[3]][[1]][of,][1:4,]  # shows best hits


###################################################
### code chunk number 27: fup
###################################################
g20 = getSS("GGtools", "20")


###################################################
### code chunk number 28: dofupfig
###################################################
plot_EvG(probeId("GI_4502372-S"), rsid("rs290449"), g20)


###################################################
### code chunk number 29: fup2
###################################################
cf2 = collectFiltered(fns, mafs=c(.02,.05,.1), hidists=c(10000,75000),
  filterFun=cis.FDR.filter.SNPcentric)
sapply(cf2, sapply, function(x) sum(x$fdr<=0.01))


###################################################
### code chunk number 30: lko (eval = FALSE)
###################################################
## onepopConfig = function(chrn="22", nperm=3L, MAF=.05, 
##     npc=10, radius=50000, exclRadius=NULL) {
##    if (!is.null(npc)) 
##      bf = basicFilter = function(ww) MAFfilter(clipPCs(ww, 1:npc), lower=MAF)[, which(ww$isFounder==1)]
##    else bf = basicFilter = function(ww) MAFfilter(ww, lower=MAF)[, which(
##     ww$isFounder==1)]
## 
##    ssm(library(GGtools))
##    iniconf = new("CisConfig")
##    smpack(iniconf) = "GGdata"
##    rhs(iniconf) = ~1
##    folderStem(iniconf) = paste0("cisScratch_", chrn)
##    chrnames(iniconf) = as.character(chrn)
##    geneannopk(iniconf) = "illuminaHumanv1.db"
##    snpannopk(iniconf) = snplocsDefault()
##    smchrpref(iniconf) = ""
##    geneApply(iniconf) = mclapply
##    exFilter(iniconf) = function(x)x
##    smFilter(iniconf) = bf
##    nperm(iniconf) = as.integer(nperm)
##    radius(iniconf) = radius
##    estimates(iniconf) = TRUE
##    MAFlb(iniconf) = MAF
## 
##    library(parallel)
##    options(mc.cores=3)
##    options(error=recover)
##    set.seed(1234)
##    tmp = All.cis( iniconf )
##    metadata(tmp)$config = iniconf
##    obn = paste("pop2_", "np_", nperm, "_maf_", MAF, "_chr_", chrn,
##     "_npc_", npc, "_rad_", radius, "_exc_", exclRadius, sep="")
##    fn = paste(obn, file=".rda", sep="")
##    assign(obn, tmp)
##    save(list=obn, file=fn)
## }


###################################################
### code chunk number 31: domo
###################################################
if (file.exists("db2")) unlink("db2", recursive=TRUE)
g20 = getSS("GGdata", "20")
exTx = function(x) MAFfilter( clipPCs(x,1:10)[fn, ], lower=0.05)
g20f = exTx(g20)


###################################################
### code chunk number 32: runWithClip (eval = FALSE)
###################################################
## b2 = best.cis.eQTLs("GGdata", ~male,  radius=50000,
##    folderstem="db3", nperm=2, geneApply=mclapply,
##    smFilter= exTx, chrnames="20", snpannopk=snplocsDefault())


###################################################
### code chunk number 33: getb2
###################################################
data(b2)


###################################################
### code chunk number 34: lkb2
###################################################
b2


###################################################
### code chunk number 35: ggg
###################################################
goodProbes = function(x) names(x@scoregr[elementMetadata(x@scoregr)$fdr<0.13])


###################################################
### code chunk number 36: chkp
###################################################
setdiff(goodProbes(b2), goodProbes(b1))


###################################################
### code chunk number 37: lkback
###################################################
setdiff(goodProbes(b1), goodProbes(b2))


###################################################
### code chunk number 38: domopic (eval = FALSE)
###################################################
## newp = setdiff(goodProbes(b2), goodProbes(b1))
## np = length(newp)
## bestSnp = function(pn, esm) elementMetadata(esm@scoregr[pn])$snpid
## par(mfrow=c(2,2))
## plot_EvG(probeId(newp[1]), rsid(bestSnp(newp[1], b2)), g20, main="raw")
## plot_EvG(probeId(newp[1]), rsid(bestSnp(newp[1], b2)), g20f, main="PC-adjusted")
## plot_EvG(probeId(newp[np]), rsid(bestSnp(newp[np], b2)), g20, main="raw")
## plot_EvG(probeId(newp[np]), rsid(bestSnp(newp[np], b2)), g20f, main="PC-adjusted")


###################################################
### code chunk number 39: domoo
###################################################
library(Biobase)
suppressPackageStartupMessages(library(GGtools))
ex = matrix(0, nr=5, nc=3)
pd = data.frame(v1 = 1:3, v2=5:7)
colnames(ex) = rownames(pd) = LETTERS[1:3]
adf = AnnotatedDataFrame(pd)
rownames(ex) = letters[1:5]
es = ExpressionSet(ex, phenoData=adf)
exprs(es)
pData(es)
library(snpStats)
mysnps = matrix(rep(1:3, 10), nr=3)  # note 1=A/A, ... 0 = NA
rownames(mysnps) = colnames(ex)
mysm = new("SnpMatrix", mysnps)
as(mysm, "character")
as(mysm, "numeric")
sml = make_smlSet(es, list(c1=mysm))
annotation(sml)
colnames(smList(sml)[[1]])


###################################################
### code chunk number 40: getss
###################################################
toLatex(sessionInfo())


