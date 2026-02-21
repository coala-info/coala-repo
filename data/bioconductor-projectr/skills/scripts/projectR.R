# Code example from 'projectR' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
options(scipen = 1, digits = 2)
set.seed(1234)
library(projectR)

## ----prcomp, warning=FALSE----------------------------------------------------
# data to define PCs
library(ggplot2)
data(p.RNAseq6l3c3t)

# do PCA on RNAseq6l3c3t expression data
pc.RNAseq6l3c3t<-prcomp(t(p.RNAseq6l3c3t))
pcVAR <- round(((pc.RNAseq6l3c3t$sdev)^2/sum(pc.RNAseq6l3c3t$sdev^2))*100,2)
dPCA <- data.frame(cbind(pc.RNAseq6l3c3t$x,pd.RNAseq6l3c3t))

#plot pca

setCOL <- scale_colour_manual(values = c("blue","black","red"), name="Condition:")
setFILL <- scale_fill_manual(values = c("blue","black","red"),guide = FALSE)
setPCH <- scale_shape_manual(values=c(23,22,25,25,21,24),name="Cell Line:")

pPCA <- ggplot(dPCA, aes(x=PC1, y=PC2, colour=ID.cond, shape=ID.line,
        fill=ID.cond)) +
        geom_point(aes(size=days),alpha=.6)+
        setCOL + setPCH  + setFILL +
        scale_size_area(breaks = c(2,4,6), name="Day") +
        theme(legend.position=c(0,0), legend.justification=c(0,0),
              legend.direction = "horizontal",
              panel.background = element_rect(fill = "white",colour=NA),
              legend.background = element_rect(fill = "transparent",colour=NA),
              plot.title = element_text(vjust = 0,hjust=0,face="bold")) +
        labs(title = "PCA of hPSC PolyA RNAseq",
            x=paste("PC1 (",pcVAR[1],"% of varience)",sep=""),
            y=paste("PC2 (",pcVAR[2],"% of varience)",sep=""))

## ----projectR.prcomp, warning=FALSE-------------------------------------------
# data to project into PCs from RNAseq6l3c3t expression data
data(p.ESepiGen4c1l)
library(ggplot2)

PCA2ESepi <- projectR(data = p.ESepiGen4c1l$mRNA.Seq,loadings=pc.RNAseq6l3c3t,
full=TRUE, dataNames=map.ESepiGen4c1l[["GeneSymbols"]])

pd.ESepiGen4c1l<-data.frame(Condition=sapply(colnames(p.ESepiGen4c1l$mRNA.Seq),
  function(x) unlist(strsplit(x,'_'))[1]),stringsAsFactors=FALSE)
pd.ESepiGen4c1l$color<-c(rep("red",2),rep("green",3),rep("blue",2),rep("black",2))
names(pd.ESepiGen4c1l$color)<-pd.ESepiGen4c1l$Cond

dPCA2ESepi<- data.frame(cbind(t(PCA2ESepi[[1]]),pd.ESepiGen4c1l))

#plot pca
library(ggplot2)
setEpiCOL <- scale_colour_manual(values = c("red","green","blue","black"),
  guide = guide_legend(title="Lineage"))

pPC2ESepiGen4c1l <- ggplot(dPCA2ESepi, aes(x=PC1, y=PC2, colour=Condition)) +
  geom_point(size=5) + setEpiCOL +
  theme(legend.position=c(0,0), legend.justification=c(0,0),
  panel.background = element_rect(fill = "white"),
  legend.direction = "horizontal",
  plot.title = element_text(vjust = 0,hjust=0,face="bold")) +
  labs(title = "Encode RNAseq in target PC1 & PC2",
  x=paste("Projected PC1 (",round(PCA2ESepi[[2]][1],2),"% of varience)",sep=""),
  y=paste("Projected PC2 (",round(PCA2ESepi[[2]][2],2),"% of varience)",sep=""))


## ----fig.show='hold', fig.width=10, fig.height=5, echo=FALSE, message= FALSE----
library(gridExtra)
#grid.arrange(pPCA,pPC2ESepiGen4c1l,nrow=1)

## -----------------------------------------------------------------------------
# get data

AP <- get(data("AP.RNAseq6l3c3t")) #CoGAPS run data
AP <- AP$Amean
# heatmap of gene weights for CoGAPs patterns
library(gplots)
par(mar=c(1,1,1,1))
pNMF<-heatmap.2(as.matrix(AP),col=bluered, trace='none',
          distfun=function(c) as.dist(1-cor(t(c))) ,
          cexCol=1,cexRow=.5,scale = "row",
          hclustfun=function(x) hclust(x, method="average")
      )

## -----------------------------------------------------------------------------
# data to project into PCs from RNAseq6l3c3t expression data

data('p.ESepiGen4c1l4')
data('p.RNAseq6l3c3t')

NMF2ESepi <- projectR(p.ESepiGen4c1l$mRNA.Seq,loadings=AP,full=TRUE,
    dataNames=map.ESepiGen4c1l[["GeneSymbols"]])

dNMF2ESepi<- data.frame(cbind(t(NMF2ESepi),pd.ESepiGen4c1l))

#plot pca
library(ggplot2)
setEpiCOL <- scale_colour_manual(values = c("red","green","blue","black"),
guide = guide_legend(title="Lineage"))

pNMF2ESepiGen4c1l <- ggplot(dNMF2ESepi, aes(x=X1, y=X2, colour=Condition)) +
  geom_point(size=5) + setEpiCOL +
  theme(legend.position=c(0,0), legend.justification=c(0,0),
  panel.background = element_rect(fill = "white"),
  legend.direction = "horizontal",
  plot.title = element_text(vjust = 0,hjust=0,face="bold"))
  labs(title = "Encode RNAseq in target PC1 & PC2",
  x=paste("Projected PC1 (",round(PCA2ESepi[[2]][1],2),"% of varience)",sep=""),
  y=paste("Projected PC2 (",round(PCA2ESepi[[2]][2],2),"% of varience)",sep=""))

## ----correlateR-exp-----------------------------------------------------------
# data to

data("p.RNAseq6l3c3t")

# get genes correlated to T
cor2T<-correlateR(genes="T", dat=p.RNAseq6l3c3t, threshtype="N", threshold=10, absR=TRUE)
cor2T <- cor2T@corM
### heatmap of genes more correlated to T
indx<-unlist(sapply(cor2T,rownames))
indx <- as.vector(indx)
colnames(p.RNAseq6l3c3t)<-pd.RNAseq6l3c3t$sampleX
library(reshape2)
pm.RNAseq6l3c3t<-melt(cbind(p.RNAseq6l3c3t[indx,],indx))

library(gplots)
library(ggplot2)
library(viridis)
pCorT<-ggplot(pm.RNAseq6l3c3t, aes(variable, indx, fill = value)) +
  geom_tile(colour="gray20", size=1.5, stat="identity") +
  scale_fill_viridis(option="B") +
  xlab("") +  ylab("") +
  scale_y_discrete(limits=indx) +
  ggtitle("Ten genes most highly pos & neg correlated with T") +
  theme(
    panel.background = element_rect(fill="gray20"),
    panel.border = element_rect(fill=NA,color="gray20", size=0.5, linetype="solid"),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.line = element_blank(),
    axis.ticks = element_blank(),
    axis.text = element_text(size=rel(1),hjust=1),
    axis.text.x = element_text(angle = 90,vjust=.5),
    legend.text = element_text(color="white", size=rel(1)),
    legend.background = element_rect(fill="gray20"),
    legend.position = "bottom",
    legend.title=element_blank()
)


## ----fig.show='hold', fig.width=10, fig.height=5, echo=FALSE------------------
pCorT

## -----------------------------------------------------------------------------
# data to project into from RNAseq6l3c3t expression data
data(p.ESepiGen4c1l)


cor2ESepi <- projectR(p.ESepiGen4c1l$mRNA.Seq,loadings=cor2T[[1]],full=FALSE,
    dataNames=map.ESepiGen4c1l$GeneSymbols)


## ----projectionDriver, message = F, out.width="100%"------
options(width = 60)
library(dplyr, warn.conflicts = F)

#size-normed, log expression
data("microglial_counts")

#size-normed, log expression
data("glial_counts")

#5 pattern cogaps object generated on microglial_counts
data("cr_microglial")
microglial_fl <- cr_microglial@featureLoadings

#the features by which to weight the difference in expression 
pattern_to_weight <- "Pattern_1"
drivers_ci <- projectionDriveR(microglial_counts, #expression matrix
                                       glial_counts, #expression matrix
                                       loadings = microglial_fl, #feature x pattern dataframe
                                       loadingsNames = NULL,
                                       pattern_name = pattern_to_weight, #column name
                                       pvalue = 1e-5, #pvalue before bonferroni correction
                                       display = T,
                                       normalize_pattern = T, #normalize feature weights
                                       mode = "CI") #confidence interval mode


conf_intervals <- drivers_ci$mean_ci[drivers_ci$sig_genes$significant_shared_genes,]


str(conf_intervals)

drivers_pv <- projectionDriveR(microglial_counts, #expression matrix
                                       glial_counts, #expression matrix
                                       loadings = microglial_fl, #feature x pattern dataframe
                                       loadingsNames = NULL,
                                       pattern_name = pattern_to_weight, #column name
                                       pvalue = 1e-5, #pvalue before bonferroni correction
                                       display = T,
                                       normalize_pattern = T, #normalize feature weights
                                       mode = "PV") #confidence interval mode

difexp <- drivers_pv$difexpgenes
str(difexp)



## ---------------------------------------------------------
suppressWarnings(library(cowplot))
#order in ascending order of estimates
conf_intervals <- conf_intervals %>% mutate(mid = (high+low)/2) %>% arrange(mid)
gene_order <- rownames(conf_intervals)

#add text labels for top and bottom n genes
conf_intervals$label_name <- NA_character_
n <- 2
idx <- c(1:n, (dim(conf_intervals)[1]-(n-1)):dim(conf_intervals)[1])
gene_ids <- gene_order[idx]
conf_intervals$label_name[idx] <- gene_ids

#the labels above can now be used as ggplot aesthetics
plots_list <- plotConfidenceIntervals(conf_intervals, #mean difference in expression confidence intervals
                                      sort = F, #should genes be sorted by estimates
                                      weights = drivers_ci$normalized_weights[rownames(conf_intervals)],
                                      pattern_name = pattern_to_weight,
                                      weights_clip = 0.99,
                                      weights_vis_norm = "none")

pl1 <- plots_list[["ci_estimates_plot"]] +
  ggrepel::geom_label_repel(aes(label = label_name), max.overlaps = 20, force = 50)

pl2 <- plots_list[["weights_heatmap"]]

#now plot the weighted differences
weighted_conf_intervals <- drivers_ci$weighted_mean_ci[gene_order,]
plots_list_weighted <- plotConfidenceIntervals(weighted_conf_intervals,
                                               sort = F,
                                               weighted = T)

pl3 <- plots_list_weighted[["ci_estimates_plot"]] +
  xlab("Difference in weighted group means") +
  theme(axis.title.y = element_blank(), axis.ticks.y = element_blank(), axis.text.y = element_blank())

cowplot::plot_grid(pl1, pl2, pl3, align = "h", rel_widths = c(1,.4, 1), ncol = 3)




## ----fig.width=9, fig.height=10---------------------------
suppressWarnings(library(cowplot))
library(fgsea)
library(msigdbr)
#manually change FC and pvalue threshold from defaults 0.2, 1e-5
drivers_pv_mod <- pdVolcano(drivers_pv, FC = 0.5, pvalue = 1e-7)

difexp_mod <- drivers_pv_mod$difexpgenes
str(difexp_mod)

#fgsea application 

#extract unweighted fgsea vector
fgseavec <- drivers_pv$fgseavecs$unweightedvec
#split into enrichment groups, negative estimates are enriched in the reference matrix (glial), positive are enriched in the test matrix (microglial), take abs value 
glial_fgsea_vec <- abs(fgseavec[which(fgseavec < 0)])
microglial_fgsea_vec <- abs(fgseavec[which(fgseavec > 0)])

#get FGSEA pathways - selecting subcategory C8 for cell types
msigdbr_list =  msigdbr::msigdbr(species = "Mus musculus", category = "C8")
pathways = split(x = msigdbr_list$ensembl_gene, f = msigdbr_list$gs_name)

#run fgsea scoreType positive, all values will be positive
glial_fgsea <- fgsea::fgsea(pathways, glial_fgsea_vec, scoreType = "pos")
#tidy 
glial_fgseaResTidy <- glial_fgsea %>% 
  subset(padj <= 0.05 & size >= 10 & size <= 500) %>%
    as_tibble() %>%
    dplyr::arrange(desc(size))
#plot 
glial_EnrichmentPlot <- ggplot2::ggplot(glial_fgseaResTidy, 
                                        ggplot2::aes(reorder(pathway, NES), NES)) + 
  ggplot2::geom_point(aes(size=size, color = padj)) + 
  coord_flip() + 
  labs(x="Pathway", y="Normalized Enrichment Score", title="Pathway NES from GSEA") + 
  theme_minimal()
glial_EnrichmentPlot
  
microglial_fgsea <- fgsea::fgsea(pathways, microglial_fgsea_vec, scoreType = "pos")
#tidy 
microglial_fgseaResTidy <- microglial_fgsea %>% 
  subset(padj <= 0.05 & size >= 10 & size <= 500) %>%
    as_tibble() %>%
    dplyr::arrange(desc(size))

microglial_EnrichmentPlot <- ggplot2::ggplot(microglial_fgseaResTidy, 
                                             ggplot2::aes(reorder(pathway, NES), NES)) +
  ggplot2::geom_point(aes(size=size, color = padj)) + 
  coord_flip() + 
  labs(x="Pathway", y="Normalized Enrichment Score", title="Pathway NES from GSEA") + 
  theme_minimal()
microglial_EnrichmentPlot




