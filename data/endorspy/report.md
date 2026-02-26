# endorspy CWL Generation Report

## endorspy

### Tool Description
endorS.py calculates percent on target (aka Endogenous DNA) from samtools flagstat files and print to screen. The percent on target reported will be different depending on the combination of samtools flagstat provided. This program also calculates clonality (aka cluster factor) and percent duplicates when the flagstat file after duplicate removal is provided Use --output flag to write results to a file

### Metadata
- **Docker Image**: quay.io/biocontainers/endorspy:1.4--hdfd78af_0
- **Homepage**: https://github.com/aidaanva/endorS.py
- **Package**: https://anaconda.org/channels/bioconda/packages/endorspy/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/endorspy/overview
- **Total Downloads**: 12.8K
- **Last updated**: 2025-07-02
- **GitHub**: https://github.com/aidaanva/endorS.py
- **Stars**: N/A
### Original Help Text
```text
usage: python endorS.py [-h] [--version] -r [<samplesfile>.stats] -qF [<samplesfile>.stats] -dedup [<samplesfile>.stats]

author:
Aida Andrades Valtueña (aida.andrades[at]gmail.com)

description:
endorS.py calculates percent on target (aka Endogenous DNA) from samtools flagstat files and print to screen.
The percent on target reported will be different depending on the combination of samtools flagstat provided.
This program also calculates clonality (aka cluster factor) and percent duplicates when the flagstat file after duplicate removal is provided
Use --output flag to write results to a file

options:
  -h, --help            show this help message and exit
  --raw, -r [<samplefile>.stats]
                        output of samtools flagstat in a txt file, assumes no
                        quality filtering nor duplicate removal performed
  --qualityfiltered, -q [<samplefile>.stats]
                        output of samtools flagstat in a txt file, assumes
                        some form of quality or length filtering has been
                        performed, must be provided with at least one of the
                        options -r or -dedup
  --deduplicated, -d [<samplefile>.stats]
                        output of samtools flagstat in a txt file, whereby
                        duplicate removal has been performed on the input
                        reads
  -v, --version         show program's version number and exit
  --output, -o [OUTPUT]
                        specify a file format for an output file. Options:
                        <json> for a MultiQC json output. Default: none
  --name, -n [NAME]     specify name for the output file. Default: extracted
                        from the first samtools flagstat file provided
  --verbose, -e         increase output verbosity
```

