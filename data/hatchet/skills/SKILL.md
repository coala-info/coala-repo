---
name: hatchet
description: HATCHet infers allele and clone-specific copy-number aberrations, clone proportions, and whole-genome duplications from tumor samples. Use when user asks to analyze tumor genomics data, infer copy-number aberrations, or characterize tumor heterogeneity.
homepage: https://github.com/raphael-group/hatchet
metadata:
  docker_image: "quay.io/biocontainers/hatchet:2.1.2--py310h184ae93_0"
---

# hatchet

A bioinformatics tool for inferring allele and clone-specific copy-number aberrations (CNAs), clone proportions, and whole-genome duplications (WGD) from tumor samples.
  Use when analyzing cancer genomics data to understand tumor heterogeneity and evolution, specifically when dealing with copy-number alterations across different tumor clones.
body: |
  ## Overview
  HATCHet is a powerful algorithm designed for the complex task of analyzing tumor genomics. It excels at identifying and characterizing copy-number aberrations (CNAs) at both the allele and clone-specific levels. Furthermore, it can infer the proportions of different tumor clones within a sample and detect whole-genome duplications (WGD). This tool is particularly useful when you need to understand the genetic landscape of a tumor, track its evolution, and identify distinct subclones.

  ## Usage Instructions

  HATCHet is primarily a command-line tool. The core functionality involves processing tumor samples to infer CNAs and clone structures.

  ### Core Workflow

  The general workflow involves providing HATCHet with one or more bulk-tumor samples. The tool then analyzes these samples to infer the desired genomic features.

  ### Key Commands and Options

  While specific command structures can vary based on the exact analysis, common patterns involve specifying input files and output directories.

  *   **Input Data**: HATCHet typically requires input files that represent the genomic data from tumor samples. These might include variant calls or other relevant genomic information. The exact format will depend on the specific HATCHet version and its requirements.
  *   **Output**: The tool generates various output files detailing the inferred CNAs, clone proportions, and WGD status. It's crucial to specify an output directory to store these results.

  ### Expert Tips

  *   **Multiple Samples**: For more robust inference, especially for complex tumors with multiple subclones, providing multiple bulk-tumor samples from the same patient is highly recommended. HATCHet leverages the relationships between clones across samples.
  *   **Documentation**: Always refer to the official HATCHet documentation for the most up-to-date and detailed command-line arguments, input file formats, and advanced options. The GitHub repository and associated documentation are excellent resources.
  *   **Dependencies**: Ensure all necessary dependencies, such as Gurobi (for optimization), are correctly installed and accessible in your environment. The installation instructions on bioconda and the GitHub repository provide guidance on this.

  ## Reference documentation
  - [HATCHet Overview](https://anaconda.org/bioconda/hatchet)
  - [HATCHet GitHub Repository](https://github.com/raphael-group/hatchet)
  - [HATCHet Documentation](https://raphael-group.github.io/hatchet/)