# rd-analyzer CWL Generation Report

## rd-analyzer_RD-Analyzer.py

### Tool Description
RD-Analyzer.py

### Metadata
- **Docker Image**: quay.io/biocontainers/rd-analyzer:1.01--hdfd78af_0
- **Homepage**: https://github.com/xiaeryu/RD-Analyzer
- **Package**: https://anaconda.org/channels/bioconda/packages/rd-analyzer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rd-analyzer/overview
- **Total Downloads**: 2.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/xiaeryu/RD-Analyzer
- **Stars**: N/A
### Original Help Text
```text
Usage: RD-Analyzer.py [options] FASTQ_1 FASTQ_2(optional)

Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -O OUTDIR, --outdir=OUTDIR
                        output directory [Default: running directory]
  -o OUTPUT, --output=OUTPUT
                        basename of output files [Default: RD-Analyzer]
  -p, --personalized    use personalized cut-offs
  -m MIN, --min=MIN     read depth cut-off (in the unit of average depth,
                        0-1), used when '-p' is set
  -c COVERAGE, --coverage=COVERAGE
                         sequence coverage cut-off (0-1), used when '-p' is
                        set
  -d, --debug           enable debug mode, keeping all intermediate files
```


## rd-analyzer_RD-Analyzer-extended.py

### Tool Description
RD-Analyzer-extended.py

### Metadata
- **Docker Image**: quay.io/biocontainers/rd-analyzer:1.01--hdfd78af_0
- **Homepage**: https://github.com/xiaeryu/RD-Analyzer
- **Package**: https://anaconda.org/channels/bioconda/packages/rd-analyzer/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: RD-Analyzer-extended.py [options] REF.FASTA FASTQ_1 FASTQ_2(optional)

Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -O OUTDIR, --outdir=OUTDIR
                        output directory [Default: running directory]
  -o OUTPUT, --output=OUTPUT
                        basename of output files [Default: RD-Analyzer]
  -d, --debug           enable debug mode, keeping all intermediate files
```


## Metadata
- **Skill**: generated
