---
name: mira
description: MIRA is a bioinformatics tool for assembling DNA and RNA sequencing data. Use when user asks to assemble sequencing data, perform de novo assembly, or map reads to a reference.
homepage: https://github.com/DrMicrobit/mira
metadata:
  docker_image: "quay.io/biocontainers/mira:5.0.0rc2--hb5a7bbe_0"
---

# mira

---
## Overview
MIRA is a powerful bioinformatics tool designed for assembling DNA and RNA sequencing data. It can handle a variety of sequencing technologies and is particularly useful for de novo assembly of genomes and transcriptomes, as well as for mapping assembled sequences against a reference. MIRA also offers capabilities for identifying variations like SNPs and indels.

## Usage Instructions

MIRA is primarily a command-line tool. The general workflow involves preparing your input reads and then running the `mira` executable with appropriate parameters.

### Core Functionality

MIRA supports several assembly modes, typically specified via configuration files or command-line arguments. The most common use cases are:

*   **De novo assembly**: Assembling sequences from scratch without a reference genome.
*   **Mapping**: Aligning reads or contigs to a reference sequence.

### Input Data

MIRA accepts various sequence data formats. Common formats include FASTA and FASTQ. For PacBio data, it supports CCS and error-corrected CLR reads.

### Command-Line Usage

The basic structure of a MIRA command is:

```bash
mira <input_reads_file> <output_directory> [options]
```

**Key Options and Considerations:**

*   **Input Files**: MIRA can take multiple input files. These can be specified directly or through a manifest file.
*   **Output Directory**: A directory where MIRA will store its output files, including assembled contigs, quality reports, and intermediate files.
*   **Configuration**: MIRA's behavior is heavily influenced by its configuration. This can be done via:
    *   **Command-line parameters**: For simpler adjustments.
    *   **Configuration files**: For complex assemblies, it's recommended to use MIRA's configuration files, which allow fine-grained control over assembly parameters. These files often have a `.cfg` extension.
*   **Technology-Specific Settings**: MIRA has specific parameters tailored to different sequencing technologies (e.g., `sanger`, `454`, `illumina`, `pacbio`). Ensure you are using the correct settings for your data.

### Expert Tips

*   **Resource Management**: Genome assembly is computationally intensive. Pay close attention to memory and CPU requirements. MIRA's documentation provides guidance on estimating resource needs.
*   **Parameter Tuning**: For optimal results, especially with large datasets or complex genomes, experiment with MIRA's assembly parameters. Refer to the "Definitive Guide to MIRA" for detailed explanations of each parameter.
*   **Error Correction**: MIRA includes built-in error correction mechanisms. Ensure these are appropriately configured for your data type to improve assembly quality.
*   **PacBio Data**: For PacBio reads, MIRA is recommended for CCS and error-corrected CLR data. For raw CLR reads, other assemblers might be more suitable.
*   **Scope Limitations**: Be aware of MIRA's recommended scope for de novo assemblies (haploid organisms up to 20-40 megabases). For larger genomes or specific use cases like RNASeq against eukaryotic genomes with splicing, consider alternative tools.

### Example Workflow (Conceptual)

1.  **Prepare Input Data**: Ensure your sequencing reads are in a supported format (e.g., FASTA, FASTQ).
2.  **Create Configuration File (Optional but Recommended)**: Define assembly parameters, input files, and output settings in a `.cfg` file.
3.  **Run MIRA**: Execute the `mira` command with your configuration.

    ```bash
    # Example: Basic command structure (actual parameters will vary)
    mira my_reads.fasta my_assembly_output -CO my_config.cfg
    ```
    *(Note: The `-CO` flag is a placeholder for a common way to specify a configuration file; consult MIRA documentation for exact syntax.)*

4.  **Analyze Output**: Examine the assembly results, contig statistics, and any generated reports.

## Reference documentation
- [MIRA - The Genome and Transcriptome Assembler and Mapper](./references/github_com_DrMicrobit_mira.md)
- [MIRA - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_mira_overview.md)