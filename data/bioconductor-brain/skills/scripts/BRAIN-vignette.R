# Code example from 'BRAIN-vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'BRAIN-vignette.Rnw'

###################################################
### code chunk number 1: BRAIN-vignette.Rnw:14-15
###################################################
library(BRAIN)


###################################################
### code chunk number 2: BRAIN-vignette.Rnw:67-76
###################################################
#angiotensineII
angiotensineII <- list(C=50,H=71,N=13,O=12) 
monoisotopicMassAngiotensineII <- calculateMonoisotopicMass(aC = angiotensineII)
monoisotopicMassAngiotensineII

#human dynein heavy chain
humandynein <- list(C=23832,H=37816,N=6528,O=7031,S=170) 
monoisotopicMassHumandynein <- calculateMonoisotopicMass(aC = humandynein)
monoisotopicMassHumandynein


###################################################
### code chunk number 3: BRAIN-vignette.Rnw:91-98
###################################################
#angiotensineII
averageMassAngiotensineII <- calculateAverageMass(aC = angiotensineII)
averageMassAngiotensineII

#humandynein
averageMassHumandynein <- calculateAverageMass(aC = humandynein)
averageMassHumandynein


###################################################
### code chunk number 4: BRAIN-vignette.Rnw:104-112
###################################################
#angiotensineII
nrPeaksAngiotensineII <- calculateNrPeaks(aC = angiotensineII)
nrPeaksAngiotensineII


#human dynein heavy chain
nrPeaksHumandynein <- calculateNrPeaks(aC = humandynein)
nrPeaksHumandynein


###################################################
### code chunk number 5: BRAIN-vignette.Rnw:119-154
###################################################
#angiotensineII

#with default options
prob1 <- calculateIsotopicProbabilities(aC = angiotensineII)
print(length(prob1))

#with user defined number of requested aggregated isotopic variants
prob2 <- calculateIsotopicProbabilities(aC = angiotensineII, nrPeaks=20)
print(length(prob2))

#with user-defined coverage as stopping criterium
prob3 <- calculateIsotopicProbabilities(aC = angiotensineII, 
stopOption = "coverage", coverage = 0.99)
print(length(prob3))  

#with user-defined abundantEstim as stopping criterium
prob4 <- calculateIsotopicProbabilities(aC = angiotensineII, 
stopOption = "abundantEstim", abundantEstim = 10)
print(length(prob4))


#human dynein heavy chain
prob1 <- calculateIsotopicProbabilities(aC = humandynein)
print(length(prob1))

prob2 <- calculateIsotopicProbabilities(aC = humandynein, nrPeaks=300)
print(length(prob2))

prob3 <- calculateIsotopicProbabilities(aC = humandynein, 
stopOption = "coverage", coverage = 0.99)
print(length(prob3))

prob4 <- calculateIsotopicProbabilities(aC = humandynein, 
stopOption = "abundantEstim", abundantEstim = 150)
print(length(prob4))


###################################################
### code chunk number 6: BRAIN-vignette.Rnw:160-173
###################################################
#angiotensineII
headr <- expression(paste(C[50], H[71], N[13],O[12]))
#with default options
res <- useBRAIN(aC= angiotensineII) 
plot(res$masses,res$isoDistr,xlab="mass",ylab="abundances", type="h", 
xlim=c(min(res$masses)-1,max(res$masses)+1.5))
title(headr)
labelMono <- paste("mono-isotopic mass:", res$monoisotopicMass, "Da", sep=" ")
labelAvg <- paste("average mass:", res$avgMass, "Da", sep=" ")
text(x=1048.7, y=0.5, labelMono, col="purple")
text(x=1048.7, y=0.45, labelAvg, col="blue")
lines(x=rep(res$monoisotopicMass[1],2),y=c(0,res$isoDistr[1]), col = "purple")
lines(x=rep(res$avgMass,2),y=c(0,max(res$isoDistr)), col = "blue", lty=2)


###################################################
### code chunk number 7: BRAIN-vignette.Rnw:177-192
###################################################
#human dynein heavy chain
headr <- expression(paste(C[23832], H[37816], N[6528],O[7031], S[170]))
res <- useBRAIN(aC=humandynein, stopOption="coverage", coverage=0.99) 
plot(res$masses,res$isoDistr,xlab="mass",ylab="abundances", type="h", 
xlim=c(min(res$masses)-1,max(res$masses)+1))
title(headr)
labelMono <- paste("mono-isotopic mass: ", res$monoisotopicMass, "Da", sep="")
labelAvg <- paste("average mass: ", res$avgMass, "Da", sep="")
mostAbundant <- res$masses[which.max(res$isoDistr)]
labelAbundant <- paste("most abundant mass: ", mostAbundant, "Da", sep="")
text(x=533550, y=0.02, labelMono, col="purple")
text(x=533550, y=0.0175, labelAvg, col="blue")
text(x=533550, y=0.015, labelAbundant, col="red")
lines(x=rep(res$avgMass,2),y=c(0,max(res$isoDistr)), col = "blue", lty=2)
lines(x=rep(mostAbundant,2),y=c(0,max(res$isoDistr)), col = "red")


###################################################
### code chunk number 8: BRAIN-vignette.Rnw:201-216
###################################################
#with user defined number of requested aggregated isotopic variants
res <- useBRAIN(aC = angiotensineII, nrPeaks = 20) 
plot(res$masses,res$isoDistr,xlab="mass",ylab="abundances", type="h", 
xlim=c(min(res$masses)-1,max(res$masses)+1))
title(headr)
#with user defined coverage as stopping criterium
res <- useBRAIN(aC = angiotensineII, stopOption = "coverage", coverage = 0.99) 
plot(res$masses,res$isoDistr,xlab="mass",ylab="abundances", type="h", 
xlim=c(min(res$masses)-1,max(res$masses)+1))
title(headr)
#with user defined abundantEstim as stopping criterium
res <- useBRAIN(aC = angiotensineII, stopOption = "abundantEstim", abundantEstim = 10) 
plot(res$masses,res$isoDistr,xlab="mass",ylab="abundances", type="h", 
xlim=c(min(res$masses)-1,max(res$masses)+1))
title(headr)


###################################################
### code chunk number 9: BRAIN-vignette.Rnw:234-237 (eval = FALSE)
###################################################
## tabUniprot <- read.table('data/uniprot.tab', sep="\t", header=TRUE) 
## tabUniprot$Sequence <- gsub(" ", "", tabUniprot$Sequence)
## howMany <- nrow(tabUniprot)


###################################################
### code chunk number 10: BRAIN-vignette.Rnw:247-250 (eval = FALSE)
###################################################
## AMINOS <- c("A", "R", "N", "D", "C", "E", "Q", "G", "H", "I", "L", "K", 
## "M", "F", "P", "S", "T", "W", "Y", "V")
## !is.na(sum(match(seqVector, AMINOS)))


###################################################
### code chunk number 11: BRAIN-vignette.Rnw:258-284 (eval = FALSE)
###################################################
## nrPeaks = 1000
## howMany <- nrow(tabUniprot)
## dfUniprot <- data.frame()
## for (idx in 1:howMany){
##   seq <- as.character(tabUniprot[idx,"Sequence"])
##   seqVector <- strsplit(seq, split="")[[1]]
##   if (!is.na(sum(match(seqVector, AMINOS)))){  
##   aC <- getAtomsFromSeq(seq)
##   res <- useBRAIN(aC = aC, nrPeaks = nrPeaks, stopOption = "abundantEstim", 
## abundantEstim = 10)
##   isoDistr <- res$isoDistr
##   masses <- res$masses
##   maxIdx <- which.max(isoDistr)
##   mostAbundantPeakMass <- masses[maxIdx]
##   monoMass <- res$monoisotopicMass  
##   dfAtomicComp <- data.frame(C=aC[1], H=aC[2], N=aC[3], O=aC[4], S=aC[5])
##   singleDfUniprot <- data.frame(dfAtomicComp, monoMass=monoMass, maxIdx=maxIdx, 
## mostAbundantPeakMass=mostAbundantPeakMass  
##   )
##   if (!is.na(monoMass)){ #for huge atomic configuration numerical problems may occur
##     dfUniprot <- rbind(dfUniprot, singleDfUniprot)
##   }
##   }
## }
## 
## write.table(unique(dfUniprot), "data/uniprotBRAIN.txt")


###################################################
### code chunk number 12: BRAIN-vignette.Rnw:295-297
###################################################
uniprotBRAIN <- read.table(system.file("extdata", "uniprotBRAIN.txt", package="BRAIN"))
nrow(uniprotBRAIN)


###################################################
### code chunk number 13: uniprot_10_5
###################################################
uniprot10to5 <- uniprotBRAIN[uniprotBRAIN$monoMass < 10^5,]
nrow(uniprot10to5)


###################################################
### code chunk number 14: BRAIN-vignette.Rnw:310-317
###################################################
library(lattice)
mm <- uniprot10to5$monoMass
mmMin <- floor(min(mm)) - 1
mmMax <- ceiling(max(mm)) + 1
sq <- seq(from=0, to=mmMax, by=5000)
bw <- bwplot(cut(monoMass, sq) ~ mostAbundantPeakMass, data=uniprot10to5, ylab="monoMass (Da)", xlab="mostAbundantPeakMass (Da)")
plot(bw)


###################################################
### code chunk number 15: BRAIN-vignette.Rnw:320-323
###################################################
bw2 <- bwplot(cut(monoMass, sq) ~ (mostAbundantPeakMass - monoMass), 
data=uniprot10to5,  ylab="monoMass (Da)", xlab="mostAbundantPeakMass - monoMass (Da)")
plot(bw2)


###################################################
### code chunk number 16: BRAIN-vignette.Rnw:333-335
###################################################
lmod <- lm(monoMass ~ mostAbundantPeakMass, data=uniprot10to5)
summary(lmod)


###################################################
### code chunk number 17: BRAIN-vignette.Rnw:354-361
###################################################
icptLm <- lmod$coefficients[1]
cffLm <- lmod$coefficients[2]
expected <- icptLm + cffLm * uniprot10to5$mostAbundantPeakMass
residuals <- uniprot10to5$monoMass - expected
hist <- hist(residuals, seq(floor(min(residuals)),ceiling(max(residuals)), by=0.1), 
main="", xlab="residuals of the linear model (Da)")
plot(hist)


###################################################
### code chunk number 18: BRAIN-vignette.Rnw:371-396
###################################################

benchmarkRCL <- function(aC, nrPeaks){
  print("Benchmarking correctness of approximations of results:")
  resNoRCL <-  useBRAIN2(aC = aC, nrPeaks = nrPeaks)$iso
  resRCL   <-  useBRAIN2(aC = aC, nrPeaks = nrPeaks, approxParam = 10)$iso
  print(c('max error: ', max(abs(resNoRCL - resRCL))))
  print(c('>> max result no RCL:  ', max(resNoRCL)))
  print(c('>> max result with RCL:', max(resRCL)))
  print("\nBenchmarking time performance")
  print("No RCL: 10 replications")
  print(system.time( 
        replicate(10, useBRAIN2(aC = aC, nrPeaks = nrPeaks)$iso ) ))
  print("With RCL: 10 replications")
  print(system.time( 
        replicate(
          10, useBRAIN2(aC = aC, nrPeaks = nrPeaks, approxParam = 10)$iso )))

  
}

#angiotensineII
benchmarkRCL(aC = angiotensineII, nrPeaks = 50)

#humandynein
benchmarkRCL(aC = humandynein, nrPeaks = 1000)


###################################################
### code chunk number 19: BRAIN-vignette.Rnw:404-438
###################################################

benchmarkLSP <- function(aC, startIdx, endIdx){
  print("Benchmarking correctness of approximations of results:")
  burn_in = 11 ##inspired by BRAIN 2.0 paper
  resNoLSP <-  useBRAIN2(aC = aC, nrPeaks = endIdx)$iso
  approxStart <- ifelse(1 <= startIdx-burn_in+1, startIdx-burn_in+1, 1) 
  resLSP   <-  useBRAIN2(aC = aC, nrPeaks = endIdx, approxStart = approxStart)$iso
  print(c('length(resNoLSP): ', length(resNoLSP)))
  print(c('length(resLSP): ', length(resLSP)))
  resNoLSP_truncate = resNoLSP[startIdx:endIdx]
  resLSP_truncate = resLSP[burn_in:length(resLSP)] ###remove peaks from burn_in region
  print(c('Note, absolute values might vary'))
  print(c('>> max result no RCL:  ', max(resNoLSP_truncate)))
  print(c('>> max result with RCL:  ', max(resLSP_truncate)))
  ratiosNoLSP = resNoLSP_truncate/max(resNoLSP_truncate)
  ratiosLSP = resLSP_truncate/max(resLSP_truncate)
  print(c('max error in interesting region: ', max(abs(ratiosNoLSP - ratiosLSP))))
  print(c('>> top 3 ratios no RCL:  ', 
        sort(ratiosNoLSP, decreasing = TRUE)[1:3]))##we assume at least 3 values
  print(c('>> top 3 ratios with RCL:', 
        sort(ratiosLSP, decreasing = TRUE)[1:3]))##we assume at least 3 values
  print("\nBenchmarking time performance")
  print("No RCL: 10 replications")
  print(system.time( replicate(10, useBRAIN2(aC = aC, nrPeaks = endIdx)$iso )))
  print("With RCL: 10 replications")
  print(system.time( 
        replicate(
         10, useBRAIN2(aC=aC, nrPeaks= endIdx, approxStart=approxStart)$iso )))

  
}

#humandynein
benchmarkLSP(aC = humandynein, startIdx = 210, endIdx = 450)


