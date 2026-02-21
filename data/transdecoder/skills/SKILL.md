---
name: transdecoder
description: TransDecoder is a specialized tool for finding Open Reading Frames (ORFs) within transcript sequences.
homepage: https://transdecoder.github.io/
---

# transdecoder

## Overview
TransDecoder is a specialized tool for finding Open Reading Frames (ORFs) within transcript sequences. It is essential for converting raw transcriptomic data into protein sequences. The tool identifies likely coding regions by looking for long ORFs and using a Markov model to score hexamer frequencies, ensuring that the predicted proteins are biologically plausible rather than random occurrences.

## Core Workflow
The standard TransDecoder analysis requires two primary steps:

1.  **ORF Extraction**: Identify all ORFs meeting a minimum length requirement (default 100 amino acids).
    ```bash
    TransDecoder.LongOrfs -t transcripts.fasta
    ```
    *Output*: Creates a directory `.transcripts.fasta.transdecoder_dir` containing intermediate files.

2.  **Coding Region Prediction**: Predict the most likely coding regions based on hexamer scores and ORF length.
    ```bash
    TransDecoder.Predict -t transcripts.fasta
    ```
    *Output*: Generates `.pep` (protein), `.cds` (coding nucleotide), `.gff3` (positions), and `.bed` files.

## Expert Tips and Best Practices
- **Minimum Length**: If working with fragmented assemblies, you can lower the minimum ORF length using `-m` (e.g., `-m 50`), but be aware this increases the false positive rate.
- **Strand Specificity**: If your RNA-Seq data is strand-specific, use the `-S` flag in `TransDecoder.Predict` to restrict predictions to the top strand only.
- **Homology Search (Optional but Recommended)**: To improve accuracy for lowly expressed or unique genes, run BlastP against UniProt and/or HMMER against Pfam using the `.pep` file from the `LongOrfs` step. You can then pass these results to `TransDecoder.Predict`:
    ```bash
    TransDecoder.Predict -t transcripts.fasta --retain_blastp_hits blastp.outfmt6 --retain_pfam_hits pfam.domtblout
    ```
- **Genome-Based Transcripts**: If your transcripts were generated via genome alignment (GFF3/GTF), use the `util/gtf_to_alignment_id_list.pl` and `util/gtf_genome_to_cdna_fasta.pl` utilities provided in the TransDecoder kit to prepare your FASTA files correctly before running the main pipeline.

## Reference documentation
- [TransDecoder Overview](./references/anaconda_org_channels_bioconda_packages_transdecoder_overview.md)
- [TransDecoder GitHub Documentation](./references/transdecoder_github_io_index.md)