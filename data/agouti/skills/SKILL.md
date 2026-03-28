---
name: agouti
description: AGouTI processes genomic and transcriptomic intervals to label them with functional features using a high-performance SQLite database built from GTF or GFF3 files. Use when user asks to create an annotation database, annotate BED or custom interval files, or perform transcriptomic-mode analysis relative to transcript starts.
homepage: https://github.com/zywicki-lab/agouti
---

# agouti

## Overview

AGouTI (Annotation of Genomic and Transcriptomic Intervals) is a bioinformatics tool designed to bridge the gap between raw sequence intervals and functional genomic features. It processes standard annotation formats (GTF/GFF3) into a high-performance SQLite database, which is then used to query and label user-provided intervals. Unlike many general-purpose tools, AGouTI excels at transcriptomic-mode annotation, allowing researchers to work with coordinates relative to transcript starts rather than just genomic positions. This makes it an essential tool for analyzing RNA-binding protein (RBP) sites, structural motifs, and post-transcriptional modifications.

## Database Creation (Step 1)

Before annotating, you must build a local database from your reference annotation.

### Basic Command
```bash
agouti create_db -f GTF -a reference.gtf -d output_db
```

### Expert Tips for Database Building
- **Memory Management**: For large genomes (e.g., Human Gencode), AGouTI may require up to 5GB of RAM. If working on a low-memory machine, use the `-l` or `--low-ram` flag to build the database directly on the disk (SSD recommended).
- **Handling Incomplete GTFs**: If your GTF file lacks explicit "gene" or "transcript" feature lines, use `-i` (infer genes) and `-j` (infer transcripts). Note that these operations are computationally expensive and increase processing time.
- **File Persistence**: Ensure you keep the generated `.relations` and `.pickle` files in the same directory as the SQLite database file; the `annotate` module requires all three to function.

## Interval Annotation (Step 2)

Once the database is ready, you can annotate BED files or custom text-based interval files.

### Basic Command
```bash
agouti annotate -i input.bed -d output_db
```

### Working with Custom Formats
If your data is not in standard BED format, use the `-m` or `--custom` flag to define your columns:
- Specify columns for: `id`, `chr` (chromosome), `s` (start), `e` (end), and optionally `strand`.
- This is ideal for TSV or CSV outputs from other bioinformatics pipelines.

### Transcriptomic Mode
When your coordinates are relative to a transcript (e.g., "Position 50 of ENST00000123456") rather than a chromosome:
- Ensure the transcript IDs in your input file match the version used in the database (e.g., ENST00000613119.1 vs .2).
- This mode is critical for RBP binding site analysis where the biological context is the processed mRNA.

## Best Practices
- **Uniformity**: AGouTI converts all feature names and attributes to lowercase during database creation to ensure case-insensitive matching during annotation.
- **Feature Selection**: After running `create_db`, check the `database_name.database.structure.txt` file. It provides a tree-like visualization of available features and attributes, helping you decide which specific tags to include in your final annotation output.
- **Version Control**: Always use the exact same GTF/GFF3 version for creating the database that was used to generate the input intervals to avoid coordinate shifts or ID mismatches.



## Subcommands

| Command | Description |
|---------|-------------|
| agouti annotate | Annotate BED or custom column-based files using a database created with agouti create_db. |
| agouti create_db | Create a genomic annotation database from GTF or GFF3 files |

## Reference documentation
- [AGouTI README](./references/github_com_zywicki-lab_agouti_blob_main_README.md)
- [AGouTI Setup and Metadata](./references/github_com_zywicki-lab_agouti_blob_main_setup.py.md)