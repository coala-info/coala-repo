---
name: cvbio
description: cvbio provides specialized bioinformatics utilities for processing genomic data, including multi-species alignment disambiguation and automated IGV session control. Use when user asks to disambiguate reads mapped to multiple references, control IGV from the command line, fetch Ensembl GTF files, or update contig names in delimited data.
homepage: https://github.com/clintval/cvbio
---


# cvbio

## Overview

The `cvbio` toolset provides specialized bioinformatics utilities designed for high-performance genomic data processing. Its primary strengths lie in "Disambiguate," which resolves the true origin of reads in multi-species alignment scenarios (like Xenografts), and "IgvBoss," which automates the Integrative Genomics Viewer (IGV) for rapid locus inspection. It is particularly useful for researchers working with complex experimental designs where standard alignment pipelines may produce ambiguous results across different reference genomes.

## Command Line Usage

### Disambiguating Multi-Reference Alignments

Use the `Disambiguate` tool when you have sequencing data (BWA or STAR produced) aligned to two or more different references and need to determine the most likely source for each template.

*   **Basic Pattern**:
    `cvbio Disambiguate -i <bam1> <bam2> -p <output_prefix>`

*   **Naming References**:
    Use the `-n` flag to provide human-readable names for the output files corresponding to each input BAM.
    `cvbio Disambiguate -i sample.human.bam sample.mouse.bam -p results/sample -n hg38 mm10`

*   **Output Structure**:
    The tool generates:
    1.  Reference-specific BAMs (e.g., `sample.hg38.bam`).
    2.  An `ambiguous-alignments/` directory containing reads that could not be confidently assigned to a single source.

*   **Best Practices**:
    *   **Sort Order**: While the tool accepts any sort order, it performs an internal sort to `queryname`. Providing queryname-sorted BAMs initially will improve performance.
    *   **Input Types**: Paired-end data provides the highest discriminatory power, but the tool also supports fragment and mixed pairing data.

### Controlling IGV with IgvBoss

`IgvBoss` allows you to manipulate an IGV session directly from the terminal, which is ideal for scripted inspections or high-throughput visualization workflows.

*   **Prerequisites**:
    Enable "Remote Control" in IGV (Preferences > Advanced > Allow HTTPS connections).

*   **Common Operations**:
    *   **Navigate to Loci**: Provide one or more locus identifiers. Multiple identifiers trigger a split-window view.
    *   **Startup Logic**: IgvBoss attempts to connect to a running instance first. If none exists, it searches for an IGV JAR, a Mac Application, or an `igv` executable on the system path.
    *   **Automatic Teardown**: Use `--close-on-exit` to shut down the IGV application once your command or script finishes.



## Subcommands

| Command | Description |
|---------|-------------|
| Disambiguate | Disambiguate reads that were mapped to multiple references. |
| FetchEnsemblGtf | Fetch a GTF file from the Ensembl web server. |
| IgvBoss | Take control of your IGV session from end-to-end. |
| UpdateContigNames | Update contig names in delimited data using a name mapping table. |

## Reference documentation

- [cvbio Overview and Disambiguate Documentation](./references/github_com_clintval_cvbio_blob_master_README.md)
- [IgvBoss and Tool Features](./references/github_com_clintval_cvbio.md)