# blastbesties CWL Generation Report

## blastbesties

### Tool Description
Finds reciprocal best BLAST pairs from BLAST output format 6 (tabular). Where hits are sorted by query name then descending match quality.

### Metadata
- **Docker Image**: quay.io/biocontainers/blastbesties:1.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/Adamtaranto/blast-besties
- **Package**: https://anaconda.org/channels/bioconda/packages/blastbesties/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/blastbesties/overview
- **Total Downloads**: 8.9K
- **Last updated**: 2025-06-27
- **GitHub**: https://github.com/Adamtaranto/blast-besties
- **Stars**: N/A
### Original Help Text
```text
usage: blastbesties [-h] [--version] -a BLASTAVB -b BLASTBVA [-l MINLEN]
                    [-e EVAL] [-s BITSCORE] [-o OUTFILE] [-d OUTDIR]
                    [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL}] [--tui]

Finds reciprocal best BLAST pairs from BLAST output format 6 (tabular). Where
hits are sorted by query name then descending match quality.

options:
  -h, --help            show this help message and exit
  --version             Show program's version number and exit.
  -a, --blastAvB BLASTAVB
                        BLAST tab result file for fastaA query against fastaB
                        subject.
  -b, --blastBvA BLASTBVA
                        BLAST tab result file for fastaB query against fastaA
                        subject.
  -l, --minLen MINLEN   Minimum length of hit to consider valid. Defaults to
                        1.
  -e, --eVal EVAL       Maximum e-value to consider valid pair. Defaults to
                        0.001.
  -s, --bitScore BITSCORE
                        Minimum bitscore to consider valid pair. Defaults to
                        1.0.
  -o, --outFile OUTFILE
                        Write reciprocal BLAST pairs to this file.
  -d, --outDir OUTDIR   Directory for new sequence files to be written to.
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set logging level. Defaults to INFO.
  --tui                 Open Textual UI.
```

