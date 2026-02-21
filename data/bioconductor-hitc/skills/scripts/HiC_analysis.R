# Code example from 'HiC_analysis' vignette. See references/ for full tutorial.

### R code from vignette source 'HiC_analysis.Rnw'

###################################################
### code chunk number 1: style
###################################################
BiocStyle::latex(use.unsrturl=FALSE)


###################################################
### code chunk number 2: head
###################################################
require(HiTC)
require(HiCDataHumanIMR90)
data(Dixon2012_IMR90)

show(hic_imr90_40)
class(intdata(hic_imr90_40$chr1chr1))
object.size(hic_imr90_40)


###################################################
### code chunk number 3: describe
###################################################
## Show data
show(hic_imr90_40)
## Is my data complete (i.e. composed of intra + the related inter chromosomal maps)
isComplete(hic_imr90_40)
## Note that a complete object is not necessarily pairwise 
## (is both chr1-chr2 and chr2-chr1 stored ?)
isPairwise(hic_imr90_40)
## Which chromosomes ?
seqlevels(hic_imr90_40)
## Details about a given map
detail(hic_imr90_40$chr6chr6)
## Descriptive statistics
head(summary(hic_imr90_40))


###################################################
### code chunk number 4: plot1
###################################################
## Go back to a smaller dataset (chr21, 22, X) at lower resolution
sset <- reduce(hic_imr90_40, chr=c("chr5","chr6","chr7"))
imr90_500 <- HTClist(lapply(sset, binningC, 
                          binsize=500000, bin.adjust=FALSE, method="sum", step=1))
mapC(imr90_500)


###################################################
### code chunk number 5: plot2
###################################################
mapC(forcePairwise(imr90_500), maxrange=200)


###################################################
### code chunk number 6: resFrag
###################################################
## Example on chromosome X
## GRanges of restriction fragments after HindIII digestion
resFrag <- getRestrictionFragmentsPerChromosome(resSite="AAGCTT", overhangs5=1, 
                                                chromosomes="chr6", 
                                                genomePack="BSgenome.Hsapiens.UCSC.hg18")
resFrag


###################################################
### code chunk number 7: annot
###################################################
## Annotation of genomic features for LGF normalization
## Example on chromosome 6

## Load mappability track
require(rtracklayer)
##map_hg18 <- import("wgEncodeCrgMapabilityAlign100mer_chr6.bw",format="BigWig")
map_hg18 <- NULL
cutSites <- getAnnotatedRestrictionSites(resSite="AAGCTT", overhangs5=1, 
                                         chromosomes="chr6", 
                                         genomePack="BSgenome.Hsapiens.UCSC.hg18", 
                                         wingc=200, mappability=map_hg18, winmap=500)

head(cutSites)
## Annotation of Hi-C object
imr90_500_chr6annot <- setGenomicFeatures(imr90_500$chr6chr6, cutSites)
y_intervals(imr90_500_chr6annot)


###################################################
### code chunk number 8: normLGF (eval = FALSE)
###################################################
## ## LGF normalization
## imr90_500_LGF <- normLGF(imr90_500_chr6annot)


###################################################
### code chunk number 9: normICE
###################################################
imr90_500_ICE <-  normICE(imr90_500, max_iter=10)
mapC(HTClist(imr90_500_ICE$chr6chr6), trim.range=.95, 
     col.pos=c("white", "orange", "red", "black"))


###################################################
### code chunk number 10: tads
###################################################
hox <- extractRegion(hic_imr90_40$chr6chr6, chr="chr6", from=50e6, to=58e6)
plot(hox, maxrange=50, col.pos=c("white", "orange", "red", "black"))


###################################################
### code chunk number 11: di
###################################################
di<-directionalityIndex(hox)
barplot(di, col=ifelse(di>0,"darkred","darkgreen"))


###################################################
### code chunk number 12: sessionInfo
###################################################
toLatex(sessionInfo(), locale=FALSE)


