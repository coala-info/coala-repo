---
name: tbox-scan
description: tbox-scan automates the identification and characterization of T-box riboswitches within genomic data by integrating structural prediction, motif extraction, and thermodynamic analysis. Use when user asks to identify T-box riboswitches, predict T-box secondary structures, classify transcriptional or translational T-boxes, or analyze T-box regulatory logic.
homepage: https://tbdb.io/
metadata:
  docker_image: "quay.io/biocontainers/tbox-scan:1.0.2--hdfd78af_2"
---

# tbox-scan

## Overview
tbox-scan is a specialized bioinformatics tool designed to automate the identification and characterization of T-box riboswitches within genomic data. It transforms raw DNA sequences into detailed structural annotations by executing a multi-step pipeline that integrates covariance model searching, motif extraction, and thermodynamic analysis. This tool is essential for researchers investigating bacterial gene regulation, amino acid metabolism, and the discovery of non-coding RNA elements that respond to tRNA aminoacylation states.

## Usage and Workflow
The tool operates through a specific analytical pipeline. When using tbox-scan, expect the following procedural stages:

1.  **Secondary Structure Prediction**: The tool utilizes INFERNAL to predict the initial secondary structure of potential T-box sequences.
2.  **Feature Extraction**: It searches the predicted structures for conserved T-box motifs, specifically:
    *   **Stem I**: The primary binding site for the tRNA anticodon.
    *   **Specifier Loop**: The region determining tRNA specificity.
    *   **Antiterminator/Antisequestrator**: The regulatory switch element.
3.  **Genetic Feature Identification**: It extracts the specifier codon and the discriminator base from their respective structural positions.
4.  **Thermodynamic Analysis**: It uses ViennaRNA (RNAfold/RNALfold) to calculate the Minimum Free Energy (MFE) for both antiterminator and terminator folds to determine the regulatory logic.
5.  **tRNA Matching**: It integrates with tRNAscan-SE results to identify cognate tRNAs within the host organism that match the predicted specifier.

## Classification Logic
tbox-scan classifies T-boxes into two primary categories based on the covariance model (CM) used:
*   **Class I (Transcriptional)**: Typically detected using the RFAM RF00230 model. These usually feature a larger Stem I and a downstream terminator hairpin.
*   **Class II (Translational)**: Detected using specialized models (like the ileS leader model). These often have shorter Stem I structures and lack a traditional terminator.

## Best Practices and Expert Tips
*   **Input Preparation**: Ensure input sequences include sufficient upstream and downstream context (at least 500bp) to allow for the detection of both the leader sequence and the downstream terminator/ORF.
*   **Handling Low Scores**: If a sequence returns a low INFERNAL score, it may be a Class II T-box being forced into a Class I model, or a complex/tandem T-box that the standard models struggle to fold.
*   **Specifier Validation**: Always cross-reference the predicted specifier loop with the host's tRNA repertoire. A "Top" match is more likely to be biologically relevant than alternative frames.
*   **Thermodynamic Delta**: Pay close attention to the `deltadelta_g` (difference between antiterminator and terminator MFE). A narrow margin suggests a highly sensitive or "leaky" switch.
*   **Complex Cases**: Be aware that standard tbox-scan runs may truncate or mischaracterize tandem (double) T-box arrangements. These require manual inspection of the INFERNAL output.

## Reference documentation
- [About the T-box riboswitch annotation database](./references/tbdb_io_about.html.md)
- [T-box riboswitch background](./references/tbdb_io_tbox_background.html.md)
- [FAQ T-box riboswitch annotation database](./references/tbdb_io_faq.html.md)
- [tbox-scan - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_tbox-scan_overview.md)