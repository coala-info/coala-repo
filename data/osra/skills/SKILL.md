---
name: osra
description: OSRA translates visual chemical diagrams from images or PDF documents into computational molecular formats like SMILES or SDF. Use when user asks to convert chemical structure images to machine-readable strings, extract molecular data from PDFs, or perform optical structure recognition on scanned documents.
homepage: http://cactus.nci.nih.gov/osra/
---


# osra

## Overview
OSRA (Optical Structure Recognition Application) is a command-line utility that translates visual chemical diagrams into computational molecular formats. It supports over 90 graphical input formats (including PNG, JPEG, TIFF, and PDF) and outputs standard strings or files used in chemoinformatics. Because optical recognition is not perfect, OSRA is best used as a high-throughput extraction tool followed by human verification.

## Usage Patterns

### Basic Conversion
To convert an image to a SMILES string (default output):
```bash
osra structure.png
```

To specify a different output format, such as SDF:
```bash
osra -f sdf structure.jpg
```

### Processing PDF Documents
When working with PDFs, it is often necessary to specify the resolution and page number to ensure accurate recognition.
```bash
# Process a specific page with high resolution
osra -r 300 -e 5 document.pdf
```

### Advanced Processing Options
*   **Resolution**: Use `-r` or `--resolution` (e.g., 300) for high-quality results, especially for scanned documents.
*   **Rotation**: Use `-R` or `--rotate` if the input image is not oriented correctly.
*   **Pre-processing**: Use `-u` to enable the `unpaper` routine, which cleans up scanned sheets before performing recognition.
*   **Metadata**: Use `-e` or `--page` to include page numbers in the output for multi-page documents.

## Best Practices
*   **Resolution Matters**: For most journal articles and patents, a resolution of 300 DPI is the "sweet spot" for balancing speed and accuracy.
*   **Format Support**: OSRA relies on GraphicsMagick; if a file format is readable by GraphicsMagick, OSRA can likely process it.
*   **Human Curation**: Always treat OSRA output as a draft. Chemical structures with complex stereochemistry or unusual bond angles are prone to OCR errors.
*   **Low Contrast**: For low-light or low-contrast images, OSRA 1.3.8+ includes adaptive thresholding to improve recognition.

## Reference documentation
- [OSRA: Optical Structure Recognition](./references/cactus_nci_nih_gov_osra.md)
- [osra - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_osra_overview.md)