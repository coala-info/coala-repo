# Code example from 'Sequences-Vignette' vignette. See references/ for full tutorial.

## ----eval=TRUE, warning=FALSE, message=FALSE----------------------------------
library(dowser)

data(ExampleClones)

# Collapse nodes with identical sequences. This will 
trees = collapseNodes(ExampleClones[1:2,])

# Plot trees with node ID numbers
plots = plotTrees(trees, tips="c_call", tipsize=2, node_nums=TRUE, labelsize=7)

plots[[1]]

sequence = getNodeSeq(trees, node=50, clone=3128)

print(sequence)

# Get all sequences as a data frame
all_sequences = getAllSeqs(trees)

head(all_sequences)


## ----eval=FALSE, warning=FALSE, message=FALSE---------------------------------
# 
# # Save all sequences as a fasta file
# dfToFasta(all_sequences, file="all_sequences.fasta", id="node_id", columns=c("clone_id","locus"))
# 

