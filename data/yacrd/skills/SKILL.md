---
name: yacrd
description: yacrd (Yet Another Chimeric Read Detector) is a specialized tool for identifying problematic sequences in long-read datasets.
homepage: https://github.com/natir/yacrd
---

# yacrd

## Overview

yacrd (Yet Another Chimeric Read Detector) is a specialized tool for identifying problematic sequences in long-read datasets. It operates by analyzing the pile-up coverage of reads based on all-against-all mapping results. By identifying regions with low or zero coverage, yacrd classifies reads as "Chimeric" (internal coverage gaps), "NotCovered" (mostly low coverage), or "NotBad" (sufficiently covered). This skill provides the necessary command-line patterns to detect these reads and perform post-detection operations like filtering, splitting, or scrubbing to improve the quality of downstream genome assembly.

## Core Workflow

The standard yacrd workflow involves two main steps: generating an overlap file with a mapper (typically minimap2) and then running yacrd to analyze those overlaps.

### 1. Generate Overlaps
Use minimap2 to perform all-against-all mapping. Note that yacrd is optimized for minimap2 versions <= v2.18.

```bash
# For Nanopore
minimap2 -x ava-ont -g 500 reads.fq reads.fq > overlap.paf

# For PacBio
minimap2 -x ava-pb reads.fq reads.fq > overlap.paf
```

### 2. Detect Chimeras
Run yacrd on the resulting PAF file to generate a report.

```bash
yacrd -i overlap.paf -o report.yacrd
```

### 3. Post-Detection Operations
Once a report is generated, use it to modify your sequence files.

*   **Filter**: Remove Chimeric and NotCovered reads entirely.
    `yacrd -i overlap.paf -o report.yacrd filter -i reads.fasta -o reads.filter.fasta`
*   **Extract**: Save only the Chimeric and NotCovered reads.
    `yacrd -i overlap.paf -o report.yacrd extract -i reads.fasta -o reads.extract.fasta`
*   **Split**: Remove bad regions in the middle of reads and discard NotCovered reads.
    `yacrd -i overlap.paf -o report.yacrd split -i reads.fasta -o reads.split.fasta`
*   **Scrubb**: Remove all bad regions from all reads and discard NotCovered reads.
    `yacrd -i overlap.paf -o report.yacrd scrubb -i reads.fasta -o reads.scrubb.fasta`

## Recommended Parameters by Platform

For datasets with coverage > 30x, use these specific configurations for better results:

| Platform | Minimap2 Preset | Minimap2 -g | yacrd -c (min-cov) | yacrd -n (min-read-cov) |
| :--- | :--- | :--- | :--- | :--- |
| **Nanopore** | `ava-ont` | 500 | 4 | 0.4 |
| **PacBio P6-C4** | `ava-pb` | 800 | 4 | 0.4 |
| **PacBio Sequel** | `ava-pb` | 5000 | 3 | 0.4 |

**Example Scrubbing Command (Nanopore):**
```bash
minimap2 -x ava-ont -g 500 reads.fasta reads.fasta > overlap.paf
yacrd -i overlap.paf -o report.yacrd -c 4 -n 0.4 scrubb -i reads.fasta -o reads.scrubb.fasta
```

## Expert Tips

*   **File Extensions**: yacrd relies on file extensions to determine format. Ensure your files end in `.paf`, `.m4`, or `.mhap` for overlaps, and `.fa`/`.fasta` or `.fq`/`.fastq` for sequences.
*   **Compression**: The tool automatically detects and handles gzip, bzip2, and lzma compression. If the input is compressed, the output will maintain the same compression format.
*   **Report as Input**: You can skip the overlap processing in subsequent runs by providing the `.yacrd` report file as the input (`-i`) for post-detection commands.
*   **Minimap2 Version**: Be cautious with minimap2 v2.19+ as changes in seed selection and chaining may slightly alter yacrd's behavior.

## Reference documentation
- [yacrd GitHub Repository](./references/github_com_natir_yacrd.md)
- [yacrd Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_yacrd_overview.md)