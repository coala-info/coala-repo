# Code example from 'OVESEG' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"   
)

## ----eval=FALSE---------------------------------------------------------------
# #Microarray
# rtest <- OVESEGtest(y, group, NumPerm=999,
#                     BPPARAM=BiocParallel::SnowParam())
# 
# #RNAseq
# yvoom <- limma::voom(count, model.matrix(~0+factor(group)))
# rtest <- OVESEGtest(yvoom$E, group, weights=yvoom$weights, NumPerm = 999,
#                     BPPARAM=BiocParallel::SnowParam())

## ----echo=TRUE----------------------------------------------------------------
library(OVESEG)
#Import data
data(RocheBT)
y <- RocheBT$y #5000*15 matrix
group <- RocheBT$group #15 labels

#filter low-expressed probes
groupMean <- sapply(levels(group), function(x) rowMeans(y[,group == x]))
groupMeanMax <- apply(groupMean, 1, max)
keep <- (groupMeanMax > log2(64))
y <- y[keep,]

#OVESEG-test
rtest1 <- OVESEGtest(y, group, NumPerm = 999, 
                     BPPARAM=BiocParallel::SnowParam())

## ----echo=TRUE----------------------------------------------------------------
#OVESEG-test
yvooma <- limma::vooma(y, model.matrix(~0+factor(group)))
rtest2 <- OVESEGtest(yvooma$E, group, weights=yvooma$weights, NumPerm = 999,
                     BPPARAM=BiocParallel::SnowParam())

## ----echo=TRUE----------------------------------------------------------------
library(OVESEG)
#Import data
data(countBT)
count <- countBT$count #10000*60 matrix
group <- countBT$group #60 labels

#filter low-expressed probes
groupMean <- sapply(levels(group), function(x) rowMeans(count[,group == x]))
groupMeanMax <- apply(groupMean, 1, max)
keep <- (groupMeanMax > 2)
count <- count[keep,]

#OVESEG-test
lib.size <- max(colSums(count))
yvoom <- limma::voom(count, model.matrix(~0+factor(group)), 
                     lib.size = lib.size)
rtest3 <- OVESEGtest(yvoom$E, group, weights=yvoom$weights, NumPerm = 999,
                     BPPARAM=BiocParallel::SnowParam())

## ----echo=TRUE----------------------------------------------------------------
#OVESEG-test statistics
rtstat1 <- OVESEGtstat(y, RocheBT$group)
rtstat2 <- OVESEGtstat(yvooma$E, RocheBT$group, weights=yvooma$weights)
rtstat3 <- OVESEGtstat(yvoom$E, countBT$group, weights=yvoom$weights)

## ----echo=TRUE----------------------------------------------------------------
ppnull1 <- postProbNull(y, RocheBT$group)
ppnull2 <- postProbNull(yvooma$E, RocheBT$group, weights=yvooma$weights)
ppnull3 <- postProbNull(yvoom$E, countBT$group, weights=yvoom$weights)

## ----echo=TRUE----------------------------------------------------------------
nullDistri(ppnull1)
nullDistri(ppnull2)
nullDistri(ppnull3)

## ----echo=TRUE----------------------------------------------------------------
patterns <- patternDistri(ppnull1)
#or
patterns <- patternDistri(rtest1)

## ----fig.height=6, fig.width=6, fig.show='hold'-------------------------------
library(gridExtra)
library(grid)
library(reshape2)
library(ggplot2)

gridpatterns <- function (ppnull) {
    K <- length(ppnull$label)
    cellcomp <- patternDistri(ppnull)
    cellcomp <- cellcomp[order(cellcomp[,K+1], decreasing = TRUE),]
    
    #Bar Chart to show pattern percentage
    DF1 <- data.frame(Rank = seq_len(2^K - 1), cellcomp)
    p1 <- ggplot(DF1, aes(x = Rank, y = Wpattern)) +
        geom_bar(stat = "identity") +
        scale_y_continuous(labels=scales::percent) +
        theme_bw(base_size = 16) +
        theme(axis.text.x = element_blank(),
              axis.title.x = element_blank(),
              plot.margin=unit(c(1,1,-0.2,1), "cm"),
              panel.grid.minor = element_line(size = 1),
              panel.grid.major = element_line(size = 1),
              panel.border = element_blank(),
              axis.ticks.x = element_blank()) +
        ylab("Percentage of up in certain subtype(s)")
    
    #patterns as X-axis
    DF2 <- data.frame(Rank = seq_len(2^K-1), cellcomp[,-(K+1)])
    DF2 <- melt(DF2, id.var="Rank")
    p2 <- ggplot(DF2, aes(x = Rank, y = value, fill = variable)) +
        geom_bar(stat = "identity") +
        scale_fill_brewer(palette="Set2") +
        theme(line = element_blank(),
              axis.text.x = element_blank(),
              axis.text.y = element_blank(),
              title = element_blank(),
              panel.background = element_rect(fill = "white"),
              legend.position="bottom",
              legend.key.size = unit(1.2,"line"),
              plot.margin=unit(c(-0.2,1,1,1), "cm")) +
        scale_y_reverse() +
        guides(fill = guide_legend(nrow = 1, byrow = TRUE))
    
    g1 <- ggplotGrob(p1)
    g2 <- ggplotGrob(p2)
    colnames(g1) <- paste0(seq_len(ncol(g1)))
    colnames(g2) <- paste0(seq_len(ncol(g2)))
    g <- gtable_combine(g1, g2, along=2)
    panels <- g$layout$t[grepl("panel", g$layout$name)]
    n1 <- length(g$heights[panels[1]])
    n2 <- length(g$heights[panels[2]])
    # assign new (relative) heights to the panels
    # notice the *4 here to get different heights
    g$heights[panels[1]] <- unit(n1*4,"null")
    g$heights[panels[2]] <- unit(n2,"null")
    return(g)
} 

grid.newpage()
grid.draw(gridpatterns(ppnull1))
#or grid.draw(gridpatterns(rtest1))

## ----echo=TRUE----------------------------------------------------------------
##multiple comparison correction 
pv.overall.adj <- stats::p.adjust(rtest1$pv.overall, method="bonferroni")
pv.multiside.adj <- stats::p.adjust(rtest1$pv.multiside, method="bonferroni")

##fdr control
qv.overall <- fdrtool::fdrtool(rtest1$pv.overall, statistic="pvalue",
                               plot=FALSE, verbose=FALSE)$qval
qv.multiside <- fdrtool::fdrtool(rtest1$pv.multiside, statistic="pvalue",
                                 plot=FALSE, verbose=FALSE)$qval

## ----echo=TRUE----------------------------------------------------------------
sessionInfo()

