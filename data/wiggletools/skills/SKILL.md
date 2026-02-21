---
name: wiggletools
description: WiggleTools is a specialized toolkit designed to treat genomic data as continuous numerical functions.
homepage: https://github.com/Ensembl/WiggleTools
---

# wiggletools

## Overview

WiggleTools is a specialized toolkit designed to treat genomic data as continuous numerical functions. By utilizing lazy evaluation and iterators, it allows for complex mathematical and statistical operations across entire genomes without the memory overhead of loading full datasets. Use this skill when you need to aggregate multiple genomic tracks, apply thresholds, scale data by constants, or compute derived statistics like variance and Wilcoxon rank-sum tests directly from standard bioinformatics file formats.

## Command Line Usage

The primary interface is the `wiggletools` executable, which accepts a "program" string describing the operations to perform.

### Basic Syntax
```bash
wiggletools <program_string>
```

For complex or very long commands that might exceed shell character limits, use a script file:
```bash
wiggletools run program.txt
```

### Input Formats
WiggleTools automatically detects formats based on file extensions:
- **Continuous data**: `.wig`, `.bw` (BigWig), `.bg` (BedGraph)
- **Interval data**: `.bed`, `.bb` (BigBed)
- **Sequence/Variant data**: `.bam`, `.cram` (requires `.bai`), `.vcf`, `.bcf` (requires `.tbi`)

### Common Operations

#### Unary Operators (Single Input)
- **Scaling and Math**:
  - `scale <scalar> <input>`: Multiply all values by a decimal.
  - `offset <scalar> <input>`: Add a constant to all values.
  - `abs <input>`, `ln <input>`, `log <base> <input>`: Standard mathematical transformations.
- **Thresholding (Boolean Output)**:
  - `gt <value> <input>`: Regions where data > value.
  - `lt <value> <input>`: Regions where data < value.
  - `unit <input>`: Returns 1 for non-zero regions, 0 otherwise.

#### Multi-Input Operators
- **Aggregation**:
  - `sum <input1> <input2> ...`
  - `product <input1> <input2> ...`
  - `mean <input1> <input2> ...`
  - `median <input1> <input2> ...`

#### Genomic Specifics
- **Coverage**: `wiggletools coverage input.bed` calculates the number of overlapping intervals.
- **Region Extraction**: `wiggletools seek <chrom> <start> <finish> <input>` restricts analysis to a specific genomic window.

### Streaming Data
You can pipe data into WiggleTools using the `-` symbol for standard input (assumes Wig or BedGraph format):
```bash
cat data.wig | wiggletools scale 10 -
```
For SAM format specifically:
```bash
samtools view input.bam | wiggletools sam -
```

## Best Practices and Tips

- **Lazy Evaluation**: WiggleTools only computes values as they are requested for output. This makes it extremely efficient for piping complex operations together.
- **File Extensions**: Ensure your files have standard extensions (e.g., `.bw` for BigWig) so the auto-detector functions correctly.
- **Indexing**: Always ensure `.bai` or `.tbi` index files are present in the same directory as your BAM, CRAM, or BCF files, or operations like `seek` will fail.
- **Boolean Masks**: Use operators like `gt` or `lt` to create masks. These can be combined with `apply` (if supported by the version) to perform operations only on specific genomic regions.
- **Memory Management**: While WiggleTools is memory efficient, processing hundreds of files simultaneously can still hit system file descriptor limits. Use `sum` or `mean` on groups of files if necessary.

## Reference documentation
- [WiggleTools Overview](./references/anaconda_org_channels_bioconda_packages_wiggletools_overview.md)
- [WiggleTools GitHub README](./references/github_com_Ensembl_WiggleTools.md)