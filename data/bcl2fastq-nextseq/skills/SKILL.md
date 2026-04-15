---
name: bcl2fastq-nextseq
description: This tool converts raw Illumina NextSeq sequencing data into merged FASTQ files while handling platform-specific index orientations and file cleanup. Use when user asks to convert BCL files to FASTQ, demultiplex NextSeq runs, reverse complement index sequences, or merge lane-specific sequencing files.
homepage: https://github.com/brwnj/bcl2fastq
metadata:
  docker_image: "quay.io/biocontainers/bcl2fastq-nextseq:1.3.0--pyh5e36f6f_0"
---

# bcl2fastq-nextseq

## Overview
The `bcl2fastq-nextseq` skill provides a streamlined workflow for processing raw sequencing data from Illumina NextSeq platforms. While standard Illumina tools often produce separate files for each lane, this tool automatically merges those lanes into single R1 and R2 files per sample. It also handles common NextSeq-specific tasks such as reverse-complementing the second index and cleaning up intermediate files or "Undetermined" reads to save storage space.

## Command Line Usage

The primary command provided by this package is `bcl_to_fastq`.

### Basic Conversion
Run the conversion from within the run folder containing the `SampleSheet.csv`:
```bash
bcl_to_fastq
```

### Common Options
- `--runfolder <path>`: Specify the path to the directory containing run data (defaults to current directory).
- `--reverse-complement`: Reverse complement index 2 in the sample sheet. This is frequently required for specific NextSeq library preps.
- `--barcode-mismatches <int>`: Number of allowed mismatches per index (default is 0).
- `--processing <int>`: Set the number of threads used for processing demultiplexed data (default is 24).
- `--keep-tmp`: Use this flag if you want to keep the individual lane files and "Undetermined" reads, which are deleted by default upon success.

### Performance Tuning
You can fine-tune the threading model based on your hardware:
```bash
bcl_to_fastq --loading 12 --demultiplexing 12 --processing 48 --writing 12
```

## Best Practices and Tips

### Sample Sheet Preparation
- The tool creates a backup of your original sample sheet as `SampleSheet.csv.bak` before making any necessary modifications (like reverse complementing).
- Ensure your `SampleSheet.csv` is in the root of the run folder or specified correctly via the environment.

### Output Structure
- **Fastq Files**: Located in `[RunFolder]/Data/Intensities/BaseCalls/`.
- **Logs**: A detailed log of the underlying `bcl2fastq` call is saved to `bcl2fastq.log`.
- **Stats**: Demultiplexing statistics are summarized in `demultiplexing_stats.csv`.
- **Sample List**: A file named `SAMPLES` is created in the output directory listing all processed sample IDs.

### Automation and Completion
- By default, the tool checks for the completion status of the run. Use `--no-wait` if you are running the tool on a dataset that is already confirmed to be complete and you want to bypass the check for `RTAComplete.txt`.
- If you are processing data from NextSeq 1000/2000 platforms, ensure you are using version 1.3.0 or later to account for specific platform differences.

## Reference documentation
- [NextSeq specific bcl2fastq2 wrapper](./references/github_com_brwnj_bcl2fastq.md)
- [bcl2fastq-nextseq bioconda overview](./references/anaconda_org_channels_bioconda_packages_bcl2fastq-nextseq_overview.md)