# cryptogenotyper CWL Generation Report

## cryptogenotyper

### Tool Description
In silico type cryptosporidium from sanger reads in AB1 format

### Metadata
- **Docker Image**: quay.io/biocontainers/cryptogenotyper:1.5.0--pyhdfd78af_3
- **Homepage**: https://github.com/phac-nml/CryptoGenotyper
- **Package**: https://anaconda.org/channels/bioconda/packages/cryptogenotyper/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cryptogenotyper/overview
- **Total Downloads**: 4.2K
- **Last updated**: 2025-09-27
- **GitHub**: https://github.com/phac-nml/CryptoGenotyper
- **Stars**: N/A
### Original Help Text
```text
usage: cryptogenotyper [-h] [--verbose] -i INPUT -m MARKER
                       [-t {forward,reverse,contig}] [-f FORWARDPRIMERNAME]
                       [-r REVERSEPRIMERNAME] [-s SUFFIX] [-o OUTPUTPREFIX]
                       [-d DATABASEFILE] [-v] [--noheaderline]

In silico type cryptosporidium from sanger reads in AB1 format

optional arguments:
  -h, --help            show this help message and exit
  --verbose             Turn on verbose logging [False].
  -i INPUT, --input INPUT
                        Path to SINGLE directory with AB1/FASTA forward and
                        reverse files OR path to a SINGLE AB1/FASTA file. Use
                        -f and/or -r to filter inputs
  -m MARKER, --marker MARKER
                        Name of the marker. Currently gp60 and 18S markers are
                        supported
  -t {forward,reverse,contig}, --seqtype {forward,reverse,contig}
                        Input sequences type. Select one option out of these
                        three: contig - both F and R sequences provided
                        forward - forward only sequence provided reverse -
                        reverse only sequence provided
  -f FORWARDPRIMERNAME, --forwardprimername FORWARDPRIMERNAME
                        Name of the forward primer to identify forward read
                        (e.g. gp60F, SSUF)
  -r REVERSEPRIMERNAME, --reverseprimername REVERSEPRIMERNAME
                        Name of the reverse primer to identify forward read
                        (e.g. gp60R, SSUR)
  -s SUFFIX, --suffix SUFFIX
                        Optional suffix to filter filenames (e.g. only include
                        files ending with a specific pattern)
  -o OUTPUTPREFIX, --outputprefix OUTPUTPREFIX
                        Output name prefix for the results (e.g. test results
                        in test_report.fa)
  -d DATABASEFILE, --databasefile DATABASEFILE
                        Path to your custom, highly curated database of 18S or
                        gp60 marker reference sequences in FASTA format
  -v, --version         show program's version number and exit
  --noheaderline        Display header on tab-delimited file [False]

Example usage using example ab1 files included in /example folder:
    cryptogenotyper -i example/P17705_Crypto16-2F-20170927_SSUF_G12_084.ab1 -m 18S -t forward -f SSUF -o test
    cryptogenotyper -i example/P17705_gp60-Crypt14-1F-20170927_gp60F_G07_051.ab1 -m gp60 -t forward -f gp60F -o test
    cryptogenotyper -i example/ -m 18S -t contig -f SSUF -r SSUR -o test
    cryptogenotyper -i example/ -m gp60 -t contig -f gp60F -r gp60R -o test
    cryptogenotyper -i example/input.fasta -m gp60 -o test
    cryptogenotyper -i example/ -m gp60 -o test -f input
```

