# htseqqc CWL Generation Report

## htseqqc_filter.py

### Tool Description
Quality control analysis of single and paired-end sequence data

### Metadata
- **Docker Image**: quay.io/biocontainers/htseqqc:v1.0--pyh5bfb8f1_0
- **Homepage**: https://reneshbedre.github.io/blog/htseqqc.html
- **Package**: https://anaconda.org/channels/bioconda/packages/htseqqc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/htseqqc/overview
- **Total Downloads**: 2.9K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: filter.py [-h] [-a INPUT_FILES_1 [INPUT_FILES_1 ...]]
                 [-b INPUT_FILES_2 [INPUT_FILES_2 ...]] [-c QUAL_FMT]
                 [-e N_CONT] [-f ADPT_SEQS] [-d MIN_SIZE] [-g ADPT_MATCH]
                 [-i QUAL_THRESH] [-n TRIM_OPT] [-p WIND_SIZE]
                 [-r MIN_LEN_FILT] [-q CPU] [-m OUT_FMT] [-v VIS_OPT]
                 [--version]

Quality control analysis of single and paired-end sequence data

optional arguments:
  -h, --help            show this help message and exit
  -a INPUT_FILES_1 [INPUT_FILES_1 ...], --p1 INPUT_FILES_1 [INPUT_FILES_1 ...]
                        Single end input files or left files for paired-end
                        data (.fastq, .fq). Multiple sample files must be
                        separated by comma or space
  -b INPUT_FILES_2 [INPUT_FILES_2 ...], --p2 INPUT_FILES_2 [INPUT_FILES_2 ...]
                        Right files for paired-end data (.fastq, .fq).
                        Multiple files must be separated by comma or space
  -c QUAL_FMT, --qfmt QUAL_FMT
                        Quality value format [1= Illumina 1.8, 2= Illumina
                        1.3,3= Sanger]. If quality format not provided, it
                        will automatically detect based on sequence data
  -e N_CONT, --nb N_CONT
                        Filter the reads containing given % of uncalled bases
                        (N)
  -f ADPT_SEQS, --adp ADPT_SEQS
                        Trim the adapter and truncate the read sequence
                        (multiple adapter sequences must be separated by
                        comma)
  -d MIN_SIZE, --msz MIN_SIZE
                        Filter the reads which are lesser than minimum size
  -g ADPT_MATCH, --per ADPT_MATCH
                        Truncate the read sequence if it matches to adapter
                        sequence equal or more than given percent (0.0-1.0)
                        [default=0.9]
  -i QUAL_THRESH, --qthr QUAL_THRESH
                        Filter the read sequence if average quality of bases
                        in reads is lower than threshold (1-40) [default:20]
  -n TRIM_OPT, --trim TRIM_OPT
                        If trim option set to True, the reads with low quality
                        (as defined by option --qthr) will be trimmed instead
                        of discarding [True|False] [default: False]
  -p WIND_SIZE, --wsz WIND_SIZE
                        The window size for trimming (5->3) the reads. This
                        option should always set when -trim option is defined
                        [default: 5]
  -r MIN_LEN_FILT, --mlk MIN_LEN_FILT
                        Minimum length of the reads to retain after trimming
  -q CPU, --cpu CPU     Number of CPU [default:2]
  -m OUT_FMT, --ofmt OUT_FMT
                        Output file format (fastq/fasta) [default:fastq]
  -v VIS_OPT, --no-vis VIS_OPT
                        No figures will be produced [True|False]
                        [default:False]
  --version             show program's version number and exit
```

