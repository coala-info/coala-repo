# Code example from 'DBChIP' vignette. See references/ for full tutorial.

### R code from vignette source 'DBChIP.Rnw'

###################################################
### code chunk number 1: loading
###################################################
library(DBChIP)
data("PHA4")


###################################################
### code chunk number 2: assign condition
###################################################
conds <- factor(c("emb","emb","L1", "L1"), levels=c("emb", "L1"))


###################################################
### code chunk number 3: load binding sites
###################################################
path <- system.file("ext", package="DBChIP")
binding.site.list <- list()
binding.site.list[["emb"]] <- read.table(paste(path, "/emb.binding.txt", sep=""), 
header=TRUE)
head(binding.site.list[["emb"]])
binding.site.list[["L1"]] <- read.table(paste(path, "/L1.binding.txt", sep=""), 
header=TRUE)
bs.list <- read.binding.site.list(binding.site.list)


###################################################
### code chunk number 4: merge
###################################################
consensus.site <- site.merge(bs.list)


###################################################
### code chunk number 5: look at ChIP data
###################################################
names(chip.data.list)
head(chip.data.list[["emb_rep1"]])


###################################################
### code chunk number 6: look at input data
###################################################
names(input.data.list)


###################################################
### code chunk number 7: load data
###################################################
dat <- load.data(chip.data.list=chip.data.list, conds=conds, consensus.site=
consensus.site, input.data.list=input.data.list, data.type="MCS")


###################################################
### code chunk number 8: site count
###################################################
dat <- get.site.count(dat)


###################################################
### code chunk number 9: differential binding
###################################################
dat <- test.diff.binding(dat)
rept <- report.peak(dat)
rept


###################################################
### code chunk number 10: fig-bs
###################################################
plotPeak(rept[1,], dat)


###################################################
### code chunk number 11: ShortRead (eval = FALSE)
###################################################
## library(ShortRead)
## aln <- readAligned("./", pattern="emb.bam", type="BAM")
## chip.data.list[["emb"]] <- aln


###################################################
### code chunk number 12: BED (eval = FALSE)
###################################################
## chip.data.list <- list()
## chip.data.list[["emb"]] <- "/path/emb.bed.file"
## chip.data.list[["L1"]] <- "/path/L1.bed.file"


###################################################
### code chunk number 13: session
###################################################
sessionInfo()


