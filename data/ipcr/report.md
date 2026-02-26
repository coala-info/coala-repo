# ipcr CWL Generation Report

## ipcr

### Tool Description
in-silico PCR toolkit

### Metadata
- **Docker Image**: quay.io/biocontainers/ipcr:4.1.1--he881be0_1
- **Homepage**: https://github.com/KPU-AGC/ipcr
- **Package**: https://anaconda.org/channels/bioconda/packages/ipcr/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ipcr/overview
- **Total Downloads**: 5.3K
- **Last updated**: 2026-02-24
- **GitHub**: https://github.com/KPU-AGC/ipcr
- **Stars**: N/A
### Original Help Text
```text
ipcr – in-silico PCR toolkit

Author:  Erick Samera (erick.samera@kpu.ca)
License: MIT
Version: 4.1.1

Usage:
  ipcr [options] --forward AAA --reverse TTT --sequences ref.fa
  ipcr [options] --forward AAA --reverse TTT ref*.fa gz/*.fa.gz

Input:
  -f, --forward string        Forward primer sequence (5'→3') [*]
  -r, --reverse string        Reverse primer sequence (5'→3') [*]
  -p, --primers string        Primer TSV (id fwd rev [min] [max])
  -s, --sequences file        FASTA file(s) (repeatable) or '-' for STDIN

PCR:
  -m, --mismatches int        Max mismatches allowed per primer [0]
      --min-length int        Minimum product length [0]
      --max-length int        Maximum product length [2000]
      --hit-cap int           Max matches stored per primer/window (0=unlimited) [10000]
      --terminal-window int   3' terminal window (N<1 disables) [3]
      --self                  Allow single-oligo amplification (A×rc(A), B×rc(B)) [true]

Performance:
  -t, --threads int           Worker threads (0=all CPUs) [0]
      --chunk-size int        Split sequences into N-bp windows (0=no chunking) [0]
      --seed-length int       Seed length for multi-pattern scan (0=auto) [12]
  -c, --circular              Treat each FASTA record as circular [false]

Output:
  -o, --output string         Output: text | json | jsonl | fasta [text]
      --products              Emit product sequences [false]
      --pretty                Pretty ASCII alignment block (text) [false]
      --sort                  Sort outputs deterministically [false]
      --no-header             Suppress header line [false]
      --no-match-exit-code int  Exit code when no amplicons found [0]

Miscellaneous:
  -q, --quiet                 Suppress non-essential warnings [false]
  -v, --version               Print version and exit
  -h, --help                  Show this help and exit
      --examples              Show quickstart examples and exit
```

