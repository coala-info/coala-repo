# sizemeup CWL Generation Report

## sizemeup

### Tool Description
A simple tool to determine the genome size of an organism

### Metadata
- **Docker Image**: quay.io/biocontainers/sizemeup:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/rpetit3/sizemeup
- **Package**: https://anaconda.org/channels/bioconda/packages/sizemeup/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sizemeup/overview
- **Total Downloads**: 4.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/rpetit3/sizemeup
- **Stars**: N/A
### Original Help Text
```text
Usage: sizemeup-main [OPTIONS]                                                 
                                                                                
 sizemeup - A simple tool to determine the genome size of an organism           
                                                                                
╭─ Required Options ───────────────────────────────────────────────────────────╮
│ *  --query  -q  TEXT  The species name or taxid to determine the size of     │
│                       [required]                                             │
│ *  --sizes  -z  TEXT  The built in sizes file to use                         │
│                       [default:                                              │
│                       /usr/local/bin/../share/sizemeup/sizemeup-sizes.txt]   │
│                       [required]                                             │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Additional Options ─────────────────────────────────────────────────────────╮
│ --outdir   -o  PATH  Directory to write output [default: ./]                 │
│ --prefix   -p  TEXT  Prefix to use for output files [default: sizemeup]      │
│ --silent             Only critical errors will be printed                    │
│ --verbose            Increase the verbosity of output                        │
│ --version  -V        Show the version and exit.                              │
│ --help               Show this message and exit.                             │
╰──────────────────────────────────────────────────────────────────────────────╯
```

