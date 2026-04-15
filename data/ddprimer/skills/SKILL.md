---
name: ddprimer
description: ddprimer is a specialized bioinformatics pipeline designed to create and validate primer sets specifically for Droplet Digital PCR. Use when user asks to design primers for genomic regions, perform SNP masking, create BLAST databases for specificity checks, or remap primer coordinates to new genome assemblies.
homepage: https://github.com/globuzzz2000/ddPrimer
metadata:
  docker_image: "quay.io/biocontainers/ddprimer:0.1.1--pyhdfd78af_0"
---

# ddprimer

## Overview
ddprimer is a specialized bioinformatics pipeline tailored for the unique requirements of Droplet Digital PCR. Unlike general primer design tools, it integrates ddPCR-specific constraints such as restriction site filtering, precise GC% windows, and thermodynamic stability calculations using ViennaRNA. It streamlines the transition from raw genomic data to validated primer sets by automating file preparation (indexing and normalization) and providing specificity checks against BLAST databases.

## Core CLI Workflows

### Standard Genome-Based Design
Use this pattern when designing primers for specific genomic regions while accounting for variants and gene boundaries.
```bash
ddprimer --fasta genome.fasta --vcf variants.vcf --gff annotations.gff
```
*   **SNP Masking**: The tool uses the VCF file to avoid placing primers over known variant positions.
*   **Annotation Filtering**: The GFF file ensures primers are designed within targeted gene regions. Use `--noannotation` if you want to design primers across the entire FASTA sequence regardless of gene boundaries.

### Direct Sequence Mode
Use this when you already have target sequences in a CSV or Excel file and want to design primers for them without full genome processing.
```bash
# Basic direct design
ddprimer --direct sequences.csv

# Direct design with SNP masking (requires reference FASTA)
ddprimer --direct sequences.xlsx --snp --vcf variants.vcf --fasta reference.fa
```

### Specificity and Database Management
Before running specificity checks, you must ensure a BLAST database is available.
```bash
# Create a custom BLAST database from a FASTA file
ddprimer --db genome.fasta my_custom_db

# Launch interactive mode to select from existing model organism databases
ddprimer --db
```

### Coordinate Remapping
If you have existing ddprimer results but need to update coordinates or annotations against a newer genome assembly:
```bash
ddprimer --remap primers.xlsx --fasta new_ref.fa --gff new_annotations.gff
```

## Configuration and Customization
ddprimer uses a JSON-based configuration for fine-tuning design parameters.

1.  **Generate Template**: `ddprimer --config template`
2.  **View Current Settings**: `ddprimer --config` or `ddprimer --config primer3`
3.  **Apply Custom Config**: `ddprimer --config custom_settings.json`

### Key Configuration Parameters
*   `RESTRICTION_SITE`: Set the sequence (e.g., "GGCC") to filter fragments based on ddPCR restriction digestion requirements.
*   `PRIMER_MIN_GC` / `PRIMER_MAX_GC`: Typically set between 50.0 and 60.0 for ddPCR.
*   `PENALTY_MAX`: Adjust the Primer3 penalty threshold to increase or decrease the stringency of candidate selection.

## Expert Tips
*   **Interactive Mode**: If unsure of the arguments, run `ddprimer` without any flags to launch a GUI-guided file selection process.
*   **File Preparation**: The tool automatically handles `bgzip` compression and `tabix` indexing for VCF files, but ensuring your VCF is normalized beforehand prevents mapping errors.
*   **Troubleshooting**: If the pipeline fails silently or produces unexpected results, use the `--debug` flag and inspect the logs located in `~/.ddPrimer/logs/`.
*   **Performance**: For large-scale designs, adjust the `NUM_PROCESSES` value in your config file to match your system's CPU cores.

## Reference documentation
- [ddPrimer GitHub Repository](./references/github_com_globuzzz2000_ddPrimer.md)
- [Bioconda ddprimer Overview](./references/anaconda_org_channels_bioconda_packages_ddprimer_overview.md)