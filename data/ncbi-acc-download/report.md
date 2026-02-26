# ncbi-acc-download CWL Generation Report

## ncbi-acc-download

### Tool Description
Download sequences from NCBI based on accession numbers.

### Metadata
- **Docker Image**: quay.io/biocontainers/ncbi-acc-download:0.2.8--pyh5e36f6f_0
- **Homepage**: https://github.com/kblin/ncbi-acc-download/
- **Package**: https://anaconda.org/channels/bioconda/packages/ncbi-acc-download/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ncbi-acc-download/overview
- **Total Downloads**: 13.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/kblin/ncbi-acc-download
- **Stars**: N/A
### Original Help Text
```text
usage: ncbi-acc-download [-h] [-m {nucleotide,protein}] [--api-key API_KEY]
                         [-e {none,loads,all,correct}]
                         [-F {fasta,genbank,featuretable,gff3}] [-o OUT]
                         [-p PREFIX] [-g RANGE] [-r] [--url] [-v]
                         NCBI-accession [NCBI-accession ...]

positional arguments:
  NCBI-accession

optional arguments:
  -h, --help            show this help message and exit
  -m {nucleotide,protein}, --molecule {nucleotide,protein}
                        Molecule type to download. Default: nucleotide
  --api-key API_KEY     Specify USER NCBI API key. More info at
                        https://www.ncbi.nlm.nih.gov/books/NBK25497/
  -e {none,loads,all,correct}, --extended-validation {none,loads,all,correct}
                        Perform extended validation. Possible options are
                        'none' to skip validation, 'loads' to check if the
                        sequence file loads in Biopython, or 'all' to run all
                        checks. Default: none
  -F {fasta,genbank,featuretable,gff3}, --format {fasta,genbank,featuretable,gff3}
                        File format to download nucleotide sequences in.
                        Default: genbank
  -o OUT, --out OUT     Single filename to use for the combined output.
  -p PREFIX, --prefix PREFIX
                        Filename prefix to use for output files instead of
                        using the NCBI ID.
  -g RANGE, --range RANGE
                        region to subset accession. only for single accession
  -r, --recursive       Recursively get all entries of a WGS entry.
  --url                 Instead of downloading the sequences, just print the
                        URLs to stdout.
  -v, --verbose         Print a progress indicator.
```

