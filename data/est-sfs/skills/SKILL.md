---
name: est-sfs
description: Estimates the unfolded site frequency spectrum and ancestral state probabilities from DNA sequence data. Use when user asks to infer the uSFS from DNA sequence data, determine ancestral state probabilities at polymorphic sites, or analyze population genetics data with outgroup species information.
homepage: https://sourceforge.net/projects/est-usfs/
metadata:
  docker_image: "quay.io/biocontainers/est-sfs:2.04--h985cbd6_1"
---

# est-sfs

est-sfs/SKILL.md
```yaml
name: est-sfs
description: |
  Estimates the unfolded site frequency spectrum (uSFS) and ancestral state probabilities for DNA sequence data using a maximum likelihood method.
  Use when Claude needs to:
  - Infer the uSFS from DNA sequence data.
  - Determine ancestral state probabilities at polymorphic sites.
  - Analyze population genetics data with outgroup species information.
```
## Overview
The `est-sfs` tool is designed for population genetic analyses, specifically for inferring the unfolded site frequency spectrum (uSFS) and ancestral state probabilities from DNA sequence data. It employs a maximum likelihood approach and can utilize information from up to three outgroup species to enhance its estimations. This skill is useful when you need to understand the distribution of allele frequencies within a population and reconstruct ancestral states for evolutionary studies.

## Usage Instructions

The `est-sfs` command-line tool requires input data in a specific format and uses various options to control the analysis.

### Basic Command Structure

The general structure for running `est-sfs` is:

```bash
est-sfs [options] <input_file>
```

### Input Data Format

The `<input_file>` should contain DNA sequence data. The exact format is crucial for `est-sfs` to parse correctly. While the provided documentation does not detail the specific input file format, it is implied to be a standard format for sequence alignments or population genetic data. Consult the `est-sfs` documentation or examples for precise formatting requirements.

### Key Options and Parameters

Based on the general functionality of such tools, expect options related to:

*   **Model Selection**: Specify the nucleotide substitution model to be used (e.g., JC69, K80, HKY85). The documentation mentions "Three models of nucleotide substitution have been implemented."
*   **Outgroup Species**: Define the outgroup species data to be used in the analysis. The tool supports up to three outgroup species.
*   **Focal Species**: Specify the focal species for which the uSFS and ancestral states are being inferred.
*   **Output Control**: Options to specify output file names, verbosity levels, and the type of output (e.g., uSFS, ancestral probabilities).
*   **Data Filtering**: Parameters to filter sites or sequences based on certain criteria (e.g., missing data, quality scores).

### Example CLI Patterns (Illustrative)

While specific examples are not provided in the documentation, common patterns for such tools include:

*   **Running with default settings**:
    ```bash
    est-sfs my_sequences.fasta
    ```
*   **Specifying a substitution model and outgroup**:
    ```bash
    est-sfs --model HKY --outgroups species1.fasta,species2.fasta my_focal_species.fasta
    ```
*   **Saving output to specific files**:
    ```bash
    est-sfs --output-sfs sfs.txt --output-ancestral ancestral.txt my_sequences.fasta
    ```

### Expert Tips

*   **Understand Your Data**: Ensure your input DNA sequence data is properly aligned and formatted according to `est-sfs` requirements. Incorrect formatting is a common source of errors.
*   **Choose the Right Model**: The choice of nucleotide substitution model can significantly impact the results. Refer to population genetics literature or the `est-sfs` documentation for guidance on selecting an appropriate model for your data.
*   **Leverage Outgroups**: The ability to use outgroup species is a powerful feature. Ensure your outgroup data is relevant and of good quality to improve the accuracy of ancestral state inference.
*   **Check Documentation**: For precise details on input file formats, available substitution models, and all command-line options, always refer to the official `est-sfs` documentation or its help messages (`est-sfs --help`).

## Reference documentation
- [Overview of est-sfs on Anaconda.org](./references/anaconda_org_channels_bioconda_packages_est-sfs_overview.md)
- [SourceForge Project Page for est-sfs](./references/sourceforge_net_projects_est-usfs.md)
- [Download Page for est-sfs releases](./references/sourceforge_net_projects_est-usfs_files.md)
- [Support Page for est-sfs](./references/sourceforge_net_projects_est-usfs_support.md)