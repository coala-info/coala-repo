# Code example from 'SCOPE_vignette' vignette. See references/ for full tutorial.

## ----eval=TRUE, message=FALSE-------------------------------------------------
library(SCOPE)
library(WGSmapp)
library(BSgenome.Hsapiens.UCSC.hg38)
bamfolder <- system.file("extdata", package = "WGSmapp")
bamFile <- list.files(bamfolder, pattern = '*.dedup.bam$')
bamdir <- file.path(bamfolder, bamFile)
sampname_raw <- sapply(strsplit(bamFile, ".", fixed = TRUE), "[", 1)
bambedObj <- get_bam_bed(bamdir = bamdir, sampname = sampname_raw, 
                        hgref = "hg38")
ref_raw <- bambedObj$ref

## ----eval=TRUE, message=FALSE-------------------------------------------------
mapp <- get_mapp(ref_raw, hgref = "hg38")
head(mapp)
gc <- get_gc(ref_raw, hgref = "hg38")
values(ref_raw) <- cbind(values(ref_raw), DataFrame(gc, mapp))
ref_raw

## ----eval=FALSE---------------------------------------------------------------
# library(BSgenome.Mmusculus.UCSC.mm10)
# mapp <- get_mapp(ref_raw, hgref = "mm10")
# gc <- get_gc(ref_raw, hgref = "mm10")

## ----eval=TRUE----------------------------------------------------------------
# Getting raw read depth
coverageObj <- get_coverage_scDNA(bambedObj, mapqthres = 40, 
                                seq = 'paired-end', hgref = "hg38")
Y_raw <- coverageObj$Y

## ----eval=TRUE----------------------------------------------------------------
QCmetric_raw <- get_samp_QC(bambedObj)
qcObj <- perform_qc(Y_raw = Y_raw, 
    sampname_raw = sampname_raw, ref_raw = ref_raw, 
    QCmetric_raw = QCmetric_raw)
Y <- qcObj$Y
sampname <- qcObj$sampname
ref <- qcObj$ref
QCmetric <- qcObj$QCmetric

## ----eval=TRUE, message=FALSE-------------------------------------------------
# get gini coefficient for each cell
Gini <- get_gini(Y_sim)

## ----eval=TRUE, message=TRUE--------------------------------------------------
# first-pass CODEX2 run with no latent factors
normObj.sim <- normalize_codex2_ns_noK(Y_qc = Y_sim,
                                        gc_qc = ref_sim$gc,
                                        norm_index = which(Gini<=0.12))

# Ploidy initialization
ploidy.sim <- initialize_ploidy(Y = Y_sim, Yhat = normObj.sim$Yhat, ref = ref_sim)

# If using high performance clusters, parallel computing is 
# easy and improves computational efficiency. Simply use 
# normalize_scope_foreach() instead of normalize_scope(). 
# All parameters are identical. 
normObj.scope.sim <- normalize_scope_foreach(Y_qc = Y_sim, gc_qc = ref_sim$gc,
    K = 1, ploidyInt = ploidy.sim,
    norm_index = which(Gini<=0.12), T = 1:5,
    beta0 = normObj.sim$beta.hat, nCores = 2)
# normObj.scope.sim <- normalize_scope(Y_qc = Y_sim, gc_qc = ref_sim$gc,
#     K = 1, ploidyInt = ploidy.sim,
#     norm_index = which(Gini<=0.12), T = 1:5,
#     beta0 = beta.hat.noK.sim)
Yhat.sim <- normObj.scope.sim$Yhat[[which.max(normObj.scope.sim$BIC)]]
fGC.hat.sim <- normObj.scope.sim$fGC.hat[[which.max(normObj.scope.sim$BIC)]]

## ----eval=FALSE---------------------------------------------------------------
# plot_EM_fit(Y_qc = Y_sim, gc_qc = ref_sim$gc, norm_index = which(Gini<=0.12),
#             T = 1:5,
#             ploidyInt = ploidy.sim, beta0 = normObj.sim$beta.hat,
#             filename = "plot_EM_fit_demo.pdf")

## ----eval=FALSE---------------------------------------------------------------
# # Group-wise ploidy initialization
# clones <- c("normal", "tumor1", "normal", "tumor1", "tumor1")
# ploidy.sim.group <- initialize_ploidy_group(Y = Y_sim, Yhat = Yhat.noK.sim,
#                                 ref = ref_sim, groups = clones)
# ploidy.sim.group
# 
# # Group-wise normalization
# normObj.scope.sim.group <- normalize_scope_group(Y_qc = Y_sim,
#                                     gc_qc = ref_sim$gc,
#                                     K = 1, ploidyInt = ploidy.sim.group,
#                                     norm_index = which(clones=="normal"),
#                                     groups = clones,
#                                     T = 1:5,
#                                     beta0 = beta.hat.noK.sim)
# Yhat.sim.group <- normObj.scope.sim.group$Yhat[[which.max(
#                                     normObj.scope.sim.group$BIC)]]
# fGC.hat.sim.group <- normObj.scope.sim.group$fGC.hat[[which.max(
#                                     normObj.scope.sim.group$BIC)]]

## ----eval=TRUE, message=FALSE-------------------------------------------------
chrs <- unique(as.character(seqnames(ref_sim)))
segment_cs <- vector('list',length = length(chrs))
names(segment_cs) <- chrs
for (chri in chrs) {
    message('\n', chri, '\n')
    segment_cs[[chri]] <- segment_CBScs(Y = Y_sim,
                                    Yhat = Yhat.sim,
                                    sampname = colnames(Y_sim),
                                    ref = ref_sim,
                                    chr = chri,
                                    mode = "integer", max.ns = 1)
}
iCN_sim <- do.call(rbind, lapply(segment_cs, function(z){z[["iCN"]]}))

## ----eval=FALSE---------------------------------------------------------------
# plot_iCN(iCNmat = iCN_sim, ref = ref_sim, Gini = Gini,
#         filename = "plot_iCN_demo")

## -----------------------------------------------------------------------------
sessionInfo()

