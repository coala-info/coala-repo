---
name: sage-proteomics
description: Sage is a high-speed proteomics search engine designed to transform raw mass spectrometry data into peptide identifications.
homepage: https://github.com/lazear/sage
---

# sage-proteomics

## Overview

Sage is a high-speed proteomics search engine designed to transform raw mass spectrometry data into peptide identifications. It integrates several advanced features into a single tool, including retention time prediction, label-free (LFQ) and isobaric quantification, and False Discovery Rate (FDR) estimation. Use this skill to configure search parameters, manage large-scale data processing, and optimize search speeds using Sage's fragment indexing and parallel processing capabilities.

## Installation and Setup

Install Sage via Bioconda for the most stable environment:

```bash
conda install bioconda::sage-proteomics
```

## Core CLI Usage

Sage primarily operates using a JSON configuration file that defines search parameters, modifications, and quantification settings.

### Running a Search
Execute a search by passing the configuration file as the primary argument:
```bash
sage config.json
```

### Index Management
For large databases or repetitive searches, use indexing to save time:
- **Generate and save an index**: Use the `--save-index` flag during the initial run.
- **Load an existing index**: Use the `--load-index` flag to skip the database indexing phase.
- **Validate an index**: Use `--validate-index` to ensure the integrity of a pre-built index.

## Configuration Best Practices

### Database and Digestion
- **Missed Cleavages**: Limit `missed_cleavages` to 2 or fewer to prevent excessive memory usage and search time.
- **Decoy Generation**: Ensure `generate_decoys` is set to `true` if your FASTA file does not already contain decoy sequences. Sage requires decoys for its built-in FDR and LDA rescoring.

### Search Parameters
- **Precursor Tolerance**: Sage supports both narrow and open searches (> 500 Da).
- **Fragment Tolerance**: Specify tolerances in Da or ppm depending on the instrument resolution.
- **Chimeric Spectra**: Enable support for co-fragmenting spectra in the configuration to increase identification rates in complex samples.

### Quantification
- **LFQ**: Configure `lfq_settings` to perform label-free quantification across all charge states and isotopologues.
- **Isobaric**: Use for TMT (MS2/MS3) or custom reporter ions.
- **Peptide Q-Value**: Use `lfq_settings.peptide_q_value` to control the threshold for peptides included in quantification.

## Expert Tips and Performance

- **Parallelism**: Sage automatically utilizes all available CPU cores. Ensure the execution environment has sufficient threads allocated.
- **Cloud Integration**: Sage can stream data directly to and from AWS S3. Use S3 URIs (e.g., `s3://bucket/file.mzML`) in the configuration file to minimize local storage requirements.
- **Output Formats**: Sage produces results in TSV format by default, which is compatible with downstream tools like Percolator, Mokapot, and PeptideShaker.
- **Memory Management**: If encountering stack overflows or memory issues, reduce the number of variable modifications or the allowed number of missed cleavages.

## Reference documentation
- [Sage Overview and Features](./references/github_com_lazear_sage.md)
- [Bioconda Installation](./references/anaconda_org_channels_bioconda_packages_sage-proteomics_overview.md)
- [Known Issues and CLI Flags](./references/github_com_lazear_sage_issues.md)