---
name: megagta
description: MegaGTA is a specialized metagenomic assembler designed to reconstruct specific genes of interest rather than the entire metagenome.
homepage: https://github.com/HKU-BAL/MegaGTA
---

# megagta

## Overview

MegaGTA is a specialized metagenomic assembler designed to reconstruct specific genes of interest rather than the entire metagenome. It utilizes Hidden Markov Models (HMMs) to guide the assembly process through iterative de Bruijn graphs. This approach is particularly effective for recovering full-length sequences of functional marker genes, even at low abundance, by focusing computational resources on sequences that match the profile of the target gene families.

## Core Workflows

### 1. Assembly Execution
The primary assembly is performed using the `megagta.py` script. It requires a set of reads and a configuration file defining the target genes.

```bash
bin/megagta.py -r reads.fq -g gene_list.txt -o output_dir
```

**Key Arguments:**
- `-r`: Input metagenomic reads in FASTQ format.
- `-g`: Path to the gene configuration list.
- `-o`: Output directory for assembly results.

### 2. Post-Processing and Clustering
After assembly, use the post-processing script to filter results, remove chimeras, and cluster sequences to reduce redundancy.

```bash
bin/post_proc.sh -g gene_resources_dir -d output_dir/contigs -m 16G -c 0.01
```

**Key Arguments:**
- `-g`: The directory containing gene resources (HMMs and alignments).
- `-d`: The directory containing the raw contigs from the assembly step.
- `-m`: Memory limit (e.g., 16G).
- `-c`: Clustering similarity threshold (expressed as distance; e.g., 0.01 results in 99% similarity clusters).

## Configuration and Setup

### Gene List Format (`gene_list.txt`)
The gene list is a tab-delimited or space-delimited file where each line defines a target gene family. You must provide paths to the forward HMM, reverse HMM, and a reference multiple sequence alignment (MSA).

**Format:**
`[gene_name] [path_to_forward_hmm] [path_to_reverse_hmm] [path_to_ref_alignment]`

**Example:**
```text
rplB share/RDPTools/Xander_assembler/gene_resource/rplB/for_enone.hmm share/RDPTools/Xander_assembler/gene_resource/rplB/rev_enone.hmm share/RDPTools/Xander_assembler/gene_resource/rplB/ref_aligned.faa
```

### Resource Management
- **Gene Resources**: MegaGTA is compatible with the resource format used by the Xander assembler. Default resources are typically located in `share/RDPTools/Xander_assembler/gene_resource`.
- **Tool Paths**: Before running `post_proc.sh`, ensure the paths to `HMMER` and `UCHIME` are correctly configured within the script itself.

## Expert Tips and Best Practices

- **Iterative Graphs**: MegaGTA uses iterative de Bruijn graphs to navigate complex regions. If assembly is fragmented, verify that your HMMs are sensitive enough to capture the diversity of the gene in your specific environment.
- **Memory Allocation**: The post-processing step can be memory-intensive depending on the number of recovered contigs. Always specify the `-m` flag based on available system resources.
- **Custom Genes**: To target genes not included in the default RDPTools set, you must prepare HMMs and a reference alignment following the Xander resource format.
- **Chimera Detection**: The post-processing pipeline includes UCHIME. Ensure UCHIME is in your PATH or explicitly defined in the shell script to avoid silent failures during the cleaning phase.

## Reference documentation
- [MegaGTA Main README](./references/github_com_HKU-BAL_MegaGTA.md)