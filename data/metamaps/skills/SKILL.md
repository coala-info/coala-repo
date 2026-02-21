---
name: metamaps
description: MetaMaps is a specialized bioinformatics tool designed for the analysis of long-read metagenomic datasets.
homepage: https://github.com/DiltheyLab/MetaMaps
---

# metamaps

## Overview
MetaMaps is a specialized bioinformatics tool designed for the analysis of long-read metagenomic datasets. It simultaneously performs read assignment and sample composition estimation, offering a balance between the speed of k-mer methods and the detail of exact alignment. It is particularly effective for strain-level resolution and provides rich output including approximate alignment locations, identity estimates, and mapping qualities.

## Core Workflow

The standard MetaMaps analysis consists of two primary steps: mapping and classification.

### 1. Mapping Reads
Use `mapDirectly` to align long reads against a reference database.

```bash
./metamaps mapDirectly --all -r databases/DB.fa -q input.fastq -o classification_results
```

### 2. Classification
Use `classify` to process the mapping results and generate taxonomic assignments.

```bash
./metamaps classify --mappings classification_results --DB databases/DB_folder
```

## Performance Optimization

### Memory Management
MetaMaps uses a heuristic approach to memory. It is recommended to set the target memory to approximately 70% of your available system RAM.

```bash
# Example for a 32GB machine (targeting 20GB)
./metamaps mapDirectly --all -r DB.fa -q input.fastq -o results --maxmemory 20
```

### Multithreading
Use the `-t` flag to specify the number of threads for both mapping and classification.

```bash
./metamaps mapDirectly -t 8 ...
./metamaps classify -t 8 ...
```

**Expert Tip:** If you experience poor multithreading efficiency or crashes during high-thread execution, run the following command immediately before calling MetaMaps:
```bash
unset MALLOC_ARENA_MAX
```

## Output File Reference

MetaMaps generates several files prefixed with your output name (e.g., `results.EM.*`):

| File Extension | Description | Key Columns |
| :--- | :--- | :--- |
| `.EM.WIMP` | Sample composition at various taxonomic levels. | `Absolute` (reads), `EMFrequency` (pre-correction), `PotFrequency` (final frequency). |
| `.EM.reads2Taxon` | Per-read taxonomic assignments. | Read ID, Taxon ID. |
| `.EM.contigCoverage` | Read coverage for contigs in 1kbp windows. | `taxonID`, `contigID`, `readCoverage`. |
| `.EM` | Complete set of approximate mappings. | Read/Contig IDs, mapping coordinates, identity, mapping quality. |
| `.krona` | Taxonomic assignments formatted for Krona tools. | Standard NCBI Taxon IDs and quality values. |

## Database Requirements
MetaMaps requires a specific database structure. When using a downloaded database (e.g., miniSeq+H), ensure the entire directory is provided to the `--DB` parameter during the classification step, while the specific FASTA file is provided to `-r` during mapping.

## Reference documentation
- [MetaMaps GitHub Repository](./references/github_com_DiltheyLab_MetaMaps.md)
- [Bioconda MetaMaps Overview](./references/anaconda_org_channels_bioconda_packages_metamaps_overview.md)