---
name: maxalign-rs
description: maxalign-rs optimizes multiple sequence alignments by removing sequences that introduce gaps to maximize the total alignment area. Use when user asks to optimize a multiple sequence alignment, remove gap-heavy sequences, maximize alignment area for phylogenetic inference, or clean up FASTA files while protecting specific reference sequences.
homepage: https://github.com/apcamargo/maxalign-rs
---


# maxalign-rs

## Overview
maxalign-rs is a high-performance Rust reimplementation of the MaxAlign algorithm. It optimizes multiple sequence alignments by selectively removing sequences that introduce gaps into columns. By maximizing the "alignment area"—the product of the number of retained sequences and the number of gap-free columns—it ensures that the resulting alignment provides the maximum amount of usable data for sensitive downstream tasks like phylogenetic inference.

## Core CLI Usage

The basic syntax requires an input FASTA and an output destination:

```bash
maxalign-rs [OPTIONS] [INPUT] [OUTPUT]
```

### Common Patterns

**Basic Optimization**
Process a FASTA file using default settings (Heuristic Method 2):
```bash
maxalign-rs input.fasta optimized_output.fasta
```

**Handling Compressed Inputs**
The tool natively supports `.gz`, `.bz2`, `.xz`, and `.zst` formats:
```bash
maxalign-rs alignment.fasta.gz cleaned.fasta
```

**Using Standard Streams**
Integrate into shell pipelines:
```bash
cat input.fasta | maxalign-rs > output.fasta
```

## Optimization Strategies

### Heuristic Methods (`-m`)
Choose the heuristic based on the size of the alignment and the required precision:
- **Method 1 (`-m 1`)**: No synergy. Fastest; evaluates sequence removals independently. Best for extremely large alignments.
- **Method 2 (`-m 2`)**: Pairwise synergy (Default). Balances speed and accuracy by considering how pairs of sequences affect gap patterns.
- **Method 3 (`-m 3`)**: Three-way synergy. Most thorough heuristic; checks interactions between three sequence sets.

### Finding the Global Optimum (`-o`)
For smaller alignments where finding the absolute maximum area is critical, use the branch-and-bound refinement:
```bash
maxalign-rs input.fasta output.fasta -o
```
*Note: This is computationally expensive and should be avoided for very large datasets.*

### Protecting Specific Sequences (`-k`)
If certain sequences (e.g., a reference genome or a specific outgroup) must remain in the alignment regardless of their gap contribution, use the keep flag:
```bash
maxalign-rs input.fasta output.fasta -k "Reference_Seq_ID" -k "Outgroup_ID"
```

## Thresholds and Constraints

To prevent the tool from removing too many sequences or running too long on marginal improvements:

- **Limit Exclusions (`-s`)**: Stop if the fraction of excluded sequences exceeds a threshold (e.g., 20%).
  ```bash
  maxalign-rs input.fasta output.fasta -s 0.2
  ```
- **Improvement Threshold (`-t`)**: Stop if the relative improvement in alignment area falls below a specific value.
- **Iteration Limit (`-i`)**: Set a hard cap on the number of removal iterations.

## Output and Reporting

Generate metadata about the optimization process for reproducibility:

```bash
maxalign-rs input.fasta output.fasta \
  --report optimization_log.txt \
  --retained-sequences kept_ids.txt \
  --excluded-sequences removed_ids.txt
```

## Expert Tips
- **Gap Characters**: The tool treats both `-` and `.` as gap characters.
- **Phylogenetic Workflow**: Run `maxalign-rs` after initial alignment (e.g., via MAFFT or Clustal Omega) but before tree building to ensure the tree is based on the most informative columns.
- **Performance**: If the tool is running slowly on a large dataset, switch to `-m 1` and ensure you are not using the `-o` refinement flag.

## Reference documentation
- [maxalign-rs GitHub Repository](./references/github_com_apcamargo_maxalign-rs.md)
- [maxalign-rs Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_maxalign-rs_overview.md)