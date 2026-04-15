---
name: bioconductor-ga4ghshiny
description: GA4GHshiny provides a web-based user interface for exploring genomic data and searching for variants across GA4GH-compliant servers. Use when user asks to launch a Shiny application to search for genomic features, connect to GA4GH servers like 1000 Genomes, or query the Beacon Network for specific variants.
homepage: https://bioconductor.org/packages/release/bioc/html/GA4GHshiny.html
---

# bioconductor-ga4ghshiny

## Overview

The `GA4GHshiny` package is a companion to `GA4GHclient` that provides a web-based user interface (Shiny app) for genomic data exploration. It allows users to connect to GA4GH-compliant servers (like 1000 Genomes or BRCA Exchange) to search for variants and genomic features without writing complex API queries. It also integrates with the Beacon Network to check for the presence of specific variants across multiple global databases.

## Core Functionality

The package revolves around a single primary function: `app()`.

### Launching the Application

To start the interface, you must provide at least the `host` URL of a GA4GH server.

```r
library(GA4GHshiny)
library(org.Hs.eg.db)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)

app(host = "http://1kgenomes.ga4gh.org/",
    serverName = "1000 Genomes Project",
    orgDb = "org.Hs.eg.db",
    txDb = "TxDb.Hsapiens.UCSC.hg19.knownGene")
```

### Key Arguments

- `host`: The URL of the GA4GH-based data server.
- `serverName`: (Optional) A custom label displayed in the application's title bar.
- `orgDb`: The name of the Genome wide annotation package (e.g., `"org.Hs.eg.db"`) required for gene symbol searches.
- `txDb`: The name of the Transcript database package (e.g., `"TxDb.Hsapiens.UCSC.hg19.knownGene"`) required for searching by exons or transcripts. **Note:** Ensure the TxDb version matches the reference genome used by the host server (e.g., hg19 vs. hg38).

### Known Public Endpoints

- **1000 Genomes:** `http://1kgenomes.ga4gh.org/`
- **Ensembl REST API:** `https://rest.ensembl.org/`
- **BRCA Exchange:** `http://brcaexchange.org/backend/data/ga4gh/v0.6.0a7/`

## Deployment Patterns

### RStudio Usage
When running `app()` inside RStudio, the Beacon Network integration might be restricted by the internal viewer. Click the **"Open in Browser"** button at the top of the RStudio window to ensure full functionality.

### Shiny Server Deployment
To host the application on a server, create an `app.R` file in your Shiny Server directory (e.g., `/srv/shiny-server/genomics/app.R`):

```r
library(GA4GHshiny)
# Load dependencies
library(org.Hs.eg.db)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)

# Launch app
app(host = "http://1kgenomes.ga4gh.org/",
    orgDb = "org.Hs.eg.db",
    txDb = "TxDb.Hsapiens.UCSC.hg19.knownGene")
```

## Reference documentation

- [GA4GHshiny Vignette (Rmd)](./references/GA4GHshiny.Rmd)
- [GA4GHshiny Vignette (Markdown)](./references/GA4GHshiny.md)