---
name: sra-human-scrubber
description: The `sra-human-scrubber` (also known as the Human Read Removal Tool or HRRT) is a specialized utility designed to sanitize genomic data.
homepage: https://github.com/ncbi/sra-human-scrubber
---

# sra-human-scrubber

## Overview
The `sra-human-scrubber` (also known as the Human Read Removal Tool or HRRT) is a specialized utility designed to sanitize genomic data. It utilizes a k-mer based approach to identify reads of human origin. By default, the tool masks these reads with 'N' characters to preserve the original file structure and read counts, though it can also be configured to delete them entirely. This tool is a standard requirement for researchers submitting clinical metagenomic data to NCBI to ensure no identifiable human genetic information is inadvertently shared.

## Setup and Initialization
Before the tool can be used, the k-mer database must be downloaded and initialized.

1.  **Initialize Database**: Run the initialization script to fetch the latest pre-built database from the NCBI FTP server.
    ```bash
    ./init_db.sh
    ```
    *Note: The database is stored in the `data/` directory by default.*

2.  **Verify Installation**: Run the built-in test to ensure the environment and binaries are functioning correctly.
    ```bash
    ./scripts/scrub.sh -t
    ```

## Common CLI Patterns

### Standard Masking
The most common use case is masking human reads in a single FASTQ file. This creates a `.fastq.clean` file.
```bash
./scripts/scrub.sh input_file.fastq
```

### Removing Reads (Hard Filter)
If you prefer to remove the reads entirely rather than masking them with 'N', use the `-x` flag.
```bash
./scripts/scrub.sh -x -i input_file.fastq -o cleaned_output.fastq
```

### Processing Interleaved Paired-End Files
When working with interleaved files where you want both reads of a pair masked if either is identified as human, use the `-s` flag.
```bash
./scripts/scrub.sh -s -i interleaved.fastq
```

### Performance Optimization
The tool scales to use all available threads by default. To limit resource usage on shared systems, specify the thread count.
```bash
./scripts/scrub.sh -p 8 -i input.fastq
```

### Tracking Removed Data
To keep a record of exactly which reads were flagged as human for internal auditing, use the `-r` flag.
```bash
./scripts/scrub.sh -r -i input.fastq
```
*This generates an additional `.spots_removed` file containing the flagged sequences.*

## Expert Tips
- **Database Location**: If you are running the tool in a containerized or restricted environment, use the `-d` flag to point to a persistent database path to avoid re-downloading the large k-mer set.
- **Piping**: The tool supports `stdout` for integration into larger bioinformatics pipelines. Set `-o -` to pipe the cleaned FASTQ data to the next tool.
- **Aggressive Filtering**: Be aware that the tool is designed to be aggressive. It contains k-mers common to primates and other Eukaryotes to ensure maximum privacy, but it is tuned to be conservative regarding bacterial and viral pathogen sequences.
- **Memory Requirements**: Ensure the system has enough RAM to load the k-mer database; while the tool is efficient, the database is substantial.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_ncbi_sra-human-scrubber.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_sra-human-scrubber_overview.md)