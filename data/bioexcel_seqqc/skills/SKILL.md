---
name: bioexcel_seqqc
description: bioexcel_seqqc is a Python-based pipeline that automates genomic sequence quality control by integrating FastQC assessment and Cutadapt trimming. Use when user asks to perform automated sequence quality control, run FastQC, trim adapters from reads, or execute high-throughput genomic data processing.
homepage: https://github.com/bioexcel/bioexcel_seqqc
metadata:
  docker_image: "quay.io/biocontainers/bioexcel_seqqc:0.6--py_0"
---

# bioexcel_seqqc

## Overview
`bioexcel_seqqc` is a Python-based pipeline designed to streamline genomic sequence quality control. It integrates FastQC for assessment and Cutadapt for trimming, with a specialized `checkfastqc` module that automates the transition between these steps based on configurable quality thresholds. This tool is particularly useful for removing human intervention from the QC process, allowing for high-throughput processing of sequencing data.

## Core CLI Usage

The primary interface for the pipeline is the `bxcl_seqqc` (or `bioexcel_seqqc`) command.

### Running the Full Pipeline
To run the complete QC workflow (FastQC -> Automated Check -> Trimming):
```bash
bxcl_seqqc --files in1.fa in2.fa --threads 4 --outdir ./output
```

### Automated Decision Logic
The tool uses a configuration file to decide whether to trim or recheck files based on FastQC results. To view or customize these default thresholds:
```bash
bxcl_seqqc --printconfig
```
This outputs the default decision-making parameters, including which FastQC summary metrics trigger specific actions.

### Running Individual Stages
Each stage of the pipeline can be executed independently if a specific step needs to be repeated or integrated into a different workflow:
- **Trimming only**: `python -m bioexcel_seqqc.runtrim <arguments>`
- **FastQC only**: `python -m bioexcel_seqqc.runfastqc <arguments>`

## Python API Integration
For more complex workflows, `bioexcel_seqqc` can be imported as a Python module. Each function typically returns a subprocess object.

```python
import bioexcel_seqqc.runfastqc as rfq
import bioexcel_seqqc.runtrim as rt

# Execute FastQC
fqc_process = rfq.run_fqc(infiles, fqcdir, tmpdir, threads)
fqc_process.wait()

# Execute Trimming
trim_process = rt.trimQC(infiles, trimdir, threads)
trim_process.wait()
```

## Best Practices
- **Environment Management**: Always run `bioexcel_seqqc` within a Conda environment to ensure dependencies like `FastQC` and `Cutadapt` are correctly mapped in your `$PATH`.
- **Resource Allocation**: Use the `--threads` argument to match your available CPU cores, as both FastQC and Cutadapt benefit significantly from parallelization.
- **Configuration Tuning**: Before running large batches, use `--printconfig` to ensure the automated "Pass/Fail/Warn" logic aligns with your specific project quality requirements.

## Reference documentation
- [BioExcel_SeqQC GitHub Repository](./references/github_com_bioexcel_BioExcel_SeqQC.md)
- [BioExcel_SeqQC Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_bioexcel_seqqc_overview.md)