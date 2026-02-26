---
name: kraken-biom
description: "kraken-biom converts Kraken taxonomic report files into BIOM format tables for downstream microbiome analysis. Use when user asks to create a BIOM table from Kraken reports, aggregate taxonomic counts at specific ranks, or integrate sample metadata into a metagenomic feature table."
homepage: https://github.com/smdabdoub/kraken-biom
---


# kraken-biom

## Overview
The `kraken-biom` tool is a utility designed to bridge the gap between Kraken taxonomic classifiers and microbiome analysis pipelines that utilize the BIOM (Biological Observation Matrix) format. It parses one or more Kraken report files, extracts counts for Operational Taxonomic Units (OTUs) based on specified taxonomic ranks, and generates a unified table. This is essential for researchers who want to perform diversity analysis, visualization, or statistical comparisons on metagenomic data classified by Kraken.

## Common CLI Patterns

### Basic Table Generation
To create a standard BIOM 2.1 (HDF5) table from multiple Kraken reports:
```bash
kraken-biom sample1_report.txt sample2_report.txt sample3_report.txt -o study_table.biom
```
*Note: Sample IDs are automatically derived from the filenames (everything before the first dot).*

### Adjusting Taxonomic Resolution
By default, the tool captures counts between the **Order (O)** and **Species (S)** levels. You can broaden or narrow this range using the `--max` and `--min` flags:
*   **Capture Class to Genus:**
    ```bash
    kraken-biom *.txt --max C --min G -o genus_level_table.biom
    ```
*   **Ranks available:** D (Domain), P (Phylum), C (Class), O (Order), F (Family), G (Genus), S (Species).

### Output Formats and Compression
Depending on your downstream tool, you may need different BIOM versions or flat files:
*   **JSON Format (BIOM v1.0):** Useful for older web-based visualizers.
    ```bash
    kraken-biom reports/*.txt --fmt json --gzip -o table.biom.gz
    ```
*   **TSV Format:** For manual inspection in spreadsheet software.
    ```bash
    kraken-biom reports/*.txt --fmt tsv -o table.tsv
    ```

### Integrating Metadata
To include sample metadata (e.g., treatment groups, pH, location) directly in the BIOM file:
```bash
kraken-biom reports/*.txt -m metadata_mapping.tsv -o annotated_table.biom
```
*Requirement: The first column of the metadata TSV must match the Sample IDs derived from the Kraken report filenames.*

## Expert Tips
*   **Rank Aggregation:** Any reads assigned at or below the `--min` rank are aggregated into that rank. For example, if `--min` is set to Genus (G), any species-level assignments are rolled up into their respective parent Genus.
*   **Missing HDF5 Support:** If the `h5py` library is missing in the environment, the tool will automatically fallback to BIOM v1.0 (JSON). If you specifically require HDF5, ensure `h5py` is installed.
*   **Taxonomy Strings:** The tool generates standard seven-level QIIME-style taxonomy strings (e.g., `k__Bacteria; p__Proteobacteria...`). If your downstream tool expects a different prefix or depth, you may need to post-process the BIOM row metadata.
*   **Batch Processing:** When dealing with hundreds of samples, use shell expansion (e.g., `path/to/reports/*.txt`) to pass all files to the positional `kraken_reports` argument.

## Reference documentation
- [GitHub Repository and Documentation](./references/github_com_smdabdoub_kraken-biom.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_kraken-biom_overview.md)