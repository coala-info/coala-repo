---
name: pepsirf
description: PepSIRF processes raw sequencing data from peptide-based assays to generate and analyze serological immune profiles. Use when user asks to demultiplex FASTQ reads, calculate peptide enrichment, perform taxonomic deconvolution, or normalize data using Z-scores.
homepage: https://github.com/LadnerLab/PepSIRF
---


# pepsirf

## Overview
PepSIRF (Peptide-based Serological Immune Response Framework) is a specialized suite of tools designed to turn raw sequencing data from peptide-based assays into interpretable immune profiles. It provides a modular workflow for demultiplexing (Demux), calculating enrichment (Enrich), normalizing data (Z-score/Normalize), and attributing immune hits to specific pathogens or taxa (Deconv). Use this skill to navigate the specific CLI modules and parameters required for serological bioinformatics pipelines.

## Core Modules and CLI Usage

PepSIRF uses a subcommand-based interface: `pepsirf <module> [options]`.

### 1. Demultiplexing (Demux)
Used to assign raw FASTQ reads to specific samples and peptides based on index sequences.
- **Reference Independent Mode**: If an exact match at the index is not found, the read is discarded (index toggling is off).
- **Key Options**:
  - `--index1` / `--index2`: Specify index locations and lengths.
  - `-q <dir>`: Generate FASTQ-level outputs for each demultiplexed sample.
  - `--unmapped-reads-output <file>`: Save reads that failed to map to any sample/peptide for troubleshooting.
  - `--replicate_info <file>`: Output diagnostics regarding sample replicates.
  - `--seq`: Provide the expected sequence length; sequences shorter than this will trigger an error, while longer ones are truncated.

### 2. Enrichment Analysis (Enrich)
Identifies peptides that show a significant signal compared to controls or across multiple replicates.
- **Workflow**: Replaces the older `s_enrich` and `p_enrich` modules. It can analyze two or more replicates simultaneously.
- **Best Practices**:
  - Use `-l` or `--low_raw_reads` to automatically drop replicates that do not meet minimum read count thresholds.
  - Failed enrichments produce blank output files to maintain pipeline compatibility (e.g., with Qiime2).

### 3. Taxonomic Deconvolution (Deconv)
Attributes enriched peptide signals to specific TaxIDs to estimate which pathogens are being recognized by the immune system.
- **Thresholding**: Use `-t` followed by a tab-delimited file containing TaxIDs and specific score thresholds for each, or a single numeric value to apply globally.
- **Mapping**: Use `--custom_id_name_map_info <file> <key_col> <val_col>` to link TaxIDs to human-readable taxon names using custom tab-delimited metadata.
- **Sorting**: Tied species in the output are sorted alphabetically by name or numerically by TaxID.

### 4. Matrix Manipulation (Subjoin)
Used for filtering, merging, or subsetting score matrices.
- **Filtering**: The `-i` option accepts a regex pattern to filter sample or peptide names directly from the matrix.
- **Exclusion**: Use `--exclude` to output all data *except* the samples/peptides specified.

### 5. Data Normalization and Statistics
- **Z-score**: Normalizes data based on peptide bins. Ensure the bins provided match the dataset; the module includes a verification check to prevent running with mismatched bin sets.
- **Normalize**: General normalization of peptide scores.
- **Info**: Use `--rep_names <file> --get_avgs <file>` to generate a matrix of average counts across specified replicates.

## Expert Tips
- **Logging**: PepSIRF automatically generates log files named by module and timestamp. Use `--logfile <name>` to specify a custom path.
- **Parallelism**: On Linux/MacOS (non-ARM), PepSIRF utilizes OpenMP. If performance is slow, verify that OpenMP was correctly linked during installation.
- **Memory Management**: When working with large PhIP-Seq libraries, use the `Subjoin` module to remove unnecessary samples early in the pipeline to reduce the memory footprint of downstream normalization.



## Subcommands

| Command | Description |
|---------|-------------|
| bin | The bin module is used to create groups of peptides with similar starting abundances (i.e. bins), based on the normalized read counts for >= 1 negative controls. These bins can be provided as an input for zscore calculations using the zscore module. |
| deconv | The deconv module converts a list of enriched peptides into a parsimony-based list of likely taxa to which the assayed individual has likely been exposed. It supports both batch and singular modes. |
| demux | Peptide-based Serological Immune Response Framework demultiplexing module. This module takes parameters and outputs counts for each reference sequence (i.e. probe/peptide) for each sample. |
| enrich | The enrich module determines which peptides are enriched in samples that have been assayed in n-replicate, as determined by user-specified thresholds. |
| info | This module is used to gather information about a score matrix. By default, the number of samples and peptides in the matrix will be output. Additional flags may be provided to extract different types of information. Each of these flags should be accompanied by an output file name, to which the information be written. |
| link | The link module is used to create the "--linked" input file for the deconv module. The output file from this module defines linkages between taxonomic groups (or other groups of interest) and peptides based on shared kmers. |
| norm | Peptide-based Serological Immune Response Framework score normalization module. The norm module is used to normalize raw count data to allow for meaningful comparison among samples. |
| subjoin | The subjoin module is used to manipulate matrix files. This module can create a subset of an existing matrix, can combine multiple matrices together or perform a combination of these two functions. |
| zscore | The zscore module is used to calculate Z scores for each peptide in each sample. These Z scores represent the number of standard deviations away from the mean, with the mean and standard deviation both calculated separately for each bin of peptides. |

## Reference documentation
- [PepSIRF Changelog](./references/github_com_LadnerLab_PepSIRF_blob_master_CHANGELOG.md)
- [PepSIRF Main README](./references/github_com_LadnerLab_PepSIRF_blob_master_README.md)