---
name: r-dowser
description: The dowser package provides a comprehensive toolkit for B cell receptor phylogenetics, including germline reconstruction, lineage tree building, and evolutionary analysis. Use when user asks to reconstruct B cell lineage trees, estimate time-resolved phylogenies, or perform statistical tests for isotype switching and migration.
homepage: https://cran.r-project.org/web/packages/dowser/index.html
---

# r-dowser

## Overview
The `dowser` package is a comprehensive toolkit for B cell receptor (BCR) phylogenetics. It provides specialized methods to account for the unique properties of B cell evolution, such as somatic hypermutation (SHM) hotspots and unmutated ancestral germlines. Key capabilities include tree reconstruction (Parsimony, ML, IgPhyML), time-tree estimation (TyCHE/BEAST), and statistical tests for migration and isotype switching.

## Installation
```r
install.packages("dowser")
# Note: Some features require external tools like IgPhyML, PHYLIP, or BEAST2.
```

## Core Workflow

### 1. Germline Reconstruction
Before building trees, you must reconstruct the unmutated germline sequence.
```r
library(dowser)
# Read IMGT-gapped reference sequences
references <- readIMGT(dir = "path/to/germlines/human/vdj")
# Reconstruct germlines for AIRR-format data
db_with_germline <- createGermlines(db, references)
```

### 2. Formatting Clones
Convert AIRR-style data frames into `airrClone` objects. This step collapses identical sequences and prepares the alignment.
```r
# traits: columns to preserve (e.g., tissue, timepoint, isotype)
clones <- formatClones(db_with_germline, traits=c("c_call", "sample_id"))
```

### 3. Building Lineage Trees
Use `getTrees` to infer topologies. Supported methods include `phangorn` (default), `dnapars`, `dnaml`, `igphyml`, and `raxml`.
```r
# Maximum Parsimony (default)
trees <- getTrees(clones)

# Maximum Likelihood using IgPhyML (requires executable)
trees <- getTrees(clones, build="igphyml", exec="/path/to/igphyml")
```

### 4. Visualization
Visualize trees with metadata at the tips using `ggtree`-based functions.
```r
# Plot with isotypes at tips
plots <- plotTrees(trees, tips="c_call", tipsize=2)
plots[[1]] # View the largest clone
```

## Specialized Analyses

### Discrete Trait Analysis (Migration/Switching)
Test for biased movement between tissues or isotype switching directions using Parsimony Score (PS) and Switch Proportion (SP) tests.
```r
# Requires IgPhyML
switches <- findSwitches(trees, trait="biopsy", igphyml="/path/to/igphyml")
sp_test <- testSP(switches$switches, alternative="greater")
```

### Measurable Evolution (Date Randomization)
Detect if a lineage is accumulating mutations over time in longitudinal data.
```r
# time must be numeric
test <- correlationTest(trees, time="timepoint", permutations=1000)
```

### Time Trees (BEAST2/TyCHE)
Infer time-resolved phylogenies using molecular clock models.
```r
# Requires BEAST2 and TyCHE package
time_trees <- getTimeTreesIterate(clones, beast="/path/to/beast/bin/", 
                                  template="StrictClock.xml", time="sample_time")
```

### Paired Heavy and Light Chains
Resolve light chain subgroups and build combined "HL" trees.
```r
db <- resolveLightChains(db)
clones <- formatClones(db, chain="HL", split_light=TRUE)
```

## Tips and Best Practices
- **Collapsing Nodes**: Use `collapseNodes(trees)` to simplify visualizations by merging internal nodes with identical reconstructed sequences.
- **Node Sequences**: Retrieve ancestral sequences using `getNodeSeq(trees, node=ID, clone=ID)`.
- **Parallel Processing**: Most heavy functions (`getTrees`, `findSwitches`) support `nproc` for multi-core execution.
- **Non-B Cells**: Dowser supports tumor lineages or other evolving populations by setting `include_germline=FALSE` in `formatClones`.

## Reference documentation
- [Build Time Trees Using TyCHE and BEAST](./references/Building-Time-Trees-Vignette.Rmd)
- [Build B cell lineage trees](./references/Building-Trees-Vignette.Rmd)
- [Discrete trait analysis](./references/Discrete-Trait-Vignette.Rmd)
- [Reconstruct clonal germline sequences](./references/Germlines-Vignette.Rmd)
- [Detect ongoing B cell evolution](./references/Measurable-Evolution.Rmd)
- [Using data from non-B cells](./references/NonB-Cell-Data.Rmd)
- [Plot B cell lineage trees](./references/Plotting-Trees-Vignette.Rmd)
- [Dowser: Simple lineage tree construction](./references/Quickstart-Vignette.Rmd)
- [Building trees with paired heavy and light chain data](./references/Resolve-Light-Chains-Vignette.Rmd)
- [Reconstruct intermediate sequences](./references/Sequences-Vignette.Rmd)