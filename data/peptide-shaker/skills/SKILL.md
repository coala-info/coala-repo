---
name: peptide-shaker
description: PeptideShaker aggregates and refines proteomics data by combining results from multiple search engines into a statistically validated identification set. Use when user asks to process search results, perform protein inference, re-score PTM localizations, or generate standardized proteomics reports.
homepage: https://compomics.github.io/projects/peptide-shaker.html
---


# peptide-shaker

## Overview
PeptideShaker is a search engine-independent platform designed to aggregate and refine proteomics data. It excels at combining results from various algorithms into a single, statistically validated identification set. Use this skill to navigate the complexities of protein inference, re-score post-translational modification (PTM) localizations, and generate standardized reports from raw search engine outputs.

## CLI Usage and Best Practices

### Core Command Structure
PeptideShaker is primarily executed via a Java Archive (JAR) file. The Command Line Interface (CLI) is essential for high-throughput pipelines.
```bash
java -jar PeptideShaker-X.Y.Z.jar eu.isas.peptideshaker.cmd.PeptideShakerCLI [options]
```

### Essential Input Requirements
To ensure successful processing and statistical validation, adhere to these data standards:
- **Search Results**: Supports formats from X!Tandem, MS-GF+, MS Amanda, Comet, Tide, Mascot (.dat), and mzIdentML.
- **Spectra**: Input files must be in `.mgf` or `.mzML` format. Ensure spectrum titles are unique.
- **Database**: You **must** use a concatenated target-decoy FASTA database (forward and reversed sequences) for PeptideShaker to perform FDR-based validation.

### Common CLI Patterns
- **Basic Processing**:
  Provide the project name, the search results folder (`-identification_files`), the spectrum files (`-spectrum_files`), and the FASTA database (`-fasta_file`).
- **Memory Management**:
  For large datasets, increase the Java heap space. Use at least 4GB for standard runs, and significantly more for large-scale experiments.
  ```bash
  java -Xmx8G -jar PeptideShaker-X.Y.Z.jar ...
  ```

### Expert Tips
- **SearchGUI Integration**: PeptideShaker works best when paired with SearchGUI. SearchGUI handles the initial search engine execution and produces a `.zip` output that PeptideShaker can ingest directly, preserving all search parameters.
- **Mascot Compatibility**: When using Mascot, do not use Mascot's internal "random decoy" option. Instead, use a pre-constructed forward-reverse database to ensure consistency across other search engines.
- **PTM Scoring**: PeptideShaker automatically re-calculates PTM localization scores (e.g., A-score or D-score). Ensure your input search results include the necessary peak intensity information in the spectrum files for accurate scoring.
- **Headless Environments**: When running on Linux servers without a GUI, ensure you are using the `PeptideShakerCLI` class to avoid errors related to graphics environments.

## Troubleshooting
- **Path Issues**: Avoid special characters (%, [, etc.) or spaces in file paths, especially on Linux systems.
- **Java Version**: Ensure Java 1.8 or newer is installed. Use a 64-bit Java Runtime Environment (JRE) to access more than 1500MB of RAM.
- **Memory Errors**: If the process hangs or throws `OutOfMemoryError`, check the `startup.log` in the `resources/conf` folder for specific failure points.

## Reference documentation
- [PeptideShaker Project Overview](./references/compomics_github_io_projects_peptide-shaker.html.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_peptide-shaker_overview.md)