---
name: cats-rb
description: CATS-rb is a benchmarking framework that evaluates transcriptome assembly quality by mapping transcripts to a reference genome and calculating biological completeness scores. Use when user asks to index a reference genome, map assembled transcripts, or perform relative and annotation-based completeness comparisons between assemblies.
homepage: https://github.com/bodulic/CATS-rb
---

# cats-rb

## Overview

CATS-rb (Comprehensive Assessment of Transcript Sequences - reference-based) is a benchmarking framework designed to quantify transcriptome assembly quality. Unlike traditional metrics like N50 that focus on continuity, CATS-rb evaluates biological completeness by mapping transcripts to a reference genome and analyzing "element sets"—non-redundant representations of exons and transcripts. It provides normalized scores (0 to 1) for both relative completeness (comparing two or more assemblies) and annotation-based completeness (comparing assemblies against a known gene set).

## Core Workflow

The CATS-rb pipeline consists of three sequential stages.

### 1. Genome Indexing
Before mapping, the reference genome must be indexed using `spaln`.

```bash
# Native execution
CATS_rb_index -g reference_genome.fasta -o index_directory

# Docker execution
docker run --rm -v "$PWD":/data -w /data bodulic/cats-rb CATS_rb_index -g reference_genome.fasta -o index_directory
```

### 2. Transcript Mapping
Map the assembled transcripts to the indexed reference genome. This step generates the necessary GTF and BED files for comparison.

```bash
CATS_rb_map -i assembly.fasta -d index_directory -o mapping_output_dir -t 8
```
*   `-i`: Input transcriptome assembly (FASTA).
*   `-d`: Directory containing the index created in step 1.
*   `-t`: Number of threads (default is 1).

### 3. Completeness Comparison
Compare one or more assemblies. This stage produces the final completeness scores and visualizations.

**Relative Completeness (No annotation required):**
Use this to compare multiple assemblies against each other to find the most complete one.
```bash
CATS_rb_compare -i "assembly1_map_dir,assembly2_map_dir" -n "AssemblerA,AssemblerB" -o compare_output
```

**Annotation-Based Completeness:**
Use this when a high-quality reference annotation (GTF/GFF3) is available to get an absolute measure of completeness.
```bash
CATS_rb_compare -i "assembly1_map_dir" -n "AssemblerA" -r reference_annotation.gtf -o compare_output
```

## Expert Tips and Best Practices

*   **Element Set Logic**: CATS-rb collapses overlapping coordinates into non-redundant sets. If you have very fragmented assemblies, the "Exon Score" is often a more stable indicator of content recovery than the "Transcript Score."
*   **Memory Management**: Mapping is the most resource-intensive step. Ensure `spaln` has access to sufficient RAM for large genomes (e.g., human or complex plant genomes).
*   **Input Formatting**: Ensure transcript headers in your FASTA files do not contain complex characters or spaces that might break GTF field parsing during the mapping stage.
*   **Interpreting Scores**: A score of 1.0 represents perfect parity with the representative set (in relative mode) or the reference annotation (in annotation mode).
*   **Visual Output**: The tool generates an `index.html` report. Always check the "Missing Element Sets" visualization to identify if specific genomic regions or high-expression genes are consistently failing to assemble.



## Subcommands

| Command | Description |
|---------|-------------|
| cats-rb_compare | transcriptome assembly comparison script |
| cats_rb_index | genome index generation script |
| cats_rb_map | transcriptome assembly mapping script |

## Reference documentation
- [CATS-rb GitHub Repository](./references/github_com_bodulic_CATS-rb_blob_main_README.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_cats-rb_overview.md)