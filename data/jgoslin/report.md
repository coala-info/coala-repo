# jgoslin CWL Generation Report

## jgoslin

### Tool Description
Parses lipid names using various grammars.

### Metadata
- **Docker Image**: quay.io/biocontainers/jgoslin:2.2.0--hdfd78af_0
- **Homepage**: https://github.com/lifs-tools/jgoslin
- **Package**: https://anaconda.org/channels/bioconda/packages/jgoslin/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/jgoslin/overview
- **Total Downloads**: 6.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/lifs-tools/jgoslin
- **Stars**: N/A
### Original Help Text
```text
usage: jgoslin-cli
 -f,--file <arg>        Input a file name to read from for lipid name for
                        parsing. Each lipid name must be on a separate
                        line.
 -g,--grammar <arg>     Use the provided grammar explicitly instead of all
                        grammars. Options are: [GOSLIN, GOSLINFRAGMENTS,
                        LIPIDMAPS, SWISSLIPIDS, HMDB, SHORTHAND2020,
                        FATTYACIDS, NONE]
 -h,--help              Print help message.
 -n,--name <arg>        Input a lipid name for parsing.
 -o,--outputFile        Write output to file 'goslin-out.tsv' instead of
                        to std out.
 -v,--version           Print version information.
 -w,--stripWhitespace   Strip leading and trailing whitespace of names
                        passed to goslin. Be aware that original names in
                        output will contain the stripped names!
```

