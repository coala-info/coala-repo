---
name: derip2
description: The `derip2` tool is designed for evolutionary biologists and genomicists working with fungal genomes.
homepage: https://github.com/Adamtaranto/deRIP2
---

# derip2

## Overview
The `derip2` tool is designed for evolutionary biologists and genomicists working with fungal genomes. It analyzes multiple sequence alignments (MSAs) of repetitive elements to identify and reverse the effects of RIP, a fungal defense mechanism that hyper-mutates repetitive DNA. By identifying consensus patterns and applying statistical thresholds, it generates a "de-RIP'd" ancestral sequence, which is essential for accurate phylogenetic analysis and transposon annotation.

## Basic Usage
The primary input for `derip2` is a multiple sequence alignment file (typically FASTA format).

```bash
derip2 -i alignment.fa -d output_dir --prefix my_element
```

## Common CLI Patterns

### Standard RIP Correction with Masking
To correct RIP mutations while masking the specific sites as ambiguous bases (e.g., changing a corrected CpA/TpA site to YpA) to prevent over-confidence in phylogenetic trees:
```bash
derip2 -i input.fa --mask --max-gaps 0.7 --min-rip-like 0.5 -d results
```

### Full Deamination Correction
If you want to correct all C -> T transitions regardless of whether they occur in the classic RIP context (CpA):
```bash
derip2 -i input.fa --reaminate --plot --plot-rip-type product
```

### Optimizing Sequence Filling
By default, `derip2` fills uncorrected positions using the sequence with the lowest RIP count. You can override this to use the sequence with the highest GC content or a specific reference row:
*   **Highest GC:** `derip2 -i input.fa --fill-max-gc`
*   **Specific Row (e.g., Index 0):** `derip2 -i input.fa --fill-index 0`

## Expert Tips and Best Practices
*   **Gap Management:** Use `--max-gaps` (default 0.7) to control how the tool handles poorly aligned regions. If a column exceeds this threshold, a gap is placed in the consensus rather than attempting a correction.
*   **Noise Filtering:** If your alignment contains many random SNPs that aren't RIP-related, increase `--max-snp-noise` to prevent them from interfering with the de-RIP logic.
*   **Visualization:** Always use the `--plot` flag during initial runs. The resulting `.png` file provides a visual markup of the alignment, helping you verify if the identified RIP events align with your biological expectations.
*   **RIP Context:** The `--min-rip-like` parameter is crucial. It defines the minimum proportion of deamination events in a column that must be in a RIP context (5' CpA 3') for the tool to trigger a correction. Adjust this based on the known RIP stringency of your target organism.

## Reference documentation
- [deRIP2 GitHub Repository](./references/github_com_Adamtaranto_deRIP2.md)
- [deRIP2 Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_derip2_overview.md)