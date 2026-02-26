---
name: ucsc-expmatrixtobarchartbed
description: The ucsc-expmatrixtobarchartbed tool converts expression data, metadata, and genomic coordinates into a BED file for UCSC Genome Browser bar chart visualization. Use when user asks to visualize gene expression data as bar charts on the UCSC Genome Browser, or prepare expression data for genomic visualization.
homepage: http://hgdownload.cse.ucsc.edu/admin/exe/
---


# ucsc-expmatrixtobarchartbed

## Overview
The `expMatrixToBarchartBed` utility is a specialized tool from the UCSC Kent toolkit used to bridge the gap between raw expression data and genomic visualization. It integrates three distinct data types—numerical expression values, sample-to-group mappings (metadata), and genomic locations—into a single `bed6+5` file. This output format is specifically designed for the UCSC Genome Browser's "barChart" track type, allowing researchers to see how gene expression varies across tissues, cell types, or experimental time points directly in the context of the genome.

## Command Line Usage

The tool typically follows this argument structure:

```bash
expMatrixToBarchartBed [options] matrix.tsv metadata.tsv coordinates.bed output.bed
```

### Required Inputs
1.  **Expression Matrix (`matrix.tsv`)**: A tab-separated file where the first column contains feature IDs (e.g., Gene IDs or Transcript IDs) and subsequent columns contain numerical expression values for each sample.
2.  **Metadata (`metadata.tsv`)**: A file that maps individual samples (columns in the matrix) to broader categories or groups. This determines how the bars are grouped and colored in the browser.
3.  **Coordinates (`coordinates.bed`)**: A standard BED file providing the `chrom`, `chromStart`, and `chromEnd` for every feature ID listed in the matrix.

### Common Options
*   `-maxLimit`: Sets the maximum value for the y-axis in the resulting bar charts.
*   `-verbose`: Enables detailed logging of the conversion process.

## Best Practices and Expert Tips

### Data Preparation
*   **ID Matching**: Ensure that the IDs in the first column of your expression matrix exactly match the "name" field (column 4) of your coordinates BED file. Mismatched IDs will result in features being dropped from the output.
*   **Matrix Header**: The first row of your matrix must contain sample names that correspond to the identifiers used in your metadata file.
*   **Coordinate Precision**: Use the same genome assembly (e.g., hg38, mm10) for your coordinates BED file as the one you intend to use on the Genome Browser.

### Workflow Integration
*   **Sorting**: The output of this tool is a BED file. If you intend to convert this to a `bigBed` file for high-performance hosting (using `bedToBigBed`), you must first sort the output by chromosome and start position using `bedSort`.
*   **BigBed Conversion**: When converting the output to BigBed, use the auto-sql (`.as`) file specifically designed for barCharts (often found in the UCSC source tree as `barChartBed.as`) to ensure the browser recognizes the extra fields correctly.

### Troubleshooting
*   **Permission Denied**: If running a freshly downloaded binary, ensure it is executable: `chmod +x expMatrixToBarchartBed`.
*   **Missing Features**: If genes are missing from your output, check for trailing whitespaces in your ID columns or differences in "chr" prefixing between your matrix and BED files.

## Reference documentation
- [ucsc-expmatrixtobarchartbed overview](./references/anaconda_org_channels_bioconda_packages_ucsc-expmatrixtobarchartbed_overview.md)
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Linux x86_64 Binary List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)