---
name: mmannot
description: mmannot quantifies small RNA-seq data by resolving multi-mapping reads based on feature types and user-defined priorities. Use when user asks to quantify sRNA-seq reads, handle multi-mapping sequences, or assign reads to genomic features using a GTF annotation.
homepage: https://github.com/mzytnicki/mmannot
---


# mmannot

## Overview

mmannot is a specialized bioinformatics tool designed for the quantification of small RNA-seq (sRNA-seq) data. Its primary strength lies in its sophisticated handling of multi-mapping reads—sequences that align to multiple locations in the genome. While standard quantification tools often discard these reads or assign them randomly, mmannot "rescues" them if all mapping locations correspond to the same feature type (e.g., a duplicated miRNA family). If a read maps to different feature types, mmannot flags it as ambiguous, providing a more transparent view of the transcriptomic landscape.

## Command Line Usage

### Basic Quantification
To run a standard quantification, you must provide a GTF annotation file and at least one BAM or SAM file.

```bash
mmannot -a annotation.gtf -r sample.bam -o output_counts.txt
```

### Processing Multiple Samples
You can process multiple files simultaneously. Use the `-n` flag to provide short labels for the output columns.

```bash
mmannot -a annotation.gtf -r cell1.bam cell2.bam cell3.bam -n Cell1 Cell2 Cell3 -t 3 -o experiment_results.txt
```

### Key Parameters
- `-s <strand>`: Set the library type. 
  - Single-end: `F` (Forward, default), `R` (Reverse), `U` (Unknown).
  - Paired-end: `FR`, `RF`, `FF`, `U`.
- `-f <format>`: Specify input format as `SAM` or `BAM`.
- `-y <strategy>`: Choose quantification logic: `default`, `unique` (only unique mappers), `random`, or `ratio`.
- `-e <integer>`: Attribute a read to a feature if at least N% of its hits map to that feature (default is 100%).
- `-t <integer>`: Number of threads (mmannot uses one thread per input BAM/SAM file).

## Configuration File Logic

The configuration file (default: `config.txt`) controls how features are prioritized and grouped.

### The "Order" Section
The `Order:` section is critical because it defines priority. If a read overlaps multiple features, it is assigned to the one listed first. To keep the ambiguity (e.g., flag as `miRNA--tRNA`), place them on the same line separated by a comma.

```text
Order: miRNA:primary_transcript
Order: protein_coding:CDS, protein_coding:UTR
```

### Handling Introns and Vicinity
If your GTF does not explicitly define introns or you want to capture reads in flanking regions:
- **Introns**: `Introns: protein_coding:gene` (infers introns from exon gaps).
- **Vicinity**: `Vicinity: protein_coding:gene` (creates `upstream` and `downstream` features based on `-d` and `-D` CLI flags).

### Helper Tool
If you are unsure of the feature names in your GTF, use the included Python helper to generate a template:
```bash
./createConfigFile -i annotation.gtf -o my_config.txt
```

## Expert Tips

1. **The NH Tag**: mmannot relies on the `NH` tag in BAM files to identify multi-mappers. If your aligner (like older versions of Bowtie) does not provide this, use the companion tool `addNH` provided in the mmannot bundle to preprocess your BAM files.
2. **Feature Naming**: In the config file, features are often referenced as `Source:Feature` (the 2nd and 3rd columns of the GTF). Ensure your config matches these strings exactly.
3. **Memory Management**: Since mmannot loads the annotation into memory, ensure your system has enough RAM for large genomes (e.g., Human or Maize), though the tool is generally efficient for sRNA-seq workflows.

## Reference documentation
- [mmannot Overview](./references/anaconda_org_channels_bioconda_packages_mmannot_overview.md)
- [mmannot GitHub Documentation](./references/github_com_mzytnicki_mmannot.md)