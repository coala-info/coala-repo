---
name: tiny-count
description: tiny-count is a specialized bioinformatic utility designed for the high-precision quantification of small RNA (sRNA) sequencing data.
homepage: https://github.com/MontgomeryLab/tinyRNA
---

# tiny-count

## Overview
tiny-count is a specialized bioinformatic utility designed for the high-precision quantification of small RNA (sRNA) sequencing data. While it functions as the engine for the broader tinyRNA pipeline, it can be used as a standalone tool to resolve complex read-to-feature assignments. Its primary strength lies in its hierarchical logic, which allows researchers to define specific rules for how reads should be categorized when they overlap with multiple genomic features, ensuring that sRNA classes are quantified according to biological priority.

## Installation and Environment
The tool is best managed via Conda to ensure all dependencies (like Pysam and Cython extensions) are correctly linked.

```bash
# Standalone installation
conda install -c bioconda -c conda-forge tiny-count

# Activation (if installed via the full tinyRNA suite)
conda activate tinyrna
```

## Core Functional Logic
When using tiny-count, the tool evaluates reads against reference annotations using several criteria:
- **Hierarchical Assignment**: Reads are assigned to features based on a user-defined order of operations.
- **Positional Information**: Precise mapping based on the extent of feature overlap.
- **Sequence Characteristics**: Filtering or classification based on the 5' nucleotide and the specific length of the sRNA read.
- **Strandedness**: Strict or relaxed strand-specific counting.

## Input Requirements
To ensure successful execution, input files must meet specific formatting standards:

### 1. Reference Annotations (GFF3 / GFF2 / GTF)
- **Column 9 Attributes**: Every feature must contain an `ID`, `gene_id`, or `Parent` tag.
- **Discontinuous Features**: Must be linked by a shared `ID` or a `Parent` tag pointing to the logical parent ID.
- **Attribute Lists**: Values containing commas are treated as lists.

### 2. Reference Genome (FASTA)
- **Chromosome Identifiers**: Must match the identifiers used in the annotation file exactly (case-sensitive).

### 3. Sequencing Data
- **Format**: FASTQ or BAM (depending on whether running the standalone counter or the wrapper).
- **Pre-processing**: Files must be demultiplexed before processing.

## CLI Usage Patterns and Best Practices

### Standalone Execution
While often wrapped in the `tiny` command, `tiny-count` can be invoked directly for specific counting tasks. 

### Handling Mismatches and Edits
Recent updates (v1.5.0+) introduced advanced mismatch handling. Use these when analyzing RNA editing events or non-templated additions:
- **Mismatch Patterns**: Use the `--mismatch_pattern` argument to specify how the tool should evaluate alignments with mismatches.
- **Edit Match Classes**: The tool supports specialized classes like `AdarEditMatch` and `TutEditMatch` for identifying specific editing signatures during the counting process.

### Performance Optimization
- **Apple Silicon Support**: If working on macOS with M1/M2/M3 chips, ensure you are using version 1.5.0 or later to avoid installation and execution errors related to architecture-specific dependencies.
- **Resuming Analyses**: When fine-tuning counting parameters, use the `recount` functionality to skip compute-heavy alignment steps and focus only on the quantification logic.

## Expert Tips
- **Feature Selection Rules**: When defining your features sheet, place the most specific or biologically significant features (e.g., miRNAs) higher in the hierarchy than broad categories (e.g., intergenic repeats) to prevent "masking" of high-interest reads.
- **CIGAR String Validation**: tiny-count performs sanity checks on CIGAR strings. Ensure your aligner does not produce incompatible operators like soft/hard clipping or skipping if the specific counting mode forbids them.
- **MD Tags**: For detailed mismatch analysis, ensure your input BAM files contain the `MD` tag, as `tiny-count` utilizes this for evaluating edit patterns.

## Reference documentation
- [tiny-count Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_tiny-count_overview.md)
- [tinyRNA GitHub Repository](./references/github_com_MontgomeryLab_tinyRNA.md)