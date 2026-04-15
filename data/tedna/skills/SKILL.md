---
name: tedna
description: Tedna is a lightweight assembler designed to extract and assemble transposable elements directly from sequencing reads using high-frequency k-mers. Use when user asks to assemble transposable elements, discover repetitive genomic components, or perform de novo assembly of repeats from short or long sequencing reads.
homepage: https://github.com/mzytnicki/tedna
metadata:
  docker_image: "quay.io/biocontainers/tedna:1.3.1--h503566f_0"
---

# tedna

## Overview
Tedna is a specialized, lightweight assembler designed to extract and assemble transposable elements (TEs) directly from sequencing reads. Unlike general-purpose assemblers that attempt to reconstruct entire genomes, Tedna focuses on high-frequency k-mers to specifically target repetitive genomic components. It is an efficient solution for TE discovery that works by building a de Bruijn graph and filtering for sequences that appear at higher frequencies than the estimated background genome coverage.

## Installation
The most reliable way to install Tedna is via Bioconda:
```bash
conda install bioconda::tedna
```
Alternatively, it can be compiled from source using `make`. Note that Tedna requires C++11 and the `sparsehash` library.

## Core CLI Usage

### Short-Read Paired-End Assembly
For standard Illumina data, you must provide both read files and the expected insert size.
```bash
tedna -1 left.fastq -2 right.fastq -k 61 -i 300 -o output.fasta
```

### Long-Read Assembly
When working with long reads (e.g., PacBio), use the `-m` flag to specify minimum length and `-t` for the repeat threshold.
```bash
tedna -1 reads.fastq -k 61 -m 1000 -t 25 -o output.fasta
```

## Parameter Optimization

### k-mer Selection (`-k`)
The choice of k-mer size is the most critical factor for assembly quality.
- **Default**: 61.
- **Strategy**: Use trial and error. Larger k-mers provide more specificity but require higher coverage and more RAM.
- **Compilation Limit**: If you need k-mers larger than 61, you must recompile the tool using `make k=91` (or your desired size).

### Handling Coverage and Repeats
Tedna attempts to automatically infer genome coverage to distinguish between unique genomic DNA and repetitive TEs.
- **Manual Threshold (`-t`)**: If the automatic inference fails (common in genomes with >50% repeats), manually provide the repeated fraction of the genome as a percentage.
- **Repeat Frequency (`--repeatFrequency`)**: Use this to target specific tiers of repeats (e.g., sequences appearing 3x more often than the genome background).

### Performance Tuning
If compiling from source, you can optimize memory usage vs. speed via the `HASH` variable:
- `make HASH=SLOW`: Lowest memory usage (uses `sparsehash-sparse`).
- `make HASH=MID`: Balanced (default C++11 hash).
- `make HASH=FAST`: Fastest execution, highest memory usage (uses `sparsehash-dense`).

## Expert Tips
- **Input Requirements**: Tedna does not support compressed files. Ensure your FASTQ files are unzipped (`.fastq`, not `.fastq.gz`) before running.
- **Memory Management**: Compiling with very large k-mer support significantly increases the RAM footprint of the binary. Only compile for the size you actually need.
- **Long Read Filtering**: When using long reads, the `-m` parameter is essential to filter out short, uninformative fragments that can clutter the de Bruijn graph.

## Reference documentation
- [Tedna GitHub Repository](./references/github_com_mzytnicki_tedna.md)
- [Bioconda Tedna Package Overview](./references/anaconda_org_channels_bioconda_packages_tedna_overview.md)