---
name: pdivas
description: PDIVAS (Pathogenicity predictor of Deep-Intronic Variants causing Aberrant Splicing) is a machine-learning tool based on a random forest algorithm.
homepage: https://github.com/shiro-kur/PDIVAS
---

# pdivas

## Overview
PDIVAS (Pathogenicity predictor of Deep-Intronic Variants causing Aberrant Splicing) is a machine-learning tool based on a random forest algorithm. It identifies variants deep within introns that may lead to the creation of pathogenic pseudoexons or the extension of existing exons. The tool integrates features from multiple splicing predictors, including SpliceAI, MaxEntScan, and ConSplice, to provide a pathogenicity score between 0.000 and 1.000.

## Installation
The tool is available via Bioconda. It is recommended to use a dedicated environment due to specific dependencies like TensorFlow.

```bash
conda create -n PDIVAS -c bioconda -c conda-forge pdivas spliceai tensorflow==2.6.2 bcftools vcfanno
conda activate PDIVAS
```

## Core CLI Usage

### Pathogenicity Prediction
The primary command for scoring variants in a VCF file.

```bash
pdivas predict -I input.vcf -O output.vcf -F off
```

**Parameters:**
- `-I`: Input VCF file (supports `.vcf` or `.vcf.gz`).
- `-O`: Output VCF file containing `GENE_ID|PDIVAS_score` in the INFO field.
- `-F`: Filtering function. 
    - `off` (default): Outputs all variants.
    - `on`: Outputs only deep-intronic variants that received a PDIVAS score.

### Format Conversion
To convert the annotated VCF into a tab-separated format (one gene annotation per line) for easier downstream analysis:

```bash
pdivas vcf2tsv -I annotated_output.vcf.gz -O final_results.tsv
```

## Workflow Best Practices

### 1. VCF Preprocessing
PDIVAS requires biallelic sites. Always normalize multi-allelic VCFs before running the prediction pipeline:

```bash
bcftools norm -m - multi_allelic.vcf > biallelic.vcf
```

### 2. Feature Annotation Requirements
For a full prediction (Option 2 in the documentation), variants must be pre-annotated with specific features. The standard pipeline involves:
1. **VEP**: Add `ConSplice`, `MaxEntScan` (SWA and NCSS), and gene symbols.
2. **Customized SpliceAI**: Use the PDIVAS-specific customized SpliceAI output module to generate required features.

### 3. Interpreting Results
The `PDIVAS` INFO field in the output VCF contains the following patterns:
- **Float (0.000 - 1.000)**: The pathogenicity score; higher values indicate a higher likelihood of being deleterious.
- **wo_annots**: The variant lacks required VEP or SpliceAI annotations.
- **out_of_scope**: The variant is outside the supported scope (e.g., Y chromosome, non-coding genes, or non-deep-intronic regions).
- **no_gene_match**: No matching gene was found for the variant.

## Expert Tips
- **Quick Implementation**: If working with rare SNVs or short indels (1-4nt) in known Mendelian disease genes, use the precomputed score files with `vcfanno` to bypass the heavy annotation pipeline.
- **Memory Management**: When running the full pipeline with SpliceAI, ensure sufficient GPU/CPU resources are available, as SpliceAI is computationally intensive.
- **Genome Build**: Ensure your reference FASTA and annotation files (GENCODE/Ensembl) match the assembly of your VCF (GRCh38 is the primary supported assembly for the latest versions).

## Reference documentation
- [PDIVAS GitHub Repository](./references/github_com_shiro-kur_PDIVAS.md)
- [Bioconda PDIVAS Overview](./references/anaconda_org_channels_bioconda_packages_pdivas_overview.md)