---
name: segul
description: segul is a high-performance tool designed for the efficient manipulation, filtering, and summary of genomic and phylogenomic datasets. Use when user asks to convert alignment formats, filter loci by quality metrics, generate sequence summary statistics, or manage sequence identifiers.
homepage: https://github.com/hhandika/segul
metadata:
  docker_image: "quay.io/biocontainers/segul:0.23.2--hc1c3326_0"
---

# segul

## Overview

segul is a specialized, high-performance tool designed for efficient manipulation of genomic and phylogenomic datasets. Written in Rust, it provides an ultrafast and memory-efficient alternative to traditional scripts for large-scale data cleaning and preparation. It excels at tasks such as converting between alignment formats, filtering loci based on specific criteria (like parsimony informative sites), trimming alignments, and generating comprehensive summary statistics for raw reads, contigs, or alignments.

## Common CLI Patterns

### Alignment Filtering
Filter a collection of alignments based on specific quality or data density metrics:
- **By length**: `segul align filter --input [DIR] --len [MIN_LEN]`
- **By parsimony informative sites**: `segul align filter --p-sites [MIN_SITES]`
- **By taxon count**: `segul align filter --ntax [MIN_TAXA]`
- **By missing data**: `segul align filter --percent [MAX_MISSING]`

### Format Conversion
Batch convert sequence files between common formats (FASTA, NEXUS, PHYLIP):
- `segul align convert --input [DIR] --input-format [FORMAT] --output-format [FORMAT]`
- **Auto-detection**: segul can often detect the input format based on file extensions when processing directories.

### Summary Statistics
Generate detailed reports on your data:
- **Alignment summary**: `segul summary alignment --input [DIR]` (provides GC content, AT content, and missing data proportions).
- **Read/Contig summary**: `segul summary read --input [FILES]` or `segul summary contig --input [FILES]`.
- **Locus-specific stats**: Use the `--locus` flag to generate statistics for every individual locus in a dataset.

### Sequence ID Management
- **Extraction**: `segul id extract --input [DIR] --id "ID1;ID2;ID3"`
- **Removal**: `segul id remove --input [DIR] --id "ID1;ID2;ID3"`
- **Renaming**: `segul id rename --input [DIR] --replace "old_string=new_string"` or use regex with `--re="regex=replacement"`.

### Advanced Manipulations
- **Trimming**: `segul align trim --input [DIR] --output [DIR]` to remove sites.
- **Unaligning**: `segul align unalign --input [DIR]` to convert alignments back to unaligned sequences.
- **Translation**: `segul sequence translate --input [DIR] --table [TABLE_ID]` to translate DNA to Amino Acids.
- **Splitting**: `segul partition split --input [ALIGNMENT] --partition [PARTITION_FILE]` to split a concatenated alignment into individual loci.

## Expert Tips

- **Overwrite Protection**: By default, segul protects existing files. Use the `--overwrite` flag to bypass prompts when running automated pipelines.
- **Output Organization**: Use the `--prefix` flag to add a custom string to the beginning of all output filenames, which is useful for versioning or labeling different filtering runs.
- **Memory Efficiency**: segul is designed to handle thousands of files with a low memory footprint. It is often significantly faster than Python or Perl-based alternatives for large phylogenomic datasets.
- **Input Flexibility**: You can provide a directory as input, and segul will process all compatible files within it. Use wildcards if you need to target specific file patterns.



## Subcommands

| Command | Description |
|---------|-------------|
| segul align | Alignment analyses |
| segul contig | Contiguous sequence analyses |
| segul maf | Multi alignment format (MAF) analyses and conversion of genomic files to other formats |
| segul partition | Alignment partition conversion |
| segul read | Sequence read analyses |
| segul sequence | Sequence analyses |

## Reference documentation
- [SEGUL README](./references/github_com_hhandika_segul_blob_main_README.md)
- [SEGUL Changelog](./references/github_com_hhandika_segul_blob_main_CHANGELOG.md)
- [Alignment Filtering Docs](./references/www_segul_app_docs_cli-usage_align-filter.md)
- [Alignment Trimming Docs](./references/www_segul_app_docs_cli-usage_align-trim.md)