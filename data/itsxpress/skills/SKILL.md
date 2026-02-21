---
name: itsxpress
description: itsxpress is a specialized tool designed for the rapid extraction of ITS sequences from raw FASTQ data.
homepage: http://github.com/usda-ars-gbru/itsxpress
---

# itsxpress

## Overview

itsxpress is a specialized tool designed for the rapid extraction of ITS sequences from raw FASTQ data. While traditional tools often focus on OTU clustering, itsxpress is optimized for modern exact sequence variant (ASV) workflows. It maintains the integrity of quality scores by de-replicating sequences, identifying ITS boundaries using Hidden Markov Models (HMMs), and then trimming the original reads. This tool is a critical preprocessing step for researchers working with fungal, plant, or other eukaryotic marker gene datasets.

## Core CLI Patterns

### Paired-End Trimming (DADA2 Workflow)
To maintain separate forward and reverse reads for pipelines like DADA2, specify both `--outfile` and `--outfile2`.
```bash
itsxpress --fastq R1.fastq.gz --fastq2 R2.fastq.gz --region ITS2 --taxa Fungi --outfile R1_trimmed.fastq.gz --outfile2 R2_trimmed.fastq.gz --threads 4
```

### Paired-End Trimming (Merged/Deblur Workflow)
To return a single merged file (common for Deblur or older OTU methods), omit the second output file.
```bash
itsxpress --fastq R1.fastq.gz --fastq2 R2.fastq.gz --region ITS2 --taxa Fungi --outfile merged_trimmed.fastq.gz --threads 4
```

### Single-End Trimming
Use the `--single_end` flag when working with data that was not sequenced as pairs.
```bash
itsxpress --fastq reads.fastq.gz --single_end --region ITS1 --taxa Fungi --outfile trimmed.fastq.gz
```

## Parameter Optimization

- **Region Selection (`--region`)**: Choose between `ITS1`, `ITS2`, or `ALL`. `ALL` includes the 5.8s rRNA gene.
- **Taxonomic Specificity (`--taxa`)**: While `Fungi` is the default, itsxpress supports a wide range of eukaryotes. Specify the correct group to improve HMM accuracy:
  - Options include: `Alveolata`, `Bryophyta`, `Bacillariophyta`, `Amoebozoa`, `Euglenozoa`, `Chlorophyta`, `Rhodophyta`, `Phaeophyceae`, `Marchantiophyta`, `Metazoa`, `Oomycota`, `Haptophyceae`, `Raphidophyceae`, `Rhizaria`, `Synurophyceae`, `Tracheophyta`, `Eustigmatophyceae`, `Parabasalia`.
- **Performance (`--threads`)**: Increase threads to speed up the HMM search process, which is the most computationally intensive step.
- **Compression**: itsxpress automatically handles `.gz` and `.zst` files based on the file extension provided in the input and output arguments.

## Expert Tips

- **Reverse Primers**: If your sequencing library used the Taylor et al. (2016) orientation where primers are reversed, use the `--reversed_primers` flag. itsxpress will automatically flip the reads to the forward orientation.
- **Clustering Identity**: The `--cluster_id` defaults to `1.0` (exact de-replication). Lowering this slightly (e.g., `0.995`) can speed up processing on extremely large datasets by reducing the number of unique sequences sent to the HMM search, though `1.0` is recommended for ASV analysis.
- **Staggered Reads**: By default, `--allow_staggered_reads` is true, which helps Vsearch merge reads that overlap significantly.
- **QIIME2 Integration**: itsxpress is available as a QIIME2 plugin. If using it within QIIME2, the commands follow the `qiime itsxpress trim-paired` or `qiime itsxpress trim-single` syntax.

## Reference documentation
- [itsxpress GitHub README](./references/github_com_usda-ars-gbru_itsxpress.md)
- [itsxpress Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_itsxpress_overview.md)