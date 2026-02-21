# Code example from 'RareVariantsVis' vignette. See references/ for full tutorial.

## ----mychunk1, cache=TRUE, eval=FALSE, hide=TRUE------------------------------
# library(RareVariantVis)
# library(DataRareVariantVis)

## ----mychunk2, cache=TRUE, eval=FALSE, hide=TRUE------------------------------
# sample = system.file("extdata", "CoriellIndex_S1.vcf.gz",
#     package = "DataRareVariantVis")
# sv_sample = system.file("extdata", "CoriellIndex_S1.sv.vcf.gz",
#     package = "DataRareVariantVis")

## ----mychunk3, cache=TRUE, eval=FALSE, hide=TRUE------------------------------
# chromosomeVis(sample=sample, sv_sample=sv_sample,
#     chromosomes=c("19"))

## ----mychunk4, cache=TRUE, eval=FALSE, hide=TRUE------------------------------
# rareVariantVis("RareVariants_CoriellIndex_S1.txt",
#                "RareVariants_CoriellIndex_S1.html",
#                "CorielIndex")

## ----mychunk5, cache=TRUE, eval=FALSE, hide=TRUE------------------------------
# inputFiles = c("RareVariants_CoriellIndex_S1.txt",
#                "RareVariants_Coriell_S2.txt")
# sampleNames = c("CoriellIndex_S1", "Coriell_S2");
# multipleVis(inputFiles, "CorielSamples.html", sampleNames, "19")

