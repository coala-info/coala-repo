---
name: tcdemux
description: tcdemux is a bioinformatics utility that streamlines the preprocessing of raw sequencing data for target capture pipelines.
homepage: https://github.com/TomHarrop/tcdemux
---

# tcdemux

## Overview

tcdemux is a bioinformatics utility that streamlines the preprocessing of raw sequencing data for target capture pipelines. It automates a multi-step workflow including barcode verification, internal demultiplexing (via cutadapt), read pairing verification, adaptor trimming, and low-complexity masking (via bbmap). It is particularly useful for handling libraries that are pooled with both external and internal barcodes.

## Sample Data Configuration

The tool requires a CSV file provided via the `--sample_data` argument. The structure of this file determines the processing mode.

### Standard Mode (External Barcodes Only)
Required fields: `name`, `i5_index`, `i7_index`, `r1_file`, `r2_file`.
Example CSV content:
i5_index,i7_index,name,r1_file,r2_file
AGCGCTAG,CCGCGGTT,sample1,sample1_r1.fastq,sample1_r2.fastq

### Pooled Mode (Internal Barcodes)
Required fields: `pool_name`, `i5_index`, `i7_index`, `name`, `internal_index_sequence`, `r1_file`, `r2_file`.
Example CSV content:
pool_name,i5_index,i7_index,name,internal_index_sequence,r1_file,r2_file
pool1,AGCGCTAG,CCGCGGTT,sample1,GTGACATC,pool_r1.fastq,pool_r2.fastq

### Naming Constraints
Sample names must strictly contain only:
- Uppercase or lowercase letters
- Digits
- Single underscores (double underscores `__` are prohibited)

## Command Line Usage

### Basic Execution
```bash
tcdemux --sample_data samples.csv \
        --read_directory ./raw_reads \
        --adaptors adaptors.fasta \
        --outdir ./processed_output
```

### Resource Management
The pipeline defaults to 5 threads and 8 GB RAM per sample. Adjust these for high-throughput environments:
- `--threads <int>`: Set total threads.
- `--mem_gb <int>`: Set total RAM in GB.

### Common Options
- `-n`: Perform a dry run to validate the sample sheet and file paths without executing the pipeline.
- `--keep_intermediate_files`: Retain files from intermediate steps (demux, trimming, etc.).
- `--restart_times <int>`: Number of times to restart failing jobs (default 0).

## Expert Tips

### Barcode Error Verification
tcdemux requires exact barcode matches and does not allow errors. If the Illumina workflow allowed barcode errors, tcdemux will discard those reads. You can check for barcode variability in your FASTQ headers using:
```bash
grep '^@' path/to/file.fastq | head -n 1000 | cut -d ':' -f10 | sort | uniq -c
```

### Output Files
For each sample, tcdemux generates:
- `<name>.r1.fastq.gz`: Processed forward reads.
- `<name>.r2.fastq.gz`: Processed reverse reads.
- `<name>.unpaired.fastq.gz`: Singletons generated during adaptor trimming.

## Reference documentation
- [tcdemux GitHub Repository](./references/github_com_TomHarrop_tcdemux.md)
- [tcdemux Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_tcdemux_overview.md)