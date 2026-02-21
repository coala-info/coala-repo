---
name: gfftk
description: gfftk is a specialized toolkit designed for the management and transformation of genomic annotation data.
homepage: https://github.com/nextgenusfs/gfftk
---

# gfftk

## Overview

gfftk is a specialized toolkit designed for the management and transformation of genomic annotation data. It provides a robust command-line interface to bridge the gap between different annotation formats and offers a powerful filtering engine to isolate specific biological features based on their attributes. Use this skill to automate the cleaning of GFF3 files, extract sequences for downstream analysis, or generate consensus gene models from multiple sources.

## Core CLI Usage

The primary command for most operations is `gfftk convert`.

### Format Conversion
Convert between common genomic formats by specifying the input, reference genome, and desired output format.

*   **GFF3 to GTF**: `gfftk convert -i input.gff3 -f genome.fasta -o output.gtf`
*   **GFF3 to Protein Sequences**: `gfftk convert -i input.gff3 -f genome.fasta -o proteins.faa --output-format proteins`
*   **GFF3 to Transcript Sequences**: `gfftk convert -i input.gff3 -f genome.fasta -o transcripts.fna --output-format transcripts`

### Handling Combined Files
gfftk supports a combined GFF3+FASTA format where the sequence data is appended to the annotation file.

*   **Create Combined File**: `gfftk convert -i input.gff3 -f genome.fasta -o combined.gff --output-format combined`
*   **Read Combined File**: When using a combined file as input, the `-f` flag is not required: `gfftk convert -i combined.gff -o output.gff3 --output-format gff3`

## Advanced Filtering

Use the `--grep` (include) and `--grepv` (exclude) flags to filter annotations based on attribute keys.

### Filter Syntax
The syntax follows the pattern `key:pattern`. Supported keys include `product`, `source`, `name`, `note`, `contig`, `strand`, `type`, `db_xref`, and `go_terms`.

*   **Basic String Match**: `gfftk convert -i in.gff3 -f ref.fa -o out.gff3 --grep product:kinase`
*   **Case-Insensitive Match**: Append `:i` to the pattern: `gfftk convert -i in.gff3 -f ref.fa -o out.gff3 --grep product:KINASE:i`
*   **Regular Expressions**: Use standard regex patterns: `gfftk convert -i in.gff3 -f ref.fa -o out.gff3 --grep "product:.*transporter.*"`
*   **Exclude Features**: `gfftk convert -i in.gff3 -f ref.fa -o out.gff3 --grepv source:augustus`

## Expert Tips and Best Practices

*   **Default Output**: If `--output-format` is not specified, gfftk defaults to GFF3.
*   **Sanitization**: Use gfftk to automatically sort and sanitize features, which is often required before submitting to NCBI or using in strict pipelines.
*   **Non-Standard Features**: gfftk natively supports features like `intron`, `noncoding_exon`, and `pseudogenic_exon`, making it useful for complex eukaryotic annotations.
*   **Piping and Chaining**: While gfftk writes to files via `-o`, you can chain multiple filtering steps by using the output of one command as the input for the next to build complex selection logic.

## Reference documentation

- [GFF toolkit Main Repository](./references/github_com_nextgenusfs_gfftk.md)
- [Bioconda gfftk Package Overview](./references/anaconda_org_channels_bioconda_packages_gfftk_overview.md)