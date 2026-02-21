---
name: cctyper
description: cctyper (CRISPRCasTyper) is a comprehensive bioinformatic pipeline that identifies CRISPR-Cas loci by integrating Cas gene detection with CRISPR array analysis.
homepage: https://github.com/Russel88/CRISPRCasTyper
---

# cctyper

## Overview

cctyper (CRISPRCasTyper) is a comprehensive bioinformatic pipeline that identifies CRISPR-Cas loci by integrating Cas gene detection with CRISPR array analysis. It uses a suite of Hidden Markov Models (HMMs) to find Cas genes and an extreme gradient boosting (XGBoost) machine learning approach to subtype CRISPR arrays based on consensus repeat sequences. The tool is essential for distinguishing between closely related subtypes and identifying "orphan" components where only the genes or the array are present.

## Core CLI Usage

The primary command for cctyper requires a nucleotide FASTA input and an output directory name.

### Basic Execution
```bash
cctyper input.fasta output_dir
```

### Handling Different Data Types
*   **Complete Genomes**: Use the circular flag if the input sequences are complete circular chromosomes or plasmids to allow detection of operons spanning the sequence start/end.
    ```bash
    cctyper genome.fasta output_dir --circular
    ```
*   **Metagenomes and Fragments**: For metagenomic assemblies, short contigs, or viral sequences, switch the gene prediction mode to "meta" to improve sensitivity on fragmented genes.
    ```bash
    cctyper assembly.fasta output_dir --prodigal meta
    ```

### Database Management
If the database was not installed via Conda or is stored in a non-standard location, specify it using the environment variable or the CLI flag:
```bash
# Environment variable method
export CCTYPER_DB="/path/to/database/"

# CLI flag method
cctyper input.fasta output_dir --db /path/to/database/
```

## Interpreting Key Outputs

cctyper produces several tab-separated files in the output directory:

*   **CRISPR_Cas.tab**: The primary summary file. It provides a consensus prediction by reconciling evidence from both Cas genes and CRISPR repeats.
*   **cas_operons.tab**: Contains detailed information on identified Cas gene clusters, including "Complete_Interference" and "Complete_Adaptation" percentages which indicate how much of the functional module was detected.
*   **crisprs_all.tab**: Lists all detected CRISPR arrays, including potential false positives.
*   **Gene Maps**: The tool automatically generates vector graphics (SVG/PDF) of the identified loci, which are suitable for direct use in manuscripts.

## Expert Tips and Best Practices

*   **Subtype Resolution**: When the output shows "Hybrid" or "Ambiguous" predictions, check the `Prediction_Cas` and `Prediction_CRISPRs` columns in `CRISPR_Cas.tab`. Often, one line of evidence is stronger than the other (e.g., a complete Cas operon vs. a short array).
*   **Tuning CRISPR Detection**: If you suspect CRISPR arrays are being missed, you can pass specific arguments to the underlying MinCED engine using the `--minced` prefix (available in v1.6.3+).
*   **Orphan Identification**: cctyper is particularly useful for finding orphan Cas operons (Cas genes without an adjacent array) and orphan CRISPR arrays (arrays without adjacent Cas genes), which are frequently found in mobile genetic elements.
*   **Version Check**: Ensure you are using at least v1.8.0 to access the latest typing schemes for newer subtypes like II-D, II-C2, and V-M.

## Reference documentation
- [cctyper Overview](./references/anaconda_org_channels_bioconda_packages_cctyper_overview.md)
- [CRISPRCasTyper GitHub Repository](./references/github_com_Russel88_CRISPRCasTyper.md)