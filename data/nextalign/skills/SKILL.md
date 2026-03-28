---
name: nextalign
description: Nextalign performs codon-aware sequence alignment and translation for viral genomes. Use when user asks to align viral sequences to a reference, translate genes into protein sequences, or extract insertions relative to a reference genome.
homepage: https://github.com/nextstrain/nextclade/tree/master/packages/nextalign_cli
---

# nextalign

## Overview

The `nextalign` tool is a specialized sequence aligner designed for viral genomes. Unlike general-purpose aligners, it is codon-aware, meaning it respects open reading frames (ORFs) during the alignment process. This prevents frameshift artifacts and allows for the simultaneous extraction and translation of specific genes. It is particularly effective for processing large batches of closely related viral sequences against a high-quality reference.

## CLI Usage and Best Practices

### Basic Alignment
To perform a standard nucleotide alignment, provide the input sequences and a reference genome:

```bash
nextalign run \
  --input-fasta sequences.fasta \
  --reference reference.fasta \
  --output-fasta aligned.fasta
```

### Codon-Aware Alignment and Translation
To enable translation and gene extraction, you must provide a gene map (GFF3 format) and specify which genes to process:

```bash
nextalign run \
  --input-fasta sequences.fasta \
  --reference reference.fasta \
  --genemap genes.gff \
  --genes S,N,ORF1b \
  --output-fasta aligned.fasta \
  --output-translations "translations/{gene}.translation.fasta"
```
*Note: The `{gene}` placeholder in the output path is automatically populated by the tool for each specified gene.*

### Key Parameters
- `--input-fasta`: Path to the query sequences (FASTA).
- `--reference`: Path to the reference sequence (FASTA).
- `--genemap`: Path to the gene annotations (GFF3).
- `--genes`: Comma-separated list of gene names to translate (must match names in the GFF).
- `--output-insertions`: Path to a CSV file containing information about insertions relative to the reference.

### Expert Tips
- **Reference Selection**: Always use a reference that is closely related to your query sequences. `nextalign` is optimized for small genomic variations rather than highly divergent sequences.
- **Memory Efficiency**: For very large datasets, `nextalign` is generally faster and more memory-efficient than `nextclade` if you only require the alignment and translation without the phylogenetic placement or clade assignment.
- **GFF3 Compatibility**: Ensure your GFF3 file uses the same sequence ID as your reference FASTA file to ensure the coordinates map correctly.



## Subcommands

| Command | Description |
|---------|-------------|
| nextalign | Nextalign is a tool for aligning sequences to a reference genome. |
| nextalign | nextalign is a tool for aligning Nextclade outputs. |
| nextalign | nextalign is a command-line tool for aligning sequences to a reference genome. |
| nextalign | Align sequences to a reference or gene map. |
| nextalign run | Run alignment and translation. |

## Reference documentation
- [Nextclade and Nextalign Overview](./references/github_com_nextstrain_nextclade.md)
- [Bioconda Nextalign Package](./references/anaconda_org_channels_bioconda_packages_nextalign_overview.md)