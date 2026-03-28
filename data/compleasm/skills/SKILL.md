---
name: compleasm
description: compleasm evaluates the completeness of genome assemblies or proteomes by identifying universal single-copy orthologs. Use when user asks to assess assembly quality, calculate BUSCO scores, or detect lineage-specific gene content.
homepage: https://github.com/huangnengCSU/compleasm
---

# compleasm

## Overview

compleasm is a high-performance tool designed to evaluate the completeness of genome assemblies. It serves as a faster alternative to BUSCO by utilizing `miniprot` for protein-to-genome alignment. It identifies Universal Single-Copy Orthologs (BUSCOs) within an assembly to provide a quantitative measure of how much of the expected gene content is present, duplicated, fragmented, or missing.

## Installation and Setup

compleasm requires Python 3, `miniprot`, and `hmmer`. For automatic lineage detection, `sepp` is also required.

```bash
# Recommended installation via Conda
conda create -n compleasm -c conda-forge -c bioconda compleasm
conda activate compleasm

# Manual check of dependencies
compleasm --help
```

## Common CLI Patterns

### 1. Basic Completeness Evaluation
If the taxonomic lineage is already known, use the `run` module.

```bash
# Evaluate a human genome assembly using the primates lineage
compleasm run -a assembly.fasta -o output_dir -l primates -t 16
```

### 2. Automatic Lineage Detection
When the specific lineage is unknown, compleasm can predict the best-fitting BUSCO library.

```bash
# Automatically detect lineage and evaluate
compleasm run -a assembly.fasta -o output_dir --autolineage -t 16
```

### 3. Managing Lineage Libraries
Lineages are downloaded to `mb_downloads` by default. You can list available lineages or specify a custom library path.

```bash
# List available remote lineages
compleasm list remote

# Download a specific lineage for offline use
compleasm download saccharomycetes -L /path/to/library/
```

### 4. Advanced Analysis Options
- **Retrocopy Detection**: Use `--retrocopy` to distinguish between true gene duplications and retrocopies.
- **Protein Assessment**: Use the `protein` module to assess the completeness of a proteome (input protein FASTA) rather than a genome.
- **Specific Contigs**: Limit analysis to specific chromosomes or scaffolds using `--specified_contigs chr1 chr2`.

## Expert Tips

- **Performance**: compleasm is significantly faster than BUSCO because it uses `miniprot` instead of Augustus or MetaEuk for gene prediction. Always leverage the `-t` (threads) parameter to maximize speed on multi-core systems.
- **Library Versions**: As of v0.2.7, compleasm supports BUSCO odb12. Ensure your local library path (`-L`) contains the correct version if you are not letting the tool download them automatically.
- **Output Interpretation**: The primary output is a `summary.txt` file in the output directory. It follows the standard BUSCO notation:
    - **S**: Complete and single-copy
    - **D**: Complete and duplicated
    - **F**: Fragmented
    - **M**: Missing
- **Memory Management**: For very large assemblies or complex lineages (like eudicots_odb10), ensure the system has sufficient RAM for the `miniprot` indexing phase.



## Subcommands

| Command | Description |
|---------|-------------|
| compleasm analyze | Analyze Miniprot output with BUSCO lineages. |
| compleasm download | Download BUSCO lineages. |
| compleasm miniprot | Miniprot alignment |
| compleasm run | Run the compleasm analysis. |
| compleasm_list | List BUSCO lineages |
| compleasm_protein | Compleasm protein analysis |

## Reference documentation

- [compleasm README](./references/github_com_huangnengCSU_compleasm_blob_0.2.7_README.md)
- [compleasm Main Script](./references/github_com_huangnengCSU_compleasm_blob_0.2.7_compleasm.py.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_compleasm_overview.md)