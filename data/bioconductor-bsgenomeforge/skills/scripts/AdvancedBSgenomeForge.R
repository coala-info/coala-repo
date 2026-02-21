# Code example from 'AdvancedBSgenomeForge' vignette. See references/ for full tutorial.

### R code from vignette source 'AdvancedBSgenomeForge.Rnw'

###################################################
### code chunk number 1: AdvancedBSgenomeForge.Rnw:193-196
###################################################
library(BSgenome)
file <- system.file("extdata", "ce2chrM.fa.gz", package="BSgenome")
fasta.seqlengths(file)


###################################################
### code chunk number 2: AdvancedBSgenomeForge.Rnw:429-440
###################################################
library(BSgenomeForge)
seed_files <- system.file("extdata", "seeds", package="BSgenomeForge")
tail(list.files(seed_files, pattern="-seed$"))

## Display seed file for musFur1:
musFur1_seed <- list.files(seed_files, pattern="\\.musFur1-seed$", full.names=TRUE)
cat(readLines(musFur1_seed), sep="\n")

## Display seed file for rn4:
rn4_seed <- list.files(seed_files, pattern="\\.rn4-seed$", full.names=TRUE)
cat(readLines(rn4_seed), sep="\n")


###################################################
### code chunk number 3: AdvancedBSgenomeForge.Rnw:453-455 (eval = FALSE)
###################################################
## library(BSgenomeForge)
## forgeBSgenomeDataPkg("path/to/my/seed")


###################################################
### code chunk number 4: AdvancedBSgenomeForge.Rnw:678-683
###################################################
library(BSgenomeForge)
seed_files <- system.file("extdata", "seeds", package="BSgenomeForge")
tail(list.files(seed_files, pattern="\\.masked-seed$"))
rn4_masked_seed <- list.files(seed_files, pattern="\\.rn4\\.masked-seed$", full.names=TRUE)
cat(readLines(rn4_masked_seed), sep="\n")


###################################################
### code chunk number 5: AdvancedBSgenomeForge.Rnw:698-700 (eval = FALSE)
###################################################
## library(BSgenomeForge)
## forgeMaskedBSgenomeDataPkg("path/to/my/seed")


###################################################
### code chunk number 6: AdvancedBSgenomeForge.Rnw:742-743
###################################################
sessionInfo()


