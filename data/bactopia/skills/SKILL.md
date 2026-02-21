---
name: bactopia
description: Bactopia is a flexible, Nextflow-based bioinformatic framework designed for the complete analysis of bacterial genomes.
homepage: https://github.com/bactopia/bactopia
---

# bactopia

## Overview
Bactopia is a flexible, Nextflow-based bioinformatic framework designed for the complete analysis of bacterial genomes. It automates the transition from raw sequencing reads to annotated assemblies and provides a suite of "Bactopia Tools" for comparative analyses such as pan-genome construction and phylogenetic tree building. Use this skill to streamline isolate-level processing or to manage large-scale comparative genomic workflows using standardized, reproducible CLI patterns.

## Installation and Setup
Bactopia is primarily distributed via Bioconda. Using `mamba` is highly recommended for faster dependency resolution.

```bash
# Create the environment
mamba create -y -n bactopia -c conda-forge -c bioconda bactopia
conda activate bactopia

# Download required datasets (mandatory first step)
bactopia datasets
```

## Common CLI Patterns

### 1. Processing Local Samples
For individual isolates, you can provide FASTQ files directly.

**Paired-End Reads:**
```bash
bactopia --sample SAMPLE_NAME \
    --R1 R1.fastq.gz \
    --R2 R2.fastq.gz \
    --datasets datasets/ \
    --outdir OUTDIR
```

**Single-End Reads:**
```bash
bactopia --sample SAMPLE_NAME \
    --SE SAMPLE.fastq.gz \
    --datasets datasets/ \
    --outdir OUTDIR
```

### 2. Batch Processing (Multiple Samples)
For multiple isolates, use the `prepare` command to create a compatible input list.

```bash
# Generate the input file
bactopia prepare /path/to/fastqs/ > fastqs.txt

# Run the pipeline in batch mode
bactopia --fastqs fastqs.txt --datasets datasets/ --outdir OUTDIR
```

### 3. Fetching and Processing Public Data
Bactopia can automatically download and process data from SRA/ENA.

**Single Accession:**
```bash
bactopia --accession SRX000000 --datasets datasets/ --outdir OUTDIR
```

**Search and Batch Download:**
```bash
# Search for a specific taxon
bactopia search "Staphylococcus aureus" > accessions.txt

# Process all found accessions
bactopia --accessions accessions.txt --datasets datasets/ --outdir OUTDIR
```

## Bactopia Tools (Comparative Analysis)
Once the main pipeline has processed isolates, use "Bactopia Tools" for downstream comparative genomics. These tools leverage the predictable output structure of the main pipeline.

*   **Summary Reports:** Aggregate QC and assembly stats.
*   **Pan-genomes:** Use tools like Roary or Pirate.
*   **Phylogeny:** Construct trees from core genome SNPs.

## Expert Tips and Best Practices
*   **Dataset Management:** Always ensure the `--datasets` directory is properly populated using `bactopia datasets`. This directory contains the necessary databases for annotation and sketching.
*   **Output Structure:** Bactopia uses a highly structured output directory. Familiarize yourself with the `main` and `tools` subdirectories to easily locate assemblies (`.fna`), annotations (`.gff`), and QC reports.
*   **Resource Allocation:** Since Bactopia is built on Nextflow, you can pass Nextflow-specific parameters like `-profile` (e.g., `docker`, `singularity`, or `slurm`) to manage execution environments and HPC resources.
*   **Resuming Runs:** If a run is interrupted, use the Nextflow `-resume` flag to continue from the last successful process.

## Reference documentation
- [Bactopia GitHub Repository](./references/github_com_bactopia_bactopia.md)
- [Bactopia Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_bactopia_overview.md)