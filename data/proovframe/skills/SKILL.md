---
name: proovframe
description: Proovframe restores the frame-fidelity of long-read sequencing data by correcting frameshifts and masking premature stop codons using protein-to-DNA alignments. Use when user asks to fix frameshifts in long reads or assemblies, map protein guides to sequences, or prepare sequences for gene prediction and functional annotation.
homepage: https://github.com/thackl/proovframe
---

# proovframe

## Overview

Proovframe is a specialized tool designed to restore the frame-fidelity of long-read sequencing data. It is particularly useful for gene prediction in metagenomic samples where sequencing depth is insufficient for traditional consensus polishing. By using frameshift-aware alignments to reference proteins (even distantly related ones with <60% identity), it inserts or deletes "N" bases to correct the reading frame and masks premature stop codons.

## Core Workflow

The proovframe workflow consists of two primary steps: mapping protein guides to your sequences and then applying the fixes.

### 1. Map Proteins to Reads
Use the `map` command to generate a guide alignment. This requires DIAMOND (v2.0.3+) to be installed in your environment.

```bash
proovframe map -a proteins.faa -o alignments.tsv raw-seqs.fa
```

*   `-a`: Path to the reference protein database (FASTA).
*   `-o`: Output TSV file containing the frameshift-aware alignments.
*   `raw-seqs.fa`: Your input long reads or assembly contigs.

### 2. Fix Frameshifts
Use the `fix` command to produce the corrected FASTA file based on the mapping results.

```bash
proovframe fix -o corrected-seqs.fa raw-seqs.fa alignments.tsv
```

*   `-o`: Path for the corrected output FASTA.
*   `raw-seqs.fa`: The original input sequences.
*   `alignments.tsv`: The mapping file generated in the previous step.

## Expert Tips and Patterns

- **Polishing Assemblies**: Proovframe can be used as a final polishing step after classic consensus-polishing tools (like Racon or Medaka) to catch remaining indels in coding regions.
- **Handling Rare Taxa**: For environmental samples with low coverage where consensus polishing is impossible, proovframe can be applied directly to raw reads to enable functional annotation.
- **Reference Selection**: You do not need perfectly matching proteins; the tool is effective with guide proteins sharing less than 60% amino acid identity.
- **Stop Codon Masking**: By default, the tool masks premature stops with "NNN" to prevent truncated gene predictions during downstream analysis.
- **Genetic Codes**: If working with non-standard organisms (e.g., certain mitochondria or bacteria), ensure you check if the version supports specific genetic code flags (often `-g`).



## Subcommands

| Command | Description |
|---------|-------------|
| proovframe_fix | Fixes frameshifts in sequences based on Diamond output. |
| proovframe_map | For consensus sequences with rather low expected error rates and if your reference database has a good represention of similar sequences, you might want to switch to '-m fast' or '-m sensitive' to speed things up. Also note, I've experienced inefficient parallelization if correcting a small number of Mb sized genomes (as opposed to thousands of long-reads) - presumably because diamond threads on a per-sequence basis |
| proovframe_prf | Assess error rate of a query sequence against a reference sequence. |

## Reference documentation

- [proovframe: frame-shift correction for long read (meta)genomics](./references/github_com_thackl_proovframe.md)
- [proovframe README](./references/github_com_thackl_proovframe_blob_main_README.org.md)