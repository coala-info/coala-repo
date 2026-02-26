# fast-fasta-compressor CWL Generation Report

## fast-fasta-compressor_ffc

### Tool Description
Fast FASTA Compressor (ffc)

### Metadata
- **Docker Image**: quay.io/biocontainers/fast-fasta-compressor:1.0--h9948957_0
- **Homepage**: https://github.com/kowallus/ffc
- **Package**: https://anaconda.org/channels/bioconda/packages/fast-fasta-compressor/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fast-fasta-compressor/overview
- **Total Downloads**: 806
- **Last updated**: 2025-11-14
- **GitHub**: https://github.com/kowallus/ffc
- **Stars**: N/A
### Original Help Text
```text
ffc [OPTIONS] [file...]

  Fast FASTA Compressor (ffc) 
  
POSITIONALS:
  file FNAME ...              Input file, use hyphen symbol (-) for stdin 

OPTIONS:
  -h,     --help              Print this help message and exit 
  -d,     --decompress        Decompress mode 
  -f,     --force             Overwrite the output file if exists 
  -i,     --input FNAME       Input file, use hyphen symbol (-) for stdin 
  -o,     --output FNAME      Output file, use hyphen symbol (-) for stdout 
  -l,     --level INT:INT in [0 - 22] 
                              Backend compr. level, default: adaptive 
  -b,     --block INT:INT in [20 - 30] 
                              Block size order, default: 22 
  -t,     --threads INT:POSITIVE 
                              Number of threads, default: 12c / 4d 
  -v,     --version           Show version information
```

