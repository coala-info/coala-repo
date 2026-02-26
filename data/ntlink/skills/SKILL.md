---
name: ntlink
description: ntLink is a lightweight, minimizer-based tool used to scaffold genome assemblies and fill gaps using long-read data. Use when user asks to scaffold a draft assembly, fill gaps with long reads, perform iterative scaffolding rounds, or generate read-to-contig mappings.
homepage: https://github.com/bcgsc/ntLink
---


# ntlink

## Overview

ntLink is a lightweight, minimizer-based tool designed to scaffold genome assemblies using long-read data. It performs a lightweight mapping between a target assembly and long reads to identify contig pairs, which are then used as evidence to orient and order the output scaffolds. This skill provides guidance on executing scaffolding, gap-filling, and iterative rounds to maximize assembly continuity.

## Common CLI Patterns

### Basic Scaffolding
The primary command to scaffold a draft assembly using long reads:
```bash
ntLink scaffold target=my_assembly.fa reads=long_reads.fq.gz k=32 w=100
```

### Scaffolding with Gap-Filling
To fill gap regions with raw read sequences during the scaffolding process:
```bash
ntLink scaffold gap_fill target=my_assembly.fa reads=long_reads.fq.gz overlap=True
```
*Note: Gaps are filled with raw sequences; subsequent polishing is recommended.*

### Iterative Scaffolding (Rounds)
To maximize scaffolding gains, run multiple rounds using the `ntLink_rounds` utility, which utilizes mapping liftover to reduce computational costs:
```bash
ntLink_rounds run_rounds target=my_assembly.fa reads=long_reads.fq.gz k=24 w=250 rounds=5
```

### Mapping Only
To generate read-to-contig mappings without performing scaffolding:
```bash
ntLink pair target=my_assembly.fa reads=long_reads.fq.gz paf=True
```

## Parameter Tuning and Best Practices

### Core Parameters
- **k (K-mer size)**: Default is 32. Smaller k-mers can increase sensitivity but may increase noise.
- **w (Window size)**: Default is 100. Controls the density of minimizers.
- **t (Threads)**: Default is 4. Increase this for faster processing on multi-core systems.
- **z (Minimum contig size)**: Default is 1000bp. Contigs smaller than this will not be scaffolded.

### Gap Management
- **g / G**: Set the minimum (`g`) and maximum (`G`) gap sizes. Use `G=-1` for no maximum.
- **soft_mask**: Set `soft_mask=True` to fill gaps with lowercase bases, making them easily identifiable for downstream tools.

### Expert Tips
- **File Handling**: ntLink requires all assembly and read files to be in the current working directory. Use soft links (`ln -s`) to bring external files into the workspace.
- **Overlap Detection**: The `overlap=True` parameter (default) attempts to identify and trim overlapping joined sequences. This is mandatory when using the `gap_fill` feature.
- **Sensitive Mode**: Use `sensitive=True` for mapping in sensitive mode if the default parameters are not yielding enough joins.
- **Output Files**: The final scaffolded assembly is always saved with the suffix `*ntLink.scaffolds.fa`.

## Reference documentation
- [ntLink Main Repository](./references/github_com_bcgsc_ntLink.md)
- [ntLink Wiki Overview](./references/github_com_bcgsc_ntLink_wiki.md)