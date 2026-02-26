---
name: clinvar-tsv
description: "clinvar-tsv automates the download and conversion of ClinVar XML data into flattened TSV files for easier analysis. Use when user asks to download ClinVar releases, convert ClinVar XML to TSV, or generate summary reports of clinical assertions."
homepage: https://github.com/bihealth/clinvar-tsv
---


# clinvar-tsv

## Overview

`clinvar-tsv` is a Snakemake-powered utility designed to streamline the acquisition and processing of ClinVar data. It automates the download of the latest ClinVar XML releases and transforms them into flattened TSV files, making the data accessible for standard Unix tools and custom scripts. The tool extracts important information from `<ReferenceClinVarAssertion>` entries and generates two distinct summary types: a standard ClinVar-like summary and a "paranoid" summary that treats all assessments equally regardless of whether the reporter provided assessment criteria.

## Installation

Install the tool via Bioconda:

```bash
conda install -c bioconda clinvar-tsv
```

## Common CLI Patterns

### Running the Full Pipeline
The primary way to use the tool is the `main` command, which handles downloading, parsing, sorting, and merging.

```bash
clinvar_tsv main \
    --cores 4 \
    --b37-path path/to/hs37d5.fa \
    --b38-path path/to/hs38.fa
```

### Manual XML Parsing
If you already have a ClinVar XML file and want to convert it to a "raw" TSV without running the full Snakemake workflow:

```bash
clinvar_tsv parse_xml \
    --input-xml ClinVarFullRelease_00-00.xml.gz \
    --output-tsv parsed_output.tsv
```

## Tool-Specific Best Practices

- **Reference Genomes**: Ensure you provide valid FASTA paths for both GRCh37 and GRCh38 if you are running the `main` workflow, as the tool generates files for both builds simultaneously.
- **Core Allocation**: Use the `--cores` argument to speed up the Snakemake workflow, especially during the parsing and sorting phases.
- **Output Interpretation**:
    - `summary_clinvar_*`: Use this for results that mirror the official ClinVar aggregate approach.
    - `summary_paranoid_*`: Use this for research contexts where you want to see all assessments weighted equally, including those without provided criteria.
- **Memory Management**: If processing large releases on memory-constrained systems, ensure you are using version 0.6.3 or later, which includes specific fixes for memory usage during normalization.
- **Version Control**: You can provide a specific ClinVar version using the `--clinvar-version` flag if the automated download needs to be pinned to a specific release.

## Reference documentation

- [clinvar-tsv GitHub Repository](./references/github_com_bihealth_clinvar-tsv.md)
- [clinvar-tsv Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_clinvar-tsv_overview.md)