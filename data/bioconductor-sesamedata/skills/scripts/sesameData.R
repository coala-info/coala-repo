# Code example from 'sesameData' vignette. See references/ for full tutorial.

## ----message=FALSE, warning=FALSE---------------------------------------------
library(sesameData)
library(GenomicRanges)
sesameDataCache(c("genomeInfo.mm10", "HM450.address"))

## -----------------------------------------------------------------------------
sesameData_getTxnGRanges("mm10")

## -----------------------------------------------------------------------------
sesameData_getTxnGRanges("mm10", merge2gene=TRUE)

## ----message = FALSE, warning = FALSE-----------------------------------------
library(GenomicRanges)

## ----eval=FALSE---------------------------------------------------------------
# ## probes in a region
# sesameData_getProbesByRegion(GRanges('chr5',
#     IRanges(135313937, 135419936)), platform = 'Mammal40')
# ## get chrX probes
# sesameData_getProbesByRegion(chrm = 'chrX', platform = "Mammal40")
# ## get autosomal probes
# sesameData_getProbesByRegion(
#     chrm_to_exclude = c("chrX", "chrY"), platform = "Mammal40")
# ## get DNMT3A probes
# sesameData_getProbesByGene('DNMT3A', "Mammal40", upstream=500)
# ## get DNMT3A promoter probes
# sesameData_getProbesByGene('DNMT3A', "Mammal40", promoter = TRUE)
# ## get all promoter probes
# sesameData_getProbesByGene(NULL, "Mammal40", promoter = TRUE)

## ----eval=FALSE---------------------------------------------------------------
# input_probes <- names(sesameData_getManifestGRanges("Mammal40"))[1:500]
# 
# ## annotate for promoter
# regs <- promoters(sesameData_getTxnGRanges("hg38"))
# sesameData_annoProbes(input_probes, regs, column = "gene_name")
# 
# ## annotate for gene association
# regs <- sesameData_getTxnGRanges("hg38", merge2gene = TRUE)
# sesameData_annoProbes(input_probes, regs, column = "gene_name")
# 
# ## get genes associated with probes
# regs <- sesameData_getTxnGRanges("hg38", merge2gene = TRUE)
# sesameData_annoProbes(input_probes, regs, return_ov_features=TRUE)
# 
# ## get genes associated with probes extending 10kb
# input_probes <- c("cg14620903","cg22464003")
# sesameData_annoProbes(input_probes, regs+10000, column = "gene_name")

## -----------------------------------------------------------------------------
gr <- sesameData_getManifestGRanges("HM450")
length(gr)

## -----------------------------------------------------------------------------
head(sesameDataList())

## -----------------------------------------------------------------------------
sesameDataCache()

## -----------------------------------------------------------------------------
HM27.address <- sesameDataGet('HM27.address')

## -----------------------------------------------------------------------------
sesameDataGet_resetEnv()

## -----------------------------------------------------------------------------
sessionInfo()

