---
name: radtk
description: radtk is a high-performance toolkit for managing, concatenating, inspecting, and partitioning RAD files used in single-cell transcriptomics workflows. Use when user asks to merge multiple RAD files, convert binary RAD files to JSON for inspection, or split a RAD file into multiple parts.
homepage: https://github.com/COMBINE-lab/radtk
---


# radtk

## Overview
The `radtk` toolkit is a high-performance utility written in Rust for managing RAD files, which are frequently generated in single-cell transcriptomics workflows (such as those using alevin-fry). This skill enables the efficient concatenation of data from different runs, the inspection of internal file tags and headers, and the partitioning of large datasets.

## Core Commands and Usage

### Concatenating RAD Files
Use the `cat` command to merge multiple RAD files into a single output file.
- **Requirement**: All input files must have compatible headers. This means they must be generated against the same reference and contain the identical tag set.
- **Pattern**: `radtk cat --input <file1.rad> <file2.rad> --output <merged.rad>`

### Inspecting RAD Content
Use the `view` command to transform the binary RAD format into a textual JSON format. This is essential for:
- Verifying header information.
- Inspecting specific records or quantities of interest.
- Debugging tag values within the file.
- **Pattern**: `radtk view <input.rad>`

### Splitting RAD Files
The `split` command allows for partitioning a RAD file into multiple parts.
- **Pattern**: `radtk split --input <input.rad> --output <output_directory>`
- **Tip**: Use the `--quiet` flag if you need to suppress progress bars during automated processing.

## Best Practices and Expert Tips
- **Header Validation**: Before attempting a `cat` operation, use `radtk view` on the first few hundred lines of each file to ensure the `ref_count` and `tag_set` match exactly.
- **JSON Processing**: Since `view` outputs JSON, pipe the output to `jq` for advanced filtering and searching of specific cell barcodes or UMI sequences.
- **Performance**: `radtk` is optimized for speed. When working with large datasets on high-core systems, the bottleneck is typically I/O rather than computation.
- **Reference Names**: The `view` command can resolve reference indices to names if the appropriate header information is present in the RAD file.

## Reference documentation
- [radtk - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_radtk_overview.md)
- [COMBINE-lab/radtk: Various tools for working with RAD files](./references/github_com_COMBINE-lab_radtk.md)
- [Commits · COMBINE-lab/radtk](./references/github_com_COMBINE-lab_radtk_commits_main.md)