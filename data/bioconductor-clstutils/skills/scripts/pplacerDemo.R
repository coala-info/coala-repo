# Code example from 'pplacerDemo' vignette. See references/ for full tutorial.

### R code from vignette source 'pplacerDemo.Rnw'

###################################################
### code chunk number 1: pplacerDemo.Rnw:55-57
###################################################
  figdir <- 'figs'
  dir.create(figdir, showWarnings=FALSE)


###################################################
### code chunk number 2: data
###################################################
library(clstutils)

expand <- function(fname){
  orig.dir <- getwd()
  destdir <- tempdir()
  setwd(destdir)
  archive <- system.file('extdata','vaginal_16s.refpkg.tar.gz', package='clstutils')
  system(sprintf('tar --no-same-owner -xzf "%s"', archive))
  setwd(orig.dir)
  file.path(destdir, fname)
}

refpkg <- expand('vaginal_16s.refpkg')
placefile <- system.file('extdata','merged.json', package='clstutils')
distfile <- system.file('extdata','merged.distmat.bz2', package='clstutils')


###################################################
### code chunk number 3: treeDists
###################################################
treedists <- treeDists(distfile=distfile, placefile=placefile)


###################################################
### code chunk number 4: taxonomyFromRefpkg
###################################################
taxdata <- taxonomyFromRefpkg(refpkg, seqnames=rownames(treedists$dmat), lowest_rank='species')


###################################################
### code chunk number 5: pplacerDemo.Rnw:141-142
###################################################
placetab <- data.frame(at=49, edge=5.14909e-07, branch=5.14909e-07)


###################################################
### code chunk number 6: pplacerDemo.Rnw:151-153
###################################################
cdata <- classifyPlacements(taxdata, treedists, placetab)
cdata


