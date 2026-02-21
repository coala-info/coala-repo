---
name: sideretro
description: sideRETRO is a specialized bioinformatics suite designed to identify somatic insertions of de novo retrocopies (processed pseudogenes) within genomic data.
homepage: https://github.com/galantelab/sideRETRO
---

# sideretro

## Overview

sideRETRO is a specialized bioinformatics suite designed to identify somatic insertions of de novo retrocopies (processed pseudogenes) within genomic data. It is particularly effective for detecting retrotransposition events that differ from the reference genome, such as those found in tumor-normal pairs or cohort studies. The tool identifies discordant and "abnormal" reads, stores them in a portable SQLite3 database, and then performs statistical merging and annotation to produce a standard VCF output.

## Core Workflow

The sideRETRO pipeline follows a strict three-step sequence using the `sider` executable.

### 1. Process Samples
Extract abnormal reads from alignment files and store them in a database.

```bash
sider process-sample \
  --annotation-file=genes.gtf \
  --input-file=bam_list.txt \
  --output-file=results.db
```

*   **Input File**: A text file containing the absolute paths to your BAM, SAM, or CRAM files (one per line).
*   **Annotation**: Use a high-quality GTF file (e.g., Gencode or Ensembl) that matches your reference genome version.

### 2. Merge and Call Events
Analyze the captured reads within the database to define and annotate retrocopy insertion events.

```bash
sider merge-call --in-place results.db
```

*   **In-place Processing**: The `--in-place` flag is recommended to update the existing SQLite database with the called events, which is required for the final VCF step.
*   **Multi-sample Analysis**: If your `bam_list.txt` contained multiple individuals, this step will discriminate between exclusive and shared events across the cohort.

### 3. Generate VCF
Convert the database results into a standard Variant Call Format (VCF) file for downstream analysis.

```bash
sider make-vcf \
  --reference-file=genome.fa \
  out.db > final_calls.vcf
```

*   **Reference**: Ensure the FASTA file is the same one used for the initial alignment of the BAM/CRAM files.

## Best Practices and Tips

*   **Library Dependencies**: sideRETRO relies on `HTSlib` for sequence reading and `SQLite3` for data management. If running from source, ensure these are in your environment.
*   **Genomic Context**: The tool automatically annotates whether an insertion is intergenic or intragenic (exonic/intronic). Review the `INFO` fields in the resulting VCF for these details.
*   **Strandness**: sideRETRO detects the orientation of the insertion relative to the leading or lagging DNA strand. This is critical for understanding the functional impact of the retrocopy.
*   **Database Inspection**: Since the intermediate format is SQLite3, you can use standard SQL queries to inspect the `out.db` file if you need to debug specific read captures before the merging step.

## Reference documentation
- [sideRETRO GitHub Repository](./references/github_com_galantelab_sideRETRO.md)
- [sideRETRO Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_sideretro_overview.md)