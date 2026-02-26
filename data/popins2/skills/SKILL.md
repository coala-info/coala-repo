---
name: popins2
description: "PopIns2 discovers and genotypes non-reference sequence insertions across population-scale genomic datasets. Use when user asks to assemble unmapped reads, merge contigs into a de Bruijn graph, anchor insertions to a reference genome, or genotype discovered sequences."
homepage: https://github.com/kehrlab/PopIns2
---


# popins2

## Overview

PopIns2 is a specialized bioinformatics suite designed to discover and genotype sequence insertions that are absent from a reference genome. It is optimized for population-scale studies, meaning it can process dozens or hundreds of samples together. The tool works by extracting reads that do not align well to the reference, assembling them into contigs per sample, and then merging these contigs into a "colored compacted de Bruijn Graph" (ccdbg). This graph allows the tool to identify shared insertion sequences (supercontigs) across the population, which are then anchored back to the reference genome to determine their precise location and genotype.

## Core Workflow and CLI Patterns

PopIns2 is executed as a series of submodules. For a population-scale project, you must run these commands in the following sequence:

### 1. Assembly (Per Sample)
Extracts unmapped or low-quality reads and assembles them into initial contigs.
```bash
# The BAM file must be indexed by 'bwa index'
popins2 assemble --sample <SAMPLE_ID> <SAMPLE.bam>
```
*   **Tip**: If you have potential contamination (e.g., human samples with possible viral DNA), use the optional reference FASTA to filter out reads before assembly.

### 2. Merging (Population Level)
Combines contigs from all samples into a global graph to produce supercontigs.
```bash
# -r: source directory containing all sample assembly folders
# -d and -i: highly recommended for graph simplification
popins2 merge -r /path/to/project_dir -di
```

### 3. Contig Mapping (Per Sample)
Maps the original unmapped reads back to the newly generated supercontigs.
```bash
popins2 contigmap <SAMPLE_ID>
```

### 4. Placement (Hybrid Population/Sample Level)
A three-step process to anchor supercontigs to the reference genome.
```bash
# Step A: Collect potential anchor locations across all samples
popins2 place-refalign

# Step B: Perform split-alignment for each sample
popins2 place-splitalign <SAMPLE_ID>

# Step C: Combine results into a final VCF
popins2 place-finish
```

### 5. Genotyping (Per Sample)
Determines the genotype (0/0, 0/1, 1/1) for each discovered insertion in each sample.
```bash
popins2 genotype <SAMPLE_ID>
```

## Best Practices and Expert Tips

*   **BAM Indexing**: Unlike many tools that require a `.bai` index, PopIns2 specifically requires the BAM file to be indexed by `bwa index` for the `assemble` command.
*   **Dependency Management**: If `bwa`, `samtools`, or `sickle` are not in your system PATH, you must edit the `popins2.config` file in the installation directory to provide absolute paths before running the tool.
*   **Bifrost Compatibility**: PopIns2 relies on the Bifrost library. Ensure your Bifrost installation was compiled with `MAX_KMER_SIZE=64`. Note that Bifrost versions released after April 28, 2022, may have API incompatibilities; using a version prior to commit `703be6d` is recommended for stability.
*   **Project Structure**: Maintain a consistent directory structure where each sample has its own subdirectory. The `merge` command expects to find `assembly_final.contigs.fa` within these subdirectories.
*   **Memory and Scaling**: The `merge` step is the most resource-intensive. Using the `-di` flags is critical for reducing graph complexity and memory usage in large cohorts.

## Reference documentation
- [PopIns2 GitHub Repository](./references/github_com_kehrlab_PopIns2.md)
- [PopIns2 Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_popins2_overview.md)