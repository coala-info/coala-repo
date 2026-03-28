---
name: dsh-bio
description: dsh-bio is a suite of command-line utilities for high-performance bioinformatics data processing, format conversion, and genomic file manipulation. Use when user asks to convert files to splittable compression formats, transform genomic data into Apache Parquet, filter sequences by length, or manipulate GFA pangenome graphs.
homepage: https://github.com/heuermh/dishevelled-bio
---

# dsh-bio

## Overview

`dsh-bio` is a comprehensive suite of command-line utilities designed for high-performance bioinformatics data processing. It acts as a "Swiss Army knife" for genomic file formats, providing tools for filtering, counting, and transforming data. A standout feature is its support for modern data engineering workflows, such as converting biological sequences and variants into Apache Parquet format for use in large-scale analytics, and providing splittable compression codecs (BGZF/Bzip2) to facilitate parallel processing.

## Usage Patterns

The tool follows a standard command-subcommand structure:
`dsh-bio [command] [args]`

### Common File Operations

#### 1. Splittable Compression
Standard gzip files are not splittable, which hinders parallel processing. Use `dsh-bio` to convert files into splittable BGZF or Bzip2 formats:
- **VCF**: `dsh-bio compress-vcf input.vcf > output.vcf.bgz`
- **FASTQ**: `dsh-bio compress-fastq input.fastq > output.fastq.bgz`
- **GFA**: `dsh-bio compress-gfa1 input.gfa > output.gfa.bgz`

#### 2. Format Conversion
- **GFF3 to BED**: `dsh-bio gff3-to-bed input.gff3 > output.bed`
- **FASTA to FASTQ**: `dsh-bio fasta-to-fastq input.fasta > output.fastq`
- **Interleaving FASTQ**: `dsh-bio interleave-fastq forward.fq reverse.fq > interleaved.fq`

#### 3. Big Data Integration (Parquet)
`dsh-bio` provides several "beta" tools to move genomic data into the Hadoop/Spark ecosystem:
- **Sequences**: `dsh-bio fasta-to-parquet input.fasta output.parquet`
- **Variants**: `dsh-bio vcf-to-partitioned-parquet input.vcf output_dir/`
- **Proteins**: `dsh-bio extract-uniprot-features-to-parquet input.xml output.parquet`

### Filtering and Extraction

- **By Length**: Extract FASTQ reads within a specific size range:
  `dsh-bio extract-fastq-by-length --min 50 --max 150 input.fastq`
- **By Attribute**: Filter VCF or GFF3 files based on specific criteria:
  `dsh-bio filter-vcf --regex "PASS" input.vcf`
- **K-mer Extraction**: Generate k-mers from FASTA sequences:
  `dsh-bio extract-fasta-kmers --k 31 input.fasta > kmers.txt`

### Pangenomics and Graphs

`dsh-bio` has extensive support for Graphical Fragment Assembly (GFA) formats:
- **GFA Versioning**: Convert GFA 1.0 to 2.0: `dsh-bio gfa1-to-gfa2 input.gfa1`
- **Visualization Prep**: Convert GFA links to Cytoscape-compatible edge lists:
  `dsh-bio links-to-cytoscape-edges input.gfa > edges.txt`
- **Pangenome Trees**: Convert FASTA indices to pangenome tree formats:
  `dsh-bio fasta-index-to-pangenome-tree input.fai > pangenome.tree`

## Expert Tips

- **Memory Management**: Since `dsh-bio` is Java-based, for very large files, ensure the JVM has enough heap space by setting `JAVA_OPTS` if the wrapper script supports it.
- **Piping**: Most commands support standard streams. Use pipes to chain operations (e.g., filter then compress) to avoid writing large intermediate files to disk.
- **Validation**: Use `dsh-bio count-fastq` as a quick sanity check to verify file integrity and record counts after a transfer or conversion.
- **Parquet Partitioning**: When using `vcf-to-partitioned-parquet`, the tool helps optimize downstream SQL queries (via DuckDB or Spark) by organizing data into a directory structure based on genomic coordinates.



## Subcommands

| Command | Description |
|---------|-------------|
| dsh-bin-fastq-quality-scores | Calculate quality scores for FASTQ files. |
| dsh-bio_compress-fasta | Compresses a FASTA file. |
| dsh-bio_extract-fasta | Extracts sequences from a FASTA file. |
| dsh-bio_extract-uniprot-features | Extracts features from UniProt XML entries. |
| dsh-bio_fasta-to-fastq | Converts FASTA sequences to FASTQ format. |
| dsh-bio_fasta-to-text | Converts FASTA sequences to plain text. |
| dsh-bio_filter-fasta | Filters FASTA files based on various criteria. |
| dsh-bio_reassemble-paths | Reassemble paths from a GFA file. |
| dsh-bio_summarize-uniprot-entries | Summarizes UniProt entries from XML files. |
| dsh-bio_truncate-fasta | Truncates FASTA sequences to a specified length. |
| dsh-compress-bed | Compresses a BED file. |
| dsh-compress-fastq | Compresses FASTQ files. |
| dsh-compress-gaf | Compresses a GAF file. |
| dsh-compress-gfa1 | Compresses a GFA 1.0 file. |
| dsh-compress-gfa2 | Compresses a GFA 2.0 file. |
| dsh-compress-gff3 | Compresses GFF3 files. |
| dsh-compress-paf | Compresses a PAF file. |
| dsh-compress-rgfa | Compresses an rGFA file. |
| dsh-compress-sam | Compresses a SAM file. |
| dsh-compress-vcf | Compresses a VCF file. |
| dsh-count-fastq | Count FASTQ reads |
| dsh-create-sequence-dictionary | Creates a sequence dictionary from a FASTA file. |
| dsh-disinterleave-fastq | Disinterleaves a FASTQ file into paired and unpaired files. |
| dsh-downsample-fastq | Downsample FASTQ files |
| dsh-downsample-interleaved-fastq | Downsample interleaved FASTQ files |
| dsh-export-segments | Export segments from a GFA file to FASTA format. |
| dsh-extract-fasta-kmers | Extract kmers from a FASTA file. |
| dsh-extract-fasta-kmers-to-parquet | Extracts kmers from FASTA files and outputs them to a Parquet file. |
| dsh-extract-fasta-kmers-to-parquet3 | Extracts kmers from FASTA files and outputs them to a Parquet file. |
| dsh-extract-fastq | Extracts sequences from a FASTQ file based on name or description. |
| dsh-extract-fastq-by-length | Extract FASTQ reads by sequence length. |
| dsh-extract-uniprot-features-to-parquet | Extracts features from UniProt XML files and saves them to a Parquet file. |
| dsh-extract-uniprot-features-to-partitioned-parquet | Extracts UniProt features to a partitioned Parquet file. |
| dsh-fasta-index-to-pangenome | Converts a FASTA index to a pangenome file. |
| dsh-fasta-index-to-pangenome-tree | Converts a FASTA index to a pangenome tree. |
| dsh-fasta-to-pangenome | Converts FASTA files to a pangenome representation. |
| dsh-fasta-to-pangenome-tree | Converts FASTA files to a pangenome tree. |
| dsh-fasta-to-parquet | Converts FASTA files to Parquet format. |
| dsh-fasta-to-parquet2 | Converts FASTA files to Parquet format. |
| dsh-fasta-to-parquet3 | Converts FASTA files to Parquet format. |
| dsh-fasta-to-parquet4 | Converts FASTA files to Parquet format. |
| dsh-fasta-to-parquet5 | Converts FASTA files to Parquet format. |
| dsh-fasta-to-parquet6 | Converts FASTA files to Parquet format. |
| dsh-fastq-description | Display description lines from a FASTQ file. |
| dsh-fastq-sequence-length | Calculates the sequence length for each read in a FASTQ file. |
| dsh-fastq-to-fasta | Converts FASTQ format to FASTA format. |
| dsh-fastq-to-text | Converts FASTQ files to a text format. |
| dsh-filter-bed | Filter BED files based on various criteria. |
| dsh-filter-fastq | Filter FASTQ files based on various criteria. |
| dsh-filter-gaf | Filter GAF files based on various criteria. |
| dsh-filter-gfa1 | Filter GFA1 files based on various criteria. |
| dsh-filter-gfa2 | Filter GFA2 files |
| dsh-filter-gff3 | Filter GFF3 files based on various criteria. |
| dsh-filter-paf | Filters a PAF file based on various criteria. |
| dsh-filter-rgfa | Filter rGFA graphs. |
| dsh-filter-sam | Filter SAM/BAM files based on various criteria. |
| dsh-filter-vcf | Filter VCF file based on various criteria. |
| dsh-gfa1-to-gfa2 | Converts GFA 1.0 format to GFA 2.0 format. |
| dsh-gff3-to-bed | Converts GFF3 format to BED format. |
| dsh-identify-gfa1 | Identify GFA 1.0 files |
| dsh-interleave-fastq | Interleaves two FASTQ files into a single paired FASTQ file, with unpaired reads written to a separate file. |
| dsh-links-to-cytoscape-edges | Converts GFA graph to Cytoscape edge list format. |
| dsh-links-to-property-graph | Converts GFA graph data to a property graph format. |
| dsh-remap-dbsnp | Remaps dbSNP IDs in a VCF file. |
| dsh-remap-phase-set | Remaps phase sets in a VCF file. |
| dsh-rename-bed-references | Rename chromosome references in a BED file. |
| dsh-rename-references | Rename chromosome references in a GFF3 file. |
| dsh-rename-vcf-references | Rename chromosome reference names in a VCF file. |
| dsh-segments-to-cytoscape-nodes | Converts GFA graph segments to Cytoscape nodes.txt format. |
| dsh-segments-to-property-graph | Converts GFA files to a property graph format. |
| dsh-split-bed | Splits a BED file into smaller files based on byte count or record count. |
| dsh-split-fasta | Splits a FASTA file into multiple smaller files based on specified criteria. |
| dsh-split-fastq | Splits a FASTQ file into multiple smaller files. |
| dsh-split-gaf | Split a GAF file into smaller files based on records or bytes. |
| dsh-split-gff3 | Splits a GFF3 file into smaller files based on byte count or record count. |
| dsh-split-interleaved-fastq | Splits an interleaved FASTQ file into multiple files. |
| dsh-split-paf | Split a PAF file into smaller files based on byte count or record count. |
| dsh-split-sam | Splits a SAM/BAM/CRAM file into smaller files based on record count or byte size. |
| dsh-split-vcf | Splits a VCF file into smaller files based on records or bytes. |
| dsh-summarize-uniprot-entries-to-parquet | Summarize UniProt entries to Parquet |
| dsh-text-to-fasta | Converts text input to FASTA format. |
| dsh-text-to-fastq | Converts a text file to a FASTQ file. |
| dsh-traversals-to-cytoscape-edges | Converts traversals from a GFA file to Cytoscape edge list format. |
| dsh-traversals-to-property-graph | Converts GFA traversals to a property graph format. |
| dsh-traverse-paths | Traverse paths in a GFA file. |
| dsh-truncate-paths | Truncates paths in a GFA file. |
| dsh-variant-table-to-vcf | Converts an Ensembl variant table to VCF format. |
| dsh-vcf-pedigree | Generates a pedigree file from a VCF file. |
| dsh-vcf-samples | Extracts sample names from a VCF file. |

## Reference documentation
- [dishevelled-bio README](./references/github_com_heuermh_dishevelled-bio.md)