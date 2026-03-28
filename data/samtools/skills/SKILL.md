---
name: samtools
description: Samtools is a suite of utilities for processing and manipulating high-throughput sequencing data in SAM, BAM, and CRAM formats. Use when user asks to convert between alignment formats, filter reads by flags or regions, sort and index BAM files, calculate coverage statistics, or extract sequences from alignment data.
homepage: https://github.com/samtools/samtools
---

# samtools

## Overview
Samtools is the industry-standard suite of utilities for handling Next-Generation Sequencing (NGS) data. It operates on the SAM (Sequence Alignment/Map) format and its binary equivalents, BAM and CRAM. This skill enables efficient data processing workflows, including filtering reads by bitwise flags, converting between compressed and uncompressed formats, and preparing data for downstream variant calling or visualization.

## Core CLI Patterns

### File Conversion and Viewing
The `view` command is the primary entry point for filtering and format conversion.
- **BAM to SAM**: `samtools view -h input.bam > output.sam` (use `-h` to include the header).
- **SAM to BAM**: `samtools view -bS input.sam > output.bam`.
- **Filter by Region**: `samtools view -b input.bam chr1:1000-2000 > region.bam` (requires index).
- **Filter by Flag**: `samtools view -b -f 2 -F 1024 input.bam > filtered.bam` (keeps proper pairs `-f 2`, removes PCR duplicates `-F 1024`).

### Sorting and Indexing
Most downstream tools require coordinate-sorted files and an index.
- **Sort**: `samtools sort -@ 4 -o sorted.bam input.bam` (uses 4 additional threads).
- **Index**: `samtools index sorted.bam` (creates `.bai` file).
- **Mark Duplicates**: Use `samtools markdup` on name-sorted or coordinate-sorted files (with `fixmate` run previously) to identify PCR duplicates.

### Statistics and Quality Control
- **Quick Stats**: `samtools flagstat input.bam` provides a summary of alignment flags.
- **Detailed Stats**: `samtools stats input.bam > stats.txt` (use `plot-bamstats` to visualize).
- **Coverage**: `samtools coverage input.bam` gives a per-chromosome summary of depth and breadth.
- **Depth**: `samtools depth input.bam > depth.txt` for per-base coverage.

### Data Extraction
- **Fastq/Fasta**: `samtools fastq -1 read1.fq -2 read2.fq input.bam` to revert alignments to raw reads.
- **Consensus**: `samtools consensus -f fasta -o consensus.fa input.bam` to generate a consensus sequence from alignments.

## Expert Tips and Best Practices

### Performance Optimization
- **Threading**: Always use the `-@` flag with `view`, `sort`, and `consensus` to utilize multiple CPU cores.
- **Piping**: Avoid writing intermediate BAM files by piping commands:
  `samtools view -u input.bam chr1 | samtools sort -@ 4 -o sorted.bam`
  (Note: `-u` outputs uncompressed BAM, which is faster for piping).

### CRAM Format
- CRAM is significantly smaller than BAM. As of version 1.22, CRAM 3.1 is the default.
- When using CRAM, always provide the reference fasta: `samtools view -C -T ref.fa -o output.cram input.bam`.

### Handling Indels with BAQ
- `samtools mpileup` calculates Base Alignment Quality (BAQ) by default. This reduces the quality score of bases near indels to prevent false-positive SNP calls. If you are seeing lower base qualities in pileup than in the BAM, this is likely the cause.

### Data Integrity
- Use `samtools checksum` to generate order-agnostic hashes of sequence and name data. This is useful for verifying that data has not been lost during conversion between FASTQ, BAM, and CRAM.



## Subcommands

| Command | Description |
|---------|-------------|
| samtools addreplacerg | Adds or replaces read group tags in a SAM, BAM, or CRAM file. |
| samtools ampliconclip | Soft clips read alignments where they match BED file defined regions. Default clipping is only on the 5' end. |
| samtools ampliconstats | Produce statistics from amplicon sequencing alignment files |
| samtools bedcov | Calculate read depth per BED region |
| samtools calmd | Generate the MD tag and optionally compute BAQ (Base Alignment Quality) |
| samtools cat | Concatenate BAM or CRAM files, first those in <bamlist.fofn>, then those on the command line. |
| samtools checksum | Generate checksums for SAM/BAM/CRAM files or merge existing checksum outputs. |
| samtools collate | Shuffles and groups reads together by name |
| samtools consensus | Generate consensus sequence from a BAM file |
| samtools coverage | Produces a histogram or tabular summary of coverage for input BAM files. |
| samtools cram-size | Calculate the size of CRAM files |
| samtools depad | Convert a padded BAM/SAM file to an unpadded BAM/SAM file |
| samtools depth | Compute the depth of coverage for one or more BAM/SAM/CRAM files. |
| samtools dict | Create a sequence dictionary file from a fasta file |
| samtools faidx | Index or extract regions from FASTA/FASTQ files |
| samtools fasta | Converts a SAM, BAM or CRAM to FASTA format. |
| samtools fastq | Converts a SAM, BAM or CRAM to FASTQ format. |
| samtools fixmate | Fill in mate coordinates, ISIZE and mate related flags from a name-sorted alignment file. |
| samtools flags | Convert between textual and numeric flag representation |
| samtools flagstat | Counts the number of alignments for each FLAG type |
| samtools fqidx | Index and retrieve sequences from FASTQ files |
| samtools head | Display header and/or alignment record lines from a SAM, BAM, or CRAM file. |
| samtools idxstats | Reports alignment statistics from a BAM index file, including sequence names, sequence lengths, number of mapped reads, and number of unmapped reads. |
| samtools import | Import FASTQ files into SAM/BAM/CRAM format |
| samtools index | Generate an index for BAM/CRAM files |
| samtools markdup | Mark duplicate alignments from a coordinate-sorted file that has gone through fixmates. The input file must be coordinate sorted and must have gone through fixmates with the mate scoring option on. |
| samtools merge | Merge multiple sorted alignment files into one. |
| samtools mpileup | Generate text pileup from BAM files |
| samtools phase | Call and phase heterozygous SNPs |
| samtools quickcheck | Quickly check if SAM/BAM/CRAM files are intact and have proper headers. |
| samtools reference | Extract the reference sequence from a CRAM file |
| samtools reheader | Replace the header in a SAM/BAM/CRAM file with a new header. |
| samtools reset | Reset a SAM/BAM/CRAM file, removing or retaining specific tags and metadata. |
| samtools samples | List samples from BAM/CRAM files, optionally checking for indices and associating with reference fasta files. |
| samtools sort | Sort alignment files by coordinates or name |
| samtools split | Splits a file by read group or tag value into multiple output files. |
| samtools stats | The program collects statistics from BAM files. The output can be visualized using plot-bamstats. |
| samtools targetcut | Targetcut identifies and cuts target regions from a BAM file, often used for processing Fosmid pool sequencing data. |
| samtools tview | Text alignment viewer |
| samtools view | View and convert SAM/BAM/CRAM files |

## Reference documentation
- [Samtools GitHub Repository](./references/github_com_samtools_samtools.md)
- [Samtools Wiki FAQ](./references/github_com_samtools_samtools_wiki_FAQ.md)
- [HTSlib Workflow Documentation](./references/www_htslib_org_workflow.md)
- [CRAM Benchmark and Usage](./references/www_htslib_org_benchmarks_CRAM.html.md)