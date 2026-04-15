---
name: metaeuk
description: MetaEuk is a toolkit designed to identify and annotate eukaryotic genes in metagenomic contigs using protein homology and dynamic programming. Use when user asks to predict eukaryotic genes, perform exon-based gene discovery, assign taxonomy to metagenomic sequences, or reduce redundancy in gene predictions.
homepage: https://github.com/soedinglab/metaeuk
metadata:
  docker_image: "quay.io/biocontainers/metaeuk:7.bba0d80--pl5321hd6d6fdc_2"
---

# metaeuk

## Overview

MetaEuk is a specialized toolkit designed to identify eukaryotic genes within metagenomic contigs. Unlike prokaryotic gene finders, MetaEuk is optimized for the complex structure of eukaryotic genes, using a dynamic programming approach to recover optimal exon sets based on protein homology. It integrates the speed of MMseqs2 for initial searches and provides workflows to reduce redundancy among multiple discoveries of the same gene and resolve overlapping predictions on the same strand.

## Core Workflows

### The easy-predict Workflow
The most common entry point for users with FASTA files. It performs the search, exon prediction, and redundancy reduction in a single command.

```bash
metaeuk easy-predict <contigs.fasta> <proteins.fasta> <out_prefix> <tmp_dir>
```

**Key Outputs:**
- `<out_prefix>.codon.fas`: Nucleotide sequences of predicted genes.
- `<out_prefix>.pep.fas`: Protein sequences of predicted genes.
- `<out_prefix>.gff`: Gene coordinates and metadata.

### Taxonomic Assignment
Assign taxonomy to predicted genes using the `taxtocontig` module.

```bash
metaeuk taxtocontig <input_db> <output_db> <taxonomy_db> [options]
```

## Expert CLI Patterns and Parameters

### Sensitivity and Search Control
MetaEuk inherits many parameters from MMseqs2. Adjusting these is critical for balancing speed and sensitivity.

- **Sensitivity (`-s`)**: Default is 5.7. Increase (e.g., `-s 7.0`) for remote homologs or decrease for faster runs on closely related references.
- **E-value (`-e`)**: Maximum e-value threshold for hits (default: 10).
- **Threads (`--threads`)**: MetaEuk is highly parallelized; always specify the number of available cores.

### Exon and Gene Calling Logic
- **`--min-exon-aa`**: Minimum length of an exon in amino acids (default: 20).
- **`--max-intron`**: Maximum allowed intron length (default: 10000).
- **`--min-ungapped-score`**: Minimum score for a hit to be considered (default: 15).

### Redundancy Reduction
If running modules manually instead of using `easy-predict`, use `reduceredundancy` to handle overlapping gene calls.

```bash
metaeuk reduceredundancy <input_db> <output_db> [options]
```

## Best Practices

1. **Reference Selection**: Use high-quality, comprehensive protein databases like UniProt or specialized eukaryotic databases (e.g., Marine Eukaryotic Reference Catalog) for better annotation.
2. **Memory Management**: For very large datasets, ensure the `<tmp_dir>` is on a fast disk (SSD) with sufficient space, as MMseqs2-based searches generate large intermediate files.
3. **Contig Filtering**: Pre-filter very short contigs (e.g., <500bp) to reduce noise and computational overhead, as short fragments rarely contain enough information for confident eukaryotic gene calls.
4. **Hardware Check**: Ensure the system supports at least SSE4.1 instructions; otherwise, the binaries will fail to execute.



## Subcommands

| Command | Description |
|---------|-------------|
| metaeuk easy-predict | Combines the following MetaEuk modules into a single step: predictexons, reduceredundancy and unitesetstofasta |
| metaeuk groupstoacc | Replace the internal contig, target and strand identifiers with accessions from the headers |
| metaeuk reduceredundancy | By Eli Levy Karin <eli.levy.karin@gmail.com> |
| metaeuk taxtocontig | By Eli Levy Karin <eli.levy.karin@gmail.com> |
| metaeuk_predictexons | By Eli Levy Karin <eli.levy.karin@gmail.com> |
| metaeuk_unitesetstofasta | By Eli Levy Karin <eli.levy.karin@gmail.com> |

## Reference documentation
- [MetaEuk GitHub Repository](./references/github_com_soedinglab_metaeuk.md)
- [MetaEuk README](./references/github_com_soedinglab_metaeuk_blob_master_README.md)