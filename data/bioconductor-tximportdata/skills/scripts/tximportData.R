# Code example from 'tximportData' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
dir <- system.file("extdata", package="tximportData")
samples <- read.table(file.path(dir,"samples.txt"), header=TRUE)
samples

## -----------------------------------------------------------------------------
samples.ext <- read.delim(file.path(dir,"samples_extended.txt"), header=TRUE)
colnames(samples.ext)

## -----------------------------------------------------------------------------
list.files(dir)
list.files(file.path(dir,"cufflinks"))
list.files(file.path(dir,"rsem","ERR188021"))
list.files(file.path(dir,"kallisto","ERR188021"))
list.files(file.path(dir,"salmon","ERR188021"))
list.files(file.path(dir,"sailfish","ERR188021"))
list.files(file.path(dir,"alevin"))

## -----------------------------------------------------------------------------
sessionInfo()

