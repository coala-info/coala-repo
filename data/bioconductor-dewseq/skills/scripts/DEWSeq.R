# Code example from 'DEWSeq' vignette. See references/ for full tutorial.

## ----setup, echo=FALSE, results="hide"----------------------------------------
knitr::opts_chunk$set(tidy    = FALSE,
                      cache   = FALSE,
                      dev     = "png",
                      message = FALSE,
                      error   = FALSE,
                      warning = TRUE)
suppressPackageStartupMessages(require(BiocStyle))

## ----citaction, eval = FALSE, echo = FALSE------------------------------------
# #**Note:** if you use DEWSeq in published research, please cite:
# #
# #> Authors. (Year)
# #> Title
# #> *Genome Biology*, **15**:550.
# #> [10.1186/s13059-014-0550-8](http://dx.doi.org/10.1186/s13059-014-0550-8)

## ----fig.cap = "Crosslink site trunction at reverse transcription", echo = FALSE----
knitr::include_graphics("truncation.png")

## ----fig.cap = "Truncation sites (referred to as crosslink sites) are the neighboring position of the aligned read", fig.small = TRUE, echo = FALSE----
# fig.width=200, out.width="200px"
knitr::include_graphics("truncationsite.png")

## ----fig.cap = "Different binding modes of RNA-binding proteins", fig.wide = TRUE, echo = FALSE----
# fig.width=200, out.width="200px"
knitr::include_graphics("binding_modes.png")

## ----fig.cap = "Chance of crosslinking", fig.small = TRUE, echo = FALSE-------
# fig.width=200, out.width="200px"
knitr::include_graphics("crosslinking_chance.png")

## ----fig.cap = "Different RNase concentrations will result in different fragment sizes.", fig.small=TRUE, echo = FALSE----
knitr::include_graphics("digestionpatterns.png")

## ----fig.cap = "Read-throughs", fig.small = T, echo = FALSE-------------------
knitr::include_graphics("readthrough.png")

## ----fig.cap = "Early truncation events", echo = FALSE------------------------
knitr::include_graphics("earlytruncation.png")

## ----fig.cap = "Sliding window approach with single-nucleotide position count data", echo = FALSE----
knitr::include_graphics("dewseqoverview.png")

## ----fig.cap = "Combining significant windows", echo = FALSE, fig.small = TRUE----
# fig.width=200, out.width="200px"
knitr::include_graphics("overlapping_sliding_windows.png")

## ----fig.cap = "Combining significant windows", echo = FALSE------------------
knitr::include_graphics("controls.png")

## ----fig.cap = "htseq-clip workflow", echo = FALSE----------------------------
knitr::include_graphics("htseq-clip.png")

## ----install, eval = FALSE----------------------------------------------------
# if(!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("DEWSeq")

## ----load library, eval = TRUE------------------------------------------------
require(DEWSeq)
require(IHW)
require(tidyverse)

## ----filenames, eval = TRUE---------------------------------------------------
countFile <- file.path(system.file('extdata',package='DEWSeq'),'SLBP_K562_w50s20_counts.txt.gz')
annotationFile <- file.path(system.file('extdata',package='DEWSeq'),'SLBP_K562_w50s20_annotation.txt.gz')

## ----loading tidyverse, eval = TRUE, results='hide'---------------------------
require(data.table)

## ----read in count matrix, eval = TRUE----------------------------------------
countData <- fread(countFile, sep = "\t")

## ----read in annotation, eval = TRUE------------------------------------------
annotationData <- fread(annotationFile, sep = "\t")

## ----datasummary1-------------------------------------------------------------
head(countData)
dim(countData)

## ----datasummary2-------------------------------------------------------------
head(annotationData)
dim(annotationData)

## ----create colData-----------------------------------------------------------
colData <- data.frame(
  row.names = colnames(countData)[-1], # since the first column is unique_id
  type      = factor(
                c(rep("IP", 2),    ##  change this accordingly
                  rep("SMI", 1)),  ##
                levels = c("IP", "SMI"))
)

## ----example import-----------------------------------------------------------
ddw <- DESeqDataSetFromSlidingWindows(countData  = countData,
                                      colData    = colData,
                                      annotObj   = annotationData,
                                      tidy       = TRUE,
                                      design     = ~type)
ddw

## ----estimate size factors, eval = TRUE---------------------------------------
ddw <- estimateSizeFactors(ddw)
sizeFactors(ddw)

## ----rowfiltering, eval = FALSE-----------------------------------------------
# keep <- rowSums(counts(ddw)) >= 10
# ddw <- ddw[keep,]

## ----countfiltering, eval = TRUE----------------------------------------------
maxCountFile <- file.path(system.file('extdata',package='DEWSeq'),'SLBP_K562_w50s20_max_counts.txt.gz')
ddw <- filterCounts( object = ddw,maxCountFile = maxCountFile, 
                      countThresh = 5,nsamples = 2)
dim(ddw)

## ----filter for mRNAs, eval = TRUE--------------------------------------------
ddw_mRNAs <- ddw[ rowData(ddw)[,"gene_type"] == "protein_coding", ]
ddw_mRNAs <- estimateSizeFactors(ddw_mRNAs)
sizeFactors(ddw) <- sizeFactors(ddw_mRNAs)
sizeFactors(ddw)

## ----tmp significant windows--------------------------------------------------
ddw_tmp <- ddw
ddw_tmp <- estimateDispersions(ddw_tmp, fitType = "local", quiet = TRUE)
ddw_tmp <- nbinomWaldTest(ddw_tmp)
ddw_tmp_results <- results(ddw_tmp,contrast = c("type", "IP", "SMI"),
                           tidy = TRUE, filterFun =  ihw)
tmp_significant_windows <- ddw_tmp_results %>%
                           dplyr::filter(padj < 0.05) %>% 
                           dplyr::pull(row)
rm(list = c("ddw_tmp", "ddw_tmp_results"))

## -----------------------------------------------------------------------------
ddw_mRNAs <- ddw_mRNAs[ !rownames(ddw_mRNAs) %in% tmp_significant_windows, ]
ddw_mRNAs <- estimateSizeFactors(ddw_mRNAs)
sizeFactors(ddw) <- sizeFactors(ddw_mRNAs)

rm( list = c("tmp_significant_windows", "ddw_mRNAs"))

sizeFactors(ddw)

## ----fitvar-------------------------------------------------------------------
decide_fit <- TRUE

## ----parametric_dispersion----------------------------------------------------
parametric_ddw  <- estimateDispersions(ddw, fitType="parametric")
if(decide_fit){
  local_ddw  <- estimateDispersions(ddw, fitType="local")
}

## ----plot parametric fit, fig.wide=TRUE---------------------------------------
plotDispEsts(parametric_ddw, main="Parametric fit")

## ----plot local fit, fig.wide = TRUE------------------------------------------
if(decide_fit){
  plotDispEsts(local_ddw, main="Local fit")
}

## ----residual fit-------------------------------------------------------------
parametricResid <- na.omit(with(mcols(parametric_ddw),abs(log(dispGeneEst)-log(dispFit))))
if(decide_fit){
  localResid <- na.omit(with(mcols(local_ddw),abs(log(dispGeneEst)-log(dispFit))))
  residDf <- data.frame(residuals=c(parametricResid,localResid),
                        fitType=c(rep("parametric",length(parametricResid)),
                                  rep("local",length(localResid))))
  summary(residDf)
}

## ----plot residual histograms, fig.wide = TRUE--------------------------------
if(decide_fit){
  ggplot(residDf, aes(x = residuals, fill = fitType)) + 
    scale_fill_manual(values = c("darkred", "darkblue")) + 
    geom_histogram(alpha = 0.5, position='identity', bins = 100) + theme_bw()
}

## ----choose_fit---------------------------------------------------------------
summary(parametricResid)
if(decide_fit){
  summary(localResid)
  if (median(localResid) <= median(parametricResid)){
    cat("chosen fitType: local")
    ddw <- local_ddw
  }else{
    cat("chosen fitType: parametric")
    ddw <- parametric_ddw
  }
  rm(local_ddw,parametric_ddw,residDf,parametricResid,localResid)
}else{
  ddw <- parametric_ddw
  rm(parametric_ddw)
}

## ----estimate dispersions and wald test, eval = TRUE--------------------------
ddw <- estimateDispersions(ddw, fitType = "local", quiet = TRUE)
ddw <- nbinomWaldTest(ddw)

## ----fig.cap = "Dispersion Estimates", fig.wide = TRUE------------------------
plotDispEsts(ddw)

## ----DEWSeq results, eval = TRUE----------------------------------------------
resultWindows <- resultsDEWSeq(ddw,
                              contrast = c("type", "IP", "SMI"),
                              tidy = TRUE) %>% as_tibble

resultWindows

## ----IHW multiple hypothesis correction, eval = TRUE, warning = FALSE---------
resultWindows[,"p_adj_IHW"] <- adj_pvalues(ihw(pSlidingWindows ~ baseMean, 
                     data = resultWindows,
                     alpha = 0.05,
                     nfolds = 10))

## ----windows tables, eval = TRUE----------------------------------------------
resultWindows <- resultWindows %>% 
                      mutate(significant = resultWindows$p_adj_IHW < 0.01)

sum(resultWindows$significant)

## ----how genes form windows---------------------------------------------------
resultWindows %>%
   filter(significant) %>% 
   arrange(desc(log2FoldChange)) %>% 
   .[["gene_name"]] %>% 
   unique %>% 
   head(20)

## ----extractRegions, eval = TRUE, results = "hide"----------------------------
resultRegions <- extractRegions(windowRes  = resultWindows,
                                padjCol    = "p_adj_IHW",
                                padjThresh = 0.01, 
                                log2FoldChangeThresh = 0.5) %>% as_tibble

## ----resultRegions output, eval = TRUE----------------------------------------
resultRegions

## ----toBED output, eval = FALSE-----------------------------------------------
# toBED(windowRes = resultWindows,
#       regionRes = resultRegions,
#       fileName  = "enrichedWindowsRegions.bed")

## -----------------------------------------------------------------------------
sessionInfo()

