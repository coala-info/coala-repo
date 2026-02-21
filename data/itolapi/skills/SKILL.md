---
name: itolapi
description: The `itolapi` skill enables automated interaction with the Interactive Tree of Life (iTOL) web service.
homepage: https://github.com/albertyw/itolapi
---

# itolapi

## Overview
The `itolapi` skill enables automated interaction with the Interactive Tree of Life (iTOL) web service. It allows for the programmatic upload of phylogenetic tree files and the subsequent export of those trees into publication-ready graphical formats or data files. This is particularly useful for bioinformatics pipelines that require consistent tree visualization or batch processing of tree exports.

## Installation
Install the tool via pip or conda:
```bash
pip install itolapi
# OR
conda install bioconda::itolapi
```

## Command Line Usage

### Uploading Trees
Use `itol.py` for basic uploads. Note that complex tree styling usually requires the Python API.
```bash
itol.py /path/to/tree_file.nwk
```
The command will output a URL to the uploaded tree if successful.

### Exporting Trees
Use `itolexport.py` to download a tree by its ID.
```bash
itolexport.py TREEID OUTPUT_FILE FORMAT [OPTIONS]
```
- **Formats**: `png`, `svg`, `eps`, `ps`, `pdf`, `nexus`, `newick`
- **Options**:
  - `-d`: Show datasets
  - `-v`: Verbose output

## Python API Best Practices

### Uploading with Parameters
The Python API is more flexible than the CLI for setting tree metadata.
```python
from itolapi import Itol
from pathlib import Path

itol_uploader = Itol()
itol_uploader.add_file(Path('my_tree.nwk'))
itol_uploader.params['treeName'] = 'Project_Alpha_Tree'
# Set other parameters in the .params dictionary
status = itol_uploader.upload()

if status:
    print(f"Tree ID: {itol_uploader.comm.tree_id}")
    print(f"URL: {itol_uploader.get_webpage()}")
```

### Advanced Exporting
Use `ItolExport` to customize the visual output (colors, labels, etc.) by passing parameters defined in the iTOL API documentation.
```python
from itolapi import ItolExport

itol_exporter = ItolExport()
itol_exporter.add_export_param_value('tree', '1234567890')
itol_exporter.add_export_param_value('format', 'pdf')
itol_exporter.add_export_param_value('display_mode', '2')  # Circular mode
itol_exporter.export(Path('visualized_tree.pdf'))
```

## Expert Tips
- **Subscription Requirements**: Be aware that iTOL requires a paid subscription for batch uploads. Single uploads via the API remain functional for standard accounts.
- **Parameter Keys**: Valid keys for `add_export_param_value` correspond exactly to the options available on the iTOL web export page (e.g., `line_width`, `font_size`, `ignore_branch_length`).
- **Connection**: An active internet connection is required as the tool communicates directly with `itol.embl.de`.
- **Output Verification**: Always check the `status` return value of the `upload()` method; a `False` value indicates a failed upload, often due to malformed tree files or connection issues.

## Reference documentation
- [itolapi GitHub README](./references/github_com_albertyw_itolapi.md)
- [itolapi Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_itolapi_overview.md)