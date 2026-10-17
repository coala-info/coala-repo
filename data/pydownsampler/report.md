# pydownsampler CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| pydownsampler | PASS |  |

## pydownsampler

### Tool Description
Downsample a BAM/SAM/CRAM file to a desired average coverage, or print the average coverage of the file.

### Metadata
- **Docker Image**: quay.io/biocontainers/pydownsampler:1.0--py_0
- **Homepage**: https://github.com/LindoNkambule/pydownsampler
- **Package**: https://anaconda.org/channels/bioconda/packages/pydownsampler/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pydownsampler/overview
- **Total Downloads**: 2.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/LindoNkambule/pydownsampler
- **Stars**: N/A
### Original Help Text
```text
pydownsampler

Usage:
  pydownsampler (<file>) [-d <dcov>]
  pydownsampler (<file>) [-d <dcov>] [-o <output>]
  pydownsampler (<file>) [-c]
  pydownsampler [-h] | [--help]
  pydownsampler [-v] [--version]

Arguments:
  file                   BAM/SAM/CRAM file to be downsampled (Required argument)

Options:
  -h --help             Show this screen.
  -v --version          Show version.
  -d --downcoverage     The coverage you want to downsample to (Required argument)
  -o --output           Output filename prefix (Optional)
  -c --coverage         Print out average coverage for file
```

