---
name: fast5seek
description: fast5seek identifies and locates raw fast5 signal files that correspond to read IDs provided in fastq, BAM, or SAM reference files. Use when user asks to find raw signal data for specific reads, subset fast5 files based on mapping results, or extract original signal files for a filtered set of sequences.
homepage: https://github.com/mbhall88/fast5seek
---


# fast5seek

## Overview
fast5seek is a specialized bioinformatics tool that maps sequence-level data back to its raw signal source. It extracts read IDs from provided reference files (fastq, BAM, or SAM) and recursively searches through fast5 directories to find the matching raw files. This allows researchers to isolate the original signal data for a specific subset of reads—such as those that mapped to a particular genomic region or passed specific quality filters—without manually searching through thousands of multi-fast5 or single-fast5 files.

## Command Line Usage

### Basic Syntax
The core workflow requires a directory of fast5 files and at least one reference file containing the read IDs of interest.

```bash
fast5seek -i /path/to/fast5_dir/ -r input.fastq -o matching_paths.txt
```

### Key Arguments
- `-i, --fast5_dir`: One or more directories containing fast5 files. The tool searches these recursively.
- `-r, --reference`: One or more fastq, BAM, or SAM files. Gzipped fastq files (.fq.gz) are supported.
- `-o, --output`: The file where paths will be written. If omitted, results are sent to STDOUT.
- `-m, --mapped`: When using BAM or SAM references, use this flag to only extract read IDs from records that are successfully mapped.

### Handling Multiple Inputs
You can provide multiple directories or reference files simultaneously using space-separated lists or shell wildcards.

```bash
fast5seek -i dir_alpha/ dir_beta/ -r sample1.bam sample2.fastq -o all_paths.txt
```

## Expert Tips and Best Practices

### Subsetting Raw Data
The most common use case is copying or moving the discovered fast5 files into a new directory for downstream processing. Use `xargs` to bridge fast5seek with standard filesystem tools:

```bash
# Create a subset directory and copy matching files into it
mkdir -p subset_fast5/
fast5seek -i /raw/fast5/ -r filtered_reads.fastq | xargs cp -t subset_fast5/
```

### Performance Optimization
Opening and reading headers from fast5 files is computationally expensive. 
1. **Save Results First**: Instead of piping directly into a heavy process, save the output of fast5seek to a text file. This ensures you have a record of the paths if the subsequent command fails.
2. **Filter References**: If you only care about mapped reads in a large BAM file, always use the `-m` flag to reduce the initial set of read IDs the tool needs to track.

### Troubleshooting Read IDs
If the tool returns fewer matches than expected, ensure that the read IDs in your reference files exactly match the internal read IDs stored in the fast5 attributes. Some basecallers or processing pipelines may append metadata to read headers in fastq files which can occasionally cause mismatches if not handled by the parser.

## Reference documentation
- [fast5seek GitHub Repository](./references/github_com_mbhall88_fast5seek.md)
- [fast5seek Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_fast5seek_overview.md)