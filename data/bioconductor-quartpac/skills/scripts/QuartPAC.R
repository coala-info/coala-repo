# Code example from 'QuartPAC' vignette. See references/ for full tutorial.

### R code from vignette source 'QuartPAC.Rnw'

###################################################
### code chunk number 1: Example1
###################################################
library(QuartPAC)
#read the mutational data
mutation_files <- list(
system.file("extdata","HFE_Q30201_MutationOutput.txt", package = "QuartPAC"),
system.file("extdata","B2M_P61769_MutationOutput.txt", package = "QuartPAC")
)

uniprots <- list("Q30201","P61769")
mutation.data <- getMutations(mutation_files = mutation_files, uniprots = uniprots)

#read the pdb file
pdb.location <- "https://files.rcsb.org/view/1A6Z.pdb"
assembly.location <- "https://files.rcsb.org/download/1A6Z.pdb1"
structural.data <- makeAlignedSuperStructure(pdb.location, assembly.location)

#Perform Analysis
#We use a very high alpha level here with no multiple comparison adjustment
#to make sure that each method provides shows a result.
#Lower alpha cut offs are typically used.
quart_results <- quartCluster(mutation.data, structural.data, perform.ipac = "Y", 
                              perform.graphpac = "Y", perform.spacepac = "Y",
                              create.map = "Y",alpha = .3,MultComp = "None",
                              Graph.Title ="MDS Mapping to 1D Space",
                              radii.vector = c(1:3))


###################################################
### code chunk number 2: Example2
###################################################
Plot.Protein.Linear(quart_results$graphpac$candidate.path, colCount = 10,
                    title = "Protein Reordering to 1D Space via GraphPAC")


###################################################
### code chunk number 3: Example3
###################################################
#look at the results for the optimal sphere combinations under the SpacePAC approach
#For clarity we only look at columns 3 - 8 which show the sphere centers.
quart_results$spacepac$optimal.sphere[,3:8]

#Find the atom with serial number 1265
required.row <- which(structural.data$aligned_structure$serial == 1265)

#show the information for that atom
structural.data$aligned_structure[required.row,]



###################################################
### code chunk number 4: Example4
###################################################
#look at the results for the first cluster shown by the ipac method
quart_results$ipac

#Find the atoms with serial numbers within the range of 2583 to 2846
required.rows <- which(structural.data$aligned_structure$serial %in% (2583:2846))

#show the information for those atoms
structural.data$aligned_structure[required.rows,]


