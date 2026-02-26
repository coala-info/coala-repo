---
name: vitap
description: VITAP classifies viral genetic fragments and assigns taxonomic lineages using alignment and graph algorithms. Use when user asks to classify viral sequences, assign viral taxonomy, or update viral databases.
homepage: https://github.com/DrKaiyangZheng/VITAP/
---


# vitap

## Overview
VITAP (Viral Taxonomic Assignment Pipeline) is a high-precision tool for classifying viral genetic fragments. It combines traditional alignment-based methods with graph algorithms to provide robust taxonomic lineages. This skill is essential for workflows involving viral metagenomics where sequences must be reconciled with the latest ICTV Viral Metadata Resource (VMR). It supports both the creation/updating of specialized viral databases and the subsequent prediction of taxonomy for unknown samples.

## Installation and Environment
The recommended way to install VITAP is via Mamba/Conda to ensure all dependencies (DIAMOND, TaxonKit, Pyrodigal, etc.) are correctly versioned.

```bash
# Create and activate the environment
mamba create -n vitap_v.1.10 -c bioconda vitap=1.10
conda activate vitap_v.1.10
```

## Database Preparation (VITAP upd)
Before running assignments, you must generate or update the VITAP-specific database. This process reformats ICTV data into a structure the pipeline can utilize.

1. **Source Data**: Download the latest VMR_MSL file from the ICTV website.
2. **Formatting**: Extract exactly 9 columns: `Virus GENBANK accession`, `Realm`, `Kingdom`, `Phylum`, `Class`, `Order`, `Family`, `Genus`, and `Species`. Save this as a `.csv`.
3. **Execution**:
   ```bash
   ./VITAP upd --vmr ./path/to/ICTV_VMR.csv -o ./path/to/reformatted_VMR.csv -d VMR-MSL
   ```

### Expert Tips for Database Updates
* **Excel Corruption Warning**: ICTV VMR files often use a period to separate start and end loci (e.g., `AE006468 (844298.877981)`). Excel may treat these as floating-point numbers and truncate trailing zeros. Always verify these entries in your CSV before running `upd` to prevent locus extraction errors.
* **Specific Categories**: Pay extra attention to *Peduoviridae*, *Belpaoviridae*, and GTA-viriforms (*Bartogtaviriformidae* and *Rhodogtaviriformidae*), as their metadata is frequently flagged for locus errors in standard ICTV releases.

## Taxonomic Assignment Logic
VITAP v1.10 uses a "Participation Index" (PI) to calibrate assignments when falling back to UniRef90.

* **Participation Index (PI)**: Defined as `PI(G, T) = |P_{G,T}| / |P_G|`, where `|P_G|` is the total predicted ORFs and `|P_{G,T}|` is the number of ORFs assigned to taxon `T`.
* **Default Threshold**: The default PI is **0.25**. This requires roughly 50% of ORFs to support a taxon if the bitscore ratio is 0.5.
* **Performance**: Version 1.10 utilizes `polars` and `pyrodigal`, significantly reducing computation time compared to older versions using `pandas` and `prodigal`.

## Common CLI Patterns
While the specific prediction command flags depend on the local installation path, the general workflow follows:
1. **Update**: Generate the database using `upd`.
2. **Predict**: Run the assignment script (typically `VITAP` or `scripts/VITAP_assignment.py`) against your FASTA sequences using the database generated in step 1.

## Reference documentation
- [VITAP Overview - Bioconda](./references/anaconda_org_channels_bioconda_packages_vitap_overview.md)
- [VITAP GitHub Repository and Documentation](./references/github_com_DrKaiyangZheng_VITAP.md)