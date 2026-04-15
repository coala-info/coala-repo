---
name: genometools
description: GenomeTools is a comprehensive suite of bioinformatics utilities designed for high-performance processing, validation, and visualization of genomic data with a focus on the GFF3 standard. Use when user asks to validate or standardize GFF3 files, identify LTR retrotransposons, create sequence indices, or generate images of genomic annotations.
homepage: https://github.com/genometools/genometools
metadata:
  docker_image: "biocontainers/genometools:v1.5.9ds-4-deb-py2_cv1"
---

# genometools

## Overview
GenomeTools is a comprehensive suite of bioinformatics utilities unified under a single executable named `gt`. It is designed for high-performance processing of large-scale genomic data, with a particular emphasis on the GFF3 (Generic Feature Format version 3) standard. The toolset is essential for workflows involving genome annotation, repeat element discovery (specifically LTR retrotransposons), and the visualization of genomic features through its AnnotationSketch component.

## Common CLI Patterns and Tool Usage

The primary interface for all GenomeTools utilities is the `gt` binary, followed by a specific tool name and its associated flags.

### GFF3 Manipulation and Validation
One of the most frequent uses of GenomeTools is the standardization and validation of GFF3 files.

*   **Standardizing GFF3 files**: Use the `gff3` tool to sort, tidy, and validate annotations.
    ```bash
    gt gff3 -sort -tidy -check -retainids input.gff3 > output.gff3
    ```
    *   `-sort`: Sorts the GFF3 features by sequence ID and start position.
    *   `-tidy`: Fixes common formatting issues and ensures parent-child relationships are logically consistent.
    *   `-retainids`: Preserves the original `ID` attributes from the input file.

*   **Validation**: To strictly check if a file adheres to the GFF3 specification:
    ```bash
    gt gff3validator file.gff3
    ```

### LTR Retrotransposon Discovery
GenomeTools is a standard for identifying Long Terminal Repeat (LTR) retrotransposons.

*   **LTRharvest**: Used for the initial de novo identification of LTR retrotransposon candidates.
    ```bash
    gt ltrharvest -index my_genome_index -out ltr_candidates.gff3
    ```
*   **LTRdigest**: Used to further annotate candidates found by LTRharvest with protein domains (requires HMM profiles).
    ```bash
    gt ltrdigest -hmms hmms/ -outfileout results.gff3 ltr_candidates.gff3 my_genome_index
    ```

### Sequence Analysis and Indexing
Many `gt` tools require an enhanced suffix array (index) of the genome sequence.

*   **Creating an index**:
    ```bash
    gt suffixerator -db genome.fasta -indexname my_genome_index -tis -suf -lcp -des -ssp -dna
    ```

### Visualization
*   **AnnotationSketch**: Generate high-quality images (PNG/PDF) of genomic annotations.
    ```bash
    gt sketch output_image.png input.gff3
    ```

## Expert Tips and Best Practices

*   **Memory Efficiency**: GenomeTools is written in C and is highly memory-efficient. When working with massive datasets, ensure you use the 64-bit version of the binary to handle large indices.
*   **GFF3 Sorting**: Many downstream bioinformatics tools require GFF3 files to be sorted. Always run `gt gff3 -sort -tidy` before using GFF3 files in other pipelines to prevent "out of order" errors.
*   **Feature Relationships**: When creating new GFF3 files via scripts (Python/Ruby/Lua bindings), ensure that `Parent` attributes correctly reference the `ID` of a container feature (e.g., an `exon` must point to a `mRNA`).
*   **HMMs for LTRdigest**: For effective LTR annotation, use a comprehensive library of HMM profiles (like Pfam) to identify Gag, Pol, and Env domains.

## Reference documentation
- [GenomeTools README](./references/github_com_genometools_genometools.md)
- [GenomeTools Issues (Usage Examples)](./references/github_com_genometools_genometools_issues.md)
- [GenomeTools Wiki](./references/github_com_genometools_genometools_wiki.md)