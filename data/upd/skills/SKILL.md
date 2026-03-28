---
name: upd
description: The upd tool identifies genomic regions where a proband has inherited both alleles from a single parent using trio VCF data. Use when user asks to identify uniparental disomy regions, extract informative inheritance sites, or distinguish between isodisomy and heterodisomy.
homepage: https://github.com/bjhall/upd
---

# upd

## Overview
The `upd` tool is a specialized bioinformatics utility for identifying genomic regions where a proband has inherited both alleles from a single parent. It processes a single VCF file containing a trio to identify "informative sites"—variants where the inheritance pattern clearly indicates a single-parent origin. It then aggregates these sites into called regions based on size and density thresholds. This is critical for diagnosing clinical conditions related to genomic imprinting or identifying regions of homozygosity that may harbor recessive mutations.

## CLI Usage and Best Practices

### Core Command Structure
The tool uses a two-stage command structure: global options followed by a specific subcommand (`regions` or `sites`).

```bash
upd --vcf [INPUT_VCF] --proband [PB_ID] --mother [MOTHER_ID] --father [FATHER_ID] [SUBCOMMAND] [OPTIONS]
```

### Identifying UPD Regions
To generate a BED file of called UPD regions:
```bash
upd --vcf input.vcf.gz --proband PROBAND --mother MOM --father DAD regions --out results.bed
```

### Extracting Informative Sites
To see the raw classification of every analyzed SNP (useful for manual visualization or debugging):
```bash
upd --vcf input.vcf.gz --proband PROBAND --mother MOM --father DAD sites --out sites.bed
```

### Handling Population Frequency and VEP
`upd` requires population frequency data to filter for common SNPs, which are more likely to be informative for inheritance.
- **Default:** It looks for `MAX_AF`.
- **Custom Tag:** Use `--af-tag [TAG_NAME]` if your VCF uses a different field (e.g., `GNOMAD_AF`).
- **VEP Annotations:** If the frequency is buried in a VEP CSQ string, you **must** use the `--vep` flag.

### Optimization and Filtering
- **Quality Control:** The default `--min-gq 30` is standard. If working with low-coverage data, you may need to lower this, but expect increased noise.
- **Sensitivity:** Adjust `--min-sites` (default 3) and `--min-size` (default 1000 bp) to filter out small, potentially false-positive segments.
- **Isodisomy Threshold:** Use `--iso-het-pct` (default 0.01) to tune the ratio of heterozygous sites allowed within a region before it is classified as heterodisomy instead of isodisomy.

## Expert Tips and Interpretation
- **Isodisomy vs. Deletion:** `upd` cannot natively distinguish between isodisomy (two identical copies from one parent) and a hemizygous deletion (one copy from one parent, the other deleted). Always cross-reference `upd` results with SV/CNV calls. If a region is called as UPD and overlaps a deletion, the `ORIGIN` field tells you which parent's allele was *retained*.
- **VCF Requirements:** Ensure the VCF is a single file containing all three family members. The tool relies on the `GQ` (Genotype Quality) field; if your pipeline strips this, the tool will not function correctly.
- **Refining Calls:** For high-confidence isodisomy detection, combine `upd` results with a dedicated Runs of Homozygosity (ROH) caller like `bcftools roh`.



## Subcommands

| Command | Description |
|---------|-------------|
| upd | Manage UPF regions |
| upd | Update variant sites |

## Reference documentation
- [github_com_bjhall_upd_blob_master_README.md](./references/github_com_bjhall_upd_blob_master_README.md)
- [github_com_bjhall_upd.md](./references/github_com_bjhall_upd.md)