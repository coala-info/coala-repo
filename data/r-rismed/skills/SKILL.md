---
name: r-rismed
description: The r-rismed tool extracts bibliographic data and metadata from NCBI databases like PubMed directly into R. Use when user asks to search for medical literature, retrieve article metadata such as titles or abstracts, and perform bibliometric analysis.
homepage: https://cran.r-project.org/web/packages/rismed/index.html
---

# r-rismed

name: r-rismed
description: Extract bibliographic content from NCBI databases, including PubMed. Use this skill when you need to search for medical literature, retrieve article metadata (titles, abstracts, authors), or perform bibliometric analysis within R.

## Overview
RISmed (Research Information Systems + PubMed) is an R package designed to interface with the National Center for Biotechnology Information (NCBI) databases. It streamlines the process of querying PubMed and downloading structured bibliographic data for research and analysis.

## Installation
To install the package from CRAN:
install.packages("RISmed")

## Core Workflow
The standard RISmed workflow follows a three-step process:
1. Search: Define a query and get a summary of results.
2. Fetch: Download the actual records based on the search summary.
3. Extract: Use accessor functions to pull specific fields (titles, abstracts, etc.) into R data structures.

## Main Functions
- EUtilsSummary(query, type = "esearch", db = "pubmed", ...): Performs the search. Use 'retmax' to limit the number of results.
- EUtilsGet(x): Downloads the records associated with an EUtilsSummary object.
- QueryCount(x): Returns the total number of records found for a search.

## Data Extraction Accessors
Once you have an object from EUtilsGet, use these functions to extract data:
- ArticleTitle(): Titles of the papers.
- AbstractText(): Full text of the abstracts.
- Author(): List of authors for each paper.
- YearPubmed(): Year the article was indexed.
- PMID(): PubMed IDs.
- MedlineTA(): Journal abbreviations.

## Examples

### Basic Search and Extraction
library(RISmed)

# 1. Search for a topic
search_query <- "cancer immunotherapy 2023"
search_summary <- EUtilsSummary(search_query, retmax = 10)

# 2. Fetch the data
records <- EUtilsGet(search_summary)

# 3. Extract specific fields
titles <- ArticleTitle(records)
abstracts <- AbstractText(records)
pmids <- PMID(records)

# Create a data frame
df <- data.frame(PMID = pmids, Title = titles)

### Handling Authors
# Authors are returned as a list of data frames
auth_list <- Author(records)
# Access authors for the first paper
first_paper_authors <- auth_list[[1]]

## Tips
- Rate Limiting: NCBI limits the frequency of requests. If performing large batches, consider using an API key via the 'api_key' argument in EUtilsSummary.
- Query Syntax: Use standard PubMed search syntax (e.g., "Term[Mesh]" or "Term[Author]").
- Memory Management: For very large searches, fetch data in smaller chunks using the 'retstart' and 'retmax' arguments to avoid memory issues.

## Reference documentation
- [RISmed Home Page](./references/home_page.md)