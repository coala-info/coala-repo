# Code example from 'gCMAPWeb' vignette. See references/ for full tutorial.

### R code from vignette source 'gCMAPWeb.Rnw'

###################################################
### code chunk number 1: gCMAPWeb.Rnw:175-183
###################################################
library(gCMAPWeb)
data( "cmap1" )
cmap1
experimentData( cmap1 )@title
abstract( cmap1 )

data( "cmap5" )
cmap5


###################################################
### code chunk number 2: gCMAPWeb.Rnw:190-191
###################################################
cmap1@experimentData@other$supported.query <- c("unsigned", "directional")


###################################################
### code chunk number 3: gCMAPWeb.Rnw:198-202
###################################################
head( pData( cmap1 ), n=3)
varMetadata( cmap1 )
varMetadata( cmap1 )$include <- c(TRUE, TRUE, FALSE)
varMetadata( cmap1 )


###################################################
### code chunk number 4: gCMAPWeb.Rnw:476-477
###################################################
sessionInfo()


