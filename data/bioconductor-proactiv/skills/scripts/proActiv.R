# Code example from 'proActiv' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----QuickStart, eval=TRUE, message=FALSE, results='hide'---------------------
library(proActiv)

## List of STAR junction files as input
files <- list.files(system.file('extdata/vignette/junctions', 
                                package = 'proActiv'), full.names = TRUE)
## Vector describing experimental condition
condition <- rep(c('A549','HepG2'), each=3)
## Promoter annotation for human genome GENCODE v34 restricted to a subset of chr1
promoterAnnotation <- promoterAnnotation.gencode.v34.subset

result <- proActiv(files = files, 
                   promoterAnnotation = promoterAnnotation,
                   condition = condition)

## ----List files, eval=FALSE---------------------------------------------------
# files <- list.files(system.file('extdata/vignette/junctions',
#                                 package = 'proActiv'), full.names = TRUE)

## ----Create annotation, eval=FALSE--------------------------------------------
# ## From GTF file path
# gtf.file <- system.file('extdata/vignette/annotation/gencode.v34.annotation.subset.gtf.gz',
#                         package = 'proActiv')
# promoterAnnotation.gencode.v34.subset <- preparePromoterAnnotation(file = gtf.file,
#                                                                    species = 'Homo_sapiens')
# ## From TxDb object
# txdb.file <- system.file('extdata/vignette/annotation/gencode.v34.annotation.subset.sqlite',
#                          package = 'proActiv')
# txdb <- loadDb(txdb.file)
# promoterAnnotation.gencode.v34.subset <- preparePromoterAnnotation(txdb = txdb,
#                                                                    species = 'Homo_sapiens')

## ----Other species, eval=TRUE-------------------------------------------------
names(GenomeInfoDb::genomeStyles())

## ----proActiv, eval=FALSE, message=FALSE, results='hide'----------------------
# promoterAnnotation <- promoterAnnotation.gencode.v34.subset
# 
# condition <- rep(c('A549', 'HepG2'), each=3)
# 
# result <- proActiv(files = files,
#                    promoterAnnotation = promoterAnnotation,
#                    condition = condition)

## ----proActiv result, eval=TRUE-----------------------------------------------
show(result)

## ----Result rowData, eval=TRUE, echo=FALSE------------------------------------
knitr::kable(head(rowData(result)))

## ----Filter result, eval=TRUE-------------------------------------------------
## Removes single-exon transcripts / promoters by eliminating promoter counts that are NA 
result <- result[complete.cases(assays(result)$promoterCounts),]

## ----Get alternative, eval=TRUE-----------------------------------------------
alternativePromoters <- getAlternativePromoters(result = result, referenceCondition = "A549")
show(alternativePromoters)

## ----Boxplot, eval=TRUE, message=FALSE, fig.align='center', fig.height=5, fig.width=7----
plots <- boxplotPromoters(result, "ENSG00000076864.19")

# Boxplot of absolute promoter activity
library(gridExtra)
grid.arrange(plots[[1]], plots[[3]], nrow = 1, ncol = 2, widths = c(3, 2))

## ----VizPromoterCategories, eval=TRUE, fig.align='center', fig.height=5, fig.width=5, message=FALSE, warning=FALSE----
library(ggplot2)

rdata <- rowData(result)
## Create a long dataframe summarizing cell line and promoter class
pdata1 <- data.frame(cellLine = rep(c('A549', 'HepG2'), each = nrow(rdata)),
                       promoterClass = as.factor(c(rdata$A549.class, rdata$HepG2.class)))

ggplot(na.omit(pdata1)) +
  geom_bar(aes(x = cellLine, fill = promoterClass)) + 
  xlab('Cell Lines') + ylab('Count') +  labs(fill = 'Promoter Category') +
  ggtitle('Categorization of Promoters')

## ----VizMajorMinorPosition, eval=TRUE, fig.align='center', fig.height=5, fig.width=5, message=FALSE, warning=FALSE----
## Because many genes have many annotated promoters, we collapse promoters 
## from the 5th position and onward into one group for simplicity
pdata2 <- as_tibble(rdata) %>%
  mutate(promoterPosition = ifelse(promoterPosition > 5, 5, promoterPosition)) %>%
  filter(HepG2.class %in% c('Major', 'Minor'))

ggplot(pdata2) +
  geom_bar(aes(x = promoterPosition, fill = as.factor(HepG2.class)), position = 'fill') +
  xlab(expression(Promoter ~ Position ~ "5'" %->% "3'")) + ylab('Percentage') + 
  labs(fill = 'Promoter Category') + ggtitle('Major/Minor Promoter Proportion in HepG2') + 
  scale_y_continuous(breaks = seq(0,1, 0.25), labels = paste0(seq(0,100,25),'%')) +
  scale_x_continuous(breaks = seq(1,5), labels = c('1','2','3','4','>=5'))

## ----VizMajorGeneExp, eval=TRUE, fig.align='center', fig.height=5, fig.width=6.5, message=FALSE, warning=FALSE----
## Get active major promoters of HepG2
majorPromoter <- as_tibble(rdata) %>% group_by(geneId) %>% 
  mutate(promoterCount = n()) %>% filter(HepG2.class == 'Major') 

pdata3 <- data.frame(proActiv = majorPromoter$HepG2.mean,
                     geneExp = majorPromoter$HepG2.gene.mean,
                     promoterCount = majorPromoter$promoterCount)

ggplot(pdata3, aes(x = geneExp, y = proActiv)) + 
  geom_point(aes(colour = promoterCount), alpha = 0.5) +
  ggtitle('Major Promoter Activity vs. Gene Expression in HepG2') + 
  xlab('Average Gene Expression') + ylab('Average Major Promoter Activity') +
  labs(colour = 'Number of \n Annotated Promoters') +
  geom_abline(slope = 1, intercept = 0, colour = 'red', linetype = 'dashed')

## ----VizTsne, eval=TRUE, fig.align='center', fig.height=5.2, fig.width=5.2----
library(Rtsne)

## Remove inactive promoters (sparse rows)
data <- assays(result)$absolutePromoterActivity %>% filter(rowSums(.) > 0)
data <- data.frame(t(data))
data$Sample <- as.factor(condition)

set.seed(40) # for reproducibility

tsne.out <- Rtsne(as.matrix(subset(data, select = -c(Sample))), perplexity = 1)
plot(x = tsne.out$Y[,1], y = tsne.out$Y[,2], bg = data$Sample, asp = 1,
     col = 'black', pch = 24, cex = 4,
     main = 't-SNE plot with promoters \n active in at least one sample',
     xlab = 'T-SNE1', ylab = 'T-SNE2',
     xlim = c(-300,300), ylim = c(-300,300))
legend('topright', inset = .02, title = 'Cell Lines',
       unique(condition), pch = c(24,24), pt.bg = 1:length(unique(condition)) , cex = 1.5, bty = 'n')

## ----SessionInfo, eval=TRUE, echo=FALSE---------------------------------------
sessionInfo()

