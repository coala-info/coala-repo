---
name: handyreadgenotyper
description: handyreadgenotyper genotypes environmental ONT data by training classification models on known samples and applying them to new sequencing reads. Use when user asks to train a classification model for target amplicons, genotype environmental samples, or classify reads based on specific SNPs.
homepage: https://github.com/AntonS-bio/HandyReadGenotyper
---


# handyreadgenotyper

## Overview
The `handyreadgenotyper` tool (also known as `AmpliconTyper`) provides a specialized workflow for genotyping environmental ONT data. It operates in two primary phases: training a classification model using BAM files from known positive (target) and negative (non-target) samples, and then using that model to classify new sequencing reads. It is particularly effective when used alongside `AmpliSeqDesigner` to identify specific genotypes based on unique SNPs while minimizing off-target amplification.

## Installation and Setup
The tool is best installed via conda/mamba from the bioconda channel:
```bash
mamba create --name amplicontyperENV -c bioconda amplicontyper
mamba activate amplicontyperENV
```

## Model Training
Training is required if a pre-existing `.pickle` model file is not available. The process uses BAM files to learn the differences between target and non-target amplicons.

### Required Inputs
- **Target Regions (`-t`)**: A BED file specifying the reference intervals.
- **Reference (`-r`)**: A FASTA file of the amplicons.
- **Positive BAMs (`-p`)**: Directory or list of BAMs from target organisms.
- **Negative BAMs (`-n`)**: Directory or list of BAMs from non-target organisms (e.g., related taxa or known off-targets).
- **VCF File (`-v`)**: Defines SNPs for genotyping or AMR classification.

### VCF ID Field Conventions
The tool uses specific suffixes in the VCF ID field to interpret mutations:
- `:AMR` (e.g., `gyrA_D87G:AMR`): Reports the mutation in the "Implied AMR" column.
- `:GT` (e.g., `4:GT`): Reports the mutation in the "Implied Genotypes" column.
- No suffix: The position is ignored during training but reported in "Dominant known SNPs" during classification.

### Training Command
```bash
train -t amplicons.bed -r amplicons.fna -p ./positive_bams -n ./negative_bams -v amplicons.vcf -o ./output_model_dir
```

## Read Classification
Once a model is trained, use the `classify` command to genotype new samples.

### Classification Command
```bash
classify -m model.pickle -b sample.bam -r amplicons.fna -o ./classification_results
```

## Best Practices
- **Negative Set Selection**: For environmental samples, include ONT data from taxa two to three taxonomic layers above your target (e.g., if targeting *Salmonella*, include other *Enterobacterales*).
- **BAM Preparation**: While the `train` command is fast (<10 minutes), generating the input BAM files by mapping raw ONT data can take significant time. Ensure BAMs are indexed (`.bai` files present).
- **Special Cases**: Use a tab-delimited file with the `-s` flag to report the presence or absence of specific amplicons that do not require SNP-based genotyping.

## Reference documentation
- [AmpliconTyper GitHub Repository](./references/github_com_AntonS-bio_AmpliconTyper.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_handyreadgenotyper_overview.md)