---
name: ngs-disambiguate
description: The `ngs-disambiguate` tool provides a deterministic algorithm for resolving the species of origin for reads in mixed-species sequencing experiments.
homepage: https://github.com/AstraZeneca-NGS/disambiguate
---

# ngs-disambiguate

## Overview

The `ngs-disambiguate` tool provides a deterministic algorithm for resolving the species of origin for reads in mixed-species sequencing experiments. It operates by comparing alignment quality metrics (such as alignment scores or edit distances) between two BAM files generated from the same library aligned to different reference genomes. This is a critical step in PDX workflows to ensure that downstream analysis is performed only on the relevant species' reads (e.g., tumor-specific reads vs. host-stroma reads).

## Usage Guidelines

### Aligner Compatibility
The tool supports specific alignment algorithms. You must specify the aligner used during the alignment phase to ensure the correct tags are parsed:
- **bwa**: Uses the `AS` (Alignment Score) tag.
- **tophat**: Uses the `AS` tag.
- **hisat2**: Uses the `AS` tag.
- **star**: Uses the `NM` (Edit Distance) tag.

### Implementation Differences
There are two versions of the tool: Python (`disambiguate.py`) and C++.
- **Python Version**: More flexible; can perform internal natural name sorting of reads if the input BAMs are coordinate-sorted.
- **C++ Version**: Significantly faster but more rigid; input BAM files **must** be natural name sorted before running the tool.

### Common CLI Patterns

#### Python Implementation
To run the Python version with internal sorting:
```bash
python disambiguate.py -a <aligner> -s <sample_prefix> <species1.bam> <species2.bam>
```

#### C++ Implementation
To run the pre-compiled binary (requires name-sorted inputs):
```bash
disambiguate -s <sample_prefix> <species1_namesorted.bam> <species2_namesorted.bam>
```

### Critical Requirements and Best Practices

1.  **STAR Alignments**: When using STAR, you must ensure the `NM` tag is present in the output BAM. For the C++ version, this is a hard requirement.
2.  **Name Sorting**: If using the C++ version or wanting to speed up the Python version, pre-sort your BAM files by name using samtools:
    ```bash
    samtools sort -n -o sample_species1_namesorted.bam sample_species1.bam
    ```
3.  **BWA ALT-alignments**: The tool is designed to ignore missing `AS` tags that can result from ALT-alignments in newer reference genomes (like hg38), preventing crashes during processing.
4.  **Output Interpretation**: The tool generates three BAM files:
    - `<prefix>.disambiguatedSpeciesA.bam`: Reads uniquely assigned to Species A.
    - `<prefix>.disambiguatedSpeciesB.bam`: Reads uniquely assigned to Species B.
    - `<prefix>.ambiguous.bam`: Reads that could not be definitively assigned.
    A summary text file is also produced containing the final counts for each category.

## Reference documentation
- [ngs-disambiguate Overview](./references/anaconda_org_channels_bioconda_packages_ngs-disambiguate_overview.md)
- [AstraZeneca-NGS/disambiguate README](./references/github_com_AstraZeneca-NGS_disambiguate.md)