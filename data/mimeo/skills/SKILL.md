---
name: mimeo
description: Mimeo is a bioinformatics suite that parses and annotates repeats, horizontally transferred segments, and conserved transposon sequences from whole-genome alignments. Use when user asks to identify internal repeats, find cross-species repeat features, map shared segments between genomes, or filter SSR-rich sequences from repeat libraries.
homepage: https://github.com/Adamtaranto/mimeo
---

# mimeo

## Overview

Mimeo is a specialized bioinformatics suite for parsing and annotating repeats from whole-genome alignments. It excels at identifying candidate repeat regions, horizontally transferred segments, and conserved coding segments of transposon families. Unlike k-mer based methods, Mimeo's alignment-based approach (powered by LASTZ) is more resilient to indels and repeat-directed point mutations. It provides four primary modules: `self` for internal repeats, `x` for cross-species discovery, `map` for high-identity segment sharing, and `filter` for removing SSR-rich sequences.

## Module Workflows and CLI Patterns

### Internal Repeat Discovery (mimeo-self)
Use this to identify candidate repeat regions within a single genome. It extracts high-identity segments above a specific coverage threshold.

*   **Basic Pattern**:
    `mimeo-self --afasta genome.fasta -d output_dir --gffout repeats.gff3 --minIdt 80 --minLen 100 --minCov 3`
*   **Expert Tip**: Use `--strictSelf` and `--intraCov` to process same-scaffold alignments with higher stringency. This prevents false repeat calls caused by staggered alignments over short tandem duplications.

### Cross-Species Repeat Finding (mimeo-x)
Use this to find features in Genome A that are abundant in an external reference Genome B. This is ideal for identifying newly acquired or low-copy transposons that might be missed by standard copy-number tools.

*   **Basic Pattern**:
    `mimeo-x --afasta genomeA.fasta --bfasta genomeB.fasta --minCov 5 --label B_Reps_in_A`

### High-Identity Mapping (mimeo-map)
Use this to find all shared segments between diverged species or to re-process alignments from other modules to find nested transposons.

*   **Basic Pattern**:
    `mimeo-map --afasta genomeA.fasta --bfasta genomeB.fasta --minIdt 90 --minLen 100`
*   **SSR Filtering**: Integrate Tandem Repeat Finder (TRF) to discard hits masked by SSRs:
    `mimeo-map ... --maxtandem 40 --writeTRF`

### Library Filtering (mimeo-filter)
Use this to post-filter short tandem repeat (SSR) rich sequences from FASTA-formatted candidate-repeat libraries.

*   **Basic Pattern**:
    `mimeo-filter --infile candidate_TEs.fa --maxtandem 40`

## Best Practices and Optimization

*   **Performance**: If providing a large multifasta genome, use `--adir` to specify a directory for split sequences. Mimeo will split the files once and reuse them, significantly speeding up subsequent runs.
*   **Alignment Reuse**: Use the `-r` or `--recycle` flag to skip the computationally expensive alignment step if the `--outfile` (alignment result tab) already exists from a previous run.
*   **Custom Alignments**: You can provide alignments from other tools (like BLAT) as long as they are in a 10-column tab-delimited format:
    `[target_name, target_strand, target_start, target_end, source_name, source_strand, source_start, source_end, score, identity]`
    Ensure the file is sorted by target name and coordinates.
*   **Sensitivity Tuning**:
    *   `--minIdt`: Minimum alignment identity (default is often 80).
    *   `--minLen`: Minimum alignment length (default is often 100bp).
    *   `--hspthresh`: Adjust the LASTZ HSP (High-scoring Segment Pair) threshold to control alignment sensitivity.



## Subcommands

| Command | Description |
|---------|-------------|
| mimeo-filter | Filter SSR containing sequences from fasta library of repeats. |
| mimeo-map | Find all high-identity segments shared between genomes. |
| mimeo-self | Internal repeat finder. Mimeo-self aligns a genome to itself and extracts high-identity segments above an coverage threshold. |

## Reference documentation

- [Mimeo Main Documentation](./references/github_com_Adamtaranto_mimeo_blob_main_README.md)
- [Mimeo CLI Tutorial and Examples](./references/adamtaranto_github_io_mimeo_cli-tutorial.md)