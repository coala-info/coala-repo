---
name: quast
description: QUAST is a comprehensive suite for assessing the quality of genomic contigs.
homepage: http://quast.sourceforge.net/
---

# quast

## Overview
QUAST is a comprehensive suite for assessing the quality of genomic contigs. It simplifies the evaluation process by generating both statistical reports and visual representations (via Icarus) of assembly completeness and accuracy. Whether you are working with small bacterial genomes, complex metagenomes, or large mammalian datasets, this tool helps identify structural errors and assembly gaps.

## Usage Patterns

### Basic Assembly Evaluation
To evaluate a single assembly against a reference genome:
```bash
quast.py assembly.fasta -r reference.fasta -g annotations.gff
```

### Comparing Multiple Assemblies
To compare several assembly files (e.g., from different assemblers) against a reference:
```bash
quast.py contigs_1.fasta contigs_2.fasta -r reference.fasta -o output_dir
```

### Metagenome Assessment (MetaQUAST)
Use `metaquast.py` when dealing with multiple species or unknown community compositions. It can automatically fetch references from NCBI:
```bash
metaquast.py metagenome_contigs.fasta --references-list refs.txt
```

### Large Genome Assessment (QUAST-LG)
For mammalian-sized genomes, use the `--large` flag to optimize resource usage and alignment parameters:
```bash
quast.py large_assembly.fasta -r human_ref.fasta --large
```

## Expert Tips
- **Icarus Visualization**: QUAST automatically generates an HTML report. Open `icarus.html` in the output directory to interactively browse contig alignments and misassembly locations.
- **Misassemblies**: Pay close attention to "Relocation", "Translocation", and "Inversion" metrics. These indicate structural discrepancies between your contigs and the reference.
- **De Novo Mode**: If no reference is available, run QUAST without the `-r` flag. It will still provide basic assembly statistics like N50, L50, and GC content.
- **Resource Management**: For large datasets, use the `-t` or `--threads` flag to speed up the alignment process (e.g., `-t 8`).

## Reference documentation
- [QUAST Project Homepage](./references/quast_sourceforge_net_index.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_quast_overview.md)