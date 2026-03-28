---
name: pin_hic
description: Pin_hic is a genome assembly tool that uses Hi-C spatial information and a dual-selection strategy to organize contigs into scaffolds. Use when user asks to scaffold genomic contigs, build a scaffolding graph from Hi-C links, or detect mis-joins in an assembly.
homepage: https://github.com/dfguan/pin_hic/
---


# pin_hic

## Overview

Pin_hic is a specialized genome assembly tool that leverages the spatial information provided by Hi-C reads to organize contigs into larger scaffolds. It employs a dual-selection and local optimization strategy to determine the best orientation and order for genomic fragments. A unique feature of this tool is its use of the SAT format (an extension of GFA 1.0), which provides a transparent record of the scaffolding process and facilitates downstream genomic analysis.

## Core Workflows

### 1. Automated Scaffolding Pipeline
The most efficient way to use pin_hic is through the iterative wrapper script, which handles multiple rounds of scaffolding automatically.

```bash
# Required: Index the assembly and generate a .fai file first
samtools faidx draft_assembly.fa

# Run N iterations (default 3) of scaffolding
./bin/pin_hic_it -i 3 -x draft_assembly.fa.fai -r draft_assembly.fa -O output_dir alignment1.bam alignment2.bam
```

### 2. Step-by-Step Manual Scaffolding
For finer control or troubleshooting, execute the pipeline stages individually:

**Step A: Calculate Contact Matrix**
Generates the link density between contig pairs.
```bash
# From draft assembly
./bin/pin_hic link bam1.bam bam2.bam > links.matrix

# From an existing SAT file (to refine previous iterations)
./bin/pin_hic link -s previous.sat bam1.bam bam2.bam > links.matrix
```

**Step B: Build Scaffolding Graph**
Constructs the paths based on the matrix.
```bash
# -w: window size (default 100), -k: k-mer/link threshold (default 3)
./bin/pin_hic build -w 100 -k 3 -c draft_assembly.fa.fai links.matrix > scaffolds.sat
```

**Step C: Mis-join Detection and Sequence Extraction**
Breaks incorrect joins and outputs the final FASTA.
```bash
./bin/pin_hic break scaffolds.sat bam1.bam bam2.bam > final_scaffs.bk.sat
./bin/pin_hic gets -c draft_assembly.fa final_scaffs.bk.sat > scaffolds_final.fa
```

## Best Practices and Tips

- **Preprocessing**: Hi-C reads must be aligned to the draft assembly using `bwa mem` with the `-SP` and `-B10` flags to properly handle paired-end constraints.
- **Input Sorting**: Ensure BAM files are processed by `samtools` to be compatible with pin_hic's link counting.
- **SAT Format**: The output `.sat` files are human-readable and follow GFA 1.0 conventions. Use the `S` (Sequence), `L` (Link), and `P` (Path) tags to inspect how contigs were joined.
- **Iteration**: For complex genomes, 3 to 5 iterations are typically recommended to maximize scaffold N50 while minimizing mis-joins.
- **Memory/Performance**: The tool relies on `zlib`. Ensure your environment has sufficient memory for the contact matrix calculation if working with highly fragmented draft assemblies.



## Subcommands

| Command | Description |
|---------|-------------|
| build | Build scaffolding graph using Hi-C links matrix |
| gets | Extract sequences from a SAT file |
| link | Collect Hi-C links from BAM files |
| pin_hic | Identify breaks in a SAT file using Hi-C BAM files |
| pin_hic_it | A tool for Hi-C based scaffolding of genomic contigs. |

## Reference documentation
- [Pin_hic README and Usage Guide](./references/github_com_dfguan_pin_hic_blob_main_README.md)
- [SAT Format Specification](./references/github_com_dfguan_pin_hic.md)