# Code example from 'TNBC.CMS' vignette. See references/ for full tutorial.

## ----include=FALSE-------------------------------------------------------
library(knitr)
opts_chunk$set(concordance=TRUE)
options(scipen = 1, digits = 2, warn = -1)

## ----loadPackagesAndData,message=FALSE-----------------------------------
library(TNBC.CMS)
data("GSE25055")
dim(assays(GSE25055)[[1]])
assays(GSE25055)[[1]][1:5, 1:5]

## ----prediction----------------------------------------------------------
predictions <- predictCMS(GSE25055)
table(predictions)
head(attr(predictions, "probabilities"))

## ----include=FALSE-------------------------------------------------------
resultGES <- t(as.matrix(colData(GSE25055)[,3:9]))

## ----eval=FALSE----------------------------------------------------------
#  resultGES <- computeGES(expr = GSE25055, pred = predictions,
#                          rnaseq = FALSE)

## ----eval=TRUE-----------------------------------------------------------
resultGES[,1:4]

## ----label=gesplot,echo=FALSE,fig.height=4,fig.cap="Gene expression signature scores",fig.pos="H",message=FALSE----
library(grid)
library(ggpubr)
CMS.palette <- c("MSL" = "brown2", "IM" = "gold2",
                   "LAR" = "yellowgreen", "SL" = "midnightblue")
pval1 <- 8.1e-7
pval2 <- 3.6e-6
pval3 <- 0.016
pval4 <- 0.00034
TITLE_SIZE <- 12
SUBTITLE_SIZE <- 10

sigdat <- data.frame(t(resultGES))
sigdat$CMS <- predictions

sub1 <- bquote(paste("Wilcoxon (MSL vs. others) ",
                         italic(p), " = ", .(format(pval1, digits = 2))))
sub2 <- bquote(paste("Wilcoxon (MSL vs. others) ",
                         italic(p), " = ", .(format(pval2, digits = 2))))
sub3 <- bquote(paste("Wilcoxon (MSL vs. others) ",
                         italic(p), " = ", .(format(pval3, digits = 2))))
sub4 <- bquote(paste("Wilcoxon (MSL vs. others) ",
                         italic(p), " = ", .(format(pval4, digits = 2))))

p1 <- ggboxplot(sigdat, x = "CMS", y = "Stromal",
                fill = "CMS", palette = CMS.palette) +
  theme_bw() + labs(title = "Stromal", subtitle = sub1) +
  theme(legend.position = "none", axis.title = element_blank(),
        axis.text.x = element_blank(), axis.ticks.x = element_blank(),
        panel.grid = element_blank(),
        plot.title = element_text(size = TITLE_SIZE,
                                  hjust = 0.5, face = "bold"),
        plot.subtitle = element_text(size=  SUBTITLE_SIZE, hjust = 0.5))

p2 <- ggboxplot(sigdat, x = "CMS", y = "Immune",
                fill = "CMS", palette = CMS.palette) +
  theme_bw() + labs(title = "Immune", subtitle = sub2) +
  theme(legend.position = "none", axis.title = element_blank(),
        axis.text.x = element_blank(), axis.ticks.x = element_blank(),
        panel.grid = element_blank(),
        plot.title = element_text(size = TITLE_SIZE,
                                  hjust = 0.5, face = "bold"),
        plot.subtitle = element_text(size=  SUBTITLE_SIZE, hjust = 0.5))

p3 <- ggboxplot(sigdat, x = "CMS", y = "Hormone",
                fill = "CMS", palette = CMS.palette) +
  theme_bw() + labs(title = "Hormone", subtitle = sub3) +
  theme(legend.position = "none", axis.title = element_blank(),
        axis.text.x = element_blank(), axis.ticks.x = element_blank(),
        panel.grid = element_blank(),
        plot.title = element_text(size = TITLE_SIZE,
                                  hjust = 0.5, face = "bold"),
        plot.subtitle = element_text(size=  SUBTITLE_SIZE, hjust = 0.5))

p4 <- ggboxplot(sigdat, x = "CMS", y = "Stemness",
                fill = "CMS", palette = CMS.palette) +
  theme_bw() + labs(title = "Stem", subtitle = sub4) +
  theme(legend.position = "none", axis.title = element_blank(),
        axis.text.x = element_blank(), axis.ticks.x = element_blank(),
        panel.grid = element_blank(),
        plot.title = element_text(size = TITLE_SIZE,
                                  hjust = 0.5, face = "bold"),
        plot.subtitle = element_text(size=  SUBTITLE_SIZE, hjust = 0.5))

g1 <- ggplotGrob(p1)
g2 <- ggplotGrob(p2)
g3 <- ggplotGrob(p3)
g4 <- ggplotGrob(p4)
g <- cbind(rbind(g1, g3, size = "first"),
           rbind(g2,  g4, size = "first"), size = "first")
grid.newpage()
grid.draw(g)

## ----label=gsa,fig.height=6,fig.cap="GSVA enrichment scores",fig.pos="H",fig.show="hold"----
resultGSVA <- performGSVA(expr = GSE25055, pred = predictions,
                          gene.set = NULL)
head(resultGSVA[,1:4])

## ----label=os,fig.height=3,fig.width=5,fig.cap="Overall survival",fig.pos="H",fig.show="hold",fig.align="center"----
time <- colData(GSE25055)$DFS.month
event <- colData(GSE25055)$DFS.status
plotKM(pred = predictions, time = time, event = event)

## ----label=hr,fig.height=3,fig.cap="Forest plot of hazard ratios",fig.pos="H",fig.show="hold"----
library(survival)

#Test for difference of survival between low and high expression groups
surv <- Surv(time, event)
GSE25055.exprs <- assays(GSE25055)[[1]]
chisq <- apply(GSE25055.exprs, 1, function(x) survdiff(surv ~ (x > median(x)))$chisq)
pval <- 1 - pchisq(chisq, 1)

#Select 10 genes with lowest p-values for the log-rank test
gs <- names(sort(pval)[1:10])
gs
plotHR(expr = GSE25055, gene.symbol = gs, pred = predictions, time = time,
       event = event, by.subtype = FALSE)

## ----label=hrsub,fig.height=4,fig.cap="Forest plot of subtype-specific hazard ratios",fig.pos="H",fig.show="hold"----
plotHR(expr = GSE25055, gene.symbol = gs[1:4], pred = predictions,
       time = time, event = event, by.subtype = TRUE)

## ----label=ds,fig.height=3,fig.cap="Drug signature scores",fig.pos="H",fig.show="hold"----
resultDS <- computeDS(expr = GSE25055, pred = predictions)
head(resultDS[,1:4])

## ----saveResults---------------------------------------------------------
dfCMS <- data.frame(row.names = colnames(GSE25055.exprs), CMS = predictions, t(resultGES),
                    t(resultDS), stringsAsFactors = FALSE)
head(dfCMS)
write.table(dfCMS, file = "GSE25055_CMS.txt")

## ----sessionInfo---------------------------------------------------------
sessionInfo()

