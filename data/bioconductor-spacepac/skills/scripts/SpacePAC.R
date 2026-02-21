# Code example from 'SpacePAC' vignette. See references/ for full tutorial.

### R code from vignette source 'SpacePAC.Rnw'

###################################################
### code chunk number 1: Example1
###################################################
library(SpacePAC)
##Extract the data from a CIF file and match it up with the canonical protein sequence.
#Here we use the 2ENQ structure from the PDB, which corresponds to the PIK3CA protein.
CIF <- "http://www.pdb.org/pdb/files/2ENQ.cif"
Fasta <- "http://www.uniprot.org/uniprot/P42336.fasta"
PIK3CA.Positions <- get.AlignedPositions(CIF, Fasta, "A")

##Load the mutational data for PIK3CA. Here the mutational data was obtained from the
##COSMIC database (version 58). 
data(PIK3CA.Mutations)

##Identify and report the clusters. 
my.clusters <- SpaceClust(PIK3CA.Mutations, PIK3CA.Positions$Positions, numsims =1000, 
  simMaxSpheres = 3, radii.vector = c(1,2,3,4), method = "SimMax")

my.clusters


###################################################
### code chunk number 2: Example2
###################################################

##Extract the data from a CIF file and match it up with the canonical protein sequence.
#Here we use the 2ENQ structure from the PDB, which corresponds to the PIK3CA protein.
CIF <- "http://www.pdb.org/pdb/files/3GFT.cif"
Fasta <- "http://www.uniprot.org/uniprot/P01116-2.fasta"
KRAS.Positions <- get.Positions(CIF, Fasta, "A")
data(KRAS.Mutations)

##Identify and report the clusters. 
my.clusters <- SpaceClust(KRAS.Mutations, KRAS.Positions$Positions, radii.vector = c(1,2,3,4),
  alpha = .05, method = "Poisson")
my.clusters


###################################################
### code chunk number 3: Example3
###################################################
  ##To avoid RGL errors, this code is not run. However it has been tested and verified. 
  #library(rgl)
  #CIF <- "http://www.pdb.org/pdb/files/3GFT.cif"
  #Fasta <- "http://www.uniprot.org/uniprot/P01116-2.fasta"
  #KRAS.Positions <- get.Positions(CIF, Fasta, "A")
  #make.3D.Sphere(KRAS.Positions$Positions, 12, 3)


