---
name: bio-vcf
description: The `bio-vcf` tool provides a Domain Specific Language (DSL) designed for efficient VCF manipulation.
homepage: https://github.com/vcflib/bio-vcf
---

# bio-vcf

## Overview
The `bio-vcf` tool provides a Domain Specific Language (DSL) designed for efficient VCF manipulation. Unlike standard parsers, it uses lazy parsing and multi-core scaling to handle massive files quickly. It is particularly useful for complex filtering logic that involves both record-level metadata (INFO fields) and sample-level genotypes (FORMAT fields), allowing for sophisticated queries that would otherwise require custom scripting.

## Core CLI Patterns

### Basic Filtering
Filter records based on quality and specific INFO fields:
```bash
bio-vcf --filter 'r.qual > 50 and r.info.dp > 20' < input.vcf
```

### Sample-Specific Filtering
Filter based on genotype data across samples. Use `s` or `sample` for sample context and `r` or `rec` for record context:
```bash
# Filter for samples with depth > 20 where the record filter is "PASS"
bio-vcf --sfilter 's.dp > 20 and r.filter == "PASS"' < input.vcf

# Filter specific samples by index (e.g., 0 and 3)
bio-vcf --sfilter-samples 0,3 --sfilter 's.dp > 20' < input.vcf
```

### Data Transformation and Evaluation
Use `--eval` to output specific fields in a tab-delimited format. If the evaluation result is an array, `bio-vcf` automatically joins them with tabs:
```bash
# Output Chromosome, Position, and Tumor Genotype Quality
bio-vcf --eval '[r.chrom, r.pos, r.tumor.gq]' < input.vcf
```

### High-Performance Processing
For large Whole Genome Sequencing (WGS) files, leverage multi-threading:
```bash
# Use 16 threads and process in chunks of 40,000 lines
bio-vcf --num-threads 16 --thread-lines 40000 --filter 'r.qual > 30' < input.vcf
```

### Format Conversion
`bio-vcf` can transform VCF data into various structured formats:
```bash
# Convert VCF header to JSON
bio-vcf --json < input.vcf

# Convert to BED format
bio-vcf --eval '[r.chrom, r.pos, r.pos+1]' < input.vcf > output.bed
```

## Expert Tips & Best Practices

- **Lazy Parsing**: `bio-vcf` only parses the fields you actually reference in your filter or eval strings. To maximize speed, avoid referencing fields you don't need.
- **Regex Matching**: Use Ruby-style regular expressions for flexible string matching:
  `--filter 'r.filter !~ /LowQD/`
- **Type Casting**: Explicitly cast fields when performing numerical comparisons to avoid errors with missing data:
  `--filter 'r.info.cp.to_f > 0.3'`
- **Handling Compressed Files**: Always pipe gzipped files using `zcat` or `pigz` for maximum throughput:
  `zcat huge_file.vcf.gz | bio-vcf --num-threads 8 --filter '...'`
- **Somatic Analysis**: Easily query tumor/normal pairs if the VCF is formatted with those sample names:
  `--filter 'r.tumor.bq[r.alt] > 30 and r.normal.dp > 10'`

## Reference documentation
- [bio-vcf GitHub Repository](./references/github_com_vcflib_bio-vcf.md)
- [Bioconda bio-vcf Overview](./references/anaconda_org_channels_bioconda_packages_bio-vcf_overview.md)