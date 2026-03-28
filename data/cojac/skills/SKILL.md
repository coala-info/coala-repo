---
name: cojac
description: "cojac identifies viral lineages in complex samples by analyzing the co-occurrence of mutations on the same sequencing reads. Use when user asks to scan alignments for viral variants of concern, identify co-occurring mutations in wastewater samples, or generate lineage definitions from covSPECTRUM."
homepage: https://github.com/cbg-ethz/cojac
---

# cojac

## Overview

The `cojac` (CoOccurrence adJusted Analysis and Calling) tool is a specialized bioinformatics suite designed to identify viral lineages in complex samples where multiple variants may coexist. Unlike standard variant callers that analyze single nucleotide variants (SNVs) in isolation, `cojac` leverages the fact that mutations belonging to the same viral haplotype will physically co-occur on the same sequencing read or read pair. This approach is particularly effective for the early detection of Variants of Concern (VoCs) in environmental samples like wastewater, providing a higher level of confidence than frequency-based SNV analysis alone.

## Command-Line Usage and Best Practices

### Core Workflow: Scanning Alignments
The primary command is `cooc-mutbamscan`. It scans alignment files against a set of variant definitions.

*   **Basic Scan**:
    `cojac cooc-mutbamscan -a sample.bam -r MN908947.3 -m ./voc_dir/ -o output.json`
*   **Batch Processing**: Use a V-pipe samples TSV to process multiple files at once.
    `cojac cooc-mutbamscan -s samples.tsv -p /path/to/workdir/ -r MN908947.3`

### Data Visualization and Export
Once a scan is complete (resulting in a JSON or YAML output), use the following tools to interpret the data:

*   **Terminal Visualization**: View a color-coded summary of co-occurrences directly in the console.
    `cojac cooc-colourmut results.json`
*   **Tabular Export**: Convert results to CSV or TSV for use in R, Python, or Excel.
    `cojac cooc-tabmut results.json --output results.csv`
*   **Publication Ready**: Generate tables formatted specifically for reports or papers.
    `cojac cooc-pubmut results.json`

### Variant Definition Management
`cojac` relies on external definitions of what mutations constitute a variant.

*   **Automated Generation**: Fetch mutation lists from covSPECTRUM to build new definitions.
    `cojac sig-generate --lineage B.1.1.7`
*   **UKHSA Integration**: Convert UK Health Security Agency standardized definitions into the format required by `cojac`.
    `cojac phe2cojac --input ukhsa_def.yml`

## Expert Tips

*   **Reference Matching**: Ensure the reference ID passed to `-r` (e.g., `MN908947.3`) matches the sequence name in your BAM/CRAM header exactly.
*   **Amplicon Coverage**: For `cojac` to be effective, the sequencing strategy must ensure that the entire amplicon of interest is covered by the read pairs. It is most powerful when analyzing "insert" regions where multiple mutations are expected to be found together.
*   **Quality Evaluation**: Use the experimental `cooc-curate` tool to evaluate the quality of your variant definitions by comparing them against global frequencies from covSPECTRUM.
*   **V-pipe Integration**: If using the V-pipe workflow, `cojac` can automatically locate alignment files using the `-s` (samples list) and `-p` (prefix) flags, significantly simplifying large-scale surveillance pipelines.



## Subcommands

| Command | Description |
|---------|-------------|
| cojac cooc-colourmut | Print coloured pretty table on terminal |
| cojac cooc-curate | Helps determining specific mutations and cooccurrences by querying covSPECTRUM |
| cojac cooc-mutbamscan | Scan amplicon (covered by long read pairs) for mutation cooccurrence |
| cojac generate-sigs-nextstrains | Generating a list of variants from nextstrain |
| cojac phe2cojac | convert phe-genomics to cojac's dedicated variant YAML format |
| cojac sig-generate | Helps generating a list of mutations frequently found in a variant by querying covSPECTRUM |
| cojac_cooc-pubmut | Calculates co-occurrence of mutations in published datasets. |

## Reference documentation
- [COJAC GitHub Repository](./references/github_com_cbg-ethz_cojac_blob_master_README.md)
- [Bioconda Cojac Overview](./references/anaconda_org_channels_bioconda_packages_cojac_overview.md)