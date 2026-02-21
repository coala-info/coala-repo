# Code example from 'pancan12' vignette. See references/ for full tutorial.

## ----echo=FALSE-------------------------------------------------------------------------------------------------------------------------------------
library(knitr)
opts_chunk$set(comment="", message=FALSE, warning = FALSE, tidy.opts=list(keep.blank.line=TRUE, width.cutoff=150),options(width=150), cache=TRUE, fig.width=10, fig.height=10, eval = FALSE)

## ---------------------------------------------------------------------------------------------------------------------------------------------------
# ## try http:// if https:// URLs are not supported
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("RTCGA.PANCAN12")
# # or try devel version
# require(devtools)
# if (!require(RTCGA.PANCAN12)) {
#     install_github("RTCGA/RTCGA.PANCAN12")
#     require(RTCGA.PANCAN12)
# }
# # or if you have RTCGA package then simpler code is
# RTCGA::installTCGA('RTCGA.PANCAN12')

## ---------------------------------------------------------------------------------------------------------------------------------------------------
# expression.cb <- rbind(expression.cb1, expression.cb2)

## ---------------------------------------------------------------------------------------------------------------------------------------------------
# grep(expression.cb[,1], pattern="MDM2")
# 
# MDM2 <- expression.cb[8467,-1]
# MDM2v <- t(MDM2)

## ---------------------------------------------------------------------------------------------------------------------------------------------------
# grep(mutation.cb[,1], pattern="TP53$", value = FALSE)
# 
# TP53 <- mutation.cb[18475,-1]
# TP53v <- t(TP53)

## ---------------------------------------------------------------------------------------------------------------------------------------------------
# dfC <- data.frame(names=gsub(clinical.cb[,1], pattern="-", replacement="."), clinical.cb[,c("X_cohort","X_TIME_TO_EVENT","X_EVENT","X_PANCAN_UNC_RNAseq_PANCAN_K16")])
# dfT <- data.frame(names=rownames(TP53v), vT = TP53v)
# dfM <- data.frame(names=rownames(MDM2v), vM = MDM2v)
# dfTMC <- merge(merge(dfT, dfM), dfC)
# colnames(dfTMC) = c("names", "TP53", "MDM2", "cohort","TIME_TO_EVENT","EVENT","PANCAN_UNC_RNAseq_PANCAN_K16")
# dfTMC$TP53 <- factor(dfTMC$TP53)
# 
# # only primary tumor
# # (removed because of Leukemia)
# # dfTMC <- dfTMC[grep(dfTMC$names, pattern="01$"),]

## ---------------------------------------------------------------------------------------------------------------------------------------------------
# library(ggplot2)
# quantile <- stats::quantile
# ggplot(dfTMC, aes(x=cohort, y=MDM2)) + geom_boxplot() + theme_bw() + coord_flip() + ylab("")
# 

## ---------------------------------------------------------------------------------------------------------------------------------------------------
# ggplot(dfTMC, aes(x=cohort, fill=TP53)) + geom_bar() + theme_bw() + coord_flip() + ylab("")

## ---------------------------------------------------------------------------------------------------------------------------------------------------
# sort(table(dfTMC$cohort))

## ---------------------------------------------------------------------------------------------------------------------------------------------------
# dfTMC$MDM2b <- cut(dfTMC$MDM2, c(-100,0,100), labels=c("low", "high"))

## ---------------------------------------------------------------------------------------------------------------------------------------------------
# library(dplyr)
# library(tidyr)
# dfTMC %>%
#   group_by(MDM2b, TP53, cohort) %>%
#   summarize(count=n()) %>%
#   unite(TP53_MDM2, TP53, MDM2b) %>%
#   spread(TP53_MDM2, count, fill = 0)

## ---------------------------------------------------------------------------------------------------------------------------------------------------
# library(survey)
# library(scales)
# library(survMisc)
# 
# # cancer = "TCGA Breast Cancer"
# cancers <- names(sort(-table(dfTMC$cohort)))
# 
# for (cancer in cancers[1:11]) {
#   survp <- survfit(Surv(TIME_TO_EVENT/356,EVENT)~TP53+MDM2b, data=dfTMC, subset=cohort == cancer)
#   pl <- autoplot(survp, title = "")$plot + theme_bw() + scale_x_continuous(limits=c(0,10), breaks=0:10) + ggtitle(cancer) + scale_y_continuous(labels = percent, limits=c(0,1))
#   cat(cancer,"\n")
#   plot(pl)
# }
# 

