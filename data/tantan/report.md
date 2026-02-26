# tantan CWL Generation Report

## tantan

### Tool Description
Find simple repeats in sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/tantan:51--h5ca1c30_1
- **Homepage**: http://cbrc3.cbrc.jp/~martin/tantan/
- **Package**: https://anaconda.org/channels/bioconda/packages/tantan/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tantan/overview
- **Total Downloads**: 35.8K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage: tantan [options] fasta-sequence-file(s)
Find simple repeats in sequences

Options (default settings):
 -p  interpret the sequences as proteins
 -x  letter to use for masking, instead of lowercase
 -c  preserve uppercase/lowercase in non-masked regions
 -m  file for letter-pair score matrix
 -r  probability of a repeat starting per position (0.005)
 -e  probability of a repeat ending per position (0.05)
 -w  maximum tandem repeat period to consider (100, but -p selects 50)
 -d  probability decay per period (0.9)
 -i  match score (BLOSUM62 if -p, else 2 if -f4, else 1)
 -j  mismatch cost, 0 means infinite (BLOSUM62 if -p, else 7 if -f4, else 1)
 -a  gap existence cost (0)
 -b  gap extension cost, 0 means no gaps (7 if -f4, else 0)
 -s  minimum repeat probability for masking (0.5)
 -n  minimum copy number, affects -f4 only (2)
 -f  output type: 0=masked sequence, 1=repeat probabilities,
                  2=repeat counts, 3=BED, 4=tandem repeats (0)
 -h, --help  show help message, then exit
 --version   show version information, then exit
```

