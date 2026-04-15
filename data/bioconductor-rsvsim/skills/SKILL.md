---
name: bioconductor-rsvsim
description: This tool simulates structural variations including deletions, insertions, inversions, tandem duplications, and translocations in genomic sequences. Use when user asks to simulate structural variations, generate rearranged genomes for benchmarking detection algorithms, or model SV formation mechanisms like NAHR and NHR.
homepage: https://bioconductor.org/packages/release/bioc/html/RSVSim.html
---

# bioconductor-rsvsim

name: bioconductor-rsvsim
description: Simulation of structural variations (SVs) in genomic sequences. Use this skill to simulate deletions, insertions, inversions, tandem duplications, and translocations. It supports rearranging the human genome (hg19) or custom genomes, modeling SV formation mechanisms (NAHR, NHR, etc.), adding breakpoint mutations (SNPs/indels), and comparing simulated SVs against detection algorithm results.

# bioconductor-rsvsim

## Overview

`RSVSim` is a Bioconductor package designed to simulate structural variations (SVs) to create a ground truth for evaluating SV detection algorithms. It can produce rearranged genomes as `DNAStringSet` objects and export them as FASTA files, along with CSV tables detailing the simulated variations.

## Core Workflow

### 1. Loading the Package and Genome
The package works with `DNAStringSet` objects. You can use the default hg19 genome (requires `BSgenome.Hsapiens.UCSC.hg19`) or provide a custom sequence.

```R
library(RSVSim)
library(Biostrings)

# Custom toy genome
genome <- DNAStringSet(c(chr1="AAAAAAAAAAAAAAAAAAAATTTTTTTTTTTTTTTTTTTT", 
                         chr2="GGGGGGGGGGGGGGGGGGGGCCCCCCCCCCCCCCCCCCCC"))
```

### 2. Simulating Structural Variations
The primary function is `simulateSV`. You specify the number of variations and their sizes.

*   **Deletions (`dels`):** `simulateSV(genome=genome, dels=3, sizeDels=10)`
*   **Insertions (`ins`):** `simulateSV(genome=genome, ins=2, sizeIns=5)`
    *   Use `percCopiedIns` to toggle between "cut-and-paste" (0) and "copy-and-paste" (1).
*   **Inversions (`invs`):** `simulateSV(genome=genome, invs=2, sizeInvs=c(5, 10))`
*   **Tandem Duplications (`dups`):** `simulateSV(genome=genome, dups=1, sizeDups=6, maxDups=3)`
*   **Translocations (`trans`):** `simulateSV(genome=genome, trans=1, percBalancedTrans=1)`

**Key Parameters:**
- `output`: Directory path to save FASTA and CSV files. Set to `NA` to keep results in R memory only.
- `bpSeqSize`: Length of the breakpoint sequence to report in metadata.
- `random`: Set to `FALSE` to insert SVs at specific coordinates provided via `regions` arguments.

### 3. Advanced Simulation Features

#### SV Size Distribution
Instead of fixed sizes, use `estimateSVSizes` to draw sizes from a beta distribution modeled on real data (DGV).
```R
# Draw 100 sizes for deletions based on DGV defaults
sizes <- estimateSVSizes(n=100, minSize=500, maxSize=10000, default="deletions")
sim <- simulateSV(genome=genome, dels=100, sizeDels=sizes)
```

#### Repeat Bias and Mechanisms (hg19 only)
For the human genome, you can simulate biases toward repeat regions (LINE, SINE, etc.) and specific formation mechanisms (NAHR, NHR, TEI, VNTR).
```R
# Requires hg19 coordinates
sim <- simulateSV(repeatBias=TRUE, genome=hg19_genome)
```

#### Breakpoint Mutations
Add small mutations (SNPs/indels) at the SV breakpoints to simulate "messy" joins.
```R
sim <- simulateSV(genome=genome, dels=5, sizeDels=10, 
                  bpFlankSize=10, percSNPs=0.1, indelProb=0.5)
```

### 4. Comparing Results
Use `compareSV` to evaluate the performance of an SV caller against the simulation ground truth. It requires the query SVs in a data frame (BED or BEDPE format).

```R
# sim_metadata is retrieved from metadata(sim)$deletions
comparison <- compareSV(querySVs=detected_df, simSVs=sim_metadata, tol=5)
```

## Reference documentation

- [RSVSim: Simulation of structural variations](./references/vignette.md)