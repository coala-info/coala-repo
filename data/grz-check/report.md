# grz-check CWL Generation Report

## grz-check

### Tool Description
Checks integrity of sequencing files (FASTQ, BAM).

### Metadata
- **Docker Image**: quay.io/biocontainers/grz-check:0.2.1--h3ec5717_0
- **Homepage**: https://github.com/BfArM-MVH/grz-tools/packages/grz-check
- **Package**: https://anaconda.org/channels/bioconda/packages/grz-check/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/grz-check/overview
- **Total Downloads**: 1.5K
- **Last updated**: 2025-12-04
- **GitHub**: https://github.com/BfArM-MVH/grz-tools
- **Stars**: N/A
### Original Help Text
```text
Checks integrity of sequencing files (FASTQ, BAM).

Use --fastq-paired for paired-end FASTQ, --fastq-single for single-end FASTQ, --bam for BAM files, or --raw for only calculating checksums of any file. These flags can be used multiple times.

By default, the tool will exit immediately after the first error is found. Use --continue-on-error to check all files regardless of errors.

Usage: grz-check [OPTIONS] --output <OUTPUT> <--fastq-paired <FQ1_PATH> <FQ2_PATH> <MIN_MEAN_READ_LEN>|--fastq-single <FQ_PATH> <MIN_MEAN_READ_LEN>|--bam <BAM_PATH>|--raw <FILE_PATH>>

Options:
      --show-progress <SHOW_PROGRESS>
          Flag to show progress bars during processing
          
          [possible values: true, false]

      --fastq-paired <FQ1_PATH> <FQ2_PATH> <MIN_MEAN_READ_LEN>
          A paired-end FASTQ sample. Provide FQ1, FQ2, and minimum mean read length. Read Length: >0 for fixed, <0 to skip length check

      --fastq-single <FQ_PATH> <MIN_MEAN_READ_LEN>
          A single-end FASTQ sample. Provide the file path and minimum mean read length. Read Length: >0 for fixed, <0 to skip length check

      --bam <BAM_PATH>
          A single BAM file to validate

      --raw <FILE_PATH>
          A file for which to only calculate the SHA256 checksum, skipping all other validation

      --output <OUTPUT>
          Path to write the output JSONL report

      --continue-on-error
          Continue processing all files even if an error is found

      --threads <THREADS>
          Number of threads to use for processing

  -h, --help
          Print help (see a summary with '-h')

  -V, --version
          Print version
```

