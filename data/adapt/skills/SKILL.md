---
name: adapt
description: ADAPT designs optimized viral diagnostic assays by using predictive models to maximize detection activity across genomic diversity. Use when user asks to design CRISPR-Cas13a guides, find optimal amplification primers, or create diagnostic assays for specific viral taxa.
homepage: https://github.com/broadinstitute/adapt
---


# adapt

## Overview
ADAPT (Activity-informed Design with All-inclusive Patrolling of Targets) is a specialized system for engineering viral diagnostics. Unlike traditional tools that rely on simple sequence conservation, ADAPT utilizes predictive models—including a pre-trained model for CRISPR-Cas13a trained on ~19,000 guide-target pairs—to maximize the expected detection activity across a virus's known genomic diversity. It automates the end-to-end process of downloading viral sequences from NCBI, curating them, and outputting ranked assay options that include both probes and amplification primers (e.g., for SHERLOCK).

## Command Line Usage and Best Practices

### Core Execution Patterns
ADAPT is typically invoked via subcommands. The primary workflow involves specifying a target (via NCBI Taxonomy ID or FASTA) and an objective function.

*   **Standard Design (NCBI TaxID):**
    To design an assay for a specific virus using its NCBI taxonomy identifier:
    `adapt <subcommand> -t <taxid> --obj maximize-activity`

*   **Local Sequence Input:**
    If you have custom or unaligned sequences, use the FASTA input flag:
    `adapt <subcommand> --use-fasta <file.fasta>`

### Objective Functions
Choose the objective based on the diagnostic requirements:
*   **maximize-activity (Default):** Optimizes for the highest predicted detection activity across the target's diversity. Best for high-sensitivity applications.
*   **minimize-guides:** Finds the smallest set of probes/guides required to cover a specific fraction of the target's genomic diversity. Best for reducing assay complexity.

### Enforcing Specificity
To ensure the design distinguishes the target from related species or different lineages within the same species:
*   Use the `--specificity-taxa` argument followed by the TaxIDs of the "background" viruses you wish to exclude or differentiate from.
*   ADAPT accounts for G-U pairing during specificity checks, which is critical for RNA-based diagnostics.

### Advanced Configuration and Optimization
*   **Thermodynamic Constraints:** If the `[thermo]` module is installed (via `pip install "adapt-diagnostics[thermo]"`), ADAPT can incorporate melting temperature (Tm) predictions for primers.
*   **Sliding Window Search:** For large viral genomes, you can restrict the search to specific regions or use a sliding window approach to find the most viable target sites.
*   **Metadata Filtering:** Use `--metadata-filter` to narrow down the sequences used for design based on specific criteria (e.g., date, location, or host) found in the NCBI records.
*   **Alignment:** ADAPT requires MAFFT for sequence alignment. Ensure the path to the MAFFT executable is available in your environment.

### Expert Tips
*   **Cloud Integration:** For large-scale designs involving massive sequence datasets, ADAPT supports AWS cloud features. Ensure `boto3` and `botocore` are installed to leverage these capabilities.
*   **Taxonomy Redirection:** ADAPT can automatically handle redirected or updated NCBI Taxonomy IDs, ensuring the most current genomic data is pulled during the "end-to-end" workflow.
*   **Output Interpretation:** The tool provides a ranked list of assay options. Always review the "predicted performance" metric to balance between the number of guides and the expected activity.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_broadinstitute_adapt.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_adapt_overview.md)