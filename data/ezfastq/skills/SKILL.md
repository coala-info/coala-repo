---
name: ezfastq
description: `ezfastq` is a specialized utility for bioinformaticians to automate the discovery and organization of FASTQ files.
homepage: https://github.com/bioforensics/ezfastq/
---

# ezfastq

## Overview

`ezfastq` is a specialized utility for bioinformaticians to automate the discovery and organization of FASTQ files. It eliminates the need for manual searching or complex shell scripts by scanning a source directory for files matching a provided list of sample names. It then aggregates these files into a specified destination directory, handling paired-end detection and file management automatically.

## Common CLI Patterns

### Basic Sample Extraction
To pull specific samples from a data repository into a local working directory:
```bash
ezfastq /path/to/sequencing/data/ sampleA sampleB sampleC --workdir=./analysis_ready/
```

### Batch Processing with Sample Lists
For large projects, provide a text file containing one sample name per line:
```bash
ezfastq /opt/sequencing_runs/ samples_to_analyze.txt --workdir=project_workspace/
```

### Space-Efficient Staging (Symlinking)
Instead of copying large FASTQ files, use symbolic links to save disk space and time:
```bash
ezfastq /path/to/data/ samples.txt --workdir=out/ --symlink
```

### Integrity Verification
Ensure files are transferred correctly by enabling checksum verification:
```bash
ezfastq /path/to/data/ samples.txt --workdir=out/ --checksum
```

## Expert Tips

- **Sample Naming**: The tool matches sample names against filenames. Ensure your sample names are specific enough to avoid catching unintended files (e.g., "Sample1" might match "Sample10" if not handled carefully by the underlying regex).
- **Paired-End Detection**: `ezfastq` automatically detects R1/R2 pairs. You do not need to specify suffixes like `_R1.fastq.gz` in your sample list; just provide the base sample ID.
- **Subdirectory Scanning**: The tool recursively searches the source directory, making it effective for data organized in nested folder structures (e.g., Illumina BaseSpace exports).
- **Python Integration**: For custom workflows, you can use the API directly:
  ```python
  import ezfastq
  ezfastq.api.copy(["sample1", "sample2"], "/source/path", workdir="/dest/path")
  ```

## Reference documentation

- [ezfastq README](./references/github_com_bioforensics_ezfastq.md)
- [ezfastq Project Overview](./references/anaconda_org_channels_bioconda_packages_ezfastq_overview.md)