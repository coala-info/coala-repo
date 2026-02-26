---
name: ucsc-catdir
description: The `ucsc-catdir` utility merges the content of all files within a specified directory into a single stream. Use when user asks to merge files from a directory, combine data from multiple files, or pipe the aggregated content to another tool.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---


# ucsc-catdir

## Overview
The `catDir` utility is a specialized tool from the UCSC Genome Browser "kent" suite designed to simplify the process of merging multiple files. While standard shell commands like `cat *` can achieve similar results, `catDir` is optimized for directory-level operations within bioinformatics pipelines. It reads every file in a specified directory and writes their combined content to standard output (stdout), making it a reliable component for data aggregation tasks where file order and stream integrity are important.

## Usage Instructions

### Basic Command
To stream the contents of all files in a directory to your terminal:
```bash
catDir [directory_path]
```

### Merging Files
The most common use case is redirecting the output to a new file to create a unified dataset:
```bash
catDir path/to/input_dir > combined_data.txt
```

### Piping to Downstream Tools
You can use `catDir` to feed data directly into other analysis tools without creating intermediate files on disk:
```bash
catDir path/to/input_dir | grep "target_sequence"
```

## Expert Tips and Best Practices

### Execution Permissions
If you have downloaded the binary directly from the UCSC server rather than installing via a package manager like Conda, you must ensure the file has execution permissions:
```bash
chmod +x ./catDir
./catDir [directory]
```

### Handling Large Datasets
When working with massive genomic files, always prefer piping `catDir` output directly into the next tool in your pipeline. This minimizes disk I/O and saves storage space by avoiding the creation of large concatenated intermediate files.

### File Ordering
`catDir` typically processes files in the order they are listed by the file system. If your analysis requires a specific sequence (e.g., by chromosome number or timestamp), ensure the files are named in a way that maintains that order (using leading zeros like `chr01`, `chr02`) or verify the directory's sort order before running the command.

### Verification
After concatenation, it is a best practice to verify the integrity of the merge by comparing the total line count of the source directory against the output file:
```bash
# Count lines in all source files
find [directory] -type f | xargs wc -l
# Compare with output
wc -l combined_data.txt
```

## Reference documentation
- [ucsc-catdir Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-catdir_overview.md)
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)