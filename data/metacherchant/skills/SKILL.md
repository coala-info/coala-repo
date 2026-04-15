---
name: metacherchant
description: MetaCherchant extracts and visualizes the local genomic neighborhood of a target sequence directly from raw metagenomic reads using a targeted de Bruijn graph search. Use when user asks to reconstruct the genetic context of a gene, compare genomic environments across multiple samples, or link plasmids to hosts using Hi-C data.
homepage: https://github.com/ctlab/metacherchant
metadata:
  docker_image: "quay.io/biocontainers/metacherchant:0.1.0--1"
---

# metacherchant

## Overview
MetaCherchant is a specialized tool designed to extract and visualize the local genomic neighborhood of a target sequence directly from raw metagenomic reads. By performing a targeted breadth-first search in a de Bruijn graph starting from a "seed" sequence, it avoids the computational cost of a full metagenome assembly. This approach is highly effective for characterizing the genetic context of mobile genetic elements, identifying horizontal gene transfer events, and associating plasmids with their bacterial hosts using Hi-C proximity ligation data.

## Core Workflows

### Single Metagenome Analysis
Use the `environment-finder` tool to reconstruct the neighborhood of a target gene within a single sample.

```bash
./metacherchant.sh --tool environment-finder \
    --k 31 \
    --coverage 5 \
    --reads /path/to/reads/*.fastq \
    --seq target_gene.fasta \
    --output ./results/ \
    --work-dir ./work/ \
    --maxkmers 100000 \
    --chunklength 100
```

### Differential (Multi-Metagenome) Analysis
Use `environment-finder-multi` to compare the genomic context of the same gene across different time points or conditions. This merges individual `env.txt` results into a single comparative graph.

```bash
./metacherchant.sh --tool environment-finder-multi \
    --seq target_gene.fasta \
    --work-dir ./multi_work/ \
    --output ./multi_results/ \
    --env sample1/env.txt sample2/env.txt
```

### Hi-C Environment Extraction
To link extrachromosomal DNA (like plasmids) to host chromosomes, use the Hi-C pipeline. This requires `bwa` and `samtools` in the environment.

```bash
./HiCEnvironmentFinder.sh \
    --reads "wgs_reads/*.fastq" \
    --seq target_seq.fasta \
    --hi-c-r1 hic_R1.fastq \
    --hi-c-r2 hic_R2.fastq \
    --work-dir ./hic_work/ \
    --metacherchant ./metacherchant.jar \
    --k 31 \
    --coverage 5
```

## Parameter Optimization
- **K-mer Size (`--k`)**: Default is 31. Larger k-mers increase specificity but require higher coverage; smaller k-mers help resolve low-abundance environments but increase graph complexity.
- **Coverage Threshold (`--coverage`)**: Filters out low-frequency k-mers (likely sequencing errors). Increase this for high-depth datasets to simplify the resulting graph.
- **Graph Size (`--maxkmers`)**: Prevents the search from expanding indefinitely into highly complex or repetitive regions.
- **Search Direction (`--bothdirs`)**: Set to `True` for a single bidirectional pass from the target sequence, or `False` (default) for two separate one-directional passes.

## Interpreting Outputs
- **graph.gfa**: The primary output for visualization. Use **Bandage** (v0.8.0+) to view the de Bruijn graph.
- **seqs.fasta**: Contains unitigs (non-branching sequences) extracted from the graph, suitable for downstream annotation or BLAST searches.
- **hic_map.txt**: (Hi-C mode only) A mapping file for Bandage to visualize Hi-C links as crosslinks between contigs.
- **tsvs/**: Graph descriptions formatted for Cytoscape if advanced network analysis is required.

## Expert Tips
- **Target Selection**: Ensure the `--seq` file contains a specific sequence. If the sequence is too common (e.g., a highly conserved 16S region), the graph will become massive and difficult to interpret.
- **Memory Management**: For large metagenomes, ensure the Java heap size is sufficient by passing JVM arguments if running the JAR directly: `java -Xmx16G -jar metacherchant.jar`.
- **Visualization**: In Bandage, use the 'Find Nodes' feature and search for the suffix `_start` to locate the nodes corresponding to your target sequence.

## Reference documentation
- [MetaCherchant GitHub README](./references/github_com_ctlab_metacherchant.md)
- [Detailed Hi-C Environment Finder Guide](./references/github_com_ctlab_metacherchant_wiki.md)