# Code example from 'roastgsaExample_genesetcollections' vignette. See references/ for full tutorial.

## ----message = FALSE, eval=FALSE----------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("roastgsa")
# 

## ----message = FALSE----------------------------------------------------------
# DO NOT RUN
# gspath = "path/to/folder/of/h.all.v7.2.symbols.gmt"
# gsetsel = "h.all.v7.2.symbols.gmt"

## ----message = FALSE----------------------------------------------------------
# DO NOT RUN
# library(GEOquery)
# data <- getGEO('GSE145603')
# normdata <- (data[[1]])
# pd <- pData(normdata)
# pd$group_LGR5 <- pd[["lgr5:ch1"]]

## ----message = FALSE----------------------------------------------------------
# DO NOT RUN
# form <- "~ -1 + group_LGR5"
# design <- model.matrix(as.formula(form),pd)
# cont.mat <- data.frame(Lgr5.high_Lgr5.neg = c(1,-1))
# rownames(cont.mat) <- colnames(design)

## ----message = FALSE----------------------------------------------------------
# DO NOT RUN
# mads <- apply(exprs(normdata), 1, mad)
# gu <- strsplit(fData(normdata)[["Gene Symbol"]], split=' \\/\\/\\/ ')
# names(gu) <- rownames(fData(normdata))
# gu <- gu[sapply(gu, length)==1]
# gu <- gu[gu!='' & !is.na(gu) & gu!='---']
# ps <- rep(names(gu), sapply(gu, length))
# gs <- unlist(gu)
# pss <- tapply(ps, gs, function(o) names(which.max(mads[o])))
# psgen.mvar <- pss

## ----message = FALSE----------------------------------------------------------
# DO NOT RUN
# roast1 <- roastgsa(exprs(normdata), form = form, covar = pd,
#                    psel = psgen.mvar, contrast = cont.mat[, 1],
#                    gspath = gspath, gsetsel = gsetsel, nrot = 1000,
#                    mccores = 7, set.statistic = "maxmean")
#
# print(roast1)
#

## ----message = FALSE----------------------------------------------------------
sessionInfo()

