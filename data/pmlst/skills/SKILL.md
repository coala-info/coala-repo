---
name: pmlst
description: pmlst identifies plasmid types by comparing genomic sequences against a database of plasmid-specific housekeeping genes. Use when user asks to identify plasmid sequence types, perform plasmid multilocus sequence typing, or track the epidemiology of plasmid-mediated outbreaks.
homepage: https://bitbucket.org/genomicepidemiology/pmlst
metadata:
  docker_image: "quay.io/biocontainers/pmlst:2.0.3--hdfd78af_0"
---

# pmlst

## Overview
pmlst is a specialized bioinformatics tool designed to identify plasmid types by comparing genomic sequences against a curated database of plasmid-specific housekeeping genes. It is essential for tracking the horizontal transfer of antimicrobial resistance (AMR) genes and understanding the epidemiology of plasmid-mediated outbreaks. This skill provides the necessary command-line patterns and workflow logic to execute pMLST scans and interpret the resulting typing data.

## Installation and Database Setup
Before running pmlst, the tool must be installed and the specific pMLST database must be cloned and configured.

```bash
# Install via Bioconda
conda install -c bioconda pmlst

# Clone the required database (usually required as a separate step)
git clone https://bitbucket.org/genomicepidemiology/pmlst_db.git
cd pmlst_db
python3 install_db.py
```

## Common CLI Patterns

### Basic Typing from Assembly
To type a plasmid from a FASTA assembly file:
```bash
pmlst.py -i input_assembly.fa -p /path/to/pmlst_db -s [species_scheme] -x
```
- `-i`: Input file (FASTA).
- `-p`: Path to the directory containing the pMLST database.
- `-s`: The specific pMLST scheme to use (e.g., `incf`, `incp1`, `inchi1`).
- `-x`: Extended output (includes the alignment of the alleles).

### Batch Processing
When dealing with multiple schemes or unknown plasmid types, it is often more efficient to wrap the call in a loop or use a script to check against multiple schemes, as pmlst typically requires a specific scheme to be defined per run.

## Expert Tips and Best Practices
- **Scheme Selection**: Unlike general MLST, pMLST is highly specific to the plasmid incompatibility group. If the group is unknown, use tools like `PlasmidFinder` first to identify the replicon type, then select the corresponding pMLST scheme.
- **Input Quality**: For best results, use high-quality assemblies. While pmlst can run on raw reads (using KMA internally in some versions), using a polished assembly reduces the risk of false-negative allele calls due to low coverage in specific gene regions.
- **Database Updates**: Plasmid schemes are updated frequently. Always ensure your `pmlst_db` is synced with the latest Bitbucket repository to ensure new alleles and sequence types (STs) are recognized.
- **Interpreting Results**: 
    - **Perfect Match**: All alleles match known sequences in the database.
    - **New ST**: All alleles are known, but the combination is new.
    - **New Allele**: One or more genes have mutations not yet recorded in the database.

## Reference documentation
- [pmlst - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_pmlst_overview.md)
- [genomicepidemiology / pmlst — Bitbucket](./references/bitbucket_org_genomicepidemiology_pmlst.md)