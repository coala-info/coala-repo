---
name: pytantan
description: This tool identifies and masks low-complexity regions and simple repeats in biological sequences. Use when user asks to mask repeats, detect low-complexity regions, or preprocess sequences before alignment.
homepage: https://github.com/althonos/pytantan
metadata:
  docker_image: "quay.io/biocontainers/pytantan:0.1.3--py312hdcc493e_1"
---

# pytantan

## Overview

The `pytantan` skill provides a high-performance Pythonic interface to Tantan, a specialized tool for detecting low-complexity regions and simple repeats in biological sequences. By using Cython bindings, it allows for direct memory interaction with the Tantan engine, making it ideal for high-throughput genomic pipelines where speed and portability are critical. Use this skill to mask sequences before alignment or to identify repetitive elements that might skew statistical analyses.

## Usage Instructions

### Basic Sequence Masking
For one-off operations, use the top-level `mask_repeats` function. By default, it masks repeats by converting them to lowercase.

```python
import pytantan

sequence = "ATTATTATTATTATT"
# Default lowercase masking
masked = pytantan.mask_repeats(sequence)
print(masked) # "ATTattattattatt"

# Custom mask character (e.g., 'N' for DNA or 'X' for protein)
masked_n = pytantan.mask_repeats(sequence, mask='N')
print(masked_n) # "ATTNNNNNNNNNNNN"
```

### High-Performance Batch Processing
When processing multiple sequences (e.g., a multi-FASTA file), do not call `mask_repeats` repeatedly. Instead, initialize a `RepeatFinder` object to reuse resources and improve performance.

```python
import pytantan

sequences = ["ATGC...", "CCGG...", "TTTA..."]
finder = pytantan.RepeatFinder()

for seq in sequences:
    masked = finder.mask_repeats(seq)
    # Process masked sequence
```

### Advanced Configuration
You can fine-tune the sensitivity of the repeat detection by adjusting the scoring parameters within the `RepeatFinder` or `mask_repeats` call.

- **mask**: The character used to replace repeated residues.
- **RepeatFinder initialization**: Can accept specific scoring matrices if the default DNA/Protein matrices are insufficient for your specific organism or sequence type.

### Expert Tips
- **SIMD Acceleration**: `pytantan` automatically selects the best SIMD (Single Instruction, Multiple Data) implementation for your CPU at runtime. Ensure your environment allows for runtime CPU feature detection (via the `archspec` package) for maximum performance.
- **Memory Efficiency**: Since `pytantan` works entirely in memory, it is significantly faster than the original Tantan CLI for small-to-medium sequences because it avoids the overhead of disk I/O and subprocess creation.
- **Integration**: Use `pytantan` as a preprocessing step before running alignment tools like BLAST or Diamond to reduce "dust" or "mask" hits that lead to biologically insignificant alignments.

## Reference documentation
- [pytantan Overview](./references/anaconda_org_channels_bioconda_packages_pytantan_overview.md)
- [pytantan GitHub Repository](./references/github_com_althonos_pytantan.md)