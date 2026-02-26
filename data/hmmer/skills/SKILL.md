---
name: hmmer
description: HMMER is a suite for biosequence analysis that uses profile hidden Markov models to detect remote homologs and identify protein domains. Use when user asks to build profiles from alignments, search sequence databases for homologs, scan sequences for known domains, or perform iterative protein searches.
homepage: http://hmmer.org/
---


# hmmer

## Overview
HMMER is a specialized suite for biosequence analysis that uses probabilistic models (profile HMMs) rather than simple pairwise alignments. It is significantly more sensitive than BLAST for detecting remote homologs because it considers the position-specific conservation patterns within a sequence family. Use this skill to identify protein domains, search genomic data for specific motifs, or align large sets of sequences to a known family consensus.

## Core Workflows

### 1. Profile Construction and Database Searching
The standard pipeline for finding new members of a protein family.
*   **Build a profile:** `hmmbuild <output.hmm> <input_alignment.sto>`
    *   *Tip:* Use Stockholm (.sto) format for best results, though aligned FASTA is supported.
*   **Search a database:** `hmmsearch <query.hmm> <database.fasta> > <results.out>`
    *   *Tip:* Use `--cpu <n>` to specify the number of worker threads (default is usually 2).

### 2. Single Sequence Queries (BLAST-like)
When you have a single protein sequence and want to find homologs without a pre-built alignment.
*   **Standard search:** `phmmer <query.fasta> <database.fasta>`
*   **Iterative search (PSI-BLAST style):** `jackhmmer <query.fasta> <database.fasta>`
    *   This automatically builds a profile from hits and re-searches through multiple iterations.

### 3. Domain Annotation (Scanning)
When you have a new sequence and want to know what known domains (e.g., from Pfam) it contains.
*   **Prepare the database:** `hmmpress <pfam.hmm>` (Required once to create binary indices).
*   **Scan the sequence:** `hmmscan <pfam.hmm> <query.fasta>`

### 4. DNA Analysis
For searching nucleotide sequences against DNA profiles or other DNA sequences.
*   **Search DNA:** `nhmmer <query.fasta_or_hmm> <target_dna.fasta>`
    *   *Note:* `nhmmer` handles long, chromosome-scale target sequences efficiently.

## Expert Tips and Best Practices

### Interpreting E-values
*   **Sequence E-value:** The expected number of false positives in the entire database search. Values < 0.001 are generally considered significant.
*   **Domain E-value (Conditional):** The significance of a specific domain match given that the sequence is already a hit. Use this to distinguish between multiple domains in a single protein.

### Handling Biased Composition
If you are getting "junk" hits in low-complexity regions (e.g., proline-rich areas):
*   The **Bias Filter** is on by default. If you suspect it is too aggressive and hiding true homologs, use `--nobias`.
*   To turn off the null2 score correction entirely, use `--nonull2`.

### Output Management
*   **Tabular Output:** For downstream scripting, use `--tblout <file>` (sequence hits) or `--domtblout <file>` (domain-specific coordinates). These are much easier to parse than the standard human-readable output.
*   **Alignment Extraction:** Use `hmmalign --mapali <alignment.sto> <query.hmm> <new_sequences.fasta>` to align new sequences to an existing structural alignment.

## Common CLI Patterns

| Task | Command |
| :--- | :--- |
| **Build HMM** | `hmmbuild family.hmm seed.sto` |
| **Search Protein DB** | `hmmsearch family.hmm nr.fasta` |
| **Search DNA DB** | `nhmmer query.fasta genome.fasta` |
| **Iterative Search** | `jackhmmer -N 5 query.fasta swissprot.fasta` |
| **Get Stats** | `hmmstat family.hmm` |
| **Generate Sequences** | `hmmemit -N 10 family.hmm` |

## Reference documentation
- [HMMER User's Guide](./references/eddylab_org_software_hmmer_Userguide.md)
- [HMMER Documentation Overview](./references/hmmer_org_documentation.html.md)
- [Input Formats and Stockholm Syntax](./references/index.html.md)