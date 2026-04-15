---
name: glam2
description: This tool performs sequence alignment and motif discovery. Use when user asks to find patterns in biological sequences, align DNA/RNA/protein sequences, or discover motifs.
homepage: https://github.com/LELEGOBOO/Glam2
metadata:
  docker_image: "biocontainers/glam2:v1064-5-deb_cv1"
---

# glam2

Tools for sequence alignment and motif discovery. Use when Claude needs to perform sequence analysis, find patterns in biological sequences, or align DNA/RNA/protein sequences. This skill is particularly useful for tasks involving the glam2 alignment algorithm.
---
## Overview

The glam2 skill provides tools for sequence alignment and motif discovery. It is designed to help users find patterns and similarities within biological sequences such as DNA, RNA, and proteins. This skill is particularly useful when you need to apply the glam2 alignment algorithm for detailed sequence analysis.

## Usage Instructions

The `glam2` tool is primarily used via its command-line interface. Here are some common patterns and expert tips for effective usage:

### Core Functionality

`glam2` is used for finding motifs in sequences. The general command structure involves specifying input sequences and output options.

### Common CLI Patterns

*   **Basic Alignment:**
    To perform a basic alignment and find motifs, you would typically provide an input file containing your sequences.

    ```bash
    glam2 <input_sequences.fasta>
    ```

*   **Specifying Output:**
    You can control the output format and content. For example, to specify an output file for the alignment results:

    ```bash
    glam2 <input_sequences.fasta> -o <output_alignment.txt>
    ```

*   **Controlling Motif Discovery:**
    `glam2` allows for fine-tuning the motif discovery process. Options might include specifying the number of motifs to find or the length of the motifs.

    ```bash
    glam2 <input_sequences.fasta> -m <number_of_motifs> -l <motif_length>
    ```
    *(Note: Actual parameter names like `-m` and `-l` may vary; consult the tool's documentation for precise flags.)*

*   **Using Pre-defined Models/Databases:**
    If `glam2` supports using pre-existing models or databases for comparison, the command would involve specifying the path to these resources.

    ```bash
    glam2 <input_sequences.fasta> --model <path/to/model>
    ```

### Expert Tips

*   **Input Format:** Ensure your input sequences are in a format recognized by `glam2`, typically FASTA.
*   **Output Interpretation:** Understand the output format of `glam2`. It usually provides information about motif locations, scores, and consensus sequences.
*   **Parameter Tuning:** For complex datasets, experiment with different parameters related to motif length, gap penalties, and scoring matrices to achieve optimal results.
*   **Performance:** For very large datasets, consider the computational resources required. `glam2` can be resource-intensive.

## Reference documentation

* [glam2 overview on Anaconda.org](./references/anaconda_org_channels_bioconda_packages_glam2_overview.md)