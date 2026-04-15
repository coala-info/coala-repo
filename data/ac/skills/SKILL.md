---
name: ac
description: The ac tool is a specialized lossless compressor designed for amino acid sequences that utilizes multiple context models to achieve high compression ratios. Use when user asks to compress protein sequences, decompress proteomic data, or calculate the information content of specific sequences.
homepage: https://github.com/cobilab/ac
metadata:
  docker_image: "quay.io/biocontainers/ac:1.1--h503566f_6"
---

# ac

## Overview

The `ac` tool is a specialized lossless compressor specifically engineered for amino acid (protein) sequences. Unlike general-purpose compression algorithms, `ac` utilizes a combination of multiple context models and substitution-tolerant models to achieve high compression ratios on proteomic data. It is ideal for researchers managing large protein databases or those needing to calculate the information content of specific sequences.

## Installation

The most efficient way to install `ac` is via Bioconda:

```bash
conda install bioconda::ac
```

## Common CLI Patterns

### Basic Compression and Decompression
The tool uses `AC` for compression and `AD` for decompression.

*   **Compress a file:**
    ```bash
    AC -v -l 2 input_sequence.fasta
    ```
    *Note: This produces a `.co` file (e.g., `input_sequence.fasta.co`).*

*   **Decompress a file:**
    ```bash
    AD -v input_sequence.fasta.co
    ```
    *Note: This produces a `.de` file (e.g., `input_sequence.fasta.de`).*

### Compression Levels
The `-l` flag sets the compression level from 1 to 7.
- **Level 1:** Fastest execution, lowest compression ratio.
- **Level 2-5:** Balanced performance for standard proteomes.
- **Level 6-7:** Maximum compression, suitable for very large datasets or when storage is at a premium, but requires significantly more time and memory.

### Reference-based Compression
If you have a similar protein sequence, you can use it as a reference to improve the compression of your target file.

```bash
AC -r reference_proteins.fasta target_proteins.fasta
```

## Advanced Usage and Expert Tips

### Information Content Analysis
Use the `-e` flag to generate an information content report.
```bash
AC -e sequence.fasta
```
This creates a `.iae` file containing the information content (entropy) details for the sequence, which is useful for bioinformatics analysis.

### Model Configuration
The tool allows for fine-grained control over the context models using `-tm` (target model) and `-rm` (reference model). The syntax is `<c>:<d>:<g>/<m>:<e>:<a>`:
- `c`: Context-order size.
- `d`: Alpha (1/d).
- `g`: Gamma (decayment forgetting factor) [0;1).
- `m`: Maximum allowed mutations in context.
- `e`: Estimator.
- `a`: Gamma for tolerant model.

**Example of custom model setup:**
```bash
AC -tm 1:1:0.8/0:0:0 -tm 7:100:0.9/2:10:0.85 sequence.fasta
```

### Handling Multiple Files
You can compress multiple files into a single stream by separating them with colons:
```bash
AC file1.fasta:file2.fasta:file3.fasta
```

## Reference documentation
- [ac Overview](./references/anaconda_org_channels_bioconda_packages_ac_overview.md)
- [cobilab/ac GitHub Repository](./references/github_com_cobilab_ac.md)