---
name: ebi-eva-common-pyutils
description: The `ebi-eva-common-pyutils` library is a collection of Python utilities designed to standardize common tasks within the European Variation Archive (EVA) data processing ecosystem.
homepage: https://github.com/EBIVariation/eva-common-pyutils
---

# ebi-eva-common-pyutils

## Overview

The `ebi-eva-common-pyutils` library is a collection of Python utilities designed to standardize common tasks within the European Variation Archive (EVA) data processing ecosystem. It provides a robust interface for downloading and organizing genomic assemblies from NCBI and offers a centralized logging framework to ensure consistent output across complex bioinformatics workflows. Use this skill to programmatically manage genomic reference data and maintain professional-grade logging in EVA-related scripts.

## Installation

Install the utilities via Bioconda:

```bash
conda install bioconda::ebi-eva-common-pyutils
```

## Assembly Retrieval

The `NCBIAssembly` module automates the downloading and organization of genomic assemblies. It places files in species-specific subfolders based on the provided scientific name.

### Full Assembly Download
To download both the assembly FASTA and the associated report:

```python
from ebi_eva_common_pyutils.assembly import NCBIAssembly

# Initialize with Accession, Scientific Name, and Destination
assembly = NCBIAssembly(
    'GCA_000008865.1', 
    'Escherichia coli O157:H7 str. Sakai', 
    '/path/to/download_dir'
)

# Download or construct the assembly files
assembly.download_or_construct()

# Access the resulting path
print(assembly.assembly_fasta_path)
```

### Report Only
If only the assembly report is required:

```python
assembly.download_assembly_report()
print(assembly.assembly_report_path)
```

## Standardized Logging

The `logger` module provides a unified configuration that propagates handlers to all newly created loggers, ensuring consistent formatting and output destinations.

### Basic Script Logging
Initialize a standard stderr handler at the start of your script:

```python
from ebi_eva_common_pyutils.logger import logging_config as log_cfg

# Setup global handler
log_cfg.add_stderr_handler()

# Get a logger for the current module
logger = log_cfg.get_logger(__name__)
logger.info('Process started')
```

### Class-based Logging
For object-oriented implementations, inherit from `AppLogger` to gain built-in logging capabilities:

```python
from ebi_eva_common_pyutils.logger import logging_config as log_cfg

class DataProcessor(log_cfg.AppLogger):
    def process(self):
        self.info('Processing data...')
        self.error('An error occurred')

# Usage
log_cfg.add_stderr_handler()
processor = DataProcessor()
processor.process()
```

## Best Practices

- **Directory Structure**: Always provide a clear `download_destination`. The tool will automatically create subdirectories based on the scientific name provided, which helps maintain a clean reference data repository.
- **Handler Initialization**: Call `add_stderr_handler()` exactly once in the `main()` block or entry point of your application to avoid duplicate log entries.
- **Accession Accuracy**: Ensure the GCA/GCF accession is correct; the tool focuses on retrieval and organization rather than validating the match between accession and scientific name.

## Reference documentation
- [EBI EVA - Common Python Utilities Overview](./references/anaconda_org_channels_bioconda_packages_ebi-eva-common-pyutils_overview.md)
- [EBIvariation/eva-common-pyutils GitHub Repository](./references/github_com_EBIvariation_eva-common-pyutils.md)