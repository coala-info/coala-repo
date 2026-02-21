---
name: sequenticon
description: Sequenticon is a specialized utility designed to transform DNA sequences into unique, colorful icons (identicons).
homepage: https://github.com/Edinburgh-Genome-Foundry/sequenticon
---

# sequenticon

## Overview
Sequenticon is a specialized utility designed to transform DNA sequences into unique, colorful icons (identicons). This provides a robust visual method for identifying sequences, where even a single nucleotide difference produces a distinct visual pattern. It is primarily used to verify sequence versions in large datasets and to generate printable labels for biological tubes, making human identification of samples faster and less error-prone than reading text labels.

## Usage Instructions

### Core Python API
The tool is primarily used as a Python library. Ensure `sequenticon` is installed via pip or conda before execution.

**Single Sequence Generation**
Generate a standalone image file or an HTML-ready string:
```python
from sequenticon import sequenticon

# Generate a PNG file
sequenticon("ATGGTGCA", size=120, output_path="sequence_icon.png")

# Generate an HTML <img> tag for web embedding
img_tag = sequenticon("ATGGTGCA", size=60, output_format="html_image")
```

**Batch Processing**
Process multiple sequences simultaneously. The tool accepts lists of tuples, file paths (GenBank/FASTA), or Biopython records.
```python
from sequenticon import sequenticon_batch, sequenticon_batch_pdf

sequences = [("seq1", "ATTGTG"), ("seq2", "TAAATGCC")]
# Or use file paths: sequences = ["record1.gb", "record2.fa"]

# Export a folder of PNGs
sequenticon_batch(sequences, size=120, output_path="output_folder/")

# Generate a consolidated PDF report
sequenticon_batch_pdf(sequences, "sequencing_report.pdf")
```

### Best Practices and Expert Tips
- **Visual Consistency**: Always specify a consistent `size` parameter across a single project. While the pattern remains unique, varying sizes can make side-by-side human comparison more difficult.
- **Input Flexibility**: Use the batch functions to handle mixed inputs. Sequenticon automatically detects whether an input is a raw string, a file path, or a Biopython SeqRecord.
- **In-Memory PDF Generation**: For web applications or automated pipelines, `sequenticon_batch_pdf` can accept `None` as a target to handle the output in-memory (depending on version support).
- **Error Prevention**: Use sequenticons as a "visual checksum." When comparing two files that should be identical (e.g., `pLac_v1.gb` and `pLac_final.gb`), generating their icons is often faster and more intuitive for a human operator than running a `diff` on the sequence strings.
- **Label Printing**: When generating icons for physical tube labels, a size of 60-100 pixels is typically sufficient for high-resolution thermal or laser printers.

## Reference documentation
- [Sequenticon GitHub Repository](./references/github_com_Edinburgh-Genome-Foundry_sequenticon.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_sequenticon_overview.md)