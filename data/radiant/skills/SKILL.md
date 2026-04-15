---
name: radiant
description: Radiant maps protein sequences to Pfam domains for fast and efficient proteome annotation. Use when user asks to annotate a proteome, identify protein domains, or map sequences to Pfam.
homepage: https://domainworld.uni-muenster.de/data/radiant-db/index.html
metadata:
  docker_image: "biocontainers/radiant:v2.7dfsg-2-deb_cv1"
---

# radiant

## Overview
Radiant is a specialized bioinformatics tool designed for the fast and efficient annotation of proteomes. It maps protein sequences to known Pfam domains, providing a streamlined alternative to more computationally intensive profile HMM searches. It is particularly useful for large-scale genomic studies where processing speed is a priority without sacrificing the accuracy of domain identification.

## Usage Guidelines

### Installation and Environment
Radiant is distributed via Bioconda. Ensure your environment is configured with the necessary channels before installation.
```bash
conda install -c bioconda radiant
```

### Basic Command Structure
The primary workflow involves taking a protein FASTA file as input and generating an annotation table.
```bash
radiant -i <input_proteome.fasta> -o <output_annotations.tsv>
```

### Best Practices
- **Input Preparation**: Ensure protein sequences are in standard FASTA format. Radiant is optimized for amino acid sequences; do not use nucleotide sequences directly.
- **Database Updates**: Periodically check for updated radiant-db files from the project homepage to ensure annotations reflect the latest Pfam releases.
- **Output Interpretation**: The resulting TSV file typically includes sequence identifiers, domain names, and positional information (start/stop coordinates). Use standard Unix tools (awk, grep) or Python (pandas) to filter results by specific domains of interest.

## Reference documentation
- [Radiant Overview](./references/anaconda_org_channels_bioconda_packages_radiant_overview.md)