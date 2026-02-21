# Code example from 'iPAC' vignette. See references/ for full tutorial.

### R code from vignette source 'iPAC.Rnw'

###################################################
### code chunk number 1: Example1 (eval = FALSE)
###################################################
## library(iPAC)
## #For more information on the mutations matrix, 
## #type ?KRAS.Mutations after executing the line below.
## data(KRAS.Mutations)
## nmc(KRAS.Mutations, alpha = 0.05, multtest = "Bonferroni")


###################################################
### code chunk number 2: Example2 (eval = FALSE)
###################################################
## library(iPAC)
## CIF<-"https://files.rcsb.org/view/3GFT.cif"
## Fasta<-"http://www.uniprot.org/uniprot/P01116-2.fasta"
## KRAS.Positions<-get.Positions(CIF, Fasta, "A")
## names(KRAS.Positions)


###################################################
### code chunk number 3: Example2a (eval = FALSE)
###################################################
## KRAS.Positions$Positions[1:10,]


###################################################
### code chunk number 4: Example2b (eval = FALSE)
###################################################
## KRAS.Positions$External.Mismatch


###################################################
### code chunk number 5: Example2c (eval = FALSE)
###################################################
## KRAS.Positions$PDB.Mismatch


###################################################
### code chunk number 6: Example2d (eval = FALSE)
###################################################
## KRAS.Positions$Result


###################################################
### code chunk number 7: Example4 (eval = FALSE)
###################################################
## CIF <- "https://files.rcsb.org/view/2RD0.cif"
## Fasta <- "http://www.uniprot.org/uniprot/P42336.fasta"
## PIK3CAV2.Positions <- get.Positions(CIF, Fasta, "A")
## names(PIK3CAV2.Positions)


###################################################
### code chunk number 8: Example4a (eval = FALSE)
###################################################
## PIK3CAV2.Positions$Positions[1:10,]


###################################################
### code chunk number 9: Example4b (eval = FALSE)
###################################################
## PIK3CAV2.Positions$External.Mismatch


###################################################
### code chunk number 10: Example4c (eval = FALSE)
###################################################
## PIK3CAV2.Positions$PDB.Mismatch


###################################################
### code chunk number 11: Example4d (eval = FALSE)
###################################################
## PIK3CAV2.Positions$Result


###################################################
### code chunk number 12: Example5 (eval = FALSE)
###################################################
## CIF<- "https://files.rcsb.org/view/2RD0.cif"
## Fasta <- "http://www.uniprot.org/uniprot/P42336.fasta"
## PIK3CAV3.Positions<-get.AlignedPositions(CIF,Fasta , "A")
## names(PIK3CAV3.Positions)


###################################################
### code chunk number 13: Example5a (eval = FALSE)
###################################################
## PIK3CAV3.Positions$Positions[1:10,]


###################################################
### code chunk number 14: Example5b (eval = FALSE)
###################################################
## PIK3CAV3.Positions$External.Mismatch


###################################################
### code chunk number 15: Example5c (eval = FALSE)
###################################################
## PIK3CAV3.Positions$PDB.Mismatch


###################################################
### code chunk number 16: Example5d (eval = FALSE)
###################################################
## PIK3CAV3.Positions$Result


###################################################
### code chunk number 17: Example6 (eval = FALSE)
###################################################
## #Extract the data from a CIF file and match it up with the canonical protein sequence.
## #Here we use the 3GFT structure from the PDB, which corresponds to the KRAS protein.
## CIF<-"https://files.rcsb.org/view/3GFT.cif"
## Fasta<-"http://www.uniprot.org/uniprot/P01116-2.fasta"
## KRAS.Positions<-get.Positions(CIF,Fasta, "A")
## 
## #Load the mutational data for KRAS. Here the mutational data was obtained from the
## #COSMIC database (version 58). 
## data(KRAS.Mutations)
## 
## #Identify and report the clusters. 
## ClusterFind(mutation.data=KRAS.Mutations,
##             position.data=KRAS.Positions$Positions,
##             create.map = "Y", Show.Graph = "Y",
##             Graph.Title = "MDS Mapping",
##             method = "MDS")


###################################################
### code chunk number 18: Example7 (eval = FALSE)
###################################################
## #Extract the data from a CIF file and match it up with the canonical protein sequence.
## #Here we use the 3GFT structure from the PDB, which corresponds to the KRAS protein.
## CIF<-"https://files.rcsb.org/view/3GFT.cif"
## Fasta<-"http://www.uniprot.org/uniprot/P01116-2.fasta"
## KRAS.Positions<-get.Positions(CIF,Fasta, "A")
## 
## #Load the mutational data for KRAS. Here the mutational data was obtained from the
## #COSMIC database (version 58). 
## data(KRAS.Mutations)
## 
## #Identify and report the clusters. 
## ClusterFind(mutation.data=KRAS.Mutations,
##             position.data=KRAS.Positions$Positions,
##             create.map = "Y", Show.Graph = "Y",
##             Graph.Title = "Linear Mapping",
##             method = "Linear")


