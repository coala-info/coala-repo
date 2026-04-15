---
name: ogtfinder
description: OGTFinder predicts the optimal growth temperature and thermophilicity class of prokaryotes using proteome-wide amino acid descriptors. Use when user asks to estimate growth temperatures for bacteria or archaea, classify organisms by thermophilicity, or analyze proteome sequences to determine environmental temperature adaptations.
homepage: https://github.com/SC-Git1/OGTFinder
metadata:
  docker_image: "quay.io/biocontainers/ogtfinder:0.0.2--pyhdfd78af_0"
---

# ogtfinder

## Overview
OGTFinder is a machine learning tool that predicts the optimal growth temperature (OGT) for prokaryotes based on mean amino acid descriptors derived from their proteomes. It is particularly useful for characterizing newly sequenced or uncultured organisms where experimental growth data is unavailable. By analyzing the amino acid composition, the tool provides a temperature estimate in Celsius and assigns the organism to a thermophilicity class.

## Installation
OGTFinder can be installed via pip or conda:

```bash
# Using pip
pip install OGTFinder

# Using conda
conda install -c bioconda ogtfinder
```

## Command Line Usage
The primary command is `ogtfinder`, which requires an input FASTA file and the taxonomic domain.

### Basic Command
```bash
ogtfinder <input_proteome.faa> --domain <Archaea|Bacteria> --outdir <output_directory>
```

### Arguments
- `input`: Path to the FASTA file containing proteome sequences.
- `--domain`: Specify the taxonomic domain, either `Archaea` or `Bacteria` (default is `Bacteria`).
- `--outdir`: The directory where results will be saved.
- `--debug`: Optional flag that outputs an additional `descriptors.tsv` file containing the feature values used by the model.

## Best Practices and Tips
- **Input Preparation**: Ensure the input file contains amino acid sequences (proteome), not nucleotide sequences (genome). If you only have a genome, annotate it first using tools like Prokka or Bakta to generate the `.faa` file.
- **Domain Specificity**: Always specify `--domain Archaea` if working with archaeal sequences, as the underlying models are optimized for the specific proteomic signatures of each domain.
- **Partial Proteomes**: While OGTFinder supports partial proteomes, using a complete or near-complete set of predicted proteins will result in a more representative mean amino acid descriptor profile and a more accurate prediction.
- **Output Files**: The main output is `results.tsv`, which includes:
    - `filename`: The source file name.
    - `domain`: The user-specified domain.
    - `prediction [°C]`: The estimated optimal growth temperature.
    - `class`: The thermophilicity classification (e.g., Hyperthermophile, Thermophile, Mesophile, Psychrophile).

## Reference documentation
- [OGTFinder GitHub Repository](./references/github_com_SC-Git1_OGTFinder.md)
- [Bioconda OGTFinder Overview](./references/anaconda_org_channels_bioconda_packages_ogtfinder_overview.md)