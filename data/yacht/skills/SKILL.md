---
name: yacht
description: YACHT statistically determines the presence or absence of organisms in metagenomic samples. Use when user asks to detect organisms in metagenomic samples, determine the presence or absence of reference genomes, sketch samples or reference genomes, train reference databases, convert analysis results, or download pre-built reference databases.
homepage: https://github.com/KoslickiLab/YACHT
---


# yacht

## Overview
YACHT (Yes/No Answers to Community membership via Hypothesis Testing) is a tool designed for the mathematically rigorous detection of organisms within metagenomic samples. It moves beyond simple k-mer matching by applying a hypothesis test based on Average Nucleotide Identity (ANI). This allows researchers to define specific sensitivity levels (false negative rates) and ANI thresholds to determine if a reference genome is truly present in a sample, providing a statistical "Yes/No" answer rather than just a list of matches.

## Core Workflow

The standard YACHT workflow consists of four primary stages: sketching, training, running (inference), and optional conversion.

### 1. Data Preparation (Sketching)
YACHT operates on k-mer sketches (using sourmash signatures). You must sketch both your query sample and your reference genomes.

```bash
# Sketch a query sample (FASTQ)
yacht sketch sample --infile ./query.fq --kmer 31 --scaled 1000 --outfile sample.sig.zip

# Sketch reference genomes (Directory of FASTA files)
yacht sketch ref --infile ./ref_genomes --kmer 31 --scaled 1000 --outfile ref.sig.zip
```

### 2. Preprocessing (Training)
The training step calculates the necessary statistics for the reference database. This step generates a JSON configuration file required for the run module.

```bash
yacht train --ref_file ref.sig.zip --ksize 31 --ani_thresh 0.95 --prefix my_db --outdir ./
```
*   **Expert Tip**: Use a higher `--ani_thresh` (e.g., 0.99) if you need to distinguish between very closely related strains.

### 3. Presence/Absence Detection (Running)
This is the inference step where YACHT performs the hypothesis test.

```bash
yacht run --json my_db_config.json --sample_file sample.sig.zip --significance 0.99 --min_coverage_list 1 0.6 0.2 0.1 --outdir ./results
```
*   **Significance**: Controls the confidence of the hypothesis test (default is often 0.99).
*   **Min Coverage**: Providing a list (e.g., `1 0.6 0.2 0.1`) allows you to see results at different sensitivity thresholds in a single output file.

### 4. Result Conversion
To use YACHT results with other taxonomic profiling tools or benchmarks, convert the output to CAMI format.

```bash
yacht convert --yacht_output_dir ./results --sheet_name min_coverage0.2 --genome_to_taxid mapping.tsv --mode cami --outfile_prefix my_sample_cami
```

## Common CLI Patterns

### Downloading Pre-built Resources
Instead of sketching and training your own database, you can download pre-trained databases for GTDB or GenBank.

```bash
# Download pre-trained GTDB rs214 database
yacht download pretrained_ref_db --database gtdb --db_version rs214 --k 31 --ani_thresh 0.95 --outfolder ./databases
```

### Managing Threads
For large datasets, always specify the thread count to speed up the `train` and `run` modules.
```bash
yacht run --num_threads 16 [other_args]
```

## Best Practices
*   **K-mer Size**: Use `k=31` for species-level identification. Smaller k-mers (e.g., `k=21`) may be used for genus-level detection but increase the risk of false positives.
*   **Scaled Value**: Ensure the `--scaled` value used in `sketch sample` matches the value used in `sketch ref`. A value of `1000` is standard for most metagenomic applications.
*   **Low Abundance**: When looking for rare organisms (MAG fishing), focus on the lower values in your `min_coverage_list` (e.g., 0.1 or 0.05).
*   **Output Files**: YACHT produces an `result.xlsx` file. Each tab in the spreadsheet corresponds to a different coverage threshold from your `min_coverage_list`, making it easy to compare sensitivity levels.

## Reference documentation
- [YACHT GitHub Repository](./references/github_com_KoslickiLab_YACHT.md)
- [YACHT Wiki](./references/github_com_KoslickiLab_YACHT_wiki.md)
- [Bioconda YACHT Package](./references/anaconda_org_channels_bioconda_packages_yacht_overview.md)