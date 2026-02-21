---
name: fastx-toolkit
description: The FASTX-Toolkit is a collection of command-line utilities designed for the initial processing of Next-Generation Sequencing (NGS) reads.
homepage: https://github.com/agordon/fastx_toolkit
---

# fastx-toolkit

## Overview

The FASTX-Toolkit is a collection of command-line utilities designed for the initial processing of Next-Generation Sequencing (NGS) reads. It allows for the manipulation of FASTA and FASTQ files to improve downstream mapping and assembly results. Use this skill to clean raw data by removing low-quality reads, stripping technical sequences like adapters or barcodes, and generating quality statistics. Note that this toolkit is legacy software (unmaintained since 2010) and is best suited for standard, low-level sequence manipulation.

## Common CLI Patterns

### Quality Control and Statistics
*   **Generate Quality Statistics**: Use `fastx_quality_stats` to produce a text file containing quality scores and nucleotide distributions per position.
    `fastx_quality_stats -i input.fastq -o output_stats.txt`
*   **Filter by Quality**: Use `fastq_quality_filter` to remove reads that do not meet a specific quality threshold.
    `fastq_quality_filter -q 20 -p 80 -i input.fastq -o filtered.fastq`
    *(Note: `-q 20` is the minimum quality score; `-p 80` is the minimum percentage of bases that must have that score.)*

### Sequence Modification
*   **Trimming**: Use `fastx_trimmer` to extract a specific range of nucleotides (e.g., removing barcodes from the 5' end or cutting low-quality 3' ends).
    `fastx_trimmer -f 1 -l 50 -i input.fastq -o trimmed.fastq`
    *(Note: `-f` is the first base to keep; `-l` is the last base to keep.)*
*   **Adapter Clipping**: Use `fastx_clipper` to remove known adapter or linker sequences.
    `fastx_clipper -a ATCGATCG -i input.fastq -o clipped.fastq`
*   **Reverse Complement**: Use `fastx_reverse_complement` to generate the reverse-complement of sequences.
    `fastx_reverse_complement -i input.fasta -o rc_output.fasta`

### Format Conversion and Organization
*   **FASTQ to FASTA**: Convert sequencing files while stripping quality scores.
    `fastq_to_fasta -i input.fastq -o output.fasta`
*   **Barcode Splitting**: Use `fastx_barcode_splitter.pl` to demultiplex reads based on a barcode file.
    `cat input.fastq | fastx_barcode_splitter.pl --bcfile barcodes.txt --prefix output_ --suffix .fastq`
*   **Collapsing Sequences**: Use `fastx_collapser` to merge identical sequences and report their counts.
    `fastx_collapser -i input.fasta -o collapsed.fasta`

## Expert Tips

*   **Piping**: Most tools in the toolkit support standard input and output. You can chain commands to avoid creating large intermediate files:
    `fastq_quality_filter -q 20 -p 80 -i in.fastq | fastx_trimmer -f 1 -l 50 > filtered_trimmed.fastq`
*   **Quality Score Encoding**: The toolkit was developed during the transition of Phred score encodings. If you encounter errors with quality scores, you may need to use `fastq_quality_converter` to ensure your ASCII scores are in the format expected by the specific tool.
*   **Gzip Support**: Native support for compressed files is limited in older versions. If a tool fails on a `.gz` file, use `zcat` to pipe the data:
    `zcat input.fastq.gz | fastq_quality_filter -q 20 -p 80 > filtered.fastq`
*   **Visualizations**: The toolkit includes wrapper scripts like `fastq_quality_boxplot_graph.sh` and `fastx_nucleotide_distribution_graph.sh`. These require `gnuplot` to be installed on the system to generate PNG charts from the output of `fastx_quality_stats`.

## Reference documentation
- [FASTX-Toolkit Summary and Tool List](./references/github_com_agordon_fastx_toolkit.md)