---
name: viralrecall
description: ViralRecall detects giant viruses and Mirusviruses integrated into eukaryotic host genomes. Use when user asks to 'set up the HMM database', 'scan genomes for viral signatures', 'adjust detection sensitivity or stringency', or 'filter small contigs'.
homepage: https://github.com/abdealijivaji/ViralRecall_3.0
---


# viralrecall

## Overview

ViralRecall is a specialized bioinformatic tool designed to detect giant viruses (and Mirusviruses) integrated into eukaryotic host genomes. It leverages the Giant Virus Orthologous Groups (GVOG) HMM database to scan genomic sequences for viral signatures. It is particularly useful for analyzing large eukaryotic genomes generated via long-read sequencing where endogenous viral elements may be present. Use this skill to navigate the database setup, execute single or batch genomic scans, and adjust detection stringency based on specific research needs.

## Database Setup

Before running predictions, you must download and set up the HMM database.

```bash
# Download to a specific directory (recommended)
viralrecall_database -d /path/to/database_dir -n viralrecall_db
```

Alternatively, manual download is possible via wget from the Zenodo repository (records/17859729).

## Common CLI Patterns

### Basic Execution
Run a standard scan on a single eukaryotic genome:
```bash
viralrecall -i genome.fasta -o output_dir -d /path/to/viralrecall_db
```

### Batch Processing
ViralRecall automatically detects if the input is a directory and runs in batch mode. Use the `-c` flag to specify the number of genomes to process in parallel.
```bash
viralrecall -i ./genomes_folder/ -o batch_output -d /path/to/viralrecall_db -c 8
```

### Adjusting Detection Sensitivity
If the default parameters are too stringent or too relaxed, modify the following:

*   **Increase Sensitivity**: Lower the minimum score (`-s`) or the minimum unique GVOG hits (`-g`).
    ```bash
    viralrecall -i genome.fasta -o sensitive_out -d ./db -s 7 -g 3
    ```
*   **Increase Stringency**: Raise the rolling average threshold or the unique hit requirement.
    ```bash
    viralrecall -i genome.fasta -o strict_out -d ./db -s 15 -g 6
    ```
*   **Filter Small Contigs**: Use `-m` to ignore small fragments that might produce false positives.
    ```bash
    viralrecall -i genome.fasta -o filtered_out -d ./db -m 50
    ```

## Expert Tips and Best Practices

*   **Mirusvirus Detection**: Version 3.0 includes HMMs for Mirusvirus hallmark proteins. While integrated, this feature is experimental; any Mirusvirus hits should be manually verified.
*   **Window Size**: The default sliding window (`-w`) is 15kb. For highly fragmented assemblies, consider reducing this size, though it may increase noise.
*   **Output Analysis**:
    *   Check the `.tsv` file for the full annotation table, which includes NCVOG descriptions for GVOG hits.
    *   The `.gbk` (GenBank) files produced by the internal Pyrodigal step are full-format and compatible with most genome visualizers.
*   **Memory Management**: When running in batch mode with `-c`, ensure the system has enough RAM to support multiple HMMsearch processes simultaneously, as eukaryotic genomes can be memory-intensive.

## Reference documentation
- [ViralRecall 3.0 GitHub Repository](./references/github_com_abdealijivaji_ViralRecall_3.0.md)
- [Bioconda ViralRecall Overview](./references/anaconda_org_channels_bioconda_packages_viralrecall_overview.md)