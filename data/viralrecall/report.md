# viralrecall CWL Generation Report

## viralrecall

### Tool Description
A command-line tool for predicting NCLDV-like regions in genomic data

### Metadata
- **Docker Image**: quay.io/biocontainers/viralrecall:3.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/abdealijivaji/ViralRecall_3.0
- **Package**: https://anaconda.org/channels/bioconda/packages/viralrecall/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/viralrecall/overview
- **Total Downloads**: 108
- **Last updated**: 2025-12-20
- **GitHub**: https://github.com/abdealijivaji/ViralRecall_3.0
- **Stars**: N/A
### Original Help Text
```text
usage: viralrecall -i INPUT -o OUTDIR -d DATABASE [-w WINDOW] [-m MINSIZE]
                   [-s MINSCORE] [-e EVALUE] [-g MINHIT] [-c CPUS] [-h] [-v]

Viralrecall: A command-line tool for predicting NCLDV-like regions in genomic data 
Abdeali (Ali) M. Jivaji, Virginia Tech Department of Biological Sciences <abdeali@vt.edu>

required arguments:
  -i, --input INPUT     Input Fasta file or directory of fasta files (ending
                        in .fna, .fasta, or .fa)
  -o, --outdir OUTDIR   Output directory name
  -d, --database DATABASE
                        Database directory name, e.g. ~/hmm (download the
                        database using viralrecall_database)

optional arguments:
  -w, --window WINDOW   sliding window size to use for detecting viral regions
                        (default=15 kb)
  -m, --minsize MINSIZE
                        minimum length of viral regions to report, in
                        kilobases (default=10 kb)
  -s, --minscore MINSCORE
                        minimum score of viral regions to report, with higher
                        values indicating higher confidence (default=10)
  -e, --evalue EVALUE   e-value that is passed to pyHmmer for hmmsearch
                        (default=1e-10)
  -g, --minhit MINHIT   minimum number of unique viral hits that each viral
                        region must have to be reported (default=4)
  -c, --cpus CPUS       number of cores to use in batch mode (default=all
                        available cores)
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit

*******************************************************************

*******************************************************************
```

