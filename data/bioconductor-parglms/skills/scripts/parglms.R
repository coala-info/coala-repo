# Code example from 'parglms' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown()

## ----dodisp-------------------------------------------------------------------
library(MASS)
library(BatchJobs)
data(anorexia)  # N = 72
myr = makeRegistry("abc", file.dir=tempfile())
chs = chunk(1:nrow(anorexia), n.chunks=18) # 4 recs/chunk
f = function(x) anorexia[x,]
options(BBmisc.ProgressBar.style="off")
batchMap(myr, f, chs)
showStatus(myr)

## ----execdisp, results="hide", echo=FALSE-------------------------------------
suppressMessages(submitJobs(myr,progressbar=FALSE))
waitForJobs(myr) 

## ----fakk, eval=FALSE---------------------------------------------------------
# submitJobs(myr)
# waitForJobs(myr)

## ----lkres--------------------------------------------------------------------
loadResult(myr,1)

## ----dopar--------------------------------------------------------------------
library(parglms)
pp = parGLM( Postwt ~ Treat + Prewt, myr,
   family=gaussian, binit = c(0,0,0,0), maxit=10, tol=.001 )
names(pp)
pp$coef

## ----defineUpdate, eval=FALSE-------------------------------------------------
# litdec = function(grWithFDR) {
#  tmp = grWithFDR
#  library(gQTLstats)
#  if (!exists("hmm878")) data(hmm878)
#  seqlevelsStyle(hmm878) = "NCBI"
#  library(GenomicRanges)
#  ov = findOverlaps(tmp, hmm878)
#  states = hmm878$name
#  states[ which(states %in% c("13_Heterochrom/lo", "14_Repetitive/CNV",
#       "15_Repetitive/CNV")) ] = "hetrep_1315"
#  levs = unique(states)
#  tmp$hmmState = factor(rep("hetrep_1315", length(tmp)),levels=levs)
#  tmp$hmmState = relevel(tmp$hmmState, "hetrep_1315")
#  tmp$hmmState[ queryHits(ov) ] = factor(states[ subjectHits(ov) ],
#    levels=levs)
#  if (!exists("gwrngs19")) data(gwrngs19)
#  library(GenomeInfoDb)
#  seqlevelsStyle(gwrngs19) = "NCBI"
#  tmp$isGwasHit = 1*(tmp %in% gwrngs19)
#  tmp
# }
# 
# decorate = function(grWithFDR) {
# #
# # the data need a distance/MAF filter
# #
#  library(gQTLstats)
#  data(filtFDR)
#  if (!exists("hmm878")) data(hmm878)
#  library(gwascat)
#  if (!exists("gwrngs19")) data(gwrngs19)
#  if (!exists("gwastagger")) data(gwastagger) # will use locations here
#  library(GenomeInfoDb)
#  seqlevelsStyle(hmm878) = "NCBI"
#  seqlevelsStyle(gwrngs19) = "NCBI"
#  seqlevelsStyle(gwastagger) = "NCBI"
#  tmp = grWithFDR
#  tmp$isGwasHit = 1*(tmp %in% gwrngs19)
#  tmp$isGwasTagger = 1*(tmp %in% gwastagger)
#  #levs = unique(hmm878$name)
#  library(GenomicRanges)
#  ov = findOverlaps(tmp, hmm878)
#  states = hmm878$name
#  states[ which(states %in% c("13_Heterochrom/lo", "14_Repetitive/CNV",
#       "15_Repetitive/CNV")) ] = "hetrep_1315"
#  levs = unique(states)
#  tmp$hmmState = factor(rep("hetrep_1315", length(tmp)),levels=levs)
#  tmp$hmmState = relevel(tmp$hmmState, "hetrep_1315")
#  tmp$hmmState[ queryHits(ov) ] = factor(states[ subjectHits(ov) ],
#    levels=levs)
#  tmp$estFDR = getFDRfunc(filtFDR)( tmp$chisq )
#  tmp$fdrcat = cut(tmp$estFDR, c(-.01, .01, .05, .1, .25, .5, 1.01))
#  tmp$fdrcat = relevel(tmp$fdrcat, "(0.5,1.01]")
#  #tmp$distcat = cut(tmp$mindist, c(-1,0,1000,5000,10000,50000,100000,250000,500001))
#  tmp$distcat = cut(tmp$mindist, c(-1,0,1000,5000,10000,25000,50001))
#  #tmp$distcat = relevel(tmp$distcat, "(2.5e+05,5e+05]")
#  tmp$distcat = relevel(tmp$distcat, "(2.5e+04,5e+04]")
#  tmp$MAFcat = cut(tmp$MAF, c(.049, .075, .1, .25, .51))
#  tmp$MAFcat = relevel(tmp$MAFcat, "(0.25,0.51]")
#  kp = c("seqnames", "start", "probeid", "snp", "estFDR", "fdrcat", "hmmState",
#   "distcat", "MAFcat", "isGwasHit", "isGwasTagger")
#  names(tmp) = NULL
#  as(tmp, "data.frame")[,kp]
# }

## ----doge, eval=FALSE---------------------------------------------------------
# suppressPackageStartupMessages({
# library(geuvStore2)
# library(gQTLBase)
# library(gQTLstats)
# })
# prst = g17transRegistry()

## ----domod,eval=FALSE---------------------------------------------------------
# prst$extractor = function(store,i) litdec(loadResult(store,i)[[1]])
# p1 = parGLM( isGwasHit ~ hmmState, prst,
#    family=binomial, binit=rep(0,13), tol=.001,
#    maxit = 10 )
# summaryPG(p1)
# #ans= list(coef=p1$coef, s.e.=sqrt(diag(p1$eff.var)))
# #ans$z = ans[[1]]/ans[[2]]
# #do.call(cbind, ans)

