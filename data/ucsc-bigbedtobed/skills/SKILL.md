---
name: ucsc-bigbedtobed
description: This tool converts binary BigBed files into text-based BED format. Use when user asks to convert BigBed to BED, extract genomic regions from a BigBed file, or stream remote BigBed data to standard output.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
metadata:
  docker_image: "quay.io/biocontainers/ucsc-bigbedtobed:482--h0b57e2e_0"
---

# ucsc-bigbedtobed

## Overview
`bigBedToBed` is a specialized utility from the UCSC Genome Browser "Kent" toolset designed to decompress and convert BigBed files back into their original BED format. BigBed files are the indexed, binary version of BED files, optimized for fast remote access and large datasets. This tool allows you to recover the text data or extract specific subsets of features based on genomic regions (chromosome, start, and end positions) without needing to process the entire file.

## Common CLI Patterns

### Basic Conversion
To convert an entire BigBed file to a standard BED file:
```bash
bigBedToBed input.bb output.bed
```

### Extracting Specific Regions
One of the most efficient uses of `bigBedToBed` is extracting data from a specific genomic window. This is significantly faster than converting the whole file and then using `grep` or `awk`.
```bash
bigBedToBed -chrom=chr1 -start=100000 -end=200000 input.bb output.bed
```

### Working with Remote Files
UCSC utilities natively support HTTP, HTTPS, and FTP URLs. You can stream data from a remote server (like the UCSC Genome Browser's hgdownload) directly to a local BED file:
```bash
bigBedToBed https://hgdownload.soe.ucsc.edu/gbdb/hg38/bbi/clinvar/clinvarMain.bb output.bed
```

### Limiting Output
If you only need a sample of the data or want to prevent creating an excessively large file, use the `-maxItems` flag:
```bash
bigBedToBed -maxItems=100 input.bb output.bed
```

## Expert Tips and Best Practices

### Performance and Caching
When working with remote files repeatedly, use the `-udcDir` option to specify a local cache directory. This prevents redundant network requests for the same file headers and indices.
```bash
bigBedToBed -udcDir=/tmp/ucsc_cache http://url/to/file.bb output.bed
```

### Permission Errors
If you have downloaded the binary directly from the UCSC servers, you must ensure it has execution permissions before running:
```bash
chmod +x bigBedToBed
./bigBedToBed input.bb output.bed
```

### Identifying BigBed Metadata
Before conversion, if you are unsure about the contents or the number of fields in the BigBed file, use the companion tool `bigBedInfo` to view the file's schema and summary statistics.

### Pipe to Standard Output
To stream the BED output directly into another tool (like `head` or a custom script) without creating an intermediate file, use `stdout` as the output filename:
```bash
bigBedToBed input.bb stdout | head -n 20
```



## Subcommands

| Command | Description |
|---------|-------------|
| bigBedInfo | Show information about a bigBed file. |
| bigBedToBed | Convert from bigBed to ascii bed format. |

## Reference documentation
- [UCSC Genome Browser Kent Wiki](./references/github_com_ucscGenomeBrowser_kent_wiki.md)
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Linux x86_64 Binaries List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)