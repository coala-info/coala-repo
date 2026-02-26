# nim-abif CWL Generation Report

## nim-abif_abi2fq

### Tool Description
Convert ABI files to FASTQ with quality trimming

### Metadata
- **Docker Image**: quay.io/biocontainers/nim-abif:0.2.0--h7b50bb2_0
- **Homepage**: https://github.com/quadram-institute-bioscience/nim-abif
- **Package**: https://anaconda.org/channels/bioconda/packages/nim-abif/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/nim-abif/overview
- **Total Downloads**: 379
- **Last updated**: 2025-04-29
- **GitHub**: https://github.com/quadram-institute-bioscience/nim-abif
- **Stars**: N/A
### Original Help Text
```text
Error: Input file required
abi2fq - Convert ABI files to FASTQ with quality trimming

Usage:
  abi2fq [options] <input.ab1> [output.fq]

Options:
  -h, --help                 Show this help message
  -w, --window=INT           Window size for quality trimming (default: 10)
  -q, --quality=INT          Quality threshold 0-60 (default: 20)
  -n, --no-trim              Disable quality trimming
  -v, --verbose              Print additional information
  --version                  Show version information

If output file is not specified, FASTQ will be written to STDOUT.
```


## nim-abif_abimerge

### Tool Description
Merge forward and reverse AB1 trace files

### Metadata
- **Docker Image**: quay.io/biocontainers/nim-abif:0.2.0--h7b50bb2_0
- **Homepage**: https://github.com/quadram-institute-bioscience/nim-abif
- **Package**: https://anaconda.org/channels/bioconda/packages/nim-abif/overview
- **Validation**: PASS

### Original Help Text
```text
Error: Both forward and reverse input files are required
abimerge - Merge forward and reverse AB1 trace files

Usage:
  abimerge [options] <input_F.ab1> <input_R.ab1> [output.fastq]

Options:
  -h, --help                 Show this help message
  -m, --min-overlap INT      Minimum overlap length for merging (default: 20)
  -o, --output STRING        Output file name (default: STDOUT)
  -j, --join INT             If no overlap is detected join the two sequences with a gap of INT Ns
                             (reverse complement the second sequence)
  Quality Trimming Options:
  -w, --window=INT           Window size for quality trimming (default: 4)
  -q, --quality=INT          Quality threshold 0-60 (default: 22)
  -n, --no-trim              Disable quality trimming

  Smith-Waterman options:
   --score-match INT         Score for a match [default: 10]
   --score-mismatch INT      Score for a mismatch [default: -8]
   --score-gap INT           Score for a gap [default: -10]
   --min-score INT           Minimum alignment score [default: 80]
   --pct-id FLOAT            Minimum percentage of identity [default: 85]
   -v, --verbose             Print additional information
   --version                 Show version information
```


## nim-abif_abichromatogram

### Tool Description
Generates an SVG chromatogram from an ABIF trace file,
displaying the four fluorescence channels with base calls.

### Metadata
- **Docker Image**: quay.io/biocontainers/nim-abif:0.2.0--h7b50bb2_0
- **Homepage**: https://github.com/quadram-institute-bioscience/nim-abif
- **Package**: https://anaconda.org/channels/bioconda/packages/nim-abif/overview
- **Validation**: PASS

### Original Help Text
```text
ABIF Chromatogram Generator
Version: 0.2.0

Usage: abichromatogram <trace_file.ab1> [options]

Description:
  Generates an SVG chromatogram from an ABIF trace file,
  displaying the four fluorescence channels with base calls.

Options:
  -o, --output FILE       Output SVG file (default: chromatogram.svg)
  -w, --width WIDTH       SVG width in pixels (default: 1200)
      --height HEIGHT     SVG height in pixels (default: 600)
  -s, --start POS         Start position (default: 0)
  -e, --end POS           End position (default: whole trace)
  -d, --downsample FACTOR Downsample factor for smoother visualization (default: 1)
      --hide-bases        Hide base calls
      --debug             Show debug information
  -h, --help              Show this help message and exit
  -v, --version           Show version information and exit

Examples:
  abichromatogram input.ab1
  abichromatogram input.ab1 -o output.svg -d 5
  abichromatogram input.ab1 -s 500 -e 1000 --width 1600
```

