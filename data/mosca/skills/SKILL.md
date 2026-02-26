---
name: mosca
description: "MOSCA is a pipeline for integrated metagenomics, metatranscriptomics, and metaproteomics data analysis. Use when user asks to perform meta-omics analyses, including data preprocessing, assembly, gene calling, annotation, expression quantification, and differential expression analysis."
homepage: https://github.com/iquasere/MOSCA
---


# mosca

MOSCA (Meta-Omics Software for Community Analysis) is a pipeline for integrated metagenomics, metatranscriptomics, and metaproteomics data analysis.
  Use this skill when Claude needs to perform complex meta-omics analyses, including data preprocessing, assembly, gene calling, annotation, expression quantification, and differential expression analysis.
  This skill is specifically for users who need to run the MOSCA pipeline from the command line.
body: |
  ## Overview
  MOSCA is a comprehensive bioinformatics pipeline designed for the integrated analysis of meta-omics data, encompassing metagenomics (MG), metatranscriptomics (MT), and metaproteomics (MP). It automates a multi-step workflow, starting from raw sequencing data and progressing through assembly, gene prediction, functional annotation, and differential expression analysis. This skill focuses on providing guidance for the command-line usage of the MOSCA pipeline.

  ## Usage Instructions

  MOSCA is typically run using a workflow management system like Snakemake. The primary interaction will involve configuring and executing the pipeline via its command-line interface.

  ### Core Workflow Steps:

  1.  **Data Preprocessing**: Removal of adapters and quality trimming of raw sequencing reads.
  2.  **Metagenomics (MG)**:
      *   Assembly of reads into contigs.
      *   Gene calling on contigs.
      *   Homology-based annotation (UniProt) and domain-based annotation (COG).
  3.  **Metatranscriptomics (MT)**:
      *   Alignment of MT reads to the generated ORFs for gene expression quantification.
  4.  **Metaproteomics (MP)**:
      *   Peptide-to-Spectrum Matching (PSM) using annotated ORFs as a reference.
  5.  **Downstream Analysis**:
      *   Differential expression analysis for MT and MP.
      *   Metabolic pathway analysis (KEGG Pathways).

  ### Command-Line Execution (General Pattern):

  MOSCA is typically executed via Snakemake. The exact command will depend on your configuration and the specific analysis you wish to perform. A general pattern might look like this:

  ```bash
  snakemake --snakefile /path/to/MOSCA/workflow/Snakefile --configfile /path/to/your/config.yaml [target_rule]
  ```

  *   `--snakefile`: Specifies the path to the main Snakemake workflow file within the MOSCA installation.
  *   `--configfile`: Points to your custom configuration file where input data, parameters, and output directories are defined.
  *   `[target_rule]`: Optionally, you can specify a particular rule (e.g., `all`, `annotate`, `differential_expression`) to execute only that part of the pipeline.

  ### Configuration File (`config.yaml`):

  The `config.yaml` file is crucial for defining your analysis. It typically includes:

  *   Paths to input raw sequencing data (FASTQ files).
  *   Paths to reference databases (e.g., UniProt, COG, KEGG).
  *   Parameters for various tools used within the pipeline (e.g., assembly parameters, annotation thresholds).
  *   Output directory for results.

  **Example Snippet (Illustrative - consult MOSCA documentation for exact structure):**

  ```yaml
  input_dir: "/path/to/your/raw_data"
  output_dir: "/path/to/your/results"
  databases:
    uniprot: "/path/to/uniprot_database"
    cog: "/path/to/cog_database"
    kegg: "/path/to/kegg_pathways"

  # Metagenomics parameters
  assembly:
    assembler: "megahit" # or "spades"
    min_contig_length: 200

  # Metatranscriptomics parameters
  expression_quantification:
    method: "kallisto" # or "salmon"

  # Metaproteomics parameters
  psm:
    database: "uniprot"
  ```

  ### Expert Tips:

  *   **Consult the Wiki**: The official MOSCA wiki (`https://github.com/iquasere/MOSCA/wiki`) is the definitive resource for detailed installation, configuration, and usage instructions. Always refer to it for the most up-to-date information.
  *   **Parameter Tuning**: MOSCA integrates many bioinformatics tools. Understanding the parameters of these underlying tools (e.g., assemblers like MEGAHIT or SPAdes, annotators) can significantly impact the quality and relevance of your results.
  *   **Resource Management**: Meta-omics analyses are computationally intensive. Ensure you have adequate CPU, memory, and disk space. Snakemake allows for specifying resources per job, which is highly recommended for efficient execution on clusters.
  *   **Database Management**: Keep your reference databases (UniProt, COG, KEGG) up-to-date for the most accurate annotations.
  *   **Reproducibility**: Use specific versions of MOSCA and its dependencies (e.g., via Conda environments) to ensure your analyses are reproducible. The Bioconda package is a good starting point for environment setup.
  *   **Debugging**: If you encounter errors, examine the Snakemake logs carefully. They often provide detailed information about which underlying tool failed and why. The `[target_rule]` can be useful for running specific parts of the pipeline to isolate issues.

  ## Reference documentation
  - [MOSCA Wiki](https://github.com/iquasere/MOSCA/wiki)
  - [MOSCA GitHub Repository](https://github.com/iquasere/MOSCA)