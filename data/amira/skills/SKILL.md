---
name: amira
description: Amira identifies antimicrobial resistance genes and estimates gene copy numbers from long-read sequences or bacterial assemblies by leveraging genomic context. Use when user asks to identify AMR genes in long reads, analyze bacterial assemblies for resistance, or perform context-aware gene detection in metagenomic samples.
homepage: https://github.com/Danderson123/Amira
metadata:
  docker_image: "quay.io/biocontainers/amira:0.11.0--pyhdfd78af_0"
---

# amira

## Overview
Amira is a bioinformatics tool designed to identify AMR genes directly from long-read sequences. By leveraging the full length of long reads, it differentiates between multiple copies of the same gene based on their surrounding genomic environment. It is particularly useful for researchers working with bacterial isolates where high-accuracy gene copy number estimation and context-aware identification are required. The tool supports raw reads, existing assemblies, and an experimental metagenomic mode for low-depth samples.

## Installation and Environment
The most reliable way to run Amira is via Singularity, as it bundles complex non-Python dependencies like Pandora, Racon, and Jellyfish.

- **Singularity (Recommended):** `singularity run amira.img amira --help`
- **Conda:** `conda install amira -c bioconda` (Note: Pandora v0.12.0 must be installed separately and pointed to using `--pandora-path`).
- **PyPI:** `pip install amira-amr`

## Core CLI Usage Patterns

### 1. Analyzing Single-Isolate Reads
Use this for standard high-depth long-read datasets.
```bash
amira --reads <PATH_TO_FASTQ> \
      --output <OUTPUT_DIR> \
      --species <SPECIES_NAME> \
      --panRG-path <PATH_TO_PANRG> \
      --cores <INT>
```

### 2. Analyzing Existing Assemblies
If you already have a bacterial assembly, Amira can process the FASTA file directly.
```bash
amira --assembly <PATH_TO_FASTA> \
      --output <OUTPUT_DIR> \
      --species <SPECIES_NAME> \
      --panRG-path <PATH_TO_PANRG> \
      --cores <INT>
```

### 3. Metagenome Mode (Experimental)
By default, Amira filters out AMR genes with low relative-read depth. Use `--meta` to disable this filtering when working with metagenomic samples or cases where AMR genes might be present at very low frequency.
```bash
amira --reads <PATH_TO_FASTQ> \
      --output <OUTPUT_DIR> \
      --species <SPECIES_NAME> \
      --panRG-path <PATH_TO_PANRG> \
      --meta
```

### 4. Developer/Advanced Workflow
If you have already run Pandora independently, you can feed the SAM and consensus files directly into Amira to save processing time.
```bash
amira --pandoraSam <PANDORA_OUTPUT_DIR>/*.sam \
      --pandoraConsensus <PANDORA_OUTPUT_DIR>/pandora.consensus.fq.gz \
      --panRG-path <PATH_TO_PANRG> \
      --reads <PATH_TO_FASTQ>
```

## Expert Tips and Best Practices
- **Reference Selection:** Always use the species-specific pan-genome (panRG) provided by the developers for the most accurate results. Supported species include *E. coli*, *K. pneumoniae*, *E. faecium*, *S. aureus*, and *S. pneumoniae*.
- **Generic Detection:** If a specific panRG for your species is unavailable, any reference panRG can be used to detect the *presence* or *absence* of AMR genes, though genomic context resolution may be reduced.
- **Dependency Paths:** If not using the Singularity container, ensure `pandora`, `minimap2`, `samtools`, `racon`, and `jellyfish` are in your `$PATH` or explicitly defined via CLI flags (e.g., `--pandora-path`).
- **Resource Allocation:** Amira is computationally intensive due to the de Bruijn graph construction; always specify `--cores` to match your available hardware to speed up the Pandora mapping and Racon polishing steps.

## Reference documentation
- [Amira GitHub README](./references/github_com_Danderson123_Amira.md)
- [Amira Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_amira_overview.md)