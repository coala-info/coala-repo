---
name: search_ncbi
description: This tool searches the NCBI PubMed database to retrieve biomedical literature, metadata, and citation data. Use when user asks to search for biomedical articles, fetch publication metadata, track citation history, or visualize research trends.
homepage: https://github.com/cyanheads/pubmed-mcp-server
---


# search_ncbi

## Overview
The search_ncbi skill provides a specialized interface for interacting with the National Center for Biotechnology Information (NCBI) PubMed database. It transforms general research queries into precise biomedical literature searches, allowing for the automated retrieval of article metadata, citation analysis, and the generation of research frameworks. Use this skill to move beyond simple keyword searches into deep evidence-based analysis, trend visualization, and systematic literature mapping.

## Tool Usage and Best Practices

### Effective Searching (pubmed_search_articles)
*   **Use MeSH Terms**: For high-precision results, incorporate Medical Subject Headings (MeSH). Instead of "heart attack," use "Myocardial Infarction [MeSH]".
*   **Boolean Logic**: Combine terms using AND, OR, and NOT (must be uppercase) to refine results.
*   **Field Tags**: Use tags like `[Author]`, `[Journal]`, or `[Title/Abstract]` to narrow the search scope.
*   **Date Ranges**: Always specify date ranges for "recent" or "last 5 years" queries to ensure temporal relevance.

### Content Retrieval (pubmed_fetch_contents)
*   **Batch Processing**: When you have a list of PubMed IDs (PMIDs) from a search, fetch them in batches to stay within rate limits while maintaining efficiency.
*   **Format Selection**: Choose the output format based on the task:
    *   `JSON`: Best for programmatic analysis and data extraction.
    *   `MEDLINE`: Best for traditional bibliography management.
    *   `BibTeX/RIS`: Best for generating citations for academic papers.

### Citation and Connection Analysis (pubmed_article_connections)
*   **Snowballing Research**: Use the `cited_by` and `references` features to perform forward and backward citation tracking. This is the most effective way to find the "intellectual lineage" of a specific discovery.
*   **Similarity Mapping**: Use the `similar` link type to find articles that NCBI's algorithms have determined are conceptually related, even if they don't share exact keywords.

### Research Planning (pubmed_research_agent)
*   **Structured Outlines**: Use this tool to generate a JSON research plan before diving into deep reading. It helps organize the search strategy and ensures all components of a research question are addressed systematically.

### Data Visualization (pubmed_generate_chart)
*   **Trend Analysis**: Use search result counts over time to generate line or bar charts showing the rise or fall of specific research topics.
*   **Categorical Data**: Use pie or radar charts to visualize the distribution of publication types (e.g., Clinical Trials vs. Reviews) within a search result set.

## Expert Tips
*   **Rate Limiting**: If you encounter 429 errors, ensure an NCBI API Key is configured. Without a key, NCBI limits requests to 3 per second; with a key, this increases to 10 per second.
*   **Affiliation Mining**: When fetching contents, pay attention to author affiliations to identify leading research institutions or geographic clusters for specific biomedical fields.
*   **Abstract Summarization**: When processing large volumes of papers, fetch the abstracts first to perform a high-level relevance filter before requesting full metadata or citation networks.

## Reference documentation
- [PubMed MCP Server Overview](./references/github_com_cyanheads_pubmed-mcp-server.md)