# sexdeterrmine CWL Generation Report

## sexdeterrmine

### Tool Description
Calculate the relative X- and Y-chromosome coverage of data, as well as the associated error bars for each.

### Metadata
- **Docker Image**: quay.io/biocontainers/sexdeterrmine:1.1.2--hdfd78af_1
- **Homepage**: https://github.com/TCLamnidis/Sex.DetERRmine
- **Package**: https://anaconda.org/channels/bioconda/packages/sexdeterrmine/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sexdeterrmine/overview
- **Total Downloads**: 15.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/TCLamnidis/Sex.DetERRmine
- **Stars**: N/A
### Original Help Text
```text
usage: sexdeterrmine [-h] [-I <INPUT FILE>] [-f SAMPLELIST] [-v]

Calculate the relative X- and Y-chromosome coverage of data, as well as the
associated error bars for each.

optional arguments:
  -h, --help            show this help message and exit
  -I <INPUT FILE>, --Input <INPUT FILE>
                        The input samtools depth file. Omit to read from
                        stdin.
  -f SAMPLELIST, --SampleList SAMPLELIST
                        A list of samples/bams that were in the depth file.
                        One per line. Should be in the order of the samtools
                        depth output.
  -v, --version         Print the version of the script and exit.
```

