# frogs CWL Generation Report

## frogs_itsx.py

### Tool Description
Uses ITSx to detect/extracts ITS1 or ITS2 regions from ITS sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
- **Homepage**: https://github.com/geraldinepascal/FROGS
- **Package**: https://anaconda.org/channels/bioconda/packages/frogs/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/frogs/overview
- **Total Downloads**: 35.9K
- **Last updated**: 2026-01-15
- **GitHub**: https://github.com/geraldinepascal/FROGS
- **Stars**: N/A
### Original Help Text
```text
usage: itsx.py [-h] [--version] [--debug] [--nb-cpus NB_CPUS]
               [--organism-groups ORGANISM_GROUPS [ORGANISM_GROUPS ...]]
               (--region {ITS1,ITS2} | --check-its-only) --input-fasta
               INPUT_FASTA [--input-biom INPUT_BIOM]
               [--output-fasta OUTPUT_FASTA] [--output-biom OUTPUT_BIOM]
               [--output-removed-sequences OUTPUT_REMOVED_SEQUENCES]
               [--html HTML] [--log-file LOG_FILE]

Uses ITSx to detect/extracts ITS1 or ITS2 regions from ITS sequences.

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --debug               Keep temporary files to debug program. [Default:
                        False]
  --nb-cpus NB_CPUS     The maximum number of CPUs used. [Default: 1]

Parameters:
  --organism-groups ORGANISM_GROUPS [ORGANISM_GROUPS ...]
                        Reduce ITSx scan to specified organim groups.
                        [Default: ['F'] , which means Fungi only]
  --region {ITS1,ITS2}  Which fungal ITS region is targeted and trimmed:
                        either ITS1 or ITS2. (mutually exclusive with --check-
                        its-only) [Default: None]
  --check-its-only      Check only if sequences seem to be an ITS (mutually
                        exclusive with --region) [Default: False]

Inputs:
  --input-fasta INPUT_FASTA
                        The cluster sequences (format: FASTA).
  --input-biom INPUT_BIOM
                        The abundance file for clusters by sample (format:
                        BIOM).

Outputs:
  --output-fasta OUTPUT_FASTA
                        sequences file out from ITSx (format: FASTA).
                        [Default: itsx.fasta]
  --output-biom OUTPUT_BIOM
                        Abundance file without chimera (format: BIOM ).
                        [Default: itsx_abundance.biom]
  --output-removed-sequences OUTPUT_REMOVED_SEQUENCES
                        sequences file removed (format: FASTA). [Default:
                        itsx_removed.fasta]
  --html HTML           The HTML file containing the graphs. [Default:
                        itsx.html]
  --log-file LOG_FILE   This output file will contain several informations on
                        executed commands. [Default: stdout]
```

