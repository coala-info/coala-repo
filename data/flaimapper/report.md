# flaimapper CWL Generation Report

## flaimapper

### Tool Description
A tool for annotating and quantifying fragments from SAM/BAM files, specifically designed for small RNA-seq data.

### Metadata
- **Docker Image**: quay.io/biocontainers/flaimapper:3.0.0--py36_1
- **Homepage**: https://github.com/yhoogstrate/flaimapper/
- **Package**: https://anaconda.org/channels/bioconda/packages/flaimapper/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/flaimapper/overview
- **Total Downloads**: 35.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/yhoogstrate/flaimapper
- **Stars**: N/A
### Original Help Text
```text
usage: flaimapper [-h] [-V] [-v | -q] [-p PARAMETERS] [-o OUTPUT] [-f {1,2}]
                  [-r FASTA] [--offset5p OFFSET5P] [--offset3p OFFSET3P]
                  alignment_file

positional arguments:
  alignment_file        indexed SAM or BAM file

optional arguments:
  -h, --help            show this help message and exit
  -V, --version         show program's version number and exit
  -v, --verbose
  -q, --quiet
  -p PARAMETERS, --parameters PARAMETERS
                        File containing the filtering parameters, using
                        default if none is provided
  -o OUTPUT, --output OUTPUT
                        output filename; '-' for stdout
  -f {1,2}, --format {1,2}
                        file format of the output: [1: table; per fragment],
                        [2: GTF (default)]
  -r FASTA, --fasta FASTA
                        Single reference FASTA file (+faid index) containing
                        all genomic reference sequences
  --offset5p OFFSET5P   Offset in bp added to the exon-type annotations in the
                        GTF file. This offset is used in tools estimating the
                        expression levels (default=4)
  --offset3p OFFSET3P   Offset in bp added to the exon-type annotations in the
                        GTF file. This offset is used in tools estimating the
                        expression levels (default=4)

Further details can be found in the manual:
<https://github.com/yhoogstrate/flaimapper>
```


## Metadata
- **Skill**: generated
