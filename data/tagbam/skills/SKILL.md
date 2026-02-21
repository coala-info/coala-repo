---
name: tagbam
description: `tagbam` is a specialized utility designed to append a specific tag and value to every read in a BAM file.
homepage: https://github.com/fellen31/tagbam
---

# tagbam

## Overview
`tagbam` is a specialized utility designed to append a specific tag and value to every read in a BAM file. Written in Rust for high performance, it allows users to inject metadata directly into alignment records. This is particularly useful in bioinformatics workflows where reads need to be labeled with information not present in the original sequencer output, such as haplotype assignments (HP tag) or custom processing flags.

## Installation
The tool is available via Bioconda:
```bash
conda install bioconda::tagbam
```

## Command Line Usage

### Basic Syntax
The tool requires an input file, a tag name, a value, and an output destination.

```bash
tagbam --input <INPUT_BAM> --tag <TAG_NAME> --value <VALUE> --output-file <OUTPUT_BAM>
```

### Options and Parameters
- `-i, --input <INPUT>`: Path to the source BAM file.
- `-t, --threads <THREADS>`: Number of parallel decompression and writer threads. (Default: 4).
- `--tag <TAG>`: The 1-2 character tag name to be added (e.g., `HP`, `RG`, `XY`).
- `-v, --value <VALUE>`: The string or numeric value to associate with the tag.
- `-o, --output-file <OUTPUT_FILE>`: Path where the tagged BAM will be saved.
- `-c, --compression <COMPRESSION>`: BAM output compression level (0-9). (Default: 6).

### Example: Adding Haplotype Tags
To label all reads in a BAM file as belonging to Haplotype 1:
```bash
tagbam --tag HP --value 1 --input sample_input.bam --output-file sample_haplotype_1.bam
```

## Best Practices and Expert Tips

### Tag Naming Conventions
BAM tags must be exactly two characters long. While `tagbam` accepts 1-2 characters, it is best practice to use standard two-character tags to ensure compatibility with other SAMtools-compliant software. Common custom tags often start with `X`, `Y`, or `Z`.

### Performance Optimization
- **Threading**: For large datasets, increase the thread count (`-t`) to match your available CPU cores. Since BAM processing is often I/O bound, 4-8 threads are usually sufficient for most environments.
- **Compression**: If you are piping the output to another tool or performing intermediate steps, you can reduce the compression level (`-c 1`) to speed up the writing process at the cost of a larger file size. Use `-c 6` (default) or higher for long-term storage.

### Validation
After tagging, you can verify the tags were added correctly using `samtools view`:
```bash
samtools view out.bam | head -n 5
```
Look for your specified tag (e.g., `HP:i:1` or `XY:Z:value`) at the end of each alignment record.

## Reference documentation
- [tagbam GitHub Repository](./references/github_com_fellen31_tagbam.md)
- [Bioconda tagbam Overview](./references/anaconda_org_channels_bioconda_packages_tagbam_overview.md)