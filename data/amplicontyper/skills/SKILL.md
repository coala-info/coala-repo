---
name: amplicontyper
description: AmpliconTyper is a specialized bioinformatics tool designed for environmental surveillance using Nanopore sequencing.
homepage: https://github.com/AntonS-bio/AmpliconTyper
---

# amplicontyper

## Overview

AmpliconTyper is a specialized bioinformatics tool designed for environmental surveillance using Nanopore sequencing. It addresses the common challenge of off-target amplification in complex environmental samples by using a machine learning approach. The tool operates in two primary modes: training a classification model using known positive and negative datasets (BAM files), and then using that model to classify new ONT sequencing reads. It is particularly effective for identifying specific strains and genotypes within multiplexed PCR data.

## Installation and Setup

The recommended way to install AmpliconTyper is via Conda or Mamba to manage dependencies effectively.

```bash
# Create and activate a dedicated environment
mamba create --name amplicontyperENV -c bioconda amplicontyper
mamba activate amplicontyperENV
```

## Model Training

Training is a one-time process that generates a portable model file (pickle format). While the training command itself is fast (<10 minutes), the preparation of input BAM files is the most time-intensive step.

### Required Inputs
- **Reference FASTA (`-r`)**: The reference sequences for your amplicons.
- **Target Regions BED (`-t`)**: Coordinates within the reference to train on (usually the whole amplicon).
- **Positive BAMs (`-p`)**: Directory containing BAM files of your target organism aligned to the reference.
- **Negative BAMs (`-n`)**: Directory containing BAM files of non-target organisms or off-target amplification products.
- **VCF File (`-v`)**: Contains SNPs used for genotyping or AMR classification.

### Command Pattern
```bash
train -t amplicons.bed -r amplicons.fna -p ./positive_bams -n ./negative_bams -v amplicons.vcf -o ./model_output
```

## Expert Tips and Best Practices

### VCF ID Field Logic
AmpliconTyper uses specific suffixes in the VCF ID field to determine how mutations are reported during classification:
- **`:AMR` suffix**: (e.g., `gyrA_D87G:AMR`) The mutation will be reported in the "Implied AMR" column.
- **`:GT` suffix**: (e.g., `4:GT`) The mutation will be reported in the "Implied Genotypes" column.
- **No suffix**: (e.g., `Other`) The position is excluded from training but reported in "Dominant known SNPs" if detected during classification.

### Selecting Negative Control Data
For robust environmental surveillance, the negative training set should be diverse:
- Use public data (NCBI SRA) for taxa 2-3 taxonomic layers above your target (e.g., if targeting *Salmonella*, include various *Enterobacterales*).
- Include BAMs from any organisms known to cause off-target amplification in your specific primer set.

### Model Portability
Once a model is trained, the resulting `.pickle` file can be shared with collaborators. They can skip the `train` step and proceed directly to classification using your validated model.

## Reference documentation
- [AmpliconTyper GitHub Repository](./references/github_com_AntonS-bio_AmpliconTyper.md)
- [AmpliconTyper Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_amplicontyper_overview.md)