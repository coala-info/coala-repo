# wgatools CWL Generation Report

## wgatools_validate

### Tool Description
Validate and fix query&target position in PAF file by CIGAR

### Metadata
- **Docker Image**: quay.io/biocontainers/wgatools:1.1.0--hf6a8760_0
- **Homepage**: https://github.com/wjwei-handsome/wgatools
- **Package**: https://anaconda.org/channels/bioconda/packages/wgatools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/wgatools/overview
- **Total Downloads**: 4.1K
- **Last updated**: 2025-11-06
- **GitHub**: https://github.com/wjwei-handsome/wgatools
- **Stars**: N/A
### Original Help Text
```text
Validate and fix query&target position in PAF file by CIGAR
Examples:
wgatools validate wrong.paf // output report to STDOUT
wgatools validate wrong.paf -f happy.paf -o fix.report

Usage: wgatools validate [OPTIONS] [INPUT]

Arguments:
  [INPUT]  Input PAF File, None for STDIN

Options:
  -f, --fix <FIX>  Fixed output file, None for NOT FIX, `-` will mix newoutput & information
  -h, --help       Print help

GLOBAL:
  -o, --outfile <OUTFILE>  Output file ("-" for stdout), file name ending in .gz/.bz2/.xz will be compressed automatically [default: -]
  -r, --rewrite            Bool, if rewrite output file [default: false]
  -t, --threads <THREADS>  Threads, default 1 [default: 1]
  -v, --verbose...         Logging level [-v: Info, -vv: Debug, -vvv: Trace, defalut: Warn]
```

## Metadata
- **Skill**: generated
