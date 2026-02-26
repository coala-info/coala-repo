# pygenetic_code CWL Generation Report

## pygenetic_code

### Tool Description
genetic_codes for translation tables

### Metadata
- **Docker Image**: quay.io/biocontainers/pygenetic_code:0.20.0--py312he4a0461_0
- **Homepage**: https://github.com/linsalrob/genetic_codes
- **Package**: https://anaconda.org/channels/bioconda/packages/pygenetic_code/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pygenetic_code/overview
- **Total Downloads**: 1.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/linsalrob/genetic_codes
- **Stars**: N/A
### Original Help Text
```text
usage: pygenetic_code [-t TRANSLATE] [-s SIXFRAME] [-c TRANSLATIONTABLE]
                      [--minlen MINLEN] [--threads THREADS] [-j] [-d] [-x]
                      [-h] [-v] [--verbose]

genetic_codes for translation tables

translating sequences:
  -t TRANSLATE, --translate TRANSLATE
                        translate a sequence in one reading frame
  -s SIXFRAME, --sixframe SIXFRAME
                        translate a sequence in all six reading frames
  -c TRANSLATIONTABLE, --translationtable TRANSLATIONTABLE
                        translation table to use (default == 11)
  --minlen MINLEN       minimum ORF length for the six frame translation
                        (default=3)
  --threads THREADS     number of threads to use for the six frame translation
                        (default=8)

printing genetic codes:
  -j, --json            print the genetic codes as a json object
  -d, --difference      print the genetic code as the difference from
                        translation table 1
  -x, --maxdifference   print difference from the most common codon usage

optional arguments:
  -h, --help            show this help message and exit
  -v, --version         print the version
  --verbose             debugging level output
```

