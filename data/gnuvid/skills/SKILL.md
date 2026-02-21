---
name: gnuvid
description: GNUVID is a specialized bioinformatics tool designed for the rapid identification and classification of SARS-CoV-2 viral genomes.
homepage: https://github.com/ahmedmagds/GNUVID
---

# gnuvid

## Overview

GNUVID is a specialized bioinformatics tool designed for the rapid identification and classification of SARS-CoV-2 viral genomes. It operates by ranking Coding Sequence (CDS) nucleotide sequences based on exact matches against a comprehensive database of known alleles across 10 specific Open Reading Frames (ORFs). By utilizing a machine learning Random Forest Classifier for novel or ambiguous sequences, it can assign genomes to Clonal Complexes (CCs) which are often more granular than standard Pango Lineages.

## Command Line Usage

The primary script for classification is `GNUVID_Predict.py`.

### Basic Classification
To run a standard analysis on a FASTA file (which may contain multiple records):
```bash
GNUVID_Predict.py input_genomes.fasta
```

### Recommended Analysis Pattern
For most research use cases, use the following flags to ensure detailed output and organized results:
```bash
GNUVID_Predict.py -i -o output_directory -f input_genomes.fasta
```
*   `-i`: Generates individual output files for each genome showing specific allele sequences and GNU scores.
*   `-o`: Specifies a custom output folder name (defaults to a timestamped folder).
*   `-f`: Forces overwriting if the output directory already exists.

### Handling Low-Quality Sequences
If working with environmental samples or older sequencing runs, adjust the quality thresholds:
```bash
GNUVID_Predict.py -m 10000 -n 0.7 input_genomes.fasta
```
*   `-m`: Minimum sequence length (default is 15000).
*   `-n`: Maximum proportion of ambiguity/Ns allowed (default is 0.5).

### Memory Management
For large datasets on machines with limited RAM, use the block prediction flag:
```bash
GNUVID_Predict.py -b 500 input_genomes.fasta
```
*   `-b`: Sets the prediction block size (default is 1000). Lowering this reduces memory overhead.

### Machine Learning Only Mode
To bypass the exact allele matching step and rely solely on the Random Forest Classifier for speed or specific research goals:
```bash
GNUVID_Predict.py -e input_genomes.fasta
```

## Expert Tips

1.  **Environment Setup**: Always run GNUVID within its dedicated Conda environment to ensure dependencies like `MAFFT`, `Blastn`, and `scikit-learn` are correctly versioned.
2.  **Input Format**: Ensure your input file uses the `.fna` or `.fasta` extension. While the tool is robust, standardizing headers helps in parsing the final reports.
3.  **Interpreting Results**: GNUVID reports both the Clonal Complex (CC) and the corresponding WHO naming system for Variants of Concern (VOC). If a genome is assigned a CC but no WHO name, it likely belongs to a lineage not currently designated as a VOC, VOI, or VUM.
4.  **ORF Coverage**: The tool specifically types 10 ORFs: ORF1ab, S, ORF3a, E, M, ORF6, ORF7a, ORF8, N, and ORF10. If your sequences are partial and missing several of these regions, the ML classifier (`-e`) may provide more stable results than exact matching.

## Reference documentation
- [github_com_ahmedmagds_GNUVID.md](./references/github_com_ahmedmagds_GNUVID.md)
- [anaconda_org_channels_bioconda_packages_gnuvid_overview.md](./references/anaconda_org_channels_bioconda_packages_gnuvid_overview.md)