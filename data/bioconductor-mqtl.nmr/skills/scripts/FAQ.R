# Code example from 'FAQ' vignette. See references/ for full tutorial.

### R code from vignette source 'FAQ.Rnw'

###################################################
### code chunk number 1: style
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: FAQ.Rnw:60-67 (eval = FALSE)
###################################################
##   ## Exchange the function setupRSPA()in the namespace of the mQTL.NMR package
##   unlockBinding("setupRSPA", as.environment("package:mQTL.NMR"))
##   assignInNamespace("setupRSPA", MysetupRSPA, ns="mQTL.NMR", 
##   envir=as.environment("package:mQTL.NMR"))
##   assign("setupRSPA", MysetupRSPA, as.environment("package:mQTL.NMR"))
##   lockBinding("setupRSPA", as.environment("package:mQTL.NMR"))
##   ppmToPt<-mQTL.NMR:::ppmToPt


###################################################
### code chunk number 3: FAQ.Rnw:83-84
###################################################
sessionInfo()


