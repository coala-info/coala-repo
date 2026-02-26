# zerone CWL Generation Report

## zerone

### Tool Description
zerone

### Metadata
- **Docker Image**: quay.io/biocontainers/zerone:1.0--h577a1d6_9
- **Homepage**: https://github.com/nanakiksc/zerone
- **Package**: https://anaconda.org/channels/bioconda/packages/zerone/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/zerone/overview
- **Total Downloads**: 7.4K
- **Last updated**: 2025-09-16
- **GitHub**: https://github.com/nanakiksc/zerone
- **Stars**: N/A
### Original Help Text
```text
USAGE:  zerone [options] <input file 1> ... <input file n>

  Input options
    -0 --mock: given file is a mock control
    -1 --chip: given file is a ChIP-seq experiment
    -w --window: window size in bp (default 300)
    -q --quality: minimum mapping quality (default 20)

  Output options
    -l --list-output: output list of targets (default table)
    -c --confidence: print targets only with higher confidence
                     restricts intervals accordingly in list output

  Other options
    -h --help: display this message and exit
    -v --version: display version and exit

EXAMPLES:
 zerone --mock file1.bam,file2.bam --chip file3.bam,file4.bam
 zerone -l -0 file1.map -1 file2.map -1 file4.map
 zerone -l -c.99 -w200 -0 file1.sam -1 file2.sam,file4.sam
```

