---
name: rebar
description: rebar (REcombination BARcode detector) is a specialized bioinformatics tool designed to identify and characterize genomic recombination.
homepage: https://github.com/phac-nml/rebar
---

# rebar

## Overview

rebar (REcombination BARcode detector) is a specialized bioinformatics tool designed to identify and characterize genomic recombination. It operates by scanning mutational barcodes to detect parental origins and breakpoint locations within a sequence. While it is optimized for SARS-CoV-2 lineage designation, its generalized clade assignment approach makes it applicable to any genomic dataset where recombination is suspected.

## Core Workflows

### 1. Dataset Management
Before running an analysis, you must download a reference dataset. rebar supports version-controlled datasets.

*   **Download SARS-CoV-2 data (by date):**
    ```bash
    rebar dataset download --name sars-cov-2 --tag 2023-11-30 --output-dir dataset/sars-cov-2
    ```
*   **Download a template/toy dataset:**
    ```bash
    rebar dataset download --name toy1 --tag custom --output-dir dataset/toy1
    ```

### 2. Running Recombination Detection
The `run` command performs the primary analysis. You can specify which populations to include or exclude using wildcards.

*   **Standard Run:**
    ```bash
    rebar run --dataset-dir dataset/sars-cov-2 --output-dir output/sars-cov-2
    ```
*   **Targeted Search (Specific Populations):**
    Use wildcards to include all sub-lineages or specific parents of interest.
    ```bash
    rebar run --dataset-dir dataset/sars-cov-2 --populations "AY.4.2*,BA.5.2,XBB.1.5.1" --output-dir output/targeted
    ```
*   **Customizing Sensitivity:**
    Adjust the minimum length of a recombinant region or mask specific sites.
    ```bash
    rebar run --dataset-dir dataset/toy1 --mask 0,0 --min-length 3 --output-dir output/toy1
    ```

### 3. Visualization and Interpretation
After a run, use the `plot` command to generate visual representations of substitutions and parental origins.

*   **Generate Plots:**
    ```bash
    rebar plot --run-dir output/sars-cov-2 --annotations dataset/sars-cov-2/annotations.tsv
    ```

## Output Analysis

*   **Linelist (`linelist.tsv`):** The primary summary. Check the `recombinant` column (true/false) and the `parents` column to identify the source lineages.
*   **Barcodes:** Located in the `barcodes/` directory, these files show the discriminating sites and mutations between the sample and its identified parents.
*   **Breakpoints:** Reported in the linelist as coordinate ranges (e.g., `12-12`) indicating where the parental origin shifts.

## Best Practices

*   **Hypothesis Testing:** Use the `--populations` flag to perform "knockout" experiments by excluding known lineages to see if rebar identifies alternative parental candidates.
*   **Validation:** Always check the `validate` and `validate_details` columns in the linelist. A "pass" indicates high confidence in the recombination detection.
*   **Masking:** If working with low-quality sequences or known problematic sites, use the `--mask` parameter to prevent false-positive recombination signals.
*   **Non-Recombinants:** rebar can be used for standard clade assignment; it will report the closest known match and any mutation conflicts even if no recombination is detected.

## Reference documentation
- [rebar GitHub Repository](./references/github_com_phac-nml_rebar.md)
- [rebar Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_rebar_overview.md)