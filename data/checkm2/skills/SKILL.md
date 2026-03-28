---
name: checkm2
description: CheckM2 is a machine learning-based tool used to assess the quality of genomic bins by predicting their completeness and contamination. Use when user asks to evaluate the quality of metagenome-assembled genomes, predict bin completeness and contamination, or download and manage the CheckM2 DIAMOND database.
homepage: https://github.com/chklovski/CheckM2
---


# checkm2

## Overview

CheckM2 is a machine learning-based tool used to rapidly assess the quality of genomic bins by predicting their completeness and contamination. Unlike previous versions that relied on lineage-specific marker sets, CheckM2 uses universally trained models that are effective across all taxonomic lineages, including those with reduced genomes or unusual biology like Nanoarchaeota. It employs two distinct models for completeness—a "general" gradient boost model for novel organisms and a "specific" neural network for well-represented lineages—automatically selecting the best fit via cosine similarity.

## Common CLI Patterns

### Database Setup
Before running predictions, you must download the DIAMOND database.
```bash
# Download to default directory (~/databases)
checkm2 database --download

# Download to a specific path
checkm2 database --download --path /custom/path/
```

### Quality Prediction
The `predict` command is the primary workflow for assessing bins.
```bash
# Basic run on a folder of FASTA files
checkm2 predict --threads 30 --input <folder_with_bins> --output-directory <output_folder>

# Run on a specific list of files (supports mixed extensions and paths)
checkm2 predict --input bin1.fa bin2.fna /data/bin3.fasta -o <output_folder>

# Handling gzipped files in a directory
checkm2 predict --input <folder> --extension gz -o <output_folder>
```

### Performance and Resource Management
```bash
# Low memory mode (reduces DIAMOND RAM usage by half)
checkm2 predict --input <in> -o <out> --lowmem

# Resume a failed or interrupted run
checkm2 predict --input <in> -o <out> --resume

# Remove intermediate files (proteins and DIAMOND output) to save space
checkm2 predict --input <in> -o <out> --remove_intermediates
```

## Expert Tips and Best Practices

- **Pre-predicted Genes**: If you have already run Prodigal on your bins, use the `--genes` flag. This skips the internal gene prediction step and expects protein files as input.
- **Translation Tables**: By default, CheckM2 chooses between translation tables 4 and 11 based on coding density. You can force a specific table using `--ttable <int>`.
- **Database Environment Variable**: To avoid specifying the database path every time, set the `CHECKM2DB` environment variable: `export CHECKM2DB="/path/to/database"`.
- **Model Selection**: While CheckM2 automatically selects the best model, you can inspect the `quality_report.tsv` in the output folder to see the "Completeness_Model_Used" column. If the models substantially disagree, a low confidence warning is issued.
- **Verification**: Always run `checkm2 testrun` after a new installation or database update to ensure the machine learning models are producing results within expected margins.



## Subcommands

| Command | Description |
|---------|-------------|
| checkm2 | checkm2: error: argument subparser_name: invalid choice: 'directory' (choose from predict, testrun, database) |
| checkm2 predict | Predict the completeness and contamination of genome bins in a folder. |
| testrun | Runs Checkm2 on internal test genomes to ensure it runs without errors. |

## Reference documentation
- [CheckM2 GitHub README](./references/github_com_chklovski_CheckM2_blob_main_README.md)
- [CheckM2 Changelog](./references/github_com_chklovski_CheckM2_blob_main_CHANGELOG.md)