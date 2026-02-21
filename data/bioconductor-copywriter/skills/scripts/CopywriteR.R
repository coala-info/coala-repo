# Code example from 'CopywriteR' vignette. See references/ for full tutorial.

### R code from vignette source 'CopywriteR.Rnw'

###################################################
### code chunk number 1: style-Sweave
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: load.CopywriteR
###################################################
library(CopywriteR)


###################################################
### code chunk number 3: get.root.folder
###################################################
data.folder <- tools::file_path_as_absolute(file.path(getwd()))


###################################################
### code chunk number 4: preCopywriteR
###################################################
preCopywriteR(output.folder = file.path(data.folder),
              bin.size = 20000,
              ref.genome = "mm10_4")


###################################################
### code chunk number 5: list.dirs
###################################################
list.dirs(path = file.path(data.folder), full.names = FALSE)[2]


###################################################
### code chunk number 6: list.dirs
###################################################
list.files(path = file.path(data.folder, "mm10_4_20kb"), full.names = FALSE)


###################################################
### code chunk number 7: show.blacklist
###################################################
load(file = file.path(data.folder, "mm10_4_20kb", "blacklist.rda"))
blacklist.grange


###################################################
### code chunk number 8: show.GC.mappa
###################################################
load(file = file.path(data.folder, "mm10_4_20kb", "GC_mappability.rda"))
GC.mappa.grange[1001:1011]


###################################################
### code chunk number 9: create.BiocParallelParam
###################################################
bp.param <- SnowParam(workers = 1, type = "SOCK")
bp.param


###################################################
### code chunk number 10: CopywriteR
###################################################
path <- SCLCBam::getPathBamFolder()
samples <- list.files(path = path, pattern = ".bam$", full.names = TRUE)
controls <- samples
sample.control <- data.frame(samples, controls)

CopywriteR(sample.control = sample.control,
           destination.folder = file.path(data.folder),
           reference.folder = file.path(data.folder, "mm10_4_20kb"),
           bp.param = bp.param)


###################################################
### code chunk number 11: CNAprofiles.folder.contents
###################################################
cat(list.files(path = file.path(data.folder, "CNAprofiles")), sep = "\n")


###################################################
### code chunk number 12: read.counts.example
###################################################
read.table(file = file.path(data.folder, "CNAprofiles", "read_counts.txt"),
           header = TRUE)[1001:1006, ]


###################################################
### code chunk number 13: log2.read.counts.example
###################################################
read.table(file = file.path(data.folder, "CNAprofiles",
                            "log2_read_counts.igv"), header = TRUE)[817:822, ]


###################################################
### code chunk number 14: CNAprofiles.folder.contents
###################################################
cat(list.files(path = file.path(data.folder, "CNAprofiles", "qc")), sep = "\n")


###################################################
### code chunk number 15: CNAprofiles.folder.contents
###################################################
plotCNA(destination.folder = file.path(data.folder))


###################################################
### code chunk number 16: CNAprofiles.folder.contents.2
###################################################
cat(list.files(path = file.path(data.folder, "CNAprofiles")), sep = "\n")


###################################################
### code chunk number 17: plots.folder.contents
###################################################
cat(list.files(path = file.path(data.folder, "CNAprofiles", "plots")), sep = "\n")


###################################################
### code chunk number 18: sessionInfo
###################################################
toLatex(sessionInfo())


