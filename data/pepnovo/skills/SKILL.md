---
name: pepnovo
description: PepNovo+ performs de novo peptide sequencing to reconstruct amino acid sequences directly from MS/MS spectra without requiring a reference database. Use when user asks to perform de novo sequencing, generate high-confidence peptide tags, handle post-translational modifications, or optimize precursor mass accuracy for mass spectrometry data.
homepage: https://github.com/jmchilton/pepnovo
metadata:
  docker_image: "biocontainers/pepnovo:v20120423_cv3"
---

# pepnovo

## Overview
PepNovo+ is a de novo sequencing algorithm that reconstructs peptide sequences directly from fragment ion patterns in MS/MS spectra. Unlike database search engines, it does not require a reference proteome, making it essential for identifying novel peptides, mutations, or organisms with unsequenced genomes. This skill provides the command-line patterns required to execute sequencing, manage post-translational modifications (PTMs), and optimize precursor mass accuracy.

## Command Line Usage

### Basic Sequencing
To run de novo sequencing on a single file using the standard tryptic CID model:
`PepNovo_bin -file <input_file.mgf> -model CID_IT_TRYP -digest TRYPSIN`

### Batch Processing
For large datasets, always use a list file containing paths to individual spectra files. This prevents the overhead of reloading model files for every spectrum:
`PepNovo_bin -list <paths_list.txt> -model CID_IT_TRYP`

### Generating Peptide Tags
If full-length de novo sequencing is too uncertain, generate short, high-confidence peptide tags (length 3-6) for use in tools like MS-Blast:
`PepNovo_bin -file <input.mgf> -model CID_IT_TRYP -tag_length 4 -num_solutions 50`

### Handling PTMs
Specify modifications using the `Residue+Mass` format separated by colons. Do not use spaces:
`PepNovo_bin -file <input.mgf> -model CID_IT_TRYP -PTMs C+57:M+16:S+80`
*   **C+57**: Carbamidomethylation (Fixed)
*   **M+16**: Oxidation (Variable)
*   **S+80**: Phosphorylation (Variable)

### Precursor and Fragment Optimization
*   **Mass Correction**: Use `-correct_pm` to let PepNovo find the optimal precursor mass and charge state, which often improves sequencing accuracy.
*   **Tolerances**: If using data from non-LTQ instruments, manually adjust tolerances:
    *   `-fragment_tolerance <0-0.75>` (Default is usually 0.4 for CID_IT)
    *   `-pm_tolerance <0-5.0>` (Default is 2.5 for CID_IT)

## Output Interpretation
The output is tab-delimited with the following key fields:
*   **RnkScr**: The primary ranking score (higher is better).
*   **PnvScr**: The raw PepNovo score based on the spectrum graph.
*   **N-Gap / C-Gap**: The mass gaps between the predicted sequence and the peptide terminals.
*   **Sequence**: The predicted amino acid string.

## Expert Tips
*   **Redirection**: PepNovo outputs to stdout by default. Capture results using standard redirection: `PepNovo_bin [args] > results.txt`.
*   **Quality Filtering**: By default, PepNovo removes low-quality spectra. To force processing of all spectra, use the `-no_quality_filter` flag.
*   **Probability Scoring**: For downstream statistical validation, use `-output_aa_probs` to get individual amino acid confidence scores or `-output_cumulative_probs` for sequence-level confidence.
*   **Model Directory**: If running the binary from a different location, specify the model path explicitly using `-model_dir <path/to/Models>`.

## Reference documentation
- [PepNovo Main Readme](./references/github_com_jmchilton_pepnovo.md)