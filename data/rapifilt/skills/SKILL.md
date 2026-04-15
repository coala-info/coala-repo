---
name: rapifilt
description: rapifilt is a high-performance utility used for quality filtering and trimming DNA sequences in FASTQ files. Use when user asks to filter low-quality sequences, trim bases based on quality thresholds, or remove reads that do not meet minimum length requirements.
homepage: https://github.com/andvides/RAPIFILT.git
metadata:
  docker_image: "quay.io/biocontainers/rapifilt:1.0--h5ca1c30_7"
---

# rapifilt

## Overview

rapifilt (RAPId FILTer) is a high-performance C-based utility designed for the preprocessing of DNA sequences. It provides a streamlined workflow for quality control by identifying and removing low-quality bases and filtering out sequences that do not meet minimum length requirements. This tool is particularly useful in bioinformatics pipelines where speed is essential for handling large datasets before downstream analysis like assembly or mapping.

## Command Line Usage

The basic syntax for rapifilt requires an input FASTQ file, thresholds for length and quality, and an output prefix.

```bash
rapifilt -fastq [input_file] -l [min_length] -r [quality_threshold] -o [output_prefix]
```

### Parameters

- `-fastq`: Path to the input DNA sequence file in FASTQ format.
- `-l`: Minimum length. Sequences shorter than this value after trimming will be moved to the "bad" file.
- `-r`: Quality threshold. Used to determine the trimming of low-quality bases.
- `-o`: Output prefix. This string will be used to name the three resulting files.

## Output Files

rapifilt automatically generates three distinct files based on the provided output prefix:

1.  `[prefix].fastq`: Contains the sequences that passed all quality and length filters.
2.  `[prefix]_bad.fastq`: Contains the sequences that were rejected or failed to meet the thresholds.
3.  `[prefix]_stat.txt`: Provides per-base statistics, useful for assessing the overall quality distribution of the library.

## Best Practices and Tips

- **Resource Efficiency**: Because rapifilt is written in C, it is highly efficient. It is preferred for initial QC passes on large-scale genomic data where more complex tools might be bottlenecked by memory or processing time.
- **Threshold Selection**: A common starting point for Illumina data is a length (`-l`) and quality (`-r`) threshold of 20, though this should be adjusted based on the specific requirements of your downstream aligner or assembler.
- **Stat Analysis**: Always review the `_stat.txt` file after a run. If the "bad" file is significantly larger than the filtered file, consider lowering the `-r` threshold or investigating the raw data for systematic sequencing errors.
- **Path Management**: Ensure the output prefix includes the desired directory path if you do not want the files generated in the current working directory.

## Reference documentation

- [RAPIFILT GitHub Repository](./references/github_com_andvides_RAPIFILT.md)
- [Bioconda rapifilt Package Overview](./references/anaconda_org_channels_bioconda_packages_rapifilt_overview.md)