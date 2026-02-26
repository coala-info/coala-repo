---
name: cojac
description: "cojac identifies viral variants by analyzing the co-occurrence of mutations within individual sequencing reads. Use when user asks to scan alignment files for variant signatures, generate mutation definitions from covSPECTRUM, or format co-occurrence results into tables for analysis."
homepage: https://github.com/cbg-ethz/cojac
---


# cojac

## Overview
cojac (CoOccurrence adJusted Analysis and Calling) is a specialized suite of command-line tools designed to identify viral variants by analyzing the co-occurrence of mutations within individual sequencing reads (amplicons). While standard variant callers often look at mutations in isolation, cojac leverages the fact that certain mutations appear together on the same genomic fragment, providing higher confidence in lineage detection—especially in complex samples like wastewater where multiple variants coexist.

## Core Workflow
The standard workflow involves scanning alignment files against known variant signatures and then formatting the results for visualization or statistical analysis.

### 1. Scanning for Co-occurrences
Use `cooc-mutbamscan` to process your alignment files. This is the primary analysis step.
- **Basic Scan**: `cojac cooc-mutbamscan -a input.bam -r reference_name -V variant_definition.yaml -b amplicons.bed -j output.json`
- **Batch Processing**: Use the `@listfile` syntax to pass a large number of BAM files via a text file instead of listing them individually on the command line.
- **V-pipe Integration**: If working within a V-pipe directory structure, use `-s samples.tsv` and `-p prefix_path` to automate file discovery.

### 2. Formatting and Exporting Results
Once you have a JSON or YAML result file, use the following tools to interpret it:
- **Terminal Preview**: `cojac cooc-colourmut -a amplicons.yaml -j results.json` (displays a color-coded table in the terminal).
- **Publication-ready Tables**: `cojac cooc-pubmut -j results.json -o table.csv` (creates a CSV formatted for spreadsheets with linebreaks).
- **Data Analysis (R/Python)**: `cojac cooc-tabmut -j results.json -o data.csv` (exports a flat table suitable for downstream statistical processing).

## Expert Tips and Best Practices
- **Handle Overlapping Variants**: Use the `--fix-subset` (or `--fs`) flag during scanning. This prevents "double-counting" when one variant's mutation signature is a complete subset of another variant's signature.
- **Signature Generation**: Instead of writing variant definitions manually, use `cojac sig-generate` to query covSPECTRUM and generate signatures based on current global data.
- **Amplicon Validation**: Use `cojac cooc-curate` to evaluate the quality of your variant definitions by checking mutation frequencies against the covSPECTRUM database.
- **BED File Sorting**: Ensure your BED file is sorted by reference name and start position. Newer versions of cojac include a `--sort` flag (enabled by default) to handle this automatically.
- **Minimum Co-occurrences**: Adjust the `--cooc` parameter to set the minimum number of mutations that must co-occur on a single read to be counted toward a variant's presence.
- **Include Reverts**: Use the `--rev` flag if your variant definitions include "revert" categories to track mutations that have returned to the reference state.

## Reference documentation
- [cojac GitHub Repository](./references/github_com_cbg-ethz_cojac.md)
- [cojac Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_cojac_overview.md)