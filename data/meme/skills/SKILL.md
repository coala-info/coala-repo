---
name: meme
description: MEME discovers and analyzes recurring sequence motifs in biological data to identify functional elements like protein-binding sites. Use when user asks to find novel motifs, scan sequences for known patterns, test for motif enrichment, or compare motifs against databases.
homepage: https://meme-suite.org
metadata:
  docker_image: "quay.io/biocontainers/meme:5.5.9--pl5321h1ca524f_0"
---

# meme

## Overview
The MEME Suite is a specialized toolkit for discovering and analyzing sequence motifs—short, recurring patterns in biological sequences that often represent functional elements like protein-binding sites. This skill enables the systematic identification of novel motifs in unaligned sequences, the search for known motifs within genomic data, and the functional characterization of these patterns through enrichment and comparison tools.

## Core Workflows

### 1. Motif Discovery
Use these tools to find novel patterns in a set of related sequences.
- **MEME**: Best for finding multiple, potentially long or complex motifs in small-to-medium datasets.
- **STREME**: Optimized for large datasets (e.g., ChIP-seq); faster and more sensitive than MEME for discovering simple motifs.
- **DREME**: Specifically designed for finding short, eukaryotic transcription factor motifs using a discriminative approach.

### 2. Motif Scanning and Enrichment
Use these tools to locate known motifs or determine if a motif is statistically over-represented.
- **FIMO**: Scans sequences for individual occurrences of a specific motif.
- **AME**: Tests if a set of sequences is enriched for motifs from a known database (e.g., JASPAR).
- **CentriMo**: Identifies motifs that are locally enriched, typically in the center of sequences (ideal for ChIP-seq peaks).
- **MAST**: Searches sequence databases using a group of motifs and ranks sequences by match strength.

### 3. Motif Comparison and Mapping
- **Tomtom**: Compares a discovered motif against a database of known motifs to identify the protein that likely binds to it.
- **GOMo**: Predicts the biological roles (Gene Ontology terms) associated with a motif by analyzing the genes downstream of its occurrences.

## Input Format Requirements

### FASTA Sequences
- Must be plain text.
- Header line starts with `>ID`.
- Supports DNA, RNA, and Protein alphabets.
- For AME, FASTA headers can include a "FASTA score" for rank-based enrichment tests.

### MEME Motif Format
- **Minimal Format**: Requires a version line (e.g., `MEME version 5`), alphabet definition, and the `letter-probability matrix`.
- **Background Frequencies**: Highly recommended to provide background letter frequencies to improve statistical accuracy.
- **Log-odds**: While MEME discovery tools output probabilities, scanning tools like MAST convert these to log-odds scores using the background model.

### BED Files
- Used for genomic coordinates.
- Must be tab-delimited with at least three fields: `chrom`, `chromStart`, `chromEnd`.
- Use `BED2FASTA` to convert these coordinates into sequences for analysis.

## Expert Tips
- **Control Sequences**: When performing enrichment analysis (AME/SEA), always use a control set (e.g., shuffled sequences) to account for biased nucleotide composition (GC content).
- **E-values vs. P-values**: Focus on the **E-value** for discovery; it accounts for the multiple testing performed across the sequence space. An E-value < 0.05 is generally considered significant.
- **Alphabet Consistency**: Ensure your motif alphabet matches your sequence alphabet. Use the "derived alphabet" options if comparing RNA motifs to DNA sequences.
- **Site Counts**: In the `letter-probability matrix`, the `nsites` parameter significantly affects the calculation of pseudocounts and the resulting p-values.



## Subcommands

| Command | Description |
|---------|-------------|
| ame | AME (Analysis of Motif Enrichment) finds known motifs that are enriched in a set of sequences. |
| centrimo | CentriMo (Local Motif Enrichment Analysis) - identifies motifs that are enriched in the center of sequences. |
| dreme | Finds discriminative regular expressions in two sets of DNA sequences. It can also find motifs in a single set of DNA sequences, in which case it uses a dinucleotide shuffled version of the first set of sequences as the second set. |
| fasta-get-markov | Estimate a Markov model from a FASTA file of sequences. Skips tuples containing ambiguous symbols. Combines both strands of complementable alphabets unless -norc is set. |
| fimo | Find Individual Motif Occurrences (FIMO) searches a sequence database for occurrences of known motifs. |
| glam2 | Gapped Local Alignment of Motifs (GLAM2) finds motifs in sequences, allowing for insertions and deletions. |
| mast | Motif Alignment and Search Tool (MAST) - searches for motifs in sequence databases. |
| meme | Motif-based sequence analysis tool for discovering motifs in a set of sequences. |
| sea | Simple Enrichment Analysis (SEA) for motifs in sequences. |
| streme | STREME (Sensitive, Thorough, Rapid, Enriched Motif Elicitation) discovers motifs in a set of sequences. |
| tomtom | Compare a query motif database against one or more target motif databases. |

## Reference documentation
- [MEME Motif Format](./references/meme-suite_org_meme_doc_meme-format.html.md)
- [FASTA Sequence Format](./references/meme-suite_org_meme_doc_fasta-format.html.md)
- [BED Genomic Loci Format](./references/meme-suite_org_meme_doc_bed-format.html.md)
- [AME Tool Guide](./references/meme-suite_org_meme_tools_ame.md)
- [Tomtom Comparison Guide](./references/meme-suite_org_meme_tools_tomtom.md)