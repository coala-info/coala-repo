---
name: strainr2
description: StrainR2 provides high-resolution strain quantification from metagenomic data by normalizing mapping values against unique k-mer content. Use when user asks to prepare a reference genome database, calculate normalized strain abundances, or perform k-mer based bias correction in shotgun metagenomics.
homepage: https://github.com/BisanzLab/StrainR2
---


# strainr2

## Overview

StrainR2 is a specialized bioinformatic tool designed to provide high-resolution strain quantification. It overcomes the mapping biases inherent in shotgun metagenomics—where unique genomes often receive disproportionately more mappings—by normalizing RPKM (Reads Per Kilobase per Million mapped reads) values against unique k-mer content. The workflow is divided into a one-time database preparation step (`PreProcessR`) and a sample-specific quantification step (`StrainR`).

## Workflow and CLI Usage

### 1. Database Preparation (PreProcessR)

Run this command once for a specific community of reference genomes. It segments contigs into subcontigs and calculates unique k-mer reports.

```bash
PreProcessR -i <PATH_TO_GENOME_DIR> -o <DB_OUTPUT_DIR> [OPTIONS]
```

**Key Parameters:**
- `-i, --indir`: Directory containing reference genomes in `.fna` or `.fasta` format.
- `-o, --outdir`: Destination for the database (default: `./StrainR2DB`).
- `-r, --readsize`: Set this to match your expected sequencing read length (e.g., 150 for 150bp reads). This determines k-mer size calculation.
- `-m, --singleend`: Enable this flag only if you intend to process single-end reads in the next step.

**Expert Tips:**
- **Subcontig Size**: By default, the tool uses the minimum N50 of the input genomes. Manual adjustment via `-s` is rarely recommended unless dealing with extremely fragmented assemblies.
- **Memory Management**: For very large communities, ensure the system has sufficient swap space, as k-mer counting can be memory-intensive.

### 2. Strain Quantification (StrainR)

Use this command to analyze metagenomic reads against a prepared database.

```bash
StrainR -1 <FORWARD_READS> -2 <REVERSE_READS> -r <DB_DIR> -o <OUT_DIR> -p <SAMPLE_NAME>
```

**Key Parameters:**
- `-1, -2`: Paths to forward and reverse FASTQ files (supports `.gz`).
- `-r, --reference`: The directory created by `PreProcessR`.
- `-c, --weightedpercentile`: Controls the sensitivity/specificity tradeoff (default: 60).
- `-t, --threads`: Number of CPU threads to utilize.

**Expert Tips:**
- **Tuning Sensitivity**: If you suspect false positives (reporting strains that aren't there), decrease the `-c` value. If you are missing low-abundance strains (false negatives), increase it.
- **Background Correction**: Use `-b1` and `-b2` to provide background reads (e.g., host DNA or contaminant profiles) that should be excluded from the abundance calculation.

## Output Interpretation

StrainR2 generates three primary files:
1. **.abundance**: The final normalized abundance table. This is the primary file for downstream analysis.
2. **.rpkm**: Raw RPKM values generated via BBMap before k-mer normalization.
3. **.sam**: The alignment file for the sample.
4. **Abundance Plot**: A visual representation of the strain distribution in the sample.



## Subcommands

| Command | Description |
|---------|-------------|
| PreProcessR | PreProcessR counts the unique hashes in subcontigs for StrainR to normalize reads with. |
| StrainR | StrainR normalizes mapping from reads using the output from PreProcessR |

## Reference documentation
- [StrainR2 GitHub README](./references/github_com_BisanzLab_StrainR2_blob_main_README.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_strainr2_overview.md)