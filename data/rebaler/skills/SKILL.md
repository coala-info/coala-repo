---
name: rebaler
description: Rebaler performs reference-guided bacterial genome assembly by using long reads to generate a high-quality consensus sequence. Use when user asks to assemble bacterial genomes using a reference structure, create unpolished assemblies from long-read fragments, or rotate circular contigs for junction polishing.
homepage: https://github.com/rrwick/Rebaler
metadata:
  docker_image: "quay.io/biocontainers/rebaler:0.2.0--py_0"
---

# rebaler

## Overview

Rebaler is a specialized tool designed for bacterial genome assembly that leverages a reference sequence to guide the large-scale structure of long-read data. It functions by aligning reads to a reference using `minimap2`, creating an unpolished assembly from read fragments, and then performing multiple rounds of `Racon` polishing to generate a high-quality consensus. 

A key advantage of Rebaler is that it prevents the reference assembly's basecalls from influencing the final output; the reference only provides the structural "map," while the reads provide the actual sequence. It is particularly effective for bacterial genomes due to its built-in support for circular contigs.

## Installation

Rebaler requires Python 3.4+, Biopython, and must have `minimap2` and `racon` (v1.0+) available in the system PATH.

**Via Conda:**
```bash
conda install bioconda::rebaler
```

**Via Pip (from GitHub):**
```bash
pip3 install git+https://github.com/rrwick/Rebaler.git
```

## Basic Usage

The standard workflow takes a reference FASTA and long-read FASTQ/FASTA files, streaming the final assembly to stdout.

```bash
rebaler reference.fasta reads.fastq.gz > assembly.fasta
```

### Common Options
- `-t, --threads`: Set the number of threads for alignment and polishing (default is 8).
- `--keep`: Retain the temporary directory containing intermediate files (useful for debugging).

## Expert Tips and Best Practices

### Handling Circular Bacterial Genomes
For bacterial chromosomes or plasmids, Rebaler can "rotate" contigs between polishing rounds to ensure the sequence is polished across the start/end junction. To enable this, you must modify the reference FASTA header to include `circular=true`.

**Example Header:**
`>chromosome_1 length=5138942 circular=true`

### When to Avoid Rebaler
- **Structural Variation:** Do not use Rebaler if you expect significant structural differences (inversions, large indels, translocations) between your reads and the reference. Rebaler assumes the structure is identical.
- **Self-Polishing:** If you are polishing an assembly using the same reads that created it, using `Racon` directly is generally more effective than using Rebaler.

### Post-Assembly Polishing
Rebaler produces a high-quality consensus based on basecalled reads. If you have raw signal-level data (Nanopore `.fast5` or PacBio `.bax.h5`), it is recommended to run a signal-level polisher like **Nanopolish** or **Arrow** after Rebaler to achieve maximum accuracy.

### Resource Management
Since Rebaler performs multiple rounds of Racon polishing, it can be CPU-intensive. Always scale the `-t` parameter to match your available hardware to significantly reduce runtime.

## Reference documentation
- [Rebaler GitHub Repository](./references/github_com_rrwick_Rebaler.md)
- [Bioconda Rebaler Overview](./references/anaconda_org_channels_bioconda_packages_rebaler_overview.md)