---
name: extract-codon-alignment
description: The `extract-codon-alignment` tool is a specialized utility for subsetting nucleotide alignments based on their position within a codon.
homepage: https://github.com/linzhi2013/extract_codon_alignment
---

# extract-codon-alignment

## Overview
The `extract-codon-alignment` tool is a specialized utility for subsetting nucleotide alignments based on their position within a codon. In evolutionary biology, the third codon position often evolves faster due to degeneracy, while the first and second positions are more conserved. This tool allows researchers to isolate these positions (or combinations like 1st+2nd) from a multiple sequence alignment (MSA) to refine phylogenetic signals or calculate specific evolutionary metrics.

## Installation
The tool can be installed via Bioconda or pip:
```bash
conda install bioconda::extract-codon-alignment
# OR
pip install extract-codon-alignment
```

## Command Line Usage
The primary command is `extract_codon_alignment`.

### Basic Extraction
By default, the tool extracts the **1st and 2nd** codon positions.
```bash
extract_codon_alignment --alignedCDS input.fasta --outAln output_pos12.fasta
```

### Extracting Specific Positions
Use the `--codonPoses` flag to define which positions to keep. Available options are `{1, 2, 3, 12, 13, 23}`.

**Extract only the 3rd position (often used to minimize saturation):**
```bash
extract_codon_alignment --alignedCDS input.fasta --codonPoses 3 --outAln output_pos3.fasta
```

**Extract only the 1st position:**
```bash
extract_codon_alignment --alignedCDS input.fasta --codonPoses 1 --outAln output_pos1.fasta
```

### Handling Different Formats
The tool uses Biopython for parsing. While `fasta` is the default, you can specify other formats (e.g., phylip, clustal, nexus) using `--aln_format`.
```bash
extract_codon_alignment --alignedCDS input.phy --aln_format phylip --codonPoses 12 --outAln output.fasta
```

## Expert Tips and Best Practices
- **Alignment Integrity**: Ensure your input alignment is a true CDS alignment (in-frame and starting at the first codon position). If the alignment is out of frame, the extracted positions will be biologically incorrect.
- **Phylogenetic Signal**: If you are dealing with deep-time phylogenetics where transitions are saturated, extracting only the 1st and 2nd positions (`--codonPoses 12`) can often provide a cleaner signal.
- **Synonymous vs. Non-synonymous**: To focus on non-synonymous changes, use positions 1 and 2. To focus on synonymous changes (neutral evolution), isolate position 3.
- **Output Format**: Note that the tool typically outputs in FASTA format regardless of the input format.

## Reference documentation
- [extract-codon-alignment Overview](./references/anaconda_org_channels_bioconda_packages_extract-codon-alignment_overview.md)
- [extract-codon-alignment GitHub Repository](./references/github_com_linzhi2013_extract_codon_alignment.md)