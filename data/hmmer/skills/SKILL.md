---
name: hmmer
description: HMMER is a suite of tools for protein and DNA homology searches that uses profile hidden Markov models to detect remote homologs with high sensitivity. Use when user asks to build a profile from a multiple sequence alignment, search protein or DNA databases for homologous sequences, or annotate domains within a sequence.
homepage: http://hmmer.org/
---


# hmmer

## Overview
HMMER is a specialized suite for protein and DNA homology searches that uses probabilistic "profiles" instead of simple pairwise alignments. Unlike BLAST, which looks for optimal local alignments, HMMER considers an ensemble of all possible alignments, making it significantly more sensitive for detecting remote homologs. It is the engine behind major databases like Pfam and is used to turn a multiple sequence alignment into a position-specific scoring model that captures the evolutionary conservation of a gene family.

## Core Workflows and CLI Patterns

### 1. Building and Searching with Profiles
The standard pipeline for searching a database with a known family alignment.
*   **Build a profile:** `hmmbuild <output.hmm> <input_alignment.sto>`
    *   *Tip:* Use Stockholm (.sto) format for best results as it preserves annotation.
*   **Search a database:** `hmmsearch <query.hmm> <target_db.fasta>`
    *   *Key Statistic:* Focus on the **E-value**. Values < 1e-3 are generally considered significant.
    *   *Full vs. Domain:* "Full sequence" scores sum all domain hits; "Best 1 domain" scores the single strongest match.

### 2. Single Sequence Queries (Protein)
When you have a single sequence and no alignment, use these BLAST-like tools:
*   **phmmer:** Search a single protein sequence against a database.
    *   `phmmer <query.fasta> <target_db.fasta>`
*   **jackhmmer:** Iteratively search a database (similar to PSI-BLAST) to build a profile on the fly.
    *   `jackhmmer <query.fasta> <target_db.fasta>`

### 3. Domain Annotation (Scanning)
To identify which known domains exist within a new protein sequence:
*   **Prepare the database:** `hmmpress <pfam.hmm>` (Creates binary indices required for `hmmscan`).
*   **Scan the sequence:** `hmmscan <pfam.hmm> <query.fasta>`

### 4. DNA Analysis
*   **nhmmer:** Specifically optimized for DNA-DNA searches, capable of handling chromosome-sized target sequences.
    *   `nhmmer <query.fasta_or_hmm> <target_dna.fasta>`

## Expert Tips
*   **Acceleration:** HMMER uses SIMD vectorization. If a search is slow, ensure you are utilizing multiple cores with `--cpu <n>`.
*   **Alignment Uncertainty:** HMMER provides "posterior probabilities" for each aligned residue. In the output alignment, the line below the consensus shows digits 1-9 and '*', where '*' indicates >95% confidence in that specific residue's alignment.
*   **Output Formatting:** For large-scale bioinformatics pipelines, use the `--tblout <file>` or `--domtblout <file>` options to generate easy-to-parse tabular summaries instead of the standard human-readable output.
*   **Effective Sequence Number:** In `hmmbuild` output, `eff_nseq` shows how much unique information is in your alignment. If this is much lower than the actual number of sequences, your input is highly redundant.



## Subcommands

| Command | Description |
|---------|-------------|
| hmmalign | align sequences to a profile HMM |
| hmmbuild | profile HMM construction from multiple sequence alignments |
| hmmemit | sample sequence(s) from a profile HMM |
| hmmpress | prepare an HMM database for faster hmmscan searches |
| hmmscan | search sequence(s) against a profile database |
| hmmsearch | search profile(s) against a sequence database |
| hmmstat | display summary statistics for a profile file |
| jackhmmer | iteratively search a protein sequence against a protein database |
| makehmmerdb | build a HMMER binary-formatted database from an input sequence file |
| nhmmer | search a DNA model, alignment, or sequence against a DNA database |
| phmmer | search a protein sequence against a protein database |

## Reference documentation
- [HMMER User's Guide](./references/eddylab_org_software_hmmer_Userguide.md)
- [HMMER Documentation Overview](./references/documentation.html.md)