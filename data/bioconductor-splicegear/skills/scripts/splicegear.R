# Code example from 'splicegear' vignette. See references/ for full tutorial.

### R code from vignette source 'splicegear.Rnw'

###################################################
### code chunk number 1: R.hide
###################################################
library(splicegear)


###################################################
### code chunk number 2: splicegear.Rnw:95-100
###################################################
data(spsites)

print(spsites)

plot(spsites)


###################################################
### code chunk number 3: splicegear.Rnw:118-121
###################################################
library(XML)
filename <- system.file("extdata", "example.xml", package="splicegear")
xml <- xmlTreeParse(filename, asTree=TRUE)


###################################################
### code chunk number 4: splicegear.Rnw:127-130
###################################################
spsites <- buildSpliceSites(xml, verbose=FALSE)
length(spsites)
show(spsites[1:2])


###################################################
### code chunk number 5: splicegear.Rnw:150-158
###################################################
## build SpliceSites
library(XML)
filename <- system.file("extdata", "example.xml", package="splicegear")
xml <- xmlTreeParse(filename, asTree=TRUE)
spsites <- buildSpliceSites(xml, verbose=FALSE)

## subset the second object in the list
my.spsites <- spsites[[2]]


###################################################
### code chunk number 6: splicegear.Rnw:161-162
###################################################
plot(my.spsites)


###################################################
### code chunk number 7: splicegear.Rnw:178-183
###################################################
data(spliceset)

dataf <- as.data.frame(spliceset)

colnames(dataf)


###################################################
### code chunk number 8: splicegear.Rnw:187-197
###################################################
lm.panel <- function(x, y, ...) {
                                  points(x,y,...)
                                  p.lm <- lm(y~x); abline(p.lm)
                                }

## to plot probe intensity values conditioned by the position of the probes on
## the mRNA:
## (commented out to avoid a warning)
##coplot(log(exprs) ~ Material | begin, data=dataf, panel=lm.panel)



###################################################
### code chunk number 9: splicegear.Rnw:220-231
###################################################
## a 10 bp window
seq.length <- as.integer(10)
## positions of the exons
spsiteIpos <- matrix(c(1, 3.5, 5, 9, 3, 4, 8, 10), nc=2)
## known variants
variants <- list(a=c(1,2,3,4), b=c(1,2,3), c=c(1,3,4))
##
n.exons <- nrow(spsiteIpos)

spvar <- new("SpliceSitesGenomic", spsiteIpos=spsiteIpos,
         variants=variants, seq.length=seq.length)


###################################################
### code chunk number 10: splicegear.Rnw:237-240
###################################################
par(mfrow = c(3,1), mar = c(3.1, 2.1, 2.1, 1.1))

plot(spvar, split=TRUE, col.exon=rainbow(n.exons))


