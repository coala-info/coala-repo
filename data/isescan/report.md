# isescan CWL Generation Report

## isescan_isescan.py

### Tool Description
ISEScan is a python pipeline to identify Insertion Sequence elements (both complete and incomplete IS elements) in genom. A typical invocation would be:
python3 isescan.py seqfile proteome hmm

- If you want isescan to report only complete IS elements, you need to set command line option --removeShortIS.

### Metadata
- **Docker Image**: quay.io/biocontainers/isescan:1.7.3--h7b50bb2_0
- **Homepage**: https://github.com/xiezhq/ISEScan
- **Package**: https://anaconda.org/channels/bioconda/packages/isescan/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/isescan/overview
- **Total Downloads**: 27.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/xiezhq/ISEScan
- **Stars**: N/A
### Original Help Text
```text
usage: isescan [-h] [--version] [--removeShortIS] [--no-FragGeneScan]
               --seqfile SEQFILE --output OUTPUT [--nthread NTHREAD]

ISEScan is a python pipeline to identify Insertion Sequence elements (both complete and incomplete IS elements) in genom. A typical invocation would be:
python3 isescan.py seqfile proteome hmm

- If you want isescan to report only complete IS elements, you need to set command line option --removeShortIS.

options:
  -h, --help         show this help message and exit
  --version          show program's version number and exit
  --removeShortIS    Remove incomplete (partial) IS elements which include IS
                     element with length < 400 or single copy IS element
                     without perfect TIR.
  --no-FragGeneScan  Use the annotated protein sequences in NCBI GenBank file
                     (.gbk which must be in the same folder with genome
                     sequence file), instead of the protein sequences
                     predicted/translated by FragGeneScan. (Experimental
                     feature!)
  --seqfile SEQFILE  Sequence file in fasta format, '' by default
  --output OUTPUT    Output directory, 'results' by default
  --nthread NTHREAD  Number of CPU cores used for FragGeneScan and hmmer, 1 by
                     default.
```

