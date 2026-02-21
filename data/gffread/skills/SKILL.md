---
name: gffread
description: The `gffread` utility is a versatile tool for handling GFF and GTF files.
homepage: http://ccb.jhu.edu/software/stringtie/gff.shtml
---

# gffread

## Overview

The `gffread` utility is a versatile tool for handling GFF and GTF files. It serves as a bridge between different annotation formats and provides essential preprocessing capabilities for transcriptomics workflows. Use this skill to perform format conversions, verify the structural integrity of gene models, and generate transcript-level FASTA sequences. It is the standard tool for ensuring that annotation files are compatible with the "Cufflinks" suite of tools.

## Common CLI Patterns

### Format Conversion
Convert between GFF3 and GTF2 formats. By default, `gffread` outputs GFF3.
- **GFF/GTF to GFF3**: `gffread input.gtf -o output.gff3`
- **GFF/GTF to GTF2**: `gffread input.gff3 -T -o output.gtf`

### Validation and Cleanup
Use the `-E` flag to expose warnings about potential issues in the input file, such as overlapping features or structural inconsistencies.
- **Quick inspection**: `gffread -E annotation.gtf -o- | less`
- **Discard non-essential attributes**: This process strips redundant information while preserving the core transcript structure (exons and CDS).

### Sequence Extraction
Generate a FASTA file containing the DNA sequences for all transcripts defined in the GFF/GTF file.
- **Basic extraction**: `gffread -w transcripts.fa -g /path/to/genome.fa annotation.gtf`
- **Optimization**: Always ensure a FASTA index (`.fai`) exists for the genome file. If missing, create it first using `samtools faidx genome.fa`. `gffread` will automatically detect the index to speed up random access.

## Expert Tips and Constraints

- **Feature Limits**: Be aware that the internal parser has hardcoded limits:
  - Genes/transcripts should not span more than 7 Megabases.
  - Exons should not exceed 30 Kilobases.
  - Introns should not exceed 6 Megabases.
- **ID Uniqueness**: Transcript IDs must be unique within the scope of a single chromosome/contig.
- **Structural Reassembly**: If an input file provides only CDS and UTR features, `gffread` will automatically reassemble the exonic structure.
- **Redundancy Handling**: The tool ignores redundant features like `start_codon` or `stop_codon` if full CDS features are provided, and ignores `UTR` features if `exon` features are present.
- **Attribute Mapping**: When converting to GFF3, `gffread` maps the `transcript_id` attribute to the `ID` field and uses `gene_name` or `gene_id` for grouping.

## Reference documentation
- [GFF/GTF utility providing format conversions, region filtering, FASTA sequence extraction and more](./references/anaconda_org_channels_bioconda_packages_gffread_overview.md)
- [Programs for processing GTF/GFF files](./references/ccb_jhu_edu_software_stringtie_gff.shtml.md)