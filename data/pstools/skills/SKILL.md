---
name: pstools
description: pstools is a bioinformatics suite that reconstructs diploid genome haplotypes by integrating HiFi assembly graphs with Hi-C proximity data. Use when user asks to map Hi-C reads to node sequences, resolve haplotypes from assembly graphs, or perform diploid genome assembly.
homepage: https://github.com/shilpagarg/pstools
---


# pstools

## Overview

pstools is a specialized bioinformatics suite designed for diploid genome assembly. It bridges the gap between HiFi assembly graphs (specifically from hifiasm) and Hi-C proximity data to reconstruct complete haplotypes. By using a graph-based algorithm, it produces base-level resolution haplotypes with high continuity (NG50 > 130 Mb) and low switch error rates. It is optimized for speed, capable of processing human-sized genomes in under 12 hours.

## Installation and Setup

The tool can be installed via Bioconda or compiled from source:

```bash
# Bioconda installation
conda install bioconda::pstools

# Source installation
git clone https://github.com/shilpagarg/pstools.git
cd pstools && make
```

## Core Workflow

The standard workflow involves converting a hifiasm graph to FASTA format, mapping Hi-C reads, and then resolving the haplotypes.

### 1. Prepare Input Sequences
Extract node sequences from the hifiasm unitig graph (`.gfa`) into a FASTA file:
```bash
awk '/^S/{print ">"$2;print $3}' hifiasm_r_utg.gfa > hifiasm_r_utg.fa
```

### 2. Map Hi-C Reads
Use the `hic_mapping` command to align Hi-C R1 and R2 reads to the extracted node sequences.
```bash
pstools hic_mapping -t <threads> -o map.out hifiasm_r_utg.fa hic.R1.fastq.gz hic.R2.fastq.gz
```
*   **-t**: Number of threads (e.g., -t32).
*   **-o**: Output mapping file.

### 3. Resolve Haplotypes
Generate the final phased sequences using the mapping results and the original GFA graph.
```bash
pstools resolve_haplotypes -t <threads> -i true map.out hifiasm_r_utg.gfa <output_directory>
```
*   **-i true**: Enables specific resolution logic for haplotypes.
*   **Output**: This command generates `pred_hap1.fa` and `pred_hap2.fa` within the specified output directory.

## Expert Tips and Best Practices

*   **Graph Input**: Ensure you use the `r_utg` (raw unitig) graph from hifiasm for the best results in resolving haplotypes.
*   **Resource Allocation**: The mapping and resolution steps are computationally intensive; always utilize the `-t` flag to match your available CPU cores to significantly reduce processing time.
*   **Known Limitations**:
    *   **Centromeres**: Current versions of pstools do not typically contain centromeric regions in the final phased sequences.
    *   **Data Types**: The tool is specifically optimized for HiFi + Hi-C. It does not currently utilize Ultra-Long (UL) Nanopore data.
    *   **Trio Data**: While primarily used for non-trio assemblies, it can be tested on trio-hifiasm graphs, though results may vary.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_shilpagarg_pstools.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_pstools_overview.md)