---
name: plasmidhawk
description: Plasmidhawk detects the lab-of-origin for input plasmids by building an annotated pangenome of training plasmids. Use when user asks to predict the lab-of-origin for plasmids.
homepage: https://gitlab.com/treangenlab/plasmidhawk
metadata:
  docker_image: "quay.io/biocontainers/plasmidhawk:1.0.3--hdfd78af_0"
---

# plasmidhawk

yaml
name: plasmidhawk
description: |
  Detects the lab-of-origin for input plasmids by building an annotated pangenome of training plasmids.
  Use when you need to identify the source laboratory of engineered DNA sequences based on their genetic profiles.
  This skill is particularly useful for analyzing novel or unknown plasmids in research and development settings.
```
## Overview
Plasmidhawk is a bioinformatics tool designed to infer the laboratory of origin for input plasmids. It achieves this by constructing an annotated pangenome from a set of training plasmids. This allows for the classification of new plasmids based on their genetic characteristics and their relationship to known plasmid collections. Use Plasmidhawk when you need to trace the provenance of engineered DNA sequences, which is crucial for research integrity, intellectual property, and understanding the landscape of synthetic biology.

## Usage Instructions

Plasmidhawk operates via the command line. The primary function is to predict the lab-of-origin for a given set of input plasmids.

### Core Command

The fundamental command structure for Plasmidhawk is:

```bash
plasmidhawk predict -i <input_plasmid_fasta> -o <output_directory>
```

### Key Arguments:

*   `-i <input_plasmid_fasta>`: Path to a FASTA file containing the input plasmid sequences for which you want to predict the lab-of-origin.
*   `-o <output_directory>`: Directory where Plasmidhawk will store its output files, including predictions and intermediate data.

### Important Considerations and Tips:

*   **Training Data**: Plasmidhawk relies on a pre-built pangenome of training plasmids. Ensure that your installation includes or has access to this training data. The tool will typically build this pangenome if it doesn't exist in the expected location, which can be time-consuming and disk-intensive.
*   **Performance**: As noted in user discussions, Plasmidhawk can be computationally intensive and require significant disk space, especially with large or highly diverse input datasets. The runtime and disk usage are directly proportional to the size and diversity of the input plasmids.
*   **Dependencies**: Plasmidhawk has dependencies, including `plaster`. Ensure these are correctly installed, preferably via a package manager like Conda.
*   **Output Interpretation**: The output directory will contain prediction results. Examine these files to understand the inferred lab-of-origin for each input plasmid. The exact format of the output files may vary, but typically includes scores or classifications.
*   **Troubleshooting Disk Space/Time**: If you encounter issues with excessive disk space usage or long runtimes, consider the diversity of your input plasmids. For very large and diverse datasets, the pangenome construction and subsequent alignment steps can be resource-heavy.



## Subcommands

| Command | Description |
|---------|-------------|
| plasmidhawk | PlasmidHawk: A tool for plasmid analysis |
| plasmidhawk annotate | Annotates plasmid metadata based on fragment metadata and plasmid ordering information. |
| plasmidhawk_predict | Choose prediction mode (max, supermax, correct), default max. supermax is max mode, but output top 50 labs |

## Reference documentation
- [Plasmidhawk Overview](./references/anaconda_org_channels_bioconda_packages_plasmidhawk_overview.md)
- [PlasmidHawk GitLab Repository](./references/gitlab_com_treangenlab_plasmidhawk.md)
- [PlasmidHawk README](./references/gitlab_com_treangenlab_plasmidhawk_-_blob_master_README.md)