---
name: psims
description: psims is a Python API for programmatically creating XML documents that follow Proteomics Standards Initiative specifications. Use when user asks to write mzML files, generate mzIdentML documents, or create HDF5-optimized mzMLb files for mass spectrometry data.
homepage: https://github.com/mobiusklein/psims
---


# psims

## Overview
psims is a declarative Python API designed for writing XML documents that follow the Proteomics Standards Initiative (PSI) specifications. It provides a high-level interface for creating mzML (mass spectrometry data), mzIdentML (peptide and protein identifications), and mzMLb (an HDF5-optimized version of mzML). Instead of manually constructing XML nodes, you use context managers and structured parameters to define the hierarchy and metadata of your mass spectrometry experiments.

## Installation
Install psims via pip or conda:
```bash
pip install psims
# OR
conda install -c bioconda psims
```

## Core Writing Patterns
The library uses a nested context manager pattern to reflect the hierarchical structure of PSI-MS files.

### Writing mzML
To write mzML files, use the `MzMLWriter`. Always include `controlled_vocabularies()` to ensure the file contains the necessary metadata definitions.

```python
from psims.mzml.writer import MzMLWriter

with MzMLWriter(open("output.mzML", 'wb'), close=True) as out:
    # 1. Define CVs
    out.controlled_vocabularies()
    
    # 2. Define the Run
    with out.run(id="analysis_1"):
        # 3. Define the Spectrum List
        with out.spectrum_list(count=total_scans):
            for scan in scans:
                out.write_spectrum(
                    scan.mz_array, 
                    scan.intensity_array, 
                    id=scan.id, 
                    params=[
                        "MS1 Spectrum", 
                        {"ms level": 1},
                        {"total ion current": sum(scan.intensity_array)}
                    ]
                )
```

### Handling MSn and Precursor Data
When writing tandem mass spectrometry data (MS2, MS3, etc.), use the `precursor_information` argument to link the scan to its parent.

```python
out.write_spectrum(
    mz_array, 
    intensity_array, 
    id=scan_id, 
    params=["MSn Spectrum", {"ms level": 2}],
    precursor_information={
        "mz": precursor_mz,
        "intensity": precursor_intensity,
        "charge": precursor_charge,
        "scan_id": parent_scan_id,
        "activation": ["beam-type collisional dissociation", {"collision energy": 25}],
        "isolation_window": [lower_limit, target_mz, upper_limit]
    }
)
```

## Best Practices
- **Controlled Vocabularies (CV):** Use the standard string names for CV terms. psims automatically maps these to the correct Accession numbers (e.g., "MS1 Spectrum" maps to MS:1000579).
- **Binary Data:** Ensure mz and intensity arrays are passed as NumPy arrays or similar iterables. psims handles the base64 encoding and compression automatically.
- **Context Management:** Always use the `with` statement. This ensures that XML tags are closed in the correct order and file handles are managed safely, even if an error occurs during writing.
- **mzMLb Support:** For very large datasets, consider using `psims.mzmlb.writer.MzMLbWriter` to produce HDF5-based files which offer faster random access and better compression.

## Reference documentation
- [psims GitHub Repository](./references/github_com_mobiusklein_psims.md)
- [Bioconda psims Overview](./references/anaconda_org_channels_bioconda_packages_psims_overview.md)