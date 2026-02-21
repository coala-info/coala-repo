---
name: bioepic
description: The bioepic skill provides a specialized interface for researchers to standardize ecological data and extract metadata from scientific repositories.
homepage: https://github.com/bioepic-data/bioepic_skills
---

# bioepic

## Overview
The bioepic skill provides a specialized interface for researchers to standardize ecological data and extract metadata from scientific repositories. It automates the process of "grounding" research terms—mapping them to formal ontologies like BERVO (Biological and Environmental Research Variable Ontology)—and facilitates the discovery of plant traits and environmental variables from the ESS-DIVE, TRY, and FRED databases.

## Core Workflows

### Ontology Grounding and Search
Standardize research terms by mapping them to recognized biological and environmental ontologies.

*   **List available ontologies**: `bioepic ontologies`
*   **Search for specific variables**: `bioepic search "soil moisture" --ontology bervo`
*   **Ground multiple terms**: `bioepic ground "air temperature" "precipitation" "soil pH" --ontology bervo`
*   **Retrieve term details**: `bioepic term ENVO:00000001`

### ESS-DIVE Data Operations
Interact with the Environmental System Science Data Infrastructure for a Virtual Ecosystem (ESS-DIVE). Note: Requires `ESSDIVE_TOKEN` environment variable.

*   **Search datasets**: `bioepic essdive-search --keyword "soil" --page-size 10`
*   **Fetch metadata**: `bioepic essdive-metadata dois.txt --output ./data`
*   **Extract variables from files**: `bioepic essdive-variables --output ./data --workers 20`
*   **Fetch specific record**: `bioepic essdive-dataset <package-id>`

### Database Discovery (TRY & FRED)
Access trait and species lists from the TRY Plant Trait Database and the Fine-Root Ecology Database (FRED).

*   **TRY Discovery**:
    *   Download pages: `python skills/try-skills/scripts/try_download_and_search.py --page traits --save try_traits.html`
    *   Convert to structured data: `python skills/try-skills/scripts/try_traits_to_json.py try_traits.html --format tsv --output try_traits.tsv`
*   **FRED Discovery**:
    *   Download inventory: `python skills/fred-skills/scripts/fred_download_and_search.py --page traits --save fred_traits.html --insecure`
    *   Convert to structured data: `python skills/fred-skills/scripts/fred_traits_to_json.py fred_traits.html --format tsv --output fred_traits.tsv`

## Expert Tips and Best Practices

*   **Standardization**: Always use `bioepic match-terms <variable_file> <ontology_file>` to align extracted dataset variables with your target ontology terms.
*   **Output Management**: Use the `--output` flag with a `.json` or `.tsv` extension for all search and grounding commands to ensure results are easily ingestible by downstream scripts.
*   **Fuzzy Matching**: The `search` command supports fuzzy matching; if a direct hit isn't found, try broader terms to identify the correct parent class in the ontology.
*   **Authentication**: Ensure `ESSDIVE_TOKEN` is exported in your current shell session before attempting any `essdive-` commands.
*   **Ontology Selection**: Use `bervo` for environmental variables, `envo` for biomes/entities, and `ncbi_taxonomy` for organism identification.

## Reference documentation
- [bioepic_skills README](./references/github_com_bioepic-data_bioepic_skills.md)