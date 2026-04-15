---
name: omark
description: OMArk assesses the quality of proteome annotations by analyzing protein placement into gene families to determine completeness and detect contamination. Use when user asks to assess proteome quality, identify species contamination, or generate proteome completeness reports from OMAmer search results.
homepage: https://github.com/DessimozLab/omark
metadata:
  docker_image: "quay.io/biocontainers/omark:0.4.1--pyh7e72e81_0"
---

# omark

## Overview
OMArk is a specialized tool for assessing the quality of proteome annotations. It works by analyzing the placement of proteins into gene families (Hierarchical Orthologous Groups or HOGs) to determine if a proteome is complete, contains expected gene duplications, or suffers from contamination by other species. This skill guides the execution of OMArk on OMAmer search outputs to generate both machine-readable and human-interpretable quality reports.

## Installation
Install OMArk via Bioconda or Pip:
```bash
conda install -c bioconda omark
# OR
pip install omark
```

## Core Workflow
OMArk requires an OMAmer search result as its primary input.

1.  **Prerequisite (OMAmer Search):**
    Run OMAmer on your proteome FASTA file using a database (e.g., `LUCA.h5`).
    ```bash
    omamer search --db LUCA.h5 --query proteome.fasta --out search_results.omamer
    ```

2.  **Run OMArk:**
    Execute the assessment using the OMAmer output and the same database.
    ```bash
    omark -f search_results.omamer -d LUCA.h5 -o output_directory
    ```

## Common CLI Patterns

### Handling Splicing Isoforms
If the input proteome contains multiple isoforms per gene, you must provide a `.splice` file to avoid overestimating gene counts or duplications.
- **Format:** Semi-colon separated protein IDs per line (one line per gene).
- **Command:**
  ```bash
  omark -f search_results.omamer -d LUCA.h5 -i species.splice
  ```

### Specifying Taxonomy
To ensure the most accurate reference lineage is used for completeness assessment, provide the NCBI TaxID or a specific taxonomic rank.
```bash
omark -f search_results.omamer -d LUCA.h5 -t 9606 -r primates
```

### Generating Sequence-Specific Outputs
To have OMArk output FASTA files categorized by quality (e.g., consistent vs. contaminants), provide the original proteome file.
```bash
omark -f search_results.omamer -d LUCA.h5 -of original_proteome.fasta
```

## Expert Tips & Best Practices
- **Database Selection:** Always prefer the `LUCA.h5` database for general assessments. Using taxonomically restricted databases (like "Primates only") prevents OMArk from detecting contamination from species outside that range.
- **Output Interpretation:**
    - `.sum`: Use for automated pipelines and parsing.
    - `_detailed_summary.txt`: Use for manual review of completeness and contamination.
    - `.pdf`: Use for visual reporting of proteome quality.
- **Conserved HOGs Mode:** Use the `-c` flag if you only need to compute a list of conserved HOGs for training models rather than performing a full proteome assessment.

## Reference documentation
- [OMArk GitHub Repository](./references/github_com_DessimozLab_OMArk.md)
- [OMArk Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_omark_overview.md)