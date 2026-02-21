# tcgaWGBSData.hg19 Vignette

#### *Divy S. Kangeyan*

#### *2018-11-01*

Differential Methylation Analysis with Whole Genome Bisulfite Sequencing (WGBS) Data in TCGA

```
library(ExperimentHub)
eh = ExperimentHub()
query(eh, "tcgaWGBSData.hg19")
```

Data can be extracted using

```
tcga_data <- eh[["EH1661"]]
TCGA_bs <- eh[["EH1662"]]
file.rename(from=tcga_data,to=paste0(dirname(tcga_data),'/assays.h5'))
```

Phenotypic data can be extracted by

```
library(Biobase)
phenoData <- Biobase::pData(TCGA_bs)
```

Methylation Comparison between normal and tumor sample

```
cov_matrix <- bsseq::getCoverage(TCGA_bs)
meth_matrix <- bsseq::getCoverage(TCGA_bs, type='M')
meth_matrix <- meth_matrix/cov_matrix

# Get total CpG coverage
totCov <- colSums(cov_matrix>0)

# Restrict to CpGs with minimum read covergae of 10
meth_matrix[cov_matrix<10] <- NA

meanMethylation <- DelayedArray::colMeans(meth_matrix, na.rm=TRUE)
sampleType <- phenoData$sample.type
Df <- data.frame('mean-methylation' = meanMethylation, 'type' = sampleType)

g <- ggplot2::ggplot()
g <- g + ggplot2::geom_boxplot(data=Df,ggplot2::aes(x=type,y=mean.methylation))
g <- g + ggplot2::xlab('sample type') + ggplot2::ylab('Methylation')
g <- g + ggplot2::theme(axis.text.x = element_text(angle = 0, hjust = 1))
g
```

Differential methylation analysis of tumor samples

```
chr1Index <- seqnames(TCGA_bs) == 'chr22'

group1 <- c(11, 6, 23) # normal samples
group2 <- c(20, 26, 25) # Tumor samples
subSample <- c(group1, group2)

TCGA_bs_sub <- updateObject(TCGA_bs[chr1Index,subSample])
TCGA_bs_sub.fit <- bsseq::BSmooth(TCGA_bs_sub, mc.cores = 2, verbose = TRUE)
TCGA_bs_sub.tstat <- bsseq::BSmooth.tstat(TCGA_bs_sub.fit,
group1 = c(1,2,3),
group2 = c(4,5,6),
estimate.var = "group2",
local.correct = TRUE,
verbose = TRUE)
plot(TCGA_bs_sub.tstat)

dmrs0 <- bsseq::dmrFinder(TCGA_bs_sub.tstat, cutoff = c(-4.6, 4.6))
dmrs <- subset(dmrs0, n >= 3 & abs(meanDiff) >= 0.1)
nrow(dmrs)
head(dmrs, n = 3)

pData <- pData(TCGA_bs_sub.fit)
pData$col <- rep(c("red", "blue"), each = 3)
pData(TCGA_bs_sub.fit) <- pData

plotRegion(TCGA_bs_sub.fit, dmrs[1,], extend = 5000, addRegions = dmrs)
```

```
sessionInfo()
```

```
## R version 3.5.1 Patched (2018-07-12 r74967)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 16.04.5 LTS
##
## Matrix products: default
## BLAS: /home/biocbuild/bbs-3.8-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.8-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## loaded via a namespace (and not attached):
##  [1] compiler_3.5.1  backports_1.1.2 magrittr_1.5    rprojroot_1.3-2
##  [5] htmltools_0.3.6 tools_3.5.1     yaml_2.2.0      Rcpp_0.12.19
##  [9] stringi_1.2.4   rmarkdown_1.10  knitr_1.20      stringr_1.3.1
## [13] digest_0.6.18   evaluate_0.12
```