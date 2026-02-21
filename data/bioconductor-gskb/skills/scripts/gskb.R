# Code example from 'gskb' vignette. See references/ for full tutorial.

### R code from vignette source 'gskb.Rnw'

###################################################
### code chunk number 1: style-Sweave
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: gskb.Rnw:26-27
###################################################
options(width=80)


###################################################
### code chunk number 3: gskb.Rnw:95-99
###################################################
library(gskb)

data(mm_miRNA)
mm_miRNA[[1]][1:10]


###################################################
### code chunk number 4: gskb.Rnw:119-122 (eval = FALSE)
###################################################
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## BiocManager::install("PGSEA")


###################################################
### code chunk number 5: gskb.Rnw:124-148
###################################################
library(PGSEA)

library(gskb)

data(mm_miRNA)

gse<-read.csv("http://ge-lab.org/gskb/GSE40261.csv",header=TRUE, row.name=1)

# Gene are centered by mean expression
gse <- gse - apply(gse,1,mean)  

pg <- PGSEA(gse, cl=mm_miRNA, range=c(15,2000), p.value=NA)

# Remove pathways that has all NAs. This could be due to that pathway has 
# too few matching genes. 
pg2 <- pg[rowSums(is.na(pg))!= dim(gse)[2], ]

# Difference in Average Z score in two groups of samples is calculated and 
# the pathways are ranked by absolute value.
diff <- abs( apply(pg2[,1:4],1,mean) - apply(pg2[,5:8], 1, mean) )
pg2 <- pg2[order(-diff), ]  

sub <- factor( c( rep("Control",4),rep("Anti-miR-29",4) ) ) 
smcPlot(pg2[1:15,],sub,scale=c(-12,12),show.grid=TRUE,margins=c(1,1,7,19),col=.rwb)


###################################################
### code chunk number 6: gskb.Rnw:163-209 (eval = FALSE)
###################################################
## library(gskb)                                                         
## data(mm_miRNA)                                                           
## 
## ## GSEA 1.0 -- Gene Set Enrichment Analysis / Broad Institute         
## 
## GSEA.prog.loc<- "http://ge-lab.org/gskb/GSEA.1.0.R"
## source(GSEA.prog.loc, max.deparse.length=9999)                        
## 
## GSEA(                                                                 
##     # Input/Output Files :------------------------------------------------
##     
##     # Input gene expression Affy dataset file in RES or GCT format        
##     input.ds = "http://ge-lab.org/gskb/mouse_data.gct", 
##     
##     # Input class vector (phenotype) file in CLS format                   
##     input.cls = "http://ge-lab.org/gskb/mouse.cls",
##     
##     # Gene set database in GMT format                                     
##     gs.db = mm_miRNA,                                                   
##     
##     # Directory where to store output and results (default: "")           
##     output.directory = getwd(),                                      
##     
##     #  Program parameters :-----------------------------------------------
##     doc.string = "mouse",                                    
##     non.interactive.run = T,                                         
##     reshuffling.type = "sample.labels",                              
##     nperm = 1000,                                                    
##     weighted.score.type =  1,                                                    
##     nom.p.val.threshold = -1,                                                    
##     fwer.p.val.threshold = -1,                                                   
##     fdr.q.val.threshold = 0.25,                                                
##     topgs = 10,                                                      
##     adjust.FDR.q.val = F,                                                   
##     gs.size.threshold.min = 15,                                                
##     gs.size.threshold.max = 500,                                                
##     reverse.sign = F,                                                 
##     preproc.type = 0,                                                 
##     random.seed = 3338,                                              
##     perm.type = 0,                                                   
##     fraction = 1.0,                                                  
##     replace = F,                                                     
##     save.intermediate.results = F,                                             
##     OLD.GSEA = F,                                                    
##     use.fast.enrichment.routine = T                                           
## )                                                                     


###################################################
### code chunk number 7: gskb.Rnw:226-248
###################################################
library(PGSEA)

library(gskb)

d1 <- scan("http://ge-lab.org/gskb/2-MousePath/MousePath_Co-expression_gmt.gmt", what="", sep="\n", skip=1)
mm_Co_expression <- strsplit(d1, "\t")
names(mm_Co_expression) <- sapply(mm_Co_expression, '[[', 1)

pg <- PGSEA(gse, cl=mm_Co_expression, range=c(15,2000), p.value=NA)

# Remove pathways that has all NAs. This could be due to that pathway has
# too few matching genes. 
pg2 <- pg[rowSums(is.na(pg))!= dim(gse)[2], ]

# Difference in Average Z score in two groups of samples is calculated and 
# the pathways are ranked by absolute value.
diff <- abs( apply(pg2[,1:4],1,mean) - apply(pg2[,5:8], 1, mean) )
pg2 <- pg2[order(-diff), ]  

sub <- factor( c( rep("Control",4),rep("Anti-miR-29",4) ) ) 

smcPlot(pg2[1:15,],sub,scale=c(-12,12),show.grid=TRUE,margins=c(1,1,7,19),col=.rwb)


###################################################
### code chunk number 8: gskb.Rnw:258-259
###################################################
sessionInfo()


