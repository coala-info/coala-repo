---
name: ucsc-bigwigaverageoverbed
description: The tool calculates the average signal from a BigWig file over genomic regions defined in a BED file. Use when user asks to calculate average expression, quantify binding levels, or get signal statistics for genomic features.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---


# ucsc-bigwigaverageoverbed

## Overview
The `bigWigAverageOverBed` utility is a high-performance tool from the UCSC Genome Browser "kent" suite designed to aggregate BigWig signal data over regions specified in a BED file. It is uniquely capable of handling BED files with multiple blocks (such as exons in a gene), ensuring that signal is only averaged over the defined blocks rather than the entire span from start to end. This makes it the standard tool for calculating average expression or binding levels across spliced transcripts or specific genomic features.

## Command Line Usage

The basic syntax for the tool is:

```bash
bigWigAverageOverBed input.bw input.bed output.tab
```

### Output Format
The output is a tab-separated file containing six columns by default:
1.  **name**: The name field from the BED file.
2.  **size**: The total number of bases in the BED features (sum of block sizes).
3.  **covered**: The number of bases in the BED feature that have data in the BigWig file.
4.  **sum**: The sum of the BigWig values over all covered bases.
5.  **mean0**: The average value over all bases in the BED feature (sum/size).
6.  **mean**: The average value over only the covered bases (sum/covered).

### Common Options
- `-stats=output.stats`: Create a summary statistics file.
- `-bedOut=output.bed`: Create a BED file that includes the average score in the score column.
- `-sample=N`: Sample every Nth base (useful for very large regions to increase speed).
- `-minMax`: Include minimum and maximum values in the output.

## Expert Tips and Best Practices

### Handling Introns and Blocks
If your BED file contains 12 columns (BED12), `bigWigAverageOverBed` automatically respects the `blockSizes` and `blockStarts` fields. It will only calculate the average signal for the exons, ignoring the intronic regions between blocks.

### Unique Identifiers
The tool uses the 4th column of the BED file (the name field) to identify rows in the output. Ensure your BED file has unique names for every entry; otherwise, the output may be difficult to parse or entries may be aggregated unexpectedly depending on the version.

### Chromosome Naming
Ensure that the chromosome names in your BigWig file exactly match those in your BED file (e.g., "chr1" vs "1"). If they do not match, the tool will report zero coverage for those regions. You can check BigWig chromosome names using `bigWigInfo -chroms`.

### Performance for Large Datasets
`bigWigAverageOverBed` is highly optimized for speed and memory. It is significantly faster than using general-purpose tools like `bedtools map` for BigWig data because it leverages the indexed structure of the BigWig format to perform random access.

### Installation and Setup
The tool is available via Bioconda. If downloading the binary directly from UCSC, remember to set execution permissions:
```bash
chmod +x bigWigAverageOverBed
```

## Reference documentation
- [ucsc-bigwigaverageoverbed - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_ucsc-bigwigaverageoverbed_overview.md)
- [Index of /admin/exe](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Index of /admin/exe/linux.x86_64](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)