---
name: integron_finder
description: Integron Finder is a specialized bioinformatics tool designed to locate integrons—genetic platforms that allow bacteria to acquire and express gene cassettes.
homepage: https://github.com/gem-pasteur/Integron_Finder
---

# integron_finder

## Overview

Integron Finder is a specialized bioinformatics tool designed to locate integrons—genetic platforms that allow bacteria to acquire and express gene cassettes. It identifies essential elements like the integron integrase (intI) and recombination sites (attC) using HMMER and INFERNAL. This skill provides guidance on running the tool, optimizing sensitivity for different genomic contexts, and interpreting the resulting classifications.

## Core Command Line Usage

The basic syntax for running Integron Finder is:

```bash
integron_finder [options] <replicon_file.fasta>
```

### Common Execution Patterns

**Standard Analysis**
For a quick scan of a genome with default parameters:
```bash
integron_finder sequence.fasta
```

**High-Sensitivity Discovery**
To maximize detection of attC sites and integrases, especially in complex or novel sequences:
```bash
integron_finder --local-max --eagle-eyes sequence.fasta
```
*   `--local-max`: Performs a more thorough local detection (slower but more sensitive).
*   `--eagle-eyes`: Uses a more sensitive (but slower) model for detection.

**Circular Genomes**
If the input is a complete circular chromosome or plasmid, use the `--circ` flag to ensure detection across the sequence origin:
```bash
integron_finder --circ sequence.fasta
```

**Functional Annotation**
To annotate the gene cassettes found within the integrons:
```bash
integron_finder --func-annot sequence.fasta
```

## Expert Tips and Best Practices

### Topology Selection
Always specify the topology if known. Use `--circ` for finished chromosomes and `--linear` for contigs or scaffolds. If you have a mix, you can provide a topology file using `--topology-file`.

### Managing Output
*   **Output Directory**: Use `--outdir <dir>` to keep results organized, especially when running multiple samples.
*   **Visualizations**: Use the `--pdf` flag to generate a graphical representation of the detected integrons.
*   **GenBank Output**: Use `--gbk` to produce a GenBank file containing the annotated integron features.

### Performance Tuning
*   **CPU Allocation**: Use `--cpu <number>` to parallelize HMMER and INFERNAL tasks. Note that increasing this above 4 often yields diminishing returns due to the nature of the underlying algorithms.
*   **Distance Threshold**: By default, elements are aggregated if they are within 4000bp. Adjust this with `-dt <bp>` if you suspect unusually large or compact integron structures.

### Understanding Classifications
Integron Finder classifies hits into three main categories:
1.  **Complete Integron**: Contains both an integrase and at least one attC site.
2.  **In0**: Contains an integrase but no attC sites.
3.  **CALIN (Cluster of attC sites Lacking INtegrase)**: A cluster of attC sites without a nearby integrase. By default, a CALIN requires at least 2 attC sites. You can change this threshold with `--calin-threshold <int>`.

## Reference documentation
- [Integron Finder GitHub Repository](./references/github_com_gem-pasteur_Integron_Finder.md)
- [Bioconda Integron Finder Overview](./references/anaconda_org_channels_bioconda_packages_integron_finder_overview.md)