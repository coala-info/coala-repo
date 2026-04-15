---
name: pmga
description: This tool annotates genomes of Neisseria species and Haemophilus influenzae. Use when user asks to annotate bacterial genomes, identify MLST alleles, or annotate serogrouping/serotyping genes.
homepage: https://github.com/CDCgov/BMGAP
metadata:
  docker_image: "quay.io/biocontainers/pmga:3.0.2--hdfd78af_0"
---

# pmga

yaml
name: pmga
description: |
  Command-line tool for annotating genomes of Neisseria species and Haemophilus influenzae.
  Use when you need to perform genome annotation for these specific bacterial species,
  especially for tasks related to MLST allele identification and serogrouping/serotyping gene annotation.
  This skill is for users who have genomic data and require specialized annotation for
  bacterial meningitis pathogens.
```

## Overview

The `pmga` tool is a command-line utility designed for the annotation of bacterial genomes, specifically focusing on Neisseria species and *Haemophilus influenzae*. It leverages PubMLST databases to identify Multi-Locus Sequence Types (MLST) and annotate serogrouping/serotyping genes. This skill is intended for users who need to process and analyze genomic data for these pathogens, often in the context of public health research and surveillance.

## Usage and Best Practices

The `pmga` tool is part of the Bacterial Meningitis Genome Analysis Platform (BMGAP). While specific command-line arguments and detailed usage patterns are not extensively documented in the provided materials, the general workflow involves providing input genomic data and specifying the target species.

### Core Functionality

*   **MLST Identification**: Identifies MLST alleles for *Neisseria* spp. and *Haemophilus influenzae* using PubMLST references.
*   **Serogrouping/Serotyping Gene Annotation**: Identifies and annotates genes responsible for serogrouping and serotyping.

### General Command-Line Usage (Inferred)

Based on its description as a command-line tool, `pmga` is likely invoked with the following structure:

```bash
pmga [options] <input_genome_file>
```

**Key considerations for usage:**

*   **Input Data**: Ensure your input is in a compatible format for genome analysis (e.g., FASTA).
*   **Species Specificity**: The tool is designed for Neisseria species and *Haemophilus influenzae*. Explicitly specifying the species might be a required or optional argument.
*   **Output**: The tool will likely generate annotated files or reports. The exact output format and location will depend on the specific command-line options used.

### Expert Tips

*   **Consult BMGAP Documentation**: For the most accurate and up-to-date command-line options, parameters, and detailed usage examples, refer to the official BMGAP documentation or the project's GitHub repository. The provided information suggests that `pmga` is a component of a larger platform.
*   **Environment Setup**: Ensure that `pmga` is correctly installed and accessible in your environment. The Anaconda Cloud (bioconda channel) is a common distribution method.

## Reference documentation

- [Overview of BMGAP and PMGA](./references/github_com_CDCgov_BMGAP.md)