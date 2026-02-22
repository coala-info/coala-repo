# flexiformatter CWL Generation Report

## flexiformatter_main

### Tool Description
Process BAM/SAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/flexiformatter:1.0.6--pyhdfd78af_0
- **Homepage**: https://github.com/ljwharbers/flexiformatter
- **Package**: https://anaconda.org/channels/bioconda/packages/flexiformatter/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/flexiformatter/overview
- **Total Downloads**: 958
- **Last updated**: 2026-01-02
- **GitHub**: https://github.com/ljwharbers/flexiformatter
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
/usr/local/lib/python3.14/site-packages/simplesam.py:23: UserWarning: pkg_resources is deprecated as an API. See https://setuptools.pypa.io/en/latest/pkg_resources.html. The pkg_resources package is slated for removal as early as 2025-11-30. Refrain from using this package or pin to Setuptools<81.
  from pkg_resources import get_distribution
╭───────────────────── Traceback (most recent call last) ──────────────────────╮
│ /usr/local/lib/python3.14/site-packages/flexiformatter/reformat_flexiplex_ta │
│ gs.py:26 in callback                                                         │
│                                                                              │
│   23 │                                                                       │
│   24 │   if ctx.invoked_subcommand is None and infile is not None:           │
│   25 │   │   # If no subcommand is invoked and 'infile' is given, call 'main │
│ ❱ 26 │   │   main(infile)                                                    │
│   27                                                                         │
│   28 @app.command()                                                          │
│   29 def main(infile: str):                                                  │
│                                                                              │
│ ╭──────────────────────── locals ─────────────────────────╮                  │
│ │     ctx = <click.core.Context object at 0x764ef364cad0> │                  │
│ │  infile = 'main'                                        │                  │
│ │ version = None                                          │                  │
│ ╰─────────────────────────────────────────────────────────╯                  │
│                                                                              │
│ /usr/local/lib/python3.14/site-packages/flexiformatter/reformat_flexiplex_ta │
│ gs.py:31 in main                                                             │
│                                                                              │
│   28 @app.command()                                                          │
│   29 def main(infile: str):                                                  │
│   30 │   """Process BAM/SAM file."""                                         │
│ ❱ 31 │   with simplesam.Reader(open(infile)) as in_bam:                      │
│   32 │   │   with simplesam.Writer(sys.stdout, in_bam.header) as out_sam:    │
│   33 │   │   │   for read in in_bam:                                         │
│   34                                                                         │
│                                                                              │
│ ╭──── locals ─────╮                                                          │
│ │ infile = 'main' │                                                          │
│ ╰─────────────────╯                                                          │
╰──────────────────────────────────────────────────────────────────────────────╯
FileNotFoundError: [Errno 2] No such file or directory: 'main'
```


## Metadata
- **Skill**: not generated
