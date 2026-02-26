---
name: pytransaln
description: pytransaln performs translation-guided nucleotide alignment to maintain codon structure and identifies putative pseudogenes through stop codon and HMM screening. Use when user asks to align nucleotide sequences based on protein translations, determine optimal reading frames, or filter sequences for frameshifts and low-quality matches.
homepage: https://github.com/monagrland/pytransaln
---


# pytransaln

## Overview
pytransaln is a specialized tool for translation-guided nucleotide alignment. It addresses the common problem in molecular biology where simple nucleotide alignments introduce gaps that break the triplet codon structure. By translating sequences into amino acids, aligning them with MAFFT, and then mapping the nucleotide sequences back onto the protein alignment, it ensures biological consistency. It also serves as a quality control filter to detect and report putative pseudogenes based on stop codon frequency and HMM bit scores.

## Core Workflows

### Reading Frame Selection
The tool provides three primary methods to determine the translation frame via the `--how` parameter:
- **user**: Applies a specific, user-defined frame offset to all sequences.
- **cons**: Calculates a consensus frame that minimizes the total number of stop codons across the entire dataset. Best for datasets where all sequences are expected to start at the same position.
- **each**: Evaluates and selects the best reading frame for every sequence individually. Use this for datasets with heterogeneous start positions or varying 5' trims.

### Pseudogene Screening
Sequences exceeding a threshold of stop codons are flagged as putative pseudogenes.
1. "Good" sequences are aligned first to create a high-quality reference alignment.
2. Putative pseudogenes are then added to this reference using the `MAFFT --add` strategy.
3. Frameshift positions are identified and reported in a dedicated log file.

### HMM Integration
For more rigorous screening, provide a Profile HMM representing the target protein:
- Use the `--hmm` option to screen translated sequences.
- Sequences with outlier bit scores (indicating they do not match the expected protein profile) are excluded from the initial alignment to prevent distortion.

## Common CLI Patterns

### Basic Consensus Alignment
Use this when your sequences are homologous and likely share the same starting frame:
```bash
pytransaln --how cons --input sequences.fasta --out alignment.fasta
```

### Individual Frame Alignment with HMM Filtering
Use this for diverse metabarcoding sets where sequences might be shifted:
```bash
pytransaln --how each --hmm profile.hmm --input sequences.fasta --out alignment.fasta
```

### Visualizing Results
After alignment, it is a best practice to inspect the codon alignment. You can use `alv` (Alignment Viewer) to view the results directly in the terminal:
```bash
alv -t codon -l alignment.fasta | less -R
```

## Expert Tips
- **Genetic Code**: You must manually specify the genetic code appropriate for your taxa (e.g., Mitochondrial vs. Standard), as the tool does not currently guess the code.
- **Sequence Length**: Ensure your sequences are long enough (typically >50bp). If sequences are too short, the heuristic for guessing the reading frame may fail due to a lack of statistical signal from stop codons.
- **MAFFT Dependency**: Ensure MAFFT (>=6.811) is in your system PATH, as pytransaln relies on it for the underlying amino acid alignment.
- **Trimming**: Leading and trailing bases that do not form complete codons may be omitted in the final output to maintain the reading frame.

## Reference documentation
- [pytransaln GitHub README](./references/github_com_monagrland_pytransaln.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_pytransaln_overview.md)