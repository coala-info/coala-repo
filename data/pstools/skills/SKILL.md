---
name: pstools
description: pstools produces base-level resolution haplotypes from genomic assembly graphs by integrating Hi-Fi long reads and Hi-C proximity ligation data. Use when user asks to map Hi-C reads to assembly graphs, resolve assembly graphs into phased haplotypes, or calculate assembly quality metrics like QV and switch error rates.
homepage: https://github.com/shilpagarg/pstools
---


# pstools

## Overview
`pstools` is a specialized bioinformatics suite designed to produce base-level resolution haplotypes from genomic assembly graphs. It primarily bridges the gap between high-fidelity long reads (HiFi) and proximity ligation data (Hi-C). By utilizing a graph-based algorithm, it resolves ambiguities in assembly graphs (like those produced by hifiasm) to output two distinct phased haplotype sets. It is optimized for speed and accuracy, capable of processing human-scale genomes in under 12 hours with high sequence continuity (NG50 > 130 Mb).

## Core Workflow

### 1. Data Preparation
Before using `pstools`, you must have an assembly graph (GFA) and corresponding Hi-C reads. You must first extract the node sequences from your GFA file into a FASTA format.

```bash
# Extract sequences from a hifiasm unitig graph
awk '/^S/{print ">"$2;print $3}' hifiasm_r_utg.gfa > hifiasm_r_utg.fa
```

### 2. Hi-C Mapping
The `hic_mapping` command aligns Hi-C paired-end reads to the extracted unitig sequences.

```bash
pstools hic_mapping -t <threads> -o <map.out> <unitigs.fa> <hic_R1.fastq.gz> <hic_R2.fastq.gz>
```
*   **-t**: Number of threads (e.g., 32).
*   **-o**: Output file for the mapping results.

### 3. Haplotype Resolution
The `resolve_haplotypes` command uses the mapping data and the original GFA structure to produce the final phased sequences.

```bash
pstools resolve_haplotypes -t <threads> -i true <map.out> <hifiasm_r_utg.gfa> <output_dir>
```
*   **-i true**: Enables specific graph integration logic.
*   **Output**: This generates `pred_hap1.fa` and `pred_hap2.fa` in the specified output directory.

## Command Reference and Utilities

| Command | Purpose |
| :--- | :--- |
| `hic_mapping` | Maps Hi-C reads to assembly graph nodes. |
| `resolve_haplotypes` | Resolves the assembly graph into two phased haplotypes. |
| `hic_qv` | Calculates the Quality Value (QV) of the assembly using Hi-C data. |
| `hic_completeness` | Evaluates the completeness of the phased sequences. |
| `hic_switch_error` | Measures switch and Hamming error rates in the haplotypes. |

## Expert Tips and Best Practices
*   **Graph Input**: Ensure you use the `r_utg` (raw unitig) graph from hifiasm for the best resolution, as processed graphs may have collapsed variations that `pstools` needs to see.
*   **Performance**: For a standard human genome (~3Gb), allocating 32-48 threads typically results in a 5-hour runtime for the mapping phase.
*   **Memory**: Ensure your system has sufficient RAM to hold the assembly graph and the k-mer hash tables used during mapping.
*   **Limitations**: Be aware that current versions of `pstools` may not fully resolve centromeric regions and do not currently incorporate Ultra-Long (UL) Nanopore data.



## Subcommands

| Command | Description |
|---------|-------------|
| completeness | Calculate completeness using Hi-C data and a sequence file |
| haplotype_scaffold | Haplotype scaffolding tool using connection files and predicted haplotypes |
| hic_mapping_haplo | Map Hi-C reads to predicted haplotypes |
| hic_mapping_unitig | Map Hi-C reads to unitig graphs |
| phasing_error | Calculate phasing errors using haplotype assemblies and Hi-C data |
| qv | Calculate QV (Quality Value) using Hi-C data and a sequence file |
| resolve_haplotypes | Resolve haplotypes using Hi-C mapping and GFA files |

## Reference documentation
- [github_com_shilpagarg_pstools_blob_main_README.md](./references/github_com_shilpagarg_pstools_blob_main_README.md)
- [github_com_shilpagarg_pstools_blob_main_Makefile.md](./references/github_com_shilpagarg_pstools_blob_main_Makefile.md)