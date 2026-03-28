---
name: repeatscout
description: RepeatScout performs de novo discovery of repetitive element families within DNA sequences to generate consensus libraries. Use when user asks to identify repetitive elements, build a repeat library, or find de novo repeats in a genome.
homepage: https://github.com/Dfam-consortium/RepeatScout
---


# repeatscout

## Overview

RepeatScout is a specialized tool for the *de novo* discovery of repetitive element families within DNA sequences. It operates by identifying short exact matches (seeds) and extending them into consensus sequences using a "fit-preferred" alignment score that accounts for partial repeat instances. The tool is designed to produce a FASTA file of repeat family consensuses which can then be used as a library for RepeatMasker. The workflow typically involves generating l-mer frequency tables, running the core discovery algorithm, and applying several filtering scripts to refine the output by removing tandem repeats, low-complexity regions, and non-mobile elements like segmental duplications.

## Core Workflow and CLI Patterns

The RepeatScout process is executed in four distinct phases.

### Phase 1: Build l-mer Frequency Table
Tabulate the frequency of all l-mers in the target sequence.

```bash
build_lmer_table -sequence genome.fa -freq genome.freq
```

*   **Note on `-l`**: By default, $l = \lceil \log_4(L) + 1 \rceil$ where $L$ is the sequence length. If you manually set `-l`, you **must** use the same value in Phase 2.

### Phase 2: Discover Repeat Families
Run the primary RepeatScout algorithm using the frequency table.

```bash
RepeatScout -sequence genome.fa -freq genome.freq -output repeats.fa
```

*   **Sensitivity**: Use `-stopafter 500` to match the original paper's sensitivity (default is 100 for speed).
*   **Tandem Distance**: Use `-tandem <dist>` (default 500) to set the minimum distance between countable instances of an l-mer, preventing consensus building for satellite repeats.

### Phase 3: First Stage Filtering
Remove low-complexity and tandem elements. This script requires `dustmasker` (NCBI BLAST+) and `trf` (Tandem Repeats Finder) to be in your PATH.

```bash
perl filter-stage-1.prl repeats.fa > repeats.filtered1.fa
```

### Phase 4: Second Stage Filtering
Filter out repeat elements that do not appear a minimum number of times (default is 10). This requires running RepeatMasker on your sequence using the filtered library from Phase 3 first.

1.  **Run RepeatMasker**:
    ```bash
    RepeatMasker genome.fa -lib repeats.filtered1.fa
    ```
2.  **Filter by occurrence**:
    ```bash
    perl filter-stage-2.prl --cat genome.fa.out --list repeats.filtered1.fa --thresh 10 > repeats.filtered2.fa
    ```

## Expert Tips and Best Practices

*   **Memory Management**: RepeatScout is memory-intensive. For whole genomes, it is often more practical to run it on individual chromosomes or large scaffolds rather than the entire assembly at once.
*   **Sequence Boundaries**: The Dfam-maintained version of RepeatScout honors sequence boundaries (indicated by `>`) to prevent seeds from extending across different contigs/chromosomes.
*   **Consensus Refinement**: The output of RepeatScout is a set of consensus sequences. If the tool discovers a family, it updates seed counts to prevent the same family from being rediscovered in the same run.
*   **Integration with GFF**: Use `compare-out-to-gff.prl` to remove sequences that overlap with known "uninteresting" regions like exons or segmental duplications, ensuring your library focuses on mobile elements.



## Subcommands

| Command | Description |
|---------|-------------|
| RepeatScout | RepeatScout Version 1.0.7 |
| build_lmer_table | Builds a table of lmers from a sequence. |
| compare-out-to-gff.prl | Compares RepeatMasker output to a set of GFF feature files. |
| filter-stage-1.prl | a first stage post-processing tool for RepeatScout output. |
| filter-stage-2.prl | Filter a repeat library by number of occurrences |

## Reference documentation
- [RepeatScout README](./references/github_com_Dfam-consortium_RepeatScout_blob_main_README.md)
- [build_lmer_table Source](./references/github_com_Dfam-consortium_RepeatScout_blob_main_build_lmer_table.c.md)