---
name: igv-reports
description: The `igv-reports` tool is a Python-based utility designed to transform genomic site lists (VCF, BED, MAF) into interactive, standalone HTML documents.
homepage: https://github.com/igvteam/igv-reports
---

# igv-reports

## Overview
The `igv-reports` tool is a Python-based utility designed to transform genomic site lists (VCF, BED, MAF) into interactive, standalone HTML documents. It works by "slicing" small regions of data from large genomic files and embedding them directly into the HTML page as Data URIs. This makes the resulting report completely independent of its source files, allowing it to be shared via email or hosted on simple web servers while still providing a fully functional IGV.js browser interface for visual inspection of variants.

## Installation
The tool can be installed via pip or conda:
```bash
pip install igv-reports
# OR
conda install -c bioconda igv-reports
```

## Core CLI Usage
The primary command is `create_report`. At a minimum, you must provide a sites file and a reference genome.

### Basic VCF Report
To create a report from a VCF with an alignment track:
```bash
create_report variants.vcf --genome hg38 --tracks alignments.bam --output report.html
```

### Using Generic Tab-Delimited Files
If your input is not a standard format (like VCF or BED), you must specify the column indices (1-based):
```bash
create_report sites.txt --sequence 1 --begin 2 --end 3 --genome hg19 --output report.html
```

### Customizing Table Columns
Control which metadata fields appear in the variant table using `--info-columns`:
```bash
create_report variants.vcf --genome hg38 --info-columns AF QUAL DP --tracks alignments.bam
```

## Expert Tips and Best Practices

### Managing File Size
Because data is embedded directly into the HTML, reports can become large if not optimized:
- **Subsampling**: Use `--subsample 0.1` to include only 10% of reads, which is often sufficient for visual verification while significantly reducing file size.
- **Flanking Regions**: The default flanking region is 1000bp. Reduce this with `--flanking 500` if you only need to see the immediate context of a SNV.
- **Exclude Flags**: Use `--exclude-flags` (passed to samtools) to filter out secondary or duplicate alignments. The default is 1536.

### Visualizing Structural Variants (SVs)
For large deletions or translocations, use `--maxlen` to control the view:
- Variants longer than the `--maxlen` value (default 10,000bp) will automatically trigger a **split-screen (multi-locus) view**, showing the start and end breakpoints side-by-side.

### Advanced Track Configuration
For complex track styling (colors, height, visibility), use a JSON configuration file:
```bash
create_report sites.vcf --genome hg38 --track-config tracks.json
```
The `tracks.json` should contain an array of igv.js track configuration objects.

### Offline Portability
By default, the report loads the IGV.js library from a CDN. To make the report work in environments with no internet access, use the `--standalone` flag to embed the JavaScript source code directly into the HTML.

### Performance
Always use **Tabix-indexed** VCF and BED files for the `--sites` argument. This allows `igv-reports` to quickly jump to the relevant genomic coordinates without reading the entire file into memory.

## Reference documentation
- [igv-reports GitHub README](./references/github_com_igvteam_igv-reports.md)
- [igv-reports Wiki](./references/github_com_igvteam_igv-reports_wiki.md)