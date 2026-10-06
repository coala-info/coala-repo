# bigwig-nim CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| bigwig-nim_stats | PASS |  |
| bigwig-nim_view | PASS |  |

## bigwig-nim_view

### Tool Description
view and convert bigwig

### Metadata
- **Docker Image**: quay.io/biocontainers/bigwig-nim:0.0.3--h9ee0642_0
- **Homepage**: https://github.com/brentp/bigwig-nim
- **Package**: https://anaconda.org/channels/bioconda/packages/bigwig-nim/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bigwig-nim/overview
- **Total Downloads**: 248
- **Last updated**: 2025-07-22
- **GitHub**: https://github.com/brentp/bigwig-nim
- **Stars**: N/A

### Original Help Text
```text
bigwig view

Usage:
  bigwig view [options] input

Arguments:
  input

Options:
  -r, --region=REGION        optional chromosome, or chrom:start-stop region to view
  -c, --chrom-sizes=CHROM_SIZES
                             file indicating chromosome sizes (can be .fai), only used for converting BED->BigWig
  -i, --value-column=VALUE_COLUMN
                             column-number (1-based) of the value to encode in to BigWig, only used for encoding BED->BigWig (default: 4)
  -O, --output-fmt=OUTPUT_FMT
                             output format Possible values: [bed, bigwig] (default: bed)
  -o, --output-file=OUTPUT_FILE
                             output bed or bigwig file (default: /dev/stdout)
  -h, --help                 Show this help
```

## bigwig-nim_stats

### Tool Description
extract stats (mean, coverage, min, max, sum) for regions in a bigwig

### Metadata
- **Docker Image**: quay.io/biocontainers/bigwig-nim:0.0.3--h9ee0642_0
- **Homepage**: https://github.com/brentp/bigwig-nim
- **Package**: https://anaconda.org/channels/bioconda/packages/bigwig-nim/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bigwig-nim/overview
- **Total Downloads**: 248
- **Last updated**: 2025-07-22
- **GitHub**: https://github.com/brentp/bigwig-nim
- **Stars**: N/A

### Original Help Text
```text
bigwig view

Usage:
  bigwig view [options] input region

Arguments:
  input
  region           BED file or regions or chromosome, or chrom:start-stop region to extract stats

Options:
  -s, --stat=STAT            statistic to output. 'header' will show the lengths, mean and coverage for each chromosome in the bigwig. Possible values: [mean, coverage, min, max, sum, header] (default: mean)
  --bins=BINS                integer number of bins (default: 1)
  -h, --help                 Show this help
bigwig view

Usage:
  bigwig view [options] input region

Arguments:
  input
  region           BED file or regions or chromosome, or chrom:start-stop region to extract stats

Options:
  -s, --stat=STAT            statistic to output. 'header' will show the lengths, mean and coverage for each chromosome in the bigwig. Possible values: [mean, coverage, min, max, sum, header] (default: mean)
  --bins=BINS                integer number of bins (default: 1)
  -h, --help                 Show this help
```

