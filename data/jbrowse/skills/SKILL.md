---
name: jbrowse
description: JBrowse is a high-performance genome browser suite used for visualizing genomic data through linear, circular, and dotplot views. Use when user asks to deploy a genome browser, visualize sequencing tracks, or analyze comparative genomics and synteny.
homepage: https://jbrowse.org/
---


# jbrowse

## Overview
This skill provides guidance for deploying JBrowse, a high-performance genome browser suite. It covers the transition from the legacy JBrowse 1 (often managed via Conda) to the modern, modular JBrowse 2. JBrowse 2 is designed for complex comparative genomics, supporting linear, circular, and dotplot views, as well as integrated phylogenetic trees and protein structural analysis.

## Installation and Setup
- **JBrowse 1 (Legacy):** Best installed via Conda for quick local instances.
  ```bash
  conda install -c bioconda jbrowse
  ```
- **JBrowse 2 (Modern):** Primarily used via the CLI tools for web or desktop deployment. Use the `@jbrowse/cli` (via npm/npx) to manage JBrowse 2 instances.

## Core CLI Patterns (JBrowse 2)
When setting up a JBrowse 2 session, use the following command patterns:

- **Initialize a new directory:**
  ```bash
  jbrowse create my-genome-browser
  ```
- **Add a Genome Assembly:**
  ```bash
  jbrowse add-assembly genome.fasta --out /path/to/jbrowse2/ --load copy
  ```
- **Add Tracks:**
  - **BAM/CRAM:** Ensure files are indexed (.bai/.crai).
  - **VCF/GFF/BED:** Must be tabix-indexed (.tbi).
  - **BigWig/BigBed:** Supported natively.
  ```bash
  jbrowse add-track data.bam --assembly my-genome --out /path/to/jbrowse2/
  ```

## Expert Tips
- **Data Indexing:** JBrowse requires indexed formats for performance. Always ensure `samtools index` (for BAM) or `tabix` (for VCF/GFF) has been run before adding tracks.
- **Structural Variants:** For SV visualization, JBrowse 2 is preferred over JBrowse 1 as it supports "breakend" (BND) notations in VCFs and provides integrated split-read views.
- **Synteny Views:** To visualize synteny between two genomes, use the `dotplot` or `linear synteny` view types, which require a mapping file (e.g., PAF or outfmt6).
- **Plugin System:** If a specific data format is not supported natively, check the JBrowse plugin store. Plugins can be added via the CLI:
  ```bash
  jbrowse add-plugin name-of-plugin
  ```

## Reference documentation
- [JBrowse 2 Overview and Features](./references/jbrowse_org_jb2.md)
- [Bioconda JBrowse 1 Installation](./references/anaconda_org_channels_bioconda_packages_jbrowse_overview.md)