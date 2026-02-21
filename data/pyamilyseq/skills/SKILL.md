---
name: pyamilyseq
description: PyamilySeq is a pangenome investigation suite designed to group gene sequences into families based on sequence similarity.
homepage: https://github.com/NickJD/PyamilySeq
---

# pyamilyseq

## Overview
PyamilySeq is a pangenome investigation suite designed to group gene sequences into families based on sequence similarity. It serves as a flexible alternative to tools like Roary or Panaroo, offering unique capabilities such as "Genus Mode" for cross-taxa analysis and a "Reclustering" workflow that allows users to add novel sequences to an established pangenome without losing the original clustering context. The tool produces standardized outputs, including gene presence-absence CSVs and concatenated alignments for phylogenomic tree construction.

## Core Workflows

### 1. Full Mode (End-to-End)
Use this mode when starting from raw annotation files (GFF + FASTA). PyamilySeq will handle the clustering via CD-HIT and process the results automatically.

```bash
PyamilySeq Full -output_dir ./results \
    -input_type combined \
    -input_dir ./genomes/ \
    -name_split_gff _combined.gff3 \
    -seq_type AA
```

### 2. Partial Mode (External Clustering)
Use this mode if you have already performed clustering using MMseqs2, BLAST, or DIAMOND. It converts external node-edge lists or cluster files into pangenome reports.

```bash
PyamilySeq Partial -clustering_format CD-HIT \
    -cluster_file ./all_sequences.clstr \
    -original_fasta ./all_sequences.fasta \
    -output_dir ./partial_results \
    -write_groups 99 \
    -align
```

### 3. Reclustering Workflow
Use this to identify how new gene predictions (e.g., from StORF-Reporter) impact an existing pangenome. This identifies "extended" groups (original groups with new members) and "second-only" groups (entirely new families).

```bash
PyamilySeq Partial -clustering_format CD-HIT \
    -cluster_file ./original_pangenome.clstr \
    -reclustered ./updated_pangenome.clstr \
    -original_fasta ./combined_sequences.fasta \
    -output_dir ./reclustered_output \
    -write_groups 95
```

## Key CLI Parameters

| Parameter | Description |
| :--- | :--- |
| `-input_type` | Format of input: `separate` (GFF and FASTA separate), `combined` (GFF with FASTA at end), or `fasta`. |
| `-group_mode` | `Species` (default) or `Genus` (identifies groups found across multiple genera). |
| `-write_groups` | Percentage threshold for defining "core" groups (e.g., `99` for 99% of genomes). |
| `-align` | Triggers MAFFT alignment of representative sequences for core groups. |
| `-align_aa` | Performs alignment on amino acid sequences even if input is DNA. |
| `-c` | Sequence identity threshold for CD-HIT (default 0.9). |

## Expert Tips & Best Practices

*   **Performance Boost**: Ensure the `levenshtein` Python library is installed. PyamilySeq will fall back to a native Python implementation if missing, which is significantly slower for large datasets.
*   **Input Formatting**: When using external clustering formats (MMseqs2/BLAST), ensure the sequence IDs follow the `GenomeName|SequenceName` convention.
*   **Paralog Management**: Use the `Group-Splitter` auxiliary tool to handle multi-copy gene groups that may need to be split into distinct orthologous families.
*   **Genus Mode**: Unlike traditional pangenome tools, setting `-group_mode Genus` allows you to identify unique gene entities that are conserved across different genera, which is useful for higher-level taxonomic studies.
*   **Memory Management**: For large-scale clustering in `Full` mode, use the `-M` flag to specify memory limits (in MB) and `-T` for thread count to optimize CD-HIT performance.

## Reference documentation
- [PyamilySeq GitHub Repository](./references/github_com_NickJD_PyamilySeq.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_pyamilyseq_overview.md)
- [Version 0.9.0 Release Notes (Feature Details)](./references/github_com_NickJD_PyamilySeq_tags.md)