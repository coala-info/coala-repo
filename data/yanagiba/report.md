# yanagiba CWL Generation Report

## yanagiba

### Tool Description
Filter and slice Nanopore reads which have been basecalled with Albacore. Takes fastq.gz and an Albacore summary file.

### Metadata
- **Docker Image**: quay.io/biocontainers/yanagiba:1.0.0--py36_1
- **Homepage**: https://github.com/Adamtaranto/Yanagiba
- **Package**: https://anaconda.org/channels/bioconda/packages/yanagiba/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/yanagiba/overview
- **Total Downloads**: 13.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Adamtaranto/Yanagiba
- **Stars**: N/A
### Original Help Text
```text
usage: yanagiba [-h] -i INFILE [-s SUMMARYFILE] [-o OUTFILE] [-l MINLEN]
                [-q MINQUAL] [--headtrim HEADTRIM] [--tailtrim TAILTRIM] [-u]

Filter and slice Nanopore reads which have been basecalled with Albacore.
Takes fastq.gz and an Albacore summary file.

optional arguments:
  -h, --help            show this help message and exit
  -i INFILE, --infile INFILE
                        Input fastq.gz file.
  -s SUMMARYFILE, --summaryfile SUMMARYFILE
                        Albacore summary file with header row.
  -o OUTFILE, --outfile OUTFILE
                        Write filtered reads to this file in .bgz format.
  -l MINLEN, --minlen MINLEN
                        Exclude reads shorter than this length. Default: 0
  -q MINQUAL, --minqual MINQUAL
                        Minimum quality score to retain a read. Default: 10
  --headtrim HEADTRIM   Trim x bases from begining of each read. Default: 0
  --tailtrim TAILTRIM   Trim x bases from end of each read. Default: None
  -u, --forceunique     Enforce unique reads. Only store first instance of a
                        read from fastq input where readID occurs multiple
                        times.
```

