---
name: transanno
description: transanno is a specialized bioinformatics tool designed for high-accuracy coordinate migration (LiftOver) between genome assemblies.
homepage: https://github.com/informationsea/transanno
---

# transanno

## Overview

transanno is a specialized bioinformatics tool designed for high-accuracy coordinate migration (LiftOver) between genome assemblies. It is particularly effective for handling complex genomic data that standard tools often struggle with, such as multiallelic VCF entries and structured gene annotations from GENCODE or Ensembl. A key advantage of transanno is its ability to generate its own chain files directly from minimap2 alignments, making it ideal for working with non-standard or newly assembled genomes where official UCSC chain files do not exist.

## Core Workflows

### 1. Generating a Chain File
If you do not have a `.chain` file for your two assemblies, generate one using `minimap2` and `transanno`.

```bash
# Step 1: Align query to reference
minimap2 -cx asm5 --cs QUERY_FASTA.fa REFERENCE_FASTA.fa > alignment.paf

# Step 2: Convert PAF to Chain
transanno minimap2-to-chain alignment.paf --output assembly_map.chain
```

### 2. VCF LiftOver
Convert variant coordinates while maintaining the integrity of INFO and FORMAT tags.

```bash
transanno liftvcf \
  --chain assembly_map.chain \
  --vcf input.vcf.gz \
  --reference reference.fa \
  --query query.fa \
  -o lifted_variants.vcf.gz \
  --fail failed_variants.vcf.gz \
  -m
```

**Key Options:**
- `-m`: Perform left-alignment to the chain for more accurate conversion.
- `--noswap`: Prevents transanno from swapping REF and ALT alleles if the reference base changed. Recommended for ClinVar or COSMIC datasets.
- `--allow-multi-map`: Allows variants to be mapped to multiple locations (default behavior fails multi-mapped variants).

### 3. Gene Annotation (GFF3/GTF) LiftOver
Specifically optimized for GENCODE and Ensembl annotations.

```bash
transanno liftgene input_annotation.gtf.gz \
  --chain assembly_map.chain \
  --output lifted_annotation.gtf.gz \
  --failed failed_annotation.gtf.gz
```

## Expert Tips and Best Practices

### File Preparation
- **FASTA Indexing**: All reference and query FASTA files must be indexed using `samtools faidx` before running transanno.
- **Compression**: transanno natively handles `.gz` and `.bgz` files. If the output filename ends in `.gz`, the tool will automatically compress the output.

### Post-Processing VCFs
transanno does **not** sort or index the output VCF files. You must use `bcftools` to make the files usable for downstream analysis or genome browsers:
```bash
bcftools sort -O z -o lifted_variants.sorted.vcf.gz lifted_variants.vcf.gz
bcftools index -t lifted_variants.sorted.vcf.gz
```

### Handling Multiallelic Sites
transanno is superior to many LiftOver tools because it correctly handles multiallelic sites, asterisks, and dots in the ALT column. It automatically rewrites allele frequencies and GT tags if REF/ALT columns are swapped during the LiftOver process.

### Assembly Comparison
To visualize the differences between two assemblies defined by a chain file, use the `chain-to-bed-vcf` command to generate VCF and BED files representing the gaps and mismatches:
```bash
transanno chain-to-bed-vcf assembly_map.chain \
  --reference reference.fa \
  --query query.fa \
  --output-reference-vcf ref_diffs.vcf.gz \
  --output-query-vcf query_diffs.vcf.gz
```

## Reference documentation
- [transanno Overview](./references/anaconda_org_channels_bioconda_packages_transanno_overview.md)
- [transanno GitHub Documentation](./references/github_com_informationsea_transanno.md)