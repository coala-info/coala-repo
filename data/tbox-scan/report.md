# tbox-scan CWL Generation Report

## tbox-scan

### Tool Description
Scan a fasta sequence file for T-boxes and predict specifier & T-box sequence.

### Metadata
- **Docker Image**: quay.io/biocontainers/tbox-scan:1.0.2--hdfd78af_2
- **Homepage**: https://tbdb.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/tbox-scan/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tbox-scan/overview
- **Total Downloads**: 10.8K
- **Last updated**: 2025-08-14
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
tbox-scan v1.0.2 (December 2020)

  Usage: tbox-scan -f <Input FASTA file> [-options]

  Scan a fasta sequence file for T-boxes and predict specifier & T-box sequence.
            -- Default: Will use INFERNAL with RFAM00230 covariance model with basic output
            -- Example: tbox-scan  -f input.fa -o output_file.csv -v -m 1 -c 100
  Dependencies: INFERNAL, cmsearch, biopython, python3, pandas.

            
  Options
    -f <file>  : input FASTA <file> (required)
    -o <file>  : save final results in <file> as .csv
                    default: out.csv
    -i <file>  : save INFERNAL output predictions to .txt <file>
                    default: INFERNAL.txt
    -l <file>  : save a .txt log <file> of pipeline output
    -m <model#> : search for T-boxes using different covariance models
                    1: RFAM model (RFAM00230.cm), finds mostly class I transcriptional T-boxes (default)
                    2: Translational Ile (TBDB001.cm), finds mostly class II translational T-boxes
    -c <value> : score cutoff for INFERNAL model predictions (default = 15)
    -v         : save verbose output
    -s         : silence console output
    -h         : print out summary of available options
```

