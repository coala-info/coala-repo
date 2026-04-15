---
name: belvu
description: Belvu visualizes and manipulates sequence alignments. Use when user asks to visualize DNA or protein sequence alignments, create dot plots, or generate consensus sequences.
homepage: https://github.com/nathanhaigh/docker-seqtools
metadata:
  docker_image: "biocontainers/belvu:v4.44.1dfsg-3-deb_cv1"
---

# belvu

yaml
name: belvu
description: |
  Handles sequence alignment visualization and manipulation tasks.
  Use when Claude needs to work with DNA or protein sequence alignments,
  visualize them, or perform operations like dot plotting or generating
  consensus sequences. This skill is particularly relevant when dealing
  with bioinformatics workflows that involve sequence data.
```
## Overview
The belvu skill is designed to assist with tasks related to sequence alignment visualization and manipulation. It enables users to process and display DNA or protein sequence alignments, create visual representations like dot plots, and perform common bioinformatics operations on sequence data. This skill is ideal for users engaged in genetic analysis, comparative genomics, or any workflow requiring detailed examination of sequence relationships.

## Usage Instructions

Belvu is a command-line tool for visualizing and manipulating sequence alignments. It is often used in conjunction with other bioinformatics tools.

### Core Functionality and Examples

Belvu's primary functions revolve around processing alignment files (like GFF, FASTA) and generating visual outputs or derived sequence data.

#### Running Belvu with Example Data

The `docker-seqtools` repository provides example usage for `blixem`, which is part of the SeqTools suite that includes Belvu. While direct `belvu` commands are not explicitly detailed, the `blixem` examples illustrate the typical input and output patterns.

**Example: Running `blixem` (demonstrates input/output patterns relevant to Belvu)**

This example shows how to run `blixem` within a Docker container, taking FASTA and GFF files as input and producing a visualization. Belvu would operate on similar input files for its specific tasks.

*   **Linux Example:**
    ```bash
    docker pull nathanhaigh/seqtools:4.44.1
    docker run -it --env= " DISPLAY " nathanhaigh/seqtools:4.44.1 \
    blixem --display-type= " N " /opt/seqtools/examples/chr4_ref_seq.fasta /opt/seqtools/examples/chr4_dna_align.gff
    ```
    *   `--env= " DISPLAY "` is used to forward the display to a running X server.
    *   `--display-type= " N "` specifies the display type.
    *   The last two arguments are the input FASTA reference sequence and the GFF alignment file.

*   **Windows Example (requires Xming and Docker for Windows/Toolbox):**
    1.  Start Xming X server with `-ac` options.
    2.  Start "Docker QuickStart Terminal".
    3.  Run the following command, replacing `<ip_address>` with your VirtualBox Host Only IP Address:
        ```bash
        docker pull nathanhaigh/seqtools:4.44.1
        docker run -it --env= " DISPLAY=&lt;ip_address&gt;:0.0 " nathanhaigh/seqtools:4.44.1 \
        blixem --display-type= " N " /opt/seqtools/examples/chr4_ref_seq.fasta /opt/seqtools/examples/chr4_dna_align.gff
        ```

#### Common CLI Patterns and Considerations

*   **Input Files:** Belvu typically takes sequence alignment files (e.g., GFF, FASTA) as input.
*   **Output:** Depending on the specific `belvu` command, output can range from graphical visualizations (often requiring an X server or image export) to derived sequence data (e.g., consensus sequences).
*   **Dependencies:** Belvu is part of the SeqTools suite. When using it, ensure all necessary dependencies and associated tools are available. The `docker-seqtools` repository provides a Docker image that bundles these tools, which is a common and recommended way to run them.
*   **Visualization:** For interactive visualization, ensure you have an X server running if executing within a container or remote environment.

## Expert Tips

*   **Leverage Docker:** The `nathanhaigh/seqtools` Docker image is a robust way to ensure Belvu and its dependencies are correctly installed and configured, avoiding environment-specific issues.
*   **Understand Input Formats:** Familiarize yourself with the expected input file formats (e.g., FASTA for sequences, GFF for annotations/alignments) to ensure successful processing.
*   **Consult SeqTools Documentation:** Since Belvu is part of SeqTools, refer to the broader SeqTools documentation for detailed command-line options, parameters, and advanced usage patterns not explicitly covered here.

## Reference documentation
- [Dockerfile for SeqTools (Blixem, Dotter, Belvu) from the Sanger](./references/github_com_nathanhaigh_docker-seqtools.md)
- [README](./references/github_com_nathanhaigh_docker-seqtools_blob_master_README.md)