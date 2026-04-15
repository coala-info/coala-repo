---
name: pytransaln
description: pytransaln aligns nucleotide sequences by translating them into amino acids to maintain codon structure and identify potential pseudogenes. Use when user asks to perform codon-aware sequence alignment, screen for pseudogenes, or detect frameshift mutations in coding sequences.
homepage: https://github.com/monagrland/pytransaln
metadata:
  docker_image: "quay.io/biocontainers/pytransaln:0.2.2--pyh7e72e81_0"
---

# pytransaln

## Overview

pytransaln is a specialized bioinformatics tool designed to align nucleotide sequences by first translating them into amino acids, aligning the proteins, and then mapping the DNA back to that alignment. This approach ensures that the resulting nucleotide alignment maintains the correct codon structure. It is particularly effective for processing PCR-amplified coding sequences where some sequences might be pseudogenes containing frameshifts or non-sense mutations. The tool uses MAFFT as its underlying alignment engine and can handle "messy" datasets by separating high-quality sequences from putative pseudogenes before performing the final augmented alignment.

## Core Workflows

### 1. Basic Codon Alignment
To perform a standard alignment where the reading frame is determined automatically for each sequence:

```bash
pytransaln --input sequences.fasta --code 5 align --how each --out_aln_nt alignment.fasta
```

### 2. Screening for Pseudogenes
If you only want to generate statistics and flag potential pseudogenes without performing a full alignment:

```bash
pytransaln --input sequences.fasta --code 5 stats
```

### 3. HMM-Guided Screening
To improve the detection of non-homologous sequences or highly divergent pseudogenes, provide a profile HMM of the target protein:

```bash
pytransaln --input sequences.fasta --code 5 --hmm protein_model.hmm align --how cons
```

## Command Reference and Best Practices

### Reading Frame Selection (`--how`)
*   `user`: Applies a fixed offset (0, 1, or 2) to all sequences. Use this if your sequences are already trimmed to a known start position. Requires `--frame`.
*   `cons`: Finds a single consensus reading frame that minimizes stop codons across the entire dataset. Best for high-quality datasets with consistent trimming.
*   `each`: Evaluates and chooses the best frame for every sequence individually. Best for datasets with varying start positions or indels.

### Key Options
*   `--code`: **Required.** Specify the NCBI genetic code integer (e.g., `1` for Standard, `5` for Invertebrate Mitochondrial).
*   `--threads`: Use multiple CPU cores to speed up MAFFT and translation steps.
*   `--ignore_terminal_stop`: Use this flag if your sequences include the natural stop codon at the end to prevent them from being flagged as "bad."
*   `--max_stop`: Adjust the threshold for how many stop codons are allowed before a sequence is classified as a pseudogene (default is 0).

### Output Files
When running the `align` command, use these flags to capture specific results:
*   `--out_bad`: Fasta file of sequences flagged as pseudogenes.
*   `--out_bad_fs_report`: A detailed report of likely frameshift positions in the pseudogenes.
*   `--out_aln_aa`: The intermediate amino acid alignment.
*   `--out_aln_nt_aug`: The final nucleotide alignment including the "bad" sequences mapped back to the "good" template.

## Expert Tips
*   **Homology Requirement**: pytransaln assumes input sequences are homologous and do not contain introns. If your data includes non-coding regions, trim them before processing.
*   **Sequence Length**: The heuristic for guessing reading frames works best on sequences longer than 50bp. Short fragments may result in ambiguous frame assignments.
*   **MAFFT Dependency**: Ensure MAFFT (>= 6.811) is installed and available in your system PATH, as pytransaln relies on it for the actual alignment calculation.
*   **Visualization**: To quickly inspect the codon alignment in the terminal, use a tool like `alv`:
    `alv -t codon -l alignment.fasta | less -R`



## Subcommands

| Command | Description |
|---------|-------------|
| pytransaln_align | Align nucleotide sequences and translate them to amino acids, handling reading frames and stop codons. |
| pytransaln_stats | Calculate statistics from translated alignments. |

## Reference documentation
- [Translation-guided alignment of nucleotide sequences](./references/github_com_monagrland_pytransaln_blob_master_README.md)
- [Makefile examples and benchmark patterns](./references/github_com_monagrland_pytransaln_blob_master_Makefile.md)
- [Test script CLI patterns](./references/github_com_monagrland_pytransaln_blob_master_run_tests.sh.md)