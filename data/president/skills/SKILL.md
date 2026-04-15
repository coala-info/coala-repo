---
name: president
description: Calculates pairwise nucleotide identity between sequences with respect to a reference. Use when user asks to compare genetic sequences for similarity, identify variations, or assess evolutionary relationships.
homepage: https://gitlab.com/RKIBioinformaticsPipelines/president
metadata:
  docker_image: "quay.io/biocontainers/president:0.6.8--pyhdfd78af_0"
---

# president

yaml
name: president
description: Calculates pairwise nucleotide identity between sequences with respect to a reference. Use when needing to compare genetic sequences for similarity, identify variations, or assess evolutionary relationships. This tool is particularly useful for analyzing genomic data, such as comparing newly sequenced DNA against a known reference genome or identifying mutations.
---
## Overview
The `president` tool is designed to compute the pairwise nucleotide identity between a set of sequences and a designated reference sequence. It quantifies the similarity at the nucleotide level, providing a measure of how closely related different genetic sequences are to a reference. This is crucial in bioinformatics for tasks like variant calling, phylogenetic analysis, and quality control of sequencing data.

## Usage Instructions

The `president` tool is typically used via its command-line interface. The core functionality involves providing a reference sequence and one or more query sequences.

### Basic Command Structure

The general command structure is as follows:

```bash
president -r <reference_fasta> -q <query_fasta> [options]
```

- `-r <reference_fasta>`: Path to the FASTA file containing the reference sequence.
- `-q <query_fasta>`: Path to the FASTA file containing the query sequences.

### Key Options and Best Practices

*   **Specifying Output:**
    *   By default, `president` outputs results to standard output. To save the output to a file, use shell redirection:
        ```bash
        president -r reference.fasta -q query.fasta > identity.txt
        ```

*   **Handling Temporary Files:**
    *   The tool may generate temporary files during its operation. In environments with limited or shared `/tmp` directories (like HPC clusters), it's advisable to specify a custom temporary directory to avoid issues with too many or too large temporary files.
    *   **Note:** As of recent activity, there's an open issue regarding the management of temporary files, suggesting a potential future parameter to control this. For now, ensure your system's temporary directory has sufficient space or consider redirecting output to avoid excessive temporary file creation if possible.

*   **Sequence Input:**
    *   Ensure your FASTA files are correctly formatted. Each sequence should have a unique identifier on its header line.
    *   The tool is designed for nucleotide sequences.

*   **Interpreting Output:**
    *   The output typically includes the identity percentage between the reference and each query sequence. Understanding this percentage is key to assessing sequence similarity.

### Example Workflow

1.  **Prepare your FASTA files:**
    *   `reference.fasta`: Contains your reference genome or sequence.
    *   `query.fasta`: Contains one or more sequences you want to compare against the reference.

2.  **Run the `president` command:**
    ```bash
    president -r reference.fasta -q query.fasta
    ```

3.  **Analyze the output:**
    The output will show the pairwise identity for each query sequence relative to the reference. For example:
    ```
    # Query  Reference  Identity (%)
    Seq1     RefSeq     99.5
    Seq2     RefSeq     95.2
    ```

### Expert Tips

*   **Large Datasets:** For very large FASTA files or numerous comparisons, consider optimizing your system's I/O performance.
*   **Version Compatibility:** While the provided information doesn't detail specific version dependencies, it's generally good practice to use the latest stable version of `president` available via bioconda to benefit from bug fixes and performance improvements. Recent activity shows updates related to pandas versions, indicating ongoing maintenance.

## Reference documentation
- [Overview](./references/anaconda_org_channels_bioconda_packages_president_overview.md)
- [GitLab Project Page](./references/gitlab_com_RKIBioinformaticsPipelines_president.md)
- [README](./references/gitlab_com_RKIBioinformaticsPipelines_president_-_blob_master_README.md)