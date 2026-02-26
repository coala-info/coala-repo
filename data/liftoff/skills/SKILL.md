---
name: liftoff
description: Liftoff maps gene annotations between genome assemblies by aligning gene sequences from a reference to a target genome. Use when user asks to map annotations between assemblies, re-annotate a new genome version, or identify additional gene copies in a target genome.
homepage: https://github.com/agshumate/Liftoff
---


# liftoff

## Overview
Liftoff is a specialized tool for mapping gene annotations between genome assemblies. Unlike coordinate-based liftover tools that rely on pre-generated alignment chains, Liftoff aligns individual gene sequences from a reference genome to a target genome. This approach allows it to accurately map features even when there are significant structural differences between assemblies. It is highly effective for re-annotating new assembly versions or identifying additional gene copies in a target genome.

## Installation
The recommended way to install Liftoff is via Bioconda:
```bash
conda install -c bioconda liftoff
```

## Basic Usage
To perform a standard liftover, provide the target genome, the reference genome, and the reference annotation:
```bash
liftoff -g reference_annotation.gff3 -o target_output.gff3 target_genome.fasta reference_genome.fasta
```

## Common CLI Patterns

### Parallel Processing
Liftoff can be computationally intensive due to the alignment step. Use the `-p` flag to specify the number of parallel processes:
```bash
liftoff -p 8 -g ref.gff3 -o target.gff3 target.fasta ref.fasta
```

### Finding Extra Gene Copies
To identify gene copies in the target genome that are not present in the reference annotation, use the `-copies` flag. You can set a minimum identity threshold for these copies using `-sc`:
```bash
liftoff -copies -sc 0.95 -g ref.gff3 -o target.gff3 target.fasta ref.fasta
```

### Adjusting Mapping Strictness
By default, Liftoff considers a feature mapped if coverage (`-a`) and sequence identity (`-s`) are ≥ 0.5. For higher confidence, increase these thresholds:
```bash
liftoff -a 0.8 -s 0.8 -g ref.gff3 -o target.gff3 target.fasta ref.fasta
```

### Handling Incomplete Annotations
If your input file lacks explicit gene or transcript records (e.g., only contains exons/CDS), use the inference flags:
- `-infer_genes`: Use if the file only includes transcripts and exons.
- `-infer_transcripts`: Use if the file only includes exons/CDS.

## Expert Tips

### Database Reuse
On the first run with a GFF/GTF file, Liftoff builds a feature database. For subsequent runs using the same annotation, use the `-db` argument instead of `-g` to skip the database creation step:
```bash
liftoff -db reference_annotation.db -o target.gff3 target.fasta ref.fasta
```

### Improving Divergent Alignments
If the target and reference genomes are more divergent, use the `-flank` parameter to include flanking sequences (as a fraction of gene length). This helps Minimap2 find better anchors for the alignment:
```bash
liftoff -flank 0.1 -g ref.gff3 -o target.gff3 target.fasta ref.fasta
```

### Custom Feature Types
By default, Liftoff maps 'gene' features and their children. To include additional parent features (like `miRNA` or `repeat_element`), create a text file listing these types and pass it with `-f`:
```bash
liftoff -f extra_features.txt -g ref.gff3 -o target.gff3 target.fasta ref.fasta
```

### Managing Unmapped Features
Always check the `unmapped_features.txt` file (or the file specified by `-u`) to understand why certain features failed to map. If many features are missing, consider lowering the `-a` and `-s` thresholds or checking for chromosome name mismatches.

## Reference documentation
- [Liftoff GitHub Repository](./references/github_com_agshumate_Liftoff.md)
- [Bioconda Liftoff Package](./references/anaconda_org_channels_bioconda_packages_liftoff_overview.md)