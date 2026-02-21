---
name: mpa-server
description: MetaProteomeAnalyzer (MPA) is a specialized platform for the interpretation of proteomics and metaproteomics identification results.
homepage: https://github.com/compomics/meta-proteome-analyzer
---

# mpa-server

## Overview

MetaProteomeAnalyzer (MPA) is a specialized platform for the interpretation of proteomics and metaproteomics identification results. It streamlines the processing of MS/MS spectrum data by integrating multiple search engines and providing sophisticated post-processing workflows. Key capabilities include False Discovery Rate (FDR) estimation, taxonomic and functional analysis, and the grouping of redundant protein hits into "meta-proteins" to simplify complex metaproteomic datasets.

## Command Line Interface (CLI) Usage

The CLI allows for high-throughput processing and integration into bioinformatics pipelines. When installed via Bioconda, the entry point is `mpa-portable`.

### Basic Execution Pattern

```bash
mpa-portable de.mpa.cli.CmdLineInterface \
  -spectrum_files "path/to/file1.mgf, path/to/file2.mgf" \
  -database path/to/database.fasta \
  -missed_cleav 1 \
  -prec_tol 10ppm \
  -frag_tol 0.5Da \
  -output_folder path/to/output/
```

### Mandatory Parameters

- `-spectrum_files`: A comma-separated list of MGF files. **Note**: The entire list must be enclosed in quotes if it contains multiple files or spaces.
- `-database`: Path to the FASTA protein sequence database.
- `-missed_cleav`: Maximum number of allowed missed cleavages (e.g., `1` or `2`).
- `-prec_tol`: Precursor tolerance. Specify units (e.g., `10ppm` or `0.5Da`).
- `-frag_tol`: Fragment ion tolerance (e.g., `0.5Da`).
- `-output_folder`: Directory where processed results will be exported.

### Search Engine Configuration

By default, only X!Tandem is enabled. Use these flags to toggle engines (1 for on, 0 for off):

- `-xtandem`: X!Tandem (Default: 1)
- `-comet`: Comet (Default: 0)
- `-msgf`: MS-GF+ (Default: 0)

### Metaprotein and Grouping Rules

Metaprotein generation (protein grouping) is enabled by default (`-generate_metaproteins 1`). You can refine how proteins are grouped:

- **Peptide Rule (`-peptide_rule`)**:
  - `0`: Share-one-peptide (Default)
  - `1`: Shared-peptide-subset
- **Taxonomy Rule (`-taxonomy_rule`)**: Groups proteins based on a specific taxonomic level.
  - `-1`: Off (Default)
  - `0` to `8`: Ranging from Superkingdom (`0`) to Species (`7`) or Subspecies (`8`).
- **Cluster Rule (`-cluster_rule`)**: Groups based on UniRef clusters.
  - `-1`: Off (Default)
  - `0`: UniRef100, `1`: UniRef90, `2`: UniRef50.

## Expert Tips and Best Practices

- **Memory Management**: If running the JAR directly via Java, always assign sufficient RAM using the `-Xmx` flag (e.g., `java -Xmx8g -cp ...`). Metaproteomics datasets often require 8GB to 16GB+ of RAM.
- **FDR Thresholding**: The default FDR is 5% (`-fdr_threshold 0.05`). For high-stringency publications, consider lowering this to 1% (`0.01`).
- **Fragmentation Methods**: When using MS-GF+, specify the fragmentation method via `-fragment_method` (1: CID, 2: HCD, 3: ETD). CID is the default.
- **Iterative Searching**: For complex samples, enable two-step searching using `-iterative_search`. Use `0` for protein-based or `1` for taxon-based iterative strategies.
- **Performance**: Use the `-threads` parameter to specify the number of CPU cores. By default, it uses all available cores.
- **Database Indexing**: Keep `-peptide_index 1` enabled to accelerate searches against large FASTA databases.

## Reference documentation

- [MetaProteomeAnalyzerCLI](./references/github_com_compomics_meta-proteome-analyzer_wiki_MetaProteomeAnalyzerCLI.md)
- [MetaProteomeAnalyzer GitHub README](./references/github_com_compomics_meta-proteome-analyzer.md)