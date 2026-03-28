---
name: yasma
description: YASMA is a bioinformatics suite designed for the comprehensive annotation and analysis of small RNA populations. Use when user asks to initialize sRNA projects, pre-process sequencing data, align reads, annotate sRNA loci, or quantify and visualize small RNA populations.
homepage: https://github.com/NateyJay/YASMA
---

# yasma

## Overview

YASMA (Yet Another Small RNA Annotator) is a specialized bioinformatics suite designed for the comprehensive annotation of the total small RNA population. Unlike tools focused solely on miRNAs, YASMA uses a "tradeoff" algorithm to balance sensitivity and specificity, capturing the most reads in the smallest genomic space. It is particularly effective for organisms with non-canonical sRNA pathways where traditional tools often under-merge or over-annotate background noise.

## Core Workflow

YASMA is directory-oriented. It uses an `inputs.json` file to track project state and relative paths, allowing you to run modules sequentially without re-specifying input files.

### 1. Project Initialization
Start by defining your output directory, genome, and data sources.
```bash
yasma inputs -o my_project -g /path/to/genome.fa -s SRR1111111 SRR2222222
cd my_project
```

### 2. Pre-processing
Automate the retrieval and cleaning of sequencing data.
- **Download**: `yasma download` (fetches SRR codes defined in initialization).
- **Identify Adapters**: `yasma adapter` (scans for 3' adapter sequences).
- **Trim**: `yasma trim` (wraps cutadapt to clean libraries).

### 3. Alignment
Align reads using a ShortStack-style weighting approach to handle multi-mapping reads.
```bash
yasma align
```

### 4. Annotation (The Tradeoff Module)
The core engine that identifies sRNA loci.
- **Basic run**: `yasma tradeoff`
- **Targeted annotation**: Use `-r` or `--annotation_readgroups` to build annotations based on specific replicates (e.g., only Wild Type) while ignoring others in the alignment.

### 5. Post-Annotation Analysis
- **Quantification**: `yasma count` (generates counts for loci, strands, and sizes).
- **Structural Analysis**: `yasma hairpin` (evaluates loci for miRNA-like structures).
- **Visualization**: `yasma jbrowse -j /path/to/jbrowse2/` (prepares tracks for JBrowse2).
- **Coverage**: `yasma coverage` (creates combined BigWig files).

## Expert Tips

- **Directory Context**: Always run yasma commands from within the project directory initialized by the `inputs` module. The tool automatically reads `inputs.json` to find the genome and BAM files.
- **Validation**: The `inputs` module performs a critical check comparing chromosome names in the genome FASTA against gene annotations (GFF). Always review this output to catch naming mismatches early.
- **Locus Filtering**: If you find too many background loci, check `removed_loci.gff3` to understand why certain regions were filtered out during the tradeoff step (depth, density, or complexity).
- **Custom Alignments**: While `yasma align` is recommended, you can use external BAM files if they contain the `@RG` (Read Group) field.



## Subcommands

| Command | Description |
|---------|-------------|
| yasma adapter | Tool to check untrimmed-libraries for 3' adapter content. |
| yasma align | Aligner based on shortstack3-style weighting |
| yasma count | Gets counts for all readgroups, loci, strand, and sizes. |
| yasma coverage | Produces bigwig coverage files |
| yasma hairpin | Evaluates annotated loci for hairpin or miRNA structures. |
| yasma size-profile | Convenience function for calculating aligned size profile. |
| yasma tradeoff | Annotator using focused capturing the most reads in the least genomic space |
| yasma trim | Wrapper for trimming using cutadapt. |
| yasma_download | Download libraries from the NCBI SRA using their SRR code |
| yasma_inputs | Initialize a project and log inputs for later analyses |
| yasma_jbrowse | Build coverage and config files for jbrowse2 |

## Reference documentation

- [YASMA README](./references/github_com_NateyJay_YASMA_blob_library-scaling_README.md)
- [Installation and Dependencies](./references/github_com_NateyJay_YASMA_blob_library-scaling_doc_installation.md)