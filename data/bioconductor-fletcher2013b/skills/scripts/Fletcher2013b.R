# Code example from 'Fletcher2013b' vignette. See references/ for full tutorial.

### R code from vignette source 'Fletcher2013b.Rnw'

###################################################
### code chunk number 1: Ropts
###################################################
options(width=70)


###################################################
### code chunk number 2: Load DE gene lists (eval = FALSE)
###################################################
##   library(Fletcher2013b)
##   data(rtni1st)
##   data(rtni2nd)
##   data(rtniNormals)
##   data(rtniTALL)


###################################################
### code chunk number 3: Load DE gene lists (eval = FALSE)
###################################################
##   sigt <- Fletcher2013pipeline.deg(what="Exp1",idtype="entrez")
##   MRA1 <- Fletcher2013pipeline.mra1st(hits=sigt$E2FGF10, verbose=FALSE)


###################################################
### code chunk number 4: Run MRA analysis (eval = FALSE)
###################################################
##   MRA2 <- Fletcher2013pipeline.mra2nd(hits=sigt$E2FGF10)
##   MRA3 <- Fletcher2013pipeline.mraNormals(hits=sigt$E2FGF10)
##   MRA4 <- Fletcher2013pipeline.mraTALL(hits=sigt$E2FGF10)


###################################################
### code chunk number 5: Plot regulons from master regulators (eval = FALSE)
###################################################
##   Fletcher2013pipeline.consensusnet()


###################################################
### code chunk number 6: Plot enrichment map (eval = FALSE)
###################################################
##   Fletcher2013pipeline.enrichmap()


###################################################
### code chunk number 7: Session information
###################################################
print(sessionInfo(), locale=FALSE)


