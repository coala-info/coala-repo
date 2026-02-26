# bamaligncleaner CWL Generation Report

## bamaligncleaner_bamAlignCleaner

### Tool Description
removes unaligned references in BAM/CRAM alignment files

### Metadata
- **Docker Image**: quay.io/biocontainers/bamaligncleaner:0.3--pyhdfd78af_0
- **Homepage**: https://github.com/maxibor/bamAlignCleaner
- **Package**: https://anaconda.org/channels/bioconda/packages/bamaligncleaner/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bamaligncleaner/overview
- **Total Downloads**: 5.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/maxibor/bamAlignCleaner
- **Stars**: N/A
### Original Help Text
```text
Usage: bamAlignCleaner [OPTIONS] BAM

  bamAlignCleaner: removes unaligned references in BAM/CRAM alignment files
  * Homepage: https://github.com/maxibor/bamAlignCleaner
  * Author: Maxime Borry

  BAM: BAM alignment file (sorted, and optionally indexed)

Options:
  --version                       Show the version and exit.
  -m, --method [parse|index_stat]
                                  unaligned reference removal method
                                  [default: parse]
  -r, --reflist PATH              File listing references to keep in output
                                  bam
  -o, --output FILE               filtered bam file [default: STDOUT]
  --help                          Show this message and exit.
```

