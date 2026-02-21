# Code example from 'tcgaWGBSData.hg19' vignette. See references/ for full tutorial.

## ---- warning=FALSE, message=FALSE, eval=FALSE---------------------------
#  library(ExperimentHub)
#  eh = ExperimentHub()
#  query(eh, "tcgaWGBSData.hg19")

## ---- warning=FALSE, message=FALSE, cache=TRUE, eval=FALSE---------------
#  tcga_data <- eh[["EH1661"]]
#  TCGA_bs <- eh[["EH1662"]]
#  file.rename(from=tcga_data,to=paste0(dirname(tcga_data),'/assays.h5'))

## ---- warning=FALSE, message=FALSE, eval=FALSE---------------------------
#  library(Biobase)
#  phenoData <- Biobase::pData(TCGA_bs)

## ---- warning=FALSE, message=FALSE, eval=FALSE---------------------------
#  cov_matrix <- bsseq::getCoverage(TCGA_bs)
#  meth_matrix <- bsseq::getCoverage(TCGA_bs, type='M')
#  meth_matrix <- meth_matrix/cov_matrix
#  
#  # Get total CpG coverage
#  totCov <- colSums(cov_matrix>0)
#  
#  # Restrict to CpGs with minimum read covergae of 10
#  meth_matrix[cov_matrix<10] <- NA
#  
#  meanMethylation <- DelayedArray::colMeans(meth_matrix, na.rm=TRUE)
#  sampleType <- phenoData$sample.type
#  Df <- data.frame('mean-methylation' = meanMethylation, 'type' = sampleType)
#  
#  g <- ggplot2::ggplot()
#  g <- g + ggplot2::geom_boxplot(data=Df,ggplot2::aes(x=type,y=mean.methylation))
#  g <- g + ggplot2::xlab('sample type') + ggplot2::ylab('Methylation')
#  g <- g + ggplot2::theme(axis.text.x = element_text(angle = 0, hjust = 1))
#  g
#  

## ---- warning=FALSE, message=FALSE, eval=FALSE---------------------------
#  chr1Index <- seqnames(TCGA_bs) == 'chr22'
#  
#  group1 <- c(11, 6, 23) # normal samples
#  group2 <- c(20, 26, 25) # Tumor samples
#  subSample <- c(group1, group2)
#  
#  TCGA_bs_sub <- updateObject(TCGA_bs[chr1Index,subSample])
#  TCGA_bs_sub.fit <- bsseq::BSmooth(TCGA_bs_sub, mc.cores = 2, verbose = TRUE)
#  TCGA_bs_sub.tstat <- bsseq::BSmooth.tstat(TCGA_bs_sub.fit,
#                                  group1 = c(1,2,3),
#                                  group2 = c(4,5,6),
#                                  estimate.var = "group2",
#                                  local.correct = TRUE,
#                                  verbose = TRUE)
#  plot(TCGA_bs_sub.tstat)
#  
#  
#  dmrs0 <- bsseq::dmrFinder(TCGA_bs_sub.tstat, cutoff = c(-4.6, 4.6))
#  dmrs <- subset(dmrs0, n >= 3 & abs(meanDiff) >= 0.1)
#  nrow(dmrs)
#  head(dmrs, n = 3)
#  
#  
#  pData <- pData(TCGA_bs_sub.fit)
#  pData$col <- rep(c("red", "blue"), each = 3)
#  pData(TCGA_bs_sub.fit) <- pData
#  
#  plotRegion(TCGA_bs_sub.fit, dmrs[1,], extend = 5000, addRegions = dmrs)
#  

## ---- warning=FALSE, message=FALSE---------------------------------------
sessionInfo()

