---
name: haploflow
description: Haploflow is a strain-aware viral genome assembler that uses a flow algorithm on deBruijn graphs to resolve closely related haplotypes from short-read sequence data. Use when user asks to assemble viral genomes, resolve viral strains from mixed samples, or perform haplotype-aware assembly of Illumina reads.
homepage: https://github.com/hzi-bifo/Haploflow
metadata:
  docker_image: "quay.io/biocontainers/haploflow:1.0--h9948957_5"
---

# haploflow

## Overview

Haploflow is a strain-aware viral genome assembler designed for Illumina short-read sequence data. It distinguishes itself from general-purpose assemblers by using a flow algorithm on a deBruijn graph data structure to resolve closely related viral strains. It is best suited for researchers working with viral populations where multiple variants or haplotypes are present in a single sample, such as HIV or SARS-CoV-2 clinical samples.

## Installation

The recommended method for installation is via Bioconda:

```bash
conda install -c bioconda haploflow
```

## Core CLI Usage

The tool requires a FASTQ input and an output directory.

### Basic Assembly
```bash
haploflow --read-file input_reads.fastq --out output_directory --log assembly.log
```

### Key Parameters and Tuning

| Parameter | Default | Description |
| :--- | :--- | :--- |
| `--k` | 41 | k-mer size. Must be an odd number. Increase for longer reads or very high depth. |
| `--error-rate` | 0.02 | Percentage filter for erroneous k-mers. 0.02 (2%) is standard for Illumina. |
| `--strict` | 1 | Error correction strictness. Set to `5` for faster initial runs; set to `0` to preserve low-abundance strains. |
| `--filter` | 500 | Minimum contig length to report in the final output. |
| `--two-strain` | 0 | Set to `1` if the sample is known to be a mixture of exactly two strains. |
| `--debug` | 0 | Set to `1` to output temporary graphs (.dot) and coverage histograms. |

## Expert Tips and Best Practices

### Optimizing for Sensitivity vs. Speed
*   **For Rare Variants**: If you expect low-frequency strains, set `--strict 0`. This prevents the algorithm from aggressively pruning low-coverage paths that might represent real haplotypes.
*   **For Rapid Screening**: Use `--strict 5` on a new dataset. This significantly reduces runtime by applying more aggressive error correction, which is useful for verifying data quality before a deep assembly.

### Handling Complex Data
If the automated strictness settings fail to produce clean results, use the `--thresh` parameter to set a hard k-mer coverage floor. Note that `--thresh` is mutually exclusive with `--strict` and will override it.

### Working with Large Datasets
Haploflow allows you to save and reload the deBruijn graph to save time during parameter tuning:
1.  **Create Dump**: `haploflow --read-file reads.fq --out dir --create-dump 1 --dump-file graph.dump`
2.  **Run from Dump**: `haploflow --from-dump 1 --dump-file graph.dump --out dir_new --k 41`

### Interpreting Results
The output `contigs.fa` uses a specific header format:
`>Contig_[ID]_flow_[ABUNDANCE]_cc_[COMPONENT]`
*   **flow_[VALUE]**: This represents the estimated abundance of that specific strain.
*   **cc_[VALUE]**: Indicates which connected component in the graph the contig originated from.

## Reference documentation
- [Haploflow GitHub Repository](./references/github_com_hzi-bifo_Haploflow.md)
- [Haploflow Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_haploflow_overview.md)