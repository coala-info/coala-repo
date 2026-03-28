# mzspeclib CWL Generation Report

## mzspeclib_convert

### Tool Description
Convert a spectral library from one format to another. If `outpath` is `-`, instead of writing to file, data will instead be sent to STDOUT.

### Metadata
- **Docker Image**: quay.io/biocontainers/mzspeclib:1.0.7--pyhdfd78af_0
- **Homepage**: https://github.com/HUPO-PSI/mzSpecLib
- **Package**: https://anaconda.org/channels/bioconda/packages/mzspeclib/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mzspeclib/overview
- **Total Downloads**: 1.4K
- **Last updated**: 2025-06-19
- **GitHub**: https://github.com/HUPO-PSI/mzSpecLib
- **Stars**: N/A
### Original Help Text
```text
Usage: mzspeclib convert [OPTIONS] INPATH OUTPATH

  Convert a spectral library from one format to another. If `outpath` is `-`,
  instead of writing to file, data will instead be sent to STDOUT.

Options:
  -i, --input-format [bibliospec|blib|dia-nn.tsv|dlib|encyclopedia|json|msp|mzSpecLib.json|mzSpecLib.txt|mzlb.json|mzlb.txt|mzlib.json|mzlib.txt|mzspeclib.json|mzspeclib.txt|spectronaut.tsv|sptxt|text]
                                  The file format of the input file. If
                                  omitted, will attempt to infer
                                  automatically.
  -f, --format [text|json|msp]
  -k, --library-attribute <TEXT TEXT>...
                                  Specify an attribute to add to the library
                                  metadata section. May be repeated.
  -K, --header-file PATH          Specify a file to read name-value pairs
                                  from. May be JSON or TAB-separated
  -h, --help                      Show this message and exit.
```


## mzspeclib_describe

### Tool Description
Produce a minimal textual description of a spectral library.

### Metadata
- **Docker Image**: quay.io/biocontainers/mzspeclib:1.0.7--pyhdfd78af_0
- **Homepage**: https://github.com/HUPO-PSI/mzSpecLib
- **Package**: https://anaconda.org/channels/bioconda/packages/mzspeclib/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mzspeclib describe [OPTIONS] PATH

  Produce a minimal textual description of a spectral library.

Options:
  -i, --input-format [bibliospec|blib|dia-nn.tsv|dlib|encyclopedia|json|msp|mzSpecLib.json|mzSpecLib.txt|mzlb.json|mzlb.txt|mzlib.json|mzlib.txt|mzspeclib.json|mzspeclib.txt|spectronaut.tsv|sptxt|text]
                                  The file format of the input file. If
                                  omitted, will attempt to infer
                                  automatically.
  -h, --help                      Show this message and exit.
```


## mzspeclib_index

### Tool Description
Build an external on-disk SQL-based index for the spectral library

### Metadata
- **Docker Image**: quay.io/biocontainers/mzspeclib:1.0.7--pyhdfd78af_0
- **Homepage**: https://github.com/HUPO-PSI/mzSpecLib
- **Package**: https://anaconda.org/channels/bioconda/packages/mzspeclib/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mzspeclib index [OPTIONS] INPATH

  Build an external on-disk SQL-based index for the spectral library

Options:
  -i, --input-format [bibliospec|blib|dia-nn.tsv|dlib|encyclopedia|json|msp|mzSpecLib.json|mzSpecLib.txt|mzlb.json|mzlb.txt|mzlib.json|mzlib.txt|mzspeclib.json|mzspeclib.txt|spectronaut.tsv|sptxt|text]
                                  The file format of the input file. If
                                  omitted, will attempt to infer
                                  automatically.
  -h, --help                      Show this message and exit.
```


## mzspeclib_validate

### Tool Description
Semantically and structurally validate a spectral library.

### Metadata
- **Docker Image**: quay.io/biocontainers/mzspeclib:1.0.7--pyhdfd78af_0
- **Homepage**: https://github.com/HUPO-PSI/mzSpecLib
- **Package**: https://anaconda.org/channels/bioconda/packages/mzspeclib/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mzspeclib validate [OPTIONS] INPATH

  Semantically and structurally validate a spectral library.

Options:
  -p, --profile [consensus|single|silver|peptide|gold]
  -i, --input-format [bibliospec|blib|dia-nn.tsv|dlib|encyclopedia|json|msp|mzSpecLib.json|mzSpecLib.txt|mzlb.json|mzlb.txt|mzlib.json|mzlib.txt|mzspeclib.json|mzspeclib.txt|spectronaut.tsv|sptxt|text]
                                  The file format of the input file. If
                                  omitted, will attempt to infer
                                  automatically.
  -h, --help                      Show this message and exit.
```


## Metadata
- **Skill**: not generated
