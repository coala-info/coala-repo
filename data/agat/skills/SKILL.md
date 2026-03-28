---
name: agat
description: AGAT is a comprehensive suite of tools designed to sanitize, convert, and manipulate genomic annotation files in GTF and GFF formats. Use when user asks to fix or standardize GFF3 files, convert between annotation formats, extract sequences from genomic features, or filter gene models by specific criteria like isoform length.
homepage: https://github.com/NBISweden/AGAT
---


# agat

## Overview

AGAT (Another Gtf/Gff Analysis Toolkit) is a robust suite of tools designed to address the inherent flexibility and frequent inconsistencies of genomic annotation formats. It is particularly useful for "sanitizing" files—automatically adding missing parent features (like genes or mRNAs), fixing ID uniqueness, and ensuring strict compliance with GFF3 standards. Use this skill to navigate the extensive library of AGAT scripts to perform tasks ranging from simple format conversion to complex gene model filtering and sequence extraction.

## Core CLI Patterns

Most AGAT tools follow a consistent naming convention and command-line structure. Tools prefixed with `agat_sp_` utilize the "AGAT parser," which is designed to be robust against non-standard or "despicable" GTF/GFF flavors.

### Standardization and Sanitization
If you have a GFF or GTF file that is causing errors in downstream tools, use the primary sanitization script first.
- **Sanitize/Fix/Sort:** `agat_convert_sp_gxf2gxf.pl -g input.gff -o output.gff3`
  - *Note:* This adds missing features (exons, UTRs), fixes IDs, and groups related features.

### Format Conversion
AGAT provides specialized scripts for converting to and from various bioinformatics formats.
- **GFF/GTF to BED:** `agat_convert_sp_gff2bed.pl --gff input.gff -o output.bed`
- **GFF to GTF:** `agat_convert_sp_gff2gtf.pl --gff input.gff -o output.gtf`
- **GFF to TSV:** `agat_sp_gff2tsv.pl --gff input.gff -o output.tsv`
- **BED to GFF3:** `agat_convert_bed2gff.pl --bed input.bed -o output.gff3`

### Annotation Statistics and QC
- **General Statistics:** `agat_sp_statistics.pl --gff input.gff -o stats_output.txt`
- **Functional Statistics:** `agat_sp_functional_statistics.pl --gff input.gff -o functional_stats.txt`

### Feature Modification and Filtering
- **Keep Longest Isoform:** `agat_sp_keep_longest_isoform.pl -gff input.gff -o output_longest.gff`
- **Filter by ORF Size:** `agat_sp_filter_by_ORF_size.pl -gff input.gff --size 300 -o filtered.gff`
- **Add Introns:** `agat_sp_add_introns.pl --gff input.gff -o output_with_introns.gff`
- **Fix CDS Phases:** `agat_sp_fix_cds_phases.pl -gff input.gff -f fasta_file.fa -o fixed_phases.gff`

### Sequence Extraction
- **Extract Sequences:** `agat_sp_extract_sequences.pl -g input.gff -f genome.fa -t cds -o output_cds.fa`
  - *Common types (-t):* `cds`, `exon`, `protein`, `upstream`, `downstream`.

## Expert Tips

1.  **The `_sp_` Advantage:** Always prefer scripts with the `_sp_` (Standardized Parser) prefix. These are more modern and handle edge cases in GFF/GTF formatting much better than older versions.
2.  **Standardize First:** When working with annotations from NCBI or Ensembl, run `agat_convert_sp_gxf2gxf.pl` as your first step. This ensures the internal hierarchy (Gene -> mRNA -> Exon/CDS) is perfectly formed before you attempt filtering or sequence extraction.
3.  **Attribute Extraction:** Use `agat_sp_extract_attributes.pl` to quickly pull specific information (like `product` or `gene_id`) from the 9th column of a GFF file into a clean list.
4.  **ID Management:** If your file has non-unique IDs or you need to rename features systematically, use `agat_sp_manage_IDs.pl`.



## Subcommands

| Command | Description |
|---------|-------------|
| agat_agat_sp_manage_utrs.pl | This script allows to extend UTRs, or to add UTRs when they are missing. It uses the protein_coding information to define the UTRs. |
| agat_convert_sp_gff2bed.pl | The script takes a GFF file as input and converts it to BED format. |
| agat_sp_keep_longest_isoform.pl | This script filters a GFF file to keep only the longest isoform (based on CDS or exon length) for each gene. |
| agat_sp_manage_functional_annotation.pl | This tool allows managing functional annotations within a GFF file, such as adding information from BLAST or InterProScan results or cleaning existing annotations. |
| agat_sp_manage_ids.pl | This script allows to manage IDs in a GFF file. It can be used to add, remove, or change IDs. |

## Reference documentation
- [AGAT GitHub Repository](./references/github_com_NBISweden_AGAT.md)
- [AGAT Wiki Home](./references/github_com_NBISweden_AGAT_wiki.md)