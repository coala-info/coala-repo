# Code example from 'clstDemo' vignette. See references/ for full tutorial.

### R code from vignette source 'clstDemo.Rnw'

###################################################
### code chunk number 1: clstDemo.Rnw:50-52
###################################################
  figdir <- 'figs_out'
  dir.create(figdir, showWarnings=FALSE)


###################################################
### code chunk number 2: clstDemo.Rnw:176-180
###################################################
library(clst)
data(iris)
dmat <- as.matrix(dist(iris[,1:4], method="euclidean"))
groups <- iris$Species


###################################################
### code chunk number 3: clstDemo.Rnw:189-191
###################################################
ii <- c(1,125)
plot(scaleDistPlot(dmat, groups, indices=ii,O=ii))


###################################################
### code chunk number 4: clstDemo.Rnw:207-209
###################################################
thresh <- findThreshold(dmat, groups, type="mutinfo")
str(thresh)


###################################################
### code chunk number 5: clstDemo.Rnw:219-221
###################################################
thresh2 <- findThreshold(dmat, groups, type="mutinfo", prob=NA)
print(thresh2$interval)


###################################################
### code chunk number 6: clstDemo.Rnw:230-231
###################################################
plot(do.call(plotDistances, thresh))


###################################################
### code chunk number 7: clstDemo.Rnw:234-235
###################################################
plot(do.call(plotDistances, thresh2))


###################################################
### code chunk number 8: clstDemo.Rnw:272-280
###################################################
ind <- 1
species <- gettextf('I. %s', groups[ind])
cat('class of "unknown" sample is',species)
dmat1 <- dmat[-ind,-ind]
groups1 <- groups[-ind]
dvect1 <- dmat[ind, -ind]
cc <- classify(dmat1, groups1, dvect1)
printClst(cc)


###################################################
### code chunk number 9: clstDemo.Rnw:290-296
###################################################
ind <- 125
species = gettextf('I. %s', groups[ind])
pp <- pull(dmat, groups, ind)
cc <- do.call(classify, pp)
cat(paste('class of "unknown" sample is', species))
printClst(cc)


###################################################
### code chunk number 10: clstDemo.Rnw:306-312
###################################################
loo <- lapply(seq_along(groups), function(i){
  do.call(classify, pull(dmat, groups, i))
})
matches <- lapply(loo, function(x) rev(x)[[1]]$matches)
result <- sapply(matches, paste, collapse='-')
table(ifelse(result=='','no match',result),groups)


###################################################
### code chunk number 11: clstDemo.Rnw:321-324
###################################################
 confusion <- sapply(matches, length) > 1
 no_match <- sapply(matches, length) < 1
 plot(scaleDistPlot(dmat, groups, fill=confusion, O=confusion, X=no_match))


###################################################
### code chunk number 12: clstDemo.Rnw:337-345
###################################################

loo <- lapply(seq_along(groups), function(i){
 do.call(classify, c(pull(dmat, groups, i),minScore=0.65))
})

matches <- lapply(loo, function(x) rev(x)[[1]]$matches)
result <- sapply(matches, paste, collapse='-')
table(ifelse(result=='','no match',result),groups)


###################################################
### code chunk number 13: clstDemo.Rnw:350-354
###################################################
 confusion <- sapply(matches, length) > 1
 no_match <- sapply(matches, length) < 1
 plot(scaleDistPlot(dmat, groups, fill=confusion, O=confusion,
                    X=no_match, indices=no_match))


###################################################
### code chunk number 14: clstDemo.Rnw:367-368
###################################################
printClst(loo[[118]])


