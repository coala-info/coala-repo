---
name: samclip
description: samclip filters sequence alignments by removing reads with excessive soft or hard clipping while preserving those at contig edges. Use when user asks to clean SAM files, filter clipped reads, or remove alignment noise before variant calling.
homepage: https://github.com/tseemann/samclip
metadata:
  docker_image: "quay.io/biocontainers/samclip:0.4.0--hdfd78af_1"
---

# samclip

## Overview
samclip is a specialized tool designed to clean up sequence alignments by filtering out reads with "clipped" ends. In SAM files, soft (S) and hard (H) clipping in the CIGAR string indicates portions of a read that did not align to the reference. While these can represent biological reality, they often introduce noise in variant calling pipelines. samclip removes these problematic alignments based on a user-defined threshold but intelligently preserves reads that are clipped because they overlap the start or end of a contig, ensuring that coverage is not unnecessarily lost in those regions.

## Usage Patterns

### Basic Filtering
The tool reads from STDIN and writes to STDOUT. You must provide a reference genome in FASTA format.

```bash
samclip --ref reference.fa < input.sam > filtered.sam
```

### Integration with Aligners
samclip is most efficient when used in a command pipeline immediately after alignment and before sorting/indexing.

**With BWA MEM:**
```bash
bwa mem ref.fa R1.fq R2.fq | samclip --ref ref.fa | samtools sort -o filtered_sorted.bam
```

**With Minimap2:**
```bash
minimap2 -ax sr ref.fa R1.fq R2.fq | samclip --ref ref.fa | samtools sort > filtered.bam
```

### Processing Existing BAM Files
To process an existing BAM file, you must include the header using `samtools view -h`.

```bash
samtools view -h input.bam | samclip --ref ref.fa | samtools view -b > filtered.bam
```

## Command Options and Best Practices

### Reference Indexing
The reference FASTA file must be indexed with `samtools faidx`. If `reference.fa.fai` is missing, samclip will fail.
```bash
samtools faidx reference.fa
```

### Adjusting Clipping Thresholds
The `--max` parameter defines the maximum allowed sum of soft and hard clipped bases (default is 5).
- **Strict filtering**: Use `--max 0` to reject any read with clipping that does not occur at a contig edge.
- **Permissive filtering**: Increase `--max` (e.g., `--max 20`) if you are working with longer reads or expect higher natural variation.

### Quality Control and Inversion
To inspect which reads are being removed by your current settings, use the `--invert` flag. This is useful for tuning the `--max` parameter.
```bash
samclip --ref ref.fa --max 10 --invert < input.sam > rejected_reads.sam
```

### Performance Monitoring
For large datasets, use `--progress` to monitor the processing rate.
```bash
samclip --ref ref.fa --progress 500000 < input.sam > filtered.sam
```

## Expert Tips
- **Contig Edges**: samclip's primary advantage over simple CIGAR string filters is its "edge-awareness." It checks the alignment position against the reference lengths (from the `.fai` file) to ensure reads falling off the ends of contigs are kept.
- **Memory Efficiency**: Since samclip processes SAM files line-by-line, it has a very low memory footprint regardless of the input file size.
- **Header Preservation**: Always ensure the SAM header is passed through the pipeline (using `-h` in samtools), as samclip requires the header to maintain a valid SAM structure for downstream tools.

## Reference documentation
- [samclip GitHub README](./references/github_com_tseemann_samclip.md)
- [samclip Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_samclip_overview.md)