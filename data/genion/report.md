# genion CWL Generation Report

## genion

### Tool Description
GENe fusION

### Metadata
- **Docker Image**: quay.io/biocontainers/genion:1.2.3--h077b44d_2
- **Homepage**: https://github.com/vpc-ccg/genion
- **Package**: https://anaconda.org/channels/bioconda/packages/genion/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/genion/overview
- **Total Downloads**: 14.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/vpc-ccg/genion
- **Stars**: N/A
### Original Help Text
```text
gtf is required!
output is required!
gpaf is required!
duplications is required!
GENe fusION
Usage:
  genion [OPTION...]

      --gtf arg                 GTF annotation path
  -i, --input arg               Input fast{a,q} file
  -g, --gpaf arg                Long read whole genom e alignment paf path
  -d, --duplications arg        genomicSuperDups.txt, unzipped
  -s, --transcriptome-self-align arg
                                Self align tsv
  -o, --output arg              Output path for an existing path
      --log arg                 logfile path (default: output_path + .log)
      --min-support arg         Minimum read support for fusion calls
                                (default: 3)
      --max-rt-distance arg     Maximum distance between genes for
                                read-through events (default: 500000)
      --max-rt-fin arg          Maximum value of chimeric-count /
                                normal-count for read-through events (default: 0.2)
      --max-base-percent-in-exon arg
                                Maximum ratio of a base type (AGTC) in an
                                potential fusion exon (This is used for low
                                complexity filtering) (default: 0.65)
      --non-coding              Allow non-coding genes and transcripts while
                                calling gene fusions
  -h, --help                    Prints help
  -v, --version                 Prints version
```

