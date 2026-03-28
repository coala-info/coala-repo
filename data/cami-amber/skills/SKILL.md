---
name: cami-amber
description: "AMBER benchmarks metagenomic binning tools by comparing predictions against a gold standard to evaluate performance. Use when user asks to evaluate genome or taxonomic binning results, calculate completeness and contamination metrics, or generate comparative benchmarking reports for metagenomic binners."
homepage: https://github.com/CAMI-challenge/AMBER
---


# cami-amber

## Overview
AMBER (Assessment of Metagenome BinnERs) is a specialized tool designed to benchmark metagenomic binning tools. It compares one or more binning predictions against a "gold standard" ground truth. It is particularly useful for researchers developing new binning algorithms or those needing to select the best-performing tool for a specific dataset. AMBER handles both genome binning (grouping sequences into bins representing single genomes) and taxonomic binning (assigning sequences to specific taxonomic ranks).

## Core Workflow

### 1. Input Preparation
AMBER requires files in the **CAMI binning Bioboxes format** (tab-separated).
*   **Gold Standard (-g):** Must include `@@SEQUENCEID`, `BINID`, `TAXID`, and `LENGTH`.
*   **Binning Files:** One or more files from different programs. Must include `@@SEQUENCEID` and `BINID` (or `TAXID` for taxonomic binning).
*   **SampleID:** The `@SampleID` header tag must match between the gold standard and prediction files.

### 2. Basic Execution
To evaluate multiple binning results and generate an HTML report:
```bash
amber.py -g gold_standard.binning \
         -l "Tool_A,Tool_B" \
         -o output_directory/ \
         tool_a_results.binning tool_b_results.binning
```

### 3. Common CLI Patterns

**Filtering Small Bins**
Filter out the smallest genome bins (e.g., bottom 1%) to reduce noise in metrics:
```bash
amber.py -p 1 -g gsa.binning -o output/ predictions.binning
```

**Setting Quality Thresholds**
Define custom completeness and contamination levels for "recovered genomes" (default is 50, 70, 90 for completeness and 10, 5 for contamination):
```bash
amber.py -x 50,70,90 -y 10,5 -g gsa.binning -o output/ predictions.binning
```

**Taxonomic Binning Assessment**
Requires the NCBI `nodes.dmp` file to calculate UniFrac metrics:
```bash
amber.py --ncbi_dir /path/to/ncbi_taxdump/ -g gsa.binning -o output/ predictions.binning
```

### 4. Expert Tips
*   **Sequence Lengths:** If your gold standard is missing the `LENGTH` column, use the utility script `src/utils/add_length_column.py` to add it, as many metrics are length-weighted.
*   **FASTA Conversion:** If your binning output is a collection of FASTA files (one per bin), use `src/utils/convert_fasta_bins_to_biobox_format.py` to create the required Biobox input file.
*   **Multi-sample Datasets:** For datasets with multiple samples, concatenate the binnings of different samples into a single file per program. Ensure the `@SampleID` tags are correctly maintained for each segment within the file.



## Subcommands

| Command | Description |
|---------|-------------|
| AMBER | AMBER: Assessment of Metagenome BinnERs |
| add_length_column.py | Add length column _LENGTH to gold standard mapping and print mapping on the standard output |
| convert_fasta_bins_to_biobox_format.py | Convert bins in FASTA files to CAMI tsv format |

## Reference documentation
- [AMBER GitHub README](./references/github_com_CAMI-challenge_AMBER_blob_master_README.md)
- [AMBER CLI Reference (amber.py)](./references/github_com_CAMI-challenge_AMBER_blob_master_amber.py.md)