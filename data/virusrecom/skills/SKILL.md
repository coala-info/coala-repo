---
name: virusrecom
description: virusrecom detects recombination within viral lineages using information theory. Use when user asks to validate potential recombinants, find specific recombination breakpoints, or perform a systematic scan for recombination.
homepage: https://github.com/ZhijianZhou01/virusrecom
metadata:
  docker_image: "quay.io/biocontainers/virusrecom:1.4.0--pyhdfd78af_0"
---

# virusrecom

## Overview
virusrecom is a bioinformatics tool that utilizes information theory to detect recombination within viral lineages. By calculating Weighted Information Content (WIC) and Expected Information Content (EIC), it identifies genomic regions where a query lineage deviates from its expected parental patterns. This skill should be used when you need to validate potential recombinants, find specific recombination breakpoints, or perform a systematic scan of a viral dataset to find any evidence of lineage crossing.

## Installation
The tool can be installed via pip or conda:

```bash
# Pip installation
pip install virusrecom

# Conda installation
conda install -c bioconda virusrecom
```

## Core Usage Patterns

### Analyzing Aligned Sequences
If your sequences are already aligned (MSA), use the `-a` flag. Ensure sequence headers contain lineage identifiers or provide a mapping file.

```bash
virusrecom -a alignment.fasta -q query_lineage_name -o output_directory
```

### Analyzing Unaligned Sequences
For raw sequences, virusrecom can call an external alignment tool (e.g., MAFFT) using the `-ua` and `-at` flags.

```bash
virusrecom -ua sequences.fasta -at mafft -q query_lineage_name -o output_directory
```

### Automated Recombination Scanning
To scan every lineage in a file as a potential recombinant against all others:

```bash
virusrecom -a alignment.fasta -q auto -o scan_results
```

## Parameter Optimization & Best Practices

### Site Selection Methods (`-m`)
*   **Polymorphic Sites (`-m p`)**: Recommended for most viral datasets. It focuses only on sites that vary, which reduces noise and speeds up calculation.
*   **All Sites (`-m a`)**: Use this if the mutation rate is extremely low and every nucleotide counts toward the information theory calculation.

### Sliding Window Configuration
The window (`-w`) and step (`-s`) sizes determine the resolution of the detection.
*   If using `-m p`, these values refer to the **number of polymorphic sites**, not nucleotides.
*   For high-resolution breakpoint detection, decrease the step size.

### Breakpoint Analysis
To enable specific breakpoint scanning (only available with `-m p`):

```bash
virusrecom -a alignment.fasta -q query_name -m p -b y -bw 200
```
*   `-b y`: Enables the breakpoint scan.
*   `-bw`: Sets the window size for the breakpoint search (default is 200).

### Handling Gaps
*   Use `-g n` (default) to delete sites containing gaps. This is generally safer for recombination analysis to avoid alignment artifacts being interpreted as recombination signals.
*   Use `-g y` only if gaps are phylogenetically informative in your specific viral group.

### Performance Tuning
*   **Threading**: Use `-t` to specify CPU cores (default is 4).
*   **Memory Management**: For very large alignments, use `--block` to specify the maximum number of sites loaded into memory at once (default 40,000).

## Input Requirements
1.  **Lineage Marks**: Each sequence name in the FASTA file must contain a lineage identifier (e.g., `>LineageA_Sequence01`).
2.  **Mapping Table**: Alternatively, provide a CSV/TSV mapping file using `-map` to link specific sequence IDs to their respective lineages.

## Reference documentation
- [VirusRecom GitHub Repository](./references/github_com_ZhijianZhou01_virusrecom.md)
- [Bioconda virusrecom Package](./references/anaconda_org_channels_bioconda_packages_virusrecom_overview.md)