# Code example from 'Fletcher2013a' vignette. See references/ for full tutorial.

### R code from vignette source 'Fletcher2013a.Rnw'

###################################################
### code chunk number 1: Ropts
###################################################
options(width=70)


###################################################
### code chunk number 2: Load gene expression datasets
###################################################
  library(Fletcher2013a)
  data(Exp1)
  data(Exp2)
  data(Exp3)


###################################################
### code chunk number 3: Run limma pipeline (eval = FALSE)
###################################################
##   Fletcher2013pipeline.limma(Exp1)
##   Fletcher2013pipeline.limma(Exp2)
##   Fletcher2013pipeline.limma(Exp3)


###################################################
### code chunk number 4: Get DE gene lists
###################################################
  deExp1 <- Fletcher2013pipeline.deg(what="Exp1")
  deExp2 <- Fletcher2013pipeline.deg(what="Exp2")
  deExp3 <- Fletcher2013pipeline.deg(what="Exp3")


###################################################
### code chunk number 5: Run PCA analysis (eval = FALSE)
###################################################
##   Fletcher2013pipeline.pca(Exp1)
##   Fletcher2013pipeline.pca(Exp2)
##   Fletcher2013pipeline.pca(Exp3)


###################################################
### code chunk number 6: Plot overlap among FGFR2 signatures (eval = FALSE)
###################################################
##   library(VennDiagram)
##   Fletcher2013pipeline.supp()


###################################################
### code chunk number 7: Plot overlap among FGFR2 signatures (eval = FALSE)
###################################################
##   #note: in order to run this option, the source code for the R-package Vennerable
##   #should be installed from the R-Forge repository (http://R-Forge.R-project.org)
##   library(Vennerable)
##   vv <- list(Exp1=deExp1$E2FGF10, Exp2=deExp2$E2AP20187, Exp3=deExp3$TetE2FGF10)
##   plotVenn(Venn(vv), doWeights=TRUE)


###################################################
### code chunk number 8: Session information
###################################################
print(sessionInfo(), locale=FALSE)


