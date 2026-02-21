---
name: asqcan
description: asqcan is a specialized pipeline designed to automate the transition from raw bacterial sequencing reads to fully annotated genomes.
homepage: https://github.com/bogemad/asqcan
---

# asqcan

## Overview
asqcan is a specialized pipeline designed to automate the transition from raw bacterial sequencing reads to fully annotated genomes. It integrates several industry-standard bioinformatics tools—FastQC, SPAdes, QUAST, BlobTools, and Prokka—into a single execution path. This skill is ideal for researchers handling multiple bacterial isolates who need a consistent, reproducible workflow for assembly and quality control without manually chaining individual command-line tools.

## Core Workflow and Capabilities
The pipeline executes the following stages in sequence for every FASTQ file found in the input directory:
1. **Raw Read QC**: Quality analysis via FastQC.
2. **Assembly**: De novo genome assembly using SPAdes.
3. **Assembly QC**: Statistical assessment of the assembly via QUAST.
4. **Contamination Check**: Visualization and analysis of potential contaminants using BlobTools.
5. **Functional Annotation**: Automated gene calling and functional assignment via Prokka.

## Command Line Usage

### Basic Execution
To run the pipeline on a directory of interleaved FASTQ files:
```bash
asqcan -q /path/to/reads_dir -o /path/to/output_dir
```

### High-Performance Configuration
For large datasets, utilize the threading option to speed up SPAdes and Prokka:
```bash
asqcan -q ./reads -o ./results -t 16
```

### Enhanced Contamination Analysis
To get the most out of BlobTools (BlobPlots and similarity tables), provide a path to a local NCBI `nt` BLAST database:
```bash
asqcan -q ./reads -o ./results -b /path/to/blast_db/nt
```

## Expert Tips and Best Practices
- **Input Requirements**: asqcan expects **interleaved** FASTQ files (where forward and reverse reads are in the same file). It supports both `.fastq` and `.fastq.gz` formats.
- **Idempotency and Resuming**: The tool generates a report file named `asqcan_report.tsv`. It automatically detects successful steps from previous runs; if a run is interrupted, simply re-run the same command to resume from the last failed step.
- **Log Monitoring**: Detailed execution data is stored in `asqcan.log` within the output directory. If a specific isolate fails, check this log to identify which sub-tool (e.g., SPAdes or Prokka) encountered the error.
- **Force Overwrite**: If you have updated your input files or want to re-run a completed pipeline from scratch, use the `-f` or `--force` flag to overwrite existing results in the output directory.
- **BLAST Database**: While the `-b` flag is optional, omitting it significantly reduces the utility of the BlobTools output, as similarity data is required to accurately identify the taxonomic origin of contigs.

## Reference documentation
- [asqcan GitHub Repository](./references/github_com_bogemad_asqcan.md)
- [asqcan Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_asqcan_overview.md)