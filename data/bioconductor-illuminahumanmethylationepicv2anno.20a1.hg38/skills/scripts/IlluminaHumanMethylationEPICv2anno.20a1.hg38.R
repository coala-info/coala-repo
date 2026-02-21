# Code example from 'IlluminaHumanMethylationEPICv2anno.20a1.hg38' vignette. See references/ for full tutorial.

## ----echo = FALSE, message = FALSE--------------------------------------------
library(knitr)
knitr::opts_chunk$set(
    error = FALSE,
    tidy  = FALSE,
    message = FALSE,
    warning = FALSE,
    fig.align = "center")

## ----eval = FALSE-------------------------------------------------------------
#  RGset = read.metharray.exp(...)
#  
#  # explained in the IlluminaHumanMethylationEPICv2manifest package
#  annotation(RGset)["array"] = "IlluminaHumanMethylationEPICv2"
#  
#  annotation(RGset)["annotation"] = "20a1.hg38"

## -----------------------------------------------------------------------------
library(IlluminaHumanMethylationEPICv2anno.20a1.hg38)
library(IlluminaHumanMethylationEPICanno.ilm10b4.hg19)

cgi1 = IlluminaHumanMethylationEPICanno.ilm10b4.hg19::Islands.UCSC
cgi2 = IlluminaHumanMethylationEPICv2anno.20a1.hg38::Islands.UCSC

## -----------------------------------------------------------------------------
t1 = table(gsub("(N|S)_", "", cgi1$Relation_to_Island))
t1
t2 = table(cgi2$Relation_to_Island)
t2

t2 - t1
(t2 - t1)/t1

## -----------------------------------------------------------------------------
dim(cgi1)
head(cgi1)
dim(cgi2)
head(cgi2)

any(duplicated(rownames(cgi1)))

## -----------------------------------------------------------------------------
illumina_ID = rownames(cgi2)
probe_ID = gsub("_.*$", "", illumina_ID)

## -----------------------------------------------------------------------------
tb = table(probe_ID)
table(tb)

## -----------------------------------------------------------------------------
tb[tb == 10]

## -----------------------------------------------------------------------------
illumina_ID[probe_ID == "cg06373096"]

## -----------------------------------------------------------------------------
cgi2[probe_ID == "cg06373096", ]

## -----------------------------------------------------------------------------
tempdir = tempdir()
datadir = paste0(tempdir, "/206891110001")
dir.create(datadir, showWarnings = FALSE)

url = "https://github.com/jokergoo/IlluminaHumanMethylationEPICv2manifest/files/11008723/206891110001_R01C01.zip"
local = paste0(tempdir, "/206891110001_R01C01.zip")
download.file(url, dest = local, quiet = TRUE)

unzip(local, exdir = datadir)

library(minfi)
RGset = read.metharray.exp(datadir)
annotation(RGset)["array"] = "IlluminaHumanMethylationEPICv2"
obj = preprocessRaw(RGset)
# there can be more intermediate steps ...
beta = getBeta(obj)
dim(beta)
head(beta)

beta2 = aggregate_to_probes(beta)
dim(beta2)
head(beta2)

## -----------------------------------------------------------------------------
head(aggregate_to_probes(cgi2))

## ----echo = FALSE-------------------------------------------------------------
unlink(datadir)
unlink(local)

## ----echo = FALSE-------------------------------------------------------------
sessionInfo()

