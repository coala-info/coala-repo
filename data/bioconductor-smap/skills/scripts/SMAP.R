# Code example from 'SMAP' vignette. See references/ for full tutorial.

### R code from vignette source 'SMAP.Rnw'

###################################################
### code chunk number 1: SMAP.Rnw:53-54
###################################################
library(SMAP)


###################################################
### code chunk number 2: SMAP.Rnw:79-86
###################################################
data(GBM)
obs <- SMAPObservations(value=as.numeric(GBM[,2]),
                        chromosome=as.character(GBM[,3]),
                        startPosition=as.numeric(GBM[,4]),
                        endPosition=as.numeric(GBM[,5]),
                        name="G24460",
                        reporterId=as.character(GBM[,1]))


###################################################
### code chunk number 3: SMAP.Rnw:93-94
###################################################
plot(obs, ylab="ratio", ylim=c(0,2))


###################################################
### code chunk number 4: SMAP.Rnw:100-103
###################################################
ids <- which(chromosome(obs) == "9")
plot(obs[ids], ylab="ratio", ylim=c(0,2),
main=paste(name(obs), "chromosome 9"))


###################################################
### code chunk number 5: SMAP.Rnw:136-141
###################################################
init.means <- c(0.4, 0.7, 1, 1.3, 1.6, 3)
init.sds <- rep(0.1, 6)
phi <- cbind(init.means, init.sds)
hmm <- SMAPHMM(noStates=6, Phi=phi, initTrans=0.02)
hmm


###################################################
### code chunk number 6: SMAP.Rnw:201-202
###################################################
    profile <- smap(hmm, obs, verbose=2)


###################################################
### code chunk number 7: SMAP.Rnw:208-209
###################################################
Q(profile)


###################################################
### code chunk number 8: SMAP.Rnw:215-216
###################################################
Phi(HMM(profile))


###################################################
### code chunk number 9: SMAP.Rnw:225-227
###################################################
## Plot results of all data:
plot(profile, ylab="ratio", ylim=c(0,2))


###################################################
### code chunk number 10: SMAP.Rnw:231-235
###################################################
## Plot chromosomes with aberrations:
chrom.selection <- as.character(c(1, 6, 7, 8, 9, 10, 15, 19, 20))
selection <- which(chromosome(obs) %in% chrom.selection)
plot(profile[selection], ylab="ratio", ylim=c(0, 2))


###################################################
### code chunk number 11: SMAP.Rnw:239-245
###################################################
## Plot all chromosomes separately:
par(mfrow=c(3, 3))
for (c in chrom.selection) {
    ids <- which(chromosome(obs) == c)
    plot(profile[ids], ylab="ratio", ylim=c(0, 2), main=c)
}


