---
name: oncogemini
description: Oncogemini is a specialized framework for analyzing tumor-normal pairs and longitudinal cancer genomics data using a SQLite database. Use when user asks to query somatic variants, identify truncal mutations, perform bottleneck analysis for clonal expansion, or detect loss of heterozygosity.
homepage: https://github.com/fakedrtom/oncogemini
---


# oncogemini

## Overview
OncoGEMINI is a specialized framework designed for cancer genomics. It extends the capabilities of the GEMINI system to handle the unique requirements of tumor-normal pairs and longitudinal sampling. By utilizing a SQLite database generated from annotated VCF files, it allows researchers to execute sophisticated SQL-based queries and use built-in tools to detect evolutionary patterns in tumor progression, such as variants that increase in frequency over time or those unique to specific metastatic sites.

## Database Preparation
Before using OncoGEMINI tools, the input VCF must be properly processed and converted into a database format.

1.  **Normalization**: Decompose multi-allelic sites and normalize variants using `vt`.
2.  **Annotation**: Annotate the VCF with functional impact (VEP/SnpEff) and cancer-specific metadata (using `vcfanno`).
3.  **Manifest Creation**: Create a sample manifest file. Unlike standard PED files, this must include:
    *   `patient_id`: To group samples from the same individual.
    *   `time`: Integer representing the sampling order (0 for normal/baseline, >0 for longitudinal tumor samples).
    *   `purity`: (Optional) Estimated tumor content.
4.  **Loading**: Use `vcf2db.py` to create the database:
    ```bash
    vcf2db.py annotated.vcf.gz sample.manifest output.db
    ```

## Common CLI Patterns

### General Querying
Use the `query` tool for flexible SQL-based filtering of the `variants` table.
```bash
oncogemini query -q "SELECT chrom, start, end, ref, alt, gene FROM variants WHERE impact_severity == 'HIGH' AND is_somatic == 1" database.db
```

### Bottleneck Analysis
Identify variants whose allele frequencies (AF) increase across sequential timepoints, suggesting clonal expansion or selection.
*   **Default requirements**: Positive slope (>0.05) and high R correlation (>0.5).
*   **Normal sample**: Automatically filters for variants with 0 AF in the normal sample (time=0).

```bash
oncogemini bottleneck --minSlope 0.1 --minR 0.8 --endDiff 0.2 database.db
```

### Somatic Analysis Tools
OncoGEMINI includes several specialized tools for tumor evolution:
*   **truncal**: Identifies "founder" mutations present in all tumor samples of a patient.
*   **unique**: Finds variants present in only one specific sample or timepoint.
*   **loh**: Detects potential Loss of Heterozygosity events based on allele frequency shifts.
*   **annotate**: Adds new column metadata to an existing OncoGEMINI database.

## Best Practices
*   **Decomposition is Mandatory**: Always run `vt decompose` before database loading; failing to do so will result in multi-allelic variants being incorrectly parsed.
*   **Timepoint Integrity**: Ensure the `time` column in your manifest accurately reflects the biological sequence of samples to make `bottleneck` results meaningful.
*   **SQL Optimization**: When using `query`, select only the columns you need (e.g., `chrom, start, end`) rather than `SELECT *` to improve performance on large clinical datasets.
*   **Normal Samples**: Always include a germline/normal sample with `time 0` in your manifest if you want the tools to automatically filter out germline variation.



## Subcommands

| Command | Description |
|---------|-------------|
| db_info | Show information about a specific database. |
| oncogemini annotate | Annotate variants with information from a BED file. |
| oncogemini bottleneck | Analyze bottleneck in cancer evolution |
| oncogemini dump | Dump data from the oncogemini database. |
| oncogemini fusions | Query the database for fusions. |
| oncogemini loh | Filter and query LOH variants from a database. |
| oncogemini query | Query the oncogemini database. |
| oncogemini region | Query oncogemini database for regions or genes. |
| oncogemini set_somatic | Set somatic status for variants in a database. |
| oncogemini stats | Report statistics from the database. |
| oncogemini truncal | Query the database for truncal variants. |
| oncogemini update | Update oncogemini and its dependencies. |
| oncogemini windower | Windowing tool for oncogemini |
| oncogemini_amend | Amend a database with new sample information. |
| oncogemini_roh | Finds regions of homozygosity (ROH) in a database. |
| oncogemini_unique | Identify unique variants in a database. |

## Reference documentation
- [OncoGEMINI README](./references/github_com_fakedrtom_oncogemini_blob_master_README.md)
- [Master Test Script (Tool List)](./references/github_com_fakedrtom_oncogemini_blob_master_master-test.sh.md)