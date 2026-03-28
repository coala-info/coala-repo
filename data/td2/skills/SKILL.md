---
name: td2
description: TD2 identifies likely coding regions within transcriptomes by extracting long open reading frames and predicting their coding potential using a pre-trained protein model. Use when user asks to identify coding regions in transcripts, extract long ORFs, or annotate non-model organism transcriptomes.
homepage: https://github.com/Markusjsommer/TD2
---


# td2

## Overview

TD2 is an evolution of the TransDecoder workflow designed to identify likely coding regions within transcriptomes. It distinguishes itself by using a pre-trained protein model (PSAURON) and extreme value analysis, allowing it to make stable predictions even for individual transcripts or mixed-organism samples without requiring a large training set. It is particularly useful for annotating non-model organisms or validating transcripts from complex environmental samples.

## Core Workflow

The standard TD2 pipeline consists of two primary steps: ORF extraction and coding region prediction.

### 1. Extract Long ORFs
Identify all potential open reading frames meeting a minimum length requirement.

```bash
TD2.LongOrfs -t transcripts.fasta
```

**Key Options:**
- `-m <int>`: Minimum amino acid length (default: 90). Lowering this increases false positives.
- `-S`: Strand-specific mode. Use this if your transcripts are oriented according to the sense strand to ignore the reverse strand.

### 2. Predict Coding Regions
Filter the extracted ORFs based on coding potential and homology.

```bash
TD2.Predict -t transcripts.fasta [options]
```

**Key Options:**
- `--retain_blastp_hits <file>`: Retain ORFs with homology to known proteins (outfmt 6).
- `--retain_pfam_hits <file>`: Retain ORFs containing known protein domains (hmmscan --domtblout).
- `--single_best_only`: Report only the single best ORF per transcript.

## Genome-Guided Workflows

If starting with a genome-based GTF (e.g., from StringTie), use the included utility scripts to map transcript-level predictions back to genomic coordinates.

1. **Generate Fasta:**
   ```bash
   util/gtf_genome_to_cdna_fasta.pl transcripts.gtf genome.fasta > transcripts.fasta
   ```
2. **Convert GTF to GFF3:**
   ```bash
   util/gtf_to_alignment_gff3.pl transcripts.gtf > transcripts.gff3
   ```
3. **Run TD2:**
   Execute `TD2.LongOrfs` and `TD2.Predict` as shown in the core workflow.
4. **Map to Genome:**
   ```bash
   util/cdna_alignment_orf_to_genome_orf.pl \
        transcripts.fasta.TD2.gff3 \
        transcripts.gff3 \
        transcripts.fasta > transcripts.fasta.TD2.genome.gff3
```

## Expert Tips

- **Homology Integration:** To maximize sensitivity, always perform a homology search (MMSeqs2, BLASTp, or HMMER) against a database like Swiss-Prot or Pfam between the `LongOrfs` and `Predict` steps. TD2 will retain these ORFs even if they fall below the default coding likelihood threshold.
- **Output Files:**
    - `.pep`: Protein sequences for candidate ORFs.
    - `.cds`: Nucleotide sequences for the coding regions.
    - `.gff3`: Positions of ORFs relative to the input transcripts.
    - `.bed`: Ideal for visualization in IGV or GenomeView.
- **Memory Management:** For very large transcriptomes, ensure you have sufficient RAM for the PSAURON scoring step, or process the fasta in chunks.



## Subcommands

| Command | Description |
|---------|-------------|
| TD2.LongOrfs | Finds the longest ORFs in transcripts. |
| TD2.Predict | Predicts ORFs from transcripts. |

## Reference documentation
- [TD2 Wiki Home](./references/github_com_Markusjsommer_TD2_wiki.md)
- [TD2 Repository Overview](./references/github_com_Markusjsommer_TD2.md)