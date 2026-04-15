---
name: rapclust
description: RapClust clusters de novo transcriptome contigs into gene-level groups using fragment equivalence classes from RNA-seq quantification. Use when user asks to cluster transcripts into genes, generate a transcript-to-gene mapping for tximport, or group de novo assembly contigs based on mapping ambiguity.
homepage: https://github.com/COMBINE-lab/RapClust
metadata:
  docker_image: "quay.io/biocontainers/rapclust:0.1.2--py35_0"
---

# rapclust

## Overview

RapClust is a specialized tool designed to cluster de novo transcriptome contigs into gene-level groups. Unlike traditional methods that rely on sequence similarity alone, RapClust utilizes the fragment equivalence classes generated during RNA-seq quantification. By analyzing how reads are shared across different contigs and conditions, it builds a mapping ambiguity graph and applies the MCL (Markov Cluster) algorithm to define clusters. This process is essential for downstream differential expression analysis, as it provides the "transcript-to-gene" mapping required by tools like tximport to aggregate transcript-level estimates into more robust gene-level counts.

## Usage Guidelines

### 1. Upstream Quantification Requirements
RapClust does not process raw reads directly. It requires specific output from Sailfish or Salmon.
- **Mandatory Flag**: You must run Sailfish or Salmon with the `--dumpEq` option. This forces the quantifier to output the fragment equivalence classes necessary for clustering.
- **Consistency**: Ensure all samples in an experiment are quantified against the same de novo assembly (contig set).

### 2. Configuration Requirements
The tool is driven by a configuration file. While the file format is YAML, the core requirements are:
- **Conditions**: A list of the experimental groups (e.g., Control, Treatment).
- **Samples**: A mapping where each condition points to a list of the directory paths containing the quantification results for those specific replicates.
- **Output Directory**: A designated path where RapClust will store the resulting clusters and network files.

### 3. Command Line Execution
The primary interface is straightforward:
`RapClust --config <path_to_config>`

### 4. Interpreting Results
After execution, the output directory will contain several files. Focus on these for downstream analysis:
- **mag.flat.clust**: This is the primary output. It provides a two-column mapping of transcripts to their assigned clusters. This file is formatted for direct compatibility with the `tximport` R package.
- **mag.clust**: Contains the raw clustering results.
- **mag.filt.net**: The filtered mapping ambiguity graph used for the final clustering step, useful for troubleshooting or deep exploration of specific loci.

## Best Practices and Tips
- **Pseudo-conditions**: If your experiment has more than two conditions, RapClust can still be used by grouping samples into "pseudo-conditions" based on a major biological factor. This helps the tool disambiguate isoforms and orthologous genes effectively.
- **Environment**: RapClust relies on the MCL clustering tool being available in your system path.
- **Memory and Speed**: Because it operates on equivalence classes rather than raw alignments, RapClust is extremely fast and typically completes in minutes even for large datasets.
- **De novo Assembly**: While Trinity is a common upstream assembler, RapClust is agnostic to the assembly tool used, provided the contigs are used as the reference for quantification.

## Reference documentation
- [RapClust README](./references/github_com_COMBINE-lab_RapClust.md)
- [RapClust Wiki - Example Pipeline](./references/github_com_COMBINE-lab_RapClust_wiki.md)