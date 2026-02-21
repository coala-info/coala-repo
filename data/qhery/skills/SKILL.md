---
name: qhery
description: qhery is a bioinformatics pipeline developed by the Queensland Health Q-PHIRE Genomics team.
homepage: http://github.com/mjsull/qhery/
---

# qhery

## Overview

qhery is a bioinformatics pipeline developed by the Queensland Health Q-PHIRE Genomics team. It automates the identification of amino acid changes in SARS-CoV-2 samples and cross-references them against the Stanford resistance database. By integrating variant data with lineage information and sequencing depth, it helps researchers determine if specific mutations might reduce the effectiveness of monoclonal antibodies or antiviral treatments.

## Command Line Usage

### 1. Identify Available Treatments
Before running an analysis, check which drugs are currently supported in the local or remote database.
```bash
qhery list_rx --database_dir ./qhery_db
```

### 2. Standard Resistance Analysis
Run the full pipeline using a VCF file. This identifies mutations and compares them to the resistance list for specified treatments.
```bash
qhery run \
  --sample_name "Sample01" \
  --vcf sample.vcf \
  --lineage "BA.1" \
  --rx_list Sotrovimab Remdesivir \
  --database_dir ./qhery_db \
  --pipeline_dir ./results
```

### 3. Enhanced Analysis with Minor Alleles and Coverage
To increase confidence and detect low-frequency variants, provide a BAM file and a consensus FASTA. This enables `lofreq` for minor allele detection and `samtools` to verify if a position has sufficient depth (default 20x) to report a mutation.
```bash
qhery run \
  --sample_name "Sample01" \
  --vcf sample.vcf \
  --bam sample.sorted.bam \
  --fasta sample.fasta \
  --lineage "BA.2" \
  --rx_list Sotrovimab \
  --database_dir ./qhery_db \
  --pipeline_dir ./results
```

### 4. Mutation Listing Only
If resistance data is not required, use the `mutations` subcommand to simply generate a list of detected amino acid changes.
```bash
qhery mutations \
  --sample_name "Sample01" \
  --vcf sample.vcf \
  --bam sample.sorted.bam \
  --lineage "Delta" \
  --pipeline_dir ./mutations_out
```

## Best Practices and Tips

- **Lineage Accuracy**: Always provide the correct `--lineage` (e.g., BA.1, BA.5, Delta). qhery uses this to distinguish between "lineage-defining" mutations and novel resistance mutations in the `final.tsv` output.
- **Coverage Validation**: Providing a BAM file is highly recommended. Without it, the tool cannot confirm if a "missing" resistance mutation is truly absent or simply not covered by sequencing reads.
- **Database Management**: The `--database_dir` should point to a persistent location. If the Stanford resistance database is missing or outdated, qhery will attempt to download the latest version automatically.
- **Output Interpretation**:
    - `*.full.tsv`: Contains every mutation detected plus all known resistance mutations for the selected drugs.
    - `*.final.tsv`: A filtered list containing only mutations in resistance-associated genes that are NOT lineage-defining, or positions with insufficient coverage (<20x).

## Reference documentation
- [qhery GitHub Repository](./references/github_com_mjsull_qhery.md)
- [qhery Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_qhery_overview.md)