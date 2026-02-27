---
name: bioconductor-pcan
description: This package assesses the relationship between genes and human phenotypes to prioritize candidate genes for Mendelian disorders. Use when user asks to compare gene-associated phenotypes to a set of interest, compute semantic similarity between HPO terms, or prioritize candidate genes using direct associations or pathway consensus.
homepage: https://bioconductor.org/packages/release/bioc/html/PCAN.html
---


# bioconductor-pcan

## Overview

The `PCAN` package provides methods to assess the relationship between a gene and a set of human phenotypes. It is particularly useful for prioritizing candidate genes identified in sequencing studies of Mendelian disorders. The package uses Information Content (IC) and semantic similarity (Resnik method) to compare phenotypes associated with a gene (or its pathways/interactors) against a user-defined set of phenotypes of interest.

## Core Workflow

### 1. Data Preparation and Prior Knowledge
PCAN relies on several internal datasets linking genes, traits (OMIM), and phenotypes (HPO).

```r
library(PCAN)
data(geneByTrait, traitDef, geneDef, hpByTrait, hpDef, package="PCAN")
data(hp_descendants, hp_ancestors, package="PCAN")

# Define phenotypes of interest (HPO terms)
hpOfInterest <- c("HP:0000483", "HP:0000510", "HP:0000518", "HP:0000639")

# Create a gene-to-phenotype mapping (excluding known associations if testing)
geneByHp <- unique(merge(geneByTrait, hpByTrait, by="id")[,c("entrez", "hp")])
```

### 2. Computing Information Content (IC)
IC measures the specificity of an HPO term based on the number of genes associated with it and its descendants.

```r
# Group genes by HP term
info <- unstack(geneByHp, entrez ~ hp)
# Compute IC for all terms
ic <- computeHpIC(info, hp_descendants)
```

### 3. Direct Gene-Phenotype Comparison
Compare a candidate gene's associated phenotypes directly to the phenotypes of interest.

```r
# Get phenotypes for a specific gene (e.g., Entrez ID 57545)
genId <- "57545"
genHp <- geneByHp[which(geneByHp$entrez == genId), "hp"]

# Compute similarity matrix
compMat <- compareHPSets(
    hpSet1 = genHp, 
    hpSet2 = hpOfInterest,
    IC = ic,
    ancestors = hp_ancestors,
    method = "Resnik",
    BPPARAM = SerialParam()
)

# Summarize similarity into a single score
score <- hpSetCompSummary(compMat, method="bma", direction="symSim")
```

### 4. Candidate Prioritization
To assess significance, compare the candidate's score against the distribution of scores for all genes.

```r
# 1. Compute similarity between all HPO terms and phenotypes of interest
hpGeneResnik <- compareHPSets(names(ic), hpOfInterest, ic, hp_ancestors, method="Resnik")

# 2. Group results by gene and compute scores
hpByGene <- unstack(geneByHp, hp ~ entrez)
resnSss <- unlist(lapply(hpByGene, function(x) {
    hpSetCompSummary(hpGeneResnik[x, , drop=FALSE], method="bma", direction="symSim")
}))

# 3. Calculate rank
candRank <- sum(resnSss >= score)
relRank <- candRank / length(resnSss) # Lower is more significant
```

### 5. Pathway Consensus Approach
If a gene has no known phenotype associations, use its pathway members or protein interactors to calculate a consensus relevance score.

```r
# Using Reactome pathways
data(hsEntrezByRPath, rPath, package="PCAN")

# Find pathway for candidate gene
candPath <- names(hsEntrezByRPath)[which(sapply(hsEntrezByRPath, function(x) genId %in% x))]

# Assess relevance of the entire pathway
rPathRes <- hpGeneListComp(
    geneList = hsEntrezByRPath[[candPath]],
    ssMatByGene = hpMatByGene, # List of matrices per gene
    geneSSScore = resnSss
)

# Visualize with a heatmap
hpGeneHeatmap(rPathRes, genesOfInterest=genId, hpLabels=hpDef$name)
```

## Key Functions
- `computeHpIC`: Calculates Information Content for HPO terms.
- `calcHpSim`: Calculates semantic similarity between two HPO terms.
- `compareHPSets`: Creates a similarity matrix between two sets of HPO terms.
- `hpSetCompSummary`: Reduces a similarity matrix to a single score (e.g., Best Match Average).
- `hpGeneListComp`: Performs Wilcoxon test to see if a gene list (pathway) is enriched for high similarity scores.

## Reference documentation
- [PCAN](./references/PCAN.md)