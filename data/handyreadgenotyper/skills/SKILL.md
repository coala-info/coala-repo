---
name: handyreadgenotyper
description: handyreadgenotyper classifies Oxford Nanopore multiplex PCR reads and identifies genotypes or antimicrobial resistance markers using a trained machine learning model. Use when user asks to train a classification model from BAM files, classify sequencing reads, or identify AMR markers and genotypes in environmental surveillance data.
homepage: https://github.com/AntonS-bio/HandyReadGenotyper
---


# handyreadgenotyper

## Overview
handyreadgenotyper (also known as AmpliconTyper) is a specialized bioinformatics tool designed for the analysis of Oxford Nanopore Technologies (ONT) multiplex PCR data. It is particularly effective for environmental surveillance where distinguishing target pathogens from complex biological backgrounds is critical. The tool operates in two primary phases: training a classification model using positive and negative BAM files to learn organism-specific sequencing signatures, and subsequently using that model to classify new reads, reporting genotypes and antimicrobial resistance (AMR) markers based on specific SNP configurations.

## Command Line Usage

### Model Training
The `train` command builds a classification model. It requires a set of "positive" BAMs (target organism) and "negative" BAMs (off-target/background organisms).

```bash
train -t amplicons.bed -r amplicons.fna -p ./positive_bams/ -n ./negative_bams/ -v amplicons.vcf -o ./output_model/
```

**Key Arguments:**
* `-t, --target_regions`: BED file specifying the reference intervals for training.
* `-r, --reference`: FASTA file of the reference sequences reads were mapped to.
* `-p, --positive_bams`: Directory or list of BAM files containing the target organism data.
* `-n, --negative_bams`: Directory or list of BAM files containing non-target/background data.
* `-v, --vcf`: VCF file defining SNPs to exclude from training or to use for genotyping/AMR.
* `-o, --output_dir`: Directory where the `model.pkl` and `quality.tsv` will be saved.

### Read Classification
Once a model is trained, use the `classify` command to analyze new sequencing data.

```bash
classify -m model.pkl -b sample.bam -r amplicons.fna -o ./results/
```

## Expert Tips and Best Practices

### VCF Formatting for Genotyping and AMR
The tool uses the `ID` field in the input VCF to determine how to handle specific SNPs during classification:
* **AMR Markers**: Append `:AMR` to the ID (e.g., `gyrA_D87G:AMR`). These are reported in the "Implied AMR" column.
* **Genotypes**: Append `:GT` to the ID (e.g., `Genotype_4:GT`). These are reported in the "Implied Genotypes" column.
* **Standard SNPs**: If no suffix is provided, the mutation is reported in the "Dominant known SNPs" column.
* **Exclusion**: All positions listed in the VCF are automatically excluded from the machine learning training process to prevent the model from over-fitting on known markers.

### Training Data Selection
* **Negative Set Diversity**: The accuracy of the classifier depends heavily on the diversity of the negative training set. Include ONT data from taxa 2-3 taxonomic layers above your target (e.g., if targeting *Salmonella*, include various *Enterobacterales*).
* **BAM Pre-calculation**: For large datasets, use the `-m` (BAM matrix) option to provide pre-calculated matrices and speed up iterative training sessions.

### Environment Setup
The tool is best managed via Conda/Mamba. Ensure the environment is activated before running commands:
```bash
mamba activate amplicontyperENV
```



## Subcommands

| Command | Description |
|---------|-------------|
| classify | Classify reads in BAM file using existing model or train a model from bam files |
| train | Classify reads in BAM file using existing model or train a model from bam files |

## Reference documentation
- [AmpliconTyper GitHub README](./references/github_com_AntonS-bio_AmpliconTyper_blob_main_README.md)
- [AmpliconTyper Meta YAML](./references/github_com_AntonS-bio_AmpliconTyper_blob_main_meta.yaml.md)