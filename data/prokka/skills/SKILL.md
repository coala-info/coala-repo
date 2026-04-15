---
name: prokka
description: Prokka provides rapid functional annotation of prokaryotic genomes by identifying genes, protein translations, and structural RNAs from genomic DNA sequences. Use when user asks to annotate bacterial or archaeal contigs, generate GFF or GenBank files from genomic sequences, or prepare genomic data for NCBI submission.
homepage: https://github.com/tseemann/prokka
metadata:
  docker_image: "quay.io/biocontainers/prokka:1.15.6--pl5321hdfd78af_0"
---

# prokka

## Overview

Prokka is a command-line tool that coordinates a suite of specialized bioinformatics software to provide rapid functional annotation of prokaryotic genomes. It transforms raw genomic DNA sequences (contigs) into a set of standard output files containing identified genes, protein translations, and structural RNAs. While the developer now recommends Bakta for modern pipelines, Prokka remains a standard for fast, lean annotation of Bacteria, Archaea, and Viruses.

## Core Workflows

### Basic Annotation
The simplest way to run Prokka is by providing a FASTA file of contigs. By default, it creates a directory named `PROKKA_YYYYMMDD`.

```bash
prokka contigs.fa
```

### Organized Output
To control the output location and naming convention (highly recommended for pipelines):

```bash
prokka --outdir my_annotation --prefix genome_v1 contigs.fa
```

### NCBI/ENA Submission Mode
When preparing data for public repositories, use the `--compliant` flag. You must register your BioProject and Locus Tag prefix first.

```bash
prokka --compliant --centre UoN --locustag EHEC --prefix EHEC-Chr1 contigs.fa
```

## Expert Configuration

### Custom Protein Databases
To improve annotation quality for specific organisms, provide a curated GenBank or FASTA file of known proteins. Prokka will search these first.

```bash
prokka --proteins reference_strains.gbk --outdir results contigs.fa
```

### Kingdom and Genus Specificity
Prokka defaults to Bacteria. For other kingdoms or to use genus-specific BLAST databases:

```bash
# For Archaea
prokka --kingdom Archaea --genus Pyrococcus contigs.fa

# To force use of genus-specific databases
prokka --usegenus --genus Escherichia contigs.fa
```

### Advanced Feature Detection
*   **Non-coding RNA:** Use `--rfam` to enable Infernal-based searches for ncRNAs (slower but more accurate).
*   **Signal Peptides:** Use `--gram pos` or `--gram neg` to refine signal peptide predictions.
*   **Gene Features:** Use `--addgenes` to include 'gene' features in the GFF for every 'CDS' feature.

## Output File Reference

| Extension | Description |
| :--- | :--- |
| **.gff** | Master annotation file (GFF3 format); viewable in Artemis or IGV. |
| **.gbk** | Standard GenBank file containing sequences and features. |
| **.faa** | Protein FASTA file of translated CDS sequences. |
| **.ffn** | Nucleotide FASTA file of all predicted transcripts (CDS, rRNA, tRNA, etc.). |
| **.sqn** | ASN1 Sequin file for direct GenBank submission. |
| **.tsv** | Tab-separated summary of all features (locus_tag, gene, product, etc.). |
| **.txt** | Statistics summary of the annotation run. |
| **.err** | NCBI discrepancy report (check this for submission errors). |

## Best Practices

1.  **Locus Tags:** Always specify a unique `--locustag`. The default 'PROKKA' prefix can cause collisions if you merge multiple datasets later.
2.  **Contig Names:** Ensure your input FASTA contig IDs are short and contain no special characters, as some downstream tools (like tbl2asn) have strict character limits.
3.  **Database Updates:** Periodically run `prokka --listdb` to check available databases and `prokka --setupdb` to index them if you are managing a local installation.
4.  **Performance:** For large metagenomic assemblies, consider using the `--metagenome` flag, which optimizes Prodigal for fragmented sequences.

## Reference documentation
- [Prokka GitHub Repository](./references/github_com_tseemann_prokka.md)
- [Prokka Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_prokka_overview.md)