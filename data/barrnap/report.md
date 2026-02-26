# barrnap CWL Generation Report

## barrnap

### Tool Description
Finds and annotates ribosomal RNA genes in genome sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/barrnap:0.9--1
- **Homepage**: https://github.com/tseemann/barrnap
- **Package**: https://anaconda.org/channels/bioconda/packages/barrnap/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/barrnap/overview
- **Total Downloads**: 177.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/tseemann/barrnap
- **Stars**: N/A
### Original Help Text
```text
[barrnap] This is barrnap 0.9
[barrnap] Written by Torsten Seemann
[barrnap] Obtained from https://github.com/tseemann/barrnap
[barrnap] Detected operating system: linux
[barrnap] Adding /usr/local/lib/barrnap/bin/../binaries/linux to end of PATH
[barrnap] Checking for dependencies:
[barrnap] Found nhmmer - /usr/local/bin/nhmmer
[barrnap] Found bedtools - /usr/local/bin/bedtools
[barrnap] Will use 1 threads
[barrnap] Setting evalue cutoff to 1e-06
[barrnap] Will tag genes < 0.8 of expected length.
[barrnap] Will reject genes < 0.25 of expected length.
[barrnap] Using database: /usr/local/lib/barrnap/bin/../db/bac.hmm
[barrnap] Copying STDIN to a temporary file: /tmp/2MAnTZeRwz
[barrnap] Scanning /tmp/2MAnTZeRwz for bac rRNA genes... please wait
[barrnap] Command: nhmmer --cpu 1 -E 1e-06 --w_length 3878 -o /dev/null --tblout /dev/stdout '/usr/local/lib/barrnap/bin/../db/bac.hmm' '/tmp/2MAnTZeRwz'
[barrnap] ERROR: bad line in nhmmer output - Fatal exception (source file esl_buffer.c, line 1599):
```

