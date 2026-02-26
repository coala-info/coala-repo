---
name: gmcloser
description: "GMcloser is a bioinformatics tool designed to fill and close gaps in scaffold assemblies. Use when user asks to close gaps in genome assemblies."
homepage: https://sourceforge.net/projects/gmcloser/
---


# gmcloser

gmcloser/
├── SKILL.md
└── references/
    ├── anaconda_org_channels_bioconda_packages_gmcloser_overview.md
    ├── sourceforge_net_projects_gmcloser.md
    └── sourceforge_net_projects_gmcloser_files.md

---
name: gmcloser
description: |
  GMcloser is a bioinformatics tool designed to fill and close gaps in scaffold assemblies, particularly those generated from de novo assembly of whole genomes using next-generation sequencing (NGS) reads.
  Use this skill when you need to improve the contiguity and completeness of genome assemblies by addressing gaps. This is especially relevant when working with draft assemblies that have been generated using NGS data.
---
## Overview

GMcloser is a specialized bioinformatics tool designed to enhance genome assemblies by filling gaps within scaffold sequences. It leverages preassembled contig sets or long read sets, along with paired-end (PE) reads and a likelihood-based algorithm, to accurately and efficiently close these assembly gaps. The tool can be applied iteratively with different contig sets for improved results. An accompanying tool, GMvalue, is also available for identifying and correcting misassembly sites within contigs and scaffolds.

## Usage Instructions

GMcloser is a command-line tool. The primary function is to close gaps in scaffold assemblies.

### Core Functionality: Gap Closure

The main purpose of GMcloser is to take an input scaffold file and use provided contig or long read sets to fill in the gaps.

**Basic command structure:**

```bash
gmcloser -s <scaffold_file> -c <contig_file_or_list> -o <output_file> [options]
```

**Key Arguments:**

*   `-s <scaffold_file>`: Path to the input scaffold file (e.g., in FASTA format). This file contains the sequences with gaps that need to be closed.
*   `-c <contig_file_or_list>`: Path to a file containing contigs, or a comma-separated list of contig files. These are the sequences used to bridge the gaps. GMcloser can also accept long read sets.
*   `-o <output_file>`: Path for the output file, which will contain the scaffold sequences with gaps closed.

**Important Options and Considerations:**

*   **Iterative Gap Closure:** For increased efficiency and accuracy, GMcloser can be run multiple times with different contig sets.
    ```bash
    # First pass with contigs_set1
    gmcloser -s scaffolds.fasta -c contigs_set1.fasta -o scaffolds_pass1.fasta

    # Second pass using the output of the first pass as input
    gmcloser -s scaffolds_pass1.fasta -c contigs_set2.fasta -o scaffolds_final.fasta
    ```
*   **GMvalue for Misassembly Detection:** The GMvalue tool is provided to identify and potentially correct misassembly sites. It can define misassembly categories and is useful for large genomes.
    *   To generate error-free assemblies by splitting or correcting misassembles using GMvalue, use the `-e` option. Consult the GMvalue documentation for specific usage.

### Best Practices and Expert Tips:

*   **Input File Formats:** Ensure your scaffold and contig files are in a compatible format, typically FASTA.
*   **Contig Set Quality:** The quality and completeness of the contig sets used for gap closure significantly impact the results. Using multiple, diverse contig sets can improve outcomes.
*   **Paired-End (PE) Reads:** GMcloser utilizes PE reads and a likelihood-based algorithm. Ensure your input data is appropriately prepared.
*   **Output Analysis:** After running GMcloser, carefully analyze the output file for improved contiguity and completeness. Tools like QUAST can be used for assembly quality assessment.
*   **GMvalue Integration:** For critical assemblies, consider using GMvalue to identify and rectify potential misassemblies in the output scaffolds.

## Reference documentation
- [GMcloser Overview](./references/anaconda_org_channels_bioconda_packages_gmcloser_overview.md)
- [GMcloser Project Page](./references/sourceforge_net_projects_gmcloser.md)
- [GMcloser Files](./references/sourceforge_net_projects_gmcloser_files.md)