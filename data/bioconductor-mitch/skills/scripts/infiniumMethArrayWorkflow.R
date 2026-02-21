# Code example from 'infiniumMethArrayWorkflow' vignette. See references/ for full tutorial.

## ----install, eval = FALSE----------------------------------------------------
# if(!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("mitch")

## ----lib----------------------------------------------------------------------

suppressPackageStartupMessages({
    library("mitch")
    library("dplyr")
    library("HGNChelper")
    library("IlluminaHumanMethylation450kanno.ilmn12.hg19")
    library("IlluminaHumanMethylationEPICanno.ilm10b4.hg19")
})

## ----genesetsExample----------------------------------------------------------
data(genesetsExample)
head(genesetsExample,3)

## ----anno1--------------------------------------------------------------------
anno <- getAnnotation(IlluminaHumanMethylation450kanno.ilmn12.hg19)
myann <- data.frame(anno[,c("UCSC_RefGene_Name","UCSC_RefGene_Group","Islands_Name","Relation_to_Island")])
head(myann)
gp <- myann[,"UCSC_RefGene_Name",drop=FALSE]
gp2 <- strsplit(gp$UCSC_RefGene_Name,";")
names(gp2) <- rownames(gp)
gp2 <- lapply(gp2,unique)
gt1 <- stack(gp2)
colnames(gt1) <- c("gene","probe")
gt1$probe <- as.character(gt1$probe)
dim(gt1)
head(gt1)

## ----genenames----------------------------------------------------------------
#new.hgnc.table <- getCurrentHumanMap()
new.hgnc.table <- readRDS("../inst/extdata/new.hgnc.table.rds")
fix <- checkGeneSymbols(gt1$gene,map=new.hgnc.table)
fix2 <- fix[which(fix$x != fix$Suggested.Symbol),]
length(unique(fix2$x))
gt1$gene <- fix$Suggested.Symbol
head(gt1)

## ----import1------------------------------------------------------------------
x <- read.table("https://ziemann-lab.net/public/gmea/dma3a.tsv",header=TRUE,row.names=1)
head(x)

## ----import2------------------------------------------------------------------
y <- mitch_import(x,DEtype="limma",geneTable=gt1)
head(y)
dim(y)

## ----enrich1------------------------------------------------------------------
res<-mitch_calc(y,genesetsExample,priority="effect",cores=2,minsetsize=5)
head(res$enrichment_result,10)

## ----downstream1--------------------------------------------------------------

mitch_plots(res,outfile="methcharts.pdf")


## ----downstream2,results=FALSE------------------------------------------------

mitch_report(res,"methreport.html")


## ----meth_network,fig.width=14,fig.height=6-----------------------------------

networkplot(res,FDR=0.1,n_sets=10)

network_genes(res,FDR=1,n_sets=10)


## ----EPIC---------------------------------------------------------------------
anno <- getAnnotation(IlluminaHumanMethylationEPICanno.ilm10b4.hg19)
myann <- data.frame(anno[,c("UCSC_RefGene_Name","UCSC_RefGene_Group","Islands_Name","Relation_to_Island")])
gp <- myann[,"UCSC_RefGene_Name",drop=FALSE]
gp2 <- strsplit(gp$UCSC_RefGene_Name,";")
names(gp2) <- rownames(gp)
gp2 <- lapply(gp2,unique)
gt <- stack(gp2)
colnames(gt) <- c("gene","probe")
gt$probe <- as.character(gt$probe)
dim(gt)
str(gt)

## ----sessioninfo,message=FALSE------------------------------------------------
sessionInfo()

