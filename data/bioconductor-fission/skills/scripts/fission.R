# Code example from 'fission' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# library("GEOquery")
# gse <- getGEO(filename="GSE56761_series_matrix.txt")
# pdata <- pData(gse)[,grepl("characteristics",names(pData(gse)))]

## ----eval=FALSE---------------------------------------------------------------
# names(pdata) <- c("strain","treatment","time","replicate")
# pdataclean <- data.frame(strain=ifelse(grepl("wild type",pdata$strain),"wt","mut"),
#                          minute=sub("time  \\(min\\): (.*)","\\1",pdata$time),
#                          replicate=paste0("r",sub("replicate: (.*)","\\1",pdata$replicate)),
#                          row.names=rownames(pdata))
# pdataclean$id <- paste(pdataclean$strain,pdataclean$minute,pdataclean$replicate,sep="_")
# pdataclean$strain <- relevel(pdataclean$strain, "wt")
# pdataclean$minute <- factor(pdataclean$minute, levels=c("0","15","30","60","120","180"))

## ----eval=FALSE---------------------------------------------------------------
# load("GSE56761_count_data.Rdata")
# stopifnot(all.equal(rownames(reads.GSE56761), as.character(gene.annotations$pombase_id)))
# colnames(reads.GSE56761) <- tolower(colnames(reads.GSE56761))
# stopifnot(all.equal(colnames(reads.GSE56761), pdataclean$id))
# colnames(reads.GSE56761) <- rownames(pdataclean)
# library("SummarizedExperiment")
# coldata <- DataFrame(pdataclean)

## ----eval=FALSE---------------------------------------------------------------
# genes <- gene.annotations
# rowranges <- GRanges(seqnames=genes$chromosome,
#                      ranges=IRanges(genes$start,
#                        genes$end),
#                      strand=genes$strand,
#                      genes[,6:7])
# mcols(rowranges)$symbol <- as.character(mcols(rowranges)$symbol)
# names(rowranges) <- genes$pombase_id

## ----eval=FALSE---------------------------------------------------------------
# library("annotate")
# metadata <- pmid2MIAME("24853205")
# metadata@url <- "http://www.ncbi.nlm.nih.gov/pubmed/24853205"

## ----eval=FALSE---------------------------------------------------------------
# fission <- SummarizedExperiment(SimpleList(counts=reads.GSE56761),
#                                 rowRanges=rowranges,
#                                 colData=coldata,
#                                 metadata=list(metadata))
# save(fission, file="fission.RData")

