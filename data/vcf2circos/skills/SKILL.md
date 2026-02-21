---
name: vcf2circos
description: vcf2circos is a Python-based tool that leverages Plotly to transform genomic data from VCF files into circular Circos plots.
homepage: https://github.com/bioinfo-chru-strasbourg/vcf2circos
---

# vcf2circos

## Overview
vcf2circos is a Python-based tool that leverages Plotly to transform genomic data from VCF files into circular Circos plots. It supports major genome assemblies including hg19, hg38, mm9, and mm10. The tool is designed to handle complex genomic features like structural variants and can be highly customized via JSON configuration files to control plot aesthetics, chromosome selection, and variant annotations.

## Installation and Setup
The tool can be installed via Bioconda or by cloning the repository:
- **Conda**: `conda install bioconda::vcf2circos`
- **Pip**: `pip install vcf2circos` (after cloning the source)

## Command Line Usage
The basic syntax for running vcf2circos is:
```bash
vcf2circos -i <input.vcf> -o <output_file> -a <assembly>
```

### Common CLI Patterns
- **Generate an interactive HTML plot**:
  `vcf2circos -i sample.vcf -o results.html -a hg38`
- **Generate a static PDF for publication**:
  `vcf2circos -i sample.vcf -o figure1.pdf -a hg19`
- **Use a custom configuration file**:
  `vcf2circos -i sample.vcf -p options.json -o plot.png -a mm10`
- **Export VCF data to JSON format**:
  `vcf2circos -i sample.vcf -e data_export.json -o plot.html -a hg38`

## Expert Tips and Best Practices

### VCF Pre-processing
vcf2circos requires VCF files to be multiallelic split to ensure all variants are processed correctly. Use `bcftools` to prepare your file:
```bash
bcftools -m -any input.vcf -o split_input.vcf
```

### VCF Header Requirements
Ensure your VCF header contains `##contig` definitions. The tool uses these definitions to determine the order of appearance for chromosomes in the plot.

### Output Formats
The tool autodetects the output format based on the file extension. Supported formats include:
- **Interactive**: `.html` (supports hover text and zooming)
- **Static Images**: `.png`, `.jpg`, `.webp`, `.svg`, `.pdf`, `.eps`
- **Data**: `.json` (Plotly JSON format)

### Configuration via JSON
To customize the plot beyond the defaults, provide a JSON file with the `-p` flag. Key sections include:
- **General**: Set `title`, `width`, `height`, and `plot_bgcolor`.
- **Chromosomes**: Use the `list` key to specify exactly which chromosomes to display (e.g., `["chr1", "chr2", "chrX"]`).
- **Variants**: Configure `annotations` to specify which VCF INFO fields (like `Gene_name` or `SVLEN`) should appear in hover text.

### Handling Custom Assemblies
If using an assembly not provided by default, you must create the required assembly data (genes, exons, transcripts, and cytobands) using the `utils.py` script provided in the package source. This involves processing UCSC `ncbiRefSeqCurated` and `chromInfo` files.

## Reference documentation
- [vcf2circos GitHub Repository](./references/github_com_bioinfo-chru-strasbourg_vcf2circos.md)
- [vcf2circos Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_vcf2circos_overview.md)