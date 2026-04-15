---
name: transanno
description: transanno is a high-performance genomic liftover tool that converts VCF, GFF3, and GTF coordinates between genome assemblies while managing metadata and allele swaps. Use when user asks to lift over VCF files, convert gene annotations between assemblies, or generate custom chain files from minimap2 alignments.
homepage: https://github.com/informationsea/transanno
metadata:
  docker_image: "quay.io/biocontainers/transanno:0.4.5--h4349ce8_0"
---

# transanno

## Overview

transanno is a high-performance genomic LiftOver tool designed to handle the complexities of modern genome assemblies. It distinguishes itself from traditional tools by providing deep integration with VCF metadata—automatically reordering INFO and FORMAT tags and updating genotype (GT) data when a coordinate shift results in a reference/alternate allele swap. It also simplifies the transition to new assemblies by allowing users to generate their own chain files directly from minimap2 alignments, ensuring that the LiftOver process is tailored to the specific differences between two assembly versions.

## Command Line Usage

### 1. Generating Chain Files
If a standard UCSC chain file is unavailable, create one using `minimap2` alignments.

```bash
# Step 1: Align query to reference
minimap2 -cx asm5 --cs QUERY_FASTA.fa REFERENCE_FASTA.fa > alignment.paf

# Step 2: Convert PAF to Chain
transanno minimap2-to-chain alignment.paf --output custom.chain
```

### 2. Lifting Over VCF Files
Lifting over VCFs requires the chain file and the FASTA files for both assemblies (with `.fai` indexes).

```bash
transanno liftvcf \
  --chain custom.chain \
  --vcf input.vcf.gz \
  --reference ref_assembly.fa \
  --query query_assembly.fa \
  -o succeeded.vcf.gz \
  --fail failed.vcf.gz \
  -m
```

### 3. Lifting Over Gene Annotations (GFF3/GTF)
Optimized specifically for GENCODE and Ensembl formatted files.

```bash
transanno liftgene input.gtf.gz \
  --chain custom.chain \
  --output succeeded.gtf.gz \
  --failed failed.gtf.gz
```

## Expert Tips and Best Practices

### VCF Post-Processing
transanno does not automatically sort or bgzip-index the output. To use the results in downstream tools (like IGV or bcftools), always sort and index:
```bash
bcftools sort -O z -o succeeded.sorted.vcf.gz succeeded.vcf.gz
bcftools index -t succeeded.sorted.vcf.gz
```

### Handling Reference Swaps
By default, transanno swaps REF and ALT columns if the reference allele changes in the new assembly. 
- **For standard variants**: Allow the swap; transanno will correctly update AF, INFO, and GT tags.
- **For ClinVar/COSMIC**: Use the `--noswap` flag. These databases often rely on specific REF/ALT orientations that should be preserved even if the underlying assembly allele differs.

### Multi-mapping Strategy
- **Default**: transanno fails variants that map to multiple locations to ensure accuracy.
- **Preference**: It automatically prefers the same contig name (e.g., chr11 to chr11) if a variant multi-maps to a primary contig and a random/alt scaffold.
- **Override**: Use `--allow-multi-map` if you need to capture all possible locations for a variant in the new assembly.

### Chain Alignment
For maximum accuracy, transanno performs a "left align" on the chain file before conversion. If you have a pre-aligned chain or want to skip this for speed on very large datasets, use `--no-left-align-chain`.

### Contig Naming
transanno is flexible with contig naming; you generally do not need to manually add or remove `chr` prefixes to match the chain file, provided the FASTA and VCF/GTF files are internally consistent.



## Subcommands

| Command | Description |
|---------|-------------|
| transanno chain-to-bed-vcf | Create BED and VCF file from chain file |
| transanno left-align | Left align and normalize chain file |
| transanno liftbed | Lift BED file |
| transanno liftgene | Lift GENCODE or Ensemble GFF3/GTF file |
| transanno liftvcf | LiftOver VCF file |
| transanno minimap2chain | Convert minimap2 result to chain file |

## Reference documentation
- [transanno README](./references/github_com_informationsea_transanno_blob_master_README.md)