---
name: cenote-taker3
description: Cenote-Taker 3 is a bioinformatics pipeline for the high-throughput discovery and functional annotation of viral sequences in metagenomic data. Use when user asks to discover novel viruses, annotate viromes, find prophages in microbial genomes, or generate GenBank-ready files and genome maps.
homepage: https://github.com/mtisza1/Cenote-Taker3
---


# cenote-taker3

## Overview

Cenote-Taker 3 (CT3) is a specialized bioinformatics pipeline designed for the high-throughput discovery and functional annotation of the virome. It scales from single sequences to massive metagenomic assemblies, identifying virus hallmark genes and providing hierarchical taxonomy assignments. Use this skill to navigate the installation of required databases, execute discovery workflows for novel viruses, find prophages within microbial genomes, and generate interactive genome maps (.gbf) or GenBank-ready files.

## Environment and Database Setup

Before running discovery, the environment must be configured and databases must be localized.

### 1. Installation
Install via Mamba for the most reliable dependency resolution:
```bash
mamba create -n ct3_env -c conda-forge -c bioconda cenote-taker3
conda activate ct3_env
```

### 2. Database Initialization
CT3 requires several gigabytes of HMM and taxonomy databases. Use the `get_ct3_dbs` utility:
```bash
# Basic database setup (~3.0 GB)
get_ct3_dbs -o /path/to/ct3_DBs --hmm T --hallmark_tax T --refseq_tax T --mmseqs_cdd T --domain_list T

# Optional: Add HHsuite databases for deeper annotation (CDD, Pfam, PDB70)
get_ct3_dbs -o /path/to/ct3_DBs --hmm T --hhCDD T --hhPFAM T --hhPDB T
```

### 3. Configuration
Set the `CENOTE_DBS` environment variable to avoid specifying the database path in every command:
```bash
conda env config vars set CENOTE_DBS=/path/to/ct3_DBs
# Reactivate environment to apply
conda activate ct3_env
```

## Common CLI Patterns

### Virus Discovery and Annotation
The default mode for metagenomic contigs where you want to find and annotate viral sequences:
```bash
cenotetaker3 -c contigs.fasta -r my_run_title -p T
```

### Prophage Discovery in Microbial Genomes
When searching for proviruses within bacterial or archaeal genomes, increase the hallmark gene stringency:
```bash
cenotetaker3 -c genome.fna -r prophage_search -p T --lin_minimum_hallmark_genes 2
```

### Annotation Only
If you already have a set of confirmed viral sequences and only need functional annotation:
```bash
cenotetaker3 -c virus_contigs.fna -r annotation_run -p F -am T
```

### Custom Hallmark Selection
Limit the search to specific viral categories by defining hallmark gene sets:
```bash
# Options include: virion, rdrp, dnarep, etc.
cenotetaker3 -c input.fna -r custom_search -p T -db virion rdrp
```

## Output Interpretation

CT3 generates a structured output directory. Key files include:
- `{run_title}_virus_summary.tsv`: The primary summary of all identified viruses.
- `{run_title}_virus_sequences.fna`: FASTA file containing the nucleotide sequences of identified viruses.
- `final_genes_to_contigs_annotation_summary.tsv`: Detailed functional info for every gene.
- `sequin_and_genome_maps/`: Contains `.gbf` files for visualization in tools like Artemis or Benchling.

## Expert Tips

- **ORF Calling**: CT3 uses `prodigal-gv` by default, which is optimized for viral gene prediction. Only force standard `prodigal` using `--caller prodigal` if you have a specific reason to avoid the virus-optimized version.
- **Performance**: CT3 is significantly faster than CT2. For very large datasets, ensure you are using the `pyhmmer` integration (default in recent versions) which utilizes multi-core processing efficiently.
- **Circular Contigs**: If you have pre-identified circular contigs from long-read assemblies, use the `--circ-files` option to improve terminal repeat detection and pruning accuracy.
- **Read Coverage**: To include abundance data in your summaries, provide your raw reads using the `--reads` flag (supports fastq/fastq.gz).

## Reference documentation
- [Cenote-Taker3 GitHub Repository](./references/github_com_mtisza1_Cenote-Taker3.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_cenote-taker3_overview.md)