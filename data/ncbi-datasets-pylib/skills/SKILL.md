---
name: ncbi-datasets-pylib
description: The ncbi-datasets-pylib library provides a Python interface for querying and downloading biological datasets and metadata from the NCBI Datasets API. Use when user asks to download genome assemblies, fetch metadata for genes or genomes, retrieve data packages containing sequences and annotations, or perform taxonomy queries.
homepage: https://www.ncbi.nlm.nih.gov/datasets
---


# ncbi-datasets-pylib

## Overview
The `ncbi-datasets-pylib` provides a Pythonic interface to the NCBI Datasets API, allowing for seamless integration of NCBI data into bioinformatics pipelines. It simplifies the process of querying and downloading complex biological datasets—such as assembly sequences, annotation files, and metadata—without needing to manually navigate the web interface or write complex REST API wrappers.

## Key Functionalities
- **Genome Retrieval**: Download genome assemblies by accession (GCA/GCF) or taxon.
- **Metadata Extraction**: Fetch detailed JSON/dictionary metadata for genomes, genes, and virus isolates.
- **Data Packages**: Create and hydrate "data packages" containing sequences (FASTA), annotation (GFF3/GTF), and reports.
- **Taxonomy Queries**: Resolve taxonomic names to IDs and explore available data for specific clades.

## Usage Patterns

### Initializing the Client
Always use the `datasets.api` modules to interact with specific data types.
```python
import ncbi.datasets
from ncbi.datasets.openapi import ApiClient as DatasetsApiClient

# Initialize the API client
with DatasetsApiClient() as api_client:
    genome_api = ncbi.datasets.GenomeApi(api_client)
    gene_api = ncbi.datasets.GeneApi(api_client)
```

### Fetching Genome Metadata
To check assembly status or check for available files before downloading:
```python
# Get metadata for a specific assembly
genome_summary = genome_api.get_assembly_dataset_by_accession(
    accessions=["GCF_000001405.40"]
)
for assembly in genome_summary.assemblies:
    print(f"Assembly: {assembly.assembly.name}, Accession: {assembly.assembly.accession}")
```

### Downloading Data Packages
The library uses a "zip" stream approach for downloading datasets.
```python
# Download a genome dataset including genomic FASTA and GFF3
zipfile_name = "human_genome.zip"
genome_api.download_assembly_dataset_package(
    accessions=["GCF_000001405.40"],
    include_sequence=True,
    include_gff3=True,
    _preload_content=False,
    dest_file=zipfile_name
)
```

## Best Practices
- **Batching**: When requesting data for thousands of accessions, batch your requests (e.g., 100-500 accessions per call) to avoid timeouts and API limits.
- **Preload Content**: Set `_preload_content=False` when downloading large files to stream the data directly to disk, preventing memory exhaustion.
- **Error Handling**: Wrap API calls in try-except blocks to handle `ncbi.datasets.openapi.exceptions.ApiException`, which covers network issues and invalid accessions.
- **API Keys**: While not always required, using an NCBI API key increases rate limits. Set it in your environment or pass it to the configuration.

## Reference documentation
- [NCBI Datasets Pylib Overview](./references/anaconda_org_channels_bioconda_packages_ncbi-datasets-pylib_overview.md)