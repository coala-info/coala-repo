---
name: expansionhunterdenovo
description: ExpansionHunter Denovo is a toolset for performing genome-wide identification of large short tandem repeat expansions from short-read sequencing data. Use when user asks to profile STR-related reads, perform case-control or outlier analysis to find significant expansions, or annotate and visualize expansion results.
homepage: https://github.com/Illumina/ExpansionHunterDenovo
metadata:
  docker_image: "quay.io/biocontainers/expansionhunterdenovo:0.9.0--h6ac36c1_11"
---

# expansionhunterdenovo

## Overview

ExpansionHunter Denovo (EHdn) is a specialized toolset designed to identify large STR expansions that cannot be fully spanned by short reads (typically 100-200bp). Unlike traditional STR callers that genotype known loci, EHdn performs a genome-wide search for "anchored" and "unplaced" repeat-rich reads to find expansions regardless of whether the locus is previously annotated.

The workflow consists of two primary stages:
1.  **Profiling**: Extracting STR-related read counts from individual BAM/CRAM files.
2.  **Comparison**: Performing cohort-level statistical tests (Case-Control or Outlier analysis) to prioritize significant expansions.

## Command Line Usage

### 1. Generating STR Profiles
The first step must be run on every sample in the cohort. This command identifies reads that originate within STRs.

```bash
ExpansionHunterDenovo profile \
  --reads sample.bam \
  --reference reference.fa \
  --output-prefix sample_name
```

**Key Parameters:**
*   `--reads`: Input BAM or CRAM file.
*   `--reference`: The reference genome fasta file used for alignment.
*   `--min-anchor-mapq`: (Optional) Minimum mapping quality for anchor reads; default is usually sufficient but can be adjusted for sensitivity.

### 2. Cohort Analysis
Once profiles are generated for all samples, they must be compared.

#### Case-Control Analysis
Use this when you have a defined group of affected individuals and a control group, looking for expansions enriched in the cases.

```bash
ExpansionHunterDenovo case-control \
  --manifest manifest.tsv \
  --output-prefix cohort_results
```

#### Outlier Analysis
Use this for heterogeneous cohorts where you expect a specific expansion to be present in only one or a few individuals.

```bash
ExpansionHunterDenovo outlier \
  --manifest manifest.tsv \
  --output-prefix outlier_results
```

**Manifest File Format:**
The manifest is a tab-separated file with three columns: `sample_name`, `status` (case/control), and `path_to_profile.json`.

### 3. Annotation and Visualization
EHdn provides auxiliary scripts to help interpret results.

*   **Annotation**: Use the provided Python scripts in the `scripts/` directory to annotate identified regions with gene names and known STR loci.
*   **Bamlets**: To visualize the evidence for an expansion in IGV, use the `make-bamlet` script to extract relevant reads into a small, viewable BAM file.

## Best Practices and Expert Tips

*   **Sequencing Consistency**: For optimal results, ensure all samples were sequenced on the same platform, with similar coverage, and processed using the same alignment pipeline. EHdn is sensitive to batch effects in read depth and fragment length.
*   **Read Length Limitation**: EHdn is specifically designed for expansions *longer* than the read length. It will ignore STRs that are shorter than the read length.
*   **Approximate Localization**: The reported coordinates for an expansion are approximate (typically within 500bp to 1kb). Always use the "bamlet" creation script to manually inspect the region in a genome browser.
*   **Normalization**: EHdn reports depth-normalized counts. While these correlate with repeat length, they are not exact genotypes. Treat the output as a prioritization score rather than a precise measurement of repeat units.
*   **Parameter Correction**: Note that in some versions, the documentation may incorrectly refer to `--test-method`; use `--test-params` if you need to adjust statistical thresholds.

## Reference documentation
- [ExpansionHunter Denovo GitHub Overview](./references/github_com_Illumina_ExpansionHunterDenovo.md)
- [Bioconda ExpansionHunter Denovo Package](./references/anaconda_org_channels_bioconda_packages_expansionhunterdenovo_overview.md)
- [EHdn Documentation Tree](./references/github_com_Illumina_ExpansionHunterDenovo_tree_master_documentation.md)