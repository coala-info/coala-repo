---
name: sccaller
description: sccaller (Single Cell Caller) is a specialized tool designed to accurately identify genomic variants in single cells.
homepage: https://github.com/biosinodx/SCcaller
---

# sccaller

## Overview
sccaller (Single Cell Caller) is a specialized tool designed to accurately identify genomic variants in single cells. It addresses the unique challenges of single-cell genomics—such as high false-positive rates from amplification errors and allelic dropout—by using a likelihood ratio test based on a null distribution derived from data resampling. It is primarily used to call germline variants or to identify somatic mutations by comparing single-cell data against a matched bulk DNA sample.

## Installation and Environment
sccaller is available via Bioconda and requires a Python 2.7 environment.
```bash
conda install -c bioconda sccaller
```
**Key Dependencies:**
* Python 2.7
* samtools v1.9+
* pysam v0.15.1
* numpy

## Common CLI Patterns

### 1. Calling Variants with Known Heterozygous SNPs
This is the preferred mode when you have a list of heterozygous SNPs pre-called from a matched bulk DNA sample. This provides the highest accuracy for determining allelic dropout rates.
```bash
python sccaller_v2.0.0.py \
  --bam cell.bam \
  --fasta reference.fa \
  --output output.vcf \
  --snp_type hsnp \
  --snp_in bulk_heterozygous_snps.vcf \
  --cpu_num 8 \
  --engine samtools
```

### 2. Calling Variants using Public Databases (dbSNP)
Use this mode if matched bulk DNA is unavailable. You must provide a VCF or BED file containing known SNPs (e.g., from dbSNP).
```bash
python sccaller_v2.0.0.py \
  --bam cell.bam \
  --fasta reference.fa \
  --output output.vcf \
  --snp_type dbsnp \
  --snp_in dbsnp_resource.vcf \
  --cpu_num 8 \
  --engine samtools
```

### 3. Somatic Mutation Discovery
To identify somatic mutations (variants present in the cell but not the bulk), include the bulk BAM file in the input.
```bash
python sccaller_v2.0.0.py \
  --bam cell.bam \
  --bulk bulk.bam \
  --fasta reference.fa \
  --output cell_vs_bulk.vcf \
  --snp_type hsnp \
  --snp_in bulk_hsnp.vcf \
  --cpu_num 8 \
  --engine samtools
```

## Post-Processing and Filtering
sccaller outputs a VCF. To isolate high-confidence somatic mutations, you must filter the output based on the presence of the variant in the bulk and the sequencing depth in the single cell.

**Filter for Somatic SNVs:**
```bash
grep '0/1' cell.vcf | grep 'True' | awk '$7=="." && length($5)==1' | awk -F "[:,]" '$8+$9>=20' > cell.somatic.snv.vcf
```

**Filter for Somatic INDELs:**
```bash
grep '0/1' cell.vcf | grep 'True' | awk '$7=="." && length($5)>1' | awk -F "[:,]" '$8+$9>=20' > cell.somatic.indel.vcf
```

## Expert Tips and Constraints
* **Ploidy Limitation:** sccaller assumes a diploid genome. It is not suitable for calling mutations on the X or Y chromosomes of male subjects.
* **Engine Selection:** Always specify `--engine samtools` for modern workflows, as it is the most tested and reliable backend for the tool.
* **Mapping Quality:** The default minimum mapping quality (mapQ) is 40. If working with low-complexity regions, you may need to adjust this, though higher values are recommended to reduce false positives.
* **Performance:** Use the `--cpu_num` argument to enable parallel processing, as single-cell variant calling is computationally intensive.
* **Input Validation:** Ensure your BAM files are indexed (`samtools index`) and the reference FASTA matches the one used for alignment.

## Reference documentation
- [SCcaller README](./references/github_com_biosinodx_SCcaller_blob_master_README.md)
- [Bioconda sccaller Overview](./references/anaconda_org_channels_bioconda_packages_sccaller_overview.md)