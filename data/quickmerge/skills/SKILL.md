---
name: quickmerge
description: Quickmerge is a meta-assembler that improves genome assembly contiguity by merging two different assemblies into a single, more contiguous result. Use when user asks to merge genome assemblies, increase assembly N50, or bridge gaps in long-read sequencing data using a reference assembly.
homepage: https://github.com/mahulchak/quickmerge
metadata:
  docker_image: "quay.io/biocontainers/quickmerge:0.3--pl5321h503566f_6"
---

# quickmerge

## Overview
Quickmerge is a meta-assembler designed to increase the contiguity of genome assemblies generated from long-molecule sequencing data. It works by using one assembly (the reference) to bridge gaps and join contigs in another assembly (the query). This process leverages the complementary strengths of different assembly algorithms or data types (like combining Illumina-hybrid and PacBio-only assemblies) to produce a final result with significantly higher N50 values without sacrificing accuracy.

## Installation
The most reliable way to install quickmerge and its dependencies (like MUMmer) is via Bioconda:
```bash
conda install -c bioconda quickmerge
```

## Core Workflows

### 1. Using the Python Wrapper (Recommended)
The `merge_wrapper.py` script automates the alignment (nucmer), filtering (delta-filter), and merging steps.

```bash
merge_wrapper.py <hybrid_assembly.fasta> <self_assembly.fasta>
```

**Key Wrapper Options:**
- `-l <int>`: Anchor length cutoff (Required). A good starting point is the N50 of the self-assembly.
- `-v`: Required if using MUMmer v4.
- `-t <int>`: Number of threads (requires MUMmer v4+).
- `-pre <string>`: Prefix for output files.

### 2. Manual Execution (Fine-grained Control)
If the wrapper does not meet specific needs, run the three-step pipeline manually:

1. **Align assemblies:**
   ```bash
   nucmer -l 100 -prefix out self_assembly.fasta hybrid_assembly.fasta
   ```
2. **Filter alignments:**
   Filter for syntenic regions and remove repeats. A 10kb length filter (`-l 10000`) is recommended for repeat-rich genomes.
   ```bash
   delta-filter -r -q -l 10000 out.delta > out.rq.delta
   ```
3. **Merge:**
   ```bash
   quickmerge -d out.rq.delta -q hybrid_assembly.fasta -r self_assembly.fasta -hco 5.0 -c 1.5 -l 2000000 -ml 5000 -p merged_output
   ```

## Parameter Tuning & Best Practices

### Selecting Query (-q) vs. Reference (-r)
- **The Rule:** The merged assembly's size and completeness (BUSCO/CEGMA) will closely resemble the **Query** assembly. The **Reference** assembly is used primarily to provide bridging sequences.
- **Strategy:** If Assembly A has better completeness but Assembly B has better contiguity, use Assembly A as the Query and Assembly B as the Reference.

### Critical Parameters
- **Length Cutoff (`-l`)**: This is the most important parameter. Set this to the **N50** of your reference assembly. Setting it too low increases mis-joins; setting it too high limits merging potential.
- **Overlap Cutoffs (`-hco` and `-c`)**: Default values are 5.0 and 1.5. Increase these (e.g., 10.0 and 3.0) for higher stringency if you suspect mis-joins.
- **Minimum Alignment Length (`-ml`)**: Default is 5000. Increase this for repeat-heavy genomes to ensure merges are based on unique sequences.

### Two-Round Merging Strategy
If a single run doesn't yield the desired N50 and genome size:
1. Run Merge 1: Assembly A (Query) + Assembly B (Ref) -> Result 1.
2. Run Merge 2: Assembly B (Query) + Assembly A (Ref) -> Result 2.
3. Identify the most contiguous result (e.g., Result 2).
4. Run a final merge using the most "correct" original assembly (e.g., Assembly A) as Query and the most contiguous result (Result 2) as Reference.
   *Note: If running manually, rename contigs in the intermediate assembly (e.g., `sed -i 's/^>/>N_/g' result2.fasta`) to avoid header conflicts.*

## Expert Tips
- **Header Cleanup:** Ensure FASTA headers do not contain white spaces. While newer versions of the script handle this, it is safer to clean headers beforehand.
- **Contig Breaking:** Before merging, identify major inversions or translocations in your component assemblies and break the contigs at those boundaries to prevent the merger from propagating errors.
- **Polishing:** Always perform assembly polishing (e.g., Pilon, Racon, or Medaka) **after** merging, as the merging process can introduce small indels at splice sites.
- **Validation:** Use `mummerplot` to create a dot plot of the merged assembly against the input assemblies to visualize the improvements and check for chimeric joins.

## Reference documentation
- [Quickmerge GitHub Repository](./references/github_com_mahulchak_quickmerge.md)
- [Quickmerge Wiki - Usage Guide](./references/github_com_mahulchak_quickmerge_wiki.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_quickmerge_overview.md)