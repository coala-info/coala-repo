---
name: fastx-toolkit
description: The FASTX-Toolkit is a collection of command-line utilities used for the preprocessing, filtering, and manipulation of short-read sequencing data. Use when user asks to trim adapters, filter reads by quality, collapse identical sequences, split barcodes, or convert FASTQ files to FASTA format.
homepage: https://github.com/agordon/fastx_toolkit
metadata:
  docker_image: "biocontainers/fastx-toolkit:v0.0.14-6-deb_cv1"
---

# fastx-toolkit

## Overview

The FASTX-Toolkit is a collection of specialized command-line utilities designed for the manipulation and "cleaning" of short-read sequencing data. While the software is legacy (unmaintained since 2010), it remains a standard for basic bioinformatic workflows where reads must be prepared before alignment to a reference genome. It allows for the removal of low-quality reads, the stripping of sequencing adapters, and the reorganization of multiplexed libraries based on barcodes.

## Command Line Usage and Patterns

### Quality Control and Statistics
Before processing, always generate statistics to understand the library quality.
- **Generate Stats**: `fastx_quality_stats -i input.fastq -o output_stats.txt`
- **Visualize Quality**: Use `fastq_quality_boxplot_graph.sh` and `fastx_nucleotide_distribution_graph.sh` on the resulting stats file to create visual charts (requires gnuplot).

### Trimming and Clipping
- **Fixed Trimming**: Use `fastx_trimmer` to remove a specific number of bases from the start or end of reads.
  - Example (keep bases 1 to 50): `fastx_trimmer -f 1 -l 50 -i in.fq -o out.fq`
- **Adapter Removal**: Use `fastx_clipper` to remove known adapter sequences.
  - Example: `fastx_clipper -a ATCGTA -i in.fq -o out.fq`
  - Use `-M` to specify a minimum alignment length for the adapter.

### Filtering
- **Quality Filtering**: Remove reads that do not meet a quality threshold.
  - Example (keep reads where 80% of bases have a Phred score of 20+): `fastq_quality_filter -q 20 -p 80 -i in.fq -o out.fq`
- **Artifact Filtering**: Use `fastx_artifacts_filter` to remove reads that are likely sequencing artifacts (e.g., reads with extremely high proportions of a single nucleotide).

### Format Conversion and Manipulation
- **FASTQ to FASTA**: `fastq_to_fasta -i in.fq -o out.fa`
- **Reverse Complement**: `fastx_reverse_complement -i in.fq -o out.fq` (automatically reverses quality scores for FASTQ).
- **Collapsing**: Use `fastx_collapser` to merge identical sequences into a single entry with a count (useful for small RNA-seq).

### Barcode Splitting
For multiplexed runs, use `fastx_barcode_splitter.pl`.
- Provide a barcode file with two columns: `[barcode_id] [sequence]`.
- Example: `cat in.fq | fastx_barcode_splitter.pl --bcfile barcodes.txt --prefix /path/to/output/ --suffix .fq`

## Expert Tips and Best Practices

- **Piping**: Most tools in the toolkit support standard input and output. Chain commands to avoid creating massive intermediate files.
  - Example: `fastx_trimmer -f 5 -i in.fq | fastq_quality_filter -q 20 -p 80 > filtered.fq`
- **Quality Offsets**: Be cautious with quality score encoding. Older versions of the toolkit may assume Phred+64 (Illumina 1.3-1.7). Use `fastq_quality_converter` if you need to switch between ASCII and numeric scores or adjust offsets.
- **Gzip Support**: The native tools often do not support compressed `.gz` files directly. Use `zcat` to pipe data in: `zcat input.fq.gz | fastx_trimmer -f 1 -l 50 > output.fq`.
- **Paired-End Data**: The toolkit was primarily designed for single-end reads. When using tools like `fastq_quality_filter` on paired-end data, be aware that it processes reads independently, which can "de-sync" your R1 and R2 files. You may need a post-processing script to re-pair the reads.



## Subcommands

| Command | Description |
|---------|-------------|
| fastq_to_fasta | Convert FASTQ files to FASTA files. |
| fastx_collapser | Collapses identical sequences in a FASTA/Q file into a single sequence. |

## Reference documentation
- [FASTX-Toolkit GitHub README](./references/github_com_agordon_fastx_toolkit.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_fastx-toolkit_overview.md)