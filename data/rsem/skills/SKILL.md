---
name: rsem
description: RSEM (RNA-Seq by Expectation-Maximization) is a specialized tool for quantifying transcript abundances from RNA-Seq data without requiring a reference genome, though it can leverage one.
homepage: https://deweylab.github.io/RSEM/
---

# rsem

## Overview
RSEM (RNA-Seq by Expectation-Maximization) is a specialized tool for quantifying transcript abundances from RNA-Seq data without requiring a reference genome, though it can leverage one. It is particularly effective at handling multi-mapping reads by using an EM algorithm to assign reads to isoforms. This skill guides the user through the two-step workflow of indexing a reference and quantifying reads, including integration with popular aligners like Bowtie2 and STAR.

## Reference Preparation
Before quantification, you must build a reference index. RSEM requires both a genomic FASTA and an annotation file (GTF/GFF3).

- **Standard GTF (Ensembl/GENCODE):**
  `rsem-prepare-reference --gtf annotation.gtf --bowtie2 genome.fa ref/index_name`
- **GFF3 (RefSeq):**
  `rsem-prepare-reference --gff3 annotation.gff3 --bowtie2 genome.fa ref/index_name`
- **Handling "Untypical" Organisms:**
  If the annotation only contains gene features without explicit transcript/exon structures (common in viral genomes), use:
  `--gff3-genes-as-transcripts`
- **Adding Poly(A) Tails:**
  Use `--polyA` to add virtual poly(A) tails to transcripts, which can improve mapping for 3'-end focused libraries.

## Calculating Expression
The primary command for quantification is `rsem-calculate-expression`.

- **Paired-end reads with Bowtie2:**
  `rsem-calculate-expression --bowtie2 --paired-end read1.fq read2.fq ref/index_name sample_out`
- **Single-end reads:**
  Requires fragment length distribution parameters for accuracy:
  `rsem-calculate-expression --bowtie2 --fragment-length-mean 200 --fragment-length-sd 35 read.fq ref/index_name sample_out`
- **Strandedness:**
  Specify library type using `--strandedness <none|forward|reverse>`.
- **Using STAR Aligner:**
  `rsem-calculate-expression --star --star-path /path/to/STAR [reads] ref/index_name sample_out`

## Expert Tips and Best Practices
- **Alignment Requirements:** If providing your own BAM file via `--alignments`, the file must be transcript-coordinate aligned (not genomic) and sorted by read name. Use `rsem-sam-validator` to verify compatibility.
- **Interpretation of Results:**
  - `.genes.results`: Gene-level quantification.
  - `.isoforms.results`: Transcript/Isoform-level quantification.
  - **TPM (Transcripts Per Million)** is generally preferred for across-sample comparisons, while **Expected Counts** are required for differential expression tools like DESeq2 or EBSeq.
- **Memory and Threads:** Use `-p <int>` to enable parallel computation during the EM step.
- **Interpretation of Multi-mapping:** RSEM excels at "isoform-level" multi-mapping. If a read maps to multiple isoforms of the same gene, RSEM uses the EM algorithm to statistically distribute the "count" based on the maximum likelihood.

## Downstream Analysis
To prepare data for differential expression (DE) analysis across multiple samples:
`rsem-generate-data-matrix sample1.genes.results sample2.genes.results > count_matrix.txt`

## Reference documentation
- [RSEM README](./references/deweylab_github_io_RSEM_README.html.md)
- [RSEM Updates and Version History](./references/deweylab_github_io_RSEM_updates.html.md)
- [RSEM Homepage Overview](./references/deweylab_github_io_RSEM.md)