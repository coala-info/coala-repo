---
name: getorganelle
description: GetOrganelle is a toolkit designed to assemble organelle genomes from Illumina sequencing data using a seed-and-extend algorithm. Use when user asks to assemble chloroplast genomes, plant or animal mitochondria, or nuclear ribosomal DNA from genomic reads.
homepage: http://github.com/Kinggerm/GetOrganelle
---


# getorganelle

## Overview

GetOrganelle is a versatile toolkit designed to accurately assemble organelle genomes from Illumina sequencing data. It works by using a "seed-and-extend" algorithm: it identifies target-related reads using a seed database, extends those reads into a larger pool, and then performs de novo assembly and graph disentanglement to produce circular or linear organelle genomes. It is particularly effective for plant plastomes (chloroplasts), plant mitochondria, and animal/fungal mitogenomes.

## Core Workflow

### 1. Database Initialization
Before first use, you must download the reference databases for your target organelle type.

```bash
# Initialize chloroplast and plant mitochondria databases
get_organelle_config.py --add embplant_pt,embplant_mt
```

**Supported Types (`-F`):**
- `embplant_pt`: Embryophyte plant plastome (chloroplast)
- `embplant_mt`: Embryophyte plant mitochondria
- `embplant_nr`: Embryophyte plant nuclear ribosomal DNA
- `animal_mt`: Animal mitochondria
- `fungus_mt`: Fungus mitochondria
- `other_pt`: Other plant plastomes

### 2. Assembly from Reads
The primary command for assembly is `get_organelle_from_reads.py`.

```bash
# Standard paired-end assembly
get_organelle_from_reads.py -1 forward.fq.gz -2 reverse.fq.gz -o output_dir -F embplant_pt -R 15 -t 4
```

**Key Parameters:**
- `-1`, `-2`: Forward and reverse fastq files (can be `.gz`).
- `-o`: Output directory.
- `-F`: Target organelle type (see list above).
- `-R`: Maximum extension rounds. Increase (e.g., 20-30) if the assembly is incomplete.
- `-k`: K-mer gradient for SPAdes (default: 21,45,65,85,105).
- `-w`: Word size for seed searching. Usually automatically estimated.

### 3. Using Custom Seeds
If the default seeds fail to recruit enough reads, provide a related species' genome as a seed.

```bash
get_organelle_from_reads.py -1 R1.fq -2 R2.fq -s related_genome.fasta -o output_dir -F embplant_pt
```

## Expert Tips & Troubleshooting

### Handling Non-Circular Results
If the assembly does not result in a circular genome (check `get_org.log.txt` or look for `*path_sequence.fasta` files):
- **Increase `-R`**: Allow more rounds of read recruitment.
- **Adjust K-mers**: If the graph is too complex, try adding a larger k-mer (e.g., `-k 21,45,65,85,105,121`).
- **Reduce Data**: If coverage is too high (causing assembly "noise"), use `--reduce-reads-for-coverage 100` to downsample.

### Assembly from Existing Graphs
If you have already run an assembly and want to re-disentangle the graph with different parameters without re-running the recruitment/SPAdes steps:

```bash
get_organelle_from_assembly.py -g assembly_graph.fastg -F embplant_pt -o new_disentanglement
```

### Memory Management
For large datasets (especially plant mitochondria), GetOrganelle can be memory-intensive.
- Use `-t` to limit threads.
- Ensure `psutil` is installed for better memory monitoring in logs.



## Subcommands

| Command | Description |
|---------|-------------|
| get_organelle_config.py | is used for setting up default GetOrganelle database. |
| get_organelle_from_assembly.py | isolates organelle genomes from assembly graph. |
| get_organelle_from_reads.py | GetOrganelle v1.7.7.1 get_organelle_from_reads.py assembles organelle genomes from genome skimming data. |

## Reference documentation
- [GetOrganelle Usage Guide](./references/github_com_Kinggerm_GetOrganelle_wiki_Usage.md)
- [Database Initialization](./references/github_com_Kinggerm_GetOrganelle_wiki_Initialization.md)
- [Frequently Asked Questions](./references/github_com_Kinggerm_GetOrganelle_wiki_FAQ.md)
- [Example 1: Plastome Assembly](./references/github_com_Kinggerm_GetOrganelle_wiki_Example-1.md)