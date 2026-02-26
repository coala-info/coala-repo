---
name: calcs
description: Appends minimap2's CS tag to SAM/BAM files. Use when user asks to add CS tags for alignment information.
homepage: https://github.com/akikuno/calcs
---


# calcs

yaml
name: calcs
description: Appends minimap2's CS tag to SAM/BAM files. Use when you need to add CS tags for alignment information, especially when working with tools that require this tag for downstream analysis. This tool is deprecated; consider using cstag-cli or paftools.js sam2paf for newer workflows.
```
## Overview
The `calcs` tool is a command-line utility designed to append minimap2's CS (Cigar String) tag to SAM or BAM files. This is particularly useful when you need to enrich alignment data with detailed CIGAR string information, which can be crucial for various bioinformatics analyses. However, it's important to note that `calcs` is deprecated. For current projects, it is recommended to use `cstag-cli` or `paftools.js sam2paf`. If your input files lack MD tags, consider using `samtools calmd` first, followed by `cstag-cli`.

## Usage Instructions

The `calcs` tool processes SAM or BAM files and outputs SAM or PAF format with appended CS tags.

### Installation

You can install `calcs` using pip or conda:

*   **Pip:**
    ```bash
    pip install calcs
    ```
*   **Conda:**
    ```bash
    conda install -c bioconda calcs
    ```

### Basic Usage

The general command structure is:

```bash
calcs [options] <input.sam> -r/--reference <input.fasta> > <output.sam>
```

### Options

*   `-l`, `--long`: Output the CS tag in the long form.
*   `-t`, `--threads [INT]`: Number of threads to use for processing (default: 1).
*   `--paf`: Output in PAF format instead of SAM.

### Examples

1.  **Append short-form CS tag to a SAM file:**
    ```bash
    calcs examples/example.sam --reference examples/ref.fa > example_cs.sam
    ```

2.  **Append long-form CS tag to a SAM file:**
    ```bash
    calcs examples/example.sam --reference examples/ref.fa --long > example_cslong.sam
    ```

3.  **Output in PAF format with short-form CS tag:**
    ```bash
    calcs examples/example.sam --reference examples/ref.fa --paf > example_cs.paf
    ```

4.  **Output in PAF format with long-form CS tag:**
    ```bash
    calcs examples/example.sam --reference examples/ref.fa --paf --long > example_cslong.paf
    ```

5.  **Using multiple threads for processing:**
    ```bash
    calcs examples/example.sam --reference examples/ref.fa --threads 4 > example_cs.sam
    ```

### Handling BAM/CRAN Files

If your input is in BAM or CRAN format, you can pipe it through `samtools view` first:

```bash
samtools view examples/example.bam | calcs --long --reference examples/ref.fa | samtools sort > example_cslong.bam
```

## Expert Tips and Best Practices

*   **Deprecation Warning:** Be aware that `calcs` is deprecated. For new projects, prioritize using `cstag-cli` or `paftools.js sam2paf`.
*   **MD Tag Requirement:** If your SAM/BAM files do not have MD tags, it is highly recommended to add them using `samtools calmd` before using `cstag-cli` for CS tag generation. This can improve the accuracy and compatibility of downstream tools.
*   **Reference FASTA:** Always provide a valid reference FASTA file using the `--reference` or `-r` option. This is crucial for `calcs` to correctly determine the CIGAR string information.
*   **Output Redirection:** Use shell redirection (`>`) to save the output to a file.
*   **Piping with samtools:** For BAM files, piping through `samtools view` and `samtools sort` is the standard workflow. Ensure your `samtools` installation is compatible.
*   **Performance:** For large files, consider using the `--threads` option to leverage multiple CPU cores. However, note that `calcs` is generally slower than its recommended alternatives.

## Reference documentation
- [calcs - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_calcs_overview.md)
- [GitHub - akikuno/calcs: Append CS tag to SAM file](./references/github_com_akikuno_calcs.md)
- [calcs/examples at main · akikuno/calcs · GitHub](./references/github_com_akikuno_calcs_tree_main_examples.md)