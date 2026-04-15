---
name: mpa-portable
description: mpa-portable identifies and analyzes proteins within complex microbial communities by searching mass spectrometry data against FASTA databases. Use when user asks to identify proteins in metaproteomics data, calculate false discovery rates, or group redundant hits into meta-proteins.
homepage: https://github.com/compomics/meta-proteome-analyzer
metadata:
  docker_image: "quay.io/biocontainers/mpa-portable:2.0.0--0"
---

# mpa-portable

## Overview
The `mpa-portable` skill enables the automated identification and analysis of proteins within complex microbial communities. It streamlines the workflow of searching mass spectrometry data against FASTA databases, calculating False Discovery Rates (FDR), and grouping redundant hits into "meta-proteins." This skill is particularly useful for researchers needing a lightweight, standalone tool for metaproteomics that integrates multiple search algorithms and provides taxonomic and functional insights via a command-line interface.

## Command Line Interface (CLI) Usage

The tool is executed via Java. Ensure Java 1.8 is installed.

### Basic Execution Pattern
```bash
java -cp mpa-portable-X.Y.Z.jar de.mpa.cli.CmdLineInterface [parameters]
```
*Note: Replace `X.Y.Z` with the specific version (e.g., 2.0.0).*

### Mandatory Parameters
- `-spectrum_files`: Comma-separated list of MGF files. Wrap the entire list in quotes (e.g., `"file1.mgf, file2.mgf"`).
- `-database`: Path to the FASTA database (UniProtKB format recommended).
- `-missed_cleav`: Maximum allowed missed cleavages (e.g., `1`).
- `-prec_tol`: Precursor tolerance (e.g., `10ppm` or `0.5Da`).
- `-frag_tol`: Fragment ion tolerance (e.g., `0.5Da`).
- `-output_folder`: Directory for processed results.

### Search Engine Selection
By default, only X!Tandem is active. Use `1` to enable and `0` to disable:
- `-xtandem`: (Default: 1)
- `-comet`: (Default: 0)
- `-msgf`: (Default: 0)

### Advanced Analysis & Grouping
- **FDR Filtering**: Set the threshold with `-fdr_threshold` (Default: `0.05` for 5%).
- **Meta-Proteins**: Enable protein grouping with `-generate_metaproteins 1`.
- **Peptide Rule**: Define grouping logic with `-peptide_rule`:
  - `0`: Share-one-peptide (Default)
  - `1`: Shared-peptide-subset
- **Iterative Search**: Use `-iterative_search` for two-step strategies:
  - `0`: Protein-based
  - `1`: Taxon-based
- **Fragmentation**: Specify instrument method with `-fragment_method`:
  - `1`: CID (Default)
  - `2`: HCD
  - `3`: ETD

## Expert Tips & Best Practices
- **Memory Management**: For large metaproteomics datasets, increase the Java heap size using the `-Xmx` flag (e.g., `java -Xmx8g -cp ...`). 8GB to 16GB is recommended for complex samples.
- **Thread Optimization**: Use the `-threads` parameter to match your CPU core count for faster processing.
- **Database Indexing**: Keep `-peptide_index 1` (default) enabled to accelerate searches against large FASTA databases.
- **Taxonomy Rules**: When generating meta-proteins, use `-taxonomy_rule` (0-8) to group proteins at specific ranks (e.g., `6` for Genus, `7` for Species) to reduce redundancy in metaproteomic reports.

## Reference documentation
- [MetaProteomeAnalyzerCLI](./references/github_com_compomics_meta-proteome-analyzer_wiki_MetaProteomeAnalyzerCLI.md)
- [MzIdentML Import](./references/github_com_compomics_meta-proteome-analyzer_wiki_MzIdentML-Import.md)
- [MPA Overview](./references/github_com_compomics_meta-proteome-analyzer.md)