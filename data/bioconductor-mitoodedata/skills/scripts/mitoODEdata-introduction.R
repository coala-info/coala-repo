# Code example from 'mitoODEdata-introduction' vignette. See references/ for full tutorial.

### R code from vignette source 'mitoODEdata-introduction.Rnw'

###################################################
### code chunk number 1: lib
###################################################
library("mitoODEdata")
tab[1:5,]
anno[1:5,]


###################################################
### code chunk number 2: getspot
###################################################
getsirna(ann="CDH1")
getspot(ann="FGFR2")
getanno(spot=1234, field=c("hgnc", "entrez", "genename"))


###################################################
### code chunk number 3: fig1plo
###################################################
spotid <- getspot(ann="FGFR2")[1]
y <- readspot(spotid)
y[1:10,]
plotspot(spotid)


