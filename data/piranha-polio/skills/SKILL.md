---
name: piranha-polio
description: Piranha-polio is a bioinformatics suite that processes Nanopore sequencing data for poliovirus surveillance, performing haplotype analysis and generating consensus sequences. Use when user asks to process Nanopore reads for poliovirus, perform VP1 sequencing analysis, identify vaccine-derived polioviruses, or detect laboratory contamination.
homepage: https://github.com/polio-nanopore/piranha
metadata:
  docker_image: "quay.io/biocontainers/piranha-polio:1.5.3--pyhdfd78af_0"
---

# piranha-polio

## Overview
Piranha (piranha-polio) is a specialized bioinformatics suite designed to standardize the processing of Nanopore sequencing data for poliovirus surveillance. It automates the workflow from raw reads to distributable, interactive reports, performing haplotype analysis and generating consensus sequences. The tool is specifically optimized for VP1 sequencing and includes built-in logic to identify Vaccine-Derived Polioviruses (VDPV) and detect potential laboratory contamination.

## Installation and Setup
The recommended way to install piranha-polio is via Bioconda:

```bash
conda install bioconda::piranha-polio
```

For users requiring the latest development features or manual environment management:
1. Clone the repository: `git clone https://github.com/polio-nanopore/piranha.git`
2. Create the environment: `mamba env create -f environment.yml`
3. Install the package: `pip install .`

## Common CLI Patterns
The `piranha` command is the primary entry point for the analysis pipeline.

### Standard VP1 Analysis
To run the full pipeline, provide the directory containing your Nanopore reads and the associated barcode information:
```bash
piranha --input /path/to/reads --barcodes barcodes.csv
```

### Advanced Configuration
- **Epidemiological Metadata**: Include an epidemiological CSV to enrich reports and enable specific metadata-based checks:
  `piranha --input /path/to/reads --barcodes barcodes.csv --epi metadata.csv`
- **Quality Filtering**: Adjust the minimum base quality threshold for read processing:
  `piranha --input /path/to/reads --min_base_q 10`
- **Isolate Mode**: Use isolate-specific configurations for whole-genome analysis (note: this mode is in active development):
  `piranha --input /path/to/reads --isolate_group <group_name>`

## Best Practices and Expert Tips
- **VP1 Optimization**: While Piranha supports whole-genome and panEV modes, the VP1 pipeline is the most mature. Always perform manual QC checks when using non-VP1 modes.
- **Contamination Alerts**: Review the summary report for flags indicating identical sequences between different samples, which is a primary indicator of run-to-run or cross-sample contamination.
- **Metadata Validation**: Ensure that the `epid` column in your metadata CSV does not contain spaces or special characters, as these can cause failures during the consensus sequence generation phase.
- **Control Verification**: Piranha automatically monitors positive and negative controls. A "failed control" flag in the report should be addressed before interpreting sample results.
- **Output Compatibility**: If using the generated FASTA files with PONS (Poliovirus Online Name Service), ensure you are using the latest version of Piranha (1.5.3+) which includes compatibility fixes for FASTA headers.

## Reference documentation
- [Piranha GitHub Repository](./references/github_com_polio-nanopore_piranha.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_piranha-polio_overview.md)