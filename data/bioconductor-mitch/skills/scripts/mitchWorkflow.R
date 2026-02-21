# Code example from 'mitchWorkflow' vignette. See references/ for full tutorial.

## ----install, eval = FALSE----------------------------------------------------
# if(!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("mitch")

## ----lib----------------------------------------------------------------------
library("mitch")

## ----gsets--------------------------------------------------------------------
download.file("https://reactome.org/download/current/ReactomePathways.gmt.zip",
    destfile="ReactomePathways.gmt.zip")
unzip("ReactomePathways.gmt.zip")
genesets <- gmt_import("ReactomePathways.gmt")

## ----genesetsExample----------------------------------------------------------
data(genesetsExample)
head(genesetsExample,3)

## ----import11-----------------------------------------------------------------
data(rna,k9a)
x <- list("rna"=rna,"k9a"=k9a)
y <- mitch_import(x,"edgeR")
head(y)

## ----import4------------------------------------------------------------------
y <- mitch_import(rna,DEtype="edger")
head(y)

## ----import5------------------------------------------------------------------
# first rearrange cols
rna_mod <- rna
rna_mod$MyGeneIDs <- rownames(rna_mod)
rownames(rna_mod) <- seq(nrow(rna_mod))
head(rna_mod)
# now import with geneIDcol
y <- mitch_import(rna_mod,DEtype="edgeR",geneIDcol="MyGeneIDs")
head(y)

## ----import6------------------------------------------------------------------
library("stringi")
# obtain vector of gene names
genenames <- rownames(rna)
# create fake accession numbers
accessions <- paste("Gene0",stri_rand_strings(nrow(rna)*2, 6, pattern = "[0-9]"),sep="")
accessions <- head(unique(accessions),nrow(rna))
# create a gene table file that relates gene names to accession numbers
gt <- data.frame(genenames,accessions)

# now swap gene names for accessions
rna2 <- merge(rna,gt,by.x=0,by.y="genenames")
rownames(rna2) <- rna2$accessions
rna2 <- rna2[,2:5]

k9a2 <- merge(k9a,gt,by.x=0,by.y="genenames")
rownames(k9a2) <- k9a2$accessions
k9a2 <- k9a2[,2:5]

# now have a peek at the input data before importing
head(rna2,3)
head(k9a2,3)
head(gt,3)
x <- list("rna2"=rna2,"k9a2"=k9a2)
y <- mitch_import(x,DEtype="edgeR",geneTable=gt)
head(y,3)

## ----calc1,results="hide"-----------------------------------------------------
# prioritisation by significance
res <- mitch_calc(y,genesetsExample,priority="significance",cores=2)

## ----calc2--------------------------------------------------------------------
# peek at the results
head(res$enrichment_result)

## ----calc3,results="hide"-----------------------------------------------------
# prioritisation by effect size
res <- mitch_calc(y,genesetsExample,priority="effect",cores=2)

## ----calc4--------------------------------------------------------------------
head(res$enrichment_result)

## ----calc5,results="hide"-----------------------------------------------------
res <- mitch_calc(y,genesetsExample,priority="significance",minsetsize=5,cores=2)

## ----calc6,results="hide"-----------------------------------------------------
res<-mitch_calc(y,genesetsExample,priority="significance",resrows=3,cores=2)

## ----report,results="hide"----------------------------------------------------
mitch_report(res,"myreport.html",overwrite=TRUE)

## ----plots,results="hide"-----------------------------------------------------
mitch_plots(res,outfile="mycharts.pdf")

## ----network_demo,fig.width=14,fig.height=6-----------------------------------

networkplot(res,FDR=1,n_sets=10)

network_genes(res,FDR=1,n_sets=10)


## ----sessioninfo,message=FALSE------------------------------------------------
sessionInfo()

