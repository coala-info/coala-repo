---
name: mudskipper
description: "Mudskipper projects genomic alignments onto transcriptomic coordinates using a GTF annotation. Use when user asks to convert genomic BAM or SAM files to transcriptomic alignments, project bulk or single-cell RNA-seq reads to transcripts, or index a GTF for efficient alignment conversion."
homepage: https://github.com/OceanGenomics/mudskipper
---

# mudskipper

## Overview

`mudskipper` is a specialized tool designed to project genomic alignments onto transcriptomic coordinates. It functions by parsing a GTF annotation to build an interval tree of exons, then mapping each genomic alignment entry to all transcripts it overlaps. This is particularly useful for researchers who have performed genome-wide alignments but want to use transcript-specific quantification tools like `salmon` (bulk) or `alevin-fry` (single-cell) without the computational overhead of re-mapping reads to a transcriptome index.

## CLI Usage Patterns

### Bulk RNA-Seq Conversion
To convert a genomic BAM to a transcriptomic BAM for use with Salmon:
```bash
mudskipper bulk --gtf annotation.gtf --alignment genomic.bam --out transcriptomic.bam
```

### Single-Cell RNA-Seq Conversion
To convert genomic alignments to a RAD file for alevin-fry:
```bash
mudskipper sc --gtf annotation.gtf --alignment genomic.sam --out transcriptomic_dir
```

### Efficient Multi-Sample Processing
If processing multiple files against the same annotation, build an index first to save time:
```bash
# 1. Create the index
mudskipper index --gtf annotation.gtf --dir-index gtf_index

# 2. Use the index for bulk or sc tasks
mudskipper bulk --index gtf_index --alignment sample1.bam --out sample1_trans.bam
mudskipper bulk --index gtf_index --alignment sample2.bam --out sample2_trans.bam
```

## Best Practices and Expert Tips

- **GTF Consistency**: Ensure the GTF file matches the exact version of the reference genome used for the initial alignment. If target sequences (chromosomes/contigs) are missing from the GTF, those alignments will be dropped.
- **Soft-clip Filtering**: By default, `mudskipper` drops alignments with more than 50 soft-clipped bases. Adjust this using `-s` or `--max-softclip <INT>` if your library prep or alignment strategy expects higher soft-clipping.
- **Performance**: Use the `-t` or `--threads` flag to speed up BAM/SAM processing, especially for deep-sequenced bulk samples.
- **Output Formats**: 
    - Use the `--rad` flag in `bulk` mode if you prefer RAD format over BAM.
    - In `sc` mode, the output is typically a directory containing the projected alignments.
- **Alignment Constraints**: Note that `mudskipper` currently only projects alignments that are fully contained within transcript boundaries and match the splicing pattern of the exons. Intergenic, intronic, or overhanging alignments are generally excluded from the output.



## Subcommands

| Command | Description |
|---------|-------------|
| mudskipper bulk | Convert alignment of bulk RNA-Seq reads against genome to alignment against transcriptome. |
| mudskipper index | Parse the GTF and build an index to make later runs faster. |
| mudskipper sc | Convert alignment of single-cell RNA-Seq reads against genome to alignment against transcriptome. |

## Reference documentation
- [mudskipper README](./references/github_com_OceanGenomics_mudskipper_blob_main_README.md)
- [mudskipper Repository Overview](./references/github_com_OceanGenomics_mudskipper.md)