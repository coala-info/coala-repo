# Code example from 'recountmethylation_data_analyses' vignette. See references/ for full tutorial.

## ----setup, echo = FALSE------------------------------------------------------
suppressMessages(library(rhdf5))
suppressMessages(library(minfi))
suppressMessages(library(recountmethylation))
suppressMessages(library(knitr))
suppressMessages(library(ggplot2))
suppressMessages(library(gridExtra))
suppressMessages(library(GenomicRanges))
suppressMessages(library(limma))
suppressMessages(library(HDF5Array))
opts_chunk$set(eval = FALSE, echo = TRUE, warning = FALSE, message = FALSE)

## ----eval = FALSE-------------------------------------------------------------
# sf <- system.file(file.path("extdata", "data_analyses"),
#                   package = "recountmethylation")
# load(file.path(sf, "data_analyses.RData"))

## ----eval = FALSE-------------------------------------------------------------
# # get local metadata
# mdpath <- system.file("extdata", "gsm_metadata", "md_final_hm450k_0-0-1.rda",
#                     package = "recountmethylation")
# md <- get(load(mdpath))

## -----------------------------------------------------------------------------
# # load methylset
# gmdn <- "remethdb-h5se_gm_0-0-1_1590090412"
# gm <- loadHDF5SummarizedExperiment(gmdn)
# # load grset
# grdn <- "remethdb-h5se_gr_0-0-1_1590090412"
# gr <- loadHDF5SummarizedExperiment(grdn)

## ----eval = FALSE-------------------------------------------------------------
# mdf <- md[!md$age == "valm:NA",]
# mdf$chron.age <- as.numeric(gsub(";.*", "", gsub("^valm:", "", mdf$age)))
# mdf$predage <- as.numeric(mdf$predage)
# mdf <- mdf[!is.na(mdf$chron.age),]
# mdf <- mdf[!is.na(mdf$predage),]

## ----eval = FALSE-------------------------------------------------------------
# mdf$stype <- as.character(gsub(";.*", "",
#   gsub("^msraptype:", "", mdf$sampletype)))
# mdf <- mdf[!is.na(mdf$stype),]

## ----eval = FALSE-------------------------------------------------------------
# mdf$is.cx <- ifelse(grepl(".*cancer.*", mdf$disease), TRUE, FALSE)

## ----eval = FALSE-------------------------------------------------------------
# xdif <- ngsm <- c()
# for(g in unique(mdf$gseid)){
#     mdff <- mdf[mdf$gseid==g, ]
#     xdif <- c(xdif, mean(abs(mdff$chron.age - as.numeric(mdff$predage))))
#     ngsm <- c(ngsm, nrow(mdff))
# }
# names(xdif) <- names(ngsm) <- unique(mdf$gseid)

## ----eval = FALSE-------------------------------------------------------------
# filt <- mdf$stype == "tissue" & !mdf$is.cx
# filt <- filt & !mdf$gseid %in% names(xdif[xdif > 10])
# mdff <- mdf[filt, ]

## ----eval = FALSE-------------------------------------------------------------
# lm1 <- lm(mdf$predage ~ mdf$chron.age + mdf$gseid + mdf$stype + mdf$is.cx)
# lm2 <- lm(mdff$predage ~ mdff$chron.age + mdff$gseid)

## ----eval = FALSE-------------------------------------------------------------
# # anovas
# av1 <- anova(lm1)
# av2 <- anova(lm2)
# # results summaries
# sperc1 <- round(100*av1$`Sum Sq`[1:4]/sum(av1$`Sum Sq`), 2)
# pval1 <- format(av1$`Pr(>F)`[1:4], scientific = TRUE, digits = 3)
# sperc2 <- round(100*av2$`Sum Sq`[1:2]/sum(av2$`Sum Sq`), 2)
# pval2 <- format(av2$`Pr(>F)`[1:2], scientific = TRUE, digits = 3)
# # summary table
# dan <- data.frame(Vperc1 = c(sperc1),
#                   Pval1 = c(pval1),
#                   Vperc2 = c(sperc2, "-", "-"),
#                   Pval2 = c(pval2, "-", "-"),
#                   stringsAsFactors = FALSE)
# rownames(dan) <- c("Chron.Age", "GSEID", "SampleType", "Cancer")
# knitr::kable(dan, align = "c")

## ----eval = FALSE-------------------------------------------------------------
# # rsquared
# rsq1 <- round(summary(lm1)$r.squared, 2)
# rsq2 <- round(summary(lm2)$r.squared, 2)
# # correlation coefficient
# rho1 <- round(cor.test(mdf$predage, mdf$chron.age,
#                       method = "spearman")$estimate, 2)
# rho2 <- round(cor.test(mdff$predage, mdff$chron.age,
#                        test = "spearman")$estimate, 2)
# # mean absolute difference
# mad1 <- round(mean(abs(mdf$chron.age - mdf$predage)), 2)
# mad2 <- round(mean(abs(mdff$chron.age - mdff$predage)), 2)

## ----eval = FALSE-------------------------------------------------------------
# dss <- data.frame(group = c("1", "2"),
#                   ngsm = c(nrow(mdf), nrow(mdff)),
#                   ngse = c(length(unique(mdf$gseid)),
#                     length(unique(mdff$gseid))),
#                   r.squared = c(rsq1, rsq2), rho = as.character(c(rho1, rho2)),
#                   mad = c(mad1, mad2), stringsAsFactors = FALSE)
# knitr::kable(dss, align = "c")

## ----dpi = 65, eval = FALSE, fig.width = 3.8, fig.height = 3.4----------------
# plot(xdif, ngsm, ylab = "Study Size (Num. GSM)",
#      xlab = "Age Difference, MAD[Chron, Pred]")
# abline(v = 10, col = "red")

## ----dpi = 65, eval = FALSE, fig.width = 3.4, fig.height = 3.1----------------
# ggplot(mdff, aes(x = chron.age, y = predage)) +
#   geom_point(size = 1.2, alpha = 0.2) + geom_smooth(method = "lm", size = 1.2) +
#   theme_bw() + xlab("Chronological Age") + ylab("Epigenetic (DNAm) Age")

## ----eval = FALSE-------------------------------------------------------------
# mdf <- md[!md$storage == "NA",]
# mdf$sgroup <- ifelse(grepl("FFPE", mdf$storage), "ffpe", "frozen")

## -----------------------------------------------------------------------------
# # get summary table
# sst <- get_sst(sgroup.labs = c("ffpe", "frozen"), mdf)
# knitr::kable(sst, align = "c") # table display

## -----------------------------------------------------------------------------
# gmf <- gm[, gm$gsm %in% mdf$gsm] # filt h5se object
# mdf <- mdf[order(match(mdf$gsm, gmf$gsm)),]
# identical(gmf$gsm, mdf$gsm)
# gmf$storage <- mdf$storage # append storage info

## -----------------------------------------------------------------------------
# meth.all <- getMeth(gmf)
# unmeth.all <- getUnmeth(gmf)

## -----------------------------------------------------------------------------
# blocks <- getblocks(slength = ncol(gmf), bsize = 1000)

## -----------------------------------------------------------------------------
# ms <- matrix(nrow = 0, ncol = 2)
# l2meth <- l2unmeth <- c()
# for(i in 1:length(blocks)){
#   b <- blocks[[i]]
#   gmff <- gmf[, b]
#   methb <- as.matrix(meth.all[, b])
#   unmethb <- as.matrix(unmeth.all[, b])
#   l2meth <- c(l2meth, apply(methb, 2, function(x){
#     log2(median(as.numeric(x)))
#   }))
#   l2unmeth <- c(l2unmeth, apply(unmethb, 2, function(x){
#     log2(median(as.numeric(x)))
#   }))
#   ms <- rbind(ms, matrix(c(l2meth, l2unmeth), ncol = 2))
#   message(i)
# }
# rownames(ms) <- colnames(meth.all)
# colnames(ms) <- c("meth.l2med", "unmeth.l2med")
# ds <- as.data.frame(ms)
# ds$storage <- ifelse(grepl("FFPE", gmf$storage), "ffpe", "frozen")

## ----dpi = 65, eval = FALSE, fig.width = 4.3, fig.height = 3.1----------------
# ggplot(ds, aes(x = meth.l2med, y = unmeth.l2med, color = storage)) +
#   geom_point(alpha = 0.35, cex = 3) + theme_bw() +
#   scale_color_manual(values = c("ffpe" = "orange", "frozen" = "purple"))

## ----dpi = 65, eval = FALSE, fig.width = 4.5, fig.height = 2.5----------------
# vp <- matrix(nrow = 0, ncol = 2)
# vp <- rbind(vp, matrix(c(ds$meth.l2med, paste0("meth.", ds$storage)),
#   ncol = 2))
# vp <- rbind(vp, matrix(c(ds$unmeth.l2med, paste0("unmeth.", ds$storage)),
#   ncol = 2))
# vp <- as.data.frame(vp, stringsAsFactors = FALSE)
# vp[,1] <- as.numeric(vp[,1])
# colnames(vp) <- c("signal", "group")
# vp$col <- ifelse(grepl("ffpe", vp$group), "orange", "purple")
# # make plot
# ggplot(vp, aes(x = group, y = signal, color = group)) +
#   scale_color_manual(values = c("meth.ffpe" = "orange",
#     "unmeth.ffpe" = "orange", "meth.frozen" = "purple",
#     "unmeth.frozen" = "purple")) +
#   geom_violin(draw_quantiles = c(0.5)) + theme_bw() +
#     theme(legend.position = "none")

## ----eval = FALSE-------------------------------------------------------------
# gsmv <- c(adipose.gsmv, liver.gsmv)
# mdf <- md[md$gsm %in% gsmv,]
# mdf$sgroup <- ifelse(mdf$gsm %in% adipose.gsmv, "adipose", "liver")
# sst.tvar <- get_sst(sgroup.labs = c("liver", "adipose"), mdf)
# knitr::kable(sst.tvar, align = "c")

## -----------------------------------------------------------------------------
# ms <- gm[,colnames(gm) %in% rownames(mdf)]
# ms <- ms[,order(match(colnames(ms), rownames(mdf)))]
# identical(colnames(ms), rownames(mdf))
# # [1] TRUE
# ms$sgroup <- mdf$sgroup
# ms <- mapToGenome(ms)
# dim(ms)
# # [1] 485512    252

## -----------------------------------------------------------------------------
# # get log2 medians
# meth.tx <- getMeth(ms)
# unmeth.tx <- getUnmeth(ms)
# blocks <- getblocks(slength = ncol(ms), bsize = 50)
# # process data in blocks
# l2m <- matrix(nrow = 0, ncol = 2)
# for(i in 1:length(blocks)){
#   b <- blocks[[i]]
#   gmff <- ms[, b]
#   methb <- as.matrix(meth.tx[, b])
#   unmethb <- as.matrix(unmeth.tx[, b])
#   l2meth <- l2unmeth <- c()
#   l2meth <- c(l2meth, apply(methb, 2, function(x){
#     log2(median(as.numeric(x)))
#   }))
#   l2unmeth <- c(l2unmeth, apply(unmethb, 2, function(x){
#     log2(median(as.numeric(x)))
#   }))
#   l2m <- rbind(l2m, matrix(c(l2meth, l2unmeth), ncol = 2))
#   message(i)
# }
# ds2 <- as.data.frame(l2m)
# colnames(ds2) <- c("l2med.meth", "l2med.unmeth")
# ds2$tissue <- as.factor(ms$sgroup)

## ----dpi = 65, eval = FALSE, fig.width = 3.2, fig.height = 2------------------
# ggplot(ds2, aes(x = l2med.meth, y = l2med.unmeth, color = tissue)) +
#   geom_point(alpha = 0.3, cex = 3) + theme_bw()

## -----------------------------------------------------------------------------
# lmv <- lgr <- lmd <- lb <- lan <- list()
# tv <- c("adipose", "liver")
# # get noob norm data
# gr <- gr[,colnames(gr) %in% colnames(ms)]
# gr <- gr[,order(match(colnames(gr), colnames(ms)))]
# identical(colnames(gr), colnames(ms))
# gr$sgroup <- ms$sgroup
# # do study ID adj
# for(t in tv){
#   lmv[[t]] <- gr[, gr$sgroup == t]
#   msi <- lmv[[t]]
#   madj <- limma::removeBatchEffect(getM(msi), batch = msi$gseid)
#   # store adjusted data in a new se object
#   lgr[[t]] <- GenomicRatioSet(GenomicRanges::granges(msi), M = madj,
#                               annotation = annotation(msi))
#   # append samples metadata
#   lmd[[t]] <- pData(lgr[[t]]) <- pData(lmv[[t]])
#   # append preprocessing metadata
#   metadata(lgr[[t]]) <- list("preprocess" = "noobbeta;removeBatchEffect_gseid")
#   # make betavals list
#   lb[[t]] <- getBeta(lgr[[t]]) # beta values list
# }

## -----------------------------------------------------------------------------
# anno <- getAnnotation(gr)
# chr.xy <-c("chrY", "chrX")
# cg.xy <- rownames(anno[anno$chr %in% chr.xy,])
# lbf <- list()
# for(t in tv){
#   bval <- lb[[t]]
#   lbf[[t]] <- bval[!rownames(bval) %in% cg.xy,]
# }
# bv <- lbf[[1]]

## -----------------------------------------------------------------------------
# lvar <- list()
# cnf <- c("gseid", "predsex", "predage", "predcell.CD8T",
#          "predcell.CD4T", "predcell.NK", "predcell.Bcell",
#          "predcell.Mono", "predcell.Gran")
# for(t in tv){
#   for(c in cnf){
#     if(c %in% c("gseid", "predsex")){
#       lvar[[t]][[c]] <- as.factor(pData(lgr[[t]])[,c])
#     } else{
#       lvar[[t]][[c]] <- as.numeric(pData(lgr[[t]])[,c])
#     }
#   }
# }

## -----------------------------------------------------------------------------
# bv <- lbf[[1]]
# blocks <- getblocks(slength = nrow(bv), bsize = 100000)
# mr <- matrix(nrow = 0, ncol = 18)
# lan <- list("adipose" = mr, "liver" = mr)
# t1 <- Sys.time()
# for(bi in 1:length(blocks)){
#   for(t in tv){
#     datr <- lbf[[t]][blocks[[bi]],]
#     tvar <- lvar[[t]]
#     newchunk <- t(apply(datr, 1, function(x){
#       # do multiple regression and anova
#       x <- as.numeric(x)
#       ld <- lm(x ~ tvar[[1]] + tvar[[2]] + tvar[[3]] + tvar[[4]] +
#                  tvar[[5]] + tvar[[6]] + tvar[[7]] + tvar[[8]] + tvar[[9]])
#       an <- anova(ld)
#       # get results
#       ap <- an[c(1:9),5] # pval
#       av <- round(100*an[c(1:9),2]/sum(an[,2]), 3) # percent var
#       return(as.numeric(c(ap, av)))
#     }))
#     # append new results
#     lan[[t]] <- rbind(lan[[t]], newchunk)
#   }
#   message(bi, "tdif: ", Sys.time() - t1)
# }
# # append colnames
# for(t in tv){colnames(lan[[t]]) <- rep(cnf, 2)}

## -----------------------------------------------------------------------------
# pfilt <- 1e-3
# varfilt <- 10
# lcgkeep <- list() # list of filtered probe sets
# for(t in tv){
#   pm <- lan[[t]][,c(1:9)]
#   vm <- lan[[t]][,c(10:18)]
#   # parse variable thresholds
#   cm <- as.data.frame(matrix(nrow = nrow(pm), ncol = ncol(pm)))
#   for(c in 1:ncol(pm)){
#     pc <- pm[,c];
#     pc.adj <- as.numeric(p.adjust(pc))
#     pc.filt <- pc.adj < pfilt
#     vc.filt <- vm[,c] >= varfilt
#     cm[,c] <- (pc.filt & vc.filt)
#   }
#   cgkeep <- apply(cm, 1, function(x){return((length(x[x == TRUE]) == 0))})
#   lcgkeep[[t]] <- rownames(pm)[cgkeep]
# }
# lgr.filt <- list("adipose" = lgr[[1]][lcgkeep[[1]],],
#                  "liver" = lgr[[2]][lcgkeep[[2]],])

## -----------------------------------------------------------------------------
# cnv <- c("min", "max", "mean", "median", "sd", "var")
# bv <- getBeta(lgr.filt[[t]])
# lbt <- lcg.ss <- list()
# bsize = 100000
# for(t in tv){
#   lcg.ss[[t]] <- matrix(nrow = 0, ncol = 6)
#   lbt[[t]] <- bt <- as.matrix(getBeta(lgr.filt[[t]]))
#   blockst <- getblocks(slength = nrow(bt), bsize = bsize)
#   for(bi in 1:length(blockst)){
#     bc <- bt[blockst[[bi]],]
#     newchunk <- t(apply(bc, 1, function(x){
#       newrow <- c(min(x), max(x), mean(x), median(x), sd(x), var(x))
#       return(as.numeric(newrow))
#     }))
#     lcg.ss[[t]] <- rbind(lcg.ss[[t]], newchunk)
#     message(t, ";", bi)
#   }
#   colnames(lcg.ss[[t]]) <- cnv
# }

## -----------------------------------------------------------------------------
# qiv = seq(0, 1, 0.01)
# qwhich = c(100)
# lmvp.abs <- list()
# lci <- list()
# for(t in tv){
#   cgv <- c()
#   sa <- lcg.ss[[t]]
#   sa <- as.data.frame(sa, stringsAsFactors = FALSE)
#   q <- quantile(sa$var, qiv)[qwhich]
#   lmvp.abs[[t]] <- rownames(sa[sa$var > q,])
# }

## -----------------------------------------------------------------------------
# # binned quantiles method
# qiv = seq(0, 1, 0.01) # quantile filter
# qwhich = c(100)
# bin.xint <- 0.1
# binv = seq(0, 1, bin.xint)[1:10] # binned bval mean
# # iter on ncts
# lmvp.bin = list()
# for(t in tv){
#   sa <- as.data.frame(lcg.ss[[t]])
#   cgv <- c()
#   # iterate on betaval bins
#   for(b in binv){
#     bf <- sa[sa$mean >= b & sa$mean < b + bin.xint, ] # get probes in bin
#     q <- qf <- quantile(bf$var, qiv)[qwhich] # do bin filter
#     cgv <- c(cgv, rownames(bf)[bf$var > q]) # append probes list
#   }
#   lmvp.bin[[t]] <- cgv
# }

## ----eval = FALSE-------------------------------------------------------------
# cgav <- c()
# for(t in tv){
#   txcg <- unique(c(lmvp.abs[[t]], lmvp.bin[[t]]))
#   cgav <- c(cgav, txcg)
# }
# cgdf <- as.data.frame(table(cgav))
# cgdf$type <- ifelse(cgdf[,2] > 1, "non-specific", "tissue-specific")
# table(cgdf$type)

## -----------------------------------------------------------------------------
# cgfilt <- cgdf$type == "non-specific"
# cgdff <- cgdf[!cgfilt,]
# ltxcg <- list()
# for(t in tv){
#   cgtx <- c()
#   cgabs <- lmvp.abs[[t]]
#   cgbin <- lmvp.bin[[t]]
#   st <- as.data.frame(lcg.ss[[t]])
#   # get t tissue specific probes
#   filtbt <- rownames(st) %in% cgdff[,1]
#   st <- st[filtbt,]
#   # get top 1k t tissue specific abs probes
#   filt.bf1 <- rownames(st) %in% cgabs
#   sf1 <- st[filt.bf1,]
#   sf1 <- sf1[rev(order(sf1$var)),]
#   cgtx <- rownames(sf1)[1:1000]
#   # get top 1k t tissue specific bin probes, after filt
#   filt.bf2 <- rownames(st) %in% cgbin &
#               !rownames(st) %in% rownames(sf1)
#   sf2 <- st[filt.bf2,]
#   sf2 <- sf2[rev(order(sf2$var)),]
#   cgtx <- c(cgtx, rownames(sf2)[1:1000])
#   ltxcg[[t]] <- cgtx
# }

## -----------------------------------------------------------------------------
# # filtered cg summaries
# lfcg <- lapply(lcg.ss,
#   function(x){x <- x[rownames(x) %in% unique(unlist(ltxcg)),]})
# # annotation subset
# anno <- getAnnotation(gr) # save anno for cga
# anno <- anno[,c("Name", "UCSC_RefGene_Name", "UCSC_RefGene_Group",
#   "Relation_to_Island")]
# anno <- anno[rownames(anno) %in% unique(unlist(ltxcg)),]
# # filtered beta values
# lcgssf <- list()
# for(t in tv){
#   bv <- lcg.ss[[t]]
#   bvf <- bv[rownames(bv) %in% ltxcg[[t]],]
#   lcgssf[[t]] <- bvf
# }

## ----dpi = 65, eval = FALSE, fig.width = 3.8, fig.height = 4.5----------------
# lvp <- makevp(lfcg, ltxcg)
# grid.arrange(lvp[[1]], lvp[[2]], ncol = 1, bottom = "Tissue")

## ----eval = FALSE-------------------------------------------------------------
# tcgss <- matrix(nrow = 0, ncol = 6)
# for(t in tv){
#   datt <- apply(lcgssf[[t]], 2, function(x){
#       round(mean(x), digits = 2)
#   })
#   mt <- matrix(datt, nrow = 1)
#   tcgss <- rbind(tcgss, mt)
# }
# colnames(tcgss) <- colnames(lcgssf$adipose)
# rownames(tcgss) <- tv
# knitr::kable(t(tcgss), align = "c")

## ----dpi = 65, eval = FALSE, fig.width = 8.2, fig.height = 4.7----------------
# cga <- get_cga(anno)
# lhmset <- hmsets(ltxcg, lfcg, cga)
# lhmplots <- hmplots(lhmset$hm.mean, lhmset$hm.var, lhmset$hm.size)
# grid.arrange(lhmplots$hm.mean.plot, lhmplots$hm.var.plot,
#              layout_matrix = matrix(c(1, 1, 1, 1, 1, 2, 2), nrow = 1),
#              bottom = "Tissue", left = "Annotation/Region Type")

## ----get_sessioninfo, eval = FALSE--------------------------------------------
# sessionInfo()

