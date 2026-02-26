---
name: weblogo
description: Generates sequence logos from multiple sequence alignments. Use when user asks to visualize sequence conservation and patterns in biological sequences.
homepage: https://github.com/WebLogo/weblogo
---


# weblogo

weblogo/SKILL.md
```yaml
name: weblogo
description: Generates sequence logos from multiple sequence alignments. Use when Claude needs to visualize sequence conservation and patterns in biological sequences (DNA, RNA, protein) using the WebLogo tool. This includes creating graphical representations of alignments for publication, analysis, or reporting.
```
## Overview
The WebLogo tool is designed to create visual representations of biological sequence alignments, known as sequence logos. These logos effectively display sequence conservation at each position within an alignment, with the height of symbols indicating the frequency of each amino acid or nucleic acid. This skill provides guidance on using the WebLogo command-line interface for generating these visualizations in various formats.

## Usage Instructions

WebLogo is a command-line tool. The primary command is `weblogo`.

### Basic Usage

The most common way to use `weblogo` is by providing an input sequence alignment file and specifying an output format.

**Input:** WebLogo accepts sequence alignments in various formats, including FASTA and the native WebLogo format.

**Output:** You can specify the output format using the `-f` or `--format` option. Common formats include:
*   `png`: Bitmap image, suitable for on-screen display.
*   `jpeg`: Bitmap image, suitable for on-screen display.
*   `pdf`: Vector format, suitable for printing and further editing.
*   `svg`: Vector format, suitable for printing and further editing.

**Example:** To generate a PNG sequence logo from a file named `alignment.fasta`:

```bash
weblogo -f png alignment.fasta > logo.png
```

### Common Options

*   **`--title <string>`**: Set a title for the sequence logo.
    ```bash
    weblogo -f png --title "My Sequence Alignment" alignment.fasta > logo.png
    ```
*   **`--xlabel <string>`**: Set a label for the x-axis.
    ```bash
    weblogo -f png --xlabel "Position" alignment.fasta > logo.png
    ```
*   **`--ylabel <string>`**: Set a label for the y-axis.
    ```bash
    weblogo -f png --ylabel "Information Content (bits)" alignment.fasta > logo.png
    ```
*   **`--errorbars <on|off>`**: Toggle error bars. Defaults to `on`.
    ```bash
    weblogo -f png --errorbars off alignment.fasta > logo.png
    ```
*   **`--resolution <integer>`**: Set the resolution for bitmap output (e.g., `png`, `jpeg`).
    ```bash
    weblogo -f png --resolution 300 alignment.fasta > logo.png
    ```
*   **`--unit <bits|nats|probability>`**: Set the unit for the y-axis. Defaults to `bits`.
    ```bash
    weblogo -f png --unit probability alignment.fasta > logo.png
    ```

### Advanced Options

*   **Coloring:** WebLogo supports custom coloring schemes. Refer to the WebLogo documentation for details on defining custom colors for specific symbols.
*   **Font:** While not directly configurable via simple CLI flags in basic usage, the tool relies on system fonts. Ensure necessary fonts (like Arial for some systems) are installed if encountering rendering issues.

### Installation Notes

*   WebLogo can be installed via conda: `conda install bioconda::weblogo`.
*   For PDF output, Ghostscript is required on your system. Install it using your system's package manager (e.g., `brew install ghostscript` on macOS, `sudo apt-get install ghostscript` on Ubuntu).

## Expert Tips

*   **Always specify output format:** Explicitly use `-f` or `--format` to ensure you get the desired output file type.
*   **Redirect output:** Use shell redirection (`>`) to save the generated logo to a file.
*   **Combine options:** Most options can be combined to customize the logo precisely.
*   **Consult documentation for complex alignments:** For very large or complex alignments, or for advanced customization like custom color schemes, refer to the official WebLogo documentation.

## Reference documentation
- [WebLogo 3: Sequence Logos redrawn](./references/github_com_gecrooks_weblogo.md)
- [Anaconda.org channels bioconda packages weblogo overview](./references/anaconda_org_channels_bioconda_packages_weblogo_overview.md)