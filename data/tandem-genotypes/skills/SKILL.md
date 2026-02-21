---
name: tandem-genotypes
description: The `tandem-genotypes` suite provides a specialized workflow for detecting changes in the length of tandem repeats using "long" DNA reads aligned to a reference genome.
homepage: https://github.com/mcfrith/tandem-genotypes
---

# tandem-genotypes

## Overview
The `tandem-genotypes` suite provides a specialized workflow for detecting changes in the length of tandem repeats using "long" DNA reads aligned to a reference genome. Unlike standard variant callers that may struggle with repetitive regions, this tool calculates the copy number change for every read covering a repeat, allowing for the identification of expansions or contractions relative to the reference. It is particularly effective for identifying disease-associated repeat expansions and supports multi-sample comparisons to filter out common polymorphisms.

## Core Workflow and CLI Patterns

### 1. Basic Genotyping
The primary command requires a repeat definition file and an alignment file in MAF format.

```bash
# Basic usage with repeat definitions and alignments
tandem-genotypes microsat.txt alignments.maf > tg_output.txt

# Recommended: Include gene annotations for context (coding, 3'UTR, etc.)
tandem-genotypes -g refGene.txt microsat.txt alignments.maf > tg_annotated.txt
```

### 2. Allele Prediction and Consensus
To move beyond raw read counts to specific allele estimates:

```bash
# Predict 2 alleles per repeat (-o2) and include read names (-v)
tandem-genotypes -o2 -v -g refGene.txt microsat.txt alignments.maf > tg_alleles.txt

# Generate consensus sequences for the predicted alleles (requires lamassemble)
tandem-genotypes-merge reads.fq alignment_params.par tg_alleles.txt > consensus.fa
```

### 3. Multi-sample Comparison (Case-Control)
Use `tandem-genotypes-join` to prioritize repeats that are expanded in a patient but not in controls. The colon `:` separates "case" files from "control" files.

```bash
# Compare one patient against two controls
tandem-genotypes-join patient.txt : control1.txt control2.txt > joined_results.txt
```

### 4. Visualization
Generate histograms of copy number changes. The x-axis represents the change in copy number; red bars indicate forward-strand reads, and blue bars indicate reverse-strand reads.

```bash
# Plot the top 16 most "important" repeats
tandem-genotypes-plot tg_output.txt

# Plot a specific subset (e.g., only coding regions)
grep "coding" tg_output.txt | tandem-genotypes-plot - coding_repeats.pdf

# Show expected coverage drop for long repeats using raw reads
tandem-genotypes-plot --reads my_reads.fa tg_output.txt
```

## Expert Tips and Best Practices

*   **Alignment Requirement**: Input MAF files **must** be produced by `last-split` from the LAST alignment suite. Standard MAF files or those in a different order will cause incorrect results.
*   **Repeat Definitions**: 
    *   Use `hg19-disease-tr.txt` or `hg38-disease-tr.txt` (included in the tool) to specifically target known pathogenic repeats like those for SCA7 or Huntington's.
    *   For discovery, `microsat.txt` is faster but limited to di- and tri-nucleotide repeats. Use `simpleRepeat.txt` for a comprehensive search.
*   **Output Interpretation**:
    *   Column 7 (Forward) and Column 8 (Reverse) contain comma-separated integers. A `-2` means the read has 2 fewer copies than the reference; `5` means 5 additional copies.
    *   The output is automatically sorted by "importance," which factors in the magnitude of the change and the genomic location (e.g., coding regions are prioritized).
*   **Handling Large Data**: You can use gzipped files (`.gz`) directly as input for most commands to save space.
*   **Crude Alleles**: The `-o2` option is a heuristic. If a sample is homozygous, it may still predict two very similar alleles due to sequencing noise.

## Reference documentation
- [tandem-genotypes GitHub Repository](./references/github_com_mcfrith_tandem-genotypes.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_tandem-genotypes_overview.md)