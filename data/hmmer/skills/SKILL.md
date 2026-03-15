---
name: hmmer
description: HMMER is a suite of tools for biological sequence analysis that uses profile hidden Markov models to detect remote homologs and annotate protein domains. Use when user asks to build profile HMMs from alignments, search databases for sequence homologs, scan sequences for known domains, or align sequences to an existing profile.
homepage: http://hmmer.org/
---


# hmmer

## Overview
HMMER is a specialized suite for biological sequence analysis that uses probabilistic profile HMMs rather than simple pairwise alignments. While tools like BLAST look for optimal local alignments, HMMER considers the entire ensemble of possible alignments, making it significantly more sensitive for detecting distant homologs (remote homology). It is the engine behind major databases like Pfam and is used for both protein and DNA analysis.

## Core Workflows

### 1. Building and Searching with Profiles
The standard pipeline for finding new members of a protein family starting from a known alignment.
- **Build**: `hmmbuild <output.hmm> <input_alignment.sto>`
- **Search**: `hmmsearch <query.hmm> <target_database.fasta>`
- **Tip**: Use Stockholm (.sto) format for input alignments to preserve metadata.

### 2. Single Sequence Queries (BLAST-like)
When you have a single sequence and want to search a database without manually building an alignment first.
- **Protein**: `phmmer <query.fasta> <target_db.fasta>` (Faster and often more sensitive than BLASTP).
- **Iterative**: `jackhmmer <query.fasta> <target_db.fasta>` (Automated iterative search similar to PSI-BLAST).

### 3. Domain Annotation (Scanning)
When you have a new sequence and want to identify which known domains it contains.
- **Prepare DB**: `hmmpress <database.hmm>` (Required once to index the HMM database).
- **Scan**: `hmmscan <database.hmm> <query.fasta>`

### 4. DNA Analysis
For nucleotide-to-nucleotide searches, specifically optimized for long, chromosome-scale sequences.
- **Search**: `nhmmer <query.fasta_or_hmm> <target_dna.fasta>`
- **Scan**: `nhmmscan <dna_database.hmm> <query_dna.fasta>`

## Expert Tips and Best Practices

### Interpreting Results
- **E-values**: Focus on the "Full Sequence" E-value for homology. Generally, $E < 10^{-3}$ is considered significant.
- **Bias Correction**: HMMER uses a "null2" model to correct for biased composition (e.g., hydrophobic-rich regions). If you suspect a true homolog is being masked by composition, try the `--nonull2` flag.
- **Envelopes vs. Alignments**: In `hmmsearch` output, the "envelope" defines the region where the domain probability is concentrated, while the "alignment" is the specific residue-to-residue mapping.

### Performance Optimization
- **CPU Usage**: Most HMMER tools use multi-threading by default. Control this with `--cpu <n>`.
- **Memory**: For extremely long sequences (e.g., Titin), HMMER3 can be memory-intensive. If a search fails on a massive sequence, ensure the system has sufficient RAM (HMMER4, currently in development, addresses this).
- **Tabular Output**: For pipeline integration, use `--tblout <file>` (sequence hits) or `--domtblout <file>` (domain hits) to get easily parsable space-delimited files.

### Alignment Generation
- Use `hmmalign` to align a large number of sequences to an existing profile:
  `hmmalign <model.hmm> <sequences.fasta> > <output.sto>`
- This is significantly faster than de novo multiple sequence alignment for large datasets.



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
- [HMMER Documentation Overview](./references/hmmer_org_documentation.html.md)