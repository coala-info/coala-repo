---
name: mendelscan
description: MendelScan prioritizes disease-causing variants in exome data by integrating variant calls with pedigree information and functional annotations. Use when user asks to score variants based on Mendelian inheritance patterns, analyze shared identity by descent, or prioritize candidate genes using family structure and expression data.
homepage: https://github.com/genome/mendelscan
---


# mendelscan

## Overview

MendelScan is a Java-based bioinformatics tool designed to streamline the identification of disease-causing variants in exome data. It functions by integrating standard variant call sets (VCF) with family pedigree information (PED) and functional annotations (VEP). By combining these data points with optional gene expression levels, it provides a prioritized list of variants that follow Mendelian inheritance patterns, helping researchers focus on the most likely candidates for a given phenotype.

## Installation and Setup

MendelScan is distributed as a Java executable. If you are working with the source code, use Apache Ant to build the JAR:

- **Compile**: `ant compile`
- **Build JAR**: `ant dist`

The resulting file is typically named `MendelScan.jar`.

## Common CLI Patterns

### Prioritizing Variants (The `score` command)
The primary workflow involves scoring variants based on inheritance models and functional impact.

```bash
java -jar MendelScan.jar score input_variants.vcf \
  --vep-file annotations.vep \
  --ped-file family_structure.ped \
  --gene-file expression_data.txt \
  --output-file results.tsv \
  --output-vcf prioritized_variants.vcf
```

### Shared Identity By Descent (The `sibd` command)
For studies involving siblings or specific inheritance thresholds, use the `sibd` subcommand to analyze shared genomic regions.

```bash
java -jar MendelScan.jar sibd \
  --ibd-score-threshold 0.5 \
  --ped-file family.ped \
  --output-file ibd_results.tsv
```

## Input Requirements and Best Practices

- **VCF Files**: Ensure your VCF is properly formatted. MendelScan includes specific fixes for GATK-style VCF parsing.
- **VEP Annotations**: Use Variant Effect Predictor (VEP) to generate the `--vep-file`. MendelScan relies on these annotations for functional prioritization.
- **Pedigree (PED) Files**: Standard 6-column PED files are required to define family relationships and affected status.
- **Gene Expression**: Providing a `--gene-file` (typically a tab-delimited text file) allows the tool to incorporate tissue-specific expression data into the variant ranking score.

## Expert Tips

- **Memory Management**: Since MendelScan processes large VCF and VEP files in Java, you may need to increase the heap size for large datasets using the `-Xmx` flag (e.g., `java -Xmx8g -jar MendelScan.jar ...`).
- **IBD Thresholding**: When using the `sibd` subcommand, the `--ibd-score-threshold` flag is critical for filtering noise in shared genomic segments.
- **Output Formats**: Always generate both the `.tsv` and `.vcf` outputs. The TSV is better for manual review and filtering in spreadsheet software, while the VCF is necessary for downstream bioinformatics pipelines.

## Reference documentation
- [MendelScan Overview](./references/github_com_genome_mendelscan.md)
- [MendelScan Source and Javadoc](./references/github_com_genome_mendelscan_tree_2b748a494c0e81eb0f85ad936de8d8202cdc3d7b.md)