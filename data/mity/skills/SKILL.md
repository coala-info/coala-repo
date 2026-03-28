---
name: mity
description: mity is a bioinformatics pipeline designed to call, normalize, and annotate mitochondrial DNA variants with high sensitivity for low-level heteroplasmy. Use when user asks to call mitochondrial variants from BAM or CRAM files, generate clinical reports in Excel format, or merge mitochondrial calls with nuclear variant files.
homepage: https://github.com/KCCG/mity
---

# mity

---

## Overview

`mity` is a specialized bioinformatics pipeline optimized for the unique challenges of mitochondrial genomics. Unlike standard nuclear variant callers, `mity` is engineered to handle the extremely high read-depth typical of mitochondrial sequencing and can detect variants with heteroplasmy levels below 1%. It provides a streamlined workflow to transform raw alignments (BAM/CRAM) into filtered, normalized, and clinically annotated reports.

## Core Workflows

### Single-Step Execution
For most standard analyses, use `runall` to execute the calling, normalization, and reporting phases in a single command.

```bash
mity runall \
  --prefix <sample_id> \
  --output-dir <dir> \
  --region MT:1-16569 \
  --min_vaf 0.01 \
  <input.bam>
```

### Variant Calling
When running `mity call` independently, always include the `--normalise` flag. This ensures multi-allelic variants and multi-nucleotide polymorphisms (MNPs) are correctly decomposed, which is a prerequisite for the reporting tool.

```bash
mity call --normalise --prefix <name> <input.bam>
```

### Generating Reports
The `report` command produces an Excel file (`.xlsx`) designed for clinical interrogation. Use the `--min_vaf` (Variant Allele Frequency) filter to reduce noise from low-level sequencing artifacts.

```bash
mity report --min_vaf 0.01 --prefix <name> <normalised.vcf.gz>
```

### Pipeline Integration
To replace low-sensitivity mitochondrial calls from standard nuclear pipelines (e.g., GATK HaplotypeCaller) with high-sensitivity `mity` calls, use the `merge` command.

```bash
mity merge \
  --mity_vcf <mity.vcf.gz> \
  --nuclear_vcf <nuclear.vcf.gz> \
  --prefix <merged_sample>
```

## Expert Tips and Best Practices

### Reference Genome Compatibility
* **rCRS Requirement**: `mity` is designed for the revised Cambridge Reference Sequence (rCRS, NC_012920.1). Ensure your reference genome uses this sequence (standard in GRCh37, hs37d5, and GRCh38).
* **hg19 Warning**: Avoid using `mity report` with hg19 (NC_001807) as the 2bp length difference and coordinate shifts will result in incorrect annotations.

### Interpretation Strategy
When reviewing the `mity report` Excel output, prioritize variants using this hierarchy:
1. **Tier 1 & 2**: Check the `commercial_panels` and `disease_mitomap` columns for confirmed pathogenic variants.
2. **Frequency Filtering**: Exclude common variants by checking `MGRB_frequency` and `GenBank_frequency_mitomap`.
3. **Tier 3 Caution**: These variants have low supporting reads. Only consider them if they match the patient's clinical phenotype and consider validation via an orthogonal assay on affected tissue.

### Performance Optimization
* **CRAM Support**: `mity` natively supports CRAM files; ensure the reference fasta is accessible in your environment.
* **Region Limiting**: Use the `--region` flag to restrict analysis to the mitochondrial genome (e.g., `MT` or `chrM`) to prevent the tool from attempting to process nuclear chromosomes.
* **Debugging**: Use `-k` or `--keep` to retain intermediate VCFs and the annotated VCF before it is converted to Excel format.



## Subcommands

| Command | Description |
|---------|-------------|
| mity normalise | Normalises VCF files from mity. |
| mity report | Create a report from mity VCF files. |
| mity runall | Run the MITY pipeline on a list of BAM/CRAM files. |
| mity_call | BAM / CRAM files to run the analysis on. If --bam-file-list is included, this argument is the file containing the list of bam/cram files. |
| mity_merge | Merge MITY and nuclear VCF files. |

## Reference documentation
- [Mity README](./references/github_com_KCCG_mity_blob_master_README.md)
- [Installation Guide](./references/github_com_KCCG_mity_blob_master_docs_INSTALL.md)
- [Report Documentation](./references/github_com_KCCG_mity_blob_master_docs_mity_report_documentation.md)