---
name: msp2db
description: The msp2db tool converts mass spectrometry MSP text files into relational databases for efficient spectral lookup and data integration. Use when user asks to convert MSP files to SQLite or MySQL databases, batch process spectral libraries, or prepare metabolomics data for spectral matching.
homepage: https://github.com/computational-metabolomics/msp2db
---


# msp2db

## Overview
The `msp2db` tool streamlines the transition from flat MSP text files to relational databases. This is essential for researchers working with large-scale metabolomics data who need to perform efficient spectral lookups or integrate mass spectrometry libraries into automated pipelines. The tool supports both directory-level batch processing and individual file conversion, with specific handling for different metadata schemas.

## Installation
Install via Bioconda or pip:
```bash
conda install -c bioconda msp2db
# OR
pip install msp2db
```

## Command Line Interface (CLI)
The primary way to interact with `msp2db` is through the command line.

### Basic Conversion
To convert a single MSP file or a directory of files into an SQLite database:
```bash
msp2db -m ./input_spectra.msp -s MassBank -o ./output_library.db
```

### Advanced CLI Options
| Flag | Description |
|------|-------------|
| `-m, --msp_pth` | Path to a single `.msp` file or a directory containing multiple files. |
| `-s, --source` | Name of the data source (e.g., `MassBank`, `LipidBlast`, `MoNA`). |
| `-o, --out_pth` | Destination path for the SQLite database file. |
| `-t, --db_type` | Database backend: `sqlite` (default) or `mysql`. |
| `-x, --schema` | Metadata schema style: `mona` (default) or `massbank`. |
| `-c, --chunk` | Number of spectra to process per chunk (default: 200). Increase for speed, decrease for low memory. |
| `-l, --mslevel` | Manually set the MS level (e.g., 1 or 2) if it is missing from the MSP headers. |
| `-d, --delete_tables` | Drop existing tables in the target database before starting the import. |

## Expert Tips and Best Practices
- **Memory Management**: When dealing with very large MSP files (e.g., the full MoNA export), use the `--chunk` parameter to limit memory consumption. A chunk size of 100-500 is typically optimal for most systems.
- **Schema Selection**: Ensure the `--schema` flag matches your input format. While `mona` is the default, using `massbank` for records specifically formatted for MassBank ensures that metadata fields like `CH$NAME` and `AC$MASS_SPECTROMETRY` are parsed correctly.
- **Batch Processing**: Pointing `--msp_pth` to a directory will automatically recurse through all MSP files within that folder, merging them into a single unified database.
- **Database Compatibility**: The resulting SQLite database is specifically structured for compatibility with the `msPurity` Bioconductor R package for spectral matching.

## Python API Usage
For integration into custom Python scripts, use the `LibraryData` class:

```python
from msp2db.create_db import create_db
from msp2db.library_data import LibraryData

db_path = 'spectral_library.db'

# Initialize the database structure
create_db(file_pth=db_path, db_type='sqlite', db_name='spectra')

# Parse and load data
lib = LibraryData(
    msp_pth='input_data.msp',
    db_pth=db_path,
    db_type='sqlite',
    schema='mona',
    source='custom_source',
    chunk=200
)
```

## Reference documentation
- [msp2db GitHub Repository](./references/github_com_computational-metabolomics_msp2db.md)
- [msp2db Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_msp2db_overview.md)