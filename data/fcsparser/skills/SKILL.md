---
name: fcsparser
description: fcsparser is a Python library designed to parse and extract metadata and event data from flow cytometry standard (FCS) files. Use when user asks to parse FCS files, extract cytometry metadata, or load flow cytometry data into a pandas DataFrame for analysis.
homepage: https://github.com/eyurtsev/fcsparser
---


# fcsparser

## Overview
fcsparser is a lightweight Python library dedicated to parsing FCS files, the standard data format in flow cytometry. It handles the complexities of the FCS binary format, extracting both the metadata (header/text segments) and the raw event data. This tool is particularly useful for researchers who need to programmatically access cytometry data from machines like BD FACSCalibur, LSRFortessa, and MiltenyiBiotec MACSQuant for custom analysis pipelines.

## Installation
The package can be installed via pip or conda:
```bash
pip install fcsparser
# OR
conda install -c conda-forge fcsparser
```

## Basic Usage
The primary entry point is the `parse` function, which returns a tuple containing the metadata dictionary and the event data.

```python
import fcsparser

# Path to your .fcs file
path = "path/to/file.fcs"

# Parse the file
# reformat_meta=True cleans up metadata keys for better readability
meta, data = fcsparser.parse(path, reformat_meta=True)

# 'data' is a pandas DataFrame containing the events
print(data.head())

# 'meta' is a dictionary containing the FCS keywords (e.g., $BEGINANALYSIS, $TOT, etc.)
print(meta['$TOT'])
```

## Expert Tips and Best Practices
- **Metadata Reformatting**: Always set `reformat_meta=True` unless you specifically need the raw, often messy, original FCS keyword strings. This makes the metadata dictionary much easier to navigate.
- **Memory Management**: FCS files can be very large. Since `fcsparser` loads the entire data segment into a Pandas DataFrame, ensure your environment has sufficient RAM for high-event-count files.
- **Data Access**: The returned `data` object is a standard Pandas DataFrame. You can immediately use `.describe()`, `.query()`, or plotting libraries like Seaborn or Matplotlib on this object.
- **Testing**: If you need to verify your environment or script logic without your own data, use the built-in test sample:
  ```python
  path = fcsparser.test_sample_path
  meta, data = fcsparser.parse(path)
  ```
- **Limitations**: Note that `fcsparser` focuses on extraction. It does not natively perform compensation or transformations (like Logicle or Hyperlog). You will need to implement these manually or use a complementary library after the data is loaded into the DataFrame.

## Reference documentation
- [fcsparser GitHub Repository](./references/github_com_eyurtsev_fcsparser.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_fcsparser_overview.md)