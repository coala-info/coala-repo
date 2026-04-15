---
name: msmetaenhancer
description: MSMetaEnhancer automates the enrichment of mass spectrometry metadata by querying web services to fill in missing chemical identifiers. Use when user asks to enrich msp files, curate chemical metadata, or convert between identifiers like compound names, InChIKeys, and SMILES strings.
homepage: https://github.com/RECETOX/MSMetaEnhancer
metadata:
  docker_image: "quay.io/biocontainers/msmetaenhancer:0.4.1--pyhdfd78af_0"
---

# msmetaenhancer

## Overview

MSMetaEnhancer is a specialized utility designed to automate the enrichment of mass spectrometry metadata. It processes `.msp` files to fill in missing chemical information by querying multiple web services asynchronously. This tool is essential for researchers who need to standardize spectral libraries or bridge gaps between different chemical identifiers (e.g., converting a compound name into an InChIKey or SMILES string) using reliable public databases.

## Installation

Install the package via Bioconda to ensure all dependencies are correctly managed:

```bash
conda create --name MSMetaEnhancer python=3.9
conda activate MSMetaEnhancer
conda install --channel bioconda --channel conda-forge MSMetaEnhancer
```

## Core Workflow (Python API)

The primary way to interact with MSMetaEnhancer is through its Python API. The process follows a Load-Curate-Annotate-Save pattern.

```python
import asyncio
from MSMetaEnhancer import Application

async def run_annotation():
    app = Application()
    
    # 1. Load data (supports .msp and tabular formats)
    app.load_data('input_file.msp', file_format='msp')
    
    # 2. Curate metadata (fixes common formatting issues, e.g., CAS numbers)
    app.curate_metadata()
    
    # 3. Define services and specific annotation jobs
    # Jobs follow the format: (input_identifier, output_identifier, service)
    services = ['CTS', 'CIR', 'IDSM', 'PubChem', 'BridgeDb', 'RDKit']
    jobs = [
        ('name', 'inchi', 'IDSM'),
        ('inchi', 'formula', 'IDSM'),
        ('inchi', 'inchikey', 'IDSM'),
        ('inchi', 'canonical_smiles', 'PubChem')
    ]
    
    # 4. Execute asynchronous annotation
    await app.annotate_spectra(services, jobs)
    
    # 5. Export enriched file
    app.save_data('enriched_output.msp', file_format='msp')

if __name__ == "__main__":
    asyncio.run(run_annotation())
```

## Supported Identifiers and Services

### Common Identifiers
- `name`, `inchi`, `inchikey`, `smiles`, `canonical_smiles`, `formula`, `cas`, `iupac_name`, `pubchem_cid`.

### Available Services
- **CIR**: Chemical Identifier Resolver.
- **CTS**: Chemical Translation Service.
- **PubChem**: Comprehensive chemical database.
- **IDSM**: Integrated Database of Small Molecules.
- **BridgeDb**: Framework for gene, protein, and metabolite mapping.
- **RDKit**: Local computation for specific conversions (e.g., InChI to SMILES).

## Expert Tips and Best Practices

- **Curate First**: Always call `app.curate_metadata()` before annotation. This standardizes existing identifiers, significantly increasing the hit rate for web service queries.
- **Job Sequencing**: Order your jobs logically. If you only have compound names, your first jobs should convert `name` to `inchi` or `inchikey`, which can then be used as inputs for subsequent jobs to fetch more specific data.
- **Service Selection**: 
    - Use **IDSM** or **PubChem** for broad identifier lookups.
    - Use **RDKit** for deterministic conversions that don't require network calls (like generating a formula from an InChI).
- **Asynchronous Performance**: The tool uses `asyncio` to query services in parallel. When processing large MSP files, ensure your network environment allows multiple concurrent connections to the supported APIs.

## Reference documentation
- [MSMetaEnhancer GitHub Repository](./references/github_com_RECETOX_MSMetaEnhancer.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_msmetaenhancer_overview.md)