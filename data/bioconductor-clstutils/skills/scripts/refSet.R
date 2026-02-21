# Code example from 'refSet' vignette. See references/ for full tutorial.

### R code from vignette source 'refSet.Rnw'

###################################################
### code chunk number 1: refSet.Rnw:54-56
###################################################
  figdir <- 'figs'
  dir.create(figdir, showWarnings=FALSE)


###################################################
### code chunk number 2: loadLibs
###################################################
library(ape)
library(lattice)
library(clst)
library(clstutils)


###################################################
### code chunk number 3: refSet.Rnw:86-88
###################################################
data(seqs)
data(seqdat)


###################################################
### code chunk number 4: refSet.Rnw:96-100
###################################################
seqdat$i <- 1:nrow(seqdat)
taxa <- split(seqdat, seqdat$tax_name)
nseqs <- sapply(taxa, nrow)
nseqs


###################################################
### code chunk number 5: refSet.Rnw:111-112
###################################################
Efaecium <- taxa[['Enterococcus faecium']]$i


###################################################
### code chunk number 6: refSet.Rnw:117-119
###################################################
dmat <- ape::dist.dna(seqs[Efaecium,], pairwise.deletion=TRUE, as.matrix=TRUE, model='raw')
summary(dmat[lower.tri(dmat)])


###################################################
### code chunk number 7: refSet.Rnw:126-128
###################################################
outliers <- clstutils::findOutliers(dmat, cutoff=0.015)
table(outliers)


###################################################
### code chunk number 8: refSet.Rnw:138-142
###################################################
with(seqdat[Efaecium,], {
  prettyTree(nj(dmat), groups=ifelse(outliers,'outlier','non-outlier'),
             X=outliers, labels=ifelse(isType,gettextf('type strain (%s)', accession),NA))
})


###################################################
### code chunk number 9: refSet.Rnw:149-152
###################################################
dmats <- lapply(taxa, function(taxon) {
  ape::dist.dna(seqs[taxon$i,], pairwise.deletion=TRUE, as.matrix=TRUE, model='raw')
})


###################################################
### code chunk number 10: refSet.Rnw:160-161
###################################################
outliers <- sapply(dmats, findOutliers, cutoff=0.015)


###################################################
### code chunk number 11: refSet.Rnw:166-172
###################################################
seqdat$outlier <- FALSE
for(x in outliers){
  seqdat[match(names(x),seqdat$seqname),'outlier'] <- x
}

with(seqdat, table(tax_name, outlier))


###################################################
### code chunk number 12: refSet.Rnw:181-191
###################################################
lowerTriangle <- function(mat){mat[lower.tri(mat)]}

dists <- do.call(rbind, lapply(names(dmats), function(tax_name){
  dmat <- dmats[[tax_name]]
  omat <- sapply(outliers[[tax_name]], function(i) {i | outliers[[tax_name]]})
  data.frame(distance=lowerTriangle(dmat), outlier=lowerTriangle(omat))
}))

dists$tax_name <- factor(rep(names(dmats), nseqs*(nseqs-1)/2))
with(dists, table(tax_name, outlier))


###################################################
### code chunk number 13: refSet.Rnw:194-195
###################################################
plot(bwplot(distance ~ tax_name, data=dists, ylim=c(0,0.15)))


###################################################
### code chunk number 14: refSet.Rnw:198-199
###################################################
plot(bwplot(distance ~ tax_name, data=subset(dists, !outlier), ylim=c(0,0.15)))


###################################################
### code chunk number 15: refSet.Rnw:208-215
###################################################
with(seqdat, {
  dmat <- ape::dist.dna(seqs, pairwise.deletion=TRUE, as.matrix=TRUE, model='raw')
  clstutils::prettyTree(nj(dmat), groups=tax_name,
                        ## type='unrooted',
                        X=outlier, fill=outlier)
})



###################################################
### code chunk number 16: refSet.Rnw:230-238
###################################################
with(seqdat[Efaecium,], {
  selected <- clstutils::maxDists(dmat, idx=which(isType),
                                  N=10, exclude=outlier, include.center=TRUE)
  prettyTree(nj(dmat), groups=ifelse(outlier,'outlier','non-outlier'),
             X=outlier,
             O=selected, fill=selected,
             labels=ifelse(isType,gettextf('type strain (%s)', accession),NA))
})


