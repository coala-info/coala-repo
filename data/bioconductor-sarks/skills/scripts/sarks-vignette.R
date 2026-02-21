# Code example from 'sarks-vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'sarks-vignette.Rnw'

###################################################
### code chunk number 1: install (eval = FALSE)
###################################################
## if(!requireNamespace("BiocManager", quietly = TRUE))
##     install.packages("BiocManager")
## BiocManager::install("sarks")


###################################################
### code chunk number 2: java-initialization
###################################################
options(java.parameters = '-Xmx8G')  ## sets to 8 gigabytes: modify as needed
library(rJava)
.jinit()
## ---------------------------------------------------------------------
## once you've set the java.parameters and then called .jinit from rJava
## (making sure not to load any other rJava-dependent packages prior to
##  initializing the JVM with .jinit!),
## you are now ready to load the sarks library:
## ---------------------------------------------------------------------
library(sarks)


###################################################
### code chunk number 3: check-length
###################################################
options(continue="  ")  ## for vignette formatting, can be ignored
data(simulatedSeqs)
length(simulatedSeqs)
table(nchar(simulatedSeqs))


###################################################
### code chunk number 4: simseqs
###################################################
vapply(simulatedSeqs, function(s) {paste0(substr(s, 1, 10), '...')}, '')


###################################################
### code chunk number 5: check-scores
###################################################
data(simulatedScores)
simulatedScores


###################################################
### code chunk number 6: check-names
###################################################
all(names(simulatedScores) == names(simulatedSeqs))


###################################################
### code chunk number 7: minimal-1
###################################################
sarks <- Sarks(simulatedSeqs, simulatedScores, halfWindow=4)
filters <- sarksFilters(halfWindow=4, spatialLength=0, minGini=1.1)
permDist <- permutationDistribution(sarks, reps=250, filters, seed=123)
thresholds <- permutationThresholds(filters, permDist, nSigma=2.0)
peaks <- kmerPeaks(sarks, filters, thresholds)
peaks[ , c('i', 's', 'block', 'wi', 'kmer', 'windowed')]


###################################################
### code chunk number 8: unique-kmers
###################################################
unique(peaks$kmer)


###################################################
### code chunk number 9: kmer-counts
###################################################
kmerCounts(unique(peaks$kmer), simulatedSeqs)


###################################################
### code chunk number 10: peaks
###################################################
peak8 = peaks[8, ]
peak8[ , c('i', 's', 'block', 'wi', 'kmer', 'windowed')]


###################################################
### code chunk number 11: block-wi-interpretation
###################################################
block <- simulatedSeqs[[peak8$block]]
kmerStart <- peak8$wi + 1
kmerEnd <- kmerStart + nchar(peak8$kmer) - 1


###################################################
### code chunk number 12: sarks-vignette.Rnw:302-303
###################################################
substr(block, kmerStart, kmerEnd)


###################################################
### code chunk number 13: sarks-vignette.Rnw:306-307
###################################################
peak8$kmer


###################################################
### code chunk number 14: merging-simplification
###################################################
nonRedundantPeaks <- mergedKmerSubPeaks(sarks, filters, thresholds)
nonRedundantPeaks[ , c('i', 's', 'block', 'wi', 'kmer', 'windowed')]


###################################################
### code chunk number 15: extending
###################################################
extendedPeaks <- extendKmers(sarks, nonRedundantPeaks)
extendedPeaks[ , c('i', 's', 'block', 'wi', 'kmer', 'windowed')]


###################################################
### code chunk number 16: catseq
###################################################
concatenated <- sarks$getCatSeq()
nchar(concatenated)


###################################################
### code chunk number 17: sarks-vignette.Rnw:364-367
###################################################
kmerCatStart <- peak8$s + 1
kmerCatEnd <- kmerCatStart + nchar(peak8$kmer) - 1
substr(concatenated, kmerCatStart, kmerCatEnd)


###################################################
### code chunk number 18: sarks-vignette.Rnw:372-373
###################################################
theSuffix <- substr(concatenated, kmerCatStart, nchar(concatenated))


###################################################
### code chunk number 19: sarks-vignette.Rnw:379-385
###################################################
extractSuffix <- function(s) {
    ## returns suffix of concatenated starting at position s (1-based)
    substr(concatenated, s, nchar(concatenated))
}
allSuffixes <- vapply(1:nchar(concatenated), extractSuffix, '')
sortedSuffixes <- sort(allSuffixes)


###################################################
### code chunk number 20: sarks-vignette.Rnw:389-391
###################################################
i1based <- peak8$i + 1
sortedSuffixes[i1based] == theSuffix


###################################################
### code chunk number 21: sarks-vignette.Rnw:400-403
###################################################
iCenteredWindow <- (i1based - 4):(i1based + 4)
iCenteredWindowSuffixes <- sortedSuffixes[iCenteredWindow]
all(substr(iCenteredWindowSuffixes, 1, 10) == 'CATACTGAGA')


###################################################
### code chunk number 22: source-block
###################################################
iCenteredWindow0Based <- iCenteredWindow - 1
sourceBlock(sarks, i=iCenteredWindow0Based)


###################################################
### code chunk number 23: yhat-plot
###################################################
yhat <- sarks$getYhat()
i0based <- seq(0, length(yhat)-1)
plot(i0based, yhat, type='l', xlab='i')


###################################################
### code chunk number 24: perm-example
###################################################
set.seed(12345)
scoresPerm <- sample(simulatedScores)
names(scoresPerm) <- names(simulatedScores)
sarksPerm <- Sarks(simulatedSeqs, scoresPerm, halfWindow=4)


###################################################
### code chunk number 25: perm-thresholds
###################################################
permDistNull <- permutationDistribution(
        sarksPerm, reps=250, filters, seed=123)
thresholdsNull <- permutationThresholds(
        filters, permDistNull, nSigma=2.0)
peaksNull <- kmerPeaks(sarksPerm, filters, thresholdsNull)
peaksNull[ , c('i', 's', 'block', 'wi', 'kmer', 'windowed')]


###################################################
### code chunk number 26: fpr-estimation
###################################################
fpr = estimateFalsePositiveRate(
        sarks, reps=250, filters, thresholds, seed=321)
fpr$ci


###################################################
### code chunk number 27: gini-testing
###################################################
estimateFalsePositiveRate(
        sarks, reps=250, filters, thresholds, seed=321)$ci
filtersNoGini <- sarksFilters(halfWindow=4, spatialLength=0, minGini=0)
estimateFalsePositiveRate(
        sarks, reps=250, filtersNoGini, thresholds, seed=321)$ci


###################################################
### code chunk number 28: no-gini-thresholds
###################################################
permDistNoGini <-
        permutationDistribution(sarks, reps=250, filtersNoGini, seed=123)
thresholdsNoGini <- 
        permutationThresholds(filtersNoGini, permDistNoGini, nSigma=2.0)
peaksNoGini <- kmerPeaks(sarks, filtersNoGini, thresholdsNoGini)
peaksNoGini[ , c('i', 's', 'block', 'wi', 'kmer', 'windowed')]


###################################################
### code chunk number 29: spatial
###################################################
sarks <- Sarks(
    simulatedSeqs, simulatedScores, halfWindow=4, spatialLength=3
)
filters <- sarksFilters(halfWindow=4, spatialLength=3, minGini=1.1)
permDist <- permutationDistribution(sarks, reps=250, filters, seed=123)
thresholds <- permutationThresholds(filters, permDist, nSigma=5.0)
## note setting of nSigma to higher value of 5.0 here!
peaks <- kmerPeaks(sarks, filters, thresholds)
peaks[ , c('i', 's', 'block', 'wi', 'kmer', 'spatialWindowed')]


###################################################
### code chunk number 30: subpeaks
###################################################
subpeaks <- mergedKmerSubPeaks(sarks, filters, thresholds)
subpeaks[ , c('i', 's', 'block', 'wi', 'kmer')]


###################################################
### code chunk number 31: block-info
###################################################
block22 <- blockInfo(sarks, block='22', filters, thresholds)
library(ggplot2)
ggo <- ggplot(block22, aes(x=wi+1))  ## +1 because R indexing is 1-based
ggo <- ggo + geom_point(aes(y=windowed), alpha=0.6, size=1)
ggo <- ggo + geom_line(aes(y=spatialWindowed), alpha=0.6)
ggo <- ggo + geom_hline(aes(yintercept=spatialTheta), color='red')
ggo <- ggo + ylab('yhat') + ggtitle('Input Sequence "22"')
ggo <- ggo + theme_bw()
print(ggo)


###################################################
### code chunk number 32: fpr-spatial
###################################################
estimateFalsePositiveRate(
        sarks, reps=250, filters, thresholds, seed=321)$ci


###################################################
### code chunk number 33: varying-parameters
###################################################
filters <- sarksFilters(
        halfWindow=c(4, 8), spatialLength=c(2, 3), minGini=1.1)
permDist <- permutationDistribution(sarks, reps=250, filters, seed=123)
thresholds <- permutationThresholds(filters, permDist, nSigma=5.0)
peaks <- mergedKmerSubPeaks(sarks, filters, thresholds)
peaks[ , c('halfWindow', 'spatialLength', 'i', 's', 'block', 'wi', 'kmer')]


###################################################
### code chunk number 34: fpr-varying
###################################################
estimateFalsePositiveRate(
        sarks, reps=250, filters, thresholds, seed=321)$ci


###################################################
### code chunk number 35: kmers-for-clustering
###################################################
kmers <- c(
    'CAGCCTGG', 'CCTGGAA', 'CAGCCTG', 'CCTGGAAC', 'CTGGAACT',
    'ACCTGC', 'CACCTGC', 'TGGCCTG', 'CACCTG', 'TCCAGC',
    'CTGGAAC', 'CACCTGG', 'CTGGTCTA', 'GTCCTG', 'CTGGAAG', 'TTCCAGC'
)


###################################################
### code chunk number 36: kmer-clustering
###################################################
kmClust <- clusterKmers(kmers, directional=FALSE)
## directional=FALSE indicates that we want to treat each kmer
##                   as equivalent to its reverse-complement
kmClust


###################################################
### code chunk number 37: cluster-counting
###################################################
clCounts <- clusterCounts(kmClust, simulatedSeqs, directional=FALSE)
## directional=FALSE to count hits of either a kmer from the cluster
##                   or the reverse-complement of such a kmer
## clCounts is a matrix with:
## - one row for each sequence in simulatedSeqs
## - one column for each *cluster* in kmClust
head(clCounts)


###################################################
### code chunk number 38: cluster-locating
###################################################
clLoci <- locateClusters(
    kmClust, simulatedSeqs, directional=FALSE, showMatch=TRUE
)
## showMatch=TRUE includes column specifying exactly what k-mer
##                registered as a hit;
##                this can be very slow, so default is showMatch=FALSE
clLoci


###################################################
### code chunk number 39: constructor
###################################################
sarks = Sarks(
    simulatedSeqs, simulatedScores, halfWindow=4, spatialLength=3, nThreads=4
)


###################################################
### code chunk number 40: permutation
###################################################
filters <- sarksFilters(halfWindow=4, spatialLength=c(0, 3), minGini=1.1)
permDist <- permutationDistribution(
        sarks, reps=250, filters=filters, seed=123)


###################################################
### code chunk number 41: thresholds
###################################################
thresholds = permutationThresholds(
        filters=filters, permDist=permDist, nSigma=5.0)


###################################################
### code chunk number 42: kmerpeaks
###################################################
peaks = kmerPeaks(sarks, filters=filters, thresholds=thresholds)


###################################################
### code chunk number 43: merging
###################################################
mergedPeaks = mergedKmerSubPeaks(sarks, filters, thresholds)


###################################################
### code chunk number 44: fpr
###################################################
fpr = estimateFalsePositiveRate(sarks, reps=250,
                                filters=filters, thresholds=thresholds,
                                seed=123456)


###################################################
### code chunk number 45: sessionInfo
###################################################
sessionInfo()


