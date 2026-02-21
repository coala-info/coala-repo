---
name: prodigal
description: Prodigal (Prokaryotic Dynamic Programming Genefinding Algorithm) is an unsupervised machine learning tool that identifies protein-coding genes in bacteria and archaea.
homepage: https://github.com/hyattpd/Prodigal
---

# prodigal

## Overview

Prodigal (Prokaryotic Dynamic Programming Genefinding Algorithm) is an unsupervised machine learning tool that identifies protein-coding genes in bacteria and archaea. It is designed to be fast and reliable, capable of analyzing a standard bacterial genome in seconds. The tool automatically learns the properties of the input sequence—including Ribosomal Binding Site (RBS) motifs, start codon usage, and coding statistics—making it highly effective for novel or poorly characterized organisms.

## CLI Usage and Best Practices

### Basic Gene Prediction
For a standard, finished genome or a high-quality draft assembly, use the default "normal" mode. This allows Prodigal to train on the sequence before predicting genes.

```bash
prodigal -i input_genome.fna -o output.genes -a proteins.faa -d nucleotides.fna
```

- `-i`: Input genomic sequence (FASTA format).
- `-o`: Output file for gene coordinates.
- `-a`: Output file for protein translations (Amino Acid FASTA).
- `-d`: Output file for nucleotide sequences of the predicted genes.

### Metagenomic and Short Sequence Analysis
If the input contains multiple organisms or very short contigs (less than 20kbp), use the "meta" procedure. This uses pre-trained models instead of trying to learn from the input.

```bash
prodigal -i metagenome.fna -o meta_output.genes -p meta
```

### Specifying Output Formats
Prodigal supports several standard bioinformatics formats. Use the `-f` flag to change the output style:

- **GFF3 (Recommended)**: `prodigal -i input.fna -o output.gff -f gff`
- **Genbank**: `prodigal -i input.fna -o output.gbk -f gb`
- **Sequin**: `prodigal -i input.fna -o output.sqn -f sqn`

### Handling Alternate Genetic Codes
By default, Prodigal uses Translation Table 11 (Standard Bacterial/Archaeal). If working with specific organisms like Mycoplasma, specify the table with `-g`.

```bash
prodigal -i mycoplasma.fna -o genes.txt -g 4
```

### Advanced Training Workflow
For large-scale projects involving many similar genomes, you can train on one high-quality genome and apply the resulting profile to others to ensure consistency.

1. **Train**: `prodigal -i reference.fna -t reference.train`
2. **Apply**: `prodigal -i new_genome.fna -t reference.train -o new_genes.txt`

## Expert Tips

- **Draft Genomes**: Prodigal handles runs of 'N's in draft assemblies. It will not predict a gene across a gap unless specifically instructed.
- **Partial Genes**: Genes at the edges of contigs are marked as partial in the output headers (e.g., `partial=01` for a gene cut off at the start).
- **Translation Initiation**: Prodigal is particularly strong at identifying the correct start codon. Check the output headers for the `conf` (confidence) and `score` values to evaluate the reliability of a specific gene call.
- **Performance**: For massive metagenomic datasets, Prodigal is significantly faster than BLAST-based or HMM-based gene finders, making it the preferred first step in annotation pipelines.

## Reference documentation
- [Prodigal README](./references/github_com_hyattpd_Prodigal.md)
- [Prodigal Wiki Home](./references/github_com_hyattpd_Prodigal_wiki.md)