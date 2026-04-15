---
name: kcalign
description: kcalign is a codon-aware multiple sequence aligner that performs amino acid alignment before projecting results back to nucleotide sequences to preserve reading frames. Use when user asks to perform codon-aware alignment, extract and align genes from whole genomes, or align sequences while preserving codon structure for evolutionary analysis.
homepage: https://github.com/davebx/kc-align
metadata:
  docker_image: "quay.io/biocontainers/kcalign:1.0.2--py_0"
---

# kcalign

## Overview

kcalign (also known as Kc-Align) is a fast, codon-aware multiple sequence aligner that uses Kalign3 as its core engine. Unlike standard nucleotide aligners, kcalign translates sequences into amino acids before alignment and then projects the alignment back onto the original nucleotide sequences. This process ensures that gaps are inserted in multiples of three, preserving the codon structure necessary for downstream evolutionary analyses such as dN/dS calculations, homology modeling, and phylogenetic reconstruction. It is uniquely capable of extracting homologous sequences from whole genomes using a reference sequence, bypassing the need for manual sequence curation.

## Usage Modes

Select the appropriate mode based on the input data format:

*   **genome**: Use when both the reference and the target sequences are full genomes. Requires start and end coordinates for the gene of interest relative to the reference.
*   **gene**: Use when all input sequences are already trimmed to the specific coding sequence (ORF). This is the fastest mode as it skips the homology search.
*   **mixed**: Use when the reference is a pre-trimmed coding sequence but the target sequences are whole genomes.

## Command Line Patterns

### Basic Gene Alignment
Align pre-extracted coding sequences:
```bash
kc-align --mode gene --reference ref_gene.fasta --sequences target_genes.fasta
```

### Whole Genome Extraction and Alignment
Extract and align a specific ORF from multiple genomes using reference coordinates:
```bash
kc-align --mode genome --reference ref_genome.fasta --sequences target_genomes.fasta --start 100 --end 1200
```

### Handling Segmented Genes (Frameshifts)
For genes consisting of multiple segments (e.g., ribosomal frameshifts), provide comma-separated coordinate lists:
```bash
kc-align -m genome -r ref.fasta -S targets.fasta -s 3532,3892 -e 3894,5326
```

### Mixed Input Alignment
Align a known gene sequence against whole genomes:
```bash
kc-align --mode mixed --reference ref_gene.fasta --sequences target_genomes.fasta
```

## Optimization and Best Practices

*   **Parallelization**: Use `--parallel` or `-p` in `genome` or `mixed` modes to enable multi-core homology searches, which can reduce runtime by approximately 35%.
*   **Sequence Compression**: Use `--compress` or `-c` to collapse identical sequences into a single representative entry. This is highly effective for large datasets with low variation (e.g., viral outbreaks). Compressed IDs appear as `MultiSeq[index]_[count]`.
*   **Translation Tables**: If working with non-standard genetic codes (e.g., mitochondrial DNA), specify the NCBI translation table index using `--table` or `-t`.
*   **Output Formats**: kcalign automatically generates two output files: one in FASTA format and one in CLUSTAL format.
*   **Coordinate System**: Note that `--start` and `--end` parameters are 1-based coordinates.

## Reference documentation
- [Kc-Align GitHub Repository](./references/github_com_davebx_kc-align.md)
- [kcalign Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_kcalign_overview.md)