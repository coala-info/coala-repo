---
name: whokaryote
description: Whokaryote classifies contigs from metagenomic assemblies as either eukaryotic or prokaryotic. Use when user asks to classify contigs by domain or generate separate fasta files for classified contigs.
homepage: https://github.com/LottePronk/whokaryote
---


# whokaryote

## Overview
Whokaryote is a random forest classifier designed to distinguish between eukaryotic and prokaryotic contigs in metagenomic assemblies. It utilizes gene-structure-based features and can optionally integrate Tiara predictions to improve classification accuracy. By identifying the domain of origin for each sequence, it allows researchers to apply the correct downstream annotation tools, such as domain-specific gene finders.

## Installation
The recommended way to install whokaryote is via Conda:
```bash
conda create -c bioconda -n whokaryote whokaryote
conda activate whokaryote
```

## Core Usage Patterns

### Standard Classification (Recommended)
The default behavior uses the Tiara-integrated model, which provides the highest accuracy.
```bash
whokaryote.py --contigs assembly.fasta --outdir output_directory
```

### Using Pre-computed Gene Predictions
If you have already run Prodigal or another gene finder, provide the GFF file to significantly speed up the process.
```bash
whokaryote.py --contigs assembly.fasta --outdir output_directory --gff genes.gff
```

### Generating Classified Fasta Files
By default, the tool provides text files with headers. Use the `-f` flag to generate separate fasta files for eukaryotes and prokaryotes.
```bash
whokaryote.py --contigs assembly.fasta --outdir output_directory -f
```

## Parameters and Best Practices

| Parameter | Description | Best Practice |
| :--- | :--- | :--- |
| `--minsize` | Minimum contig length (default: 5000) | Accuracy drops significantly below 5000bp. Avoid lowering this unless necessary. |
| `--model` | Choose 'S' (Standalone) or 'T' (Tiara) | Use 'T' (default) for better performance; 'S' is faster but less precise. |
| `--contigs` | Input DNA fasta file | Ensure headers do not contain complex special characters that might break downstream parsing. |

## Expert Tips
- **Contig Length Matters**: Whokaryote is optimized for contigs ≥ 5kb. If your assembly is highly fragmented, the classification of shorter contigs should be treated with caution.
- **Memory and Time**: Running the tool without a GFF file triggers Prodigal internally. For large metagenomes, it is often more efficient to run Prodigal independently and pass the GFF to whokaryote.
- **Output Interpretation**: 
    - `whokaryote_predictions_[model].tsv`: The primary file for downstream automation.
    - `featuretable.csv`: Useful for troubleshooting or secondary machine learning analysis.
- **Unclassified Sequences**: Contigs with fewer than 2 predicted genes or those shorter than the `--minsize` will not be classified and will be omitted from the main prediction files.

## Reference documentation
- [Whokaryote GitHub Repository](./references/github_com_LottePronk_whokaryote.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_whokaryote_overview.md)