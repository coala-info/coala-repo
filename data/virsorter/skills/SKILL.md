---
name: virsorter
description: VirSorter is a specialized tool for mining viral signals from microbial genomic data.
homepage: https://github.com/simroux/VirSorter
---

# virsorter

## Overview

VirSorter is a specialized tool for mining viral signals from microbial genomic data. It employs a multi-classifier approach that evaluates features such as viral hallmark genes, protein-coding density, and enrichment of uncharacterized proteins to distinguish viral sequences from their bacterial or archaeal hosts. This skill provides the necessary procedural knowledge to execute VirSorter, manage its databases, and interpret the resulting viral predictions.

## Core Workflows

### Basic Execution

The primary entry point for VirSorter is the Perl wrapper script. A standard run requires an input FASTA file, a database selection, and a path to the pre-computed VirSorter data.

```bash
wrapper_phage_contigs_sorter_iPlant.pl -f assembly.fasta --db 1 --wdir output_directory --ncpu 4 --data-dir /path/to/virsorter-data
```

### Database Selection (`--db`)

Choose the database based on the nature of your input data:
- `--db 1`: Uses the RefSeq database. Best for isolate genomes or datasets where you expect viruses similar to known references.
- `--db 2`: Uses the Virome database. Best for environmental metagenomes where novel viral signals are expected.

### Handling Metagenomic Data

If the input is a virome (enriched for viral particles), use the `--virome` flag to enable specific decontamination steps and adjusted scoring.

```bash
wrapper_phage_contigs_sorter_iPlant.pl -f virome_assembly.fasta --db 2 --virome 1 --wdir output_dir --data-dir /path/to/data
```

## Expert Tips and Troubleshooting

### Directory Management
VirSorter will throw a "Step 1 failed" error if the directory provided to `--wdir` already exists and is not a valid previous run. Always ensure the output directory is new or deleted before starting a fresh analysis.

### The `--no_c` Fallback
If the run fails during the enrichment statistics step (often due to C-script compilation issues on specific architectures), use the `--no_c` flag. This forces the tool to use a slower but more compatible Perl-based calculation.

### Interpreting Results
The most critical output files are located in the root of the output directory:
- `VIRSorter_global-phage-signal.csv`: The summary table of all predictions.
- `Predicted_viral_sequences/`: Contains FASTA and GenBank files for the identified viral segments.

Viral predictions are categorized by confidence:
- **Categories 1 & 4**: High confidence (Pretty sure it's a virus).
- **Categories 2 & 5**: Medium confidence (Likely a virus).
- **Categories 3 & 6**: Low confidence (Possible viral signal, requires manual inspection).

### Performance
Always specify `--ncpu` to match your available hardware resources, as the HMMER and BLAST/Diamond steps are computationally intensive.

## Reference documentation

- [VirSorter GitHub Repository](./references/github_com_simroux_VirSorter.md)
- [VirSorter Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_virsorter_overview.md)