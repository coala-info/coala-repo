---
name: variantbam
description: `variantbam` is a specialized tool for high-performance filtering of next-generation sequencing data.
homepage: https://github.com/jwalabroad/VariantBam
---

# variantbam

## Overview
`variantbam` is a specialized tool for high-performance filtering of next-generation sequencing data. Unlike standard tools that apply global filters, `variantbam` allows for complex, region-specific rules using JSON syntax or standard genomic interval files (VCF, BED, MAF). It is particularly effective for reducing file sizes by keeping only reads relevant to specific biological questions, such as those supporting breakpoints or specific mutations, while maintaining the ability to include mate-pairs even if they fall outside the target regions.

## Common CLI Patterns

### Basic Filtering and Extraction
Extract reads from a specific genomic range and output as a BAM file:
```bash
variant input.bam -g 'X:1,000,000-1,100,000' -b -o output.bam
```

Extract all read pairs that intersect with variants defined in a VCF file:
```bash
variant input.bam -l variants.vcf -b -o filtered.bam
```

### Structural Variation Enrichment
To extract reads likely to support structural variants (clipped, discordant, or containing indels), use a combination of flags:
```bash
# Filters for MAPQ >= 20 and insertions/deletions >= 10bp
variant input.bam --min-mapq 20 --min-ins 10 --min-del 10 -b -o sv_enriched.bam
```

### Quality Control and Masking
Exclude reads (and their mates) that overlap specific regions (e.g., blacklisted regions):
```bash
variant input.bam -L blacklist.bed -b -o masked.bam
```

Filter for high-quality clipped reads where the clip length is calculated after accounting for low-quality bases:
```bash
variant input.bam --min-phred 4 --min-clip 5 -o high_qual_clips.sam
```

### Coverage Subsampling
Subsample a sorted BAM file to a maximum coverage depth (e.g., 100x):
```bash
variant input.bam -m 100 -b -o subsampled.bam
```

## Advanced Rule Configuration
For complex workflows, `variantbam` uses JSON-based rules. This allows different filters to be applied to different genomic regions in a single pass.

**Example: Global filter for high-quality reads**
Create a `rules.json` file:
```json
{
  "hq_filter" : {
    "region" : "WG",
    "rules" : [{
      "length" : [50, 1000],
      "mapq" : [1, 60],
      "duplicate" : false,
      "hardclip" : false,
      "qcfail" : false
    }]
  }
}
```
Execute using the rules file:
```bash
variant input.bam -r rules.json -b -o hq_reads.bam
```

## Expert Tips
- **Streaming**: `variantbam` supports stdin/stdout. Use `-` as the input filename and the `-b` flag to ensure the output is a binary BAM stream for piping into tools like `samtools` or `bedtools`.
- **Mate Awareness**: Use the `-P` (padding) option when extracting regions to ensure that read-mates are included, which is critical for maintaining proper pair information for downstream analysis.
- **Performance**: When working with large datasets, ensure `libcurl` support is enabled if you need to stream data directly from cloud storage (S3/GCP).
- **Base Quality**: The `--min-phred` flag is unique because it dynamically adjusts how "clip length" or "read length" is calculated by ignoring bases below the specified quality threshold.

## Reference documentation
- [VariantBam GitHub Repository](./references/github_com_walaj_VariantBam.md)
- [Bioconda VariantBam Overview](./references/anaconda_org_channels_bioconda_packages_variantbam_overview.md)