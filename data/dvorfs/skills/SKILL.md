---
name: dvorfs
description: dvorfs detects and reconstructs highly degraded or pseudogenized viral sequences within host genomes by incorporating frameshift mutations and stop codons into its search model. Use when user asks to search for endogenous viral elements, reconstruct non-pseudogenized amino acid sequences from degraded DNA, or identify viral open reading frames using protein profiles.
homepage: https://github.com/ilevantis/dvorfs
metadata:
  docker_image: "quay.io/biocontainers/dvorfs:1.0.1--pyhdfd78af_0"
---

# dvorfs

## Overview

dvorfs (Disrupted Viral ORF Search) is a specialized bioinformatics pipeline designed to detect and reconstruct highly degraded viral sequences within host genomes. While standard alignment tools often struggle with pseudogenes, dvorfs utilizes GeneWise to incorporate frameshift mutations and stop codons into its search model. This allows it to reconstruct a reasonable estimate of the original non-pseudogenized amino acid sequence, making it an essential tool for evolutionary virology and paleovirology.

## Usage Guidelines

### Core Workflow
The tool operates in three distinct stages:
1.  **Presearch**: Windows and translates DNA sequences to perform a lenient HMMER search.
2.  **Search**: Uses the GeneWise 3:33L model to search identified hit locations and their flanking regions.
3.  **Post-process**: Combines and filters hits to produce a final set of predicted coding sequences.

### Essential CLI Patterns

**Basic Search**
Search a genome using a protein profile (Stockholm format):
```bash
dvorfs -f genome.fasta --seed viral_protein.sto -p 8
```

**Using Pre-compiled HMMs**
If you already have a HMMER3 profile:
```bash
dvorfs -f genome.fasta -h viral_domain.hmm --filter no-overlap
```

**Targeted Search (Skipping Presearch)**
If you have specific genomic coordinates of interest (e.g., from BLAST or RepeatMasker), provide them in BED format to bypass the initial HMMER stage:
```bash
dvorfs -f genome.fasta --seed query.sto --bed regions_of_interest.bed
```

### Best Practices and Expert Tips

*   **Index Your Fasta**: dvorfs requires the subject FASTA to be indexed. Always run `samtools faidx your_genome.fasta` before starting.
*   **Thread Management**: Use the `-p` flag to specify CPU cores. GeneWise is computationally intensive; providing more threads significantly reduces runtime during the Search stage.
*   **Overlap Filtering**: Use `--filter no-overlap` to ensure the output table is cleaned of redundant hits that occupy the same genomic space.
*   **Interpreting Amino Acid Sequences**: The output `aaseq` column contains special characters indicating the nature of the degradation:
    *   `?`: Codon containing a base pair deletion.
    *   `&`: Codon containing a base pair insertion.
    *   `!`: Nonsense frameshifting insertion.
    *   `x`: Gaps between alignment sections (length corresponds to missing pHMM positions).
*   **Input Flexibility**: dvorfs accepts HMMER2 (common in GyDB) and HMMER3 (common in PFAM) formats. It automatically handles the conversion if the correct input flag is used.

## Reference documentation

- [dvorfs GitHub Repository](./references/github_com_ilevantis_dvorfs.md)
- [dvorfs Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_dvorfs_overview.md)