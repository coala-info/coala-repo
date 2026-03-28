---
name: pyamilyseq
description: PyamilySeq organizes gene sequences into pangenomic families based on sequence identity using either internal clustering or external bioinformatic results. Use when user asks to perform end-to-end pangenome analysis, process external clustering outputs, or extend an existing pangenome with new sequences.
homepage: https://github.com/NickJD/PyamilySeq
---


# pyamilyseq

## Overview

PyamilySeq is a specialized pangenomics utility designed to organize gene sequences into families or groups based on sequence identity. It serves as a bridge between raw clustering outputs and comparative genomic analysis. Its primary strength lies in its flexibility: it can handle end-to-end workflows starting from GFF/FASTA files or process pre-computed clusters from external bioinformatic tools. It also features a unique "Genus Mode" for identifying gene groups across broader taxonomic ranks and supports "Reclustering" to maintain pangenome continuity when adding novel gene predictions to an existing dataset.

## Core Workflows

### 1. Full Mode (End-to-End)
Use this mode when you have raw genome annotations and want PyamilySeq to handle the clustering (via CD-HIT) and downstream processing automatically.

```bash
PyamilySeq Full \
  -input_type combined \
  -input_dir ./genomes/ \
  -output_dir ./pangenome_results/ \
  -name_split_gff _combined.gff3 \
  -seq_type AA \
  -threads 8
```

### 2. Partial Mode (External Clusters)
Use this mode if you have already performed clustering using BLAST, DIAMOND, or MMseqs2. 

**Note on Input Format**: For non-CD-HIT formats, the input must be a two-column TSV/CSV where sequence IDs follow the format `GenomeName|SequenceID`.

```bash
PyamilySeq Partial \
  -clustering_format CD-HIT \
  -cluster_file ./results.clstr \
  -original_fasta ./all_sequences.fasta \
  -output_dir ./processed_clusters/ \
  -write_groups 99 \
  -align
```

### 3. Reclustering (Pangenome Extension)
Use this to see how new sequences (e.g., from a new annotation tool like StORF-Reporter) relate to an existing pangenome without losing the original group identities.

```bash
PyamilySeq Partial \
  -cluster_file ./original_pangenome.clstr \
  -reclustered ./new_combined_clustering.clstr \
  -original_fasta ./combined_all.fasta \
  -output_dir ./updated_pangenome/ \
  -write_groups 95
```

## Command Line Best Practices

### Input Management
- **Genome Naming**: Ensure your input files use consistent naming conventions. Use `-name_split_gff` and `-name_split_fasta` to tell the tool how to extract the "Genome Name" from the filename.
- **Sequence Types**: Explicitly set `-seq_type AA` for proteins or `-seq_type DNA` for nucleotides. Protein clustering is generally more sensitive for distant homologs.

### Performance Tuning
- **Memory**: Use `-M [MB]` to limit memory usage for CD-HIT during Full mode.
- **Parallelization**: Use `-T [threads]` to speed up clustering and alignment phases.
- **Levenshtein**: Ensure the `levenshtein` Python library is installed in the environment; otherwise, the tool falls back to a much slower pure-Python implementation.

### Output Customization
- **Presence-Absence**: The tool automatically generates a `gene_presence_absence.csv` compatible with Roary/Panaroo downstream tools.
- **Alignments**: Use `-align` to trigger MAFFT alignments of representative sequences. Use `-align_aa` if you want to align protein sequences specifically.
- **Group Splitting**: If a gene group contains multiple copies from the same genome (paralogs), use the `group-splitter` auxiliary tool to resolve them.

## Auxiliary Tools
PyamilySeq installs several helper scripts for specific data manipulation tasks:
- `seq-combiner`: Merges multiple FASTA files while prepending genome names.
- `group-extractor`: Pulls specific gene group sequences for further study.
- `group-summary`: Provides statistical overviews of the identified gene families.
- `seq-finder`: Locates specific sequences within the clustered groups.



## Subcommands

| Command | Description |
|---------|-------------|
| pyamilyseq | A tool for gene clustering and pangenome analysis. |
| pyamilyseq | A tool for gene clustering and pangenome analysis. |

## Reference documentation
- [PyamilySeq README](./references/github_com_NickJD_PyamilySeq_blob_main_README.md)
- [Project Configuration](./references/github_com_NickJD_PyamilySeq_blob_main_pyproject.toml.md)