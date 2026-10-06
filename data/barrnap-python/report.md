# barrnap-python CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| barrnap-python | Failed | image problem: barrnap.py cannot find its HMM database (db/bac.hmm is not installed in the image), so it exits before predicting rRNAs on a real bacterial genome. |

## barrnap-python

### Tool Description
barrnap ported to python3 - rapid ribosomal RNA prediction

### Metadata
- **Docker Image**: quay.io/biocontainers/barrnap-python:0.0.5--py36_1
- **Homepage**: https://github.com/nickp60/barrnap-python
- **Package**: https://anaconda.org/channels/bioconda/packages/barrnap-python/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/barrnap-python/overview
- **Total Downloads**: 7.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/nickp60/barrnap-python
- **Stars**: N/A
### Original Help Text
```text
usage: /usr/local/bin/barrnap.py [options] <chromosomes.fasta>
Synopsis:
  /usr/local/bin/barrnap.py 0.0.5 - rapid ribosomal RNA prediction
Author:
  Torsten Seemann <torsten.seemann@gmail.com>

barrnap ported to python3

positional arguments:
  fasta

optional arguments:
  -k {bac,euk,arc,mito}, --kingdom {bac,euk,arc,mito}
                        whether to look for eukaryotic, archaeal, or bacterial
                        rDNA; default: bac
  -t THREADS, --threads THREADS
                        Number of threads/cores/CPUs to use;default: 8
  -e EVALUE, --evalue EVALUE
                        Similarity e-value cut-off; default: 1e-06
  -l LENCUTOFF, --lencutoff LENCUTOFF
                        Proportional length threshold to label as partial;
                        default: 0.8
  -r REJECT, --reject REJECT
                        Proportional length threshold to reject prediction;
                        default: 0.5
  -i, --incseq          Include FASTA input sequences in GFF3 output
  -h, --help            This help
  -v, --version         Print version and exit
  --citation            Print citation for referencing barrnap
```


