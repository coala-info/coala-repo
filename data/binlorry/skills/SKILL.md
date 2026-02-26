---
name: binlorry
description: "BinLorry is a utility for partitioning and filtering sequencing reads based on header attributes or external metadata. Use when user asks to bin reads by barcode, filter sequences by length, or subset data using a CSV metadata table."
homepage: https://github.com/rambaut/binlorry
---


# binlorry

## Overview
BinLorry is a flexible utility for bioinformaticians to organize and subset sequencing data. It allows for the partitioning of reads into distinct files (binning) or the removal of reads that do not meet specific criteria (filtering). The tool is highly effective for demultiplexing reads by barcode or extracting specific subsets of data based on metadata stored in external CSV files or directly within the read headers.

## Command Line Usage

### Basic Filtering and Binning
The primary syntax requires an input (file or directory) and an output prefix.

*   **Filter by length:**
    `binlorry -i input.fastq -o filtered_reads -n 500 -x 1000`
    (Extracts reads between 500 and 1000 nucleotides).

*   **Bin by header attribute:**
    `binlorry -i reads/ -o sample --bin-by barcode`
    (Groups reads into files like `sample_BC01.fastq`, `sample_BC02.fastq` based on the `barcode` field in the headers).

*   **Filter and Bin simultaneously:**
    `binlorry -i reads/ -o demux --bin-by barcode --filter-by barcode BC01 BC02`
    (Only outputs bins for BC01 and BC02, ignoring other barcodes).

### Using External Metadata (CSV)
If read headers do not contain the necessary attributes, provide a CSV index table where the first column matches the read names.

`binlorry -i my_file.fastq -t metadata.csv --filter-by reference Type_1 -o filtered`

### Recursive Directory Processing
BinLorry can process entire directories of sequencing files and metadata reports. When both `-i` and `-t` are directories, the tool matches FASTQ and CSV files based on their filename stems.

`binlorry -i ./fastq_dir -t ./csv_dir -o ./output/binned --bin-by barcode --out-report`

## Expert Tips and Best Practices

*   **Metadata Synchronization:** Always use the `--out-report` flag when filtering with an external CSV (`-t`). This generates a new CSV containing only the metadata for the reads that passed the filter, keeping your downstream analysis in sync.
*   **Performance Optimization:** For very large datasets, ensure your CSV index table includes file and line number columns if available; BinLorry can use these to improve lookup performance.
*   **Empty File Handling:** By default, BinLorry does not create files for bins that contain no reads. Use `--force-output` if your downstream pipeline requires the existence of all expected output files, even if they are empty.
*   **Header Parsing:** BinLorry expects attributes in headers to be formatted as `key=value` or similar standard conventions. If parsing fails, verify the delimiter used in your sequencing headers.
*   **Verbosity Levels:** Use `-v 2` or `-v 3` during initial pipeline setup to debug filtering logic and ensure the tool is correctly identifying the metadata fields.

## Reference documentation
- [BinLorry GitHub Repository](./references/github_com_rambaut_binlorry.md)
- [Bioconda BinLorry Package](./references/anaconda_org_channels_bioconda_packages_binlorry_overview.md)