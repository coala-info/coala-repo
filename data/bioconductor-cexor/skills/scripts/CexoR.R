# Code example from 'CexoR' vignette. See references/ for full tutorial.

### R code from vignette source 'CexoR.Rnw'

###################################################
### code chunk number 1: style
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: setup
###################################################
options(width=200)
options(continue=" ")
options(prompt="R> ")


###################################################
### code chunk number 3: Call reproducible peak-pairs in ChIP-exo replicates
###################################################
options(width=60)
## hg19. chr2:1-1,000,000

owd <- setwd(tempdir())

library(CexoR)
rep1 <- "CTCF_rep1_chr2_1-1e6.bam"
rep2 <- "CTCF_rep2_chr2_1-1e6.bam"
rep3 <- "CTCF_rep3_chr2_1-1e6.bam"
r1 <- system.file("extdata", rep1, package="CexoR",mustWork = TRUE)
r2 <- system.file("extdata", rep2, package="CexoR",mustWork = TRUE)
r3 <- system.file("extdata", rep3, package="CexoR",mustWork = TRUE)

peak_pairs <- cexor(bam=c(r1,r2,r3), chrN="chr2", chrL=1e6, idr=0.01, N=3e4, p=1e-12)

peak_pairs$bindingEvents

peak_pairs$bindingCentres

setwd(owd)



###################################################
### code chunk number 4: Visualisation of ChIP-exo replicates (eval = FALSE)
###################################################
## options(width=60)
## plotcexor(bam=c(r1,r2,r3), peaks=peak_pairs, EXT=500)


###################################################
### code chunk number 5: sessionInfo
###################################################
sessionInfo()


