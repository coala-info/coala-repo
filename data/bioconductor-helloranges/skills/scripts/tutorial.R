# Code example from 'tutorial' vignette. See references/ for full tutorial.

### R code from vignette source 'tutorial.Rnw'

###################################################
### code chunk number 1: style-Sweave
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: loadData
###################################################
library(HelloRanges)
library(HelloRangesData)


###################################################
### code chunk number 3: setwd
###################################################
oldwd <- setwd(system.file("extdata", package="HelloRangesData"))


###################################################
### code chunk number 4: intersect-default
###################################################
code <- bedtools_intersect("-a cpg.bed -b exons.bed -g hg19.genome")
code


###################################################
### code chunk number 5: intersect-eval
###################################################
ans <- eval(code)
mcols(ans)$hit <- NULL
ans


###################################################
### code chunk number 6: intersect-simple
###################################################
code <- bedtools_intersect("-a cpg.bed -b exons.bed")
code


###################################################
### code chunk number 7: seqinfo
###################################################
genome <- eval(code[[2L]])
genome


###################################################
### code chunk number 8: intersect-genome
###################################################
bedtools_intersect("-a cpg.bed -b exons.bed -g hg19.genome")


###################################################
### code chunk number 9: intersect-genome-id
###################################################
bedtools_intersect("-a cpg.bed -b exons.bed -g hg19")


###################################################
### code chunk number 10: granges
###################################################
gr_a


###################################################
### code chunk number 11: rtracklayer-cpgs (eval = FALSE)
###################################################
## ucsc <- browserSession()
## genome(ucsc) <- "hg19"
## cpgs <- ucsc[["CpG Islands"]]


###################################################
### code chunk number 12: txdb-exons (eval = FALSE)
###################################################
## library(TxDb.Hsapiens.UCSC.hg19.knownGene)
## exons <- exons(TxDb.Hsapiens.UCSC.hg19.knownGene)


###################################################
### code chunk number 13: intersect-pairs
###################################################
pairs


###################################################
### code chunk number 14: export-pairs (eval = FALSE)
###################################################
## export(pairs, "pairs.bedpe")


###################################################
### code chunk number 15: intersect-ans
###################################################
ans


###################################################
### code chunk number 16: intersect-wa-wb
###################################################
bedtools_intersect("-a cpg.bed -b exons.bed -g hg19 -wa -wb")


###################################################
### code chunk number 17: intersect-wo
###################################################
bedtools_intersect("-a cpg.bed -b exons.bed -g hg19 -wo")


###################################################
### code chunk number 18: intersect-c
###################################################
bedtools_intersect("-a cpg.bed -b exons.bed -g hg19 -c")


###################################################
### code chunk number 19: intersect-v
###################################################
bedtools_intersect("-a cpg.bed -b exons.bed -g hg19 -v")


###################################################
### code chunk number 20: intersect-f
###################################################
bedtools_intersect("-a cpg.bed -b exons.bed -g hg19 -f 0.5 -wo")


###################################################
### code chunk number 21: intersect-performance
###################################################
a <- import("exons.bed")
b <- import("hesc.chromHmm.bed")
system.time(pintersect(findOverlapPairs(a, b, ignore.strand=TRUE),
                       ignore.strand=TRUE))


###################################################
### code chunk number 22: intersect-multiple
###################################################
code <- bedtools_intersect(
    paste("-a exons.bed",
          "-b cpg.bed,gwas.bed,hesc.chromHmm.bed -wa -wb -g hg19",
          "-names cpg,gwas,chromhmm"))
ans <- eval(code)
code


###################################################
### code chunk number 23: intersect-multiple-second
###################################################
second(ans)


###################################################
### code chunk number 24: merge
###################################################
bedtools_merge("-i exons.bed")


###################################################
### code chunk number 25: merge-count-overlaps
###################################################
code <- bedtools_merge("-i exons.bed -c 1 -o count")
code


###################################################
### code chunk number 26: merge-count-overlaps-ans
###################################################
eval(code)


###################################################
### code chunk number 27: merge-count-overlaps-direct
###################################################
identical(lengths(ans$grouping), ans$seqnames.count)


###################################################
### code chunk number 28: merge-close
###################################################
bedtools_merge("-i exons.bed -d 1000")


###################################################
### code chunk number 29: merge-multiple
###################################################
bedtools_merge("-i exons.bed -d 90 -c 1,4 -o count,collapse")


###################################################
### code chunk number 30: complement
###################################################
bedtools_complement("-i exons.bed -g hg19.genome")


###################################################
### code chunk number 31: genomecov-bg
###################################################
bedtools_genomecov("-i exons.bed -g hg19.genome -bg")


###################################################
### code chunk number 32: genomecov
###################################################
code <- bedtools_genomecov("-i exons.bed -g hg19.genome")
ans <- eval(code)
code


###################################################
### code chunk number 33: genomecov-cov
###################################################
cov


###################################################
### code chunk number 34: genomecov-ans
###################################################
ans


###################################################
### code chunk number 35: combine-genomecov
###################################################
code <- bedtools_genomecov("-i exons.bed -g hg19.genome -bga")
gr0 <- subset(eval(code), score == 0L) # compare to: awk '$4==0'
gr0


###################################################
### code chunk number 36: combine-intersect
###################################################
code <- R_bedtools_intersect("cpg.bed", gr0)
code


###################################################
### code chunk number 37: combine-pipe (eval = FALSE)
###################################################
## do_bedtools_genomecov("exons.bed", g="hg19.genome", bga=TRUE) %>% 
##     subset(score > 0L) %>%
##     do_bedtools_intersect("cpg.bed", .)    


###################################################
### code chunk number 38: coalescence-naive
###################################################
bedtools_coverage("-a cpg.bed -b exons.bed -hist -g hg19.genome")


###################################################
### code chunk number 39: coalescence-simplify
###################################################
genome <- import("hg19.genome")
gr_a <- import("cpg.bed", genome = genome)
gr_b <- import("exons.bed", genome = genome)
cov <- unname(coverage(gr_b)[gr_a])


###################################################
### code chunk number 40: coalescence-custom
###################################################
all_cov <- unlist(cov)
df <- as.data.frame(table(coverage=all_cov))
df$fraction <- df$Freq / length(all_cov)


###################################################
### code chunk number 41: tutorial.Rnw:615-616
###################################################
setwd(oldwd)


###################################################
### code chunk number 42: coalescence-plot
###################################################
plot((1-cumsum(fraction)) ~ as.integer(coverage), df, type="s",
     ylab = "fraction of bp > coverage", xlab="coverage")


###################################################
### code chunk number 43: tutorial.Rnw:622-623
###################################################
setwd(system.file("extdata", package="HelloRangesData"))


###################################################
### code chunk number 44: jaccard-example
###################################################
code <- bedtools_jaccard(
    paste("-a fHeart-DS16621.hotspot.twopass.fdr0.05.merge.bed",
          "-b fHeart-DS15839.hotspot.twopass.fdr0.05.merge.bed"))
heart_heart <- eval(code)
code <- bedtools_jaccard(
    paste("-a fHeart-DS16621.hotspot.twopass.fdr0.05.merge.bed",
          "-b fSkin_fibro_bicep_R-DS19745.hg19.hotspot.twopass.fdr0.05.merge.bed"))
heart_skin <- eval(code)
mstack(heart_heart=heart_heart, heart_skin=heart_skin)


###################################################
### code chunk number 45: jaccard-code
###################################################
code


###################################################
### code chunk number 46: jaccard-all
###################################################
files <- Sys.glob("*.merge.bed")
names(files) <- sub("\\..*", "", files)
ncores <- if (.Platform$OS.type == "windows") 1L else 4L
library(parallel)
ans <- outer(files, files, 
             function(a, b) mcmapply(do_bedtools_jaccard, a, b, 
                                     mc.cores=ncores))
jaccard <- apply(ans, 1:2, function(x) x[[1]]$jaccard)


###################################################
### code chunk number 47: tutorial.Rnw:669-670
###################################################
setwd(oldwd)


###################################################
### code chunk number 48: jaccard-plot
###################################################
palette <- colorRampPalette(c("lightblue", "darkblue"))(9)
heatmap(jaccard, col=palette, margin=c(14, 14))


###################################################
### code chunk number 49: tutorial.Rnw:676-677
###################################################
setwd(system.file("extdata", package="HelloRangesData"))


###################################################
### code chunk number 50: answers-load
###################################################
genome <- import("hg19.genome")
exons <- import("exons.bed", genome=genome)
gwas <- import("gwas.bed", genome=genome)
hesc.chromHmm <- import("hesc.chromHmm.bed", genome=genome)


###################################################
### code chunk number 51: answer-1
###################################################
bedtools_complement("-i exons.bed -g hg19.genome")
## or without HelloRanges:
setdiff(as(seqinfo(exons), "GRanges"), unstrand(exons))


###################################################
### code chunk number 52: answer-2
###################################################
bedtools_closest("-a gwas.bed -b exons.bed -d")
## or 
distanceToNearest(gwas, exons)


###################################################
### code chunk number 53: answer-3
###################################################
code <- bedtools_makewindows("-g hg19.genome -w 500000")
code
windows <- unlist(eval(code))
R_bedtools_intersect(windows, exons, c=TRUE)
## or
str(countOverlaps(tileGenome(seqinfo(exons), tilewidth=500000), 
                  exons))


###################################################
### code chunk number 54: answer-4
###################################################
bedtools_intersect(
    paste("-a exons.bed -b <\"grep Enhancer hesc.chromHmm.bed\"",
          "-f 1.0 -wa -u"))
quote(length(ans))
## or
sum(exons %within% 
    subset(hesc.chromHmm, grepl("Enhancer", name)))


###################################################
### code chunk number 55: answer-5
###################################################
bedtools_intersect("-a gwas.bed -b exons.bed -u")
quote(length(gr_a)/length(ans))
## or
mean(gwas %over% exons)


###################################################
### code chunk number 56: answer-6
###################################################
bedtools_flank("-l 2 -r 2 -i exons.bed -g hg19.genome")
## or, bonus:
txid <- sub("_exon.*", "", exons$name)
tx <- split(exons, txid)
bounds <- range(tx)
transpliced <- lengths(bounds) > 1
introns <- unlist(psetdiff(unlist(bounds[!transpliced]), 
                           tx[!transpliced]))
Pairs(resize(introns, 2L), resize(introns, 2L, fix="end"))
## better way to get introns:
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
introns <- unlist(intronsByTranscript(txdb))


###################################################
### code chunk number 57: answer-7
###################################################
system.time(names(which.max(xtabs(width ~ name, 
                                  hesc.chromHmm))))
## or
names(which.max(sum(with(hesc.chromHmm, 
                         splitAsList(width, name)))))
## or
df <- aggregate(hesc.chromHmm, ~ name, totalWidth=sum(width))
df$name[which.max(df$totalWidth)]


###################################################
### code chunk number 58: restore-wd
###################################################
setwd(oldwd)


