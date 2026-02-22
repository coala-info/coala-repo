---
name: td2
description: TD2 is a de novo open reading frame (ORF) finder designed to identify likely protein-coding regions in transcriptomic data.
homepage: https://github.com/Markusjsommer/TD2
---

# td2

## Overview

TD2 is a de novo open reading frame (ORF) finder designed to identify likely protein-coding regions in transcriptomic data. It follows a workflow similar to TransDecoder but enhances prediction stability by utilizing a pre-trained protein model (PSAURON) and extreme value analysis. This allows it to produce consistent results regardless of whether it is processing a single transcript or a complex mixture of organisms. It identifies coding sequences based on a combination of minimum ORF length, PSAURON likelihood scores, and false discovery rate (FDR) thresholds.

## Basic Workflow

The standard TD2 pipeline consists of two primary steps: identifying potential ORFs and then predicting which ones are likely to be coding.

### 1. Extract Long ORFs
Identify all ORFs meeting a minimum length requirement.
```bash
TD2.LongOrfs -t target_transcripts.fasta [options]
```
*   **Strand Specificity**: If your transcripts are oriented (sense strand), use `-S` to limit the search to the top strand.
*   **Minimum Length**: Use `-m <int>` to change the minimum amino acid length (default is 90). Note that shorter lengths significantly increase false positive rates.

### 2. Predict Coding Regions
Filter the extracted ORFs to find the most likely coding candidates.
```bash
TD2.Predict -t target_transcripts.fasta [options]
```
The final outputs will be generated in the current directory with extensions `.pep` (peptides), `.cds` (nucleotides), `.gff3` (positions), and `.bed`.

## Genome-Based Workflow

When starting with a genome and a GTF file (from StringTie or Cufflinks), use the provided utility scripts to prepare the data.

1.  **Generate Transcript Fasta**:
    ```bash
    util/gtf_genome_to_cdna_fasta.pl transcripts.gtf genome.fasta > transcripts.fasta
    ```
2.  **Convert GTF to GFF3**:
    ```bash
    util/gtf_to_alignment_gff3.pl transcripts.gtf > transcripts.gff3
    ```
3.  **Run TD2 Pipeline**:
    Execute `TD2.LongOrfs` and `TD2.Predict` as described in the basic workflow.
4.  **Map Predictions back to Genome**:
    ```bash
    util/cdna_alignment_orf_to_genome_orf.pl \
        transcripts.fasta.TD2.gff3 \
        transcripts.gff3 \
        transcripts.fasta > transcripts.fasta.TD2.genome.gff3
    ```

## Advanced: Homology Integration

To increase sensitivity for functional ORFs that might have lower coding scores, you can include homology search results (e.g., from MMSeqs2, BLAST, or Pfam) as retention criteria.

1.  Run `TD2.LongOrfs` first.
2.  Search the generated peptide file (`transcripts.TD2_dir/longest_orfs.pep`) against a database:
    ```bash
    mmseqs easy-search transcripts.TD2_dir/longest_orfs.pep swissprot alnRes.m8 tmp -s 7.0
    ```
3.  Pass the homology results to `TD2.Predict`:
    ```bash
    TD2.Predict -t target_transcripts.fasta --mmseqs2 alnRes.m8
    ```

## Expert Tips

*   **Memory Management**: For very large transcriptomes, monitor memory usage during the PSAURON scoring phase.
*   **Output Directory**: TD2 creates a working directory (e.g., `transcripts.TD2_dir/`) for intermediate files like `psauron_score.csv`. Do not delete this until the `Predict` step is finished.
*   **FDR Control**: TD2 uses extreme value analysis to fix the False Discovery Rate for long ORFs, which is particularly useful when dealing with non-model organisms where standard length thresholds might be inappropriate.

## Reference documentation
- [TD2 Wiki](./references/github_com_Markusjsommer_TD2_wiki.md)
- [TD2 Overview](./references/anaconda_org_channels_bioconda_packages_td2_overview.md)