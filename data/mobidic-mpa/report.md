# mobidic-mpa CWL Generation Report

## mobidic-mpa_mpa

### Tool Description
Annotate VCF with Mobidic Prioritization Algorithm score (MPA).

### Metadata
- **Docker Image**: quay.io/biocontainers/mobidic-mpa:1.3.0--pyh5e36f6f_0
- **Homepage**: https://neuro-2.iurc.montp.inserm.fr/mpaweb/
- **Package**: https://anaconda.org/channels/bioconda/packages/mobidic-mpa/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mobidic-mpa/overview
- **Total Downloads**: 26.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/mobidic/MPA
- **Stars**: N/A
### Original Help Text
```text
usage: mpa [-h] [-d MPA_DIRECTORY] [-l {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
           [-v] [-r] [-p] -i INPUT -o OUTPUT

Annotate VCF with Mobidic Prioritization Algorithm score (MPA).

optional arguments:
  -h, --help            show this help message and exit
  -d MPA_DIRECTORY, --mpa-directory MPA_DIRECTORY
                        The path to the MPA installation folder. [Default:
                        /usr/local/bin]
  -l {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --logging-level {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        The logger level. [Default: INFO]
  -v, --version         show program's version number and exit

Options:
  -r, --no-refseq-version
                        Annotation without using refseq version with annovar.
  -p, --no-progress-bar
                        Disable progress bar (avoid to read vcf twice for
                        large vcf).

Inputs:
  -i INPUT, --input INPUT
                        The vcf file to annotate (format: VCF). This vcf must
                        be annotate with annovar.

Outputs:
  -o OUTPUT, --output OUTPUT
                        The output vcf file with annotation (format : VCF)
```

