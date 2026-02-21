---
name: pyexcelerator
description: The `pyexcelerator` library is a Python-based tool designed for the programmatic creation and manipulation of Excel spreadsheets.
homepage: http://sourceforge.net/projects/pyexcelerator/
---

# pyexcelerator

## Overview
The `pyexcelerator` library is a Python-based tool designed for the programmatic creation and manipulation of Excel spreadsheets. It excels in environments where Microsoft Excel is not installed, providing a platform-independent API to generate workbooks with support for Unicode, cell styling, and printing options. It also includes utility scripts for extracting data from existing binary XLS files into web-friendly or plain-text formats.

## Usage Guidelines

### Core Capabilities
- **Generation**: Create `.xls` files compatible with Excel 97, 2000, XP, and 2003.
- **Extraction**: Import data from legacy Excel 95 and 97+ formats.
- **Dumping**: Analyze the internal structure of OLE2 compound files and Excel streams.
- **Conversion**: Built-in utilities for transforming binary spreadsheets into accessible formats.

### Common CLI Patterns
The package typically includes several standalone utility scripts for quick data extraction:

- **xls2csv**: Converts a binary XLS file into a Comma Separated Values file.
  ```bash
  xls2csv input_file.xls > output_file.csv
  ```
- **xls2txt**: Extracts raw text content from a spreadsheet.
  ```bash
  xls2txt input_file.xls
  ```
- **xls2html**: Generates an HTML table representation of the spreadsheet data.
  ```bash
  xls2html input_file.xls > report.html
  ```

### Expert Tips
- **Environment**: Since this library is written in pure Python, it is ideal for server-side Linux environments where COM/ActiveX is unavailable.
- **Formatting**: When generating files, you can define `XFStyle` objects to handle fonts, borders, and alignment, though keep in mind that binary XLS formats have strict limits on the number of unique styles allowed.
- **Python Version**: Note that this library was originally designed for Python 2.4+; when using modern Python environments, ensure compatibility or look for the `xlwt` fork if specific legacy behaviors are required.

## Reference documentation
- [pyExcelerator Project Summary](./references/sourceforge_net_projects_pyexcelerator.md)
- [Bioconda pyexcelerator Package Overview](./references/anaconda_org_channels_bioconda_packages_pyexcelerator_overview.md)