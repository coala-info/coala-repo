# estscan CWL Generation Report

## estscan

### Tool Description
ESTScan is a program for predicting the coding regions of eukaryotic genes.

### Metadata
- **Docker Image**: biocontainers/estscan:v3.0.3-3-deb_cv1
- **Homepage**: https://github.com/sib-swiss/ESTScan
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/estscan/overview
- **Total Downloads**: 8.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sib-swiss/ESTScan
- **Stars**: N/A
### Original Help Text
```text
estscan [options] [<FASTA file> ...]

Available options (default value in braces[]):
  -a          All in one sequence output
  -b <float>  only results are shown, which have scores higher than this 
              fraction of the best score [1.000000].
  -d <int>    deletion penalty [-50]
  -h          print this usage information
  -i <int>    insertion penalty [-50]
  -l <int>    only results longer than this length are shown [50]
  -M <file>   score matrices file ($ESTSCANDIR/Hs.smat)
              [/usr/molbio/share/ESTScan/Hs.smat]
  -m <int>    min value in matrix [-100]
  -N <int>    how to compute the score of N [0]
  -n          remove deleted nucleotides from the output
  -O          report header information for best match only
  -o <file>   send output to file.  - means stdout.  If both -t and -o specify
              stdout, only proteins will be written.
  -p <float>  GC select correction for score matrices [4.000000]
  -S          only analyze positive strand
  -s <int>    Skip sequences shorter than length [1]
  -T <int*>   8 integers used as log-probabilities for transitions,
              start->5'UTR, start->CDS, start->3'UTR, 5'UTR->CDS,
              5'UTR->end, CDS->3'UTR, CDS->end, 3'UTR->end
              [-10, -10, -5, -80, -40, -80, -40, -20]
  -t <file>   Translate to protein.  - means stdout.
              will go to the file and the nucleotides will still go to stdout.
  -v          version information
  -w <int>    width of the FASTA sequence output [60]
```


## Metadata
- **Skill**: generated
