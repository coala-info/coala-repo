---
name: pileuppy
description: pileuppy is a high-performance bioinformatics utility designed to render sequencing alignments in a visually intuitive, color-coded format within a terminal environment.
homepage: https://gitlab.com/tprodanov/pileuppy
---

# pileuppy

## Overview
pileuppy is a high-performance bioinformatics utility designed to render sequencing alignments in a visually intuitive, color-coded format within a terminal environment. Unlike heavy GUI-based genome browsers, it allows for rapid command-line inspection of read distributions. It is particularly useful for developers and bioinformaticians who need to verify alignment results or debug mapping issues quickly on remote servers.

## Installation
The tool is available via Bioconda:
```bash
conda install -c bioconda pileuppy
```

## Common CLI Patterns

### Basic Visualization
To view the alignment pileup for a specific file:
```bash
pileuppy input.bam
```

### Targeted Region Inspection
Use the region flag to jump to a specific genomic coordinate. This is the most common way to use the tool for variant validation:
```bash
pileuppy --region chr1:1000-1100 input.bam
```

### Detailed Read Analysis
If you need to identify specific reads contributing to a pileup (e.g., for troubleshooting discordant pairs), enable read name output:
```bash
pileuppy --show-names input.bam
```

### Output Customization
To clean up the terminal output or adjust for different terminal backgrounds:
*   **Skip Legend**: Use `--skip-legend` to hide the color key and maximize the data view.
*   **Clean View**: Use `--skip-empty` to remove lines that do not contain alignment data.
*   **Color Schemes**: The tool supports different color modes (such as 16-color or white schemes) to ensure readability across various terminal themes.

## Expert Tips
*   **CRAM Support**: Since version 1.1.0, pileuppy supports CRAM files. Ensure you have the reference genome accessible if the CRAM requires it for decompression.
*   **Soft-Clipping**: The tool visualizes soft-clipped bases, which is essential for identifying structural variant breakpoints or adapter contamination.
*   **Piping to Pager**: Because the output is colorful and can be long, pipe it to `less` with the `-R` flag to preserve ANSI color codes while enabling scrolling:
    ```bash
    pileuppy input.bam | less -R
    ```
*   **TTY Awareness**: In newer versions (v1.2.0+), TTY awareness can be toggled. If you are capturing output to a file and lose colors, check your version's default behavior regarding color stripping.

## Reference documentation
- [Overview](./references/anaconda_org_channels_bioconda_packages_pileuppy_overview.md)
- [README](./references/gitlab_com_tprodanov_pileuppy_-_blob_master_README.md)
- [Tags and Version History](./references/gitlab_com_tprodanov_pileuppy_-_tags.md)