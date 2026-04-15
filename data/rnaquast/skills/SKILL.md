---
name: rnaquast
description: rnaQUAST evaluates the quality of RNA-Seq assemblies by comparing transcripts to a reference genome and gene annotations or performing de novo assessments. Use when user asks to assess assembly completeness, compare multiple RNA-Seq assemblers, or evaluate transcript correctness using a reference genome and GTF file.
homepage: http://cab.spbu.ru/software/rnaquast/
metadata:
  docker_image: "quay.io/biocontainers/rnaquast:2.3.0--h9ee0642_0"
---

# rnaquast

## Overview
rnaQUAST (RNA-Seq Assembly Quality Assessment Tool) provides a comprehensive framework for evaluating the completeness and correctness of RNA-Seq assemblies. It is particularly useful for comparing different assemblers or parameter sets by mapping assembled transcripts to a reference genome and an existing gene annotation (GTF/GFF). It can also estimate how well raw reads cover the known gene database and perform de novo assessments when a reference is unavailable.

## Core Usage Patterns

### Basic Evaluation with Reference
The most common workflow involves providing the assembly, a reference genome, and a gene database.
```bash
python rnaQUAST.py --transcripts assembly.fasta --reference genome.fasta --gtf annotation.gtf
```

### Evaluating Multiple Assemblies
To compare multiple assemblers (e.g., Trinity vs. SPAdes), pass multiple fasta files.
```bash
python rnaQUAST.py --transcripts trinity.fasta spades.fasta --reference genome.fasta --gtf annotation.gtf
```

### De Novo Evaluation (No Reference)
If a reference genome is unavailable, rnaQUAST can run in de novo mode using third-party tools like BUSCO or GeneMarkS-T.
```bash
python rnaQUAST.py --transcripts assembly.fasta --busco_lineage eukaryota
```

### Including Raw Reads
To estimate gene database coverage by the actual sequencing data, include the original FASTQ files.
```bash
python rnaQUAST.py --transcripts assembly.fasta --reference genome.fasta --gtf annotation.gtf --left reads_1.fastq --right reads_2.fastq
```

## Expert Tips & Best Practices
- **Coordinate Consistency**: Ensure that the chromosome/scaffold names in your `--reference` FASTA exactly match those in your `--gtf` file.
- **Strand-Specific Data**: If your RNA-Seq library is stranded, use the `--ss` flag to improve mapping accuracy and reduce chimeric alignment artifacts.
- **Resource Management**: For large genomes or high-depth datasets, use the `-t` or `--threads` parameter to speed up the alignment steps (minimap2 or STAR).
- **Output Interpretation**: Focus on the `summary.txt` for high-level metrics, but check the `comparison_dist.pdf` plots to visualize how transcript lengths and coverage vary between different assembly versions.
- **Third-Party Tools**: For a complete assessment, ensure `minimap2` (or `blat`), `busco`, and `samtools` are in your PATH, as rnaQUAST relies on these for alignment and specialized metrics.

## Reference documentation
- [rnaQUAST Overview](./references/anaconda_org_channels_bioconda_packages_rnaquast_overview.md)