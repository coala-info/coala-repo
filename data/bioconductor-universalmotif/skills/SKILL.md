---
name: bioconductor-universalmotif
description: This package provides a standardized interface in R for importing, exporting, manipulating, and visualizing biological sequence motifs across various formats and alphabets. Use when user asks to create or convert motifs, perform motif scanning in sequences, calculate P-values, or compare and cluster motifs using sequence logos and trees.
homepage: https://bioconductor.org/packages/release/bioc/html/universalmotif.html
---

# bioconductor-universalmotif

name: bioconductor-universalmotif
description: Expert guidance for the universalmotif Bioconductor package. Use this skill to import, export, manipulate, compare, and visualize sequence motifs (DNA, RNA, Protein) in R. It supports conversion between PCM, PPM, PWM, and ICM formats, motif scanning in sequences, and P-value calculations.

# bioconductor-universalmotif

## Overview
The `universalmotif` package provides a standardized R interface for biological sequence motifs. It centers around the `universalmotif` class, which allows for seamless conversion between different motif representations (Position Count, Probability, Weight, and Information Content matrices). It is highly compatible with other Bioconductor motif packages like `MotifDb`, `TFBSTools`, and `PWMEnrich`.

## Core Workflows

### 1. Motif Creation and Conversion
Motifs can be created from matrices, sequences, or converted from other formats.

```r
library(universalmotif)

# Create a motif from a matrix
m <- matrix(c(0.1, 0.5, 0.2, 0.2, 0.8, 0.0, 0.1, 0.1), nrow = 4)
my_motif <- create_motif(m, alphabet = "DNA", name = "MyMotif")

# Convert between types (PCM, PPM, PWM, ICM)
pwm_motif <- convert_type(my_motif, type = "PWM")

# Convert from other Bioconductor objects (e.g., TFBSTools or MotifDb)
# motifs <- convert_motifs(MotifDb_object)
```

### 2. Motif Manipulation
Modify motif properties or transform the motif itself.

```r
# Access and modify slots
my_motif["name"] <- "NewName"
my_motif["strand"] <- "+-"

# Trim low information edges
trimmed_motif <- trim_motifs(my_motif, min.ic = 0.2)

# Generate reverse complement
rc_motif <- motif_rc(my_motif)

# Merge multiple motifs into a consensus
merged <- merge_motifs(c(motif1, motif2))
```

### 3. Comparison and Clustering
Compare motifs using various metrics (PCC, Euclidean, KL divergence) and visualize relationships.

```r
# Compare two motifs
comparison <- compare_motifs(motifs_list, method = "PCC")

# Generate a motif tree (requires ggtree)
tree <- motif_tree(motifs_list, layout = "rectangular")
plot(tree)
```

### 4. Sequence Scanning
Search for motif occurrences within Biostrings objects (DNAStringSet, etc.).

```r
# Scan sequences for matches
# threshold = 1e-4 (P-value) or 0.8 (relative score)
results <- scan_sequences(my_motif, my_sequences, threshold = 0.8, threshold.type = "logodds")

# Calculate P-values for specific scores
p_val <- motif_pvalue(my_motif, score = 10.5)
```

### 5. Visualization
Generate sequence logos and other plots.

```r
# Basic sequence logo
view_motifs(my_motif)

# View multiple motifs together
view_motifs(c(motif1, motif2))
```

## Tips and Best Practices
- **Pseudocounts**: When converting to PWM, `universalmotif` uses a default pseudocount to avoid `-Inf` values. You can adjust this via `my_motif["pseudocount"]`.
- **Background Frequencies**: Always ensure the background frequencies (`bkg` slot) match your target organism's genome for accurate PWM scoring and P-value calculation.
- **Alphabet Support**: Beyond DNA/RNA/AA, you can define custom alphabets for non-standard sequence analysis.
- **Performance**: For large-scale comparisons, `compare_motifs` is optimized for speed compared to older Bioconductor alternatives.

## Reference documentation
- [Introduction to "universalmotif"](./references/Introduction.md)
- [Introduction to sequence motifs](./references/IntroductionToSequenceMotifs.md)
- [Motif import, export, and manipulation](./references/MotifManipulation.md)
- [Sequence scanning and manipulation](./references/SequenceSearches.md)
- [Motif comparisons and P-values](./references/MotifComparisonAndPvalues.md)