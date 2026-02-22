# pango-collapse CWL Generation Report

## pango-collapse

### Tool Description
Collapse Pango sublineages up to user defined parent lineages.

### Metadata
- **Docker Image**: quay.io/biocontainers/pango-collapse:0.8.2--pyhdfd78af_0
- **Homepage**: https://github.com/MDU-PHL/pango-collapse
- **Package**: https://anaconda.org/channels/bioconda/packages/pango-collapse/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pango-collapse/overview
- **Total Downloads**: 548
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/MDU-PHL/pango-collapse
- **Stars**: N/A
### Original Help Text
```text
Usage: pango-collapse [OPTIONS] [INPUT]                                        
                                                                                
 Collapse Pango sublineages up to user defined parent lineages.                 
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│   input      [INPUT]  Path to input CSV/TSV with Lineage column.             │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --output              -o      FILE  Path to output CSV/TSV with Lineage      │
│                                     column. If not supplied will print to    │
│                                     stdout.                                  │
│ --collapse-file       -c      TEXT  Path or URL to collapse file with        │
│                                     parental lineages (one per line) to      │
│                                     collapse up to. Defaults to collapse     │
│                                     file shipped with this version of        │
│                                     pango-collapse.                          │
│ --parent              -p      TEXT  Parental lineage to collapse up to. Can  │
│                                     be used multiple times to collapse to    │
│                                     multiple lineages. If --collapse-file is │
│                                     supplied parents will be appended to the │
│                                     file.                                    │
│ --lineage-column      -l      TEXT  Column to extract from input file for    │
│                                     lineage.                                 │
│                                     [default: Lineage]                       │
│ --full-column         -f      TEXT  Column to use for the uncompressed       │
│                                     output.                                  │
│                                     [default: Lineage_full]                  │
│ --collapse-column     -k      TEXT  Column to use for the collapsed output.  │
│                                     [default: Lineage_family]                │
│ --expand-column       -e      TEXT  Column to use for the expanded output.   │
│                                     [default: Lineage_expanded]              │
│ --alias-file          -a      FILE  Path to Pango Alias file for             │
│                                     pango_aliasor. Will download latest file │
│                                     if not supplied.                         │
│ --strict              -s            If a lineage is not in the collapse file │
│                                     return None instead of the compressed    │
│                                     lineage.                                 │
│ --latest              -u            Load the latest collapse from from       │
│                                     https://raw.githubusercontent.com/MDU-P… │
│ --tsv                               Input file is in TSV format. If not      │
│                                     supplied will try to infer from file     │
│                                     extension.                               │
│ --version             -v            Print the current version number and     │
│                                     exit.                                    │
│ --install-completion                Install completion for the current       │
│                                     shell.                                   │
│ --show-completion                   Show completion for the current shell,   │
│                                     to copy it or customize the              │
│                                     installation.                            │
│ --help                -h            Show this message and exit.              │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## Metadata
- **Skill**: generated
