---
name: barrnap
description: Barrnap predicts the location of ribosomal RNA and other RNA features in genomic sequences using profile Hidden Markov Models. Use when user asks to identify rRNA genes, locate RNA features in a FASTA file, or annotate ribosomal subunits in genomic assemblies.
homepage: https://github.com/tseemann/barrnap
metadata:
  docker_image: "quay.io/biocontainers/barrnap:0.9--1"
---

# barrnap

## Overview
Barrnap (BAsic Rapid Ribosomal RNA Predictor) is a high-speed tool designed to locate RNA features in genomic assemblies. It utilizes profile Hidden Markov Models (HMMs) and Covariance Models (CMs) to identify ribosomal subunits (5S, 16S, 23S) and has been expanded to detect transfer RNAs, non-coding RNAs, and messenger RNA components. It is the standard choice for rapid, reliable RNA annotation in microbial genomics.

## Common CLI Patterns

### Basic Annotation
The simplest usage takes a FASTA file and redirects the GFF3 output to a file. By default, it searches for Bacterial features.
```bash
barrnap input.fna > output.gff
```

### Kingdom Selection
Specify the appropriate database for your organism to ensure accuracy.
*   **Bacteria**: `--kingdom bac` (default)
*   **Archaea**: `--kingdom arc`
*   **Fungi**: `--kingdom fun`

```bash
barrnap --kingdom arc archaea_genome.fna > output.gff
```

### Performance Optimization
For large genomes or metagenomic contigs, use multi-threading and the "fast" mode.
*   `--threads [N]`: Number of CPUs to use.
*   `--fast`: Uses simpler HMMs instead of CMs. This is significantly faster but may be less accurate for divergent sequences.

```bash
barrnap --threads 8 --fast metagenome.fna > output.gff
```

### Sequence Extraction
To obtain the actual sequences of the predicted RNA features in FASTA format alongside the GFF3 report:
```bash
barrnap --outseq rna_features.fa input.fna > output.gff
```

## Expert Tips and Best Practices

*   **Legacy Mode**: If you only require ribosomal RNA (5S, 16S, 23S) and want to ignore newer feature types like tRNA or ncRNA, use the `--legacy` flag. This mimics the behavior of Barrnap versions prior to 1.0.
*   **Feature Filtering**: You can selectively disable specific RNA types if they are being handled by other specialized tools (like tRNAscan-SE):
    *   `--no-trna`: Disable tRNA detection.
    *   `--no-rrna`: Disable rRNA detection.
    *   `--no-ncrna`: Disable non-coding RNA detection.
*   **E-value Thresholds**: The default e-value is 1e-06. If you are working with highly fragmented or poor-quality assemblies, you might need to adjust `--evalue` to be more or less stringent.
*   **GFF3 Compliance**: Use `--incseqreg` to include `##sequence-region` headers in the GFF3 output, which is often required for downstream genome browsers or databases.
*   **Unique Identifiers**: When processing multiple contigs, use `--adids` to ensure every feature in the GFF3 output has a unique `ID=` tag.

## Reference documentation
- [Barrnap GitHub Repository](./references/github_com_tseemann_barrnap.md)
- [Bioconda Barrnap Overview](./references/anaconda_org_channels_bioconda_packages_barrnap_overview.md)