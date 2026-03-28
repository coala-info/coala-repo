---
name: ntlink
description: ntLink is a genome assembly tool that bridges and orients contigs using long-read evidence to produce scaffolds. Use when user asks to scaffold draft assemblies, fill gaps with long reads, perform iterative scaffolding, or generate read-to-contig mappings.
homepage: https://github.com/bcgsc/ntLink
---

# ntlink

## Overview

ntLink is a lightweight genome assembly tool designed to bridge and orient contigs using long-read evidence. It utilizes ordered minimizer sketches to map reads to a target assembly, constructs a scaffold graph based on these mappings, and traverses the graph to produce final scaffolds. It is particularly useful for refining draft assemblies where high-accuracy long reads are available to resolve gaps and overlaps.

## Core CLI Usage

### Standard Scaffolding
Run the basic scaffolding pipeline to orient and order contigs.
```bash
ntLink scaffold target=assembly.fa reads=long_reads.fq.gz k=32 w=100
```

### Scaffolding with Gap-Filling
Enable the `gap_fill` target to fill scaffold gaps with raw read sequences. Note that `overlap=True` (default) is required for this mode.
```bash
ntLink scaffold gap_fill target=assembly.fa reads=long_reads.fq.gz
```

### Iterative Scaffolding (Rounds)
Use the `ntLink_rounds` utility to run multiple iterations. This uses liftover coordinates to avoid re-mapping reads, significantly reducing runtime.
```bash
# Run 5 rounds without gap-filling
ntLink_rounds run_rounds target=assembly.fa reads=long_reads.fq.gz rounds=5

# Run 5 rounds with gap-filling at each iteration
ntLink_rounds run_rounds_gapfill target=assembly.fa reads=long_reads.fq.gz rounds=5
```

### Mapping Only
To generate read-to-contig mappings without performing scaffolding, use the `pair` target.
```bash
ntLink pair target=assembly.fa reads=long_reads.fq.gz paf=True
```

## Parameter Optimization

| Parameter | Default | Recommended Range | Description |
| :--- | :--- | :--- | :--- |
| `k` | 32 | 24 - 40 | K-mer size for minimizers. |
| `w` | 100 | 100 - 500 | Window size for minimizers. |
| `z` | 1000 | >500 | Minimum contig size (bp) to consider for scaffolding. |
| `n` | 1 | 1 - 5 | Minimum graph edge weight (number of supporting reads). |

### Expert Tips
- **Grid Search**: If results are suboptimal, perform a grid search across k (24, 32, 40) and w (100, 250, 500).
- **Thread Management**: The `indexlr` step is multi-threaded but capped at 5 threads. Setting `t=5` is usually sufficient.
- **Disk Space**: Use the `extra_clean` target to aggressively remove intermediate files, leaving only the final scaffolds.
- **Polishing**: Because `gap_fill` uses raw read sequences, always run a polishing tool (like Medaka or Pilon) on the final output to correct errors in the filled regions.

## Output Files
- `*.ntLink.scaffolds.fa`: The final scaffolded assembly.
- `*.path`: Tab-separated file describing scaffold composition (contig orientation and gap sizes).
- `*.paf`: Read-to-contig mappings in PAF format (if `paf=True` is set).



## Subcommands

| Command | Description |
|---------|-------------|
| make | GNU Make is a tool which controls the generation of programs and other non-source files from a description file. |
| make | GNU Make is a tool which controls the makeup of large programs that depend on many smaller pieces.  Make takes a description file that says how to build the program and which pieces depend on which other pieces.  It figures out what needs to be rebuilt and issues the commands to rebuild them.  This program built for x86_64-conda-linux-gnu |

## Reference documentation
- [ntLink Main README](./references/github_com_bcgsc_ntLink.md)
- [Gap-filling Feature](./references/github_com_BirolLab_ntLink_wiki_Gap-filling-feature.md)
- [Overlap Feature](./references/github_com_BirolLab_ntLink_wiki_Overlap-Feature.md)
- [Running Rounds of ntLink](./references/github_com_BirolLab_ntLink_wiki_Running-rounds-of-ntLink.md)
- [Tips for Running ntLink](./references/github_com_BirolLab_ntLink_wiki_Tips-for-running-ntLink.md)
- [Output File Formats](./references/github_com_BirolLab_ntLink_wiki_Output-file-formats.md)