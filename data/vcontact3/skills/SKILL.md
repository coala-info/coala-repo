---
name: vcontact3
description: vcontact3 is a computational tool designed for the automated clustering and taxonomic classification of viral sequences.
homepage: https://bitbucket.org/MAVERICLab/vcontact3
---

# vcontact3

## Overview
vcontact3 is a computational tool designed for the automated clustering and taxonomic classification of viral sequences. It utilizes a protein-sharing network approach, where viral contigs are grouped into clusters (Viral Clusters or VCs) based on the number of shared protein families. This method is particularly effective for genus-level classification of viral "dark matter" in metagenomic datasets where traditional marker-gene approaches are insufficient.

## Installation and Setup
vcontact3 is primarily distributed via Bioconda.

```bash
conda install -c bioconda vcontact3
```

Before running analysis, you must initialize the reference database:
```bash
# Download the default reference database (e.g., RefSeq)
vcontact3 db --download
```

## Common CLI Patterns

### Standard Analysis Run
The core command for clustering viral proteins against a reference database:
```bash
vcontact3 run --input proteins.faa --db refseq --output ./vcontact3_results --threads 8
```

### Input Requirements
- **Proteins**: Input should be a FASTA file of predicted protein sequences.
- **Gene-to-Genome Mapping**: If your proteins are from multiple contigs, ensure headers are formatted correctly or provide a mapping file if required by specific sub-modules to link proteins back to their source contigs.

### Database Management
To list available databases or check the status of local ones:
```bash
vcontact3 db --list
```

## Expert Tips and Best Practices

1. **Protein Prediction**: For best results, use a consistent gene caller like **Prodigal** (in meta mode) or **PHANOTATE** (specifically for phages) before passing sequences to vcontact3.
2. **Resource Allocation**: The clustering process, especially the All-versus-All protein comparison, is computationally intensive. Always specify `--threads` to match your environment's capabilities.
3. **Interpreting VCs**: 
   - **VC (Viral Cluster)**: Roughly equivalent to a genus.
   - **Outlier**: A sequence that shares some proteins but not enough to be confidently placed in a cluster.
   - **Singleton**: A sequence with no significant protein sharing with any other sequence in the dataset or database.
4. **Network Visualization**: vcontact3 generates network files (typically in `.ntw` or CSV formats) that can be imported into **Cytoscape** or **Gephi** for visual inspection of the protein-sharing clusters.
5. **Taxonomy Assignment**: Use the `clusters.csv` output to find the taxonomic lineage assigned to your contigs based on their membership in VCs containing known reference genomes.

## Reference documentation
- [anaconda_org_channels_bioconda_packages_vcontact3_overview](./references/anaconda_org_channels_bioconda_packages_vcontact3_overview.md)
- [bitbucket_org_MAVERICLab_vcontact3](./references/bitbucket_org_MAVERICLab_vcontact3.md)