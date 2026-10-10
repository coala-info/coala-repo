# mtb-snp-it CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| mtb-snp-it_snpit-run.py | PASS |  |


## mtb-snp-it_snpit-run.py

### Tool Description
Reports the species and lineage of a Mycobacterium tuberculosis complex sample from a VCF or FASTA file aligned to NC_000962 (H37Rv).

### Metadata
- **Docker Image**: quay.io/biocontainers/mtb-snp-it:1.1--py_0
- **Homepage**: https://github.com/samlipworth/snpit
- **Package**: https://anaconda.org/channels/bioconda/packages/mtb-snp-it/overview
- **Validation**: PASS

### Original Help Text
```text
usage: snpit-run.py [-h] --input INPUT

optional arguments:
  -h, --help     show this help message and exit
  --input INPUT  the path to the VCF or FASTA file to read and classify
                 (either can be bzip2ed/gzipped)
```
