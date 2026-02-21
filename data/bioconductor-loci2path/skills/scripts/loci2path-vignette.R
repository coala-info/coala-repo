# Code example from 'loci2path-vignette' vignette. See references/ for full tutorial.

## ----query_region-------------------------------------------------------------
require(GenomicRanges)
bed.file <- system.file("extdata", "query/Psoriasis.BED", package = "loci2path")
query.bed <- read.table(bed.file, header=FALSE)
colnames(query.bed) <- c("chr","start","end")
query.gr <- makeGRangesFromDataFrame(query.bed)

## ----eset---------------------------------------------------------------------
library(loci2path)
library(GenomicRanges)
brain.file <- system.file("extdata", "eqtl/brain.gtex.txt", 
                       package="loci2path")
tab <- read.table(brain.file, stringsAsFactors=FALSE, header=TRUE)
snp.gr <- GRanges(seqnames=Rle(tab$snp.chr), 
  ranges=IRanges(start=tab$snp.pos, 
  width=1))
brain.eset <- eqtlSet(tissue="brain",
  eqtlId=tab$snp.id,
  eqtlRange=snp.gr,
  gene=as.character(tab$gene.entrez.id))
brain.eset

skin.file <- system.file("extdata", "eqtl/skin.gtex.txt", package="loci2path")
tab=read.table(skin.file, stringsAsFactors=FALSE, header=TRUE)
snp.gr <- GRanges(seqnames=Rle(tab$snp.chr), 
  ranges=IRanges(start=tab$snp.pos, 
  width=1))
skin.eset <- eqtlSet(tissue="skin",
  eqtlId=tab$snp.id,
  eqtlRange=snp.gr,
  gene=as.character(tab$gene.entrez.id))
skin.eset

blood.file <- system.file("extdata", "eqtl/blood.gtex.txt", 
                       package="loci2path")
tab <- read.table(blood.file, stringsAsFactors=FALSE, header=TRUE)
snp.gr <- GRanges(seqnames=Rle(tab$snp.chr), 
  ranges=IRanges(start=tab$snp.pos, 
  width=1))
blood.eset <- eqtlSet(tissue="blood",
  eqtlId=tab$snp.id,
  eqtlRange=snp.gr,
  gene=as.character(tab$gene.entrez.id))
blood.eset

## ----esetlist-----------------------------------------------------------------
eset.list <- list(Brain=brain.eset, Skin=skin.eset, Blood=blood.eset)
eset.list

## -----------------------------------------------------------------------------
biocarta.link.file <- system.file("extdata", "geneSet/biocarta.txt", 
                               package="loci2path")
biocarta.set.file <- system.file("extdata", "geneSet/biocarta.set.txt", 
                              package="loci2path")

biocarta.link <- read.delim(biocarta.link.file, header=FALSE, 
                         stringsAsFactors=FALSE)
set.geneid <- read.table(biocarta.set.file, stringsAsFactors=FALSE)
set.geneid <- strsplit(set.geneid[,1], split=",")
names(set.geneid) <- biocarta.link[,1]

head(biocarta.link)
head(set.geneid)

## -----------------------------------------------------------------------------
#build geneSet
biocarta <- geneSet(
    numGene=31847,
    description=biocarta.link[,2],
    geneSetList=set.geneid)
biocarta

## -----------------------------------------------------------------------------
#query from one eQTL set.
res.one <- query(
  query.gr=query.gr,
  loci=skin.eset, 
  path=biocarta)

#enrichment result table
res.one$result.table

#all the genes associated with eQTLs covered by the query region
res.one$cover.gene

## -----------------------------------------------------------------------------
#query from one eQTL set.
res.esetlist <- query(
  query.gr=query.gr, 
  loci=eset.list, 
  path=biocarta)  

#enrichment result table, tissue column added
resultTable(res.esetlist)

#all the genes associated with eQTLs covered by the query region; 
#names of the list are tissue names from eqtl set list
coveredGene(res.esetlist)

## -----------------------------------------------------------------------------
#query from one eQTL set.
res.paral <- query(
  query.gr=query.gr, 
  loci=eset.list, 
  path=biocarta, 
  parallel=TRUE)  
#should return the same result as res.esetlist

## -----------------------------------------------------------------------------
result <- resultTable(res.esetlist)

## -----------------------------------------------------------------------------
#all the genes associated with eQTLs covered by the query region
res.one$cover.gene

#all the genes associated with eQTLs covered by the query region; 
#names of the list are tissue names from eqtl set list
coveredGene(res.esetlist)

## -----------------------------------------------------------------------------
tissue.degree <- getTissueDegree(res.esetlist, eset.list)

#check gene-tissue mapping for each gene
head(tissue.degree$gene.tissue.map)

#check degree for each gene
head(tissue.degree$gene.tissue.degree)

#average tissue degree for the input result table
tissue.degree$mean.tissue.degree

#add avg. tissue degree to existing result table
res.tissue <- data.frame(resultTable(res.esetlist),
                      t.degree=tissue.degree$mean.tissue.degree)

## -----------------------------------------------------------------------------
#query tissue specificity
gr.tissue <- query(query.gr, loci=eset.list)
gr.tissue

## -----------------------------------------------------------------------------
#extract tissue-pathway matrix
mat <- getMat(res.esetlist, test.method="gene")

#plot heatmap
heatmap.para <- getHeatmap(res.esetlist)

## -----------------------------------------------------------------------------

#plot word cloud
wc <- getWordcloud(res.esetlist)

## -----------------------------------------------------------------------------
#plot p-value distribution of result
pval <- getPval(res.esetlist, test.method="gene")

## -----------------------------------------------------------------------------
#obtain geneset description from object
description <- getPathDescription(res.esetlist, biocarta)
head(description)

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

