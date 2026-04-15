---
name: genometools-genometools
description: GenomeTools is a versatile bioinformatics suite for processing structured genome annotations and large-scale sequence data using the gt executable. Use when user asks to validate or sort GFF3 files, convert between genomic formats, extract sequences from specific features, visualize annotations with AnnotationSketch, or perform LTR retrotransposon analysis.
homepage: https://genometools.org
metadata:
  docker_image: "quay.io/biocontainers/genometools-genometools:1.6.6--py310he902909_1"
---

# genometools-genometools

## Overview
GenomeTools is a versatile suite of bioinformatics tools unified under the `gt` executable. It is designed for efficient processing of structured genome annotations and large-scale sequence data. Use this skill when you need to validate GFF3 files, convert between genomic formats, extract specific features based on coordinates, or generate publication-quality genomic diagrams. It is particularly powerful for LTR retrotransposon discovery and managing compressed sequence representations.

## Core CLI Patterns

### GFF3 Manipulation and Validation
The GFF3 format is central to GenomeTools. Always ensure files are valid before complex processing.

*   **Strict Validation**: Use `gt gff3validator` to check compliance with the GFF3 specification.
    `gt gff3validator -typecheck so file.gff3`
*   **Tidying and Sorting**: Fix common formatting issues and sort by coordinates (required for many downstream tools).
    `gt gff3 -sort -tidy -retainids -o sorted.gff3 input.gff3`
*   **Adding Introns**: Automatically infer and add intron features based on exon/gene structures.
    `gt gff3 -addintrons input.gff3 > output_with_introns.gff3`
*   **Format Conversion**:
    *   BED to GFF3: `gt bed_to_gff3 file.bed`
    *   GTF to GFF3: `gt gtf_to_gff3 file.gtf`
    *   GFF3 to GTF: `gt gff3_to_gtf file.gff3`

### Genomic Visualization (AnnotationSketch)
Create graphical representations of annotations in PNG, PDF, SVG, or PS formats.

*   **Basic Sketch**:
    `gt sketch output.png input.gff3`
*   **Specific Region**: Define the sequence ID and range to visualize.
    `gt sketch -seqid chr1 -start 1000 -end 5000 view.pdf input.gff3`
*   **Piped Input**: Combine sorting and sketching in one command.
    `gt gff3 -sort input.gff3 | gt sketch output.png -`

### Feature Extraction
Extract sequences corresponding to specific feature types (e.g., exons, CDS).

*   **Extracting Sequences**: Requires the original FASTA file.
    `gt extractfeat -type exon -seqfile genome.fasta input.gff3 > exons.fasta`
*   **Translating to Protein**:
    `gt extractfeat -type CDS -translate -seqfile genome.fasta input.gff3 > proteins.fasta`

### LTR Retrotransposon Analysis
A two-step workflow for de novo LTR detection.

1.  **Harvest**: Find candidates.
    `gt ltrharvest -index my_index -out candidates.gff3`
2.  **Digest**: Annotate internal features (requires HMM profiles).
    `gt ltrdigest -hmms hmms/*.hmm candidates.gff3 my_index > final_annotation.gff3`

## Expert Tips

*   **The `gt` Binary**: Almost all functionality is accessed via subcommands of the single `gt` executable. Use `gt -help` for a full list of tools.
*   **Encoded Sequences**: For large genomes, use `gt encseq encode` to create a compressed representation. Many `gt` tools (like `ltrharvest` or `tallymer`) operate directly on these `.esq` files for better performance.
*   **Memory Management**: If processing very large GFF3 files, ensure they are sorted (`gt gff3 -sort`) to allow tools to process them in a stream-like fashion rather than loading the entire file into memory.
*   **Sequence ID Mapping**: Use `gt id_to_md5` to standardize sequence IDs in GFF3 files to their MD5 fingerprints, ensuring consistency across different versions of a genome assembly.

## Reference documentation
- [AnnotationSketch Module](./references/genometools_org_annotationsketch.html.md)
- [GenomeTools Tools List](./references/genometools_org_tools.html.md)
- [GenomeTools Overview](./references/genometools_org_index.html.md)