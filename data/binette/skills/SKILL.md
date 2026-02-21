---
name: binette
description: Binette is a high-performance binning refinement tool designed to improve the quality of Metagenome-Assembled Genomes (MAGs).
homepage: https://github.com/genotoul-bioinfo/binette
---

# binette

## Overview

Binette is a high-performance binning refinement tool designed to improve the quality of Metagenome-Assembled Genomes (MAGs). It takes the output from multiple binning algorithms and applies set operations—intersection, difference, and union—to create new hybrid bin combinations. By leveraging CheckM2 for quality assessment and optimizing the underlying protein identification steps, Binette identifies the most complete and least contaminated bins significantly faster than previous refinement tools.

## Installation and Setup

Binette is primarily distributed via Bioconda.

```bash
# Install via Conda
conda create -n binette -c bioconda binette
conda activate binette

# Mandatory: Download the CheckM2 database before first use
checkm2 database --download --path <path/to/database_dir>
```

## Common CLI Patterns

### Using Contig-to-Bin Tables
Use this pattern when you have TSV files mapping contigs to bin IDs (format: `contig_id <tab> bin_id`).

```bash
binette --contig2bin_tables set1.tsv set2.tsv set3.tsv \
        --contigs assembly.fasta \
        --outdir refinement_results \
        --threads 16
```

### Using Bin Directories
Use this pattern when your binning tools have already produced directories of FASTA files.

```bash
binette --bin_dirs ./metabat2_bins/ ./maxbin2_bins/ \
        --contigs assembly.fasta \
        --outdir refinement_results
```

### Resuming a Run
If a run is interrupted or you wish to add more bin sets to an existing analysis, use the `--resume` flag to utilize the `temporary_files/` directory.

```bash
binette --bin_dirs ./set1 ./set2 ./set3 \
        --contigs assembly.fasta \
        --resume
```

## Expert Tips and Best Practices

- **Contamination Weighting**: By default, Binette calculates a score as `completeness - contamination * weight`. If your downstream analysis is highly sensitive to contamination, increase the penalty using `--contamination_weight` (default is typically 1.0).
- **Storage Optimization**: For very large metagenomes, generating FASTA files for every intermediate bin can be IO-intensive. Use `--no-write-fasta-bins` to only produce the `final_contig_to_bin.tsv` mapping file, which you can use to extract specific bins later.
- **CheckM2 Efficiency**: Binette is faster than metaWRAP because it runs Prodigal and Diamond once for the entire assembly rather than per-bin. Ensure your `--threads` count matches your available CPU cores to maximize this advantage during the initial feature extraction phase.
- **Input Consistency**: Ensure the `--contigs` FASTA file is the exact same file used to generate the input bins. Discrepancies in contig headers will cause the refinement to fail or produce empty results.

## Key Outputs

- `final_bins_quality_reports.tsv`: The primary metrics file containing completeness, contamination, N50, and scores for the winning bins.
- `final_contig_to_bin.tsv`: A lightweight mapping of contigs to their final refined bin assignments.
- `final_bins/`: Directory containing the actual FASTA sequences of the refined MAGs.

## Reference documentation

- [Binette GitHub Repository](./references/github_com_genotoul-bioinfo_Binette.md)
- [Bioconda Binette Package Overview](./references/anaconda_org_channels_bioconda_packages_binette_overview.md)