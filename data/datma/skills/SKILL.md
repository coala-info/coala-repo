---
name: datma
description: DATMA (Distributed AuTomatic Metagenomic Assembly and Annotation) is a modular framework designed to streamline the complex transition from raw sequencing reads to annotated metagenome-assembled genomes (MAGs).
homepage: https://github.com/andvides/DATMA
---

# datma

## Overview
DATMA (Distributed AuTomatic Metagenomic Assembly and Annotation) is a modular framework designed to streamline the complex transition from raw sequencing reads to annotated metagenome-assembled genomes (MAGs). It integrates multiple bioinformatics stages—QC, binning, assembly, and classification—into a single pipeline. Use this skill to guide the setup, configuration, and execution of the DATMA pipeline, ensuring all prerequisites like database indexing and configuration parameters are correctly handled.

## Installation and Setup
DATMA can be installed via Conda or by cloning the source repository.

**Conda Installation (Recommended):**
```bash
conda install bioconda::datma
```

**Manual Installation:**
1. Clone the repository: `git clone https://github.com/andvides/DATMA.git`
2. Run the installation script: `bash install_datma_UBUNTU.sh` (or the CENTOS equivalent).
3. Add the tools to your environment: `export PATH=<install_path>/DATMA/tools/bin/:$PATH`

**Prerequisite: 16S Database Indexing**
Before running the pipeline, you must generate the 16S database index. Navigate to the `16sDatabases` directory within the installation path and follow the instructions in the local README to prepare the reference indices.

## Configuration
DATMA relies on a plain-text configuration file to define parameters and input paths. 
- Locate template files in the `examples/` directory (e.g., `configBmini.txt`).
- Key parameters typically include paths to input FASTQ files, output directories, and specific tool settings for assembly or binning.
- Use a text editor like `nano` or `vim` to modify these templates for your specific dataset.

## Execution Patterns
The primary entry point is the `runDATMA.sh` script.

**Standard Execution:**
```bash
<install_path>/DATMA/runDATMA.sh <path_to_your_config.txt>
```

**Execution Modes:**
- **Sequential (seq):** Used for standard local processing.
- **Distributed (compss):** Requires the COMPSs framework to be installed and configured for distributed computing across clusters.

## Output Structure
Upon completion, DATMA generates a structured output directory:
- `clean/`: Contains quality control reports for the input reads.
- `16sSeq/`: Identified 16S ribosomal RNA sequences.
- `bins/`: The final results of assembly and annotation for individual bins.
- `round/`: Intermediate data from CLAME executions.
- `report.html` & `resumenFile.html`: High-level summaries of the binning and assembly results.
- `binsBlastn.html` & `binsKaiju.html`: Taxonomic annotations visualized in Krona format.

## Best Practices
- **Resource Management:** Metagenomic assembly is memory-intensive. Ensure your environment has sufficient RAM, especially when processing large datasets or using de novo assemblers within the pipeline.
- **Quality Check:** Always review the `clean/` directory first to ensure the input data quality was sufficient for downstream assembly.
- **Database Updates:** Periodically check the 16S database references to ensure taxonomic annotations remain current.

## Reference documentation
- [DATMA Overview - Bioconda](./references/anaconda_org_channels_bioconda_packages_datma_overview.md)
- [DATMA GitHub Repository](./references/github_com_andvides_DATMA.md)