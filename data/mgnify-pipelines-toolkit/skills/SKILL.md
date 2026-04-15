---
name: mgnify-pipelines-toolkit
description: The mgnify-pipelines-toolkit provides a collection of Python-based utilities and scripts designed to support MGnify production pipelines and metagenomic data processing. Use when user asks to extract ribosomal subunits, generate GenBank files, sort contig-gene-coordinate FASTA files, or normalize taxonomic data according to NCBI standards.
homepage: https://github.com/EBI-Metagenomics/mgnify-pipelines-toolkit
metadata:
  docker_image: "quay.io/biocontainers/mgnify-pipelines-toolkit:1.4.16--pyhdfd78af_0"
---

# mgnify-pipelines-toolkit

## Overview

The mgnify-pipelines-toolkit is a curated collection of Python-based utilities designed to support the EBI-Metagenomics (MGnify) production pipelines. It serves as a "glue" layer, providing scripts that are too specific for general-purpose bioinformatic packages but essential for metagenomic workflows. The toolkit is particularly useful for handling one-off production tasks, processing taxonomic assignments following NCBI updates, and performing specific file format conversions or sorting operations (like CGC FASTA sorting) without the overhead of bulky containers.

## Installation and Setup

The toolkit is available via standard bioinformatics channels.

*   **Bioconda (Recommended):** `conda install -c bioconda mgnify-pipelines-toolkit`
*   **PyPI:** `pip install mgnify-pipelines-toolkit`

Once installed, the scripts are available as direct command-line aliases.

## Common CLI Patterns and Tools

### Subunit Extraction
Use `get_subunits` to extract specific ribosomal subunits or other genomic regions based on coordinate files (e.g., from Easel).
```bash
get_subunits -i <coords_file> -n <sample_id>
```

### GenBank Generation
The `gbk_generator` script creates GenBank files from pipeline outputs, often used for downstream visualization or submission prep.
```bash
gbk_generator [options] -i <input_file> -o <output_gbk>
```

### Contig and Gene Operations (CGC)
The toolkit includes scripts for handling Contig-Gene-Coordinates (CGC). A key feature is the ability to sort output FASTA files to ensure deterministic pipeline results.
*   **Sorting:** Recent updates to the CGC scripts include automated sorting of output FASTA files to maintain consistency across runs.

### Taxonomic Data Handling
The toolkit is updated to handle major changes in the NCBI Taxonomy (specifically the March 2025 update).
*   **Domain vs. Superkingdom:** When processing study summaries or Krona-compatible contig taxa, ensure you are using the `d__` (domain) prefix instead of the legacy `sk__` (superkingdom) prefix.
*   **LSU Support:** The toolkit supports Large Subunit (LSU) taxids, which were previously excluded in older versions of the MGnify pipeline scripts.

## Expert Tips and Best Practices

*   **Alias Usage:** Always use the provided command-line aliases (e.g., `get_subunits`) rather than attempting to locate the script path within the `site-packages` directory.
*   **Empty Input Handling:** When using tools like `amrintegrator`, the toolkit is designed to handle empty inputs gracefully. If your pipeline step produces no hits, the toolkit scripts generally provide a safe exit or empty output rather than a crash.
*   **Taxonomy Consistency:** If you are working with legacy MGnify data, use the toolkit to normalize taxonomic strings to the new "domain" standard to ensure compatibility with modern visualization tools.
*   **Development:** If adding new scripts to the toolkit, they must include a `main()` function and be registered in the `[project.scripts]` section of the `pyproject.toml` to be accessible as aliases.

## Reference documentation

- [mgnify-pipelines-toolkit GitHub Repository](./references/github_com_EBI-Metagenomics_mgnify-pipelines-toolkit.md)
- [Toolkit Version History and Updates](./references/github_com_EBI-Metagenomics_mgnify-pipelines-toolkit_commits_main.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_mgnify-pipelines-toolkit_overview.md)