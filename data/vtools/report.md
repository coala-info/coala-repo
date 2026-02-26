# vtools CWL Generation Report

## vtools_vtools-filter

### Tool Description
Filter VCF files based on provided parameters.

### Metadata
- **Docker Image**: quay.io/biocontainers/vtools:1.1.0--py311h93dcfea_7
- **Homepage**: https://github.com/LUMC/vtools
- **Package**: https://anaconda.org/channels/bioconda/packages/vtools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/vtools/overview
- **Total Downloads**: 17.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/LUMC/vtools
- **Stars**: N/A
### Original Help Text
```text
Usage: vtools-filter [OPTIONS]

Options:
  -i, --input PATH                Path to input VCF file  [required]
  -o, --output PATH               Path to output (filtered) VCF file
                                  [required]
  -t, --trash PATH                Path to trash VCF file  [required]
  -p, --params-file PATH          Path to filter params json  [required]
  --index-sample TEXT             Name of index sample  [required]
  --immediate-return / --no-immediate-return
                                  Immediately write filters to file upon
                                  hitting one filter criterium. Default = True
  --help                          Show this message and exit.
```


## vtools_vtools-stats

### Tool Description
Calculate statistics for VCF files.

### Metadata
- **Docker Image**: quay.io/biocontainers/vtools:1.1.0--py311h93dcfea_7
- **Homepage**: https://github.com/LUMC/vtools
- **Package**: https://anaconda.org/channels/bioconda/packages/vtools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: vtools-stats [OPTIONS]

Options:
  -i, --input FILE  Input VCF file  [required]
  --help            Show this message and exit.
```


## vtools_vtools-gcoverage

### Tool Description
Collect coverage metrics from VCF files.

### Metadata
- **Docker Image**: quay.io/biocontainers/vtools:1.1.0--py311h93dcfea_7
- **Homepage**: https://github.com/LUMC/vtools
- **Package**: https://anaconda.org/channels/bioconda/packages/vtools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: vtools-gcoverage [OPTIONS]

Options:
  -I, --input-gvcf PATH          Path to input VCF file  [required]
  -R, --refflat-file PATH        Path to refFlat file  [required]
  --per-exon / --per-transcript  Collect metrics per exon or per transcript
  --help                         Show this message and exit.
```


## vtools_vtools-evaluate

### Tool Description
Evaluate calls in a VCF against a set of known calls.

### Metadata
- **Docker Image**: quay.io/biocontainers/vtools:1.1.0--py311h93dcfea_7
- **Homepage**: https://github.com/LUMC/vtools
- **Package**: https://anaconda.org/channels/bioconda/packages/vtools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: vtools-evaluate [OPTIONS]

Options:
  -c, --call-vcf PATH           Path to VCF with calls to be evaluated
                                [required]
  -p, --positive-vcf PATH       Path to VCF with known calls  [required]
  -cs, --call-samples TEXT      Sample(s) in call-vcf to consider. May be
                                called multiple times  [required]
  -ps, --positive-samples TEXT  Sample(s) in positive-vcf to consider. May be
                                called multiple times  [required]
  -s, --stats PATH              Path to output stats json file
  -dvcf, --discordant-vcf PATH  Path to output the discordant vcf file
  -mq, --min-qual FLOAT         Minimum quality of variants to consider
  -md, --min-depth INTEGER      Minimum depth of variants to consider
  --help                        Show this message and exit.
```

