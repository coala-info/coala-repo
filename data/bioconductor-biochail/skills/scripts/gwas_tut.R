# Code example from 'gwas_tut' vignette. See references/ for full tutorial.

## ----eval = FALSE-------------------------------------------------------------
# if (!require("BiocManager"))
#     install.packages("BiocManager")
# BiocManager::install("BiocHail")

## ----getlib,message=FALSE-----------------------------------------------------
library(BiocHail)
library(ggplot2)

## ----get1, eval=FALSE---------------------------------------------------------
# hl <- hail_init()
# mt <- get_1kg(hl)
# mt
# print(mt$rows()$select()$show(5L)) # limited info

## ----getdim, eval=FALSE-------------------------------------------------------
# mt$count()

## ----dodim, eval=FALSE--------------------------------------------------------
# dim.hail.matrixtable.MatrixTable <- function(x) {
#   tmp <- x$count()
#   c(tmp[[1]], tmp[[2]])
# }
# dim(mt)
# ncol.hail.matrixtable.MatrixTable <- function(x) {
#  dim(x)[2]
# }
# nrow.hail.matrixtable.MatrixTable <- function(x) {
#  dim(x)[1]
# }
# nrow(mt)

## ----domo, eval=FALSE---------------------------------------------------------
# annopath <- path_1kg_annotations()
# tab <- hl$import_table(annopath, impute=TRUE)$key_by("Sample")

## ----getsup, eval=FALSE-------------------------------------------------------
# mt$aggregate_cols(hl$agg$counter(mt$pheno$SuperPopulation))

## ----lkcaf, eval=FALSE--------------------------------------------------------
# uu <- mt$aggregate_cols(hl$agg$stats(mt$pheno$CaffeineConsumption))
# names(uu)
# uu$mean
# uu$stdev

## ----dohist, eval=FALSE-------------------------------------------------------
# p_hist <- mt$aggregate_entries(
#      hl$expr$aggregators$hist(mt$DP, 0L, 30L, 30L))
# names(p_hist)
# length(p_hist$bin_edges)
# length(p_hist$bin_freq)
# midpts <- function(x) diff(x)/2+x[-length(x)]
# dpdf <- data.frame(x=midpts(p_hist$bin_edges), y=p_hist$bin_freq)
# ggplot(dpdf, aes(x=x,y=y)) + geom_col() + ggtitle("DP") + ylab("Frequency")

## ----lkagg, eval=FALSE--------------------------------------------------------
# names(hl$expr$aggregators)

## ----update, eval=FALSE-------------------------------------------------------
# mt <- hl$sample_qc(mt)

## ----lkcr, eval=FALSE---------------------------------------------------------
# callrate <- mt$sample_qc$call_rate$collect()
# graphics::hist(callrate)

## ----after, eval=FALSE--------------------------------------------------------
# dim(mt)

## ----addvarqc, eval=FALSE-----------------------------------------------------
# mt = hl$variant_qc(mt)

## ----dolam, eval=FALSE--------------------------------------------------------
# pv = gwas$p_value$collect()
# x2 = stats::qchisq(1-pv,1)
# lam = stats::median(x2, na.rm=TRUE)/stats::qchisq(.5,1)
# lam

## ----doqq, eval=FALSE---------------------------------------------------------
# qqplot(-log10(ppoints(length(pv))), -log10(pv), xlim=c(0,8), ylim=c(0,8),
#   ylab="-log10 p", xlab="expected")
# abline(0,1)

## ----eval=FALSE---------------------------------------------------------------
# locs <- gwas$locus$collect()
# conts <- sapply(locs, function(x) x$contig)
# pos <- sapply(locs, function(x) x$position)
# library(igvR)
# mytab <- data.frame(chr=as.character(conts), pos=pos, pval=pv)
# gt <- GWASTrack("simp", mytab, chrom.col=1, pos.col=2, pval.col=3)
# igv <- igvR()
# setGenome(igv, "hg19")
# displayTrack(igv, gt)

## ----lkpcs, eval=FALSE--------------------------------------------------------
# sc <- pcastuff[[2]]$scores$collect()
# pc1 = sapply(sc, "[", 1)
# pc2 = sapply(sc, "[", 2)
# fac = mt$pheno$SuperPopulation$collect()
# myd = data.frame(pc1, pc2, pop=fac)
# library(ggplot2)
# ggplot(myd, aes(x=pc1, y=pc2, colour=factor(pop))) + geom_point()

## ----dolam2, eval=FALSE-------------------------------------------------------
# pv = gwas2$p_value$collect()
# x2 = stats::qchisq(1-pv,1)
# lam = stats::median(x2, na.rm=TRUE)/stats::qchisq(.5,1)
# lam

## ----doman, eval=FALSE--------------------------------------------------------
# locs <- gwas2$locus$collect()
# conts <- sapply(locs, function(x) x$contig)
# pos <- sapply(locs, function(x) x$position)
# mytab <- data.frame(chr=as.character(conts), pos=pos, pval=pv)
# ggplot(mytab[mytab$chr=="8",], aes(x=pos, y=-log10(pval))) + geom_point()

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

