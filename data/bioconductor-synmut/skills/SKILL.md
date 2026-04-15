---
name: bioconductor-synmut
description: bioconductor-synmut creates synonymous mutant DNA sequences by modifying codon and dinucleotide usage bias without altering the translated protein. Use when user asks to generate synonymous mutations, optimize or de-optimize specific codons, manipulate dinucleotide content, or mimic the codon usage pattern of a target organism.
homepage: https://bioconductor.org/packages/release/bioc/html/SynMut.html
---

# bioconductor-synmut

## Overview

`SynMut` is a Bioconductor package designed for the creation of synonymous mutant DNA sequences. It allows researchers to modify the genomic signatures of a sequence—specifically codon usage bias and dinucleotide usage bias—without altering the translated protein product. This is particularly useful in virology (e.g., virus attenuation) and synthetic biology.

Key capabilities include:
- Defining specific "mutable regions" to protect conserved motifs.
- Random synonymous mutagenesis.
- Maximizing or minimizing specific codons or dinucleotides.
- Mimicking the codon usage pattern of a target organism or sequence.

## Core Workflow

### 1. Data Preparation
The package uses a `regioned_dna` object as the primary data structure.

```r
library(SynMut)

# Load DNA sequences (fasta or DNAStringSet)
filepath.fasta <- system.file("extdata", "example.fasta", package = "SynMut")

# Optional: Define mutable regions (CSV with amino acid positions)
# If omitted, the entire sequence is considered mutable.
filepath.csv <- system.file("extdata", "target_regions.csv", package = "SynMut")
region <- read.csv(filepath.csv)

# Create the core object
rgd.seq <- input_seq(filepath.fasta, region)
```

### 2. Sequence Analysis
Before mutating, analyze the baseline genomic features:

- `get_dna(rgd.seq)`: Returns a `DNAStringSet`.
- `get_cu(rgd.seq)`: Returns codon usage counts.
- `get_du(rgd.seq)`: Returns dinucleotide usage counts.
- `get_freq(rgd.seq)`: Returns synonymous codon frequency.
- `get_rscu(rgd.seq)`: Returns Relative Synonymous Codon Usage.

### 3. Generating Mutations

#### Random Mutagenesis
Generate random synonymous changes. Use `keep = TRUE` to maintain the original codon usage bias while shuffling positions.
```r
# Random mutations
mut.seq <- codon_random(rgd.seq, n = 0.5) # n = proportion of codons to mutate

# Randomize while preserving global codon usage bias
mut.seq_fixed <- codon_random(rgd.seq, keep = TRUE)
```

#### Codon Optimization/De-optimization
Target specific codons for maximization or minimization.
```r
# Maximize AAC usage
mut.max <- codon_to(rgd.seq, max.codon = "AAC")

# Minimize AAC usage
mut.min <- codon_to(rgd.seq, min.codon = "AAC")
```

#### Dinucleotide Manipulation
Commonly used to increase or decrease CpG (CG) content.
```r
# Maximize CG dinucleotides
mut.cg <- dinu_to(rgd.seq, max.dinu = "cg")

# Maximize CG while preserving original codon usage bias
mut.cg_keep <- dinu_to(rgd.seq, max.dinu = "cg", keep = TRUE)
```

#### Codon Mimicry
Mutate a sequence to match the codon usage profile of a target (e.g., a host organism).
```r
# 'alt' can be a codon usage vector or a DNAStringSet
target_usage <- get_cu(rgd.seq)[2,] 
mut.mimic <- codon_mimic(rgd.seq, alt = target_usage)
```

### 4. Exporting Results
Convert the `regioned_dna` object back to standard formats for downstream use.
```r
final_dna <- get_dna(mut.mimic)
Biostrings::writeXStringSet(final_dna, "mutant_sequences.fasta")
```

## Tips and Best Practices
- **Mutable Regions**: Always define `region` if your sequence contains known functional RNA elements, promoters, or overlapping reading frames that must not be mutated.
- **Heuristic Algorithm**: `dinu_to` uses a greedy algorithm. For very complex constraints, results are optimized but may not reach the theoretical mathematical limit.
- **Verification**: Always compare the output of `get_cu()` or `get_du()` between the original and mutant objects to verify the magnitude of the change.

## Reference documentation
- [SynMut: Designing Synonymous Mutants for DNA Sequences](./references/SynMut.Rmd)
- [SynMut: Tools for Designing Synonymously Mutated Sequences](./references/SynMut.md)