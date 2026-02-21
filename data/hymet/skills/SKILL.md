---
name: hymet
description: HYMET (Hybrid Metagenomic Tool) is designed for high-accuracy taxonomic identification in metagenomic datasets.
homepage: https://github.com/inesbmartins02/HYMET
---

# hymet

## Overview

HYMET (Hybrid Metagenomic Tool) is designed for high-accuracy taxonomic identification in metagenomic datasets. It utilizes a multi-stage pipeline: first, it uses Mash for rapid candidate filtering, followed by precise minimap2 alignment, and finally applies a weighted Lowest Common Ancestor (LCA) resolver to classify sequences. This tool is particularly useful for researchers needing to classify long reads or assembled contigs with a balance of computational efficiency and taxonomic precision.

## Installation and Setup

The most reliable way to use HYMET is via the Bioconda package, which provides the `hymet` and `hymet-config` wrappers.

```bash
# Install via conda
conda install -c bioconda hymet
```

### Database Preparation

HYMET requires specific reference Mash sketches and taxonomy files to function.

1.  **Download Sketches**: Obtain the required Mash sketches (`sketch1.msh`, `sketch2.msh`, `sketch3.msh`) from the official repository links.
2.  **Placement**: Place these files in a `data/` directory relative to your execution path.
3.  **Decompression**: Ensure the sketches are unzipped:
    ```bash
    gunzip data/*.msh.gz
    ```
4.  **Taxonomy Configuration**: Run the configuration utility to prepare the taxonomy hierarchy:
    ```bash
    hymet-config
    ```

## Command Line Usage

### Primary Classification

Once configured, run the main classification pipeline on your FASTA input files.

```bash
# Standard execution
hymet
```

### Input Requirements

*   **Format**: FASTA (`.fna` or `.fasta`).
*   **Structure**: The tool expects input files to be located in the directory defined by the environment or internal configuration (defaulting to an `input_dir/` structure if running from source).
*   **Headers**: Sequence IDs should be unique.

### Output Interpretation

The tool generates a `classified_sequences.tsv` file in the `output/` directory. Key columns include:

*   **Query**: The original sequence identifier.
*   **Lineage**: The full taxonomic path assigned to the sequence.
*   **Taxonomic Level**: The specific rank (e.g., species, genus) of the classification.
*   **Confidence**: A score between 0 and 1 indicating the reliability of the assignment.

## Expert Tips and Best Practices

*   **Hybrid Workflow**: HYMET is optimized for cases where Mash alone provides too many false positives and minimap2 alone is too computationally expensive for the entire database.
*   **Manual Path Overrides**: If using the source version instead of the Conda package, ensure `config.pl` and `main.pl` have execution permissions (`chmod +x`) and that the `scripts/` subdirectory is intact, as the Perl wrappers call Python and Bash scripts internally.
*   **Memory Management**: Since the tool involves Mash sketches and minimap2 alignments, ensure your environment has sufficient RAM to load the reference sketches into memory.
*   **Custom Datasets**: For benchmarking or case studies, refer to the `testdataset` folder in the source repository, which contains scripts like `create_database.py` and `extractTaxonomy.py` to build custom reference sets.

## Reference documentation

- [HYMET Overview - Bioconda](./references/anaconda_org_channels_bioconda_packages_hymet_overview.md)
- [HYMET Repository and Usage Guide](./references/github_com_inesbmartins02_HYMET.md)