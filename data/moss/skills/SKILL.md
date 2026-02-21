---
name: moss
description: Moss is a specialized somatic variant caller designed to improve the detection of single nucleotide variants (SNVs) that exhibit low variant allele frequencies (VAF) across multiple related samples.
homepage: https://github.com/elkebir-group/Moss
---

# moss

## Overview

Moss is a specialized somatic variant caller designed to improve the detection of single nucleotide variants (SNVs) that exhibit low variant allele frequencies (VAF) across multiple related samples. Rather than acting as a standalone primary caller, Moss functions as an extension to existing tools. It leverages the collective evidence from a cohort of samples to recover variants that might fall below the detection threshold of single-sample analysis, while maintaining high precision through a joint calling approach.

## Installation

The recommended method is via Bioconda:

```bash
conda install -c bioconda moss
```

## Core Workflow

The Moss pipeline consists of three primary stages: candidate generation, joint calling, and post-filtering.

### 1. Generate Candidate Loci
Before running the caller, you must create a unified VCF of candidate loci from your primary somatic caller results (e.g., Strelka2 or Mutect2).

```bash
python scripts/union_candidates.py \
    -f samples.list \
    --normal-name <normal_sample_id> \
    -t <caller_type> \
    -o candidates.vcf
```
*   `-f`: A list of sample VCF files.
*   `-t`: The type of base caller used (e.g., `strelka` or `mutect2`).

### 2. Execute Moss Caller
The `moss` executable requires the reference genome, BAM files for all samples (normal and tumors), and the candidate VCF.

```bash
./moss -r reference.fa \
    -b normal.bam -R empty.bam \
    -b tumor1.bam -R empty.bam \
    -b tumor2.bam -R empty.bam \
    -l candidates.vcf \
    -m 4 -t -0.693 \
    --ignore0 --grid-size 200 \
    -o output.vcf
```

**Key Parameters:**
*   `-b` and `-R`: These flags must be provided in pairs for every sample. `-b` is the standard BAM; `-R` is the realigned BAM. If realigned BAMs are unavailable, provide a path to an empty BAM file.
*   `-m`: The number of threads to use.
*   `-t`: The log-likelihood ratio threshold for calling a variant.
*   `--ignore0`: Recommended flag to ignore the normal sample during the variant discovery phase to focus on somatic mutations.

### 3. Post-Filtering
After calling, the output VCF must be compressed, indexed, and filtered to remove artifacts and clustered loci.

```bash
# Prepare the file
bgzip output.vcf
tabix output.vcf.gz

# Run filter
python scripts/post_filter.py \
    --normal-name <normal_sample_id> \
    -i output.vcf.gz \
    -o final_filtered.vcf
```

## Expert Tips and Best Practices

*   **BAM Pairing**: Ensure that the order of `-b` and `-R` flags matches the order of samples used in the candidate generation step. The normal sample is typically provided as the first `-b` entry.
*   **Empty BAMs**: If you do not have realigned BAMs (often produced by tools like Strelka), you must still provide the `-R` flag with a placeholder "empty.bam" to satisfy the command-line requirements.
*   **Reference Consistency**: The reference FASTA (`-r`) must be the exact same file (including chromosome naming conventions) used for the initial alignment of the BAM files.
*   **Low VAF Sensitivity**: Moss is specifically tuned for low VAF. If you are only interested in high-frequency clonal variants, standard callers may suffice; use Moss specifically when looking for subclonal or shared low-frequency events across multiple biopsies or timepoints.

## Reference documentation
- [Moss GitHub Repository](./references/github_com_elkebir-group_Moss.md)
- [Bioconda Moss Overview](./references/anaconda_org_channels_bioconda_packages_moss_overview.md)