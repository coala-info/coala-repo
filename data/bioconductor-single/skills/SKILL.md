---
name: bioconductor-single
description: This tool performs accurate gene consensus calling for nanopore sequencing of gene libraries by correcting systematic errors using the SINGLe algorithm. Use when user asks to train error models from reference sequences, re-weight quality scores in mutant libraries, or compute high-accuracy consensus sequences for directed evolution experiments.
homepage: https://bioconductor.org/packages/3.16/bioc/html/single.html
---

# bioconductor-single

name: bioconductor-single
description: Accurate gene consensus calling for nanopore sequencing of gene libraries. Use this skill when analyzing long amplicon reads from directed evolution experiments to correct systematic nanopore errors and compute high-accuracy consensus sequences using the SINGLe algorithm.

# bioconductor-single

## Overview

The `single` package (SINGLe: Systematic error Identification in Nanopore Gene Libraries) improves the accuracy of consensus calling for nanopore sequencing data, specifically for gene libraries derived from a known reference sequence. It characterizes systematic sequencing errors using a reference (wild-type) dataset and applies this knowledge to re-weight quality scores (QUAL) in mutant libraries. This allows for high-accuracy variant identification even at low coverage.

## Typical Workflow

The SINGLe workflow consists of three primary steps: training the error model, evaluating the library reads, and computing the consensus.

### 1. Training the Model
Use reads from a known reference (wild-type) sequence to characterize systematic errors.

```r
library(single)

# Define genomic range
pos_start <- 1
pos_end <- 1000 

# Path to reference fasta and sorted BAM of reference reads
ref_fasta <- "path/to/ref.fasta"
ref_bam <- "path/to/REF_READS.sorted.bam"

# Train the model
train_fits <- single_train(
  bamfile = ref_bam,
  refseq_fasta = ref_fasta,
  rates.matrix = mutation_rate, # Provided by package
  mean.n.mutations = 5.4,       # Expected mutations per sequence
  pos_start = pos_start,
  pos_end = pos_end,
  verbose = FALSE
)
```

### 2. Evaluating Library Reads
Apply the trained model to the experimental library to correct/re-weight the quality scores.

```r
lib_bam <- "path/to/LIB_READS.sorted.bam"
ref_seq <- Biostrings::readDNAStringSet(ref_fasta)

corrected_reads <- single_evaluate(
  bamfile = lib_bam,
  single_fits = train_fits,
  ref_seq = ref_seq,
  pos_start = pos_start,
  pos_end = pos_end,
  gaps_weights = "minimum"
)
```

### 3. Computing Consensus
Group reads (e.g., by barcode or UMI) and compute the weighted consensus sequence.

```r
# BC_TABLE should have columns: SeqID (read name) and BCid (group ID)
bc_table_path <- "path/to/BC_TABLE.txt"

consensus_results <- single_consensus_byBarcode(
  barcodes_table = bc_table_path,
  sequences = corrected_reads
)
```

## Key Functions

- `single_train()`: Fits a logistic regression model to characterize systematic errors based on reference reads.
- `single_evaluate()`: Re-weights the Phred quality scores of library reads based on the trained model.
- `single_consensus_byBarcode()`: Generates consensus sequences for groups of reads identified by barcodes.
- `weighted_consensus()`: Computes a single consensus sequence from a data frame of nucleotides and SINGLe probabilities.
- `pileup_by_QUAL()`: Creates a summary table of counts by position, nucleotide, and quality score.

## Tips and Best Practices

- **Data Preprocessing**: Before using `single` in R, reads must be aligned to the reference sequence and provided as a sorted BAM file (e.g., using `minimap2` and `samtools`).
- **Memory Management**: For very long amplicons or large libraries, process the data in chunks by adjusting `pos_start` and `pos_end`.
- **Mutation Rates**: The `mutation_rate` matrix is a built-in dataset in the package; ensure it is loaded or defined if using custom mutation priors.
- **Consensus Thresholds**: When using `weighted_consensus()`, the `cutoff_prob` parameter (default 0.9) determines the stringency. Higher values (e.g., 0.999) may result in more gaps (-) if the evidence is not strong enough.

## Reference documentation

- [single](./references/single.md)