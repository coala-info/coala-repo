---
name: pmidcite
description: The pmidcite tool retrieves citation data, reference lists, and NIH performance metrics for biomedical papers using the National Institutes of Health Open Citation Collection. Use when user asks to perform forward or backward citation snowballing, analyze NIH percentile rankings for PMIDs, or batch process literature for bibliometric summaries.
homepage: http://github.com/dvklopfenstein/pmidcite
---


# pmidcite

## Overview
The `pmidcite` skill provides a command-line interface to the National Institutes of Health (NIH) Open Citation Collection. It allows for the rapid retrieval of "Cited by" data and reference lists without the need for manual web browsing. Beyond simple citation counts, it provides deep metadata including NIH performance percentiles, clinical citation markers, and MeSH term categories. This tool is essential for researchers conducting systematic reviews, bibliometric analyses, or literature discovery in the biomedical and life sciences.

## Core CLI Workflows

### Single Paper Analysis
To get a quick summary of a paper's impact, including author count, reference count, and its NIH percentile ranking:
```bash
icite -H <PMID>
```
*Tip: Look for the "G" column (NIH percentile grouping). Groups 2, 3, and 4 represent top-performing papers.*

### Citation Snowballing
*   **Forward Snowballing (Cited By):** Find all papers that have cited a specific PMID.
    ```bash
    icite <PMID> --load_citations | sort -k6 -r
    ```
*   **Backward Snowballing (References):** Find all papers cited by a specific PMID.
    ```bash
    icite <PMID> --load_references | sort -k6 -r
    ```
*Note: Sorting by `-k6` typically organizes results by the NIH percentile or citation impact.*

### Batch Processing and Summarization
When dealing with a large set of papers (e.g., from a PubMed search), use the following pattern:
1.  **Analyze a list of PMIDs:**
    ```bash
    icite -i pmids_list.txt -o annotated_citations.txt
    ```
2.  **Summarize the collection:**
    Use the `sumpaps` command to get a distribution of the papers' performance groups (from 'i' for newest to '4' for top-performing).
    ```bash
    sumpaps annotated_citations.txt
    ```

## Expert Tips
*   **NIH Percentile Grouping:** The tool uses a novel grouping system where lower-performing papers (groups 0-1) are moved to the back, while newer papers ('i') and high-performers (2-4) are highlighted. This is more effective than raw citation counts for finding relevant recent discoveries.
*   **Handling Large Downloads:** The NIH-OCC limit is currently 200 PMIDs per request. `pmidcite` handles this, but for very large sets, ensure you use the `-o` flag to save progress to a file.
*   **Configuration:** Generate a default configuration file to manage API keys or default behaviors:
    ```bash
    icite --generate-rcfile > ~/.pmidciterc
    ```
*   **Filtering for Top Papers:** Use `grep` to quickly isolate high-impact papers from an output file:
    ```bash
    grep TOP annotated_citations.txt | sort -k6
    ```

## Reference documentation
- [pmidcite GitHub Repository](./references/github_com_dvklopfenstein_pmidcite.md)
- [pmidcite Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pmidcite_overview.md)