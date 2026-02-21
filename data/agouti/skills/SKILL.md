---
name: agouti
description: The provided text does not contain help information or usage instructions for the tool 'agouti'. It contains error logs from a container runtime (Apptainer/Singularity) indicating a failure to extract the tool's image due to insufficient disk space.
homepage: https://github.com/zywicki-lab/agouti
---

# agouti

## Overview
AGouTI (Annotation of Genomic and Transcriptomic Intervals) is a flexible tool designed to assign biological context to specific coordinates. It transforms raw positional data into functional information by overlapping intervals with known genomic features. You should use this skill when you need to determine which genes or sub-genic regions (e.g., 5' part, middle, or 3' part of a transcript) correspond to your experimental data, such as RBP binding sites, variants, or structural motifs.

## Installation and Setup
AGouTI is available via Bioconda or pip. It requires Python >= 3.7.

```bash
# Installation via Conda
conda install bioconda::agouti

# Installation via pip
pip install AGouTI
```

## Core Workflow
Running AGouTI is a mandatory two-step process: first building a searchable database, then performing the actual annotation.

### 1. Database Creation (`create_db`)
This step converts GTF/GFF3 files into an SQLite database. All attributes are converted to lowercase for consistency.

**Basic Command:**
```bash
agouti create_db -f GTF -a annotation.gtf -d output_db
```

**Expert Tips for Database Creation:**
*   **Memory Management:** By default, the database is built in RAM. For large genomes (e.g., Human/Mouse) on machines with < 8GB RAM, use the `-l` or `--low-ram` flag to build directly on disk.
*   **Sparse GTF Files:** If your GTF file lacks explicit "gene" or "transcript" lines, use `-i` (`--infer_genes`) and `-j` (`--infer_transcripts`). Note that this significantly increases processing time.
*   **Required Files:** Ensure the generated `.relations` and `.pickle` files remain in the same directory as the `.db` file; the annotation step requires all three.

### 2. Interval Annotation (`annotate`)
Once the database is ready, use it to annotate your coordinate files.

**Basic Command:**
```bash
agouti annotate -d output_db -i input.bed -o annotated_results.txt
```

**Common CLI Patterns:**
*   **Transcriptomic Mode:** Use this when your input coordinates are relative to the start of a transcript rather than a chromosome.
    *   *Warning:* Ensure the transcript IDs in your input exactly match the version used to build the database (e.g., ENST00000613119.1 vs .2).
*   **Custom Formats:** If your input is not a standard BED file, use the `--custom` flag to define which columns contain the ID, Chromosome/Transcript, Start, End, and Strand.
*   **Feature Selection:** You can limit annotations to specific features (e.g., only `exon` or `CDS`) or specific attributes (e.g., `gene_name`, `biotype`) to keep the output concise.

## Best Practices
*   **Uniformity:** Always check the `database_name.database.structure.txt` file after creation. It provides a tree-like visualization of the feature hierarchy, which is essential for choosing the right filters during the annotation step.
*   **De Novo Regions:** AGouTI can define regions like "5' part" or "3' part" even if they aren't explicitly in the GTF. This is highly useful for analyzing distribution patterns across mRNA.
*   **Handling Overlaps:** AGouTI is flexible with multiple annotations. If a region overlaps multiple features, use the attribute selection flags to prioritize the most relevant metadata for your analysis.

## Reference documentation
- [AGouTI GitHub README](./references/github_com_zywicki-lab_agouti.md)
- [Bioconda AGouTI Overview](./references/anaconda_org_channels_bioconda_packages_agouti_overview.md)