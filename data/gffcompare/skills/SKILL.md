---
name: gffcompare
description: The `gffcompare` skill provides a framework for bioinformatic analysis of transcript structures.
homepage: https://ccb.jhu.edu/software/stringtie/gffcompare.shtml
---

# gffcompare

## Overview
The `gffcompare` skill provides a framework for bioinformatic analysis of transcript structures. It allows for the systematic comparison of "query" GTF files (typically from RNA-Seq assembly) against a "reference" GFF/GTF. Use this tool to generate accuracy statistics at the base, exon, intron, and transcript levels, or to merge multiple GTF files into a non-redundant set of loci.

## Core Workflows

### Accuracy Assessment
To evaluate how well an assembly matches a known reference:
`gffcompare -r reference.gtf -o output_prefix query.gtf`

*   **Key Output**: `output_prefix.stats` contains sensitivity and precision metrics.
*   **Refining Metrics**: 
    *   Use `-R` to ignore reference transcripts not overlapped by any query (adjusts sensitivity).
    *   Use `-Q` to ignore query transcripts not overlapped by the reference (adjusts precision).

### Merging and Redundancy Reduction
To combine multiple GTF files into a single set of non-redundant transcripts:
`gffcompare -i input_list.txt -o merged_output`

*   **Note**: `input_list.txt` should contain the paths to all GTF files, one per line.
*   **Filtering**: Use `-C` to discard "contained" transfrags (those fully covered by another transcript with a compatible intron structure).

### Transcript Classification
Gffcompare assigns class codes to query transcripts based on their overlap with the reference. These are found in the `.tmap` and `.refmap` files. Common codes include:
*   `=`: Complete match of intron chain.
*   `j`: Potentially novel isoform (at least one shared junction).
*   `u`: Unknown, intergenic transcript.
*   `x`: Exonic overlap on the opposite strand.

## Expert Tips and Best Practices
*   **Genome Context**: Provide a fasta file with `-s <genome.fa>` to enable the 'r' (repeat) class code assessment. Ensure the fasta is soft-masked (lower case) for repeat detection.
*   **Single-Exon Noise**: RNA-Seq often produces many single-exon "noise" fragments. Use `-M` to discard single-exon transcripts from both query and reference to focus on high-confidence multi-exon models.
*   **Fuzzy Ends**: By default, terminal exon boundaries can differ by 100bp. Adjust this with `-e` if your library prep or assembly method requires stricter or looser matching.
*   **Duplicate Removal**: Use `-D` to discard redundant transfrags within a single sample that share the same intron chain.
*   **Debugging**: If results are unexpected, use `--debug` to generate `.Q_discarded.lst` and `.missed_introns.gtf` to see exactly what the tool is filtering out.

## Reference documentation
- [GffCompare Program for processing GTF/GFF files](./references/ccb_jhu_edu_software_stringtie_gffcompare.shtml.md)