---
name: strvctvre
description: StrVCTVRE predicts the clinical impact of structural variants that overlap exons using a machine learning framework. Use when user asks to predict the pathogenicity of structural variants, annotate VCF or BED files with impact scores, or classify exonic deletions and duplications.
homepage: https://github.com/andrewSharo/StrVCTVRE/tree/master
metadata:
  docker_image: "quay.io/biocontainers/strvctvre:1.10--pyh7e72e81_0"
---

# strvctvre

## Overview
StrVCTVRE (Structural Variant Classifier Trained on Variants Rare and Exonic) is a specialized machine learning tool designed to predict the clinical impact of structural variants (SVs) that overlap exons. It utilizes a random forest framework to generate a score between 0 and 1, where higher values indicate a greater likelihood of pathogenicity. This tool is essential for clinical genomics workflows where researchers need to distinguish between benign rare variants and those likely to cause disease.

## Installation and Setup
StrVCTVRE is available via Bioconda or GitHub.
- **Conda**: `conda install bioconda::strvctvre`
- **External Dependency**: You must download the 9.2GB `hg38.phyloP100way.bw` file. By default, the tool looks for this in the `data/` directory of the installation.
- **LiftOver**: If processing GRCh37 data, the `liftOver` executable must be available on your system path or provided via arguments.

## Command Line Usage

### Basic Annotation (GRCh38)
To annotate a standard VCF file using the default GRCh38 assembly:
```bash
python StrVCTVRE.py -i input.vcf -o output.vcf
```

### Processing BED Files
Specify the format explicitly when using BED files:
```bash
python StrVCTVRE.py -i input.bed -o output.bed -f bed
```

### Processing GRCh37 (hg19)
When working with GRCh37, you must specify the assembly and provide the path to the `liftOver` binary:
```bash
python StrVCTVRE.py -i input.vcf -o output.vcf -a GRCh37 -l /path/to/liftOver
```

### Custom Resource Paths
If the required PhyloP conservation file is not in the default `data/` folder, use the `-p` flag:
```bash
python StrVCTVRE.py -i input.vcf -o output.vcf -p /custom/path/to/hg38.phyloP100way.bw
```

## Expert Tips and Best Practices
- **VCF Requirements**: For a record to be processed, the INFO column must contain `END` and `SVTYPE` entries.
- **Supported SV Types**: The tool only classifies `DEL` (deletions) and `DUP` (duplications). Other types will be skipped.
- **Exonic Overlap**: StrVCTVRE only annotates variants that overlap at least one exon. Variants in purely intronic or intergenic regions will not receive a score.
- **Score Interpretation**: Scores are calibrated such that a high threshold (e.g., >0.5) significantly enriches for pathogenic variants while maintaining high specificity.
- **Memory Management**: Ensure sufficient disk space for the 9.2GB PhyloP file, as it is required even when running GRCh37 samples (the tool lifts coordinates to hg38 to perform the calculation).

## Reference documentation
- [StrVCTVRE GitHub Repository](./references/github_com_andrewSharo_StrVCTVRE.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_strvctvre_overview.md)