---
name: plasmidid
description: PlasmidID is a hybrid pipeline that combines read mapping and de novo assembly to identify and reconstruct plasmid sequences within bacterial samples. Use when user asks to identify plasmidic composition, reconstruct plasmids from reads or contigs, or generate circular visualizations of plasmid sequences.
homepage: https://github.com/BU-ISCIII/plasmidID
---


# plasmidid

## Overview
PlasmidID is a hybrid pipeline that combines read mapping and de novo assembly to accurately identify plasmid sequences within bacterial samples. By using a reference database as a scaffold, it clusters sequences to reduce redundancy and provides a graphical circular representation (via Circos) of the results. This tool is essential when you need to determine the plasmidic composition of a sample, especially when dealing with complex datasets where simple assembly might fail to resolve individual plasmids.

## Core Workflows

### 1. Database Preparation
Before running the pipeline, you must have a formatted plasmid database.
```bash
# Download and prepare the default plasmid database
download_plasmid_database.py -o /path/to/database_folder
```

### 2. Standard Paired-End Analysis
The most common use case involves providing raw or trimmed Illumina reads and a reference database.
```bash
plasmidID \
  -1 SAMPLE_R1.fastq.gz \
  -2 SAMPLE_R2.fastq.gz \
  -d database.fasta \
  -s SAMPLE_NAME \
  -g GROUP_NAME
```

### 3. Assembly-Assisted Analysis (Recommended)
If you already have assembled contigs, providing them significantly improves the reconstruction accuracy and speed.
```bash
plasmidID \
  -1 SAMPLE_R1.fastq.gz \
  -2 SAMPLE_R2.fastq.gz \
  -c assembled_contigs.fasta \
  -d database.fasta \
  -s SAMPLE_NAME \
  --no-trim
```

### 4. Contig-Only Reconstruction
For SMRT sequencing or when only assemblies are available, use the `--only-reconstruct` flag.
```bash
plasmidID \
  -d database.fasta \
  -c SAMPLE_contigs.fasta \
  -s SAMPLE_NAME \
  --only-reconstruct
```

## Expert Tips and Best Practices

- **Sample Naming**: Ensure the sample name (`-s`) is less than 37 characters to avoid issues with downstream visualization tools like Circos.
- **Sensitivity Tuning**: 
    - Use `--explore` to relax default parameters if you suspect the presence of plasmids with low homology to your database.
    - Adjust `-C` (coverage-cutoff, default 80) if you are looking for partial plasmid matches or highly divergent sequences.
- **Performance**: Use `-T` to specify the number of threads and `-M` to limit memory usage in HPC environments.
- **Clustering**: If your database contains many nearly identical sequences, adjust `-f` (clustering identity, default 0.5) to group them and simplify the output.
- **Batch Reporting**: If processing multiple samples in a single group, use the summary script to aggregate results:
  ```bash
  summary_report_pid.py -i GROUP_FOLDER/
  ```

## Output Interpretation
- **SAMPLE_final_results.html**: The primary interactive report containing the circular images.
- **MAPPING %**: Indicates how much of the reference sequence was covered by your reads.
- **Contig Track**: Shows how your assembled contigs align back to the reference scaffold.

## Reference documentation
- [PlasmidID Main Documentation](./references/github_com_BU-ISCIII_plasmidID.md)
- [PlasmidID Wiki and Workflow](./references/github_com_BU-ISCIII_plasmidID_wiki.md)