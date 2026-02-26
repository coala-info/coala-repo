---
name: scallop
description: Scallop is a reference-based transcriptome assembler that reconstructs transcripts from RNA-seq alignments. Use when user asks to assemble transcripts from BAM files, reconstruct a transcriptome, or detect rare multi-exon transcripts.
homepage: https://github.com/Kingsford-Group/scallop
---


# scallop

## Overview
Scallop is a reference-based transcriptome assembler that processes RNA-seq alignments to reconstruct a complete set of transcripts. Unlike some assemblers that focus solely on parsimony, Scallop utilizes a novel algorithm designed to preserve phasing paths from both single and paired-end reads. This approach significantly improves the accuracy of multi-exon transcript assembly and the detection of rare transcripts. It takes coordinate-sorted BAM files as input and produces transcript annotations in GTF format.

## Installation and Setup
The most reliable way to install Scallop is via Bioconda:
```bash
conda install bioconda::scallop
```

## Common CLI Patterns

### Basic Assembly
To run a standard assembly with default parameters:
```bash
scallop -i input.sort.bam -o output.gtf
```

### Handling Stranded Data
Specifying the library type is critical for accurate assembly of stranded RNA-seq data. If you are unsure of the library type, use the preview flag first:
```bash
# Preview the inferred library type
scallop -i input.sort.bam --preview

# Apply the library type (unstranded, first, or second)
scallop -i input.sort.bam -o output.gtf --library_type first
```

### Filtering and Sensitivity Tuning
You can adjust the stringency of the assembly based on your experimental needs:
```bash
# Increase sensitivity for lowly expressed transcripts
scallop -i input.sort.bam -o output.gtf --min_transcript_coverage 0.5

# Increase stringency for single-exon transcripts to reduce noise
scallop -i input.sort.bam -o output.gtf --min_single_exon_coverage 50
```

## Expert Tips and Best Practices

### Input Requirements
*   **Coordinate Sorting**: Scallop requires the input BAM file to be sorted by coordinate. If your aligner (STAR, HISAT2, etc.) did not sort the output, use samtools:
    `samtools sort input.bam > input.sort.bam`
*   **Mapping Quality**: By default, Scallop ignores reads with a mapping quality less than 1. For high-precision assemblies, consider increasing `--min_mapping_quality` to 10 or 20 to exclude multi-mapping reads or poorly aligned data.

### Transcript Length Constraints
Scallop uses a formula to determine the minimum length of a transcript: `min_transcript_length_base + (num_exons - 1) * min_transcript_length_increase`.
*   Default base: 150bp.
*   Default increase: 50bp.
If you are looking for very short functional RNAs, you may need to decrease `--min_transcript_length_base`.

### CIGAR String Limits
Scallop ignores reads with a CIGAR size larger than 7 by default (controlled by `--max_num_cigar`). If you are working with long-read data or highly fragmented alignments, you may need to increase this value, though Scallop is primarily optimized for short-read Illumina data.

## Reference documentation
- [Scallop GitHub Repository](./references/github_com_Kingsford-Group_scallop.md)
- [Bioconda Scallop Package](./references/anaconda_org_channels_bioconda_packages_scallop_overview.md)