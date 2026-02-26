---
name: mimeo
description: Mimeo is a bioinformatics suite that uses alignment-based approaches to identify, parse, and annotate repeats and shared segments within or between genomes. Use when user asks to identify internal repeat regions, find cross-species repeat abundance, map shared segments for horizontal gene transfer detection, or filter simple sequence repeats from candidate libraries.
homepage: https://github.com/Adamtaranto/mimeo
---


# mimeo

## Overview
Mimeo is a bioinformatics suite designed to parse and annotate repeats from whole-genome alignments. Unlike k-mer based methods, mimeo utilizes alignment-based approaches (primarily via LASTZ) to identify high-identity segments. This makes it particularly effective at finding repeats that might be disrupted by indels or point mutations. It is organized into specialized modules for self-alignment, cross-species comparison, and raw alignment mapping, with built-in support for filtering simple sequence repeats (SSRs).

## Core Modules and CLI Patterns

### 1. Internal Repeat Finding (`mimeo self`)
Use this to identify candidate repeat regions within a single genome. It aligns a genome against itself and collapses overlapping segments above a coverage threshold.

*   **Standard Usage:**
    ```bash
    mimeo self --afasta genome.fasta -d output_dir --gffout repeats.gff3 --minIdt 80 --minLen 100 --minCov 3
    ```
*   **Expert Tip:** Use `--strictSelf` and `--intraCov` to handle same-scaffold alignments separately. This is critical for avoiding false positives caused by staggered alignments over short tandem duplications or SSRs.

### 2. Cross-Species Repeat Discovery (`mimeo x`)
Use this to find features in Genome A that are abundant in Genome B. This is ideal for identifying transposons that are low-copy in the target genome but high-copy in a donor or related species.

*   **Standard Usage:**
    ```bash
    mimeo x --afasta target.fasta --bfasta reference.fasta -d output_dir --minIdt 80 --minCov 5
    ```

### 3. HGT and Shared Segment Mapping (`mimeo map`)
Use this to identify all high-identity segments shared between genomes without applying a coverage filter. This is the primary tool for HGT candidate detection.

*   **Standard Usage:**
    ```bash
    mimeo map --afasta genome_A.fasta --bfasta genome_B.fasta --minIdt 90 --minLen 100
    ```

### 4. SSR Filtering (`mimeo filter`)
Post-process candidate repeat libraries to remove sequences dominated by short tandem repeats.

*   **Standard Usage:**
    ```bash
    mimeo filter --infile candidate_repeats.fa
    ```

## Best Practices and Optimization

*   **Alignment Recycling:** If you need to re-run an analysis with different filtering parameters (e.g., changing `--minIdt` or `--minLen`), use the `--recycle` flag. This allows mimeo to skip the computationally expensive LASTZ alignment step and re-process the existing `--outfile`.
*   **Tandem Repeat Integration:** When using `mimeo map`, you can integrate Tandem Repeats Finder (TRF) results directly using `--maxtandem <int>`. This filters out hits where a specific percentage of the sequence is comprised of tandem repeats.
*   **Input Preparation:** For large genomes, providing the genome as a multifasta via `--afasta` is standard. Mimeo can automatically split these into individual scaffolds in a directory specified by `--adir`.
*   **Output Interpretation:**
    *   **GFF3:** Best for downstream genome browser visualization or overlap analysis.
    *   **Tab File:** Contains raw alignment data; useful for custom statistical analysis of identity and coverage breakpoints.

## Reference documentation
- [Mimeo GitHub Repository](./references/github_com_Adamtaranto_mimeo.md)
- [Bioconda Mimeo Overview](./references/anaconda_org_channels_bioconda_packages_mimeo_overview.md)