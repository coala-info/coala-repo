---
name: bioconductor-procoil
description: This tool predicts whether a coiled coil protein sequence is more likely to form a dimer or a trimer using support vector machines. Use when user asks to predict oligomerization states, compute prediction profiles for amino acid sequences, perform comparative mutation analysis, or visualize residue contributions as plots and heatmaps.
homepage: https://bioconductor.org/packages/release/bioc/html/procoil.html
---

# bioconductor-procoil

name: bioconductor-procoil
description: Predicts whether a coiled coil sequence is more likely to form a dimer or a trimer using support vector machines. Use this skill to analyze amino acid sequences with heptad registers, compute prediction profiles, perform comparative mutation analysis, and visualize results as curves or heatmaps.

## Overview

The `procoil` package predicts the oligomerization state (dimer vs. trimer) of coiled coil proteins. It requires both an amino acid sequence and an aligned heptad register (positions 'a' through 'g'). Beyond simple classification, it provides "prediction profiles" that quantify the contribution of each individual residue to the final oligomerization decision.

## Core Workflow

### 1. Basic Prediction
To predict the oligomerization state, use the `predict()` function. You must provide a model object (usually the built-in `PrOCoilModel`) and the sequence data.

```R
library(procoil)

# Sequence and heptad register must be the same length
seq <- "MKQLEDKVEELLSKNYHLENEVARLKKLV"
reg <- "abcdefgabcdefgabcdefgabcdefga"

# Run prediction
res <- predict(PrOCoilModel, seq, reg)

# View results
res
# Access specific values
score(res)
prediction(res) # "dimer" or "trimer"
```

### 2. Handling Sequences with Non-Coiled Coil Regions
If a sequence contains regions that are not coiled coils, use dashes (`-`) in the heptad register. `procoil` will automatically extract and analyze the contiguous coiled coil segments.

```R
seq_long <- "MGECDQLLVFMITSRVLVLSTLIIMDSRQVYLENLRQFAENLRQNIENVHSFLENLRADLENLRQKFPGKWYSAMPGRHG"
reg_long <- "-------------------------------abcdefgabcdefgabcdefgabcdefgabcdefg--------------"

res_list <- predict(PrOCoilModel, seq_long, reg_long)
# Returns a CCProfile object containing all detected segments
```

### 3. Comparative Mutation Analysis
You can compare multiple sequences (e.g., wild-type vs. mutants) by passing vectors to `predict()`.

```R
sequences <- c(wt = "MKQLEDKVEELLSKNYHLENEVARLKKLV", 
               mut = "MKQLEDKVEELLSKYYHTENEVARLKKLV")
registers <- rep("abcdefgabcdefgabcdefgabcdefga", 2)

comparative_res <- predict(PrOCoilModel, sequences, registers)
```

## Visualization

### Profile Plots
Visualize the contribution of each residue. Positive values favor trimers; negative values favor dimers.

```R
# Standard plot
plot(res)

# Overlay two profiles for comparison
plot(comparative_res[c(1, 2)])

# Customizing: add legends and colors
plot(comparative_res[c(1, 2)], 
     legend = c("Wild-type", "Mutant"),
     col = c("red", "blue"))
```

### Heatmaps
For three or more sequences, use a heatmap to see patterns across the entire set.

```R
heatmap(comparative_res)
```

## Advanced Usage

### Alternative Models
The package includes `PrOCoilModelBA`, which is optimized for **balanced accuracy** (useful if you want to weigh trimer and dimer detection sensitivity equally).

```R
res_ba <- predict(PrOCoilModelBA, seq, reg)
```

### Supplying Registers via Metadata
Instead of the `reg` argument, you can attach registers directly to Biostrings objects:

```R
library(Biostrings)
s <- AAString("MKQLEDKVEELLSKNYHLENEVARLKKLV")
metadata(s)$reg <- "abcdefgabcdefgabcdefgabcdefga"
predict(PrOCoilModel, s)
```

### Exporting Plots
When saving to PDF or PNG, scale the width based on the sequence length for better readability (approx. 1/24 of the height per residue).

```R
pdf("profile.pdf", height = 6, width = nchar(seq) * 6 / 24)
plot(res)
dev.off()
```

## Reference documentation
- [procoil](./references/procoil.md)