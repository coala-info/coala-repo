# Code example from 'sesame' vignette. See references/ for full tutorial.

## ----message=FALSE, warning=FALSE, include=FALSE------------------------------
options(rmarkdown.html_vignette.check_title = FALSE)

## ----message=FALSE, warning=FALSE---------------------------------------------
library(sesame)

## -----------------------------------------------------------------------------
## As sesame and sesameData are under active development, this documentation is
## specific to the following version of R, sesame, sesameData and ExperimentHub:
sesame_checkVersion()

## ----message=FALSE------------------------------------------------------------
sesameDataCache()

## -----------------------------------------------------------------------------
tools::R_user_dir("ExperimentHub", which="cache")

## ----base1, eval=FALSE--------------------------------------------------------
# betas = openSesame("path_to_idats", BPPARAM = BiocParallel::MulticoreParam(2))

## ----base2, eval=FALSE--------------------------------------------------------
# ##  The above openSesame call is equivalent to:
# betas = do.call(cbind, BiocParallel::bplapply(
#     searchIDATprefixes(idat_dir), function(pfx) {
#         getBetas(prepSesame(readIDATpair(pfx), "QCDPB"))
# }, BPPARAM = BiocParallel::MulticoreParam(2)))
# 
# ## or even more explicitly (if one needs to control argument passed
# ## to a specific preprocessing function)
# betas = do.call(cbind, BiocParallel::bplapply(
#     searchIDATprefixes(idat_dir), function(pfx) {
#         getBetas(noob(pOOBAH(dyeBiasNL(inferInfiniumIChannel(qualityMask(
#             readIDATpair(pfx)))))))
# }, BPPARAM = BiocParallel::MulticoreParam(2)))

## ----base12, eval=FALSE-------------------------------------------------------
# betas = openSesame(idat_dir, func = getBetas) # getBetas is the default
# sdfs = openSesame(idat_dir, func = NULL) # return SigDF list
# allele_freqs = openSesame(idat_dir, func = getAFs) # SNP allele frequencies
# sdfs = openSesame(sdfs, prep = "Q", func = NULL)   # take and return SigDFs

## ----base14, eval=FALSE-------------------------------------------------------
# pvals = openSesame(idat_dir, func = pOOBAH, return.pval=TRUE)

## ----base9--------------------------------------------------------------------
sdf = sesameDataGet('EPIC.1.SigDF')
sdf_preped = openSesame(sdf, prep="DB", func=NULL)

## ----base10, echo=FALSE, result="asis"----------------------------------------
library(knitr)
df <- data.frame(rbind(
    c("EPICv2/EPIC/HM450", "human", "QCDPB"),
    c("EPICv2/EPIC/HM450", "non-human organism", "SQCDPB"),
    c("MM285", "mouse", "TQCDPB"),
    c("MM285", "non-mouse organism", "SQCDPB"),
    c("Mammal40", "human", "HCDPB"),
    c("Mammal40", "non-human organism", "SHCDPB")))
colnames(df) <- c("Platform", "Sample Organism", "Prep Code")
kable(df, caption="Recommended Preprocessing")

## ----base11-------------------------------------------------------------------
prepSesameList()

## -----------------------------------------------------------------------------
cg_msa = names(sesameData_getManifestGRanges("MSA"))
## only mappable probes, return mapping from MSA to HM450
head(mLiftOver(cg_msa, "HM450"))

cg_hm450 = names(sesameData_getManifestGRanges("HM450"))
cg_hm450 = grep("cg", cg_hm450, value=TRUE)
## only mappable probes, return mapping from HM450 to EPICv2
head(mLiftOver(cg_hm450, "EPICv2"))

## -----------------------------------------------------------------------------
betas = openSesame(sesameDataGet("EPICv2.8.SigDF")[[1]])
betas_epic = mLiftOver(betas, "EPIC", impute=FALSE)
length(betas_epic)     # EPIC platform dimension
sum(is.na(betas_epic)) # NA values are present

betas_epic = imputeBetas(betas_epic)
length(betas_epic)     # EPIC platform dimension
sum(is.na(betas_epic)) # expect 0 NA after imputation

## use empirical evidence in mLiftOver
mapping = sesameDataGet("liftOver.EPICv2ToEPIC")
betas_matrix = openSesame(sesameDataGet("EPICv2.8.SigDF")[1:2])
dim(mLiftOver(betas_matrix, "EPIC", mapping = mapping))
## compare to without using empirical evidence
dim(mLiftOver(betas_matrix, "EPIC"))

## -----------------------------------------------------------------------------
sdf = sesameDataGet("EPICv2.8.SigDF")[["GM12878_206909630042_R08C01"]]
dim(mLiftOver(sdf, "EPICv2")) # EPICv2 platform dimension
dim(mLiftOver(sdf, "EPIC"))   # EPIC platform dimension
dim(mLiftOver(sdf, "HM450"))  # HM450 platform dimension

## ----eval=FALSE---------------------------------------------------------------
# betas = getBetas(sdf_from_EPICv2, collapseToPfx = TRUE)
# ## or
# betas = openSesame("path_to_idats", collapseToPfx = TRUE)
# ## by default the method for collapsing is to make means
# betas = openSesame("path_to_idats", collapseToPfx = TRUE, collapseMethod = "mean")
# ## one can also switch to min detection p-value
# betas = openSesame("path_to_idats", collapseToPfx = TRUE, collapseMethod = "minPval")

## ----eval=FALSE---------------------------------------------------------------
# betas = betasCollapseToPfx(betas, BPPARAM=BiocParallel::MulticoreParam(2))

## -----------------------------------------------------------------------------
sessionInfo()

