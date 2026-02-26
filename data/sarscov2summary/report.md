# sarscov2summary CWL Generation Report

## sarscov2summary

### Tool Description
Summarize selection analysis results.

### Metadata
- **Docker Image**: quay.io/biocontainers/sarscov2summary:0.5--py_1
- **Homepage**: https://github.com/nickeener/sarscov2formatter
- **Package**: https://anaconda.org/channels/bioconda/packages/sarscov2summary/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sarscov2summary/overview
- **Total Downloads**: 3.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/nickeener/sarscov2formatter
- **Stars**: N/A
### Original Help Text
```text
usage: sarscov2summary [-h] [-o OUTPUT] -s SLAC -f FEL -m MEME [-p PRIME]
                       [-P PVALUE] -c COORDINATES -D DATABASE -d DUPLICATES
                       [-M MAF] [-E EVOLUTIONARY_ANNOTATION]
                       [-F EVOLUTIONARY_FRAGMENT] [-A MAFS]
                       [-V EVOLUTIONARY_CSV]

Summarize selection analysis results.

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUT, --output OUTPUT
                        Write results here
  -s SLAC, --slac SLAC  SLAC results file
  -f FEL, --fel FEL     FEL results file
  -m MEME, --meme MEME  MEME results file
  -p PRIME, --prime PRIME
                        PRIME results file
  -P PVALUE, --pvalue PVALUE
                        p-value
  -c COORDINATES, --coordinates COORDINATES
                        An alignment with reference sequence (assumed to start
                        with NC)
  -D DATABASE, --database DATABASE
                        Primary database record to extract sequence
                        information from
  -d DUPLICATES, --duplicates DUPLICATES
                        The JSON file recording compressed sequence duplicates
  -M MAF, --MAF MAF     Also include sites with hapoltype MAF >= this
                        frequency
  -E EVOLUTIONARY_ANNOTATION, --evolutionary_annotation EVOLUTIONARY_ANNOTATION
                        If provided use evolutionary likelihood annotation
  -F EVOLUTIONARY_FRAGMENT, --evolutionary_fragment EVOLUTIONARY_FRAGMENT
                        Used in conjunction with evolutionary annotation to
                        designate the fragment to look up
  -A MAFS, --mafs MAFS  If provided, write a CSV file with MAF/p-value tables
  -V EVOLUTIONARY_CSV, --evolutionary_csv EVOLUTIONARY_CSV
                        If provided, write a CSV file with observed/predicted
                        frequncies
```


## Metadata
- **Skill**: generated
