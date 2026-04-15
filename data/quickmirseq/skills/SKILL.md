---
name: quickmirseq
description: QuickMIRSeq is a strand-aware pipeline for the joint processing and quantification of multiple small RNA-sequencing samples. Use when user asks to prepare reference databases, configure multi-sample miRNA runs, quantify isomiRs, or generate interactive summary reports.
homepage: https://sourceforge.net/projects/quickmirseq/
metadata:
  docker_image: "quay.io/biocontainers/quickmirseq:1.0.0--hdfd78af_3"
---

# quickmirseq

## Overview

QuickMIRSeq is a strand-aware pipeline designed for the joint processing of multiple small RNA-sequencing samples. It streamlines the workflow from raw reads to quantification, specifically accounting for the unique nature of miRNAs and their variants (isomiRs). Use this skill to manage database preparation, configure multi-sample runs, and generate interactive summary reports that include distribution plots, redundancy checks, and expression correlations.

## Environment Setup

Before running the pipeline, ensure the environment is correctly configured.

- **Installation**: Install via Bioconda using `conda install bioconda::quickmirseq` or download the source from SourceForge.
- **Environment Variables**: If installing from source, set the installation directory:
  ```bash
  export QuickMIRSeq=/path/to/QuickMIRSeq_Directory
  export PATH=$QuickMIRSeq:$PATH
  ```
- **Dependencies**: Ensure `bowtie` (v0.12.7) and `cutadapt` are in your PATH. Required Perl modules include `Config::Simple`, `Parallel::ForkManager`, `Compress::Zlib`, and `MIME::Base64`.

## Database Preparation

You must build the reference databases before processing samples. This is a one-time setup that typically takes 2–4 hours.

1. Navigate to the database directory: `cd $QuickMIRSeq/database`
2. Execute the creation script: `./create_database_util.sh`
3. To customize for specific species or include additional smallRNA/mRNA sequences, modify `create_database_util.sh` before execution.

## Execution Workflow

The pipeline requires two primary configuration files: `allIDs.txt` and `run.config`.

### 1. Prepare Input Files
- **allIDs.txt**: A simple text file listing one sample ID per line.
- **run.config**: A control file defining parameters (adapter sequences, paths to databases, output directory). Use the `run.config.template` provided in the package as a starting point.
- **sample.annotation.txt** (Optional but recommended): A TAB-delimited file placed in the output folder.
  - Column 1: `sample_id`
  - Column 2: `subject_id` (samples from the same subject should share an ID)
  - Column 3+: Additional metadata for the report.

### 2. Run Quantification
Execute the main pipeline script using Perl:
```bash
perl $QuickMIRSeq/QuickMIRSeq.pl allIDs.txt run.config
```

### 3. Generate Reports
After the main pipeline completes, generate the interactive HTML report:
1. Navigate to your specified output folder.
2. Run the report script:
```bash
$QuickMIRSeq/QuickMIRSeq-report.sh
```

## Output Analysis

Key results are located in the `Results/Summary` directory:
- **miRNA Counts**: `miR.filter.Counts.csv` (filtered for noise) and `miR.Counts.csv` (raw).
- **isomiR Counts**: `isoform.filter.Counts.csv`.
- **Normalization**: `miR.filter.RPM.csv` (Reads Per Million).
- **Visualizations**: Look for `.png` files covering read length distribution, 5'/3' offsets, and sample correlations.

## Expert Tips

- **Sample Naming**: Ensure sample names start with a letter and contain no white space.
- **Memory Management**: QuickMIRSeq uses `Parallel::ForkManager`. Adjust the number of parallel processes in `run.config` to match your system's CPU and RAM capacity.
- **Data Sharing**: To share results without bulky intermediate files, package the output folder while excluding temporary data:
  ```bash
  tar -zcvf project_results.tgz --exclude='unmapped.csv' --exclude='mapped.csv' --exclude='trimmed' --exclude='bowtie_temp' --exclude='alignment' [output_folder]
  ```

## Reference documentation
- [QuickMIRSeq Files and README](./references/sourceforge_net_projects_quickmirseq_files.md)
- [Bioconda QuickMIRSeq Overview](./references/anaconda_org_channels_bioconda_packages_quickmirseq_overview.md)