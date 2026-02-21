---
name: rmlst_api
description: The `rmlst_api` tool provides a streamlined Python-based interface to the PubMLST species identification engine.
homepage: pypi.org/project/rmlst-api
---

# rmlst_api

## Overview
The `rmlst_api` tool provides a streamlined Python-based interface to the PubMLST species identification engine. It allows for the rapid taxonomic assignment of bacterial genomes by analyzing 53 genes encoding bacterial ribosomal proteins (rMLST). This approach is highly effective for identifying isolates to the species level and detecting potential contamination or mixed cultures within a genomic sample.

## Usage Guidelines

### Basic Command Pattern
The primary function of the tool is to submit a FASTA file to the API and retrieve the identification results.
```bash
rmlst_api -i <input_assembly.fasta> -o <output_results.json>
```

### Best Practices
- **Input Quality**: Ensure input FASTA files contain high-quality assemblies. While rMLST is robust, highly fragmented assemblies may result in missing ribosomal loci, leading to lower confidence in species assignment.
- **API Connectivity**: Since this tool relies on the PubMLST RESTful API, an active internet connection is required. For large batches of isolates, implement a delay or check for rate-limiting if the tool does not handle it natively.
- **Result Interpretation**: The output typically includes a list of potential species matches with associated "support" or "identity" scores. Always prioritize the match with the highest number of loci identified (ideally 53/53).
- **Taxon Specificity**: If the tool returns multiple closely related species with similar support scores, consider the biological context or use supplementary methods (like 16S rRNA or ANI) for definitive differentiation.

### Common Troubleshooting
- **Connection Errors**: If the API is down or unreachable, the tool will fail. Check the status of [pubmlst.org](https://pubmlst.org) if persistent timeouts occur.
- **File Formats**: Ensure the input file is in standard FASTA format. Compressed files (.gz) may need to be decompressed depending on the specific version's support.

## Reference documentation
- [rmlst_api Overview](./references/anaconda_org_channels_bioconda_packages_rmlst_api_overview.md)