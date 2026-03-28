---
name: pdivas
description: PDIVAS is a machine learning tool designed to predict the pathogenicity of deep-intronic variants that cause aberrant splicing. Use when user asks to predict the impact of deep-intronic mutations, calculate pathogenicity scores for splicing variants, or convert PDIVAS VCF outputs into TSV format.
homepage: https://github.com/shiro-kur/PDIVAS
---


# pdivas

## Overview

PDIVAS (Pathogenicity Predictor for Deep-Intronic Variants causing Aberrant Splicing) is a specialized machine learning tool designed to identify deleterious variants located deep within introns. While most variant effect predictors focus on coding regions or canonical splice sites, PDIVAS uses a random forest algorithm to evaluate the likelihood that a deep-intronic mutation will disrupt normal gene expression via aberrant splicing. It integrates scores from SpliceAI, MaxEntScan, and ConSplice to provide a unified pathogenicity metric.

## Installation and Environment Setup

PDIVAS requires a specific environment due to its dependencies on older versions of scikit-learn and specialized splicing predictors.

1. **Create the Environment**:
   ```bash
   conda create -n PDIVAS -c bioconda -c conda-forge spliceai tensorflow==2.6.2 pdivas bcftools vcfanno
   ```

2. **Custom SpliceAI Requirement**: PDIVAS requires a customized version of SpliceAI's output module to function correctly. If running the full pipeline, you must replace the default SpliceAI files with the customized versions found in the PDIVAS repository.

## Core Workflows

### 1. Fast Annotation (Precomputed Scores)
For variants in known Mendelian disease genes (approx. 4,500 genes), use the precomputed score files to avoid heavy computational overhead.

```bash
# Use vcfanno with a configuration file pointing to the precomputed PDIVAS VCF
vcfanno -lua custom.lua conf.toml input.vcf > annotated_output.vcf
```

### 2. Full Prediction Pipeline
When analyzing variants not covered by precomputed files, follow this sequence:

**Step A: Preprocessing**
Ensure the VCF is biallelic.
```bash
bcftools norm -m - multi_allelic.vcf > biallelic.vcf
```

**Step B: Feature Generation**
Run VEP with the MaxEntScan and ConSplice plugins, followed by the customized SpliceAI.
```bash
# SpliceAI command for PDIVAS features
spliceai -I vep_annotated.vcf -O features_ready.vcf -R hg38.fa -A grch38 -D 300 -M 1
```

**Step C: PDIVAS Prediction**
```bash
pdivas predict -I features_ready.vcf -O final_predictions.vcf.gz -F off
```

## CLI Reference and Best Practices

### pdivas predict
The primary command for calculating pathogenicity scores.
- `-I`: Input VCF (must contain SpliceAI, MaxEntScan, and ConSplice annotations).
- `-O`: Output VCF.
- `-F`: Filtering mode. 
    - `off` (default): Outputs all variants.
    - `on`: Outputs only deep-intronic variants that received a PDIVAS score.

### pdivas vcf2tsv
Converts the VCF output into a readable TSV format, which is essential for downstream manual review as it handles multi-gene annotations by creating one line per gene.
```bash
pdivas vcf2tsv -I final_predictions.vcf.gz -O final_report.tsv
```

## Expert Tips
- **Score Interpretation**: PDIVAS scores range from 0.000 to 1.000. Higher values indicate a higher probability of pathogenicity.
- **Scope Limitations**: PDIVAS is optimized for protein-coding genes on autosomes and the X chromosome. Variants on the Y chromosome or in non-coding RNA genes may return `out_of_scope`.
- **Handling Exceptions**: 
    - `wo_annots`: Indicates the variant lacked the required input features (SpliceAI/MaxEntScan/ConSplice) for a prediction.
    - `out_of_scope`: Indicates the variant is outside the genomic regions PDIVAS was trained to evaluate.



## Subcommands

| Command | Description |
|---------|-------------|
| predict | Add PDIVAS annotation to a VCF file and predict deep-intronic variants. |
| vcf2tsv | Convert PDIVAS annotated VCF files to TSV format |

## Reference documentation
- [PDIVAS Main Documentation](./references/github_com_shiro-kur_PDIVAS.md)
- [PDIVAS README and Usage](./references/github_com_shiro-kur_PDIVAS_blob_main_README.md)