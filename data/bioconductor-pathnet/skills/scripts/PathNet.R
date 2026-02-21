# Code example from 'PathNet' vignette. See references/ for full tutorial.

### R code from vignette source 'PathNet.Rnw'

###################################################
### code chunk number 1: options
###################################################
options(width=60, continue=" ")
set.seed(123)


###################################################
### code chunk number 2: Install packages (eval = FALSE)
###################################################
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## BiocManager::install("PathNet")
## BiocManager::install("PathNetData")


###################################################
### code chunk number 3: Import Package and show Disease Progression
###################################################
library("PathNet")
library("PathNetData")
data(disease_progression)
head(disease_progression)


###################################################
### code chunk number 4: Show Brain Regions
###################################################
data(brain_regions)
head(brain_regions)


###################################################
### code chunk number 5: Show Adjacency Matrix
###################################################
data(A)
# Load genes from direct evidence 
gene_ID <- brain_regions[,1]
# Construct adjacency matrix
A <- A [rownames(A) %in% gene_ID, rownames(A) %in% gene_ID]
# Display a sample of the adjacency matrix contents
A [100:110,100:110]


###################################################
### code chunk number 6: Show pathway
###################################################
data(pathway)
pathway[965:975,]


###################################################
### code chunk number 7: Show custom loading
###################################################
# We use system.file to locate the directory with the
# example text files from the PathNetData Package
current <- getwd()
setwd(system.file(dir="extdata", package="PathNetData"))

# Begin loading datasets from the text files
brain_regions <- as.matrix(read.table(
  file = "brain_regions_data.txt", sep = "\t", header = T))

disease_progression <- as.matrix(read.table(
  file = "disease_progression_data.txt", sep = "\t", header = T))

A <- as.matrix(read.table(
  file = "adjacency_data.txt", sep = "\t", header = T))

pathway <- read.table(
  file = "pathway_data.txt", sep = "\t", header = T) 

# Change back to our previous working directory
setwd(current)


###################################################
### code chunk number 8: Enrichment Analysis
###################################################
# Note we use a subset of evidence and a small number of
# permutations for demonstration purposes
results <- PathNet(Enrichment_Analysis = TRUE, 
        DirectEvidence_info = brain_regions[1:2000,], 
        Adjacency = A, 
        pathway = pathway, 
        Column_DirectEvidence = 7,
        n_perm = 10, threshold = 0.05) 


###################################################
### code chunk number 9: Enrichment Results
###################################################
# Retrieve the first ten entrichment results
results$enrichment_results[1:10,]

# Retrieve the first ten combined evidence entries
results$enrichment_combined_evidence[1:10,]


###################################################
### code chunk number 10: Contextual analysis
###################################################
# Perform a contextual analysis with pathway enrichment
# Note we use a subset of evidence and a small number of
# permutations for demonstration purposes
results <- PathNet(Enrichment_Analysis = FALSE, 
        Contextual_Analysis= TRUE, 
        DirectEvidence_info = brain_regions[1:500,], 
        Adjacency = A, 
        pathway = pathway, 
        Column_DirectEvidence = 7, 
        use_sig_pathways = FALSE, 
        n_perm = 10, threshold = 0.05)


###################################################
### code chunk number 11: Contextual results
###################################################
# Show the first four rows and first two columns 
# of the contextual association from the
# demonstration
results$conn_p_value[1:4, 1:2]

# Show the first four rows and first two columns 
# of the pathway overlap scores from the
# demonstration
results$pathway_overlap[1:4, 1:2]


