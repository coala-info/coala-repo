# Code example from 'SVAPLSseq' vignette. See references/ for full tutorial.

### R code from vignette source 'SVAPLSseq.Rnw'

###################################################
### code chunk number 1: SVAPLSseq.Rnw:5-6
###################################################
options(width=65)


###################################################
### code chunk number 2: style-Sweave
###################################################
BiocStyle::latex()


###################################################
### code chunk number 3: input
###################################################
library(SummarizedExperiment)
library(SVAPLSseq)
library(edgeR)

##Loading the simulated RNAseq gene expression count dataset 'sim.dat'
data(sim.dat)
dat = SummarizedExperiment(assays = SimpleList(counts = sim.dat))
dat = DGEList(counts = sim.dat)
sim.dat[1:6, c(1:3, 11:13)]


###################################################
### code chunk number 4: input
###################################################
data(sim.dat)
group = as.factor(c(rep(1, 10), rep(-1, 10)))
sim.dat.se = SummarizedExperiment(assays = SimpleList(counts = sim.dat))
sim.dat.dg = DGEList(counts = sim.dat)

sv <- svplsSurr(dat = sim.dat.se, group = group, max.surrs = 3, surr.select =
                  "automatic", controls = NULL)

slotNames(sv)
head(surr(sv))
head(prop.vars(sv))


###################################################
### code chunk number 5: input
###################################################
data(sim.dat)
controls = c(1:nrow(sim.dat)) > 400
group = as.factor(c(rep(1, 10), rep(-1, 10)))
sim.dat.se = SummarizedExperiment(assays = SimpleList(counts = sim.dat))
sim.dat.dg = DGEList(counts = sim.dat)

sv <- svplsSurr(dat = sim.dat.se, group = group, max.surrs = 3, surr.select =
                  "automatic", controls = controls)

slotNames(sv)
head(surr(sv))
head(prop.vars(sv))


###################################################
### code chunk number 6: input
###################################################
data(sim.dat)
group = as.factor(c(rep(1, 10), rep(-1, 10)))
sv = svplsSurr(dat = sim.dat, group = group)
surr = surr(sv)

sim.dat.se = SummarizedExperiment(assays = SimpleList(counts = sim.dat))
sim.dat.dg = DGEList(counts = sim.dat)

fit = svplsTest(dat = sim.dat.se, group = group, surr = surr, normalization =
                  "TMM", test = "t-test")

head(sig.features(fit))
head(pvs.unadj(fit))
head(pvs.adj(fit))


