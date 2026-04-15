---
name: ampliconclassifier
description: The ampliconclassifier tool categorizes focal amplifications from AmpliconArchitect outputs into biological classes such as ecDNA, BFB cycles, and linear amplifications. Use when user asks to classify genomic amplicons, identify ecDNA or BFB status, extract gene-level copy number data, or quantify the genomic complexity of amplified regions.
homepage: https://github.com/jluebeck/AmpliconClassifier
metadata:
  docker_image: "quay.io/biocontainers/ampliconclassifier:0.4.14--hdfd78af_0"
---

# ampliconclassifier

## Overview
The `ampliconclassifier` tool is the standard downstream analysis component for the AmpliconSuite. It transforms raw AmpliconArchitect (AA) outputs into biological classifications. It is essential for distinguishing between extrachromosomal DNA (ecDNA), Breakage-Fusion-Bridge (BFB) cycles, and other focal amplifications. Use this skill to automate the classification of multiple samples, extract gene-level copy number data, and assess the genomic complexity of amplified regions.

## Core Workflows

### 1. Batch Classification
The most efficient way to run the tool is by pointing it to a directory containing multiple AA results. It will recursively search for `.graph` and `.cycles` files.

```bash
python amplicon_classifier.py --ref GRCh38 --AA_results /path/to/AA_outputs/ > classification_summary.log
```

### 2. Single Amplicon Analysis
To analyze a specific amplicon manually, provide the explicit paths to the cycles and graph files.

```bash
python amplicon_classifier.py --ref hg19 --cycles sample_amplicon1_cycles.txt --graph sample_amplicon1_graph.txt
```

### 3. Unifying Reference Genomes
If your dataset contains a mix of GRCh37 and hg19 results, use the `--add_chr_tag` flag to prepend "chr" to chromosome names, allowing for a unified hg19-based output.

```bash
python amplicon_classifier.py --ref hg19 --add_chr_tag --AA_results /path/to/mixed_results/
```

## Interpreting Key Outputs

### Classification Profiles (`*_amplicon_classification_profiles.tsv`)
- **Cyclic**: Indicates genome cycles. Check the `ecDNA+` and `BFB+` columns to differentiate between ecDNA and BFB.
- **Complex non-cyclic (CNC)**: Highly rearranged but lacks the circularity characteristic of ecDNA.
- **Linear**: Low rearrangement focal amplification, often tandem duplications.
- **Invalid**: Does not meet the tool's filters for a focal amplification.

### Gene and lncRNA Lists (`*_gene_list.tsv`)
This file maps genes to specific features (e.g., `ecDNA_1`).
- **gene_cn**: The maximum copy number of segments >1kbp overlapping the gene.
- **truncated**: Indicates if the 5', 3', or both ends of the gene are lost.
- **is_canonical_oncogene**: Cross-references with COSMIC/ONGene.

### Complexity and Entropy (`*_feature_entropy.tsv`)
Use this file to quantify "amplicon chaos." It reports scores based on the number of genomic segments and the diversity of copy number states within the AA decomposition.

## Expert Tips
- **Environment Variables**: Ensure `$AA_DATA_REPO` is set and points to the required reference data (e.g., RefGene annotations), otherwise gene classification will fail.
- **Experimental ecDNA Counts**: The `ecDNA_amplicons` column provides an experimental estimate of the number of distinct ecDNA species within a single AA amplicon.
- **Borderline Calls**: Check the `*_feature_basic_properties.tsv` file for the "borderline" flag. This identifies ecDNA with CN < 8 or other classes with CN < 5, which may require manual inspection.

## Reference documentation
- [AmpliconClassifier GitHub Repository](./references/github_com_AmpliconSuite_AmpliconClassifier.md)