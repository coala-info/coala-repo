---
name: pdfkit
description: pdfkit converts HTML content, URLs, or local files into PDF documents using the wkhtmltopdf rendering engine. Use when user asks to generate PDFs from web pages, convert HTML strings to PDF files, or batch process multiple URLs into a single document.
homepage: https://pypi.python.org/pypi/pdfkit
metadata:
  docker_image: "quay.io/biocontainers/pdfkit:0.6.1--py35_0"
---

# pdfkit

## Overview
pdfkit is a Python wrapper for the wkhtmltopdf utility, which uses the Webkit rendering engine to transform HTML into PDF. This skill enables the generation of PDF documents from three primary sources: live URLs, local HTML files, or raw HTML strings. It supports complex layouts, external CSS, and specific PDF features like Tables of Contents (TOC) and cover pages.

## Core Implementation
The library provides three main entry points. If an output path is not provided, the functions return the PDF content as a byte string.

```python
import pdfkit

# From a URL
pdfkit.from_url('http://google.com', 'out.pdf')

# From a local file
pdfkit.from_file('test.html', 'out.pdf')

# From a string
pdfkit.from_string('Hello!', 'out.pdf')

# Batch processing (merges multiple inputs into one PDF)
pdfkit.from_url(['google.com', 'yandex.ru'], 'out.pdf')
```

## Configuration and Environment
pdfkit requires the `wkhtmltopdf` binary to be installed on the system. If the binary is not in the system PATH, you must specify its location manually.

```python
config = pdfkit.configuration(wkhtmltopdf='/path/to/wkhtmltopdf')
pdfkit.from_string(html_content, 'output.pdf', configuration=config)
```

## Advanced Options and Styling
You can pass a dictionary of options that correspond to wkhtmltopdf command-line flags. Drop the leading dashes from the option names.

```python
options = {
    'page-size': 'Letter',
    'margin-top': '0.75in',
    'encoding': "UTF-8",
    'no-outline': None,
    'custom-header': [('Accept-Encoding', 'gzip')],
    'cookie': [('cookie-name', 'cookie-value')]
}

# Injecting external CSS (useful for from_string or from_file)
pdfkit.from_file('file.html', 'out.pdf', options=options, css='styles.css')
```

## Special Elements: TOC and Covers
Due to the underlying command syntax, Table of Contents and Cover pages are handled via specific parameters.

```python
toc = {'xsl-style-sheet': 'toc.xsl'}
cover = 'cover.html'

pdfkit.from_file('content.html', 'out.pdf', toc=toc, cover=cover, cover_first=True)
```

## Troubleshooting and Best Practices
- **Verbose Output**: If PDF generation fails or looks incorrect, enable verbose mode to see the underlying wkhtmltopdf logs: `pdfkit.from_url(url, 'out.pdf', verbose=True)`.
- **Binary Limitations**: Standard Debian/Ubuntu repository versions of `wkhtmltopdf` often have reduced functionality (no TOC/headers/footers) because they lack QT patches. Use static binaries for full feature support.
- **HTML Meta Tags**: You can specify options directly in the HTML source using meta tags: `<meta name="pdfkit-page-size" content="Legal"/>`.

## Reference documentation
- [pdfkit · PyPI](./references/pypi_org_project_pdfkit.md)
- [pdfkit - bioconda](./references/anaconda_org_channels_bioconda_packages_pdfkit_overview.md)