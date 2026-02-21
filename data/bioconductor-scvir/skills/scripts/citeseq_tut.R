# Code example from 'citeseq_tut' vignette. See references/ for full tutorial.

## ----doinit,message=FALSE, eval=FALSE-----------------------------------------
# library(scviR)
# library(ggplot2)
# library(reshape2)
# adref = getCiteseq5k10kPbmcs()
# adref

## ----dogetv, eval=FALSE-------------------------------------------------------
# vae = getCiteseqTutvae()

## ----lkclv, eval=FALSE--------------------------------------------------------
# class(vae)

## ----some, eval=FALSE---------------------------------------------------------
# vae$is_trained
# cat(vae$`_model_summary_string`)
# vae$adata

## ----lkmod, eval=FALSE--------------------------------------------------------
# vae$module

## ----lkelb, eval=FALSE--------------------------------------------------------
# h = vae$history
# npts = nrow(h$elbo_train)
# plot(seq_len(npts), as.numeric(h$elbo_train[[1]]), ylim=c(1200,1400),
#   type="l", col="blue", main="Negative ELBO over training epochs",
#   ylab="neg. ELBO", xlab="epoch")
# graphics::legend(300, 1360, lty=1, col=c("blue", "orange"), legend=c("training", "validation"))
# graphics::lines(seq_len(npts), as.numeric(h$elbo_validation[[1]]), type="l", col="orange")

## ----getn, eval=FALSE---------------------------------------------------------
# NE = vae$get_normalized_expression(n_samples=25L,
#     return_mean=TRUE,
#     transform_batch=c("PBMC10k", "PBMC5k")
# )

## ----getdenoise, eval=FALSE---------------------------------------------------
# denoised = getTotalVINormalized5k10k()
# vapply(denoised, dim, integer(2))

## ----lkn, eval=FALSE----------------------------------------------------------
# utils::head(colnames(denoised$rna_nmlzd))
# utils::head(colnames(denoised$prot_nmlzd))

## ----getproj, fig.height=6, eval=FALSE----------------------------------------
# full = getTotalVI5k10kAdata()
# # class distribution
# cllabs = full$obs$leiden_totalVI
# blabs = full$obs$batch
# table(cllabs)
# um = full$obsm$get("X_umap")
# dd = data.frame(umap1=um[,1], umap2=um[,2], clust=factor(cllabs), batch=blabs)
# ggplot(dd, aes(x=umap1, y=umap2, colour=clust)) + geom_point(size=.05) +
#    guides(color = guide_legend(override.aes = list(size = 4)))

## ----getba, eval=FALSE--------------------------------------------------------
# ggplot(dd, aes(x=umap1, y=umap2, colour=factor(batch))) + geom_point(size=.05)

## ----lknn,fig.width=8, eval=FALSE---------------------------------------------
# pro4 = denoised$prot_nmlzd[,1:4]
# names(pro4) = gsub("_.*", "", names(pro4))
# wprot = cbind(dd, pro4)
# mm = melt(wprot, id.vars=c("clust", "batch", "umap1", "umap2"))
# utils::head(mm,3)
# ggplot(mm, aes(x=umap1, y=umap2, colour=log1p(value))) +
#    geom_point(size=.1) + facet_grid(.~variable)

## ----lkmod2, eval=FALSE-------------------------------------------------------
# vae$module

## ----lksess-------------------------------------------------------------------
sessionInfo()

