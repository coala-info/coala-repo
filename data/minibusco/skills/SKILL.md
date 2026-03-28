---
name: minibusco
description: minibusco assesses the completeness of genome assemblies and protein sets by identifying orthologs using rapid protein-to-genome alignment. Use when user asks to evaluate assembly quality, check proteome completeness, download BUSCO lineages, or run automated lineage detection.
homepage: https://github.com/huangnengCSU/minibusco
---

# minibusco

## Overview
The `minibusco` skill (interfaced via the `compleasm` command) provides a high-performance alternative to the standard BUSCO pipeline for assessing the completeness of genome assemblies and protein sets. By leveraging `miniprot` for rapid protein-to-genome alignment and `hmmsearch` for ortholog identification, it significantly reduces the computational time required for quality control in genomics. It supports OrthoDB v12 lineages and features an automated lineage detection mode.

## Common CLI Patterns

### Lineage Management
Before running an analysis, you must have the appropriate BUSCO lineage data.
* **List available lineages**: `compleasm list` (shows both local and remote lineages).
* **Download a specific lineage**: `compleasm download <lineage_name>` (e.g., `primates`, `eukaryota`).
* **Specify download path**: Use `-L /path/to/library` to store or reference lineages in a specific directory.

### Genome Completeness Evaluation
The `run` module is the primary entry point for assembly assessment.
* **Standard run**: `compleasm run -a <assembly.fa> -o <output_dir> -l <lineage> -t <threads>`
* **Automatic lineage detection**: `compleasm run --autolineage -a <assembly.fa> -o <output_dir>` (requires `sepp` to be installed).
* **Identify retrocopies**: Add `--retrocopy` to separate retrotransposed genes from standard duplications in the final report.
* **Targeted evaluation**: Use `--specified_contigs chr1 chr2` to limit the analysis to specific sequences.

### Protein Set Evaluation
To assess the completeness of a predicted proteome rather than a genome assembly:
* **Protein mode**: `compleasm protein -p <proteins.faa> -l <lineage> -o <output_dir> -t <threads>`

### Advanced Analysis
* **Analyze existing alignments**: If you have already run `miniprot`, you can evaluate completeness from the GFF/PAF output:
  `compleasm analyze -g <miniprot.gff> -l <lineage> -o <output_dir>`
* **Custom alignment parameters**: Adjust sensitivity using `--min_identity` (default 0.35) or `--min_length_percent` (default 0.35).

## Expert Tips and Best Practices
* **Resource Allocation**: `minibusco` is highly parallelizable. Always specify `-t` to match your available CPU cores for maximum speed.
* **Library Path**: Set the `LIBRARY_PATH` using `-L` if you are working in a multi-user environment or HPC to share downloaded lineages across different projects.
* **Version Compatibility**: Note that version 0.2.7+ is optimized for OrthoDB v12. If you require odb10 compatibility, you must use version 0.2.6.
* **Dependency Check**: Ensure `miniprot` and `hmmsearch` are in your system PATH. If they are in non-standard locations, use `--miniprot_execute_path` and `--hmmsearch_execute_path`.



## Subcommands

| Command | Description |
|---------|-------------|
| minibusco list | List BUSCO lineages |
| minibusco miniprot | Miniprot alignment |
| minibusco run | Run BUSCO analysis with Minibosco |
| minibusco_analyze | Miniprot output gff file |
| minibusco_download | Download BUSCO lineage datasets. |

## Reference documentation
- [Main README](./references/github_com_huangnengCSU_compleasm_blob_0.2.7_README.md)
- [CLI Implementation Details](./references/github_com_huangnengCSU_compleasm_blob_0.2.7_compleasm.py.md)