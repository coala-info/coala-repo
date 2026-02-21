---
name: rust-mdbg
description: `rust-mdbg` is a specialized assembler that operates in "minimizer-space." By representing reads, assembly graphs, and the final assembly as ordered lists of minimizers rather than nucleotide strings, it achieves significant performance gains.
homepage: https://github.com/ekimb/rust-mdbg
---

# rust-mdbg

## Overview

`rust-mdbg` is a specialized assembler that operates in "minimizer-space." By representing reads, assembly graphs, and the final assembly as ordered lists of minimizers rather than nucleotide strings, it achieves significant performance gains. It can assemble a human genome in approximately 10 minutes using minimal RAM. While it offers high speed, it is generally less contiguous than state-of-the-art assemblers like hifiasm and requires high-accuracy reads (PacBio HiFi); it is not suitable for high-error Nanopore data.

## Core Workflow

The assembly process typically involves three stages: graph construction, simplification, and base-space conversion.

### 1. Input Preparation
`rust-mdbg` requires FASTA/FASTQ files that are formatted with single-line sequences and uppercase characters. If your reads do not meet this criteria, format them using `seqtk`:
```bash
seqtk seq -AU reads.unformatted.fq > reads.fa
```

### 2. Recommended Assembly (Multi-k)
For the best contiguity, use the multi-k iterative strategy. This automatically determines the largest $k$ and yields better results than a single-k run, though it takes roughly 7x longer.
```bash
utils/multik <reads.fq.gz> <output_prefix> <threads>
```

### 3. Standard Assembly (Single-k)
If you prefer manual control or maximum speed, run the components individually:

**Step A: Construct the minimizer-space graph**
```bash
rust-mdbg <reads.fa.gz> -k 21 --density 0.003 -l 14 --minabund 2 --prefix my_assembly
```

**Step B: Simplify and convert to base-space**
The `magic_simplify` script wraps `gfatools` and `to_basespace` to produce the final FASTA and GFA files.
```bash
utils/magic_simplify my_assembly
```

## Parameter Tuning

If not using the `multik` script, you must tune the three primary parameters:
- **k**: The k-min-mer value (recommended range: 20-40).
- **l**: Minimizer length (recommended range: 10-14).
- **d (density)**: Minimizer density (recommended range: 0.001-0.005).

**Expert Tip**: A successful strategy is to set $k$ and $d$ such that the ratio $k/d$ is slightly below the average read length.

## Common CLI Patterns

### Metagenome Assembly
For metagenomic data, use the specific metagenome simplification script which is less aggressive in pruning:
```bash
rust-mdbg <meta_reads.fa.gz> -k 21 -l 14 --density 0.003 --prefix meta_out
utils/magic_simplify_meta meta_out
```

### Manual Base-Space Conversion
If you need to convert a GFA to base-space without any graph simplification:
```bash
# Using gfatools (faster)
gfatools asm -u example.gfa > example.unitigs.gfa
to_basespace --gfa example.unitigs.gfa --sequences example

# Without gfatools
utils/complete_gfa.py example example.gfa
```

### Converting GFA to FASTA
To extract sequences from the final GFA:
```bash
bash utils/gfa2fasta.sh my_assembly.complete.gfa
```

## Limitations and Requirements
- **Coverage**: Requires at least 40x to 50x coverage for optimal results.
- **Accuracy**: Only supports high-accuracy reads (PacBio HiFi). Do not use for standard ONT reads.
- **Polishing**: No internal polishing is performed; the assembly accuracy will match the input read accuracy.

## Reference documentation
- [rust-mdbg GitHub Repository](./references/github_com_ekimb_rust-mdbg.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_rust-mdbg_overview.md)