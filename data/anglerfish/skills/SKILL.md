---
name: anglerfish
description: Anglerfish identifies and demultiplexes Illumina-prepared libraries within Oxford Nanopore sequencing data. Use when user asks to demultiplex Illumina libraries sequenced on ONT flowcells, assess pool balancing, or identify unknown barcodes in sequencing runs.
homepage: https://github.com/remiolsen/anglerfish
---


# anglerfish

## Overview
Anglerfish is a specialized bioinformatics tool designed to identify and demultiplex Illumina-prepared libraries within Oxford Nanopore sequencing data. While Illumina libraries are typically sequenced on Illumina machines, sequencing them on ONT flowcells is a common strategy for rapid quality control. Anglerfish searches for specific Illumina adapter sequences and barcodes within the long, noisy Nanopore reads to partition data into sample-specific files and provide detailed statistics on the composition of the sequencing pool.

## Installation
The tool is available via Bioconda or PyPI:
```bash
conda install -c bioconda anglerfish
# OR
pip install bio-anglerfish
```
Note: On ARM64 (Apple Silicon), ensure `minimap2` is installed and available in your PATH before running the pip installation.

## Core Usage Patterns

### Standard Demultiplexing
The primary command is `run`, which requires a samplesheet and the input FASTQ data.
```bash
anglerfish run -s samples.csv -o analysis_output -t 8
```

### Quality Control (Counting Only)
If you only need to assess pool balancing or contamination without generating large demultiplexed FASTQ files, use the skip demux flag:
```bash
anglerfish run -s samples.csv --skip_demux
```

### Handling ONT Barcoded Runs
If your Illumina pool was itself loaded into an ONT barcoding kit (e.g., Native Barcoding), use the `-n` flag. This requires input files to be organized in `barcodeXX` folders as produced by MinKNOW.
```bash
anglerfish run -s samples_with_ont_barcodes.csv --ont_barcodes
```

## Samplesheet Configuration
The samplesheet is a CSV file with the following columns: `SampleName,AdaptorType,Barcode,FastqPath`.

### Common Adaptor Types
- `truseq`: Single index Illumina.
- `truseq_dual`: Dual index Illumina (e.g., `TAATGCGC-CAGGACGT`).

### Path Handling
- You can use wildcards in the path column: `P12345,truseq,CAGGACGT,/data/run_01/*.fastq.gz`
- Multiple samples can point to the same input file; Anglerfish will process the file once and look for all specified barcodes.

## Expert Tips and Best Practices

### Managing i5 Index Orientation
Illumina i5 indexes can be in different orientations depending on the sequencer used for the original library prep. If you are unsure of the orientation or seeing poor matches:
- Use `--lenient` (`-l`): This forces Anglerfish to check both orientations of the i5 barcode and select the one with significantly more matches. Use this with caution as it can increase the risk of false assignments in very similar index sets.

### Recovering "Undetermined" Reads
To identify what is in your sequencing pool that wasn't specified in your samplesheet:
- Use `--max-unknowns` (`-u`): Set this to a value (e.g., 20) to report the most frequent barcodes found that follow the adapter schema but aren't in your samplesheet.

### Tuning Sensitivity
- **Edit Distance**: By default, Anglerfish sets the maximum edit distance to 1 or 2 based on barcode length. You can override this with `--max-distance` (`-m`) if you have very low-quality reads or highly similar barcodes.
- **Exploration**: If you have a FASTQ file but no samplesheet, use the experimental `anglerfish explore` command to guess the adapter types and index lengths present in the data.

## Output Files
Anglerfish creates a timestamped directory containing:
- `*.fastq.gz`: The demultiplexed reads for each sample.
- `anglerfish_stats.txt`: A human-readable summary of the demultiplexing results.
- `anglerfish_stats.json`: Machine-readable statistics for integration into downstream pipelines.

## Reference documentation
- [Anglerfish GitHub Repository](./references/github_com_remiolsen_anglerfish.md)
- [Bioconda Anglerfish Package](./references/anaconda_org_channels_bioconda_packages_anglerfish_overview.md)