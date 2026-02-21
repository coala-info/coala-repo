# Code example from 'idiogram' vignette. See references/ for full tutorial.

### R code from vignette source 'idiogram.Rnw'

###################################################
### code chunk number 1: idiogram.Rnw:62-76
###################################################
  if(require(hu6800.db) && require(golubEsets)){
	library(golubEsets)
	data(golubTrain)
	library(hu6800.db)
	library(idiogram)
	library(annotate)

	hu.chr <- buildChromLocation("hu6800")
        ex <- golubTrain@exprs[,1]
	colors <- rep("black",times=length(ex))
        colors[ex > 10000] <- "red"
        pts <- rep(1,times=length(ex))
        pts[ex > 10000] <- 2
}


###################################################
### code chunk number 2: idiogram.Rnw:84-88
###################################################
  if(require(hu6800.db) && require(golubEsets)){	
	idiogram(ex,hu.chr,chr="1",col=colors,
	  pch=pts,font.axis=2,cex.axis=1)
}


