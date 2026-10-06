# msoma CWL Generation Report

## msoma_count

### Tool Description
Count somatic mutations

### Metadata
- **Docker Image**: quay.io/biocontainers/msoma:0.1.2--pyhdfd78af_0
- **Homepage**: https://github.com/AkeyLab/mSOMA
- **Package**: https://anaconda.org/channels/bioconda/packages/msoma/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: msoma count [OPTIONS] INPUT_BAM
Try 'msoma count -h' for help.

Error: No such option: --h Did you mean --help?
```

## msoma_merge-counts

### Tool Description
Merge count files into a single count file

### Metadata
- **Docker Image**: quay.io/biocontainers/msoma:0.1.2--pyhdfd78af_0
- **Homepage**: https://github.com/AkeyLab/mSOMA
- **Package**: https://anaconda.org/channels/bioconda/packages/msoma/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: msoma merge-counts [OPTIONS] COUNT_PATHS...

  Merge count files into a single count file

Options:
  -o, --output PATH  Path to write merged counts file. Default is to write to
                     stdout
  -h, --help         Show this message and exit.
```

## msoma_mle

### Tool Description
Calculate p-values for each locus using maximum likelihood estimation from counts file

### Metadata
- **Docker Image**: quay.io/biocontainers/msoma:0.1.2--pyhdfd78af_0
- **Homepage**: https://github.com/AkeyLab/mSOMA
- **Package**: https://anaconda.org/channels/bioconda/packages/msoma/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: msoma mle [OPTIONS] INPUT_COUNTS

  Calculate p-values for each locus using maximum likelihood estimation from
  counts file

  NOTE uses an Rscript included as package-data in msoma

Options:
  -o, --output PATH        Path to write p-value output file  [required]
  -d, --min-depth INTEGER  Minimum read depth to consider locus for p-value
                           calculation  [required]
  -a, --ab TEXT            Output file to write alpha and beta parameter
                           estimates  [required]
  -h, --help               Show this message and exit.
```

## Metadata
- **Skill**: generated
