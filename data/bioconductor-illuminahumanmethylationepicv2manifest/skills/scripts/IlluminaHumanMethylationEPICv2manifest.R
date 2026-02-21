# Code example from 'IlluminaHumanMethylationEPICv2manifest' vignette. See references/ for full tutorial.

## ----echo = FALSE, message = FALSE--------------------------------------------
library(knitr)
knitr::opts_chunk$set(
    error = FALSE,
    tidy  = FALSE,
    message = FALSE,
    warning = FALSE,
    fig.width = 6,
    fig.height = 6,
    fig.align = "center")

## ----eval = FALSE-------------------------------------------------------------
#  RGset = read.metharray.exp(...)
#  
#  annotation(RGset)["array"] = "IlluminaHumanMethylationEPICv2"
#  
#  # explained in the IlluminaHumanMethylationEPICv2anno.20a1.hg38 package
#  annotation(RGset)["annotation"] = "20a1.hg38"

## -----------------------------------------------------------------------------
library(IlluminaHumanMethylationEPICv2manifest)

illumina_ID = getManifestInfo(IlluminaHumanMethylationEPICv2manifest, "locusNames")
head(illumina_ID)
any(duplicated(illumina_ID))

## -----------------------------------------------------------------------------
probe_ID = gsub("_.*$", "", illumina_ID)

## -----------------------------------------------------------------------------
tb = table(probe_ID)
table(tb)

## -----------------------------------------------------------------------------
tb[tb == 10]

## -----------------------------------------------------------------------------
illumina_ID[probe_ID == "cg06373096"]

## -----------------------------------------------------------------------------
library(IlluminaHumanMethylationEPICmanifest)

probe1 = getManifestInfo(IlluminaHumanMethylationEPICmanifest, "locusNames")
probe2 = getManifestInfo(IlluminaHumanMethylationEPICv2manifest, "locusNames")

# probes can be duplicated
probe1 = unique(probe1)

probe2 = gsub("_.*$", "", probe2)  # remove suffix
probe2 = unique(probe2)

## -----------------------------------------------------------------------------
length(probe1)
length(probe2)

## ----fig.width = 6, fig.height = 6--------------------------------------------
library(eulerr)
plot(euler(list(v1 = probe1, v2 = probe2)), quantities = TRUE,
    main = "Compare total probes in the two arrays")

## -----------------------------------------------------------------------------
TypeI_1 = IlluminaHumanMethylationEPICmanifest@data$TypeI
TypeI_2 = IlluminaHumanMethylationEPICv2manifest@data$TypeI
plot(euler(list(v1_TypeI = unique(TypeI_1$Name), v2_TypeI = unique(gsub("_.*$", "", TypeI_2$Name)))), 
    quantities = TRUE, main = "Compare TypeI probes in the two arrays")

TypeII_1 = IlluminaHumanMethylationEPICmanifest@data$TypeII
TypeII_2 = IlluminaHumanMethylationEPICv2manifest@data$TypeII
plot(euler(list(v1_TypeII = unique(TypeII_1$Name), v2_TypeII = unique(gsub("_.*$", "", TypeII_2$Name)))), 
    quantities = TRUE, main = "Compare TypeII probes in the two arrays")

## -----------------------------------------------------------------------------
tempdir = tempdir()
datadir = paste0(tempdir, "/206891110001")
dir.create(datadir, showWarnings = FALSE)

url = "https://github.com/jokergoo/IlluminaHumanMethylationEPICv2manifest/files/11008723/206891110001_R01C01.zip"
local = paste0(tempdir, "/206891110001_R01C01.zip")
download.file(url, dest = local, quiet = TRUE)

unzip(local, exdir = datadir)

## -----------------------------------------------------------------------------
library(minfi)
RGset = read.metharray.exp(datadir)
RGset

## -----------------------------------------------------------------------------
annotation(RGset)["array"] = "IlluminaHumanMethylationEPIC"
preprocessRaw(RGset)

## -----------------------------------------------------------------------------
annotation(RGset)["array"] = "IlluminaHumanMethylationEPICv2"
preprocessRaw(RGset)

## -----------------------------------------------------------------------------
obj = preprocessRaw(RGset)
# there can be more intermediate steps ...
beta = getBeta(obj)

beta2 = do.call(rbind, tapply(1:nrow(beta), gsub("_.*$", "", rownames(beta)), function(ind) {
    colMeans(beta[ind, , drop = FALSE])
}, simplify = FALSE))

head(beta2)

## ----echo = FALSE-------------------------------------------------------------
unlink(datadir)
unlink(local)

## -----------------------------------------------------------------------------
sessionInfo()

