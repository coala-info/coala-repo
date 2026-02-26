---
name: maxentscan
description: "MaxEntScan calculates the strength of 5' and 3' splice site signals based on the Maximum Entropy principle. Use when user asks to score donor or acceptor splice sites, evaluate the impact of mutations on splicing, or quantify the strength of short sequence motifs."
homepage: https://github.com/esebesty/maxentscan
---


# maxentscan

## Overview
MaxEntScan is a specialized tool for calculating the strength of splice site signals based on the Maximum Entropy principle. It provides a quantitative measure of how well a short sequence motif matches the expected distribution of human splice sites. The tool is divided into two primary components: `score5.pl` for 5' (donor) splice sites and `score3.pl` for 3' (acceptor) splice sites. It is particularly effective for evaluating sequences that deviate from the consensus, as it accounts for non-adjacent dependencies between nucleotides.

## CLI Usage and Patterns

### Core Commands
The tool is implemented in Perl and typically requires input sequences in FASTA format.

*   **Score 5' Splice Sites (Donor):**
    ```bash
    perl score5.pl <input_file.fa>
    ```
*   **Score 3' Splice Sites (Acceptor):**
    ```bash
    perl score3.pl <input_file.fa>
    ```

### Sequence Requirements
MaxEntScan requires specific sequence lengths to function correctly. If the sequences in your input file do not match these lengths, the tool may produce errors or incorrect scores.

*   **5' Splice Site (9bp):** Requires a 9-base sequence consisting of the last 3 bases of the exon and the first 6 bases of the intron (e.g., `CAG|GUAAGU`).
*   **3' Splice Site (23bp):** Requires a 23-base sequence consisting of the last 20 bases of the intron and the first 3 bases of the exon (e.g., `UUUCUCCCCUCCUCCCCUAG|GUA`).

### Dependencies
Ensure the following are available in your environment:
*   **Perl**: The base language for the scripts.
*   **Bio::SeqIO**: Used for parsing FASTA files.
*   **Getopt::Long**: Used for handling command-line arguments.
*   **Model Files**: The `splicemodels/` directory must be located in the same directory as the scripts for the scoring algorithms to load the necessary probability distributions.

## Expert Tips and Best Practices
*   **Input Validation**: Always verify that your input sequences are exactly 9bp for 5' sites and 23bp for 3' sites. The tool uses `Bio::SeqIO` to read sequences, so standard FASTA formatting is preferred.
*   **Interpreting Scores**: MaxEntScan scores can be negative. Higher (more positive) scores indicate stronger splice sites. A score of 0 or less generally suggests a very weak or non-functional site, though this can vary by context.
*   **Variant Effect Prediction**: To predict the effect of a mutation, score the wild-type sequence and the mutant sequence separately. A significant drop in the MaxEntScan score (e.g., >15-20% or a specific point drop) often indicates a high probability of splicing disruption.
*   **Directory Structure**: Keep the `score5.pl`, `score3.pl`, and the `splicemodels/` folder together. The scripts are hardcoded to look for model data in relative paths.

## Reference documentation
- [Main Repository and Overview](./references/github_com_esebesty_maxentscan.md)
- [Commit History and Updates](./references/github_com_esebesty_maxentscan_commits_master.md)