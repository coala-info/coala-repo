---
name: tadrep
description: TaDReP (Targeted Detection and Reconstruction of Plasmids) is a specialized bioinformatics tool designed to bridge the gap between draft genome assemblies and complete plasmid sequences.
homepage: https://github.com/oschwengers/tadrep
---

# tadrep

## Overview
TaDReP (Targeted Detection and Reconstruction of Plasmids) is a specialized bioinformatics tool designed to bridge the gap between draft genome assemblies and complete plasmid sequences. It uses a reference-based approach to identify plasmid-associated contigs, filter them based on coverage and identity thresholds, and reconstruct them into scaffolds or pseudomolecules. This skill provides the necessary command-line patterns to manage the full workflow, from database preparation to final visualization.

## Core Workflow & CLI Patterns

### 1. Environment Setup
Before running analyses, initialize the required incompatibility (Inc) type databases.
```bash
tadrep setup -o <output_dir> --verbose
```

### 2. Reference Acquisition
You can either download public databases or extract your own references from existing genomes.

**Download Public Databases:**
```bash
# Download RefSeq plasmid database
tadrep database --type refseq -o <output_dir>

# Download PLSDB database
tadrep database --type plsdb -o <output_dir>
```

**Extract Custom References:**
```bash
# Extract all sequences except the longest (usually the chromosome)
tadrep extract --type genome --discard-longest 1 --files complete_genome.fna -o <output_dir>

# Extract sequences based on specific header keywords (e.g., "plasmid")
tadrep extract --type draft --header "plasmid" --files assembly.fna -o <output_dir>
```

### 3. Reference Processing
Process your extracted or downloaded references to make them searchable and categorized.
```bash
# Characterize plasmids (GC content, Inc types, conjugation genes)
tadrep characterize -o <output_dir>

# Cluster related plasmids to reduce redundancy
tadrep cluster -o <output_dir>
```

### 4. Detection and Reconstruction
This is the primary analysis step where draft genomes are screened against the processed references.
```bash
# Detect plasmids in one or more draft assemblies
tadrep detect --threads 8 -o <output_dir> --files draft_1.fna draft_2.fna.gz
```

### 5. Visualization
Generate PDF maps showing how draft contigs align against the detected reference plasmid backbones.
```bash
tadrep visualize -o <output_dir>
```

## Expert Tips & Best Practices

- **Thread Management**: Use the `--threads` (or `-t`) flag during the `detect` step, as Blast+ alignments are computationally intensive.
- **Input Formats**: TaDReP natively supports gzipped fasta files (`.fna.gz`), saving disk space during large cohort studies.
- **Output Interpretation**:
    - `<genome>-summary.tsv`: Use this for per-contig alignment statistics.
    - `<genome>-<plasmid>-pseudo.fna`: This is the best file for downstream comparative genomics as it represents the reconstructed plasmid sequence.
    - `plasmids.tsv`: A presence/absence matrix ideal for population-scale plasmid epidemiology.
- **Filtering Logic**: If `extract --type genome` is capturing the chromosome, increase `--discard-longest` to ensure only smaller extrachromosomal elements are kept as references.

## Reference documentation
- [TaDReP GitHub Repository](./references/github_com_oschwengers_tadrep.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_tadrep_overview.md)