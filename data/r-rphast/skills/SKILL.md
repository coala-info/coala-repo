---
name: r-rphast
description: r-rphast provides an R interface to the PHAST library for comparative genomics and molecular evolutionary analysis. Use when user asks to fit phylogenetic substitution models, calculate conservation scores with phyloP or phastCons, and manipulate multiple sequence alignments or genomic features.
homepage: https://cran.r-project.org/web/packages/rphast/index.html
---

# r-rphast

name: r-rphast
description: Interface to the PHAST (Phylogenetic Analysis with Space/Time models) library. Use for comparative genomics, fitting phylogenetic substitution models, calculating conservation scores (phyloP, phastCons), and manipulating multiple sequence alignments (MSA) and genomic features (GFF/BED).

# r-rphast

## Overview
rphast provides an R interface to the PHAST software package. It is designed for comparative genomics and molecular evolution, allowing users to handle large-scale genomic data, fit complex substitution models, and identify conserved or accelerated elements across species.

## Installation
To install the package from CRAN:
```R
install.packages("rphast")
```

## Core Objects
- **msa**: Multiple Sequence Alignment object.
- **tm**: Tree Model object (includes phylogenetic tree and substitution parameters).
- **feat**: Features object (genomic annotations like GFF, BED, or FixedStep).

## Common Workflows

### 1. Loading Data
```R
library(rphast)

# Load an alignment (FASTA, PHYLIP, SS, etc.)
align <- read.msa("alignment.fa")

# Load a tree model
mod <- read.tm("model.mod")

# Load genomic features
genes <- read.feat("annotations.gff")
```

### 2. Fitting Substitution Models
Fit a model (e.g., REV, HKY85, JC) to an alignment given a tree topology.
```R
# Fit a neutral model using four-fold degenerate sites
neutral_mod <- fit.model(msa_4d, tree="((human,chimp),macaque);")
```

### 3. Conservation Scoring
Identify evolutionary conservation or acceleration.
```R
# Calculate phyloP scores (p-values for conservation/acceleration)
scores <- phyloP(neutral_mod, msa=align)

# Run phastCons to find conserved elements
pc_results <- phastCons(align, neutral_mod)
# pc_results$con.elements contains the predicted elements
# pc_results$post.prob contains base-by-base probabilities
```

### 4. MSA Manipulation
```R
# Extract a sub-alignment based on features
coding_msa <- msa.subalignment(align, features=genes[genes$feature=="CDS",])

# Get alignment statistics
msa.stat(align)

# Convert to sufficient statistics (compact representation)
ss <- as.ss(align)
```

### 5. Tree Operations
```R
# Scale tree branches
scaled_mod <- mod
scaled_mod$tree <- rescale.tree(mod$tree, 0.5)

# Calculate phylogenetic distance
dist <- tree.dist(tree1, tree2)
```

## Tips
- **Memory Management**: For very large alignments, use `pointer.only=TRUE` in `read.msa` to keep data in C structures rather than R, or use Sufficient Statistics (`as.ss`).
- **Coordinate Systems**: rphast generally uses 1-based indexing for coordinates to match R conventions, but pay attention when importing 0-based BED files.
- **Visualization**: Use `plot.msa()` or `msa.view()` for quick inspection of alignments.

## Reference documentation
- [rphast CRAN Page](https://cran.r-project.org/web/packages/rphast/index.html)
- [PHAST Official Documentation](http://compgen.cshl.edu/phast/)