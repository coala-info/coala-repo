# Code example from 'pepXMLTab' vignette. See references/ for full tutorial.

### R code from vignette source 'pepXMLTab.Rnw'

###################################################
### code chunk number 1: options
###################################################
options(width=70)


###################################################
### code chunk number 2: loadpkg
###################################################
library(pepXMLTab)


###################################################
### code chunk number 3: pepTab
###################################################
#MyriMatch example
pepxml <- system.file("extdata/pepxml", "Myrimatch.pepXML", 
    package="pepXMLTab")
tttt <- pepXML2tab(pepxml)
tttt[1:2,]

#Mascot example
pepxml <- system.file("extdata/pepxml", "Mascot.pepXML", package="pepXMLTab")
tttt <- pepXML2tab(pepxml)
tttt[1:2,]

#SEQUEST example
pepxml <- system.file("extdata/pepxml", "SEQUEST.pepXML", package="pepXMLTab")
tttt <- pepXML2tab(pepxml)
tttt[1:2,]

#XTandem example
pepxml <- system.file("extdata/pepxml", "XTandem.pepXML", package="pepXMLTab")
tttt <- pepXML2tab(pepxml)
tttt[1:2,]



###################################################
### code chunk number 4: filter
###################################################
## MyriMatch example
pepxml <- system.file("extdata/pepxml", "Myrimatch.pepXML", 
        package="pepXMLTab")
tttt <- pepXML2tab(pepxml)
passed <- PSMfilter(tttt, pepFDR=0.01, scorecolumn='mvh', hitrank=1, 
        minpeplen=6, decoyprefix='rev_')
passed[1, ]


###################################################
### code chunk number 5: SessionInfo
###################################################
sessionInfo()


