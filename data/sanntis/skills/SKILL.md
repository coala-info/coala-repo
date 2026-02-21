---
name: sanntis
description: SanntiS (SMBGC Annotation using Neural Networks Trained on Interpro Signatures) is a machine-learning tool designed to detect Small Molecule Biosynthetic Gene Clusters.
homepage: https://github.com/Finn-Lab/SanntiS
---

# sanntis

## Overview
SanntiS (SMBGC Annotation using Neural Networks Trained on Interpro Signatures) is a machine-learning tool designed to detect Small Molecule Biosynthetic Gene Clusters. Unlike traditional rule-based detection tools, SanntiS leverages neural networks to identify cluster boundaries and types based on protein domain signatures. It is primarily used as a downstream analysis tool for InterProScan results, allowing for high-resolution BGC discovery in both isolated genomes and complex metagenomic assemblies.

## Core Workflows

### Standard Annotation (GenBank Input)
The primary workflow requires a GenBank (.gbk) file containing coding sequences (CDS) and a corresponding InterProScan output file (GFF3 or TSV).
```bash
sanntis --ip-file path/to/interproscan_results.gff3 path/to/sequence.gbk
```

### Protein FASTA Annotation
When working with protein sequences (e.g., predicted by Prodigal), use the `--is_protein` flag. Note that FASTA headers must follow Prodigal's naming conventions for proper coordinate mapping.
```bash
sanntis --is_protein --ip-file path/to/interproscan_results.tsv path/to/proteins.faa
```

### antiSMASH Integration
To facilitate downstream analysis or visualization within the antiSMASH ecosystem, SanntiS can generate a specialized JSON output.
```bash
sanntis --antismash_output True path/to/input_file
```
The resulting `.antismash.json` file can be uploaded to the antiSMASH web server via 'Data input' > 'Upload extra annotations'.

## Best Practices and Expert Tips

- **InterProScan Requirements**: SanntiS requires InterProScan version > 5.52-86.0. If running on a non-Linux OS, you cannot run InterProScan locally; you must provide pre-generated TSV or GFF3 files using the `--ip-file` parameter.
- **Input Formatting**: When using `--ip-file`, ensure the protein IDs in the InterProScan output match the IDs in your GenBank or FASTA file exactly.
- **Interpreting Output**:
    - **Score**: The post-processing probability output from the neural network.
    - **Partial Flag**: Look at the `partial` attribute in the GFF3 output. A value like "10" or "01" indicates the cluster is truncated by the edge of a contig (5' or 3' respectively), which is critical for assessing BGC completeness.
    - **MiBIG Dissimilarity**: The `nearest_MiBIG_diceDistance` field uses the Dice dissimilarity coefficient. Lower values indicate higher similarity to known clusters in the MiBIG database.
- **Docker Usage**: For large-scale runs, use the provided `sanntis_container.py` script, but ensure you have at least 25GB of disk space available for the InterProScan data dependencies.

## Reference documentation
- [SanntiS GitHub Repository](./references/github_com_Finn-Lab_SanntiS.md)
- [SanntiS Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_sanntis_overview.md)