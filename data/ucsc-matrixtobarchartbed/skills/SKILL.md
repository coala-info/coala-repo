---
name: ucsc-matrixtobarchartbed
description: The `matrixToBarChartBed` utility is part of the UCSC Kent toolkit.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---

# ucsc-matrixtobarchartbed

## Overview
The `matrixToBarChartBed` utility is part of the UCSC Kent toolkit. It transforms a standard expression matrix—where rows represent genomic features and columns represent samples or categories—into a specialized BED format compatible with the UCSC Genome Browser's bar chart track type. This is essential for researchers who want to visualize quantitative data (like RNA-seq expression levels or cell-type-specific activity) directly on the genome at specific loci.

## Command Line Usage

The basic syntax for the tool is:
```bash
matrixToBarChartBed [options] matrixFile bedFile outputBed
```

### Input Requirements
1.  **Matrix File**: A tab-separated file. The first column must contain identifiers that match the "name" column (column 4) of your BED file. The first row should contain labels for the samples/categories.
2.  **BED File**: A standard BED file (usually BED6 or BED12). The name field (column 4) must correspond to the row labels in your matrix.

### Common Patterns

**Basic Conversion**
To join a matrix of expression values to a BED file of gene coordinates:
```bash
matrixToBarChartBed expression_matrix.tsv genes.bed output_barchart.bed
```

**Handling Large Limits**
If your data contains a very large number of categories or samples, you may need to use the companion script `barChartMaxLimit` to ensure the browser can handle the resulting track.

## Best Practices and Expert Tips

*   **Identifier Matching**: Ensure that the IDs in your matrix exactly match the names in your BED file. If the BED file uses transcript IDs (e.g., ENST...) but the matrix uses gene symbols (e.g., GAPDH), the tool will fail to join the data.
*   **Coordinate Sorting**: While `matrixToBarChartBed` performs the join, it is best practice to run `bedSort` on the final output before converting it to a BigBed file for browser viewing.
*   **Visualization**: The output of this tool is typically converted to a BigBed file using `bedToBigBed` with a specific `.as` (AutoSql) file that defines the bar chart fields. This allows the UCSC Genome Browser to render the numerical columns as interactive bar charts.
*   **Data Normalization**: The tool does not normalize your data. Ensure your matrix contains pre-normalized values (e.g., TPM, FPKM, or Z-scores) appropriate for the visualization you intend to create.
*   **Permissions**: If running the binary directly from a download, remember to set execution permissions: `chmod +x matrixToBarChartBed`.

## Reference documentation
- [bioconda / ucsc-matrixtobarchartbed](./references/anaconda_org_channels_bioconda_packages_ucsc-matrixtobarchartbed_overview.md)
- [Index of /admin/exe/linux.x86_64](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)
- [Index of /admin/exe](./references/hgdownload_cse_ucsc_edu_admin_exe.md)