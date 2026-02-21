---
name: slamdunk
description: Slamdunk is a specialized bioinformatics pipeline designed to streamline the analysis of SLAMseq data.
homepage: http://t-neumann.github.io/slamdunk
---

# slamdunk

## Overview
Slamdunk is a specialized bioinformatics pipeline designed to streamline the analysis of SLAMseq data. It automates the detection of 4-thiouridine (4sU) incorporation events by identifying T>C conversions in high-throughput sequencing reads. By distinguishing metabolic labeling events from the background, it enables the study of intracellular RNA dynamics, including transcription rates and RNA stability. The tool integrates mapping (via NextGenMap), filtering, SNP calling (to exclude genomic T>C variants), and UTR-based quantification.

## Core Workflow: The "All" Dunk
The most efficient way to process SLAMseq data is using the `all` module, which executes the entire pipeline (map, filter, snp, and count) in one command.

### Standard Execution
```bash
slamdunk all -r <reference.fasta> -b <utr_coordinates.bed> -o <output_dir> -t <threads> -m -rl <read_length> <input_files>
```

### Key Parameters
- `-r`: Reference genome in FASTA format.
- `-b`: BED file containing 3' UTR coordinates. This is critical as Slamdunk focuses on UTR-specific signal.
- `-o`: Output directory for all intermediate and final results.
- `-t`: Number of threads. Note that NextGenMap is multi-threaded; it is recommended to use more threads than the number of samples.
- `-m`: **Multimapper reconciliation**. Highly recommended. It reassigns reads mapping to both a 3' UTR and a non-UTR region to the UTR, increasing signal sensitivity.
- `-5`: Number of bases to trim from the 5' end (default is often 12 for QuantSeq).
- `-n`: Maximum number of mismatches allowed in the alignment.

## Quality Control with Alleyoop
After running the main pipeline, use the `alleyoop` utility to perform sanity checks and generate diagnostic plots.

### UTR Conversion Rates
To verify if the metabolic labeling was successful and check for biases:
```bash
alleyoop utrrates -o <plot_dir> -r <reference.fasta> -b <utr_coordinates.bed> -l <read_length> <filter_folder/*.bam>
```

### Other Alleyoop Modules
- `rates`: General conversion rates to check T>C excess.
- `tcperreadpos`: Check if T>C conversions are evenly distributed across read positions (to identify sequencing artifacts).
- `tcperutrpos`: Check T>C distribution across UTR positions.

## Data Formats and Best Practices

### Input Samplesheet
Instead of listing every file, you can provide a tab-separated (TSV) or comma-separated (CSV) samplesheet:
- **Column 1**: Path to raw reads (BAM/FASTQ/FASTA).
- **Column 2**: Sample description.
- **Column 3**: Sample type (e.g., pulse/chase).
- **Column 4**: Timepoint (in minutes).

### Understanding Tcount Output
The primary output is the `.tcount` file. Key columns for downstream analysis:
- `conversionRate`: The average T>C conversion rate for the UTR, normalized by T-content and coverage.
- `readsCPM`: Normalized read counts (Counts Per Million).
- `coverageOnTs`: Total number of T-positions covered by reads.
- `conversionsOnTs`: Total number of T>C conversions detected.

### Expert Tips
1. **Strand Specificity**: Slamdunk is designed for strand-specific assays (like QuantSeq). It only considers sense reads for the final analysis.
2. **SNP Filtering**: Slamdunk automatically runs a SNP calling step to ensure that genomic T>C mutations are not miscounted as metabolic labeling events.
3. **MultiQC Integration**: Slamdunk results are compatible with MultiQC (v0.9+). Run `multiqc .` in your output directory to aggregate all "dunk" statistics into a single report.

## Reference documentation
- [Slamdunk Documentation](./references/t-neumann_github_io_slamdunk_docs.html.md)
- [Slamdunk Home](./references/t-neumann_github_io_slamdunk.md)