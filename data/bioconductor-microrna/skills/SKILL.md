---
name: bioconductor-microrna
description: This package provides data and functions for microRNA analysis, including seed region extraction, sequence matching, and self-hybridization analysis. Use when user asks to extract seed regions from microRNA sequences, match seeds to target sequences, convert RNA to DNA, or identify self-hybridizing subsequences.
homepage: https://bioconductor.org/packages/release/bioc/html/microRNA.html
---

# bioconductor-microrna

name: bioconductor-microrna
description: Data and functions for microRNA analysis, including seed region extraction, sequence matching, and self-hybridization analysis. Use when Claude needs to: (1) Extract seed regions from microRNA sequences, (2) Match microRNA seeds to 3'UTR target sequences, (3) Convert RNA sequences to DNA, or (4) Identify self-hybridizing subsequences within RNA/DNA.

## Overview

The `microRNA` package provides infrastructure for handling microRNA sequences and their targets. It includes built-in datasets for human (`hsSeqs`, `hsTargets`) and mouse (`mmSeqs`, `mmTargets`), along with utilities to find potential binding sites by matching seed regions to 3' UTR sequences.

## Core Workflows

### 1. Seed Region Extraction and Matching
The most common workflow involves extracting the "seed" (typically bases 2-7) from a microRNA and finding matches in target sequences (like 3'UTRs).

```r
library(microRNA)
library(Biostrings)

# Load human sequences and 3'UTR data
data(hsSeqs)
data(s3utr)

# 1. Extract seed regions (default is bases 2 to 7)
seeds = seedRegions(hsSeqs[1:5])

# 2. Prepare seeds for matching (Reverse Complement + RNA to DNA)
# Note: To match RNA seeds to DNA UTRs, you must RC and convert U to T
comp_seeds = as.character(reverseComplement(RNAStringSet(seeds)))
dna_seeds = RNA2DNA(comp_seeds)

# 3. Find exact matches in UTR sequences
matches = matchSeeds(dna_seeds, s3utr)
```

### 2. Self-Hybridization Analysis
Use `get_selfhyb_subseq` to find the longest subsequences that are reverse complements of themselves within the same strand.

```r
seqs = c(mir1 = "UGAGGUAGUAGGUUGUAUAGUU")
ans = get_selfhyb_subseq(seqs, minlen = 3, type = "RNA")

# Visualize results
show_selfhyb_counts(ans)
show_selfhyb_lengths(ans)
```

### 3. Sequence Conversion
The `RNA2DNA` function is a utility to convert RNA strings (with 'U') to DNA strings (with 'T'). It automatically converts input to uppercase.

```r
rna_seq = "augc"
dna_seq = RNA2DNA(rna_seq) # Returns "ATGC"
```

## Data Resources

- `hsSeqs` / `mmSeqs`: Character vectors of mature microRNA sequences for Human and Mouse.
- `hsTargets` / `mmTargets`: Data frames containing microRNA names, Ensembl transcript IDs, and genomic coordinates of binding sites.
- `s3utr`: A sample character vector of 3' UTR sequences (names are Entrez Gene IDs).

## Tips and Best Practices

- **Orientation Matters**: When using `matchSeeds`, ensure your sequences are in the same "alphabet" (DNA vs RNA) and that you have accounted for the reverse-complementarity of binding (microRNA seed vs UTR target).
- **Seed Coordinates**: While the default for `seedRegions` is 2-7, you can specify custom ranges using the `start` and `stop` arguments.
- **Dependencies**: This package relies on `Biostrings`. For complex sequence manipulations (like reverse complementation), use `Biostrings` objects (e.g., `RNAStringSet`).

## Reference documentation
- [microRNA Reference Manual](./references/reference_manual.md)