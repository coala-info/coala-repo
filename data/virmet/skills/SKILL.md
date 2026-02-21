---
name: virmet
description: VirMet is a specialized bioinformatics pipeline designed for viral metagenomics (mNGS), particularly in clinical settings.
homepage: https://github.com/medvir/VirMet
---

# virmet

## Overview
VirMet is a specialized bioinformatics pipeline designed for viral metagenomics (mNGS), particularly in clinical settings. It automates the complex process of quality control, multi-stage host decontamination, and viral identification via BLAST. The tool follows a "wolfpack" approach to analyze entire sequencing runs, providing structured reports on species identification and genomic coverage to facilitate viral diagnosis.

## Core Workflow

### 1. Database Preparation
Before running analyses, databases must be downloaded and indexed. This is a one-time setup requirement.

```bash
# Download all required reference databases
virmet fetch

# Index the downloaded genomes for alignment
virmet index

# Periodically update the viral database to include new sequences
virmet update
```

### 2. Primary Analysis (Wolfpack)
The `wolfpack` subcommand is the main entry point for analyzing sequencing data. It performs QC, removes host reads (human, bovine, bacterial, fungal), and identifies viral sequences.

```bash
# Analyze an entire MiSeq run directory
virmet wolfpack --run path/to/run_directory

# Analyze a single FASTQ file
virmet wolfpack --file path/to/sample.fastq.gz
```

### 3. Visualization and Support
To confirm a diagnosis, generate coverage plots for specific organisms identified in the initial scan.

```bash
# Generate coverage plots (usually automated in wolfpack unless --nocovplot is used)
virmet covplot --org "Organism Name" --sample sample_name
```

## Output Interpretation

| File | Description |
| :--- | :--- |
| `Orgs_species_found.csv` | The primary results table showing identified viruses, accession numbers, and read counts. |
| `Run_reads_summary.tsv` | A summary of the filtering process (how many reads were human, bacterial, etc.). |
| `viral_reads.fastq.gz` | Extracted reads identified as viral (filtered at ≥75% identity and ≥75% coverage). |
| `undetermined_reads.fastq.gz` | Reads that did not match any known reference in the pipeline. |
| `*.pdf` | Coverage plots found in organism-specific subdirectories. |

## Best Practices and Tips
- **Host Decontamination Order**: VirMet uses a sequential approach: Human (GRCh38) -> Bovine -> Bacteria -> Fungi. If you see high "undetermined" counts, check the `Run_reads_summary.tsv` to see where most reads are being dropped.
- **Manual Inspection**: Always review the coverage plots in the `virmet_output_RUN_NAME` subdirectories. A high read count with very low genome coverage often indicates a false positive or highly conserved region match rather than a true infection.
- **Storage Management**: The decontamination steps generate `.err` files for each stage. While useful for debugging, these can be safely deleted after a successful run to save space.
- **Path Handling**: Ensure the path to the FASTQ files is correctly specified. VirMet is optimized for MiSeq structures (`Data/Intensities/BaseCalls`) but can handle custom paths using the `--file` or `--run` flags.

## Reference documentation
- [VirMet GitHub Repository](./references/github_com_medvir_VirMet.md)
- [VirMet Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_virmet_overview.md)