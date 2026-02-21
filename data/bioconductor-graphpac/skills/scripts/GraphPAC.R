# Code example from 'GraphPAC' vignette. See references/ for full tutorial.

### R code from vignette source 'GraphPAC.Rnw'

###################################################
### code chunk number 1: Example1
###################################################
library(GraphPAC)
#Extract the data from a CIF file and match it up with the canonical protein sequence.
#Here we use the 3GFT structure from the PDB, which corresponds to the KRAS protein.
CIF<-"https://files.rcsb.org/view/3GFT.cif"
Fasta<-"http://www.uniprot.org/uniprot/P01116-2.fasta"
KRAS.Positions<-get.Positions(CIF,Fasta, "A")

#Load the mutational data for KRAS. Here the mutational data was obtained from the
#COSMIC database (version 58). 
data(KRAS.Mutations)

#Identify and report the clusters. 
my.graph.clusters <- GraphClust(KRAS.Mutations,KRAS.Positions$Positions,
                                insertion.type = "cheapest_insertion",
                                alpha = 0.05, MultComp = "Bonferroni")
my.graph.clusters


###################################################
### code chunk number 2: Example2a
###################################################
#Using the heat color palette
Plot.Protein.Linear(my.graph.clusters$candidate.path, 25, color.palette = "heat", 
                    title = "Protein Reordering - Heat Map")


###################################################
### code chunk number 3: Example2b
###################################################
#Using the gray color palette
Plot.Protein.Linear(my.graph.clusters$candidate.path, 25, color.palette = "gray",
                    title = "Protein Reordering - Gray Color Scale")


###################################################
### code chunk number 4: Example3 (eval = FALSE)
###################################################
## 
## #Using the heat color palette
## Plot.Protein(my.graph.clusters$protein.graph, my.graph.clusters$candidate.path,
##              vertex.size=5, color.palette="heat")


###################################################
### code chunk number 5: Example4
###################################################
library(RMallow)
graph.path <-my.graph.clusters$candidate.path

#get.Remapped.Order is a function in the \iPAC package
mds.path <- get.Remapped.Order(KRAS.Mutations,KRAS.Positions$Positions)

path.matrix <- rbind (original.seq = sort(graph.path), graph.path, mds.path)
AllSeqDists(path.matrix)


