# Code example from 'PoTRA' vignette. See references/ for full tutorial.

## ----results1, include=FALSE-----------------------------------------------
library(PoTRA)
library(graphite)
library(graph)
library(igraph)
devtools::install_github('christophergandrud/repmis')
library(repmis)
source_data("https://github.com/GenomicsPrograms/example_data/raw/master/PoTRA-vignette.RData")

options(warn=-1)
humanKEGG <- pathways("hsapiens", "kegg") 
Pathway.database = humanKEGG  
results.KEGG <-PoTRA.corN(mydata=mydata,genelist=genelist,Num.sample.normal=113,Num.sample.case=113,Pathway.database=Pathway.database[1:15],PR.quantile=PR.quantile)

## ----results2, include=TRUE------------------------------------------------
names(results.KEGG)
head(results.KEGG$Fishertest.p.value)
head(results.KEGG$KStest.p.value) 
head(results.KEGG$LengthOfPathway)
head(results.KEGG$TheNumberOfHubGenes.normal)
head(results.KEGG$TheNumberOfHubGenes.case)
head(results.KEGG$TheNumberOfEdges.normal)
head(results.KEGG$TheNumberOfEdges.case)
head(results.KEGG$PathwayName)


## ----results3, include=FALSE-----------------------------------------------

humanReactome<- pathways("hsapiens", "reactome") 
Pathway.database = humanReactome 
results.Reactome <-PoTRA.corN(mydata=mydata,genelist=genelist,Num.sample.normal=113,Num.sample.case=113,Pathway.database=Pathway.database[1:15],PR.quantile=PR.quantile)

## ----results4, include=TRUE------------------------------------------------
names(results.Reactome)
head(results.Reactome$Fishertest.p.value)
head(results.Reactome$KStest.p.value) 
head(results.Reactome$LengthOfPathway)
head(results.Reactome$TheNumberOfHubGenes.normal)
head(results.Reactome$TheNumberOfHubGenes.case)
head(results.Reactome$TheNumberOfEdges.normal)
head(results.Reactome$TheNumberOfEdges.case)
head(results.Reactome$PathwayName)


## ----results5, include=FALSE-----------------------------------------------

humanBiocarta <- pathways("hsapiens", "biocarta")
Pathway.database = humanBiocarta  
results.Biocarta <-PoTRA.corN(mydata=mydata,genelist=genelist,Num.sample.normal=113,Num.sample.case=113,Pathway.database=Pathway.database[1:15],PR.quantile=PR.quantile)

## ----results6, include=TRUE------------------------------------------------
names(results.Biocarta)
head(results.Biocarta$Fishertest.p.value)
head(results.Biocarta$KStest.p.value) 
head(results.Biocarta$LengthOfPathway)
head(results.Biocarta$TheNumberOfHubGenes.normal)
head(results.Biocarta$TheNumberOfHubGenes.case)
head(results.Biocarta$TheNumberOfEdges.normal)
head(results.Biocarta$TheNumberOfEdges.case)
head(results.Biocarta$PathwayName)


## ----results7, include=FALSE-----------------------------------------------

humanPharmGKB <- pathways("hsapiens", "pharmgkb")
Pathway.database = humanPharmGKB
results.PharmGKB <-PoTRA.corN(mydata=mydata,genelist=genelist,Num.sample.normal=113,Num.sample.case=113,Pathway.database=Pathway.database[1:15],PR.quantile=PR.quantile)

## ----results8, include=TRUE------------------------------------------------
names(results.PharmGKB)
head(results.PharmGKB$Fishertest.p.value)
head(results.PharmGKB$KStest.p.value) 
head(results.PharmGKB$LengthOfPathway)
head(results.PharmGKB$TheNumberOfHubGenes.normal)
head(results.PharmGKB$TheNumberOfHubGenes.case)
head(results.PharmGKB$TheNumberOfEdges.normal)
head(results.PharmGKB$TheNumberOfEdges.case)
head(results.PharmGKB$PathwayName)


## ----results9, include=FALSE-----------------------------------------------

FPvalues1 <- c(0.01,0.05,1,0.90,0.01,0.05,0.03)
FPvalues2 <- c(0.01,1,1,1,0.94,0.34,0.25)
FPvalues3 <- c(0.01,0.01,0.04,0.07,0.01,0.03,0.40)
FPvalues4 <- c(0.55,0.21,0.01,0.02,0.01,0.01,0.01)


Pathways <- c("Statin Pathway - Generalized, Pharmacokinetics","Atorvastatin/Lovastatin/Simvastatin Pathway","Pharmacokinetics","Pravastatin Pathway","Pharmacokinetics","Fluvastatin Pathway", "Pharmacokinetics")


DF <- data.frame(Pathways,FPvalues1,FPvalues2,FPvalues3,FPvalues4)
DF$FPvalues1 <- sort(FPvalues1, decreasing=FALSE)
DF$FPvalues2 <- sort(FPvalues2, decreasing=FALSE)
DF$FPvalues3 <- sort(FPvalues3, decreasing=FALSE)
DF$FPvalues4 <- sort(FPvalues4, decreasing=FALSE)

DF$Rank1 <- c(1,1,2,3,3,4,5)
DF$Rank2 <- c(1,2,3,4,5,5,5)
DF$Rank3 <- c(1,1,1,2,3,4,5)
DF$Rank4 <- c(1,1,1,1,2,3,4)
 



## ----results10, include=TRUE-----------------------------------------------
DF

## ----results11, include=FALSE----------------------------------------------
library(metap)
library(colr)
FE = cgrep(DF, "^FPvalues")

data_FE <- as.data.frame(t(FE))

FE_SumLog <- t(sapply(data_FE, function(z) 
      sumlog(z)$p
))

FE_SumLogs <- data.frame(t(FE_SumLog))

names(FE_SumLogs) <- c("SumLog_Pval")
DF$FE_SumLogs <- FE_SumLogs

## ----results12, include=TRUE-----------------------------------------------
FE_SumLogs
 

## ----results13, include=FALSE----------------------------------------------

Ranks = cgrep(DF, "^Rank")
data_Ranks <- Ranks
DF$Average_Rank <- rowMeans(data_Ranks, na.rm = TRUE, dims = 1)
DF[2:9] <- NULL 
 

## ----results14, include=TRUE-----------------------------------------------
DF
 

## ----results15, include=TRUE-----------------------------------------------
sessionInfo()

