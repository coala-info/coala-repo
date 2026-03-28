---
name: megagta
description: MegaGTA is a metagenomic gene-targeted assembler that uses Hidden Markov Models to reconstruct specific genes of interest from complex microbial communities. Use when user asks to perform targeted assembly of specific genes, reconstruct low-abundance sequences using HMMs, or process metagenomic reads for antibiotic resistance and metabolic markers.
homepage: https://github.com/HKU-BAL/MegaGTA
---

# megagta

## Overview

MegaGTA is a specialized metagenomic gene-targeted assembler that utilizes Hidden Markov Models (HMMs) to guide the construction of iterative de Bruijn graphs. Unlike general-purpose de novo assemblers, MegaGTA focuses computational resources on specific genes of interest (e.g., antibiotic resistance genes, metabolic markers, or phylogenetic anchors), allowing for more sensitive reconstruction of low-abundance sequences in complex microbial communities. It leverages gene resources compatible with the Xander assembler to define the target search space.

## Core Workflow

### 1. Preparation and Configuration
Before running the assembly, you must define your target genes in a `gene_list.txt` file. Each line specifies a gene and its associated HMM and alignment files.

**gene_list.txt format:**
`<gene_name> <forward_hmm> <reverse_hmm> <ref_alignment_faa>`

**Example:**
```text
rplB share/RDPTools/Xander_assembler/gene_resource/rplB/for_enone.hmm share/RDPTools/Xander_assembler/gene_resource/rplB/rev_enone.hmm share/RDPTools/Xander_assembler/gene_resource/rplB/ref_aligned.faa
```

### 2. Targeted Assembly
Run the primary assembly script using your sequencing reads and the configuration file.

```bash
bin/megagta.py -r reads.fq -g gene_list.txt -o output_dir
```

### 3. Post-Processing
After assembly, use the post-processing script to perform clustering and chimera checking (via UCHIME).

```bash
bin/post_proc.sh -g gene_resources_dir -d output_dir/contigs -m 16G -c 0.01
```
*   `-g`: Directory containing gene resources (formatted for Xander).
*   `-d`: The `contigs` subdirectory within your assembly output.
*   `-m`: Memory limit (e.g., 16G).
*   `-c`: Clustering similarity threshold (0.01 represents a 0.99 similarity threshold).

## Expert Tips and Best Practices

*   **Tool Path Configuration**: The `bin/post_proc.sh` script requires manual editing to point to your local installations of HMMER and UCHIME. Ensure these paths are updated before execution.
*   **Gene Resources**: MegaGTA is compatible with Xander assembler gene resources. If your gene of interest is not provided in the default `share/RDPTools/Xander_assembler/gene_resource` directory, you must follow Xander's preparation protocols to generate the required HMMs and alignments.
*   **Submodule Initialization**: If building from source, ensure submodules are initialized (`git submodule update --init --recursive`) to include the necessary RDPTools components.
*   **Memory Management**: During post-processing, ensure the `-m` flag matches your available system resources, as HMM-guided filtering and clustering can be memory-intensive for large datasets.



## Subcommands

| Command | Description |
|---------|-------------|
| buildlib | Build a library from read files. |
| denovo | no succinct de Bruijn graph name! |
| megagta_findstart | Find the start of the first exon in a gene. |
| readstat | Reads FASTQ files from standard input. |
| sdbg_builder read2sdbg | Builds a de Bruijn graph from sequencing reads. |
| search | Search for genes in a de Bruijn graph. |

## Reference documentation
- [MegaGTA README](./references/github_com_HKU-BAL_MegaGTA_blob_master_README.md)
- [Build Script (make.sh)](./references/github_com_HKU-BAL_MegaGTA_blob_master_make.sh.md)