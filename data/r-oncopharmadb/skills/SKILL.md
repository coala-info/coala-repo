---
name: r-oncopharmadb
description: This R package provides access to a comprehensive database of oncology drugs, their mechanisms of action, and genomic cancer biomarkers. Use when user asks to retrieve drug-target interactions, filter drugs by ATC classification, analyze actionable genomic aberrations, or access clinical trial and approval data for cancer therapies.
homepage: https://cran.r-project.org/web/packages/oncopharmadb/index.html
---


# r-oncopharmadb

name: r-oncopharmadb
description: Access and analyze targeted and non-targeted cancer drugs, drug regimens, and genomic cancer biomarkers. Use when needing information on drug mechanisms of action, clinical trial phases, ATC classifications, or actionable genomic aberrations (mutations, fusions, CNA, and expression biomarkers).

## Overview
oncopharmadb (also known as pharmOncoX) is an R package that provides a comprehensive database of oncology drugs and genomic biomarkers. It integrates data on drug targets, mechanism-of-action, approval dates, and clinical trial phases across various indications. Drugs are classified according to the Anatomical Therapeutic Chemical (ATC) Classification System, allowing for precise filtering of therapeutic agents. Additionally, the package provides access to actionable genomic aberrations, including gene fusions, mutations, and copy number alterations.

## Installation
To install the package from CRAN:
install.packages("oncopharmadb")

To load the package:
library(oncopharmadb)

## Core Workflows

### Drug Data Retrieval
The package allows users to query comprehensive annotations for anticancer drugs.
- Retrieve targeted and non-targeted drug lists.
- Access drug-target interactions and mechanism-of-action (MoA) data.
- Filter drugs by ATC classification codes to focus on specific therapeutic classes.

### Biomarker Analysis
Users can access data on actionable genomic aberrations that serve as cancer biomarkers.
- Query gene fusions and mutations associated with drug sensitivity or resistance.
- Analyze copy number alterations (CNA) and expression-based biomarkers.
- Link genomic variants to specific clinical indications and drug regimens.

### Clinical Context
- Access FDA/EMA approval dates for specific drug-indication pairs.
- Review clinical trial phases for drugs in development or approved for new indications.

## Usage Tips
- Use the ATC classification system to filter for specific classes of drugs (e.g., L01 for antineoplastic agents).
- Combine biomarker data with drug target annotations to identify potential therapeutic options for specific genomic profiles.
- Check the versioning of the underlying database to ensure clinical trial and approval data is current.

## Reference documentation
- [CODE_OF_CONDUCT.md](./references/CODE_OF_CONDUCT.md)
- [NEWS.md](./references/NEWS.md)
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)